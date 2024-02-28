Return-Path: <netdev+bounces-75745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC286B0F0
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486D21C24A8E
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4894E15531E;
	Wed, 28 Feb 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/8e8AEj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E5157E7B
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128492; cv=none; b=NKHvif1tn4+GY1OELenznVRwcV9GpMBCn7/3lSdbrzxQm6lznRf4lcDu1XwnP1FXHcrlwZeDK8s/iEN6DgSE1zEz5vAtoNBH5iQMOE4S6XREmEF2oSXWoCzwhf3daot1TA1NiB5wUiiLHGJdpZmmEGK712p/cAzFDLJEgGDGf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128492; c=relaxed/simple;
	bh=ygLg94dIps3zIcDRFubF2s7jK0F5ZmRb8SWXaOSKLXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RPvsrQ2rJ/wk+lKBmwhisqUB0PZkWcUzek3VmZo3c9Otw4VIZmqkSi4sCxk1TZq2CoRKJWM1jt9ibvjmCCsAU9J5UIRrxaLi3b/TpsJ7UET4j2hgeK8y4l0Xui8tB3Lyznp5nWH7leYm/fwR1EG+SJn3GqXBi6jiaO+Mmj81/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v/8e8AEj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so7008038276.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128489; x=1709733289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7NTXK4f/hgsidvPYAJ36SmYjWcf3wQ94jpBSeMR/q0=;
        b=v/8e8AEjtN5P2UUJUL3vJndeKUrVSuSVGcNgSEetLBsb4MoqqOzwWsw7UEctygJHlO
         Xpkjgos8CIsKwHY6sR5f+MDFdP+nvwMNFxcGBdd8VHnoqqrw++U1xu+uczNKwVvC6q6S
         /nWHH4UjwWncUw2v6hzfpnxxbi8gdyIIdnaajeHUfEZV07y8qGfWya798C+8KYtXYJ2e
         7ozC/dy/QQB2hZdX0wBt+AowQbta0IqJZMRsSasKD9GS4dxZ6NeEL3TH+IQbRFPdaeFZ
         EhGncOW84zxwKfq78yJ2Lu6tr+ZZJfbIPgF60uW1KDmBOYb3UQQ0JWKNcnJTYUV5L/Ik
         l30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128489; x=1709733289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7NTXK4f/hgsidvPYAJ36SmYjWcf3wQ94jpBSeMR/q0=;
        b=MuIKrFSK00UljPl8Ogu5n7MJmCDpLAvj8/9smnfJOjEqkRDAJTe/THHfIhnsdxl9Bj
         ijYH1QXe21Bv4KFrE5V2Y8LeDNg91YJ2W+CCHymuP2c+O+3uUE2y2+2rMs5w7S5xPvsA
         p6cp0MT4VEg6c/kUzepOyFKULD0AEModKcSYlr5XOBdVeEw2a68Xq7k7A3IT+GOyZ1yR
         T13+bVmAsDrBNRzS4+ygpLCXBW6TdCGpA0SNRP5i7nBw3oLj/XishALYWpUMiGoqSfkp
         et9h/TZ2H/r8SErZgYJzluWZH6EuiomGB5r/tkirJDzsSGUIv+HEQyQNlqxT9PRdV+Rn
         x1Ig==
X-Gm-Message-State: AOJu0YxsktR680DdAwL/6lBgcihG+HPfjCuYWU3XlwjednympJ1tM2zC
	tovqxvAH+nZjJi8b3+wdrKZFH1TGxkVxlE3I0e/R6582QrT6m55Ib5+5kfKcNtS/baFUSR5qX4w
	6BW3l/+uAIA==
X-Google-Smtp-Source: AGHT+IEIXzUAmeELorWcDE5L855aOKhWG/XTCFSxkmmSn2v9yK8O58x9Ry+nVUridtrK8SmY9KP2J90Y8dViuA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1105:b0:dc6:b982:cfa2 with SMTP
 id o5-20020a056902110500b00dc6b982cfa2mr124760ybu.8.1709128489352; Wed, 28
 Feb 2024 05:54:49 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:29 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-6-edumazet@google.com>
Subject: [PATCH v3 net-next 05/15] ipv6: annotate data-races around cnf.hop_limit
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"

idev->cnf.hop_limit and net->ipv6.devconf_all->hop_limit
might be read locklessly, add appropriate READ_ONCE()
and WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Florian Westphal <fw@strlen.de> # for netfilter parts
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
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


