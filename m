Return-Path: <netdev+bounces-99328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60E88D4836
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D299B283350
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD642183990;
	Thu, 30 May 2024 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAIzVttm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1918396B
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060625; cv=none; b=qsy3UPxI4VMn/Fitdxuj0ap5H1AnC1PgsrBR2nz0pHQ2CbbDtKsGKQYyaYFdXSmvJvzNUkQk/OP7UGD2KQEer3Bv6iRAr5uv5qjQ6lUhfTkrDD0M4jPPNK/lhLL+gY/ls6u4F0rTkOgPw+dpUDNzDMAurPnWPZZ9Tfcb1ntnAXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060625; c=relaxed/simple;
	bh=Qvvm7yXi7fdn9ZQxdd4sSR2uFtuRkZJ1zm/Rv/gmONE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbgjPC37an9ojpuAnOH+MbSWJuXQqOQvhOSYB8wFGS0rm3T2TImS0nO9LlC0P+15ZnFoo3Mnn6/Oew71kkyJy1+typ3J9m8lYH76WypNIk/CaOFegQ+GdC/+A1tiT0Nb4RPicSswZzlC8OENCE3HzMVxu5KTlPSoBweS9/KKi/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAIzVttm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717060622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMkW1PqnAjWl0A+6StZOUl5hBdvwmGS5SCjr1iUxRvU=;
	b=iAIzVttmTW7D4PjEYZdKKKs1rXptAXYkqiUv/S4oTuj2IVAyeX1q1sX2pcQgXfNxtoDxmh
	XYFN2uJHgLLBTyUfzFL+K4YXl1BnHBHDaToZ/ld5K3g2QiNcv6ah6EbCC7wDl04CdnOlhJ
	5zYnuXHidA81imXKm8M4tTC4Tk/+lMs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-j40g5-C1OFyzVJZAZbm68Q-1; Thu, 30 May 2024 05:17:01 -0400
X-MC-Unique: j40g5-C1OFyzVJZAZbm68Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dc0949675so540510f8f.3
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717060620; x=1717665420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMkW1PqnAjWl0A+6StZOUl5hBdvwmGS5SCjr1iUxRvU=;
        b=tZ+cWXthHTzadwdQK6deBd+qD1PVyjLV4pVBMQul2fMErmI0qde6ac+gj6PQXY9x0G
         jwX8W9d/6Z1YrpJMopdENZVm5/VxBkBJmZ0No/sBQxFygLVyKIvoWB6CpqYOYQn8NuNK
         rIAhFYYeyk//Qa2mTr04cE9N7eEs6lpYT4wllA0CtSXmN5sys/THdTRJhzTE7L3W7A1k
         FSmZHtr4HT/hcV4LCix8CiV2/XyaB/gCJLduDO2OKUUcvV7j8zq6CUtjrbxMlFd3v8qG
         cjXkpFLbtsCc+BeO0gx0KRIK5/s14lkUiG7uRb1KPWs5upsrlqwIuGrvRzbBfHYdWMEi
         Q1kg==
X-Gm-Message-State: AOJu0YwPls3VY946qrFghQyR4JvLLKE9NzokxDsm+LM3p0NdM99r5VyB
	LSfnjq5ssEzZ0q9JP/cU/5AFgjQAMdXrz7AjxWF0XFVC6e3KAGXCvt1n5C4TDs8VIyeeEP9oYn/
	OSLKNI8lNYjeF2SvMy2qIKhsBplBch3Ds2OGive79v+c1ynuMJQhoqA==
X-Received: by 2002:a5d:6850:0:b0:354:eb62:365a with SMTP id ffacd0b85a97d-35dc008e9a0mr1447390f8f.25.1717060619777;
        Thu, 30 May 2024 02:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi3J261H+kvNlM51nAbEppEo0zvT/nXdwb2pSpj63MFdYMyK0Nzg/1FLCsBdnPikDYyBa54A==
X-Received: by 2002:a5d:6850:0:b0:354:eb62:365a with SMTP id ffacd0b85a97d-35dc008e9a0mr1447350f8f.25.1717060619144;
        Thu, 30 May 2024 02:16:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:fb20:c957:3427:ac94:f0a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3574c7017d1sm14349827f8f.76.2024.05.30.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 02:16:58 -0700 (PDT)
Date: Thu, 30 May 2024 05:16:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net v3 2/2] virtio_net: fix a spurious deadlock issue
Message-ID: <20240530051420-mutt-send-email-mst@kernel.org>
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
 <20240528134116.117426-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528134116.117426-3-hengqi@linux.alibaba.com>

On Tue, May 28, 2024 at 09:41:16PM +0800, Heng Qi wrote:
> When the following snippet is run, lockdep will report a deadlock[1].
> 
>   /* Acquire all queues dim_locks */
>   for (i = 0; i < vi->max_queue_pairs; i++)
>           mutex_lock(&vi->rq[i].dim_lock);
> 
> There's no deadlock here because the vq locks are always taken
> in the same order, but lockdep can not figure it out. So refactoring
> the code to alleviate the problem.
> 
> [1]
> ========================================================
> WARNING: possible recursive locking detected
> 6.9.0-rc7+ #319 Not tainted
> --------------------------------------------
> ethtool/962 is trying to acquire lock:
> 
> but task is already holding lock:
> 
> other info that might help us debug this:
> Possible unsafe locking scenario:
> 
>       CPU0
>       ----
>  lock(&vi->rq[i].dim_lock);
>  lock(&vi->rq[i].dim_lock);
> 
> *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by ethtool/962:
>  #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
>  #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
> 				ethnl_default_set_doit+0xbe/0x1e0
> 
> stack backtrace:
> CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 	   rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x79/0xb0
>  check_deadlock+0x130/0x220
>  __lock_acquire+0x861/0x990
>  lock_acquire.part.0+0x72/0x1d0
>  ? lock_acquire+0xf8/0x130
>  __mutex_lock+0x71/0xd50
>  virtnet_set_coalesce+0x151/0x190
>  __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
>  ethnl_set_coalesce+0x34/0x90
>  ethnl_default_set_doit+0xdd/0x1e0
>  genl_family_rcv_msg_doit+0xdc/0x130
>  genl_family_rcv_msg+0x154/0x230
>  ? __pfx_ethnl_default_set_doit+0x10/0x10
>  genl_rcv_msg+0x4b/0xa0
>  ? __pfx_genl_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x5a/0x110
>  genl_rcv+0x28/0x40
>  netlink_unicast+0x1af/0x280
>  netlink_sendmsg+0x20e/0x460
>  __sys_sendto+0x1fe/0x210
>  ? find_held_lock+0x2b/0x80
>  ? do_user_addr_fault+0x3a2/0x8a0
>  ? __lock_release+0x5e/0x160
>  ? do_user_addr_fault+0x3a2/0x8a0
>  ? lock_release+0x72/0x140
>  ? do_user_addr_fault+0x3a7/0x8a0
>  __x64_sys_sendto+0x29/0x30
>  do_syscall_64+0x78/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 4d4ac2ececd3 ("virtio_net: Add a lock for per queue RX coalesce")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/net/virtio_net.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4f828a9e5889..ecb5203d0372 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4257,7 +4257,6 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>  	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
>  	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
>  	struct scatterlist sgs_rx;
> -	int ret = 0;
>  	int i;
>  
>  	if (rx_ctrl_dim_on && !virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> @@ -4267,27 +4266,27 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>  			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
>  		return -EINVAL;
>  
> -	/* Acquire all queues dim_locks */
> -	for (i = 0; i < vi->max_queue_pairs; i++)
> -		mutex_lock(&vi->rq[i].dim_lock);
> -
>  	if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
>  		vi->rx_dim_enabled = true;
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			mutex_lock(&vi->rq[i].dim_lock);
>  			vi->rq[i].dim_enabled = true;
> -		goto unlock;
> +			mutex_unlock(&vi->rq[i].dim_lock);
> +		}
> +		return 0;
>  	}
>  
>  	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
> -	if (!coal_rx) {
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
> +	if (!coal_rx)
> +		return -ENOMEM;
>  
>  	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
>  		vi->rx_dim_enabled = false;
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			mutex_lock(&vi->rq[i].dim_lock);
>  			vi->rq[i].dim_enabled = false;
> +			mutex_unlock(&vi->rq[i].dim_lock);
> +		}
>  	}
>  
>  	/* Since the per-queue coalescing params can be set,
> @@ -4300,22 +4299,19 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>  
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>  				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> -				  &sgs_rx)) {
> -		ret = -EINVAL;
> -		goto unlock;
> -	}
> +				  &sgs_rx))
> +		return -EINVAL;
>  
>  	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
>  	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		mutex_lock(&vi->rq[i].dim_lock);
>  		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
>  		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
> -	}
> -unlock:
> -	for (i = vi->max_queue_pairs - 1; i >= 0; i--)
>  		mutex_unlock(&vi->rq[i].dim_lock);
> +	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
> -- 
> 2.32.0.3.g01195cf9f


