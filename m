Return-Path: <netdev+bounces-266194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJpWFN42sGkKhQIAu9opvQ
	(envelope-from <netdev+bounces-266194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:21:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1648253369
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E47D3043FB9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5BF2DC76C;
	Tue, 10 Mar 2026 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dx24Uj8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9323A564
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154037; cv=none; b=pTY9BNKmE4vjKEZsDzr57yfZD6H8ivCCvbTcjeXVJuKX0VHQNRkMH15ZVZ59lO6l3rj1jP2/vYN3FT/Ezj+6Nus+JaAYJAKFLKfIP9dq75pxpB9KmNr1WVn9BC/v4m6B5bXAXk809SNCGxG1WzFhLRfjVynu+AWFtDbaREBzvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154037; c=relaxed/simple;
	bh=BfbSFgreWiIQp6vhNWoyJ3zBM1Hl+T/lGWmkHzyJQyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pFpQBnVrPe9P4ZV9ZpmcLCkgFWNELfv1vMqnRZfp0Cgfuo5P/gh3XKIBDRaaP6RPYO0b5XdS4A0RwqaUce4644UytEc7aK9aYSxuTU2KEwALLkERoP/D9zZp12/zjudb4I5mL6n++f29rIwDgJvgNArdhW7JZ6dCmOwU4WMbMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dx24Uj8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CFDC19423;
	Tue, 10 Mar 2026 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773154037;
	bh=BfbSFgreWiIQp6vhNWoyJ3zBM1Hl+T/lGWmkHzyJQyM=;
	h=From:Date:Subject:To:Cc:From;
	b=Dx24Uj8hsLn46ThSQMA2cMAwMvcFgW5G41kDLuikgo5F+QsEFhhHVscq6NeVDMHvp
	 GGBcIhYHAhdDdMkKRA0zL7abaq/VYSAV1gBBsCH6PwMb0evo/CPo/Opu+E8LGGpIB1
	 wist/aS+MXSMsSTU+AVDZAtINkF1C9cDWRPObFv6atdC6tiRoTsA+cmjxH6lz2eiyh
	 jlZGfnd9sGePZoDs7JwJOqry1PnFkMr2VvlC/HpI4dskFBRZiXIi+WTN2sAw6DWr+Y
	 xH7jzhefqrZTaFluiQbqjGkd9LpQ4DX3lbBQKTMKnY29428YOJqaM96ljIS2K+mhWt
	 ulM2UB5hHdSCw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 10 Mar 2026 15:46:53 +0100
Subject: [PATCH net-next] net: airoha: select QDMA block according LAN/WAN
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-airoha-qdma-lan-wan-mode-v1-1-64ec74dea872@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MsQqEMBAFf0W2diEmYOGviMViXnRBEy+BU5D8+
 4Urpphi5qWCrCg0dS9lfLVoik2GvqN1l7iB1Tcna+xo3GBYNKdd+ONP4UMi340zefDovLMWCAi
 OWn5lBH3+63mp9Qdg8uBtagAAAA==
X-Change-ID: 20260310-airoha-qdma-lan-wan-mode-63d322eefef3
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: A1648253369
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266194-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Select the QDMA block used to send the traffic to host cpu according to
LAN/WAN port confiugration:
- QDMA0 is used for LAN devices
- QDMA1 is used for WAN devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 18 ++++++++----------
 drivers/net/ethernet/airoha/airoha_eth.h |  1 +
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 3e9ec5c178f86fdd055e079078a23461edf97951..b4563b5d53bbf174d45548a5efc6fdfb79d33c19 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1754,11 +1754,13 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 static int airoha_dev_init(struct net_device *dev)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
-	struct airoha_qdma *qdma = port->qdma;
-	struct airoha_eth *eth = qdma->eth;
+	struct airoha_eth *eth = port->eth;
 	u32 fe_cpu_port;
 	u8 ppe_id;
 
+	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
+	port->qdma = &eth->qdma[!airoha_is_lan_gdm_port(port)];
+	port->dev->irq = port->qdma->irq_banks[0].irq;
 	airoha_set_macaddr(port, dev->dev_addr);
 
 	switch (port->id) {
@@ -1782,7 +1784,7 @@ static int airoha_dev_init(struct net_device *dev)
 		}
 		fallthrough;
 	default: {
-		u8 qdma_id = qdma - &eth->qdma[0];
+		u8 qdma_id = port->qdma - &eth->qdma[0];
 
 		/* For PPE1 select cpu port according to the running QDMA. */
 		fe_cpu_port = qdma_id ? FE_PSE_PORT_CDM2 : FE_PSE_PORT_CDM1;
@@ -2866,11 +2868,10 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 }
 
 static int airoha_alloc_gdm_port(struct airoha_eth *eth,
-				 struct device_node *np, int index)
+				 struct device_node *np)
 {
 	const __be32 *id_ptr = of_get_property(np, "reg", NULL);
 	struct airoha_gdm_port *port;
-	struct airoha_qdma *qdma;
 	struct net_device *dev;
 	int err, p;
 	u32 id;
@@ -2901,7 +2902,6 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 		return -ENOMEM;
 	}
 
-	qdma = &eth->qdma[index % AIROHA_MAX_NUM_QDMA];
 	dev->netdev_ops = &airoha_netdev_ops;
 	dev->ethtool_ops = &airoha_ethtool_ops;
 	dev->max_mtu = AIROHA_MAX_MTU;
@@ -2913,7 +2913,6 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	dev->features |= dev->hw_features;
 	dev->vlan_features = dev->hw_features;
 	dev->dev.of_node = np;
-	dev->irq = qdma->irq_banks[0].irq;
 	SET_NETDEV_DEV(dev, eth->dev);
 
 	/* reserve hw queues for HTB offloading */
@@ -2934,7 +2933,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	port = netdev_priv(dev);
 	u64_stats_init(&port->stats.syncp);
 	spin_lock_init(&port->stats.lock);
-	port->qdma = qdma;
+	port->eth = eth;
 	port->dev = dev;
 	port->id = id;
 	eth->ports[p] = port;
@@ -3034,7 +3033,6 @@ static int airoha_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_start_napi(&eth->qdma[i]);
 
-	i = 0;
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_device_is_compatible(np, "airoha,eth-mac"))
 			continue;
@@ -3042,7 +3040,7 @@ static int airoha_probe(struct platform_device *pdev)
 		if (!of_device_is_available(np))
 			continue;
 
-		err = airoha_alloc_gdm_port(eth, np, i++);
+		err = airoha_alloc_gdm_port(eth, np);
 		if (err) {
 			of_node_put(np);
 			goto error_napi_stop;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 59ed7569f7c33620ea694ec52384a37e1917eaf8..8cfa94ec084a16d6b2d3c94c404f25904c1150e3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -533,6 +533,7 @@ struct airoha_qdma {
 
 struct airoha_gdm_port {
 	struct airoha_qdma *qdma;
+	struct airoha_eth *eth;
 	struct net_device *dev;
 	int id;
 

---
base-commit: 89fe91c65992a37863241e35aec151210efc53ce
change-id: 20260310-airoha-qdma-lan-wan-mode-63d322eefef3

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


