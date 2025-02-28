Return-Path: <netdev+bounces-170577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9353FA49096
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84FE016FE6A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629E61B040E;
	Fri, 28 Feb 2025 04:54:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53BB1AF0DB
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718451; cv=none; b=fpFH60Vx1wz8dLbrcLiZbSI5idcy7JOtr9Q6vI1tppVokf6slmISFfJ3O3a9vOTMADaj2z9bq9ssIcYDKJnJo2xOAHjLDvFu1qyJYKqHtyDjoBReXuzRfVNIJT8FW4YHha0bbLqxGgxouuaQB80iiukvrzgd/Wre/vSfjYPhqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718451; c=relaxed/simple;
	bh=h4xZruX92Zb55WzC/oJeNuehFzJj5ZzvVMKY3xmvwu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vENG9Hp+7ahxdobyozBhz3nBG1q25fvlh24UPN6i1nXzJ5LXvJK0+AjHa+sr9wJrLjPjKw0g1eph7YWswynHlFPyOFCgoz3RM1vJU0P1rfANaxWASYUMdSauGJZUvzakt8GsDXGGjkftFFKtgIsltm19HNHoA4YC+3CDpZPIkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22355618fd9so26284825ad.3
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 20:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740718449; x=1741323249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSfiwM5ewCF8whUQrEz0GK9kW8CGbUp8jlzCToSoCdk=;
        b=M7iBERy24Zfc0uROrEOaTBh+q5w+7cTYF5n3fV4CYwfwV28RiZ3Odjd8JalkGHcFRE
         kezLDumzLPVZtCk7jigEcUOHe3Am0j+j0cs2+iKv7oDcTNtUmQxIpibqepp6TLNJ9yRp
         HZT/gU0ZKDCDVIcTo8z2Di7hQpDTPBDwKkSCgVdB0FeLuww5+NYAT+9B5XVxrrBPaXAA
         xSsMlW2LwdIHjILdXTxpHmv2MhBlkbrv6k+xvhonqS88JHVUGg2+7zmV1y9LUzBV2Nq9
         F5wmGvY5tqYgmasm9LTqoswH2605vjHG4cdr1XMaXyphsCK5hoiRVpj/T6kVsVZTf8qx
         uf+A==
X-Gm-Message-State: AOJu0YyZZwKOGgEyNa5xULAKh+xJox4t/BR4ynhL9J6NPyhl46qSgE4N
	oR/Gz23Q9RD1QrioF+8KDRUrl/yuVpN1BRVfsuNaHRDfIpMQTGPTdo9d
X-Gm-Gg: ASbGnctIjUrOrcA0sgsqQuLR+2vVQs9yzhofAqruXsc6CYZaLpAOPSNVJJu17ZQFDjp
	kZc3eYRWwsPS/C7t/EoOxF4ite1N9ATasMGpjxe2N7T4E6lHIobmycCIxk7ct5H8aH34MIxwukI
	9xxtd31qv9shAqkNZav8rNZgVHsagX/s4MuhubXe01tP8zQuz6SLmQffuzo/48sN9TB5N41kM0c
	N0stwkV/iJMxO+LsMgayhHCFD2JbRU5qLERexUgQn66j0+s8arSS/xjmz5VQz0Ko/Rt4RTT5FlU
	hL/fhaqPy7Ge6hJ6ASEONCRAVQ==
X-Google-Smtp-Source: AGHT+IHn26HYq2mSf9ZRl7P5TF5fahdVk4AnzOFjdEfhyCKelOCVX9ZschnMfZGbV4y2BUqUOUy/kA==
X-Received: by 2002:a17:902:d48c:b0:21a:8300:b9ce with SMTP id d9443c01a7336-2236926a62emr31330535ad.49.1740718448726;
        Thu, 27 Feb 2025 20:54:08 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501f9d52sm24546285ad.86.2025.02.27.20.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:54:08 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v9 11/12] docs: net: document new locking reality
Date: Thu, 27 Feb 2025 20:53:52 -0800
Message-ID: <20250228045353.1155942-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228045353.1155942-1-sdf@fomichev.me>
References: <20250228045353.1155942-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also clarify ndo_get_stats (that read and write paths can run
concurrently) and mention only RCU.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 65 ++++++++++++++++++++-----
 include/linux/netdevice.h               |  4 ++
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 1d37038e9fbe..d235a7364893 100644
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
+under ``rtnl_lock``. In addition, netdev instance lock is taken as well if
+the driver implements queue management or shaper API.
+
 struct napi_struct synchronization rules
 ========================================
 napi->poll:
@@ -298,6 +308,35 @@ struct napi_struct synchronization rules
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
+global lock known as ``rtnl_lock``. There is an ongoing effort to replace this
+global lock with separate locks for each network namespace. Additionally,
+properties of individual netdev are increasingly protected by per-netdev locks.
+
+For device drivers that implement shaping or queue management APIs, all control
+operations will be performed under the netdev instance lock. Currently, this
+instance lock is acquired within the context of ``rtnl_lock``. The drivers
+can also explicitly request instance lock to be acquired via
+``request_ops_lock``. In the future, there will be an option for individual
+drivers to opt out of using ``rtnl_lock`` and instead perform their control
+operations directly under the netdev instance lock.
+
+Devices drivers are encouraged to rely on the instance lock where possible.
+
+For the (mostly software) drivers that need to interact with the core stack,
+there are two sets of interfaces: ``dev_xxx`` and ``netif_xxx`` (e.g.,
+``dev_set_mtu`` and ``netif_set_mtu``). The ``dev_xxx`` functions handle
+acquiring the instance lock themselves, while the ``netif_xxx`` functions
+assume that the driver has already acquired the instance lock.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1813dc87bb2d..c10701a24d6d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2505,6 +2505,10 @@ struct net_device {
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


