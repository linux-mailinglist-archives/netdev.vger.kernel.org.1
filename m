Return-Path: <netdev+bounces-273914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FM/BEArDzGm+WgYAu9opvQ
	(envelope-from <netdev+bounces-273914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:02:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D707375867
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37CA33068EF7
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9B63624CE;
	Wed,  1 Apr 2026 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFZ8srze"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF2361647;
	Wed,  1 Apr 2026 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775026812; cv=none; b=l8kUUGxzQF9S3ShFDHgOU5qASzDmiMp7Nrana2hLv4qilWsIUMN0vq/xYcXbtWz1pxej2jsubP20r7ismL55M3XGFy4C2wYHSP0Z0+JT3RZLteWL7uV0K5em5OIGCq2mql49O2WzilI+ZCBgKsbDP+ISnz2LDfmjgYMThV4qzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775026812; c=relaxed/simple;
	bh=q5vQNrHcUcTNzAEVoqEgSWxwh5VfHdV5Kq4DABj2NLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r6RzKjiZn0gVzGbCTWtrUjYCJrM9CUycc7/+6HfrnsHKD7WwLv9VKmkbGgMwXxyOHf4FIiOG8WLVUUlKZxeP2wJlGMPSZ0B23HmpZRNmE/ydZVk5OUeDyOO//vooLXAIY1WVnGhAShCghRVZQrPPFWLunz6zyDRmlCGHYlK+oSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFZ8srze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A09C2BCB7;
	Wed,  1 Apr 2026 07:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775026812;
	bh=q5vQNrHcUcTNzAEVoqEgSWxwh5VfHdV5Kq4DABj2NLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HFZ8srzewUH73OcFejOz2TKZeHU3uSztW9N5fcuh1HtSv7BiQ+uGF9VJIcP2W5llI
	 Wm5AEmj+S9pcfTLgUeVn77qfjD/9JJon3f305vOkpXjK48LQl9wgAxQlXlNcFGwK/b
	 DBL7/dp1W6uSCoGsQ+A5Tr4+nMAl7LXifyg66oWr60Cdgvfo2QV9NTIpiQucGgZQ9t
	 oXWI8UHPGxdOvdSmAqyOchttmi4qse/x7h3EfPkyOiFjVExqF6YcpRG/6xNWbY4+MX
	 uQvekkDU7DFUuOFriBMCAM0DWHGBasrYf78VOTLfWQn2dguzGJjVFZ3h8QURcZDxsq
	 BEY+dGsygXuQA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 01 Apr 2026 08:59:22 +0200
Subject: [PATCH net-next v2 04/11] net: airoha: Rely on net_device pointer
 in HTB callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-airoha-eth-multi-serdes-v2-4-ac427ae4beeb@kernel.org>
References: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
In-Reply-To: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
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
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273914-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D707375867
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove airoha_gdm_port dependency in HTB tc callback signatures and rely
on net_device pointer instead. Please note this patch does not introduce
any logical change and it is a preliminary patch in order to support
multiple net_devices connected to the same GDM3 or GDM4 port via an
external hw arbiter.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 51 ++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index e1448e01dd69b7d46f0efd8ad4e8531bca0ae1eb..52599ebe85e6a74002c290edb82c55ba9fdfcc69 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2480,10 +2480,11 @@ static int airoha_qdma_set_trtcm_token_bucket(struct airoha_qdma *qdma,
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
@@ -2503,21 +2504,21 @@ static int airoha_qdma_set_tx_rate_limit(struct airoha_gdm_port *port,
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
@@ -2527,9 +2528,10 @@ static int airoha_tc_htb_alloc_leaf_queue(struct airoha_gdm_port *port,
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
@@ -2716,44 +2718,47 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
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
@@ -2765,23 +2770,23 @@ static int airoha_tc_get_htb_get_leaf_queue(struct airoha_gdm_port *port,
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
@@ -2798,7 +2803,7 @@ static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
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


