Return-Path: <netdev+bounces-297484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4nWoDmUFKWq8OwMAu9opvQ
	(envelope-from <netdev+bounces-297484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:34:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F4C666483
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:34:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=TLIvp3xL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297484-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297484-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27BB630097EA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBD2371CEE;
	Wed, 10 Jun 2026 06:29:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30043AC00
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:29:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072948; cv=none; b=c0uCk+FMg9lRY1zqaZtjo8p5mo+sOJzBMcex78Ol9GShp6xsi5tHdvztALrmDUwqzY8EBRVBaxP2SQuPg8xCsdOx6H/f8mwP2xnVXx8TE4xs96oRMEoURoJNziXePnBFthCF77fY9UC9Rifz0ij1KENQQnl41ZWZ/1kKX7l2Q6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072948; c=relaxed/simple;
	bh=gnwfqkTWBp5ntntu0BImNZGpeCB+/fM08zUD4G5e+HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDlMhrrZrXDWhpcnugN5+W69rbZPGGLtjv8GcE3XLPUq8KbXaRJ2sQmTaZ0RSK5Mwx0JQblorWPzjC9bqEGhyQyA0K02JOnK14Y9s41zUH6cb2hUdNdMPoC8MEu8PsvAAgAQZCAu6/M6ajUxYFUGxJs+CvTOTARrhrPnfCtiFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=TLIvp3xL; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso49593965e9.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 23:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781072945; x=1781677745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XU+vzqrYlGVSeYvKZXP37r01sAxItKN5dslisirfkd4=;
        b=TLIvp3xLYMbQ4IPK0Yyh0P6SSue/A/VnkHt8Mm4q34+V6m5bnTvm23lOqm+XGk1mC7
         9vOwyKCmsqNqz6++8zz8pSR97PWqqVQex23dZ3nq5pLl57nUaH6NaPMWj6dosig5ipMz
         hSdYOhQZ6cMIcOVJQ5vc9BZAae2/zdpoIfla8K9gvsUldbfkq8gDVjkq7WiyCl3mPOS5
         DQEwR8yMUHsfGXjMQpOox4sHm809JXusqgWV8Anqs9JSf2bzXKYUEHDOVFi+lD1EiQHk
         103qCvdEY2rkaigWOlD8rlQWviyQd5UQdrr6D5EFONDUP8GfkhFhMLn9StooRUj6hHs3
         ZW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781072945; x=1781677745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XU+vzqrYlGVSeYvKZXP37r01sAxItKN5dslisirfkd4=;
        b=gFP/KImzWUAnrJSk3wOaxjsDWYr5xmsRT5xQAMMyPXK4yJVWF2Koj+eXO2/zGbQDQj
         xG0Bf9C23afu91cvKKdNF0TW+x0rguP1o3u7LTp0XHm85xrxcHlohcKI5gK7xYYBe2pJ
         QzPBnNoQN724I+EsHhQ5jeq7zeaSVVxJyUIrt5wavysP5DGF1FE2k3ve+pO8/+kKs6I0
         Ih3BYULSCvEgh/8ulP1tn9TjKBy91Hq0CR36eBek/F7TIV5CVzQMLznzkJXR6rST6ci/
         AxNDIMxH7Oj29nt1sfPbcWUFwtXj8dvQidln4Z9AwoI7UbJcuLfGimk3rzEdZOe/bSnZ
         zo2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8I+Nx350gczsdomSFGnurRE4+EgXrf/QWLw8gJZVhu1ZD9EgR5nwkIYQh+CX2bBKoSUPvidms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyF1Wh/A4ozYSp1KpnkN80p4mgGCfZc12hI/4O9Zx8mYD4L2wP
	R0PZImoJg09HR+ctHBbDInwYGNCPDdk9zFkYUJtIww5UY+9b1A+xqr8KJZPR3hGMrjY=
X-Gm-Gg: Acq92OG5qCT1aLdgKGSY0ou2t3ZGozSC/ePICPcSq3acbc46BgXZT9WeVD3gk80rQVi
	4KBfzacCu4BQH5SzyDTUrmuXUhOMKkQ6xLcmtQReoxlx9Lp1SH22jesliotbkKHDnbymjf11aDw
	TX31LQP4RTWP7j8zY4CvhHRGTALYLBQDsFUDgsIzbPLXvouAf6PDRXaFQTK4FsTd+Lu7WRDnIvb
	HUpkj+o5I8Ba8eWWDJJgy2xdHaqaU+QACg5sLxNn4i+SSyCveehWjnmpI7CMEbkqx53WUpjXPSk
	ZPHwBB4BhoysYh1OtH0yZc22k7XLFUr6MFMRmu6uX4fUOUxdFHk9lt8M7eo5mQpIgP/a8zK00eY
	lAG5CTB0I+Y7KvTnHY9RzgPySxMde8qCZZMNxFFOPl9Kqi550o4boVaGIurjt0X6meLRkhzmibB
	MAXbktOnwGJXW/saVsn/362qP2Z1vLpjjKMhWFzC9hzVvs+cmgG1QGIqv6Pgt5NmgaGtasP+PrL
	7Q=
X-Received: by 2002:a05:600c:c059:10b0:490:3d3d:805a with SMTP id 5b1f17b1804b1-490c2d08d6dmr234815245e9.12.1781072944855;
        Tue, 09 Jun 2026 23:29:04 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm70413060f8f.28.2026.06.09.23.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 23:29:04 -0700 (PDT)
Message-ID: <b1680463-5563-413e-a6aa-e07f60c1489a@blackwall.org>
Date: Wed, 10 Jun 2026 09:29:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] net: bridge: use atomic ops to read/change
 p->flags (I)
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260609080839.2506801-1-edumazet@google.com>
 <20260609080839.2506801-4-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260609080839.2506801-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297484-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,blackwall.org:dkim,blackwall.org:mid,blackwall.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80F4C666483

On 09/06/2026 11:08, Eric Dumazet wrote:
> Use test_bit() in net/bridge/br_arp_nd_proxy.c,
> net/bridge/br_fdb.c and net/bridge/br_forward.c.
> 
> Use READ_ONCE(p->flags) in br_recalculate_neigh_suppress_enabled()
> as we test two bits at once.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 22 +++++++---------------
>   net/bridge/br_fdb.c          |  2 +-
>   net/bridge/br_forward.c      | 15 ++++++++-------
>   3 files changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 5263232278b4fe95775cfcbba71615197e2f5311..23eb6931a2b4ad9137ef20735d8333f376fd49f2 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -29,7 +29,7 @@ void br_recalculate_neigh_suppress_enabled(struct net_bridge *br)
>   	bool neigh_suppress = false;
>   
>   	list_for_each_entry(p, &br->port_list, list) {
> -		if (p->flags & (BR_NEIGH_SUPPRESS | BR_NEIGH_VLAN_SUPPRESS)) {
> +		if (READ_ONCE(p->flags) & (BR_NEIGH_SUPPRESS | BR_NEIGH_VLAN_SUPPRESS)) {
>   			neigh_suppress = true;
>   			break;
>   		}
> @@ -206,8 +206,8 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>   			const struct net_bridge_port *dst = READ_ONCE(f->dst);
>   			bool replied = false;
>   
> -			if ((p && (p->flags & BR_PROXYARP)) ||
> -			    (dst && (dst->flags & BR_PROXYARP_WIFI)) ||
> +			if ((p && test_bit(BR_PROXYARP_BIT, &p->flags)) ||
> +			    (dst && test_bit(BR_PROXYARP_WIFI_BIT, &dst->flags)) ||
>   			    br_is_neigh_suppress_enabled(dst, vid)) {
>   				if (!vid)
>   					br_arp_send(br, p, skb->dev, sip, tip,
> @@ -511,10 +511,7 @@ bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid)
>   	if (!p)
>   		return false;
>   
> -	if (!vid)
> -		return !!(p->flags & BR_NEIGH_SUPPRESS);
> -
> -	if (p->flags & BR_NEIGH_VLAN_SUPPRESS) {
> +	if (vid && test_bit(BR_NEIGH_VLAN_SUPPRESS_BIT, &p->flags)) {
>   		struct net_bridge_vlan_group *vg = nbp_vlan_group_rcu(p);
>   		struct net_bridge_vlan *v;
>   
> @@ -522,17 +519,13 @@ bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid)
>   		if (!v)
>   			return false;
>   		return !!(v->priv_flags & BR_VLFLAG_NEIGH_SUPPRESS_ENABLED);
> -	} else {
> -		return !!(p->flags & BR_NEIGH_SUPPRESS);
>   	}
> +	return test_bit(BR_NEIGH_SUPPRESS_BIT, &p->flags);
>   }
>   
>   bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid)
>   {
> -	if (!vid)
> -		return !!(p->flags & BR_NEIGH_FORWARD_GRAT);
> -
> -	if (p->flags & BR_NEIGH_VLAN_SUPPRESS) {
> +	if (vid && test_bit(BR_NEIGH_VLAN_SUPPRESS_BIT, &p->flags)) {
>   		struct net_bridge_vlan_group *vg = nbp_vlan_group_rcu(p);
>   		struct net_bridge_vlan *v;
>   
> @@ -540,7 +533,6 @@ bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid)
>   		if (!v)
>   			return false;
>   		return !!(v->priv_flags & BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED);
> -	} else {
> -		return !!(p->flags & BR_NEIGH_FORWARD_GRAT);
>   	}
> +	return test_bit(BR_NEIGH_FORWARD_GRAT_BIT, &p->flags);
>   }
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index a114373c98163d1e81b090b9c799adcb1bfeed77..e4570bbed85445bcda08537b81c78bacd163f28d 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1514,7 +1514,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>   
>   	trace_br_fdb_external_learn_add(br, p, addr, vid);
>   
> -	if (locked && (!p || !(p->flags & BR_PORT_MAB)))
> +	if (locked && (!p || !test_bit(BR_PORT_MAB_BIT, &p->flags)))
>   		return -EINVAL;
>   
>   	spin_lock_bh(&br->hash_lock);
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 4a77d07433745152241789818949bd228aa95be0..36735f7f7b7b0cb4868a0d7704fc808a9c78e813 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -24,7 +24,7 @@ static inline int should_deliver(const struct net_bridge_port *p,
>   	struct net_bridge_vlan_group *vg;
>   
>   	vg = nbp_vlan_group_rcu(p);
> -	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
> +	return (test_bit(BR_HAIRPIN_MODE_BIT, &p->flags) || skb->dev != p->dev) &&
>   		(br_mst_is_enabled(p) || p->state == BR_STATE_FORWARDING) &&
>   		br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
>   		!br_skb_isolated(p, skb);
> @@ -214,24 +214,24 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>   		 */
>   		switch (pkt_type) {
>   		case BR_PKT_UNICAST:
> -			if (!(p->flags & BR_FLOOD))
> +			if (!test_bit(BR_FLOOD_BIT, &p->flags))
>   				continue;
>   			break;
>   		case BR_PKT_MULTICAST:
> -			if (!(p->flags & BR_MCAST_FLOOD) && skb->dev != br->dev)
> +			if (!test_bit(BR_MCAST_FLOOD_BIT, &p->flags) && skb->dev != br->dev)
>   				continue;
>   			break;
>   		case BR_PKT_BROADCAST:
> -			if (!(p->flags & BR_BCAST_FLOOD) && skb->dev != br->dev)
> +			if (!test_bit(BR_MCAST_FLOOD_BIT, &p->flags) && skb->dev != br->dev)

here it should be BR_BCAST_FLOOD_BIT, not MCAST

>   				continue;
>   			break;
>   		}
>   
>   		/* Do not flood to ports that enable proxy ARP */
> -		if (p->flags & BR_PROXYARP)
> +		if (test_bit(BR_PROXYARP_BIT, &p->flags))
>   			continue;
>   		if (BR_INPUT_SKB_CB(skb)->proxyarp_replied) {
> -			if (p->flags & BR_PROXYARP_WIFI)
> +			if (test_bit(BR_PROXYARP_WIFI_BIT, &p->flags))
>   				continue;
>   			/* For gratuitous ARPs/NAs, check neigh_forward_grat.
>   			 * For regular ARPs/NDs, check only neigh_suppress.
> @@ -328,7 +328,8 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>   		if ((unsigned long)lport > (unsigned long)rport) {
>   			port = lport;
>   
> -			if (port->flags & BR_MULTICAST_TO_UNICAST) {
> +			if (test_bit(BR_MULTICAST_TO_UNICAST_BIT,
> +				     &port->flags)) {
>   				maybe_deliver_addr(lport, skb, p->eth_addr,
>   						   local_orig);
>   				goto delivered;


