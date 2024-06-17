Return-Path: <netdev+bounces-103902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C2E90A217
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 03:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED8C1F24F45
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E653A178363;
	Mon, 17 Jun 2024 01:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ictiB/zU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F4176AB7
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 01:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718589108; cv=none; b=gC86o60TOTI8BE/fGLVsBqqMfHPb7NoMTepDWCHWCXtqCI/4TvtuzEG1Z7u60PZLoWSvY1I5NIVptX37t+4xv7vdcTAYcbBrMOIVBxrkFw3xCT/KUmMoXTaxGOtplcsIrAIQMYwp1c6qrG0YWP4oi+yatIreFrSxQZdlKm99Hhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718589108; c=relaxed/simple;
	bh=KrtdDO/VCr23v8ybpPvgLXMiSCeSjc0+KH0kowuinfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHBif3vqbcG/rQT+I516CpTQYxc/m/13KktQ2VJhQIS1/L6iQXk7W2/GRb09bbzPFHXLpOKnjFbekxrPUMZQKlcluCaLH5Gfe4Tuho6b/Zg0DwDY8KzT7M63dLBuP9SJbO3GXHfvYFfNcg5Kk/C1911ywt4I5E/WkI8UujQPTyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ictiB/zU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718589106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sFa9jqalWQkohxBGb7r1/BRwO9hzM28tWfgameCGoM=;
	b=ictiB/zUGuZOsKy8+gr3pSgtj1jCUizm/A2HSwNZOCaW0sMu4NvwU6udKxtKKZLF7CAXZj
	QscOPwLw9f065pJwic0NEjHjZQHY8LVn8pISmVgWfjymexk1wx4Nsw8q/FM33vtxAodiHe
	wtL8JZla8OS3ijzZUOCEXLM/DiN97Iw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-eB-qR_pNM8OtgUfMBUeYFA-1; Sun, 16 Jun 2024 21:51:43 -0400
X-MC-Unique: eB-qR_pNM8OtgUfMBUeYFA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6658175f9d4so3723997a12.0
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 18:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718589102; x=1719193902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sFa9jqalWQkohxBGb7r1/BRwO9hzM28tWfgameCGoM=;
        b=XIJE0GPz8Y/W8TBgo+JH/wk7vMKkXIDIPSnPPi4qNBs3NHmkI0o+i4YXqo54Uk+Cbr
         oAuPGEY4g7ECPzhzFaXer1z4A94exmi3BoC5d/aW8KZDZbDSeGmrJGgceUO4rdG00cJ3
         ETwtSDv+V12JLxumoTzXK5m4XiFvC68YyB1P/B9jX/CE4Vz5y7kWlhyt++8YZazNVln+
         vCFw9UEG1NlARt1WRaPUl6iDIiLPLaUsfBzvGrf3xgUngC3zg+JBqhY/pkwqDtFaW872
         w7tI+e4mp0Q8t+wt0lYCDANJbrU55g0fpvHHoCZB5eUvQL3VN+mc/cFcYxl66aufwPDe
         +PNA==
X-Forwarded-Encrypted: i=1; AJvYcCVJAV9amrgqaaoOCtoJmYlPMzt2if9/llYSx9rhgwDxdQonobjbCo9E6Ch0taoas0jnsEG8sO4kYnx0mvMyyrNCxGdG5TVi
X-Gm-Message-State: AOJu0YzhjXk3tMBHEnPn2sH1nHeRhKqmqjtYGt2ad+FdeYQ4A0DSmi1R
	txBVX754aFxInF5DuG4q6SQhCGdSaf7WPgUYCamT9s6TZutjjf4Ks8h0QmuF/6GJPSQEojkHGcw
	ApbyVwY9ae/gFbcK278s6XaZwnFqyux45Q4a+L1ltzqv2yOFyiuQam++vfiwZIT1kY1PKFLSJI7
	RLMIGTnN0ZMDmaAV3bL6bFPGfejGcc
X-Received: by 2002:a05:6a20:9705:b0:1b6:d9fa:8bd with SMTP id adf61e73a8af0-1bae7e7d746mr9987507637.25.1718589102239;
        Sun, 16 Jun 2024 18:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKgEBaAC5HQqbCxUsXuTfI029p4WEvw6v7kCzjrPyFhRt1ZFQs3vMZt900K6rK/wsx8brxoPR4nl9Zu4d7zU0=
X-Received: by 2002:a05:6a20:9705:b0:1b6:d9fa:8bd with SMTP id
 adf61e73a8af0-1bae7e7d746mr9987491637.25.1718589101920; Sun, 16 Jun 2024
 18:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614220422.42733-1-jain.abhinav177@gmail.com>
In-Reply-To: <20240614220422.42733-1-jain.abhinav177@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:51:30 +0800
Message-ID: <CACGkMEt1nREjoe9bSmwoAmbbpA5mCSiC7QizE5rHCas0xvfgEA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Eliminate OOO packets during switching
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	javier.carrasco.cruz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 6:05=E2=80=AFAM Abhinav Jain <jain.abhinav177@gmail=
.com> wrote:
>
> Disable the network device & turn off carrier before modifying the
> number of queue pairs.
> Process all the in-flight packets and then turn on carrier, followed
> by waking up all the queues on the network device.
>
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  drivers/net/virtio_net.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d134544..d0a655a3b4c6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3447,7 +3447,6 @@ static void virtnet_get_drvinfo(struct net_device *=
dev,
>
>  }
>
> -/* TODO: Eliminate OOO packets during switching */
>  static int virtnet_set_channels(struct net_device *dev,
>                                 struct ethtool_channels *channels)
>  {
> @@ -3471,6 +3470,15 @@ static int virtnet_set_channels(struct net_device =
*dev,
>         if (vi->rq[0].xdp_prog)
>                 return -EINVAL;
>
> +       /* Disable network device to prevent packet processing during
> +        * the switch.
> +        */
> +       netif_tx_disable(dev);
> +       netif_carrier_off(dev);

Any reason we don't need to synchronize with NAPI here?

Thanks

> +
> +       /* Make certain that all in-flight packets are processed. */
> +       synchronize_net();
> +
>         cpus_read_lock();
>         err =3D virtnet_set_queues(vi, queue_pairs);
>         if (err) {
> @@ -3482,7 +3490,12 @@ static int virtnet_set_channels(struct net_device =
*dev,
>
>         netif_set_real_num_tx_queues(dev, queue_pairs);
>         netif_set_real_num_rx_queues(dev, queue_pairs);
> - err:
> +
> +       /* Restart the network device */
> +       netif_carrier_on(dev);
> +       netif_tx_wake_all_queues(dev);
> +
> +err:
>         return err;
>  }
>
> --
> 2.34.1
>


