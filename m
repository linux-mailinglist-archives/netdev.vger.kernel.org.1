Return-Path: <netdev+bounces-167185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F2DA390B7
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FA73B2DC4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4A014F9EB;
	Tue, 18 Feb 2025 02:10:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF0A14EC60
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844609; cv=none; b=tesiDbMPVA6Tg0qzhLsvQlaLIKFSqMvFGtzn/7vJNvrwkp0Ist1PihabUfoEYzH5gLe24EOV6EiRtoIVKmAricnu3jWgPRrYvUwgONuBcCADvnmh3P1fpHmA8sMAdXJmkbv9Ns7DFaBBLXgLYp4j8FDAyVVv31VnGbKzXtj3Jjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844609; c=relaxed/simple;
	bh=uD79fP9jZ3kucHa24E+1htDkJkh6RALoXanUO1cDHPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gE8d38XqXAJKij43K7DTJnYnASo3uPzDvBusI4+pbcQD6CDzZ7NCb0bF3mdqpD1hkCwlAgYd21M/AesnHYYJxrvWtryPfGUgA3jTvnegCaPF24DJ1Jj/zZguvqlRgPhO+C4ofDJhLwaT+lFB15BgZ4GLX/gyRBaUV8JDicEuIco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d132f16dso70495225ad.0
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739844607; x=1740449407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrvEobV/tv2Qim5McMdlN1w7JFLztezVB8h9lTEXIQg=;
        b=VqVgP3NCBagE9WVqlJ75/gpHpGpYJi+c8Tsb+F+kLEiKfwGRjQQs9L40/ZVPj149Aj
         M8WH+d7KHrL6wQAYCzon27FyexUKBpsFCECBirszP5m8pmz6NMPWz38Ioan3ISRe6jcw
         Z/udnJyn6MV5ZypPngYaqrKL92+ClFIRj4x7DSLICQsfbZXlbkq0gMLz1jLKULVt2mSE
         GNsJZgTrfpwfVju331zpDYXuavGSrK9gU1i2d8IRn3Atj79U4xj5iM1xG5ccaFGqO7AU
         y3rHiUUR1YE3bW8Bdgnlcv3wr6AuBH7tvV8UZckF1pTBp0I5bPsGsKqVKifyYzqsi8cd
         xHfw==
X-Gm-Message-State: AOJu0Yx++iwywvNS5ftU9FqHuUYmusI1DCESilHkIBTrGDuXbFrzgH94
	GDOqwZNF6gBeEEDSRSGhPE8d+ysaJ0ivGBUNxt3eRPwH45WsW0GP64mj
X-Gm-Gg: ASbGncvVglmYTzsAVUi6+spo33SxLqXtL5H8zdAAPifSypfLCXkSLHSMrLyrndZJHKR
	olohC9WB/SyJ5hxzJ1N2NtKuhe7yHKulgyLv+h2xtrxIMajs0Sfuhep+E+/KRN0p3EeFVy7F2JR
	nMuApkQWz9Ddl51njcP4ZRr52ytcTWs47RhNUlTh+RQ6gIWynRSLz8fL2e2gUT6xHLF77yObu06
	muTwMg9Y78hROZ7BgyHGqotbwcnuIu81oaLTxHOdtQeD/OcE1cE4fo29xzrLKXdpRCuW0niZBQx
	s3r5v5g74uukKbI=
X-Google-Smtp-Source: AGHT+IGKv4itGIy2IEPal8LVkQk8ID219+Iwx20HPAZNG3kUJHOJm67TobGliuy76LhDrnSSAZgx9w==
X-Received: by 2002:a17:902:da8c:b0:220:c2bf:e8c6 with SMTP id d9443c01a7336-221040c0b88mr194407945ad.53.1739844606946;
        Mon, 17 Feb 2025 18:10:06 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d663sm77355255ad.120.2025.02.17.18.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 18:10:06 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v4 11/12] docs: net: document new locking reality
Date: Mon, 17 Feb 2025 18:09:47 -0800
Message-ID: <20250218020948.160643-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218020948.160643-1-sdf@fomichev.me>
References: <20250218020948.160643-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also clarify ndo_get_stats (that reads and write paths can run
concurrently) and mention only RCU.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 57 +++++++++++++++++++------
 include/linux/netdevice.h               |  4 ++
 2 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 1d37038e9fbe..0d2ab558f86a 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -210,49 +210,55 @@ packets is preferred.
 struct net_device synchronization rules
 =======================================
 ndo_open:
-	Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
 	Context: process
 
 ndo_stop:
-	Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
 	Context: process
 	Note: netif_running() is guaranteed false
 
 ndo_do_ioctl:
 	Synchronization: rtnl_lock() semaphore.
-	Context: process
 
-        This is only called by network subsystems internally,
-        not by user space calling ioctl as it was in before
-        linux-5.14.
+	This is only called by network subsystems internally,
+	not by user space calling ioctl as it was in before
+	linux-5.14.
 
 ndo_siocbond:
-        Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
         Context: process
 
-        Used by the bonding driver for the SIOCBOND family of
-        ioctl commands.
+	Used by the bonding driver for the SIOCBOND family of
+	ioctl commands.
 
 ndo_siocwandev:
-	Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
 	Context: process
 
 	Used by the drivers/net/wan framework to handle
 	the SIOCWANDEV ioctl with the if_settings structure.
 
 ndo_siocdevprivate:
-	Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
 	Context: process
 
 	This is used to implement SIOCDEVPRIVATE ioctl helpers.
 	These should not be added to new drivers, so don't use.
 
 ndo_eth_ioctl:
-	Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
 	Context: process
 
 ndo_get_stats:
-	Synchronization: rtnl_lock() semaphore, or RCU.
+	Synchronization: RCU (can be called concurrently with the stats
+	update path).
 	Context: atomic (can't sleep under RCU)
 
 ndo_start_xmit:
@@ -284,6 +290,10 @@ struct net_device synchronization rules
 	Synchronization: netif_addr_lock spinlock.
 	Context: BHs disabled
 
+Most ndo callbacks not specified in the list above are running
+under RTNL. In addition, netdev instance lock is taken as well if
+the driver implements queue management or shaper API.
+
 struct napi_struct synchronization rules
 ========================================
 napi->poll:
@@ -298,6 +308,27 @@ struct napi_struct synchronization rules
 		 softirq
 		 will be called with interrupts disabled by netconsole.
 
+struct netdev_queue_mgmt_ops synchronization rules
+==================================================
+
+All queue management ndo callbacks are holding netdev instance lock.
+
+RTNL and netdev instance lock
+=============================
+
+Historically, all networking control operations were protected by a single
+global lock known as RTNL. There is an ongoing effort to replace this global
+lock with separate locks for each network namespace. The netdev instance lock
+represents another step towards making the locking mechanism more granular.
+
+For device drivers that implement shaping or queue management APIs, all control
+operations will be performed under the netdev instance lock. Currently, this
+instance lock is acquired within the context of RTNL. In the future, there will
+be an option for individual drivers to opt out of using RTNL and instead
+perform their control operations directly under the netdev instance lock.
+
+Devices drivers are encouraged to rely on the instance lock where possible.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3b1b6df775f..983c8e9e767f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2470,6 +2470,10 @@ struct net_device {
 	 *
 	 * Also protects some fields in struct napi_struct.
 	 *
+	 * For the drivers that implement shaper or queue API, the scope
+	 * of this lock is expanded to cover most ndo/queue/ethtool/sysfs
+	 * operations.
+	 *
 	 * Ordering: take after rtnl_lock.
 	 */
 	struct mutex		lock;
-- 
2.48.1


