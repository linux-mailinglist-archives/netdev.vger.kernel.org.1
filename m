Return-Path: <netdev+bounces-134654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8146799AB64
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0078D1F232DB
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0C91D0F6A;
	Fri, 11 Oct 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ssItfq8g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2041CC174
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672355; cv=none; b=ZAzcHDfScin8x1jVqABeo6OAanHQiEqSarMkSjbKf9aB+I2AtA2eHiWvv79NA7zt70qDeR8dtCSKA0g4GyyeZoKexxf6Koasr9ITNp7hwwT9KHP4sJMG7xTSaw8Gf9fPOQCcXTn1hgHA2f99cp6+zVo3n6tZq2CO4rXJ/2A39as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672355; c=relaxed/simple;
	bh=jq2l+fxGXKoykb2l2iMxd+SFdR3dmpqdfUhhGDXCRWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/TiH+NFMchekYojDxRisQnRYTZUovR8xXi0W02fgUmjLVYR2YT1IIAzzMNGRl7GlJwUi8bx+npDyoxCI4QRSsTUK75phrHncy8PRiRO09l3Ot+bR5I+GdsW+YMhl8iHd1cclCuz7W9EHvhouNAMmEg1AzcpcJuBQvKQjOiTMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ssItfq8g; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so1685489a91.1
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672352; x=1729277152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80z0m3ADJ29bsKYQWP0ErWo8cSlJeLlTsXMs/xhftIw=;
        b=ssItfq8gtTOaiM+A3T2CvbdGjVxfdLYPTuBBjTiUo39PUwSG4S0YxJpvVBe1D5RG76
         sUKJ2Q9Jx9CmlA0WbrO95GnsntbgYL41Zf0FWQYtE2h1f6VKbx1YJmnAcuEFFtqRjJB1
         D3x+oNQUpIaCUfVmRjOB+1h91y6u4+9jZxfNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672352; x=1729277152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80z0m3ADJ29bsKYQWP0ErWo8cSlJeLlTsXMs/xhftIw=;
        b=TkRceXxFsp7oAMaqROGObek2WO7EE4GWQsyZbxCafzvDfNsdSbYOSICWs1udNKDln/
         0Yt5DgR3XNbZKpagAFZrA8GBnE+60kMZuH8LCHOLUMebxoZ1azzhadTJFQr98yLI2Qw/
         fd79WPn6eBzo5o2ZttNiJpSK0FGEGdfL4ksA3yDHqB1bxF3jbjx2913/eqK+d/+qKIb9
         UjZ/tSOSImRu85D8DMqtCRHfZWsfu2WNNP1hMJ7O8GNb/LJX4glkM4DwjqJhq9Wr7Gqw
         nelVo58rb5UHkpIFM2/2AU9r3aw0TeAUWevmryFG5osD1jYomsMa/mnQ9l0434AcdOx+
         2qUw==
X-Gm-Message-State: AOJu0YwaZjQ6o2jCvcGIcrHh0YJLCKFpoB0Fk8QCpr3WRF9TRySM0xNV
	bxuGYvgjchXQZXE4jA/GBux3g7hY62ZM5Ag/MuX1reBb2HMo9CEAAWB/h5sVInfSHD86V0EpVQk
	vPzOZb/RUsyQ8ZvmFseP/VAUpaVrshSj1Eb25stR9CHmpNTyIphg/8224vkXRBFdP2XDVt4AMSC
	ES7zPyppvu/ySGRW6uwy+g2+DttwYgljkjFA0=
X-Google-Smtp-Source: AGHT+IFYcs3KxuO+CWTjDrHOAcPtxCILOLE7nbtAh6uSh43xs0LBvyu0sXaZNFv82HkWTgZFGAsk5A==
X-Received: by 2002:a17:90b:897:b0:2e2:e086:f5c0 with SMTP id 98e67ed59e1d1-2e2e086f663mr9255734a91.5.1728672352013;
        Fri, 11 Oct 2024 11:45:52 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:45:51 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [net-next v6 3/9] net: napi: Make gro_flush_timeout per-NAPI
Date: Fri, 11 Oct 2024 18:44:58 +0000
Message-Id: <20241011184527.16393-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011184527.16393-1-jdamato@fastly.com>
References: <20241011184527.16393-1-jdamato@fastly.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  3 +-
 net/core/dev.c                                | 12 +++---
 net/core/dev.h                                | 40 +++++++++++++++++++
 net/core/net-sysfs.c                          |  2 +-
 5 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 5a7388b2ab6f..67910ea49160 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -186,5 +186,6 @@ struct dpll_pin*                    dpll_pin
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
 u64                                 max_pacing_offload_horizon
+unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
 =================================== =========================== =================== =================== ===================================================================================
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2e7bc23660ec..93241d4de437 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -373,6 +373,7 @@ struct napi_struct {
 	unsigned int		napi_id;
 	struct hrtimer		timer;
 	struct task_struct	*thread;
+	unsigned long		gro_flush_timeout;
 	u32			defer_hard_irqs;
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
@@ -2085,7 +2086,6 @@ struct net_device {
 	int			ifindex;
 	unsigned int		real_num_rx_queues;
 	struct netdev_rx_queue	*_rx;
-	unsigned long		gro_flush_timeout;
 	unsigned int		gro_max_size;
 	unsigned int		gro_ipv4_max_size;
 	rx_handler_func_t __rcu	*rx_handler;
@@ -2413,6 +2413,7 @@ struct net_device {
 	struct dim_irq_moder	*irq_moder;
 
 	u64			max_pacing_offload_horizon;
+	unsigned long		gro_flush_timeout;
 	u32			napi_defer_hard_irqs;
 
 	/**
diff --git a/net/core/dev.c b/net/core/dev.c
index fbaa9eabf77f..e21ace3551d5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6232,12 +6232,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 
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
@@ -6372,7 +6372,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
 		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		timeout = READ_ONCE(napi->dev->gro_flush_timeout);
+		timeout = napi_get_gro_flush_timeout(napi);
 		if (napi->defer_hard_irqs_count && timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
 			skip_schedule = true;
@@ -6654,6 +6654,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
 	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
+	napi_set_gro_flush_timeout(napi, READ_ONCE(dev->gro_flush_timeout));
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
@@ -11059,7 +11060,7 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
 	WARN_ON(dev->reg_state == NETREG_REGISTERED);
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		dev->gro_flush_timeout = 20000;
+		netdev_set_gro_flush_timeout(dev, 20000);
 		netdev_set_defer_hard_irqs(dev, 1);
 	}
 }
@@ -12003,7 +12004,6 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ifindex);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, real_num_rx_queues);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_flush_timeout);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_ipv4_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler);
@@ -12015,7 +12015,7 @@ static void __init net_dev_struct_check(void)
 #ifdef CONFIG_NET_XGRESS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
 #endif
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 100);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 92);
 }
 
 /*
diff --git a/net/core/dev.h b/net/core/dev.h
index 0716b1048261..7d0aab7e3ef1 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -184,6 +184,46 @@ static inline void netdev_set_defer_hard_irqs(struct net_device *netdev,
 		napi_set_defer_hard_irqs(napi, defer);
 }
 
+/**
+ * napi_get_gro_flush_timeout - get the gro_flush_timeout
+ * @n: napi struct to get the gro_flush_timeout from
+ *
+ * Return: the per-NAPI value of the gro_flush_timeout field.
+ */
+static inline unsigned long
+napi_get_gro_flush_timeout(const struct napi_struct *n)
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
+ * netdev_set_gro_flush_timeout - set gro_flush_timeout of a netdev's NAPIs
+ * @netdev: the net_device for which all NAPIs will have gro_flush_timeout set
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


