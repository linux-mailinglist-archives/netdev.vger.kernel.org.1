Return-Path: <netdev+bounces-157180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CBCA0938F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03445188BEDF
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B818B21129C;
	Fri, 10 Jan 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5nHQVAf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124B211298
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519602; cv=none; b=IyVB5n3UdxKAQUqayY9NHWIpcF97I7k65JJH/T7rOYep8cVCC4FqH/u8n6dZ+Wp0N+sBAjL1WrJ+eBFaLoMa2d/MdBDtFmB2GNmFPxj/0Ao28tFBrINWWHA1ZbBoiCJvCoytgxSGQgXTyAJkbzEZcmSys9ZDPm6uhOb8daWJv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519602; c=relaxed/simple;
	bh=1S6qbsBKfTppE9eisub13pjTDPOYeVwUrXKQRjkJgG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lZa9dxpRq363cv8uhP9N3qysk0kdCudHVfiwmkKzagWOzgDfjdPybQQrnTgYGGWO79/0hCnkF1xiUgHf3v60eGPjcUXFcYw3/Bsdm1GA/uyMvkHho447tskDLwf6EMPVglnMHZ0uZrvv2sLlk7gzsOTy291Pc/9mDE9s9utp4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5nHQVAf; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6e1c50ef1so296348785a.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 06:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736519600; x=1737124400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtslpac2oU1C1mFmOo7/eOYL6PrtZjI6ro6i9TjMAzo=;
        b=G5nHQVAfHOXasVEvI2VxNUZ1MnqSZIvWn1+xzi3maeHIFROlw+DLkk64Hf5Xq+jEtU
         Wb3o1ffatsCHN/Iy2xNTXcEnP/xXVvQ0OXLrCsiLIPM/2kTVI6O45Bb1S6jh6i/YX9mG
         v0oplcMLbdHPgMGbR504rBKgJY+6F2fOFf/lb6LUr8KZ5CU8JZqiwSVfcGh1MiYlglE1
         IAVtrSwMEdPCV8r0iLlBcH3LWqAsCYrserGLnFDIRzlkZ2qw01h6HpyaFY9HaS3Sy+Y1
         wvj2qlEzLRobaLuUeNRPiGMBN5JqfbgOS14v4US6ZhxXwlRsCkDpdzm5KguPl/xYduRC
         Sxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519600; x=1737124400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtslpac2oU1C1mFmOo7/eOYL6PrtZjI6ro6i9TjMAzo=;
        b=SMJ7MyHuA3YaSTnn71MnmwcAF7FG0Zfo3ZdD5QE6fAYoJjSSjbjTOZHI8iCOhsyHwD
         wgG2Q7mUB9cHe88ZAONYdpgsVyFM7praFPQcBFocvGBi1AIq2GZ3KsRlQSIpwMhG9ia3
         ymBEu1G/9kUj2rYEW5dkMDCbYHjABkKNT9VOUMnQhU3nzsa7r7cYlrQeEZANGAxdM25v
         kBZT4qwvBzoK65b5gx4/b9yOEbyr5n1hC6T/3RSb7ygR44hzvpBobaLjEkTbq2pC68tP
         PBEsTdlYLA5Bq54F+mf5Kuq2RPGtDi4IiOnpE8Li5MboRs47udLGKUnA3AeOfNErwSYR
         TQDg==
X-Gm-Message-State: AOJu0Ywy/758AIDedYgA4M5+RBBVs4ojHs1toMgpyTL2qhfPXlzaDzGu
	w/NUYAH09d2tkT34kLRqfx3+hAGSFkz9bqpHs2/VjjRbetICm6e10GOANJmqo7kIUeaKJWGCG/c
	Rraoko4TvJA==
X-Google-Smtp-Source: AGHT+IE03yHvuewdIOj5wSQoNyAjz9GUSLAA83MOwUx+Cfey9Ow5byDQZf9hEyEMkVgYOqJoIPacUaeMSA1Jig==
X-Received: from qknrb8.prod.google.com ([2002:a05:620a:8d08:b0:7bc:a1f4:3d5f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:25cd:b0:7b6:de65:9ee7 with SMTP id af79cd13be357-7bcd97ae12fmr1682878585a.43.1736519599957;
 Fri, 10 Jan 2025 06:33:19 -0800 (PST)
Date: Fri, 10 Jan 2025 14:33:15 +0000
In-Reply-To: <20250110143315.571872-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110143315.571872-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250110143315.571872-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] tcp: add TCP_RFC7323_PAWS_ACK drop reason
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

XPS can cause reorders because of the relaxed OOO
conditions for pure ACK packets.

For hosts not using RFS, what can happpen is that ACK
packets are sent on behalf of the cpu processing NIC
interrupts, selecting TX queue A for ACK packet P1.

Then a subsequent sendmsg() can run on another cpu.
TX queue selection uses the socket hash and can choose
another queue B for packets P2 (with payload).

If queue A is more congested than queue B,
the ACK packet P1 could be sent on the wire after
P2.

A linux receiver when processing P2 currently increments
LINUX_MIB_PAWSESTABREJECTED (TcpExtPAWSEstab)
and use TCP_RFC7323_PAWS drop reason.
It might also send a DUPACK if not rate limited.

In order to better understand this pattern, this
patch adds a new drop_reason : TCP_RFC7323_PAWS_ACK.

For old ACKS like these, we no longer increment
LINUX_MIB_PAWSESTABREJECTED and no longer sends a DUPACK,
keeping credit for other more interesting DUPACK.

perf record -e skb:kfree_skb -a
perf script
...
         swapper       0 [148] 27475.438637: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
         swapper       0 [208] 27475.438706: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
         swapper       0 [208] 27475.438908: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
         swapper       0 [148] 27475.439010: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
         swapper       0 [148] 27475.439214: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
         swapper       0 [208] 27475.439286: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
...

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dropreason-core.h |  5 +++++
 net/ipv4/tcp_input.c          | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 3a6602f379783078388eaaad3a9237b11baad534..28555109f9bdf883af2567f74dea86a327beba26 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -36,6 +36,7 @@
 	FN(TCP_OVERWINDOW)		\
 	FN(TCP_OFOMERGE)		\
 	FN(TCP_RFC7323_PAWS)		\
+	FN(TCP_RFC7323_PAWS_ACK)	\
 	FN(TCP_OLD_SEQUENCE)		\
 	FN(TCP_INVALID_SEQUENCE)	\
 	FN(TCP_INVALID_ACK_SEQUENCE)	\
@@ -259,6 +260,10 @@ enum skb_drop_reason {
 	 * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
 	 */
 	SKB_DROP_REASON_TCP_RFC7323_PAWS,
+	/**
+	 * @SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK: PAWS check, old ACK packet.
+	 */
+	SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK,
 	/** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate packet) */
 	SKB_DROP_REASON_TCP_OLD_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 24966dd3e49f698e110f8601e098b65afdf0718a..dc0e88bcc5352dafee38143076f9e4feebdf8be3 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4465,7 +4465,9 @@ static enum skb_drop_reason tcp_disordered_ack_check(const struct sock *sk,
 
 	/* 2. Is its sequence not the expected one ? */
 	if (seq != tp->rcv_nxt)
-		return reason;
+		return before(seq, tp->rcv_nxt) ?
+			SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK :
+			reason;
 
 	/* 3. Is this not a duplicate ACK ? */
 	if (ack != tp->snd_una)
@@ -5967,6 +5969,12 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (unlikely(th->syn))
 		goto syn_challenge;
 
+	/* Old ACK are common, do not change PAWSESTABREJECTED
+	 * and do not send a dupack.
+	 */
+	if (reason == SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK)
+		goto discard;
+
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
 	if (!tcp_oow_rate_limited(sock_net(sk), skb,
 				  LINUX_MIB_TCPACKSKIPPEDPAWS,
-- 
2.47.1.613.gc27f4b7a9f-goog


