Return-Path: <netdev+bounces-95384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 947CB8C219B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEF01C21275
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46A6165FBF;
	Fri, 10 May 2024 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcZaGom8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83E15FA62
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335654; cv=none; b=lp9k0L/5Gxr4t8FdsUdK0FtIwPHTYJYvZ5AQPGvTjgZtUg+aM9Bp4+mC8C0TXwY2pke8pFn5Hf3elfwwIfy+9HZsSGsznCjQUwzdRmNRDZ/cR0y60n1JhMG9KfsYBLJVLV1XOPFy/XPzHI0i3qJU5vhhIKCWiauNdpSq0yqwSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335654; c=relaxed/simple;
	bh=UzzrEAXXC7GjB0UzWHaGTus02kqoHPT2GIyFF+3NxgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVaOHsFG8WuwZJ3ssz0PZFAeFe/I+Tjj+ariSycYEazmFPg7wo0MYTdKmBHYz8hc4FD7GkZ0+zw42WqhzEb06Lsm0D9cYARKxwj5bme52oT3itkl0/nu0AIWpeA1ACO9Fi+mFzCi7ZzySJ4kLMqTJCQmOpsDric1pxpklqd7k28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcZaGom8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715335652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PU1jXrUxZHpWqbXLAeWI4bSbPEiHk/0IQA0hXmx3ydw=;
	b=hcZaGom8fah+C7e6y2QG5Z0WPO5MMnpDhTfV9nXqs/q4I8mfEfUBy4UGj1i9Eq17d85oz1
	cKmRB6NgNx35hCrEdHdFn1A4Eh953DYrtJb8JmEGWF9UHQFkBEDZ0cF5b19MGhrfpMhfI3
	YwDA9/HNqg52I1Blvh6EDZCXM519cHQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Na0Q46Y0PlKqL1rwmuUgMA-1; Fri, 10 May 2024 06:07:29 -0400
X-MC-Unique: Na0Q46Y0PlKqL1rwmuUgMA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e5225e937aso6472531fa.1
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715335648; x=1715940448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU1jXrUxZHpWqbXLAeWI4bSbPEiHk/0IQA0hXmx3ydw=;
        b=WGzGwUXZuHz16bWCWGC3H8w0u+5eHdO8XbIMd1TET3amdkQ+2pv9jcWl1/xT/lzDIc
         xuZDdXIDLDTBFsh+837zgKWS/PnvD1rdp1dhLzRhMf1txNkWrS7BK+0SZrBgJ2c3TcEq
         a7HcdZHfLwKLJPTDl2+ldoHTRkFzmg7vzQMyNT+avBZ8/Jp8+RjQHokT1T3OA2fHAKp/
         l1aKIbe7zZk1ACW+iEGX1nCEaXlzEFhIqiKbXcJ+w62daT14BOrT5A8fv3A+pn3TiiPa
         Z4R355xlpCNou27zC4oTj+ep9DBN28fvP7txMym7gVFprjPspGplEpcl0iRhp213Igx+
         O8CA==
X-Gm-Message-State: AOJu0Yz4zz55Wpt8P/36kEY+/MORJh/r+mveokfd2gPJ3BxJYIq25b5o
	XwMppphsp2Q510vgFMv2TJKwpWiD5QSRdsfk8aFjnjoo3+rrqzEYTjiDATRwM7Bh+jAVWo49bi4
	29wONDEp2rCfkG8+ihygKpP/s4gZlo497iUCDyt3uwHY6kEEoqQhwyg==
X-Received: by 2002:a2e:9584:0:b0:2e4:9606:6b88 with SMTP id 38308e7fff4ca-2e51fc36498mr13732051fa.3.1715335648281;
        Fri, 10 May 2024 03:07:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXKNWD+EFdcSFAS5T5UD1yMpgsUDi4mA7kwfVGY9LXB94v/2AnWVsvufoI3+85K8YrZW3SFw==
X-Received: by 2002:a2e:9584:0:b0:2e4:9606:6b88 with SMTP id 38308e7fff4ca-2e51fc36498mr13731841fa.3.1715335647614;
        Fri, 10 May 2024 03:07:27 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7408:4800:68b:bbd9:73c8:fb50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe1277sm56451675e9.42.2024.05.10.03.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:07:27 -0700 (PDT)
Date: Fri, 10 May 2024 06:07:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@nvidia.com, axboe@kernel.dk
Subject: Re: [PATCH] virtio_net: Fix memory leak in virtnet_rx_mod_work
Message-ID: <20240510060716-mutt-send-email-mst@kernel.org>
References: <20240509183634.143273-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509183634.143273-1-danielj@nvidia.com>

On Thu, May 09, 2024 at 01:36:34PM -0500, Daniel Jurgens wrote:
> The pointer delcaration was missing the __free(kfree).
> 
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Closes: https://lore.kernel.org/netdev/0674ca1b-020f-4f93-94d0-104964566e3f@kernel.dk/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

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


