Return-Path: <netdev+bounces-166973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980BFA383A6
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC74F3B5BB7
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C1121C173;
	Mon, 17 Feb 2025 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="RaLMBegg"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626B21B8FE;
	Mon, 17 Feb 2025 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797154; cv=none; b=MGGeBWFkIGCiZYMsB1WWm0BkVjxBQmKSqJI1+kuVI2McJvwcjg8K1AhffjWj8FGCAbaPuduNa6eq/ft6zVSfWTF1MtkreMaj33fj3GESYRlrStmKdnKYpVeBC/E8TKmyA/09FNX732zD+plYlBodKPBV14yGBL08a9Q729RWZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797154; c=relaxed/simple;
	bh=i+N2nth154zGkAult6jW7Vlqawpmm2vMrGQqF2gKW00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBNAL9+WrWWrzd66/k14dLgJl1R/yb0UZAjGTsnHAJrj4rSdMDsSDT7AUBDWaKGucphZpgYz9X51iGFgNeJXCSEyoaQ/IG2mlKUcgsUnAuZIq0BJaNbHqXsK5etVxNLkSJEpPP3/fRlvCDulvTgkrk5JFc1grTtRyQpnS8t0SKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=RaLMBegg; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=crn1rBRCBq9NeaYIfa5zc62UtYSOR+W5jBXVKOJnYzE=; b=RaLMBegg3btEsFm0frqsfkJNTd
	x+sEC64wp6y8JWfSatJP8P3Gs0B839+YWcpFlgDxJu7Vs/+XkZszFggc+cOaOeu7wB2kS7X9xT6La
	1hGQNQJXvd/5eOEMFBuK8bfqFvwl38d4Lur3Lqx7/FDWt5uL3cUj/Z3XvgoS7Crhqzqo=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tk0hx-006HRj-0H;
	Mon, 17 Feb 2025 13:58:45 +0100
Message-ID: <7932cd23-571e-4646-b5dd-467ec8106695@nbd.name>
Date: Mon, 17 Feb 2025 13:58:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: locally receive all multicast packets if
 IFF_ALLMULTI is set
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250217112621.66916-1-nbd@nbd.name>
 <37bf04ee-954e-461f-9e37-210a8c5a790a@blackwall.org>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <37bf04ee-954e-461f-9e37-210a8c5a790a@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.25 12:54, Nikolay Aleksandrov wrote:
> On 2/17/25 13:26, Felix Fietkau wrote:
>> If multicast snooping is enabled, multicast packets may not always end up on
>> the local bridge interface, if the host is not a member of the multicast
>> group. Similar to how IFF_PROMISC allows all packets to be received locally,
>> let IFF_ALLMULTI allow all multicast packets to be received.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/bridge/br_input.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>> index 232133a0fd21..7fa2da6985b5 100644
>> --- a/net/bridge/br_input.c
>> +++ b/net/bridge/br_input.c
>> @@ -155,6 +155,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>>  			pkt_type = BR_PKT_MULTICAST;
>>  			if (br_multicast_rcv(&brmctx, &pmctx, vlan, skb, vid))
>>  				goto drop;
>> +			if (br->dev->flags & IFF_ALLMULTI)
>> +				local_rcv = true;
>>  		}
>>  	}
>>  
> 
> This doesn't look like a bug fix, IMO it should be for net-next.
> 
> Also you might miss a mcast stat increase, see the multicast code
> below, the only case that this would cover is the missing "else"
> branch of:
>                         if ((mdst && mdst->host_joined) ||
>                              br_multicast_is_router(brmctx, skb)) {
>                                  local_rcv = true;
>                                  DEV_STATS_INC(br->dev, multicast);
>                          }
> 
> So I'd suggest to augment the condition and include this ALLMULTI check there,
> maybe with a comment to mention that all other cases are covered by the current
> code so people are not surprised.
Will do, thanks.

> By the way what is the motivation for supporting this flag? I mean you can
> make the bridge mcast router and it will receive all mcast anyway.

OpenWrt uses a user space daemon for DHCPv6/RA/NDP handling, and in 
relay mode it sets the ALLMULTI flag in order to receive all relevant 
queries on the network.
This works for normal network interfaces and non-snooping bridges, but 
not snooping bridges (unless, as you pointed out, multicast routing is 
enabled).

- Felix

