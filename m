Return-Path: <netdev+bounces-209166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C128DB0E825
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5445B1C889AD
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22741C3BE0;
	Wed, 23 Jul 2025 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IxiWsHpW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796119047F
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234239; cv=none; b=SFO35+Ta3PR+Hy1wQiYpNrqijxiBq8FlW4C0KLv1x/I/NLW1o/ScOxAKoIMvjrK66U0sKCU0C64Jzja3kLYGGxVxZQAmtP8ty/2ThQRNFYgX7w527qO8pDKfdoctiYO945/FojrXFeVDC5RvTWivnhTqw99mUG5sTEMjVT1IaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234239; c=relaxed/simple;
	bh=feVQbaQk91ZNBk5DNt+lPNZV58OknGiSOpNz+9ghVxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J/Z5QO0GRPjLRPx85pV0yOdkDDUtSM7GlA7aCtU73PR3+2FWGNFAzcloJbAVQCfrkNxXUHZNA+l7FR3XT2QHPoTbstOEzSERdtB8WgwLPCGwB3afyj/t+LovF/era3pvodQ+ZoP63dcmhojXEbn2uBZyMGyLKn55MeJlRx70Osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IxiWsHpW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74ad608d60aso5098029b3a.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 18:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753234237; x=1753839037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5Yw5uEI39/24dUKFRl/d57ulhqlFaBcPqX7CetG7pM=;
        b=IxiWsHpWTE0biUWer6UIFFuRPw4dYJb5sz4HqNaP6LphRXQKdpeF3AUOg3iDHNh0jT
         qlwoZW7er/82gasgpSRGwerm6D4NgHT+1bvouWE8v4FwIhXNWRh+hO9wrCslLXfR2YcB
         FryHkidvrsEVD23PzicfeTDbJ0mJHM5Fn1ZsamkxQdu5W/rR63yo2jxyYSJ139vC4piY
         rzqpd+dQbOeLxCKjYkHwT4NJc5XdNO42twLjpQNSp9NQSiFkVOWFbz+6WkBn96uR+lck
         j02kaCOgEgjIB1utQjQk6lpVJqIL6yoAPoNP8bRencYs3vHiXAb671BD1AJrZ6dnA0Ey
         1bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753234237; x=1753839037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5Yw5uEI39/24dUKFRl/d57ulhqlFaBcPqX7CetG7pM=;
        b=gbAmbjfuuYtT1fGnW4KyH4RoCh6PIzr5Xx1OkIc1xExAJXQa8hzRLRyN3X1bE1TWYW
         d8AX1Az3t6nfr/6Lgda5wLHtBJN4l7fS1A9E5h5Az0bI9FVyfzaxEpTFlXxPhhsiS68p
         8lPU9rSnpq8TEQfb6RIPCPHV1WCaxN6XYhpUxdOPy598IYRRPsggU5EIu2iQxYv/DT0R
         gMfpuRHqhFBDqCddtQjTQOBBFW6V1S9eXShqRjQs7cfO0CtrQL9mC+nMI1yH3z5qDE8p
         vxqAixCxl/ZUcd52aoR56eDOtmbBhnN7q0ofq0IvAqAsHcfLTeQshNTgMSaxAxAjV2Dt
         BErA==
X-Gm-Message-State: AOJu0Yxvl9+VNCf5n9+Z9LcquMjdfvRe4kOmwZA7WFcjaPTEmJsse4Ti
	57o7SMGfbrbemSBArTTBZYyndGnNVKPVsH2BcFqGJl1LFszbB8LTvcvXPh33wvlmfkx2JQrNMdY
	V/z7JnPlXpMnC8w==
X-Google-Smtp-Source: AGHT+IEBCqaQBDykQ64Gr0tpSbcRkmGxoiI57L19tKwVYRi9CZtLiV4tKwWtlPs2gC8szC88CF47cOTIz0oofg==
X-Received: from pfbfj4.prod.google.com ([2002:a05:6a00:3a04:b0:749:2cc7:bd89])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d0c:b0:749:456:4082 with SMTP id d2e1a72fcca58-76033a13dd9mr1626913b3a.1.1753234236875;
 Tue, 22 Jul 2025 18:30:36 -0700 (PDT)
Date: Wed, 23 Jul 2025 01:30:31 +0000
In-Reply-To: <20250723013031.2911384-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723013031.2911384-1-skhawaja@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723013031.2911384-4-skhawaja@google.com>
Subject: [PATCH net-next v8 3/3] net: define an enum for the napi threaded state
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Instead of using '0' and '1' for napi threaded state use an enum with
'disabled' and 'enabled' states.

Tested:
 ./tools/testing/selftests/net/nl_netdev.py
 TAP version 13
 1..7
 ok 1 nl_netdev.empty_check
 ok 2 nl_netdev.lo_check
 ok 3 nl_netdev.page_pool_check
 ok 4 nl_netdev.napi_list_check
 ok 5 nl_netdev.dev_set_threaded
 ok 6 nl_netdev.napi_set_threaded
 ok 7 nl_netdev.nsim_rxq_reset_down
 # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---

v7:
 - Fixed yamllint issue.

v6:
 - Moved threaded in struct netdevice up to fill the cacheline hole.
 - Changed dev_set_threaded to dev_set_threaded_hint and removed the
   second argument that was always set to true by all the drivers.
   Exported only dev_set_threaded_hint and made dev_set_threaded core
   only function. This change is done in a separate commit.
 - Updated documentation comment for threaded in struct netdevice.

---
 Documentation/netlink/specs/netdev.yaml       | 13 ++++---
 .../networking/net_cachelines/net_device.rst  |  2 +-
 include/linux/netdevice.h                     | 10 +++---
 include/uapi/linux/netdev.h                   |  5 +++
 net/core/dev.c                                | 12 ++++---
 net/core/dev.h                                | 13 ++++---
 net/core/dev_api.c                            |  3 +-
 net/core/netdev-genl-gen.c                    |  2 +-
 net/core/netdev-genl.c                        |  2 +-
 tools/include/uapi/linux/netdev.h             |  5 +++
 tools/testing/selftests/net/nl_netdev.py      | 36 +++++++++----------
 11 files changed, 62 insertions(+), 41 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 85d0ea6ac426..c035dc0f64fd 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -85,6 +85,10 @@ definitions:
     name: qstats-scope
     type: flags
     entries: [queue]
+  -
+    name: napi-threaded
+    type: enum
+    entries: [disabled, enabled]
 
 attribute-sets:
   -
@@ -286,11 +290,10 @@ attribute-sets:
       -
         name: threaded
         doc: Whether the NAPI is configured to operate in threaded polling
-             mode. If this is set to 1 then the NAPI context operates in
-             threaded polling mode.
-        type: uint
-        checks:
-          max: 1
+             mode. If this is set to enabled then the NAPI context operates
+             in threaded polling mode.
+        type: u32
+        enum: napi-threaded
   -
     name: xsk-info
     attributes: []
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 2d3dc4692d20..1c19bb7705df 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -68,6 +68,7 @@ unsigned_char                       addr_assign_type
 unsigned_char                       addr_len
 unsigned_char                       upper_level
 unsigned_char                       lower_level
+u8                                  threaded                                                            napi_poll(napi_enable,netif_set_threaded)
 unsigned_short                      neigh_priv_len
 unsigned_short                      padded
 unsigned_short                      dev_id
@@ -165,7 +166,6 @@ struct sfp_bus*                     sfp_bus
 struct lock_class_key*              qdisc_tx_busylock
 bool                                proto_down
 unsigned:1                          wol_enabled
-unsigned:1                          threaded                                                            napi_poll(napi_enable,netif_set_threaded)
 unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a97c9a337d6b..5e5de4b0a433 100644
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
 
@@ -590,7 +590,8 @@ static inline bool napi_complete(struct napi_struct *n)
 }
 
 void netif_threaded_enable(struct net_device *dev);
-int dev_set_threaded(struct net_device *dev, bool threaded);
+int dev_set_threaded(struct net_device *dev,
+		     enum netdev_napi_threaded threaded);
 
 void napi_disable(struct napi_struct *n);
 void napi_disable_locked(struct napi_struct *n);
@@ -1872,6 +1873,7 @@ enum netdev_reg_state {
  * 	@addr_len:		Hardware address length
  *	@upper_level:		Maximum depth level of upper devices.
  *	@lower_level:		Maximum depth level of lower devices.
+ *	@threaded:		napi threaded state.
  *	@neigh_priv_len:	Used in neigh_alloc()
  * 	@dev_id:		Used to differentiate devices that share
  * 				the same link layer address
@@ -2011,8 +2013,6 @@ enum netdev_reg_state {
  *			switch driver and used to set the phys state of the
  *			switch port.
  *
- *	@threaded:	napi threaded mode is enabled
- *
  *	@irq_affinity_auto: driver wants the core to store and re-assign the IRQ
  *			    affinity. Set by netif_enable_irq_affinity(), then
  *			    the driver must create a persistent napi by
@@ -2248,6 +2248,7 @@ struct net_device {
 	unsigned char		addr_len;
 	unsigned char		upper_level;
 	unsigned char		lower_level;
+	u8			threaded;
 
 	unsigned short		neigh_priv_len;
 	unsigned short          dev_id;
@@ -2429,7 +2430,6 @@ struct net_device {
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
-	bool			threaded;
 	bool			irq_affinity_auto;
 	bool			rx_cpu_rmap_auto;
 
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 1f3719a9a0eb..48eb49aa03d4 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -77,6 +77,11 @@ enum netdev_qstats_scope {
 	NETDEV_QSTATS_SCOPE_QUEUE = 1,
 };
 
+enum netdev_napi_threaded {
+	NETDEV_NAPI_THREADED_DISABLED,
+	NETDEV_NAPI_THREADED_ENABLED,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
diff --git a/net/core/dev.c b/net/core/dev.c
index f28661d6f5ea..1c6e755841ce 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6963,7 +6963,8 @@ static void napi_stop_kthread(struct napi_struct *napi)
 	napi->thread = NULL;
 }
 
-int napi_set_threaded(struct napi_struct *napi, bool threaded)
+int napi_set_threaded(struct napi_struct *napi,
+		      enum netdev_napi_threaded threaded)
 {
 	if (threaded) {
 		if (!napi->thread) {
@@ -6988,7 +6989,8 @@ int napi_set_threaded(struct napi_struct *napi, bool threaded)
 	return 0;
 }
 
-int netif_set_threaded(struct net_device *dev, bool threaded)
+int netif_set_threaded(struct net_device *dev,
+		       enum netdev_napi_threaded threaded)
 {
 	struct napi_struct *napi;
 	int err = 0;
@@ -7000,7 +7002,7 @@ int netif_set_threaded(struct net_device *dev, bool threaded)
 			if (!napi->thread) {
 				err = napi_kthread_create(napi);
 				if (err) {
-					threaded = false;
+					threaded = NETDEV_NAPI_THREADED_DISABLED;
 					break;
 				}
 			}
@@ -7043,7 +7045,7 @@ int netif_set_threaded(struct net_device *dev, bool threaded)
  */
 void netif_threaded_enable(struct net_device *dev)
 {
-	WARN_ON_ONCE(netif_set_threaded(dev, true));
+	WARN_ON_ONCE(netif_set_threaded(dev, NETDEV_NAPI_THREADED_ENABLED));
 }
 EXPORT_SYMBOL(netif_threaded_enable);
 
@@ -7360,7 +7362,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	 * threaded mode will not be enabled in napi_enable().
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
-		dev->threaded = false;
+		dev->threaded = NETDEV_NAPI_THREADED_DISABLED;
 	netif_napi_set_irq_locked(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight_locked);
diff --git a/net/core/dev.h b/net/core/dev.h
index f5b567310908..ab69edc0c3e3 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -315,14 +315,19 @@ static inline void napi_set_irq_suspend_timeout(struct napi_struct *n,
 	WRITE_ONCE(n->irq_suspend_timeout, timeout);
 }
 
-static inline bool napi_get_threaded(struct napi_struct *n)
+static inline enum netdev_napi_threaded napi_get_threaded(struct napi_struct *n)
 {
-	return test_bit(NAPI_STATE_THREADED, &n->state);
+	if (test_bit(NAPI_STATE_THREADED, &n->state))
+		return NETDEV_NAPI_THREADED_ENABLED;
+
+	return NETDEV_NAPI_THREADED_DISABLED;
 }
 
-int napi_set_threaded(struct napi_struct *n, bool threaded);
+int napi_set_threaded(struct napi_struct *n,
+		      enum netdev_napi_threaded threaded);
 
-int netif_set_threaded(struct net_device *dev, bool threaded);
+int netif_set_threaded(struct net_device *dev,
+		       enum netdev_napi_threaded threaded);
 
 int rps_cpumask_housekeeping(struct cpumask *mask);
 
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index dd7f57013ce5..f28852078aa6 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -368,7 +368,8 @@ void netdev_state_change(struct net_device *dev)
 }
 EXPORT_SYMBOL(netdev_state_change);
 
-int dev_set_threaded(struct net_device *dev, bool threaded)
+int dev_set_threaded(struct net_device *dev,
+		     enum netdev_napi_threaded threaded)
 {
 	int ret;
 
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 0994bd68a7e6..e9a2a6f26cb7 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -97,7 +97,7 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_THREADED
 	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
 	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
-	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_UINT, 1),
+	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
 };
 
 /* NETDEV_CMD_BIND_TX - do */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 5875df372415..6314eb7bdf69 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -333,7 +333,7 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 		int ret;
 
 		threaded = nla_get_uint(info->attrs[NETDEV_A_NAPI_THREADED]);
-		ret = napi_set_threaded(napi, !!threaded);
+		ret = napi_set_threaded(napi, threaded);
 		if (ret)
 			return ret;
 	}
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 1f3719a9a0eb..48eb49aa03d4 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -77,6 +77,11 @@ enum netdev_qstats_scope {
 	NETDEV_QSTATS_SCOPE_QUEUE = 1,
 };
 
+enum netdev_napi_threaded {
+	NETDEV_NAPI_THREADED_DISABLED,
+	NETDEV_NAPI_THREADED_ENABLED,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index c8ffade79a52..5c66421ab8aa 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -52,14 +52,14 @@ def napi_set_threaded(nf) -> None:
         napi1_id = napis[1]['id']
 
         # set napi threaded and verify
-        nf.napi_set({'id': napi0_id, 'threaded': 1})
+        nf.napi_set({'id': napi0_id, 'threaded': "enabled"})
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['threaded'], "enabled")
         ksft_ne(napi0.get('pid'), None)
 
         # check it is not set for napi1
         napi1 = nf.napi_get({'id': napi1_id})
-        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1['threaded'], "disabled")
         ksft_eq(napi1.get('pid'), None)
 
         ip(f"link set dev {nsim.ifname} down")
@@ -67,18 +67,18 @@ def napi_set_threaded(nf) -> None:
 
         # verify if napi threaded is still set
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['threaded'], "enabled")
         ksft_ne(napi0.get('pid'), None)
 
         # check it is still not set for napi1
         napi1 = nf.napi_get({'id': napi1_id})
-        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1['threaded'], "disabled")
         ksft_eq(napi1.get('pid'), None)
 
         # unset napi threaded and verify
-        nf.napi_set({'id': napi0_id, 'threaded': 0})
+        nf.napi_set({'id': napi0_id, 'threaded': "disabled"})
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0['threaded'], "disabled")
         ksft_eq(napi0.get('pid'), None)
 
         # set threaded at device level
@@ -86,10 +86,10 @@ def napi_set_threaded(nf) -> None:
 
         # check napi threaded is set for both napis
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['threaded'], "enabled")
         ksft_ne(napi0.get('pid'), None)
         napi1 = nf.napi_get({'id': napi1_id})
-        ksft_eq(napi1['threaded'], 1)
+        ksft_eq(napi1['threaded'], "enabled")
         ksft_ne(napi1.get('pid'), None)
 
         # unset threaded at device level
@@ -97,16 +97,16 @@ def napi_set_threaded(nf) -> None:
 
         # check napi threaded is unset for both napis
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0['threaded'], "disabled")
         ksft_eq(napi0.get('pid'), None)
         napi1 = nf.napi_get({'id': napi1_id})
-        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1['threaded'], "disabled")
         ksft_eq(napi1.get('pid'), None)
 
         # set napi threaded for napi0
         nf.napi_set({'id': napi0_id, 'threaded': 1})
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['threaded'], "enabled")
         ksft_ne(napi0.get('pid'), None)
 
         # unset threaded at device level
@@ -114,10 +114,10 @@ def napi_set_threaded(nf) -> None:
 
         # check napi threaded is unset for both napis
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0['threaded'], "disabled")
         ksft_eq(napi0.get('pid'), None)
         napi1 = nf.napi_get({'id': napi1_id})
-        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1['threaded'], "disabled")
         ksft_eq(napi1.get('pid'), None)
 
 def dev_set_threaded(nf) -> None:
@@ -141,10 +141,10 @@ def dev_set_threaded(nf) -> None:
 
         # check napi threaded is set for both napis
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['threaded'], "enabled")
         ksft_ne(napi0.get('pid'), None)
         napi1 = nf.napi_get({'id': napi1_id})
-        ksft_eq(napi1['threaded'], 1)
+        ksft_eq(napi1['threaded'], "enabled")
         ksft_ne(napi1.get('pid'), None)
 
         # unset threaded
@@ -152,10 +152,10 @@ def dev_set_threaded(nf) -> None:
 
         # check napi threaded is unset for both napis
         napi0 = nf.napi_get({'id': napi0_id})
-        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0['threaded'], "disabled")
         ksft_eq(napi0.get('pid'), None)
         napi1 = nf.napi_get({'id': napi1_id})
-        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1['threaded'], "disabled")
         ksft_eq(napi1.get('pid'), None)
 
 def nsim_rxq_reset_down(nf) -> None:
-- 
2.50.0.727.gbf7dc18ff4-goog


