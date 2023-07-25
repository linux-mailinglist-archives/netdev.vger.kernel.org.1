Return-Path: <netdev+bounces-21100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9E176274B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41352281A5F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B22B27704;
	Tue, 25 Jul 2023 23:28:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D4E8BE1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F896C433C7;
	Tue, 25 Jul 2023 23:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690327693;
	bh=wFYXU8FW2j/CEZh6TX3L/u8JpUiq+8Aq7hmDBPOY9DU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mQ/ujqP6+Rw45KHYH5KJINobLDHmPO+KgDM8Os7LLAu0+kSpNkKsQGq2gw2CWRP/v
	 I4onXPchvaMTAqf++F5DeKdXIjDFU7RxQ/Fobuh1zxAWuTEwWqiXF4Wfle8zFpgeWC
	 XoBBnE8Ssfv8BayFhhB2/IfnYJw7llJXI9UueqXlChxaqkUCLvhQZoxJsVEw+mQEQ/
	 ptnUTRj6NLNfrzKFxSyALgV6e7TGv0a4t/f1qlPvFmcDWIDc+AAW92iBhblfVAtmwY
	 jWIWVg2hByLLPCgZppR+DtP028OrHl4KgrTgSSIxQaFNjP6E/nJSjRwGoLFZG55xAl
	 9Cfkwpn0ZijVg==
Message-ID: <1940c057-99c4-8355-cc95-3f17cca38481@kernel.org>
Date: Tue, 25 Jul 2023 17:28:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [net-next] net: change accept_ra_min_rtr_lft to affect all RA
 lifetimes
Content-Language: en-US
To: Patrick Rohr <prohr@google.com>, "David S . Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20230725183122.4137963-1-prohr@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230725183122.4137963-1-prohr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/23 12:31 PM, Patrick Rohr wrote:
> @@ -2727,6 +2727,11 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len, bool sllao)
>  		return;
>  	}
>  
> +	if (valid_lft != 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft) {
> +		net_info_ratelimited("addrconf: prefix option lifetime too short\n");

The error message does not really provide any value besides spamming the
logs. Similar comment applies to existing error logging in that function
too. I think a counter for invalid prefix packets would be more useful.

> +		return;
> +	}
> +
>  	/*
>  	 *	Two things going on here:
>  	 *	1) Add routes for on-link prefixes
> @@ -5598,7 +5603,7 @@ static inline void ipv6_store_devconf(struct ipv6_devconf *cnf,
>  	array[DEVCONF_IOAM6_ID_WIDE] = cnf->ioam6_id_wide;
>  	array[DEVCONF_NDISC_EVICT_NOCARRIER] = cnf->ndisc_evict_nocarrier;
>  	array[DEVCONF_ACCEPT_UNTRACKED_NA] = cnf->accept_untracked_na;
> -	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] = cnf->accept_ra_min_rtr_lft;
> +	array[DEVCONF_ACCEPT_RA_MIN_LFT] = cnf->accept_ra_min_lft;
>  }
>  
>  static inline size_t inet6_ifla6_size(void)
> @@ -6793,8 +6798,8 @@ static const struct ctl_table addrconf_sysctl[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  	{
> -		.procname	= "accept_ra_min_rtr_lft",
> -		.data		= &ipv6_devconf.accept_ra_min_rtr_lft,
> +		.procname	= "accept_ra_min_lft",
> +		.data		= &ipv6_devconf.accept_ra_min_lft,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index 29ddad1c1a2f..eeb60888187f 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1280,8 +1280,6 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
>  	if (!ndisc_parse_options(skb->dev, opt, optlen, &ndopts))
>  		return SKB_DROP_REASON_IPV6_NDISC_BAD_OPTIONS;
>  
> -	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
> -
>  	if (!ipv6_accept_ra(in6_dev)) {
>  		ND_PRINTK(2, info,
>  			  "RA: %s, did not accept ra for dev: %s\n",
> @@ -1289,13 +1287,6 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
>  		goto skip_linkparms;
>  	}
>  
> -	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
> -		ND_PRINTK(2, info,
> -			  "RA: router lifetime (%ds) is too short: %s\n",
> -			  lifetime, skb->dev->name);
> -		goto skip_linkparms;
> -	}
> -
>  #ifdef CONFIG_IPV6_NDISC_NODETYPE
>  	/* skip link-specific parameters from interior routers */
>  	if (skb->ndisc_nodetype == NDISC_NODETYPE_NODEFAULT) {
> @@ -1336,6 +1327,14 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
>  		goto skip_defrtr;
>  	}
>  
> +	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
> +	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_lft) {
> +		ND_PRINTK(2, info,
> +			  "RA: router lifetime (%ds) is too short: %s\n",
> +			  lifetime, skb->dev->name);
> +		goto skip_defrtr;
> +	}
> +
>  	/* Do not accept RA with source-addr found on local machine unless
>  	 * accept_ra_from_local is set to true.
>  	 */
> @@ -1499,13 +1498,6 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
>  		goto out;
>  	}
>  
> -	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
> -		ND_PRINTK(2, info,
> -			  "RA: router lifetime (%ds) is too short: %s\n",
> -			  lifetime, skb->dev->name);
> -		goto out;
> -	}
> -

The commit mentioned in the Fixes was just applied and you are already
sending a follow up moving the same code around again.

>  #ifdef CONFIG_IPV6_ROUTE_INFO
>  	if (!in6_dev->cnf.accept_ra_from_local &&
>  	    ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
> @@ -1530,6 +1522,9 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
>  			if (ri->prefix_len == 0 &&
>  			    !in6_dev->cnf.accept_ra_defrtr)
>  				continue;
> +			if (ri->lifetime != 0 &&
> +			    ntohl(ri->lifetime) < in6_dev->cnf.accept_ra_min_lft)
> +				continue;
>  			if (ri->prefix_len < in6_dev->cnf.accept_ra_rt_info_min_plen)
>  				continue;
>  			if (ri->prefix_len > in6_dev->cnf.accept_ra_rt_info_max_plen)


