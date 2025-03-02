Return-Path: <netdev+bounces-170986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64DA4AE90
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 01:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F9F7A857F
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148EA3594F;
	Sun,  2 Mar 2025 00:09:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F579EA
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 00:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874163; cv=none; b=cLD8sV/233cowdMPpnlqSG/hk3mbVh4hr1p9W/4WR9YwClyjAIodC9JSaT0nWo0RjmgIxURexqLnrG8S3jsFNx11uYiTxb1RPf5+SD649QLSFOwV+2ebBCxjvUCbKL85VNyEBj6cQjSRmxye2uwb7aoeCksW/I9d9jNI979O0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874163; c=relaxed/simple;
	bh=h4xZruX92Zb55WzC/oJeNuehFzJj5ZzvVMKY3xmvwu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdR60HZ/wArckklhKNYmBUCJCYx9nX/AFoV4NkNH1JkaNn+K5Rmb27l7AawmKn1dsxdXE237+8dLAHuNfaPMFNzgZAu8bqC7AlEkns2sBt/b61rKxO+66EVEuFuNOEYXMGdpak5McBk52mWaGYGHRI4uZ1UV2TPtC3f0pJExaDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2feb1d7a68fso5379198a91.1
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 16:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740874160; x=1741478960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSfiwM5ewCF8whUQrEz0GK9kW8CGbUp8jlzCToSoCdk=;
        b=YnDLHpzRfdkO7UriZ1PBDAsm81A+tPWbFJcfPYul+9inxdB1A3d/x9cQFY5aPW7Txv
         HZfP0mAnYvJg80s4XqPN+tYMwW/x4Vk7mOH/kMc6gOAcmJ6Nv+JCnwrdaj9XUHeKR9zb
         QMnqWenbUDVUGusggCiH4xu/N5GgB713mHrrbvBQ6aMSZXc/mfQV1gutSqjOcjo3GnVk
         IcM7Gaq1VqgWOVeWuFdDU6YZXtbSwj1TqvJPwiz4wsD45bl/XX2XU94MwbDYl8Kid9Q6
         ViBmoTLaNbtYI0dI6KVuYZ8bhtbxGlv4AJsQ8o6WWe2QEgPS0dDTwiCToMQxi88Nv9Cw
         +20Q==
X-Gm-Message-State: AOJu0YzISnKSgJ5peCvh/CPdhPjp1nKkqh9yVS9F+huPEbSjShdDUDqH
	cHrjwGjZJb0gXNyXeysEqBIIbIhplhdB14ncaxUNUmdOQI+0oDWXm9P5
X-Gm-Gg: ASbGnctD5DabhOlbGb9FVvFQ+OJT5GeXPCVmj9PtvNRMInNu6xQtIhJRLBtTm7qnYH7
	nK7tby0dY70jzO4CXW5l1lWdgSaWXEyMw8I/kzoOfKrsr3iaBOcIFjXivJtsA2hkJ9tyVQRup/L
	8QTI+YM5CXfhBsKHUrACTYD5NofdIHwy2x9yWcC9sTtzte9QOGwqpviZhIxj+ILzKM6XWXkr9wH
	nSh8IjLubkJs+PO+0YwyLg5K0EbwPDYjoujmv+jrQv2V9PMmX5c7Amb0V6LXNfGtI6ECJCeIvrN
	d6h91AT3Mj6/uXNmopYCJKzNkZtb3CEfU6tRDUMLCSCf
X-Google-Smtp-Source: AGHT+IHwAomUfSrVzZGs5DUqHIg98VV8SUMA+GOYAeZTePlErVQEuL6uWxOvVYIs/UzojUGKx0Glig==
X-Received: by 2002:a17:90b:1a86:b0:2fe:a545:4c85 with SMTP id 98e67ed59e1d1-2febabdc304mr13221204a91.27.1740874160438;
        Sat, 01 Mar 2025 16:09:20 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe825d2b18sm8351902a91.24.2025.03.01.16.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 16:09:19 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 13/14] docs: net: document new locking reality
Date: Sat,  1 Mar 2025 16:09:00 -0800
Message-ID: <20250302000901.2729164-14-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302000901.2729164-1-sdf@fomichev.me>
References: <20250302000901.2729164-1-sdf@fomichev.me>
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


