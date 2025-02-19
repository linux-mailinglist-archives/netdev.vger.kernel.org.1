Return-Path: <netdev+bounces-167872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9074DA3C9C2
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806A1179383
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615523BF88;
	Wed, 19 Feb 2025 20:27:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5537423956E
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996856; cv=none; b=NanS8Tw/0BH7RBEh3Z3qxsiAPFm9UevpXCFpzlVdplpEwgXYyjPnl3BUNIMEBH4A8zZ8rID/cjfJTvG1PBMc2sUh6usyNgVP8uljscTqgXrYODg4XR28YWyYCWLHX1nb8QoA3TDrbYmGgs0cf5OYa2GDL6L9Cc4TM6MPkK0L3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996856; c=relaxed/simple;
	bh=F88xB1LH19IWukUl2QAUPvQBA/BLgIxwqUiLaQl7xnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhFGjdiHdv0pqb8EAIQ8W3JHAig6PBsxps1uhNWp7t3tlz/J3AdGaK9LYCvAj6OB7W1xPDx/798hK8S4TJDETtGByzShUprf453zHRveqNGYtAIbvYDsFZbteMvrifjtDPSmJ+E/LMbgodvD//QSa4Q7SXNgC106drK9su98MQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-221057b6ac4so2487675ad.2
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 12:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996854; x=1740601654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5BGjm1SzjqCWF53yjcSV6XNzIlCNPsqiQi/nCjfKKo=;
        b=lGo5blsXldGTIGfOmejIAW2CFljX2y0Q1vsJk9shBe/oaTFZJlE3fqVYBgavRwNAaQ
         BrQBvsw3NzXwvBmACrt4VaF+WScK/VazUWzFTyHkRx9wux7vwFIHj7LVt15w4HLPEMxR
         NZ9uu8K2LRXfrF2JC3F9SUd953STmllwFCuZY9G3RLAETA5RWHydP7cwlNHdkR0vQjpC
         HoH+cXQMABXIZc4UpakbgmwkTaO0QwwSEsA9L5k2G+DR1a8Wtj2xmbtNZE3dQxnPlNQS
         yxmxSIUHjxZW7pQYo7QWgHdif4yQpbbYfasOZyFBju6KuuSdBQs/m9rQm0H1r6rf5hpP
         ovOA==
X-Gm-Message-State: AOJu0YwYHiZ+9ICSOaSL6WWX6mZFkTenFx8q8z3GJtlC0g8V1DCML8G1
	drLIojBjuJBkQJ/DuW3o5aEM6vj/G516lgrxPitQLFUaSWq8TIBF7r7G
X-Gm-Gg: ASbGnctJMXRAgYkb6CPdC92rp+Ptt0z5wcBPY55fkZt6/uNQMlMnqQ6FjCSUTxEssBE
	VUVn2DJ7q1BR9hlbALePrxgEyzo5aZyd13e7KEGIqi6pgU1TkM79wP3mb1P7DcmX7YUPnVK4su0
	DrKVY6d1gNqNQVLUQfNeYcMpZ2obBXR8EO04vZWrXbdjeI9zHej8qaU1dKwYeXVKSWGQ3WHuy3S
	BK7VM0EvpkfFSB3rzqZo4G8OZWI8tyvQziH+eLSsbbGVSDZiUlKdhU/gvyWe7i/vzdpY8N6psi+
	gzWYe6/vooGPZkI=
X-Google-Smtp-Source: AGHT+IEJQXrCNvo1NbSa313xGgyzRQI5J2UqrOInqHeuTC1qIsVDIIBRcpFGgipc/WDr//m1J18fRg==
X-Received: by 2002:a17:902:d502:b0:220:eaaf:f6ec with SMTP id d9443c01a7336-22103efc9dfmr323856945ad.5.1739996854435;
        Wed, 19 Feb 2025 12:27:34 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22120093e41sm62008235ad.93.2025.02.19.12.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:27:34 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v5 11/12] docs: net: document new locking reality
Date: Wed, 19 Feb 2025 12:27:18 -0800
Message-ID: <20250219202719.957100-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219202719.957100-1-sdf@fomichev.me>
References: <20250219202719.957100-1-sdf@fomichev.me>
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
index 4a11e78b1a60..c63ba78c39b5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2476,6 +2476,10 @@ struct net_device {
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


