Return-Path: <netdev+bounces-104772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507BE90E4C3
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88F228681A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1CF770ED;
	Wed, 19 Jun 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O9NfQard"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645073514
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782991; cv=none; b=oHGc/P433Fgn/nKRyPLhxZyM0vSebANV9cW9omSu94GL/BSqoNW24H2AxgGh2Ij65t23AW77CjT+Y8AO7/QEO/YMmyla/JvVnCGcTvnPG/FkmOx77VVpa4rILaapJTcaolDOzXBvHuku1E/IaRepJuYtKqY/Bh5r4V0E7Wa2SEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782991; c=relaxed/simple;
	bh=CWFYCLr1S9tlTDsXwd82PYiyX9o/sFArGzlmRlQeeQM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=EcRRm5UbHwSAfuYlcj77cVKAawLw6fhZzKzO5PhObgTdLTa9TXq+2fWpNCfgbK8GHpD2L6j0x67E+i1mRHZ2I3/dXqc+kxeBxDCb/+AB6XEpPKNe4ch22Qxlywzqi0j2JEn5BAV98Mn20kBwUDbYUkRlIDVlgm5ltHc1cAo0kOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O9NfQard; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718782981; h=Message-ID:Subject:Date:From:To;
	bh=wCgw5wclWH6p97tsJn6yIeHJSR+uCtIF69aE5YHRmqQ=;
	b=O9NfQardvUIqHTHXVFipwL8zB6XiCC1OgVUFWWkzgM7TgwY7m+KsQLTQXL8Ap60NQJTRcDUBhVtmm6N/rVhohd8g78/Q3rBZWCR2F4Ne96eZAlfy+jkCL8BlWv8b1XdcvXSnpXToXKAf9wfTbh6s4Z/i3mX3mybHw1g5bTAkGsE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W8nS15P_1718782979;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8nS15P_1718782979)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 15:43:00 +0800
Message-ID: <1718782933.7258735-3-hengqi@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Date: Wed, 19 Jun 2024 15:42:13 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: Li RongQing <lirongqing@baidu.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20240619025529.5264-1-lirongqing@baidu.com>
In-Reply-To: <20240619025529.5264-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 19 Jun 2024 10:55:29 +0800, Li RongQing <lirongqing@baidu.com> wrote:
> This place is fetching the stats, so u64_stats_fetch_begin
> and u64_stats_fetch_retry should be used

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks!

> 
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/net/virtio_net.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d1..b669e73 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2332,16 +2332,18 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
>  {
>  	struct dim_sample cur_sample = {};
> +	unsigned int start;
>  
>  	if (!rq->packets_in_napi)
>  		return;
>  
> -	u64_stats_update_begin(&rq->stats.syncp);
> -	dim_update_sample(rq->calls,
> -			  u64_stats_read(&rq->stats.packets),
> -			  u64_stats_read(&rq->stats.bytes),
> -			  &cur_sample);
> -	u64_stats_update_end(&rq->stats.syncp);
> +	do {
> +		start = u64_stats_fetch_begin(&rq->stats.syncp);
> +		dim_update_sample(rq->calls,
> +				u64_stats_read(&rq->stats.packets),
> +				u64_stats_read(&rq->stats.bytes),
> +				&cur_sample);
> +	} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
>  
>  	net_dim(&rq->dim, cur_sample);
>  	rq->packets_in_napi = 0;
> -- 
> 2.9.4
> 

