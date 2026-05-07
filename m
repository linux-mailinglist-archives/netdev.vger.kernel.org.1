Return-Path: <netdev+bounces-285504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Dh3KOgC/WmIWgAAu9opvQ
	(envelope-from <netdev+bounces-285504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:23:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F16924EF39C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1D66305FC10
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB06F3446CA;
	Thu,  7 May 2026 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pa1GTTBX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C833BBB9;
	Thu,  7 May 2026 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188958; cv=none; b=fSKuRM8sWYokhTTWBxM1ZGDTIkl9onjScdnNuaFKG8uLQiMJaKRyzI6ClVahK6VMt2rx/NpQQWBuBIcf7qHdCUqHmXcmEwM2qri/zK7rVkIRWZXBS9vAYQR4oP43epAZKn+vOvkJdGD3D+WQ8LiSqq0r5Dn6a/UjtbwkOkH01Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188958; c=relaxed/simple;
	bh=XgAYoU0y85slz9uL3LFVwtZeHsDOMroq0sYN29Ni1v4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nm5d1snwDJr4cBwDKeoE8O1uruhQkxutQ4yjBd+T5kXV+FOh8zk6AbYL/s8YevPPOK54JNMx9ECmjYhWjJgDTXuPYZczCBPJ0MtVVqNTmVWPwwUWiCXep3vec/FCxPZEm3C+YDQoOgjLbbPnUMecvP8LM6v/dK7la0nq5mDQiro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pa1GTTBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E139FC2BCC9;
	Thu,  7 May 2026 21:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778188958;
	bh=XgAYoU0y85slz9uL3LFVwtZeHsDOMroq0sYN29Ni1v4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pa1GTTBX5w2DQ4jeqg7ftrvjxpnoK4tTi9IBFDynXi6KtNN7oXFzvSkTMWlFbPMAY
	 yArnKFsrSCjGX81+p9B93uLgHJ6TgWmASL/8gIbTzuqh3ci4U3J2WACgvQqu6MWAAf
	 fqJ1Z1QM8FsdgumuWu4w6anvODzdTPUic5RP5IWT3rFYeF4R453674O0KcweX6VSy7
	 aRYUEsEIdyDuBSRwEfJ8ir79yDq8aBV9lrT8tfgiapxO/KZ5wVIn/2a/5cWipsA8N8
	 W5Hc/G5HltBkW4xwPkE1Po4kBkwr83z26/Su1FfrNVIJ3vFFTN08G8wMpbR5ar3DXX
	 V37oh07PbUxMQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 07 May 2026 23:21:48 +0200
Subject: [PATCH net-next v4 05/10] net: airoha: Move qos_sq_bmap in
 airoha_qdma struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-airoha-eth-multi-serdes-v4-5-af613b61ae02@kernel.org>
References: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
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
X-Rspamd-Queue-Id: F16924EF39C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285504-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Since now multiple net_devices connected to different QDMA blocks can
share the same GDM port, qos_sq_bmap field can be overwritten with the
configuration obtained from a net_device connected to a different QDMA
block. In order to fix the issue move qos_sq_bmap field from
airoha_gdm_port struct to airoha_qdma one.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 20 ++++++++++----------
 drivers/net/ethernet/airoha/airoha_eth.h |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 080705e2f58d..69a4c2e0d58b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2600,7 +2600,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
 	int err, num_tx_queues = netdev->real_num_tx_queues;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	struct airoha_qdma *qdma = dev->qdma;
 
 	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
@@ -2627,7 +2627,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 		return err;
 	}
 
-	set_bit(channel, port->qos_sq_bmap);
+	set_bit(channel, qdma->qos_sq_bmap);
 	opt->qid = AIROHA_NUM_TX_RING + channel;
 
 	return 0;
@@ -2811,11 +2811,11 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
 static void airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	struct airoha_qdma *qdma = dev->qdma;
 
 	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
 	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
-	clear_bit(queue, port->qos_sq_bmap);
+	clear_bit(queue, qdma->qos_sq_bmap);
 }
 
 static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
@@ -2823,9 +2823,9 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	struct airoha_qdma *qdma = dev->qdma;
 
-	if (!test_bit(channel, port->qos_sq_bmap)) {
+	if (!test_bit(channel, qdma->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
 		return -EINVAL;
 	}
@@ -2838,10 +2838,10 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 static int airoha_tc_htb_destroy(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	struct airoha_qdma *qdma = dev->qdma;
 	int q;
 
-	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
+	for_each_set_bit(q, qdma->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
 		airoha_tc_remove_htb_queue(netdev, q);
 
 	return 0;
@@ -2852,9 +2852,9 @@ static int airoha_tc_get_htb_get_leaf_queue(struct net_device *netdev,
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	struct airoha_qdma *qdma = dev->qdma;
 
-	if (!test_bit(channel, port->qos_sq_bmap)) {
+	if (!test_bit(channel, qdma->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 18a9dfd75d44..34f1fef51640 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -531,6 +531,8 @@ struct airoha_qdma {
 
 	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
 	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
+
+	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
 };
 
 struct airoha_gdm_dev {
@@ -547,8 +549,6 @@ struct airoha_gdm_port {
 
 	struct airoha_hw_stats stats;
 
-	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
-
 	/* qos stats counters */
 	u64 cpu_tx_packets;
 	u64 fwd_tx_packets;

-- 
2.54.0


