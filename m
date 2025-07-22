Return-Path: <netdev+bounces-209018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61826B0E009
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A511C86E67
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEF52EB5A8;
	Tue, 22 Jul 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+8I33Nl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FBD28A1EA
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196623; cv=none; b=ZwJPo4Rq0leOe2yZkRbzR4IdKQGiVRdcsV+cfBduBBvCF20yjcL3LIHkOls3SfUdUkysbN6ROOEF4/4LVurf/hqYmM2XcHNdKrvKFsoC7KzOvejlmeJ2oIc48Klk0oaNQ7D2FPv7RJQnE46Y5Ryb0CKyFfi3ENi/Lkflsn/PsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196623; c=relaxed/simple;
	bh=z2gj5V7u4WprQQoCZFJO+IylNg/HsgVNMYcaqhQgwVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEPY4XKvbyBA3twxKbbAIjIKdFi6emWFv9OUYjkrKlK6sLii9zmn4wGpZoZK8ZzPt7MJuBeKki/0r2yTnBsC88s73h3WRqhiUe16Jqp/5/sG1/cYWWD98TnGTXah+21Z2vmAVkvk12V67N+BqQ9A+80w7kG/aIAi+0c3hvna9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+8I33Nl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753196620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLoXN0zviuhjRHlOKL2rQE3hdCG3gOLWxmD1fwrgVH8=;
	b=W+8I33NlCzefY9VilWlrriOctn6SJomNs5+xwMo6/1GozuOUPTZPfHYVOMGzREjC5rmwpz
	glp2usBy8gBJaWTvwZBj4A5+qZo+wtHqfCBn+DVh5BM9a4rF1D6XzMN7zgdo9E6c3U40zB
	xckBRkpiUjtPcOuqVgBy9R19hErlQTE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-hys1L7g0PQCd10cDdQ6Ttw-1; Tue, 22 Jul 2025 11:03:37 -0400
X-MC-Unique: hys1L7g0PQCd10cDdQ6Ttw-1
X-Mimecast-MFC-AGG-ID: hys1L7g0PQCd10cDdQ6Ttw_1753196616
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4563f15f226so11311605e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196616; x=1753801416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLoXN0zviuhjRHlOKL2rQE3hdCG3gOLWxmD1fwrgVH8=;
        b=rJ+haFq3HKQ2ld/GYijW5shth90A27ZVc9ffZt8GpyKdMzseQpJIHNGBOGQkh6RyTd
         Sc96/VnIYdVyN2FVhgfvW2a8PCa+/MXUjJO4Nf+CGwZklLOpddklFB6ZdZqKwIfxGo58
         AhVh/O9J6LnL/6R5bsy04PQCsJy4nrkB0oGnFXfjflfyGqCfhvFm31r1W8oZUZRklNMs
         3i6l4obeGSEy0wWyPYnCB9CGVULY4YF4rB+i7sPIC0HHZ3bWwYeoOT8jGxSnnQXMTJ7i
         qzqAfxtV7rn4eMlmgTwGlqg7UVA1mB7VMsCMMUMGROm0PjYctfozLYe6sD+g+WafQeyr
         UGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfRWqNYFaVwgzl0NJfA88gkxHovfZ0ECCnL4b6S82KM46r+lq4ra1Zx4Xee+dNbCjRb/ljiCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8DUAe3IrvInmxIZGF044XyDwrfuStJhWGV2a+mHrCIMfQnYZR
	JTXH10BuoC2W3iBHPGr/igT1O8cc97gnFetxTJM4et2hb3twvV/6TLsxM3Qh1BiBxtynZPrD9OG
	63HXwapwPt8SCksgBnJC03PRausdmxcb3FZ1eDWsO041TEuqXady+51C2dA==
X-Gm-Gg: ASbGnct7ecwteDDbGWoxql201Ql6Rrr7TAA6vk6A+M2E0PjMwve3ytRxPZZ0OTRyaY2
	2JGLkLxjvgP7pljQw1UfMn1rFqdTsNK/V4gpdPZJY6I5W2BWGRm+l4Tbz9pHcbEoYvN94RXk5cb
	pa0XBcBAF8YUbixebZjs8sNOiKDBePKzLOf555UZfOUwKN2aNr1Utye53vhnwXRuYW3ODI0jVA3
	bWL18Mou2vvWyFSRa7lODQyRYS7pd3qtD9xYxBAobetcintBeeTonxVm0WofY5zQ2fUxuwJKqi9
	MD9Uyq6uhSVI4X9fdKwORKq/dVU5Ar/1HDgm4Ty01nfs+RSGsV+1HYI2wVn4+Rshrzyv/S6G9mu
	Zg2IAxUuXnn4=
X-Received: by 2002:a05:600c:8588:b0:456:22f0:d9ca with SMTP id 5b1f17b1804b1-4563bf262e3mr103369955e9.26.1753196615970;
        Tue, 22 Jul 2025 08:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXBjtom7DfrBS3RzSHHM2jEi5VfD/84zxgrNdm4BqqX7Z5GS1hjLJJaVsZOKAqO1uS8F1VCg==
X-Received: by 2002:a05:600c:8588:b0:456:22f0:d9ca with SMTP id 5b1f17b1804b1-4563bf262e3mr103368725e9.26.1753196614818;
        Tue, 22 Jul 2025 08:03:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b73fa43sm131621725e9.21.2025.07.22.08.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:03:34 -0700 (PDT)
Message-ID: <eea3a104-1cb9-4606-9664-a8beda93e018@redhat.com>
Date: Tue, 22 Jul 2025 17:03:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
To: Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Nimrod Oren <noren@nvidia.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 shuah@kernel.org, horms@kernel.org, cratiu@nvidia.com, cjubran@nvidia.com,
 mbloch@nvidia.com, jdamato@fastly.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, tariqt@nvidia.com,
 thoiland@redhat.com
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
 <20250719083059.3209169-3-mohsin.bashr@gmail.com>
 <ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
 <20250721084046.5659971c@kernel.org>
 <eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 8:34 PM, Gal Pressman wrote:
> On 21/07/2025 18:40, Jakub Kicinski wrote:
>> On Mon, 21 Jul 2025 14:43:15 +0300 Nimrod Oren wrote:
>>>> +static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port)
>>>> +{
>>>> +	void *data_end = (void *)(long)ctx->data_end;
>>>> +	void *data = (void *)(long)ctx->data;
>>>> +	struct udphdr *udph = NULL;
>>>> +	struct ethhdr *eth = data;
>>>> +
>>>> +	if (data + sizeof(*eth) > data_end)
>>>> +		return NULL;
>>>> +  
>>>
>>> This check assumes that the packet headers reside in the linear part of
>>> the xdp_buff. However, this assumption does not hold across all drivers.
>>> For example, in mlx5, the linear part is empty when using multi-buffer
>>> mode with striding rq configuration. This causes all multi-buffer test
>>> cases to fail over mlx5.
>>>
>>> To ensure correctness across all drivers, all direct accesses to packet
>>> data should use these safer helper functions instead:
>>> bpf_xdp_load_bytes() and bpf_xdp_store_bytes().
>>>
>>> Related discussion and context can be found here:
>>> https://github.com/xdp-project/xdp-tools/pull/409
>>
>> That's a reasonable way to modify the test. But I'm not sure it's
>> something that should be blocking merging the patches.
>> Or for that matter whether it's Mohsin's responsibility to make the
>> test cater to quirks of mlx5, 
> 
> Definitely not a quirk, you cannot assume the headers are in the linear
> part, especially if you're going to put this program as reference in the
> kernel tree.
> 
> This issue has nothing to do with mlx5, but a buggy XDP program.

Note that with the self-tests we have a slightly different premise WRT
the actual kernel code. We prefer on-boarding tests cases that work for
some/most of the possible setup vs perfect ones, and eventually improve
incrementally as needed: the goal is to increase the code coverage _and_
encourage people to contribute new tests upstream.

We try to avoid breaking existing tests (at least the ones actually
reporting into the infrastructure), but for new ones the barriers are
intentionally different than VS kernel code.

Cheers,

Paolo


