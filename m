Return-Path: <netdev+bounces-265925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +sjDGzfYr2kLdAIAu9opvQ
	(envelope-from <netdev+bounces-265925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:37:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D36E124761E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D228D3016812
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9FA3EDAD9;
	Tue, 10 Mar 2026 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0Y3DZZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52140B6E8
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773131826; cv=none; b=gYbUR1pqSOSps5VsdgXcs9j9qffi7YjFBSWtHSeTgBKPxobbZAhvhZ++h5iRmO5RSo/RnPfhvp2u7L9bsYilFo/Ui+qTTE6Rp73xheB7qrsUA1HBeCJ95CGJJfkyG7Kyjctyz1AFGCvXFeXYk5rxBWUXySLC177KMBB5fg20j/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773131826; c=relaxed/simple;
	bh=SkOW0Me5Mei+6+811W8wfI40/OJEsEajTjQbZP2i/9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwGADJcOPJYqnEbhLTnS19pGcDG7AFDf2h6coqlNNhQxXuFFH4IN2bVZl0X5uw4hSiW5Sh/QMAubb2/RhNejGJ0R4OWuCnvoWX8XABziCLjnOWcEq4zgdIau9zksa4xqJjVgV62pJSgoTPpZTY/MqXAKQthNgzte6EuQRPIbVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0Y3DZZx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-662e7450a8aso225731a12.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773131824; x=1773736624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nmp2C2LK1KcB7kS8d+inf4YkPeQ+OioLOT0ROrHIx4Q=;
        b=j0Y3DZZxqWzBx0w0jrGAC3EzKuM0bm64IyMhsaadSYJRSy9gMDrRpUrtORyP7h/yiT
         WdNGTx9e6eAoyHsiLMifexwfVePSkN8amSjtZHsZaUTLZsCbpeBpZipYTx+Wn7E27Bex
         NOFTjlEH+cu3YDMkMfQizQkTJJ0fHuDwcGPMB608+GjpJcyGh3Qe9wFxuDhwoOgLM0Pd
         yCbC7fOecB2xPGK5H+yeAEIl8PqvX6gslzonNhR5qWxwhBGY7Fk3npb2zKe95yaxx+jh
         HTXrKS5pyvAFXWe/7aGPOdz2H3PsMLmC/mpyx+pTdofMl21VsKZSnlP+fkGl1X+0h3zl
         4HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773131824; x=1773736624;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nmp2C2LK1KcB7kS8d+inf4YkPeQ+OioLOT0ROrHIx4Q=;
        b=lHsvPqTZ7itGaEmMvmtTCCD78wAK+/5iJ28axmj6n4lCtwswAjg9VrwFys1oNV1Uz2
         cNYtAgB88r+96+gvJSWW7SI6P3xQUJMuxSK2hMYAzgzwORAUEs7OaH81TQXNkZXM+NIh
         tjL+DmsuL+NZE7kPcre+0KNy2Ad7bKzwTYcMeknZziiGoOhRKhB68M1TrMc7e6adlHzN
         bz4ravLv1W8WDqXj8hSenxgvofjfPbM9bBsPT4Zox8FV9XA8/dD9mPvt+a9VA1KBORqT
         7lcGwmlNv96jk56UDPJm+VbuqPtoVKVXSFeo7JIMLTUQ8rRBRWD6dIK/9JkE0XCsGhw1
         4nHw==
X-Forwarded-Encrypted: i=1; AJvYcCUyNyZ5yJSEjjwGBa4hpufweuu9AaBq9RVvTo9qX3ySx4ZLNdfr9fu8yktL5nbx96mkeOfx/gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx66yMDFDoO9lVm/pYmjkLQ2ZltViQ4FASE93GmKT5feQyTjn2E
	P4YJAWlHAfmqi+Z2yEVvJz5PsvY5oYpHvqKFnfKLyvEC1ryDzKXJVPMn
X-Gm-Gg: ATEYQzytUkmburjCAjVUrSP8KR932EvOXpqzl6g3iaM3AeosdPYeDoU+iQYVz1Y45Um
	NnRYIP9lOcySfyoGOJ8P+F0FM9kF57k+LMQbd+omR4xzcdD2S+dtg+xVmB78BXEt/Dt2tyYBIKK
	3YpARd0ojktOrJ0ccSOHkngB5pKZ1n6u0WpoBDJ6hjk5lROFRWv6LSTi0yLEZ0kkbQ6oc96Naqr
	l4nWbwNdlwtOYKvdQmPw1Kxqe3OXNp6k0hUrL1tcyMjbdhX0HUBNj+rqWbG6k7vBl+x7+I9aRnf
	GGfVvxBgZHkgRxSZWDAdxkdQxh/6Otzl0vlqSP4T9sFLPkKNUwD1rGae9LlSqzoLRPw2Ilk9VZt
	mWZ4kFtlcdZLoHZk38Ty6/eznF0NJAyhkSgUKHVXVJpp0tES5HfK8jHH7myEaVNlaMugNthKSbe
	LQag9ksDhDbNyJtXwzWzZxAJ+jqNFOZlYGWNoVhUscfqUwOFavaRbD2elZ6fVPBHhzwsSsrtrHC
	L3UPyuxdBjziqvjku8vwSLzYZKkFbaj0ocAKaIlQvTA2Iqcf7/UeTOQkFQMfVbn+uAHnQQNG2Rp
	wAcm+VgfTtNkAiLBTZfSvuuHLQ/rzT55Ew==
X-Received: by 2002:a05:6402:13cb:b0:660:ce49:f6d1 with SMTP id 4fb4d7f45d1cf-6619d53ce70mr7697726a12.30.1773131823379;
        Tue, 10 Mar 2026 01:37:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-661a3e61eb6sm4096796a12.8.2026.03.10.01.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 01:37:02 -0700 (PDT)
Message-ID: <76b3546a-37c5-4dab-9074-4df0cbe48524@gmail.com>
Date: Tue, 10 Mar 2026 09:37:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 nf-next 5/5] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Phil Sutter <phil@nwl.cc>, Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20260224065307.120768-1-ericwouds@gmail.com>
 <20260224065307.120768-6-ericwouds@gmail.com>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <20260224065307.120768-6-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D36E124761E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265925-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,vger.kernel.org,blackwall.org,google.com,nvidia.com,lists.linux.dev,davemloft.net,nwl.cc,earthlink.net,lunn.ch];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 2/24/26 7:53 AM, Eric Woudstra wrote:
> In nft_do_chain_bridge() pktinfo is only fully populated for plain packets
> and packets encapsulated in single 802.1q or 802.1ad.
> 
> When implementing the software bridge-fastpath and testing all possible
> encapulations, there can be more encapsulations:
> 
> The packet could (also) be encapsulated in PPPoE, or the packet could be
> encapsulated in an inner 802.1q, combined with an outer 802.1ad or 802.1q
> encapsulation.
> 
> nft_flow_offload_eval() also examines the L4 header, with the L4 protocol
> known from the conntrack-tuplehash. To access the header it uses
> nft_thoff(), but for these packets it returns zero.
> 
> Introduce nft_set_bridge_pktinfo() to help populate pktinfo with the
> offsets.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_chain_filter.c | 55 +++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
> index d4d5eadaba9c..66ef30c60e56 100644
> --- a/net/netfilter/nft_chain_filter.c
> +++ b/net/netfilter/nft_chain_filter.c
> @@ -227,21 +227,68 @@ static inline void nft_chain_filter_inet_fini(void) {}
>  #endif /* CONFIG_NF_TABLES_IPV6 */
>  
>  #if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
> +static int nft_set_bridge_pktinfo(struct nft_pktinfo *pkt, struct sk_buff *skb,
> +				  const struct nf_hook_state *state,
> +				  __be16 *proto)
> +{
> +	nft_set_pktinfo(pkt, skb, state);
> +
> +	switch (*proto) {
> +	case htons(ETH_P_PPP_SES): {
> +		struct ppp_hdr {
> +			struct pppoe_hdr hdr;
> +			__be16 proto;
> +		} *ph, _ph;
> +
> +		ph = skb_header_pointer(skb, 0, sizeof(_ph), &_ph);
> +		if (!ph) {
> +			*proto = 0;
> +			return -1;
> +		}
> +		switch (ph->proto) {
> +		case htons(PPP_IP):
> +			*proto = htons(ETH_P_IP);
> +			return PPPOE_SES_HLEN;
> +		case htons(PPP_IPV6):
> +			*proto = htons(ETH_P_IPV6);
> +			return PPPOE_SES_HLEN;
> +		}
> +		break;
> +	}
> +	case htons(ETH_P_8021Q): {
> +		struct vlan_hdr *vhdr, _vhdr;
> +
> +		vhdr = skb_header_pointer(skb, 0, sizeof(_vhdr), &_vhdr);
> +		if (!vhdr) {
> +			*proto = 0;
> +			return -1;
> +		}
> +		*proto = vhdr->h_vlan_encapsulated_proto;
> +		return VLAN_HLEN;
> +	}
> +	}
> +	return 0;
> +}
> +
>  static unsigned int
>  nft_do_chain_bridge(void *priv,
>  		    struct sk_buff *skb,
>  		    const struct nf_hook_state *state)
>  {
>  	struct nft_pktinfo pkt;
> +	__be16 proto;
> +	int offset;
>  
> -	nft_set_pktinfo(&pkt, skb, state);
> +	proto = eth_hdr(skb)->h_proto;
> +
> +	offset = nft_set_bridge_pktinfo(&pkt, skb, state, &proto);
>  
> -	switch (eth_hdr(skb)->h_proto) {
> +	switch (proto) {
>  	case htons(ETH_P_IP):
> -		nft_set_pktinfo_ipv4_validate(&pkt, 0);
> +		nft_set_pktinfo_ipv4_validate(&pkt, offset);
>  		break;
>  	case htons(ETH_P_IPV6):
> -		nft_set_pktinfo_ipv6_validate(&pkt, 0);
> +		nft_set_pktinfo_ipv6_validate(&pkt, offset);
>  		break;
>  	default:
>  		nft_set_pktinfo_unspec(&pkt);

Just in case, I'm sending a kind and small reminder, before it is too
late in the cycle.

Regards,

Eric


