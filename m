Return-Path: <netdev+bounces-205766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C7EB0012B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 14:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B29337BC241
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D535525DB0B;
	Thu, 10 Jul 2025 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="B9ckkfqu"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B724DD1B;
	Thu, 10 Jul 2025 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148730; cv=none; b=VlQcMGAbQiCH9hZ/9rFcqB/pl4jECWQuL+QA4+xOdjGrjsky36wUzjp5rjB5EKY6D4dlJi7qafeGluLMexscPJJ7B6OLPyJYMwARJc2a5991dzWwZa3YM4TBrmsyb3hY5znTJv99/hho/nfePXfpqxE4FoL/ha1ak4ZMCiDS4ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148730; c=relaxed/simple;
	bh=yakUu7ROJDjmYInAaHAqTylMcI531SLw3tDlYIMQSLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3gFv3HjvG2UAAZv99gCOJPeCVrmMHu9ajtwY+/N1bLFC6pYQqLKyy404cyPibOhYka/yXmi+gk2JhBY7sW48EDWWGeVYoT13Vkio7dd+mltWzI1Mb6dc1DMKHkMSTJp+5VGi6a0PxdmfFPG5TxqzbZY8ulQrPJD7YmS8yvm6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=B9ckkfqu; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qQO+FIiG3OlYKVVQ1uLHtRsQ+tG8butzxgIJKXarsws=; b=B9ckkfqufQdlvMLeeaL0HjJi90
	soREwPKUvktJ2J8Yt2Euub1EbATjbabjVNL4bi2iZU/ZqfKE98TuMYllFJK/ycMgG4RJZUlPdaixn
	Ik9lpfQs2M7KtyV3Jo59KNBPZqb+tCSstH0ncCSlzqoarnLJU2m6MLYJ+kKIL9Qo5St4=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uZpv7-009Whk-0N;
	Thu, 10 Jul 2025 13:58:33 +0200
Message-ID: <5a787632-97cb-479e-897c-6e9034d9dfde@nbd.name>
Date: Thu, 10 Jul 2025 13:58:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix segmentation after TCP/UDP fraglist GRO
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: linux-kernel@vger.kernel.org
References: <20250705150622.10699-1-nbd@nbd.name>
 <615bc4d6-3b10-bd7d-dbfe-2b79072af44e@gmail.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
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
In-Reply-To: <615bc4d6-3b10-bd7d-dbfe-2b79072af44e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.25 13:37, Richard Gobert wrote:
> Felix Fietkau wrote:
>> Since "net: gro: use cb instead of skb->network_header", the skb network
>> header is no longer set in the GRO path.
>> This breaks fraglist segmentation, which relies on ip_hdr()/tcp_hdr()
>> to check for address/port changes.
>> Fix this regression by selectively setting the network header for merged
>> segment skbs.
>> 
>> Fixes: 186b1ea73ad8 ("net: gro: use cb instead of skb->network_header")
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/ipv4/tcp_offload.c | 1 +
>>  net/ipv4/udp_offload.c | 1 +
>>  2 files changed, 2 insertions(+)
>> 
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index d293087b426d..be5c2294610e 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -359,6 +359,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
>>  		flush |= skb->ip_summed != p->ip_summed;
>>  		flush |= skb->csum_level != p->csum_level;
>>  		flush |= NAPI_GRO_CB(p)->count >= 64;
>> +		skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
>>  
>>  		if (flush || skb_gro_receive_list(p, skb))
>>  			mss = 1;
>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>> index 85b5aa82d7d7..e0a6bfa95118 100644
>> --- a/net/ipv4/udp_offload.c
>> +++ b/net/ipv4/udp_offload.c
>> @@ -767,6 +767,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
>>  					NAPI_GRO_CB(skb)->flush = 1;
>>  					return NULL;
>>  				}
>> +				skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
>>  				ret = skb_gro_receive_list(p, skb);
>>  			} else {
>>  				skb_gro_postpull_rcsum(skb, uh,
> 
> Were you able to reproduce this regression? If so, can you share how?

This was reported by several OpenWrt users after upgrading from Linux 
6.6 to 6.12. OpenWrt enables fraglist GRO by default. From the reports, 
the issues appeared when bridging packets through a VLAN filtering 
bridge from DSA ports to a WLAN device.

- Felix

