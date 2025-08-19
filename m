Return-Path: <netdev+bounces-214939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D6DB2C38A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB9416A65C
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C472343202;
	Tue, 19 Aug 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TShZKr3G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281DF343200
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606086; cv=none; b=HffLlRC56A0zdC/taRSReg55urZbhBvW7UTEZjcjKg60yVoITTEXdOsKA2mGQKxhUbDRRingHGJq5FEsTxwsLk9IgX7y9tEBmgOjFqs/3mlMuNJak0f3JKsjxQ/xEudpmsY+wnqLAYi3F/FeqCou39ElWfo0dhTuwDRE0w1e3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606086; c=relaxed/simple;
	bh=LRGy/NRdIaClMog/+9KxOMMANWnTaZpp/9kvA4YLbSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RSltZwVIQ5QBq4cah4N6b63cxZ1YeS5YmSzuIVyhvPRkEUFe+BAYWVwhWGOuB8HPGiVSJHDPiuMgh7XhH73QrV8ASs9GQbBdvlUc7KJ83k9oqEtnlt8oC4i9hroUHtC9xnVlzFo+96rSRpUOka7vQqI6dtx72WO1QDc5N1wCE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TShZKr3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C46C4CEF1;
	Tue, 19 Aug 2025 12:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755606085;
	bh=LRGy/NRdIaClMog/+9KxOMMANWnTaZpp/9kvA4YLbSo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TShZKr3Gm/BxO7zA424m3828ndLGqhxIzOVFLIKsQD/sqxP1LBa6GlA188KVoj7OM
	 RcbZ1K7GDtZmqw7Y/Rlc/nqgACMLCmstx2tDaiUZbxChBjH51ABFVM0RybtSQlFF3F
	 z7M1XxK0xIwJHDUVsE2eqQFWjPGJ6zQ8ecJmKmyhijwuBcX/PmEcXGxgb2+IxClRDc
	 vT17b3BGPRDhZj0IlIqZs6eo/OwAwMRPiTcMM8R2KD2mxFomKsLr0VF1ewIAGKO/9P
	 0ai90SG5vApCY/7G30XFHupogVOHWEgRg1vbEKS0gPGsBBCKb9Bzkj4tAuOSCHLjLu
	 r8FPht1W0Ubgw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 19 Aug 2025 14:21:06 +0200
Subject: [PATCH net-next 1/3] net: airoha: Rely on airoha_eth struct in
 airoha_ppe_flow_offload_cmd signature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-airoha-en7581-wlan-rx-offload-v1-1-71a097e0e2a1@kernel.org>
References: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
In-Reply-To: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Rely on airoha_eth struct in airoha_ppe_flow_offload_cmd routine
signature and in all the called subroutines.
This is a preliminary patch to introduce flowtable offload for traffic
received by the wlan NIC and forwarded to the ethernet one.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 2bf1c584ba7b7217549ce79df86f7a123199b5e1..2fabf33a5034d98c46efcaf3934e4ff21bd60e4a 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -937,11 +937,10 @@ static int airoha_ppe_entry_idle_time(struct airoha_ppe *ppe,
 	return airoha_ppe_get_entry_idle_time(ppe, e->data.ib1);
 }
 
-static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
+static int airoha_ppe_flow_offload_replace(struct airoha_eth *eth,
 					   struct flow_cls_offload *f)
 {
 	struct flow_rule *rule = flow_cls_offload_flow_rule(f);
-	struct airoha_eth *eth = port->qdma->eth;
 	struct airoha_flow_table_entry *e;
 	struct airoha_flow_data data = {};
 	struct net_device *odev = NULL;
@@ -1138,10 +1137,9 @@ static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
 	return err;
 }
 
-static int airoha_ppe_flow_offload_destroy(struct airoha_gdm_port *port,
+static int airoha_ppe_flow_offload_destroy(struct airoha_eth *eth,
 					   struct flow_cls_offload *f)
 {
-	struct airoha_eth *eth = port->qdma->eth;
 	struct airoha_flow_table_entry *e;
 
 	e = rhashtable_lookup(&eth->flow_table, &f->cookie,
@@ -1184,10 +1182,9 @@ void airoha_ppe_foe_entry_get_stats(struct airoha_ppe *ppe, u32 hash,
 	rcu_read_unlock();
 }
 
-static int airoha_ppe_flow_offload_stats(struct airoha_gdm_port *port,
+static int airoha_ppe_flow_offload_stats(struct airoha_eth *eth,
 					 struct flow_cls_offload *f)
 {
-	struct airoha_eth *eth = port->qdma->eth;
 	struct airoha_flow_table_entry *e;
 	u32 idle;
 
@@ -1211,16 +1208,16 @@ static int airoha_ppe_flow_offload_stats(struct airoha_gdm_port *port,
 	return 0;
 }
 
-static int airoha_ppe_flow_offload_cmd(struct airoha_gdm_port *port,
+static int airoha_ppe_flow_offload_cmd(struct airoha_eth *eth,
 				       struct flow_cls_offload *f)
 {
 	switch (f->command) {
 	case FLOW_CLS_REPLACE:
-		return airoha_ppe_flow_offload_replace(port, f);
+		return airoha_ppe_flow_offload_replace(eth, f);
 	case FLOW_CLS_DESTROY:
-		return airoha_ppe_flow_offload_destroy(port, f);
+		return airoha_ppe_flow_offload_destroy(eth, f);
 	case FLOW_CLS_STATS:
-		return airoha_ppe_flow_offload_stats(port, f);
+		return airoha_ppe_flow_offload_stats(eth, f);
 	default:
 		break;
 	}
@@ -1290,7 +1287,6 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 int airoha_ppe_setup_tc_block_cb(struct net_device *dev, void *type_data)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
-	struct flow_cls_offload *cls = type_data;
 	struct airoha_eth *eth = port->qdma->eth;
 	int err = 0;
 
@@ -1299,7 +1295,7 @@ int airoha_ppe_setup_tc_block_cb(struct net_device *dev, void *type_data)
 	if (!eth->npu)
 		err = airoha_ppe_offload_setup(eth);
 	if (!err)
-		err = airoha_ppe_flow_offload_cmd(port, cls);
+		err = airoha_ppe_flow_offload_cmd(eth, type_data);
 
 	mutex_unlock(&flow_offload_mutex);
 

-- 
2.50.1


