Return-Path: <netdev+bounces-194249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A8AAC8086
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 17:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BA44E4206
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5843222CBC1;
	Thu, 29 May 2025 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw+rhh/7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7C193062
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533981; cv=none; b=fO1gvDKW52u8CyCnmG9rhtNFBv769M7f5Di+j75xfb/jF4ZU9PHSLi9DHxhKI8pn04noLYyskRuO22szZaLR21Ru8MZntYGhLeHIy46wzdAOsakkcWdWDN1UAPaB6W037pklpIDYDaq3aUqA8Xh7JvP9ETJiMGOmE54Yb7pxh7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533981; c=relaxed/simple;
	bh=dBrwp1lSjo0/zOXj6+oiqnIpBPI1NPg/5I0TXg2hVv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L3nXppIuDkWdRkAPUH0ao5sQjqUjmPZ0ZNIa1QsUqLBB9kJyOBSsANQB9CoozZ+owZBxS6ESXd9+WRN9Awm5rvuoY81RyV6q2MkqmcaTUdBFwmfOz/yQ5m+/21WgCC8tPym6M8RrfGC4lCqxExSe/6dtovmZCEDBs12XzY/uBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw+rhh/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25163C4CEE7;
	Thu, 29 May 2025 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748533980;
	bh=dBrwp1lSjo0/zOXj6+oiqnIpBPI1NPg/5I0TXg2hVv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yw+rhh/7vLdzy29EEq4xkty36nZuNp/uVPHljZW42ReP4ZM0WRx5x00cuKa8nKoWW
	 cehhCWZD2qR5mAB9p7IPwFaxZ57fAMxlQdZbMmPU65C+9U9vwNu7pX2j58pUoNappk
	 5IffxJ5eBVEc3ui9eV7Yy1bZQWajrtJTvZcrLaS672kA1Q4lMxXddS7BFJ03sF7Yi9
	 seAOrSV0ZVz4riIGZjG133mrmxPWWox+J6l3T+6Ht0uBdtQXB6eYr80J2wQTqaT0Qj
	 5hzRAllPMLyk2rjcCIeb3KtkrzyJjisjwW7tesfif8Bj4v/B/NKPoEZqQJ/6nUorL0
	 JxVVdPWvO1hGQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 29 May 2025 17:52:38 +0200
Subject: [PATCH net 2/2] net: airoha: Fix IPv6 hw acceleration in bridge
 mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-airoha-flowtable-ipv6-fix-v1-2-7c7e53ae0854@kernel.org>
References: <20250529-airoha-flowtable-ipv6-fix-v1-0-7c7e53ae0854@kernel.org>
In-Reply-To: <20250529-airoha-flowtable-ipv6-fix-v1-0-7c7e53ae0854@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

ib2 and airoha_foe_mac_info_common have not the same offsets in
airoha_foe_bridge and airoha_foe_ipv6 structures. Fix IPv6 hw
acceleration in bridge mode resolving ib2 and airoha_foe_mac_info_common
overwrite in airoha_ppe_foe_commit_subflow_entry routine. Moreover, set
AIROHA_FOE_MAC_SMAC_ID to 0xf in airoha_ppe_foe_commit_subflow_entry()
to configure the PPE module to keep original source mac address of the
bridged packets.

Fixes: cd53f622611f ("net: airoha: Add L2 hw acceleration support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index a783f16980e6b7fdb69cec7ff09883a9c83d42d5..d5dbcb556f2b10b23ebbdd32a66a3c4f32cfb460 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -639,7 +639,6 @@ airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
 	u32 mask = AIROHA_FOE_IB1_BIND_PACKET_TYPE | AIROHA_FOE_IB1_BIND_UDP;
 	struct airoha_foe_entry *hwe_p, hwe;
 	struct airoha_flow_table_entry *f;
-	struct airoha_foe_mac_info *l2;
 	int type;
 
 	hwe_p = airoha_ppe_foe_get_entry(ppe, hash);
@@ -656,18 +655,23 @@ airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
 
 	memcpy(&hwe, hwe_p, sizeof(*hwe_p));
 	hwe.ib1 = (hwe.ib1 & mask) | (e->data.ib1 & ~mask);
-	l2 = &hwe.bridge.l2;
-	memcpy(l2, &e->data.bridge.l2, sizeof(*l2));
 
 	type = FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe.ib1);
-	if (type == PPE_PKT_TYPE_IPV4_HNAPT)
-		memcpy(&hwe.ipv4.new_tuple, &hwe.ipv4.orig_tuple,
-		       sizeof(hwe.ipv4.new_tuple));
-	else if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T &&
-		 l2->common.etype == ETH_P_IP)
-		l2->common.etype = ETH_P_IPV6;
-
-	hwe.bridge.ib2 = e->data.bridge.ib2;
+	if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T) {
+		memcpy(&hwe.ipv6.l2, &e->data.bridge.l2, sizeof(hwe.ipv6.l2));
+		hwe.ipv6.ib2 = e->data.bridge.ib2;
+		/* keep origianl source mac address */
+		hwe.ipv6.l2.src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID,
+						    0xf);
+	} else {
+		memcpy(&hwe.bridge.l2, &e->data.bridge.l2,
+		       sizeof(hwe.bridge.l2));
+		hwe.bridge.ib2 = e->data.bridge.ib2;
+		if (type == PPE_PKT_TYPE_IPV4_HNAPT)
+			memcpy(&hwe.ipv4.new_tuple, &hwe.ipv4.orig_tuple,
+			       sizeof(hwe.ipv4.new_tuple));
+	}
+
 	hwe.bridge.data = e->data.bridge.data;
 	airoha_ppe_foe_commit_entry(ppe, &hwe, hash);
 

-- 
2.49.0


