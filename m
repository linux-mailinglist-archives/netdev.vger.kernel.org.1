Return-Path: <netdev+bounces-127769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE82997666D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F25A1C225F0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723671A0BC2;
	Thu, 12 Sep 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CkMGpgOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D01A00C5
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135693; cv=none; b=eFe1KuruZpjm28NiWgABMoLuELsSItfrbbOUGZuZMV73tv3daWhZK+e1ymznx9siiOljUVCoO0XCjfg/g41yXRkFFXqAZ6r7p8kMflHcRorF/iSDGj9yyc+NgboMGn5JSF3+GNI4kdC4J/5znnCMUJq1kwPshEGrs3HpN1h9TjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135693; c=relaxed/simple;
	bh=h6jbFg3yI896qytI1xpUiCGRLIyGARAX6EcPd3lUMvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1GBbj6Fj2nkYqXmpkGuW+nUvXqvMI+4O851VuT+LS41IGVjmlNPUcBiKYNwE9e5Ee5c5+Hq1SS1qNpWwH+yMv+VnAd5QVbxpACr/2vtF0jNuKeT33SwEpKxZDsjS9ojSqvEiF238BewMv4/yBUxK+o9Y+HLMEUqt1o8Ik5bSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CkMGpgOJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2053616fa36so9678215ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726135691; x=1726740491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UBjebpmjpuyVZ0+PgYdCT0hRPVHfzVPHoo8s9iw55o=;
        b=CkMGpgOJwZhVycbPSf5XB6E8s/k8QuYk7KUjPutD8je/glcguo+bzLVQ7TsiINBKQp
         d9eg5eE2sAxDY4baKJTtZZM4iQ1S1KgJOFWsNzeltrCoi+T/UrHONdvYysCCVHwXp+3G
         Y2iZEV3LRyqFpsaIS7yq7YFGtuwW5XPLt0aww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135691; x=1726740491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UBjebpmjpuyVZ0+PgYdCT0hRPVHfzVPHoo8s9iw55o=;
        b=kk7tJNTfBd1nNGV2IbEFTUd1spGo/LvzGYGUAnk4KX9hbPAGiolSKmq/NQrDdsHaHR
         jWhX2UZTfCcQsJHg5gwwqfVwPtzU/kipng/Ca3WUy+w30+c2ZaVMF01X/3YF54lXo/Kq
         hXwzyZuht3RvetIuwyzPpFt/dZzELxIfTbTxUHYbGfsdlLDjyqjovuHGNkqJ56m4DR0s
         Xw6iRA3g50fFnstoSDTR4MnzGULHWGxLIxnTVvQMYvNHY3gyqrdF8mODXpPRj9/xdlgh
         jLvuB4S6ueb32sj5xrH9d9ERiOGxsUysr14jSB3IKvo4FMIPbC5PDnYZ7nA9mSkTTkPq
         BRag==
X-Gm-Message-State: AOJu0Yw3Fs0dk6o1jYgZCPVvp/FSvlY5/uQC7AbEaia3tKMRafQUnJDG
	7mfUd0hcMqo09wAmIwLXHfOlbWE6OhKoj5KUJ5gC0m+ewTJfTt7I87ee87cMAK6NUUuONfTZoIJ
	7r6HXz7NXAgGgN+xwzbdOCZ6wgRRfxZqa+mpdnFlKuz0RUEyGz1tRnnrHGnK/cP4fn83kYu0IPQ
	JD8IGr9MiogR41YJZZ9zvLuJ/VTubZzUsqqhfHcQ==
X-Google-Smtp-Source: AGHT+IHp7ODIKlvphCUjxcyN551gTEJqtHlLb5YGCWaSPJNMU99ey9TL4b/oodqIxQqkCxC0tA9LwQ==
X-Received: by 2002:a17:903:1c1:b0:207:1848:394e with SMTP id d9443c01a7336-2076e305b0cmr33824425ad.8.1726135690384;
        Thu, 12 Sep 2024 03:08:10 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm11583795ad.239.2024.09.12.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:08:09 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 1/9] net: napi: Make napi_defer_hard_irqs per-NAPI
Date: Thu, 12 Sep 2024 10:07:09 +0000
Message-Id: <20240912100738.16567-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912100738.16567-1-jdamato@fastly.com>
References: <20240912100738.16567-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow per-NAPI defer_hard_irqs setting.

The existing sysfs parameter is respected; writes to sysfs will write to
all NAPI structs for the device and the net_device defer_hard_irq field.
Reads from sysfs will read from the net_device field.

sysfs code was updated to guard against what appears to be a potential
overflow as the field is an int, but the value passed in is an unsigned
long.

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
index 2e40a137dc12..f28b96c95259 100644
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
index 8f4dead64284..d3d0680664b3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6221,7 +6221,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	if (work_done) {
 		if (n->gro_bitmask)
 			timeout = READ_ONCE(n->dev->gro_flush_timeout);
-		n->defer_hard_irqs_count = READ_ONCE(n->dev->napi_defer_hard_irqs);
+		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
 	if (n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
@@ -6359,7 +6359,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
-		napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
+		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
 		timeout = READ_ONCE(napi->dev->gro_flush_timeout);
 		if (napi->defer_hard_irqs_count && timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
@@ -6641,6 +6641,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	INIT_HLIST_NODE(&napi->napi_hash_node);
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
+	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
@@ -11023,7 +11024,7 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		dev->gro_flush_timeout = 20000;
-		dev->napi_defer_hard_irqs = 1;
+		netdev_set_defer_hard_irqs(dev, 1);
 	}
 }
 EXPORT_SYMBOL_GPL(netdev_sw_irq_coalesce_default_on);
@@ -11960,7 +11961,6 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, real_num_rx_queues);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_flush_timeout);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, napi_defer_hard_irqs);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_ipv4_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler);
@@ -11972,7 +11972,7 @@ static void __init net_dev_struct_check(void)
 #ifdef CONFIG_NET_XGRESS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
 #endif
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 104);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 100);
 }
 
 /*
diff --git a/net/core/dev.h b/net/core/dev.h
index 5654325c5b71..f24fa38a2cac 100644
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
+ * @netdev: the net_device for which all NAPIs will have their defer_hard_irqs set
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


