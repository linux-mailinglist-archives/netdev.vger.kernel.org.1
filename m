Return-Path: <netdev+bounces-266901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNO+APc8smnMJwAAu9opvQ
	(envelope-from <netdev+bounces-266901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:11:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F4226CF94
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE73D3010744
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CDD38F657;
	Thu, 12 Mar 2026 04:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpWMKJLD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8658A38F651
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773288686; cv=none; b=IoLC9Bgjro7u8puBXr0T0FRsc9X7VNSK+fN+tpOLZRLNcqy85XA0w1CJii92sbk4maFq2z3Old7pLoprRycBiKswFhEW2aNJP08tE0gIDwb2qSa+aI0ZU6W35RDRhe0QYB/2+AabzhjlGbkNcaexWueJs+n4y5kLTW6nse4kLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773288686; c=relaxed/simple;
	bh=4/vhjXADK71XYN26vxVYzMu+psuYILvqOAZwlrDi97Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iOSeQn2eutVBuTwbiaIqr3bUPvfNUXZWfC2Wh0+69dFacn7md31+BPO3cyp5AwRHftsl9BTCgBJSnigm03kYAZOYoeojhZZsAtsgalHMhSwoZNMrA5xcMBQECccHTtploZU3mMzjjauUZMuPnlQ0DKP/BRTrrmWYFe8XTBEuyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpWMKJLD; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5093b92f327so47543741cf.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 21:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773288684; x=1773893484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aVesapVnk4tVu2QgnA4ubnu2usIno9LM3oOd9tAqsrY=;
        b=lpWMKJLDtbk4UIi7nfI1Pndsj16uATh3aOyRseE4LfpE9AYwommU64CMTiDUPLcC8t
         0q7FmwaoAMHKhgpMjSN/W5r6L5IwWQaIQ3cg7uwRZYB82LHviyRxTJTVx6LYwYicZRiG
         z0RsA0nXzFym7zVhs3IezwICslz8C5H4yiNnE4quXRAwvt1Zpf8Xup8d2BPSKtwxSfPP
         B08P8xD8FHQXGlkPpJszn3WV0fLLb2Ep10w5SoiMloSCAVIkGLA3VBqmGxUR7CJe4VU1
         u0UaHMk05glWSgroAN6svB4AQo/oIqnYK7K+5oKXpKom15/9vBwjCpC0m0qt68t+QoMS
         NN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773288684; x=1773893484;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVesapVnk4tVu2QgnA4ubnu2usIno9LM3oOd9tAqsrY=;
        b=NIrAOIw28tGcJX/ggCZGJdtSf8syOrTFZ/x/hpQ7P45MIuKm7RMBZ9QTk1SHqbgRYo
         0nI2YU/Hh08yjfA7K4z6clwM9xSm4iAMQKQYjuHLmcUXlO4W7QUF9vn6LuF9WZ4Qwsge
         KSvTyljfSA73DnqiPh68qids0klAXr5loK2EndCMCJP2XRj1QiiisRdw38ilpt8O/GOl
         QGRB7Y327lpGk2q7LDAEu4otvDcaptrk+MfTn0QhQ21XOfF63rerlxeeae1Rfndx6wUD
         uyLDRvIXWaMArIdS1XSjGdP6gdPMZjsIHan91ykswCFDzKOGSKdXiG7bLMZuViYvgxiP
         +4SA==
X-Forwarded-Encrypted: i=1; AJvYcCXnN6kEVQQr8v6DGYvZfX8pW46dWKQ4GKYn3Tt6qd3lnibkwm7PMBcYQ2FhTKDi8lY9TnZL/L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGxjpNaB5ZI0nkcmNBxI+Hcj89bAMs6QDRkE2Q+7Vli5PozixJ
	4vKWNTjxiJMFOVoGDfRp4kLTcA3D2iby44WthmgsejBPjjtGSzeiCuTsETLN2M1x886QFCBrE/G
	7P17X5PwFDSwLPA==
X-Received: from qtxt1.prod.google.com ([2002:a05:622a:1481:b0:509:9b2:689f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:578b:0:b0:509:2d83:5acd with SMTP id d75a77b69052e-5093a1c7298mr60074081cf.63.1773288684319;
 Wed, 11 Mar 2026 21:11:24 -0700 (PDT)
Date: Thu, 12 Mar 2026 04:11:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260312041123.2756608-1-edumazet@google.com>
Subject: [PATCH net] net: prevent NULL deref in ip[6]tunnel_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266901-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00F4226CF94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Blamed commit missed that both functions can be called with dev == NULL.

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Signed-off-by: Eric Dumazet <edumazet@google.com>
CC: Weiming Shi <bestswngs@gmail.com>
---
 include/net/ip6_tunnel.h  | 2 +-
 net/ipv4/ip_tunnel_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index 1253cbb4b0a45f1c62999be21931ca31b596697f..b964b31e8757858ffafe47d003028d9a2640751c 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -158,7 +158,7 @@ static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
 
 	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
 		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-				     dev->name);
+				     dev ? dev->name : "null");
 		DEV_STATS_INC(dev, tx_errors);
 		kfree_skb(skb);
 		return;
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index b1b6bf949f65ab7a09ba201d48aa204d913f146d..0496b7e2b94e15e2f471d1cd82e0019ba5fedb1d 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -60,7 +60,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 
 	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
 		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-				     dev->name);
+				     dev ? dev->name : "null");
 		DEV_STATS_INC(dev, tx_errors);
 		ip_rt_put(rt);
 		kfree_skb(skb);
-- 
2.53.0.473.g4a7958ca14-goog


