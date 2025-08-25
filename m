Return-Path: <netdev+bounces-216555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD536B347AE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C4B1B251EF
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC67301027;
	Mon, 25 Aug 2025 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN35mZe0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038AE30102A
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139898; cv=none; b=L3IwlVIdHkLOFwSL1/j0lTjKRHq7JP4RCR0N7jH49cGa9QmVeWA8PcyCgVvo75XfN0rAV93t712+MNUGoXUNHTubjrI6PMzylnhwHjeL7r/yl6EjnULsAEgPYLBP1ktmzJ1VYL9QfNX32+u/IvpoyZCJ3C2oKgWLZR0EYU4tk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139898; c=relaxed/simple;
	bh=rS4NLGQ3cm29c9I48A79rEOkkI867Y/jwCSJgsLNGuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOox7aQYAST1S3eys6ooNgXVdK2ph70byO8YZ+Fyk88ulY82lliHEhlgRJKZ/0X1wE2fMZvHSIuSjuFSF4pBZPYVr0BSqzWiOc6Yx9kmAAK8zhVRqEuO+tA2tzgVeLWSo48YaH5wiYTlQZpY/zvnL6RG3RdnWI79dYs1ikt231M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CN35mZe0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756139895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsOqQsOl1L9WBuNz/tsq6H1vvCCd+3l4jHwQMoFeSBs=;
	b=CN35mZe0nMWveDg15r7QKdrmoN20oSUHpKiwFZu/hf7TTGHTUdhl48CO3Y6yKO4F/G14Ff
	CHe/Xj0YnRGANV3pLS7HVGqmn/GwsF8re9GHajizCPQ5pgHQnFNYFcou//BTZJa59IYmLA
	CHhec4rssyv/LDgHEkcZDfJzu0HA0Cc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-_AkYstmZPG22tWtUm7wL2w-1; Mon, 25 Aug 2025 12:38:14 -0400
X-MC-Unique: _AkYstmZPG22tWtUm7wL2w-1
X-Mimecast-MFC-AGG-ID: _AkYstmZPG22tWtUm7wL2w_1756139893
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so27380945e9.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 09:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756139893; x=1756744693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsOqQsOl1L9WBuNz/tsq6H1vvCCd+3l4jHwQMoFeSBs=;
        b=LmrU7tbbUY9TN/xsWlMnx0nz2u4yavGEe55yQn9BrXSIak7V978E5xXP0kX+Qxq+He
         D3QLSHQXHAdtAIxQepF/nvaZLnOvMcbUaKNCx64cUaS6Bj3skiF9b8NsCpe7uHpyU30K
         5Bk8JpDoycS9smOZFElH0Moho/c7b3OaLIY40AB7KIesFfC3/NiGjZmmERELFTywdjMg
         WW1D1dVByvGdqzrM3mFr76eE6dzoED1llknSCnLnKIwwTDqg5eYssekqr0Q6No5Rolb/
         7WI1abN7PXOwuaNjevxqq20sqpsMdCphTrkyqDB9otbErTSuc7KQIlqJAGse85wif64v
         WH9g==
X-Forwarded-Encrypted: i=1; AJvYcCUrzLpfaNkyXxZvzvyS2OHrDx+/4ChdFymzv73IvXLvdHnxLOjI64TtryQsvaaFPEzt1M8uCpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGGItaA8h2JGxMRim7+JNi/Vq3FNc0dgVwisWDfE6F6HwCfXk
	5oLMas7L8lC64V9hdkTOf38Zi88wF2/p/bWossy6bYtVD6pxu11kaBPyt0gaL0e9wntnpzRPifN
	bKfASmaeNm7onopZ6NCZmGKTGWusG6k2sW2VVKiIbn1uvv4VL6lihYHRVzw==
X-Gm-Gg: ASbGncurV0GeIGP7Xr/C6OioHJiV6q9NQc/pv2FKB5xM/+BTeEUEZ4MXo5vC0lp59Ve
	dPSKmFxNib3RjjScymJN6DfZi7XtWqIgp+n4ZMfZReHxiiV/t/jKR8tzfy5gZbX2ufEZ7G2nqyA
	RIAK2MKf3DG3Fw4hcQa54t8xRIO1WtoPI3xr9L/caxyYBO0qh4hyw1Z9Lwk3RwTTbGTeQyqWzUl
	Ez+IQA0B9rSXvEIsMJTF2Jpr+xyPkoepQVw9gc0WBkrlvKdG2MEp7fJS4468tMqeLhUWkidN+7m
	8XVWxMYqQPInM35hPMi1zEoTHyvhi5neibH1ubRbpQhsP/zsw2g6MVZfCuQ+jURDwGtr0PFlssr
	WHKp8LkflHls=
X-Received: by 2002:a5d:5f55:0:b0:3c8:7fbf:2d6d with SMTP id ffacd0b85a97d-3c87fbf31eamr3414109f8f.50.1756139893172;
        Mon, 25 Aug 2025 09:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxWufFp1U5EgXmP2NfBWHpN3YSozzioAzI3CWWgAwRfKMbNgAB7JyDJ5t5no/W/0GjLgDL5w==
X-Received: by 2002:a5d:5f55:0:b0:3c8:7fbf:2d6d with SMTP id ffacd0b85a97d-3c87fbf31eamr3414088f8f.50.1756139892691;
        Mon, 25 Aug 2025 09:38:12 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711ca623asm12165054f8f.59.2025.08.25.09.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 09:38:12 -0700 (PDT)
Message-ID: <7edcbbb6-ac6f-4340-9629-c73ef5f12da8@redhat.com>
Date: Mon, 25 Aug 2025 18:38:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, ecree.xilinx@gmail.com,
 dsahern@kernel.org, ncardwell@google.com, kuniyu@google.com,
 shuah@kernel.org, sdf@fomichev.me, aleksander.lobakin@intel.com,
 florian.fainelli@broadcom.com, willemdebruijn.kernel@gmail.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250821073047.2091-1-richardbgobert@gmail.com>
 <20250821073047.2091-4-richardbgobert@gmail.com>
 <4feda9bd-0aba-4136-a1ca-07e713c991b7@redhat.com>
 <7935b433-4249-4f3f-bf22-bb377a6f6224@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7935b433-4249-4f3f-bf22-bb377a6f6224@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 3:31 PM, Richard Gobert wrote:
> Paolo Abeni wrote:
>> On 8/21/25 9:30 AM, Richard Gobert wrote:
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index 68dc47d7e700..9941c39b5970 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -3772,10 +3772,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>>  	 * IPv4 header has the potential to be fragmented.
>>>  	 */
>>>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
>>> -		struct iphdr *iph = skb->encapsulation ?
>>> -				    inner_ip_hdr(skb) : ip_hdr(skb);
>>> -
>>> -		if (!(iph->frag_off & htons(IP_DF)))
>>> +		if (!(ip_hdr(skb)->frag_off & htons(IP_DF)) ||
>>> +		    (skb->encapsulation &&
>>> +		     !(inner_ip_hdr(skb)->frag_off & htons(IP_DF))))
>>>  			features &= ~NETIF_F_TSO_MANGLEID;
>>
>> FWIW, I think the above is the problematic part causing GSO PARTIAL issues.
>>
>> By default UDP tunnels do not set the DF bit, and most/all devices
>> implementing GSO_PARTIAL clear TSO for encapsulated packet when MANGLEID
>> is not available.
>>
>> I think the following should workaround the problem (assuming my email
>> client did not corrupt the diff), but I also fear this change will cause
>> very visible regressions in existing setups.
>>
> 
> Thanks for the thorough review!
> 
> To solve this issue, we can decide that MANGLEID cannot cause
> incrementing IDs to become fixed for outer headers of encapsulated
> packets (which is the current behavior), then just revert this diff.
> I'll update the documentation in segmentation-offloads.rst to reflect this.
> Do you think that would be a good solution?

I'm not sure I read correctly the above, let me rephrase. You are
suggesting that devices can set MANGLEID but they must ensure, for
encapsulated packets, to keep incrementing IDs for outer IP headers even
when MANGLEID is set. It that what you mean?

Note that most device exposing GSO_PARTIAL can't perform the above.

>> Note that the current status is incorrect - GSO partial devices are
>> mangling the outer IP ID for encapsulated packets even when the outer
>> header IP DF is not set.
>>
>> /P
> 
> WDYM? 

In the following setup:

TCP socket -> UDP encap device (without 'df set') -> H/W NIC exposing
GSO partial for encap traffic

with the current kernel, if the TCP socket creates a GSO packet with
size MSS multiple, the wire packets will have the outer IP header with
the DF bit NOT set and will have ID fixed - for all the wire packets
corresponding to a given GSO one.

/P

> Currently, when the DF-bit isn't set, it means that the IDs must
> be incrementing. Otherwise, the packets wouldn't have been merged by GRO.

Note that GSO packets can be locally generated.

> GSO partial (and also regular GSO/TSO) generate incrementing IDs, so the
> IDs cannot be mangled. 

AFAIK, most device exposing GSO partial don't increment the outer IP ID
for encap packet (the silicon is not able to do that).

> With my patch, if the IDs were originally fixed,
> regardless of the DF-bit, TSO/GSO partial will not occur unless MANGLEID
> is enabled.

I think the above statement is a lit confusing, S/W segmentation can
happen even if MANGLEID is enabled on the egress device: for FIXEDID
pkts, with DF bit not set, both the current kernel code and your patch
will clear it.

/P


