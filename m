Return-Path: <netdev+bounces-178630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859C9A77ED1
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 17:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D5016B201
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC70205AD7;
	Tue,  1 Apr 2025 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="o/Od6KDk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFF720ADF9
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743520932; cv=none; b=urGlQGrJ1KOFFzlZKIctadsQ9KdXPh7f5FkWuhvu+nymuGFnebNlwUzmS7JrI1FCV9N+gD3MgAVoe6sB4snd5bxLPMmmdrcimBmVVTSPSnW0OiuhRJUXztmLY11oAA9L17gJYOAVLuMk+2UfhBE2v5YH5wAFdC6nOKJwUyiWTx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743520932; c=relaxed/simple;
	bh=ikNPUFDpEMf9EorASJvZwMqDgAix5jdWrhBjd7KYtaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCctHi2KBs8DNPQBMGI1FIjqfmufValCseqKcIRX2lbO+p5m/hsaPwoCoPmhM+IZfAW+/iZIjo0QE9ndRAiCDqbu9FOurP1aYk9t3MSPbpVC6CgnYxQmmPvyx1ptscgjTby3yjUag2vu681nZ/ka9Uvbj48Nzk2tpSXTwT+za1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=o/Od6KDk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225df540edcso123525465ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1743520930; x=1744125730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p42GW0UzlpEvdCNmHDOXs5/84+MIAYbXHlyiy5Ohh/8=;
        b=o/Od6KDkcf8hJ4Ggp6tnkhQRInFqDbXDaCKW1MTK4aTsih3vSJ9nqqj33Q4aaeIOz8
         5qx+i4NlX0HpbkjWSmv+CbUFw1ahkfAVuASzPgH/syHRj7GOK39jkqrMn7YZLL9v6BHy
         RmH5qrmLSmctWOkTWHqsi1NpSNjMcsAe8iOyueQndZ0o7bsMn4W3Ky2hw8iwHoM6QzDh
         Ht5U6+H9CJ70doSbHyLHen+nBGyZY/J82sOkqWstS0gFg2KRHHE7VF+J3QrZvht98SFF
         X+kXj2dpvd5mt5yxxUbht94NLuXHeHqNIARAeLbsjjm2MCFxlRRnRRAF56hY8CdDZ9yj
         dNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743520930; x=1744125730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p42GW0UzlpEvdCNmHDOXs5/84+MIAYbXHlyiy5Ohh/8=;
        b=mDQFFXWfPTz6w9QyHbghEK8RBefSNLpiz8ylatIaA+a4cqMCeEz75wj4j+fmzoLdZU
         sE6nQu91As87Vj4i6mlOhj05LR/MExzji7hvcVfS0Rttjq5icQb00J+vz0q5moc/tb5l
         KmfZQWwOzwnduacYDmNWky0C65C48AR0RyJc3vsaXCamiXxS2x3YtQwFXKlpl0nkylCu
         lZ41bT2zOMyzazhty900kKKTvkFC6TEdiya77XFLw103xriRb/DosblL2g6Ym82dL0UO
         i1eN3gEjvRj6gDFuX7M9VPTBWR6drFrMIhZhxV+P5NxhXc/A2eKIg7SSwBvYyU7wiQ2z
         RceQ==
X-Forwarded-Encrypted: i=1; AJvYcCXloilWtgH21BEwCIxlIeaGbZte5Y5HmfQjDD+r2rCDJmkW8m2c6NaOj889SCniTDawlrPHrMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFJYaeLkxSNIh5/YiKWfhjt1dzIBLn2R+PNfcF9ABERzNGkKi
	ktXEBF0hENKg4d47X/0o4qcjB6DkG3SwAeqe1sqQ6G63cjzl14a+6gFIxzEW7XE=
X-Gm-Gg: ASbGnctv+Tk5FMXsYWYKKoqrl3bwoQWrubcMWtwTVsJ2dzXRRhgS7sm0wCM/CULwCsU
	awqIKI2qjWVDwWlLuRZHSdBJHYPrFqOM32ST8Mw41mRqv5j0i6JPDA7wDlQYKRwKVWPrOCa6ZKW
	cALJFBVqzQBG/0P2GA7gtEfpGb+W3II0sbNnnW/yWMsLv394FcVXFqwY6dclnNqGZJdg+UljtBx
	rUleuVtLj9xT/2Vy9H9FpeDaF9jKLpCor2vb7kZpk6xHOJ8IWlK9ZD6CdMqQJ8gImIKkp//4OZW
	rGOEsXA5dZOj9cJ7GUJD/CP8LrT/qyrP7E5uK6XdrjVGpU+zLSPG2Lm75lHyag9PV44/cxCM7QQ
	Wyt2RzLQ=
X-Google-Smtp-Source: AGHT+IGQSmVa5xZdqStgytNf533M3udJDP6TYHdAWfrjHuHvdF5snTq0SIqiA6FzDn1+je4IJtk2sQ==
X-Received: by 2002:a05:6a00:3a24:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-739c43a9798mr461548b3a.11.1743520929944;
        Tue, 01 Apr 2025 08:22:09 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cf1:8569:9916:d71f? ([2620:10d:c090:500::5:4565])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710dccbdsm9306672b3a.179.2025.04.01.08.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 08:22:09 -0700 (PDT)
Message-ID: <e5ea71d4-dca2-4a21-a727-4ac04023aad4@davidwei.uk>
Date: Tue, 1 Apr 2025 08:22:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/2] eth: bnxt: refactor buffer descriptor
Content-Language: en-GB
To: Taehee Yoo <ap420073@gmail.com>, Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, ilias.apalodimas@linaro.org,
 netdev@vger.kernel.org, kuniyu@amazon.com, sdf@fomichev.me,
 aleksander.lobakin@intel.com
References: <20250331114729.594603-1-ap420073@gmail.com>
 <20250331114729.594603-2-ap420073@gmail.com>
 <CACKFLinMwcWpv1Z13Si2sDPFUeRYx_aMfS=_46PWTBYmHvMm5g@mail.gmail.com>
 <CAMArcTXrryUq_D9i4ezRk7Et6qNC4jD9iGNxSELYt2qWzSREgg@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAMArcTXrryUq_D9i4ezRk7Et6qNC4jD9iGNxSELYt2qWzSREgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-04-01 00:17, Taehee Yoo wrote:
> On Tue, Apr 1, 2025 at 2:39 PM Michael Chan <michael.chan@broadcom.com> wrote:
>>
> 
> Hi Michael,
> Thanks a lot for the review!
> 
>> On Mon, Mar 31, 2025 at 4:47 AM Taehee Yoo <ap420073@gmail.com> wrote:
>>
>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> index 934ba9425857..198a42da3015 100644
>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> @@ -915,24 +915,24 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
>>>         if (!page)
>>>                 return NULL;
>>>
>>> -       *mapping = page_pool_get_dma_addr(page) + *offset;
>>> +       *mapping = page_pool_get_dma_addr(page) + bp->rx_dma_offset + *offset;
>>
>> Why are we changing the logic here by adding bp->rx_dma_offset?
>> Please explain this and other similar offset changes in the rest of
>> the patch.  It may be more clear if you split this patch into smaller
>> patches.
> 
> Apologies for a lack of explanation.
> This change intends to make the two functions similar.
> __bnxt_alloc_rx_page() and __bnxt_alloc_rx_frag().
> 
> Original code like this.
> ```
>     __bnxt_alloc_rx_page()
>         *mapping = page_pool_get_dma_addr(page) + *offset;
>     __bnxt_alloc_rx_frag()
>         *mapping = page_pool_get_dma_addr(page) + bp->rx_dma_offset + offset;
> 
> Then, we use a mapping value like below.
>     bnxt_alloc_rx_data()
>         if (BNXT_RX_PAGE_MODE(bp)) {
>             ...
>             mapping += bp->rx_dma_offset;
>         }
> 
>     rx_buf->mapping = mapping;
> 
>     bnxt_alloc_rx_page()
>         page = __bnxt_alloc_rx_page();
>         // no mapping offset change.
> ```
> 
> So I changed this logic like below.
> ```
>     __bnxt_alloc_rx_page()
>         *mapping = page_pool_get_dma_addr(page) + bp->rx_dma_offset + *offset;
>     __bnxt_alloc_rx_frag()
>         *mapping = page_pool_get_dma_addr(page) + bp->rx_dma_offset + *offset;
> 
>     bnxt_alloc_rx_data()
>         // no mapping offset change.
>         rx_buf->mapping = mapping;
> 
>     bnxt_alloc_rx_page()
>         page = __bnxt_alloc_rx_page();
>         mapping -= bp->rx_dma_offset; //added for this change.
> ```
> 
> However, including this change is not necessary for this patchset.
> Moreover, it makes the patch harder to review.
> Therefore, as you mentioned, I would like to drop this change for now
> and submit a separate patch for it later.

I double checked this when testing the patchset. The maths is correct,
though imo it just shifts the extra op (either add or sub
bp->rx_dma_offset) so I'm not sure how much it gains.

