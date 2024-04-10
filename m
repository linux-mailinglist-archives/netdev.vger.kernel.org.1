Return-Path: <netdev+bounces-86668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A789FC76
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 18:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321F41C217B6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C881791E9;
	Wed, 10 Apr 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkSdt+eM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08E1779AD
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765221; cv=none; b=hpgUQwyZl3Lo3ZDFOcUdg5CLKnl8DHrSDOnYD9TYKOoTJLIk+h3mCv7OGQeqfrTwDYF5MPDgbp/cashh5ZKReotKaKEOGxb/hLpMRV/DSiqNhax7URSAbtOX1Y43MgqLh+kIxGHQUBJZJOu3MIE9e30YwPOLObbVdbNxLTjKMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765221; c=relaxed/simple;
	bh=nvWl1bZewKIPWTM6J2d58Pmrr0Mymh7RKdxUjQRSwBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqNnBD2VyYnVlBIZoLVnK1kPufB7Vq9DNLzt+TWq8NvFCqXu1bCPlPkfq/SzWspttx9bR/lr/dIS8SxVYTv7SLEl9eOJb6jnqpwagx6A33e8x4lIfk9XLAroqUvQMjvSTvAjVOByqJd48hoTi8Vlv24z5xCoFUZNVfDf5qG9UXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkSdt+eM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712765218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N6kKTqXMZNlUBawwTh4IwJfauVu20nj9TB2zdIeMmjI=;
	b=TkSdt+eMuwSSvvm0iD5BBT/uGcnKVhkNlaq30lH67wTnA2RyJl5en2k65pYXEoWi4irF1b
	09+m/SGUR28WLpqClvVzR0C+8zuCTnuVPRn3/89LDAXaPSvtmGdqTRZIph2lnZ3mmHyN1S
	ECO5xsmRlXQoZUtqutXjd5ex+sOHSBw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-im33p1A7NKGplBDCDnjFtw-1; Wed, 10 Apr 2024 12:06:55 -0400
X-MC-Unique: im33p1A7NKGplBDCDnjFtw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34619c30076so996018f8f.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712765214; x=1713370014;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6kKTqXMZNlUBawwTh4IwJfauVu20nj9TB2zdIeMmjI=;
        b=PS9KPDdJLaC+XYN6HQaW0nBKx1oMYP1gURw5vzECs/KFg8avkmIOfQKwWvK42lEfLu
         0DxQBraCzd5zNqfCXNTYT0ffin+SALioNvtzkKEp0ijNZ+ttCJ+idNGLSFeTaSKTPFND
         1khK1BONO82MiHpfxTDPF+/5FkxKazgrCm76M4nNPO5ngbSdkYOXanc1Qz+MJFPpEI/+
         gO/n4pQEAE/0lNxscxOt2MXEKLQCOERFQjgQLzoWeCmOrKEFEZ4TvLdFTQhfdQdwnKxz
         kace0Fv1fKg7Ybm2/O5C3sL6AsLgTrl5xXUYm+eXrv/4+iG7t8FT1eCKBj/6AMBD5ZCO
         VNdg==
X-Forwarded-Encrypted: i=1; AJvYcCXjWD1oJQ3FCEKEnU0Se1az7j2XCgAr2r51OokBWD8gP94wKKL10nbemhkeuPngWYcOlGmObhq6GqqjA8n5Y3CjKPuLSu/3
X-Gm-Message-State: AOJu0YyTBnNaC705Omx5qmblTbfG0MLF7C2XTRTgHwYNs0fKgT9R+vRu
	KmNSE3Vv/I+NESr6RGdrnwfdQ2S7fXcxOASIr8XMGDfoTk9Uw5SEuDSoeUrfCUx7AwHabb1ANy/
	sb//A8pLka7ENNqPymTZIJe6m3z3BM4WSc+Cu7BkR1g3zmmAj0YcVSg==
X-Received: by 2002:adf:cc0a:0:b0:33d:a944:54c0 with SMTP id x10-20020adfcc0a000000b0033da94454c0mr2083162wrh.22.1712765214184;
        Wed, 10 Apr 2024 09:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhlL13uLX3EZ0GsQxiY91L+XTbJxZjq4cVS06NgpPLCSNK6zwU3kFelw3sKKHLjU7Xf5werA==
X-Received: by 2002:adf:cc0a:0:b0:33d:a944:54c0 with SMTP id x10-20020adfcc0a000000b0033da94454c0mr2083137wrh.22.1712765213783;
        Wed, 10 Apr 2024 09:06:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:fa00:38eb:93ad:be38:d469? (p200300cbc712fa0038eb93adbe38d469.dip0.t-ipconnect.de. [2003:cb:c712:fa00:38eb:93ad:be38:d469])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d540c000000b00343f662327bsm12907344wrv.77.2024.04.10.09.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 09:06:53 -0700 (PDT)
Message-ID: <6517b5ae-e302-4cbe-8a4c-716e604822ce@redhat.com>
Date: Wed, 10 Apr 2024 18:06:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 12/12] mm: page_frag: update documentation and
 maintainer for page_frag
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-13-linyunsheng@huawei.com>
 <b5c5866e626f6c90657a32b5e9adff724d5896db.camel@gmail.com>
 <c1f5a78a-3040-0cc7-f113-d5ec82c6010f@huawei.com>
 <CAKgT0UfZBGEVJa1O7cdNt6zy_EEPoGo=aW6ugRKy8a44qg0j8w@mail.gmail.com>
 <09d7d59b-9da3-52f7-b039-acd0344c88c8@huawei.com>
 <20240409062504.26cfcdde@kernel.org>
 <CAKgT0UfqDRxhUyfQhwsDrRhQmCw4qNw_7Jwq+xN1Z4f6_1Bthg@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAKgT0UfqDRxhUyfQhwsDrRhQmCw4qNw_7Jwq+xN1Z4f6_1Bthg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.04.24 17:11, Alexander Duyck wrote:
> On Tue, Apr 9, 2024 at 6:25 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue, 9 Apr 2024 15:59:58 +0800 Yunsheng Lin wrote:
>>>> Just to be clear this isn't an Ack, but if you are going to list
>>>> maintainers for this my name should be on the list so this is the
>>>> preferred format. There are still some things to be cleaned up in this
>>>> patch.
>>>
>>> Sure, I was talking about "Alexander seems to be the orginal author for
>>> page_frag, we can add him to the MAINTAINERS later if we have an ack from
>>> him." in the commit log.
>>
>> Do we have to have a MAINTAINERS entry for every 1000 lines of code?
>> It really feels forced :/
> 
> I don't disagree. However, if nothing else I think it gets used as a
> part of get_maintainers.pl that tells you who to email about changes
> doesn't it? It might make sense in my case since I am still
> maintaining it using my gmail account, but I think the commits for
> that were mostly from my Intel account weren't they? So if nothing
> else it might be a way to provide a trail of breadcrumbs on how to
> find a maintainer who changed employers..

Would a .mailmap entry also help for your case, such that the mail 
address might get mapped to the new one? (note, I never edited .mailmap 
myself)

-- 
Cheers,

David / dhildenb


