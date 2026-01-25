Return-Path: <netdev+bounces-253188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MqGDxFEdmmVOQEAu9opvQ
	(envelope-from <netdev+bounces-253188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 17:25:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0CF816C3
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 17:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BAB83005D3B
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C6E30DD13;
	Sun, 25 Jan 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqIiRvkH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FAD1F3BAC
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769358348; cv=none; b=ZFBjU1tamVnpNXk2fKhTiYhgo7drGvHhL1sBDINvxJtRndh9wegA0g4cBdJFwq+jSBd9iXcuH0UCHN7LkzDsCoCVpAvHJmZ58gZppTrKugJ4s+DL0itGPr4GRHXDaaUQ6tepXF8egTY+0jKUfuhG+Oa1nvS7ZVni+ppl0K+r97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769358348; c=relaxed/simple;
	bh=QVtSTX/XLp16X/oXKfhKEuxOzQqk8ZSe4U/GC/FHDBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGe6GIzniFPV8Z0IFNKXBoY/Kd2LOrpjHl8GLLUZ5YIfLICrSoEL8T9iQfqz1BGGL1v/su8g3ZV0/WgbQnsvoopm1levAYNuFohEvpTjPD6N2to9Sisgc2vKWY0wLve1agqsONZdhKFLLJzSaoVUIT/gJXovShKz57CBKFcfdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqIiRvkH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso4899184a12.3
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 08:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769358344; x=1769963144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3v57Iy+bDz50Wo3pEiRxYhkqRNwfCJZJ1CeX2JqnHG4=;
        b=OqIiRvkHIpky35Lm795JQYFph/tL3/iuFylaZYybbVRwn+8215c9wtABw9xo6gVQ4/
         5e0GLgehdPAAFygx6Ex6BKeaF6kA0pIbLKhh/FKKwhWdeH9725z69K3yEk5Ck5Lcto4w
         S5V1iJ97a3ui8njQfItB51mZZFocwwJKEBLufKZOCDori1d7AevkyiAV3RjHPh7qncZw
         MGo9mdstytYyLSdg76MigFFOJfYVnPARNxxfkKHVS4V2V+QFJ6F9ruHd62u7NJEsErl9
         UHka3u5ZwO+ww9ABrz6M5WG/FavLEVT4S3Ebd9mSC2MpsptY/b57HZprJqWhsMaSkOj9
         mp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769358344; x=1769963144;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3v57Iy+bDz50Wo3pEiRxYhkqRNwfCJZJ1CeX2JqnHG4=;
        b=DRaYJjO43ZVrJK+QWPHe2kFSzFkTCvpLlgOC26dN2xrsJLvS/UtLaizwGsaEQDvgo1
         Hqjc+3bzhiYaFDpDSY/HQRsj5jJxn6dYbBQwz+Xu6+n5P1VOlKeVr4ejgLTFRnKtoFV3
         A2uhRNcasiEzeSs+xuXvwveKBVrZg3bWyBu3PeIogjMbnWcW+NA2l5gRf8/Q6Oj7VLFg
         VfBPVZppIz3d/f3v8JPQdESJqZQEAvtACZBcu7Ol7trZQlzgaB0XUNYQUfpytUbhUYc4
         ZUbQO6jhUFWbPr1RVlcVn87aKcL/vzHNVhzvUNalPIll7VoVVE46pztKIltL9k2ltNQV
         ojpw==
X-Forwarded-Encrypted: i=1; AJvYcCWKBokZqXSXtJHDPkDdiBTOXASXyiBZMvI8mD4FFDCQ9HIButm8K5yR2DBSA9F7rFZpXqr4adU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqVa1aTB76bBkMHn/AXiAH7EU1WPz4oLEBKLD6KdU6ivLGCy7D
	wG16V0Ynyd3qghSw5EKDQ3ghHVZIklSFlUlcOqb8YTK0aPhGkl1xowj7
X-Gm-Gg: AZuq6aKMYzGAe+eTzlNeUHgsZv7QczrfUsNTFHcQCIh7nV3wxJjBywFV4OMDiRrHN+H
	pYgQFhBXIwPdB6UXnOF+Zv1I3kIijzAbh1V/F+ZGgCqhblA+ehDuPrK+ppQkk2CMAeC332Mq9q1
	6poaJZnaUXrsO3OI5TTl2Gm++EcZl3csPL5cjkK1oO8uN7lP8R2xjKwlF+7D1fDq0zMjse5PoZf
	doCxwYk7tpl2tTYTYYklytceB3JtAHOsqOYLzQna3JiMhyGo15ZNGdyi7s+tiVRhHugO0zG6WSU
	iOYRZBsU7I9x18ZVxOgxckQWSWx8dBkw707Z5ZagTsyd2BOgKiMKKPcC2BA75txxhbqlvwEk7zQ
	IRerfARZxeXI1x8ndNKwLFuswnL7thgUR6uSLyzusfYS2Bu3YEzwhbZlC3B6yxmIJ/7fwi/g2Pc
	gjB+lnf7Rr9YZNN7K/pgrj+jm2vt2QeEepBkJfEUud6gV1Ru+gVYH+6U8exAAiodsINqS3GsGBh
	H5i3zeZMSefgNy/LgVTmDDzJu2zPEZmFtCtpURTZCAa7IjWkmKgKCfKHH7aDmFjyA==
X-Received: by 2002:a05:6402:f23:b0:658:7a1:fbe7 with SMTP id 4fb4d7f45d1cf-658706ecd1amr811921a12.23.1769358343678;
        Sun, 25 Jan 2026 08:25:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b3e07cbsm3860622a12.1.2026.01.25.08.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 08:25:43 -0800 (PST)
Message-ID: <e9c7fa63-6c9b-48c2-97c9-2d73e1029f20@gmail.com>
Date: Sun, 25 Jan 2026 17:25:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 nf-next 4/4] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux.dev
References: <20251109192427.617142-1-ericwouds@gmail.com>
 <20251109192427.617142-5-ericwouds@gmail.com>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <20251109192427.617142-5-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-253188-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CE0CF816C3
X-Rspamd-Action: no action



On 11/9/25 8:24 PM, Eric Woudstra wrote:
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
> index d4d5eadaba9c..082b10e9e853 100644
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
> +		} *ph;
> +
> +		if (!pskb_may_pull(skb, PPPOE_SES_HLEN)) {
> +			*proto = 0;
> +			return -1;
> +		}
> +		ph = (struct ppp_hdr *)(skb->data);
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
> +		struct vlan_hdr *vhdr;
> +
> +		if (!pskb_may_pull(skb, VLAN_HLEN)) {
> +			*proto = 0;
> +			return -1;
> +		}
> +		vhdr = (struct vlan_hdr *)(skb->data);
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

I've also tried asking on the cover letter 0/4, but no response.

Can I ask what is the status of this patchset? Quite some time has
passed by now...


