Return-Path: <netdev+bounces-195843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7BFAD278C
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCA11894B1E
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4569021E087;
	Mon,  9 Jun 2025 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdSMrzR/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF7221CC57
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500946; cv=none; b=LUCGrB4stOs19byU9b8z6UVqfB1dfPuO+wMD++BoxsEvUrySvS9HBYnRyKcQPTLnBCO2mGqwSzAro/DllbnDwKkkUHle3PShlJrIGG3Uywjskb64mYtft+A6skndR3QqlMAuc1v9SMaKKTZNik4JGYs/eXoJZOFhVsIqvHfHk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500946; c=relaxed/simple;
	bh=ynv6xDu7Wvta+MTxVq8GsI3jIBgL0uLRSQMAaRThjp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZqFWuMk5IAaMxCc7d9m/RXzB48dw/nQVuOUZpK7MKsbYTx4f1TWK+kO6pfDJVn+1rRd42HWMXQDtOVaRfo2T8/s7d5sWX8jhewbysI/QEGxdi62OTRW0bIGqUDeS/0fShn9B2DL6dLUBanevDxeolUz8oli2SWu6ry5Ygn3zYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdSMrzR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EB2C4CEEB;
	Mon,  9 Jun 2025 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749500945;
	bh=ynv6xDu7Wvta+MTxVq8GsI3jIBgL0uLRSQMAaRThjp0=;
	h=From:Date:Subject:To:Cc:From;
	b=pdSMrzR/4NX6Gx6Y5aZXBlfcEd4ruoj6qJzMwxt/W8wN9a7Dc1euf/MsBxGnnwRnZ
	 R/SsvMqjvvezL/hOcW/jA+iTYw2GAHN+WMuJjqYJECbCZKm06XK/aBNASgx7E3sSVT
	 Mzy0sLR89if+dRrRvGq4a/vwxrYaMdGhH3MG7PbDA/i5k2bxrdC9tdVZAzJII/gWq6
	 TzeHs7t3B2NN9r4VKN6P5htJFojtDfk4YJSAf1efv2859RC0+k6XBPrCZgYIUIV2zn
	 WlqOb9ANGkSpmiCKM4VUXhiEYshkTI3RGiHz9d0AWmRMHPAcuYf1KC7Cw9piI7v99I
	 InjB2cPKp1AOQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 09 Jun 2025 22:28:40 +0200
Subject: [PATCH net-next] net: airoha: Add PPPoE offload support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-b4-airoha-flowtable-pppoe-v1-1-1520fa7711b4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPdDR2gC/32NQQ6CMBBFr0Jm7Zi2tgZceQ/DouAAEwltpgQ1h
 Ltbce/yveS/v0IiYUpwKVYQWjhxmDLoQwHt4KeekO+ZwSjjlNUnbCx6ljB47MbwnH0zEsYYA6F
 pdVV1TrmKPOR9FOr4tbdvdeaB0xzkvV8t+mt/VWf+VReNCktXWqu0O5ekrg+SicZjkB7qbds+r
 0nOv8MAAAA=
X-Change-ID: 20250413-b4-airoha-flowtable-pppoe-2c199f5059ea
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce flowtable hw acceleration for PPPoE traffic.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 9067d2fc7706ecf489bee9fc9b6425de18acb634..50d816344b1f8c1ed639de357f62e761ede92f05 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -232,6 +232,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 	      FIELD_PREP(AIROHA_FOE_IB1_BIND_UDP, l4proto == IPPROTO_UDP) |
 	      FIELD_PREP(AIROHA_FOE_IB1_BIND_VLAN_LAYER, data->vlan.num) |
 	      FIELD_PREP(AIROHA_FOE_IB1_BIND_VPM, data->vlan.num) |
+	      FIELD_PREP(AIROHA_FOE_IB1_BIND_PPPOE, data->pppoe.num) |
 	      AIROHA_FOE_IB1_BIND_TTL;
 	hwe->ib1 = val;
 
@@ -281,33 +282,42 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 		hwe->ipv6.data = qdata;
 		hwe->ipv6.ib2 = val;
 		l2 = &hwe->ipv6.l2;
+		l2->etype = ETH_P_IPV6;
 	} else {
 		hwe->ipv4.data = qdata;
 		hwe->ipv4.ib2 = val;
 		l2 = &hwe->ipv4.l2.common;
+		l2->etype = ETH_P_IP;
 	}
 
 	l2->dest_mac_hi = get_unaligned_be32(data->eth.h_dest);
 	l2->dest_mac_lo = get_unaligned_be16(data->eth.h_dest + 4);
 	if (type <= PPE_PKT_TYPE_IPV4_DSLITE) {
+		struct airoha_foe_mac_info *mac_info;
+
 		l2->src_mac_hi = get_unaligned_be32(data->eth.h_source);
 		hwe->ipv4.l2.src_mac_lo =
 			get_unaligned_be16(data->eth.h_source + 4);
+
+		mac_info = (struct airoha_foe_mac_info *)l2;
+		mac_info->pppoe_id = data->pppoe.sid;
 	} else {
-		l2->src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID, smac_id);
+		l2->src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID, smac_id) |
+				 FIELD_PREP(AIROHA_FOE_MAC_PPPOE_ID,
+					    data->pppoe.sid);
 	}
 
 	if (data->vlan.num) {
-		l2->etype = dsa_port >= 0 ? BIT(dsa_port) : 0;
 		l2->vlan1 = data->vlan.hdr[0].id;
 		if (data->vlan.num == 2)
 			l2->vlan2 = data->vlan.hdr[1].id;
-	} else if (dsa_port >= 0) {
-		l2->etype = BIT(15) | BIT(dsa_port);
-	} else if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T) {
-		l2->etype = ETH_P_IPV6;
-	} else {
-		l2->etype = ETH_P_IP;
+	}
+
+	if (dsa_port >= 0) {
+		l2->etype = BIT(dsa_port);
+		l2->etype |= !data->vlan.num ? BIT(15) : 0;
+	} else if (data->pppoe.num) {
+		l2->etype = ETH_P_PPP_SES;
 	}
 
 	return 0;
@@ -957,6 +967,11 @@ static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
 		case FLOW_ACTION_VLAN_POP:
 			break;
 		case FLOW_ACTION_PPPOE_PUSH:
+			if (data.pppoe.num == 1 || data.vlan.num == 2)
+				return -EOPNOTSUPP;
+
+			data.pppoe.sid = act->pppoe.sid;
+			data.pppoe.num++;
 			break;
 		default:
 			return -EOPNOTSUPP;

---
base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
change-id: 20250413-b4-airoha-flowtable-pppoe-2c199f5059ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


