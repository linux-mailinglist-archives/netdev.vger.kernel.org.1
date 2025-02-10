Return-Path: <netdev+bounces-164885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A7A2F880
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AAC3A2641
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51D12580D9;
	Mon, 10 Feb 2025 19:20:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8D72586DA
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215259; cv=none; b=ONjsVeA4BWQRqXw8ZX+BNIGw6Nc8SZYLsoZfbXoPe1ztyXW7H7+dy0ghc9xA+GmcjLLpO3xb+v8h7hH/AqpLGK94D40UH/h/EMVIl534HVwOD7mf0CFSopFn2rt7mPSONsD+mO6eULbpqxalLfU9GDOjnx9sx1jnK08oPrrMXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215259; c=relaxed/simple;
	bh=cjlBLG35jpBsHYHde1FyPnYJaMVA3mwk+VGYTWeEZKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/n9PJFHKQxMTQJqg0iKasCgwYYphUP9uEfXeiCwkZsoGBgsk5vKuUWVgvGQcweJI+67kX1dlOjNqCGGsFeAbQBExWTMy19pu7Pv/sN+dg6xu51HzrCjXAnCzctasGbZfF2YLGK9hHmon/YsxaX8/MlXoyiwyJsn+DCKK+PmS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f6d2642faso57281355ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215257; x=1739820057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIlyx5bzXKVNGkC/qnhV4gdj7VpO+O0JyoKEfstSSdY=;
        b=g9pAC8VmWeajq9xUkrbNlXk8gn+zZVwV98lezrlCFY11pRtB9aQCx0IQMiFOQ3apxA
         5rfFxdewav4Io0f3k4LWJbGhAemLdjZwasEL03judg+T8jlanZChNZTfiDMwhHxcg1pp
         gKBtLyrv79Z96foCUBzZb0gbzaK2wSAQL41CIYPqzRnOh0IafQdDOs2p2kLlncMIjm1I
         B/nuV2Zxu4EJZc5nbQ0YgaIPTGJBsrqeudx8lSvgP8Fsp0g6i4U5MLNRZ7cEZ3ss/OdF
         zhnfl8N9IGyHs+2YbvF1991DChqvf2A3MFDMZmWCWNiR2EkQoAG/2v+VCHVUqnr7T4EC
         xJxQ==
X-Gm-Message-State: AOJu0Ywm5QrgGnLgPrmlRNhAiOwDCdr2app9ObXlYYD6J9WqTcHYW9WL
	TFssFnT4tES9ZYHKvMgIVMxUp5ZV45FVTDj3BBCpWplbGo9Ewc6eBY1b
X-Gm-Gg: ASbGncsk3o2Ww36dodfa4AG27lfbY0j0nvFwsiAQLjqbhHSXjIT7V7JA/YlOzcbGKUS
	H3pBQA9ez/ZgWo1UMQMLfYpgSugtWu3YxykWTlMX2so+sduYfnXK/xqBo5kYre3td1acC0/MCZN
	SdgHd8KTo8fvBp/hbhk4zlQX4uqtHzbr5491yvyrAQZmhkhMH0KUAXDKZ4aADEaI6YZcjuew7BP
	25lij7+hmYT9Lxqzzsa+jL6M6bsNeqay77sGYbYaIZ8ZBwHFnBPXLf5lbMYdDgE/dv1AGA9Jklo
	mOEsy/S636OMoOk=
X-Google-Smtp-Source: AGHT+IE2Lv7aPFtSHTYiTFS+RrG5wGLKckytxBYMfg/3HkAQ9wlg20CFPI0OrFMckrFTyNISCmh/wg==
X-Received: by 2002:a17:902:db0b:b0:216:3297:92a4 with SMTP id d9443c01a7336-21f4e77c7d3mr283448875ad.46.1739215256990;
        Mon, 10 Feb 2025 11:20:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f36560ee5sm82239445ad.96.2025.02.10.11.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:20:56 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next 10/11] docs: net: document new locking reality
Date: Mon, 10 Feb 2025 11:20:42 -0800
Message-ID: <20250210192043.439074-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210192043.439074-1-sdf@fomichev.me>
References: <20250210192043.439074-1-sdf@fomichev.me>
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
index 675e5dee3219..59c7c35bae33 100644
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


