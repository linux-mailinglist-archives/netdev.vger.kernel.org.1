Return-Path: <netdev+bounces-50466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CBB7F5E3B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873E7281B91
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F6B2376D;
	Thu, 23 Nov 2023 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAsAyaKz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CC51A8
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700740286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AooG8xN58HCuuL3jxOniLdSeQfR0UM774bPAV7td7nU=;
	b=DAsAyaKzgTDPZgeDaf1f1J335Q0GJdnTSCmAb6zEBzg/5b2QtECMeTvUGi7eXtrco52Xkr
	0nW+1MHLYC64lfPcTFna/vZwZlNVqxGAqLTmqfZtZ4am2csV3xdL5jjr3CFNmseWtEgCmL
	AXmd46BQT+0keGO8kWAEsVG95C7JZfM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-4SNskkJNPaiSbjS0pvI9Ow-1; Thu, 23 Nov 2023 06:51:24 -0500
X-MC-Unique: 4SNskkJNPaiSbjS0pvI9Ow-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a03389a0307so11400266b.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700740284; x=1701345084;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AooG8xN58HCuuL3jxOniLdSeQfR0UM774bPAV7td7nU=;
        b=RToJmzs03jb6ss5LL4mWRlma5rYU3gshlAU8QaSBsshPBNwtYfr+G4fLySPD5qvXh+
         QRrefcKkMisBuipYSZqdK6B6yj4BwFREK4TlFFFDDt+/VQSxBuzNP8Vr1Yo4T9GJxUz6
         eG0VD8O4RWYTcfRKt8GxknSqLErOuFSWTnAtIc4fB2EZNelbes/hmzpGu2w9qNsWfndG
         UZLqJ1JOGhSpVHvSNroT5bHgi/q5Chgg0obP2VUzpQmFKB9X+URzeNBdFNgAH7sE99W4
         pdIWXQtKF8PL6g26o5UQ71UnqUQ0F1EcWrYqw8vdQLMRDjABysZorzuoyoXMLFKfSAVD
         CjBQ==
X-Gm-Message-State: AOJu0Yy9j5wkx5TD+4lJbJCwaBXvN1UKYM28bDbBxIL+2iQ2JMC25F4/
	oJxNzecqEwUGGbDDxQ6anlA+aRgz6MfUgsl9ooVvJd7sH+zji6YtmH+B7Mru+9u4Qb67e5XzK0D
	OKVmi92U4WjxDCqB6
X-Received: by 2002:a17:906:7398:b0:a00:1acf:6fe6 with SMTP id f24-20020a170906739800b00a001acf6fe6mr3795158ejl.1.1700740283887;
        Thu, 23 Nov 2023 03:51:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKoHgojVkghYhaLFpuj4mSg8DTd3sbqe347RC+/YIfpkMmjH4/qZi6WhOW8SHPau4YhBZfEw==
X-Received: by 2002:a17:906:7398:b0:a00:1acf:6fe6 with SMTP id f24-20020a170906739800b00a001acf6fe6mr3795142ejl.1.1700740283470;
        Thu, 23 Nov 2023 03:51:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906288b00b009ffba6f1aafsm693555ejd.109.2023.11.23.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 03:51:23 -0800 (PST)
Message-ID: <ea0087881f20dc154ca08a5b748b853246e2b86f.camel@redhat.com>
Subject: Re: [PATCH 3/4 net] qca_spi: Fix ethtool -G iface tx behavior
From: Paolo Abeni <pabeni@redhat.com>
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, Florian Fainelli
 <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Nov 2023 12:51:21 +0100
In-Reply-To: <20231121163004.21232-4-wahrenst@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
	 <20231121163004.21232-4-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
> After calling ethtool -g it was not possible to adjust the TX ring size
> again.=C2=A0

Could you please report the exact command sequence that will fail?


> The reason for this is that the readonly setting rx_pending get
> initialized and after that the range check in qcaspi_set_ringparam()
> fails regardless of the provided parameter. Since there is no adjustable
> RX ring at all, drop it from qcaspi_get_ringparam().

>=20
> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA=
7000")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/net/ethernet/qualcomm/qca_debug.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethe=
rnet/qualcomm/qca_debug.c
> index 6f2fa2a42770..613eb688cba2 100644
> --- a/drivers/net/ethernet/qualcomm/qca_debug.c
> +++ b/drivers/net/ethernet/qualcomm/qca_debug.c
> @@ -252,9 +252,7 @@ qcaspi_get_ringparam(struct net_device *dev, struct e=
thtool_ringparam *ring,
>  {
>  	struct qcaspi *qca =3D netdev_priv(dev);
>=20
> -	ring->rx_max_pending =3D 4;
>  	ring->tx_max_pending =3D TX_RING_MAX_LEN;
> -	ring->rx_pending =3D 4;
>  	ring->tx_pending =3D qca->txr.count;
>  }

I think it's preferable update qcaspi_set_ringparam() to complete
successfully when the provided arguments don't change the rx_pending
default (4)

Cheers,

Paolo


