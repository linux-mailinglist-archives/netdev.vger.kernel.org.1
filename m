Return-Path: <netdev+bounces-178271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31774A763E7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 12:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B6D16740A
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5E11DF247;
	Mon, 31 Mar 2025 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM5PkaxQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38D157A5A
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416061; cv=none; b=WLT3+MeUWQuGEHcY6OALICa55tesz6AV+KeXU5BWeZXgxtOHKF7TNKRQsCNaJUYluRUb9a7aqPc51Xmia/Gp1YVeIpy4v0pPrwHQ0OFMLUgK56UB5iWQosn9Rr+RmD8bZ4a9VNdizq5aV+0framNfVQpNGEdyNZ3QqYhby4Dnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416061; c=relaxed/simple;
	bh=56IfTRauGxaQRKelmBbZK/tQWYp/lbJMPy7TjK50Wqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OZO35JJX+57Mx4v9KyYgzwB9ysraWDHcuKkrVNFKWYoX+wV2h27SdBNHO6/sHcs6J/A0u06M/Xo6/vYEX+UDZEpBtlIDFAiA1rjuTozYaqf/rN6WUuSMScRKsGj/O+ar1oweBKSwsiqpb/oqgizsoHjejcz2kgHblaGamAO1OVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM5PkaxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDE1C4CEE5;
	Mon, 31 Mar 2025 10:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743416060;
	bh=56IfTRauGxaQRKelmBbZK/tQWYp/lbJMPy7TjK50Wqc=;
	h=From:Date:Subject:To:Cc:From;
	b=UM5PkaxQaot4GJoJ+pHs9qPNmy+XoOLrc2NZ7l9Mikjh9Q6ro0mj/NEQyD+mWDF4n
	 A2JEbK/A0Lud86zCoJEVtjBNiIYh7t0+Fouw68z1hC+mmAsYvLLoDSt1oNk5Op3uxz
	 MKUmfoHUs5SPE/B3B8SjuvCD7Kj79NMRAaGk83yjA97UYFcHG1RINlUoNUPvn80iV3
	 uIPvHC4IFUNLWtAEE3W19QGnUhQp2ZHn2KZjnUAq31SIezXVpEtg7gr4I9aR38Dnx3
	 UMmAJu5whsDInYk/XgHgfCx09hFossNbly/7CZn/M4ZHB/+fq/us1yReLb6zI2taWu
	 FCBZQs+lAJjNg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 31 Mar 2025 12:14:09 +0200
Subject: [PATCH net v3] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-airoha-validate-egress-gdm-port-v3-1-c14e6ba9733a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPBq6mcC/x3NQQqDQAxA0atI1gZGQ231KtJFmEnHQOtIIlIQ7
 96hy7f5/wQXU3GYmhNMDnUtawW1DcSF1yyoqRr60N8CUYesVhbGg9+aeBeUbOKOOX1wK7Yj0RA
 f93EcQmSolc3kpd//YX5e1w9fdG6DcQAAAA==
X-Change-ID: 20250331-airoha-validate-egress-gdm-port-336c879960ca
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Device pointer in airoha_ppe_foe_entry_prepare routine is not strictly
necessary a device allocated by airoha_eth driver since it is an egress
device and the flowtable can contain even wlan, pppoe or vlan devices.
E.g:

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
index 60690b685710c72a2e15c6c6c94240108dafa1c1..d199b8adffc0b25c369dc19cdc074c50af40e3bf 100644
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
base-commit: 2ea396448f26d0d7d66224cb56500a6789c7ed07
change-id: 20250331-airoha-validate-egress-gdm-port-336c879960ca

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


