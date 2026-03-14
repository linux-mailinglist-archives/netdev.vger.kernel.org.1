Return-Path: <netdev+bounces-267855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDV7C8/CtWkV4wAAu9opvQ
	(envelope-from <netdev+bounces-267855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:19:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8907928ED8D
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 455FB3091C89
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9F7388399;
	Sat, 14 Mar 2026 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOWC0qXh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0338737E
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519295; cv=none; b=lY4PLDQgbXUtjSJDOZpbzgISM2hz7gwXrrgYPrLekVn1GeGw9jfXNp8WBJ5ns7hLkUdUTDm8ksTQKCMb++ohW2cuOKMOaw6oUg2iIZDPrQFxHfNtjuwDhmKwJxfagd7hO+QYefOccYrJXhzYxnSg7fxLL8/f45i1slTA5I0rhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519295; c=relaxed/simple;
	bh=ww0RG9/Q0OVKyskNxv3bbhNoq1jg/FnsAuo6CN8DsUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hahrg6nM+TOujL3FS/8t/DsFK2D1HO+MEB9gjUvdqXLBNHIVdSpcapnoM+Nyh7G7iYjv13Re9b8dwIyLTGX7Z8QZPwU8d3CNAOS0E6VREZTCcWQTAljQf3JVUclGFVebLrX4cwhRcUu+glVEaLuiiHniMZI7TfcMG6rSZQ08b9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOWC0qXh; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40f387a688dso2616686fac.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519292; x=1774124092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSj81+CF0f4yFIE+he2UWBsfbEKSyH1G8KBdb3oc/PY=;
        b=AOWC0qXh+17dY5zV3bR0wBdty1DN4PVf4/qwtPFcaS+XM1Djn8KeVi5gDTy96aBuvq
         xxTCXRv1DcXqaZS1iOaiahU5QeEVdTPt29VzILWyJLSwn4/Of6Hvu9SeiVuibgzSy1UI
         BTkqBFEUPrRKibNQJ8EiR0USjSx1NjQfRAcsYaZor/av3f4jS7NJys2xlYBY4h0bKa3O
         NFewcN29iIS2T+Zwb28EGxipknPGSw0YQ/2R+Ccs7H8fBhzR3WaO3SMRv0kxt7sShsdy
         gfo17VuqIp6fauojTs7NUc3YQLhSfSPecz8x/2LMVqMMBIU+6c6jcx9RS2GgbprsTzYW
         xgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519292; x=1774124092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LSj81+CF0f4yFIE+he2UWBsfbEKSyH1G8KBdb3oc/PY=;
        b=rHL7F5WJsi3TSjOxX9Vs30CtL38iuHRoSLEzDkbMTAZ2Oyp1GXti+88GF/xk2RIE8/
         5/0YM+mTrMcjlc+BhXHCbCYDatrPj2Ss/d4Bzgc5bZkot4Qaxee2s7RpebnVXz24CKpy
         EO+2OE4+ncN4PJjeT8cpL7gUQ/1bZw1aEJeoHG0+4uSupuo6C7XGXzr+a+1g72eyP0zV
         RkETyskzTRoz7WTAxpIOkptL/uhkcvZU5VrIU1J2Zq6rPbcIMpny9OtPcla6POtPMCCu
         VL7a2l8eeRKUGj4P5NCz47Pim3IfyV2jnnFSqLJ1J/Wdi2siHG0qTAYcW88TByrJxUYQ
         yOTg==
X-Gm-Message-State: AOJu0YwdsO4GehLfg8xg5mTIDjjaivVh88OG1QLpjVAq1g5nARWiRX/G
	hpMJ83zpnVA2SKGQf5uYrJUgVmSTtkuhQdopbYsialgokHscr/K27S0yu4fH76KH1Fk=
X-Gm-Gg: ATEYQzwnuHs8OyB5so/zPNKkZY+o0HPbSNybMkhgyNkjo1AiEATDK+n2wVGdN5VrhQc
	ih4l5ndK8xKaDW8mFw8tpMmLAIgfvJthH0fjwDJl/94wpZ3vQngJKoVWMv7FkdVHT41e8s6kiye
	L3DE8dUYi+2yIr+mKt+neQQTURRqF/QnM/i3/1aiI8yK3bxZNaFow1LnMpYEm8fkOAKUhLUBX5s
	Rg9dvc/1z+th9Xw/FMHGwSvuhbqcRBw4cRiN6COJeP5iSjZmlh34iROh2NjLlH4FyxmluaZ0dkM
	2Xye+EPGpdJvYJEMxrQeKZZkv10/Al/UqlwqduBW9EBk3Foa9sRUt5eUfMaqMp6z4VPm++AiFvl
	y6uNjjXVjN25G/RDH/L2A/kQuz7857k3Hsb8JgMeoxMtjz5r10SitFZi7FiPOfaqwtg0ycXYP6n
	0728TSAURadfeODqd2YCWR53MSd4POGCJC4AKZ4P+hfT8UDEvoFSM4pqjBWYSDgfJy3SyQH/2NI
	xFH1jojZQmOj0yJUsqPFZ4dRFxlJvFXq65srHARekUJHFEF+cM=
X-Received: by 2002:a05:6870:309:b0:40e:95b9:40e6 with SMTP id 586e51a60fabf-417b946c51fmr4109655fac.40.1773519292142;
        Sat, 14 Mar 2026 13:14:52 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:51 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 07/14] tcp: honor the maximum advertised window after live retraction
Date: Sat, 14 Mar 2026 14:13:41 -0600
Message-ID: <20260314201348.1786972-8-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267855-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8907928ED8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

If receive-side accounting retracts the live rwnd below a larger
sender-visible window that was already advertised, allow one in-order
skb within that historical bound to repair its backing and reach the
normal receive path.

Hard receive-memory admission is still enforced through the existing
prune and collapse path. The rescue only changes how data already
inside sender-visible sequence space is classified and backed.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/ipv4/tcp_input.c | 92 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d76e4e4c0e57..4b9309c37e99 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5376,24 +5376,86 @@ static void tcp_ofo_queue(struct sock *sk)
 static bool tcp_prune_ofo_queue(struct sock *sk, const struct sk_buff *in_skb);
 static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb);
 
+/* Sequence checks run against the sender-visible receive window before this
+ * point. If later receive-side accounting retracts the live receive window
+ * below the maximum right edge we already advertised, allow one in-order skb
+ * which still fits inside that sender-visible bound to reach the normal
+ * receive queue path.
+ *
+ * Keep receive-memory admission itself on the legacy hard-cap path so prune
+ * and collapse behavior stay aligned with the established retracted-window
+ * handling.
+ */
+static bool tcp_skb_in_retracted_window(const struct tcp_sock *tp,
+					const struct sk_buff *skb)
+{
+	u32 live_end = tp->rcv_nxt + tcp_receive_window(tp);
+	u32 max_end = tp->rcv_nxt + tcp_max_receive_window(tp);
+
+	return after(max_end, live_end) &&
+	       after(TCP_SKB_CB(skb)->end_seq, live_end) &&
+	       !after(TCP_SKB_CB(skb)->end_seq, max_end);
+}
+
 static bool tcp_can_ingest(const struct sock *sk, const struct sk_buff *skb)
 {
-	unsigned int rmem = atomic_read(&sk->sk_rmem_alloc);
+	return tcp_rmem_used(sk) <= READ_ONCE(sk->sk_rcvbuf);
+}
+
+/* Caller already established that @skb extends into the retracted-but-still-
+ * valid sender-visible window. For in-order progress, regrow sk_rcvbuf before
+ * falling into prune/forced-mem handling.
+ *
+ * This path intentionally repairs backing for one in-order skb that is already
+ * within sender-visible sequence space, rather than treating it like ordinary
+ * receive-buffer autotuning.
+ *
+ * Keep this rescue bounded to the span accepted by this skb instead of the
+ * full historical tp->rcv_mwnd_seq. However, never grow below skb->truesize,
+ * because sk_rmem_schedule() still charges hard memory, not sender-visible
+ * window bytes.
+ */
+static void tcp_try_grow_retracted_skb(struct sock *sk,
+				       const struct sk_buff *skb)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	int needed = skb->truesize;
+	int span_space;
+	u32 span_win;
+
+	if (TCP_SKB_CB(skb)->seq != tp->rcv_nxt)
+		return;
+
+	span_win = TCP_SKB_CB(skb)->end_seq - tp->rcv_nxt;
+	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
+		span_win--;
+
+	if (tcp_space_from_rcv_mwnd(tp, span_win, &span_space))
+		needed = max_t(int, needed, span_space);
 
-	return rmem <= sk->sk_rcvbuf;
+	tcp_try_grow_rcvbuf(sk, needed);
 }
 
+/* Sender-visible window rescue does not relax hard receive-memory admission.
+ * If growth did not make room, fall back to the established prune/collapse
+ * path.
+ */
 static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb,
 				 unsigned int size)
 {
-	if (!tcp_can_ingest(sk, skb) ||
-	    !sk_rmem_schedule(sk, skb, size)) {
+	bool can_ingest = tcp_can_ingest(sk, skb);
+	bool scheduled = can_ingest && sk_rmem_schedule(sk, skb, size);
+
+	if (!scheduled) {
+		int pruned = tcp_prune_queue(sk, skb);
 
-		if (tcp_prune_queue(sk, skb) < 0)
+		if (pruned < 0)
 			return -1;
 
 		while (!sk_rmem_schedule(sk, skb, size)) {
-			if (!tcp_prune_ofo_queue(sk, skb))
+			bool pruned_ofo = tcp_prune_ofo_queue(sk, skb);
+
+			if (!pruned_ofo)
 				return -1;
 		}
 	}
@@ -5629,6 +5691,7 @@ void tcp_data_ready(struct sock *sk)
 static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool retracted;
 	enum skb_drop_reason reason;
 	bool fragstolen;
 	int eaten;
@@ -5647,6 +5710,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 	}
 	tcp_cleanup_skb(skb);
 	__skb_pull(skb, tcp_hdr(skb)->doff * 4);
+	retracted = skb->len && tcp_skb_in_retracted_window(tp, skb);
 
 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	tp->rx_opt.dsack = 0;
@@ -5667,6 +5731,9 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 			    (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
 				goto queue_and_out;
 
+			if (retracted)
+				goto queue_and_out;
+
 			reason = SKB_DROP_REASON_TCP_ZEROWINDOW;
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
 			goto out_of_window;
@@ -5674,7 +5741,20 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 
 		/* Ok. In sequence. In window. */
 queue_and_out:
+		if (unlikely(retracted))
+			tcp_try_grow_retracted_skb(sk, skb);
+
 		if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
+			/* If the live rwnd collapsed to zero while rescuing an
+			 * skb that still fit in sender-visible sequence space,
+			 * report zero-window rather than generic proto-mem.
+			 */
+			if (unlikely(!tcp_receive_window(tp) && retracted)) {
+				reason = SKB_DROP_REASON_TCP_ZEROWINDOW;
+				NET_INC_STATS(sock_net(sk),
+					      LINUX_MIB_TCPZEROWINDOWDROP);
+				goto out_of_window;
+			}
 			/* TODO: maybe ratelimit these WIN 0 ACK ? */
 			inet_csk(sk)->icsk_ack.pending |=
 					(ICSK_ACK_NOMEM | ICSK_ACK_NOW);
-- 
2.43.0


