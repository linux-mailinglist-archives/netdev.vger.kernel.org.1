Return-Path: <netdev+bounces-112280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11024937EFE
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 07:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB15A282264
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 05:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CFCDF60;
	Sat, 20 Jul 2024 05:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KqDo/RXM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276CD50F
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 05:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721452382; cv=none; b=Ed+0MjIot1ZWynh24klf7P4BVCLQdZyOpvq7YAVOQGcrCgRryjJRpSufFeNIdmUQ6eCtmTZTUVICegUR3jderBkExE/WSscgPL7Dw/OeEwISEP92piSWZ0qsBozQCBldnW3fnfXzS0mKezzA2X63iozhQ3gO/zatBYJcC0lxvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721452382; c=relaxed/simple;
	bh=KgNKJvAXhAiWWb2wS44nW6zSzR186Z6DSPWneLuNL18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8XcSu2hJjEqmXWZIcUsAh0MF8QithwC5+Q53Tn1uviddluObxOUkJIr5/Wbab4GLvpEQQ4qrqMe+vz3N7MnOKRTzvt+Cq2b2RkT/wuHc2CRTEZTH1pWedYChHUFVe1WnHmi75a7xvxDO6GaxC49MxpVNQq2cDYJc+lanTqZWzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=KqDo/RXM; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70360eeb7d2so1281633a34.1
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 22:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1721452380; x=1722057180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tgJg0hljnE5zqpw/s2L0yzmCA56OANZosMWcuIVe6SI=;
        b=KqDo/RXMEKchRdN7T/mnOSaZnobBGW/GTVe2HIDqqhQz/vThE6Dt8yekIUTpnz06Tj
         Oj3fn1TiDFZOOxtdCl0WFudqQJur6GDJNuZXOLCsuM4g3RW12SWw51kNUsCE5v7e3O0j
         NEYfGeklfH1Cz8+fe4JQprahoLRS/tJX9a5xEtgwgft+vqZKqN9vETC5oucfCAMvpp9G
         A2imlqP0zIjBXkU3YfWkJ5FcMRumXwNkajZ4udDDL457L9HviR+z68xU5Y0Ck5wbHmBO
         36OyAP8H5qfsXvoElDvK0M4LLsA/aQ+PIGkm9X8LJaJJslVdT6PpFin+XiJv0n1K4u22
         FJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721452380; x=1722057180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgJg0hljnE5zqpw/s2L0yzmCA56OANZosMWcuIVe6SI=;
        b=wnOp8tUEX+dK/nPkQ2uLqM8Mug8T9NJGf4Sp+o/tGnzgUgQXPog6+U/uB2bg/bJIvO
         IiGW+V5LV0qqNGXT6puRV137klTKTxxHma15kRhqQ5q3Xmb6wZnjjpMcQmF+dgeYxyk1
         fwcWDZ4bdvb1gzxFTM2sygxhGG0fDOrnUb+e4g/Spnb0+UMEpsO4kUTMcbSAONnbBqio
         KAdO1Q3SgFSiXe1yFL2Iy2GGAUdaLhokgwMefcuNdqq5bMVdoFjwrZCl7wciXztKDHPa
         bo8yHeWF/4+jEr/dka/qW/tB24AFUFZvuYnlIV8XYGYIa9WwqQ0qROKxBfWb46aqpUUW
         w6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVcwGGp8d4CB/An2Jjddg1mHrH4J7XFh8aVAMK/lLjyyh07btWWd7/rvYnetwoMji8XnNiqVif7YrWV68W3x/WiJQVDo6Tz
X-Gm-Message-State: AOJu0Yy7y/3VmpGx0ln5AZRiLsDZ0IQpE8Dflbdkr4pdHfh2Y3ezJMK0
	XVm+dMA2mVj0yP2SaiqYRoHWGLixKw8ypiBLPTvGDOUVgpwShH5e9ZJfRPWRExw=
X-Google-Smtp-Source: AGHT+IHyPRUGTc6ydhXhThmtwRxD4dthMt5SswntvKJUezLsef9wI+WZFicEmeZ1V54iD2omYubQQg==
X-Received: by 2002:a05:6830:6501:b0:708:b334:de64 with SMTP id 46e09a7af769-70900927e57mr937086a34.13.1721452380168;
        Fri, 19 Jul 2024 22:13:00 -0700 (PDT)
Received: from [192.168.1.13] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0a3def52sm999297a12.18.2024.07.19.22.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 22:12:59 -0700 (PDT)
Message-ID: <74fcb647-0226-4aa4-bf99-06fee8d510d0@davidwei.uk>
Date: Fri, 19 Jul 2024 22:12:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnxt_en: update xdp_rxq_info in queue restart logic
Content-Language: en-GB
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, michael.chan@broadcom.com,
 netdev@vger.kernel.org
Cc: somnath.kotur@broadcom.com, horms@kernel.org
References: <20240719041911.533320-1-ap420073@gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240719041911.533320-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-18 21:19, Taehee Yoo wrote:
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

Thanks, didn't know this existed! As a follow up once Mina lands his
devmem TCP series with netdev_rx_queue_restart(), a netdev netlink
selftest using would be great.

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
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index bb3be33c1bbd..11d8459376a9 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
[...]
> @@ -15065,6 +15079,8 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
>  	page_pool_destroy(rxr->page_pool);
>  	rxr->page_pool = NULL;
>  
> +	xdp_rxq_info_unreg(&rxr->xdp_rxq);
> +

IMO this should go before page_pool_destroy() for symmetry with
bnxt_free_rx_rings(). I know there's already a call deep inside of
xdp_rxq_info_unreg().

>  	ring = &rxr->rx_ring_struct;
>  	bnxt_free_ring(bp, &ring->ring_mem);
>  
> @@ -15145,6 +15161,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  	rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
>  	rxr->rx_next_cons = clone->rx_next_cons;
>  	rxr->page_pool = clone->page_pool;
> +	memcpy(&rxr->xdp_rxq, &clone->xdp_rxq, sizeof(struct xdp_rxq_info));

Assignment is fine here.

