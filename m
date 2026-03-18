Return-Path: <netdev+bounces-269026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cApSC4KuumlXagIAu9opvQ
	(envelope-from <netdev+bounces-269026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:54:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB222BC673
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A7FD312E5F9
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4823D9055;
	Wed, 18 Mar 2026 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyJD2N9j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8A3D904E
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841728; cv=none; b=eK0D/zU9LDo1vFewXgFAM3PmJXG1GABvgrX1mJaFUDrsTevQDIzJPnuTO9UbHn0ZHjHu3oOrrA4lkMccBM8DwkxyGX4gSQUQlZKa62VvJ8nt6kgPWzNjLnu/dD1gP8QA6IK6HRQktQhq7dadaERV63i6MqCCn8xlIJ9pLqrq5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841728; c=relaxed/simple;
	bh=wUMy1K+F4ysd18r+BhqlIpwQYaHa/QW0dK1Ts49kKD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRfn+tkfyE0ZY5uu+w+b+vUlTqqfA8RGdIaIt3UlEnxQo3SwGXBVa8qrsD43mJKDaxF/zEKSCAbrqFpSXm5J2x4sckKFLvERZCbisckzUK1OcGseVSBqwrEXlQMdf29FNPQWedT8iHI9DGwoSCUG0oBxlLA3wQ3axruiNCKohOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyJD2N9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F879C19424;
	Wed, 18 Mar 2026 13:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773841727;
	bh=wUMy1K+F4ysd18r+BhqlIpwQYaHa/QW0dK1Ts49kKD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyJD2N9jc0zAe3J/SKci+Q42tXuL6scpVqnN+/xkPHgbehALPZ3MGJ6AKex1mEqDW
	 FzLyHIMwGwznbe5pwh5yJFOc/SY6/+pqLyOnkUSLh6UGneg6LJViz18oSlfuHHqvfg
	 RFQQPtkKORSBcyX2p/Sgo2wXSNrkfsjDSAgclmVsLeBexhZoqzIQlFCCW8Fouao7si
	 WAoyHe/AmR0xk1o30P43x6e2qKkB2U+UoDBeEQ+MthRtI9HsewbyByIij5dHlEeQTc
	 SSWNGVd2MN7fe+gLLa+BzCHmJ7X0+b5k6Iqd8PuxRFs1re4+LQT9APxp51gK5HKsBy
	 bX9hDOM6NRPPw==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	toke@toke.dk,
	sdf@fomichev.me,
	j.koeppeler@tu-berlin.de,
	mfreemon@cloudflare.com,
	carges@cloudflare.com
Subject: [RFC PATCH net-next 4/6] net: sched: add timeout count to NETDEV WATCHDOG message
Date: Wed, 18 Mar 2026 14:48:24 +0100
Message-ID: <20260318134826.1281205-5-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318134826.1281205-1-hawk@kernel.org>
References: <20260318134826.1281205-1-hawk@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269026-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tu-berlin.de:email]
X-Rspamd-Queue-Id: 7FB222BC673
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


