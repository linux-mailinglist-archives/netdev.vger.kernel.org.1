Return-Path: <netdev+bounces-277850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDjGC+jT22m7HAkAu9opvQ
	(envelope-from <netdev+bounces-277850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:18:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCAD3E50D2
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72FD0302AE2A
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C16311973;
	Sun, 12 Apr 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLtGdfuQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C5314A9F
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776014022; cv=none; b=ZpTPab2lJJu0apfEFI1Eoked14L0eaF+dcixXkN0gvlqCiH0EdwybGcjbrEyxAWIn+St6V1S8bixySg1djljh8UA6hDr2wBBcRvAPWe9AKqAQ9MrakVvCMp78IqiR2yDzAfK6CknG1N8EWZIFbMiQ0COnh6eTtJHddMrl0pqJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776014022; c=relaxed/simple;
	bh=hUh+M3O256Q+bQ8hOJtGw8bHZiknE0TXgnIBLy2b7LA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HWe4km0kO3Qhxr9vDYB5HF1UeyPOsUskUC+3bpQmgupZnQKBWLyfSjkXYwfcouXhJMa2YCWW5abF/51T44kDF318AOM6n2s4CmT58IpKdNATUkTCVF66wDC7gpnV6S66rQrCQqP96fkVUm+LxGLWf6UMBtOVwOJOTKC1gpXk+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLtGdfuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D710C19424;
	Sun, 12 Apr 2026 17:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776014021;
	bh=hUh+M3O256Q+bQ8hOJtGw8bHZiknE0TXgnIBLy2b7LA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dLtGdfuQLenAZVV0tpDE5X/cJLrbK0FyV3d13pj4W+Ujw+QuhFv7w3e057t2zS8aJ
	 u8bSnBAQkdlZcda5OglKxDxqLcYllh/RIYj727fsHZnTiQScQhKWK34ydqRD8TnDyJ
	 6FgzvK2nTMT3GLOB6Hy5FjgYPStbx/3oTmeoCsWC1q2nVyTFYo9WdNHm0clBBbH+fc
	 OHxWC2zRUjYxF+EuLRgtvYUJONyjHBVoGMd3tvBuQLVz3ys9m5YvRhHNknj96luizv
	 4+v3bEN4Eywz79VmqtwZSaX+DQURTRrYTM7g9AtblGNrlBU8O1eEbl/fHZooKSkj1Q
	 SeWkc7Oeolfmw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 12 Apr 2026 19:13:13 +0200
Subject: [PATCH net-next 2/3] net: airoha: Rely on net_device pointer in
 HTB callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-airoha-multi-serdes-preliminary-patch-v1-2-08d5b670ca8f@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-277850-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 9CCAD3E50D2
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
 drivers/net/ethernet/airoha/airoha_eth.c | 45 +++++++++++++++++---------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index a98512e963b5..c2b5fcffce82 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2492,10 +2492,11 @@ static int airoha_qdma_set_trtcm_token_bucket(struct airoha_qdma *qdma,
 					   mode, val);
 }
 
-static int airoha_qdma_set_tx_rate_limit(struct airoha_gdm_port *port,
+static int airoha_qdma_set_tx_rate_limit(struct net_device *dev,
 					 int channel, u32 rate,
 					 u32 bucket_size)
 {
+	struct airoha_gdm_port *port = netdev_priv(dev);
 	int i, err;
 
 	for (i = 0; i <= TRTCM_PEAK_MODE; i++) {
@@ -2515,21 +2516,20 @@ static int airoha_qdma_set_tx_rate_limit(struct airoha_gdm_port *port,
 	return 0;
 }
 
-static int airoha_tc_htb_alloc_leaf_queue(struct airoha_gdm_port *port,
+static int airoha_tc_htb_alloc_leaf_queue(struct net_device *dev,
 					  struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
-	struct net_device *dev = port->dev;
-	int num_tx_queues = dev->real_num_tx_queues;
-	int err;
+	int err, num_tx_queues = dev->real_num_tx_queues;
+	struct airoha_gdm_port *port = netdev_priv(dev);
 
 	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
 		return -EINVAL;
 	}
 
-	err = airoha_qdma_set_tx_rate_limit(port, channel, rate, opt->quantum);
+	err = airoha_qdma_set_tx_rate_limit(dev, channel, rate, opt->quantum);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(opt->extack,
 				   "failed configuring htb offload");
@@ -2541,7 +2541,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct airoha_gdm_port *port,
 
 	err = netif_set_real_num_tx_queues(dev, num_tx_queues + 1);
 	if (err) {
-		airoha_qdma_set_tx_rate_limit(port, channel, 0, opt->quantum);
+		airoha_qdma_set_tx_rate_limit(dev, channel, 0, opt->quantum);
 		NL_SET_ERR_MSG_MOD(opt->extack,
 				   "failed setting real_num_tx_queues");
 		return err;
@@ -2728,44 +2728,47 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
 	}
 }
 
-static void airoha_tc_remove_htb_queue(struct airoha_gdm_port *port, int queue)
+static void airoha_tc_remove_htb_queue(struct net_device *dev, int queue)
 {
-	struct net_device *dev = port->dev;
+	struct airoha_gdm_port *port = netdev_priv(dev);
 
 	netif_set_real_num_tx_queues(dev, dev->real_num_tx_queues - 1);
-	airoha_qdma_set_tx_rate_limit(port, queue + 1, 0, 0);
+	airoha_qdma_set_tx_rate_limit(dev, queue + 1, 0, 0);
 	clear_bit(queue, port->qos_sq_bmap);
 }
 
-static int airoha_tc_htb_delete_leaf_queue(struct airoha_gdm_port *port,
+static int airoha_tc_htb_delete_leaf_queue(struct net_device *dev,
 					   struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
+	struct airoha_gdm_port *port = netdev_priv(dev);
 
 	if (!test_bit(channel, port->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
 		return -EINVAL;
 	}
 
-	airoha_tc_remove_htb_queue(port, channel);
+	airoha_tc_remove_htb_queue(dev, channel);
 
 	return 0;
 }
 
-static int airoha_tc_htb_destroy(struct airoha_gdm_port *port)
+static int airoha_tc_htb_destroy(struct net_device *dev)
 {
+	struct airoha_gdm_port *port = netdev_priv(dev);
 	int q;
 
 	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
-		airoha_tc_remove_htb_queue(port, q);
+		airoha_tc_remove_htb_queue(dev, q);
 
 	return 0;
 }
 
-static int airoha_tc_get_htb_get_leaf_queue(struct airoha_gdm_port *port,
+static int airoha_tc_get_htb_get_leaf_queue(struct net_device *dev,
 					    struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
+	struct airoha_gdm_port *port = netdev_priv(dev);
 
 	if (!test_bit(channel, port->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
@@ -2777,23 +2780,23 @@ static int airoha_tc_get_htb_get_leaf_queue(struct airoha_gdm_port *port,
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
@@ -2810,7 +2813,7 @@ static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
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


