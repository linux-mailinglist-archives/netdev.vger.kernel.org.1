Return-Path: <netdev+bounces-126291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F419D9708A9
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 18:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F77B21255
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F6117836B;
	Sun,  8 Sep 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="X35UlQLr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15F174ECD
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811726; cv=none; b=P768yGZYZFRSzBz6Gedbtdrl7SCLjzaqjhG8M4r/i5ZVm6/JjD4IUej3/eq9XX7yTrHVlfDBsmuETHPS84KYId86iqcEkUMOTbvbKvsGXvNts2yIpaszjAkOX1AsdqGrjAZX5orHT8HAgyT+LczMvE3cXpKNMNN/+1EJ7Wou3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811726; c=relaxed/simple;
	bh=qZ0T8CKExRvD5T2B1Yh7TajT/3Et+GX0HYMbFOGpRZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAkoaowIXo7aZtUMEbtgxCFQkQYICW5C60sNUpLUu4S5oGszUFW9tevA1Csx97LT9FwI2N/zyOr6anQUjlMUepf7UwI/PGKNPNLaGTcdBVKyTs+Y4BGnF81XUrl2ZKIYuggn3wnj+rIBWeldkq0NVyS6R5fztxjghNZj5vrShls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=X35UlQLr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2055136b612so41476365ad.0
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811723; x=1726416523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiyI3KUrh2IbLXgMecroHUMIkcTz7Cey6giPzmfBc6M=;
        b=X35UlQLrm27ddHTcUnU2CVgp3rFZosh/uCoNiay7/1ArTVzzq9dU5qCTSMhgMnUhow
         1hxVXG0GdsdSpwW4rjTpSvQbF2mP9xVdE95BLRQG/fIPyqJy2A2obBkSjqXejdUpiKwS
         d5yKr66ITZi6A0fmPcJFKYZ9O/SKHEEuXVkuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811723; x=1726416523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiyI3KUrh2IbLXgMecroHUMIkcTz7Cey6giPzmfBc6M=;
        b=sEq4vmVflnMJdw4NhkWiMEMiFnpIw2hPBYCHc76dRJH/wKLXi77rtI3sUgB5wnMv95
         tk9y1L0+N1rj8R64VDGvP5246ug6wtJwB3PeIWC13txhchT0h/IuxJivGoFMFvi9RUag
         RZLujo9Yt52cr/AOASZ+u+uFd0vatlQ41BAxkchTNVM3Gpi1DxmiE57prnMr2pQBtiEa
         YAnMwrFrFE8h89e0XnPWwk3vpyYi61HEuCRDKKUFuJSEAVIoCgyE7d7K3l58ceHhSWQw
         YYMcOBq3rK3TKNC1JCrrKLXS4SjAIfI0RKOIiGFIHlcMn1EcdhNiaYgg1kpFaI05pbDC
         cHjg==
X-Gm-Message-State: AOJu0Yx2UGRPQYqMcWNEFc+iomsJGrd8wcv+s5HfPnxxDIBTPAcnvNZn
	LFFNJScZdh106Kfa2DyozV+/b3Z2zxyVmTN/rjJD+MWPMHBNnQC7P1pfUJk4x9ybxBSN3dvFo9U
	9JewNNIbA4uZ6Zkl69GwJ2U1RaPOHgkbT2G6ukZz4eyKmFGuVIeV9T3vir/3OLAJAIgWuRyGmNt
	8skm+ksX4t5U0OxUDpycKpY70NHv+XUyKDt5VtgOrr
X-Google-Smtp-Source: AGHT+IGn8u85dwq4o1reUH1GhhZmDtmxxPG4rQjIJ7eMol+kaITAp2KDE1rStg8cebOoGXifDmTKXQ==
X-Received: by 2002:a17:902:e888:b0:202:2fc8:da35 with SMTP id d9443c01a7336-206f06241femr125103985ad.55.1725811723333;
        Sun, 08 Sep 2024 09:08:43 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3179fsm21412535ad.258.2024.09.08.09.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:08:42 -0700 (PDT)
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
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 3/9] net: napi: Make napi_defer_hard_irqs per-NAPI
Date: Sun,  8 Sep 2024 16:06:37 +0000
Message-Id: <20240908160702.56618-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908160702.56618-1-jdamato@fastly.com>
References: <20240908160702.56618-1-jdamato@fastly.com>
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
 .../networking/net_cachelines/net_device.rst  |  1 -
 include/linux/netdevice.h                     |  2 +-
 net/core/dev.c                                | 10 ++---
 net/core/dev.h                                | 40 +++++++++++++++++++
 net/core/net-sysfs.c                          |  2 +-
 5 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index a82751c88d18..4cd801398c4e 100644
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
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 54da1c800e65..5a58cf61539e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2088,7 +2088,6 @@ struct net_device {
 	unsigned int		real_num_rx_queues;
 	struct netdev_rx_queue	*_rx;
 	unsigned long		gro_flush_timeout;
-	u32			napi_defer_hard_irqs;
 	unsigned int		gro_max_size;
 	unsigned int		gro_ipv4_max_size;
 	rx_handler_func_t __rcu	*rx_handler;
@@ -2412,6 +2411,7 @@ struct net_device {
 
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
+	u32			napi_defer_hard_irqs;
 
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
diff --git a/net/core/dev.c b/net/core/dev.c
index ca90e8cab121..9495448fedaa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6228,7 +6228,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	if (work_done) {
 		if (n->gro_bitmask)
 			timeout = READ_ONCE(n->dev->gro_flush_timeout);
-		n->defer_hard_irqs_count = READ_ONCE(n->dev->napi_defer_hard_irqs);
+		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
 	if (n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
@@ -6366,7 +6366,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
-		napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
+		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
 		timeout = READ_ONCE(napi->dev->gro_flush_timeout);
 		if (napi->defer_hard_irqs_count && timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
@@ -6648,6 +6648,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	INIT_HLIST_NODE(&napi->napi_hash_node);
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
+	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
@@ -11033,7 +11034,7 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		dev->gro_flush_timeout = 20000;
-		dev->napi_defer_hard_irqs = 1;
+		netdev_set_defer_hard_irqs(dev, 1);
 	}
 }
 EXPORT_SYMBOL_GPL(netdev_sw_irq_coalesce_default_on);
@@ -11982,7 +11983,6 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, real_num_rx_queues);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_flush_timeout);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, napi_defer_hard_irqs);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_ipv4_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler);
@@ -11995,7 +11995,7 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
 #endif
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, napi_storage);
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 112);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 108);
 }
 
 /*
diff --git a/net/core/dev.h b/net/core/dev.h
index 5654325c5b71..2584a7de189f 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -138,6 +138,46 @@ static inline void netif_set_gro_ipv4_max_size(struct net_device *dev,
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
+	if (n->napi_storage)
+		return READ_ONCE(n->napi_storage->defer_hard_irqs);
+	else
+		return READ_ONCE(n->dev->napi_defer_hard_irqs);
+}
+
+/**
+ * napi_set_defer_hard_irqs - set the defer_hard_irqs for a napi
+ * @n: napi_struct to set the defer_hard_irqs field
+ * @defer: the value the field should be set to
+ */
+static inline void napi_set_defer_hard_irqs(struct napi_struct *n, u32 defer)
+{
+	if (n->napi_storage)
+		WRITE_ONCE(n->napi_storage->defer_hard_irqs, defer);
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
index 0648dbf0e234..0a0bbbfb39b4 100644
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


