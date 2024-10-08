Return-Path: <netdev+bounces-132951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D04993D22
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 04:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376391F24A05
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564B224F0;
	Tue,  8 Oct 2024 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2VGnmY1O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B53381B1
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356224; cv=none; b=UFEBnrhvKKIbLxIDDLcSz9Le8MaRZhmPqsFoAOlK9EWW6oaVTG082BoRzfh/FZTd0NikBYpKhYq1CHOUEaMS92m0sxvULOUw0sGxL0pkJUav7+tOeAhjujBMbHXOp4SjfGT0hKBC7O1LpRSlFCglwjoHXZmKsh2Xm9/hKMhv05I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356224; c=relaxed/simple;
	bh=8GkUSNf25Cn9J4JQ9XYwCOdVwonJE2PEmlrutdyF10Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Akid7wigfnb0qeTzNYiMw76HrEoZ7maPXUhjczbg9ZE9xzbQx5SAXB6lUaog65CfsxGXenXsXTOOlb7V0liZTKfa9N2HCGfa5e2fMSccJZ2a+QTD5ngi4U+cQV/GqsMS48LmPNsQ/hUi11W/fPOlFYOCbxzhvKHBxALzxX9pFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=2VGnmY1O; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c593d6b1cso624705ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 19:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1728356222; x=1728961022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eZTXyt3O/zLAFP72VFPp+UUj+qAFqeGbguv+KwTUOE=;
        b=2VGnmY1OJnjN3v7+Qdbt90dBabZ6DwSzDr7ym4UDmAP+xD1c2sNGtu2atJbvys7Uql
         L9IWXZRvFV5FtnI/VCjMPjfqkWzz+OfULIc3bNx0OEFbrhu0/Wo/zW+sW2Vl2E+zQzsp
         MOsGKxMZQo8LRXGSJyGLRz3NvcDLTbOnWkg4xjdrD+A4Liuya0GRMXcn5L+HJ/ve0oxt
         F98SzCAra55r0tt06/A4AbBmm3VkPmpllsrXLoD73cTDT4RiZimmPG/P2AdeW3QjtKtz
         K6/jLf+Mb6USdAk1u8cgFZX+79xvvR1lJWrSzu2QJyRaRNDuvR/d+7RtxYNQrySR9xD0
         dT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728356222; x=1728961022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eZTXyt3O/zLAFP72VFPp+UUj+qAFqeGbguv+KwTUOE=;
        b=ecPS8j9s4/0dcXkPD5NudR3tuBEH74EhVBwn0D+MyDcdWh7dbI5nNbRt4bCspssxo7
         cXokXUZneD77srTB8+j+02xvGDXnixWqrCHHJ03Z+DUpoozGU5tPEYj8E0ao+hwhghNI
         MuoBTgNjANQVemrWegoW8rfxssubchVpdVLykRDdV/fEMpZJuf5ub7BFS7yyuzOHrN5+
         Cdmog2P8f06OFABP9AJQAawYi2SuVOovD7+dFYp4/nhxYrZ0ODnPDtzLAovNp5BNHxxq
         0QfC9qY1Ql5a9S/lzuZfC+qEvJV4arvXvHAhoHC/T+cJdeV1C48hp2+Mf5ioR4lwo20Y
         AYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXcmRDGzDjbXWXRKyCMLW6CaAl7UqQwOS/aM00F3CMe61ZVmiM3pcgxNdEwYqsTwXNeEsAiNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSjANfOjn85nJSQ7SDmylt9/U1/CI+4qnOqggMLVHa7VX3wQV3
	d68cijLJMq9rLWGS8X7HKsOkmnn4Bz5vW4R87QAUXVWtnVf3dSLt4E6r7bSLbDc=
X-Google-Smtp-Source: AGHT+IHN52YLdi9YsfHSIXKQJAGggabVSwrgLe8V8XoGt/QgSPui2fK6CCX85siC6Db8p5XpvtQt4Q==
X-Received: by 2002:a17:903:4408:b0:20b:b455:eb7c with SMTP id d9443c01a7336-20bff176f0cmr195979445ad.56.1728356221688;
        Mon, 07 Oct 2024 19:57:01 -0700 (PDT)
Received: from [192.168.1.24] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1398d184sm46395945ad.263.2024.10.07.19.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 19:57:01 -0700 (PDT)
Message-ID: <18255eaf-a2ce-4cd1-b47b-2482b6c42e08@davidwei.uk>
Date: Mon, 7 Oct 2024 19:57:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory
 tcp
Content-Language: en-GB
To: Taehee Yoo <ap420073@gmail.com>, Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
 kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, sridhar.samudrala@intel.com, bcreeley@amd.com,
 David Wei <dw@davidwei.uk>
References: <20241003160620.1521626-1-ap420073@gmail.com>
 <20241003160620.1521626-8-ap420073@gmail.com>
 <CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
 <CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-10-04 03:34, Taehee Yoo wrote:
> On Fri, Oct 4, 2024 at 3:43 AM Mina Almasry <almasrymina@google.com> wrote:
>>> @@ -3608,9 +3629,11 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
>>>
>>>  static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
>>>                                    struct bnxt_rx_ring_info *rxr,
>>> +                                  int queue_idx,
>>>                                    int numa_node)
>>>  {
>>>         struct page_pool_params pp = { 0 };
>>> +       struct netdev_rx_queue *rxq;
>>>
>>>         pp.pool_size = bp->rx_agg_ring_size;
>>>         if (BNXT_RX_PAGE_MODE(bp))
>>> @@ -3621,8 +3644,15 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
>>>         pp.dev = &bp->pdev->dev;
>>>         pp.dma_dir = bp->rx_dir;
>>>         pp.max_len = PAGE_SIZE;
>>> -       pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
>>> +       pp.order = 0;
>>> +
>>> +       rxq = __netif_get_rx_queue(bp->dev, queue_idx);
>>> +       if (rxq->mp_params.mp_priv)
>>> +               pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_ALLOW_UNREADABLE_NETMEM;
>>
>> This is not the intended use of PP_FLAG_ALLOW_UNREADABLE_NETMEM.
>>
>> The driver should set PP_FLAG_ALLOW_UNREADABLE_NETMEM when it's able
>> to handle unreadable netmem, it should not worry about whether
>> rxq->mp_params.mp_priv is set or not.
>>
>> You should set PP_FLAG_ALLOW_UNREADABLE_NETMEM when HDS is enabled.
>> Let core figure out if mp_params.mp_priv is enabled. All the driver
>> needs to report is whether it's configured to be able to handle
>> unreadable netmem (which practically means HDS is enabled).
> 
> The reason why the branch exists here is the PP_FLAG_ALLOW_UNREADABLE_NETMEM
> flag can't be used with PP_FLAG_DMA_SYNC_DEV.
> 
>  228         if (pool->slow.flags & PP_FLAG_DMA_SYNC_DEV) {
>  229                 /* In order to request DMA-sync-for-device the page
>  230                  * needs to be mapped
>  231                  */
>  232                 if (!(pool->slow.flags & PP_FLAG_DMA_MAP))
>  233                         return -EINVAL;
>  234
>  235                 if (!pool->p.max_len)
>  236                         return -EINVAL;
>  237
>  238                 pool->dma_sync = true;                //here
>  239
>  240                 /* pool->p.offset has to be set according to the address
>  241                  * offset used by the DMA engine to start copying rx data
>  242                  */
>  243         }
> 
> If PP_FLAG_DMA_SYNC_DEV is set, page->dma_sync is set to true.
> 
> 347 int mp_dmabuf_devmem_init(struct page_pool *pool)
> 348 {
> 349         struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
> 350
> 351         if (!binding)
> 352                 return -EINVAL;
> 353
> 354         if (!pool->dma_map)
> 355                 return -EOPNOTSUPP;
> 356
> 357         if (pool->dma_sync)                      //here
> 358                 return -EOPNOTSUPP;
> 359
> 360         if (pool->p.order != 0)
> 361                 return -E2BIG;
> 362
> 363         net_devmem_dmabuf_binding_get(binding);
> 364         return 0;
> 365 }
> 
> In the mp_dmabuf_devmem_init(), it fails when pool->dma_sync is true.

This won't work for io_uring zero copy into user memory. We need all
PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | PP_FLAG_ALLOW_UNREADABLE_NETMEM
set.

I agree with Mina that the driver should not be poking at the mp_priv
fields. How about setting all the flags and then letting the mp->init()
figure it out? mp_dmabuf_devmem_init() is called within page_pool_init()
so as long as it resets dma_sync if set I don't see any issues.

> 
> tcp-data-split can be used for normal cases, not only devmem TCP case.
> If we enable tcp-data-split and disable devmem TCP, page_pool doesn't
> have PP_FLAG_DMA_SYNC_DEV.
> So I think mp_params.mp_priv is still useful.
> 
> Thanks a lot,
> Taehee Yoo
> 
>>
>>
>> --
>> Thanks,
>> Mina

