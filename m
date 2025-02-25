Return-Path: <netdev+bounces-169334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF26A4385A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821F3189ECEA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12541261585;
	Tue, 25 Feb 2025 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DX2n45AZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB6260A40
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473746; cv=none; b=eRfVpG1qZvJ8vtLIWpMaRmLpplfJN+kl+fKRHKy1Q2Wo3SUFSpfEjVTzl89a2kLUqjsy1jjQm9lMIjIJDczaCsT0a0dHVHhr+tD+4zI0oRd5ABGRPFZYg616pRCOwgfhUFQDyjOEbGgoJIiN29sqgxNqe9Z3N5izUn+ZqYxNiwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473746; c=relaxed/simple;
	bh=4WfKCMWcV1sz1r/xYfnI+h85SR2D0RsZD5RoLL0eJPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qoe1VBIhYENl33ju+fmZMc9xMhT2Ij5ZG7lYJGKAcferiob8nASuYrVT2sE3hXaZuAQoQpXKgSbCMODoXh4tW5Y3IJHKkt7VXtXrRFwGW9xYRVcXZaNz1gQizG2+J2oCXD6tlDUEOjsXSQvCdI0ML+ig1Z6W0fxOYRNcE75DDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DX2n45AZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740473743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FX6qo2rjYkln2nnyoIWVMmLZCwBhuXL5govaxF0xfxc=;
	b=DX2n45AZ6+Sm8FMF80ulNe4jcg90Qp0av2qlQDzrJ+TqKB3YZT23ol1JvIgUVxbruWnIWE
	hln8ZOaBpKFE3iJ1FCRFjwWJ6xidF1lryXTuHWtz14dzkgqQYZnQV3Qxdzy8jWSDg1z68L
	DKyG5z2FhKRMSXTe+t6K9eBbmHJJ0RY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-SU2coT6CMPSZZsMxJ92UtQ-1; Tue, 25 Feb 2025 03:55:41 -0500
X-MC-Unique: SU2coT6CMPSZZsMxJ92UtQ-1
X-Mimecast-MFC-AGG-ID: SU2coT6CMPSZZsMxJ92UtQ_1740473740
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso50638005e9.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 00:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740473740; x=1741078540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FX6qo2rjYkln2nnyoIWVMmLZCwBhuXL5govaxF0xfxc=;
        b=M9Xn6m3swn3+ZULLxWmuZNfsS6sID3ueiVoab1KvE1Owf2SrGEKUX9Yx1hF+LGrN0n
         iAM34jYH5qBNBM3j1CYWdYQGC9Elig9jhHfqBoNxzvdClWuHw54BFPNs0UrzGktnmGHl
         B9ybIaX7cDjHBC+m6rIApN7nTozsb4HXcPZtuk8BMEhGDla9iSQ52CRktpwznkP6Tncs
         MlcGe0u84vLW4UWyLgGmELoylJHGivbHX6KH0/HxWv0RMRsCZWiFdV2dJkc5RJGQwn9Z
         /qS0hvDHRT6ojxkvJ8wdmy0UCXZTUCoG+LpYtXB1Fga8zDHQY3ZkHx4n7B7dSNQblveb
         jOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLj0WHybzyN0tS0NBglj9QLunUGpQdQZ6bl5g5VL1BenvjYxTW1Le3JA6xTLNzb1ozIy2akJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbvLYZs8sHSm1cw/clEd2mOx7ea+0VgRqrLv+RgMFwAnmfe8AO
	8KSVufo4L3Ldx6hy1Vv5gcFmawgCECCegedQbpdvnB7OPTrEEc4/uhmKgt+kkKynqxxA0DQi2WP
	fApHAqN1+0fyQL8kJ4Foy2ZxEp1fhUYbXFK6yp//VOS3eW/iiZFCqxA==
X-Gm-Gg: ASbGncuEKdkwfVTv6mqgdvCA/KpZzociJl/odNjVenr1JC3rB4HEO1jLaoBOX+q7gLi
	z3NBwxJJ8X+wbtyYaAa3ZbUcsYSG3mmH0A5TJFB+cffvI+Kp8Z5v93pNE/fRN/2fHFkHp1wTpEi
	LJ64DIlHjPoI7z2LNz8/f0c947EmsIGkNP1BI7hLiuqykmiWfNlnsFyks6fPf0CSsv3qL8LKqTy
	vqaNicT8/2qn2GOFbpMyoB6d5bagjF26mCwJAJ/fPJ97dNK3p+lQoPj14BCWF1fYvJxEJWQEJi/
	Y2LPSck/TUbADTEEiWS9hwLbwgOmDS1sJ5X5iBb+jO8=
X-Received: by 2002:a05:600c:1d1a:b0:439:916a:b3db with SMTP id 5b1f17b1804b1-43ab0f28872mr21375435e9.6.1740473740053;
        Tue, 25 Feb 2025 00:55:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz5QBwhYiQzteSKicfFKmG7eQvCW6FMNxv1diVSBaFGNBNcW9s0Gl7OTJo7oVMAq15xZfsyw==
X-Received: by 2002:a05:600c:1d1a:b0:439:916a:b3db with SMTP id 5b1f17b1804b1-43ab0f28872mr21375115e9.6.1740473739586;
        Tue, 25 Feb 2025 00:55:39 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab155eb97sm17837985e9.26.2025.02.25.00.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 00:55:39 -0800 (PST)
Message-ID: <099147dd-555a-4f3b-bd75-3a3dcd7d942e@redhat.com>
Date: Tue, 25 Feb 2025 09:55:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND,PATCH net-next v7 7/8] net: txgbe: Add netdev features
 support
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Joe Damato <jdamato@fastly.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>, jiawenwu@trustnetic.com,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>
References: <20230530022632.17938-1-mengyuanlou@net-swift.com>
 <20230530022632.17938-8-mengyuanlou@net-swift.com>
 <3dc42e5c-2944-47d9-9082-9dc347a70802@redhat.com>
 <CAKgT0UeEgLiRzqNkd08B4HP2=CFc_=+p14V5ASkFPwMN6VYRKg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAKgT0UeEgLiRzqNkd08B4HP2=CFc_=+p14V5ASkFPwMN6VYRKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding Joe, which authored a change possibly relevant here.

On 2/25/25 12:59 AM, Alexander Duyck wrote:
> On Mon, Feb 24, 2025 at 2:17 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> I just stumbled upon the following while working on something slightly
>> related. Adding a bunch of people hopefully interested.
>>
>> On 5/30/23 4:26 AM, Mengyuan Lou wrote:
>>> Add features and hw_features that ngbe can support.
>>>
>>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>>> ---
>>> @@ -596,11 +597,25 @@ static int txgbe_probe(struct pci_dev *pdev,
>>>               goto err_free_mac_table;
>>>       }
>>>
>>> -     netdev->features |= NETIF_F_HIGHDMA;
>>> -     netdev->features = NETIF_F_SG;
>>> -
>>> +     netdev->features = NETIF_F_SG |
>>> +                        NETIF_F_TSO |
>>> +                        NETIF_F_TSO6 |
>>> +                        NETIF_F_RXHASH |
>>> +                        NETIF_F_RXCSUM |
>>> +                        NETIF_F_HW_CSUM;
>>> +
>>> +     netdev->gso_partial_features =  NETIF_F_GSO_ENCAP_ALL;
>>> +     netdev->features |= netdev->gso_partial_features;
>>> +     netdev->features |= NETIF_F_SCTP_CRC;
>>> +     netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
>>> +     netdev->hw_enc_features |= netdev->vlan_features;
>>
>> This driver does not implement the .ndo_features_check callback, meaning
>> it will happily accept TSO_V4 over any IP tunnel, even when ID mangling
>> is explicitly not allowed.
>>
>> The above in turn looks inconsistent. If the device is able to update
>> the (outer) IP (and IP csum) while performing TSO, than it should be
>> able to fully offload NETIF_F_GSO_GRE: such offload should not be
>> included in the partial ones.
>>
>> Otherwise, if the device is not able to perform the mentioned tasks, the
>> driver should implement a suitable ndo_features_check op, stripping
>> NETIF_F_TSO for tunneled packet that could be potentially fragmented,
>> that is, when `features` lacks the `NETIF_F_TSO_MANGLEID` bit.
>>
>> Alike what several intel drivers (ixgbe, igc, etc.) do.
>>
>> Assuming I did not misread something relevant, and the above is somewhat
>> correct, I'm wondering if we should move the mentioned check into the
>> core; preventing future similar errors and avoiding some driver code
>> duplication.
>>
>> Something alike the following, completely untested:
>> ---
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index d5ab9a4b318e..2fdfcddf9c3b 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3668,15 +3668,6 @@ static netdev_features_t gso_features_check(const
>> struct sk_buff *skb,
>>                 return features & ~NETIF_F_GSO_MASK;
>>         }
>>
>> -       /* Support for GSO partial features requires software
>> -        * intervention before we can actually process the packets
>> -        * so we need to strip support for any partial features now
>> -        * and we can pull them back in after we have partially
>> -        * segmented the frame.
>> -        */
>> -       if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL))
>> -               features &= ~dev->gso_partial_features;
>> -
>>         /* Make sure to clear the IPv4 ID mangling feature if the
>>          * IPv4 header has the potential to be fragmented.
>>          */
>> @@ -3684,10 +3675,24 @@ static netdev_features_t
>> gso_features_check(const struct sk_buff *skb,
>>                 struct iphdr *iph = skb->encapsulation ?
>>                                     inner_ip_hdr(skb) : ip_hdr(skb);
>>
>> -               if (!(iph->frag_off & htons(IP_DF)))
>> +               if (!(iph->frag_off & htons(IP_DF))) {
>>                         features &= ~NETIF_F_TSO_MANGLEID;
>> +                       if (features & dev->gso_partial_features &
>> +                           (NETIF_F_GSO_GRE | NETIF_F_GSO_IPXIP4 |
>> +                            NETIF_F_GSO_IPXIP6 | NETIF_F_GSO_UDP_TUNNEL))
>> +                               features &= ~NETIF_F_TSO;
>> +               }
>>         }
>>
> 
> My main concern would be that there might be implementations of
> partial that are capable of doing a partial offload without the
> MANGLEID feature that would be impacted.
> 
> If I recall I think for the i40e it may have supported some logic to
> do the proper things while not knowing how to deal with the tunnel
> headers but correctly handling the IP headers.

Thanks for the pointer, I missed the i40e case. It's not clear to me how
such driver handles the special case.

If I understand correctly, such NIC is able to touch inner and outer IP
id and csum correctly, without being able to parse the encap header. If
so, I guess it needs explicit notion of the inner and outer header
offsets, provided by the driver.

But I don't see the driver passing to the H/W the offsets, so possibly
the current code is actually bugged for this specific case? What am I
missing here?

If i40e can handle the IP headers correctly, why it need the partial
feature for NETIF_F_GSO_GRE? Perhaps commit b4fb2d33514 ("i40e: Add
support for MPLS + TSO") increased the partial features set too
broadly?!? It looks like originally none of
NETIF_F_GSO_UDP_TUNNEL, NETIF_F_GSO_GRE, NETIF_F_GSO_IPXIP4,
NETIF_F_GSO_IPXIP6
belonged to the partial features set.

>> +       /* Support for GSO partial features requires software
>> +        * intervention before we can actually process the packets
>> +        * so we need to strip support for any partial features now
>> +        * and we can pull them back in after we have partially
>> +        * segmented the frame.
>> +        */
>> +       if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL))
>> +               features &= ~dev->gso_partial_features;
>> +
> 
> Why move this? I'm not sure it gains you anything if it is either
> before or after the result should be the same.

I'm sorry, I rushed the code out-of-the-door to try to get some
feedback; I moved that chunk so that in the previous block `features`
still contains the partials bits and the code can check for tunnels
looking at `features` contents.

Thinking again about it, it's not needed, as we could (and should) check
instead the skb wanted features (skb_shinfo(skb)->gso_type <<
NETIF_F_GSO_SHIFT).

Thanks,

Paolo


