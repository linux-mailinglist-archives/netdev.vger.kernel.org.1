Return-Path: <netdev+bounces-83057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20813890944
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 20:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C458629899A
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 19:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B2F1369AB;
	Thu, 28 Mar 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J/toOWTl"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271801C6BD
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654313; cv=none; b=eTBIXAe52uzTUxuv6bBPLp63je103RcD46fzSpjApEpB1XAqGibg2WDfAu2146MTr4b0FipVLQELACih82JWMzsDEtIonX02RuSz5PFodwAOYS1AJCEGWLGwyF5+E8wvCrYv1NP4R41+wmd+TVofj+fGL5n1O8Zx3lfHTlB2Hyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654313; c=relaxed/simple;
	bh=YLEdDPeb7AtCZmKA1AZUQCHFqDaG4HXndkl4P6IqeQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ArSVs85zrB5lLriC3YxprRgLwB6OUyBfKUntUzvfAswyXHhoIlD164VyxQcAEyiCwAYt7SdZhOnVj6DNkza5PVSs1NPW9sxLdEV6cJ2X41XLIBzrfbyIXSpZFNGTwTOWAxr93h/cU7tli7OWQHgdfEiObEAt6/erHBrZGJewDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J/toOWTl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=zE/xXrsL+KiB4U52ZeHQ1qLjqVEjzsWqwcfYh+J19ng=; t=1711654310; x=1712863910; 
	b=J/toOWTluRtlsuEqTvZOIiNJe43sBjjq/NaH+yv9hs5UOBHKla1fLudBWH8XJVaqjJ5xXEFBurE
	OXbOliVup97MbUwN4u24i2u/E1ZYsSvhP++7wy/lCDsRd773mVMDa3nME//Bj5g8CQMvqrVrKU8JX
	PGG/0qOrOP2lTlwtXd1S8/6ts8pihiuTsjPYNmPQ2WfNIHdE3Azvu5wp10KPIhEPmGM5nhFhPK2Cg
	ytkSHwTaJDktZq/qKUs89UUcRVO6Oa+CuvcSs68dhOXAgN2g69xYJZOkdZ/c7GsWmf/070fRMPpvB
	4sP65ONXTqC2FXp6HFNabrAIEcps1DjSf1DQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpvTX-00000001Gf9-0nRo;
	Thu, 28 Mar 2024 20:31:47 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next] netlink: introduce type-checking attribute iteration
Date: Thu, 28 Mar 2024 20:31:45 +0100
Message-ID: <20240328203144.b5a6c895fb80.I1869b44767379f204998ff44dd239803f39c23e0@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are, especially with multi-attr arrays, many cases
of needing to iterate all attributes of a specific type
in a netlink message or a nested attribute. Add specific
macros to support that case.

Also convert many instances using this spatch:

    @@
    iterator nla_for_each_attr;
    iterator name nla_for_each_attr_type;
    identifier nla;
    expression head, len, rem;
    expression ATTR;
    type T;
    identifier x;
    @@
    -nla_for_each_attr(nla, head, len, rem)
    +nla_for_each_attr_type(nla, ATTR, head, len, rem)
     {
    <... T x; ...>
    -if (nla_type(nla) == ATTR) {
     ...
    -}
     }

    @@
    identifier nla;
    iterator nla_for_each_nested;
    iterator name nla_for_each_nested_type;
    expression attr, rem;
    expression ATTR;
    type T;
    identifier x;
    @@
    -nla_for_each_nested(nla, attr, rem)
    +nla_for_each_nested_type(nla, ATTR, attr, rem)
     {
    <... T x; ...>
    -if (nla_type(nla) == ATTR) {
     ...
    -}
     }

    @@
    iterator nla_for_each_attr;
    iterator name nla_for_each_attr_type;
    identifier nla;
    expression head, len, rem;
    expression ATTR;
    type T;
    identifier x;
    @@
    -nla_for_each_attr(nla, head, len, rem)
    +nla_for_each_attr_type(nla, ATTR, head, len, rem)
     {
    <... T x; ...>
    -if (nla_type(nla) != ATTR) continue;
     ...
     }

    @@
    identifier nla;
    iterator nla_for_each_nested;
    iterator name nla_for_each_nested_type;
    expression attr, rem;
    expression ATTR;
    type T;
    identifier x;
    @@
    -nla_for_each_nested(nla, attr, rem)
    +nla_for_each_nested_type(nla, ATTR, attr, rem)
     {
    <... T x; ...>
    -if (nla_type(nla) != ATTR) continue;
     ...
     }

Although I had to undo one bad change this made, and
I also adjusted some other code for whitespace and to
use direct variable initialization now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 +---
 drivers/net/ethernet/emulex/benet/be_main.c   |  5 +---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 ++----
 drivers/net/ethernet/intel/ice/ice_main.c     |  7 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++-----
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  5 +---
 .../ethernet/netronome/nfp/nfp_net_common.c   |  5 +---
 include/net/netlink.h                         | 27 +++++++++++++++++++
 net/8021q/vlan_netlink.c                      | 10 +++----
 net/core/bpf_sk_storage.c                     | 23 +++++++---------
 net/core/rtnetlink.c                          | 15 +++++------
 net/devlink/dev.c                             | 12 +++------
 net/sched/sch_mqprio.c                        |  6 ++---
 net/sched/sch_taprio.c                        |  5 +---
 14 files changed, 65 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 493b724848c8..b08b618ffba1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14454,12 +14454,9 @@ static int bnxt_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	if (!br_spec)
 		return -EINVAL;
 
-	nla_for_each_nested(attr, br_spec, rem) {
+	nla_for_each_nested_type(attr, IFLA_BRIDGE_MODE, br_spec, rem) {
 		u16 mode;
 
-		if (nla_type(attr) != IFLA_BRIDGE_MODE)
-			continue;
-
 		mode = nla_get_u16(attr);
 		if (mode == bp->br_mode)
 			break;
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index ad862ed7888a..a8596ebcdfd6 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -4982,10 +4982,7 @@ static int be_ndo_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	if (!br_spec)
 		return -EINVAL;
 
-	nla_for_each_nested(attr, br_spec, rem) {
-		if (nla_type(attr) != IFLA_BRIDGE_MODE)
-			continue;
-
+	nla_for_each_nested_type(attr, IFLA_BRIDGE_MODE, br_spec, rem) {
 		mode = nla_get_u16(attr);
 		if (BE3_chip(adapter) && mode == BRIDGE_MODE_VEPA)
 			return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f86578857e8a..e427e65af205 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13108,13 +13108,9 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 	if (!br_spec)
 		return -EINVAL;
 
-	nla_for_each_nested(attr, br_spec, rem) {
-		__u16 mode;
+	nla_for_each_nested_type(attr, IFLA_BRIDGE_MODE, br_spec, rem) {
+		__u16 mode = nla_get_u16(attr);
 
-		if (nla_type(attr) != IFLA_BRIDGE_MODE)
-			continue;
-
-		mode = nla_get_u16(attr);
 		if ((mode != BRIDGE_MODE_VEPA) &&
 		    (mode != BRIDGE_MODE_VEB))
 			return -EINVAL;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 33a164fa325a..3838d82f04be 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7999,12 +7999,9 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	if (!br_spec)
 		return -EINVAL;
 
-	nla_for_each_nested(attr, br_spec, rem) {
-		__u16 mode;
+	nla_for_each_nested_type(attr, IFLA_BRIDGE_MODE, br_spec, rem) {
+		__u16 mode = nla_get_u16(attr);
 
-		if (nla_type(attr) != IFLA_BRIDGE_MODE)
-			continue;
-		mode = nla_get_u16(attr);
 		if (mode != BRIDGE_MODE_VEPA && mode != BRIDGE_MODE_VEB)
 			return -EINVAL;
 		/* Continue  if bridge mode is not being flipped */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f985252c8c8d..ed05af665466 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10061,15 +10061,10 @@ static int ixgbe_ndo_bridge_setlink(struct net_device *dev,
 	if (!br_spec)
 		return -EINVAL;
 
-	nla_for_each_nested(attr, br_spec, rem) {
-		int status;
-		__u16 mode;
+	nla_for_each_nested_type(attr, IFLA_BRIDGE_MODE, br_spec, rem) {
+		__u16 mode = nla_get_u16(attr);
+		int status = ixgbe_configure_bridge_mode(adapter, mode);
 
-		if (nla_type(attr) != IFLA_BRIDGE_MODE)
-			continue;
-
-		mode = nla_get_u16(attr);
-		status = ixgbe_configure_bridge_mode(adapter, mode);
 		if (status)
 			return status;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 91848eae4565..81e1c1e401f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4950,10 +4950,7 @@ static int mlx5e_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	if (!br_spec)
 		return -EINVAL;
 
-	nla_for_each_nested(attr, br_spec, rem) {
-		if (nla_type(attr) != IFLA_BRIDGE_MODE)
-			continue;
-
+	nla_for_each_nested_type(attr, IFLA_BRIDGE_MODE, br_spec, rem) {
 		mode = nla_get_u16(attr);
 		if (mode > BRIDGE_MODE_VEPA)
 			return -EINVAL;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index f28e769e6fda..997cc4fcffdb 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2289,10 +2289,7 @@ static int nfp_net_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	if (!br_spec)
 		return -EINVAL;
 
-	nla_for_each_nested(attr, br_spec, rem) {
-		if (nla_type(attr) != IFLA_BRIDGE_MODE)
-			continue;
-
+	nla_for_each_nested_type(attr, IFLA_BRIDGE_MODE, br_spec, rem) {
 		new_ctrl = nn->dp.ctrl;
 		mode = nla_get_u16(attr);
 		if (mode == BRIDGE_MODE_VEPA)
diff --git a/include/net/netlink.h b/include/net/netlink.h
index c19ff921b661..1d2bbcc50212 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -157,7 +157,11 @@
  *   nla_parse()			parse and validate stream of attrs
  *   nla_parse_nested()			parse nested attributes
  *   nla_for_each_attr()		loop over all attributes
+ *   nla_for_each_attr_type()		loop over all attributes with the
+ *					given type
  *   nla_for_each_nested()		loop over the nested attributes
+ *   nla_for_each_nested_type()		loop over the nested attributes with
+ *					the given type
  *=========================================================================
  */
 
@@ -2070,6 +2074,18 @@ static inline int nla_total_size_64bit(int payload)
 	     nla_ok(pos, rem); \
 	     pos = nla_next(pos, &(rem)))
 
+/**
+ * nla_for_each_attr_type - iterate over a stream of attributes
+ * @pos: loop counter, set to current attribute
+ * @type: required attribute type for @pos
+ * @head: head of attribute stream
+ * @len: length of attribute stream
+ * @rem: initialized to len, holds bytes currently remaining in stream
+ */
+#define nla_for_each_attr_type(pos, type, head, len, rem) \
+	nla_for_each_attr(pos, head, len, rem) \
+		if (nla_type(pos) == type)
+
 /**
  * nla_for_each_nested - iterate over nested attributes
  * @pos: loop counter, set to current attribute
@@ -2079,6 +2095,17 @@ static inline int nla_total_size_64bit(int payload)
 #define nla_for_each_nested(pos, nla, rem) \
 	nla_for_each_attr(pos, nla_data(nla), nla_len(nla), rem)
 
+/**
+ * nla_for_each_nested_type - iterate over nested attributes
+ * @pos: loop counter, set to current attribute
+ * @type: required attribute type for @pos
+ * @nla: attribute containing the nested attributes
+ * @rem: initialized to len, holds bytes currently remaining in stream
+ */
+#define nla_for_each_nested_type(pos, type, nla, rem) \
+	nla_for_each_nested(pos, nla, rem) \
+		if (nla_type(pos) == type)
+
 /**
  * nla_is_last - Test if attribute is last in stream
  * @nla: attribute to test
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index a3b68243fd4b..cf5219df7903 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -117,17 +117,15 @@ static int vlan_changelink(struct net_device *dev, struct nlattr *tb[],
 			return err;
 	}
 	if (data[IFLA_VLAN_INGRESS_QOS]) {
-		nla_for_each_nested(attr, data[IFLA_VLAN_INGRESS_QOS], rem) {
-			if (nla_type(attr) != IFLA_VLAN_QOS_MAPPING)
-				continue;
+		nla_for_each_nested_type(attr, IFLA_VLAN_QOS_MAPPING,
+					 data[IFLA_VLAN_INGRESS_QOS], rem) {
 			m = nla_data(attr);
 			vlan_dev_set_ingress_priority(dev, m->to, m->from);
 		}
 	}
 	if (data[IFLA_VLAN_EGRESS_QOS]) {
-		nla_for_each_nested(attr, data[IFLA_VLAN_EGRESS_QOS], rem) {
-			if (nla_type(attr) != IFLA_VLAN_QOS_MAPPING)
-				continue;
+		nla_for_each_nested_type(attr, IFLA_VLAN_QOS_MAPPING,
+					 data[IFLA_VLAN_EGRESS_QOS], rem) {
 			m = nla_data(attr);
 			err = vlan_dev_set_egress_priority(dev, m->from, m->to);
 			if (err)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 6c4d90b24d46..bc01b3aa6b0f 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -496,27 +496,22 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 	if (!bpf_capable())
 		return ERR_PTR(-EPERM);
 
-	nla_for_each_nested(nla, nla_stgs, rem) {
-		if (nla_type(nla) == SK_DIAG_BPF_STORAGE_REQ_MAP_FD) {
-			if (nla_len(nla) != sizeof(u32))
-				return ERR_PTR(-EINVAL);
-			nr_maps++;
-		}
+	nla_for_each_nested_type(nla, SK_DIAG_BPF_STORAGE_REQ_MAP_FD,
+				 nla_stgs, rem) {
+		if (nla_len(nla) != sizeof(u32))
+			return ERR_PTR(-EINVAL);
+		nr_maps++;
 	}
 
 	diag = kzalloc(struct_size(diag, maps, nr_maps), GFP_KERNEL);
 	if (!diag)
 		return ERR_PTR(-ENOMEM);
 
-	nla_for_each_nested(nla, nla_stgs, rem) {
-		struct bpf_map *map;
-		int map_fd;
+	nla_for_each_nested_type(nla, SK_DIAG_BPF_STORAGE_REQ_MAP_FD,
+				 nla_stgs, rem) {
+		int map_fd = nla_get_u32(nla);
+		struct bpf_map *map = bpf_map_get(map_fd);
 
-		if (nla_type(nla) != SK_DIAG_BPF_STORAGE_REQ_MAP_FD)
-			continue;
-
-		map_fd = nla_get_u32(nla);
-		map = bpf_map_get(map_fd);
 		if (IS_ERR(map)) {
 			err = PTR_ERR(map);
 			goto err_free;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a3d7847ce69d..283e42f48af6 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5245,15 +5245,14 @@ static int rtnl_bridge_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
 	if (br_spec) {
-		nla_for_each_nested(attr, br_spec, rem) {
-			if (nla_type(attr) == IFLA_BRIDGE_FLAGS) {
-				if (nla_len(attr) < sizeof(flags))
-					return -EINVAL;
+		nla_for_each_nested_type(attr, IFLA_BRIDGE_FLAGS, br_spec,
+					 rem) {
+			if (nla_len(attr) < sizeof(flags))
+				return -EINVAL;
 
-				have_flags = true;
-				flags = nla_get_u16(attr);
-				break;
-			}
+			have_flags = true;
+			flags = nla_get_u16(attr);
+			break;
 		}
 	}
 
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 19dbf540748a..c609deb42e88 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -1202,17 +1202,13 @@ static void __devlink_compat_running_version(struct devlink *devlink,
 	if (err)
 		goto free_msg;
 
-	nla_for_each_attr(nlattr, (void *)msg->data, msg->len, rem) {
+	nla_for_each_attr_type(nlattr, DEVLINK_ATTR_INFO_VERSION_RUNNING,
+			       (void *)msg->data, msg->len, rem) {
 		const struct nlattr *kv;
 		int rem_kv;
 
-		if (nla_type(nlattr) != DEVLINK_ATTR_INFO_VERSION_RUNNING)
-			continue;
-
-		nla_for_each_nested(kv, nlattr, rem_kv) {
-			if (nla_type(kv) != DEVLINK_ATTR_INFO_VERSION_VALUE)
-				continue;
-
+		nla_for_each_nested_type(kv, DEVLINK_ATTR_INFO_VERSION_VALUE,
+					 nlattr, rem_kv) {
 			strlcat(buf, nla_data(kv), len);
 			strlcat(buf, " ", len);
 		}
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 225353fbb3f1..51d4013b6121 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -215,10 +215,8 @@ static int mqprio_parse_tc_entries(struct Qdisc *sch, struct nlattr *nlattr_opt,
 	for (tc = 0; tc < TC_QOPT_MAX_QUEUE; tc++)
 		fp[tc] = priv->fp[tc];
 
-	nla_for_each_attr(n, nlattr_opt, nlattr_opt_len, rem) {
-		if (nla_type(n) != TCA_MQPRIO_TC_ENTRY)
-			continue;
-
+	nla_for_each_attr_type(n, TCA_MQPRIO_TC_ENTRY, nlattr_opt,
+			       nlattr_opt_len, rem) {
 		err = mqprio_parse_tc_entry(fp, n, &seen_tcs, extack);
 		if (err)
 			goto out;
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a0d54b422186..1ab17e8a7260 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1752,10 +1752,7 @@ static int taprio_parse_tc_entries(struct Qdisc *sch,
 		fp[tc] = q->fp[tc];
 	}
 
-	nla_for_each_nested(n, opt, rem) {
-		if (nla_type(n) != TCA_TAPRIO_ATTR_TC_ENTRY)
-			continue;
-
+	nla_for_each_nested_type(n, TCA_TAPRIO_ATTR_TC_ENTRY, opt, rem) {
 		err = taprio_parse_tc_entry(sch, n, max_sdu, fp, &seen_tcs,
 					    extack);
 		if (err)
-- 
2.44.0


