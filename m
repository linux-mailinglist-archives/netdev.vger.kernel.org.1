Return-Path: <netdev+bounces-305885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r8J6Am16TmpMNgIAu9opvQ
	(envelope-from <netdev+bounces-305885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:27:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B59728B04
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:27:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="iAo3j/OB";
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305885-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305885-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D508130AD8E5
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ADA361DBC;
	Wed,  8 Jul 2026 16:04:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA372147F9
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:04:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526663; cv=none; b=iOs/5s3gfB3rtjLL4k4ZPtg0x+qyBda0TAEke7y3ZOa7odMzO3aH/Ln3X/jaVLWvLucQERhEon5ObH+ylJQ5d12BI90N3R5Hle14j+bLCYUp/ks/ZT2PcEMET2y3GX60ui41lzfaJkPfnyceh+02RQ0kzctqAp7YKTFePdZlu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526663; c=relaxed/simple;
	bh=dakI7lNxU+qWuViH1I1zwqmUPcmjEjUWbYrx2HweWSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l5aK6EFgitsot0Jnzj6lckyPk1r147bV4npxFgdg7z5EWh8TUDXJmpsPhyV6gXdCs+lofJDbgUi4NbLTFHMuzQBovLn20ZXbHal0ymDnQOMD7NLtxFId6oAOq1Ug0etabCc/zCSvnp61XEwYYjEFPTqkC9LBXmDOPZeQ1CURPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAo3j/OB; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-915d3261c5cso97054285a.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783526659; x=1784131459; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KFCz6Hc7rce8hXzg5fQYzr6jGjLNCkdpi9OcKJNFmOg=;
        b=iAo3j/OBa5s1nrZw8TNju/x27B71A7lH0tUB7BrHce1u0N9nGiQ9574tnpbw5jMP83
         i6kz+EZ3oYJrPlpJyXLQR4pmnefoOloKjp6DqW/Bqv2whqsmQUA8BMVLy4DdZgkXhgW1
         Xu0NlKXJy5ZYc0A4ZtGRHXMaLy9InEP4i9PYqtkm583kjYdhTd3GspzIQiT8yaLbZhQs
         4KyVtPArvq6/AvAgxHD7SOgFB8UMUPPGPE3yTsQgM+KrAVhik+hwyppIPCctweTxEq4S
         uZNSaSUrcpxHlWjCJkVx2HjaSkTX2iq12us6XEnX/iXU2vM3Titf0yZJimu5paH7HOwO
         nZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526659; x=1784131459;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KFCz6Hc7rce8hXzg5fQYzr6jGjLNCkdpi9OcKJNFmOg=;
        b=npR+abNh7+XYil0/WA///AIixnEHnppsDlR2UroVBm2HTBx/0Y8i7b8l9/+FmIIrTG
         b9betDKn7j35pS6II2GbHa8FPXmmmjN7nZp6oDrb56RmBs2GOKSN+kd4/jpiYbzsmsY1
         4Bog/Z5+CV+HDLIqk8OmeBL9lEAFZ3D1AJmRxMhgR9F4vDfbGfYFEVJlU6kllEIw561Y
         jtWEDSMIgqOMRh7jXvS2AIfLaAi5HFeNVD2lKM2azdP/7f/5SyGMglLG3i2qL9rexV6B
         +MlEA1MKcLIA+wXUH1LjfM8vfGuxgCHGAqS4kBI1qCF7CQDtGl5cLXGLojs88sgfbwG+
         JmPg==
X-Forwarded-Encrypted: i=1; AHgh+RqDBgJsqnYLyDX8OU84EVoOj+5Hg6i30yrb7sQAXDHBBGBBAraCRojj7KnCEFnlmY/mlYDUSrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhUw++RTrpezqGO5kaE7Ll45IldMy6FDt5Yqs402kD1Kc1S2y
	+y0Vjj59t9ZhgX98ZdaBkiX2tcy4+Hcc2tXfm/thH6bbrjv4UOI/N+C83EFshaUXi1bA2qBnqGW
	8cMbGrWqUOUHTZw==
X-Received: from qknvu7.prod.google.com ([2002:a05:620a:5607:b0:92e:535b:e091])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3195:b0:915:68dd:1eff with SMTP id af79cd13be357-92ecf68c95amr349353885a.50.1783526658231;
 Wed, 08 Jul 2026 09:04:18 -0700 (PDT)
Date: Wed,  8 Jul 2026 16:04:10 +0000
In-Reply-To: <20260708160411.1355008-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708160411.1355008-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708160411.1355008-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] vxlan: convert configuration to RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305885-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,lunn.ch,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46B59728B04

In order to allow lockless readers in future patches, dynamically allocate
'struct vxlan_config' and convert 'vxlan->cfg' to an RCU protected pointer.

Updating configuration via vxlan_changelink() or __vxlan_dev_create()
now allocates a new struct vxlan_config, initializes it, and uses
rcu_assign_pointer() to publish it, freeing the previous config with
kfree_rcu().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       |  14 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  57 ++-
 drivers/net/vxlan/vxlan_core.c                | 336 +++++++++++-------
 drivers/net/vxlan/vxlan_mdb.c                 |  29 +-
 drivers/net/vxlan/vxlan_multicast.c           |  12 +-
 drivers/net/vxlan/vxlan_vnifilter.c           |  21 +-
 include/net/vxlan.h                           |   3 +-
 net/openvswitch/vport-vxlan.c                 |  31 +-
 8 files changed, 331 insertions(+), 172 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index 52c2fe3644d4b9b27f1d589d9f7f597748339782..50cea39323f570e04067f2f98aff4d97e4a409fc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -59,8 +59,11 @@ static bool mlxsw_sp_nve_vxlan_can_offload(const struct mlxsw_sp_nve *nve,
 					   const struct mlxsw_sp_nve_params *params,
 					   struct netlink_ext_ack *extack)
 {
-	struct vxlan_dev *vxlan = netdev_priv(params->dev);
-	struct vxlan_config *cfg = &vxlan->cfg;
+	const struct vxlan_config *cfg;
+	struct vxlan_dev *vxlan;
+
+	vxlan = netdev_priv(params->dev);
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	if (vxlan_addr_multicast(&cfg->remote_ip)) {
 		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Multicast destination IP is not supported");
@@ -148,8 +151,11 @@ static void mlxsw_sp_nve_vxlan_config(const struct mlxsw_sp_nve *nve,
 				      const struct mlxsw_sp_nve_params *params,
 				      struct mlxsw_sp_nve_config *config)
 {
-	struct vxlan_dev *vxlan = netdev_priv(params->dev);
-	struct vxlan_config *cfg = &vxlan->cfg;
+	const struct vxlan_config *cfg;
+	struct vxlan_dev *vxlan;
+
+	vxlan = netdev_priv(params->dev);
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	config->type = MLXSW_SP_NVE_TYPE_VXLAN;
 	config->ttl = cfg->ttl;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index fe45e533a4b2efb532b85960009c586a53ade340..f25105ceb3f1bff87ec6addcae70c606bbe048ba 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2513,15 +2513,17 @@ mlxsw_sp_bridge_vlan_aware_vxlan_join(struct mlxsw_sp_bridge_device *bridge_devi
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_lower_get(bridge_device->dev);
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
-	struct mlxsw_sp_nve_params params = {
-		.type = MLXSW_SP_NVE_TYPE_VXLAN,
-		.vni = vxlan->cfg.vni,
-		.dev = vxlan_dev,
-		.ethertype = ethertype,
-	};
+	struct mlxsw_sp_nve_params params;
+	const struct vxlan_config *cfg;
 	struct mlxsw_sp_fid *fid;
 	int err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+	params.type = MLXSW_SP_NVE_TYPE_VXLAN;
+	params.vni = cfg->vni;
+	params.dev = vxlan_dev;
+	params.ethertype = ethertype;
+
 	/* If the VLAN is 0, we need to find the VLAN that is configured as
 	 * PVID and egress untagged on the bridge port of the VxLAN device.
 	 * It is possible no such VLAN exists
@@ -2704,15 +2706,17 @@ mlxsw_sp_bridge_8021d_vxlan_join(struct mlxsw_sp_bridge_device *bridge_device,
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_lower_get(bridge_device->dev);
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
-	struct mlxsw_sp_nve_params params = {
-		.type = MLXSW_SP_NVE_TYPE_VXLAN,
-		.vni = vxlan->cfg.vni,
-		.dev = vxlan_dev,
-		.ethertype = ETH_P_8021Q,
-	};
+	struct mlxsw_sp_nve_params params;
+	const struct vxlan_config *cfg;
 	struct mlxsw_sp_fid *fid;
 	int err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+	params.type = MLXSW_SP_NVE_TYPE_VXLAN;
+	params.vni = cfg->vni;
+	params.dev = vxlan_dev;
+	params.ethertype = ETH_P_8021Q;
+
 	fid = mlxsw_sp_fid_8021d_get(mlxsw_sp, bridge_device->dev->ifindex);
 	if (IS_ERR(fid)) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed to create 802.1D FID");
@@ -2933,10 +2937,13 @@ static void __mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
 					  const struct net_device *vxlan_dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
+	const struct vxlan_config *cfg;
 	struct mlxsw_sp_fid *fid;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+
 	/* If the VxLAN device is down, then the FID does not have a VNI */
-	fid = mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vxlan->cfg.vni);
+	fid = mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, cfg->vni);
 	if (!fid)
 		return;
 
@@ -3029,11 +3036,13 @@ static void mlxsw_sp_fdb_vxlan_call_notifiers(struct net_device *dev,
 	struct switchdev_notifier_vxlan_fdb_info info;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	enum switchdev_notifier_type type;
+	const struct vxlan_config *cfg;
 
+	cfg = rtnl_dereference(vxlan->cfg);
 	type = adding ? SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE :
 			SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE;
 	mlxsw_sp_switchdev_addr_vxlan_convert(proto, addr, &info.remote_ip);
-	info.remote_port = vxlan->cfg.dst_port;
+	info.remote_port = cfg->dst_port;
 	info.remote_vni = vni;
 	info.remote_ifindex = 0;
 	ether_addr_copy(info.eth_addr, mac);
@@ -3236,8 +3245,10 @@ __mlxsw_sp_fdb_notify_mac_uc_tunnel_process(struct mlxsw_sp *mlxsw_sp,
 
 	if (adding && netif_is_vxlan(dev)) {
 		struct vxlan_dev *vxlan = netdev_priv(dev);
+		const struct vxlan_config *cfg;
 
-		if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
+		cfg = rtnl_dereference(vxlan->cfg);
+		if (!(cfg->flags & VXLAN_F_LEARN))
 			return -EINVAL;
 	}
 
@@ -3722,9 +3733,11 @@ mlxsw_sp_switchdev_vxlan_work_prepare(struct mlxsw_sp_switchdev_event_work *
 {
 	struct vxlan_dev *vxlan = netdev_priv(switchdev_work->dev);
 	struct switchdev_notifier_vxlan_fdb_info *vxlan_fdb_info;
-	struct vxlan_config *cfg = &vxlan->cfg;
+	const struct vxlan_config *cfg;
 	struct netlink_ext_ack *extack;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+
 	extack = switchdev_notifier_info_to_extack(info);
 	vxlan_fdb_info = container_of(info,
 				      struct switchdev_notifier_vxlan_fdb_info,
@@ -3851,11 +3864,15 @@ mlxsw_sp_switchdev_vxlan_vlan_add(struct mlxsw_sp *mlxsw_sp,
 				  struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
-	__be32 vni = vxlan->cfg.vni;
+	const struct vxlan_config *cfg;
 	struct mlxsw_sp_fid *fid;
 	u16 old_vid;
+	__be32 vni;
 	int err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+	vni = cfg->vni;
+
 	/* We cannot have the same VLAN as PVID and egress untagged on multiple
 	 * VxLAN devices. Note that we get this notification before the VLAN is
 	 * actually added to the bridge's database, so it is not possible for
@@ -3935,12 +3952,16 @@ mlxsw_sp_switchdev_vxlan_vlan_del(struct mlxsw_sp *mlxsw_sp,
 				  const struct net_device *vxlan_dev, u16 vid)
 {
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
-	__be32 vni = vxlan->cfg.vni;
+	const struct vxlan_config *cfg;
 	struct mlxsw_sp_fid *fid;
+	__be32 vni;
 
 	if (!netif_running(vxlan_dev))
 		return;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+	vni = cfg->vni;
+
 	fid = mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vni);
 	if (!fid)
 		return;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index eb2608fb7139a18d905d9b1a5140f22a880818d6..96ac74fb1eb064d4e280af8ffa68cff37aacbca7 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -110,20 +110,23 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
 		vni = 0;
 
 	hlist_for_each_entry_rcu(node, vni_head(vs, vni), hlist) {
+		const struct vxlan_config *cfg;
+
 		if (!node->vxlan)
 			continue;
+
+		cfg = rcu_dereference(node->vxlan->cfg);
+
 		vnode = NULL;
-		if (node->vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+		if (cfg->flags & VXLAN_F_VNIFILTER) {
 			vnode = vxlan_vnifilter_lookup(node->vxlan, vni);
 			if (!vnode)
 				continue;
-		} else if (node->vxlan->default_dst.remote_vni != vni) {
+		} else if (cfg->vni != vni) {
 			continue;
 		}
 
 		if (IS_ENABLED(CONFIG_IPV6)) {
-			const struct vxlan_config *cfg = &node->vxlan->cfg;
-
 			if ((cfg->flags & VXLAN_F_IPV6_LINKLOCAL) &&
 			    cfg->remote_ifindex != ifindex)
 				continue;
@@ -157,6 +160,7 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			  u32 portid, u32 seq, int type, unsigned int flags,
 			  const struct vxlan_rdst *rdst)
 {
+	const struct vxlan_config *cfg = rcu_dereference_rtnl(vxlan->cfg);
 	unsigned long now = jiffies;
 	struct nda_cacheinfo ci;
 	bool send_ip, send_eth;
@@ -216,10 +220,10 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			goto nla_put_failure;
 
 		if (rdst->remote_port &&
-		    rdst->remote_port != vxlan->cfg.dst_port &&
+		    rdst->remote_port != cfg->dst_port &&
 		    nla_put_be16(skb, NDA_PORT, rdst->remote_port))
 			goto nla_put_failure;
-		if (rdst->remote_vni != vxlan->default_dst.remote_vni &&
+		if (rdst->remote_vni != cfg->vni &&
 		    nla_put_u32(skb, NDA_VNI, be32_to_cpu(rdst->remote_vni)))
 			goto nla_put_failure;
 		if (rdst->remote_ifindex &&
@@ -227,7 +231,7 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			goto nla_put_failure;
 	}
 
-	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) && fdb->key.vni &&
+	if ((cfg->flags & VXLAN_F_COLLECT_METADATA) && fdb->key.vni &&
 	    nla_put_u32(skb, NDA_SRC_VNI,
 			be32_to_cpu(fdb->key.vni)))
 		goto nla_put_failure;
@@ -418,7 +422,7 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	lockdep_assert_held_once(&vxlan->hash_lock);
 
 	rcu_read_lock();
-	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, mac, vni);
+	f = vxlan_find_mac_rcu(vxlan, rcu_dereference(vxlan->cfg), mac, vni);
 	rcu_read_unlock();
 
 	return f;
@@ -459,7 +463,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, eth_addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, rcu_dereference(vxlan->cfg), eth_addr, vni);
 	if (f)
 		rdst = first_remote_rcu(f);
 	if (!rdst) {
@@ -865,12 +869,13 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
 		     u32 nhid, struct vxlan_fdb **fdb,
 		     struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_rdst *rd = NULL;
 	struct vxlan_fdb *f;
 	int rc;
 
-	if (vxlan->cfg.addrmax &&
-	    vxlan->addrcnt >= vxlan->cfg.addrmax)
+	if (cfg->addrmax &&
+	    vxlan->addrcnt >= cfg->addrmax)
 		return -ENOSPC;
 
 	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
@@ -1150,6 +1155,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 			   __be32 *vni, u32 *ifindex, u32 *nhid,
 			   struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct net *net = dev_net(vxlan->dev);
 	int err;
 
@@ -1166,7 +1172,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 			return err;
 		}
 	} else {
-		union vxlan_addr *remote = &vxlan->default_dst.remote_ip;
+		const union vxlan_addr *remote = &cfg->remote_ip;
 
 		if (remote->sa.sa_family == AF_INET) {
 			ip->sin.sin_addr.s_addr = htonl(INADDR_ANY);
@@ -1186,7 +1192,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 		}
 		*port = nla_get_be16(tb[NDA_PORT]);
 	} else {
-		*port = vxlan->cfg.dst_port;
+		*port = cfg->dst_port;
 	}
 
 	if (tb[NDA_VNI]) {
@@ -1196,7 +1202,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 		}
 		*vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
 	} else {
-		*vni = vxlan->default_dst.remote_vni;
+		*vni = cfg->vni;
 	}
 
 	if (tb[NDA_SRC_VNI]) {
@@ -1206,7 +1212,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 		}
 		*src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
 	} else {
-		*src_vni = vxlan->default_dst.remote_vni;
+		*src_vni = cfg->vni;
 	}
 
 	if (tb[NDA_IFINDEX]) {
@@ -1396,18 +1402,23 @@ static int vxlan_fdb_get(struct sk_buff *skb,
 			 struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
 	struct vxlan_fdb *f;
 	__be32 vni;
 	int err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+
 	if (tb[NDA_VNI])
 		vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
+	else if (cfg)
+		vni = cfg->vni;
 	else
-		vni = vxlan->default_dst.remote_vni;
+		return -ENODEV;
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, cfg, addr, vni);
 	if (!f) {
 		NL_SET_ERR_MSG(extack, "Fdb entry not found");
 		err = -ENOENT;
@@ -1510,6 +1521,7 @@ static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
 
 static void vxlan_sock_release(struct vxlan_dev *vxlan)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
 #if IS_ENABLED(CONFIG_IPV6)
 	struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
@@ -1519,7 +1531,7 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 
 	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg && (cfg->flags & VXLAN_F_VNIFILTER))
 		vxlan_vs_del_vnigrp(vxlan);
 	else
 		vxlan_vs_del_dev(vxlan);
@@ -1650,6 +1662,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
 static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct vxlan_vni_node *vninode = NULL;
+	const struct vxlan_config *cfg;
 	__be16 protocol = htons(ETH_P_TEB);
 	enum skb_drop_reason reason;
 	const struct vxlanhdr *vh;
@@ -1691,8 +1704,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (vh->vx_flags & vxlan->cfg.reserved_bits.vx_flags ||
-	    vh->vx_vni & vxlan->cfg.reserved_bits.vx_vni) {
+	cfg = rcu_dereference(vxlan->cfg);
+
+	if (vh->vx_flags & cfg->reserved_bits.vx_flags ||
+	    vh->vx_vni & cfg->reserved_bits.vx_vni) {
 		/* If the header uses bits besides those enabled by the
 		 * netdevice configuration, treat this as a malformed packet.
 		 * This behavior diverges from VXLAN RFC (RFC7348) which
@@ -1704,12 +1719,12 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
-		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, vninode,
+		vxlan_vnifilter_count(vxlan, cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_GPE) {
+	if (cfg->flags & VXLAN_F_GPE) {
 		if (!vxlan_parse_gpe_proto(vh, &protocol))
 			goto drop;
 		raw_proto = true;
@@ -1721,8 +1736,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_RX) {
-		reason = vxlan_remcsum(skb, vxlan->cfg.flags);
+	if (cfg->flags & VXLAN_F_REMCSUM_RX) {
+		reason = vxlan_remcsum(skb, cfg->flags);
 		if (unlikely(reason))
 			goto drop;
 	}
@@ -1747,14 +1762,14 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		memset(md, 0, sizeof(*md));
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_GBP)
-		vxlan_parse_gbp_hdr(skb, vxlan->cfg.flags, md);
+	if (cfg->flags & VXLAN_F_GBP)
+		vxlan_parse_gbp_hdr(skb, cfg->flags, md);
 	/* Note that GBP and GPE can never be active together. This is
 	 * ensured in vxlan_dev_configure.
 	 */
 
 	if (!raw_proto) {
-		reason = vxlan_set_mac(vxlan, &vxlan->cfg, vs, skb, vni);
+		reason = vxlan_set_mac(vxlan, cfg, vs, skb, vni);
 		if (reason)
 			goto drop;
 	} else {
@@ -1775,7 +1790,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (reason) {
 		DEV_STATS_INC(vxlan->dev, rx_length_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
-		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, vninode,
+		vxlan_vnifilter_count(vxlan, cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
 	}
@@ -1787,7 +1802,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
-		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, vninode,
+		vxlan_vnifilter_count(vxlan, cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
 	}
@@ -1797,14 +1812,14 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(!(vxlan->dev->flags & IFF_UP))) {
 		rcu_read_unlock();
 		dev_dstats_rx_dropped(vxlan->dev);
-		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, vninode,
+		vxlan_vnifilter_count(vxlan, cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
 		reason = SKB_DROP_REASON_DEV_READY;
 		goto drop;
 	}
 
 	dev_dstats_rx_add(vxlan->dev, skb->len);
-	vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, vninode, VXLAN_VNI_STATS_RX, skb->len);
+	vxlan_vnifilter_count(vxlan, cfg, vni, vninode, VXLAN_VNI_STATS_RX, skb->len);
 	gro_cells_receive(&vxlan->gro_cells, skb);
 
 	rcu_read_unlock();
@@ -1848,17 +1863,20 @@ static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
 static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u32 flags)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
 	struct arphdr *parp;
 	u8 *arpptr, *sha;
 	__be32 sip, tip;
 	struct neighbour *n;
 
+	cfg = rcu_dereference(vxlan->cfg);
+
 	if (dev->flags & IFF_NOARP)
 		goto out;
 
 	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
 		dev_dstats_tx_dropped(dev);
-		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
+		vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 				      VXLAN_VNI_STATS_TX_DROPS, 0);
 		goto out;
 	}
@@ -1896,7 +1914,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u
 		}
 
 		rcu_read_lock();
-		f = vxlan_find_mac_tx(vxlan, &vxlan->cfg, n->ha, vni);
+		f = vxlan_find_mac_tx(vxlan, cfg, n->ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -1922,7 +1940,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u
 
 		if (netif_rx(reply) == NET_RX_DROP) {
 			dev_dstats_rx_dropped(dev);
-			vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
+			vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
 
@@ -2036,6 +2054,7 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u32 flags)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
 	const struct in6_addr *daddr;
 	const struct ipv6hdr *iphdr;
 	struct neighbour *n;
@@ -2045,6 +2064,8 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni,
 	if (unlikely(!ipv6_mod_enabled()))
 		goto out;
 
+	cfg = rcu_dereference(vxlan->cfg);
+
 	iphdr = ipv6_hdr(skb);
 	daddr = &iphdr->daddr;
 	msg = (struct nd_msg *)(iphdr + 1);
@@ -2065,7 +2086,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni,
 			goto out;
 		}
 
-		f = vxlan_find_mac_tx(vxlan, &vxlan->cfg, n->ha, vni);
+		f = vxlan_find_mac_tx(vxlan, cfg, n->ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -2084,7 +2105,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni,
 
 		if (netif_rx(reply) == NET_RX_DROP) {
 			dev_dstats_rx_dropped(dev);
-			vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
+			vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
 	} else if (flags & VXLAN_F_L3MISS) {
@@ -2749,10 +2770,12 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	u32 nhid = 0;
 	u32 flags;
 
-	cfg = &vxlan->cfg;
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
 	flags = cfg->flags;
 	default_vni = cfg->vni;
 	saddr_family = cfg->saddr.sa.sa_family;
+	rcu_read_unlock();
 
 	info = skb_tunnel_info(skb);
 
@@ -2867,12 +2890,17 @@ static void vxlan_cleanup(struct timer_list *t)
 {
 	struct vxlan_dev *vxlan = timer_container_of(vxlan, t, age_timer);
 	unsigned long next_timer = jiffies + FDB_AGE_INTERVAL;
+	const struct vxlan_config *cfg;
 	struct vxlan_fdb *f;
 
 	if (!netif_running(vxlan->dev))
 		return;
 
 	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
+	if (!cfg)
+		goto out;
+
 	hlist_for_each_entry_rcu(f, &vxlan->fdb_list, fdb_node) {
 		unsigned long timeout;
 
@@ -2882,7 +2910,7 @@ static void vxlan_cleanup(struct timer_list *t)
 		if (f->flags & NTF_EXT_LEARNED)
 			continue;
 
-		timeout = READ_ONCE(f->updated) + vxlan->cfg.age_interval * HZ;
+		timeout = READ_ONCE(f->updated) + cfg->age_interval * HZ;
 		if (time_before_eq(timeout, jiffies)) {
 			spin_lock(&vxlan->hash_lock);
 			if (!hlist_unhashed(&f->fdb_node)) {
@@ -2896,6 +2924,7 @@ static void vxlan_cleanup(struct timer_list *t)
 			next_timer = timeout;
 		}
 	}
+out:
 	rcu_read_unlock();
 
 	mod_timer(&vxlan->age_timer, next_timer);
@@ -2926,13 +2955,16 @@ static void vxlan_vs_add_dev(struct vxlan_sock *vs, struct vxlan_dev *vxlan,
 static int vxlan_init(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
 	int err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+
 	err = rhashtable_init(&vxlan->fdb_hash_tbl, &vxlan_fdb_rht_params);
 	if (err)
 		return err;
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+	if (cfg->flags & VXLAN_F_VNIFILTER) {
 		err = vxlan_vnigroup_init(vxlan);
 		if (err)
 			goto err_rhashtable_destroy;
@@ -2952,7 +2984,7 @@ static int vxlan_init(struct net_device *dev)
 err_gro_cells_destroy:
 	gro_cells_destroy(&vxlan->gro_cells);
 err_vnigroup_uninit:
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg->flags & VXLAN_F_VNIFILTER)
 		vxlan_vnigroup_uninit(vxlan);
 err_rhashtable_destroy:
 	rhashtable_destroy(&vxlan->fdb_hash_tbl);
@@ -2962,10 +2994,13 @@ static int vxlan_init(struct net_device *dev)
 static void vxlan_uninit(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
+
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	vxlan_mdb_fini(vxlan);
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg && (cfg->flags & VXLAN_F_VNIFILTER))
 		vxlan_vnigroup_uninit(vxlan);
 
 	gro_cells_destroy(&vxlan->gro_cells);
@@ -2977,6 +3012,7 @@ static void vxlan_uninit(struct net_device *dev)
 static int vxlan_open(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
 	int ret;
 
 	ret = vxlan_sock_add(vxlan);
@@ -2989,7 +3025,8 @@ static int vxlan_open(struct net_device *dev)
 		return ret;
 	}
 
-	if (vxlan->cfg.age_interval)
+	cfg = rtnl_dereference(vxlan->cfg);
+	if (cfg && cfg->age_interval)
 		mod_timer(&vxlan->age_timer, jiffies + FDB_AGE_INTERVAL);
 
 	return ret;
@@ -3011,8 +3048,10 @@ struct vxlan_fdb_flush_desc {
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
 				       const struct vxlan_dev *vxlan)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
+
 	return is_zero_ether_addr(f->key.eth_addr) &&
-	       f->key.vni == vxlan->cfg.vni;
+	       f->key.vni == cfg->vni;
 }
 
 static bool vxlan_fdb_nhid_matches(const struct vxlan_fdb *f, u32 nhid)
@@ -3229,14 +3268,18 @@ static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
-							 dst->remote_ifindex);
+	const struct vxlan_config *cfg;
+	struct net_device *lowerdev;
+
+	cfg = rtnl_dereference(vxlan->cfg);
+
+	lowerdev = __dev_get_by_index(vxlan->net, dst->remote_ifindex);
 
 	/* This check is different than dev->max_mtu, because it looks at
 	 * the lowerdev->mtu, rather than the static dev->max_mtu
 	 */
 	if (lowerdev) {
-		int max_mtu = lowerdev->mtu - vxlan_headroom(vxlan->cfg.flags);
+		int max_mtu = lowerdev->mtu - vxlan_headroom(cfg->flags);
 		if (new_mtu > max_mtu)
 			return -EINVAL;
 	}
@@ -3249,11 +3292,14 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
+	const struct vxlan_config *cfg;
 	__be16 sport, dport;
 
-	sport = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
-				  vxlan->cfg.port_max, true);
-	dport = info->key.tp_dst ? : vxlan->cfg.dst_port;
+	cfg = rcu_dereference(vxlan->cfg);
+
+	sport = udp_flow_src_port(dev_net(dev), skb, cfg->port_min,
+				  cfg->port_max, true);
+	dport = info->key.tp_dst ? : cfg->dst_port;
 
 	if (ip_tunnel_info_af(info) == AF_INET) {
 		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
@@ -3363,6 +3409,14 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
 	}
 }
 
+static void vxlan_free_dev(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_config *cfg = rcu_dereference_protected(vxlan->cfg, 1);
+
+	kfree(cfg);
+}
+
 /* Initialize the device structure. */
 static void vxlan_setup(struct net_device *dev)
 {
@@ -3371,6 +3425,8 @@ static void vxlan_setup(struct net_device *dev)
 	eth_hw_addr_random(dev);
 	ether_setup(dev);
 
+	dev->priv_destructor = vxlan_free_dev;
+
 	dev->needs_free_netdev = true;
 	SET_NETDEV_DEVTYPE(dev, &vxlan_type);
 
@@ -3651,21 +3707,22 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 
 static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 {
-	bool metadata = vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
+	bool metadata = cfg->flags & VXLAN_F_COLLECT_METADATA;
 	struct vxlan_sock *vs = NULL;
 	struct vxlan_dev_node *node;
 	int l3mdev_index = 0;
 
 	ASSERT_RTNL();
 
-	if (vxlan->cfg.remote_ifindex)
+	if (cfg->remote_ifindex)
 		l3mdev_index = l3mdev_master_upper_ifindex_by_index(
-			vxlan->net, vxlan->cfg.remote_ifindex);
+			vxlan->net, cfg->remote_ifindex);
 
-	if (!vxlan->cfg.no_share) {
+	if (!cfg->no_share) {
 		rcu_read_lock();
 		vs = vxlan_find_sock(vxlan->net, ipv6 ? AF_INET6 : AF_INET,
-				     vxlan->cfg.dst_port, vxlan->cfg.flags,
+				     cfg->dst_port, cfg->flags,
 				     l3mdev_index);
 		if (vs && !refcount_inc_not_zero(&vs->refcnt)) {
 			rcu_read_unlock();
@@ -3675,7 +3732,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 	}
 	if (!vs)
 		vs = vxlan_socket_create(vxlan->net, ipv6,
-					 vxlan->cfg.dst_port, vxlan->cfg.flags,
+					 cfg->dst_port, cfg->flags,
 					 l3mdev_index);
 	if (IS_ERR(vs))
 		return PTR_ERR(vs);
@@ -3690,7 +3747,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 		node = &vxlan->hlist4;
 	}
 
-	if (metadata && (vxlan->cfg.flags & VXLAN_F_VNIFILTER))
+	if (metadata && (cfg->flags & VXLAN_F_VNIFILTER))
 		vxlan_vs_add_vnigrp(vxlan, vs, ipv6);
 	else
 		vxlan_vs_add_dev(vs, vxlan, node);
@@ -3700,11 +3757,14 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 
 static int vxlan_sock_add(struct vxlan_dev *vxlan)
 {
-	bool metadata = vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA;
-	bool ipv6 = vxlan->cfg.flags & VXLAN_F_IPV6 || metadata;
-	bool ipv4 = !ipv6 || metadata;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
+	bool metadata, ipv6, ipv4;
 	int ret = 0;
 
+	metadata = cfg->flags & VXLAN_F_COLLECT_METADATA;
+	ipv6 = (cfg->flags & VXLAN_F_IPV6) || metadata;
+	ipv4 = !ipv6 || metadata;
+
 	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
@@ -3728,22 +3788,27 @@ int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
 	struct vxlan_dev *tmp;
 
 	list_for_each_entry(tmp, &vn->vxlan_list, next) {
+		const struct vxlan_config *tmp_cfg;
+
 		if (tmp == vxlan)
 			continue;
-		if (tmp->cfg.flags & VXLAN_F_VNIFILTER) {
+
+		tmp_cfg = rtnl_dereference(tmp->cfg);
+
+		if (tmp_cfg->flags & VXLAN_F_VNIFILTER) {
 			if (!vxlan_vnifilter_lookup(tmp, vni))
 				continue;
-		} else if (tmp->cfg.vni != vni) {
+		} else if (tmp_cfg->vni != vni) {
 			continue;
 		}
-		if (tmp->cfg.dst_port != conf->dst_port)
+		if (tmp_cfg->dst_port != conf->dst_port)
 			continue;
-		if ((tmp->cfg.flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)) !=
+		if ((tmp_cfg->flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)) !=
 		    (conf->flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)))
 			continue;
 
 		if ((conf->flags & VXLAN_F_IPV6_LINKLOCAL) &&
-		    tmp->cfg.remote_ifindex != conf->remote_ifindex)
+		    tmp_cfg->remote_ifindex != conf->remote_ifindex)
 			continue;
 
 		return -EEXIST;
@@ -3905,7 +3970,7 @@ static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
 }
 
 static void vxlan_config_apply(struct net_device *dev,
-			       struct vxlan_config *conf,
+			       struct vxlan_config *new_cfg,
 			       struct net_device *lowerdev,
 			       struct net *src_net,
 			       bool changelink)
@@ -3913,8 +3978,9 @@ static void vxlan_config_apply(struct net_device *dev,
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	unsigned short needed_headroom = ETH_HLEN;
+	struct vxlan_config *old_cfg;
 	int max_mtu = ETH_MAX_MTU;
-	u32 flags = conf->flags;
+	u32 flags = new_cfg->flags;
 
 	if (!changelink) {
 		if (flags & VXLAN_F_GPE)
@@ -3922,18 +3988,18 @@ static void vxlan_config_apply(struct net_device *dev,
 		else
 			vxlan_ether_setup(dev);
 
-		if (conf->mtu)
-			dev->mtu = conf->mtu;
+		if (new_cfg->mtu)
+			dev->mtu = new_cfg->mtu;
 
 		vxlan->net = src_net;
 	}
 
-	dst->remote_vni = conf->vni;
+	dst->remote_vni = new_cfg->vni;
 
-	memcpy(&dst->remote_ip, &conf->remote_ip, sizeof(conf->remote_ip));
+	memcpy(&dst->remote_ip, &new_cfg->remote_ip, sizeof(new_cfg->remote_ip));
 
 	if (lowerdev) {
-		dst->remote_ifindex = conf->remote_ifindex;
+		dst->remote_ifindex = new_cfg->remote_ifindex;
 
 		netif_inherit_tso_max(dev, lowerdev);
 
@@ -3946,7 +4012,7 @@ static void vxlan_config_apply(struct net_device *dev,
 		if (max_mtu < ETH_MIN_MTU)
 			max_mtu = ETH_MIN_MTU;
 
-		if (!changelink && !conf->mtu)
+		if (!changelink && !new_cfg->mtu)
 			dev->mtu = max_mtu;
 	}
 
@@ -3958,7 +4024,10 @@ static void vxlan_config_apply(struct net_device *dev,
 	needed_headroom += vxlan_headroom(flags);
 	dev->needed_headroom = needed_headroom;
 
-	memcpy(&vxlan->cfg, conf, sizeof(*conf));
+	old_cfg = rtnl_dereference(vxlan->cfg);
+	rcu_assign_pointer(vxlan->cfg, new_cfg);
+	if (old_cfg)
+		kfree_rcu(old_cfg, rcu);
 }
 
 static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
@@ -3967,13 +4036,18 @@ static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct net_device *lowerdev;
+	struct vxlan_config *new_cfg;
 	int ret;
 
 	ret = vxlan_config_validate(src_net, conf, &lowerdev, vxlan, extack);
 	if (ret)
 		return ret;
 
-	vxlan_config_apply(dev, conf, lowerdev, src_net, false);
+	new_cfg = kmemdup(conf, sizeof(*conf), GFP_KERNEL);
+	if (!new_cfg)
+		return -ENOMEM;
+
+	vxlan_config_apply(dev, new_cfg, lowerdev, src_net, false);
 
 	return 0;
 }
@@ -3985,6 +4059,7 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct net_device *remote_dev = NULL;
+	const struct vxlan_config *cfg;
 	struct vxlan_rdst *dst;
 	int err;
 
@@ -3993,6 +4068,8 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 	if (err)
 		return err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+
 	dev->ethtool_ops = &vxlan_ethtool_ops;
 
 	err = register_netdevice(dev);
@@ -4024,7 +4101,7 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 				       &dst->remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_EXCL | NLM_F_CREATE,
-				       vxlan->cfg.dst_port,
+				       cfg->dst_port,
 				       dst->remote_vni,
 				       dst->remote_vni,
 				       dst->remote_ifindex,
@@ -4088,8 +4165,12 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 	memset(conf, 0, sizeof(*conf));
 
 	/* if changelink operation, start with old existing cfg */
-	if (changelink)
-		memcpy(conf, &vxlan->cfg, sizeof(*conf));
+	if (changelink) {
+		const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
+
+		if (cfg)
+			memcpy(conf, cfg, sizeof(*conf));
+	}
 
 	if (data[IFLA_VXLAN_ID]) {
 		__be32 vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
@@ -4436,9 +4517,11 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	bool rem_ip_changed, change_igmp;
 	struct net_device *lowerdev;
 	struct vxlan_config conf;
+	struct vxlan_config *new_cfg;
 	struct vxlan_rdst *dst;
 	int err;
 
@@ -4452,13 +4535,19 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	new_cfg = kmemdup(&conf, sizeof(conf), GFP_KERNEL);
+	if (!new_cfg)
+		return -ENOMEM;
+
 	if (dst->remote_dev == lowerdev)
 		lowerdev = NULL;
 
 	err = netdev_adjacent_change_prepare(dst->remote_dev, lowerdev, dev,
 					     extack);
-	if (err)
+	if (err) {
+		kfree(new_cfg);
 		return err;
+	}
 
 	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
 	change_igmp = vxlan->dev->flags & IFF_UP &&
@@ -4473,7 +4562,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					       &conf.remote_ip,
 					       NUD_REACHABLE | NUD_PERMANENT,
 					       NLM_F_APPEND | NLM_F_CREATE,
-					       vxlan->cfg.dst_port,
+					       cfg->dst_port,
 					       conf.vni, conf.vni,
 					       conf.remote_ifindex,
 					       NTF_SELF, 0, true, extack);
@@ -4481,13 +4570,14 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 				spin_unlock_bh(&vxlan->hash_lock);
 				netdev_adjacent_change_abort(dst->remote_dev,
 							     lowerdev, dev);
+				kfree(new_cfg);
 				return err;
 			}
 		}
 		if (!vxlan_addr_any(&dst->remote_ip))
 			__vxlan_fdb_delete(vxlan, all_zeros_mac,
 					   dst->remote_ip,
-					   vxlan->cfg.dst_port,
+					   cfg->dst_port,
 					   dst->remote_vni,
 					   dst->remote_vni,
 					   dst->remote_ifindex,
@@ -4497,12 +4587,13 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 		/* If vni filtering device, also update fdb entries of
 		 * all vnis that were using default remote ip
 		 */
-		if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+		if (cfg->flags & VXLAN_F_VNIFILTER) {
 			err = vxlan_vnilist_update_group(vxlan, &dst->remote_ip,
 							 &conf.remote_ip, extack);
 			if (err) {
 				netdev_adjacent_change_abort(dst->remote_dev,
 							     lowerdev, dev);
+				kfree(new_cfg);
 				return err;
 			}
 		}
@@ -4511,13 +4602,13 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
 		err = vxlan_multicast_leave(vxlan);
 
-	if (conf.age_interval != vxlan->cfg.age_interval)
+	if (conf.age_interval != cfg->age_interval)
 		mod_timer(&vxlan->age_timer, jiffies);
 
 	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
 	if (lowerdev && lowerdev != dst->remote_dev)
 		dst->remote_dev = lowerdev;
-	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
+	vxlan_config_apply(dev, new_cfg, lowerdev, vxlan->net, true);
 
 	if (!err && change_igmp &&
 	    vxlan_addr_multicast(&dst->remote_ip))
@@ -4580,11 +4671,16 @@ static size_t vxlan_get_size(const struct net_device *dev)
 static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	const struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct ifla_vxlan_port_range ports = {
-		.low =  htons(vxlan->cfg.port_min),
-		.high = htons(vxlan->cfg.port_max),
-	};
+	struct ifla_vxlan_port_range ports;
+	const struct vxlan_config *cfg;
+	const struct vxlan_rdst *dst;
+
+	dst = &vxlan->default_dst;
+
+	cfg = rtnl_dereference(vxlan->cfg);
+
+	ports.low = htons(cfg->port_min);
+	ports.high = htons(cfg->port_max);
 
 	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(dst->remote_vni)))
 		goto nla_put_failure;
@@ -4606,79 +4702,79 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (dst->remote_ifindex && nla_put_u32(skb, IFLA_VXLAN_LINK, dst->remote_ifindex))
 		goto nla_put_failure;
 
-	if (!vxlan_addr_any(&vxlan->cfg.saddr)) {
-		if (vxlan->cfg.saddr.sa.sa_family == AF_INET) {
+	if (!vxlan_addr_any(&cfg->saddr)) {
+		if (cfg->saddr.sa.sa_family == AF_INET) {
 			if (nla_put_in_addr(skb, IFLA_VXLAN_LOCAL,
-					    vxlan->cfg.saddr.sin.sin_addr.s_addr))
+					    cfg->saddr.sin.sin_addr.s_addr))
 				goto nla_put_failure;
 #if IS_ENABLED(CONFIG_IPV6)
 		} else {
 			if (nla_put_in6_addr(skb, IFLA_VXLAN_LOCAL6,
-					     &vxlan->cfg.saddr.sin6.sin6_addr))
+					     &cfg->saddr.sin6.sin6_addr))
 				goto nla_put_failure;
 #endif
 		}
 	}
 
-	if (nla_put_u8(skb, IFLA_VXLAN_TTL, vxlan->cfg.ttl) ||
+	if (nla_put_u8(skb, IFLA_VXLAN_TTL, cfg->ttl) ||
 	    nla_put_u8(skb, IFLA_VXLAN_TTL_INHERIT,
-		       !!(vxlan->cfg.flags & VXLAN_F_TTL_INHERIT)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
-	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
-	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
-	    nla_put_u32(skb, IFLA_VXLAN_LABEL_POLICY, vxlan->cfg.label_policy) ||
+		       !!(cfg->flags & VXLAN_F_TTL_INHERIT)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_TOS, cfg->tos) ||
+	    nla_put_u8(skb, IFLA_VXLAN_DF, cfg->df) ||
+	    nla_put_be32(skb, IFLA_VXLAN_LABEL, cfg->label) ||
+	    nla_put_u32(skb, IFLA_VXLAN_LABEL_POLICY, cfg->label_policy) ||
 	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
-		       !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
+		       !!(cfg->flags & VXLAN_F_LEARN)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_PROXY,
-		       !!(vxlan->cfg.flags & VXLAN_F_PROXY)) ||
+		       !!(cfg->flags & VXLAN_F_PROXY)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_RSC,
-		       !!(vxlan->cfg.flags & VXLAN_F_RSC)) ||
+		       !!(cfg->flags & VXLAN_F_RSC)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_L2MISS,
-		       !!(vxlan->cfg.flags & VXLAN_F_L2MISS)) ||
+		       !!(cfg->flags & VXLAN_F_L2MISS)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_L3MISS,
-		       !!(vxlan->cfg.flags & VXLAN_F_L3MISS)) ||
+		       !!(cfg->flags & VXLAN_F_L3MISS)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_COLLECT_METADATA,
-		       !!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)) ||
-	    nla_put_u32(skb, IFLA_VXLAN_AGEING, vxlan->cfg.age_interval) ||
-	    nla_put_u32(skb, IFLA_VXLAN_LIMIT, vxlan->cfg.addrmax) ||
-	    nla_put_be16(skb, IFLA_VXLAN_PORT, vxlan->cfg.dst_port) ||
+		       !!(cfg->flags & VXLAN_F_COLLECT_METADATA)) ||
+	    nla_put_u32(skb, IFLA_VXLAN_AGEING, cfg->age_interval) ||
+	    nla_put_u32(skb, IFLA_VXLAN_LIMIT, cfg->addrmax) ||
+	    nla_put_be16(skb, IFLA_VXLAN_PORT, cfg->dst_port) ||
 	    nla_put_u8(skb, IFLA_VXLAN_UDP_CSUM,
-		       !(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM_TX)) ||
+		       !(cfg->flags & VXLAN_F_UDP_ZERO_CSUM_TX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_TX,
-		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_TX)) ||
+		       !!(cfg->flags & VXLAN_F_UDP_ZERO_CSUM6_TX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_RX,
-		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_RX)) ||
+		       !!(cfg->flags & VXLAN_F_UDP_ZERO_CSUM6_RX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_TX,
-		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_TX)) ||
+		       !!(cfg->flags & VXLAN_F_REMCSUM_TX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
-		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)) ||
+		       !!(cfg->flags & VXLAN_F_REMCSUM_RX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_LOCALBYPASS,
-		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)))
+		       !!(cfg->flags & VXLAN_F_LOCALBYPASS)))
 		goto nla_put_failure;
 
 	if (nla_put(skb, IFLA_VXLAN_PORT_RANGE, sizeof(ports), &ports))
 		goto nla_put_failure;
 
-	if (vxlan->cfg.flags & VXLAN_F_GBP &&
+	if (cfg->flags & VXLAN_F_GBP &&
 	    nla_put_flag(skb, IFLA_VXLAN_GBP))
 		goto nla_put_failure;
 
-	if (vxlan->cfg.flags & VXLAN_F_GPE &&
+	if (cfg->flags & VXLAN_F_GPE &&
 	    nla_put_flag(skb, IFLA_VXLAN_GPE))
 		goto nla_put_failure;
 
-	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_NOPARTIAL &&
+	if (cfg->flags & VXLAN_F_REMCSUM_NOPARTIAL &&
 	    nla_put_flag(skb, IFLA_VXLAN_REMCSUM_NOPARTIAL))
 		goto nla_put_failure;
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER &&
+	if (cfg->flags & VXLAN_F_VNIFILTER &&
 	    nla_put_u8(skb, IFLA_VXLAN_VNIFILTER,
-		       !!(vxlan->cfg.flags & VXLAN_F_VNIFILTER)))
+		       !!(cfg->flags & VXLAN_F_VNIFILTER)))
 		goto nla_put_failure;
 
 	if (nla_put(skb, IFLA_VXLAN_RESERVED_BITS,
-		    sizeof(vxlan->cfg.reserved_bits),
-		    &vxlan->cfg.reserved_bits))
+		    sizeof(cfg->reserved_bits),
+		    &cfg->reserved_bits))
 		goto nla_put_failure;
 
 	return 0;
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index c92217906d5ee90c92f3da50ca9a276793ed9aca..eb15bb052a6a874a61c9a3306e1132cca3a98fdf 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -164,7 +164,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 				     const struct vxlan_mdb_entry *mdb_entry,
 				     const struct vxlan_mdb_remote *remote)
 {
-	const struct vxlan_config *cfg = &vxlan->cfg;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	struct br_mdb_entry e;
 	struct nlattr *nest;
@@ -605,7 +605,9 @@ static int vxlan_mdb_config_init(struct vxlan_mdb_config *cfg,
 {
 	struct br_mdb_entry *entry = nla_data(tb[MDBA_SET_ENTRY]);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct vxlan_config *vcfg = &vxlan->cfg;
+	const struct vxlan_config *vcfg;
+
+	vcfg = rtnl_dereference(vxlan->cfg);
 
 	memset(cfg, 0, sizeof(*cfg));
 	cfg->vxlan = vxlan;
@@ -940,12 +942,12 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 			    const struct vxlan_mdb_entry *mdb_entry,
 			    const struct vxlan_mdb_remote *remote)
 {
-	const struct vxlan_config *cfg = &vxlan->cfg;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	const struct vxlan_mdb_entry_key *group = &mdb_entry->key;
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	size_t nlmsg_size;
 
-		     /* MDBA_MDB_ENTRY_INFO */
+	/* MDBA_MDB_ENTRY_INFO */
 	nlmsg_size = nla_total_size(sizeof(struct br_mdb_entry)) +
 		     /* MDBA_MDB_EATTR_TIMER */
 		     nla_total_size(sizeof(u32));
@@ -1205,7 +1207,7 @@ vxlan_mdb_entry_get(struct vxlan_dev *vxlan,
 		goto err_free_entry;
 
 	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
-		vxlan->cfg.flags |= VXLAN_F_MDB;
+		rtnl_dereference(vxlan->cfg)->flags |= VXLAN_F_MDB;
 
 	return mdb_entry;
 
@@ -1222,7 +1224,7 @@ static void vxlan_mdb_entry_put(struct vxlan_dev *vxlan,
 		return;
 
 	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
-		vxlan->cfg.flags &= ~VXLAN_F_MDB;
+		rtnl_dereference(vxlan->cfg)->flags &= ~VXLAN_F_MDB;
 
 	rhashtable_remove_fast(&vxlan->mdb_tbl, &mdb_entry->rhnode,
 			       vxlan_mdb_rht_params);
@@ -1610,7 +1612,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 						struct sk_buff *skb,
 						__be32 src_vni)
 {
-	const struct vxlan_config *cfg = &vxlan->cfg;
+	const struct vxlan_config *cfg;
 	struct vxlan_mdb_entry *mdb_entry;
 	struct vxlan_mdb_entry_key group;
 
@@ -1618,6 +1620,10 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 	    is_broadcast_ether_addr(eth_hdr(skb)->h_dest))
 		return NULL;
 
+	cfg = rcu_dereference(vxlan->cfg);
+	if (!cfg)
+		return NULL;
+
 	/* When not in collect metadata mode, 'src_vni' is zero, but MDB
 	 * entries are stored with the VNI of the VXLAN device.
 	 */
@@ -1691,8 +1697,11 @@ netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
 			   struct sk_buff *skb)
 {
 	struct vxlan_mdb_remote *remote, *fremote = NULL;
+	const struct vxlan_config *cfg;
 	__be32 src_vni = mdb_entry->key.vni;
 
+	cfg = rcu_dereference(vxlan->cfg);
+
 	list_for_each_entry_rcu(remote, &mdb_entry->remotes, list) {
 		struct sk_buff *skb1;
 
@@ -1708,12 +1717,12 @@ netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
 
 		skb1 = skb_clone(skb, GFP_ATOMIC);
 		if (skb1)
-			vxlan_xmit_one(skb1, vxlan->dev, &vxlan->cfg, src_vni,
+			vxlan_xmit_one(skb1, vxlan->dev, cfg, src_vni,
 				       rcu_dereference(remote->rd), false);
 	}
 
 	if (fremote)
-		vxlan_xmit_one(skb, vxlan->dev, &vxlan->cfg, src_vni,
+		vxlan_xmit_one(skb, vxlan->dev, cfg, src_vni,
 			       rcu_dereference(fremote->rd), false);
 	else
 		kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
@@ -1744,7 +1753,7 @@ void vxlan_mdb_fini(struct vxlan_dev *vxlan)
 	struct vxlan_mdb_flush_desc desc = {};
 
 	vxlan_mdb_flush(vxlan, &desc);
-	WARN_ON_ONCE(vxlan->cfg.flags & VXLAN_F_MDB);
+	WARN_ON_ONCE(rtnl_dereference(vxlan->cfg)->flags & VXLAN_F_MDB);
 	rhashtable_free_and_destroy(&vxlan->mdb_tbl, vxlan_mdb_check_empty,
 				    NULL);
 }
diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
index 3b75b48dc726df40cebb233095a8a046ee274c30..e2cf10da274f1b608d8bb5020d2b87ebfedeff46 100644
--- a/drivers/net/vxlan/vxlan_multicast.c
+++ b/drivers/net/vxlan/vxlan_multicast.c
@@ -147,6 +147,8 @@ bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
 #endif
 
 	list_for_each_entry(vxlan, &vn->vxlan_list, next) {
+		const struct vxlan_config *cfg;
+
 		if (!netif_running(vxlan->dev) || vxlan == dev)
 			continue;
 
@@ -158,7 +160,9 @@ bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
 		    rtnl_dereference(vxlan->vn6_sock) != sock6)
 			continue;
 #endif
-		if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+		cfg = rtnl_dereference(vxlan->cfg);
+
+		if (cfg->flags & VXLAN_F_VNIFILTER) {
 			if (!vxlan_group_used_by_vnifilter(vxlan, ip, ifindex))
 				continue;
 		} else {
@@ -233,6 +237,7 @@ static int vxlan_multicast_leave_vnigrp(struct vxlan_dev *vxlan)
 
 int vxlan_multicast_join(struct vxlan_dev *vxlan)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	int ret = 0;
 
 	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip)) {
@@ -244,7 +249,7 @@ int vxlan_multicast_join(struct vxlan_dev *vxlan)
 			return ret;
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg->flags & VXLAN_F_VNIFILTER)
 		return vxlan_multicast_join_vnigrp(vxlan);
 
 	return 0;
@@ -252,6 +257,7 @@ int vxlan_multicast_join(struct vxlan_dev *vxlan)
 
 int vxlan_multicast_leave(struct vxlan_dev *vxlan)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
 	int ret = 0;
 
@@ -263,7 +269,7 @@ int vxlan_multicast_leave(struct vxlan_dev *vxlan)
 			return ret;
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg->flags & VXLAN_F_VNIFILTER)
 		return vxlan_multicast_leave_vnigrp(vxlan);
 
 	return 0;
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 3674dec5a59ae4cdb94319c8789826fbb9f0104c..f3dda671b4e45677944fd1f2db2afc453061e3a5 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -178,7 +178,7 @@ void vxlan_vnifilter_count(struct vxlan_dev *vxlan,
 {
 	struct vxlan_vni_node *vnode;
 
-	if (!cfg || !(cfg->flags & VXLAN_F_VNIFILTER))
+	if (!(cfg->flags & VXLAN_F_VNIFILTER))
 		return;
 
 	if (vninode) {
@@ -337,13 +337,15 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 	struct vxlan_vni_node *tmp, *v, *vbegin = NULL, *vend = NULL;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct tunnel_msg *new_tmsg, *tmsg;
+	const struct vxlan_config *cfg;
 	int idx = 0, s_idx = cb->args[1];
 	struct vxlan_vni_group *vg;
 	struct nlmsghdr *nlh;
 	bool dump_stats;
 	int err = 0;
 
-	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
+	cfg = rcu_dereference(vxlan->cfg);
+	if (!(cfg->flags & VXLAN_F_VNIFILTER))
 		return -EINVAL;
 
 	/* RCU needed because of the vni locking rules (rcu || rtnl) */
@@ -478,6 +480,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 					  union vxlan_addr *remote_ip,
 					  struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	int err = 0;
 
@@ -487,7 +490,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				       remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_APPEND | NLM_F_CREATE,
-				       vxlan->cfg.dst_port,
+				       cfg->dst_port,
 				       vni,
 				       vni,
 				       dst->remote_ifindex,
@@ -501,7 +504,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 	if (old_remote_ip && !vxlan_addr_any(old_remote_ip)) {
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   *old_remote_ip,
-				   vxlan->cfg.dst_port,
+				   cfg->dst_port,
 				   vni, vni,
 				   dst->remote_ifindex,
 				   true);
@@ -615,6 +618,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 				   struct vxlan_vni_node *vninode)
 {
 	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 
 	/* if per vni remote_ip not present, delete the
@@ -626,7 +630,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   (vxlan_addr_any(&vninode->remote_ip) ?
 				   dst->remote_ip : vninode->remote_ip),
-				   vxlan->cfg.dst_port,
+				   cfg->dst_port,
 				   vninode->vni, vninode->vni,
 				   dst->remote_ifindex,
 				   true);
@@ -726,6 +730,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 			 u32 vni, union vxlan_addr *group,
 			 struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_vni_node *vninode;
 	__be32 v = cpu_to_be32(vni);
 	bool changed = false;
@@ -734,7 +739,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 	if (vxlan_vnifilter_lookup(vxlan, v))
 		return vxlan_vni_update(vxlan, vg, v, group, &changed, extack);
 
-	err = vxlan_vni_in_use(vxlan->net, vxlan, &vxlan->cfg, v);
+	err = vxlan_vni_in_use(vxlan->net, vxlan, cfg, v);
 	if (err) {
 		NL_SET_ERR_MSG(extack, "VNI in use");
 		return err;
@@ -943,6 +948,7 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 				   struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
+	const struct vxlan_config *cfg;
 	struct tunnel_msg *tmsg;
 	struct vxlan_dev *vxlan;
 	struct net_device *dev;
@@ -967,8 +973,9 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	vxlan = netdev_priv(dev);
+	cfg = rtnl_dereference(vxlan->cfg);
 
-	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
+	if (!(cfg->flags & VXLAN_F_VNIFILTER))
 		return -EOPNOTSUPP;
 
 	nlmsg_for_each_attr_type(attr, VXLAN_VNIFILTER_ENTRY, nlh,
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index dfba89695efcfa46cbc56f005763e1086ce67b23..7321768b0f2c1e81467d90153c422ee576aaefa9 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -229,6 +229,7 @@ struct vxlan_config {
 	bool				no_share;
 	enum ifla_vxlan_df		df;
 	struct vxlanhdr			reserved_bits;
+	struct rcu_head			rcu;
 };
 
 enum {
@@ -301,7 +302,7 @@ struct vxlan_dev {
 	unsigned int	  addrcnt;
 	struct gro_cells  gro_cells;
 
-	struct vxlan_config	cfg;
+	struct vxlan_config __rcu	*cfg;
 
 	struct vxlan_vni_group  __rcu *vnigrp;
 
diff --git a/net/openvswitch/vport-vxlan.c b/net/openvswitch/vport-vxlan.c
index b0a084864a858453715d8e51b3e95cc7b2d9370f..9b1101f6ce1e1ceee3032ce94b0886846e6e1f84 100644
--- a/net/openvswitch/vport-vxlan.c
+++ b/net/openvswitch/vport-vxlan.c
@@ -22,27 +22,40 @@ static struct vport_ops ovs_vxlan_netdev_vport_ops;
 static int vxlan_get_options(const struct vport *vport, struct sk_buff *skb)
 {
 	struct vxlan_dev *vxlan = netdev_priv(vport->dev);
-	const struct vxlan_config *cfg = &vxlan->cfg;
-	__be16 dst_port = cfg->dst_port;
+	const struct vxlan_config *cfg;
+	__be16 dst_port;
+	int err = 0;
 
-	if (nla_put_u16(skb, OVS_TUNNEL_ATTR_DST_PORT, ntohs(dst_port)))
-		return -EMSGSIZE;
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
+	dst_port = cfg->dst_port;
+
+	if (nla_put_u16(skb, OVS_TUNNEL_ATTR_DST_PORT, ntohs(dst_port))) {
+		err = -EMSGSIZE;
+		goto out;
+	}
 
 	if (cfg->flags & VXLAN_F_GBP) {
 		struct nlattr *exts;
 
 		exts = nla_nest_start_noflag(skb, OVS_TUNNEL_ATTR_EXTENSION);
-		if (!exts)
-			return -EMSGSIZE;
+		if (!exts) {
+			err = -EMSGSIZE;
+			goto out;
+		}
 
 		if (cfg->flags & VXLAN_F_GBP &&
-		    nla_put_flag(skb, OVS_VXLAN_EXT_GBP))
-			return -EMSGSIZE;
+		    nla_put_flag(skb, OVS_VXLAN_EXT_GBP)) {
+			err = -EMSGSIZE;
+			goto out;
+		}
 
 		nla_nest_end(skb, exts);
 	}
 
-	return 0;
+out:
+	rcu_read_unlock();
+	return err;
 }
 
 static const struct nla_policy exts_policy[OVS_VXLAN_EXT_MAX + 1] = {
-- 
2.55.0.795.g602f6c329a-goog


