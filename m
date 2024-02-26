Return-Path: <netdev+bounces-74997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44929867B84
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA8EB27A66
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D43A12C54A;
	Mon, 26 Feb 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="koduu5BH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133B12C55F
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962673; cv=none; b=CpsSP1EBP3OwG9JAWAsqUMK29q8ZFBacdxYU0hm4ZPOI9eSdHKh8VW2ph4oC3PCs9iZ6qYQnzi1aInbDEozhgE4sgAIJzWAuvpsMuhejA6ZSpl5I7ke/YTwKuRO7mqQXwgCa+2yfd3VqSPKc8zvdqDRiHzuIBvR21EmChx94LBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962673; c=relaxed/simple;
	bh=4ECaiAiIxz52ofD8BMwBMQz94h8wgg3loFVPz1YX5uU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gkJj3Lc7/zuU3hV8ShFxlLEzHxB9d7U33tu9En8F8/1d3jHBIlhFRyTF6M5j8DBXWtoAAfygIyre5cCPXHQ/TtDYIffD90SzmlY89ifGO8UMooHFWtfavAZu9ZoiuBURzEWsjWOD8AEm4hsNdrMYHM8wxpMTR+Wq1fLumY/dmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=koduu5BH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso4825662276.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708962671; x=1709567471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWOoMa987sKCREj7DqHUrlA6ygmJnTt1QZi1WiqcABw=;
        b=koduu5BHmA1PgY+0agC9250fFV/YElSDpaZD39Ap62vHCGA7xF51O3wevAqAlg8fvD
         M5AZcbFLXawgnWKgro3aRQE9XIBIZh30P0SxH/TAVCAsAS+zUvP/U8qLGGUadOouicNL
         l7og6YR0kxU70I7P6O3aENdu66rtRIU0HfdaJAJNvMQNkdBA33tH4gY9nr0l6eGmpXnY
         HCt5MZ5oZB+P/MsZVAS8IUbmh4d+2rbujTtw8gnhsqeAmpyq//rWoqnon7nfvpN2mP4z
         QiDmrKPWfYYSGCBP5Hxo52I058vMRJJzHZcmNo7Wf/ahPjNosFu1pPovwG8ZPL2qpfS/
         9uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962671; x=1709567471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWOoMa987sKCREj7DqHUrlA6ygmJnTt1QZi1WiqcABw=;
        b=DROqgIZ7Xdsfvumg/FCE3Ta33Nz/tmjShCGtZiqudETNQ38yY/mZ5Ka2FEeHc2Lqzp
         uo3Xrj34gPGlaYBmFesF3ebpB3FBYgxkLLrsLKG6/RDOK1sozW8AtUxIlsrj+O5otl0M
         rPW0R1T+Rtz+icE1QZFPDbYXhaCrF8CT1B5Cmrd1Inv1lzONp+qtGERQ+ONj8g0gSVg4
         zYY0JdBJvlblXqltvv2cUXc46nyEQf3kCKD4h00w1hBhJK7OIcWHrHMNZ7vt42BqBEhI
         +qQIwIXXRQB0QM9aPHR+CxQ0B5vXQKC2R+YybW/v5OisaOmrnsc4G+D4I/pLFH52SrZF
         MAUw==
X-Forwarded-Encrypted: i=1; AJvYcCWQM4vjovHGik6ZvFO283GMli4uTcN7+LaILzzudcWNRMXsbhdvDuBXVNNnkPjZ3VUtyyAX4LwbRud8B5u/Bn1cZnB9a67K
X-Gm-Message-State: AOJu0YzoCtEp/tBfCDmDgbmV7wWOAalV+CwqcY9hGEIP20pFc0yGj7So
	t/fZpCJXcKJi5CT1Ode+ohbiPEre6PDcUSbWDd53G0s035mZnQmDKzkSPt6wit/VEACmKabLwDy
	8h6no8hT2zw==
X-Google-Smtp-Source: AGHT+IHAchImivpPt3JuWC5qDtM0hcE07DErRrkxNLicJ4AvPX7LLUUaW6zoGPy40OiH0lUhawbq8Z90KmBCkg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1749:b0:dc6:4bf5:5a74 with SMTP
 id bz9-20020a056902174900b00dc64bf55a74mr281243ybb.11.1708962671013; Mon, 26
 Feb 2024 07:51:11 -0800 (PST)
Date: Mon, 26 Feb 2024 15:50:46 +0000
In-Reply-To: <20240226155055.1141336-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226155055.1141336-5-edumazet@google.com>
Subject: [PATCH net-next 04/13] ipv6: annotate data-races around cnf.hop_limit
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

idev->cnf.hop_limit and net->ipv6.devconf_all->hop_limit
might be read locklessly, add appropriate READ_ONCE()
and WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/netronome/nfp/flower/action.c | 2 +-
 net/ipv6/ipv6_sockglue.c                           | 2 +-
 net/ipv6/ndisc.c                                   | 2 +-
 net/ipv6/netfilter/nf_reject_ipv6.c                | 4 ++--
 net/ipv6/output_core.c                             | 4 ++--
 net/netfilter/nf_synproxy_core.c                   | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/action.c b/drivers/net/ethernet/netronome/nfp/flower/action.c
index 2b383d92d7f573b450ed3e315af3f07de56c1921..2c3f629079584024ed9d1640a980f4894b987115 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -460,7 +460,7 @@ nfp_fl_set_tun(struct nfp_app *app, struct nfp_fl_set_tun *set_tun,
 			set_tun->ttl = ip6_dst_hoplimit(dst);
 			dst_release(dst);
 		} else {
-			set_tun->ttl = net->ipv6.devconf_all->hop_limit;
+			set_tun->ttl = READ_ONCE(net->ipv6.devconf_all->hop_limit);
 		}
 #endif
 	} else {
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 56c3c467f9deb907ac6e6b84dcd33ec44bde0682..f61d977ac0528e190d901c9b5e71b1cf358096bd 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1346,7 +1346,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		}
 
 		if (val < 0)
-			val = sock_net(sk)->ipv6.devconf_all->hop_limit;
+			val = READ_ONCE(sock_net(sk)->ipv6.devconf_all->hop_limit);
 		break;
 	}
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index e96d79cd34d27ca304c5f71b6db41b99d2dd8856..9c9c31268432ee58c1a381d0333d85a558a602e1 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1423,7 +1423,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	if (in6_dev->cnf.accept_ra_min_hop_limit < 256 &&
 	    ra_msg->icmph.icmp6_hop_limit) {
 		if (in6_dev->cnf.accept_ra_min_hop_limit <= ra_msg->icmph.icmp6_hop_limit) {
-			in6_dev->cnf.hop_limit = ra_msg->icmph.icmp6_hop_limit;
+			WRITE_ONCE(in6_dev->cnf.hop_limit, ra_msg->icmph.icmp6_hop_limit);
 			fib6_metric_set(rt, RTAX_HOPLIMIT,
 					ra_msg->icmph.icmp6_hop_limit);
 		} else {
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 196dd4ecb5e215f8a1de321bf249bec6fca6b97c..dedee264b8f6c8e5155074c6788c53fdf228ca3c 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -83,7 +83,7 @@ struct sk_buff *nf_reject_skb_v6_tcp_reset(struct net *net,
 
 	skb_reserve(nskb, LL_MAX_HEADER);
 	nip6h = nf_reject_ip6hdr_put(nskb, oldskb, IPPROTO_TCP,
-				     net->ipv6.devconf_all->hop_limit);
+				     READ_ONCE(net->ipv6.devconf_all->hop_limit));
 	nf_reject_ip6_tcphdr_put(nskb, oldskb, oth, otcplen);
 	nip6h->payload_len = htons(nskb->len - sizeof(struct ipv6hdr));
 
@@ -124,7 +124,7 @@ struct sk_buff *nf_reject_skb_v6_unreach(struct net *net,
 
 	skb_reserve(nskb, LL_MAX_HEADER);
 	nip6h = nf_reject_ip6hdr_put(nskb, oldskb, IPPROTO_ICMPV6,
-				     net->ipv6.devconf_all->hop_limit);
+				     READ_ONCE(net->ipv6.devconf_all->hop_limit));
 
 	skb_reset_transport_header(nskb);
 	icmp6h = skb_put_zero(nskb, sizeof(struct icmp6hdr));
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index b5205311f372bdaaff140d651e4b42b27a3ed805..806d4b5dd1e60b27726facbb59bbef97d6fee7f5 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -111,9 +111,9 @@ int ip6_dst_hoplimit(struct dst_entry *dst)
 		rcu_read_lock();
 		idev = __in6_dev_get(dev);
 		if (idev)
-			hoplimit = idev->cnf.hop_limit;
+			hoplimit = READ_ONCE(idev->cnf.hop_limit);
 		else
-			hoplimit = dev_net(dev)->ipv6.devconf_all->hop_limit;
+			hoplimit = READ_ONCE(dev_net(dev)->ipv6.devconf_all->hop_limit);
 		rcu_read_unlock();
 	}
 	return hoplimit;
diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index fbbc4fd373495b69940e29e657fde2cdc67b55db..5b140c12b7dfa40efc9bec6f2588c4350fed6bfb 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -800,7 +800,7 @@ synproxy_build_ip_ipv6(struct net *net, struct sk_buff *skb,
 	skb_reset_network_header(skb);
 	iph = skb_put(skb, sizeof(*iph));
 	ip6_flow_hdr(iph, 0, 0);
-	iph->hop_limit	= net->ipv6.devconf_all->hop_limit;
+	iph->hop_limit	= READ_ONCE(net->ipv6.devconf_all->hop_limit);
 	iph->nexthdr	= IPPROTO_TCP;
 	iph->saddr	= *saddr;
 	iph->daddr	= *daddr;
-- 
2.44.0.rc1.240.g4c46232300-goog


