Return-Path: <netdev+bounces-208767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC7AB0D004
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 05:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28677B217F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6926428BABE;
	Tue, 22 Jul 2025 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fxq8j4aW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BB1876
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153655; cv=none; b=FPbqcdi131TdK2MlJ5LFbLXwz+t340pqhK7KsKFfiws20aJDSAnpQj8S/m93zc/d/W/m790pwhj5s8RU24mfn2QryEOED3t29Sd+Nj8PQI9DQTjQNid+ctY4bSuCQLsGWQ+HlZpytMwF8bC1eAoii/f3KCk8YnOn7+BHhU4Sh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153655; c=relaxed/simple;
	bh=yfJD20KsC2D/IJEsKnqHjB/lfaniB0C2FgBNBrwhUE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t5NAVjyhz85r0fNxLJbW74562BzPYP+MUnl/I+Oti9fzW29GfClWbtQoLoJnIqqamXKENL/KOhVTi/AlwbtFXoJVPFoS4WHtt5RzhBti3ZcI87I8HIX+jrsoRRskHpLll8/sXxuYYO0/h0zSyAyUyWeJwjeQtQePPveFxzjxVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fxq8j4aW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31315427249so4791117a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753153652; x=1753758452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMZ9p0HZh88liYCozQlcg2uf0elQviB/5i4iMM6RiTI=;
        b=Fxq8j4aWh1tw21o82FrS72RUURCWRn6CLSr2JU/6EPeo0jlEpRuLbdb0bbGC9uRZYY
         zCeXmi+mLKXe5svyQRE9BCDOUUDbb/W2oqrCc5Ln8oqhVIr/irb4KebLTf1ASRBV1Y+V
         tzWG9OBGvvPVQ5ncSkm7ZKel1S2Q9qMyJCNtwMSr5b3UB5viSNuxZ4uOYOSIhYlDffOS
         T4VsA1tuSJ9yk3qohtn13orzEh1CFNjwvuzglqJ+Mf3Xl3Yif/UxGl9a0+momtRziZEB
         Ehkcg1EiJvmAOvxU0QdyrPEKgr+ZSiOqFLGDwG8jojtXYKOM0PzeqQOwUxpxmW4CwMdt
         hN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753153652; x=1753758452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMZ9p0HZh88liYCozQlcg2uf0elQviB/5i4iMM6RiTI=;
        b=j4DuoyR3YJuKlSpta0/aG+P0sAYoWyscdetnhojosmB+9DbDz5nV6LfVwthD9itpj9
         EjiRmLuL4ERU1IXlfORLqfLXyf9stw8babYgZwPazvX5o0oVB+y9dZCHexV2RdHiJei9
         yDsOUuUyZsp3w7XsHfj2Cbd//5nlm5Q4a1by/fvL1dPqCpjYTEr3CqvY+0lDCNwjOaLd
         Av+xeGS0zkxdqOoNLoUTCJOVXbgq4VHt9BWXCJc/+AUnxyTLUBzvHlfgLqJo7tWizXuk
         2uJH6FxdsFwE1kX+xzlCz9OiAWUS25HeULN0qBEg3fDdZVNKfcmmT95TVjFfcYdK6jX3
         ji3Q==
X-Gm-Message-State: AOJu0Yxyfk4ZRj1GlV2qabkaGFgAzzAO3gbGq6FAu6RDk+uNXteVq6/9
	iDCPNFSTFHemWm4Ys8mv2kL/3l2nXt6gQhyJg64UNKzaEYiERCxSS1n/Ob+NNzJJjWrB0WHBiYE
	pIVXEfRwMa1IfrA==
X-Google-Smtp-Source: AGHT+IHnH2Pv/3CfSJRgZeDvqdc083/DCkv2rfPpbyVfUMbUzgRZ2Q9nChadTlV0jEu6BCwISCeh8pRzPLA4mQ==
X-Received: from pjboh11.prod.google.com ([2002:a17:90b:3a4b:b0:312:e914:4548])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f8d:b0:316:d69d:49fb with SMTP id 98e67ed59e1d1-31c9e70915amr37160659a91.14.1753153652365;
 Mon, 21 Jul 2025 20:07:32 -0700 (PDT)
Date: Tue, 22 Jul 2025 03:07:27 +0000
In-Reply-To: <20250722030727.1033487-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722030727.1033487-1-skhawaja@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722030727.1033487-3-skhawaja@google.com>
Subject: [PATCH net-next v7 3/3] net: define an enum for the napi threaded state
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
index 32ea881d79fe..ee1bedb4ee06 100644
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
 
 int netif_set_threaded_hint(struct net_device *dev);
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
index 4eeae65fda09..c236c7570693 100644
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
@@ -7032,7 +7034,7 @@ int netif_set_threaded(struct net_device *dev, bool threaded)
 
 int netif_set_threaded_hint(struct net_device *dev)
 {
-	return netif_set_threaded(dev, true);
+	return netif_set_threaded(dev, NETDEV_NAPI_THREADED_ENABLED);
 }
 EXPORT_SYMBOL(netif_set_threaded_hint);
 
@@ -7349,7 +7351,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
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


