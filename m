Return-Path: <netdev+bounces-254886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHBvEWOje2kVHgIAu9opvQ
	(envelope-from <netdev+bounces-254886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:13:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E39D3B3713
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C3FA301464D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FBD3446C5;
	Thu, 29 Jan 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8Qfkgu/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B10919F40B
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710409; cv=none; b=YDFE0HgmqyYf2jOqUWNJFeuvS8St1vhf5k8RR3Z2EpH2r3qmFY9ENnzB+Ua0NeZQVCM8mt+ZdzgkFqA70IWjYbmuUUVWKrfnyV/+moxBI5S/v2kCQ01YS7zxNSLH703HFIefRS22M5j9rnmPA0RO5V7ReWNR4Cu8kZHv7xR7i8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710409; c=relaxed/simple;
	bh=Uv5WZMcU42sQxpjJG8wdnYQ2lhgUufULsYE1nP7I1m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e18IYOzNPXbhg/Oozbdr3ZWUPpJiYzlKc6ApSTlSxi3mimSrXyU/SBKT29VCVjwH/vP54Uk94w2JWllZwEc7EDX1Fr/1hARrkY2JPjw0E+uyEf7NMFF0omyKak8vDv8Nfjdpove7ycG7DbxZnYg03s0Bw/kq/YMn9st/LY/gEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8Qfkgu/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4327790c4e9so814502f8f.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769710406; x=1770315206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nlCyxHSNnwuwcAWe3w3p+ljfIeMBEuInyL0DKq9zkyY=;
        b=T8Qfkgu/FXXEX30gKJJfUfcivl6eEaLhIrhkA0VIcJOxaRESKcmMCRUZhwU/t0wYvu
         jPCm2wVpwIU/ySMndEgrOdNDMNHM0TDPCXESzi0CQF3AgPdkYrngrCvbNnop39S2Jyzx
         N1KhkzSy9A7D0yVx31ienM4BCCBE3MVyz+dpdh7Zxkoa3sL7DrjrcKQ7+vSfCgw4QXQb
         Dqah2ruNPi2SkrkIrO4B9VL8NrQFTUuT/coFkwTPVedDj5lIfIPATeR47hmMBcJgVtXQ
         2h1N0FxKWhFmAoTE7vQ5UFhCbDJ2rb0kzw+VO09HTXxSCzb9QXboZ485mYhZfP4BrYi2
         VgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769710406; x=1770315206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlCyxHSNnwuwcAWe3w3p+ljfIeMBEuInyL0DKq9zkyY=;
        b=lAXfNtrr4+QY6xhSrvEdtEdzUF86oguqAwW5OgOUl9PJT5a5vGHcLbUrkYHpVM+wwR
         ZkllHLaE3vyXcFtOe3IQyx8BaFKE/7ZzPiYTn//dFHZ8kUjE8gciB44vn8bUeVXvulbS
         23KpWs0hmRWs9Wut3fMDABADzyQPvvtfNKp32GoBKRoLTk1iQF3M/Y6LZPjb59unPHD+
         wueKR4ALqF5TYdGuu0crsE4rVDROwWf+jZpb7y6UCYHbQoKZQmEWZUxfPdfdbqOYQ1xe
         X9970skK+64jBKaflzeqsowfSPTUE+976KzAzmQy2iuwczCaTgZkhEAN9YyimaWnCiwE
         Athw==
X-Forwarded-Encrypted: i=1; AJvYcCXeA39MDaL0HcTE3wju6l22zRjsdbXx5UJyIKb5ZA2N2I/r5NkP76jsLhcLzbVlb/l5sqCmOL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhwC5fqQ3apyPuddmkWQwN1HjELipkVDnHV7nAuCpqVU2A1Nq
	yoTH0KmJXzBnzfsHIx8V5dkkF4oykaVbOuS7cuKrMZ7Y1IDsOnm/rvN6
X-Gm-Gg: AZuq6aKtjN6Jc7kmCXMGr8qoByS+Ss3Xuui8D9Q6ry9eltDhqZugx1IHArRA6FQ57aW
	y9q3vJyHdHraHOD5W1qGcN959Q31o3YzxMNdqMJFAFcLMQiijAjiLqd6r0ieLoi4x8OXx3Wpt4f
	GenYw9+8I8qC356HMGhzlnwIOqA8FgcriU91FoNmAUskm89wuX0lZACh5CREq03gBNgBHRP5ZpJ
	kg316Uq9EBhFZZwMWk/E9sBdHCPxXQBfXLg2YTBycSPZxe0reclwZfwuT/SdvnsUCgve+zXExdg
	Zx6MhZAmdWu1O6yR0pRYPKmiyUwkq+NC1bu7utIrLjh4UBkmUFbBu6jKP0fVH+17T2PBioA5Huu
	19qswDgSoMacsbnvf/W3F0npgzKAKME8xO+FyfjJV29CHGo22RDl27Rn0nU/3LGlFY/328ms0aq
	3hycBixUA5EzysgT+QTyHyr/r7FB8IGf3ZwBRV1sjg3UUNyYmK0tlrSV0tZwbEiyJfm96XEMHH7
	jTH
X-Received: by 2002:a05:6000:4308:b0:435:a370:2d71 with SMTP id ffacd0b85a97d-435f3aaa9b8mr745250f8f.33.1769710406259;
        Thu, 29 Jan 2026 10:13:26 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:8ea7:1ca8:fcdb:48b3? ([2a02:a03f:a75e:9a00:8ea7:1ca8:fcdb:48b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4762sm15777055f8f.6.2026.01.29.10.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 10:13:26 -0800 (PST)
Message-ID: <60fb02d8-77ca-457b-be24-33a3cc7b344b@gmail.com>
Date: Thu, 29 Jan 2026 19:13:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/7] ipv6: Cleanup IPv6 TLV definitions
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-3-tom@herbertland.com>
 <willemdebruijn.kernel.235a1f46c52f8@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <willemdebruijn.kernel.235a1f46c52f8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254886-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,herbertland.com,davemloft.net,kernel.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,herbertland.com:email]
X-Rspamd-Queue-Id: E39D3B3713
X-Rspamd-Action: no action

On 1/29/26 06:30, Willem de Bruijn wrote:
> Tom Herbert wrote:
>> Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the rest
>> of the TLV definitions. Label each of the TLV definitions as to whether
>> they are a Hop-by-Hop option, Destination option, or both.
>>
>> Signed-off-by: Tom Herbert <tom@herbertland.com>
>> ---
>>   include/uapi/linux/in6.h        | 21 ++++++++++++++-------
>>   include/uapi/linux/ip6_tunnel.h |  1 -
>>   2 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
>> index 5a47339ef7d7..438283dc5fde 100644
>> --- a/include/uapi/linux/in6.h
>> +++ b/include/uapi/linux/in6.h
>> @@ -140,14 +140,21 @@ struct in6_flowlabel_req {
>>   
>>   /*
>>    *	IPv6 TLV options.
>> + *
>> + *	Hop-by-Hop and Destination options share the same number space.
>> + *	For each option below whether it is a Hop-by-Hop option or
>> + *	a Destination option is indicated by HBH or DestOpt.
>>    */
>> -#define IPV6_TLV_PAD1		0
>> -#define IPV6_TLV_PADN		1
>> -#define IPV6_TLV_ROUTERALERT	5
>> -#define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
>> -#define IPV6_TLV_IOAM		49	/* RFC 9486 */
>> -#define IPV6_TLV_JUMBO		194
>> -#define IPV6_TLV_HAO		201	/* home address option */
>> +#define IPV6_TLV_PAD1		0	/* HBH or DestOpt */
>> +#define IPV6_TLV_PADN		1	/* HBH or DestOpt */
>> +#define IPV6_TLV_TNL_ENCAP_LIMIT 4	/* RFC 2473, DestOpt */
>> +#define IPV6_TLV_ROUTERALERT	5	/* HBH */
>> +#define IPV6_TLV_CALIPSO	7	/* RFC 5570, HBH */
>> +#define IPV6_TLV_IOAM		49	/* RFC 9486, HBH or Destopt
>> +					 * IOAM sent and rcvd as HBH
> 
> Explicit labeling with HBH or Destopt is quite informative.
> 
> Does this mean that IPV6_TLV_IOAM should also be accepted in ip6_parse_tlv
> in the Destopt branch? RFC 9486 indeed did reserve a number.

Nope, not right now. The only IOAM option currently implemented in the 
kernel is the Pre-allocated Trace, which uses a Hop-by-Hop option. It 
wouldn't make sense to have it in a Destination option, although you 
could (i.e., it's not forbidden, just weird). Actually, the only IOAM 
option that would make sense to carry in a Destination Option is the 
Edge-to-Edge (E2E), but it's not implemented in the kernel. Should it be 
implemented at some point, then yes, you'd have IPV6_TLV_IOAM in the 
Destopt branch as well.

>> +					 */
>> +#define IPV6_TLV_JUMBO		194	/* HBH */
>> +#define IPV6_TLV_HAO		201	/* home address option, DestOpt */
>>   
>>   /*
>>    *	IPV6 socket options
>> diff --git a/include/uapi/linux/ip6_tunnel.h b/include/uapi/linux/ip6_tunnel.h
>> index 85182a839d42..35af4d9c35fb 100644
>> --- a/include/uapi/linux/ip6_tunnel.h
>> +++ b/include/uapi/linux/ip6_tunnel.h
>> @@ -6,7 +6,6 @@
>>   #include <linux/if.h>		/* For IFNAMSIZ. */
>>   #include <linux/in6.h>		/* For struct in6_addr. */
>>   
>> -#define IPV6_TLV_TNL_ENCAP_LIMIT 4
>>   #define IPV6_DEFAULT_TNL_ENCAP_LIMIT 4
>>   
>>   /* don't add encapsulation limit if one isn't present in inner packet */
>> -- 
>> 2.43.0
>>
> 
> 


