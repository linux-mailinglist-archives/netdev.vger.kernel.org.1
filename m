Return-Path: <netdev+bounces-75363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB6D8699CB
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05601C22004
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A1314CACE;
	Tue, 27 Feb 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gt71Vb61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AD0149DF2
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046141; cv=none; b=gPC/AvwdogqkBGOBColffVfduwx4P8gjW9i/Nu0j9MejV0TJVAPkYv4KmRrr4HA8DvHFGv01c0nSZLyF9dKQ0pbWNGpgKcpA1/YbHsbdXqbPfsT2FqekC3g17C0BwA/4IvT5rJd5+hF5PRdm+9mx07JxkhPhfvBtcj7VtAYmKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046141; c=relaxed/simple;
	bh=oZgNCL9ebI+tL17kN3/hO+82BT1V9LmCZhsynYx32sw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ssN28Is6pNEkZWnKeUXkJEa0uzW2A9xkN7FEOZChYbvpzRqEj2VTpBWsKRW5rDKnWerpaB0bd5k4wSAnDf5zCzJ7JlzeXPYfKn505bdnQNk2Ppc4quUHVEUu6+DrKusR8kpmvVO6PtFGIWw8zBnauSkhfZj9q1Hnkk1O2ZGIONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gt71Vb61; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso6534250276.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046138; x=1709650938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtR7GXBiKy3C2ug1kbVH38a+cc3fKMLHvC5dGGfdXXU=;
        b=gt71Vb61DlpnBckhEVLe2E7wpbqSibbvoBjNkt/qLRgpJ1FFn0WCk9IiMHhAZLeuZv
         fQe61DvE1dhhouiUbcfhPfJ6Xt2l2Bp5pbH8dxrfmIff8Zz1gCqCzyE6mb/UA+TtNja0
         czllJIhZCwq3EU8QkQu5caJvLBSlydE1tCiVlJ/C1eJ4Mkj0cUi1J2OUJpQDE07SlWYM
         XBmJDrWyhFPcvO9hkBO+5hCkmGYSMFNYtab5rvuFnQ6b3CM+TuDot8bIlVt7T3Ifk0nL
         mmWCn7dwCAJEv2XjfvMTJDz8DGNCgm3KTvgZLaQPV2fkUDf/jxcfjBwPCyVxPTr++Szf
         gCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046138; x=1709650938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtR7GXBiKy3C2ug1kbVH38a+cc3fKMLHvC5dGGfdXXU=;
        b=Pofbk0C25Ny4E6DJjguZ53Oxo+HEoBNdIJCF++AJwrMAWYV+IEV2vSsfjwKTtDGXRC
         jdiHChwOkJGs+rxFapQWxMnert4ATUK51AJmC4EnYPvOPLh4E/AHMjq0+HKOly7cGj+j
         feIayVDMX2b+bsZhAr0gUbsrKRvkk1hLNUom4BnxTiFgeOhzSw7BbSMP+BCnD5W4KM/F
         g7ftE3ddS3oeF7+WCKSmTHUS8LJJZmrZwpg6ICZQyFr8UM+Qzck0NhnmHp721n0oftOY
         q08FBg8ekSfRsok56CmyRknCUQSpRgCT2yQvmevSdZR+R+5TKa4rPae6SriJA/J24cTw
         ppVA==
X-Forwarded-Encrypted: i=1; AJvYcCWSpFSsXDSNRegCrqRy6V7mt7WQESBmV+epVUOmUXB/1mh6EcpAi25eNAD1XXAqzdRCtrDb8Qp48oUT9cjjBf8rpxLGNpBd
X-Gm-Message-State: AOJu0YzOflQQDGbJOEi7qQWEq3NTirSdSpS9USvRDDSJHzmcJ35oe5b9
	CEwrK3c1rqnCtbhJIHTIuQcfGRj9C2d10gGIcMOpOGMrk+fuiIEALoDz4i3ELSFWrMBXaYQUSmQ
	gbX+H1F083w==
X-Google-Smtp-Source: AGHT+IE1itF0gz7xd2WEgyNthTdPE06PRDNHdkhxVxFCeS8wVLZ8724CzrtVMdBJtQTJGFVMw4qTjBztDPpOKw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:d44:b0:dc6:44d4:bee0 with SMTP
 id cs4-20020a0569020d4400b00dc644d4bee0mr89216ybb.7.1709046138648; Tue, 27
 Feb 2024 07:02:18 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:55 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-11-edumazet@google.com>
Subject: [PATCH v2 net-next 10/15] ipv6: annotate data-races around devconf->proxy_ndp
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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
index 2f7b76a6ba7da21a51c4219bdb96b7e060583b65..8637957ab9c8fcfce2a81910c8ae0e965f32b7f4 100644
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


