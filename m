Return-Path: <netdev+bounces-111885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54E933EE3
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDEE1C220D0
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA2181B94;
	Wed, 17 Jul 2024 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OT7ph67H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14822181BB8
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227997; cv=none; b=fRnEK3hIk7gSu2HyuSnb0aZfTzQc9pqq0YR+3D8CM0o8+EMZ8WSHpbNMok96xx3a41Xs2sFRltxWL5jWYSLwrcAIQyRjbGSXyx9ahyFk85yrP/NSIt7XTthsW2UlSf0cD+LiQlszAn4VzC0IIiaGGwTWDEfiQhvW2bO4Eyc0bvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227997; c=relaxed/simple;
	bh=kCRuCFKH00Yv9RTb5Jsoea/ZCzt8+9ZjEpg6ljiCw9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ospKDIk67u/muZLpR6DH5MlvP/o62daXlbGGEf1JN7Ip/fNePZ533j/g9mo/Jm1MN59DzzAHBmm8UkcQ8DL44lXx5IZuty8spi+uF4JmCURr4VZiB6l2+nnC5Yg9KDQlayTQEKV6y7s0FQqLIGOB8VqhtYpZWnCuoJp/OyNMrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OT7ph67H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721227994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4gXwaQnFC8dpzAa9VOdPRef8VIf0jem3tNV2iniLUs=;
	b=OT7ph67H9EAdSuvjDGhcJHp7FD0tbg8CRCPX6q4OThT1m5fNMYeob8hZnNI7Sj7Bf3KIGy
	8syaFk7tCVEWX659HjEibTPz69apN8gtQ/+SHWLtD4HRdj9ZJ0QMSb26SMdE68mtR2FELr
	5hQvQuDQzQaBDdgUW1/V6HyIOCx/UKk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-_tMln6d-M3q2KrzVK_sj-g-1; Wed, 17 Jul 2024 10:53:13 -0400
X-MC-Unique: _tMln6d-M3q2KrzVK_sj-g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-368306717b8so164147f8f.3
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 07:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721227992; x=1721832792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4gXwaQnFC8dpzAa9VOdPRef8VIf0jem3tNV2iniLUs=;
        b=cmC6WXs/rfgmSCzTvpMahgfUldJaUgXVyGM0TZ8bTTDUMw+UXEesG7fX45iHQU9B7V
         z0AixQ0VllldDChAWnZ5RcQHBTWKhzJS4F2hERp69DDTLpPcgeTZRYoMvCBqebIK11c3
         BBVW5PCq81sCs7pAqUCFPjJ1rzoX7aLHNEfD4G5/iNsqjaJwPAs4HhRjveBot16VxmIz
         zcj8WJst/Zy24yktraOSUkY24AI79wnpgX4bSW7oiNFT/UvDc43kl8eX5auYRMZHWY8C
         h2wikBZtyJXaB2KVFdwzjjbibH5MqWc+7w4lLkpQCHcwOhjDmrJP3LEmSS3PQED1zEnU
         fOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZgpooaNCHvH6FqAwxQvC3GrUWqhEaBsRbC+IyWikzuPrUytQvc4apSEaWT8ECGkWtOLx5tmD3OIzwMcPva85wPfe0bp8l
X-Gm-Message-State: AOJu0YxQC4iAR8255xkNSfKwnZNkygSS4+icjl7AtIPbQfwvgwvXlgqy
	Fq5ZdMu6/AkecXFwdFDFQF3aaAVIRP7TUJBUgMlJ0RiWckviB2DpWjIhriYrfNBmH/1SKR0ZmfM
	5aDR2KRkbkwO1xZ4xh66NyvuYvO9Koolg+4YsVt3fbPPzztVfw67DHw==
X-Received: by 2002:a05:6000:1846:b0:366:ea51:be79 with SMTP id ffacd0b85a97d-3683169255bmr828753f8f.6.1721227992381;
        Wed, 17 Jul 2024 07:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBdo6AGAZP/xPMe0DSyU4cH0KhO5odEJXH8Kcn7QAocgC5kr4ee0+ZnX0IJlZ1mmB6yc+ygA==
X-Received: by 2002:a05:6000:1846:b0:366:ea51:be79 with SMTP id ffacd0b85a97d-3683169255bmr828748f8f.6.1721227991950;
        Wed, 17 Jul 2024 07:53:11 -0700 (PDT)
Received: from [192.168.1.24] ([145.224.81.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77d4f8esm879435e9.21.2024.07.17.07.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:53:11 -0700 (PDT)
Message-ID: <498dac82-3fbe-4490-a322-bb7420370d0b@redhat.com>
Date: Wed, 17 Jul 2024 16:50:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] eth: fbnic: don't build the driver when skb has more
 than 25 frags
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 alexanderduyck@fb.com, kernel-team@meta.com
References: <20240717133744.1239356-1-kuba@kernel.org>
 <43bc03f0-5e5a-4265-898b-8ca526d6cc75@redhat.com>
 <20240717071218.72ec1bc6@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240717071218.72ec1bc6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/17/24 16:12, Jakub Kicinski wrote:
> On Wed, 17 Jul 2024 15:44:09 +0200 Paolo Abeni wrote:
>> I think that with aarch MAX_SKB_FRAGS should be max 21. Aarch cacheline
>> size is 128, right? The frag independent part of skb_shared_info takes
>> 48 bytes, and sizeof(skb_frag_t) == 16:
>>
>> (512 - 128 - 48)/16 = 21
> 
> Hm, my grep foo must be low, I don't see aarch64 with 128B cache lines.
> But I do see powerpc, so we can stick to 21 to be safe.

Yup, it looks like I was wrong with aarch64, but there are indeed other 
64bits arches with 128 bytes cache line size.

Given this impact builds, I think we are better off with a fast repost 
(before the 24h grace period).

Thanks,

Paolo


