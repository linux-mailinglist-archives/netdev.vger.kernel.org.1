Return-Path: <netdev+bounces-300325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rd+qKqWJM2reDAYAu9opvQ
	(envelope-from <netdev+bounces-300325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:01:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5969DC59
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:01:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cFFDo3xd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300325-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300325-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 054CF302B388
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 06:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288CA2F99B8;
	Thu, 18 Jun 2026 06:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063BB134CCF
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 06:00:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781762460; cv=none; b=ul9Sf2/02mxJSqXGBFxFTDlQwxnVGZcLNI5686QH4oL1NH4BrymlNvyLvc+HU9zwiR7PvNsY4iz/BQ5XIaG/HmdIKCfWpMQJ8yeLcSanEK2eqjFt6L8dbmoW44aZo8g/ZwDbGl/AvEVuTN11efy8h9G/W9l8ABAQ5d5pid7Oj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781762460; c=relaxed/simple;
	bh=SxIMk6/UyYfWXv305q0xatFiCoEFMy8Z7XTqlBqvSG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwpOh+f8nnjmGF0Yod3Fszo/pm+zfHQMx0ZxV4fr8+BJrUI+jpHuiyWg9soTmUE7BfyCWyyxJ/90mIipam+9QseJfLnbOCaImO9CQ8DOY4VMsdBiCZJqTD2sOYB5nX3mXGJNvh0O6c4qrC4ybGAe80M+a3DouQxmwxsedm8KXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFFDo3xd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263CE1F000E9;
	Thu, 18 Jun 2026 06:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781762458;
	bh=xYe/R+B0EIyzp+VSVmzKrxMqtVM346VU1YDtZ/Nm964=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cFFDo3xdDE7f9X36tOCU65NXDqgnoAHLQ/UzCTnXJ2WidFPO0zIUOiWlITv/ucbTA
	 9NQUJQEHYf0ySE7FWYGKJ0ZdAMXN+r/K1GBaF3/OqVAOt03Y9tLgSV37wKrUiSdtJR
	 Axh9i8owHcYZw7dw9N1pPOMx5e9kIZJ3UQ1rZntnxLisNmpgQGAR/7S6lW04wFv3ud
	 BZNuCefgBmnlpowgKw/Gb0xpD0BCWywYqnNoP7y++mfW/2dvcCvbRT1RZKYEkfj2jl
	 zxZpm7C0zeuzT0rjy+qya1u0BwoZo8iUL9gdS5kCBoJ0gz77mV5t27NbEtlYgFZhLw
	 66vUiVJYh95xA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 18 Jun 2026 08:00:30 +0200
Subject: [PATCH net 2/2] net: airoha: fix netif_set_real_num_tx_queues for
 sparse QoS channels
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-airoha-qos-fixes-v1-2-37192652157f@kernel.org>
References: <20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org>
In-Reply-To: <20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300325-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,kernel.org];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14A5969DC59

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
 drivers/net/ethernet/airoha/airoha_eth.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index aa98d1823ab6..e2652cff67c0 100644
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
 
@@ -2806,7 +2806,10 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 	if (err)
 		goto error;
 
-	err = netif_set_real_num_tx_queues(netdev, num_tx_queues + 1);
+	if (num_tx_queues <= netdev->real_num_tx_queues)
+		goto set_qos_sq_bmap;
+
+	err = netif_set_real_num_tx_queues(netdev, num_tx_queues);
 	if (err) {
 		airoha_qdma_set_tx_rate_limit(netdev, channel, 0,
 					      opt->quantum);
@@ -2815,6 +2818,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 		goto error;
 	}
 
+set_qos_sq_bmap:
 	set_bit(channel, dev->qos_sq_bmap);
 	opt->qid = AIROHA_NUM_TX_RING + channel;
 
@@ -3003,13 +3007,18 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
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


