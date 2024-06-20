Return-Path: <netdev+bounces-105328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA07D910797
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6311F21BB1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE401AD4A3;
	Thu, 20 Jun 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxdjSK5w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E8E1AD486;
	Thu, 20 Jun 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892550; cv=none; b=tG9oJ1+e3D4RjqX0rwc+KiqvnAiRN5c/Akwme3wlSquLFd4e7X+vAtUufGg9qU5tT1OEI/A96eaS37uTNv1buvkJjBqMQqm0k8m57qjpQmodcfVC3WIgFJCXfJpUJqzHXMX1mPYOOdszw0e7Vg1OsOEXTr6z15QoO0R3hAzvRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892550; c=relaxed/simple;
	bh=etDIzRCNZUggUP9Ms5ILVfj1z7ZS2DIQWqYMJnxqJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PN+NaoM9jFf0qD/7mv0pfbqyaXtvHRNNwYVXTXml12CxdhjpzLqhbm48D+htv7dsASpYswNWbbzp28RGmM2+zAEPkLnBjpz2VNobVKEpUxRC+1NV/GIGZyu8jhZOZN4nzWDWudRmbhySEjIzbvy3v5W5qxJXD3i7ks/4CxMc7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxdjSK5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946C1C2BD10;
	Thu, 20 Jun 2024 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718892550;
	bh=etDIzRCNZUggUP9Ms5ILVfj1z7ZS2DIQWqYMJnxqJlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qxdjSK5wue7ylnNY68l9J7BOg8kQKvJs118G3JOgLJoPKNtLsYWzIItQ1LU0lxA2+
	 phPkBdqEj0fYjYrmEuDIIAAYwYKrIONvceRlzmOK9dUroOXGKIyOtVSF+rrEKkr2iF
	 40FuvbG1MJ8102jfXjiQr3p6HyzkBlBg/T5jPBvV7k45T1ofOSv7inctyM78WET3io
	 uF0ttzFf/8Wlw8frSztSSqRKWVPLWS0GmwnxXWZeMl5F+9+Uj4F8tFqlGdeBZUHP7v
	 31QXiKfe7oct7Y9Kv4ijr6dCAB3OyI+spS+GLAkP9MpgVbgYtniYgChh1+695DIVHh
	 vMSetfc1XKC4g==
Date: Thu, 20 Jun 2024 07:09:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, hengqi@linux.alibaba.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Message-ID: <20240620070908.2efe2048@kernel.org>
In-Reply-To: <20240619025529.5264-1-lirongqing@baidu.com>
References: <20240619025529.5264-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 10:55:29 +0800 Li RongQing wrote:
> This place is fetching the stats, so u64_stats_fetch_begin
> and u64_stats_fetch_retry should be used
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

Did you by any chance use an automated tool of any sort to find this
issue or generate the fix?

I don't think this is actually necessary here, you're in the same
context as the updater of the stats, you don't need any protection.
You can remove u64_stats_update_begin() / end() (in net-next, there's
no bug).

I won't comment on implications of calling dim_update_sample() in 
a loop.

Please make sure you answer my "did you use a tool" question, I'm
really curious.
-- 
pw-bot: cr

