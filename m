Return-Path: <netdev+bounces-287487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLhIDyVFBGp0GQIAu9opvQ
	(envelope-from <netdev+bounces-287487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:32:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB29530ABF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66D0C30884CA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625633B7B9E;
	Wed, 13 May 2026 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EJ/2Wnh0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C983672BE
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663411; cv=none; b=KGqNU+o7rBpezl4zrVBzg/Keo1a7x5Dn8B19ZdRFfuMpxbRHh+Rg4skt0+eQWy3cq5ovv0QdOrCwNl9W8WeHByUpiJ+ZsaOKM51ICRKbBNAy8cQNMTOpTMuIL2lnREm5HT19cT2J9McwsTy4iR2jJClmEOPUDqFElHczG+J/gSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663411; c=relaxed/simple;
	bh=BKxvFzfdM5EClemNoRL6TkadDCxmz+WCDUzMM9K+Iek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hb0naqIJeBDTLBJqMXjpyX9I0tPsqCxeJb/xXZPqo873a7abvYBWxnP5FL4cY+OZLuzNeo/uI3EYM+kTmeNDeLuwhJ3uu0bXza/8u6hKc8bvlUnnUv5Sui0JRMjiQ5J8bh36D/zqVN+1Kv5FEcBfuzYYAjh2On6QOOHgRIZHIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EJ/2Wnh0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48909558b3aso64993995e9.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 02:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778663407; x=1779268207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XNqs2XkZ0/CMwZDZ1F5etal84fbT2oKNdMLbI7FAEa4=;
        b=EJ/2Wnh0fYjFecKLZJEU9aWRXeoVmeZZJ7nnHQbkQFQPOiDBjOiz+eD5C4jW7ED2OH
         akm9gvGUv4F0H6Yj8sLxLm1qztmxSGB72kKkhX9ftFCe8cLqe3KxgPkzO/CNdp5Haouu
         MI2GSnYGGMtEJ8tCMXd8y5le9GLmeCp00oF1MtqPCauvpBkqpQv/FMFcAvYFpMLhVeDt
         d7Hn7QGtj5NRVqnR3lxZUkq8Ko0w/X05zL9M/5mYUnUSAplT8JANl84C29jS8wOqtF49
         emc07l6NNRp+I55mZD4xd7GUhlWZcJXTPyrCbU4ZD9PhGRXv4pQ6IL4Y5YDF3f9w7MX6
         99Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663407; x=1779268207;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNqs2XkZ0/CMwZDZ1F5etal84fbT2oKNdMLbI7FAEa4=;
        b=FDNtSwXA0K1ObZg3l4r6SluDREHf8L+sAWgANQcNBzg3HPTICHUyqkSvpTRPYHTbz6
         cJ8E3j/flcNdBGuBYUv59XuMOjCb2LJ5S0/7QuakiHgW21pFb0q4BIDXNpkElAGpB08K
         s/vsKr5Lgrp90rV2tiOnQvIcg+UmL5VSE345l0FyZY6VQ8jwaqyK+k3yISoUoWPjn6FP
         COrQfUi2UBcXZyx/NYnc1BRcurdEaOjemo1WLuJxIkMl0NP8zjGNVebpeKGD/FFxvloj
         L+UOmJcZgAfM3BW6KZWCNiukGxLpVEEg86XU1QsHEutZSU9kn3hNob5itciRdwnnSuWv
         OvuQ==
X-Gm-Message-State: AOJu0YyrD0QyvywlwGcfUxAiIa9O30s8cWiPMY6aJBPeLuToZxi87fA7
	PUUXyNqMFF+rBTRzzj94HGv8UoaeZ+9j9dl23usnEoPdBthQWqGeG7ERI0llTfvgfh/xbQ3GeTC
	cwB45YCrmijaxiwRqFBAflumFs5w7oHanTPYJ+EtjvQNHZwdNh5E=
X-Gm-Gg: Acq92OFmrEZFxRNsvHDOe4fJMVEvmdYgiGfP0CK34mKtVkDj/LnUsI5nHT3G1pAXTsv
	nkS+sZ0cCepcimpucd9vhuyAgfvIAmCX0Zz580VepYMtyhzFIqCNV9gatfSKepN+r9F5CZqeQM6
	ZaL7jUGxHT7Npp2WBxZiigPaFQ6RXSptGDRxVRsfi4zXehby/B2hfExQAK3TP2hqfBZ4ZflOOPo
	7q9dsAtmcqUczxGemHtyKoq+ovg08L9Ma7w1mqXtQrt0V7H7RnOFxEI4NWFX2Y3kXCydxUGmm8u
	SLoqBoUJ7BlUNTTyjYaBl72EPfEWM34DxYh7IafVjF6MaNuzvgQDozNIrcSXVw8hAQa6j8MYjN1
	JNabbgmG+nd2zNifI6k+bvRaeK8GfiNf+eyvSiY2voBuiR6F5hBSFGR2G21+3nrxFEBjBRmj8zF
	v6Xuqh7neHA/0TbqxS7QKxmDG1dGJk2YiZu9GpdggHIsUzA55vCx6ywMWzumzsQQ==
X-Received: by 2002:a05:600c:8705:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-48fce9c731dmr27136025e9.9.1778663407264;
        Wed, 13 May 2026 02:10:07 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:1f37:1bce:f581:7f7f? ([2001:67c:2fbc:1:1f37:1bce:f581:7f7f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce38e42fsm37353985e9.15.2026.05.13.02.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 02:10:06 -0700 (PDT)
Message-ID: <098951a4-8c7b-408f-b5ad-207452e9df1b@openvpn.net>
Date: Wed, 13 May 2026 11:10:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] ovpn: respect peer refcount in CMD_NEW_PEER error
 path
To: Sabrina Dubroca <sd@queasysnail.net>, David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20260512042036.19870-1-devnexen@gmail.com>
 <20260512042036.19870-3-devnexen@gmail.com> <agNDqz_4aUnwkusN@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <agNDqz_4aUnwkusN@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4DB29530ABF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[queasysnail.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-287487-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On 12/05/2026 17:13, Sabrina Dubroca wrote:
> 2026-05-12, 05:19:13 +0100, David Carlier wrote:
>> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
>> index 291e2e5bb450..4c66c1ec497e 100644
>> --- a/drivers/net/ovpn/netlink.c
>> +++ b/drivers/net/ovpn/netlink.c
>> @@ -462,10 +462,12 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>>   sock_release:
>>   	ovpn_socket_release(peer);
>>   peer_release:
>> -	/* release right away because peer was not yet hashed, thus it is not
>> -	 * used in any context
>> +	/* For UDP, the peer is unreachable until added to the hashtables, so
>> +	 * dropping the initial reference is enough. For TCP, the peer may be
>> +	 * concurrently reachable via sk_user_data->peer until
>> +	 * ovpn_socket_release() detaches; rely on the refcount.
>>   	 */
>> -	ovpn_peer_release(peer);
>> +	ovpn_peer_put(peer);
>>   
>>   	return ret;
>>   }
> 
> nit: after this change, ovpn_peer_release() is only used within
> peer.c, and can become static.
> 
> I think it'd be nicer to do that now with a v2, but if Antonio wants
> to pick this patch up directly, the fix LGTM:
> 
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> 

I think it makes sense to make it static now.

@David: how about sending v2 with this change included?

Thanks a lot!
Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


