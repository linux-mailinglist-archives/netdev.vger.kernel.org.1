Return-Path: <netdev+bounces-114556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F11942DE6
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8CB9B23850
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B51AE87D;
	Wed, 31 Jul 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+Rfu6mj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE351AE874
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428103; cv=none; b=Le3k6Uu/EM+wIDrRoLtklSNEwFV5921Q1l8Sq/hIcGHoVisTCZe7oW0wQJIAICCNEnMBqkO6MtCpSCfBjaiB3dYd0etV/SOb66AFCjSdBiH41UugQYdUdc9PNP5keHFbRDVKBQ4xpTR+a441czN21qvx0505sRsMYdbmdt/4TR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428103; c=relaxed/simple;
	bh=xDyq+YNzsuZmIA5MWTu0TYp70ynL/hAgNlh33JRK6GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTVeTUDnDfe7nYimRbf0r0zOIpr0Xqy4Fv/OFbdYne0yjEfDIZSjxS/wE785ZOYZ6zULJHe6D/yDMEwczBNGIwCNEieQXPLWNBLKGmbhUQtlnh63cbGq9DygJKdJoQEOFeUAhWDujdE2oDQr7nsO22tVEh/3oxOnAGjEY9YkTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+Rfu6mj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722428098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YKnyXQcFpO63RzG+wMvq5+IXaB3gH8ilGfOoPfmzUo=;
	b=J+Rfu6mjcsxnGkQBB+CNAspI+lwqyBzaEsfZg6yYSpqGleMIeblqvhIt9oxKIZTiRWRwTD
	KqclGHrqmdT5QW3HWgDEWdIMNL+BTHkB1arluWTc9jgaZe4xKrYGFojQIoM362BgqeyQ5Q
	tXhRFELPj+3ac9pb7OCHZRI9vJAy94A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-vgOO_Yt_MH-wkgH20JhQMQ-1; Wed, 31 Jul 2024 08:14:50 -0400
X-MC-Unique: vgOO_Yt_MH-wkgH20JhQMQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7ab644746eso492798366b.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722428089; x=1723032889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YKnyXQcFpO63RzG+wMvq5+IXaB3gH8ilGfOoPfmzUo=;
        b=YOd2/1i/tFu1dx3fuZil+NeUJvuXn5XwoXRpFcIAMnUAIwlfqeOYnPTU1VJIyM4nRr
         DQ0XRJT/dMdDmb+/PbbbC3ADheWOUzwTiOMNW4VzTsO4OtKZLfsKZzcPWYuy1M7/APvf
         xtvDStv/3FbmwocXcPn6bscXlbfI9ZLcRqV/5yAKb93IqdBMt6bNikIGHy0W8SM3kKeR
         2gBEkQnYYMmuvMT4kAP/CI/F9ULDDc/kIMCl1pkKOEjfrvzcT6zY3hJ/Rjdqb/IZ+oEa
         boD6gb2H6aSMyMPtIyg78VnOFzm0f7DJaEHlu0PAuOLSzoDz1svbCyyK7FsubxgUFo4g
         1+SA==
X-Gm-Message-State: AOJu0YzPFGYuDa4wSNIhCwek1t33dqN82xTCNVWqECmbRwvRZ2evqAY/
	VxC7sZ6Iw8uYin03/Exx44qbi/Q4BKniLcZ4ElW+ss4a4CCAFw54dR1go8gJXHGuKmbaldw2Akb
	61caAzR70JFHh7N6hr6PWbUTpBPrdVZ2zdtzccsgwKCfFgfDb31NYEw==
X-Received: by 2002:a17:907:3da5:b0:a6f:59dc:4ece with SMTP id a640c23a62f3a-a7d3ffadd60mr1162293466b.2.1722428089060;
        Wed, 31 Jul 2024 05:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ32tU5QkV3XxnRAEOGE5gGnHUsVrKVZIyaxJfKVGUTbxZ0SFn4wzHhukeXP8lcTRBjN/DCw==
X-Received: by 2002:a17:907:3da5:b0:a6f:59dc:4ece with SMTP id a640c23a62f3a-a7d3ffadd60mr1162289566b.2.1722428088281;
        Wed, 31 Jul 2024 05:14:48 -0700 (PDT)
Received: from redhat.com ([2.55.44.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad434a3sm760393866b.139.2024.07.31.05.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:14:47 -0700 (PDT)
Date: Wed, 31 Jul 2024 08:14:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	=?iso-8859-1?Q?EugenioP=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net v2] virtio-net: unbreak vq resizing when coalescing
 is not negotiated
Message-ID: <20240731081409-mutt-send-email-mst@kernel.org>
References: <20240731120717.49955-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731120717.49955-1-hengqi@linux.alibaba.com>

On Wed, Jul 31, 2024 at 08:07:17PM +0800, Heng Qi wrote:
> >From the virtio spec:
> 
> 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> 
> The driver must not send vq notification coalescing commands if
> VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> applies to vq resize.
> 
> Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Eugenio Pé rez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> v1->v2:
>  - Rephrase the subject.
>  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().
> 
>  drivers/net/virtio_net.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..2b566d893ea3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3658,6 +3658,9 @@ static int virtnet_send_rx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
>  {
>  	int err;
>  
> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> +		return -EOPNOTSUPP;
> +
>  	err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
>  					    max_usecs, max_packets);
>  	if (err)
> @@ -3675,6 +3678,9 @@ static int virtnet_send_tx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
>  {
>  	int err;
>  
> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> +		return -EOPNOTSUPP;
> +
>  	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
>  					    max_usecs, max_packets);
>  	if (err)
> @@ -3743,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
>  							       vi->intr_coal_tx.max_usecs,
>  							       vi->intr_coal_tx.max_packets);
> -			if (err)
> +			if (err && err != -EOPNOTSUPP)
>  				return err;
>  		}
>


So far so good.
  
> @@ -3758,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  							       vi->intr_coal_rx.max_usecs,
>  							       vi->intr_coal_rx.max_packets);
>  			mutex_unlock(&vi->rq[i].dim_lock);
> -			if (err)
> +			if (err && err != -EOPNOTSUPP)
>  				return err;
>  		}
>  	}

I don't get this one. If resize is not supported, we pretend it
was successful? Why?

> -- 
> 2.32.0.3.g01195cf9f


