Return-Path: <netdev+bounces-166479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C2A361DD
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DB93AC7BD
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28C267393;
	Fri, 14 Feb 2025 15:34:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B01267716
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547296; cv=none; b=rUbD2SSgCuhkhvG6+jGExAfq3TmbNSZ9Ofp6/6aPyTKVS05PEX7++VYhaVTiYFZ8aHS0b7Y+TNz0wAK+fwvsNw2bn1twVRoGeQTfuJLpImJtQGDNYqiZytThcmiiKdhahU1omCgkctsXMtHDKKIvU+LSBL2g7TIZG/qW5PtJdxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547296; c=relaxed/simple;
	bh=49OHU5VoKXGjR5E3mPQaLPZqJMlSME66h41wWWgUasI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXYvuzS3Hy6QMDVAK/CoQUQXLehzAKvBSbtMKcbNJuMqJrRSN9f91qjVRGgzIxW1YT4cQyBQtkWdMlxBqRZqTRYU5JtN7G6URFI/KxVmj/g6ztQ9B1jusPorfesvsOZ+emMIl0GtvVn+uuQ6WH/IHdBr6otZsNY/M8b2GLpPG1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220dc3831e3so29294785ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 07:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547294; x=1740152094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tei9E7oEMfF0yI9g1AMPHrPN64i50X2S0eTiqU40RiQ=;
        b=uCCVceOKdV6uW66jMsozli0Oogb/0XGEKuoFzezstSJz+XcH2FiJOpHBaRL2qefFF8
         X7iCBYQGAgzkluFc/Mtc85242T9gIAfZLNlpvaXgPfL6zVO60FZEKHSBguPw48ydty0e
         dJlx/gA9g5yzglxi5ftsDRMTIHLnLZNEzok/5H8rJ2jXCdGeDXwNJDffbSJGLz4SD90j
         ST03YYmcODGgqaVnF7rXD0vsFrDWDN1zoiwtXkOA6pMmKQRFMwHS/NCY22HdfpK7aBId
         po3eeOUclMLKYuTx1V2sc9mzk0mlAxblGoH7HBBiyfbQ4xdmF3jJYuD1TY/GjPq8/A6Q
         zyrw==
X-Gm-Message-State: AOJu0YzKe4d0wU1jwFdWIIcpzmDDWAEKFLziHMQ0uFEu/jfnGC/vTA67
	RxJdBDtR1mfyNO8iD8RLzG5Meq90D6Ye+sNeOCvgeRRUIU2dvi+FnHaF
X-Gm-Gg: ASbGnctCL3yyE/Sx7cm6TBKfrQR9PyHw9LEUmk87+yrxKIV7xH/qsqrgS9Il4c86gJU
	Qwhr4rTd5FL5ntisMnToPrTUlIgs8BQoGRRieb38ynn0bxhQmScQ4w+nF21vHY7MS58C3Mbin5t
	7UbDvJMCAZIvIIWsI4Lb0WKQyCKBHzefqVhGJlCwmR2uIL6ljA8YwkkPv+Dya310XXbJ+eNZmx0
	kh0+aimYB/lg1YtH8EkZiiUMAZLuoYnzyZO2xPoJA9rfHyzVdTJie4KQH/uNCYWFuR0wfmNqK/i
	LAsm3akhOcy2KUg=
X-Google-Smtp-Source: AGHT+IE63+ulckWk1BSfXaPRliBwvKg00CjoFC4V140r48ot7bLOghGp1zltR4l215/bYQLo5fYl+w==
X-Received: by 2002:a05:6a21:700c:b0:1d9:a94:feec with SMTP id adf61e73a8af0-1ee6c910306mr12073413637.2.1739547294102;
        Fri, 14 Feb 2025 07:34:54 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242568a1asm3267257b3a.39.2025.02.14.07.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:34:53 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v2 10/11] docs: net: document new locking reality
Date: Fri, 14 Feb 2025 07:34:39 -0800
Message-ID: <20250214153440.1994910-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214153440.1994910-1-sdf@fomichev.me>
References: <20250214153440.1994910-1-sdf@fomichev.me>
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
index 53fc0d02abc8..d577a2e6505d 100644
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


