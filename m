Return-Path: <netdev+bounces-18855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C92758E16
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E808281635
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 06:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBFE5242;
	Wed, 19 Jul 2023 06:47:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6CAD45
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:47:58 +0000 (UTC)
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044881BFC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:47:57 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-7682705c039so272114285a.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689749276; x=1692341276;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LrM52kzX9eNA6vn1Q+/ISMM2ennPazWpPjDqunPq+CY=;
        b=qC8dTnVzlFafRIWR+EV9dfav7BJf0aTHEPfO7eGnQREvr80xd63Hf/HLTluiXkmxSX
         aPC0sbvL/DxOVDFlIiHBX6PhP41nd4i4zXcYWqMqpeJdE6Qdz2i7sC31tSFDZKDbxMtt
         DvOHBrBSjUGvAk5z9S9kvrvTZ6IbLhVesjoJ+tfWzKtKRU+DFlRidpMZIwbfk/MEM7Dn
         0AlE3rLxjS+562x1gRVC/DW+yOuQki/oLcfFtrVgP9AW3PFS0eDpjCi35fP9ZCXg+mNK
         s/VdiULFMe5vpCFKnbqtlLw61mE5tNygg+rWqQcrPasb9TdmUdjwfghIeQ9c/S4vK6vL
         Gahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689749276; x=1692341276;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrM52kzX9eNA6vn1Q+/ISMM2ennPazWpPjDqunPq+CY=;
        b=V/nT6d9nCY7N+Yc9aniu48IKHRm/iIrtmU4HiOGcjqxn3h1opbYNDnoj5MN2cjpfwQ
         9MLqG5vIHTrbqFXggLpFowk19moPK0xNrm/+CIapejlc+rW5tDxvERm4z3NCJWXaud7b
         GyVX7kKOJGr7XJX3/NQfPKcLdyKKA5wUdLslkpP+f2lq5t+aUeReIYn36Hb97fkn/bZf
         3HXWCYks7Ve5zUgcleBZRVnJspbntFnbjXQJFzln3EjKC3mju0OcHR/F1N6LJuexHxMO
         du8u3db/p+hp3Us5aJByzvDUYuYlqoICH3erkYUBPpt1vvtlbHL5Q6XYBYOcYSrBzBWT
         O+aQ==
X-Gm-Message-State: ABy/qLbbUzkTfElnNOh+N/LQHGq20w+lFvYK64ez7ggkZruHZeP679jU
	fXpRFwX9YOuXe1pSqpEQAXxWO92HpkQe5g==
X-Google-Smtp-Source: APBJJlGA2GFr/ZWAcaBK3gTT4nwhWnchGlVxMvklqjaMj/QuM2XXS+hlnBCvFDZnNVRs3C0lg6JmXjlUilCvaw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:1b8c:b0:403:daba:38a2 with SMTP
 id bp12-20020a05622a1b8c00b00403daba38a2mr89062qtb.11.1689749276035; Tue, 18
 Jul 2023 23:47:56 -0700 (PDT)
Date: Wed, 19 Jul 2023 06:47:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719064754.2794106-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: add TCP_OLD_SEQUENCE drop reason
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tcp_sequence() uses two conditions to decide to drop a packet,
and we currently report generic TCP_INVALID_SEQUENCE drop reason.

Duplicates are common, we need to distinguish them from
the other case.

I chose to not reuse TCP_OLD_DATA, and instead added
TCP_OLD_SEQUENCE drop reason.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dropreason-core.h |  3 +++
 net/ipv4/tcp_input.c          | 16 +++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a2b953b57689b8233f35ef508716a3128dabb4a8..f291a3b0f9e512bd933b961caa4368367c3c5c6c 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -30,6 +30,7 @@
 	FN(TCP_OVERWINDOW)		\
 	FN(TCP_OFOMERGE)		\
 	FN(TCP_RFC7323_PAWS)		\
+	FN(TCP_OLD_SEQUENCE)		\
 	FN(TCP_INVALID_SEQUENCE)	\
 	FN(TCP_RESET)			\
 	FN(TCP_INVALID_SYN)		\
@@ -188,6 +189,8 @@ enum skb_drop_reason {
 	 * LINUX_MIB_PAWSESTABREJECTED
 	 */
 	SKB_DROP_REASON_TCP_RFC7323_PAWS,
+	/** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate packet) */
+	SKB_DROP_REASON_TCP_OLD_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field */
 	SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_RESET: Invalid RST packet */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3cd92035e0902298baa8afd89ae5edcbfce300e5..2258eebf0f0045c730a3bc2b50fb37176e245c07 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4313,10 +4313,16 @@ static inline bool tcp_paws_discard(const struct sock *sk,
  * (borrowed from freebsd)
  */
 
-static inline bool tcp_sequence(const struct tcp_sock *tp, u32 seq, u32 end_seq)
+static enum skb_drop_reason tcp_sequence(const struct tcp_sock *tp,
+					 u32 seq, u32 end_seq)
 {
-	return	!before(end_seq, tp->rcv_wup) &&
-		!after(seq, tp->rcv_nxt + tcp_receive_window(tp));
+	if (before(end_seq, tp->rcv_wup))
+		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
+
+	if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
+		return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
+
+	return SKB_NOT_DROPPED_YET;
 }
 
 /* When we get a reset we do this. */
@@ -5739,7 +5745,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	}
 
 	/* Step 1: check sequence number */
-	if (!tcp_sequence(tp, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq)) {
+	reason = tcp_sequence(tp, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq);
+	if (reason) {
 		/* RFC793, page 37: "In all states except SYN-SENT, all reset
 		 * (RST) segments are validated by checking their SEQ-fields."
 		 * And page 69: "If an incoming segment is not acceptable,
@@ -5756,7 +5763,6 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		} else if (tcp_reset_check(sk, skb)) {
 			goto reset;
 		}
-		SKB_DR_SET(reason, TCP_INVALID_SEQUENCE);
 		goto discard;
 	}
 
-- 
2.41.0.255.g8b1d071c50-goog


