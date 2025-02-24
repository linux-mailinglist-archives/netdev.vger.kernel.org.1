Return-Path: <netdev+bounces-169147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EDDA42AC5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE21F189CFF3
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8609B26659D;
	Mon, 24 Feb 2025 18:08:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D126658F
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420506; cv=none; b=iAyFzUeqBO9B+atcyhNN1Zx33myxDhl967AyHlIxe3zC5uL3CMd/m6jdlovtBfhcdeWipl0YyHg0q4+PWVcvsjqYcF8Pa3Ni7LEhtF6RDZU9gOpP46g/dGRpLfZSJrF/IFHu3F6lIRfSh6iSfIJNEITCMEP8m47j0+RNCRNiJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420506; c=relaxed/simple;
	bh=hq6emUcmi6HAj/7F6cEm8jWrYRVR1DpsfsfcXddJc/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FApATb0jBz5rdxX6+zXppWcpszusOb0F9gxVBP3a9uCxTaocbCy+MdHQJf33S/cEDyvdsfPbzKpNp8Ay9VpORDje9s0RrKxn7sVpBNHLiQqRbPS9gU6EYMMFHUvqHwcu3jH+agPuW69WaO0zOY2GOOA469l8FGn2+FAp3PphEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221057b6ac4so90788595ad.2
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 10:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420504; x=1741025304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ER+CuPUfYJFDjECqJyIK7WhflcDyqEUOduvh6DPTY5Q=;
        b=hLCPbFiAxtQVk0Il2f5KxEmgtIH5FlJ4AcWSc/VWa7BD13f10VTFPzWcvD/lD5faUI
         gcHWmL0RSOFrfkigizDFtztGwgeSzQd3hIfq34jnntPgiHTFd7hidwZvkwt5/BMONFdC
         Mgu/UPGFD8i5xm8nu5KNVhCq7dtGKLcjedqYHmPckTHQvcfO1iGlAzPptr7Ozoa8k33S
         JKfyADkn2K4634Gd9eFoiJs8rySsaIX2l/rWorhV3mto31iTy23o+J+E4C5xq7mNK/v/
         ZN6xC5e+oayQsyABhKlVuq//jjxCLlxIs4DCvY1zq+eDNQYmXl+CYDJ72YmE4gZFyndD
         giTg==
X-Gm-Message-State: AOJu0YyzxaIwMxK8L/shp61+5TqzVuzdO++nlRGZ+bO+eZWR8pyYioSU
	4ThNQGJSROAhxBoiMdLMtchBkDlcfnCDE94tw2N2v376xPjRXd2b7bjp
X-Gm-Gg: ASbGncsFMyisfGcWo8LUETlzaGTpAfHeUUVHdCI2xdJV6usKMjl44PFHRAd6Ab/KS0h
	KL9np5YMK3IDc1POwdreh132mlLWnxN9AhENyRaAtlFQWITxrzAjhZ0VxAK7nmkofdUPN/am9hE
	DbKuUiDkBiAa2vIR6ur+62PqLcDOTmFY57HX6oUKcbCvNi4nozPCwOgASzuC61Q8D4Z/G5sLepY
	3fRwNz1LC9lZJgquYHR7hypXzx8Hfc7pIwswdOWo55AB6N1yFZbGz0zEsi5FhMauKnuWSxnWik6
	EVpJ8j0d2uahohUQWhmronv03w==
X-Google-Smtp-Source: AGHT+IFgKJv0wlinyfie8gHFpjwcb72ByHSiMK6wqbeKEYaq7PgDl/F+NDOj3vkeIAYeK4XCrDd7iQ==
X-Received: by 2002:a17:902:e5c4:b0:220:c813:dfd1 with SMTP id d9443c01a7336-221a1192a83mr229879605ad.36.1740420503845;
        Mon, 24 Feb 2025 10:08:23 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5348f1esm183127275ad.51.2025.02.24.10.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:08:23 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v7 11/12] docs: net: document new locking reality
Date: Mon, 24 Feb 2025 10:08:07 -0800
Message-ID: <20250224180809.3653802-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180809.3653802-1-sdf@fomichev.me>
References: <20250224180809.3653802-1-sdf@fomichev.me>
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
index b13d5da97f8c..950d91f43fc7 100644
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


