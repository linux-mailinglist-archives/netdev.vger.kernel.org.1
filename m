Return-Path: <netdev+bounces-255259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHZ0EPQdfWlQQQIAu9opvQ
	(envelope-from <netdev+bounces-255259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:09:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6916BEB46
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B4C9306F24E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9496C38737A;
	Fri, 30 Jan 2026 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtCyil1V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0938885F
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806995; cv=none; b=unCwqF3oJPxsoL4aDHvqkA2nGyl3aler/beS9ojLwnmnNpG0brF54NyI026aTuO0UJSuZtgJZ9xNInvJZu/j2zFdZaydxQZlXlgcqDfP7zqkOqDSdb1qB4AdPR8naEpXIZ9sAY3qSAnkkkW4ztufgM51hKs4Q5wAR7Rq5IZ5kYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806995; c=relaxed/simple;
	bh=8pmjX2SFdFntjTwUQlQpp1V+DpgNk1u8D0kiAodC+FU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ta2syNynZTwfdYIbuEJxYbSXaf+Xwpd0Utd0wbJqquABjlS5b8mO9HvvpxJwm0mm8XLhKXdB9yYT4tsUF/Tud+xbyuNrf/5inr9NruVkOaCcU9wOAtS7ygftRqw0CKRPOOiNuzma8FMOY+6BGK+coTL4VAk6BPijFqC1MFUIpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtCyil1V; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c6ae763d03so284839985a.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769806993; x=1770411793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPphjm2c1gPQ3kpVx5hq75KVY9OOfxoKNR47+DlFTQM=;
        b=XtCyil1V2IMFoGpfXxvnkrObYe3qN0LIFpJdrRxyVHZe/T/R6zFhVHjc4yCEfcHdUB
         MSBT2U/YreqU7IYSxP7WVZRaj5mOf4hKvj4z6TfXk1/6oO4CNAQZRgA7zo9Ci7RvWlFE
         uiw4lw0E/bppDfy7l4nxxMfJazQ4HtKTgGH3U1A2MBmczF5Jz0/zHNDv8IQcvteU0gCz
         SLpw/fpXIrr+QJiM5O7eZCfeOyeg87q16qHIVbOBvvV8XsNiLnup1oeCkm5tPcC2vGxK
         8sz1vJUkTE0a9hdITsxBUzF0QVmLL7gwsxZlwkhiJ1MEDoqwK9ZSHR6ANZHUDh4TKQrt
         La8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806993; x=1770411793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPphjm2c1gPQ3kpVx5hq75KVY9OOfxoKNR47+DlFTQM=;
        b=K4E/qlgmUad/E6I964y5OaF6ymxvd5rYbdZ/K9mub9SyzrDPoNRh1rPObLaDPQ9yP2
         R6e9SY3s6sHhQ/bKBL8fb+ktJ/ROaeQ+vXYgxYtHHNAd21D3yVNpf3u+xcQHVoDYkoR7
         pZWhwZ/DWASTCnmYoKwpgdA0IzAPjtNTWCJ/I+eZp5UcOWd+u/2Ewfb8qQk30ulQltAB
         nuLEf92i5CWyZdNjzw3Rq1JSw8BCQkSO9GzL+CPWiTSkRixol8+NSEl3E1GM6M2C8ZHh
         o/sc9JJq1niU8kczRD9LdK46eFaUFuyDfpcHvd8Scid/URUYP4aknD2S047zsIEhyLIo
         kvWA==
X-Forwarded-Encrypted: i=1; AJvYcCXO1Y2mVoBrmTDmFktgLGQzdrqNR6zwzzsXwp4Sy9wVywlbI0uU/E5FwBDLR/pKpddw6hgA1m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2qJGRbSh/dKuOsNdADZwZDqSV70Pdop1uL5QHYnTNTvIeQoh
	FtnPE9vE2a2A3i/Ofbe+ggcJQ6LL2TRyx7/txjsXY9rZRJb7aIWcXmSHxEMZw4ftIUZA08Mkml1
	4ZhEGQHYOmdOePA==
X-Received: from qkbaz20.prod.google.com ([2002:a05:620a:1714:b0:8b2:e930:ccb6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:444a:b0:8c6:aeff:4002 with SMTP id af79cd13be357-8c9eb349f59mr570799985a.81.1769806992698;
 Fri, 30 Jan 2026 13:03:12 -0800 (PST)
Date: Fri, 30 Jan 2026 21:03:00 +0000
In-Reply-To: <20260130210303.3888261-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130210303.3888261-6-edumazet@google.com>
Subject: [PATCH net-next 5/8] inet: add dst4_mtu() and dst6_mtu() helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255259-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6916BEB46
X-Rspamd-Action: no action

With CONFIG_MITIGATION_RETPOLINE=y dst_mtu() is a bit fat,
because it is generic.

Indeed, clang does not always inline it.

Add dst4_mtu() and dst6_mtu() helpers for callers that
expect either ipv4_mtu() or ip6_mtu() to be called.

These helpers are always inlined.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dst.h       | 6 ++++++
 include/net/ip6_route.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/dst.h b/include/net/dst.h
index f8aa1239b4db639bd6b63f4ddb4ec4d7ee459ac0..307073eae7f83456aa80dfa8686f839b302ca004 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -219,6 +219,12 @@ static inline u32 dst_mtu(const struct dst_entry *dst)
 	return INDIRECT_CALL_INET(dst->ops->mtu, ip6_mtu, ipv4_mtu, dst);
 }
 
+/* Variant of dst_mtu() for IPv4 users. */
+static inline u32 dst4_mtu(const struct dst_entry *dst)
+{
+	return INDIRECT_CALL_1(dst->ops->mtu, ipv4_mtu, dst);
+}
+
 /* RTT metrics are stored in milliseconds for user ABI, but used as jiffies */
 static inline unsigned long dst_metric_rtt(const struct dst_entry *dst, int metric)
 {
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 7c5512baa4b2b7503494b1ae02756df29ef93666..a55f9bf95fe393311967b9b94073acb3860214aa 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -266,6 +266,12 @@ static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *));
 
+/* Variant of dst_mtu() for IPv6 users */
+static inline u32 dst6_mtu(const struct dst_entry *dst)
+{
+	return INDIRECT_CALL_1(dst->ops->mtu, ip6_mtu, dst);
+}
+
 static inline unsigned int ip6_skb_dst_mtu(const struct sk_buff *skb)
 {
 	const struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
-- 
2.53.0.rc1.225.gd81095ad13-goog


