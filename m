Return-Path: <netdev+bounces-277851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBQuBfTT22m7HAkAu9opvQ
	(envelope-from <netdev+bounces-277851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:18:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6534B3E50DC
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58B44302ED55
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7873313E38;
	Sun, 12 Apr 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7VwjRcK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785F313E24
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776014024; cv=none; b=WRtkJvKDeHylpPNgOUEB/cM04cEdkzkoyUFG606UG7LEfRAZ4/2JKYVuUzXKASV1nBcoSx11eZGopg3nHaPajs9rzAp5bB8z6YCciGPYV2JdBrlFlDEueBOU0Qx0wRPms9y3XoaSXYejdVmlg1N1F1Cmwaef0Vx5Xl8B3pzWld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776014024; c=relaxed/simple;
	bh=BwXzSKo8O6XZ4uKlUSwMzQY2fTA/0n/oxvStx7Ka5oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlMCsKB66aGPpUEjyCfI+fIZu6C1Bhoco9MWjER9OlZr+8Xb4PkfYUA02TbXfD3vOrcm8FmO/k7OnSz6y7RBDvlzuy7RMTmi3EvDaNF6MDX9bDiCmNjwNW+wnFX8/ogqYm55+obNODsRLFYo5vkq2fq/LPlBima11Mh+5YW3NYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7VwjRcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8228C19424;
	Sun, 12 Apr 2026 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776014024;
	bh=BwXzSKo8O6XZ4uKlUSwMzQY2fTA/0n/oxvStx7Ka5oM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g7VwjRcKwFy7gc7X/oa6VeIRpU4Tk/HA1FXGoi5k9c4RH3PiLaA36raLAJw6wnO24
	 WgouBjti2v0hnGvVCwXQuMVwLf0nUvk/PsuZp8cPZVyEWhAtdeu6t/PqpoH3G0l51H
	 K/zt9lTBgho3rsapudLiFwFuAqFtvTkP8LNNwJh+LrA+9eCnAsXs4MTJ0YaI3M8ho3
	 pY/NT5vTdsnkgfRPY6C7X7Ap/0lU2DhItyRBXs07VlQwsEu/3X32ZU/6BGCjfhmB3v
	 Vx87RG4SMWw8uSfKJO/FqvhcDvZc6nnZKwkqVC+VCFIV8jq/S1npptrGx3jF0KksFF
	 y8AfL9AhvIOiQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 12 Apr 2026 19:13:14 +0200
Subject: [PATCH net-next 3/3] net: airoha: Rely on net_device pointer in
 ETS callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-airoha-multi-serdes-preliminary-patch-v1-3-08d5b670ca8f@kernel.org>
References: <20260412-airoha-multi-serdes-preliminary-patch-v1-0-08d5b670ca8f@kernel.org>
In-Reply-To: <20260412-airoha-multi-serdes-preliminary-patch-v1-0-08d5b670ca8f@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277851-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6534B3E50DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove airoha_gdm_port dependency in ETS tc callback signatures and rely
on net_device pointer instead. Please note this patch does not introduce
any logical change and it is a preliminary patch in order to support
multiple net_devices connected to the same GDM3 or GDM4 port via an
external hw arbiter.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c2b5fcffce82..d426dc173d99 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2138,10 +2138,11 @@ airoha_ethtool_get_rmon_stats(struct net_device *dev,
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
-static int airoha_qdma_set_chan_tx_sched(struct airoha_gdm_port *port,
+static int airoha_qdma_set_chan_tx_sched(struct net_device *dev,
 					 int channel, enum tx_sched_mode mode,
 					 const u16 *weights, u8 n_weights)
 {
+	struct airoha_gdm_port *port = netdev_priv(dev);
 	int i;
 
 	for (i = 0; i < AIROHA_NUM_TX_RING; i++)
@@ -2173,17 +2174,15 @@ static int airoha_qdma_set_chan_tx_sched(struct airoha_gdm_port *port,
 	return 0;
 }
 
-static int airoha_qdma_set_tx_prio_sched(struct airoha_gdm_port *port,
-					 int channel)
+static int airoha_qdma_set_tx_prio_sched(struct net_device *dev, int channel)
 {
 	static const u16 w[AIROHA_NUM_QOS_QUEUES] = {};
 
-	return airoha_qdma_set_chan_tx_sched(port, channel, TC_SCH_SP, w,
+	return airoha_qdma_set_chan_tx_sched(dev, channel, TC_SCH_SP, w,
 					     ARRAY_SIZE(w));
 }
 
-static int airoha_qdma_set_tx_ets_sched(struct airoha_gdm_port *port,
-					int channel,
+static int airoha_qdma_set_tx_ets_sched(struct net_device *dev, int channel,
 					struct tc_ets_qopt_offload *opt)
 {
 	struct tc_ets_qopt_offload_replace_params *p = &opt->replace_params;
@@ -2224,20 +2223,21 @@ static int airoha_qdma_set_tx_ets_sched(struct airoha_gdm_port *port,
 	else if (nstrict < AIROHA_NUM_QOS_QUEUES - 1)
 		mode = nstrict + 1;
 
-	return airoha_qdma_set_chan_tx_sched(port, channel, mode, w,
+	return airoha_qdma_set_chan_tx_sched(dev, channel, mode, w,
 					     ARRAY_SIZE(w));
 }
 
-static int airoha_qdma_get_tx_ets_stats(struct airoha_gdm_port *port,
-					int channel,
+static int airoha_qdma_get_tx_ets_stats(struct net_device *dev, int channel,
 					struct tc_ets_qopt_offload *opt)
 {
+	struct airoha_gdm_port *port = netdev_priv(dev);
 	u64 cpu_tx_packets = airoha_qdma_rr(port->qdma,
 					    REG_CNTR_VAL(channel << 1));
 	u64 fwd_tx_packets = airoha_qdma_rr(port->qdma,
 					    REG_CNTR_VAL((channel << 1) + 1));
 	u64 tx_packets = (cpu_tx_packets - port->cpu_tx_packets) +
 			 (fwd_tx_packets - port->fwd_tx_packets);
+
 	_bstats_update(opt->stats.bstats, 0, tx_packets);
 
 	port->cpu_tx_packets = cpu_tx_packets;
@@ -2246,7 +2246,7 @@ static int airoha_qdma_get_tx_ets_stats(struct airoha_gdm_port *port,
 	return 0;
 }
 
-static int airoha_tc_setup_qdisc_ets(struct airoha_gdm_port *port,
+static int airoha_tc_setup_qdisc_ets(struct net_device *dev,
 				     struct tc_ets_qopt_offload *opt)
 {
 	int channel;
@@ -2259,12 +2259,12 @@ static int airoha_tc_setup_qdisc_ets(struct airoha_gdm_port *port,
 
 	switch (opt->command) {
 	case TC_ETS_REPLACE:
-		return airoha_qdma_set_tx_ets_sched(port, channel, opt);
+		return airoha_qdma_set_tx_ets_sched(dev, channel, opt);
 	case TC_ETS_DESTROY:
 		/* PRIO is default qdisc scheduler */
-		return airoha_qdma_set_tx_prio_sched(port, channel);
+		return airoha_qdma_set_tx_prio_sched(dev, channel);
 	case TC_ETS_STATS:
-		return airoha_qdma_get_tx_ets_stats(port, channel, opt);
+		return airoha_qdma_get_tx_ets_stats(dev, channel, opt);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2807,11 +2807,9 @@ static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
 static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
 			       void *type_data)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
-
 	switch (type) {
 	case TC_SETUP_QDISC_ETS:
-		return airoha_tc_setup_qdisc_ets(port, type_data);
+		return airoha_tc_setup_qdisc_ets(dev, type_data);
 	case TC_SETUP_QDISC_HTB:
 		return airoha_tc_setup_qdisc_htb(dev, type_data);
 	case TC_SETUP_BLOCK:

-- 
2.53.0


