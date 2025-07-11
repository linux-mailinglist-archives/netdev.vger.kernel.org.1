Return-Path: <netdev+bounces-206239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F1B02447
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BC116E6B3
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A82F2C79;
	Fri, 11 Jul 2025 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvRnr84q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11FF2F2726
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261018; cv=none; b=SBS0lkkrpNky1exLa6MsWS9/JQF0ZDPLU4SM4Dsb6T0o9REKmyZXKiWEc3xrynL/W0m58toZLjDFUL3xXbA4Vo3XZ/CgXQGIV4KWFMentEBBiLP85enQRP2v2uode3dD0NLDpn5NsGm992lQT9JMEoLhjGNDfhJCJeZFsZsBvZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261018; c=relaxed/simple;
	bh=QuQ6d8r+101uLPJPbNwU9kfo8GZqC6Uz/6ANFIyS0h0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gk6/4USXY9hlaXQr9TxqC8tVU5dzm4xUxRe3Ee6k7JYny+GqbRGLaPdu2XVX/DnX12Su55Cmq+ATo99HlAJFmhysZe9vX/KUvBsDr9taZsWGZEeTq0x/gA+wZkKQqbINi4C+4VEDd1RUc4XJhrZEcULlokmXusnhvr6LuBb4PeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tvRnr84q; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315b60c19d4so2068169a91.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261016; x=1752865816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdTNkZqr+AtANgl8MZ+nO9ZRekcVUalHvfBsZneUgC4=;
        b=tvRnr84qILDVUouUi+FrPcQkeyCj0uC4P/TsALTX4/Ug3Y2ahlso8bRLEjwDpakhvg
         05YrZnHfhWrHdkyo6dAIP8Vc/gIClSzFEkxFZYe/amLrtBVY4dR6PLAK1L6vC72uG2U3
         QWP/tjp41HDFaO93HWgiyLnTKRcjRjSKagEK8g53N3+EjrM2AdFy0TewRgm6K51s2Fpn
         XAzvIcdJw+W7uFUS8rnUiL0s25Edj2/o97agTKcKr7wbAbpLe//3Q1PwZ2DTJBI3l8YC
         jvxPCxSLmnyeAZi+5uB9xgoV3A+tSwO7X4/iYhFlRVoWxqInfpXnawbeox6z7YAJagWJ
         W72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261016; x=1752865816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdTNkZqr+AtANgl8MZ+nO9ZRekcVUalHvfBsZneUgC4=;
        b=oR0cWIlssnD2jRM/593TAsvlH+eJdWYDK/rmCBta7hY4mw2OqSmkBup0V6+DCvqPRO
         AfRtJE4zyntKm8DlFMdnfqOfyiBM8K2ifzOFJsjRmVWHysmaGYj3OkA490oGAVL3t2rF
         CaOsUM7JujQnGD/vMforgMBm7/YqsaBH0aw0ejStmdFMwiYxbMJzIZ0FfZ1IdTsu3Wjn
         yuigQaSFoK0lt3ZTHT7UkHkDiyPUplp1uGDCsprMBX5MN8Xme+doIgsieTg49KvYoxO0
         zDU0jU3auBlfSORFAfUILUnkXwSXlB1kenu01bfFtpZWPoDYEelj1JnB7lCQFm50P2jD
         6yRA==
X-Forwarded-Encrypted: i=1; AJvYcCUAwPErm8umI5BL2ohX5hc/5ItnNVr9Z/lPWFRP6JpoUDqDJETJgYN4L0nrvUjkpeA+XRjro6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFRbPXY6KpOyRKFa8fcVaj7KPDb3ZXg9SZS2eCrBn0/VvXz6w
	RaSGmRCTmcDPz3AHCPVDjxMlTgST6tgy4En/Q+22MQ/6spgjtcOYvDq1+i3Dbkzq2U35jStLR9K
	wfxjnIw==
X-Google-Smtp-Source: AGHT+IEV99Fl+eI1FVQaVUbCmvlwCfHZ48SwX+1lOT8hAQtnsFpMlxu3dz+Umj7gm9Am9QQj35+XwvSBRyA=
X-Received: from pjbnd8.prod.google.com ([2002:a17:90b:4cc8:b0:315:b7f8:7ff])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d8c:b0:311:e8cc:4264
 with SMTP id 98e67ed59e1d1-31c4ca84ac1mr6926419a91.12.1752261016351; Fri, 11
 Jul 2025 12:10:16 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:08 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 03/14] neighbour: Allocate skb in neigh_get().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will remove RTNL for neigh_get() and run it under RCU instead.

neigh_get_reply() and pneigh_get_reply() allocate skb with GFP_KERNEL.

Let's move the allocation before __dev_get_by_index() in neigh_get().

Now, neigh_get_reply() and pneigh_get_reply() are inlined and
rtnl_unicast() is factorised.

We will convert pneigh_lookup() to __pneigh_lookup() later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 88 ++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 56 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 2c3e0f3615e20..df5938b6020f1 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2998,27 +2998,6 @@ static inline size_t neigh_nlmsg_size(void)
 	       + nla_total_size(1); /* NDA_PROTOCOL */
 }
 
-static int neigh_get_reply(struct net *net, struct neighbour *neigh,
-			   u32 pid, u32 seq)
-{
-	struct sk_buff *skb;
-	int err = 0;
-
-	skb = nlmsg_new(neigh_nlmsg_size(), GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	err = neigh_fill_info(skb, neigh, pid, seq, RTM_NEWNEIGH, 0);
-	if (err) {
-		kfree_skb(skb);
-		goto errout;
-	}
-
-	err = rtnl_unicast(skb, net, pid);
-errout:
-	return err;
-}
-
 static inline size_t pneigh_nlmsg_size(void)
 {
 	return NLMSG_ALIGN(sizeof(struct ndmsg))
@@ -3027,34 +3006,16 @@ static inline size_t pneigh_nlmsg_size(void)
 	       + nla_total_size(1); /* NDA_PROTOCOL */
 }
 
-static int pneigh_get_reply(struct net *net, struct pneigh_entry *neigh,
-			    u32 pid, u32 seq, struct neigh_table *tbl)
-{
-	struct sk_buff *skb;
-	int err = 0;
-
-	skb = nlmsg_new(pneigh_nlmsg_size(), GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	err = pneigh_fill_info(skb, neigh, pid, seq, RTM_NEWNEIGH, 0, tbl);
-	if (err) {
-		kfree_skb(skb);
-		goto errout;
-	}
-
-	err = rtnl_unicast(skb, net, pid);
-errout:
-	return err;
-}
-
 static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		     struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(in_skb->sk);
+	u32 pid = NETLINK_CB(in_skb).portid;
 	struct net_device *dev = NULL;
 	struct neigh_table *tbl = NULL;
+	u32 seq = nlh->nlmsg_seq;
 	struct neighbour *neigh;
+	struct sk_buff *skb;
 	struct ndmsg *ndm;
 	void *dst = NULL;
 	int err;
@@ -3063,11 +3024,19 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (IS_ERR(ndm))
 		return PTR_ERR(ndm);
 
+	if (ndm->ndm_flags & NTF_PROXY)
+		skb = nlmsg_new(neigh_nlmsg_size(), GFP_KERNEL);
+	else
+		skb = nlmsg_new(pneigh_nlmsg_size(), GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
 	if (ndm->ndm_ifindex) {
 		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
-			return -ENODEV;
+			err = -ENODEV;
+			goto err;
 		}
 	}
 
@@ -3077,23 +3046,30 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		pn = pneigh_lookup(tbl, net, dst, dev, 0);
 		if (!pn) {
 			NL_SET_ERR_MSG(extack, "Proxy neighbour entry not found");
-			return -ENOENT;
+			err = -ENOENT;
+			goto err;
 		}
-		return pneigh_get_reply(net, pn, NETLINK_CB(in_skb).portid,
-					nlh->nlmsg_seq, tbl);
-	}
-
-	neigh = neigh_lookup(tbl, dst, dev);
-	if (!neigh) {
-		NL_SET_ERR_MSG(extack, "Neighbour entry not found");
-		return -ENOENT;
-	}
 
-	err = neigh_get_reply(net, neigh, NETLINK_CB(in_skb).portid,
-			      nlh->nlmsg_seq);
+		err = pneigh_fill_info(skb, pn, pid, seq, RTM_NEWNEIGH, 0, tbl);
+		if (err)
+			goto err;
+	} else {
+		neigh = neigh_lookup(tbl, dst, dev);
+		if (!neigh) {
+			NL_SET_ERR_MSG(extack, "Neighbour entry not found");
+			err = -ENOENT;
+			goto err;
+		}
 
-	neigh_release(neigh);
+		err = neigh_fill_info(skb, neigh, pid, seq, RTM_NEWNEIGH, 0);
+		neigh_release(neigh);
+		if (err)
+			goto err;
+	}
 
+	return rtnl_unicast(skb, net, pid);
+err:
+	kfree_skb(skb);
 	return err;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


