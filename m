Return-Path: <netdev+bounces-286181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BmfIVsx/2lb3QAAu9opvQ
	(envelope-from <netdev+bounces-286181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:06:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBCD4FFBC5
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4313230071DB
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 13:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4938AC8B;
	Sat,  9 May 2026 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtBsJrmn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49911C5D59;
	Sat,  9 May 2026 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778331985; cv=none; b=Njco+ieIC5lN5QSY4vGHo7A2iC93ZurqlQdzYDXLTJ+0DNsfnrGVEjR30GkPEiz8yuJqJiQlga5N5Gqyn5285tUk0FFtsSsONH0R+X4gl08k806esccFdN8npwAD/sMX1mIrmbfHtOeVnhDKQ5V9bjC+dIU0HB9busHBfBS6ayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778331985; c=relaxed/simple;
	bh=0Ncmz0wTr80Sx4M7x6CSIXKalauJz5yxccgQ2CIvGbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PvD86ifxdW7/lCHC9ao52Ln7HYtRsteC79wM31rWlyb6w0iGXN1kRlX+R80pwXXPQos1lbjAlYIC77+eY/lvb5HMI/gLOxXzdTVPqkIb+8qTjNcKcgDMW9E5UAoXAxWJudiizjSLO95n+vovOGgct+kVa8qCQSTaPrIdOE6MNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtBsJrmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3A9C2BCF7;
	Sat,  9 May 2026 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778331985;
	bh=0Ncmz0wTr80Sx4M7x6CSIXKalauJz5yxccgQ2CIvGbE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rtBsJrmnsT+N04h+OFM0hi8oKZQFXjEu/VfhgucCUkVBUgz4NLTGnCQ+U3TjY67UR
	 Cr/mMfwc51sPF4thKXvZe7SD87Jdjr8A6JJkwVPltAAFcMnDW25Hvq6ROL7980phqq
	 asINPwWujULhsznsNu2/e0msLrSBRlHeMSxoA5So/W8DwNR9wjb6JS0jYCVuNczG52
	 O5qGfN45x1D1y1WWTxbSSMbOrsSdvuocWuQsmru6eiY/4qGpDIyzLIBduOEB63nz4+
	 keafCoOXhNqrWzvj3KQ8oDOuDncpmc8POgs1QLjh++H8vxe0uo2FhNxAov3JDQHZaq
	 GeZI4/BG16qow==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 09 May 2026 15:05:37 +0200
Subject: [PATCH net-next v5 12/12] net: airoha: Better handle MIB for GDM
 with multiple port attached
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-airoha-eth-multi-serdes-v5-12-805e38edc2aa@kernel.org>
References: <20260509-airoha-eth-multi-serdes-v5-0-805e38edc2aa@kernel.org>
In-Reply-To: <20260509-airoha-eth-multi-serdes-v5-0-805e38edc2aa@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 2CBCD4FFBC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286181-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Christian Marangi <ansuelsmth@gmail.com>

In the context of a GDM that can have multiple port attached (GDM3/4)
the HW counter (MIB) are global for the GDM port. This cause duplicated
stats reported to the kernel for the related interface.

The SoC supports a split MIB feature where each counter is tracked based
on the relevant HW channel (NBQ) to account for this scenario and
provide a way to select the related counter on accessing the MIB
registers.

Enable this feature for GDM3 and GDM4 and configure the relevant HW
channel before updating the HW stats to report correct HW counter to the
kernel for the related interface.

Also move the stats struct from port to dev since HW counter are
now specific to the network interface instead of the GDM port.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 169 ++++++++++++++++---------------
 drivers/net/ethernet/airoha/airoha_eth.h |   4 +-
 2 files changed, 91 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 623cac42dfb7..b1a658629345 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1621,143 +1621,150 @@ static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 	struct airoha_eth *eth = dev->eth;
 	u32 val, i = 0;
 
-	spin_lock(&port->stats.lock);
-	u64_stats_update_begin(&port->stats.syncp);
+	spin_lock(&dev->stats.lock);
+	u64_stats_update_begin(&dev->stats.syncp);
+
+	/* Read relevant MIB for GDM with multiple port attached */
+	if (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)
+		airoha_fe_rmw(eth, REG_FE_GDM_MIB_CFG(port->id),
+			      FE_TX_MIB_ID_MASK | FE_RX_MIB_ID_MASK,
+			      FIELD_PREP(FE_TX_MIB_ID_MASK, dev->nbq) |
+			      FIELD_PREP(FE_RX_MIB_ID_MASK, dev->nbq));
 
 	/* TX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
-	port->stats.tx_ok_pkts += ((u64)val << 32);
+	dev->stats.tx_ok_pkts += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
-	port->stats.tx_ok_pkts += val;
+	dev->stats.tx_ok_pkts += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
-	port->stats.tx_ok_bytes += ((u64)val << 32);
+	dev->stats.tx_ok_bytes += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
-	port->stats.tx_ok_bytes += val;
+	dev->stats.tx_ok_bytes += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
-	port->stats.tx_drops += val;
+	dev->stats.tx_drops += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
-	port->stats.tx_broadcast += val;
+	dev->stats.tx_broadcast += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
-	port->stats.tx_multicast += val;
+	dev->stats.tx_multicast += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
-	port->stats.tx_len[i] += val;
+	dev->stats.tx_len[i] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	/* RX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
-	port->stats.rx_ok_pkts += ((u64)val << 32);
+	dev->stats.rx_ok_pkts += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
-	port->stats.rx_ok_pkts += val;
+	dev->stats.rx_ok_pkts += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
-	port->stats.rx_ok_bytes += ((u64)val << 32);
+	dev->stats.rx_ok_bytes += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
-	port->stats.rx_ok_bytes += val;
+	dev->stats.rx_ok_bytes += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_DROP_CNT(port->id));
-	port->stats.rx_drops += val;
+	dev->stats.rx_drops += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_BC_CNT(port->id));
-	port->stats.rx_broadcast += val;
+	dev->stats.rx_broadcast += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_MC_CNT(port->id));
-	port->stats.rx_multicast += val;
+	dev->stats.rx_multicast += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ERROR_DROP_CNT(port->id));
-	port->stats.rx_errors += val;
+	dev->stats.rx_errors += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_CRC_ERR_CNT(port->id));
-	port->stats.rx_crc_error += val;
+	dev->stats.rx_crc_error += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OVERFLOW_DROP_CNT(port->id));
-	port->stats.rx_over_errors += val;
+	dev->stats.rx_over_errors += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_FRAG_CNT(port->id));
-	port->stats.rx_fragment += val;
+	dev->stats.rx_fragment += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_JABBER_CNT(port->id));
-	port->stats.rx_jabber += val;
+	dev->stats.rx_jabber += val;
 
 	i = 0;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
-	port->stats.rx_len[i] += val;
+	dev->stats.rx_len[i] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_LONG_CNT(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	/* reset mib counters */
 	airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(port->id),
 		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
 
-	u64_stats_update_end(&port->stats.syncp);
-	spin_unlock(&port->stats.lock);
+	u64_stats_update_end(&dev->stats.syncp);
+	spin_unlock(&dev->stats.lock);
 }
 
 static int airoha_dev_open(struct net_device *netdev)
@@ -1970,6 +1977,11 @@ static int airoha_dev_init(struct net_device *netdev)
 	case AIROHA_GDM4_IDX: {
 		struct airoha_eth *eth = dev->eth;
 
+		/* Enable split MIB for GDM with multiple port attached */
+		airoha_fe_set(eth, REG_FE_GDM_MIB_CFG(port->id),
+			      FE_GDM_TX_MIB_SPLIT_EN_MASK |
+			      FE_GDM_RX_MIB_SPLIT_EN_MASK);
+
 		/* GDM2 supports a single net_device */
 		if (eth->ports[1] && eth->ports[1]->devs[0])
 			break;
@@ -2008,23 +2020,22 @@ static void airoha_dev_get_stats64(struct net_device *netdev,
 				   struct rtnl_link_stats64 *storage)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	unsigned int start;
 
 	airoha_update_hw_stats(dev);
 	do {
-		start = u64_stats_fetch_begin(&port->stats.syncp);
-		storage->rx_packets = port->stats.rx_ok_pkts;
-		storage->tx_packets = port->stats.tx_ok_pkts;
-		storage->rx_bytes = port->stats.rx_ok_bytes;
-		storage->tx_bytes = port->stats.tx_ok_bytes;
-		storage->multicast = port->stats.rx_multicast;
-		storage->rx_errors = port->stats.rx_errors;
-		storage->rx_dropped = port->stats.rx_drops;
-		storage->tx_dropped = port->stats.tx_drops;
-		storage->rx_crc_errors = port->stats.rx_crc_error;
-		storage->rx_over_errors = port->stats.rx_over_errors;
-	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
+		start = u64_stats_fetch_begin(&dev->stats.syncp);
+		storage->rx_packets = dev->stats.rx_ok_pkts;
+		storage->tx_packets = dev->stats.tx_ok_pkts;
+		storage->rx_bytes = dev->stats.rx_ok_bytes;
+		storage->tx_bytes = dev->stats.tx_ok_bytes;
+		storage->multicast = dev->stats.rx_multicast;
+		storage->rx_errors = dev->stats.rx_errors;
+		storage->rx_dropped = dev->stats.rx_drops;
+		storage->tx_dropped = dev->stats.tx_drops;
+		storage->rx_crc_errors = dev->stats.rx_crc_error;
+		storage->rx_over_errors = dev->stats.rx_over_errors;
+	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
 }
 
 static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
@@ -2283,20 +2294,19 @@ static void airoha_ethtool_get_mac_stats(struct net_device *netdev,
 					 struct ethtool_eth_mac_stats *stats)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	unsigned int start;
 
 	airoha_update_hw_stats(dev);
 	do {
-		start = u64_stats_fetch_begin(&port->stats.syncp);
-		stats->FramesTransmittedOK = port->stats.tx_ok_pkts;
-		stats->OctetsTransmittedOK = port->stats.tx_ok_bytes;
-		stats->MulticastFramesXmittedOK = port->stats.tx_multicast;
-		stats->BroadcastFramesXmittedOK = port->stats.tx_broadcast;
-		stats->FramesReceivedOK = port->stats.rx_ok_pkts;
-		stats->OctetsReceivedOK = port->stats.rx_ok_bytes;
-		stats->BroadcastFramesReceivedOK = port->stats.rx_broadcast;
-	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
+		start = u64_stats_fetch_begin(&dev->stats.syncp);
+		stats->FramesTransmittedOK = dev->stats.tx_ok_pkts;
+		stats->OctetsTransmittedOK = dev->stats.tx_ok_bytes;
+		stats->MulticastFramesXmittedOK = dev->stats.tx_multicast;
+		stats->BroadcastFramesXmittedOK = dev->stats.tx_broadcast;
+		stats->FramesReceivedOK = dev->stats.rx_ok_pkts;
+		stats->OctetsReceivedOK = dev->stats.rx_ok_bytes;
+		stats->BroadcastFramesReceivedOK = dev->stats.rx_broadcast;
+	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
 }
 
 static const struct ethtool_rmon_hist_range airoha_ethtool_rmon_ranges[] = {
@@ -2316,8 +2326,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
 			      const struct ethtool_rmon_hist_range **ranges)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
-	struct airoha_hw_stats *hw_stats = &port->stats;
+	struct airoha_hw_stats *hw_stats = &dev->stats;
 	unsigned int start;
 
 	BUILD_BUG_ON(ARRAY_SIZE(airoha_ethtool_rmon_ranges) !=
@@ -2330,7 +2339,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
 	do {
 		int i;
 
-		start = u64_stats_fetch_begin(&port->stats.syncp);
+		start = u64_stats_fetch_begin(&dev->stats.syncp);
 		stats->fragments = hw_stats->rx_fragment;
 		stats->jabbers = hw_stats->rx_jabber;
 		for (i = 0; i < ARRAY_SIZE(airoha_ethtool_rmon_ranges) - 1;
@@ -2338,7 +2347,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
 			stats->hist[i] = hw_stats->rx_len[i];
 			stats->hist_tx[i] = hw_stats->tx_len[i];
 		}
-	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
+	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
 }
 
 static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
@@ -3185,6 +3194,8 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 
 	netdev->dev.of_node = of_node_get(np);
 	dev = netdev_priv(netdev);
+	u64_stats_init(&dev->stats.syncp);
+	spin_lock_init(&dev->stats.lock);
 	dev->dev = netdev;
 	dev->port = port;
 	dev->eth = eth;
@@ -3225,8 +3236,6 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	if (!port)
 		return -ENOMEM;
 
-	u64_stats_init(&port->stats.syncp);
-	spin_lock_init(&port->stats.lock);
 	port->id = id;
 	eth->ports[p] = port;
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 4564a581d138..921d8aa01ac0 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -554,6 +554,8 @@ struct airoha_gdm_dev {
 
 	u32 flags;
 	int nbq;
+
+	struct airoha_hw_stats stats;
 };
 
 struct airoha_gdm_port {
@@ -561,8 +563,6 @@ struct airoha_gdm_port {
 	int id;
 	int users;
 
-	struct airoha_hw_stats stats;
-
 	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
 };
 

-- 
2.54.0


