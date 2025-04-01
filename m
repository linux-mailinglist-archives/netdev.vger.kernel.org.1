Return-Path: <netdev+bounces-178540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE0BA777FB
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56B13A9979
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8971EEA37;
	Tue,  1 Apr 2025 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UriSNX2w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81F1EE7C6
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500568; cv=none; b=qILTK9JQlg7BxPEGu9BYRmfHRb8rRH7f3nXLniQECuWVOfjNLDdjuevSTjZP4bYoRN4lRW3gaR93UhaUBOBHlXqOQ7riqCniwkLEk5Ix2mjroQedb6LZfymaEW13gGryKHq+sEFoA9gLaNHFou622urjBF4c6LmV4apUJ7oQXxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500568; c=relaxed/simple;
	bh=Tg3tXMHJf2C+qh4933Cv7caaqlu4tWE4+ox/5ISh5pA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s7DWQZTdVVVLB9L6nXFNi7QtKuBGbV0XyjZhPiBuTyD9ic/NVcrh+Hg6wQFjQryvt45KaIWG6WtinKQJhUD/M4YkmOOQj6U5QVe6aB0qe67pP63ZOnYYZ0r2iNS6kCPdOYK5r08bpOacYywENzA9xoE3E1nDMt2fWxnSUmOyDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UriSNX2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069CFC4CEE4;
	Tue,  1 Apr 2025 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743500568;
	bh=Tg3tXMHJf2C+qh4933Cv7caaqlu4tWE4+ox/5ISh5pA=;
	h=From:Date:Subject:To:Cc:From;
	b=UriSNX2wpuXYZx7VT/c9Z8eibqdIg6QdUTcwrJJu7clqwp16r6uArXVZWx5Cg7yWT
	 2OtbHnRPB2qbUyZx/4R0HbOf6CYB8eHJyQuh07YbbdZtRjc634oKwgotGKMbSWwG0a
	 84tcm4s0aegCOe3UtfBqJslPloIHbGK10v0ZxZA475MuapMku8EWWKsobjFNHY0hHZ
	 gCvEgud8mKPu80H+xEO76p+ICRYwIHmLunzF5Fs8gR3tXCT81BYRr3UQ8U/GD0Fznb
	 wgsB49XeRm9ArhapHZXO71VsAFlOPOG4VIYLmj2+nIEZLOkVdmwSthalkbc3L3VsA+
	 UMHMEqohUW0VA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 01 Apr 2025 11:42:30 +0200
Subject: [PATCH net v4] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-airoha-validate-egress-gdm-port-v4-1-c7315d33ce10@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAW162cC/42NQQ6CMBAAv0J6dg2wCOLJfxgOa1nLRqRkSxoN4
 e9WXuBx5jCzmsAqHMwlW41ylCB+SlAdMmMHmhyD9IlNmZenHLEAEvUDQaRReloY2CmHAK5/wex
 1AcTanpu2rXNLJlVm5Ye898OtSzxIWLx+9mHEn/2/HREKsEXF9Z3aBpGuT9aJx6NXZ7pt276DG
 7UnzwAAAA==
X-Change-ID: 20250331-airoha-validate-egress-gdm-port-336c879960ca
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Dev pointer in airoha_ppe_foe_entry_prepare routine is not strictly
a device allocated by airoha_eth driver since it is an egress device
and the flowtable can contain even wlan, pppoe or vlan devices. E.g:

flowtable ft {
        hook ingress priority filter
        devices = { eth1, lan1, lan2, lan3, lan4, wlan0 }
        flags offload                               ^
                                                    |
                     "not allocated by airoha_eth" --
}

In this case airoha_get_dsa_port() will just return the original device
pointer and we can't assume netdev priv pointer points to an
airoha_gdm_port struct.
Fix the issue validating egress gdm port in airoha_ppe_foe_entry_prepare
routine before accessing net_device priv pointer.

Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v4:
- Return bool in airoha_is_valid_gdm_port() instead of int
- Link to v3: https://lore.kernel.org/r/20250331-airoha-validate-egress-gdm-port-v3-1-c14e6ba9733a@kernel.org

Changes in v3:
- Rebase on top of net tree
- Fix commit log
- Link to v2: https://lore.kernel.org/r/20250315-airoha-flowtable-null-ptr-fix-v2-1-94b923d30234@kernel.org

Changes in v2:
- Avoid checking netdev_priv pointer since it is always not NULL
- Link to v1: https://lore.kernel.org/r/20250312-airoha-flowtable-null-ptr-fix-v1-1-6363fab884d0@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 13 +++++++++++++
 drivers/net/ethernet/airoha/airoha_eth.h |  3 +++
 drivers/net/ethernet/airoha/airoha_ppe.c |  8 ++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c0a642568ac115ea9df6fbaf7133627a4405a36c..743f85a1ee380a92d22ba91f3ee42e5fcb59aec7 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2454,6 +2454,19 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
 	}
 }
 
+bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
+			      struct airoha_gdm_port *port)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		if (eth->ports[i] == port)
+			return true;
+	}
+
+	return false;
+}
+
 static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 				 struct device_node *np, int index)
 {
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 60690b685710c72a2e15c6c6c94240108dafa1c1..ec8908f904c61988c3dc973e187596c49af139fb 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -532,6 +532,9 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
+bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
+			      struct airoha_gdm_port *port);
+
 void airoha_ppe_check_skb(struct airoha_ppe *ppe, u16 hash);
 int airoha_ppe_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 				 void *cb_priv);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 8b55e871352d359fa692c253d3f3315c619472b3..f10dab935cab6fad747fdfaa70b67903904c1703 100644
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
@@ -225,6 +226,9 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
 		struct airoha_gdm_port *port = netdev_priv(dev);
 		u8 pse_port;
 
+		if (!airoha_is_valid_gdm_port(eth, port))
+			return -EINVAL;
+
 		if (dsa_port >= 0)
 			pse_port = port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
 		else
@@ -633,7 +637,7 @@ static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
 	    !is_valid_ether_addr(data.eth.h_dest))
 		return -EINVAL;
 
-	err = airoha_ppe_foe_entry_prepare(&hwe, odev, offload_type,
+	err = airoha_ppe_foe_entry_prepare(eth, &hwe, odev, offload_type,
 					   &data, l4proto);
 	if (err)
 		return err;

---
base-commit: f278b6d5bb465c7fd66f3d103812947e55b376ed
change-id: 20250331-airoha-validate-egress-gdm-port-336c879960ca

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


