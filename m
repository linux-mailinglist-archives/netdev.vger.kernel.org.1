Return-Path: <netdev+bounces-289341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGoLMosoDGq/XgUAu9opvQ
	(envelope-from <netdev+bounces-289341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DF057AE9F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 030E4309957B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C023F6C5F;
	Tue, 19 May 2026 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTgwWEbw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F50E3F65F7;
	Tue, 19 May 2026 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181113; cv=none; b=XeAc+R5AS5gsZSfhj88+VYdXB9hWbvHX0oOucOFt3M6RjRXe9sicmhuOh1k95jJYCmCsNyZo/79jtH2Rd4FW39xYjckO+mczLcsI99ZdX8TO2W2Ve0NJQzt66CR1bsISE4EMmHsECYNKMQsVjKLA3AfJzDbrA40lWdzDlKk2KOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181113; c=relaxed/simple;
	bh=PYjKbAzL9TGggPm3kjc7214y/9EFSBkPL8WaWAvWkdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8SP7uAamPsHSymVq8izpHLT6/PvrEtRRFyD9ddQ4V5gqd3j7h4l/GaF41Bf1qlB56KNUYTMi29CJUdXKg/1U3AIock1zH157vcj6s/oSpIrvA/0TkuOOU2eWzkRQrW8H3Fs4shnU91PlRp45emP6JQv5V4ewS96l3UFPY+f4Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTgwWEbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F6CC2BCF6;
	Tue, 19 May 2026 08:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779181113;
	bh=PYjKbAzL9TGggPm3kjc7214y/9EFSBkPL8WaWAvWkdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NTgwWEbwKhOCES0wzU6h8ZgP8wxViEr+HTq+DquS00KhmWlCu9coCTrC4BAwXSyCs
	 awfUOZIcs5iyaCTqU2A4HAY39gfKr+XEZj4y3GpIUAcrOagoJ4lwLU6W3RRQp9KqFO
	 c4IUq0jEwNFMRjiiLAhLGYl+tv6OUVQXlIKlfVsfBtrrGlpoyh0PiwdFFDC2wMOKwT
	 xjN/WwDubUX2Si3rfNCr4byug9ShooDdz5F6DzaqTSZ8VoTbZyCkdIf6pD67NuRi+Z
	 gTjo9lQ5MZdnwHFedvZ66A7cBsj1w+6ayHq3SK1xpMFffa+LVAcp0fCHN2WohqrLTi
	 N2zi1XTRzqrcg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 19 May 2026 10:57:48 +0200
Subject: [PATCH net-next v8 05/10] net: airoha: Move qos_sq_bmap in
 airoha_gdm_dev struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-airoha-eth-multi-serdes-v8-5-6bd70e329df6@kernel.org>
References: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
In-Reply-To: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289341-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 66DF057AE9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since now multiple net_devices connected to different QDMA blocks can
share the same GDM port, qos_sq_bmap field can be overwritten with the
configuration obtained from a net_device connected to a different QDMA
block. In order to fix the issue move qos_sq_bmap field from
airoha_gdm_port struct to airoha_gdm_dev one.
Add qos_channel_map bitmap in airoha_qdma struct to track if a shared
QDMA channel is already in use by another net_device.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 58 ++++++++++++++++++++------------
 drivers/net/ethernet/airoha/airoha_eth.h |  6 ++--
 2 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 847f432b0a2b..594fbebcb12c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2600,30 +2600,40 @@ static int airoha_qdma_set_tx_rate_limit(struct net_device *netdev,
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
@@ -2631,13 +2641,17 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
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
@@ -2818,11 +2832,13 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
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
@@ -2830,9 +2846,8 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 
-	if (!test_bit(channel, port->qos_sq_bmap)) {
+	if (!test_bit(channel, dev->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
 		return -EINVAL;
 	}
@@ -2845,10 +2860,9 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 static int airoha_tc_htb_destroy(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	int q;
 
-	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
+	for_each_set_bit(q, dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
 		airoha_tc_remove_htb_queue(netdev, q);
 
 	return 0;
@@ -2859,9 +2873,8 @@ static int airoha_tc_get_htb_get_leaf_queue(struct net_device *netdev,
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 
-	if (!test_bit(channel, port->qos_sq_bmap)) {
+	if (!test_bit(channel, dev->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
 		return -EINVAL;
 	}
@@ -2880,6 +2893,7 @@ static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
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


