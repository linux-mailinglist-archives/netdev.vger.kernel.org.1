Return-Path: <netdev+bounces-216966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B333B36BC7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331178E4C77
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570D5352096;
	Tue, 26 Aug 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYV0H1x6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E287260586;
	Tue, 26 Aug 2025 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218727; cv=none; b=rnp3tDkvDj4/iZF0rHLavv0vDBW8jyP3fB6Htjx8rzHq4MG5Y4u5teS0pc6WTybkRe7OuE3Df9j1irfHEzgt/mtwaQQhkDya7ktUCa6Lr8A91r8tCPDOiyqAsFaRmQoWwMY56+8m4lnwovk33sorQ1yEhb5JK6SLgXRrQFKR634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218727; c=relaxed/simple;
	bh=byDMhM9JzVLwSHAn47B5Vm6524i7NauQkzNA65cDxEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGglDKgvFF6VHtHAX9SXqHqx1CInyFImYEr0VCwenrQxhQ0Ejmslvboe7PzkXpG3MzpSirrflcnhkgzEBbP7ni3Ji3FA1CM1MnlZqlbHLdjN2ppoYQ+SbSwl+6KTCF9I1bRuh0l8kvck/199cHp8iB47Ad/kchaRktV8vPd4+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYV0H1x6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so35189415e9.3;
        Tue, 26 Aug 2025 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756218724; x=1756823524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XK9Usx6Vz4ZTcY7mx64b545nF47Z31E+zXXjKfFYvpQ=;
        b=GYV0H1x6qH+CYGuCvy8oXwrSRw2fd8tl2uUwZikQgCYgmLoLJTKMEwOLw5xsfAxKGF
         3ZpdfEwJVr9TVzLr5TrZqEAu/rwVLVUtvPFacsxlwfZw9iTopaI9KxP2J+CCyBjQp8Ll
         4IpImpvV8aFs3NxvFuac2UOM4gyPr6EHrdg7jILnpLgOtnPUgSYAp9rb86yd0xqiSYGR
         jH4IZlYMaoIz9f7+C9RfQS+7XPSgrXjSheZXyTV3Skc3qDe7gqOMLL1H5Ol55KXZJla8
         Ys2FwcjWiTyijGp2irOcxffqnxF2FXq2ZL220p6ojh+O4bb3sHyMh/UW6+lh7AV+PE0i
         mmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218724; x=1756823524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XK9Usx6Vz4ZTcY7mx64b545nF47Z31E+zXXjKfFYvpQ=;
        b=T9yVQeZuDSpIyML9ZtFSGeFc4Ep6cnJ8TzLblIotaH6dz8PrxQ8HZ9jnP1LcIGUc4W
         vkOlyT7pVe92UbouvAULsyi3KpL3Pwbvm6BqJDhRFhQ3Y6LKJKdCsIw0xXD2NMhvDdcW
         mu6NlEjCpgLhQnKJ/XNJg8qgY1Ir7po4FkhEVJMjwbcky1bYYAEJH1Ai2krRoP58AZxy
         bEZUEsnT1/OsFRzaoUg9ApCJyw7bKCBtHurZkvXY/tHjh0IAXgjQenufSDlvAp/o6ApF
         Gtlp8PBrTdCGhSL91dDUc0VAjZybb3KKaZ31y4sJ6oirO0FWtiTJsM3S4GmQnJH1H7hv
         2UJg==
X-Forwarded-Encrypted: i=1; AJvYcCUrn1p8qvILhD5jPcn0tWIlylb/eoeDyLR6yFZdT90fJMp9ytmNaCvbz0hTZLFc6ue9Pk1dxyU3@vger.kernel.org, AJvYcCVkefyvy4X2fxX5S+5gnyrPORM84ajxU5oFvB45eTAmqVQ/H6LcUJaviGpXLf37+hYG4+WIwLMQhj320IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5W+BR58ga1CiR9Gd5IAT/Ta1XlCrEOntXHR9OIVTLDgOB/Kn
	UkQvnlmYw8drmXje+3BUKslK4H88zZ9KCvjoorR1goMoPB4Au8GX3Ca7
X-Gm-Gg: ASbGncsnUz8goOLKhmSnSPeZhVEEI1/DivnvPO/4R1MD/ErgqODX8NSnfPTLbrH2HAO
	lSMbkz2zGhmM5zyBIRs6yQQmVJJ8ms2iyR+kV/vqpDsIFkRTQk3pvhPuTpfmNxoEN55tVSiBbrz
	cj3Skrq5JVI2n4ltP/+NvmabLhBbKe4UsSfYLjp9nllmMNK3usgX8ftIGPbax31y4WYvnm359mu
	nPBNaD2/wNZHeftRe9VnhBDnN85KstDMHAfhxBWOyOSdC8M6VAGz7CoYaWpsy85WGOZkHXkdemP
	12SVmh7jyXLUBj2eliyP13Pv0ou+gfjdFSsLyhHm2+D1wxeL9YALj52T1yVbeUai6DqKzpJmlSK
	WTMaFPeebI1+YdD8lTtLEAkjwWGNgUXVycCXl1A==
X-Google-Smtp-Source: AGHT+IHyfNMmF5kP3wsn98iVIjUXNxmbWOYH4YEJSsBVdlPVhNZJG1JRfvSeH6Tttcg6k4KyYpZNCw==
X-Received: by 2002:a05:600c:470c:b0:456:285b:db29 with SMTP id 5b1f17b1804b1-45b517d416bmr111454305e9.29.1756218723302;
        Tue, 26 Aug 2025 07:32:03 -0700 (PDT)
Received: from localhost ([45.10.155.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ca6240b4e1sm6444192f8f.21.2025.08.26.07.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 07:32:02 -0700 (PDT)
Message-ID: <a88ee88c-707f-4266-b514-d0390166dedb@gmail.com>
Date: Tue, 26 Aug 2025 16:31:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
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
 <7edcbbb6-ac6f-4340-9629-c73ef5f12da8@redhat.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <7edcbbb6-ac6f-4340-9629-c73ef5f12da8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 8/25/25 3:31 PM, Richard Gobert wrote:
>> Paolo Abeni wrote:
>>> On 8/21/25 9:30 AM, Richard Gobert wrote:
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index 68dc47d7e700..9941c39b5970 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -3772,10 +3772,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>>>  	 * IPv4 header has the potential to be fragmented.
>>>>  	 */
>>>>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
>>>> -		struct iphdr *iph = skb->encapsulation ?
>>>> -				    inner_ip_hdr(skb) : ip_hdr(skb);
>>>> -
>>>> -		if (!(iph->frag_off & htons(IP_DF)))
>>>> +		if (!(ip_hdr(skb)->frag_off & htons(IP_DF)) ||
>>>> +		    (skb->encapsulation &&
>>>> +		     !(inner_ip_hdr(skb)->frag_off & htons(IP_DF))))
>>>>  			features &= ~NETIF_F_TSO_MANGLEID;
>>>
>>> FWIW, I think the above is the problematic part causing GSO PARTIAL issues.
>>>
>>> By default UDP tunnels do not set the DF bit, and most/all devices
>>> implementing GSO_PARTIAL clear TSO for encapsulated packet when MANGLEID
>>> is not available.
>>>
>>> I think the following should workaround the problem (assuming my email
>>> client did not corrupt the diff), but I also fear this change will cause
>>> very visible regressions in existing setups.
>>>
>>
>> Thanks for the thorough review!
>>
>> To solve this issue, we can decide that MANGLEID cannot cause
>> incrementing IDs to become fixed for outer headers of encapsulated
>> packets (which is the current behavior), then just revert this diff.
>> I'll update the documentation in segmentation-offloads.rst to reflect this.
>> Do you think that would be a good solution?
> 
> I'm not sure I read correctly the above, let me rephrase. You are
> suggesting that devices can set MANGLEID but they must ensure, for
> encapsulated packets, to keep incrementing IDs for outer IP headers even
> when MANGLEID is set. It that what you mean?
> 
> Note that most device exposing GSO_PARTIAL can't perform the above.

I think there are two misunderstandings:

1. When I'm talking about mangled ids, I'm mostly talking about forwarded
   packets whose IDs are mangled after being forwarded. You also consider
   locally generated packets to have mangled IDs if the IDs are modified
   during segmentation, which is fair.
2. You say that GSO partial keeps the outer IDs fixed, but AFAICT this isn't
   the case. (See below)

I think you understood me correctly, but I'll explain in more detail.

My understanding is that TSO generates packets with incrementing IDs. Since
TSO can't promise to keep fixed IDs, if a packet has SKB_GSO_TCP_FIXEDID, TSO
cannot be used and software GSO must be used instead (this is checked by net_gso_ok).
If you don't care about mangled IDs, MANGLEID can be set on the device so that
TSO can still be used.

If MANGLEID is set on the device, then TSO is allowed to generate either incrementing
or fixed IDs, depending on the device's preference. However, mangling incrementing IDs
into fixed IDs is a problem when the DF-bit is not set, as the packets might then
be fragmented and fragments of different packets will share the same ID. To prevent
this, the check discussed above removes MANGLEID if the DF-bit is not set.

Currently, MANGLEID is only relevant for the inner-most header. With my patch,
MANGLEID explicitly allows the mangling of outer IDs as well, so the check must be
modified to check both the inner and the outer headers.

I suggest that we revert the diff so that only the inner-most header is checked,
allowing TSO even when the DF bit is not set on the outer header. For this to be
correct, we must explicitly define MANGLEID on the outer header to mean that TSO
is not allowed to turn incrementing IDs into fixed IDs when the DF bit is not set.
No code change is required since devices already generate incrementing IDs for the
outer headers.

> 
>>> Note that the current status is incorrect - GSO partial devices are
>>> mangling the outer IP ID for encapsulated packets even when the outer
>>> header IP DF is not set.
>>>
>>> /P
>>
>> WDYM? 
> 
> In the following setup:
> 
> TCP socket -> UDP encap device (without 'df set') -> H/W NIC exposing
> GSO partial for encap traffic
> 
> with the current kernel, if the TCP socket creates a GSO packet with
> size MSS multiple, the wire packets will have the outer IP header with
> the DF bit NOT set and will have ID fixed - for all the wire packets
> corresponding to a given GSO one.

Are you sure? The documentation clearly states that for GSO partial, the device
drivers must increment outer IDs when the DF-bit is not set. For example, AFAICT,
this is what ixgbe and i40e do, but I don't have the hardware to verify.

I would think the behavior in the example you provided is undesirable, since
the packets could potentially be fragmented later.

> 
> /P
> 
>> Currently, when the DF-bit isn't set, it means that the IDs must
>> be incrementing. Otherwise, the packets wouldn't have been merged by GRO.
> 
> Note that GSO packets can be locally generated.

Of course. I was just referring to forwarded packets.

> 
>> GSO partial (and also regular GSO/TSO) generate incrementing IDs, so the
>> IDs cannot be mangled. 
> 
> AFAIK, most device exposing GSO partial don't increment the outer IP ID
> for encap packet (the silicon is not able to do that).
> 
>> With my patch, if the IDs were originally fixed,
>> regardless of the DF-bit, TSO/GSO partial will not occur unless MANGLEID
>> is enabled.
> 
> I think the above statement is a lit confusing, S/W segmentation can
> happen even if MANGLEID is enabled on the egress device: for FIXEDID
> pkts, with DF bit not set, both the current kernel code and your patch
> will clear it.

Sorry, I phrased that awkwardly.

> 
> /P
> 


