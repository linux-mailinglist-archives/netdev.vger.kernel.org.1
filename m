Return-Path: <netdev+bounces-198021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2CCADAD58
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C0A47A8BB3
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A12777E4;
	Mon, 16 Jun 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U85AwX1h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5D264FB4
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069675; cv=none; b=JIjmHq0+tVQQns8PRjbCRQc9x1YtJeExUzmk7seEbPK02UN8HsEaFgK5rhRrsquOzMzt2jKdSptqp/siqdlTD+84SZIUoQttMCu2RWGW9AjC21g5RpoURWdgW2QJkKVvWIhDZ5fN26r0by6wpGrVaW5TKdW4RthmkNN4M5naINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069675; c=relaxed/simple;
	bh=5LzQijiu/p5O6FBhUQ/Lt7GJHoI4biz/rU84psJrRNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LT6HdhGI+kmdbX+UVxvRVgUrVJMAd8+Cum0UZp0RytxMgkQOH9HM0t+tn/mil155U9TLPBKwfCalsboVde+7mXDBndcsG/2ouedNtDn+NfamKHztaeVEcmRjOfyTDtRlj/Jed1UsuV+7+93JZA6d2tmFUErzADF7JbGlxqygjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U85AwX1h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750069671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFXMPQE6eNAFkhRUtW5vmk03nH39LxHIXXQdwxMC9ek=;
	b=U85AwX1hKwk/JmQCSmxqPXG0ndFfwkxh9CQpz8sMxHbs+Z9gpAZ4a4i3yYQNj/ZxFg0K5a
	XeL3ZLvwsC5S0XWlmv5WpHFYaQPlsG/zRUJ9+G57XYYniumLoytVXexbhy1K6disGNYjhb
	KXUzNuzgqmISABp1doDfA2zWAg3X+YA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-z_syiCA6Obu7ewRoFm-22w-1; Mon, 16 Jun 2025 06:27:50 -0400
X-MC-Unique: z_syiCA6Obu7ewRoFm-22w-1
X-Mimecast-MFC-AGG-ID: z_syiCA6Obu7ewRoFm-22w_1750069670
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f3796779so2939253f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 03:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750069669; x=1750674469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFXMPQE6eNAFkhRUtW5vmk03nH39LxHIXXQdwxMC9ek=;
        b=ali0O6oThGor5s0rpygOnLRVFP3wHAJQLa7pDmGJ15+dJONtbQRcNxkesaMjeSCnob
         dSLJrBVHsyoTDsCKJCtI/En3breLbYADWc61sad3oa3D662ybK6Hv0RRMyttSIjHCdSa
         fNVMEnGUbII4Efbktga0BhvAvj/S2XgBoD49QO7zKg9Lr+m4DLc/x5cJs9Uc5/YfOGmC
         z7G5qjr3In7SWlkelUhTRd4iT3UU/yucDbG2Um/mYnL9ONnUqk+atdR2qpoBWQ6cBkQO
         6B2a+/5wt2mAX10U2b+8lVEU2i82j1gLZknPURUT7abT5mj/DU11vJpLyEmo7BpXDqGL
         Ud4A==
X-Forwarded-Encrypted: i=1; AJvYcCUS1rAyrtOAFJt2oDzTY5HKkhMtCubqUBfuZx1VQpOu0j5y0ndbM2FOC3xTBY1nMj/tgsRm9AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDHBf1Krzt1Z+f3jMdj6YhkngtXVfiBaCzhLyNeqFkiaHf6U5N
	afrHF67fsheI+1YoLqslPPpArF/hNRaPi422tvishCIOdR1D6s1G+j2qTIXWwlI8f4L71lxYk/A
	aXhbQvHcWF/OWCHcLUT415O1H6NcGKs6aUWgK9Zvk5FHBICf3tO2uEU1xYw==
X-Gm-Gg: ASbGncv+LOX6705964A62GxSl0ZJDmtnYdi8+apKxVNRl+QYwBAU25Izr6tAWOlTpnd
	Wf87Uzh2zlkSUi9roiaHE93zcZ9SDq17hALpBGqa2qCJTt8B+5IFYCNVabDDU3Ib4zfIA0i1z2N
	ARTvx0jzRmiISY6fTB0e5D3wYuwERODIx/HtzCv4UvdL8vpOpLgLXqEG91d/8kyixbIO1J+TMeX
	qXh3bkwqbtE3loSG0+bgJzdGPXXznqGBRgLY6DPogpEBR8uZAhNrloDvnR9+/8nVYa05ybSd/j0
	cAESmhKbt2CuV+EgkNrgCcFK7+s59g==
X-Received: by 2002:a05:6000:2313:b0:3a4:ffec:ee8e with SMTP id ffacd0b85a97d-3a572e795dfmr6996912f8f.36.1750069669558;
        Mon, 16 Jun 2025 03:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCvCUNzKOOf53SMq/Bg7rwMA/8vUIyIHeq4fNWUDtnoQ5QY00Mk+5fYBDr4KQySXEfyUtfNA==
X-Received: by 2002:a05:6000:2313:b0:3a4:ffec:ee8e with SMTP id ffacd0b85a97d-3a572e795dfmr6996891f8f.36.1750069669081;
        Mon, 16 Jun 2025 03:27:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10::f39? ([2a0d:3344:2448:cb10::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea17d7sm138899735e9.10.2025.06.16.03.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 03:27:48 -0700 (PDT)
Message-ID: <1f436638-1aa8-48b9-95db-cef81a6333b4@redhat.com>
Date: Mon, 16 Jun 2025 12:27:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/8] vhost-net: allow configuring extended features
To: Akihiko Odaki <akihiko.odaki@daynix.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <960cefa020e5cfa7afdf52447ee1785bedea75fd.1749210083.git.pabeni@redhat.com>
 <0497f70f-3c6a-4ecc-97e9-4487b3531810@daynix.com>
 <78d97778-06ec-4080-a9c3-19a754234f78@redhat.com>
 <ebf8e65a-9907-4ecf-a411-7002f11b9d1f@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ebf8e65a-9907-4ecf-a411-7002f11b9d1f@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 10:57 AM, Akihiko Odaki wrote:
> On 2025/06/14 16:27, Paolo Abeni wrote:
>> On 6/8/25 8:16 AM, Akihiko Odaki wrote:
>>> On 2025/06/06 20:45, Paolo Abeni wrote:
>>>> +
>>>> +		/* Zero the trailing space provided by user-space, if any */
>>>> +		if (i < count && clear_user(argp, (count - i) * sizeof(u64)))
>>>
>>> I think checking i < count is a premature optimization; it doesn't
>>> matter even if we spend a bit longer because of the lack of the check.
>>
>> FTR, the check is not an optimization. if `i` is greater than `count`,
>> `clear_user` is going to try to clear almost all the memory space (the
>> 2nd argument is an unsigned one) and will likely return with error.
>>
>> I think it's functionally needed.
> 
> The for loop tells i cannot be greater than count, so i < count will be 
> false only when i == count. 

Right you are, /me goes grabbing more coffee...

Thanks,

Paolo


