Return-Path: <netdev+bounces-154834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458189FFF48
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 20:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0607D3A389C
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861221B3944;
	Thu,  2 Jan 2025 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2JQ08xx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D731B4153
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735845155; cv=none; b=Tghf/9MxrgUAXRwmIe+cI/hIKBArqFCjvvDzJeN5FRS/1r+VQzjbNubkA0SyCwTPbTwg3hpov19AsUDlMyKpLtpvngYUE82HtyeMfBR9lM02aGGzB0xRvwS9aGJoNLTF2fLuOSf1tpO67yTfVJ9cWn3FPYjTc/981ao45BAjCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735845155; c=relaxed/simple;
	bh=LW/zSQGtxoTxPEP6l3I9wwZh+Wt+abfeVXThB2HE0Vc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RkXEjqFk4vk/U1NJq8YQvyWeEG1AvIgbTpjVo7VyVriHyJotauS7YhZnooqG30nskyddGWcWVESb/DqrU9iDu2oTplvz3vWLWzypErKJjePoMI+md4gsdnenFPdXUZob8IQKHNeCXyzXPQrm7kv92IzcFzSdjZF52FRJiKaXd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2JQ08xx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso15475981a91.2
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 11:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735845153; x=1736449953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MtjhhJiEXKyaw1nvpEbH/yDIveLeL8Bw5DjTTO0PZIM=;
        b=R2JQ08xxIipLdB/RiIKA9GRLp0TERPB6Ra/F/sqmpxLVyvjjRyJcd709msROo1UXJl
         jir/waWwZjL5ly+fgnwG0cM3vEIQnF8gfjMqbJEg72l4d+6JxAp70tLAZT1G/+wWuisl
         reMCkDo/PL8AlUYhPZUi/ddUgceHM+MBl3Xb+eCfv7zaxxMapojsgAWlpwxyPgU5PQMu
         n+0MmfGlMN5/3OHzaT8BkHZTjvmVH64eOL66cS2XbKbSB4MdqYWG599ukxDTnClELzRp
         Pzha+tjHTG4uc9Bu0kiir8Vd1yfZTgPVanI+vvWX3/xGOv6s44B60kDNWjcVAJr+Lvrr
         ZQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735845153; x=1736449953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtjhhJiEXKyaw1nvpEbH/yDIveLeL8Bw5DjTTO0PZIM=;
        b=cNR9ZwMoW5x/GAp0sS0xwz2/fyWi0vhWhAVoPWlK/6r+p6xsMLrVdDZdaGEgMxTS7J
         dqDaOQHrhFJS+nBBKN3E/SFUfldZLCfTl1KWUPCY18Dw+tlFw9dFm5WgB8JK7m9PAInB
         C+1lnTx5GUSwWi9sEmmodveOTGru3XRsX+zPNQSiIkkPgyEX+ycmFyWpx2olxNfSOyJN
         N21nK6Qu01X3/Bwrd5g5G0ZkOsxYtg58Ps/t88F8y9kpehRmPiX9pp2WdDwNbxs2uD0F
         NcXmQAFsvZu2u57e69K51OfkJmDftASbYlRoiQ9LO0EMLYf75gM0tyGKw2nFkFxiVVXd
         Y7Kw==
X-Gm-Message-State: AOJu0YxxDEXXvpD7Vbhue6jNpSvXfR5skgZF3oVHHvw7EolSx+Z7c/JY
	IJb4nv2The8p0uOt+5qe+wDoyCVlrfq85ofsmLcZALV7aXXJ9N9M3OS62x7TtJdSyL/+xdPHNZb
	Y2Pb/jfz0ng==
X-Google-Smtp-Source: AGHT+IE9ZEXOoD83btWayqgeUFbAx+MRYWf74UTJuX8o39Ppf5qdoMdf0v1TnPcxCqxwvIqr9qsRPTnQXg7sBg==
X-Received: from pfbdw23.prod.google.com ([2002:a05:6a00:3697:b0:728:e3af:6ba5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1947:b0:725:456e:76e with SMTP id d2e1a72fcca58-72abdd8caf2mr67826361b3a.6.1735845152866;
 Thu, 02 Jan 2025 11:12:32 -0800 (PST)
Date: Thu,  2 Jan 2025 19:12:27 +0000
In-Reply-To: <20250102191227.2084046-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250102191227.2084046-1-skhawaja@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250102191227.2084046-4-skhawaja@google.com>
Subject: [PATCH net-next 3/3] Extend napi threaded polling to allow kthread
 based busy polling
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Add a new state to napi state enum:

- STATE_THREADED_BUSY_POLL
  Threaded busy poll is enabled/running for this napi.

Following changes are introduced in the napi scheduling and state logic:

- When threaded busy poll is enabled through sysfs it also enables
  NAPI_STATE_THREADED so a kthread is created per napi. It also sets
  NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that we are
  supposed to busy poll for each napi.

- When napi is scheduled with STATE_SCHED_THREADED and associated
  kthread is woken up, the kthread owns the context. If
  NAPI_STATE_THREADED_BUSY_POLL and NAPI_SCHED_THREADED both are set
  then it means that we can busy poll.

- To keep busy polling and to avoid scheduling of the interrupts, the
  napi_complete_done returns false when both SCHED_THREADED and
  THREADED_BUSY_POLL flags are set. Also napi_complete_done returns
  early to avoid the STATE_SCHED_THREADED being unset.

- If at any point STATE_THREADED_BUSY_POLL is unset, the
  napi_complete_done will run and unset the SCHED_THREADED bit also.
  This will make the associated kthread go to sleep as per existing
  logic.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/ABI/testing/sysfs-class-net     |  3 +-
 Documentation/netlink/specs/netdev.yaml       |  5 +-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
 include/linux/netdevice.h                     | 24 +++++--
 net/core/dev.c                                | 72 ++++++++++++++++---
 net/core/net-sysfs.c                          |  2 +-
 net/core/netdev-genl-gen.c                    |  2 +-
 7 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
index ebf21beba846..15d7d36a8294 100644
--- a/Documentation/ABI/testing/sysfs-class-net
+++ b/Documentation/ABI/testing/sysfs-class-net
@@ -343,7 +343,7 @@ Date:		Jan 2021
 KernelVersion:	5.12
 Contact:	netdev@vger.kernel.org
 Description:
-		Boolean value to control the threaded mode per device. User could
+		Integer value to control the threaded mode per device. User could
 		set this value to enable/disable threaded mode for all napi
 		belonging to this device, without the need to do device up/down.
 
@@ -351,4 +351,5 @@ Description:
 		== ==================================
 		0  threaded mode disabled for this dev
 		1  threaded mode enabled for this dev
+		2  threaded mode enabled, and busy polling enabled.
 		== ==================================
diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index aac343af7246..9c905243a1cc 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -272,10 +272,11 @@ attribute-sets:
         name: threaded
         doc: Whether the napi is configured to operate in threaded polling
              mode. If this is set to `1` then the NAPI context operates
-             in threaded polling mode.
+             in threaded polling mode. If this is set to `2` then the NAPI
+             kthread also does busypolling.
         type: u32
         checks:
-          max: 1
+          max: 2
   -
     name: queue
     attributes:
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index c571614b1d50..a709cddcd292 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->mii.mdio_write = atl1c_mdio_write;
 	adapter->mii.phy_id_mask = 0x1f;
 	adapter->mii.reg_num_mask = MDIO_CTRL_REG_MASK;
-	dev_set_threaded(netdev, true);
+	dev_set_threaded(netdev, DEV_NAPI_THREADED);
 	for (i = 0; i < adapter->rx_queue_count; ++i)
 		netif_napi_add(netdev, &adapter->rrd_ring[i].napi,
 			       atl1c_clean_rx);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8f531d528869..c384ffe0976e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -407,6 +407,8 @@ enum {
 	NAPI_STATE_PREFER_BUSY_POLL,	/* prefer busy-polling over softirq processing*/
 	NAPI_STATE_THREADED,		/* The poll is performed inside its own thread*/
 	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
+	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded napi poller will busy poll */
+	NAPI_STATE_SCHED_THREADED_BUSY_POLL,  /* The threaded napi poller is busy polling */
 };
 
 enum {
@@ -420,8 +422,14 @@ enum {
 	NAPIF_STATE_PREFER_BUSY_POLL	= BIT(NAPI_STATE_PREFER_BUSY_POLL),
 	NAPIF_STATE_THREADED		= BIT(NAPI_STATE_THREADED),
 	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
+	NAPIF_STATE_THREADED_BUSY_POLL	= BIT(NAPI_STATE_THREADED_BUSY_POLL),
+	NAPIF_STATE_SCHED_THREADED_BUSY_POLL
+				= BIT(NAPI_STATE_SCHED_THREADED_BUSY_POLL),
 };
 
+#define NAPIF_STATE_THREADED_BUSY_POLL_MASK \
+	(NAPIF_STATE_THREADED | NAPIF_STATE_THREADED_BUSY_POLL)
+
 enum gro_result {
 	GRO_MERGED,
 	GRO_MERGED_FREE,
@@ -568,16 +576,24 @@ static inline bool napi_complete(struct napi_struct *n)
 	return napi_complete_done(n, 0);
 }
 
-int dev_set_threaded(struct net_device *dev, bool threaded);
+enum napi_threaded_state {
+	NAPI_THREADED_OFF = 0,
+	NAPI_THREADED = 1,
+	NAPI_THREADED_BUSY_POLL = 2,
+	NAPI_THREADED_MAX = NAPI_THREADED_BUSY_POLL,
+};
+
+int dev_set_threaded(struct net_device *dev, enum napi_threaded_state threaded);
 
 /*
  * napi_set_threaded - set napi threaded state
  * @napi: NAPI context
- * @threaded: whether this napi does threaded polling
+ * @threaded: threading mode
  *
  * Return 0 on success and negative errno on failure.
  */
-int napi_set_threaded(struct napi_struct *napi, bool threaded);
+int napi_set_threaded(struct napi_struct *napi,
+		      enum napi_threaded_state threaded);
 
 /**
  *	napi_disable - prevent NAPI from scheduling
@@ -2406,7 +2422,7 @@ struct net_device {
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
-	bool			threaded;
+	u8			threaded;
 
 	/* priv_flags_slow, ungrouped to save space */
 	unsigned long		see_all_hwtstamp_requests:1;
diff --git a/net/core/dev.c b/net/core/dev.c
index 762977a62da2..b6cd9474bdd3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -78,6 +78,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/isolation.h>
+#include <linux/sched/types.h>
 #include <linux/sched/mm.h>
 #include <linux/smpboot.h>
 #include <linux/mutex.h>
@@ -6231,7 +6232,8 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	 *    the guarantee we will be called later.
 	 */
 	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
-				 NAPIF_STATE_IN_BUSY_POLL)))
+				 NAPIF_STATE_IN_BUSY_POLL |
+				 NAPIF_STATE_SCHED_THREADED_BUSY_POLL)))
 		return false;
 
 	if (work_done) {
@@ -6633,8 +6635,10 @@ static void init_gro_hash(struct napi_struct *napi)
 	napi->gro_bitmask = 0;
 }
 
-int napi_set_threaded(struct napi_struct *napi, bool threaded)
+int napi_set_threaded(struct napi_struct *napi,
+		      enum napi_threaded_state threaded)
 {
+	unsigned long val;
 	if (napi->dev->threaded)
 		return -EINVAL;
 
@@ -6649,30 +6653,41 @@ int napi_set_threaded(struct napi_struct *napi, bool threaded)
 
 	/* Make sure kthread is created before THREADED bit is set. */
 	smp_mb__before_atomic();
-	assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+	val = 0;
+	if (threaded == NAPI_THREADED_BUSY_POLL)
+		val |= NAPIF_STATE_THREADED_BUSY_POLL;
+	if (threaded)
+		val |= NAPIF_STATE_THREADED;
+	set_mask_bits(&napi->state, NAPIF_STATE_THREADED_BUSY_POLL_MASK, val);
 
 	return 0;
 }
 
-int dev_set_threaded(struct net_device *dev, bool threaded)
+int dev_set_threaded(struct net_device *dev, enum napi_threaded_state threaded)
 {
 	struct napi_struct *napi;
+	unsigned long val;
 	int err = 0;
 
 	if (dev->threaded == threaded)
 		return 0;
 
+	val = 0;
 	if (threaded) {
 		/* Check if threaded is set at napi level already */
 		list_for_each_entry(napi, &dev->napi_list, dev_list)
 			if (test_bit(NAPI_STATE_THREADED, &napi->state))
 				return -EINVAL;
 
+		val |= NAPIF_STATE_THREADED;
+		if (threaded == NAPI_THREADED_BUSY_POLL)
+			val |= NAPIF_STATE_THREADED_BUSY_POLL;
+
 		list_for_each_entry(napi, &dev->napi_list, dev_list) {
 			if (!napi->thread) {
 				err = napi_kthread_create(napi);
 				if (err) {
-					threaded = false;
+					threaded = NAPI_THREADED_OFF;
 					break;
 				}
 			}
@@ -6691,9 +6706,13 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 	 * polled. In this case, the switch between threaded mode and
 	 * softirq mode will happen in the next round of napi_schedule().
 	 * This should not cause hiccups/stalls to the live traffic.
+	 *
+	 * Switch to busy_poll threaded napi will occur after the threaded
+	 * napi is scheduled.
 	 */
 	list_for_each_entry(napi, &dev->napi_list, dev_list)
-		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+		set_mask_bits(&napi->state,
+			      NAPIF_STATE_THREADED_BUSY_POLL_MASK, val);
 
 	return err;
 }
@@ -7007,7 +7026,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 	return -1;
 }
 
-static void napi_threaded_poll_loop(struct napi_struct *napi)
+static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
@@ -7036,22 +7055,53 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 		}
 		skb_defer_free_flush(sd);
 		bpf_net_ctx_clear(bpf_net_ctx);
+
+		/* Push the skbs up the stack if busy polling. */
+		if (busy_poll)
+			__napi_gro_flush_helper(napi);
 		local_bh_enable();
 
-		if (!repoll)
+		/* If busy polling then do not break here because we need to
+		 * call cond_resched and rcu_softirq_qs_periodic to prevent
+		 * watchdog warnings.
+		 */
+		if (!repoll && !busy_poll)
 			break;
 
 		rcu_softirq_qs_periodic(last_qs);
 		cond_resched();
+
+		if (!repoll)
+			break;
 	}
 }
 
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
+	bool busy_poll_sched;
+	unsigned long val;
+	bool busy_poll;
+
+	while (!napi_thread_wait(napi)) {
+		/* Once woken up, this means that we are scheduled as threaded
+		 * napi and this thread owns the napi context, if busy poll
+		 * state is set then we busy poll this napi.
+		 */
+		val = READ_ONCE(napi->state);
+		busy_poll = val & NAPIF_STATE_THREADED_BUSY_POLL;
+		busy_poll_sched = val & NAPIF_STATE_SCHED_THREADED_BUSY_POLL;
+
+		/* Do not busy poll if napi is disabled. */
+		if (unlikely(val & NAPIF_STATE_DISABLE))
+			busy_poll = false;
+
+		if (busy_poll != busy_poll_sched)
+			assign_bit(NAPI_STATE_SCHED_THREADED_BUSY_POLL,
+				   &napi->state, busy_poll);
 
-	while (!napi_thread_wait(napi))
-		napi_threaded_poll_loop(napi);
+		napi_threaded_poll_loop(napi, busy_poll);
+	}
 
 	return 0;
 }
@@ -12205,7 +12255,7 @@ static void run_backlog_napi(unsigned int cpu)
 {
 	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
 
-	napi_threaded_poll_loop(&sd->backlog);
+	napi_threaded_poll_loop(&sd->backlog, false);
 }
 
 static void backlog_napi_setup(unsigned int cpu)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 2d9afc6e2161..36d0a22e341c 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -626,7 +626,7 @@ static int modify_napi_threaded(struct net_device *dev, unsigned long val)
 	if (list_empty(&dev->napi_list))
 		return -EOPNOTSUPP;
 
-	if (val != 0 && val != 1)
+	if (val > NAPI_THREADED_MAX)
 		return -EOPNOTSUPP;
 
 	ret = dev_set_threaded(dev, val);
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 93dc74dad6de..4086d2577dcc 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -102,7 +102,7 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPE
 /* NETDEV_CMD_NAPI_SET_THREADED - do */
 static const struct nla_policy netdev_napi_set_threaded_nl_policy[NETDEV_A_NAPI_THREADED + 1] = {
 	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
-	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 2),
 };
 
 /* Ops table for netdev */
-- 
2.47.1.613.gc27f4b7a9f-goog


