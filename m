Return-Path: <netdev+bounces-300689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 11LwNAsqNWo3nwYAu9opvQ
	(envelope-from <netdev+bounces-300689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:37:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0E56A5740
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:37:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HgJkgRVJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300689-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300689-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9E21301CFFD
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F53803F3;
	Fri, 19 Jun 2026 11:37:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775A3803DA
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 11:37:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781869065; cv=none; b=S2CVlAsFPZXbG6BNFvTdaV+W2DZ3pBnY3LoxZYcbMTgEVW84So9VjXHvGKcJjtINgK983NbLUBN6YbsUu/pLE8BoAnFh1FD/CoaCNQUreyysU1+4Nga01ljh+lbm8dEloEf5odI0WeVgUaqOh4onqwFn2o68atJJXuPEShWw/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781869065; c=relaxed/simple;
	bh=x/UtDnDqovH/y9LevYdn47SrGzVi25htORol/PYc5Pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHmK51g6NCe6dXNPIfPSpAy5zlBk+xmJ19mkRwmD/sOUdPkAFxF6Ng6rfmoPapusv5K6NvKpuk0RlLhfYp+O+/+uvH6DQF89xlATPLUe+A8gVnIKb17Ml8HEs0zTzOe4d6K09osYC0zXkg52qHUW6U79pEqdVHScPRfsXZzaQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgJkgRVJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257681F000E9;
	Fri, 19 Jun 2026 11:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781869063;
	bh=jzGWo/J3oWaOMaIBzTSc/1EZhyAP1P9XFheTEgmUqRw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HgJkgRVJyQTeYJh8CF9PvOAkHxNxLtvwZnvzDOJNI6gEbsfOm5W9LKjgqpnjfrw9/
	 Cf+wXKrC4AoaE70wxaoKLRSVKZtWyu0nk4djm0bZ1BV0/bMXYUuUnDbLpRZvSnWnek
	 h1+1ZdvItX54QqBZKOnpZRTWAwXwudixbk3AcYreJu7p3xhu89oAvKzVtiJ4wAzZNN
	 gW4WQw1hgvqZKFYX5+rsmtBqWEDNLUPDVSxFTS4Qed2CDE65PILGLaHxizeyp04Tf4
	 F1ZG0tmjbZEObf4KZz+KV1GrIgG6DfN4Ylfe1aMy64vLTnHpQK3l+kTtBjbIanzAWP
	 wBG76r8P+q9+g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 19 Jun 2026 13:37:14 +0200
Subject: [PATCH net v2 2/2] net: airoha: fix netif_set_real_num_tx_queues
 for sparse QoS channels
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-airoha-qos-fixes-v2-2-5c43485038f9@kernel.org>
References: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
In-Reply-To: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Wayen Yan <win847@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300689-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:horms@kernel.org,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A0E56A5740

airoha_tc_htb_alloc_leaf_queue() assigns queue IDs based on the channel
index (opt->qid = AIROHA_NUM_TX_RING + channel), but updates
real_num_tx_queues with a simple increment (num_tx_queues + 1). When QoS
channels are allocated sparsely (e.g., channels 0 and 3 without 1 and
2), the returned qid can exceed real_num_tx_queues, causing out-of-bounds
accesses in the networking stack.
For example, allocating channel 0 then channel 3 results in
real_num_tx_queues = 34 but qid = 35, which is out of range [0, 34).
Fix this by computing real_num_tx_queues based on the highest active
channel index rather than using a simple counter, in both the allocation
and deletion paths.

Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index aa98d1823ab6..aa2ddfd3af9f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2789,7 +2789,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 					  struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
-	int err, num_tx_queues = netdev->real_num_tx_queues;
+	int err, num_tx_queues = AIROHA_NUM_TX_RING + channel + 1;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_qdma *qdma = dev->qdma;
 
@@ -2806,13 +2806,15 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 	if (err)
 		goto error;
 
-	err = netif_set_real_num_tx_queues(netdev, num_tx_queues + 1);
-	if (err) {
-		airoha_qdma_set_tx_rate_limit(netdev, channel, 0,
-					      opt->quantum);
-		NL_SET_ERR_MSG_MOD(opt->extack,
-				   "failed setting real_num_tx_queues");
-		goto error;
+	if (num_tx_queues > netdev->real_num_tx_queues) {
+		err = netif_set_real_num_tx_queues(netdev, num_tx_queues);
+		if (err) {
+			airoha_qdma_set_tx_rate_limit(netdev, channel, 0,
+						      opt->quantum);
+			NL_SET_ERR_MSG_MOD(opt->extack,
+					   "failed setting real_num_tx_queues");
+			goto error;
+		}
 	}
 
 	set_bit(channel, dev->qos_sq_bmap);
@@ -3003,13 +3005,18 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
 static void airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	int num_tx_queues = AIROHA_NUM_TX_RING;
 	struct airoha_qdma *qdma = dev->qdma;
 
-	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
 	airoha_qdma_set_tx_rate_limit(netdev, queue, 0, 0);
 
 	clear_bit(queue, qdma->qos_channel_map);
 	clear_bit(queue, dev->qos_sq_bmap);
+
+	if (!bitmap_empty(dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS))
+		num_tx_queues += find_last_bit(dev->qos_sq_bmap,
+					       AIROHA_NUM_QOS_CHANNELS) + 1;
+	netif_set_real_num_tx_queues(netdev, num_tx_queues);
 }
 
 static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,

-- 
2.54.0


