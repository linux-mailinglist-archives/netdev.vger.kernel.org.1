Return-Path: <netdev+bounces-235582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F5C32BF2
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 20:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C3FF4E6987
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4537262B;
	Tue,  4 Nov 2025 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tted8uOH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D4C2FB
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283758; cv=none; b=lvwOtBkVtIt0ScLcUAwAU45na0DrhRf/GBN4zUkJ+/the0+bEqeNZ8afd9i738ZEWoBPuM9LmusshlHCVOF2cxWpmUVkYY8ddi915PD19BAQ77nww0zEEkp/TbuqBOO0HGNyo0sR4zRbGRprQN3Mbgq+admcpuA76UGhNEft56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283758; c=relaxed/simple;
	bh=7S8+vO3ASy53c9/QMBRYjqmZUqwJy9+RRobBAyVghQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3gyHydg7SFF8fctcgwFKUqvYheM/krkSUjCLJ/AoM50wbcyNlrq/KAngT7D9ZssHgjZ8Ex3E4XEwCt+YiOOtJO8Ue0OQ4KGHcAQ3yjDZmeOpamPfqD97XCrkOed7DdWEmHgBjX6kgfEr6r+tO9crSPFq280P+yX7IT+Loxx9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tted8uOH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b5e19810703so795224866b.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 11:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762283755; x=1762888555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QMyfynSbIJu4PvSuals8RhlA+Y6TdmVDUTrRaQq4u0=;
        b=Tted8uOHUyq8Y3gfRjdnFf8UCc9v3+0jHMdlUyTqyvldEB081s3sJAD52jD9wepwOY
         ROP/gJfXC2DduCpLJGI5NvUKt+29w9699rlhPHF4vch7k7ccQcgT35+RBppqaQWWlqup
         03J2mSgLNgJ7J/qypBh8cIza4yZkowpjG/Rj+3t9lPkqaZCPmbKvVnemIlirJ5KDUMMl
         X2bLr/YH1QKErqEp8L3kSOOawCAjuwFp4nXi/n0h+dXnRm6jq3d6SEoVyZ3rxEEBFZXL
         21VqdgSs77qylaIFwQOElpoYrPcMUl/qf5m0dym8biyBQl7sOBcL6AhMRsVGArVX+e/a
         nKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762283755; x=1762888555;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QMyfynSbIJu4PvSuals8RhlA+Y6TdmVDUTrRaQq4u0=;
        b=PBzyVqn0709M/HAW9NJ6RLwt676j3bRUtP7R9mmHJ1+L/PGSNRX/bvVVJYZJUGWhvQ
         yUf4dhvmZI5qp7HlBFCNG8pCnV1OoiKIj0QJadkt4V49qXz+ZqvisMOYgbvswOq/QX8x
         nIclVfuQg/Qdv4NsJzPj5Uq8lbxpulrrb3rI1U1zdBQgWBqdDQoS+e0AlFfIulUnoVDF
         Cpv5xyd2PBJxBGUcUDhFBb07K29b5Gp8n7Rub3S6Yn9BrJksLabarp/SBOY/dirRWv09
         60wSzZOgu9AG3jNl3k3RJ8iaHQCTXvY+aBSUBlNN2R0oJyhQl9qicyqzu/8Tf+rqLN3O
         K+uw==
X-Forwarded-Encrypted: i=1; AJvYcCVQJzXQ2t6GhLbD9n3dXmbVCFKXfYmPcgpFpMNQ8PhPpAdyU2TPPSgG7BWFFbUa1vLOkyLErVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz6n640Da+WNltQixv5eah/lNQ8aHBCtyzYYb5lOqlKp7CS4Jh
	F/+jh0apAOlRq4hXb/rtJN0d1JbxOJPNHRItmhn4FvAUZposnH3fpKVJTtx3gA==
X-Gm-Gg: ASbGncs3LgD55Gxy9ROUh6QYzQD3pPCZSq8f6UheoQArcXP8zGxXsy+SPSVvFij2k2p
	PlN0W1WhvoEcsp2Wbargwwe7vnaV1rFqG73XnYtftU99jWckZ3A25Bya2+g9oyXiDl5frRdA6dk
	ph3TFarv4e1qiAUetqKy371XGu/XCqSl+ViYeTcXfKdh5M4BJ1sPIFMKK7eO5sNBdO7MkBzPN/Z
	jA/UyVL93rsMRuDAPWMXDIq/4h7MPG+S5hXBeXTMugdbU0r/P5W/ZHvnDoipvdmJK1OQxojzEnJ
	d0v51GZpevwxvY+SAdvj6YMNiuigUfN/OOqg3kurAUQpFEFW9hIb5N6JHId1q7dLz9ZBN3iWk0R
	KKKTby1rtIXcjk1FakkGepYAzrHHS9kQWSFFwMOhwTc8TGYMWq/0O9CZ6wSuCkPdBnFrVdIOwzw
	L+cPx0fc6AQvNbC/bTNX71c441am06ltmv3iqW29Z8eMhS/ZQTxVzYWrV31Vn8BshGz6Ya7HbH2
	Pr79TGrxrvoCVL31DQcUptOWwDIItPZ1hEwt9l6XskKhm5LTpBWEQ==
X-Google-Smtp-Source: AGHT+IGKnATGAMZLZ7BfrzK+rb/mjrrF2BjsXgKd9+vxecCJZWw7vzWEChRRFBgO1QfKEyIV7kI6LA==
X-Received: by 2002:a17:907:6d0c:b0:b3f:5049:9e81 with SMTP id a640c23a62f3a-b726554c6fbmr23752866b.47.1762283754795;
        Tue, 04 Nov 2025 11:15:54 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a336asm290222766b.7.2025.11.04.11.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 11:15:54 -0800 (PST)
Message-ID: <114f0b33-2c5f-4ae8-8ed8-e8bc7ef3dd2c@gmail.com>
Date: Tue, 4 Nov 2025 20:15:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 nf-next 3/3] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter <phil@nwl.cc>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20251104145728.517197-1-ericwouds@gmail.com>
 <20251104145728.517197-4-ericwouds@gmail.com> <aQohjDYORamn7Gya@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aQohjDYORamn7Gya@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 4:53 PM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> +	switch (*proto) {
>> +	case htons(ETH_P_PPP_SES): {
>> +		struct ppp_hdr {
>> +			struct pppoe_hdr hdr;
>> +			__be16 proto;
>> +		} *ph;
>> +
>> +		if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
>> +			return -1;
>> +		ph = (struct ppp_hdr *)(skb->data);
>> +		switch (ph->proto) {
>> +		case htons(PPP_IP):
>> +			*proto = htons(ETH_P_IP);
>> +			skb_set_network_header(skb, PPPOE_SES_HLEN);
>> +			return PPPOE_SES_HLEN;
>> +		case htons(PPP_IPV6):
>> +			*proto = htons(ETH_P_IPV6);
>> +			skb_set_network_header(skb, PPPOE_SES_HLEN);
>> +			return PPPOE_SES_HLEN;
>> +		}
>> +		break;
>> +	}
>> +	case htons(ETH_P_8021Q): {
>> +		struct vlan_hdr *vhdr;
>> +
>> +		if (!pskb_may_pull(skb, VLAN_HLEN))
>> +			return -1;
>> +		vhdr = (struct vlan_hdr *)(skb->data);
>> +		*proto = vhdr->h_vlan_encapsulated_proto;
>> +		skb_set_network_header(skb, VLAN_HLEN);
>> +		return VLAN_HLEN;
>> +	}
>> +	}
>> +	return 0;
>> +}
>> +
>>  static unsigned int
>>  nft_do_chain_bridge(void *priv,
>>  		    struct sk_buff *skb,
>>  		    const struct nf_hook_state *state)
>>  {
>>  	struct nft_pktinfo pkt;
>> +	__be16 proto;
>> +	int offset;
>>  
>> -	nft_set_pktinfo(&pkt, skb, state);
>> +	proto = eth_hdr(skb)->h_proto;
>>  
>> -	switch (eth_hdr(skb)->h_proto) {
>> +	offset = nft_set_bridge_pktinfo(&pkt, skb, state, &proto);
>> +	if (offset < 0)
>> +		return NF_ACCEPT;
> 
> 
> Hmm.  I'm not sure, I think this should either drop them right away
> OR pass them to do_chain without any changes (i.e. retain existing
> behavior and have this be same as nft_set_pktinfo_unspec()).
> 
> but please wait until resend.
> 
> I hope to finish a larger set i've been working on by tomorrow.
> Then I can give this a more thorough review (and also make a summary +
> suggestion wrt. the bridge match semantics wrt.  vlan + pppoe etc.
> 
> My hunch is that your approach is pretty much the way to go
> but I need to complete related homework to make sure I did not
> miss/forget anything.

I understand. I've send this, because from v5 to v15 it moved towards
matching in the rule, but it all started with the fact that
nft_flow_offload_eval() uses nft_thoff().

At a bare minimum I need to address having pkt->thoff set correctly to
implement the software bridge-fastpath.

The fact that it also makes possible to match L3/L4 data in the rule is
also nice to have.

Hopefully you can take this in consideration during your review.


