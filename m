Return-Path: <netdev+bounces-54357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D85806BCC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A811C20984
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC192D78C;
	Wed,  6 Dec 2023 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQPtw/JG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26039D44
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701858075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRpm8LJyiiRWUlz6GAxojgBjtryrOUDizfbbrpySu3o=;
	b=BQPtw/JG4B/hvPXOo7hV1Mx53POJr9MD7vsgmMwu7f0i7a/L8LVUFfpdYvRz2L/2JZ40py
	pIEaW2GART1Lz4iq2pR8L76sYGEr53eScbqMkNSofp6wJAkjWfXQkvckUAOMWoSU4SwZA+
	S8cwuZLpQ4uPkV4GlSPa3MV7jzyhlDI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-ZLed4G_8MrOfo8LElvPOng-1; Wed, 06 Dec 2023 05:21:11 -0500
X-MC-Unique: ZLed4G_8MrOfo8LElvPOng-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b3487fed9so9137455e9.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 02:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701858070; x=1702462870;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRpm8LJyiiRWUlz6GAxojgBjtryrOUDizfbbrpySu3o=;
        b=HlvUFimdx5M8iFtqigwjKcbCMreGt+WDB+LEAW9b3mne1m/YRfQb4d14/IPTuqX/Xg
         OwrOtMsiQO2azWLDITh4caKx4q1LGkrSh+3Ok0s2VWtYjVLC5Bsf5jhYM/idty7fuChg
         H6YRk4V305xLyZIQWJA7jPA/HejmFBTe2eVJyOxOuElCjRmfhNCMzM2Vc5Jy63sGzDak
         HD2uMeuu1MwgyhdO86NjabynUD7SSULZSvntvT3zx7EzGpX8c6tYL6yX3nFKCAPZQPM7
         EV3EW4BZ4n/itw/5lvT37FfU5Xyufvhu3n4xOTGKZdMNk7iJtHux3wE+uon8sQXz32Lw
         l8UQ==
X-Gm-Message-State: AOJu0YxZI8hyCYiHWCLWeZWi4mRty+xxIaIUuukuYC7qKGu0DQ7sQGFv
	2etPgOFCxqpsdMcyUb8IEbzoaAHVI2/xxLghsCptJpVm0soRA9h/EPR57uuQ2mON01odE2M7RWm
	jmFwBT31eC+t84Fza
X-Received: by 2002:a05:600c:1387:b0:3fe:d637:7b25 with SMTP id u7-20020a05600c138700b003fed6377b25mr1011191wmf.0.1701858070615;
        Wed, 06 Dec 2023 02:21:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzLXIFZZc9kH9a0qoOjJc2dMhzqVfyNK62mNXv/pQ96Mjtxwek/hMFKj/u8yGU1IkKMmv2iA==
X-Received: by 2002:a05:600c:1387:b0:3fe:d637:7b25 with SMTP id u7-20020a05600c138700b003fed6377b25mr1011177wmf.0.1701858070221;
        Wed, 06 Dec 2023 02:21:10 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b0040b3632e993sm25050697wmq.46.2023.12.06.02.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:21:09 -0800 (PST)
Message-ID: <6d2d35c48875e8881509f94aeb9fb37d32238069.camel@redhat.com>
Subject: Re: [PATCH net-next v3 8/9] net: rswitch: Add jumbo frames handling
 for TX
From: Paolo Abeni <pabeni@redhat.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, s.shtylyov@omp.ru,
  davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Date: Wed, 06 Dec 2023 11:21:08 +0100
In-Reply-To: <20231204012058.3876078-9-yoshihiro.shimoda.uh@renesas.com>
References: <20231204012058.3876078-1-yoshihiro.shimoda.uh@renesas.com>
	 <20231204012058.3876078-9-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 10:20 +0900, Yoshihiro Shimoda wrote:
> @@ -1647,25 +1676,32 @@ static netdev_tx_t rswitch_start_xmit(struct sk_b=
uff *skb, struct net_device *nd
>  	if (skb_put_padto(skb, ETH_ZLEN))
>  		return ret;
> =20
> -	dma_addr =3D dma_map_single(ndev->dev.parent, skb->data, skb->len, DMA_=
TO_DEVICE);
> -	if (dma_mapping_error(ndev->dev.parent, dma_addr))
> +	dma_addr_orig =3D dma_map_single(ndev->dev.parent, skb->data, skb->len,=
 DMA_TO_DEVICE);
> +	if (dma_mapping_error(ndev->dev.parent, dma_addr_orig))
>  		goto err_kfree;
> =20
>  	gq->skbs[gq->cur] =3D skb;
>  	gq->unmap_addrs[gq->cur] =3D dma_addr;

Here 'dma_addr' is still used uninitialized. I guess you should use
'dma_addr_orig' even here.

Cheers,

Paolo


