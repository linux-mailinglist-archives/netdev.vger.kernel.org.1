Return-Path: <netdev+bounces-193144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E9BAC2A6C
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544F73BE40B
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC8529B794;
	Fri, 23 May 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELkz6srq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879129B77E
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028238; cv=none; b=FzfKk+GgZ5xhItmffKyyaosZHas9SeQzKbAR4BPLeb4TcNf1tRt+wH2QSEE8rngp7s8vposjX0PZqFnVKsk0K8WOY+iunC8iV1Is3e7SJWGBhTJ1pzaFdExzLfQhYK3+pmb2q2KJWHs2Jdiud9HgXUi9tb4TgRpQm85biLothyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028238; c=relaxed/simple;
	bh=Q2Dup5l+vEvGwrc1bpceFqvGlnEspT+jpGeX8zIyloQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCw+JLBn1TyhgVD3SdsonKttjsWKowarOYlJ+aJ8OtQpiQhxrasJzpVLcoAr24rw4xlGnnt22YGhz72em0XJIauT2au6s6IUAenkEjovu6xY+q7L8XX9krEMGhnOs/ikD77aDMc6cUdze3B0C58OQjgnO+XtUPlo8qtMVKDNQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELkz6srq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DAAC4CEEB;
	Fri, 23 May 2025 19:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748028237;
	bh=Q2Dup5l+vEvGwrc1bpceFqvGlnEspT+jpGeX8zIyloQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ELkz6srq6PjLkje3gdZEsiN0t9qgNjOqMMyKZbqaCWKuwxuw7odDwVEiRbd1TW0T0
	 KwcqONMCOjI3+60F8UnaFzxoP2t5IPU812FOlrBH6ppulteDSokIScMfBrp1GVbgL4
	 ET7WlE1o0hoHzy14ReV8RDjSyYTUuuYuRV67mEfMh7W0EMemIjBBzZVqRd5crjyVUk
	 EPtrhb2P6eduJZGbegiqSesV8j9FnaJd4fKsG2aCCulHf05+nPTaM0wjWrfcQ8AzeF
	 zHVJKAApuUjlXqwAWHlv77Pu4nKM0qH0PXkxCNBiefu1qCc6VsftY+RkplnNG8tGml
	 5AhkHihCWt8/Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 23 May 2025 21:23:31 +0200
Subject: [PATCH net-next 2/2] net: airoha: Add PPPoE offload support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-b4-airoha-flowtable-pppoe-v1-2-8584401568e0@kernel.org>
References: <20250523-b4-airoha-flowtable-pppoe-v1-0-8584401568e0@kernel.org>
In-Reply-To: <20250523-b4-airoha-flowtable-pppoe-v1-0-8584401568e0@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce flowtable hw acceleration for PPPoE traffic.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 37 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 1d5a04eb82a6645e2b6a22ff4e694275ef1727d8..6571511cf4bb8c341b03b94ba8e444f558cbf125 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -232,6 +232,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 	      FIELD_PREP(AIROHA_FOE_IB1_BIND_UDP, l4proto == IPPROTO_UDP) |
 	      FIELD_PREP(AIROHA_FOE_IB1_BIND_VLAN_LAYER, data->vlan.num) |
 	      FIELD_PREP(AIROHA_FOE_IB1_BIND_VPM, data->vlan.num) |
+	      FIELD_PREP(AIROHA_FOE_IB1_BIND_PPPOE, data->pppoe.num) |
 	      AIROHA_FOE_IB1_BIND_TTL;
 	hwe->ib1 = val;
 
@@ -274,33 +275,38 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
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
-	} else {
-		l2->src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID, smac_id);
-	}
 
-	if (data->vlan.num) {
-		l2->etype = dsa_port >= 0 ? BIT(dsa_port) : 0;
-		l2->vlan1 = data->vlan.hdr[0].id;
-		if (data->vlan.num == 2)
-			l2->vlan2 = data->vlan.hdr[1].id;
-	} else if (dsa_port >= 0) {
-		l2->etype = BIT(15) | BIT(dsa_port);
-	} else if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T) {
-		l2->etype = ETH_P_IPV6;
+		mac_info = (struct airoha_foe_mac_info *)l2;
+		mac_info->pppoe_id = data->pppoe.sid;
 	} else {
-		l2->etype = ETH_P_IP;
+		l2->src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID, smac_id) |
+				 FIELD_PREP(AIROHA_FOE_MAC_PPPOE_ID,
+					    data->pppoe.sid);
+	}
+	l2->vlan1 = data->vlan.hdr[0].id;
+	l2->vlan2 = data->vlan.hdr[1].id;
+
+	if (dsa_port >= 0) {
+		l2->etype = BIT(dsa_port);
+		l2->etype |= !data->vlan.num ? BIT(15) : 0;
+	} else if (data->pppoe.num) {
+		l2->etype = ETH_P_PPP_SES;
 	}
 
 	return 0;
@@ -944,6 +950,11 @@ static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
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

-- 
2.49.0


