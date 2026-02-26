Return-Path: <netdev+bounces-261304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H8DKFUxoGmLgAQAu9opvQ
	(envelope-from <netdev+bounces-261304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:41:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 131C81A53CC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B084E30795DD
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906E376BE2;
	Thu, 26 Feb 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="CQNmsiEj"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8D331223
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106062; cv=none; b=Fhe+a3iNRddkVmjTVXNv+qwMC4TDPpt8jnPDsY2UJRLMhYW3zhEC+10yw8P2ClsC9tq6iJ1TqtVMSiDkjo4g5HXqPAzqXE2TrNjSzCvGvCs1IarzDmt59wLxnmHNltUGBwqJoo6yakUqLJCs5a9yz2o1b/CfGlDCOB13B2RziZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106062; c=relaxed/simple;
	bh=+7ziugQ1fLa7yMGLFiCUtenJJXEOF7U5zJF2RkV9ZFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nTSrlfgbe5sa7H3JLSgUSdy5uaAf3x8twgM9kKGVgw0bL9Bu74NfpsQiYoxNcAXaQHBIQb2X40TyK1oUVvU/xns4YKmRS4J6kG0vAWOz6OhQRgX8Y98SalNT3q6Zgte82fCZfoM1h3CKUtpfRxSK+HmncZIXLNc/A5IoZPSFPKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=CQNmsiEj; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=5783; s=dkim-tub; t=1772106061;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ifbQIjtO2y6oByxRU7kTHGld7fTdwB5Ek5SD4R3ZnGk=;
  b=CQNmsiEj4p3Pjz8jjFs1HBJA6rozvuIcKG+nMsZILOvY8dF0TGJ6R8Cm
   InWviNqG+dLksikRg8I/sD+k4vnGV84upSx1NfBF20hwpJJURGctz/3UV
   ODmFXj6gQGzwTkbeVJ0UXLWr/vuhCNxsLW6IIa30cuA9jStlR/N+DWwv+
   Y=;
X-CSE-ConnectionGUID: m4XkvQADSgOjMaqTVXEr7A==
X-CSE-MsgGUID: RR/MnBNHTOqBaBWhch5b2w==
X-IronPort-AV: E=Sophos;i="6.21,312,1763420400"; 
   d="scan'208";a="57705339"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 26 Feb 2026 12:40:48 +0100
From: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Date: Thu, 26 Feb 2026 12:40:16 +0100
Subject: [PATCH net 2/2] net/sched: sch_cake: fixup cake_mq rate adjustment
 for diffserv config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-2-01830bb4db87@tu-berlin.de>
References: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-0-01830bb4db87@tu-berlin.de>
In-Reply-To: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-0-01830bb4db87@tu-berlin.de>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, "Jamal Hadi
 Salim" <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <cake@lists.bufferbloat.net>, <netdev@vger.kernel.org>,
	=?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772106043; l=5904;
 i=j.koeppeler@tu-berlin.de; s=20260219; h=from:subject:message-id;
 bh=+7ziugQ1fLa7yMGLFiCUtenJJXEOF7U5zJF2RkV9ZFI=;
 b=CQlY/bqSFqThHeEfJ+5uQwiKPu5vLSqefV1sfhw+yiGtWdJWr2PxhBUM9FmDQzhxMMTcXGkq9
 bi/EpkQqIgbCwy/SVCNWAcEXG6p9jdfaM3K8pXjAHw3uGh85jdmsRhx
X-Developer-Key: i=j.koeppeler@tu-berlin.de; a=ed25519;
 pk=+pMLYEiy24PHhKr0HCDJhKWgh9WowPOEUOtiuMX7LLc=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261304-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-berlin.de:mid,tu-berlin.de:dkim,tu-berlin.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wikipedia.org:url]
X-Rspamd-Queue-Id: 131C81A53CC
X-Rspamd-Action: no action

cake_mq's rate adjustment during the sync periods did not adjust the
rates for every tin in a diffserv config. This lead to inconsistencies
of rates between the tins. Fix this by setting the rates for all tins
during synchronization.

Fixes: 1bddd758bac2 ("net/sched: sch_cake: share shaper state across sub-instances of cake_mq")
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 net/sched/sch_cake.c | 50 +++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 3718200353b5..230ed16c6c91 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -391,8 +391,8 @@ static const u32 inv_sqrt_cache[REC_INV_SQRT_CACHE] = {
 	1239850263, 1191209601, 1147878294, 1108955788
 };
 
-static void cake_set_rate(struct cake_tin_data *b, u64 rate, u32 mtu,
-			  u64 target_ns, u64 rtt_est_ns);
+static void cake_configure_rates(struct Qdisc *sch, u64 rate, bool rate_adjust);
+
 /* http://en.wikipedia.org/wiki/Methods_of_computing_square_roots
  * new_invsqrt = (invsqrt / 2) * (3 - count * invsqrt^2)
  *
@@ -2040,12 +2040,9 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 		if (num_active_qs > 1)
 			new_rate = div64_u64(q->config->rate_bps, num_active_qs);
 
-		/* mtu = 0 is used to only update the rate and not mess with cobalt params */
-		cake_set_rate(b, new_rate, 0, 0, 0);
+		cake_configure_rates(sch, new_rate, true);
 		q->last_checked_active = now;
 		q->active_queues = num_active_qs;
-		q->rate_ns = b->tin_rate_ns;
-		q->rate_shft = b->tin_rate_shft;
 	}
 
 begin:
@@ -2362,12 +2359,10 @@ static void cake_set_rate(struct cake_tin_data *b, u64 rate, u32 mtu,
 	b->cparams.p_dec = 1 << 20; /* 1/4096 */
 }
 
-static int cake_config_besteffort(struct Qdisc *sch)
+static int cake_config_besteffort(struct Qdisc *sch, u64 rate, u32 mtu)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct cake_tin_data *b = &q->tins[0];
-	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->config->rate_bps;
 
 	q->tin_cnt = 1;
 
@@ -2381,12 +2376,10 @@ static int cake_config_besteffort(struct Qdisc *sch)
 	return 0;
 }
 
-static int cake_config_precedence(struct Qdisc *sch)
+static int cake_config_precedence(struct Qdisc *sch, u64 rate, u32 mtu)
 {
 	/* convert high-level (user visible) parameters into internal format */
 	struct cake_sched_data *q = qdisc_priv(sch);
-	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->config->rate_bps;
 	u32 quantum = 256;
 	u32 i;
 
@@ -2457,7 +2450,7 @@ static int cake_config_precedence(struct Qdisc *sch)
  *	Total 12 traffic classes.
  */
 
-static int cake_config_diffserv8(struct Qdisc *sch)
+static int cake_config_diffserv8(struct Qdisc *sch, u64 rate, u32 mtu)
 {
 /*	Pruned list of traffic classes for typical applications:
  *
@@ -2474,8 +2467,6 @@ static int cake_config_diffserv8(struct Qdisc *sch)
  */
 
 	struct cake_sched_data *q = qdisc_priv(sch);
-	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->config->rate_bps;
 	u32 quantum = 256;
 	u32 i;
 
@@ -2505,7 +2496,7 @@ static int cake_config_diffserv8(struct Qdisc *sch)
 	return 0;
 }
 
-static int cake_config_diffserv4(struct Qdisc *sch)
+static int cake_config_diffserv4(struct Qdisc *sch, u64 rate, u32 mtu)
 {
 /*  Further pruned list of traffic classes for four-class system:
  *
@@ -2518,8 +2509,6 @@ static int cake_config_diffserv4(struct Qdisc *sch)
  */
 
 	struct cake_sched_data *q = qdisc_priv(sch);
-	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->config->rate_bps;
 	u32 quantum = 1024;
 
 	q->tin_cnt = 4;
@@ -2547,7 +2536,7 @@ static int cake_config_diffserv4(struct Qdisc *sch)
 	return 0;
 }
 
-static int cake_config_diffserv3(struct Qdisc *sch)
+static int cake_config_diffserv3(struct Qdisc *sch, u64 rate, u32 mtu)
 {
 /*  Simplified Diffserv structure with 3 tins.
  *		Latency Sensitive	(CS7, CS6, EF, VA, TOS4)
@@ -2555,8 +2544,6 @@ static int cake_config_diffserv3(struct Qdisc *sch)
  *		Low Priority		(LE, CS1)
  */
 	struct cake_sched_data *q = qdisc_priv(sch);
-	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->config->rate_bps;
 	u32 quantum = 1024;
 
 	q->tin_cnt = 3;
@@ -2581,32 +2568,33 @@ static int cake_config_diffserv3(struct Qdisc *sch)
 	return 0;
 }
 
-static void cake_reconfigure(struct Qdisc *sch)
+static void cake_configure_rates(struct Qdisc *sch, u64 rate, bool rate_adjust)
 {
+	u32 mtu = likely(rate_adjust) ? 0 : psched_mtu(qdisc_dev(sch));
 	struct cake_sched_data *qd = qdisc_priv(sch);
 	struct cake_sched_config *q = qd->config;
 	int c, ft;
 
 	switch (q->tin_mode) {
 	case CAKE_DIFFSERV_BESTEFFORT:
-		ft = cake_config_besteffort(sch);
+		ft = cake_config_besteffort(sch, rate, mtu);
 		break;
 
 	case CAKE_DIFFSERV_PRECEDENCE:
-		ft = cake_config_precedence(sch);
+		ft = cake_config_precedence(sch, rate, mtu);
 		break;
 
 	case CAKE_DIFFSERV_DIFFSERV8:
-		ft = cake_config_diffserv8(sch);
+		ft = cake_config_diffserv8(sch, rate, mtu);
 		break;
 
 	case CAKE_DIFFSERV_DIFFSERV4:
-		ft = cake_config_diffserv4(sch);
+		ft = cake_config_diffserv4(sch, rate, mtu);
 		break;
 
 	case CAKE_DIFFSERV_DIFFSERV3:
 	default:
-		ft = cake_config_diffserv3(sch);
+		ft = cake_config_diffserv3(sch, rate, mtu);
 		break;
 	}
 
@@ -2617,6 +2605,14 @@ static void cake_reconfigure(struct Qdisc *sch)
 
 	qd->rate_ns   = qd->tins[ft].tin_rate_ns;
 	qd->rate_shft = qd->tins[ft].tin_rate_shft;
+}
+
+static void cake_reconfigure(struct Qdisc *sch)
+{
+	struct cake_sched_data *qd = qdisc_priv(sch);
+	struct cake_sched_config *q = qd->config;
+
+	cake_configure_rates(sch, qd->config->rate_bps, false);
 
 	if (q->buffer_config_limit) {
 		qd->buffer_limit = q->buffer_config_limit;

-- 
2.43.0


