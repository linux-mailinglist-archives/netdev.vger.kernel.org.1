Return-Path: <netdev+bounces-170015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A0AA46D29
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB5116C344
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402625E470;
	Wed, 26 Feb 2025 21:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0CC25D55C
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604284; cv=none; b=L3Ldguy9gSvydhNPm1eClVvJx5iZjZTalgDMWKtkPrSlRBZfFvSHHA2UX0cZVbFZXg6LfTBNABE2QDAAkTrIyG1dQHLpxVAdhKfJCjtMb3/bAGLI7NuI2URppU8u/45bxt3qRLM79Lxw2ZwzVux3qvnaMTnqNnJFJIh0Ve9q8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604284; c=relaxed/simple;
	bh=UKt+GHT+287Ipx8kS5ik7J/ptKY2auu75XN6XzRnZKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzECE/nkLAANZJ/HcsuHSyvOCcQ8CzYcW7o3ZrTLFelWqgfUkSFGCInLYFFWWs/6vC7gt+xcP/0FzX6djOFVTxkYoYCRmd7t3L6hdO+mBQCfZPeHUZh2afvL7sBzaxNe+/p/IZZQs2TEg7g7vEDgLOnOM5nHENjfDwGQJOE1xP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2210d92292eso5166125ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 13:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604282; x=1741209082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUeugTVnayp4kxbgmhUld9dkErlJ887txv51ZBkIoKg=;
        b=HZDDRNdEEsSwhuAR7aVZJhdzxNrpItNhdjV4VBqTW1EiEdrvZDDUuMXhAsBtClXy9t
         CbZRSXj0lziK9Uxmycgsgg00SfMkhVnvwq8DCmWAL9uCxaCPq7+P8NUQUrmc/A1lD+ak
         TnWh8aXIIBcjmZxbzKzZ3eVeRqXkLnWMh33JkUji13kIhVmanH2acdT1ZoVvLsS0zPan
         X/mPNdACb1GN6kgiWEgxsEy+Srg3ZkDkxQki9TjMBs5QCuq1q9argT+7RRmKOSVS6IGK
         zXiRq2i0znwSRQ/reLr03SfCLkegqj+wZCJZ0dnELvj/gCs5O5/jWIslKUg0rkZeBYeK
         3Eng==
X-Gm-Message-State: AOJu0Yzar/9zXapPKxUHmLIj4dB6YRRD7R1nojcQ/hqMYMgyYQO0pRLk
	IczuZBHj32g5U4elA7i4P5SnVlkZWj86huBzFpfB56ZGMYO0o41OBL6/
X-Gm-Gg: ASbGncu+lDe3ohs89g/Q6bcLmLBWVDF1WpQazP8QFRDIhZrDRIcy+XtQTtCN8O9kJyA
	V34U+wPiLXHIWL0Cm/NksRNtIglR4WS+ZGIRv/We6A/Ek3KmimSeUC/Q4jqhla0p+DyHXAFr48v
	wZiGy9ExnjleKuXd7iOsQt5ipgg8mPy3dNH+nMm3V/1HM1lzAYnbm9/MjcWQis4AMS3Jcmq/0ty
	AqOfmybWZFtNANtsoaan2m6NoQzLTz9vZjfnH61I0vu1TZ63uw1MKPWpSEONWeIEvkH5Af0DbJw
	YOsanI+O88u4XqDVwVQ7x/K+3Q==
X-Google-Smtp-Source: AGHT+IF1/V3UST8QVzUgh5L2o6hPIp5VmFZzhMUOwgIOOSyTohWGkR6hkHKEwtTiH/yP8lRSLyc8gg==
X-Received: by 2002:a17:902:e842:b0:220:ff93:e12e with SMTP id d9443c01a7336-22320082679mr77187815ad.1.1740604281677;
        Wed, 26 Feb 2025 13:11:21 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a6abaddsm4015590b3a.20.2025.02.26.13.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 13:11:21 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v8 10/12] net: add option to request netdev instance lock
Date: Wed, 26 Feb 2025 13:11:06 -0800
Message-ID: <20250226211108.387727-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226211108.387727-1-sdf@fomichev.me>
References: <20250226211108.387727-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently only the drivers that implement shaper or queue APIs
are grabbing instance lock. Add an explicit opt-in for the
drivers that want to grab the lock without implementing the above
APIs.

There is a 3-byte hole after @up, use it:

        /* --- cacheline 47 boundary (3008 bytes) --- */
        u32                        napi_defer_hard_irqs; /*  3008     4 */
        bool                       up;                   /*  3012     1 */

        /* XXX 3 bytes hole, try to pack */

        struct mutex               lock;                 /*  3016   144 */

        /* XXX last struct has 1 hole */

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f487a65f16a7..29f61bd0ddf1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2456,6 +2456,12 @@ struct net_device {
 	 */
 	bool			up;
 
+	/**
+	 * @request_ops_lock: request the core to run all @netdev_ops and
+	 * @ethtool_ops under the @lock.
+	 */
+	bool			request_ops_lock;
+
 	/**
 	 * @lock: netdev-scope lock, protects a small selection of fields.
 	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
@@ -2745,7 +2751,7 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 
 static inline bool netdev_need_ops_lock(struct net_device *dev)
 {
-	bool ret = !!dev->queue_mgmt_ops;
+	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	ret |= !!dev->netdev_ops->net_shaper_ops;
-- 
2.48.1


