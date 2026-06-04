Return-Path: <netdev+bounces-295455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2wX/GQABImr2RQEAu9opvQ
	(envelope-from <netdev+bounces-295455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:49:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A31643DD7
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:49:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=G+0uz0mA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295455-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295455-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45C46303E2FC
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32082EEE72;
	Thu,  4 Jun 2026 22:47:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344A2F7F14
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613242; cv=none; b=Ag0IvXP0OV7SqoRIRT8QbYMhREirjWUiVf0faQT/NPIk06jaEa9y47A0QWvS7EJcD+zUw4QmwSpqYVi3TJcbcn2BMle+SLkaqJPW2fnh3kKeMPxo5naLoA6OJhxX0toLLbUu8qSWGMCYzOGRdI9e7mhcH49i3czsqnMIq/rrPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613242; c=relaxed/simple;
	bh=scE5nSvt6sH6IDkOhq+SHblZhFr8L8f3mGayWDrZOGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XLjgZ90rtgN0mTJaVGEbJxkgxoTlTcO4JiKhMDjcM2B69RKwDd6sJ5bb3dbq6Zs2mCq0Fiw9uak9rjNfbGMS2rvko+9Iy8/k9MYz0wj5kXfRoPPO08iRTO0qR1U9o3h2kYRsYh7kYKoW76msMme5OXD+0TeSbQaqfPpjB60I7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+0uz0mA; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b74447so815221a91.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613240; x=1781218040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EuzCZZHh0Giyw1iTlEs9FMI2itiUtC678o8MzBoBREQ=;
        b=G+0uz0mAVIPmiXIZmV+bNe5jCcOpOuDnKvWKHBLKHgOBD+x4FvbsR8o20Wha81Tgj+
         /5V7j/k4pwbUSWI9xqC0cAGJ36dxV3+oDQFmAqPDfqcZ9+6KheGSzgEqFykKyaKh9MQn
         cpfo0GIeLHv6NTCmBzfjQJiaABNh54pi3y82F53jj9J1k9deQuHc7IHVMyD1ZD2yuyC/
         eTW0dgBrXETu0z8LQYbXeJOfEMEIAqQN+R8gn1XE1kWduevZRoB/cGSeJsWjRl6uVhhm
         +XH6q4S6P4xg6B5k513o2Qevyxe1kuY66v/VESfstFuD1kyf4HtH4j0sD3FrhNk+VP7O
         mQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613240; x=1781218040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuzCZZHh0Giyw1iTlEs9FMI2itiUtC678o8MzBoBREQ=;
        b=qKN3Y0ed3hJGcGHNa5uHpaDnGrvGxezuPbvJq3pIsDZIDvhCZzNPy56HGJiCgbElpx
         zjBRCgI0PoISkUxhkYpbpI4FthBt6/gpRynumtslkau+3LSU5EbW++6z7kgAwJ+hNWGg
         O/veZIbZb3D3RtUrvYS2rjD6YqWojrHRr0mB3ZVPmSRv5M+4p1vqEUqH2vOFPsstkrXv
         n10brC1syjs8+DKZjIZPbDPx1Cyoz2il67ooiA1TlcL+9CszN1QvoU/OIRr6cypDhdSe
         mo92/xriGUs070fu4SRtlMsaxdUzNK8I8T9KJRUUOZQwnlNyVn1rXHkhSnj/5jf5aWx8
         up5w==
X-Forwarded-Encrypted: i=1; AFNElJ+qH5L1YICtx6aG21ohFYAurz4PD72UsuUyRbChbhyysz3BUo1seu+qftc742A8gSrZv8Qalag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvi/5Dd4U+oyiVXhlPTwEUhMfiLu9r7QDSwj5tU2Ppx8Zx6X8J
	h6oqZ0Wh4w7VGam6tq2h8ozQ447+jkdv9QnvVkV80fDogTKbivDn+lYGtp90J87fG86k5fwaJ2b
	SZS2ddQ==
X-Received: from pgjm14.prod.google.com ([2002:a63:fd4e:0:b0:c73:ef4d:6a16])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1809:b0:368:6998:b49d
 with SMTP id 98e67ed59e1d1-370eeff6b37mr827223a91.10.1780613240168; Thu, 04
 Jun 2026 15:47:20 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:22 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-5-kuniyu@google.com>
Subject: [PATCH v3 net-next 04/15] ip6mr: Allocate skb earlier in ip6mr_rtm_getroute().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295455-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6A31643DD7

We will convert ip6mr_rtm_getroute() to RCU in the following patch,
where __ip6mr_get_table() will be called under RCU.

nlmsg_new() uses GFP_KERNEL and needs to be called before holding
rcu_read_lock().

As a prep, let's move nlmsg_new() before __ip6mr_get_table().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index ed56c4c8fda0..018985593b03 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2700,6 +2700,10 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	skb = nlmsg_new(mr6_msgsize(false), GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
 	if (tb[RTA_SRC])
 		src = nla_get_in6_addr(tb[RTA_SRC]);
 	if (tb[RTA_DST])
@@ -2709,7 +2713,8 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	mrt = __ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
-		return -ENOENT;
+		err = -ENOENT;
+		goto err;
 	}
 
 	/* entries are added/deleted only under RTNL */
@@ -2718,21 +2723,20 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	rcu_read_unlock();
 	if (!cache) {
 		NL_SET_ERR_MSG_MOD(extack, "MR cache entry not found");
-		return -ENOENT;
+		err = -ENOENT;
+		goto err;
 	}
 
-	skb = nlmsg_new(mr6_msgsize(false), GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
 	err = ip6mr_fill_mroute(mrt, skb, NETLINK_CB(in_skb).portid,
 				nlh->nlmsg_seq, cache, RTM_NEWROUTE, 0);
-	if (err < 0) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (err < 0)
+		goto err;
 
 	return rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
+
+err:
+	kfree_skb(skb);
+	return err;
 }
 
 static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
-- 
2.54.0.1032.g2f8565e1d1-goog


