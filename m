Return-Path: <netdev+bounces-175053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C68BA62C3B
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 13:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E103F189CC85
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 12:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C95117BED0;
	Sat, 15 Mar 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U39fyKue"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9682E337A
	for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742040280; cv=none; b=eR41epvGDt4mTwt2GNz+l4L0K+sMnG71JGo19hl2pAo1lWKMwjVjjk8PSpJG/Dm/2JG7zGmWi9oh/TW1eH++Jp2xGjQsPAMazE+r31oBe0WVz2sdzUq4eKxARpJ9G85bC9CGx8zt8n+aumOIIux2Dsnvgojm7dAAptJBNQuk/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742040280; c=relaxed/simple;
	bh=Q6YX4RfHkj91q3Dip9aHj/as/+GLl3Xew2ywTJYh+2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ou2ysjzqNgX15h6QbrZ7pZP5pkknzKAobCnz6yRUw9FAkb10MTEOCAup71PToQyzVYQigZhhjyYVmkx6qg5BFzHUsAeWQomaly+HQH3ebfrmA+2U0qshYJesG+jNtv0nQXkPSPxkgg2MuJXw9mv/wacwvPo1T/dw5CdtQRa4QOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U39fyKue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD87C4CEE5;
	Sat, 15 Mar 2025 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742040279;
	bh=Q6YX4RfHkj91q3Dip9aHj/as/+GLl3Xew2ywTJYh+2A=;
	h=From:Date:Subject:To:Cc:From;
	b=U39fyKuekTfBHLvZY24aOSCyeQBGiZlnNB0yhKBqhK/PZg1FwzzK3/gOIK7k6EEXM
	 jiHLpxXlNiBkdp4cPKN/UuWx5BlDzPDym9AYNtarwk+Xs4lfpQyQqBXYrfIVC0a+Bs
	 7wdNYsivLfpX6re+1ENOgIfPa1EkIiBEQvErmQ+segZ7d9cgn4Pu/l7yVea4YvgIjt
	 /d5ye/imNkEakUsvVdSwSxJjI4yE8PAGAC5jtvCz7tdl/CfwQI4PUWp3jaUhOrxd8a
	 n5lnldPbDq7ktVT3yIsxaPQngVPdgupypDUkh1H0UNwKecoqpTcKFkEtrTT/5s0JJx
	 3ypYJbDdoDJtg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 15 Mar 2025 13:04:20 +0100
Subject: [PATCH net-next v2] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-airoha-flowtable-null-ptr-fix-v2-1-94b923d30234@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMRs1WcC/42NQQ6CMBAAv0L27BpaoCGe/IfhsMgCjU1Ltoga0
 r9beYHHmcPMDpHFcoRLsYPwZqMNPoM+FXCfyU+MdsgMutRNWSmNZCXMhKMLr5V6x+ifzuGyCo7
 2jVSbxgxKN7UhyI1FOOujf+syzzauQT7HblM/+295U6jQVKYaqW/beiivDxbP7hxkgi6l9AW/J
 0jlywAAAA==
X-Change-ID: 20250312-airoha-flowtable-null-ptr-fix-a4656d12546a
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

The system occasionally crashes dereferencing a NULL pointer when it is
forwarding constant, high load bidirectional traffic.

[ 2149.913414] Unable to handle kernel read from unreadable memory at virtual address 0000000000000000
[ 2149.925812] Mem abort info:
[ 2149.928713]   ESR = 0x0000000096000005
[ 2149.932762]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 2149.938429]   SET = 0, FnV = 0
[ 2149.941814]   EA = 0, S1PTW = 0
[ 2149.945187]   FSC = 0x05: level 1 translation fault
[ 2149.950348] Data abort info:
[ 2149.953472]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[ 2149.959243]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 2149.964593]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 2149.970243] user pgtable: 4k pages, 39-bit VAs, pgdp=000000008b507000
[ 2149.977068] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[ 2149.986062] Internal error: Oops: 0000000096000005 [#1] SMP
[ 2150.082282]  arht_wrapper(O) i2c_core arht_hook(O) crc32_generic
[ 2150.177623] CPU: 0 PID: 38 Comm: kworker/u9:1 Tainted: G           O       6.6.73 #0
[ 2150.185362] Hardware name: Airoha AN7581 Evaluation Board (DT)
[ 2150.191189] Workqueue: nf_ft_offload_add nf_flow_rule_route_ipv6 [nf_flow_table]
[ 2150.198653] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2150.205615] pc : airoha_ppe_flow_offload_replace.isra.0+0x6dc/0xc54
[ 2150.211882] lr : airoha_ppe_flow_offload_replace.isra.0+0x6cc/0xc54
[ 2150.218149] sp : ffffffc080e8ba10
[ 2150.221456] x29: ffffffc080e8bae0 x28: ffffff80080b0000 x27: 0000000000000000
[ 2150.228591] x26: ffffff8001c70020 x25: 0000000000000002 x24: 0000000000000000
[ 2150.235727] x23: 0000000061000000 x22: 00000000ffffffed x21: ffffffc080e8bbb0
[ 2150.242862] x20: ffffff8001c70000 x19: 0000000000000008 x18: 0000000000000000
[ 2150.249998] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[ 2150.257133] x14: 0000000000000001 x13: 0000000000000008 x12: 0101010101010101
[ 2150.264268] x11: 7f7f7f7f7f7f7f7f x10: 0000000000000041 x9 : 0000000000000000
[ 2150.271404] x8 : ffffffc080e8bad8 x7 : 0000000000000000 x6 : 0000000000000015
[ 2150.278540] x5 : ffffffc080e8ba4e x4 : 0000000000000004 x3 : 0000000000000000
[ 2150.285675] x2 : 0000000000000008 x1 : 00000000080b0000 x0 : 0000000000000000
[ 2150.292811] Call trace:
[ 2150.295250]  airoha_ppe_flow_offload_replace.isra.0+0x6dc/0xc54
[ 2150.301171]  airoha_ppe_setup_tc_block_cb+0x7c/0x8b4
[ 2150.306135]  nf_flow_offload_ip_hook+0x710/0x874 [nf_flow_table]
[ 2150.312168]  nf_flow_rule_route_ipv6+0x53c/0x580 [nf_flow_table]
[ 2150.318200]  process_one_work+0x178/0x2f0
[ 2150.322211]  worker_thread+0x2e4/0x4cc
[ 2150.325953]  kthread+0xd8/0xdc
[ 2150.329008]  ret_from_fork+0x10/0x20
[ 2150.332589] Code: b9007bf7 b4001e9c f9448380 b9491381 (f9400000)
[ 2150.338681] ---[ end trace 0000000000000000 ]---
[ 2150.343298] Kernel panic - not syncing: Oops: Fatal exception
[ 2150.349035] SMP: stopping secondary CPUs
[ 2150.352954] Kernel Offset: disabled
[ 2150.356438] CPU features: 0x0,00000000,00000000,1000400b
[ 2150.361743] Memory Limit: none

Fix the issue validating egress gdm port in airoha_ppe_foe_entry_prepare
routine.

Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Avoid checking netdev_priv pointer since it is always not NULL
- Link to v1: https://lore.kernel.org/r/20250312-airoha-flowtable-null-ptr-fix-v1-1-6363fab884d0@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 13 +++++++++++++
 drivers/net/ethernet/airoha/airoha_eth.h |  3 +++
 drivers/net/ethernet/airoha/airoha_ppe.c | 10 ++++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c0a642568ac115ea9df6fbaf7133627a4405a36c..bf9c882e9c8b087dbf5e907636547a0117d1b96a 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2454,6 +2454,19 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
 	}
 }
 
+int airoha_is_valid_gdm_port(struct airoha_eth *eth,
+			     struct airoha_gdm_port *port)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		if (eth->ports[i] == port)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 				 struct device_node *np, int index)
 {
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index f66b9b736b9447b31afc036eb906d0a1c617e132..c7d4f124d11481cd31c1566936cd47e3446877c0 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -532,6 +532,9 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
+int airoha_is_valid_gdm_port(struct airoha_eth *eth,
+			     struct airoha_gdm_port *port);
+
 void airoha_ppe_check_skb(struct airoha_ppe *ppe, u16 hash);
 int airoha_ppe_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 				 void *cb_priv);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 8b55e871352d359fa692c253d3f3315c619472b3..65833e2058194a64569eafec08b80df8190bba6c 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -197,7 +197,8 @@ static int airoha_get_dsa_port(struct net_device **dev)
 #endif
 }
 
-static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
+static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
+					struct airoha_foe_entry *hwe,
 					struct net_device *dev, int type,
 					struct airoha_flow_data *data,
 					int l4proto)
@@ -224,6 +225,11 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
 	if (dev) {
 		struct airoha_gdm_port *port = netdev_priv(dev);
 		u8 pse_port;
+		int err;
+
+		err = airoha_is_valid_gdm_port(eth, port);
+		if (err)
+			return err;
 
 		if (dsa_port >= 0)
 			pse_port = port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
@@ -633,7 +639,7 @@ static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
 	    !is_valid_ether_addr(data.eth.h_dest))
 		return -EINVAL;
 
-	err = airoha_ppe_foe_entry_prepare(&hwe, odev, offload_type,
+	err = airoha_ppe_foe_entry_prepare(eth, &hwe, odev, offload_type,
 					   &data, l4proto);
 	if (err)
 		return err;

---
base-commit: bfc6c67ec2d64d0ca4e5cc3e1ac84298a10b8d62
change-id: 20250312-airoha-flowtable-null-ptr-fix-a4656d12546a

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


