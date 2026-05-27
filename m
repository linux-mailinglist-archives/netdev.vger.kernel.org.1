Return-Path: <netdev+bounces-292430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOZgNtxCF2ov/AcAu9opvQ
	(envelope-from <netdev+bounces-292430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:15:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB405E96D5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BEA6300C5B1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036BA360EED;
	Wed, 27 May 2026 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvqT/hXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B5311C07
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909337; cv=none; b=BnlqxwB1UvR2EehzOSfvbYguFH9BWNWiG1+mCnyP6FD7DYYJeEo/n1Oo9T9OS9+HQmvGqOdhcIGjrXjyO2XWXxtRfzDEf1qgJyFKN/ueOyjcKzsdWrDwiEmzYyMpOCq891X2lcwF2Ct6L4T49oB47vfSGygvl3I+SBKi8wVJuDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909337; c=relaxed/simple;
	bh=QoBfDnGdRYiVGEF3NG4YwnnlRAN5LaUvvETr1YE2vec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vpgrr4kjkZr9kSndCu7OAPMepoaYTD0jQReq7IxlPDwH2gLiXom8y1HP/8c9IE8328jZkd8FbUVv97ITxyFEs9PQo4twfZ7s9sz4JjkW1pyOLNaTALHdikMD19ycbzXPL74jsCWEdITt9iscOxYO3nK0VgefKD27jAQ+pgZMNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvqT/hXI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so22208295a12.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779909335; x=1780514135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrrLwN7IIEdEkDKpk+7mEdj1yluLYP0wUyVCm7yOfvo=;
        b=kvqT/hXIYmbuYm5uzKDqFHdM97gIp3iXWj4RCZFYF2lDzhOonAJsHB/hCio1/2IVFm
         NQmU9vEG5w21DWJjf5uZ/sfxDrFq5eRkC2Z9xCTSd5bDxPSpbvRl1NsRLFnaYdst2Wic
         DQ7SGa2XOvAjHq8a48epdyyck6lsKo/h1A+pKQOASs/DtMhUjeebEDGiy9QL3waG1kYk
         YuMJU8dPvFzMN8tgUWEQunMvKgYyK0Ye9ShByMfpdH9qZ5f08cC0OAlvynWcD0GyAleO
         gMyCoIB1x6Kr/i+Cfm0rxlyT9towUhBrYTDZZr8jTlYjl0lKaJG4vHKYJzFcj/70yIjX
         8m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909335; x=1780514135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrrLwN7IIEdEkDKpk+7mEdj1yluLYP0wUyVCm7yOfvo=;
        b=WfCx3bLF7qT2shaeOYrljqNQ2BzSK1NRb/UU6QVWFGGrC4CuBj7eFJNgLi4SMas6gr
         dU01CAYC02sR20M5leV+eCctqnDw3ouAalY2knvIH9cepW9/ieTvg2WE8JhNnURikZl/
         8mC0VMQJGNaeaQ7oP3C3UrfITD43kLOiucYNncQAmtOD4XhpNmVKLT50bRPYlGTJuCDW
         Z2W386Wj5xJAlLr8yMJ7Zi4G9AErpLTdJxut50Sj5hrcKqigrYOlgUMo7y+WMWfW9OZD
         Az2eYV1UMPTTOn2gqGrPWknN1QI80hk58LzU4IXhDZTqzwQtNCRBkoE/i9xkV7x/FjUl
         BARw==
X-Forwarded-Encrypted: i=1; AFNElJ8u7n4EF6C/W4kpoy4D4ofdZ6xRMyzLjfZ5QM/4mEcSxRCgqONDW8P4G+ol811zmnuxxjI8A7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAVrFfqUERMouIGetRcOGZ1woDBvnQVbV66z5i4eKCGrofFFw
	f8Q335Nu5z4+n+hSXhJ7MWv47U/l5fcmJhSlm1W8WH5AwF+l1kloh+Jl
X-Gm-Gg: Acq92OFB+N9UkGfI6KrgnVdp/FsR35MTj+3HlvXZ7gfHE20Yi4pXqz9aMrdm7VAGabU
	D9fEhwsDUZk+Xt+zI6YgKNzbPiFbuocOTAv1Zwu+PI3FT2JgH5pY4gKA5VtuHGwCgJQWN0ta5VR
	o11dJcu7rqF6hBXDNff/f4GkD9jElfvDvoiCJmllfSddSX7Ugyy66lo8cso6SkG6IdISIePCzot
	pQdPYZsJwD6rlsNr1Hmx1A1kjPow4mOhnP+7+KdZ7ulPT5WJ5kruAt4in6KfWL+y94z085zQRl3
	GadPe8hoSiV/rV5golhQfsbF72H9r+/P3VGvOTXW+6sJvBvTRpI4mSitEZiCLbW7snGY9PHCWoN
	iLo4dbVDjVytD/rRJruee5ceeVu67DMo+gfVpvcXNtM6u6wa0tvDvtUH6KIgmg80OtLH68+O4rH
	pVaoa/7JKkX+unxzHVD5cRJeBHr2C6VgLiBgKXRPOxbao5NDkD4yB7Oohlyqerxy2R4czciaytN
	FDr2c1CM8+OVCZQSmD+KnF0Dpg=
X-Received: by 2002:a17:907:7846:b0:bda:2ef8:e6d0 with SMTP id a640c23a62f3a-bdd22a3f891mr1223392666b.6.1779909334678;
        Wed, 27 May 2026 12:15:34 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:13d0:4c73:1183:e9b6? ([2a02:a03f:a75e:9a00:13d0:4c73:1183:e9b6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc355d25bsm624803066b.27.2026.05.27.12.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 12:15:34 -0700 (PDT)
Message-ID: <5f04bbd3-ff5d-41f6-8e42-fd17740361a1@gmail.com>
Date: Wed, 27 May 2026 21:15:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ipv6: exthdrs: refresh nh after handling HAO
 option
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, dsahern@kernel.org,
 yoshfuji@linux-ipv6.org, nakam@linux-ipv6.org, davem@davemloft.net,
 yuantan098@gmail.com, bird@lzu.edu.cn, tr0jan@lzu.edu.cn, zcliangcn@gmail.com
References: <cover.1779247873.git.zcliangcn@gmail.com>
 <7aba1debc2196189172499e5769802b026f8caf8.1779247873.git.zcliangcn@gmail.com>
 <ed9cf618-a5b6-4343-9f20-b51b3814acaa@gmail.com>
 <20260524142639.GA93154@shredder>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260524142639.GA93154@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,kernel.org,linux-ipv6.org,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-292430-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 3BB405E96D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/24/26 16:26, Ido Schimmel wrote:
> On Fri, May 22, 2026 at 01:30:40PM +0200, Justin Iurman wrote:
>> On 5/22/26 11:42, Ren Wei wrote:
>>> From: Zhengchuan Liang <zcliangcn@gmail.com>
>>>
>>> ip6_parse_tlv() caches skb_network_header(skb) in nh while walking
>>> IPv6 TLVs.
>>>
>>> ipv6_dest_hao() may call pskb_expand_head() for a cloned skb, which can
>>> move the skb head and invalidate the cached network header pointer.
>>> Refresh nh after ipv6_dest_hao() returns so any trailing padding or TLVs
>>> are parsed from the current skb head.
>>>
>>> This matches the existing pattern used in ip6_parse_tlv() after helpers
>>> that can modify skb header storage.
>>>
>>> Fixes: a831f5bbc89a ("[IPV6] MIP6: Add inbound interface of home address option.")
>>> Cc: stable@kernel.org
>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>>> Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
>>> Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
>>> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>>> Assisted-by: Codex:gpt-5.4
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
>>> ---
>>>    net/ipv6/exthdrs.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
>>> index 47c5502a34a2..751e07392aae 100644
>>> --- a/net/ipv6/exthdrs.c
>>> +++ b/net/ipv6/exthdrs.c
>>> @@ -201,6 +201,8 @@ static bool ip6_parse_tlv(bool hopbyhop,
>>>    				case IPV6_TLV_HAO:
>>>    					if (!ipv6_dest_hao(skb, off))
>>>    						return false;
>>> +
>>> +					nh = skb_network_header(skb);
>>>    					break;
>>>    #endif
>>>    				default:
>>
>> Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
>>
>> Note that the same issue applies to IPV6_TLV_JUMBO (hopopts), I've sent a
>> patch to fix it as well (see [1]). Which makes me wonder... at some point,
>> we may refresh the nh pointer once by default, regardless of the option. The
>> impact wouldn't be that huge, and it would avoid missing the above for
>> similar (new) cases.
> 
> +1
> 
> Do you want to send such a patch to net-next once both patches are
> present there?

Sure, will do. In case I forget, don't hesitate to remind me offline.

