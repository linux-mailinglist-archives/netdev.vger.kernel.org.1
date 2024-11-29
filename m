Return-Path: <netdev+bounces-147794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414169DBE45
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 01:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5E02822DE
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 00:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26879CD;
	Fri, 29 Nov 2024 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="rRNX524R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8AD8BF8
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732841023; cv=none; b=ExBUf+OjePtKQgDg2ICymw2WHWr8/oV4w6zUlM10AnDs4zfw57IC04pjV7BH7SJOvGMmG5Qvtd+Fu9C/GKqVBRwQh/I/nIIlJJtZuSwLeWpAMZIGXSseaKMxmpw4Pte/MZD4O4Yw2sitXWnMzxZeQiNnGQW280KFKgFRIG4J7Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732841023; c=relaxed/simple;
	bh=NI7Jt8COQZW0XDjMBb3pNri2jT7SnVvPr+A4DJ/I5HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5T/vOmf1iOyRUcN4VXw9FzV5/fJE6x36vDXkYld9KEUNRhx0jQwDdfmOnd3JK4ZNTpBpc+4hux2ipHX019CRtfVrQGIs2NorAgcDM5wscyQc/3e1mDN+iIVtVPAgWSX6ZBZq4TfQA/fvq+1aKrSYnquJq5mqUmeekDBBNSytnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=rRNX524R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21262a191a5so10884395ad.0
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 16:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732841022; x=1733445822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuPAcNfwMOW7zCG7lnxUINSPtEfZO6aB/M3eaN8CVAs=;
        b=rRNX524RzCIdg6sSSOr+PmQxZNulgjB/x6b/avQyT9huaCzI5BDQqo8Lb3j5CydQeD
         RrCQs7NTCAuPq+qjyV42NQnKPVxAOY4AuOplnEn3OfAXJI++z7cvhT2ZQI/vZUJo0AZX
         gKnw3eoHdMqruJeLt+AKUntkgeNvbvR6151TdCnybX08bCc4svFowVuRom30lXMbpt86
         agQz8Ar9aVPsAW8FEbfQ/o7qVFvUGPVqFYu/j9abyRDOhI/o3bgBUqJLGrV87sRl9fpH
         XOESKhEU/uzbyNqCGnd7i/cVPu2piNPsvM1i8Gxq7hK0ceNlsdRBDetO4uzPhBpQ6owt
         1fTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732841022; x=1733445822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuPAcNfwMOW7zCG7lnxUINSPtEfZO6aB/M3eaN8CVAs=;
        b=hnFfRSpHC6koApDiM04Qi5ZLKAWSNj6vFZNp3gisi/c4gMEsTz4WCFM8GNTaiaSc9e
         4Vg7cJQuARsmCShCHzFL0MCbWB2FCPr2A3Hh/glOr/g4Vj96okGJP74WTgFRlnZOK9fH
         R9r9IKNfpQIfbuCr+oPVwIV6B1rQ831PLBlfcqwMhNfCLxboggJyMv1ZSN0masFTMld3
         iZarLPQJp4JFqD6eGPU0t/2MC/4Kx2UIgO9k4TRIROj1AljSDKbVt3vHQnzo2vwdgmHk
         WH67Q84gHJ5hChzKqyxheMyl3IuP2upFVuiGIjuKQp9dtGtUai4VkIIM/4QFBpeAbWsh
         /NVw==
X-Gm-Message-State: AOJu0YwjdcfGMxl5t9+TXvqKzaOwbxiL0gCX/Yp6IeYWwNCgXaxaDi0G
	zzT714kFPK3CkBBvTWUUcPJo6kZ+nAdrI+IK54WeEV4NchkF3HaMa3ST93MoRL8=
X-Gm-Gg: ASbGncvM9xEsRnzJjBrhlncsA1VbVRiTWoMs9yiypeNzpPqqPhvWVCAVNM0kxlxufJ7
	lmnQOBTl5/3LkF3ym8vSZKmm3bKFgkWE84p/4HNFvGdr+k/z/5hthATeB3+W1nDxcl8KTNizZ86
	NVzSHLMJTQ4Bo6slhx0/9dVTk+8hnoR2DiwAxLtzPdOWhnw2XUEBs0+YxFcHcHanRhlwzToGStU
	IJtdFwLLhNA7kJkNEWcMpeFr26nAMwTUFbJLqWPsFATt53JkAXNU2kI
X-Google-Smtp-Source: AGHT+IGVAJgXeDKbpDif8vI/Z41UkxsG0Ynz0rkNBDCZtpBWleO3Cg60iKiWGh6DRpbzga6fXzhaHw==
X-Received: by 2002:a17:902:d4d2:b0:212:26e:7117 with SMTP id d9443c01a7336-21501b3e449mr98147185ad.33.1732841021728;
        Thu, 28 Nov 2024 16:43:41 -0800 (PST)
Received: from [192.168.1.12] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f511asm19689415ad.1.2024.11.28.16.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 16:43:41 -0800 (PST)
Message-ID: <c84c5177-2d1b-467f-805b-5cb979edc30a@davidwei.uk>
Date: Thu, 28 Nov 2024 16:43:40 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Content-Language: en-GB
To: Somnath Kotur <somnath.kotur@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241127223855.3496785-1-dw@davidwei.uk>
 <20241127223855.3496785-4-dw@davidwei.uk>
 <CAOBf=muU_fTz-qN=BvNFoGT+h8pykmWe0WX-7tw0ska=hEk=og@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAOBf=muU_fTz-qN=BvNFoGT+h8pykmWe0WX-7tw0ska=hEk=og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-11-27 19:46, Somnath Kotur wrote:
> On Thu, Nov 28, 2024 at 4:09 AM David Wei <dw@davidwei.uk> wrote:
>>
>> Commit 7ed816be35ab ("eth: bnxt: use page pool for head frags") added a
>> page pool for header frags, which may be distinct from the existing pool
>> for the aggregation ring. Add support for this head_pool in the queue
>> API.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 ++++++++++++++++++++---
>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index 9b079bce1423..08c7d3049562 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -15382,15 +15382,25 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
>>                         goto err_free_rx_agg_ring;
>>         }
>>
>> +       if (bp->flags & BNXT_FLAG_TPA) {
>> +               rc = bnxt_alloc_one_tpa_info(bp, clone);
>> +               if (rc)
>> +                       goto err_free_tpa_info;
>> +       }
>> +
>>         bnxt_init_one_rx_ring_rxbd(bp, clone);
>>         bnxt_init_one_rx_agg_ring_rxbd(bp, clone);
>>
>>         bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
>>         if (bp->flags & BNXT_FLAG_AGG_RINGS)
>>                 bnxt_alloc_one_rx_ring_page(bp, clone, idx);
>> +       if (bp->flags & BNXT_FLAG_TPA)
>> +               bnxt_alloc_one_tpa_info_data(bp, clone);
>>
>>         return 0;
>>
>> +err_free_tpa_info:
>> +       bnxt_free_one_tpa_info(bp, clone);
>>  err_free_rx_agg_ring:
>>         bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
>>  err_free_rx_ring:
>> @@ -15398,9 +15408,11 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
>>  err_rxq_info_unreg:
>>         xdp_rxq_info_unreg(&clone->xdp_rxq);
>>  err_page_pool_destroy:
>> -       clone->page_pool->p.napi = NULL;
>>         page_pool_destroy(clone->page_pool);
>> +       if (clone->page_pool != clone->head_pool)
> Just curious, why is this check needed everywhere? Is there a case
> where the 2 page pools can be the same ? I thought either there is a
> page_pool for the header frags or none at all ?

Yes, frags are always allocated now from head_pool, which is by default
the same as page_pool.

If bnxt_separate_head_pool() then they are different.

