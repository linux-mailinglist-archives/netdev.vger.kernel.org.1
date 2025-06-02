Return-Path: <netdev+bounces-194594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F385FACACD9
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 12:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50A217ED54
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 10:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297722054E4;
	Mon,  2 Jun 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PajkfvFA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575D2040AB
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748861762; cv=none; b=R6Vy/eG2TTBDsW3ZRZ5WKQi1+N8QOO2Wcydx7y8zvxrHzT52wrD3Alf5MAle7AazO3gTGDJeMGXnuFGVRnjJhiXM3eJZpMRrxHQnlpjOHYMlxzdOUd4N2jSLK5LpV4fYL/oo66zKMB/WGwd4qqUB95TgINr1tG1Jjb87dHFGRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748861762; c=relaxed/simple;
	bh=KGXQsqjuf+rgYidf6tzgY9bpwLnO257ZStKX95kSwjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQLaMgywbI8g7q8b6Zs87/Z9dWTC+OvbSPTXatpFQIkCjb1titFZJmJeGmdV5hEQA24HrfOxzQD5kH0SCscfjrfKagofNP1jg+zoNjN/6VoOd1Lp7qrMqjBx37oJSJAI1Pj/TA8C6fiNL+3q1jyj7z9HiQUcT/xJaDKL5scEmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PajkfvFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2640CC4CEEB;
	Mon,  2 Jun 2025 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748861761;
	bh=KGXQsqjuf+rgYidf6tzgY9bpwLnO257ZStKX95kSwjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PajkfvFAu+letbcKYheYBet9yR6/CeYQYK2/U6r72qEai39jK7jvrZg3StrPTwx8f
	 aqJFlV5pTLvVVTg9M5fL7DvjXapplNTm9iM/iWACN8pOrvKnQK3PAWrtHOmuyV8VUK
	 rqR6y3CgXjzXX27yewcljJm5OdLUk2Y4RvxC5+OL4MF0sVqH60PbO19XQ+bpDmvNqQ
	 nBS8rfQrf9FSW02AVZSZ30Cp9VBqHM7316wBkaa2TEOc/yxibPiJDMcvWOThFwXU46
	 wfWm2oJwqmRbu3GVWB4Y5tzopqd4R81QWgtmEU94WwRx5B3NToyrKDajvx/xdknFBz
	 HBfvL14L7AUhA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 02 Jun 2025 12:55:38 +0200
Subject: [PATCH net v2 2/3] net: airoha: Fix IPv6 hw acceleration in bridge
 mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-airoha-flowtable-ipv6-fix-v2-2-3287f8b55214@kernel.org>
References: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
In-Reply-To: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

ib2 and airoha_foe_mac_info_common have not the same offsets in
airoha_foe_bridge and airoha_foe_ipv6 structures. Current codebase does
not accelerate IPv6 traffic in bridge mode since ib2 and l2 info are not
set properly copying airoha_foe_bridge struct into airoha_foe_ipv6 one
in airoha_ppe_foe_commit_subflow_entry routine.
Fix IPv6 hw acceleration in bridge mode resolving ib2 and
airoha_foe_mac_info_common overwrite in
airoha_ppe_foe_commit_subflow_entry() and configuring them with proper
values.

Fixes: cd53f622611f ("net: airoha: Add L2 hw acceleration support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index a783f16980e6b7fdb69cec7ff09883a9c83d42d5..557779093a79a4b42a1dc49b8ba0dacbdc219385 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -639,7 +639,6 @@ airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
 	u32 mask = AIROHA_FOE_IB1_BIND_PACKET_TYPE | AIROHA_FOE_IB1_BIND_UDP;
 	struct airoha_foe_entry *hwe_p, hwe;
 	struct airoha_flow_table_entry *f;
-	struct airoha_foe_mac_info *l2;
 	int type;
 
 	hwe_p = airoha_ppe_foe_get_entry(ppe, hash);
@@ -656,18 +655,20 @@ airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
 
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


