Return-Path: <netdev+bounces-294885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uq8yGWR8IGrP4AAAu9opvQ
	(envelope-from <netdev+bounces-294885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:11:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A5363AC50
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:11:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HN2FYNRh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294885-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294885-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C98D305BB4E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F9377EAF;
	Wed,  3 Jun 2026 19:02:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33933D506
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 19:02:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513372; cv=none; b=VXG0XfO5D6TZ6a+edNUYmdssf33WyFI2hJ8rrrpgyWnWWtPXi+QYTfcT9B5SHuKuwu+3/HbGmj2Dk1/Mpx8W09QA1sJQt/8wqLLtTHwoJ1zsPdCUXPn/xSlGpiC6tajWRHcRUaRRhWKI2M3ipDNBWJQvXbMfRBn0UyYqQhsnIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513372; c=relaxed/simple;
	bh=8y8lVGfkQo98qLaW8pO6Lr2Xj+kENoFSTUuxPRH5Z1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWziwxJo45/XeEzNFp+gTXkf3slKtubTssb4D1iNSuuXcPr/G1qHdNkYvYg0e+NnWVWZty2izfSPC0HaaaEHbhs6oFqYhNq2hzbsD13zNFVYRVMw/u8zWiARz/8z2/DLk6jybU86sQBC8eNcVFUX04kuYomNC0TvOvQQ+V8aQQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN2FYNRh; arc=none smtp.client-ip=209.85.128.178
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dbd25309f7so74323107b3.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780513371; x=1781118171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BC1nNQKmOWbR/+H/7qbmuSp9A7i/0xiQhhwcCu+r6DM=;
        b=HN2FYNRhggvPl6KrP4T30hOiPBC+RtnP8x3urNOGJMzv42suy+MpSWUjtTbVy/5gQH
         9IxsH6UpBYSeWF7hMoN8r/IQ0UxGDXm0QFQsqougn0Aalj3LewMh2DGaw0n2MuRDdMvc
         KKIOSs1YEpiXybw84IdLfkbUYbCZkCydy2Kpp+5adV/z2RIQx/6R4yvbmz/hUcO0NfA2
         XiSdKoFpgLiOBJFScKoyilAbAky4Cu2IsfWUnJ9LLGnSxSkUQThMtYg4oWRqk1iIC60C
         cZyphuiAGLiLGtNaHtaUXKhBegcK7VaK9lsjpvh18CGKxkFih81AWnuvaL0yUFICchaN
         T/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780513371; x=1781118171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BC1nNQKmOWbR/+H/7qbmuSp9A7i/0xiQhhwcCu+r6DM=;
        b=QW9ckoTqlDktTrj2ltpfK854vJYDvnDPdo4HMo/tewEDZTskogj+JPFKJUVWE6RYs0
         gtmrr+mHMXz1zSt50641pYpMA32hKXyG8/hkTjdJudfLgViv/URTf6lWYzucL2k20moY
         u0jqhi3/69dUhJDFu/yUI3ZtRrIbjXvQ+AEsoDrir/nbzPjQtYxq6vNZ4CyAjyGXtsdB
         SyF6KJswp2tb6ajXzG6UKtmXLNF/oatQReo93wUlvpDITF832woPOn1hnsd8F9O4DzET
         +txk9Sihwu6cukhjdV9Q0Lmr6LPSCR8lEtFXbqrnsKud4h3wKYItdXONEIiWkXX+3P0v
         E5WQ==
X-Gm-Message-State: AOJu0YxP+nDz1udcaoIjiRUw5l49yTLWY+jCfkuIR0QH3AsaJmQEjeLZ
	zknAYUKVMk5rQBIdJcDU/ZXP2ZQWn3PmO6uXncBw1hGN9Un3/luIzQCY5yOu6Q==
X-Gm-Gg: Acq92OHfM7qIMQ/25S3yabVdAtzFkQuZMorsGHI0mh0CH4OvU+OFBnd6y1ua+a4iuHG
	9PCMJJOro1lu7iI+cJ4fTkJG90kR7/HB1KlUlGoVEFbd7kcYR4pdLbhANYFenUAiRnnqb9gzGLD
	QNwFCedsJlzYJSpQmKr7IKDCJTXE0cU/da8Gb8UiapqitGEPud+FCv/113/jer6jlNO8BxqT53f
	okfOC//2tAux23LqDOQguRmQ8zJi6B0Po7bZGq+Gi6EiamPf+OFoW/K7m03HPPhrW74i/8g4etf
	EM4FC2s0iImvfDcGs117FQWp9BcxvrnAKwRWyDfSSFEYCGT4+cxSi1doJ5OSCf+83rlnws0jEh7
	Yk+uU+mVg6HnxFfWfKlw7Fyz3IB/P6mnrN0Mser8QWuEDJnzsSb+wROpcIasG5Yexk9+dc+gvoE
	3TtoDiQPbsw7RfhmxKol4Y5IueFlRA4jNDoGte1xRrmv9xOrA33YfXsSuhTwC8R0ibp3PDf++RU
	wlcd3q9dG6PBOdEJ5dxWj5+IceXO1AiBYSCp5Iy
X-Received: by 2002:a05:690c:b10:b0:7dc:1d92:180a with SMTP id 00721157ae682-7ea4db5d23emr45256527b3.50.1780513370579;
        Wed, 03 Jun 2026 12:02:50 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8186sm22350467b3.4.2026.06.03.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:02:49 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/3] net_sched: sch_fq: convert skb->tstamp if not monotonic
Date: Wed,  3 Jun 2026 15:01:29 -0400
Message-ID: <20260603190243.2789335-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
References: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-294885-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9A5363AC50

From: Willem de Bruijn <willemb@google.com>

FQ currently assumes skb->tstamp holds monotonic time, as used by TCP.

Users with ns_capable CAP_NET_ADMIN can transmit skbs using SO_TXTIME
with CLOCK_MONOTONIC, CLOCK_REALTIME or CLOCK_TAI clockids as of the
below commit.

More recently, skbs also gained tstamp_type to explicitly communicate
the clockid of skb->tstamp.

Detect other clocks and convert to monotonic for use in FQ. That is,
convert fq_skb_cb(skb)->time_to_send. Do not convert skb->tstamp
itself. Network device clocks are more commonly synchronized to TAI.

Conversion may be imprecise due to clock adjustment (e.g., adjfreq)
between when SCM_TSTAMP is set and when it is converted in fq_enqueue.
The common codepath is short, so skew will be well below common pacing
operation. Even in edge cases, bursts (too soon) or beyond horizon
(too late) are indistinguishable from network conditions. To which
senders must be robust, as long as infrequent.

Avoid overflow due to negative offsets becoming huge when converting
from signed ktime_t to u64 time_to_send. Bound lower to mono 1 and
upper to now + q->horizon. This protects against bad input, e.g.,
from BPF programs.

Detect legacy BPF programs that program skb->tstamp without setting
skb->tstamp_type. Here tstamp_type is zero (SKB_CLOCK_REALTIME), but
the value will be unrealistic for realtime in the 21st century. Follow
existing TIME_UPTIME_SEC_MAX as bound between mono and realtime.

Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/sched/sch_fq.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 33783c9f8e16..7cae082a9847 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -537,10 +537,10 @@ static void flow_queue_add(struct fq_flow *flow, struct sk_buff *skb)
 	rb_insert_color(&skb->rbnode, &flow->t_root);
 }
 
-static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
+static bool fq_packet_beyond_horizon(ktime_t time_to_send,
 				     const struct fq_sched_data *q, u64 now)
 {
-	return unlikely((s64)skb->tstamp > (s64)(now + q->horizon));
+	return unlikely((s64)time_to_send > (s64)(now + q->horizon));
 }
 
 static void fq_flow_adjust_timer(struct fq_sched_data *q, struct fq_flow *flow,
@@ -561,6 +561,36 @@ static void fq_flow_adjust_timer(struct fq_sched_data *q, struct fq_flow *flow,
 	}
 }
 
+static ktime_t fq_skb_tstamp_to_mono(struct sk_buff *skb)
+{
+	const ktime_t mono_max = NSEC_PER_SEC * TIME_UPTIME_SEC_MAX;
+
+	if (likely(skb->tstamp_type == SKB_CLOCK_MONOTONIC))
+		return max(skb->tstamp, 1);
+
+	if (skb->tstamp_type == SKB_CLOCK_TAI)
+		return max(ktime_sub(skb->tstamp, ktime_mono_to_any(0, TK_OFFS_TAI)), 1);
+
+	if (likely(skb->tstamp > mono_max))
+		return max(ktime_sub(skb->tstamp, ktime_mono_to_real(0)), 1);
+
+	/* Handle BPF programs setting skb->stamp but not tstamp_type */
+	net_warn_ratelimited("fq: likely mono tstamp with tstamp_type 0\n");
+
+	skb->tstamp_type = SKB_CLOCK_MONOTONIC;
+	return max(skb->tstamp, 1);
+}
+
+static void fq_mono_to_skb_tstamp(struct sk_buff *skb, ktime_t time_to_send)
+{
+	if (skb->tstamp_type == SKB_CLOCK_MONOTONIC)
+		skb->tstamp = time_to_send;
+	else if (skb->tstamp_type == SKB_CLOCK_REALTIME)
+		skb->tstamp = ktime_mono_to_real(time_to_send);
+	else
+		skb->tstamp = ktime_mono_to_any(time_to_send, TK_OFFS_TAI);
+}
+
 static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		      struct sk_buff **to_free)
 {
@@ -579,17 +609,20 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (!skb->tstamp) {
 		fq_skb_cb(skb)->time_to_send = now;
 	} else {
+		ktime_t time_to_send = fq_skb_tstamp_to_mono(skb);
+
 		/* Check if packet timestamp is too far in the future. */
-		if (fq_packet_beyond_horizon(skb, q, now)) {
+		if (fq_packet_beyond_horizon(time_to_send, q, now)) {
 			if (q->horizon_drop) {
 				q->stat_horizon_drops++;
 				return qdisc_drop_reason(skb, sch, to_free,
 							 QDISC_DROP_HORIZON_LIMIT);
 			}
 			q->stat_horizon_caps++;
-			skb->tstamp = now + q->horizon;
+			time_to_send = now + q->horizon;
+			fq_mono_to_skb_tstamp(skb, time_to_send);
 		}
-		fq_skb_cb(skb)->time_to_send = skb->tstamp;
+		fq_skb_cb(skb)->time_to_send = (u64)time_to_send;
 	}
 
 	f = fq_classify(sch, skb, now);
-- 
2.54.0.1032.g2f8565e1d1-goog


