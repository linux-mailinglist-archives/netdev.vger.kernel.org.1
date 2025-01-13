Return-Path: <netdev+bounces-157756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CFBA0B8E0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CCD166844
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665E323DE9A;
	Mon, 13 Jan 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSSbUxLj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44BD23A56F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776566; cv=none; b=KJUNfg5URbyRqll33/Ry/ofbY+1ZxWsLh2mqiuzaTSXtMo8VOlJS8+lLYLtBhHZwbY37dIQfTPd4lZ0Gc+eoEPAroBLFqGj1CJ82HL8fvVKwC9fQLvI0uniE3HrP2pg6Ak/UtpL7rju3zz1P5VGvtLh5NjHk+Arm/z6d64bBfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776566; c=relaxed/simple;
	bh=FnRT7xDm2jSZw8J8X01x/L2LSRGmct7Y7egsQtkZ8F8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eFLbf8x8xa6vCvI54+C9QMyybt1jxHXu0WFnnW2re/L0wH+kDRoRZ6d3z955b55VCLHHRVn5lnlpFhF3ZzZkGN8UGjHl9gvtGRkYay+Jq2ZJdLFtSaTgZdCor9BrOyraL0ZhW9/zvlT8PWlyCZc1Z8UxAurXQBdy5xQK5szey7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSSbUxLj; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6e1c50ef1so629008685a.2
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 05:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736776563; x=1737381363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=72NehsPMmIfpXsz7Pze5hUJE5FfsrxMMp8HLRAq7MS8=;
        b=vSSbUxLjFduFxlg6tkcJnj68aJEglTMZw4S7xcByOpQseE50pjivsYMDCcgRNiilBf
         LwvD6BJ78s6zWBNo+9J5FOk9FysC4tKzBAQBp2lhADwueg6+aBioWQobtMULzeVPqCpO
         WFgiOr2UYWwDg0N8uAnJOfx9nYccZXL/Ja98VnbJ/U0ehrlvC7n6Rbxg80uUUVPZLSnd
         ika60W2zLkkCd6TIl8CliToJwvP3wxnhGH3NpJsgsUiLyqobn07E2uoo51x9o7D3p4Wp
         NCV5G0yBrddnD2y9Us1VwQhd5TKyp4oHgNwQgvEOQXHvVYccmpugMKj5rj8Tj7vDSQaR
         Jj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736776563; x=1737381363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72NehsPMmIfpXsz7Pze5hUJE5FfsrxMMp8HLRAq7MS8=;
        b=NtapTcpnTljJlqgfQsZ0gO/XbT2QgWAWUuOIJM2CqKdzXyEQrQ+0B90TwyP96NNAmN
         2YlrC23o8D6dLY4dfmRASHzIMpNGKLN0fa8OrDk9pBJRSoVM54Q4hh9F0c5uAShAdtJF
         e4ZkQKVve7i0a6hjxdyMDnCCGctXxWXZrq+Ny1BsuF3QsD/kT6ekxypXq1z2p2F9EYFg
         DNJDH6JRUWi84m2ghEp1/e8zBAwmYCvgu+v8ZkZ84q19MUT7kVJIBZ+4RZOPZlHozbQN
         vyUVmpqWG7Xk76RGqy06h3HcWN09Oex7SLKsun55iI5puNsORbtnij/k9nzeIH/gwVZw
         wVlw==
X-Gm-Message-State: AOJu0YxAp70/1qqIH+3gcvOkl5Drl0SDcR1tJSD3Zhb/8J3UiiHb21rX
	jSp5887Mof7Kucen1EVpg2naJpS2j1vP5odlOuKETMIOMIOQ0ftu1Sk0CLUiMi8Fl4Gl7CZtHpO
	F+0lloGHjfw==
X-Google-Smtp-Source: AGHT+IHnpuiQWV4PZYmwmCL7KTGCNBhycp0YTXBZQqoSC34Wq5yT4fo5uwQ15HsspVccRuE7qRqwTl52UNo+Wg==
X-Received: from qkbbi10.prod.google.com ([2002:a05:620a:318a:b0:7b6:ed9f:7b6e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a016:b0:7bc:db11:4945 with SMTP id af79cd13be357-7bcdb114b95mr2590067885a.51.1736776563733;
 Mon, 13 Jan 2025 05:56:03 -0800 (PST)
Date: Mon, 13 Jan 2025 13:55:58 +0000
In-Reply-To: <20250113135558.3180360-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113135558.3180360-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250113135558.3180360-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/3] tcp: add LINUX_MIB_PAWS_OLD_ACK SNMP counter
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Prior patch in the series added TCP_RFC7323_PAWS_ACK drop reason.

This patch adds the corresponding SNMP counter, for folks
using nstat instead of tracing for TCP diagnostics.

nstat -az | grep PAWSOldAck

Suggested-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dropreason-core.h | 1 +
 include/uapi/linux/snmp.h     | 1 +
 net/ipv4/proc.c               | 1 +
 net/ipv4/tcp_input.c          | 7 ++++---
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 28555109f9bdf883af2567f74dea86a327beba26..ed864934e20b11fcf91478afe2450b2eadce799f 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -262,6 +262,7 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_RFC7323_PAWS,
 	/**
 	 * @SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK: PAWS check, old ACK packet.
+	 * Corresponds to LINUX_MIB_PAWS_OLD_ACK.
 	 */
 	SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK,
 	/** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate packet) */
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 2e75674e7d4f8f50f624ca454e6d7d1ed86f5c26..848c7784e684c03bdf743e42594317f3d889d83f 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -186,6 +186,7 @@ enum
 	LINUX_MIB_TIMEWAITKILLED,		/* TimeWaitKilled */
 	LINUX_MIB_PAWSACTIVEREJECTED,		/* PAWSActiveRejected */
 	LINUX_MIB_PAWSESTABREJECTED,		/* PAWSEstabRejected */
+	LINUX_MIB_PAWS_OLD_ACK,			/* PAWSOldAck */
 	LINUX_MIB_DELAYEDACKS,			/* DelayedACKs */
 	LINUX_MIB_DELAYEDACKLOCKED,		/* DelayedACKLocked */
 	LINUX_MIB_DELAYEDACKLOST,		/* DelayedACKLost */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 40053a02bae103a9e1617ab0457da6398d75cd85..affd21a0f57281947f88c6563be3d99aae613baf 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -189,6 +189,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TWKilled", LINUX_MIB_TIMEWAITKILLED),
 	SNMP_MIB_ITEM("PAWSActive", LINUX_MIB_PAWSACTIVEREJECTED),
 	SNMP_MIB_ITEM("PAWSEstab", LINUX_MIB_PAWSESTABREJECTED),
+	SNMP_MIB_ITEM("PAWSOldAck", LINUX_MIB_PAWS_OLD_ACK),
 	SNMP_MIB_ITEM("DelayedACKs", LINUX_MIB_DELAYEDACKS),
 	SNMP_MIB_ITEM("DelayedACKLocked", LINUX_MIB_DELAYEDACKLOCKED),
 	SNMP_MIB_ITEM("DelayedACKLost", LINUX_MIB_DELAYEDACKLOST),
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index dc0e88bcc5352dafee38143076f9e4feebdf8be3..eb82e01da911048b41ca380f913ef55566be79a7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5969,12 +5969,13 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (unlikely(th->syn))
 		goto syn_challenge;
 
-	/* Old ACK are common, do not change PAWSESTABREJECTED
+	/* Old ACK are common, increment PAWS_OLD_ACK
 	 * and do not send a dupack.
 	 */
-	if (reason == SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK)
+	if (reason == SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK) {
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWS_OLD_ACK);
 		goto discard;
-
+	}
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
 	if (!tcp_oow_rate_limited(sock_net(sk), skb,
 				  LINUX_MIB_TCPACKSKIPPEDPAWS,
-- 
2.47.1.613.gc27f4b7a9f-goog


