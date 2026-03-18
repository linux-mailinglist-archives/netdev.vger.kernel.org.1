Return-Path: <netdev+bounces-269182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPZQJXcVu2k3ewIAu9opvQ
	(envelope-from <netdev+bounces-269182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:13:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9162C2E0B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1DD530FFF16
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA836B054;
	Wed, 18 Mar 2026 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIaTSKpd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E0372EE1
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868322; cv=none; b=iw3fEV08qbfFzAMe4qq0cFb17OknW/B4CQUZiF1QLw874S5IGF/xGYqYlP87JX1hweKrQ3uG4Uf7pWTSskAhDF7/1BV5gcnVuVYQ4mG+0SVUcWowWszK81NaDPl4oDBSLkohbtAFedm9sS1hD7tOAZ4zlpJnbmLO4XrTtkIwljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868322; c=relaxed/simple;
	bh=Bc7FuaVfriVTlmWmJKPbflUCbTjIXZMDzHnpCnNX0fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGgfjf7bPeTsaLjlROlRQn0c+0Aqt5pSYeIXu5DwGb+f1grk0YM5PdBilVo2gLbuNed/GQYPa+W3jNNllfn5aJ5HCgBZ5jFdLgJKXl/jwLR60bEDk1AVO2wCwHMElChPIIg+YiJv6c56loKa48vuDNdGemPGsQ7M9YsU6qfC10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIaTSKpd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a27c021b58so327707e87.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773868320; x=1774473120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7uDPEFKy6/pc9tqIEzURrCbQW2EOE5IGjEosk7mUc9U=;
        b=gIaTSKpdCy9Wh267cMGGEJP0Vv6/zXdxOdPdxXBJf7XOy5vqMCss9op0edYrVjEzLd
         kKuK4WgSUnQscjthHB/Chqd2z3Enrqx7b60XCISsr7I37RwfteodpAHg+VUdOZ3dg6Jp
         P7RTRn3yTZeZWxzk/3q2/F5xQhQlx47AS+EgbT5b5WIyLeeefpvDZuPnh0bFAI4xf05k
         OafqBES7O08pevC55IOjcuX5rFo4xOSYf0Wr2O9XqYqjKmIYSsdnLgBTSod+QVCHu/ul
         aXrhdGqYK03TwMlmwjEwMgTiCtPFrxvx2XjDJZkjdi5AJX+DSQ1+tDspWXE70YwlKWlx
         aeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773868320; x=1774473120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uDPEFKy6/pc9tqIEzURrCbQW2EOE5IGjEosk7mUc9U=;
        b=tGXwZSwF1oS1lAMx4XdCrA0KfP9411eK78ZYK/Lsbnzzxzyn5+03VccJk538IuFLlw
         hu+rxOh/wDMSWsmDiY+DollzWjCNofK3rFZwDq48/gTW6/eIAXVAG/yPHdA1Yvlj8l91
         RG2qoH3iKBlNWLNZZ78H33QbXw7jq7R41uK+2+pQkggqTUrpNGwB+w06yCkWOxivaRBd
         r1XEJnIIXUd9Psye2bjsbGHwGRbEIX+JZNKCNXxfnb6ryRxcyK4nZh0hAC4hykdLiEne
         R+IlDF6GUguTt5q0zdm9SmCztcgEbPmAg72qoobjhP6fj2Wxov0qcFLjW+1kFA5Ea+85
         AOHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX92rharyeKNAZR+ZNmRXUFGnReVaFhm3HISZRmzvW4V3KSmO3ktNgPDnb1DJCwXhc+vcU2NJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKRtgKa8knBGaah6SZITgz0fGTfng3vyVB8uuiUYqGWvee95vZ
	ZbbjEBl40PrYzxvdpKhDQEGdWEq/eRFXfhC8Mhel6ndmhUTzo8bJb2DU
X-Gm-Gg: ATEYQzxbYvIt79eOJn2Wlt2Jz2mn5gOwi1Q1e5jnycgpS1UapEQvVv2oXMPz9JR/mGU
	Ltsr0vJrafeAw6DSlb8bIVdaBqxbJJLedBEQVN6Yax6UiSyE8x+rpd17xkf0BNLrDzaYOFccFrr
	2usiQav3F5v3sazuc9fJTpQnHyYokeS/CAn4rdt9eETaUthwh6oe+67QvYAdIfMXw7QZYlT/N2T
	ObUajYvHYMYJV4mHxM/EkyoOMr0JkPRvaQLJPjPnAT1Y+dNfJxzBpwhXdAuJZCJOK7pJtF3ZBmE
	9LUFgO3PFEkv85y5Rem3jPEIw9B478vkQk/a83I4+pckxuKvDwiGoTBTJwpE6F+IH66ILQ83nIk
	i4VlkJoTrx522ihq/n51fTvKi0TWFc8YQwWbPOLT2s3imVgbzgZoV4boJOdtjDtIK9WhOLnvdB+
	X+LrD3m3gtzfoZXtmYLE07rp3O1DRzUubIZvsMS8P3BG/k7I3jI1JE7iKCtIgU/x0YCfLx099NQ
	w==
X-Received: by 2002:a05:6512:20c9:b0:5a1:381b:fae1 with SMTP id 2adb3069b0e04-5a279588187mr1510495e87.10.1773868319381;
        Wed, 18 Mar 2026 14:11:59 -0700 (PDT)
Received: from T6NXCV08J99224A.lan (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a279c7b7a8sm798082e87.80.2026.03.18.14.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 14:11:57 -0700 (PDT)
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
Subject: [PATCH net v4] net: ntb_netdev: add SPDX tag and remove boilerplate license text
Date: Wed, 18 Mar 2026 22:11:53 +0100
Message-ID: <20260318211153.9460-1-rayfraytech@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,davemloft.net,kernel.org,networkplumber.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269182-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rayfraytech@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.915];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC9162C2E0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add SPDX-License-Identifier tag to reflect the dual
GPL-2.0-only/BSD-3-Clause license, remove the redundant
boilerplate license text and contact information, keeping
only the driver description.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
v4: Remove contact information as suggested by Dave Jiang,
    keeping only the driver description
v3: Keep driver description and contact information as
    suggested by Dave Jiang
v2: Also remove redundant boilerplate license text as
    suggested by Stephen Hemminger
v1: Add SPDX-License-Identifier tag only

 drivers/net/ntb_netdev.c | 47 +---------------------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..cf04aa5d2824 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -1,51 +1,6 @@
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
- *
- * Contact Information:
- * Jon Mason <jon.mason@intel.com>
  */
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-- 
2.43.0


