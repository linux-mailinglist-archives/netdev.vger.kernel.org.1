Return-Path: <netdev+bounces-286175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDwyJFcx/2lb3QAAu9opvQ
	(envelope-from <netdev+bounces-286175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:06:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 127B84FFBB6
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 680D8301E9A6
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E6388E5B;
	Sat,  9 May 2026 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC4PVVPB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95E34A79D;
	Sat,  9 May 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778331970; cv=none; b=KUVkgJEJ2EcmPOUGP5Bkn+PRXT20kBbXibRN/Z5+uqNp0wNyAi8pSLCblJdLBZjWk22sbcEbzxLbD/8DyC3TXjFIUeLOMUBGt3drysBGky0xbDXcQCbO60+qowe/BTSkiqkbnrkLLm8aCAZuC8gHsiKzXuU2iefnQNWNtiP6SW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778331970; c=relaxed/simple;
	bh=JBu/pFDd+voohNzFYglle2gQXZmQlnyxgdMRxiXi4VY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UhNSQUK7bni94AG8RvgSyQp0xFvQli6s+EGKnTzz7Odhp5kkc44bScJ2P7jer3NKKZRbyBBjewEk5gtwKBwP6z/zw3U410ureuvcrArMeRtu5ouxFCwldawZyBTFdlXqQtSut2f4xw2TbyGylAKilS8UoIjsv9cmuPMEa0ZmL14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC4PVVPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186C0C2BCC7;
	Sat,  9 May 2026 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778331969;
	bh=JBu/pFDd+voohNzFYglle2gQXZmQlnyxgdMRxiXi4VY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lC4PVVPBLoeKcia8HT3X1Wmgn+bgat7xq+udY6tQZNmHCwHGl6XvN8U/wwFNLB19Q
	 loiFIYxryxFT8ei6wvZRNKvBGVBjbKuYXJDeMgepBgrS0B2lj9B7/7wurqnWJ+nNvI
	 NLtuNCgomv0D87iFVSSFQT1Fh8o92mLGx1a8mxJCm+Ahlr2RfUpd+NsquwzY7+HA2h
	 fJ90sEjaAbyqfHwd4H342PsdTv6YMnCXU7Fhxd0BOuItBQyxLW4+UHxgsWP1Q8mExP
	 q0iTV2Q8DSbwJ4lYaAf7r9EH4kWuz16t6ldXZdB/i5LD8DyKCwKV5geIEt3+tq5jlF
	 njz0Jb9TysK1g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 09 May 2026 15:05:31 +0200
Subject: [PATCH net-next v5 06/12] net: airoha: Move qos_sq_bmap in
 airoha_gdm_dev struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-airoha-eth-multi-serdes-v5-6-805e38edc2aa@kernel.org>
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
X-Rspamd-Queue-Id: 127B84FFBB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286175-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Since now multiple net_devices connected to different QDMA blocks can
share the same GDM port, qos_sq_bmap field can be overwritten with the
configuration obtained from a net_device connected to a different QDMA
block. In order to fix the issue move qos_sq_bmap field from
airoha_gdm_port struct to airoha_gdm_dev one.
Add qos_channel_map bitmap in airoha_qdma struct to track if a shared
QDMA channel is already in use by another net_device.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 65 ++++++++++++++++++++++----------
 drivers/net/ethernet/airoha/airoha_eth.h |  6 ++-
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index f9cb49f0529a..33a0f7b98d52 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2606,19 +2606,28 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
 	int err, num_tx_queues = netdev->real_num_tx_queues;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	struct airoha_qdma *qdma = dev->qdma;
 
 	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
 		return -EINVAL;
 	}
 
+	/* Here we need to check the requested QDMA channel is not already
+	 * in use by another net_device running on the same QDMA block.
+	 */
+	if (test_and_set_bit(channel, qdma->qos_channel_map)) {
+		NL_SET_ERR_MSG_MOD(opt->extack,
+				   "qdma qos channel already in use");
+		return -EBUSY;
+	}
+
 	err = airoha_qdma_set_tx_rate_limit(netdev, channel, rate,
 					    opt->quantum);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(opt->extack,
 				   "failed configuring htb offload");
-		return err;
+		goto error;
 	}
 
 	if (opt->command == TC_HTB_NODE_MODIFY)
@@ -2630,13 +2639,17 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 					      opt->quantum);
 		NL_SET_ERR_MSG_MOD(opt->extack,
 				   "failed setting real_num_tx_queues");
-		return err;
+		goto error;
 	}
 
-	set_bit(channel, port->qos_sq_bmap);
+	set_bit(channel, dev->qos_sq_bmap);
 	opt->qid = AIROHA_NUM_TX_RING + channel;
 
 	return 0;
+error:
+	clear_bit(channel, qdma->qos_channel_map);
+
+	return err;
 }
 
 static int airoha_qdma_set_rx_meter(struct airoha_gdm_dev *dev,
@@ -2814,14 +2827,28 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
 	}
 }
 
-static void airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
+static int airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	struct airoha_qdma *qdma = dev->qdma;
+	int err;
 
-	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
-	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
-	clear_bit(queue, port->qos_sq_bmap);
+	err = netif_set_real_num_tx_queues(netdev,
+					   netdev->real_num_tx_queues - 1);
+	if (err)
+		return err;
+
+	err = airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
+	if (err) {
+		netif_set_real_num_tx_queues(netdev,
+					     netdev->real_num_tx_queues + 1);
+		return err;
+	}
+
+	clear_bit(queue, qdma->qos_channel_map);
+	clear_bit(queue, dev->qos_sq_bmap);
+
+	return 0;
 }
 
 static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
@@ -2829,26 +2856,27 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 
-	if (!test_bit(channel, port->qos_sq_bmap)) {
+	if (!test_bit(channel, dev->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
 		return -EINVAL;
 	}
 
-	airoha_tc_remove_htb_queue(netdev, channel);
-
-	return 0;
+	return airoha_tc_remove_htb_queue(netdev, channel);
 }
 
 static int airoha_tc_htb_destroy(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	int q;
 
-	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
-		airoha_tc_remove_htb_queue(netdev, q);
+	for_each_set_bit(q, dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS) {
+		int err;
+
+		err = airoha_tc_remove_htb_queue(netdev, q);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
@@ -2858,9 +2886,8 @@ static int airoha_tc_get_htb_get_leaf_queue(struct net_device *netdev,
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 
-	if (!test_bit(channel, port->qos_sq_bmap)) {
+	if (!test_bit(channel, dev->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index c038e722370e..475f5c64bfcb 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -532,6 +532,8 @@ struct airoha_qdma {
 
 	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
 	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
+
+	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
 };
 
 struct airoha_gdm_dev {
@@ -539,6 +541,8 @@ struct airoha_gdm_dev {
 	struct airoha_qdma *qdma;
 	struct net_device *dev;
 	struct airoha_eth *eth;
+
+	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
 };
 
 struct airoha_gdm_port {
@@ -548,8 +552,6 @@ struct airoha_gdm_port {
 
 	struct airoha_hw_stats stats;
 
-	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
-
 	/* qos stats counters */
 	u64 cpu_tx_packets;
 	u64 fwd_tx_packets;

-- 
2.54.0


