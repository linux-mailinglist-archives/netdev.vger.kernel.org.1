Return-Path: <netdev+bounces-185722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE6A9B8B8
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B894A03A4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB801F4C85;
	Thu, 24 Apr 2025 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxPdfcp6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F81F3B87
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524948; cv=none; b=DK+cWQ+cp5pjAP1rcy0Q0TYMc9eKmVyvyetNbHcMW+qjj5a3DmIXZonzgLiMf+wECoKMrHLa3kbI26rYfjwiRDod+7yQhK04jhhiQla0tRRmzZb1ZsI71/rL6m8ZMETWH8Ty2hAq9lzjKqSt9PjJZh0LUgBhrXp5jDbuSms5svE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524948; c=relaxed/simple;
	bh=cuwcL3L1RN8UQdQ5NtHzD81ty+0mFNGpBZSeabL5RSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nl/nm38YnMvmec9kh/kFcMYmJDEPpxrlTAA+kGNUk6O9IB69Hf52Zruy9AHgQ7sGqFFV/kyE2BifzmHRp4TorXixPrmkIkFKeGr6Ag6VihvBnw63mog5/FrstOZ2vOp4TQ/K8QHLSGCM8WrWKKXp2fDtlGr7rOHtjKm9Tq1C7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxPdfcp6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736fff82264so1051332b3a.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745524946; x=1746129746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AfIAymEmv4UFqHEw212eA1b2ErJYK8BHKy1pyDJm6Y0=;
        b=RxPdfcp6JBMaJHVarZQcAeMpWN49o2FMQf5HnWlUT29y7c7b+oL0WN4KbU2iLVGtao
         kIp66aMDoxUNA1VkRFabw1VA6byruw4texsgEKLdA/hQjlmKUGBlu5mNbaqsPbUwsRn3
         KjbA4fjZqIvtOu+OM4U4+EE9Qf7wV9z7PGbDURprOlji0vEoKsAqyDX4tAAQ2oYEAuMP
         4d1QmDiYyAXTeMtnC0AjWCRk2wlbOtfuNRHd4gJnfGlFTxGVRUj8lMTZdgfdfT5xXrxP
         S3M2FIR5tim9B3t944DeJS+iVS8lDifSH9xKY3vIOwbgRhC2y0m6K92zNHFRL/3VLEU2
         0r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745524946; x=1746129746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfIAymEmv4UFqHEw212eA1b2ErJYK8BHKy1pyDJm6Y0=;
        b=lwuVjdUQjV4xpnW2j1buO6ijd8cXCIw16tEjh05xlTEPvLuTNmPx+tLeVGupZ/KiHt
         4HAVEGcYcBSSu1VxbQ/jo7mZJDBS2NGLmY2Iwx97bOFQmJyptmf1u4dIXQvfkind5y6R
         jvTrzVlGqGNpf/eN0hhADB/K30ox/r0zXDuavAiz0ycM0aLd02YU5zeyGE2KN6jvjoHf
         Yu1V4Y1HRVHppSDhyzsMO4yAaHzzmJjj4o4RKn0LERWfS3l/qhxqUqS6OxpNA2BzIvIU
         u34EHEbPEJ/k8d3UYEHb3bhsAvJeDHGzigdvlyNSlxXECA+eSC1p2aqHb+nPIprsAtKE
         vksQ==
X-Gm-Message-State: AOJu0Yx+klCy3GdV0aRzPE5fbsmXD7FRge16bXOiZyTKFsbtjRHDfyOm
	UWr8Aw39VNn/hNyfv6Y4dMdYdkLoW5i48ZPCvJlcgA3GBkkQ07lcucCNzn/zPeVZnDdx1P41gNY
	wOu9lIYLpKg==
X-Google-Smtp-Source: AGHT+IFeAy+lnqQBIEKwUue/Rsy5qKscr6uo1Lmeug/1BuAhYZOgU8xznJdpN3GSwK7VxTmd/0lm0Qzttsooig==
X-Received: from pfef12.prod.google.com ([2002:a05:6a00:228c:b0:730:4672:64ac])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1306:b0:73e:2367:c914 with SMTP id d2e1a72fcca58-73e2680bccfmr4496163b3a.7.1745524946371;
 Thu, 24 Apr 2025 13:02:26 -0700 (PDT)
Date: Thu, 24 Apr 2025 20:02:20 +0000
In-Reply-To: <20250424200222.2602990-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424200222.2602990-1-skhawaja@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250424200222.2602990-3-skhawaja@google.com>
Subject: [PATCH net-next v5 2/4] net: define an enum for the napi threaded state
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Instead of using '0' and '1' for napi threaded state, use an enum with
'disable' and 'enable' states, preparing for the next patch to add a new
'busy-poll-enable' state. Also update the 'threaded' field in struct
net_device to u8 instead of bool.

Tested:
 ./tools/testing/selftests/net/nl_netdev.py
 TAP version 13
 1..6
 ok 1 nl_netdev.empty_check
 ok 2 nl_netdev.lo_check
 ok 3 nl_netdev.page_pool_check
 ok 4 nl_netdev.napi_list_check
 ok 5 nl_netdev.napi_set_threaded
 ok 6 nl_netdev.nsim_rxq_reset_down
 # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/netlink/specs/netdev.yaml       | 11 +++++---
 .../networking/net_cachelines/net_device.rst  |  2 +-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
 include/linux/netdevice.h                     |  7 +++--
 include/uapi/linux/netdev.h                   |  5 ++++
 net/core/dev.c                                | 25 ++++++++++++++---
 net/core/dev.h                                | 12 +++++---
 net/core/netdev-genl-gen.c                    |  2 +-
 net/core/netdev-genl.c                        |  4 +--
 tools/include/uapi/linux/netdev.h             |  5 ++++
 tools/testing/selftests/net/nl_netdev.py      | 28 +++++++++----------
 14 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index c9d190fe1f05..c8834161e8ec 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -82,6 +82,10 @@ definitions:
     name: qstats-scope
     type: flags
     entries: [ queue ]
+  -
+    name: napi-threaded
+    type: enum
+    entries: [ disable, enable ]
 
 attribute-sets:
   -
@@ -283,11 +287,10 @@ attribute-sets:
       -
         name: threaded
         doc: Whether the napi is configured to operate in threaded polling
-             mode. If this is set to `1` then the NAPI context operates
+             mode. If this is set to `enable` then the NAPI context operates
              in threaded polling mode.
-        type: uint
-        checks:
-          max: 1
+        type: u32
+        enum: napi-threaded
   -
     name: xsk-info
     attributes: []
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 6327e689e8a8..e9796adc2fb0 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -164,7 +164,7 @@ struct sfp_bus*                     sfp_bus
 struct lock_class_key*              qdisc_tx_busylock
 bool                                proto_down
 unsigned:1                          wol_enabled
-unsigned:1                          threaded                                                            napi_poll(napi_enable,dev_set_threaded)
+u8                                  threaded                                                            napi_poll(napi_enable,dev_set_threaded)
 unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 82137f9deae9..58254113678c 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->mii.mdio_write = atl1c_mdio_write;
 	adapter->mii.phy_id_mask = 0x1f;
 	adapter->mii.reg_num_mask = MDIO_CTRL_REG_MASK;
-	dev_set_threaded(netdev, true);
+	dev_set_threaded(netdev, NETDEV_NAPI_THREADED_ENABLE);
 	for (i = 0; i < adapter->rx_queue_count; ++i)
 		netif_napi_add(netdev, &adapter->rrd_ring[i].napi,
 			       atl1c_clean_rx);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 058dcabfaa2e..2ed3b9263be2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -156,7 +156,7 @@ static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
 	}
 	strscpy(mlxsw_pci->napi_dev_rx->name, "mlxsw_rx",
 		sizeof(mlxsw_pci->napi_dev_rx->name));
-	dev_set_threaded(mlxsw_pci->napi_dev_rx, true);
+	dev_set_threaded(mlxsw_pci->napi_dev_rx, NETDEV_NAPI_THREADED_ENABLE);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c9f4976a3527..12e4f68c0c8f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3075,7 +3075,7 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->coalesce_irqs) {
 		netdev_sw_irq_coalesce_default_on(ndev);
 		if (num_present_cpus() == 1)
-			dev_set_threaded(ndev, true);
+			dev_set_threaded(ndev, NETDEV_NAPI_THREADED_ENABLE);
 	}
 
 	/* Network device register */
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 866bad2db334..902517bed686 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -935,7 +935,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
-	dev_set_threaded(ar->napi_dev, true);
+	dev_set_threaded(ar->napi_dev, NETDEV_NAPI_THREADED_ENABLE);
 	ath10k_core_napi_enable(ar);
 	ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3817720e8b24..2eda563307f9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -369,7 +369,7 @@ struct napi_config {
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
 	cpumask_t affinity_mask;
-	bool threaded;
+	u8 threaded;
 	unsigned int napi_id;
 };
 
@@ -589,7 +589,8 @@ static inline bool napi_complete(struct napi_struct *n)
 	return napi_complete_done(n, 0);
 }
 
-int dev_set_threaded(struct net_device *dev, bool threaded);
+int dev_set_threaded(struct net_device *dev,
+		     enum netdev_napi_threaded threaded);
 
 void napi_disable(struct napi_struct *n);
 void napi_disable_locked(struct napi_struct *n);
@@ -2428,7 +2429,7 @@ struct net_device {
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
-	bool			threaded;
+	u8			threaded;
 	bool			irq_affinity_auto;
 	bool			rx_cpu_rmap_auto;
 
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index fac1b8ffeb55..a5737572ce92 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -77,6 +77,11 @@ enum netdev_qstats_scope {
 	NETDEV_QSTATS_SCOPE_QUEUE = 1,
 };
 
+enum netdev_napi_threaded {
+	NETDEV_NAPI_THREADED_DISABLE,
+	NETDEV_NAPI_THREADED_ENABLE,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ff275bbf6e2..41d809f2a7f7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6893,7 +6893,19 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-int napi_set_threaded(struct napi_struct *napi, bool threaded)
+static void napi_set_threaded_state(struct napi_struct *napi,
+				    enum netdev_napi_threaded threaded)
+{
+	unsigned long val;
+
+	val = 0;
+	if (threaded)
+		val |= NAPIF_STATE_THREADED;
+	set_mask_bits(&napi->state, NAPIF_STATE_THREADED, val);
+}
+
+int napi_set_threaded(struct napi_struct *napi,
+		      enum netdev_napi_threaded threaded)
 {
 	if (threaded) {
 		if (!napi->thread) {
@@ -6909,14 +6921,16 @@ int napi_set_threaded(struct napi_struct *napi, bool threaded)
 
 	/* Make sure kthread is created before THREADED bit is set. */
 	smp_mb__before_atomic();
-	assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+	napi_set_threaded_state(napi, threaded);
 
 	return 0;
 }
 
-int dev_set_threaded(struct net_device *dev, bool threaded)
+int dev_set_threaded(struct net_device *dev,
+		     enum netdev_napi_threaded threaded)
 {
 	struct napi_struct *napi;
+	unsigned long val;
 	int err = 0;
 
 	netdev_assert_locked_or_invisible(dev);
@@ -6924,12 +6938,15 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 	if (dev->threaded == threaded)
 		return 0;
 
+	val = 0;
 	if (threaded) {
+		val |= NAPIF_STATE_THREADED;
+
 		list_for_each_entry(napi, &dev->napi_list, dev_list) {
 			if (!napi->thread) {
 				err = napi_kthread_create(napi);
 				if (err) {
-					threaded = false;
+					threaded = NETDEV_NAPI_THREADED_DISABLE;
 					break;
 				}
 			}
diff --git a/net/core/dev.h b/net/core/dev.h
index b50d118ad014..3924996ae85c 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -321,19 +321,23 @@ static inline void napi_set_irq_suspend_timeout(struct napi_struct *n,
  *
  * Return: the per-NAPI threaded state.
  */
-static inline bool napi_get_threaded(struct napi_struct *n)
+static inline enum netdev_napi_threaded napi_get_threaded(struct napi_struct *n)
 {
-	return test_bit(NAPI_STATE_THREADED, &n->state);
+	if (test_bit(NAPI_STATE_THREADED, &n->state))
+		return NETDEV_NAPI_THREADED_ENABLE;
+
+	return NETDEV_NAPI_THREADED_DISABLE;
 }
 
 /**
  * napi_set_threaded - set napi threaded state
  * @n: napi struct to set the threaded state on
- * @threaded: whether this napi does threaded polling
+ * @threaded: napi threaded state
  *
  * Return 0 on success and negative errno on failure.
  */
-int napi_set_threaded(struct napi_struct *n, bool threaded);
+int napi_set_threaded(struct napi_struct *n,
+		      enum netdev_napi_threaded threaded);
 
 int rps_cpumask_housekeeping(struct cpumask *mask);
 
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 2791b6b232fa..c2e5cee857d2 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -97,7 +97,7 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_THREADED
 	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
 	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
-	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_UINT, 1),
+	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
 };
 
 /* Ops table for netdev */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index f7d000a600cf..7335c8f6ef68 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -330,8 +330,8 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 	u32 defer = 0;
 
 	if (info->attrs[NETDEV_A_NAPI_THREADED]) {
-		threaded = nla_get_uint(info->attrs[NETDEV_A_NAPI_THREADED]);
-		napi_set_threaded(napi, !!threaded);
+		threaded = nla_get_u32(info->attrs[NETDEV_A_NAPI_THREADED]);
+		napi_set_threaded(napi, threaded);
 	}
 
 	if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index fac1b8ffeb55..a5737572ce92 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -77,6 +77,11 @@ enum netdev_qstats_scope {
 	NETDEV_QSTATS_SCOPE_QUEUE = 1,
 };
 
+enum netdev_napi_threaded {
+	NETDEV_NAPI_THREADED_DISABLE,
+	NETDEV_NAPI_THREADED_ENABLE,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index 505564818fa8..ec60bff34f5e 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -52,53 +52,53 @@ def napi_set_threaded(nf) -> None:
         napi1_id = napis[1]['id']
 
         # set napi threaded and verify
-        nf.napi_set({'id': napi0_id, 'threaded': 1})
+        nf.napi_set({'id': napi0_id, 'threaded': "enable"})
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['threaded'], "enable")
 
         ip(f"link set dev {nsim.ifname} down")
         ip(f"link set dev {nsim.ifname} up")
 
         # verify if napi threaded is still set
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['threaded'], "enable")
 
         # unset napi threaded and verify
-        nf.napi_set({'id': napi0_id, 'threaded': 0})
+        nf.napi_set({'id': napi0_id, 'threaded': "disable"})
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0['threaded'], "disable")
 
         # set napi threaded for napi0
-        nf.napi_set({'id': napi0_id, 'threaded': 1})
+        nf.napi_set({'id': napi0_id, 'threaded': "enable"})
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['threaded'], "enable")
 
         # check it is not set for napi1
         napi1 = nf.napi_get({'id': napi1_id})
-        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1['threaded'], "disable")
 
         # set threaded at device level
         system(f"echo 1 > /sys/class/net/{nsim.ifname}/threaded")
 
         # check napi threaded is set for both napis
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['threaded'], "enable")
         napi1 = nf.napi_get({'id': napi1_id})
-        ksft_eq(napi1['threaded'], 1)
+        ksft_eq(napi1['threaded'], "enable")
 
         # set napi threaded for napi0
-        nf.napi_set({'id': napi0_id, 'threaded': 1})
+        nf.napi_set({'id': napi0_id, 'threaded': "enable"})
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['threaded'], "enable")
 
         # unset threaded at device level
         system(f"echo 0 > /sys/class/net/{nsim.ifname}/threaded")
 
         # check napi threaded is unset for both napis
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0['threaded'], "disable")
         napi1 = nf.napi_get({'id': napi1_id})
-        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1['threaded'], "disable")
 
 def nsim_rxq_reset_down(nf) -> None:
     """
-- 
2.49.0.850.g28803427d3-goog


