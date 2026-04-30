Return-Path: <netdev+bounces-282683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCeZCWAH82lBwwEAu9opvQ
	(envelope-from <netdev+bounces-282683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:40:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BEF49EC1D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 256FB300B9FF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4913D3488;
	Thu, 30 Apr 2026 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSYwAXKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7713D638
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534812; cv=none; b=XjAI4iu3MMcumhBBgVOiDfQh+fqxizR8VcDDUFVEVPJ4LHiFoDQMNNdzclEcP/XL5rQtXmO2wukAnikYTnXWqvXCncqz8SZ79KumR3WR10zD51RGVeL0D+EfX9ZtMt6H4bnnggF3y9hwBuO4b7bbB86j3P12RnPQqdrF8JjMo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534812; c=relaxed/simple;
	bh=q1Vk0LxCsWA/DIoDsI1fSxfwyVQo7vGXBUNjmZc+To0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ja6zDJOX563XAq7f5KSBNc2fmZSkWsOonAvVzRnLtsXAX3bgmuxUdVcPllYzekX0wFms3j5AdRYZRdsSvAQo8ZhNCylXDy6X1pAclTGYce0nLrWYB1JI+Zj1kHZJuD7BcbJ+mBpvbOGmLLAMsYN+B7gb+eFy8iKbzMxaZ8DEGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSYwAXKh; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8ead5ab474bso120412985a.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777534807; x=1778139607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f6bRFdgUYF4iiaKNHUSb8WsCcEYFdvtGqgX4SZ7M0lQ=;
        b=aSYwAXKhT8pJEbBX2LSiBxkyfjeIx2kTBvnTJPe67wzFqlXJijVXx9hXk3kXWE43ns
         mzlMqdfssN3T+TsgT6NeHcC/3RKkEpeK1BMbfn/hVDM0Jg+Ip40bcYe/SBa5rYcHoKDY
         fHqnedPTB+o5TeKtxCswd5QKS3iPA7Z8I2qhd81KNuGEsHsKtJFkZMfU5k30uLS1nVaJ
         rF1cVqkX98gC1dbGS9TYbXHcAHZvrgL2+ysq9/5YqHQjrePtiON9c2zcSVStyftBk2tB
         4m2hTyQEauOmjNh89G84mDNodJVUrefu5CUjztfEQfpOJVUGOsGDxpT7m+ZcHBUEkP09
         tvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534807; x=1778139607;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6bRFdgUYF4iiaKNHUSb8WsCcEYFdvtGqgX4SZ7M0lQ=;
        b=TlkZFhCnO8RvVc3VhSCW3eO1jEB57aYhc1zkoCV+1aoB2d3/ne6bCLa3w4coC9uxQj
         BloN9QnBgCtjnBQB9PQ34LQwEnlBiE6GdpwRQeFZ3J0q4GGfvVOEK0dsNAVCu6KGxy6d
         IZi5Z3z+lBD/Si2lcvszQm4/onLzllyY3t/xfV+HymV3y6NPeSYTs0lhR2DbUEgcF/2n
         nAnio6JmZd3dAVDuGjz7FFWhCw8rSSIbGPwPj8AezSPRrpOPXGCb3CmsUXE6u4ajT0Zz
         obuf4Y/QeWlXCXXXrC81GijpJJRFv9o0L4F+2pRouEX53LEwC6lbf8pyUl4N4Ws/D2EU
         R33w==
X-Forwarded-Encrypted: i=1; AFNElJ91e9oj1O+d6rbCl1/OmDMjDsC76WRc7FltDG2dcSMP69W1xwDAlnapHwHL0kooShJ58aWcyAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymiPbRViw+g1BavyTbatgQEl+HA6iaEAciUgE9tdSpPgeM9r3T
	GG+Jf6YByzEanawn/lFsIIixQpJVukEQW3fsq6OtWSFLzzd/Nhua8xXKPeuCf0+f/RJiqcLhM7F
	Xu+THlvUl5lAInw==
X-Received: from qkmy29.prod.google.com ([2002:a05:620a:e1d:b0:8eb:9285:cfb5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:458d:b0:8cf:e0fe:f227 with SMTP id af79cd13be357-8fa872a25d0mr314254685a.26.1777534806547;
 Thu, 30 Apr 2026 00:40:06 -0700 (PDT)
Date: Thu, 30 Apr 2026 07:40:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430074004.4133602-1-edumazet@google.com>
Subject: [PATCH net-next] ip6mr: plug drop_reason to ip6mr_cache_report()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B9BEF49EC1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282683-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

- Check mrt->mroute_sk earlier in the function.

- Use sock_queue_rcv_skb_reason() instead of sock_queue_rcv_skb().
- Use sk_skb_reason_drop() instead of kfree_skb().
  Note that we return -ENOMEM if sock_queue_rcv_skb_reason() failed,
  as the precise error is not really needed for callers.

- Remove one net_warn_ratelimited().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6mr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 85010ff21c981913e2a5e6096819d55c91f5d714..9d748f4c44e97046fa5acae5042f8bd31e13b66d 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1063,10 +1063,14 @@ static void ip6mr_cache_resolve(struct net *net, struct mr_table *mrt,
 static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 			      mifi_t mifi, int assert)
 {
+	enum skb_drop_reason reason;
 	struct sock *mroute6_sk;
 	struct sk_buff *skb;
 	struct mrt6msg *msg;
-	int ret;
+
+	mroute6_sk = rcu_dereference(mrt->mroute_sk);
+	if (!mroute6_sk)
+		return -EINVAL;
 
 #ifdef CONFIG_IPV6_PIMSM_V2
 	if (assert == MRT6MSG_WHOLEPKT || assert == MRT6MSG_WRMIFWHOLE)
@@ -1136,23 +1140,17 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
 
-	mroute6_sk = rcu_dereference(mrt->mroute_sk);
-	if (!mroute6_sk) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
 	mrt6msg_netlink_event(mrt, skb);
 
 	/* Deliver to user space multicast routing algorithms */
-	ret = sock_queue_rcv_skb(mroute6_sk, skb);
+	reason = sock_queue_rcv_skb_reason(mroute6_sk, skb);
 
-	if (ret < 0) {
-		net_warn_ratelimited("mroute6: pending queue full, dropping entries\n");
-		kfree_skb(skb);
+	if (reason) {
+		sk_skb_reason_drop(mroute6_sk, skb, reason);
+		return -ENOMEM;
 	}
 
-	return ret;
+	return 0;
 }
 
 /* Queue a packet for resolution. It gets locked cache entry! */
-- 
2.54.0.545.g6539524ca2-goog


