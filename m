Return-Path: <netdev+bounces-50441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B77F5D03
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF421C20D45
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAB224E1;
	Thu, 23 Nov 2023 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/Vi1LQm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D2D49
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700736903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjFVbEkEc3cCGzg7BPQSnbWJhLULm7Z08rp1xpQQ9kM=;
	b=f/Vi1LQm4+FIqe9XCW2zvcmD51i24StYXSfm+bTjCl4yqVCooynGrHY7J4Ddm/RuTztpPK
	mLcgYZk0moH9ZW9EGAWdvQ7ddk7Ax0LtgitjE5AAEEaHtP5qERejqpel4rV6S3Vkj80A8H
	USnLGhl/f1idZMAUOuMyx16l9EPyzHs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-594rwLG3P4Ws_RYvBN4dpQ-1; Thu, 23 Nov 2023 05:55:00 -0500
X-MC-Unique: 594rwLG3P4Ws_RYvBN4dpQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-544f174ccccso36940a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736899; x=1701341699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CjFVbEkEc3cCGzg7BPQSnbWJhLULm7Z08rp1xpQQ9kM=;
        b=QJ8rPmqaQM3AIxupZPH6LOQ1Kd8HdPCuisfvunSmn2r1uhtUggs65KYLdKALEA45am
         rG0SV0wYLgy5AnMv+H4s6Gmagf9jdPBoP87ByiTsDL/4kV8eiA83N5UGPltAMArbtRQh
         sToqN4jzxTtgA8EOaPSQ5ybCwcN1tJm51h/0P+9R/a5xxgdiK5ABpWcblZqIuBHAvYRf
         9jQd/i6bLysD3zNTILV71hc+7tNbByvvzes4RHQXLPA/r8SEWdP8dyeMYoPBs2BZRg3T
         OHH5k+eY7RUbz9GMN+cQfL0shO1Pl4XD3O+0bE2k6y/YwOQi4sO+ZIrLDgjmi56/eake
         m6bw==
X-Gm-Message-State: AOJu0YwTtLeDIWrZQcSZPt5hJeVq+fYkSACZ66+rBIfN9lZJSzI2b0vP
	/v/tPVBu/Rb5ANWi26lhRAS8kFPo/YP+K/Gc17ctZ2fBv83fj03MqqLW5sNlFO1FrGQZcKQBzBT
	LXP0Eins4geXYRuo5
X-Received: by 2002:a05:6402:2903:b0:546:efd8:7f05 with SMTP id ee3-20020a056402290300b00546efd87f05mr3451050edb.1.1700736899224;
        Thu, 23 Nov 2023 02:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM8b9TjCgTESKuR7rtfFpkDoJyxon/Vyb9MUnZls74BW7+4SWlLeWtNcgC/KOD5JJZCV1nyQ==
X-Received: by 2002:a05:6402:2903:b0:546:efd8:7f05 with SMTP id ee3-20020a056402290300b00546efd87f05mr3451020edb.1.1700736898906;
        Thu, 23 Nov 2023 02:54:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id f18-20020a05640214d200b005486228190dsm514274edx.42.2023.11.23.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:54:58 -0800 (PST)
Message-ID: <b3735179804cb941bbdd17cbdee5efd9a25a72df.camel@redhat.com>
Subject: Re: [PATCH net-next v1 2/3] net: dsa: microchip: Remove redundant
 optimization in ksz8_w_phy_bmcr
From: Paolo Abeni <pabeni@redhat.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub
 Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Woojung
 Huh <woojung.huh@microchip.com>, Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,  UNGLinuxDriver@microchip.com
Date: Thu, 23 Nov 2023 11:54:57 +0100
In-Reply-To: <20231121152426.4188456-2-o.rempel@pengutronix.de>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
	 <20231121152426.4188456-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 16:24 +0100, Oleksij Rempel wrote:
> Remove the manual checks for register value changes in the
> ksz8_w_phy_bmcr function. Instead, rely on regmap_update_bits() for
> optimizing register updates.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/microchip/ksz8795.c | 95 +++++++++--------------------
>  1 file changed, 28 insertions(+), 67 deletions(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microc=
hip/ksz8795.c
> index 835157815937..4c1e21fd87da 100644
> --- a/drivers/net/dsa/microchip/ksz8795.c
> +++ b/drivers/net/dsa/microchip/ksz8795.c
> @@ -951,107 +951,68 @@ static int ksz8_w_phy_ctrl(struct ksz_device *dev,=
 int port, u16 val)
>  static int ksz8_w_phy_bmcr(struct ksz_device *dev, int port, u16 val)
>  {
>  	const u16 *regs =3D dev->info->regs;
> -	u8 restart, ctrl, speed, data;
> +	u8 restart, speed, ctrl, restart_mask;

Very minor nit and only if you have to repost for some other reason,
please respect the reverse x-mas tree above.

Thanks,

Paolo


