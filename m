Return-Path: <netdev+bounces-199599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FE3AE0E9C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E763B9511
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319D30E847;
	Thu, 19 Jun 2025 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIObE5Yg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18230E834
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750365053; cv=none; b=pbe449lVuUX4m6DkAYY84V2htw4Q7hjA6S3o/6H1Z2AIAtCj5lxNTJOJpiJ3IcuXUURTNTDlj7Dsrur/7oj9eHq31ryXb4TjprCNfvh7JCWTg0RPb3KL7egKle6OkGuzme7CBy2k3xfquRzzfaFp+/Vt+4CUtI6+FAejB49Kuls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750365053; c=relaxed/simple;
	bh=rorrnNeHoS0v6wfoOEePIk/cUa0quCi+admbXTHJFrc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CQhSopuwkFcuScuDdhCq4x1FToqAv4Dt79v1c0H4nsScu0tuiQY3yS5udbYLr9pf8JCyF/HIaku5CA8Q9Y1KXo6VrihjLRc0i1wHUFfeIB/bprcieXQsbPFcwOek0NeQfEI/Xsb5Vd+UzixUNzGY2VoYiN3SIHWZX8yP9/H3Pr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIObE5Yg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750365050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4fOraHK2jpJEJsqSEcNYJwgNPAvM0rdQj/PCtLDmKA=;
	b=fIObE5Ygpw3hRSpzi0fWmxpdZDpegWX13pNJSxpBGCnQZodXvmcDgH46O7O7HIV+hfud5I
	MaNC/ZzTK900jj511tVGY7Hh1sRT03AmV0mXUOdCYTr+/kqL1+4sHIp6q4oZH1EG02zeGs
	TqY2u2z/C/xwOfkPODtZ01Zyq6m2GDs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-6lBnPr0YPrW5YnOykvdEVQ-1; Thu, 19 Jun 2025 16:30:47 -0400
X-MC-Unique: 6lBnPr0YPrW5YnOykvdEVQ-1
X-Mimecast-MFC-AGG-ID: 6lBnPr0YPrW5YnOykvdEVQ_1750365046
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so5588735e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 13:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750365046; x=1750969846;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4fOraHK2jpJEJsqSEcNYJwgNPAvM0rdQj/PCtLDmKA=;
        b=rRvpQoe3m5SY/wwIgP6CKiBH2jj1HB3yridvKe/CO55CuFpPxqY8t7kNxnO9+ebX/j
         kMH8k7BWjsAtD5ry42Li5+a7GBbms1BXtuL4ojckGi9aK4zSJ5pgRkTbekeCzRqnMl9j
         BGHDs1sRCUYryK5/2KGkELTTUwl3+ptZZYLH1QD0mk8kCJDogcq6IQD6GrzaxCgJvoZb
         FdFLaekPVqaRsHzhzVH2rfrclgAz6aCrXYmRgxL0BDlIfGOylVLli9lmd9xBZumNbz1F
         wkT46LgPS+FbAp9n3+eMaQrkmqwQTo8SCTCzEsZuzNtSrCZ6xvzpiWwfikRh4aBv0HLj
         ShpA==
X-Forwarded-Encrypted: i=1; AJvYcCUJSjOikFVdTdN106An21gcR9tieZBufLEqR1wEu4vDCXdTBs08wJUISsn+MhFeXbT+34Wue/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8Vh0Es6bjR5u6hZi6f8eptY/KP659xbYUG6gcGEh04l+nCHM
	IGEnh1xFrSXCsYQL93KpwAvAvr5mvZZf0xEaS/PU9CPtRT2eAEt5mxFimFs+thXx5x7zAlTXmed
	gKa0N2sV54ejnkgFyC/jRHrAmDsVwEAIr6wREuWDQwwpKRsCVhbkRbxA9Eg==
X-Gm-Gg: ASbGncsqTKJ5qYEXaHkF8GrN6Ozj5Sm6I8wxbIZrJIiUtWJLO38Oc8veaJkAvU3ZTIT
	M2xCT06W4hA6XhHFTS2a1WGOChnJJroGf1QzxWD+EYWQ94qrhw+LA/ey94IhiUriTeKTKYSKZDO
	AOIwZ9Utlk7AgYTJINFEg3TQ7YoXWG8Mel6HCTjQ/aLuEjgMypr5mKWWbe8+xeBOIH/gU/RTUNK
	6Wn9bIabB0+EIRkjyaNRY+bYSOnDoAwf+qPkNQPS9K8wYYYPO/DUaXUSNT2HYClKHNHpcHKf0co
	Nn/KxmDQS8XDpA0bm7FD/NvEGUUGGh1QbDMLkOCp6eU=
X-Received: by 2002:a05:600c:3b87:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-453659be405mr1131065e9.7.1750365045696;
        Thu, 19 Jun 2025 13:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWlkJjm7SQMNAqB4PruWDl5eHoKV29lwzgN+089Bluzqv1RQdvfWS8QYi/Ao9jvPalHD31uQ==
X-Received: by 2002:a05:600c:3b87:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-453659be405mr1130825e9.7.1750365045219;
        Thu, 19 Jun 2025 13:30:45 -0700 (PDT)
Received: from [192.168.0.115] (146-241-9-4.dyn.eolo.it. [146.241.9.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb672sm4573535e9.6.2025.06.19.13.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 13:30:44 -0700 (PDT)
Message-ID: <f5bb7b71-bae6-49c6-970d-869a59f11a1f@redhat.com>
Date: Thu, 19 Jun 2025 22:30:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 7/8] tun: enable gso over UDP tunnel support.
From: Paolo Abeni <pabeni@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
 <add3a48e-f16a-4e32-91d4-fc34b1ff3ce6@daynix.com>
 <0aa1055e-3e52-4275-a074-e6f27115a748@redhat.com>
Content-Language: en-US
In-Reply-To: <0aa1055e-3e52-4275-a074-e6f27115a748@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 7:41 PM, Paolo Abeni wrote:
> On 6/19/25 6:02 PM, Akihiko Odaki wrote:
>> On 2025/06/18 1:12, Paolo Abeni wrote:
>>> @@ -2426,7 +2453,17 @@ static int tun_xdp_one(struct tun_struct *tun,
>>>   	if (metasize > 0)
>>>   		skb_metadata_set(skb, metasize);
>>>   
>>> -	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
>>> +	/*
>>> +	 * Assume tunnel offloads are enabled if the received hdr is large
>>> +	 * enough.
>>> +	 */
>>> +	if (READ_ONCE(tun->vnet_hdr_sz) >= TUN_VNET_TNL_SIZE &&
>>> +	    xdp->data - xdp->data_hard_start >= TUN_VNET_TNL_SIZE)
>>> +		features = NETIF_F_GSO_UDP_TUNNEL |
>>> +			   NETIF_F_GSO_UDP_TUNNEL_CSUM;
>>
>> xdp->data - xdp->data_hard_start may not represent the header size.
>>
>> struct tun_xdp_hdr is filled in vhost_net_build_xdp() in 
>> drivers/vhost/net.c. This function sets the two fields with 
>> xdp_prepare_buff(), but the arguments passed to xdp_prepare_buff() does 
>> not seem to represent the exact size of the header.
> 
> Indeed the xdp->data - xdp->data_hard_start range additionally contains
> some padding and eventually the xdp specific headroom. The problem is
> that both info are vhost_net specific and tun can't (or at least shoul)
> not be aware of them.
> 
> The only IMHO feasible refinement could be using xdp->data_meta instead
> of xdp->data when available. Alternatively I could drop entirely the test.

As the vhost_net padding is considerably larger than the largest
possible vnet_hdr_sz, I'll drop entirely the xdp check - so that I can
use the newly introduced tun_vnet_hdr_guest_features() helper here, too.

/P


