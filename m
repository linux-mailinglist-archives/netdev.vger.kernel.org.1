Return-Path: <netdev+bounces-304302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IjUZJur9Rmo2gQsAu9opvQ
	(envelope-from <netdev+bounces-304302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:10:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3387C6FD8CA
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:10:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="Tt/+YYjC";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304302-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304302-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0AF7302C1E1
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1668A1D6BB;
	Fri,  3 Jul 2026 00:10:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB633EC
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037414; cv=none; b=HKPwnLitPRnCizgQGOpA85ohrw5+EmwoRVsIINpsMQcC6eR2zv/U72Q3EHlk2ioltOGJYWc095LKCnp4ZFiUbJX0+3vw/VfFAuJWnSzsMUhRkVkPs6DUg9OOQKjnDibZAXA8okLTs1eZ7hgmO1pi1J8XUVyZ7m8BjWTbTpAEf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037414; c=relaxed/simple;
	bh=/2ry5RvcC9Yxc00mx+YaOLP5cNnsb2uuihrjyOBXEkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jqIQvUJLjhLURBr5+yiixtzGWxPd/Vs/IMUw8NdkMXs9j3yImaDswbzAulL7e4i+L9MIewFe3TPJRT040mymbkp2xfxjeTnvN6UIVextNoJrpsGUP1z8tURh/JMQQ1NVP+zY0X8yPgoXqkChbHezol6yxKkIBtRpXXJOcE2P+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tt/+YYjC; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c98136ceff4so3690284a12.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037412; x=1783642212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFWlGw2z/guD1Jm5mvn96PsBPjjMxfF9E2cez3Rchpk=;
        b=Tt/+YYjCQj9kH5URsZiQd0r9RHufx6HXxor9NeLP8bGn7R+u3pU5XENUI+gBcCKXrH
         TS5WfSZkwJkIJAtGf3qmXMflnJ8E3FVy8ipSiCaxz0PuS/a+wiFRdzWTI9in01/AcrSi
         twQ8V7tT0iua7yk03mTXbdj81RusKvFKUzlV7NtSo8WKQ9ASlUCefGsutU4lqchNf2Hl
         y11/qyoqjIzoT1QxDBvBKR+mQiDRwnJuXZ6H0fyYkwmvJYwM/uNkd7tSWklQzxuKNV/f
         l3wZWB5E7+BonimFkFI4Q2Cf2VBeAu8rCnftKtovShKmKvo+0bMP0eA2c1xddzTHozUl
         Rzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037412; x=1783642212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFWlGw2z/guD1Jm5mvn96PsBPjjMxfF9E2cez3Rchpk=;
        b=fNm+g1g9tZRSnGrhHASyQ/ZDLXx3QaNAITNUpv6IHmgTl5jvlFuWhOeP4s6eMEw/uP
         tSm50PQ+E3GLCWTXhD1XTNrJmIo1LZNmZBpPqaruQGV6PJVCBMOP/1LCUjd1em3lN85I
         pBnULAvGAHxdkqAngqoyoNrb58Gi7pCk8ug6UndCvQQsve7vfTjY+u18mv4OInthQCsB
         QO/3vsP1hEYw+qFqxD/RyIEcnFb8itJmTfNkVIsd7gcBtk7ZWKprKts5bEHbbG46oBpO
         ED+YSa9ZfHT2/GaUvSQJBS5z87MHQi0vnwZk9r0TQGYxnUn+/xZWWEJjwUgl0RA/nQOb
         TYrA==
X-Forwarded-Encrypted: i=1; AFNElJ8qm4OcemMOL8/72z+AlYv6Q1Y054jfDbz1EFUR/ts42GqvpEptV9knh8SSdrPPaDw794R/4kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtaNF/yEdc6FELTjNnUc9/9aQYCg8RDJK/FEMiK7m0GWjrWs9S
	4ssP06YYLZPTHOSUTzeB265LuKp3IHmsT4X4+LTGl14o6TG3qfJpbRiXk/6Dd5d9dlb0so4Xce7
	DSdRfKA==
X-Received: from pgcv24.prod.google.com ([2002:a05:6a02:5318:b0:c85:8035:8b21])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:62cc:b0:3bf:9e25:1a19
 with SMTP id adf61e73a8af0-3bff42ecd94mr9538230637.52.1783037412164; Thu, 02
 Jul 2026 17:10:12 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:12 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 01/14] rtnetlink: Lock sock_net(skb->sk) in rtnl_newlink().
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304302-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3387C6FD8CA

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


