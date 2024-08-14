Return-Path: <netdev+bounces-118456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD0A951AD7
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C1428507B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5551B0124;
	Wed, 14 Aug 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fnk/0dkW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C41B0111
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638534; cv=none; b=eeiTbAQDS1ojEGdYDZCflV+dYr372N0ZOkQz8V+DhR6F5MkZm2O9kzMEIkwwrBC5MbuWLkRGp8F8O/7cU05IsGvWbtm6mD9HA5SCjaXcZ8xmIjfERx/VYbolS0OQOD9WLKtxXiO9usNdauaTJrmwM/L5sForokSohgcbqYhnSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638534; c=relaxed/simple;
	bh=wne3hJeVETHoRxRRwmczPltR0xe6KenZjR0jCB4pmvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bc9+2Y2/PSA9OlTspyNWoXnWrJ63F2IfbuH76llvyjQm+tnAiv9lNiqXxCLNWHZm0xF/6dZMDaAzzJcZh7Ue15QZUVZIIYWHEwSdiKe5t+C4jEzjvIikvvsa6kOAvJXi+v8ZxRNbch5s2tcBOBtrvQkCULEAxgx7zcrby/srErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fnk/0dkW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723638531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lgbv51mAhjP7OL8sHCVTSn/9XlOCPKA1u2vqzb5lGSk=;
	b=Fnk/0dkWyXkz4EvhaYZr9td0F4hjZC790KcYSKnVX3Me5yy8u98it9RiZ6Qy6qxlL57wf1
	eXh8ya56n88GDktMzerhDdig+VDW7T5DT9f+jqNgR9bzOdjlXdTYx/oLZpV3ApLeYTOTU7
	2lM6k+e78xG3GPTu1l5i0rwqmdOLZjI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-1CdUJANmMfOj3149gXzZtw-1; Wed, 14 Aug 2024 08:28:50 -0400
X-MC-Unique: 1CdUJANmMfOj3149gXzZtw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f01a8b90b6so66541471fa.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 05:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723638529; x=1724243329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgbv51mAhjP7OL8sHCVTSn/9XlOCPKA1u2vqzb5lGSk=;
        b=tHvuWdeY2XwKSSRChxXkBURJg6+Qe12PKLejEAkitEQZvbo50d/I3JlFymba1IwN5A
         Z7u2E0P5K7rDbaRzGz+/e/wbCNt/wKH5hYAntVeJJavogJva9WD49xBkOjZoMWmrm4Mo
         zDEhMOtKLDlikzq9e7Gksrpn6F79GD8m4RKmUy0giohXH0gzdGUG3ypqAr/ZyvXpY5SL
         4tjePxLXh4tXY4n86nGUY3s6L6UIA6TCGeB5Bl4RgKqG0Gd92dsdoEmi1SHSCX3VTMLa
         Br1nmN9tDqeVxg4FOY9xACkK8J/4ZnxG7iGsU6H8S4KeeeAl+VSvVwtQ5WlkbWmTGk5x
         p5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCW/9x1tZ/IaAc6b/L9IpnvsG+SK7tObfCpu387bG8NPNCs0GUph21skSu+KHRwlx6usjmeGNLH3PGvWdSAIjh70wArVkpfj
X-Gm-Message-State: AOJu0YwHAZ9UEI70ZhnzN85+oAmuSKRMhDLUEmN3G0eyhFXOis1TpiD7
	6982iZm3PVP4RV9kX6DBCttOxAAOlfLbmeLxU458V1Zk4aw/YBZ3FiAG6nUiq0YsOO3zGF0DQGl
	jSUlGDYbQHibFwXRdwx9v+drmca7mUpprR7r/23R8rphl06zLM1m4nQ==
X-Received: by 2002:a2e:9d50:0:b0:2ef:2677:7b74 with SMTP id 38308e7fff4ca-2f3aa3005e3mr18060441fa.41.1723638528537;
        Wed, 14 Aug 2024 05:28:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoO998whhV2B/Fj79zap0l1nunj76NdP8xdJSb1vU4WlBoCqFKT3DJ+Ti9U2vZ8m/OzEhhzg==
X-Received: by 2002:a2e:9d50:0:b0:2ef:2677:7b74 with SMTP id 38308e7fff4ca-2f3aa3005e3mr18060001fa.41.1723638527515;
        Wed, 14 Aug 2024 05:28:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f4d20dsm165555166b.7.2024.08.14.05.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:28:46 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:28:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, m.szyprowski@samsung.com
Subject: Re: [PATCH net] virtio_net: move netdev_tx_reset_queue() call before
 RX napi enable
Message-ID: <20240814082835-mutt-send-email-mst@kernel.org>
References: <20240814122500.1710279-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814122500.1710279-1-jiri@resnulli.us>

On Wed, Aug 14, 2024 at 02:25:00PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> During suspend/resume the following BUG was hit:
> ------------[ cut here ]------------
> kernel BUG at lib/dynamic_queue_limits.c:99!
> Internal error: Oops - BUG: 0 [#1] SMP ARM
> Modules linked in: bluetooth ecdh_generic ecc libaes
> CPU: 1 PID: 1282 Comm: rtcwake Not tainted
> 6.10.0-rc3-00732-gc8bd1f7f3e61 #15240
> Hardware name: Generic DT based system
> PC is at dql_completed+0x270/0x2cc
> LR is at __free_old_xmit+0x120/0x198
> pc : [<c07ffa54>]    lr : [<c0c42bf4>]    psr: 80000013
> ...
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 43a4406a  DAC: 00000051
> ...
> Process rtcwake (pid: 1282, stack limit = 0xfbc21278)
> Stack: (0xe0805e80 to 0xe0806000)
> ...
> Call trace:
>   dql_completed from __free_old_xmit+0x120/0x198
>   __free_old_xmit from free_old_xmit+0x44/0xe4
>   free_old_xmit from virtnet_poll_tx+0x88/0x1b4
>   virtnet_poll_tx from __napi_poll+0x2c/0x1d4
>   __napi_poll from net_rx_action+0x140/0x2b4
>   net_rx_action from handle_softirqs+0x11c/0x350
>   handle_softirqs from call_with_stack+0x18/0x20
>   call_with_stack from do_softirq+0x48/0x50
>   do_softirq from __local_bh_enable_ip+0xa0/0xa4
>   __local_bh_enable_ip from virtnet_open+0xd4/0x21c
>   virtnet_open from virtnet_restore+0x94/0x120
>   virtnet_restore from virtio_device_restore+0x110/0x1f4
>   virtio_device_restore from dpm_run_callback+0x3c/0x100
>   dpm_run_callback from device_resume+0x12c/0x2a8
>   device_resume from dpm_resume+0x12c/0x1e0
>   dpm_resume from dpm_resume_end+0xc/0x18
>   dpm_resume_end from suspend_devices_and_enter+0x1f0/0x72c
>   suspend_devices_and_enter from pm_suspend+0x270/0x2a0
>   pm_suspend from state_store+0x68/0xc8
>   state_store from kernfs_fop_write_iter+0x10c/0x1cc
>   kernfs_fop_write_iter from vfs_write+0x2b0/0x3dc
>   vfs_write from ksys_write+0x5c/0xd4
>   ksys_write from ret_fast_syscall+0x0/0x54
> Exception stack(0xe8bf1fa8 to 0xe8bf1ff0)
> ...
> ---[ end trace 0000000000000000 ]---
> 
> After virtnet_napi_enable() is called, the following path is hit:
>   __napi_poll()
>     -> virtnet_poll()
>       -> virtnet_poll_cleantx()
>         -> netif_tx_wake_queue()
> 
> That wakes the TX queue and allows skbs to be submitted and accounted by
> BQL counters.
> 
> Then netdev_tx_reset_queue() is called that resets BQL counters and
> eventually leads to the BUG in dql_completed().
> 
> Move virtnet_napi_tx_enable() what does BQL counters reset before RX
> napi enable to avoid the issue.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/netdev/e632e378-d019-4de7-8f13-07c572ab37a9@samsung.com/
> Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3f10c72743e9..c6af18948092 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2867,8 +2867,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  	if (err < 0)
>  		goto err_xdp_reg_mem_model;
>  
> -	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
>  	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
> +	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
>  	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
>  
>  	return 0;
> -- 
> 2.45.2


