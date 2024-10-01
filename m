Return-Path: <netdev+bounces-131093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D7E98C99E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093C1282FBE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEB21E00BC;
	Tue,  1 Oct 2024 23:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="V2TSWNFp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB31E00AF
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826817; cv=none; b=ZU5Q/+PYzfo+7DVXTrJcNTZBUy0mx5Hb2nDKL4wr/6ZQZ0255zEN0SYNeAUbbD5jzjRyndRApV5yDtJ6ny1RJS71Wr8ICXZ01h2x6qXwN9bAkZCV7GOdyv5iL2Sxhz6tMM80/NW/jXHlG6mdhCrpzO5f8sjJr16pQdLsyvLd6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826817; c=relaxed/simple;
	bh=NKSjiGMl8HVeQM8T+1w9Wip+oPRlHTP1Per56Ka6OO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBZSuibIix5cVQ7ROYO7gO5H4/4uk9A9RMfJScanaWXmBXayDWUsIqyx0/CF3RigODkV8baO7gmqXVnW7X1JR6irWJo8Sj5ZrghTLGCvpnPUQ8gnykj/H3ezvCyXRA6ROVRRiDWKPTLMfap5v73lVu7SrlE8NiE4CkOxzxUqJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=V2TSWNFp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db4c1a54easo3887649a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826815; x=1728431615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNxcXSwfx56FZIl6Cm7lpquz7kJ98h6HMSLIQEYkHDY=;
        b=V2TSWNFpjMKCzXWbOQ2fhlGWG1CoRSycziw8NOfXZFwXMyFXRC/UudQkzvKBQBt5fb
         AwxhOSekCXt7pjJlaUovQcDZzryQv95gKFs2AjhczgAtG2eLh6qnT7aKUHC7PVT1DAdM
         W5SzKdO7TGrhEyUBqZep3rRLBTw3UACn+GeTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826815; x=1728431615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNxcXSwfx56FZIl6Cm7lpquz7kJ98h6HMSLIQEYkHDY=;
        b=xPFvgGl6gJWXGEEfDmVaBrZ7bF2K1c6QPq0XIjWbT9eaWvzbR5RapdgZyr2VLuG8xk
         hoWHtNzI8/g7Aa0qFhRTm99q0EIc2gD1ycstFjWjSaE0BvHT69xLPnYzf7iq630mbeR+
         ND+701mHb0YmHMybP6A6NCjRKl2uzP0c6Wj80QzSKe7edBMk/sHIZi5BdQ0elrMynzBx
         4lKjMYXyoyhOuu9Ik89lYvfNSoKj6RI7YZZZejx17sOJRbMB+WtAdZSO5x3869i2djBx
         ELbj9LSf1aQO78CE+xu30ZiYoeIX09n9DH0B3NryzHKpvcUbDI2qPMGEqvP9zARo/grB
         VFBg==
X-Gm-Message-State: AOJu0YwjhOLxYZm7l4sqZUP7bLRVVUu9xK+T/gkRDXmcnaCR/KIltV+4
	twQ5L9acOamykeFvwzXZObgrOSP0B0tZGfM1lqTzoPcQn17UCyEkYJDNJDCtBTQtQykqXESbQ3S
	h1tUYrk4Qml+L3BD06Yasr8F2722jWr/UkGR4zqxhnRvyKNEhwoD3J2YHKqRLbsKQCSgeOef/sT
	cYlH5g+OuNExO53UYp+qFDRTcfkEgOKm23IoU=
X-Google-Smtp-Source: AGHT+IGk/edwwPJhtIujE/fEuThhfDAouuDtB+XD7cDRW7qhVSa/cILWYeRQBLMIALnf0IvrHUAu+w==
X-Received: by 2002:a17:90a:c383:b0:2da:da85:b705 with SMTP id 98e67ed59e1d1-2e18466e09cmr1620618a91.14.1727826815119;
        Tue, 01 Oct 2024 16:53:35 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:53:34 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v4 1/9] net: napi: Make napi_defer_hard_irqs per-NAPI
Date: Tue,  1 Oct 2024 23:52:32 +0000
Message-Id: <20241001235302.57609-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001235302.57609-1-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defer_hard_irqs to napi_struct in preparation for per-NAPI
settings.

The existing sysfs parameter is respected; writes to sysfs will write to
all NAPI structs for the device and the net_device defer_hard_irq field.
Reads from sysfs show the net_device field.

The ability to set defer_hard_irqs on specific NAPI instances will be
added in a later commit, via netdev-genl.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../networking/net_cachelines/net_device.rst  |  2 +-
 include/linux/netdevice.h                     |  3 +-
 net/core/dev.c                                | 10 +++---
 net/core/dev.h                                | 36 +++++++++++++++++++
 net/core/net-sysfs.c                          |  2 +-
 5 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 22b07c814f4a..eeeb7c925ec5 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -99,7 +99,6 @@ unsigned_int                        num_rx_queues
 unsigned_int                        real_num_rx_queues      -                   read_mostly         get_rps_cpu
 struct_bpf_prog*                    xdp_prog                -                   read_mostly         netif_elide_gro()
 unsigned_long                       gro_flush_timeout       -                   read_mostly         napi_complete_done
-u32                                 napi_defer_hard_irqs    -                   read_mostly         napi_complete_done
 unsigned_int                        gro_max_size            -                   read_mostly         skb_gro_receive
 unsigned_int                        gro_ipv4_max_size       -                   read_mostly         skb_gro_receive
 rx_handler_func_t*                  rx_handler              read_mostly         -                   __netif_receive_skb_core
@@ -183,3 +182,4 @@ struct_devlink_port*                devlink_port
 struct_dpll_pin*                    dpll_pin                                                        
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
+u32                                 napi_defer_hard_irqs
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e87b5e488325..55764efc5c93 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -377,6 +377,7 @@ struct napi_struct {
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
 	int			irq;
+	u32			defer_hard_irqs;
 };
 
 enum {
@@ -2075,7 +2076,6 @@ struct net_device {
 	unsigned int		real_num_rx_queues;
 	struct netdev_rx_queue	*_rx;
 	unsigned long		gro_flush_timeout;
-	u32			napi_defer_hard_irqs;
 	unsigned int		gro_max_size;
 	unsigned int		gro_ipv4_max_size;
 	rx_handler_func_t __rcu	*rx_handler;
@@ -2398,6 +2398,7 @@ struct net_device {
 
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
+	u32			napi_defer_hard_irqs;
 
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
diff --git a/net/core/dev.c b/net/core/dev.c
index cd479f5f22f6..748739958d2a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6227,7 +6227,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	if (work_done) {
 		if (n->gro_bitmask)
 			timeout = READ_ONCE(n->dev->gro_flush_timeout);
-		n->defer_hard_irqs_count = READ_ONCE(n->dev->napi_defer_hard_irqs);
+		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
 	if (n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
@@ -6365,7 +6365,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
-		napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
+		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
 		timeout = READ_ONCE(napi->dev->gro_flush_timeout);
 		if (napi->defer_hard_irqs_count && timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
@@ -6647,6 +6647,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	INIT_HLIST_NODE(&napi->napi_hash_node);
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
+	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
@@ -11053,7 +11054,7 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		dev->gro_flush_timeout = 20000;
-		dev->napi_defer_hard_irqs = 1;
+		netdev_set_defer_hard_irqs(dev, 1);
 	}
 }
 EXPORT_SYMBOL_GPL(netdev_sw_irq_coalesce_default_on);
@@ -11991,7 +11992,6 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, real_num_rx_queues);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_flush_timeout);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, napi_defer_hard_irqs);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_ipv4_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler);
@@ -12003,7 +12003,7 @@ static void __init net_dev_struct_check(void)
 #ifdef CONFIG_NET_XGRESS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
 #endif
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 104);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 100);
 }
 
 /*
diff --git a/net/core/dev.h b/net/core/dev.h
index 5654325c5b71..b3792219879b 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -138,6 +138,42 @@ static inline void netif_set_gro_ipv4_max_size(struct net_device *dev,
 	WRITE_ONCE(dev->gro_ipv4_max_size, size);
 }
 
+/**
+ * napi_get_defer_hard_irqs - get the NAPI's defer_hard_irqs
+ * @n: napi struct to get the defer_hard_irqs field from
+ *
+ * Return: the per-NAPI value of the defar_hard_irqs field.
+ */
+static inline u32 napi_get_defer_hard_irqs(const struct napi_struct *n)
+{
+	return READ_ONCE(n->defer_hard_irqs);
+}
+
+/**
+ * napi_set_defer_hard_irqs - set the defer_hard_irqs for a napi
+ * @n: napi_struct to set the defer_hard_irqs field
+ * @defer: the value the field should be set to
+ */
+static inline void napi_set_defer_hard_irqs(struct napi_struct *n, u32 defer)
+{
+	WRITE_ONCE(n->defer_hard_irqs, defer);
+}
+
+/**
+ * netdev_set_defer_hard_irqs - set defer_hard_irqs for all NAPIs of a netdev
+ * @netdev: the net_device for which all NAPIs will have defer_hard_irqs set
+ * @defer: the defer_hard_irqs value to set
+ */
+static inline void netdev_set_defer_hard_irqs(struct net_device *netdev,
+					      u32 defer)
+{
+	struct napi_struct *napi;
+
+	WRITE_ONCE(netdev->napi_defer_hard_irqs, defer);
+	list_for_each_entry(napi, &netdev->napi_list, dev_list)
+		napi_set_defer_hard_irqs(napi, defer);
+}
+
 int rps_cpumask_housekeeping(struct cpumask *mask);
 
 #if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 05cf5347f25e..25125f356a15 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -429,7 +429,7 @@ static int change_napi_defer_hard_irqs(struct net_device *dev, unsigned long val
 	if (val > S32_MAX)
 		return -ERANGE;
 
-	WRITE_ONCE(dev->napi_defer_hard_irqs, val);
+	netdev_set_defer_hard_irqs(dev, (u32)val);
 	return 0;
 }
 
-- 
2.25.1


