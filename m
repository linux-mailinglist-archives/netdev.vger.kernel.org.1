Return-Path: <netdev+bounces-271208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PSbD8rOwmnRmQQAu9opvQ
	(envelope-from <netdev+bounces-271208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:50:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA55031A4EE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEDF6305366D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE3D40B6CE;
	Tue, 24 Mar 2026 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZWMmwlm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68040824B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374487; cv=none; b=B+5B7LnenIHSV20yTLJS29TbIkQrVXvT86Y5gv8T8AR/Z14kcOPfoAtU68IU7zoyqrnXN+qfzThB7ANiaEFcnU9pWljTleGRlCHno11gdNLafmAxO2lU+THNz8uJKIDPDu6PXmphGiOIUQlmSDunJGfMTiBRv9GYg8gmtaiao8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374487; c=relaxed/simple;
	bh=wUMy1K+F4ysd18r+BhqlIpwQYaHa/QW0dK1Ts49kKD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FK0xNfSDOk28dsfLiZgFflLWQEYHICojTA630ZjBaV6L7mRHDULx4lx8XgylS1W/QzWgLaf22r42/yjJUWWtwW1tAHHYkWVIkojqlpyOPtN7qhlap/IsQj8Mc5raVLffyBHYA4aVbieUcXf8lro3jNTC9VGky1ZgbaUoFdwB2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZWMmwlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24CBC2BC87;
	Tue, 24 Mar 2026 17:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774374486;
	bh=wUMy1K+F4ysd18r+BhqlIpwQYaHa/QW0dK1Ts49kKD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZWMmwlmvghhfke9sp8dWlEyh9T0fK5Ad3UT67Vzsgxu72cIn4tuwt62Uxv74Y3gK
	 T+7mOc2eE4G0XIFqQDVZt895Zb1FRIkMcgLNFDAoSGuVEpeRkq/BevCH4XnmGjiyly
	 WFyuhBqBXsvYrkuOR6/82c070p7NqM1DXCiB07AZdg4al5bUM5Lvpe7jFKDd6hioy9
	 tcuTuD1+TfVpEmmur7ER4PlukLSKHuQZguw8caUfgQjf+UdZvbZD2XcsRWeFee/t+O
	 d7vo1Cx4VB0/oDTVRECmWiSghaL1VGko2AEJAffLifSuPpGSIyVOQLqfTRb8pDeF+O
	 o5yK0gygeG90g==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	j.koeppeler@tu-berlin.de,
	kernel-team@cloudflare.com
Subject: [PATCH net-next 4/5] net: sched: add timeout count to NETDEV WATCHDOG message
Date: Tue, 24 Mar 2026 18:47:03 +0100
Message-ID: <20260324174719.1224337-6-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324174719.1224337-1-hawk@kernel.org>
References: <20260324174719.1224337-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271208-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tu-berlin.de:email]
X-Rspamd-Queue-Id: EA55031A4EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

Add the per-queue timeout counter (trans_timeout) to the core NETDEV
WATCHDOG log message.  This makes it easy to determine how frequently
a particular queue is stalling from a single log line, without having
to search through and correlate spaced-out log entries.

Useful for production monitoring where timeouts are spaced by the
watchdog interval, making frequency hard to judge.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20251107175445.58eba452@kernel.org/
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 net/sched/sch_generic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 69d5ac4f17d1..da97cda1a1e7 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -533,13 +533,12 @@ static void dev_watchdog(struct timer_list *t)
 		    netif_running(dev) &&
 		    netif_carrier_ok(dev)) {
 			unsigned int timedout_ms = 0;
+			struct netdev_queue *txq;
 			unsigned int i;
 			unsigned long trans_start;
 			unsigned long oldest_start = jiffies;
 
 			for (i = 0; i < dev->num_tx_queues; i++) {
-				struct netdev_queue *txq;
-
 				txq = netdev_get_tx_queue(dev, i);
 				if (!netif_xmit_stopped(txq))
 					continue;
@@ -561,9 +560,10 @@ static void dev_watchdog(struct timer_list *t)
 
 			if (unlikely(timedout_ms)) {
 				trace_net_dev_xmit_timeout(dev, i);
-				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms\n",
+				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms (n:%ld)\n",
 					    raw_smp_processor_id(),
-					    i, timedout_ms);
+					    i, timedout_ms,
+					    atomic_long_read(&txq->trans_timeout));
 				netif_freeze_queues(dev);
 				dev->netdev_ops->ndo_tx_timeout(dev, i);
 				netif_unfreeze_queues(dev);
-- 
2.43.0


