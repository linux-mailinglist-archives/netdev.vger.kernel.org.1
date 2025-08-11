Return-Path: <netdev+bounces-212595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA71B2165B
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 22:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DEC1882C33
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF1A2C21C3;
	Mon, 11 Aug 2025 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="BNTXHQol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F7311C31
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943589; cv=none; b=ABx76gUzSUSFwWts0I3A8WnxOFnnExoKaiJkc0eXpi63AlaM7mf7Msrn3O+3vIGYW5/gfcHnqC1TDGK4dbRDC16oUiOfqRHk1Qujlx1LHKkEEiSi1GIO4pzCRafck1mn9Ma7iogpdCqATIBGZc2djNcDTgkxD/oxIa31LRcW39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943589; c=relaxed/simple;
	bh=sSJ/ad4MUkAKVnAtr9sOTxm9m00jZDEE2PYBXBIh5k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8DQ11+VKqVRZLjkLu6jdmNb8AeYwF6VExUT3ZnbfS73TZ91YJ+yEb9FJLxVf8A3fVGgNuQ9bQDxTx4B/H5Q/0JrS+MlA7W/bsU0LDqmfJ6XINiCWdsAXaixCb889C/CLJA7SCgar4nYHAcXCuKPSzEhWPy3YD3/fBk2mXW0sGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=BNTXHQol; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so3280279a91.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1754943587; x=1755548387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D959IXMVDze7oXfvJioQlNfQhE71olzO+v8yu28JKQ4=;
        b=BNTXHQolSF0XLGe3xBdXVImSpzODnN+n+Z4HOlXobblyxYmagbl2E8fThu41WAI/Bf
         dFshS76K06eLLhkKJ9KTax7pbO5zwOxNKRiGiDHNLtApw7rpCVH0jaBUceR2+hZQ8Sp8
         QPBBhlYY+BHuBW6hFHgm8fRzaBSUU19etoA8bCrvo+CqzgIg5wG+dVQwEJbI0ne6peKd
         MvVBl0RBe2VEub6iK7Mwx5AhXdWdvtoMiWKnNSbut9DgpsTuX0FpT6NNzLZuoNkk76f4
         mYoPf/DkeB5SagOK6faDR8LE/CIVBwhovmi8JO0bES6tSHaYcuvA8X4oN99kr2tieyxj
         4Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943587; x=1755548387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D959IXMVDze7oXfvJioQlNfQhE71olzO+v8yu28JKQ4=;
        b=kgscemzgnp3ygn4Quf0g7pPChRz0zONMcnx+bIjhQD718L3nHgojT6NTYNSC9w+XR1
         k52/Cikv6Zn2OyjzLAvacOeRa01Ne9ZA4nBIQ0kb9GY6pRYbuHsvL0jkUM6c/5FHEFEu
         8/6cIqvU5yCVjACTinfbNMmu2tIYMG0zyzzX0vDDPHbmnkGElOQTayd6DBf0Ggz9tQ0N
         OHoqd1MzueNtGWr5H/M9+Eba5YP1o1hG3Hf3TEgNjBiosvxo2FjfblyLXPkVWAaC+pqQ
         ru/OB2VSs7SLOqxRArMr/LMOgXU/TqZbOyTnGX1DHoP+XQo5rxh39yAJ2b0ULUiG9BPd
         btJQ==
X-Gm-Message-State: AOJu0Yy723mcKyMuCvQPyezmzrkPk+49cerAHmh/k83ovf6SeDIKHvGQ
	C9RkJ9bVYx7x/QeDtLAOas+eM6lw24Oj6ba6apxPpxVnllQE1zQidIZUE8fvWTK1UfsKGr1jBsG
	JSltVI0c=
X-Gm-Gg: ASbGncs+Wms6ydff4gAurmYR5Mi8nxod0hUiaLzzAULXNKdhrV4uGRsHf53X2jfuSXg
	Glwlui5ykiiKwEdK3RtcjaRcqAYdlhL7YSDEMUDKCTkQnrsrQVuA6891dnWum4v+//kD8Bp9A2/
	522a2qPRWtlRjRpoXCZaLQvAGfbmoP7aK3V8gLStGyMpiJOVXTuSjRLnSx6uPqhkhcbm5IxE9ld
	O1JOP8NCGhc+UnhtpI9xL45M2aoiS5zPXbKIv9TVDXybrEzinbwizjlFvrgpVFL5QXJ38EJhNko
	jj6wEm3S9syHU4FyvZdsW9q9bxyt3FpaTWtn8ZG8oDk0syCP/Uar2J4DlvtPc1O5ZQhasPt78yC
	dk5MNhbMe/xGP6NI5vIlSFkU2RRX4cBjWZc+FBtNeUKstCZw75gow+iZDUcTwX263Z9IDJURiQY
	ENHpo4NxQi+dvzswCY
X-Google-Smtp-Source: AGHT+IGfFGc5mgg8XuY69tLqibsi4SnqqKhVi2wpiVhxQSy2Xpms2KWJxcnhrQK9BEyBH01ffiaHLw==
X-Received: by 2002:a17:90b:5205:b0:31e:326e:4d2d with SMTP id 98e67ed59e1d1-321c09de3c4mr1317230a91.5.1754943586875;
        Mon, 11 Aug 2025 13:19:46 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:147c:18e8:a38b:e40d? ([2620:10d:c090:500::7:1e04])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216125b7b5sm15142990a91.20.2025.08.11.13.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 13:19:46 -0700 (PDT)
Message-ID: <521bf1f1-4a22-4afc-b101-ac960781b911@davidwei.uk>
Date: Mon, 11 Aug 2025 13:19:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bnxt: fill data page pool with frags if
 PAGE_SIZE > BNXT_RX_PAGE_SIZE
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250811174346.1989199-1-dw@davidwei.uk>
 <CACKFLimKpAtt8GDGT7k5zagQfzmPc_ggt9c0pu427=+T_FST1g@mail.gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CACKFLimKpAtt8GDGT7k5zagQfzmPc_ggt9c0pu427=+T_FST1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-08-11 11:08, Michael Chan wrote:
> On Mon, Aug 11, 2025 at 10:43 AM David Wei <dw@davidwei.uk> wrote:
>>
>> The data page pool always fills the HW rx ring with pages. On arm64 with
>> 64K pages, this will waste _at least_ 32K of memory per entry in the rx
>> ring.
>>
>> Fix by fragmenting the pages if PAGE_SIZE > BNXT_RX_PAGE_SIZE. This
>> makes the data page pool the same as the header pool.
>>
>> Tested with iperf3 with a small (64 entries) rx ring to encourage buffer
>> circulation.
> 
> This was a regression when adding devmem support.  Prior to that,
> __bnxt_alloc_rx_page() would handle this properly.  Should we add a
> Fixes tag?

Sounds good, how about this?

Fixes: cd1fafe7da1f ("eth: bnxt: add support rx side device memory TCP")

> 
> The patch looks good to me.  Thanks.
> Reviewed-by: Michael Chan <michael.chan@broadocm.com>
> 
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index 5578ddcb465d..9d7631ce860f 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -926,15 +926,21 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
>>
>>   static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *mapping,
>>                                           struct bnxt_rx_ring_info *rxr,
>> +                                        unsigned int *offset,
>>                                           gfp_t gfp)
>>   {
>>          netmem_ref netmem;
>>
>> -       netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
>> +       if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
>> +               netmem = page_pool_alloc_frag_netmem(rxr->page_pool, offset, BNXT_RX_PAGE_SIZE, gfp);
>> +       } else {
>> +               netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
>> +               *offset = 0;
>> +       }
>>          if (!netmem)
>>                  return 0;
>>
>> -       *mapping = page_pool_get_dma_addr_netmem(netmem);
>> +       *mapping = page_pool_get_dma_addr_netmem(netmem) + *offset;
>>          return netmem;
>>   }
>>
>> @@ -1029,7 +1035,7 @@ static int bnxt_alloc_rx_netmem(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
>>          dma_addr_t mapping;
>>          netmem_ref netmem;
>>
>> -       netmem = __bnxt_alloc_rx_netmem(bp, &mapping, rxr, gfp);
>> +       netmem = __bnxt_alloc_rx_netmem(bp, &mapping, rxr, &offset, gfp);
>>          if (!netmem)
>>                  return -ENOMEM;
>>
>> --
>> 2.47.3
>>

