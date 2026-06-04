Return-Path: <netdev+bounces-295411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SVsHDNHWIWrTPQEAu9opvQ
	(envelope-from <netdev+bounces-295411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:49:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5964303C
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:49:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MmYgwdvI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295411-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295411-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 542B53042599
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F6B3C0605;
	Thu,  4 Jun 2026 19:42:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29C3BB110
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 19:42:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602161; cv=none; b=rEwWXmFfwEObtWZFd1Fnm8qKNlPeIHmpzWc6c915ch6JGiqpkPxKkdcwxmAlCqSlEIFv16yzxS1nQ0kPt48mrNjzN2Pt1p3Lxc53dQN7RcB/b0gRkdiKSLJy3vBVtfuUKJiWH/TcxgEvpZVV0wRO0QvWLad1NRESOckCEdzypCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602161; c=relaxed/simple;
	bh=M4hiF7YwPI2lYWjpD4J9bD0R34K0vwa07RO0lqlO1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRd3zk9z0f08uNVA0PRvC45gInHjMY7Ka7RH7xQOUq09Ay9aJES5dAvYbCppib6l1lpIsgnfSjirt75J98AxbXmgUOsKZOPhnAY4wrzvsoif9YS48eNIz79kWEj9sDE09io8osnkhg34HfwTFXZaRSdvJt+ojCdRQrNuaswMlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmYgwdvI; arc=none smtp.client-ip=74.125.224.46
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6603246b66dso1301309d50.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780602159; x=1781206959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3QXrG/2vKJvfso7g4Rud2xgiuOiKBeiLVu5uA2xl9s=;
        b=MmYgwdvI4bLbVuopplgfZcYu68OW8LTaDPFAFSUrDZPKHqnsVYeoMjr6qSu8h7okO4
         yuBkl21CZXCj5fvSAx+8kPg1SgrgF5GEmPz2kNc90vokcncACwuQHy3X3P98fg2dadb4
         4iE+lGKlu/ELofZxop/cKk4ejR2FdGGlrL2wonxyBimaub69GzGOUqrMPNaMRisx1Qah
         +3Klo8ZfylCnc+lLCwTYnO2vmNMDXF5LTwICp0T4goG9QU2ss7e7TxSmdvtLb3Ms8r0K
         Y/efcx/FNz0kCg4ew5Z6ijkG8kCqVqan9v8SmEcuGRXbjBI00aGaGAf4mfObTRqhPYd0
         iWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602159; x=1781206959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O3QXrG/2vKJvfso7g4Rud2xgiuOiKBeiLVu5uA2xl9s=;
        b=k52ZgwD/TgFHm2IvVNub4xO1VBrwU4O9DBGnTWEnCbCo/0ECD8Tv8uwuvXbuIXQTBK
         isBz2H7GSbpE6X68bErMjs9erHVjb4nOyIEptZ896+W+m+IABjfFgqX8wzHJOiKSRfcw
         lOV5JFCZU0x9WTVqGOjESoqpet4BjiR27EjoRd0CBPU1O/Xj+u5IBMdijdjy45G/Dhai
         M1iePi+eJsmkR0ibZo14klAEJ9BQnJtzLx+W7b9OeVAqjIF0lbp8AUWjZRq5S58iV01W
         EoA1tlPslb0H05JaLzny6eQraa8WimlzqiRwz+r0CI+UwwgB3cVd2OecDkU7T7DgVqzF
         cYOA==
X-Gm-Message-State: AOJu0YyzcpiDxmBoW3z9FLKkPJeMzb6LSEEPYQAOpPePJlsDQt4u7EwJ
	K7frdn141RIixVj0Et41GtJZesI8PwelTNXMiujWHov4MZVb8crdo1EIFruWYw==
X-Gm-Gg: Acq92OGVuaU949+K2+wzbPszXz7bpwii2Kwk4+xw597X6L7FAbOTx0fdYbTS7x0kO/d
	TJWsHZRkQYp4dWaA5Rpbnmv2ApJPDnI5Yv4OeCrSmgYPvaGBSpBHbmUI1c/Tpaeyqy4ZY9mpQhq
	WWgZrK6hyR18cHZKTCD6+Xp51GyJaYZlWbz60fF1ECwWkBgUTR++W2owCjQovUIu0SJKa1odSbD
	osBsnb0X2V0Um0BAp23jBa/G03KlQApN+ZDjW+Fh95uzdqhXikpkS7ydpRDBsWmDVAWQ+YknajB
	KLQ4IpFUUL0Ld2ZdRHbSdvnMEwnuQmlaK8THryAK88c0+9cywYV3qFnVmtuyCJI1wLJaW9G4YIo
	KSKKf+PtXsFD0v+H3n+DCrLd3+EGmYiOGkjCZPk8r5wPqmlBpmwxmzIej2hYPI3PHR2b8ZIUcEk
	5HB5AjX0fF2ZSBjfhXjLBN4NMcYAr+V3c7SeoUH8LJshOpY2fq9OX/qVrxWxGVOMu4p6uziAhjN
	8FZj+vBHpyZebvg2Lt4uhQVwddD/UGo/rzDMRRb
X-Received: by 2002:a05:690e:484c:b0:65c:4066:d17c with SMTP id 956f58d0204a3-66106dcf1dfmr171252d50.8.1780602159192;
        Thu, 04 Jun 2026 12:42:39 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f883e2sm4360772d50.6.2026.06.04.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:42:38 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 2/3] net_sched: sch_fq: convert skb->tstamp if not monotonic
Date: Thu,  4 Jun 2026 15:41:04 -0400
Message-ID: <20260604194221.3319080-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604194221.3319080-1-willemdebruijn.kernel@gmail.com>
References: <20260604194221.3319080-1-willemdebruijn.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-295411-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86F5964303C

From: Willem de Bruijn <willemb@google.com>

FQ currently assumes skb->tstamp holds monotonic time, as used by TCP.

Users with ns_capable CAP_NET_ADMIN can transmit skbs using SO_TXTIME
with CLOCK_MONOTONIC, CLOCK_REALTIME or CLOCK_TAI clockids as of
commit 80b14dee2bea ("net: Add a new socket option for a future
transmit time.")

More recently, skbs also gained tstamp_type to explicitly communicate
the clockid of skb->tstamp, with commit 4d25ca2d6801 ("net: Rename
mono_delivery_time to tstamp_type for scalabilty"), commit
1693c5db6ab8 ("net: Add additional bit to support clockid_t timestamp
type") and a few others.

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

Signed-off-by: Willem de Bruijn <willemb@google.com>

----

Changes
  v1 -> v2
    - replace Fixes tag with references inside the commit message
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


