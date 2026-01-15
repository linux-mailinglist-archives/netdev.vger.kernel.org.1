Return-Path: <netdev+bounces-250079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1E9D23ADE
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7680930545B5
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A89C35E52A;
	Thu, 15 Jan 2026 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QovC8/sK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69FE35EDB8
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470118; cv=none; b=LFilSX0IFjwYV1uBIjGuiGkBiqaNKYYqftCthreVOD0r5UWfdqBf22Dd3nhmQJsxuREfLfr92W4bwJDKlMk2JiH462TDA7nYVwa0DN7uJpXjGgXJh7BuM+ROmCTk1RuDOCGirkrNBG/TjfRUWBYeKC+/dFG7rBSfkigGz06+T9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470118; c=relaxed/simple;
	bh=QQL3wsfHBo0AeavtTrgEIbV4vSe5pq1ywzG76lGm6YE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UgZKomnBgo4CKyuf7tGzpv49KI6fzma1Sg1VJ5dTx5Ug5n8gLpu8aGsN8e8lLiquS3ijeNyjAXzqyKzRHKdZm+qGxLs0F2yXcNH/7byjHm05dgJMq8xKVwVeTls8hb6hIzYBUf68iLlWwvUuRnfy70TkcACufvvvIjasSRmpeRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QovC8/sK; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c52f89b415so200669185a.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768470116; x=1769074916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6YWgMHbyQOkwskilAKSPWPQcioKJcg2ZbggClwfRa0=;
        b=QovC8/sK4yNo7EsT7CfvtDvQGjBhX3p7lCpbMYgAQasZ1PY3TaArdoR9ubT+3JpmWM
         0N/0Qs5dGIeuEjM1cHLdMoAcinpXYyBJXniNvLCCaq0HroHF1zQznKOYXnamkmM7vQqQ
         nrBLN3QoxiN8d/6QQwLFKfe57f+htByw7v0S51YTlr52LtiC5cJj+ofJWqn6B6ATmqnb
         dD7xOYCTa1ahkKBPiluEDzT6d4SSvE0xriW37DgjrDbi1ta32QHtWST6pKk4amavR3ZK
         hlkwGQQ7Y/0Pl9P/XbHXNYwpf3tMllXG5IQKmKXffOgapFwzdWgRjXyIX4C63OncHLR6
         cutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470116; x=1769074916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6YWgMHbyQOkwskilAKSPWPQcioKJcg2ZbggClwfRa0=;
        b=YXq6/PRTM0Z2koLz+1Q93TBSdfZFX3t83z+JWTtIzz5ttFj4xgPKua5UZOEWqCXRDq
         ycU5J4s+/PZsNK0Eo9Lquc0NAYyd7OIzJsMCYHK2/6zLheeMLtuAuchpgnc64VH6ZWV0
         P1fx3SNO50rri3TD1v0fnWZdQ5Oz0IHY/baddVQkJQwe/QZWkTNPfNqOIPaXsTjELNsD
         zM438EXMSHr3D49GgxrQ7MpKB71y6H2AbCsFv8VksggWOSi5SMVe/+Cx3yIKnHloH59b
         fSHf6kILXyN6HXLn3QZoc293ibuTGPEGLS++CGUHEykbJBsLjBW9EXNCTzVNJhEKh2MQ
         0pyg==
X-Forwarded-Encrypted: i=1; AJvYcCUIjcsg1MyxB1ApGXr3szhsyYBWE+6K/mXG/KbcthfCDI5OmNZ21u9rehLXa4+9JnwX7c8lcGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvSi5anaTznR8hbJ8ODZV62ARuIjGvdUOocCY62VptoOxU9Yp
	CLJQGZBciZ5zGxwNvj0FGHhWctAZbtqCC9dCU26Ykfn8Oj79V/xL0AoXPYo85VDRkZtb19SUbHl
	8KJ9F6ZupAYUXPw==
X-Received: from qvbmf8.prod.google.com ([2002:a05:6214:5d88:b0:88f:cd47:6d5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:414c:b0:8c5:2dbc:623c with SMTP id af79cd13be357-8c52fb90abcmr831564285a.42.1768470115916;
 Thu, 15 Jan 2026 01:41:55 -0800 (PST)
Date: Thu, 15 Jan 2026 09:41:40 +0000
In-Reply-To: <20260115094141.3124990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115094141.3124990-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115094141.3124990-8-edumazet@google.com>
Subject: [PATCH net-next 7/8] ipv6: exthdrs: annotate data-race over multiple sysctl
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following four sysctls can change under us, add missing READ_ONCE().

- ipv6.sysctl.max_dst_opts_len
- ipv6.sysctl.max_dst_opts_cnt
- ipv6.sysctl.max_hbh_opts_len
- ipv6.sysctl.max_hbh_opts_cnt

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/exthdrs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index a23eb8734e151dac46a2d03d15de10ce6e45af54..54088fa0c09d068d35779e3cafd721cd24e00ea8 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -314,7 +314,7 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	}
 
 	extlen = (skb_transport_header(skb)[1] + 1) << 3;
-	if (extlen > net->ipv6.sysctl.max_dst_opts_len)
+	if (extlen > READ_ONCE(net->ipv6.sysctl.max_dst_opts_len))
 		goto fail_and_free;
 
 	opt->lastopt = opt->dst1 = skb_network_header_len(skb);
@@ -322,7 +322,8 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	dstbuf = opt->dst1;
 #endif
 
-	if (ip6_parse_tlv(false, skb, net->ipv6.sysctl.max_dst_opts_cnt)) {
+	if (ip6_parse_tlv(false, skb,
+			  READ_ONCE(net->ipv6.sysctl.max_dst_opts_cnt))) {
 		skb->transport_header += extlen;
 		opt = IP6CB(skb);
 #if IS_ENABLED(CONFIG_IPV6_MIP6)
@@ -1049,11 +1050,12 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 	}
 
 	extlen = (skb_transport_header(skb)[1] + 1) << 3;
-	if (extlen > net->ipv6.sysctl.max_hbh_opts_len)
+	if (extlen > READ_ONCE(net->ipv6.sysctl.max_hbh_opts_len))
 		goto fail_and_free;
 
 	opt->flags |= IP6SKB_HOPBYHOP;
-	if (ip6_parse_tlv(true, skb, net->ipv6.sysctl.max_hbh_opts_cnt)) {
+	if (ip6_parse_tlv(true, skb,
+			  READ_ONCE(net->ipv6.sysctl.max_hbh_opts_cnt))) {
 		skb->transport_header += extlen;
 		opt = IP6CB(skb);
 		opt->nhoff = sizeof(struct ipv6hdr);
-- 
2.52.0.457.g6b5491de43-goog


