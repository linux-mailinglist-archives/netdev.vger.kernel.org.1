Return-Path: <netdev+bounces-95254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074AD8C1BF7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783FA2825A3
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 01:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886F513AA59;
	Fri, 10 May 2024 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dmooV9W0"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F213A89A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303965; cv=none; b=XfGvG86KVfjkWO6hrPW5jc76AXd2OfQ/ahAs5lWf54WFAs8l7lZnco0PtaTzQY9VtEeKA3X8N0ZGCKRUFrdphxXgXcQpB2Ks8h7CLViZ6x1QIPDqhSAijUwcpd8tzMW7+RvhkB2Fb9cZm/lMM1gXxy+BcfSmahh8ZfYk/u/Z3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303965; c=relaxed/simple;
	bh=OES0ocJOGOCNOUpdz2lxGQKJI6TmFx00t08hjU1Cp9Q=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Uko7Q3ng7SHuWc9IQeZjV9jXz8ynhmLfBlc8f4ZX6+l0YLrd/jEBw0ZCtbpGAAvPZIXHU54zFVb3r7EEwTPMwya/tzSP4A44u2DUM/YU53jP7UnscfuYcl4RjuYZYzdEc3eUl1pFR3HWOLtZCGAAfVk+76GK+WLsyol0M2ZEYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dmooV9W0; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715303959; h=Message-ID:Subject:Date:From:To;
	bh=6tUqBykojlPtOa+QazN2Fepll1KlXCkQkFGlBoxMAGY=;
	b=dmooV9W0d2ng1bkafpVVWg2Mjmni//ivoSKlPqEegIRtrm2y5sV+H3p6yGt42KiYYtKvvBx3tH4eEWwv3DQHvryawPrOGbJhtIyCacsaG65OOSo5PvF0vqjA6rFLsibBp5mJxqNMPNDJuYd36zg5eayYj9Hu2x6BLO4CjzUwWMA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W68Tgkt_1715303957;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W68Tgkt_1715303957)
          by smtp.aliyun-inc.com;
          Fri, 10 May 2024 09:19:18 +0800
Message-ID: <1715303950.5769324-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Fix memory leak in virtnet_rx_mod_work
Date: Fri, 10 May 2024 09:19:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <virtualization@lists.linux.dev>,
 <davem@davemloft.net>,
 <edumazet@google.com>,
 <kuba@kernel.org>,
 <pabeni@redhat.com>,
 <jiri@nvidia.com>,
 <axboe@kernel.dk>,
 Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>
References: <20240509183634.143273-1-danielj@nvidia.com>
In-Reply-To: <20240509183634.143273-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 9 May 2024 13:36:34 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> The pointer delcaration was missing the __free(kfree).
>
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Closes: https://lore.kernel.org/netdev/0674ca1b-020f-4f93-94d0-104964566e3f@kernel.dk/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>  drivers/net/virtio_net.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index df6121c38a1b..42da535913ed 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2884,7 +2884,6 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>
>  static int virtnet_close(struct net_device *dev)
>  {
> -	u8 *promisc_allmulti  __free(kfree) = NULL;
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
>
> @@ -2905,11 +2904,11 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  {
>  	struct virtnet_info *vi =
>  		container_of(work, struct virtnet_info, rx_mode_work);
> +	u8 *promisc_allmulti  __free(kfree) = NULL;
>  	struct net_device *dev = vi->dev;
>  	struct scatterlist sg[2];
>  	struct virtio_net_ctrl_mac *mac_data;
>  	struct netdev_hw_addr *ha;
> -	u8 *promisc_allmulti;
>  	int uc_count;
>  	int mc_count;
>  	void *buf;
> --
> 2.45.0
>

