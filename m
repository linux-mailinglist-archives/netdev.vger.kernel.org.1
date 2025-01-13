Return-Path: <netdev+bounces-157755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB46A0B8DF
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BFA3A24D0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3337F23A586;
	Mon, 13 Jan 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1SmmVfa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819992397B5
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776565; cv=none; b=BhgHReOq1F8QCh6Gr304DOzEB7DPOMSigL7nsFYwbrbdnPRssaeHhWksHXK3pctiK/6zKtT8oByhIQcxl3XR6k2eIMqLzpzcviOPlmHOB52hU9oTkDKAebOymeRTFFdTNQtf/RCVrRx65S2SXVQaHXeylm81LeSFRU0U41p10R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776565; c=relaxed/simple;
	bh=Kvm9+Dez3YLepfPHoKcca3bIIsvFVh+k7L4BogIbXCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VOpJK24+tdHzzdz3/d+ewUgFV0otJmwtm24Zts1LJ5apQqCuEf+tjn+wOA8wiELxSCClXvKwR03gshi7515jfaYkYW9OdBbynrfyy9oy/aa+fGLz/nzT+4h4PqPrcINLE4MUgTyMToxzHh8W0AVMi5RZPXtTfkhh7L8ieBJpFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1SmmVfa; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e53bf9e60e4so9957074276.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 05:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736776562; x=1737381362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FMDm8S+gZ1xmkoqPNsmlzlxEiE3dU72laviv30xoSo=;
        b=n1SmmVfa9voLNNPjT+GE8CThy146MfSCsPFjMiGBpdxJ0y9cpZpV8drP0mUeTTvhOJ
         0SBfzr7uX9iSeHFA4cprmt0x8vcFMLlFG8mvaT791aDPu196COVaiKYicsX8PVwYSFhu
         jcv0I8567RRWODXuNpHvSqxkVgYLEJ4cno20YPiTI3Y/5Vl4Npsq3sTuEPiFVbd5vgXz
         F8whQLp0dFeDBwGygJSW2kJlyD2fKBZ8FKzXcD085fqq5w40KDDR99Zc3yvHzK5Tu4EZ
         xRcoiynDZw+ehDDvl2gkewSsVoUti9TNr9DMkgteS9FV+b3joAT69HawFLEQO+c22CEC
         4LQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736776562; x=1737381362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4FMDm8S+gZ1xmkoqPNsmlzlxEiE3dU72laviv30xoSo=;
        b=MMuVp1REtDHrNI+r+kI+vZkEu4d+5JEbLpjlmDQhPxj7nkTfVmof444Q10JujIKVI0
         raz5uXiATJLqJgFYMWy7mGC8YlQn6R59JjiY3QqV/IsCRd7yZ6ZRgtkPCoMcCct5z06P
         9VxQtl0aewPqLY9nlNypWm89LwNKN+kXufnMfXbN1DDKOFWUD6HQnmx8xNyZytdd0eUq
         N5IJY34AQUojkfQonx2TADBVXzliHjxudeiM0jEo0o/Ljc+XYXrl4eu5ELgi4eIK6lBK
         gC++zdXr+XqJ3cFOdcwCAVzoZC7hgnXJcILVKK0wBHEdmHon/3SOqFIc7fnerzY5hC4B
         PJvA==
X-Gm-Message-State: AOJu0YyNBtrmknWNNEndTw/WxzoA8xp9fwF1I54EjsG7+YxzsMQ4X1P4
	rpHr3wK6yaGKiAeA5pzsUn1Foq0b5ab6eu/JcNS/UxWJMKqLmQubdCtjMYh0r92r80S66dYNxuH
	oXeJziJ1JXQ==
X-Google-Smtp-Source: AGHT+IEhgnvYKvLO6EH1TYccJZvZbOTbHFZsJf8V6Z/G3GgHrOVRHaZV0nfZ7svePS4LNYuuPymNYsEE7p7oXw==
X-Received: from ywbhr4.prod.google.com ([2002:a05:690c:6404:b0:6f5:278e:e957])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:998c:b0:6ef:7640:e18a with SMTP id 00721157ae682-6f5312dd1a3mr162662417b3.31.1736776562456;
 Mon, 13 Jan 2025 05:56:02 -0800 (PST)
Date: Mon, 13 Jan 2025 13:55:57 +0000
In-Reply-To: <20250113135558.3180360-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113135558.3180360-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250113135558.3180360-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/3] tcp: add TCP_RFC7323_PAWS_ACK drop reason
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, eric.dumazet@gmail.com, 
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

A linux receiver when processing P1 (after P2) currently increments
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
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


