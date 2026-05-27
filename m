Return-Path: <netdev+bounces-292248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPMnG5vGFmpVrwcAu9opvQ
	(envelope-from <netdev+bounces-292248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:25:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8E45E2A67
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26F3E3059A66
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3AA3EFFD0;
	Wed, 27 May 2026 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT07KvBu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD8E3E00BC
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877306; cv=none; b=n0olTaFKBGROxVDk1KLqbZL2IQipDn9sPZknbeJS0ETPE7hRoMp20HTixuxeXbQ9d5FWCRh3t44oFVv9Zjr1kd5h8LcnmwdyFKNWMFqNQ9h+X5s7GNCskN3hYUawfytGvtUTCpz1kAhzVtusMW/uSP8MRiksIukUv4XLfcRSAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877306; c=relaxed/simple;
	bh=5DjhvolDUbBoQ6d/isDTmjem/Q3bhqNPb4oQu1Njaoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3cAyAw1PRKcaafy1lW02+mB3OUdDiukdBN8ZUp4G9MhFE/VesZP2C+pYyqVDcSuOjJt9duX1j7z1wyGJIjkTuwZX561SlAIBKDcV2T+VwRNnTVCRY/cLlkBXlH1JlB0deVlbzm5hehONsWbGMtXvqRjM6ECs3vkFf+BGc4JLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT07KvBu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED631F00A3E;
	Wed, 27 May 2026 10:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779877303;
	bh=MntI+JlZcyWrHkdgyRbc4OVZeOcOUsQE+81qxPdcZlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mT07KvBu7d4tbN0yVuEXKuE+m9E3ZJ4r3Ta0alz5uEPhKx27iphlWR0scuEeFR3jF
	 7H5QqiHDb9BMn0Abphy2yCCkWHhZBzoXt+XX5wRPOSSKa3xRHeVWup1kHQ9kCpIiMR
	 VtOmiYw0jql1KtU5l9aK9RmKLXe26QFW8P/cs9SubaMchDzc5FFuBjov+YlOMQfR3J
	 6a/pods6wTfr5a4aYCwPKlh7byPSnOzEnIMb95HKf5ELmJYck8Ti0CFotrrYPgppVd
	 NTp5QuW3nsx+7DMNaMy6c/O8yAV6bktZUWf7IW7T1+2wEdCrI5oJbkG8f9sns4c8ya
	 T7Z2y2I4oBvaA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 27 May 2026 12:21:18 +0200
Subject: [PATCH net-next 4/6] net: airoha: Move qos_sq_bmap in
 airoha_gdm_dev struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-airoha-eth-multi-serdes-preliminary-v1-4-ec6ed73ef7fc@kernel.org>
References: <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
In-Reply-To: <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292248-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DB8E45E2A67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since now multiple net_devices connected to different QDMA blocks can
share the same GDM port, qos_sq_bmap field can be overwritten with the
configuration obtained from a net_device connected to a different QDMA
block. In order to fix the issue move qos_sq_bmap field from
airoha_gdm_port struct to airoha_gdm_dev one.
Add qos_channel_map bitmap in airoha_qdma struct to track if a shared
QDMA channel is already in use by another net_device.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 58 ++++++++++++++++++++------------
 drivers/net/ethernet/airoha/airoha_eth.h |  6 ++--
 2 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c5d25f7640ac..4f77a0c22162 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2602,30 +2602,40 @@ static int airoha_qdma_set_tx_rate_limit(struct net_device *netdev,
 	return 0;
 }
 
-static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
-					  struct tc_htb_qopt_offload *opt)
+static int airoha_tc_htb_modify_queue(struct net_device *dev,
+				      struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
-	int err, num_tx_queues = netdev->real_num_tx_queues;
-	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 
 	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
 		return -EINVAL;
 	}
 
-	err = airoha_qdma_set_tx_rate_limit(netdev, channel, rate,
-					    opt->quantum);
-	if (err) {
+	return airoha_qdma_set_tx_rate_limit(dev, channel, rate, opt->quantum);
+}
+
+static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
+					  struct tc_htb_qopt_offload *opt)
+{
+	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
+	int err, num_tx_queues = netdev->real_num_tx_queues;
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_qdma *qdma = dev->qdma;
+
+	/* Here we need to check the requested QDMA channel is not already
+	 * in use by another net_device running on the same QDMA block.
+	 */
+	if (test_and_set_bit(channel, qdma->qos_channel_map)) {
 		NL_SET_ERR_MSG_MOD(opt->extack,
-				   "failed configuring htb offload");
-		return err;
+				   "qdma qos channel already in use");
+		return -EBUSY;
 	}
 
-	if (opt->command == TC_HTB_NODE_MODIFY)
-		return 0;
+	err = airoha_tc_htb_modify_queue(netdev, opt);
+	if (err)
+		goto error;
 
 	err = netif_set_real_num_tx_queues(netdev, num_tx_queues + 1);
 	if (err) {
@@ -2633,13 +2643,17 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
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
@@ -2820,11 +2834,13 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
 static void airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	struct airoha_qdma *qdma = dev->qdma;
 
 	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
 	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
-	clear_bit(queue, port->qos_sq_bmap);
+
+	clear_bit(queue, qdma->qos_channel_map);
+	clear_bit(queue, dev->qos_sq_bmap);
 }
 
 static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
@@ -2832,9 +2848,8 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 
-	if (!test_bit(channel, port->qos_sq_bmap)) {
+	if (!test_bit(channel, dev->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
 		return -EINVAL;
 	}
@@ -2847,10 +2862,9 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 static int airoha_tc_htb_destroy(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	int q;
 
-	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
+	for_each_set_bit(q, dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
 		airoha_tc_remove_htb_queue(netdev, q);
 
 	return 0;
@@ -2861,9 +2875,8 @@ static int airoha_tc_get_htb_get_leaf_queue(struct net_device *netdev,
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 
-	if (!test_bit(channel, port->qos_sq_bmap)) {
+	if (!test_bit(channel, dev->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
 		return -EINVAL;
 	}
@@ -2882,6 +2895,7 @@ static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
 	case TC_HTB_DESTROY:
 		return airoha_tc_htb_destroy(dev);
 	case TC_HTB_NODE_MODIFY:
+		return airoha_tc_htb_modify_queue(dev, opt);
 	case TC_HTB_LEAF_ALLOC_QUEUE:
 		return airoha_tc_htb_alloc_leaf_queue(dev, opt);
 	case TC_HTB_LEAF_DEL:
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index f6f59d25abd9..a308a770116b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -533,6 +533,8 @@ struct airoha_qdma {
 
 	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
 	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
+
+	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
 };
 
 struct airoha_gdm_dev {
@@ -540,6 +542,8 @@ struct airoha_gdm_dev {
 	struct airoha_qdma *qdma;
 	struct net_device *dev;
 	struct airoha_eth *eth;
+
+	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
 };
 
 struct airoha_gdm_port {
@@ -549,8 +553,6 @@ struct airoha_gdm_port {
 
 	struct airoha_hw_stats stats;
 
-	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
-
 	/* qos stats counters */
 	u64 cpu_tx_packets;
 	u64 fwd_tx_packets;

-- 
2.54.0


