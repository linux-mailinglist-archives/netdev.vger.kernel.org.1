Return-Path: <netdev+bounces-284045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKrPB+AK+Wnt4gIAu9opvQ
	(envelope-from <netdev+bounces-284045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:08:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C26F4C3E2A
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F082E306294A
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9022D33E35F;
	Mon,  4 May 2026 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICjNUjgR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF433F582
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928782; cv=none; b=fF9VbSWNH4K6G5P2BIpserQ4zdEsSrZCMe8LMeJRzkDtEQBe1N0LI6sfiRsFCx1sY41PrXSUQ+K0q4SMmzSPzwzjo5uPNycY4eAiytbusvkRbIDuHIsarkzcR7v5ZBYC5kh/F9VcaQbGqYtNauuZAEG0koFJXpshTH50P5gfz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928782; c=relaxed/simple;
	bh=cG/yesVRvvntcKSQhtEbypsl9lWGthOVsQu6VxN6nT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o45yJUfy1aXxv78KbqxsZUbv19C+3yn+NuoBA4Dlem8jz+p1zojweX0Wo2iBOBOC/B6TI/OshwaGMys268suBBlXa48iyWa7u9c2sySea4iWXKWXQHzhxYOKuVhl04lavCo/CTDhm/7yfCJ7Lrs9zSYbXod/N4JRAiYBkev7o4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICjNUjgR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-835444b6ce1so1064119b3a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928781; x=1778533581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zoNImAKoVG1tOJMnje5UjYQ+6eRMKYNpQz4KdMgcck=;
        b=ICjNUjgR/Ph15ePSxM5cM96i+7OtqSKgpDtCoa+fk+XhuWMwf69HpVB+4euOvf68Y1
         cz31ZoBqjrHk/sukJDCE1Tc6H3T3Z4v95pD1RftMg+2eZJHFGe9ukKBJC3I5w2UzL64M
         mcWte52a6PugvicNVVCrLabYjLjjXVlp5S1JPv0GqbIX6kVkfB4woGbi7g+OVF6Px0BJ
         SdY1i1pgtSq3MXROZZt41SBXwbX7bowbd0LGhjM1V0O3L0/nJfoRu+2/w9m3OdCTdLgq
         DQIqaMWi2Qog1BP4TzAe2gvse8pRE2WWJPZq9Ep43g53p2vuWLbMjqSfYXOtNNTX8fdk
         GNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928781; x=1778533581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zoNImAKoVG1tOJMnje5UjYQ+6eRMKYNpQz4KdMgcck=;
        b=Ybazi5lHxhfiQL0GSkGtV25NKWK916uwT5CToS1gDgddUVurFfgKnJegFs3vpsFk1Y
         o2iznUzs+IkyC+ZZuWhEQuvXaC5vWTIVBhJ9Xyiq1WAB0Jy77HCRJA5HwlS3NniGY361
         ulHAwGFyg2vibnLnNueIrbGhxGPzPsr3FLjtDsJFIJUcwvGamvxHtk4cSUaX9/KoTByq
         zYwHZ/Rrem42nyvzHzszZZ02sQAOdmfSkzUUMBFHAkWG93zzA1iYay8hi/Hxj6ZDsSVa
         Q+W4Ma+AjMAF+vmzNmr/7rbnpE9kTKhcXop1k3B9cmooYj63mOrLH44KOqYts44vL2C2
         ZlAg==
X-Forwarded-Encrypted: i=1; AFNElJ+Li2NrD7COCR1Vl7YWoqR2AK91rU8xnPn+Dk5416zR0qD+CfYk+y3Zpmv2hh0X9Dav87FYOO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvmp7YX9NhkoY+eqRpI3/Ek0xZMmTrClQ2uVN8zw6+4PbTGgYZ
	d2Lq3pcBxYemvPWuCiKeK1qdU+dy5NhKSSzm7VbexplR6s55qO2dkGLzAS7H2ItVihHVTJqw8fa
	g4LHk1Q==
X-Received: from pfud19.prod.google.com ([2002:a05:6a00:10d3:b0:82f:20ed:8059])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:288f:b0:835:405a:7e68
 with SMTP id d2e1a72fcca58-835405a7fd9mr7331136b3a.32.1777928780467; Mon, 04
 May 2026 14:06:20 -0700 (PDT)
Date: Mon,  4 May 2026 21:04:52 +0000
In-Reply-To: <20260504210610.180150-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504210610.180150-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504210610.180150-6-kuniyu@google.com>
Subject: [PATCH v2 bpf 5/6] bpf: tcp: Fix type confusion in bpf_skc_to_tcp6_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7C26F4C3E2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284045-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

bpf_skc_to_tcp6_sock() only checks if sk->sk_protocol is IPPROTO_TCP
and sk->sk_family is AF_INET6, but RAW socket can bypass it:

  socket(AF_INET6, SOCK_RAW, IPPROTO_TCP)

Let's check sk->sk_type too.

Fixes: af7ec1383361 ("bpf: Add bpf_skc_to_tcp6_sock() helper")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 7d945dc2cb92..684922efd481 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11947,7 +11947,7 @@ BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
 	 */
 	BTF_TYPE_EMIT(struct tcp6_sock);
 	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP &&
-	    sk->sk_family == AF_INET6)
+	    sk->sk_type == SOCK_STREAM && sk->sk_family == AF_INET6)
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
-- 
2.54.0.545.g6539524ca2-goog


