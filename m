Return-Path: <netdev+bounces-104327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23C290C2E3
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41901C21B77
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 04:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305D1804E;
	Tue, 18 Jun 2024 04:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="FzfSrhKE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB441C01
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718685413; cv=none; b=bkUHM6bi2BNUX5+st4acFj5fuM1yZaImCpX7hsiVDlElSe1ugeeoKIb5WYpm/mPfy6KFHKWTqynl9xgBBbEoIY3AEjitxB7SRhCeTcGhELMCR6YRLPl8a8JgF4jNFF+cD5q9hCuzObd/UpnlRwAH55NtQigSeI2GaTiK1IYAAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718685413; c=relaxed/simple;
	bh=IpXZUzNvSWlAdRUsV385stqgnIb9Id5o9HVEpLsEx+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTtYbSg7BZRuJ8s8qzsNugFJzRvfJqYOjzA7+nrLD1G8GPoBcIUYy/GXznzKuTiuZkhZlcjlFizsRqnFvcH3onvjCN0C2x3IfC1kKK8jl3zRgQTXx/MSFcee/unlBwe2IHugj9donyAbzjrKxuYjfyWt6U2oUXzp1JfttQayPbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=FzfSrhKE; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so4187789a12.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 21:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718685411; x=1719290211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpFaV6xidvhmzURzekcrOa5Ggky9tfyLtp7fcoUqxL0=;
        b=FzfSrhKEFaGbG4ShXC75hcCOT20le2Z8LrcqCXsMZpdRUGKfngPtefBPhiUhC2Owhu
         XhGc2kkXEqaHMyaFs3lNbeVtwKERyJJjbHd0fEEL04LW1LC6SQ9x/cRUODv2koY3WJ5Y
         1HGgNpUC5WQVoQkxYinGvuN+HRl7nt1lbjWIYPMn2tYthia2vrXuAsiqO+pFCB2mzCAY
         NVCB8oHjDsRpHOC9oNxSaU6rm/APiIh5/47bpNRYj0PBM1Im0EWjEZPXO/GAcIWyspIv
         euUljv+OL0LoZhLpkJOc4DNqm7oBcC/gJZGDmBuU4ovQOQYp5ASgnnY91aOEkhwhfrgP
         YGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718685411; x=1719290211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpFaV6xidvhmzURzekcrOa5Ggky9tfyLtp7fcoUqxL0=;
        b=K/LUR7kbjqawqurlUa9uDO+Ie6eurYDMyjCa2XKa5QS53mY/uATM9M6pXXGRiypYwe
         fKO1ej8857NVX70WUNxgPp6uY83gjpZ8vbc8o8cbeyQT8jB4BcgHIi5b9GNP++2q+RiW
         RzZaL36vL0Uqiv6DV/8t/rde9UFUA/QAAegtzf1uWB98jYxEI1uZMzg3xZhiErUByhGj
         9cs1l+UMMhYOQV1qyKwPkOYN00PGH8b3cyHqhqcyuFqtzFUCc6Re+ybJf7gjqivJQI2t
         xLLSMM5gN3So3BNKJCVvaCLXb7fuDCttgPZE2LmJzuCgGOgbkF0Bt9hpYXcvYwnykKUS
         EXoA==
X-Forwarded-Encrypted: i=1; AJvYcCXTdNQC7HHk+YT/G2VXtkTODtolSYiGwfxCy3nKGpTNyM7goAoBp9prbvxoeVDg4uBd8YoTgHV7ptxWNqlxOI1V/2C1Gymd
X-Gm-Message-State: AOJu0YyWx36mUqWAFSWa9HAHcPbwqrlPNj9s+9GILS+c7nOK31nIZvqB
	AE6e2YEer481aVokNf8B29oa7xcJxaO74Z+Xt37JbpnaR1WNtzb6810qYvBCPCE=
X-Google-Smtp-Source: AGHT+IGX7nu8IAtmtAp3bkvh5HB5Mdxa25YRsUv0hdfQ8Dfpix4fXdjoaZDUeUQU8frM+dBdSE117g==
X-Received: by 2002:a17:903:2443:b0:1f7:1d71:25aa with SMTP id d9443c01a7336-1f98b213273mr23936345ad.6.1718685411114;
        Mon, 17 Jun 2024 21:36:51 -0700 (PDT)
Received: from [192.168.1.8] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55c6asm88239345ad.5.2024.06.17.21.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 21:36:50 -0700 (PDT)
Message-ID: <38c072b5-ba08-4283-a3b3-dbcffcd1a3df@davidwei.uk>
Date: Mon, 17 Jun 2024 21:36:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 3/3] bnxt_en: implement netdev_queue_mgmt_ops
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240611023324.1485426-1-dw@davidwei.uk>
 <20240611023324.1485426-4-dw@davidwei.uk> <20240614200751.GY8447@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240614200751.GY8447@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-14 13:07, Simon Horman wrote:
> On Mon, Jun 10, 2024 at 07:33:24PM -0700, David Wei wrote:
>> Implement netdev_queue_mgmt_ops for bnxt added in [1].
>>
>> Two bnxt_rx_ring_info structs are allocated to hold the new/old queue
>> memory. Queue memory is copied from/to the main bp->rx_ring[idx]
>> bnxt_rx_ring_info.
>>
>> Queue memory is pre-allocated in bnxt_queue_mem_alloc() into a clone,
>> and then copied into bp->rx_ring[idx] in bnxt_queue_mem_start().
>>
>> Similarly, when bp->rx_ring[idx] is stopped its queue memory is copied
>> into a clone, and then freed later in bnxt_queue_mem_free().
>>
>> I tested this patchset with netdev_rx_queue_restart(), including
>> inducing errors in all places that returns an error code. In all cases,
>> the queue is left in a good working state.
>>
>> Rx queues are stopped/started using bnxt_hwrm_vnic_update(), which only
>> affects queues that are not in the default RSS context. This is
>> different to the GVE that also implemented the queue API recently where
>> arbitrary Rx queues can be stopped. Due to this limitation, all ndos
>> returns EOPNOTSUPP if the queue is in the default RSS context.
>>
>> Thanks to Somnath for helping me with using bnxt_hwrm_vnic_update() to
>> stop/start an Rx queue. With their permission I've added them as
>> Acked-by.
>>
>> [1]: https://lore.kernel.org/netdev/20240501232549.1327174-2-shailend@google.com/
>>
>> Acked-by: Somnath Kotur <somnath.kotur@broadcom.com>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 307 ++++++++++++++++++++++
>>  1 file changed, 307 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> 
> ...
> 
>> +static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
>> +{
>> +	struct bnxt_rx_ring_info *rxr = qmem;
>> +	struct bnxt *bp = netdev_priv(dev);
>> +	struct bnxt_ring_struct *ring;
>> +
>> +	if (bnxt_get_max_rss_ring(bp) >= idx)
>> +		return -EOPNOTSUPP;
> 
> Hi David,
> 
> I guess there was some last minute refactoring and these sloped through the
> cracks. The two lines above seem a bit out of place here.
> 
> * idx doesn't exist in this context
> * The return type of this function is void

Hi Simon, thanks, you were absolutely right and these slipped through at
the end. Will be fixed in the next version.

> 
>> +
>> +	bnxt_free_one_rx_ring(bp, rxr);
>> +	bnxt_free_one_rx_agg_ring(bp, rxr);
>> +
>> +	/* At this point, this NAPI instance has another page pool associated
>> +	 * with it. Disconnect here before freeing the old page pool to avoid
>> +	 * warnings.
>> +	 */
>> +	rxr->page_pool->p.napi = NULL;
>> +	page_pool_destroy(rxr->page_pool);
>> +	rxr->page_pool = NULL;
>> +
>> +	ring = &rxr->rx_ring_struct;
>> +	bnxt_free_ring(bp, &ring->ring_mem);
>> +
>> +	ring = &rxr->rx_agg_ring_struct;
>> +	bnxt_free_ring(bp, &ring->ring_mem);
>> +
>> +	kfree(rxr->rx_agg_bmap);
>> +	rxr->rx_agg_bmap = NULL;
>> +}
> 
> ...

