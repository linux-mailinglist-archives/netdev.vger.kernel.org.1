Return-Path: <netdev+bounces-112329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015D693858E
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 18:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC94C281019
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F366B161916;
	Sun, 21 Jul 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Pu2blCo/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18E5380F
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721581050; cv=none; b=VJ/Sfpi+w7+HoLyS5+4oPEL2ne66COEL/GOh2wYgeVWrkAiFkJS01zl2vunLyIsz/Z7OdYeu8lUS6yPz3vg1XpDhjkPFncp7B0dQQZZG1vrnnrbQWQK9L+IwFge0CCKR7X4CBGRglqrG10QqrpneSXugrki/1FUupndx0EpdwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721581050; c=relaxed/simple;
	bh=4PlMVic3jqoJLbDT6nKZ0d7igXsNjQaKsh/iUaYDAAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PS9YM/lAdEdyuGzgnAx70OhqUJAHeSIgoxABDDXZVPY4NVVTy6EhDloOd+q8nRC31dPWIDJJ5+xyVnAldpUpkHuuunXD6ax/X0DT3B13fN5GizO6BUibRMOvP4FnAunowzlbZdKl4WKxKYelPCUA+uRHXs+x6RTvPGD+qIiERD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Pu2blCo/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso2090645b3a.3
        for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1721581049; x=1722185849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XK/gb8pL49ywSSBVUoYSjqJuBUchBpKxe7dLQu0DZw=;
        b=Pu2blCo/aQccesjSxm4mbs/G+jfR2knKlzfrNTETmsu2I91zhYtlEsjHbZ7RNCe9R+
         zdIyuZblaxu98QyFYm7oymooTwLtlyZbKi5H4WziOZlLgz0Kg4GmWshAeHC3Sgcn92GJ
         M7OnIsPs/dDYt6NXhkx5rFkQynXupT6pSHqbg857H0eEIJfLHZpVrKcMV8N0FCp4gjyG
         SQJdP91uViN0N2RdyGkw/pvr6SieqaQ7k6q1ZKvv8W/0Ap3PsAqIEaRTXGHSHF9R3gkG
         aqUEKg4XNfYrX9yfK70Q+CmdhzCPmkT9dBa/7WoP0GLGOmPWg83cA4s1Vs4+9WCMDAAE
         G1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721581049; x=1722185849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XK/gb8pL49ywSSBVUoYSjqJuBUchBpKxe7dLQu0DZw=;
        b=rf4epwVCnKxVE6D0wcg9rI0B69CptGLfKBX/roevYlR9zibeOOTUccw0EOHN2qHCvR
         oHpPJUx+da+mwq3mDYrZCcO+FFAjEUqqMZAIHPVpQot+ofvL7z2DsXS4jL5Bk2T3q7jx
         3FHNq5UWSJXfIdi7SlFd6w3/5Bo06gCn2NfbTpRP/KZlZYryzXGlIyGlLw5fazntkDtR
         EY9uDVNh6vqK0pVbqNzjbVBAxJOewfu/3pxWVES4FbhB62eJIKPBju0yqtRobQn5Mvmw
         fUhaq4tRZT32iIp5fIQGJdEF7eZBweNyZOG7ys7KuRSYDLJVWwYqriJicLHXVBr2m8uR
         rSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBRhAUsI3gZiA7aV6ylB1+CcV1Gt8liIZFLZBDeuawrFvncK6HHrlKdfUQmBiv8BtIDh+x7wNpmAtaXhGPk1S4vpmm7wVN
X-Gm-Message-State: AOJu0YzRuOGdumCxnuxUo/qKp/GG0TSZ8l1fxz9fu3sfumj2bJOZj2Yw
	XfxfIG1T7xtVzS3+a8/dRA7iN2b1KnEK4mYq/b+chOwRO8oTKpKR587Ar7/2XfM=
X-Google-Smtp-Source: AGHT+IHEskCrT9WLpskMbDnzu63taCb/km07fbn7S9BCIhU2qdgSRyBRGLSh0uLjr/QOnQBN8QGoGQ==
X-Received: by 2002:a05:6a00:1acf:b0:70d:21d9:e2ae with SMTP id d2e1a72fcca58-70d21d9e8b2mr1962695b3a.6.1721581048640;
        Sun, 21 Jul 2024 09:57:28 -0700 (PDT)
Received: from [192.168.1.13] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d21ab0cb4sm1002221b3a.130.2024.07.21.09.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 09:57:28 -0700 (PDT)
Message-ID: <9f794505-9f9c-4d18-9b0f-c603ec0443c0@davidwei.uk>
Date: Sun, 21 Jul 2024 09:57:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bnxt_en: update xdp_rxq_info in queue restart
 logic
Content-Language: en-GB
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, michael.chan@broadcom.com,
 netdev@vger.kernel.org
Cc: somnath.kotur@broadcom.com, horms@kernel.org
References: <20240721053554.1233549-1-ap420073@gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240721053554.1233549-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-20 22:35, Taehee Yoo wrote:
> When the netdev_rx_queue_restart() restarts queues, the bnxt_en driver
> updates(creates and deletes) a page_pool.
> But it doesn't update xdp_rxq_info, so the xdp_rxq_info is still
> connected to an old page_pool.
> So, bnxt_rx_ring_info->page_pool indicates a new page_pool, but
> bnxt_rx_ring_info->xdp_rxq is still connected to an old page_pool.
> 
> An old page_pool is no longer used so it is supposed to be
> deleted by page_pool_destroy() but it isn't.
> Because the xdp_rxq_info is holding the reference count for it and the
> xdp_rxq_info is not updated, an old page_pool will not be deleted in
> the queue restart logic.
> 
> Before restarting 1 queue:
> ./tools/net/ynl/samples/page-pool
> enp10s0f1np1[6] page pools: 4 (zombies: 0)
> 	refs: 8192 bytes: 33554432 (refs: 0 bytes: 0)
> 	recycling: 0.0% (alloc: 128:8048 recycle: 0:0)
> 
> After restarting 1 queue:
> ./tools/net/ynl/samples/page-pool
> enp10s0f1np1[6] page pools: 5 (zombies: 0)
> 	refs: 10240 bytes: 41943040 (refs: 0 bytes: 0)
> 	recycling: 20.0% (alloc: 160:10080 recycle: 1920:128)
> 
> Before restarting queues, an interface has 4 page_pools.
> After restarting one queue, an interface has 5 page_pools, but it
> should be 4, not 5.
> The reason is that queue restarting logic creates a new page_pool and
> an old page_pool is not deleted due to the absence of an update of
> xdp_rxq_info logic.
> 
> Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v2:
>  - Do not use memcpy in the bnxt_queue_start
>  - Call xdp_rxq_info_unreg() before page_pool_destroy() in the
>    bnxt_queue_mem_free().
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index bb3be33c1bbd..ffa74c26ee53 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4052,6 +4052,7 @@ static void bnxt_reset_rx_ring_struct(struct bnxt *bp,
>  
>  	rxr->page_pool->p.napi = NULL;
>  	rxr->page_pool = NULL;
> +	memset(&rxr->xdp_rxq, 0, sizeof(struct xdp_rxq_info));
>  
>  	ring = &rxr->rx_ring_struct;
>  	rmem = &ring->ring_mem;
> @@ -15018,6 +15019,16 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
>  	if (rc)
>  		return rc;
>  
> +	rc = xdp_rxq_info_reg(&clone->xdp_rxq, bp->dev, idx, 0);
> +	if (rc < 0)
> +		goto err_page_pool_destroy;
> +
> +	rc = xdp_rxq_info_reg_mem_model(&clone->xdp_rxq,
> +					MEM_TYPE_PAGE_POOL,
> +					clone->page_pool);
> +	if (rc)
> +		goto err_rxq_info_unreg;
> +
>  	ring = &clone->rx_ring_struct;
>  	rc = bnxt_alloc_ring(bp, &ring->ring_mem);
>  	if (rc)
> @@ -15047,6 +15058,9 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
>  	bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
>  err_free_rx_ring:
>  	bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
> +err_rxq_info_unreg:
> +	xdp_rxq_info_unreg(&clone->xdp_rxq);
> +err_page_pool_destroy:
>  	clone->page_pool->p.napi = NULL;
>  	page_pool_destroy(clone->page_pool);
>  	clone->page_pool = NULL;
> @@ -15062,6 +15076,8 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
>  	bnxt_free_one_rx_ring(bp, rxr);
>  	bnxt_free_one_rx_agg_ring(bp, rxr);
>  
> +	xdp_rxq_info_unreg(&rxr->xdp_rxq);
> +
>  	page_pool_destroy(rxr->page_pool);
>  	rxr->page_pool = NULL;
>  
> @@ -15145,6 +15161,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  	rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
>  	rxr->rx_next_cons = clone->rx_next_cons;
>  	rxr->page_pool = clone->page_pool;
> +	rxr->xdp_rxq = clone->xdp_rxq;
>  
>  	bnxt_copy_rx_ring(bp, rxr, clone);
>  

Thanks for addressing my comments. Checkpatch and make W=1 C=1 also
showed no errors.

Reviewed-by: David Wei <dw@davidwei.uk>

