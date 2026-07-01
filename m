Return-Path: <netdev+bounces-303841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f+HHH0iKRWraBgsAu9opvQ
	(envelope-from <netdev+bounces-303841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:44:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D402C6F1EBC
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:44:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=lI9NWZWN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303841-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303841-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 213A63044C38
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA743B71B0;
	Wed,  1 Jul 2026 21:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD973A9601
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942225; cv=none; b=FGbggwCO2H3i2PSAQ1OKvxNlZJCy6PKYc7WdFJkGmaC9Coecsb84pIQn13rsxukTsh75ys9dAnLvreUpSN6DVw9Flji8PnSvi3U1Q01O0fL00QRJmxwEJFmNLmiadKwLqtNqWEaGsFnYz7Xwn/i0LonxK+9XXqYk5h08y4FK1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942225; c=relaxed/simple;
	bh=/2ry5RvcC9Yxc00mx+YaOLP5cNnsb2uuihrjyOBXEkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Iq9cK3uuuN0+muMgOPJQzl3Br4lnTw7/wG74w5geyA5jRZYw2VgfDVAb9wFJ8zVq7Vvx8mCQMn5H5fU99848PSjGQmfkpORzvO9JXopvT0P274oomzrM3ayTLphqIHT6WNJs9SA4RQfUo6+wHhG2NvLvgkCmu/QB1VgybOkTO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lI9NWZWN; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c9b1b608e2so17299885ad.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942224; x=1783547024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFWlGw2z/guD1Jm5mvn96PsBPjjMxfF9E2cez3Rchpk=;
        b=lI9NWZWNqO/zhxsoKFG6qx6X2sLyp4byDbjAQr2QWOVe7NvXbDWAKSd6iPYpn+OMlB
         NqRH9gJTNSaSn9Hwh5P4l9lxNBfV2xMpv4bG14xapILaHk3j7D1vW1o7TTmO3SaLZ6XK
         Cn4cW+Tc1ZJCr+3VTSKvldPbRUXv3qBcrdFDp3QWGrCj9JR5atD7IjvRMH7Vxu3S6O0V
         vBoppA+oYiWjIiU9Y4o9QasFWOREY/cz04zFed2sGITR5raSZ2wtfkjIOyOUwzMr2N+P
         AsNS/hqAZrRu6TsTvN0ymtsT/xsYrdXlUvt5h5Y6xqZOOFaFJmh1sj6ytjXP1sWRvXE/
         Rm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942224; x=1783547024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFWlGw2z/guD1Jm5mvn96PsBPjjMxfF9E2cez3Rchpk=;
        b=MeTHOIVAdl4Pq7S8JZd4tZaipy73eOJ4ThCDXHNr6orJCr0Vc2vwE0++Wj8xO+Y9tN
         1v2jkVMpZGiriu5tIcHfDPVcse6aFCMCZfOG8J1pUx6qQx7FI5orj9pUiMzyHQjhakQP
         KnDcvi4bwY9PJAo0tcFimWWcpxGWf1s8q6+1VbkxpWSqHRhk7b3B8I9nnd+N59sRqBeg
         2WwLd0syFNvpdMnrHyeQyL77x/xZWNA5Me8k7hwWRom37TACUVu8GZS/IhcKduLKrkaF
         ybOW/Vz7U5H/o9Qv221z8eqHOReaI2Y5QIrhqJJyErzEPZk63nqK4aCLSywcEPsbBLPo
         3GeQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZp77j+FdHPLJjUxCoUjk4IOwscw6Sjg8U6IISr9F65osQ8etRiKHJGqRjauG8WJ+6j2USQxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wqmn5GQepGcbtRCokCaoBpyi3o7iMxKGEovjJTjhcMEUJFoq
	jgppHvqkgqjHUkFTysuNAR4EczJcc/FJ9De+RcMY1rrrvA0w08Qp6NSn2QP9i79BxkmYGgmMSfM
	msc93HQ==
X-Received: from pljc4.prod.google.com ([2002:a17:903:3b84:b0:2c7:ee2a:a90e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22ca:b0:2ca:17e2:2acc
 with SMTP id d9443c01a7336-2ca7e706861mr35834165ad.21.1782942223507; Wed, 01
 Jul 2026 14:43:43 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:39 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 01/14] rtnetlink: Lock sock_net(skb->sk) in rtnl_newlink().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303841-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D402C6F1EBC

There are a few cases where rtnl_net_lock() is not properly
held in rtnl_newlink().

When either of IFLA_NET_NS_PID / IFLA_NET_NS_FD / IFLA_TARGET_NETNSID
is specified but IFLA_LINK_NETNSID is not, sock_net(skb->sk) is used
as link_net in rtnl_newlink_link_net().

In addition, the do_setlink() path uses sock_net(skb->sk) and one
from the three netns attributes while rtnl_link_get_net_capable()
returns only one of four.

Let's add sock_net(skb->sk) to rtnl_nets in rtnl_newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
No fixes tag is needed since there is no real bug nor assertion.
---
 net/core/rtnetlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 12aa3aa1688b..f39c93e80e20 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -282,10 +282,11 @@ static int rtnl_net_cmp_locks(const struct net *net_a, const struct net *net_b)
 #endif
 
 struct rtnl_nets {
-	/* ->newlink() needs to freeze 3 netns at most;
-	 * 2 for the new device, 1 for its peer.
+	/* ->newlink() needs to freeze 4 netns at most;
+	 * 2 for the new device, 1 for its peer, 1 for
+	 * an existing device (do_setlink() path).
 	 */
-	struct net *net[3];
+	struct net *net[4];
 	unsigned char len;
 };
 
@@ -4155,6 +4156,8 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
+	rtnl_nets_add(&rtnl_nets, get_net(sock_net(skb->sk)));
+
 	rtnl_nets_lock(&rtnl_nets);
 	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, link_net, peer_net, tbs, data, extack);
 	rtnl_nets_unlock(&rtnl_nets);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


