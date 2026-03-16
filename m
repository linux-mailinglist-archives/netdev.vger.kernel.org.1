Return-Path: <netdev+bounces-268259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOB4NOBYuGmKcAEAu9opvQ
	(envelope-from <netdev+bounces-268259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:24:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B4829FC89
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E02A93002932
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4A6328B58;
	Mon, 16 Mar 2026 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUdYsjCL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30933F361
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689049; cv=none; b=HvmRFnt7lBpd1MyYhO8Wd5Z0R4Ruf5DLR2wjSB3YcJn7mF04AU/UZoVh5TcawDn9TlGrRHmhMyOMTNUVoExO9TsT/Xt2CDyO07Vcb+D5EfOKRW02xX+hHGhmmhR+XJkbeojyZ38Y8IM2F2Ji/w3Je7tZ0aNQeQvPRnePhAzNQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689049; c=relaxed/simple;
	bh=mok+0GN/V4P5qG+TDfFZAcX6xlih6/hGqugS54vAftM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TquhanGFtdAYxXH9xnWAbKypNUzwUnBbPYC9MKXVzm8TxvFThyCfPnHb9rVPRpMmJDZFEj85KCR5ZPLd4VS360rlEJJN5yephpch1AtAluoWyD4Wg9HzCY9uPu0NtqQk0WAC5iPYD1ARXb5zDorClVj4RRwCrsOtyoH3EZ0RDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUdYsjCL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a133502accso6173431e87.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773689046; x=1774293846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OeUzdNtqUzZ05FUtZtH1B/y/MvIg739iNl7JRLf75nM=;
        b=cUdYsjCLfkfGisMsB6atTIWyDnwnl5jGLkNwUxIaa+oNVaNoo6viKvQ8keYDqgfPKh
         ll/OaULgXEp+ou6cJmRT36Cq6+/maAKQ467d0qHUGWUrZ5IcRGg2u09od3LyJE2PeCoI
         wrqkKM2T2ygassWzo7gP8HO1lOXphgthoZWiHCqgIqdmQff8r1wIeZR0eyjBQYzbUm3k
         NtzID1RTmsxeTrG4Ofd/fJ4sGDAWs7ThGupNzc9RmujikGRgIM7XIATRS0zpgtvdz4dZ
         aQBr6Mh/licPGfmHBycO/Yya1T1RzFxn+GLo6p2agvW4kAvcmAJcebLgLtth4oJJeHpQ
         lQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773689046; x=1774293846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeUzdNtqUzZ05FUtZtH1B/y/MvIg739iNl7JRLf75nM=;
        b=MUxa+dOJhnRhdyG5bROxWy/tJb4yMUTj0VBzVbRJD7sHU/QoDzUnj6s5KsY9gOlSJo
         6pfwgnthDc+XZXAyeRuQb3R8BBmCdaHh2WTwVsCUo/vZHlCO+fRB0RyAGBBS+iPxPaQp
         k55mYe4YFvaPaGD/Az1PZvxEh0MO/x+W+AI7F7Nwcaa8/l13WZx3Mrk9ok646/+BoJ5M
         YAih2HPIDcGEf4A/bia7aEfczamKjai9naJopKk4YJtTNdAa3iLrIRUsrPsB028gGgDk
         OnE/B3neVtNZN0Ydc516SRsfPq4Tyyujj73vX0s8LKWtq9eht+nPlOY8tp/K8f+8/xlu
         olAw==
X-Forwarded-Encrypted: i=1; AJvYcCXHtXVrZVfYtbnhNTeWZe19IFTmb7VpXUTc4kYW0JH5xoTQcdgW2Zw4eudeHrK3uJFL8/ZCu70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTIghYgV62EBceeVID7VQ8j7XxnZHwcVEnGLpWoqZJl/DMgFV
	NWXxXYhfZJ7E5nORTk9x9F7MxbHMmUCetVKI+So6gxRohS6HxhuGaC2m
X-Gm-Gg: ATEYQzzUwdwyYzNWqbJ/LIfZGki1KRxRE/wU0PPo9xaixoA8RbbOrALV9Y+TRlbRpbw
	6lVDI04syp0Gb+qF/Vjo1j7CVGd4N6b0ZQl8MqBnhyTjkm6hRdJJVNfPZATnFCrhzhRl5+kGlPo
	gJnScRDKYnBbg9ET8rlo0/JkoxJ9F69OuLjHiRiejOoAmI597lWk34tucu+MA0uQn3T69uIsIsL
	sH6/J7lPq7HhysYF+H2x1U/sOPSiaovTPM25TtJfx0pSYO7IJIBKvzy9zuue+a6MJeEEVVoO28+
	PI2bOVA/n9LZttyEjSzJi1acnCuwKvO0b+xtbcBVYP7UZzlBYgqBr3Fx3+3idmcTDpG5EYn/tj+
	EthefAc0/+tHUZtHG2cDSVj63Y70SuoS6yno4/sSbI6v/+VM7vvspaO49aMyCRnvPAKstk0qx2S
	5NGYBBoB7BlNhfOLMGiJpu0S5EUlALxffuHRAlTni5ymGzDv8IwafauttUy9EBAwq8pRAJtJsaf
	A==
X-Received: by 2002:ac2:43c8:0:b0:5a1:2ccd:ad56 with SMTP id 2adb3069b0e04-5a162aee2b1mr3140079e87.9.1773689045753;
        Mon, 16 Mar 2026 12:24:05 -0700 (PDT)
Received: from T6NXCV08J99224A.lan (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a16c8eb1bcsm1708226e87.41.2026.03.16.12.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:24:04 -0700 (PDT)
From: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com,
	allenbh@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	stephen@networkplumber.org,
	ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: [PATCH v3] net: ntb_netdev: add SPDX tag and remove boilerplate license text
Date: Mon, 16 Mar 2026 20:22:48 +0100
Message-ID: <20260316192248.518-1-rayfraytech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,davemloft.net,kernel.org,networkplumber.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268259-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rayfraytech@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8B4829FC89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add SPDX-License-Identifier tag to reflect the dual
GPL-2.0-only/BSD-3-Clause license, remove the redundant
boilerplate license text, and keep the driver description
and contact information.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
v3: Keep driver description and contact information as
    suggested by Dave Jiang
v2: Also remove redundant boilerplate license text as
    suggested by Stephen Hemminger
v1: Add SPDX-License-Identifier tag only

 drivers/net/ntb_netdev.c | 44 +---------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..48482b18c73e 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -1,47 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 /*
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- *   redistributing this file, you may do so under either license.
- *
- *   GPL LICENSE SUMMARY
- *
- *   Copyright(c) 2012 Intel Corporation. All rights reserved.
- *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of version 2 of the GNU General Public License as
- *   published by the Free Software Foundation.
- *
- *   BSD LICENSE
- *
- *   Copyright(c) 2012 Intel Corporation. All rights reserved.
- *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
- *
- *   Redistribution and use in source and binary forms, with or without
- *   modification, are permitted provided that the following conditions
- *   are met:
- *
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copy
- *       notice, this list of conditions and the following disclaimer in
- *       the documentation and/or other materials provided with the
- *       distribution.
- *     * Neither the name of Intel Corporation nor the names of its
- *       contributors may be used to endorse or promote products derived
- *       from this software without specific prior written permission.
- *
- *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
  * PCIe NTB Network Linux driver
  *
  * Contact Information:
-- 
2.43.0


