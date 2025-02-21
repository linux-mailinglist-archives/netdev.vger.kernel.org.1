Return-Path: <netdev+bounces-168651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCE9A40030
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8296E3B2FCE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C442254AE5;
	Fri, 21 Feb 2025 19:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70987253F3A
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167781; cv=none; b=dfW1hi6Q4mI5ou9cKxqYQbbMYlOAPYbP403R+eiKTbDv8FR2RZfTeL67MHZ3vJDbTwVnxnKuqbu1f2UAebeaOTHehMU5wsEaHRXgqWj07QBGUbSrnp7SqvMabKrbgTTm6m952J5UqE8mAUfRb8/dVFOpu7pF3CtCl+g0DRGxCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167781; c=relaxed/simple;
	bh=hq6emUcmi6HAj/7F6cEm8jWrYRVR1DpsfsfcXddJc/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l35wd/yby9sPUq3vjKiLP2q4fSNLjBMZC99RtwA8FrscSDj0w9TfP+xoI1OIW44xq+aNT2rQBk2vFiVczyvrE4pFAYqDF8auMZBaDvTIXavaUqkw2M0OE4dQWazS+Kr+CYHC8WkkGWLbU9E96q6JcSrpePT0q3dwk01w/6i8FRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22114b800f7so49875505ad.2
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167779; x=1740772579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ER+CuPUfYJFDjECqJyIK7WhflcDyqEUOduvh6DPTY5Q=;
        b=sbcrR1He52f3/Ydb1O519dXVctWP1V42EefqiZVAOd7ObfAzc7zGNuEdFO3VvhI+50
         CBGBI5hdN47jDy79Xs2+U18ACkNpvJHs6PKNV08NvL3lDQLlh5mJpICfVUGTrOUq0LE8
         tQ4U5ljQEjOsH+zoCkbpj/rlJFq4G7aRavtBBgB+mImKzcY1NleKlKzP0n3acZEbPNYZ
         V7McsS0FTB2TETNwTZXPgqbdCOs8LnLpePnCiYowrNJe4itLpLz9DrGdTHUiiDtIMGLH
         hVw1D6pFtdG5nsIwroQztjrp4q5v0ouDxQRLfCJ/EiiA2ovIb69m7DLKn4goJQUcSZwe
         hRuQ==
X-Gm-Message-State: AOJu0Yza/GoffiWwKmTGwDtGp7YFozLopaXDD5p3fcfuVZpAKR1z0PXQ
	4oBz9YsOPInBcz+aK2Df5ATbC3x7RX3XpDJaoOo0SO2jANPEehBCuhyN
X-Gm-Gg: ASbGncujdcwupEI0uBPCzzm2xMKBtpHShHh20qgCCESjk4l8oDa2vkreyBtml637Y/v
	6/762LN4h2eXWiowrDNJzjz2P0VJxTZFi9fh8Aq9ZOWFN+476FoQ7WPf58HHmTOnIO8wtFqxfRg
	lQ+Y2WvMX1IgCiHkUB5rijJWPxzgQv5Ykka9e5IS1s6ToXw7pIWPk4JyAGeAOoRb2vbmrvbE+V0
	39Ya78TIWIFPvnX+yULVRbElwZf2MWj8IzoZqopSD1QE5qeU3V+OpuJ6gNuSXqcSe7C0SIIBY3M
	wYGBYknP/l85sNW7sUavGEfXAA==
X-Google-Smtp-Source: AGHT+IFDj4VIilYL2LPp+czF33zK/wWkPPb3LuMmRyXs6iNWq3Qp2VSmM5zcaN9IyGPipwRxphWDQA==
X-Received: by 2002:a17:902:ea11:b0:216:48f4:4f1a with SMTP id d9443c01a7336-2219ff515edmr65945535ad.16.1740167779334;
        Fri, 21 Feb 2025 11:56:19 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53638c5sm140487685ad.58.2025.02.21.11.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:56:18 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v6 11/12] docs: net: document new locking reality
Date: Fri, 21 Feb 2025 11:56:03 -0800
Message-ID: <20250221195604.2103132-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221195604.2103132-1-sdf@fomichev.me>
References: <20250221195604.2103132-1-sdf@fomichev.me>
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


