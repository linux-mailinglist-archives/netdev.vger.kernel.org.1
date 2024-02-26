Return-Path: <netdev+bounces-75002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FDD867AC5
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C272A1C247BC
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE3612C55F;
	Mon, 26 Feb 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H87DOnF6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134D12CD97
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962681; cv=none; b=jCBxzV73TmhkOeBP1/T12UshTcNfdp2bKKABN8es4Mrp6Pg+VRc6bGRNDFkWKU/sB3lLYOF0oZDX3+zPJ2aRZTpNZrj3yrzykeuezOzVqo0+WOhCoDAhlWNYl/OsluhXHbWi4AmzzvBOiabXXXQ7xaVvFa8VQnPcSRJv6CVa7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962681; c=relaxed/simple;
	bh=JLJFvGcrrIwz/0ZAlqp02BGPDd+OfiG89ZZrrZbMJqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BC9eZyuGvUdw53gplKnYtKd7/bgHT4ifFNi/MggGSlSvEtcf72HLrxeOUfou+1RNw7q1IvArG14KtYyaGVRN2LS0XyKBO9+S7n/lPDJw8XRXmFrf514TWTYs5jD4nytz93rc9KczBpCHMazxNES+q6Q5OnxsLzn7PZtb3VQdR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H87DOnF6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047fed0132so47428927b3.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708962678; x=1709567478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7orXrBTlLkmW312bw2JJR7Jtilb7bKlCwXeCiRkpGw=;
        b=H87DOnF6VVF/GT7sR1bOcbmr1c3OQZmtpZI/+3bWjCIkNwwN2LNSDdsMKvE14xsMs6
         dr/uXO7saXoGWYEzbhhY/Z359gchHMEXCmyHzf7ywqLk+ttI8E0fDNaB53OVzO3kX7aI
         1jgsbQUbnvgyGp4zkBIiru+LLDrzHGkE7uVLrQaciUSCyFEn/HgrEwn1LRwcHHufhb0N
         dm5qQY22kfFut71NnlXPCPPaArbNJsVcra1fQnbEBMO3DvJMf4PZJDhim4qssTHtgi5x
         kLexNiCruVyk3AfQlnKRDqyiAIuNTlesuhOX/Cx0d/vPOutvpw7sEJdzKQXnnvj+WXFJ
         Wj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962678; x=1709567478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7orXrBTlLkmW312bw2JJR7Jtilb7bKlCwXeCiRkpGw=;
        b=ZiBR8CUjXFkekIMqWACMLYlPi4rWq2PtS0ItqREjhHLSV0WFB3lrzEHETyMqKeeOBF
         yTfgy6f80p0X/6z2KNvV840uYMUNFXVW/ZG38avYhwgRITqREVuvQHXWLFpLOicBKUbd
         hxclHlSBtQ5QvxIWuR33Jm6nPQkmTR3+iF2HnCwR/AtkouPLGgjJhauuIPBvqhHdml0B
         0X7M8R3mzQefXEz12rYqyc0/31oxawEYlDz09MrbwONr3YyGHF8Z2y07c2iAY4o+Awfq
         E99h1m3COYVVTcUDBM6FC3XsBSvCV+FsI00JeZ8h0Z/bvtYgZJsYEx+KtxSMhWPTlVgP
         KJgA==
X-Forwarded-Encrypted: i=1; AJvYcCVP5P9QA9yt7TtKfN7VfjkQX6lupK3RUjZduawVtxzuKEZxfL6OYL94l2pl2QSw+S6WeIS8/6cI9ApUmq3Qm/PD2iC2ueF+
X-Gm-Message-State: AOJu0Yw2Qg/7hUWbwiQeAPEjIunhGgYNmxNz6FRxUre/p4l2pvTCKw6X
	0+mLs47a/+67A4/Qe0MNzNTtimmhc59k/Tp2AMSlmkGYFHlIpEa81CTHmImo3KXU2TzI1W3vqAv
	gnYguZCA9/Q==
X-Google-Smtp-Source: AGHT+IHu1fL7xzasmPQlAj2gtYZUTw8g5VjLhskp4HgOB2XTH9OhrXJte9M9xIXlYV5w/UsCntmwCDYs6Ca2TQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:c0e:0:b0:dcb:fb69:eadc with SMTP id
 f14-20020a5b0c0e000000b00dcbfb69eadcmr371186ybq.6.1708962678767; Mon, 26 Feb
 2024 07:51:18 -0800 (PST)
Date: Mon, 26 Feb 2024 15:50:51 +0000
In-Reply-To: <20240226155055.1141336-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226155055.1141336-10-edumazet@google.com>
Subject: [PATCH net-next 09/13] ipv6: annotate data-races around devconf->proxy_ndp
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

devconf->proxy_ndp can be read and written locklessly,
add appropriate annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c   | 3 ++-
 net/ipv6/ip6_output.c | 2 +-
 net/ipv6/ndisc.c      | 5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 86992c1701485834662ec1a11d78576b211fdfab..f2a91bdda23f808d38640d3f3ec91140386bc640 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -561,7 +561,8 @@ static int inet6_netconf_fill_devconf(struct sk_buff *skb, int ifindex,
 		goto nla_put_failure;
 #endif
 	if ((all || type == NETCONFA_PROXY_NEIGH) &&
-	    nla_put_s32(skb, NETCONFA_PROXY_NEIGH, devconf->proxy_ndp) < 0)
+	    nla_put_s32(skb, NETCONFA_PROXY_NEIGH,
+			READ_ONCE(devconf->proxy_ndp)) < 0)
 		goto nla_put_failure;
 
 	if ((all || type == NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN) &&
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 444be8c84cc579bf32b2950e0261ffe7c1d265a8..f08af3f4e54f5dcb0b8b5fb8f60463e41bd1f578 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -552,7 +552,7 @@ int ip6_forward(struct sk_buff *skb)
 	}
 
 	/* XXX: idev->cnf.proxy_ndp? */
-	if (net->ipv6.devconf_all->proxy_ndp &&
+	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
 	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev, 0)) {
 		int proxied = ip6_forward_proxy_check(skb);
 		if (proxied > 0) {
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f6430db249401b12debc0b174027af966fa71ccb..4114918f12c88f2b74e53d6d726018994feaf213 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -904,7 +904,8 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 
 		if (ipv6_chk_acast_addr(net, dev, &msg->target) ||
 		    (READ_ONCE(idev->cnf.forwarding) &&
-		     (net->ipv6.devconf_all->proxy_ndp || idev->cnf.proxy_ndp) &&
+		     (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
+		      READ_ONCE(idev->cnf.proxy_ndp)) &&
 		     (is_router = pndisc_is_router(&msg->target, dev)) >= 0)) {
 			if (!(NEIGH_CB(skb)->flags & LOCALLY_ENQUEUED) &&
 			    skb->pkt_type != PACKET_HOST &&
@@ -1101,7 +1102,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		 */
 		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
 		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
-		    net->ipv6.devconf_all->proxy_ndp &&
+		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
 		    pneigh_lookup(&nd_tbl, net, &msg->target, dev, 0)) {
 			/* XXX: idev->cnf.proxy_ndp */
 			goto out;
-- 
2.44.0.rc1.240.g4c46232300-goog


