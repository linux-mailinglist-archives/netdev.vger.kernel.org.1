Return-Path: <netdev+bounces-284400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M9CGdnw+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:30:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C5D4CE81F
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FF65304E535
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34E547DD50;
	Tue,  5 May 2026 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctc3eBYf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092947DD4E;
	Tue,  5 May 2026 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987346; cv=none; b=c61PRwjhjL0vTdXnvhTPq/YLc3Ea+zTBRV855gOZH0Pmj9dEq5oXhG6lqs8GmS3wQNzupBwBFjcepFLKNFkEfAY6OgkQlHvRsnysQM3Tg1kEJrrGhoriInFArHTX7wPyFhQB6bdtGSwJux6jN8K5Mb8TwxKG6Jm6zEJhMVQKOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987346; c=relaxed/simple;
	bh=XPcRTdbWwomJwXrQ4r6B2U9JVjj7QGAmxhRjGzNSS7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldG2G+LuqMCHw8z2HyjbDjzxiJlA3F3RLmr4IO2jN7rr/+J239QbTmf147ppNvWOPTe7dDLmvyFqj4H0tYQZugOvSF63UC91AhMIUaJHIsPGeGtoqtzJrRKwTpcKw92oEZm+r0HNj/HeUiw/RaDd+VzZ9CyMqrk6BjlCkhPMSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctc3eBYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF5CC2BCC9;
	Tue,  5 May 2026 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777987346;
	bh=XPcRTdbWwomJwXrQ4r6B2U9JVjj7QGAmxhRjGzNSS7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctc3eBYf+AYecBvQoHcKCRCmUOAgNlT6CfsONMWqXb1SoflLKZV+wcqeaIttXBwup
	 BjblxohlTzYun3RV0c9lDb9qT4yAs11WTQde4KFy/zp6i0mRME8zqzJlli00SjXRui
	 g4LlTZo8Kx4JJdUooz8OtcjBvoFFk1m4jUagPFxHggffG/+eDA+XdQeucmcB11cQ65
	 ABD3qLMAPK3SF1h8itzO4ljvvLNiEq+agQdVbIU2HAm9FB/DQtR1t4bjS8la8v4MmM
	 WKv3XapE/gMiXnH0X5kUR5AlqB7aRioe9S4iTWMVSv40tIwlVZv+xa76UACaXrsKy0
	 H993wPhO8ry9Q==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	kernel-team@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 5/5] net: sched: add timeout count to NETDEV WATCHDOG message
Date: Tue,  5 May 2026 15:21:57 +0200
Message-ID: <20260505132159.241305-6-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505132159.241305-1-hawk@kernel.org>
References: <20260505132159.241305-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76C5D4CE81F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284400-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tu-berlin.de:email]

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
index a93321db8fd7..3e2e2e887a86 100644
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


