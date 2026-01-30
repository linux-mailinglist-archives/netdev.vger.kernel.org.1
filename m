Return-Path: <netdev+bounces-255258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN9tIoUefWlQQQIAu9opvQ
	(envelope-from <netdev+bounces-255258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:11:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7452BEBBC
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60BF93033AA8
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD051388853;
	Fri, 30 Jan 2026 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqT7KXSh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061723876BE
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806993; cv=none; b=BSzZdzaiS4hH2kcVuPWZ6S3ezuf2GwCqPrlC5eTXLlom4jlLqbikG8ITH0lZ0sN8ByqqEV1JKaIdV0YyFiaaX/pZHAMRENImv4sN/nWGij1eBidxW3onLuH4eHo9Tx5zXiV99MA4FyR1T8luTPhMbZ4Bz+AktSXfw8XlIITF9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806993; c=relaxed/simple;
	bh=aesX20qM+W9X47ixcQw22p7darICgnXLDevGjFQdVjY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NomY0gSyGhxnPJboHYXtyuiRg5hhEp1iVRDNNj6OvWKlzMcWBa8D1q7wcx5jrq3uHyAN7n9yEOvXR5KLGGQSevRnPLI7Fxar8QEE0VAi3D3liKHeHiJXAtGGxVI4kvTdXIZsqvyz1X1E0Ldc5+JiX3ROWEgNrENoq2xxA9427gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqT7KXSh; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-502d38a3e39so34250081cf.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769806990; x=1770411790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqpTdT+0fMgrPuzcdfHxHkCef33T1C7Mt7lt4s7wWm4=;
        b=HqT7KXShNGIf/5kdaO7rGofTI2Z50p3lCuvtQWHHtZGK0jZo2D6BX6Dz/UuxcEI8Yj
         zqyCzmmESXRIi0Bf7Gz9d7KTd2eJOjlh+qVGeDxZNeot5wGYZ5sKP6LqF+B7ycCCA9fm
         CkjhrlK2zqoRMT3oeIcoDt8nn9zKDZaB82iEsNtPA7Tt7TS1/X5AosFJhnNn4leIhK+q
         wd7hFPwYbON0uyU/AKX+xH23CDdX+wB1vX1fO9+Zpr02O9eh+6GYUy/yUavDhMbazfHt
         i68mGX1Lta8l615tyq5xJG5wLHlJ13fMDXHCcO2GOv7R3uwD/FH1a0h85on+ts1EDa9y
         SgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806990; x=1770411790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqpTdT+0fMgrPuzcdfHxHkCef33T1C7Mt7lt4s7wWm4=;
        b=Wh8QRWDXvHA78S+adQscI0Vv0DIgrmzTFCUNpoEKEb4Jobhc91mESVOu19gHvBPz7S
         jrnKjr1MzkZfzAjMgt/utq4U5Hb3MNa0u8dkM8FCC8kWzVpWUADhyHFrZUOZK5hFmtdO
         zJ3T1SLNYZFi2MgpyP6283Os7WYelvmQMfFxKS5ihzbky594tAhuEMxr/FSyFAi9+Ahc
         Hfofmf7+qT/vHcxpIefBxH/GmxziLhwDm6ZHUNB0+SqQqAwU7xUSKrxEWuNR06muAJTN
         sYpurzmq7uSFaNyIYhyTLJiAJNRfDd7vm5gxoh2jGs0bV+LePKsA0tve7TMKAfvCyDOU
         KKVA==
X-Forwarded-Encrypted: i=1; AJvYcCVjnlbe9CLMBLEB4IEf8cNSTQWZh9280anZ2owBsoe5jDTIq+tMlZ7ejW+rXPQJynS+sZ8kaJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbnsgloQDE7O1bN5In/UnzHaw0XGPF6u8O8qnNP9TGNWcYjcsF
	jV7RT8dU6lnYlhm4GxPIBaQtuq0LIfEFwOF0pqO1MRiPHHrwFg6qx2GcD72g61plQHiABSKaWTI
	Pn2xIsMT+RfqAhg==
X-Received: from qva2.prod.google.com ([2002:a05:6214:8002:b0:894:6449:6a60])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5903:0:b0:503:2d06:8e1f with SMTP id d75a77b69052e-505d217da6emr59880721cf.19.1769806989632;
 Fri, 30 Jan 2026 13:03:09 -0800 (PST)
Date: Fri, 30 Jan 2026 21:02:58 +0000
In-Reply-To: <20260130210303.3888261-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130210303.3888261-4-edumazet@google.com>
Subject: [PATCH net-next 3/8] ipv6: use __skb_push() in ip6_xmit()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255258-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7452BEBBC
X-Rspamd-Action: no action

ip6_xmit() makes sure there is enough headroom in the skb,
it can uses __skb_push() instead of the out-of-line skb_push().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 5c2cfcc3cf6e56192123c5830250865d37e72581..279d4daa85c442eb3db8add1d97c57c1ffbe820f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -314,7 +314,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	}
 
 	if (unlikely(seg_len > IPV6_MAXPLEN)) {
-		hop_jumbo = skb_push(skb, hoplen);
+		hop_jumbo = __skb_push(skb, hoplen);
 
 		hop_jumbo->nexthdr = proto;
 		hop_jumbo->hdrlen = 0;
@@ -327,7 +327,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		IP6CB(skb)->flags |= IP6SKB_FAKEJUMBO;
 	}
 
-	skb_push(skb, sizeof(struct ipv6hdr));
+	__skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
 	hdr = ipv6_hdr(skb);
 
-- 
2.53.0.rc1.225.gd81095ad13-goog


