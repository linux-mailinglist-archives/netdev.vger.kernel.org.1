Return-Path: <netdev+bounces-254572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKAiDaPtemnT/wEAu9opvQ
	(envelope-from <netdev+bounces-254572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:18:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E449ABE24
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D7883005300
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E1285C8D;
	Thu, 29 Jan 2026 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMliRZQG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D32AEE4
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663900; cv=none; b=PXD7bRQRI3Pxtkc+U3IxrISf6y51pLbyzbQMd5PPA/s8TdyLmLAEnqxM1uvi87D34pOm8EeTAQQzlzqKAVmB0a5voVxbGoVCWiqkOZIKuOnqAj4qRXVQRU3M2vmeP+yNPaUFZrxaHoB6H36XOIbBAjIbe6jDtblI/TR97mcZJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663900; c=relaxed/simple;
	bh=Rexvp1faCt2bVLuhDBNIyBxJAU5AUG+1ihrqZlqY/8Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=M1fg94u4x5L6QkoxWDhfPX/MzVgNJ/25RAautB0gwWhT4lb7XHR/zMbujEsVXm4Qr0oxIgqgDoje272Sviab1uBW1NXYGKJLCeOImS2pK2XJtoCAvamxMkO2eNozSTHG8ssrqy4uEGEIldfUuJgwBb7j9ahP8RkaIbh8hPFCNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMliRZQG; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64969550a1aso560840d50.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769663897; x=1770268697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cfi69+q5IU7J4ZORnqs2PULiEpkF+Nvl7GD3gjXhuM8=;
        b=VMliRZQGEuPzpI/h/Rg03+0eM+um7vKAXiqWPf/+1nv0o4SvfhrmnFNm6eR7O54oUH
         zF6IY5PcrtRmZpFxdgqsJTG8GOmjDQ/COhnIbnYpH+feKN3ZEcDwtBJPvgOzTsnpYvj+
         G1aWXK+gISDp+at91jADc+fENhf83vWo9XsJ8QeVCA+9s01ZEfvIQKy8tlYiTtKMwgfP
         huRCfl7tpxf4FEdR9X/BU13jGgoR0HjFbHyH/bn3Kb+wk2aDzAXZRaQPzSPbuuv6+adE
         CKrvaBg9XMW+o3IiIPCqpkTkk/VB04AgtQQG28OT1cbH5bLG7ME5A3xS3rX/BGDTv8MM
         L2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769663897; x=1770268697;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cfi69+q5IU7J4ZORnqs2PULiEpkF+Nvl7GD3gjXhuM8=;
        b=Gg/CqqDNiA8WcGFDcs/YWLPfnGh28Xr8oaOPs+dJZOgGg/VrZq3ASNmDOptfnRQ3Po
         c57kD3HwtHijEzoxGTU4vpifg1lnJ0MI4d/7gBPpl1oZbtwUpnKUi9nl//nTeWZ1oT5+
         uSTBAp1DteRb3f5H/+KYajArzQKobPAPPKp3cBNfxw4oT4lKg2OQRYAi3/2h88Wi8eou
         oLe0s4gC7gIwhoN8A5LBO4mGTY98pnRW9t5MTru2IJGKVYaW2976Z73GWMFpRBS5F+Yo
         Ci04ybvghJpMB9VlP4qj1ezf7od1em30H3CQwSduct3VMFz+EN23LCxvTt+z0FoZEDle
         dJEA==
X-Forwarded-Encrypted: i=1; AJvYcCXpoMrdn7lud95xeLcBTuK8VmIRjzFf/ZvEJ/6xl1CJrotJhrjCuwjt3xNwFXoIJe+Qns+L8rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3svyFskE3cp3RfvvNi96OHjTq0CnGZ+CZN7xdTgS4dZOFJvW6
	oUzNTqTmCFv9ppDNjRJePjG0vcDk3Uo+CkBjlGEVUzGQXcbjcwN8jccI
X-Gm-Gg: AZuq6aIC5P8NYRVNPIucmco+jRg3Ex+1fGXPnWWP58BsjG6/1ohNwkeks6taKKnqRZD
	8w+Z778e69II6F9b/UfTGE3TuBTXae0U3A98BHW4bUfvjs0q7Eh3OZwcbGujJ6TVCHFocUNIZni
	tHmFVjxwE+dMikinEDjUIN4yllq/yz8J3tuby2XvbjCPv5YKfFJkVWBQfcCzVN3+r3jEBKHYVhj
	bLevWdp18xI2tQFTU91Dd3ofvcgm0LmwxyjJmHzBxK5FJ+XQG0ezvplkDMaLspfUu9mbSR70NMr
	F5q8zZQKmop5ZKjpEzXSOygBWCTnJoW8qxMj2xeHBYUQbB4wGfsefXroKrdb3cG5s9dttmapq2/
	vXtv4gKbVfnAWCFSBb8epOsPF4XdZcOQzwdxv80snwgpU163uDeLHXfPTH15L2NFyQRJgoyx9XM
	xZPykReS+tkfRnFnwLf+amMyMmJcv8QVdWDAN+2FoHehikmBr5ZGr/NpOteAA=
X-Received: by 2002:a05:690e:4086:b0:645:5bfc:8be4 with SMTP id 956f58d0204a3-6498fc5b319mr5554727d50.66.1769663897341;
        Wed, 28 Jan 2026 21:18:17 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-649960efe0csm1839741d50.19.2026.01.28.21.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:18:16 -0800 (PST)
Date: Thu, 29 Jan 2026 00:18:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 netdev@vger.kernel.org, 
 justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <willemdebruijn.kernel.19061eebdb902@gmail.com>
In-Reply-To: <20260126194826.236075-7-tom@herbertland.com>
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-7-tom@herbertland.com>
Subject: Re: [PATCH net-next v5 6/7] ipv6: Enforce Extension Header ordering
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254572-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E449ABE24
X-Rspamd-Action: no action

Tom Herbert wrote:
> RFC8200 highly recommends that different Extension Headers be send in
> a prescibed order and all Extension Header types occur at most once
> in a packet with the exception of Destination Options that may
> occur twice. This patch enforces the ordering be folowed in received
> packets.
> 
> The allowed order of Extension Headers is:
> 
>     IPv6 header
>     Hop-by-Hop Options header
>     Destination Options before the Routing Header
>     Routing header
>     Fragment header
>     Authentication header
>     Encapsulating Security Payload header
>     Destination Options header
>     Upper-Layer header
> 
> Each Extension Header may be present only once in a packet.
> 
> net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
> enforcement of xtension Header order. If it is set to zero then

[e]xtension. There are a few more typos in the various commit
messages.

> Extension Header order and number of occurences is not checked
> in receive processeing (except for Hop-by-Hop Options that
> must be the first Extension Header and can only occur once in
> a packet.

RFC 8200 also states

   "IPv6 nodes must accept and attempt to process extension headers in
   any order and occurring any number of times in the same packet,
   except for the Hop-by-Hop Options header, which is restricted to
   appear immediately after an IPv6 header only. Nonetheless, it is
   strongly advised that sources of IPv6 packets adhere to the above
   recommended order until and unless subsequent specifications revise
   that recommendation."

A case of be strict in what you send, liberal in what you accept.

This new sysctl has a chance of breaking existing users.

The series as a whole is framed as a security improvement. Does
enforcing order help with that?

> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  include/net/netns/ipv6.h   |  1 +
>  include/net/protocol.h     | 14 +++++++++++++
>  net/ipv6/af_inet6.c        |  1 +
>  net/ipv6/exthdrs.c         |  2 ++
>  net/ipv6/ip6_input.c       | 42 ++++++++++++++++++++++++++++++++++++++
>  net/ipv6/reassembly.c      |  1 +
>  net/ipv6/sysctl_net_ipv6.c |  7 +++++++
>  net/ipv6/xfrm6_protocol.c  |  2 ++
>  8 files changed, 70 insertions(+)
> 
> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> index 34bdb1308e8f..2db56718ea60 100644
> --- a/include/net/netns/ipv6.h
> +++ b/include/net/netns/ipv6.h
> @@ -61,6 +61,7 @@ struct netns_sysctl_ipv6 {
>  	u8 fib_notify_on_flag_change;
>  	u8 icmpv6_error_anycast_as_unicast;
>  	u8 icmpv6_errors_extension_mask;
> +	u8 enforce_ext_hdr_order;
>  };
>  
>  struct netns_ipv6 {
> diff --git a/include/net/protocol.h b/include/net/protocol.h
> index b2499f88f8f8..0f1676625570 100644
> --- a/include/net/protocol.h
> +++ b/include/net/protocol.h
> @@ -50,6 +50,19 @@ struct net_protocol {
>  };
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> +
> +/* Order of extension headers as prescribed in RFC8200. The ordering and
> + * number of extension headers in a packet can be enforced in IPv6 receive
> + * processing.
> + */
> +#define IPV6_EXT_HDR_ORDER_HOP			BIT(0)
> +#define IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH	BIT(1)
> +#define IPV6_EXT_HDR_ORDER_ROUTING		BIT(2)
> +#define IPV6_EXT_HDR_ORDER_FRAGMENT		BIT(3)
> +#define IPV6_EXT_HDR_ORDER_AUTH			BIT(4)
> +#define IPV6_EXT_HDR_ORDER_ESP			BIT(5)
> +#define IPV6_EXT_HDR_ORDER_DEST			BIT(6)
> +
>  struct inet6_protocol {
>  	int	(*handler)(struct sk_buff *skb);
>  
> @@ -61,6 +74,7 @@ struct inet6_protocol {
>  
>  	unsigned int	flags;	/* INET6_PROTO_xxx */
>  	u32		secret;
> +	u32		ext_hdr_order;
>  };
>  
>  #define INET6_PROTO_NOPOLICY	0x1
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index bd29840659f3..43097360ce64 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -980,6 +980,7 @@ static int __net_init inet6_net_init(struct net *net)
>  	net->ipv6.sysctl.max_dst_opts_len = IP6_DEFAULT_MAX_DST_OPTS_LEN;
>  	net->ipv6.sysctl.max_hbh_opts_len = IP6_DEFAULT_MAX_HBH_OPTS_LEN;
>  	net->ipv6.sysctl.fib_notify_on_flag_change = 0;
> +	net->ipv6.sysctl.enforce_ext_hdr_order = 1;
>  	atomic_set(&net->ipv6.fib6_sernum, 1);
>  
>  	net->ipv6.sysctl.ioam6_id = IOAM6_DEFAULT_ID;
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 6925cfad94d2..4ab94c8cddb9 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -845,11 +845,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>  static const struct inet6_protocol rthdr_protocol = {
>  	.handler	=	ipv6_rthdr_rcv,
>  	.flags		=	INET6_PROTO_NOPOLICY,
> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_ROUTING,
>  };
>  
>  static const struct inet6_protocol destopt_protocol = {
>  	.handler	=	ipv6_destopt_rcv,
>  	.flags		=	INET6_PROTO_NOPOLICY,
> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_DEST,
>  };
>  
>  static const struct inet6_protocol nodata_protocol = {
> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> index 168ec07e31cc..ab921c0a94af 100644
> --- a/net/ipv6/ip6_input.c
> +++ b/net/ipv6/ip6_input.c
> @@ -355,6 +355,27 @@ void ipv6_list_rcv(struct list_head *head, struct packet_type *pt,
>  		ip6_sublist_rcv(&sublist, curr_dev, curr_net);
>  }
>  
> +static u32 check_dst_opts_before_rh(const struct inet6_protocol *ipprot,
> +				    u32 ext_hdrs)
> +{
> +	/* Check if Destination Options before the Routing Header are
> +	 * present.
> +	 */
> +	if (ipprot->ext_hdr_order != IPV6_EXT_HDR_ORDER_ROUTING ||
> +	    !(ext_hdrs | IPV6_EXT_HDR_ORDER_DEST))
> +		return ext_hdrs;
> +
> +	/* We have Destination Options before the Routing Header. Set
> +	 * the mask of recived extension headers to reflect that. We promote
> +	 * the bit from indicating just Destination Options present to
> +	 * Destination Options before the Routing Header being present
> +	 */
> +	ext_hdrs = (ext_hdrs & ~IPV6_EXT_HDR_ORDER_DEST) |
> +		IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH;
> +
> +	return ext_hdrs;
> +}
> +
>  INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *));
>  
>  /*
> @@ -366,6 +387,7 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>  	const struct inet6_protocol *ipprot;
>  	struct inet6_dev *idev;
>  	unsigned int nhoff;
> +	u32 ext_hdrs = 0;
>  	SKB_DR(reason);
>  	bool raw;
>  
> @@ -427,6 +449,26 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>  				goto discard;
>  			}
>  		}
> +
> +		if (ipprot->ext_hdr_order &&
> +		    READ_ONCE(net->ipv6.sysctl.enforce_ext_hdr_order)) {
> +			/* The protocol is an extension header and EH ordering
> +			 * is being enforced. Discard packet if we've already
> +			 * seen this EH or one that is lower in the order list
> +			 */
> +			if (ipprot->ext_hdr_order <= ext_hdrs) {
> +				/* Check if there's Destination Options
> +				 * before the Routing Header
> +				 */
> +				ext_hdrs = check_dst_opts_before_rh(ipprot,
> +								    ext_hdrs);
> +				if (ipprot->ext_hdr_order <= ext_hdrs)
> +					goto discard;
> +			}
> +
> +			ext_hdrs |= ipprot->ext_hdr_order;
> +		}
> +
>  		if (!(ipprot->flags & INET6_PROTO_NOPOLICY)) {
>  			if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
>  				SKB_DR_SET(reason, XFRM_POLICY);
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index 25ec8001898d..91dba72c5a3c 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -414,6 +414,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
>  static const struct inet6_protocol frag_protocol = {
>  	.handler	=	ipv6_frag_rcv,
>  	.flags		=	INET6_PROTO_NOPOLICY,
> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_FRAGMENT,
>  };
>  
>  #ifdef CONFIG_SYSCTL
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index d2cd33e2698d..543b6acdb11d 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -213,6 +213,13 @@ static struct ctl_table ipv6_table_template[] = {
>  		.proc_handler	= proc_doulongvec_minmax,
>  		.extra2		= &ioam6_id_wide_max,
>  	},
> +	{
> +		.procname	= "enforce_ext_hdr_order",
> +		.data		= &init_net.ipv6.sysctl.enforce_ext_hdr_order,
> +		.maxlen		= sizeof(u8),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dou8vec_minmax,
> +	},
>  };
>  
>  static struct ctl_table ipv6_rotable[] = {
> diff --git a/net/ipv6/xfrm6_protocol.c b/net/ipv6/xfrm6_protocol.c
> index ea2f805d3b01..5826edf67f64 100644
> --- a/net/ipv6/xfrm6_protocol.c
> +++ b/net/ipv6/xfrm6_protocol.c
> @@ -197,12 +197,14 @@ static const struct inet6_protocol esp6_protocol = {
>  	.handler	=	xfrm6_esp_rcv,
>  	.err_handler	=	xfrm6_esp_err,
>  	.flags		=	INET6_PROTO_NOPOLICY,
> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_ESP,
>  };
>  
>  static const struct inet6_protocol ah6_protocol = {
>  	.handler	=	xfrm6_ah_rcv,
>  	.err_handler	=	xfrm6_ah_err,
>  	.flags		=	INET6_PROTO_NOPOLICY,
> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_AUTH
>  };
>  
>  static const struct inet6_protocol ipcomp6_protocol = {
> -- 
> 2.43.0
> 



