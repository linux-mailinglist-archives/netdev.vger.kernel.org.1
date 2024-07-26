Return-Path: <netdev+bounces-113252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEC593D559
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 16:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A328828129E
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 14:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7EF134C4;
	Fri, 26 Jul 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0pnta9l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437591CD06
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005427; cv=none; b=kI5MGn1lhcjkZfbfSiv0dhJI/NaduFe0Amsnxp4MaVUatrgQUZFqNFolBRcToZ/ghacM/k58KthBTHc+fCH19GyTyh/zR/7EGzBvlaIxesY+8Bez698WF3g2Ris0Tc1eXx5lupKXAhUsUcaqcOddo5266hXgAI/iR5xi1jACaBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005427; c=relaxed/simple;
	bh=tLx/fMXOVGCyadE2i1prx1ayp8nFacEeeSEdUOK4kbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2KgEBvZXm7I4V5d6m8RiErsZHFsfvoT3c3W+aqcWjbVLaMI2not/aaHNctf6auARI1n50D2Xe+fi/j2c/tZAUN0U9LXXYE8B9k4JWSFBjEJjBnXzxBocbXIjifvLNiLIyRUGZl21D2/+f7fD/hqf85ysLS63rKLaUjhmGVHV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0pnta9l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722005425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvwUGbn07tsXSoowZQu31RzeEXtVHtqeR0AF7mHMHh4=;
	b=M0pnta9lTAozmUo5L2Pa/a7vYnJDhiK2dEx4fxRbO0mWNuN3bZzkYe+YkztNnB1A4/J96z
	Qt4zyMDwUEnE9gjQp3Je9GkFnY3hLKG87nZ6akwYMOsrVkQ6746+1uUpG+y85l28yIKdhn
	12YJ27zfBglGwAE13mS+0T7YY/SSIBE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-tYomVtHZPQKC6K9Z5gpnng-1; Fri, 26 Jul 2024 10:50:23 -0400
X-MC-Unique: tYomVtHZPQKC6K9Z5gpnng-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-426624f4b7aso2246145e9.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 07:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722005422; x=1722610222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvwUGbn07tsXSoowZQu31RzeEXtVHtqeR0AF7mHMHh4=;
        b=MHBKRaf6Tdd252vzp/ICUG/Kdu/iNU3RWklZy/O5z/A7byYvHQLwKicpYHs9M4bGep
         f5Ie7fxjSJhjI6u0lMNezCfTWuzN7oPY+MsQF1bMb7aJgpLqdKqURPPYwp6I4ajyzEoc
         SVU/fsqbv2lzJPVwE/fsmYbSdIG4LDo8JTu0FsxT6OH+xIQqyWjYnNfPySo22L9DzIYB
         KEaMCHAifwYtc5IRf103o0Et9y2hbrbZno9vk+Rs/xZwmtiLkZ+01Lcj1uWmTGikSCu+
         anEpAAB71agWM6Doi7f6RHqvJUtxmRfc8X6v2m+pw9VURK7pEDK1yAcDomLEQRJ1M8jO
         nydg==
X-Gm-Message-State: AOJu0YwCN18q2Um7DSC/AU6uQw5/i3+lhloh1aroJauGglMKaEhYR/ke
	69+BZCVh1rMKwJsLVoHI+6Wcm5Ab5v36WjCgBd6GRXhh88YhseGXZCu+dXvEisHlqoLXDIpPLSZ
	YO7Nkec4dbVr1Pd0L0RvzDzdt+xqGONDRMNhnbY5bxQ8CA9RchekrZQ==
X-Received: by 2002:a05:600c:3b21:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-428057706aemr25378665e9.3.1722005422453;
        Fri, 26 Jul 2024 07:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi3Z9jbl+hMmUI7U3ZNPl1/Ndk9lNLNUNn8NAAYX7TfuFrgQKs3zUcmvvJUAtbTDzJ8aLL5Q==
X-Received: by 2002:a05:600c:3b21:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-428057706aemr25378485e9.3.1722005421960;
        Fri, 26 Jul 2024 07:50:21 -0700 (PDT)
Received: from [192.168.1.24] ([145.224.103.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863d87sm5314384f8f.110.2024.07.26.07.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 07:50:21 -0700 (PDT)
Message-ID: <aad76753-d2b5-4905-b90b-e31483e5956b@redhat.com>
Date: Fri, 26 Jul 2024 16:48:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, mst@redhat.com, jasowang@redhat.com, arefev@swemel.ru,
 alexander.duyck@gmail.com, Willem de Bruijn <willemb@google.com>,
 stable@vger.kernel.org
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <bab2caf1-87a5-444d-8b5f-c6388facf65d@redhat.com>
 <CAF=yD-J57z=iUZChLJR4YXq-3X-qPc+N93jvpCy5HE89B7-Tdw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAF=yD-J57z=iUZChLJR4YXq-3X-qPc+N93jvpCy5HE89B7-Tdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/26/24 15:52, Willem de Bruijn wrote:
> On Fri, Jul 26, 2024 at 4:23 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 7/26/24 04:32, Willem de Bruijn wrot> @@ -182,6 +171,11 @@ static
>> inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>>>                        if (gso_type != SKB_GSO_UDP_L4)
>>>                                return -EINVAL;
>>>                        break;
>>> +             case SKB_GSO_TCPV4:
>>> +             case SKB_GSO_TCPV6:
>>
>> I think we need to add here an additional check:
>>
>>                          if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
>>                                  return -EINVAL;
>>
> 
> Historically this interface has been able to request
> VIRTIO_NET_HDR_GSO_* without VIRTIO_NET_HDR_F_NEEDS_CSUM.

I see. I looked at the SKB_GSO_UDP_L4 case, but I did not dig into history.

> I would love to clamp down on this, as those packets are essentially
> illegal. But we should probably leave that discussion for a separate
> patch?

Yep, I guess we have to keep the two discussion separate.

As a consequence, I'm fine with the current checks (with Eric's 
suggested changes).

Thanks,

Paolo


