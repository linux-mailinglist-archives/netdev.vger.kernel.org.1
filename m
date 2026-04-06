Return-Path: <netdev+bounces-275560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDjhDluM02nFiwcAu9opvQ
	(envelope-from <netdev+bounces-275560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:35:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9063A2D5E
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B6973006789
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FEF32AAAB;
	Mon,  6 Apr 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSYT2jz2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DA3290DB;
	Mon,  6 Apr 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471704; cv=none; b=p1rs+jPSMe9ECycuR0K1VXB39rcdXSJlk8/4piEJHaW3il7DCRp+m5dYhUX+bVDihOWn9u7QpQBX5a8D+iKLtrMPR2l2AW5ztxTNsBwRqo4CAUmgkqYi3XDPLR9W2Jg9MYpIKKvixALBVpWnYgU4FVywrwdZY9LVre7JKgkJqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471704; c=relaxed/simple;
	bh=hmPB/nEOluY6Q5mv9fsfLC1lS8aApTFJmLoH2BfAk+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSLIl8dftFj3r61CFLBcVdu6TnILupYVTJhhzXENc2/7pIRMLCl4VghkfJ+un0ktfd6YiAzw5DOUfoYGSOPuTCpyBb2djCw6A10xX6aJRwCz4jJBZarVJrrt9InKsbEGRLw4VC70FdPX9PFdbwhYmxGmlLgd5c76+t/Le8b/Nws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSYT2jz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD479C2BCB0;
	Mon,  6 Apr 2026 10:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471704;
	bh=hmPB/nEOluY6Q5mv9fsfLC1lS8aApTFJmLoH2BfAk+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rSYT2jz28FFzt6QsatvNInHpKKhlh6QZrSrNvHCVNjRzN9UfSnKjUUTej/6ocHeBZ
	 YOh6HeJpjxdjWcOLScK4OPSLXjIl46lSqziPt4Adhskb5AvDbOEMoPYB16XaveUnzF
	 qx5zGn8F0WBY8mfV6QGgkx5Fg10Oc5u3EEGsV7OLvVGz01+oTiu5wkSdvd5j7gw4SG
	 CTZiy+G/VBtEANloB0FZaewZjREvQNX+KrSPZSdHjRH7KlsPRpuhntGGUBkE+R238l
	 mgkOAi6s0f/+VmXJUtpbX5lVDJfxEAR4yr2ccps0YVxRLyWb61HqjTz3lQdQ2qyWAV
	 zl1DgRleU2G0Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 06 Apr 2026 12:34:10 +0200
Subject: [PATCH net-next v3 05/12] net: airoha: Rely on net_device pointer
 in ETS callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-airoha-eth-multi-serdes-v3-5-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275560-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email]
X-Rspamd-Queue-Id: 1B9063A2D5E
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
index 8dc50d60f136..d67d844b788b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2143,10 +2143,11 @@ airoha_ethtool_get_rmon_stats(struct net_device *dev,
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
-static int airoha_qdma_set_chan_tx_sched(struct airoha_gdm_port *port,
+static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
 					 int channel, enum tx_sched_mode mode,
 					 const u16 *weights, u8 n_weights)
 {
+	struct airoha_gdm_port *port = netdev_priv(netdev);
 	int i;
 
 	for (i = 0; i < AIROHA_NUM_TX_RING; i++)
@@ -2178,17 +2179,15 @@ static int airoha_qdma_set_chan_tx_sched(struct airoha_gdm_port *port,
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
@@ -2229,14 +2228,15 @@ static int airoha_qdma_set_tx_ets_sched(struct airoha_gdm_port *port,
 	else if (nstrict < AIROHA_NUM_QOS_QUEUES - 1)
 		mode = nstrict + 1;
 
-	return airoha_qdma_set_chan_tx_sched(port, channel, mode, w,
+	return airoha_qdma_set_chan_tx_sched(dev, channel, mode, w,
 					     ARRAY_SIZE(w));
 }
 
-static int airoha_qdma_get_tx_ets_stats(struct airoha_gdm_port *port,
-					int channel,
+static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
 					struct tc_ets_qopt_offload *opt)
 {
+	struct airoha_gdm_port *port = netdev_priv(netdev);
+
 	u64 cpu_tx_packets = airoha_qdma_rr(port->qdma,
 					    REG_CNTR_VAL(channel << 1));
 	u64 fwd_tx_packets = airoha_qdma_rr(port->qdma,
@@ -2251,7 +2251,7 @@ static int airoha_qdma_get_tx_ets_stats(struct airoha_gdm_port *port,
 	return 0;
 }
 
-static int airoha_tc_setup_qdisc_ets(struct airoha_gdm_port *port,
+static int airoha_tc_setup_qdisc_ets(struct net_device *dev,
 				     struct tc_ets_qopt_offload *opt)
 {
 	int channel;
@@ -2264,12 +2264,12 @@ static int airoha_tc_setup_qdisc_ets(struct airoha_gdm_port *port,
 
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
@@ -2814,11 +2814,9 @@ static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
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


