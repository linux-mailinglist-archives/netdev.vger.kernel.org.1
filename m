Return-Path: <netdev+bounces-170016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B44A46D2A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575D5188CBBC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4906F25EF95;
	Wed, 26 Feb 2025 21:11:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5AC25E466
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604285; cv=none; b=YMwiZae6J4MxQfA28phi1Uq6qVQJFJn7SwMd/XXlGZ0n2Rrmi7PDhghPTSC7tGW1bIzbHdKt4TWEDfov5jsuFWYjaZZkxe6A10a527WyO+lGqqVEu/Yps7U1j2QN+fk+1benxSO3OYce796JRgyWXACBO6iRHlGLxrewkPt55o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604285; c=relaxed/simple;
	bh=srLPZP8yeoThoRIgaI6xtJ07FN5mmUup2hfIhck3uPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp5JKAWR4Sa1ttglbLMnIYiAMY6nQ9DWfh//uv9PpvsCEnZtovnYu8GgytYiNAIHAaPQ+DXORQVtA162Zq05TUPyr0zO6DkHgHCYeo7EEc4GjR+M1i+xkGFcwLDu2pbRWfyNvHWWDFiGfWrOfVyZ5yt4yGxK9JcnSK4MuoQe1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22114b800f7so3694395ad.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 13:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604283; x=1741209083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrQlpyp/hJxEjROwpjxFWeF9DRf3GbUP7yL/ICVZ8Is=;
        b=CXzQ7E0y8RPvbvlpQKPNvgHVv9qdNgER+oG4SD78LtdH6O6/dDLBbqOx8oUglTevIR
         y4rk1xdls9SyFnVSnCHCDtPuBJ3wb1yuxS6Iaq9/nWemfkC0fjKb4PNUHXYxqlIu5yqF
         mgUd1wsWRJ8nyCTkxC6DSz7FFP8O4QhKjThIdHx8s994FzMIb2sq8kY+NH7BqLV0hHF6
         0to61MMfNZKDBGoyumCqzpuqfJqN6ngtlQRyBjktILdqPtuqJeC/zTM833+iGeyMAR+l
         eOrqgK+ndDsKsxZPcJMulUZDAFvdf+U8rrD3mSVJgusjG2qpBYLpqEDq4tFA59kEkK+x
         s3ZA==
X-Gm-Message-State: AOJu0Yxw2zXTXKmIu2UvOFaLSmhScyGMs1sDyfknTc3PZoZjpLSKEISs
	auAeX3XvJHv2iBob9pyUeBo5NvkerCoCGsUiA89W6v0ZXBVRrMfMyBfm
X-Gm-Gg: ASbGncvPJZL4xdnxdnX9Dw3mxDk3VKyIGkylyuHL+fQ+gQjCfqomuJibi9KytW7Gksy
	juX2j+7JeiNe+T3h9JSSdZJ/0we2bgiYtf4TxkvlDAkoTQ+kRrz79S299e5D/g4nZhGqa9WWCZb
	vT19HHGQC9a0dEABbCJUDSGVX9d512CSsJ7DPzf5HxRoMbuoFO+R2HvTnV8wxIfEmKYZL/RE5AM
	E2xmNG7+kgs8ryN8BUOHSLUG9wYIsq7OwjtWK7rfOqJelKr9Bt/LjtLwutXJdALnKJR40WA2gIA
	j9G7OZruRyUBY8EvIajsT8JCeA==
X-Google-Smtp-Source: AGHT+IF3dD5FCwNVrzxYEcC3gyc7HuuWNyE9asUY9Qm0gRZCrwswmF1BDgLEBWlxCMmB0UIVRl1bZw==
X-Received: by 2002:a17:90b:56cc:b0:2f1:2fa5:1924 with SMTP id 98e67ed59e1d1-2fe7e39f2afmr6170006a91.26.1740604282767;
        Wed, 26 Feb 2025 13:11:22 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe825ecb8esm2093358a91.35.2025.02.26.13.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 13:11:22 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v8 11/12] docs: net: document new locking reality
Date: Wed, 26 Feb 2025 13:11:07 -0800
Message-ID: <20250226211108.387727-12-sdf@fomichev.me>
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
index 29f61bd0ddf1..59bbe189d542 100644
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


