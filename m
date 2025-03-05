Return-Path: <netdev+bounces-172149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF902A50523
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E351169AD4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202681917E4;
	Wed,  5 Mar 2025 16:37:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3961FFE
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192674; cv=none; b=muHBRdMJf1K+4rzVZtuyCYi+Zogyh2Sf1xgDdHO66Rj/4AJ6nqTAakgaG0sGb9mXAFaup4OPHt+pswzYtIF1v84JUmMbIpEtY8rJLknurGYmMf1fTNomKumh2dYIiLHBxqcBrTvskzjFf1cuHWV6ZrVcUBefExVTCZjM1rdnGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192674; c=relaxed/simple;
	bh=mvZ5nDO2zHRvismY8ULnT4BoEMXbnPJw4M+Ypvy90fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ParzG3KVjKP5ig8tntUv0Lz2If8AHkVemTgn47oVU1NCal+tBawGkpfNImaa/SX1uZfV3NC+lRLNenff85ihtjT5VcE+6/0mmdALAPIOAWJ2qfQPfDhDziwFUzTtWrOtxsf18jJgj7DYbHz3ka6vxqwhdDHZxrfIuN4Pm0mGsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fe8c35b6cbso11312313a91.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192671; x=1741797471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFo798Kck18PGMVFsuH1Uc6+NAoJtSAscgl7hYdDJmo=;
        b=N5AW5bqbOjTLo7LCLe7NOJqMoZCXDLpj58W/TGJORBj4NVGr7MW+Wol/cl7yJbMmk6
         u7YIIgTvUGHQpNGj+wqWO3fHiTxu5j9n2xVAJ47t35PJcaiDzCHw5y/nnJko+Ixz/zWs
         qineQ2w11ofbqnZ9ngRyH4y1eHI1fqCLPnA+qFub6GEZEllxT7yNFSlnFv/0xVnDU+Md
         2oVid5ngsUOjyqATPcb60BavzUsuFIwS6rlTyHZlkT/yH1ZKzpvjOXVleQNj5bhxiycZ
         P0nssZCCi7ZN6MoYBXefBEvrbAfu/f9+ewTPrwYYDQvB3LYFBgjN4ubCR7VzUPisKH8a
         t1mA==
X-Gm-Message-State: AOJu0YwhnhUBJzy3RuwEnW9Z6B5sAzx2ryxVUV/CjxmTc//7tfrRnJpX
	vwDOmppKNob/5HZm+OX/q4I8nNZIN0XfQ/1Fw6khmd89vzA1yHDKikPm
X-Gm-Gg: ASbGncut1R9699gPve/eZEcq5L/9JyHTl136XT8ctZ20+5NpZOyMTsDMmiTYwG328fl
	eT+0hDFXzV4c4bG//tF/hsLhCE6rGx2aQ48hZAyS4X+Vh8uF+ItimJSGIEN70ixR34U+9ILKkNL
	q44azfuzdgLR4y0y6FIErqjTbfGZ/gvDVg4hVuO5FVnx450CrD6ZfSVwvOftV0OMtdntYyJkwqe
	J+Dj8TCYHj7rJ/wd40WqQ1yjIIRvuHsueUbxxGowqUN+DF+ayuVVHTllUavg+CRUcX+5Ogxr3W4
	4nKMyLMyltW/ZBqhYwSo/wPZWkzXviyLzV6fm5LD7hKk
X-Google-Smtp-Source: AGHT+IGb4+Gkynf6kU+1UlORYvAB2jINlzq/OFFnH01f4A0jHOEtJ7AY5UrqESFO2/uDtfYSd3tIYg==
X-Received: by 2002:a17:90b:498d:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-2ff497c2d0emr6404037a91.29.1741192670040;
        Wed, 05 Mar 2025 08:37:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff36bef80esm3123218a91.1.2025.03.05.08.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:37:49 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 13/14] docs: net: document new locking reality
Date: Wed,  5 Mar 2025 08:37:31 -0800
Message-ID: <20250305163732.2766420-14-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305163732.2766420-1-sdf@fomichev.me>
References: <20250305163732.2766420-1-sdf@fomichev.me>
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
index adf201617b72..2f8560a354ba 100644
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


