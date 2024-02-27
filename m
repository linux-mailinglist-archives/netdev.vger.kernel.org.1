Return-Path: <netdev+bounces-75358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F212D8699C3
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F611C22D73
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3BA1487C4;
	Tue, 27 Feb 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DosfY4Ss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2610148310
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046133; cv=none; b=KQ/QQEnDreLRhU8vmeRV7BU2PsfbDCCFMePdI/IGHPnbu9Ez2LqEPChFbBjkyvngK9RRGzwlNvT4uozTWJvLWP7yivaQnJuksGjS8R9OFuxiWaPdDcOf+sp7Za4abcQ83MV23S4Ck38gdm5DbZJiJRrXB+HT3BV38wjVi3DcZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046133; c=relaxed/simple;
	bh=4ECaiAiIxz52ofD8BMwBMQz94h8wgg3loFVPz1YX5uU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yjqh6oCXzPxxe8cBuYu4CPYTWFrKJsBPETWcSJsVmi/aZzOplzvTcIgkBaxKJHpYNoM+LKqKoyOHuM+rOPqDCGK97D+G40WEsEwATQIkaCAQzIaB9bPL2GH8mUqqnwk6aRWVS9Vm6/Aasn9iYESqor4TernZJ9vwFP9qEnsZdhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DosfY4Ss; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-787c94280c3so348384085a.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046131; x=1709650931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWOoMa987sKCREj7DqHUrlA6ygmJnTt1QZi1WiqcABw=;
        b=DosfY4Ss/hsCBGxBE2+m1n/0nMd64+HkybCDykm7acn441o6QlrlkxWlf0VtptYG35
         /u9cEvKxZ52Iw3o2CvFUUI6O5YaPKYAKs3g8hSTBLSdZIMVb9nl1GuHS4GQhcOPVtobQ
         lpjppC3BkF40M2fS2FGmMEhmjOHMxTV8bu7ZDZZ9XyWI+8/JiZFuItzfOq4jM7R/qapD
         v9qEseRYI+QWeC6zNh/SWYUtY0xOO/by9oV98N98VABf+Uya0LQVUNYgRKn1QFCgNBdA
         4Loq6Upa8bpAAXmUnhFEl3qmhYHSo/THTZlTP9nYfwjhRPMO05U3wxz3kRP6MD6bMn3D
         B20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046131; x=1709650931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWOoMa987sKCREj7DqHUrlA6ygmJnTt1QZi1WiqcABw=;
        b=Rvk1cbdCmD0CRWy3OIl+1b9KfJMtve4/AC1O9R1bxYnlvtv0/b4sd769MsxtRlF258
         b6IQGma5MCHgYG1hJr1xvikW5AsrG6yuKpvSslXtfuHjciZY4jSIbjpe4XApFQL13+RM
         8avwbZLGGz4uc6cmXc1wM1FVVY+wr3tpcJUIZ62IpyNmP6Y9xa/PN6bIy/KA4fZwp4DB
         vXhNDG8x3KowFpHh4WQLi6qlQf0Phd89xvqsLyHlYHIxVNmVY7GaUlGacHNPTKjxEeSv
         CahPCXFPvE/RFN3NWMW7dCD2qyhfTJYNWXHj4t1mV25Fb6TRyeMhw7fMPCmqw2ORN4rP
         0bMg==
X-Forwarded-Encrypted: i=1; AJvYcCWdM1YJX0ndyTtdC0d1p4NJ/2pWrdxAcFT523O4/aOAjzKrKzeAsDjpdEiU20zONR82+LOo1TI5hIXHkZF6gjc/aUkvCg0V
X-Gm-Message-State: AOJu0YxS/7Z7XkM+vTpWcZ6o7g1r1uycZIZvLKp3YqxjJUGj1aMlmpPQ
	6ZP9bFmMiVepns69zqbRvUMIWLhY8Q4LdM036XfjuRvUcZGfkNoMYjNSi80f+mRTnH4O+g46LYd
	yH5jzPuqfOQ==
X-Google-Smtp-Source: AGHT+IGBZ0SEuIHkjWelMV7f9naPe/tgmaR4IcKwBD2X+OC5mZcTNjLbmbGCj293ftJAN43orb0wg3AptdbGVw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:179f:b0:787:c704:26d9 with SMTP
 id ay31-20020a05620a179f00b00787c70426d9mr49755qkb.12.1709046130818; Tue, 27
 Feb 2024 07:02:10 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:50 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/15] ipv6: annotate data-races around cnf.hop_limit
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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


