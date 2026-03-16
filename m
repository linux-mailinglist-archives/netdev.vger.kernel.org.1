Return-Path: <netdev+bounces-268217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMsVGiY5uGmpagEAu9opvQ
	(envelope-from <netdev+bounces-268217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:08:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDFD29DD70
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0E7330965C0
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80F93CF690;
	Mon, 16 Mar 2026 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE7xrZ0i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA563CD8C1
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680529; cv=none; b=Iw6U7d50hH7hNpoz8yskp9kTRKj5sUgfOWJaBsiCRbgjINxcPwqSRxrguGXnIHIQaf5Mge0x9LwR1JO75F0OcEbgLl6JQ1hzSkxT6WfHDujGi0huBok9VMSRBPkw8lMRbBVfjTrzVUjF0ynDUkyJ7A84teGW8NhqKFJEtmQroDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680529; c=relaxed/simple;
	bh=JabMMdnsMTxWUIpUCHuaaYydbHEI4FzFLCz/JBCiC4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEL2HEkREbhXxkNtEbsD9DMgbCm3mQEo3WE3q11/1QYw4rGQdzQWGw+CCkaCzTNaaPokhf1jNx5R08sNF3AofpBib6LEm5ZAA6DY41tc73MpTX8XP8XYAysC5xUxzdT8WjBUS6+6NeTYXpunUasTbDTX/GEDhUMSiDNdoHYsT8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eE7xrZ0i; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e4989dacdso5448841e87.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773680525; x=1774285325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FBv+DUbkZKn5UcTiH4mk1Kik16KscvfZ3cWgSXjFvg=;
        b=eE7xrZ0ib0VvoIMfej4MRnlB2ekV1hMRnq3ZAnSQ8No4WcYvtwYsTGNeroqPAo8OIp
         8ln5Wp4bOm4f648vIM8Rtz1/N7Qk1x1W6Uea5GTwxYmb5EV3wjjkF5Y4kmVWIhI5ks2s
         Foswrlri0sLFoLaeQJT7mFHT/ET8tk7VtlrDbyj0WXloRNw5bzlVL2NTF8LcwP5J6Ztf
         YgGUb9kXDYTR+uRFkCrj7nGu+KtiXZBKYJF+QnoqiC1kQy0X/y4Wc+Mfw4LGQFWqwOAP
         N5msO1jSlRAAS7ETt9pMNGBu5gsjI9JxcquJSNVI/uDxXcssc1NyNoGLWPa5AAlaNvZ0
         O7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680525; x=1774285325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FBv+DUbkZKn5UcTiH4mk1Kik16KscvfZ3cWgSXjFvg=;
        b=ehtuLlNet07ENMfJLrS+wi71iJg+ExLUyM1mMg0nEfxCq8WOYhr9yuJA0+6xxIlkPa
         jwf507cgBDAqPMfrPB4QGGgMwK2KrVdX/6uV+ck4Cl5w90gSYE7tsosek11mME7pZybo
         0gXTLphT+Pic/LR5MD1JWBJJ2F2d/tl1e9wbIhBb0xmdb1E1hJCqvV+O3idE50bZxaqp
         6q609IFw80C7JkhdsaAnsSM2MhEZBMdxczX03J+am8Uq+3l6jMBwFVUpRz5fZlBUnH7K
         7HBoF06iaLtswmq6VR6mZs5I4oZjPJZcwR4yEnXYSFrQwMjOuMwbaQel8kfKtwWbhyjF
         Qu1w==
X-Forwarded-Encrypted: i=1; AJvYcCUNaHMzcdGU29UJYqNk9ct/V5d5sf7lbGf1mq3Pq5inC/KP98PCwWnYWjCVKTOmU3wkNfLBpz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFaBrL6lzQlfCeLyWrO+WkJD84hmb2//5McXGOuN0Mmj7isg9Q
	8pIdsZI+hvXJdyZZ1NhO7ZYP2l0zkTXJ720yaNIOoeQS5z6Q3MUJNAZ7
X-Gm-Gg: ATEYQzzb41nRcUqxH/D2wCUrVz3Dd4VARaQlZMKOBM2SbaMHcOt604ew2QRLQrE+F+Q
	aKsP716bwVm4sO7MdTrdgmfBHg4iQ29XTAE3dX1c/OiEFgehAKU4Cihcg2/z/xtqnZZAblQqR/P
	UFCY2Nt8zq2HeUfxR8C00nOZWcCUR9iQBvcu+1mxiZqiwpqk3O0nDI+SPYtw1+VYA8VcRAiyg5G
	nu/4uPOY5qMicnLjULdcHPGnOTnxeG9PKueAVHA1jqSAe+IjOKUTtn05uoQKr3jw4u+ZCrqQz/t
	Ab+si/qSiKqEjzN1g25UGypU2+zGjrSsSb0KHSwF47TI/qpet6Q8F+RfkQDzllqlve6YbJHnHyy
	67QPcbJhGmbWEiwSnQQoI9ngXIpi4YpYBB4Lg0aVt3VXly9CtpubfsDN6iV9tAyl1nMsOn/QR+g
	RUZAMBDpK4CJjiT9RnRj6JmvrigaEnbfYpBeQfWjRXVrXWgGj3o00iGI+vwtNkzC7P
X-Received: by 2002:a05:6512:3d08:b0:5a1:476f:bbcd with SMTP id 2adb3069b0e04-5a162b1febemr4357044e87.44.1773680524993;
        Mon, 16 Mar 2026 10:02:04 -0700 (PDT)
Received: from T6NXCV08J99224A.admin.jenseneducation.se ([185.154.228.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a16c8eb1bcsm1646911e87.41.2026.03.16.10.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:02:03 -0700 (PDT)
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
Subject: [PATCH v2] net: ntb_netdev: add SPDX tag and remove boilerplate license text
Date: Mon, 16 Mar 2026 18:01:41 +0100
Message-ID: <20260316170141.1792-1-rayfraytech@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-268217-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: BFDFD29DD70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add SPDX-License-Identifier tag to reflect the dual
GPL-2.0-only/BSD-3-Clause license and remove the redundant
boilerplate license text.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
v2: Also remove redundant boilerplate license text as
    suggested by Stephen Hemminger
v1: Add SPDX-License-Identifier tag only

 drivers/net/ntb_netdev.c | 50 +---------------------------------------
 1 file changed, 1 insertion(+), 49 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..76806d1c5e69 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -1,52 +1,4 @@
-/*
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
- * PCIe NTB Network Linux driver
- *
- * Contact Information:
- * Jon Mason <jon.mason@intel.com>
- */
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/module.h>
-- 
2.43.0


