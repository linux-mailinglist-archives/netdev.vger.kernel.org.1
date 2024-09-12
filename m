Return-Path: <netdev+bounces-127771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA11976672
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EEDA282A3E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC01A2550;
	Thu, 12 Sep 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xGuyByfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181C1A2620
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135701; cv=none; b=PuqO0vNhwZek3c+Z0minmLcQtlX+EXGidce8WZYBH/Xi60A5rYH3Y8aLJ4nPGlRNEHpVVcB4awz5L36/YxQA2S0M83hiB1OLItAZ4o52ziVqJzowb/qp8J4Nzxb0p7eoArSu/F9KQ6OrWajc+146yCylW5W6AuTdNaE9V/5dwMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135701; c=relaxed/simple;
	bh=UYFHT5Rtrjp2TbS7AQ5vsSkVHNaJO8WMKD93eugQvpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MSla0KXN5Rxdt1eJBtYRX/9kZLAKlnkdgp9y76lPvBl8tZ/FxXfK+waLVNj54BrdMpxirFZW8avpy9qsgJ/OhU7bhrw/XxoFByhB/3ltnFN7H5jlcPAk9eEWFn1iTHq+E27+njs9DD+fhJwA6Ot30xku/is0phsXZY6ODjEG0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xGuyByfZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-207115e3056so7522465ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 03:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726135699; x=1726740499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YerXYBbzlInpcAAkn5hrMa1T09WgrIl+NF/PwzLH+gI=;
        b=xGuyByfZka6UvNEfSJ63Mxl/HRy8jWaYHiP+lZzQsTPs/nMt+OnzLSNo58/2vn8flu
         nyhoJ7DnXv5jzhOpqt6LwiLTucKX86Vx3UlIsnYvo1qD2r1M/Kf8HKAKtWzCfVNM3InD
         LZ4cPKWuQifGj1jN4nufG3qn1oaLjnboV62jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135699; x=1726740499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YerXYBbzlInpcAAkn5hrMa1T09WgrIl+NF/PwzLH+gI=;
        b=RyinojpUNt7I9rgy7LZpfe7hZJXiWFdyahVRM6GmVnT1F0SY312OHQa9fFCRtgsdY9
         P0lz11k+/4+53li0bnByVpx3tr0iQ0TH+nCcFd0lF4VEWy04qKMzetHSvMQhfe7oYOWe
         OanLgaFZRM3l9LnN1hpSsnJJQSlIh/SDQUHqM7s/oyqIBizEIsb41zx/9Hu/tC6I8pr4
         3LGNn7MypKaDxDPrfM6cekLENZ2F+1M4NJVYlsWvftwIkI5rT0rNuHdBC+d3mPYgEnVU
         At0D94mlKFmrs+MxsW9KtYvQI7y8lhV5iA0PuCghmaLEtGcdapBclTiCiafIUg+KZbYC
         rw1w==
X-Gm-Message-State: AOJu0Ywglghnc5BqYSiiW2CDQzZDhabEVeESnN46DsOw8qDZ3AWjHPJY
	ZaWruWmWPmR3jtn9686DTRctEjjVGvo1yCc1Mxw8GsSMBDhEhyPxiyfkcDx8GQOxBbDPpOTKEnr
	idVbhgFwhq5MU3J4nnPBqklVtk7h5wmC0XeGXdBWCDNs/hA8Aj40PQOHdttWszvEtAJq4zftY9S
	j8mxq1NS8SC+acA7fDNAXmLTOcx8sL5NbSv1lrNg==
X-Google-Smtp-Source: AGHT+IForQeMfGb0GCdvRNabl/PACHbWLROiaNCpFz1nTSKb8kGS4noXiMmFQIaSiz28x7rm1JGmYw==
X-Received: by 2002:a17:902:c943:b0:203:a0ea:63c5 with SMTP id d9443c01a7336-2076d71ada8mr29329145ad.0.1726135698853;
        Thu, 12 Sep 2024 03:08:18 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm11583795ad.239.2024.09.12.03.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:08:18 -0700 (PDT)
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
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 3/9] net: napi: Make gro_flush_timeout per-NAPI
Date: Thu, 12 Sep 2024 10:07:11 +0000
Message-Id: <20240912100738.16567-4-jdamato@fastly.com>
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

Allow per-NAPI gro_flush_timeout setting.

The existing sysfs parameter is respected; writes to sysfs will write to
all NAPI structs for the device and the net_device gro_flush_timeout
field. Reads from sysfs will read from the net_device field.

The ability to set gro_flush_timeout on specific NAPI instances will be
added in a later commit, via netdev-genl.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../networking/net_cachelines/net_device.rst  |  2 +-
 include/linux/netdevice.h                     |  3 +-
 net/core/dev.c                                | 12 +++---
 net/core/dev.h                                | 39 +++++++++++++++++++
 net/core/net-sysfs.c                          |  2 +-
 5 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index eeeb7c925ec5..3d02ae79c850 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -98,7 +98,6 @@ struct_netdev_queue*                _rx                     read_mostly
 unsigned_int                        num_rx_queues                                                   
 unsigned_int                        real_num_rx_queues      -                   read_mostly         get_rps_cpu
 struct_bpf_prog*                    xdp_prog                -                   read_mostly         netif_elide_gro()
-unsigned_long                       gro_flush_timeout       -                   read_mostly         napi_complete_done
 unsigned_int                        gro_max_size            -                   read_mostly         skb_gro_receive
 unsigned_int                        gro_ipv4_max_size       -                   read_mostly         skb_gro_receive
 rx_handler_func_t*                  rx_handler              read_mostly         -                   __netif_receive_skb_core
@@ -182,4 +181,5 @@ struct_devlink_port*                devlink_port
 struct_dpll_pin*                    dpll_pin                                                        
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
+unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f28b96c95259..3e07ab8e0295 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -377,6 +377,7 @@ struct napi_struct {
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
 	int			irq;
+	unsigned long		gro_flush_timeout;
 	u32			defer_hard_irqs;
 };
 
@@ -2075,7 +2076,6 @@ struct net_device {
 	int			ifindex;
 	unsigned int		real_num_rx_queues;
 	struct netdev_rx_queue	*_rx;
-	unsigned long		gro_flush_timeout;
 	unsigned int		gro_max_size;
 	unsigned int		gro_ipv4_max_size;
 	rx_handler_func_t __rcu	*rx_handler;
@@ -2398,6 +2398,7 @@ struct net_device {
 
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
+	unsigned long		gro_flush_timeout;
 	u32			napi_defer_hard_irqs;
 
 	u8			priv[] ____cacheline_aligned
diff --git a/net/core/dev.c b/net/core/dev.c
index d3d0680664b3..f2fd503516de 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6220,12 +6220,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 
 	if (work_done) {
 		if (n->gro_bitmask)
-			timeout = READ_ONCE(n->dev->gro_flush_timeout);
+			timeout = napi_get_gro_flush_timeout(n);
 		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
 	if (n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
-		timeout = READ_ONCE(n->dev->gro_flush_timeout);
+		timeout = napi_get_gro_flush_timeout(n);
 		if (timeout)
 			ret = false;
 	}
@@ -6360,7 +6360,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
 		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		timeout = READ_ONCE(napi->dev->gro_flush_timeout);
+		timeout = napi_get_gro_flush_timeout(napi);
 		if (napi->defer_hard_irqs_count && timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
 			skip_schedule = true;
@@ -6642,6 +6642,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
 	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
+	napi_set_gro_flush_timeout(napi, READ_ONCE(dev->gro_flush_timeout));
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
@@ -11023,7 +11024,7 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
 	WARN_ON(dev->reg_state == NETREG_REGISTERED);
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		dev->gro_flush_timeout = 20000;
+		netdev_set_gro_flush_timeout(dev, 20000);
 		netdev_set_defer_hard_irqs(dev, 1);
 	}
 }
@@ -11960,7 +11961,6 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ifindex);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, real_num_rx_queues);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_flush_timeout);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_ipv4_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler);
@@ -11972,7 +11972,7 @@ static void __init net_dev_struct_check(void)
 #ifdef CONFIG_NET_XGRESS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
 #endif
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 100);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 92);
 }
 
 /*
diff --git a/net/core/dev.h b/net/core/dev.h
index f24fa38a2cac..a9d5f678564a 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -174,6 +174,45 @@ static inline void netdev_set_defer_hard_irqs(struct net_device *netdev,
 		napi_set_defer_hard_irqs(napi, defer);
 }
 
+/**
+ * napi_get_gro_flush_timeout - get the gro_flush_timeout
+ * @n: napi struct to get the gro_flush_timeout from
+ *
+ * Return: the per-NAPI value of the gro_flush_timeout field.
+ */
+static inline unsigned long napi_get_gro_flush_timeout(const struct napi_struct *n)
+{
+	return READ_ONCE(n->gro_flush_timeout);
+}
+
+/**
+ * napi_set_gro_flush_timeout - set the gro_flush_timeout for a napi
+ * @n: napi struct to set the gro_flush_timeout
+ * @timeout: timeout value to set
+ *
+ * napi_set_gro_flush_timeout sets the per-NAPI gro_flush_timeout
+ */
+static inline void napi_set_gro_flush_timeout(struct napi_struct *n,
+					      unsigned long timeout)
+{
+	WRITE_ONCE(n->gro_flush_timeout, timeout);
+}
+
+/**
+ * netdev_set_gro_flush_timeout - set gro_flush_timeout for all NAPIs of a netdev
+ * @netdev: the net_device for which all NAPIs will have their gro_flush_timeout set
+ * @timeout: the timeout value to set
+ */
+static inline void netdev_set_gro_flush_timeout(struct net_device *netdev,
+						unsigned long timeout)
+{
+	struct napi_struct *napi;
+
+	WRITE_ONCE(netdev->gro_flush_timeout, timeout);
+	list_for_each_entry(napi, &netdev->napi_list, dev_list)
+		napi_set_gro_flush_timeout(napi, timeout);
+}
+
 int rps_cpumask_housekeeping(struct cpumask *mask);
 
 #if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 25125f356a15..2d9afc6e2161 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -409,7 +409,7 @@ NETDEVICE_SHOW_RW(tx_queue_len, fmt_dec);
 
 static int change_gro_flush_timeout(struct net_device *dev, unsigned long val)
 {
-	WRITE_ONCE(dev->gro_flush_timeout, val);
+	netdev_set_gro_flush_timeout(dev, val);
 	return 0;
 }
 
-- 
2.25.1


