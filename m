Return-Path: <netdev+bounces-272895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDR0LFMkyWm/vAUAu9opvQ
	(envelope-from <netdev+bounces-272895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:08:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D307835215E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC82330055E1
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8586A36F400;
	Sun, 29 Mar 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCb4W0pV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E6433AD;
	Sun, 29 Mar 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789703; cv=none; b=evGyZVCtcHOUaZiwOGAB7L5ka5/ZkzuFdgGX7f67pYYlYwU2CxQw8IDpDBqwN4v/83pL/2tvATXkNhOhA11zQT4KHwfOOZVFYGcRZjOJ0nYeUMWeBn7Yxm1HC95DQtU4L7NCdEZOKzJ/SB9YhrdnDl2iG8fqM14qDqUt7G32nBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789703; c=relaxed/simple;
	bh=a6VHtOoX2yN5lMHt15TWZ/7eg1zEgvzORhqP9bJw0rM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gOtCg3urx5wMMfh4fpSzrMwlxreJkH5IeehvRgkoVgC8yju4qQ2grgMSaTJagIS83SKZG1X97MhOrYOt6xtKhglhP5dFoI3jqtpawvK2JnBAjPqFFiYT1Q3XIbhx0LcgyoTzkAUdqPn7A2x8r3udVRd6Ea8UDmFDiZcGdwo1PIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCb4W0pV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94CCC116C6;
	Sun, 29 Mar 2026 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774789703;
	bh=a6VHtOoX2yN5lMHt15TWZ/7eg1zEgvzORhqP9bJw0rM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kCb4W0pVdXHLZdLgvLMDh3RODDcjAHXkfaO231hwApwY8+MMs6firSQFejDSHCd9U
	 qGDkFAZfvJuhU99/bx0/mgKl++vBrtDCVZXdyN2O+IK8Cn3TLGNlQSuuVthHNUUOcf
	 N2ZcEFIJP0rTEvJd2ee9g+dwUSFkbj1ozrRP5IRmEjcFLiYFhhrIlqTa8+Gwfs2/MP
	 ZwBoZE1duTbKAXTqlDVMmgZKn0uGX3dNU10wFiTi4lKZ1cqlJZUybGqHyWFjqbnhRr
	 CKneAR0VmCmToiEasebF8RBaof5bqT4ybKvGA9UgfZO88KCKjOa3UjUoKWTpM6//Li
	 +GXOCRO0nSAjg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 29 Mar 2026 15:07:53 +0200
Subject: [PATCH net-next 03/10] net: airoha: Rely on net_device pointer in
 HTB callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-airoha-eth-multi-serdes-v1-3-00f52dc360ca@kernel.org>
References: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
In-Reply-To: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272895-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D307835215E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove airoha_gdm_port dependency in HTB tc callback signatures and rely
on net_device pointer instead. Please note this patch does not introduce
any logical change and it is a preliminary patch in order to support
multiple net_devices connected to the same GDM3 or GDM4 port via an
external hw multiplexer.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 51 ++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 421a154ee7189eb7919382b6cd893ae5d4e03766..e8d4fdbc990195e4b0121ae591066e4fc11ab647 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2476,10 +2476,11 @@ static int airoha_qdma_set_trtcm_token_bucket(struct airoha_qdma *qdma,
 					   mode, val);
 }
 
-static int airoha_qdma_set_tx_rate_limit(struct airoha_gdm_port *port,
+static int airoha_qdma_set_tx_rate_limit(struct net_device *netdev,
 					 int channel, u32 rate,
 					 u32 bucket_size)
 {
+	struct airoha_gdm_port *port = netdev_priv(netdev);
 	int i, err;
 
 	for (i = 0; i <= TRTCM_PEAK_MODE; i++) {
@@ -2499,21 +2500,21 @@ static int airoha_qdma_set_tx_rate_limit(struct airoha_gdm_port *port,
 	return 0;
 }
 
-static int airoha_tc_htb_alloc_leaf_queue(struct airoha_gdm_port *port,
+static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 					  struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
-	struct net_device *dev = port->dev;
-	int num_tx_queues = dev->real_num_tx_queues;
-	int err;
+	int err, num_tx_queues = netdev->real_num_tx_queues;
+	struct airoha_gdm_port *port = netdev_priv(netdev);
 
 	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
 		return -EINVAL;
 	}
 
-	err = airoha_qdma_set_tx_rate_limit(port, channel, rate, opt->quantum);
+	err = airoha_qdma_set_tx_rate_limit(netdev, channel, rate,
+					    opt->quantum);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(opt->extack,
 				   "failed configuring htb offload");
@@ -2523,9 +2524,10 @@ static int airoha_tc_htb_alloc_leaf_queue(struct airoha_gdm_port *port,
 	if (opt->command == TC_HTB_NODE_MODIFY)
 		return 0;
 
-	err = netif_set_real_num_tx_queues(dev, num_tx_queues + 1);
+	err = netif_set_real_num_tx_queues(netdev, num_tx_queues + 1);
 	if (err) {
-		airoha_qdma_set_tx_rate_limit(port, channel, 0, opt->quantum);
+		airoha_qdma_set_tx_rate_limit(netdev, channel, 0,
+					      opt->quantum);
 		NL_SET_ERR_MSG_MOD(opt->extack,
 				   "failed setting real_num_tx_queues");
 		return err;
@@ -2712,44 +2714,47 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
 	}
 }
 
-static void airoha_tc_remove_htb_queue(struct airoha_gdm_port *port, int queue)
+static void airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
 {
-	struct net_device *dev = port->dev;
+	struct airoha_gdm_port *port = netdev_priv(netdev);
 
-	netif_set_real_num_tx_queues(dev, dev->real_num_tx_queues - 1);
-	airoha_qdma_set_tx_rate_limit(port, queue + 1, 0, 0);
+	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
+	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
 	clear_bit(queue, port->qos_sq_bmap);
 }
 
-static int airoha_tc_htb_delete_leaf_queue(struct airoha_gdm_port *port,
+static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 					   struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
+	struct airoha_gdm_port *port = netdev_priv(netdev);
 
 	if (!test_bit(channel, port->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
 		return -EINVAL;
 	}
 
-	airoha_tc_remove_htb_queue(port, channel);
+	airoha_tc_remove_htb_queue(netdev, channel);
 
 	return 0;
 }
 
-static int airoha_tc_htb_destroy(struct airoha_gdm_port *port)
+static int airoha_tc_htb_destroy(struct net_device *netdev)
 {
+	struct airoha_gdm_port *port = netdev_priv(netdev);
 	int q;
 
 	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
-		airoha_tc_remove_htb_queue(port, q);
+		airoha_tc_remove_htb_queue(netdev, q);
 
 	return 0;
 }
 
-static int airoha_tc_get_htb_get_leaf_queue(struct airoha_gdm_port *port,
+static int airoha_tc_get_htb_get_leaf_queue(struct net_device *netdev,
 					    struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
+	struct airoha_gdm_port *port = netdev_priv(netdev);
 
 	if (!test_bit(channel, port->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
@@ -2761,23 +2766,23 @@ static int airoha_tc_get_htb_get_leaf_queue(struct airoha_gdm_port *port,
 	return 0;
 }
 
-static int airoha_tc_setup_qdisc_htb(struct airoha_gdm_port *port,
+static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
 				     struct tc_htb_qopt_offload *opt)
 {
 	switch (opt->command) {
 	case TC_HTB_CREATE:
 		break;
 	case TC_HTB_DESTROY:
-		return airoha_tc_htb_destroy(port);
+		return airoha_tc_htb_destroy(dev);
 	case TC_HTB_NODE_MODIFY:
 	case TC_HTB_LEAF_ALLOC_QUEUE:
-		return airoha_tc_htb_alloc_leaf_queue(port, opt);
+		return airoha_tc_htb_alloc_leaf_queue(dev, opt);
 	case TC_HTB_LEAF_DEL:
 	case TC_HTB_LEAF_DEL_LAST:
 	case TC_HTB_LEAF_DEL_LAST_FORCE:
-		return airoha_tc_htb_delete_leaf_queue(port, opt);
+		return airoha_tc_htb_delete_leaf_queue(dev, opt);
 	case TC_HTB_LEAF_QUERY_QUEUE:
-		return airoha_tc_get_htb_get_leaf_queue(port, opt);
+		return airoha_tc_get_htb_get_leaf_queue(dev, opt);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2794,7 +2799,7 @@ static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
 	case TC_SETUP_QDISC_ETS:
 		return airoha_tc_setup_qdisc_ets(port, type_data);
 	case TC_SETUP_QDISC_HTB:
-		return airoha_tc_setup_qdisc_htb(port, type_data);
+		return airoha_tc_setup_qdisc_htb(dev, type_data);
 	case TC_SETUP_BLOCK:
 	case TC_SETUP_FT:
 		return airoha_dev_setup_tc_block(dev, type_data);

-- 
2.53.0


