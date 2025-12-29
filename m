Return-Path: <netdev+bounces-246231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CA6CE6E3E
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 14:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B297F300DBB5
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4533164B6;
	Mon, 29 Dec 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk8Gtq/G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0E212554
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767015147; cv=none; b=jlUXLi4MAWnf/NUaH5wJEnTC8niVNxQ8j06cYTr9NdxxKbLaW3y7Ki2YY9wdKN1z/xv6LOsKRU21W5fchqx4yxeH4kxEcELbLofl1MsEU9boZqilBmJ0Md4TgDZ6Ret+DX4XPBvsxO0IrtpZVky/g2KVyNBYlmReD2k1cKtA/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767015147; c=relaxed/simple;
	bh=cjm2ARDU4Ilw36GA6XP8oG+tMJuID0N8F0GSM/rH/Xk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XgAQjVHxlnVdyYQ7wtveipf5+Z1Ni2Qk6T1xYZd8Nmg0iTtX/5Y4Qcu3IirCZpLT+DsNSky5Jws+fAu31JCMwTCYsG71j2jeRR8uGA6rV1DND2wrDohy68eZk1w8TEDpyrmfHnrIYfdrTNlod0lj4vAvNt6iR96Dln5XR5teAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk8Gtq/G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47928022b93so11219475e9.0
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 05:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767015144; x=1767619944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TH+hcq7bd4mxCYeCUmeAujqoUODEJoLDU3mL4QihJ+I=;
        b=Vk8Gtq/GjGO58WYU7NEBnPzu9phufBPwVWt4ajhiOfeitaJiLd15FsUrTDcoY+tELr
         8df5QK1a5pdjSK0zYybWYv6LIKHJXxbYyFjj20pb9Ki0vIuUuPjujgO0qz0ZGr7CJquA
         suBmC6GsgQZ9gMvToUnfZ5iFqVqyN1G9mvVWQZcTyazb6XyqiH5tJpoYo21+E6crRmrm
         JNIXNIq3R1cH9+se0Ecc9UtRkxUkmc6pqcKW7b6vT7dj3yZiRawpzdVxgN0Cuyw+w3z5
         a42LfvPnR/INxw2E3dvodUAAAj4L8Gm6cKPDj8KqJqEwHfNG5yPHg13Oemaii5rgR02h
         alZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767015144; x=1767619944;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TH+hcq7bd4mxCYeCUmeAujqoUODEJoLDU3mL4QihJ+I=;
        b=DNpT2tdjyZKju9xZrxfY8+MomEYCOCpnYMbgfjJxwwvdMezT6Ibz+GyUdC4InSFXjP
         YNEnYcH/tPNhPijGf+G6RTpJqnjpTUyDBmBTBoEnmvDp+rrV2vSs85OrsiOc6QiX9JTo
         4kppH+IlBs41Tl+Z25ygVhCGrVsrAUK5NCxLad6UH4m4+pn3oF5iz0cBWEQEXd3+ngiF
         iB4CXdaF/uwWpQzKQWDmj2VHZkrr/oXjoMbKkZXQXrgtK3UupnXMkal6ASUciiXpzpbA
         pqutoPQj47iemq/Prc/S60mQDDkOZqD7k8X90ksUcfH6UAE3Djg4b7OAeVYcCXYeL/Rd
         MtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeuFTG8gfo8uZ6T4uQ9n0qYVXztPqr5/1V7FbpH+MOliVrenTizkrC+qbcuSHg7t9BZh24lfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyalCEhni01ududy1874T+0NQE3BRjfXrZMqLgmYh33AjkRsNKL
	4RlB65p3ETy5tDYx9DvlzbI8gfABHOf3C0x6tPuRb0nE6XtLq/Yf+1iq
X-Gm-Gg: AY/fxX40MNdBa0oKmrl3dTZ2qm2wNhnUvj3zy/fXk3OU5lscyRQ+ltrdvSLCZsJPohh
	CFerO4NDhw4PZIsET4bMYgZXxHfa7FGK7h/X0F5Tyjex7ffKgy48M4xy/5N3kZzTUc8yv8NBubT
	YcADcP7cunEeH2np5GUkZ5zmTjB65j/JCoJR2qM2EScnmIDT9lgqlX7HyhLoF2IUuE4fJDQw+di
	5aS25d9hA8FFpwN3d/JzxMi50ubodQ3h9wI8mJRa3rb+qUAnRBqYK1Sxc9/NkX3airmJt5fiTiW
	z1ZbeBukaa4cLZTTQNCeqqTpd/TNmtCj3NPzc+oaRfUegnu5JHa76VXOJ1f8P8S8EZ6dx5yXH9t
	2Z1mWanDsh1JxMiDPH3Igkd6KDrrhaN4S92tUR80oH1u7dj5JxmfDRfGnjArBJ2buNA64ybrru6
	NgOr73PQU5xCtfxBNOCFL/0XqK9P7jmZKk+YY5y6jxrqvrqAy3NpBr
X-Google-Smtp-Source: AGHT+IHszWy0+s83zJSwanWUVcASb7lQtk8CjsaWtYMfYyLjCXdDlLtmTCgSm1MFc64raO36ZloPcg==
X-Received: by 2002:a05:6000:4305:b0:431:32f:3153 with SMTP id ffacd0b85a97d-4324e51040fmr22586616f8f.7.1767015143929;
        Mon, 29 Dec 2025 05:32:23 -0800 (PST)
Received: from [128.93.83.215] (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b36fsm62031162f8f.5.2025.12.29.05.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 05:32:23 -0800 (PST)
Message-ID: <9074448b-1b2c-4791-94ed-0ac296f0b897@gmail.com>
Date: Mon, 29 Dec 2025 14:32:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethernet: cxgb4: Fix dma_unmap_sg() nents value
From: Thomas Fourier <fourier.thomas@gmail.com>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623122557.116906-2-fourier.thomas@gmail.com>
 <aFrBED5rhHtrN0sv@chelsio.com>
 <ace152fe-877b-4df9-ba22-3c928bffa253@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <ace152fe-877b-4df9-ba22-3c928bffa253@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/06/2025 15:27, Thomas Fourier wrote:
> On 24/06/2025 17:17, Potnuri Bharat Teja wrote:
>> On Monday, June 06/23/25, 2025 at 14:25:55 +0200, Thomas Fourier wrote:
>>> The dma_unmap_sg() functions should be called with the same nents as 
>>> the
>>> dma_map_sg(), not the value the map function returned.
>>>
>>> Fixes: 8b4e6b3ca2ed ("cxgb4: Add HMA support")
>>> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
>>> ---
>>>   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c 
>>> b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>>> index 51395c96b2e9..73bb1f413761 100644
>>> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>>> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>>> @@ -3998,7 +3998,7 @@ static void adap_free_hma_mem(struct adapter 
>>> *adapter)
>>>         if (adapter->hma.flags & HMA_DMA_MAPPED_FLAG) {
>>>           dma_unmap_sg(adapter->pdev_dev, adapter->hma.sgt->sgl,
>>> -                 adapter->hma.sgt->nents, DMA_BIDIRECTIONAL);
>>> +                 adapter->hma.sgt->orig_nents, DMA_BIDIRECTIONAL);
>>>           adapter->hma.flags &= ~HMA_DMA_MAPPED_FLAG;
>>>       }
>> Thanks for the patch Thomas.
>> this fix needs below change as well:
>> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> @@ -4000,7 +4000,7 @@ static void adap_free_hma_mem(struct adapter 
>> *adapter)
>>          }
>>
>>     for_each_sg(adapter->hma.sgt->sgl, iter,
>> -                   adapter->hma.sgt->orig_nents, i) {
>> +                   adapter->hma.sgt->nents, i) {
>>                  page = sg_page(iter);
>>         if (page)
>>                          __free_pages(page, HMA_PAGE_ORDER);
>
> I don't think this change is correct since this loop iterates over all 
> the pages
>
> allocated at line 4076, not over the dma mapped pages.
>
> It also seems that when passing the dma addresses to hardware,
>
> the newpage assignment is not used line 4104 and that the dma mapping
>
> length is not given to hardware.  Is that correct?
>
>>> -- 
>>> 2.43.0
>>>
Hello Potnuri,

Any update on this patch?

Thanks for your time,

Thomas



