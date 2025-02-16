Return-Path: <netdev+bounces-166852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB15A378DC
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 00:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CCB27A2CA4
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 23:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826CA1ADC7B;
	Sun, 16 Feb 2025 23:33:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D21ACEC7
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 23:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739748782; cv=none; b=Fry44LACvGGnd5Ss9pdDB5bK8+gYm8xKxUVw9wRBihnRqqSu371JnKv431vqh7M4muEH/56VUFXO+n/fZT7DRvlkdQVImd5hiUUd4M4Ql3We/XPabOLqCxJfxk9PRweRm/JcSCz/l4Qw8cp/UQ4TS9R+pRmyO7NpnubmahrVecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739748782; c=relaxed/simple;
	bh=ygEt3JNkB4DMLlDss/1BWcar/3QcCL11CimTCCT0AEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2Ps7h34sMH5PtbkkW9ZBZDDMM8KN/IFxdX6YgpXuEvpZ2u/4Ab0YeNiJmiI40FGMGCUiDCKgjvXfmzoA8JaJDdMdKhVDh4f8imSLft4PM0ZK4ypW7zPR9LXa3WVg+kA9JyhrzrmpKqGnmOqXp78HXwMF434j43MRc8PL2U/oQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22100006bc8so28580105ad.0
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 15:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739748780; x=1740353580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zapDG9/9hdpx9wgq5fIA1GoEkxqk8rkSCyaszuzMaIk=;
        b=fMG5fwqb0zKMi0qUlpK+Fwmt8PD1t54UhV2jiqe0BNLbAlkLm9+tdMpM4EreYjaryj
         JKMlKD27w0pgkHsdOeUhTlAor7MveCBwH3PgHIO2ScQ0JqkUd4lD5wE00Pr2vce/JDiO
         VwurNmAUjg7p8WKCPMfJnFDlph91Mt2HryewP+xbp3M41oqgLAOWVex07c1bLGkWK701
         Sb5N5bp8UfcHM6+lISLJ8x0DNThfA/Xij+f/TFwVzB0bOorn4bOpBeqgFCuuRtgZ3p6Q
         ceogXtwEY5YBMdQ/Nr+WdaLaIskuKzM15AMMixvmdKRoOpJVZyz9RsjJ0CTFukcbeVm0
         vDDQ==
X-Gm-Message-State: AOJu0Yw0wQivelvY47t3S56FaXq/JVwm/fkxxst/ocFnRRS2ScV6F1Ot
	3KfpzdtAsAKOZaYCBgG/pKkqzQ0srqRCjiJtCdKqavjbOQm4ugYx+GxB
X-Gm-Gg: ASbGncs6mKHlyIvG+m5SAuM5cXr5xG14aEX7Ez/RxYh/NBKbUsoCEo1TkisMb3p6KmC
	hxTk8FTykVAV0oNXUftNSpqsjNeY2VLsST8VlpsEGjuUWN0w9RfkH9T2gw+SYS65QgGMODQTtdc
	56pP870NsmreIiqc/dTAGV+0ycGKUo9uvwps3nVtheBVcnnhrGY9G2gQycj3a96JRfSnJAKvY74
	Jqgy0nVapQ+aKuDP+m2gl2Upm5AoayYnVaBJygg35HZ3rqm0YDHRfkY9bs02ffM8gHGCQnIVCdG
	zNrEL73PzRU2W2E=
X-Google-Smtp-Source: AGHT+IFmdfHXsSUNhINNcw0HQ1WhVbPMRO4kSm33z/vvVLOXFTJLup8afh//uODELG39VbMpEAYwNA==
X-Received: by 2002:a05:6a21:6d86:b0:1ee:1c5b:9d7 with SMTP id adf61e73a8af0-1ee8cb4b58dmr11824254637.25.1739748779955;
        Sun, 16 Feb 2025 15:32:59 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7324276176bsm6843194b3a.154.2025.02.16.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 15:32:59 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v3 11/12] docs: net: document new locking reality
Date: Sun, 16 Feb 2025 15:32:44 -0800
Message-ID: <20250216233245.3122700-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216233245.3122700-1-sdf@fomichev.me>
References: <20250216233245.3122700-1-sdf@fomichev.me>
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
index 03fd15639d94..96922ef8b1df 100644
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


