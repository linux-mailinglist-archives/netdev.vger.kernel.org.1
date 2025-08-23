Return-Path: <netdev+bounces-216194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AE4B32781
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 09:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434A65A63DF
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 07:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C2B22B5B8;
	Sat, 23 Aug 2025 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmBcOvuf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43970150997
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935788; cv=none; b=T7SIp9saF6cIeEm/NBO/Rl2NWTcZhlcgbgtUxo6/Dt9tXnW3k0XkFgwWtUO097RwIhnNowlI/Qz2OxG+s773WxeZvLvvffYvh7r+ssQXwf+kkpcOzZVF+YOzF/FpQu3ycMETHM+Aci/zevR3ZvIttkWM20UyBBrCDh/vkOrMgnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935788; c=relaxed/simple;
	bh=bUhhisMpwunCiVpJimsogShTnS7b3lFsORIaZ4diA6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vu/FMtbI2lfnNxYhIZl8M3elAcjj7KAqwz2GvapNo93EkbhnR7eX+GYyteFvPoC2YH8Xd24C5qZ5HtYY+E3of8UDai46jTmUMggsvrWRTaljnjJ6ojrurTjNK67qPhPfii51mIPXqvpcoolq+613/Z8qxaIlCJV/IjHZOI92rjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmBcOvuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE63C4CEE7;
	Sat, 23 Aug 2025 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755935787;
	bh=bUhhisMpwunCiVpJimsogShTnS7b3lFsORIaZ4diA6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cmBcOvufqRiTIVI2CcRlHEkYOr9lQEMA+fzMI9PSFqFWxHhwLZMRrGVemG833UKyS
	 2/zkTP3+JIkkKhoHjWn/j16HKtzH8gmYmRdb5CemGDQOwXD4pzF0JsOa9hKqwyxHNk
	 kQ+yu4ZmzLMwJjG2PpvDsH7kN7WRCAiLxdr4mOzFokoqqeMJyeL5lUsUZsGJXFjRRv
	 pYy7SxlK3i85hWDlwz9pQHohRtwAtdKZkPsYGUZVhF0L+HXya76UvAqxz56XBis9hi
	 KSmLgtW8kK4YApjb6SXrjn/YhuJskKxmVrE+SA7KF3InKB9oSvFZdywPn9ZxMrCTi/
	 NslgmI3XzSYqg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 23 Aug 2025 09:56:02 +0200
Subject: [PATCH net-next v3 1/3] net: airoha: Rely on airoha_eth struct in
 airoha_ppe_flow_offload_cmd signature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-airoha-en7581-wlan-rx-offload-v3-1-f78600ec3ed8@kernel.org>
References: <20250823-airoha-en7581-wlan-rx-offload-v3-0-f78600ec3ed8@kernel.org>
In-Reply-To: <20250823-airoha-en7581-wlan-rx-offload-v3-0-f78600ec3ed8@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
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
index 0d5cd3a13a3ee3d877f344ee0644d76d1c9df74a..36b45e98279a1d18ef0c7e185d8fca7b32c70436 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -935,11 +935,10 @@ static int airoha_ppe_entry_idle_time(struct airoha_ppe *ppe,
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
@@ -1136,10 +1135,9 @@ static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
 	return err;
 }
 
-static int airoha_ppe_flow_offload_destroy(struct airoha_gdm_port *port,
+static int airoha_ppe_flow_offload_destroy(struct airoha_eth *eth,
 					   struct flow_cls_offload *f)
 {
-	struct airoha_eth *eth = port->qdma->eth;
 	struct airoha_flow_table_entry *e;
 
 	e = rhashtable_lookup(&eth->flow_table, &f->cookie,
@@ -1182,10 +1180,9 @@ void airoha_ppe_foe_entry_get_stats(struct airoha_ppe *ppe, u32 hash,
 	rcu_read_unlock();
 }
 
-static int airoha_ppe_flow_offload_stats(struct airoha_gdm_port *port,
+static int airoha_ppe_flow_offload_stats(struct airoha_eth *eth,
 					 struct flow_cls_offload *f)
 {
-	struct airoha_eth *eth = port->qdma->eth;
 	struct airoha_flow_table_entry *e;
 	u32 idle;
 
@@ -1209,16 +1206,16 @@ static int airoha_ppe_flow_offload_stats(struct airoha_gdm_port *port,
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
@@ -1288,7 +1285,6 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 int airoha_ppe_setup_tc_block_cb(struct net_device *dev, void *type_data)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
-	struct flow_cls_offload *cls = type_data;
 	struct airoha_eth *eth = port->qdma->eth;
 	int err = 0;
 
@@ -1297,7 +1293,7 @@ int airoha_ppe_setup_tc_block_cb(struct net_device *dev, void *type_data)
 	if (!eth->npu)
 		err = airoha_ppe_offload_setup(eth);
 	if (!err)
-		err = airoha_ppe_flow_offload_cmd(port, cls);
+		err = airoha_ppe_flow_offload_cmd(eth, type_data);
 
 	mutex_unlock(&flow_offload_mutex);
 

-- 
2.50.1


