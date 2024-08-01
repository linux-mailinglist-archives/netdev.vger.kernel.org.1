Return-Path: <netdev+bounces-114933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84753944B50
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B665E1C23A7C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A519F49C;
	Thu,  1 Aug 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFnCgFQr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5518FC75
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515454; cv=none; b=RBEQR42p8xyEAYqVyk12GDwt5TjQJnXXjUtSzmvC/M/6uxJFB7CUY+pf8WA6PEiOqeh8WthqyQ+UVCcUjpHChEFi07B/8RoeSt4MD2Sdk73c0PzOKsZVeQaCHfZhgz4F15310WKwPwhFBtcgz9TcU9Y151w8fLq8kXfEn5j3XM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515454; c=relaxed/simple;
	bh=+VwoTw4/VSWSO5vEZar5LeS4B0UPhnVHwbXKzFqkOnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AORuD40p5CO3JRwxt+lZ3H8CPHQug6qsvMkKMRptcjT9xlOBABPkpTlp6oi48b9N37WTcTjnrlCQx+omONO0CzIjJ9zMZo005sqW3Os6CKODWV3PCXUkHTFHpea+bfI8ust/AzQjVFNivHKQmYVCSUDih0ASoe9JW82gmPiISMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFnCgFQr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722515452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxhE1NPgVuOO/n6fsUwjPWz/ezblDpX/qadlR9lwo2s=;
	b=NFnCgFQr16wOHKpQDpwrjgg3X6YzdNMt8mac9zLAiNb7b+ZQNfPJlDW48seYCVagIu4s7/
	qxAQLImyzfAjB7pi93u/60NzfU5B+LPuRAs/8AQlKaQUCPHudEfLTUraBLA1vjt0zCiP/V
	tQohzm8M5ZxswjU2rET8s7LZQkuBwpg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-y9euUjx0NL6o-JqMRejvoQ-1; Thu, 01 Aug 2024 08:30:50 -0400
X-MC-Unique: y9euUjx0NL6o-JqMRejvoQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7aa020cef5so613698666b.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 05:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722515449; x=1723120249;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxhE1NPgVuOO/n6fsUwjPWz/ezblDpX/qadlR9lwo2s=;
        b=a4RgaY3gUtZcAnXfqhP+8lFJt4ma7r9hw0m+dqcyJOCjD/PI0ifv4Jlxa3uyhlSaXI
         KcB4u3uM0YAKAyUTIncSVmV/e+7q9UBFRG9RccT5yBZDenHpinczExxI7wRPr59k16Li
         Yjcgeo9LH4hJxsUt0qh4rlXchjZ2kUX/hxBkYFYWSSBvXHP5a0vx0yaqPPOkumr593Be
         i3aJQfuX3iGAJKef/RuTZDEt/qkXRISqLNaxWoGeWGCxtMSYOHcPC7q7UihBwqoSmo/a
         3largYvj3eurFfWigfE+k6kN8cT4PWZAI66PV6bSi05tBepdkFP9sf+sLegze4qZNsV0
         t1WQ==
X-Gm-Message-State: AOJu0YyA01/4ACnL+yoVlXDE3ZViADPaDpmzX6me5ShP1wzNsnX27lsK
	y+g/wBYzWLbkv/GVcu79Bb6NgYT9pFjkG4Azdqil1gyd3KS7rSFLdCy5juzKJzfNhImfY+P8xZh
	4ZTnSE7MeYqaXXMwAG9kD3YuvJCWcHIo/iTqw9P3F3nwGhhJFFczykg==
X-Received: by 2002:a17:906:7956:b0:a7a:b8f1:fd69 with SMTP id a640c23a62f3a-a7dc4e4ae17mr350566b.18.1722515449192;
        Thu, 01 Aug 2024 05:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiuSk/hmqqH204m75ZyS9JWIgO4b9X57Vmo7qnnG08z26nbF6SQ7ZvDrhI/u5K/Gz7A/xUsQ==
X-Received: by 2002:a17:906:7956:b0:a7a:b8f1:fd69 with SMTP id a640c23a62f3a-a7dc4e4ae17mr346766b.18.1722515448416;
        Thu, 01 Aug 2024 05:30:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90251sm910073566b.143.2024.08.01.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:30:47 -0700 (PDT)
Date: Thu, 1 Aug 2024 08:30:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v3 2/2] virtio-net: unbreak vq resizing when
 coalescing is not negotiated
Message-ID: <20240801082947-mutt-send-email-mst@kernel.org>
References: <20240801122739.49008-1-hengqi@linux.alibaba.com>
 <20240801122739.49008-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801122739.49008-3-hengqi@linux.alibaba.com>

On Thu, Aug 01, 2024 at 08:27:39PM +0800, Heng Qi wrote:
> Don't break the resize action if the vq coalescing feature
> named VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated.
> 
> Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Eugenio Pé rez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> v2->v3:
>   - Break out the feature check and the fix into separate patches.
> 
> v1->v2:
>   - Rephrase the subject.
>   - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().
> 
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b1176be8fcfd..2b566d893ea3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3749,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
>  							       vi->intr_coal_tx.max_usecs,
>  							       vi->intr_coal_tx.max_packets);
> -			if (err)
> +			if (err && err != -EOPNOTSUPP)
>  				return err;
>  		}
>  
> @@ -3764,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  							       vi->intr_coal_rx.max_usecs,
>  							       vi->intr_coal_rx.max_packets);
>  			mutex_unlock(&vi->rq[i].dim_lock);
> -			if (err)
> +			if (err && err != -EOPNOTSUPP)
>  				return err;


This needs a comment.


>  		}
>  	}
> -- 
> 2.32.0.3.g01195cf9f


