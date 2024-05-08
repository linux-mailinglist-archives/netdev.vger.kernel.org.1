Return-Path: <netdev+bounces-94700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6638C0422
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 20:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C251F24623
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 18:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD3F12B14B;
	Wed,  8 May 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="ioXHAmxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA878128829
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191752; cv=none; b=aQbDMq+/x9KmthJKYlYqnIQ6GieTJLZMxXFL+JAYlWbgqkkhCe5N4orvSsCeDxMNTQg2GYCpsY1or712IFLujP+bbgyH4GUbEO7Wiv/7jCty/VCuPURRJ+NKnp5Gnw6Dfocn9kl3xCW39l/Gq7RDBFaNOMUHRLYKCvlLKT1B9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191752; c=relaxed/simple;
	bh=5jB0MReNBDrITSrke0WnnIS1jVzv7MmrH8FRbjijGik=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=f2F5UWO9V2Azl0/8hzUdAMQqScRmwU8dv4Ls2spFe6mD5fATlV3lNyTUGvIMHdrKAoIMvWe/Zy7QuxOxC0aLTmEsGN8aSN5orgx2tb37ky2B/bSQeOTgjYkiFv98PddAxinWwXu+m+7xI+3/7mkUMW5txnXdBUurPobH7PRfGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=ioXHAmxZ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1715191739; x=1715796539; i=hfdevel@gmx.net;
	bh=5jB0MReNBDrITSrke0WnnIS1jVzv7MmrH8FRbjijGik=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ioXHAmxZb0SLoge5nt4q6i3h6dhbCLqSzgiRF1Ki1I7uaI82bvdBOSqz8W7p7pUN
	 YqDe9oeLNGTFgwRalvbcaaWtSVxNSe1lzeFmhNtwloaGRyXE6U+ZM36bPGmux1Z1m
	 pas9IeTpa8er6Ux1uBG055oStt7USRAKyYQde2lSP49vxrYWKH5LHfMsnAt4xZE5f
	 YFInFodsN8DUcWwk0tPRMo/77JT72Tm1gEeRV5yzhrNDD37hW5VPBxubxNnhsETqt
	 qvzakVcR+iMgMA+p3hZ7UeNj2SX5DzRoYvMOQ5bGe6a/Ga14Sdc0EEd0rZ/7K8CZN
	 LxvjxNR6gHdcI1ZHeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1sLbmi0hu7-00IX3R; Wed, 08
 May 2024 20:08:59 +0200
Message-ID: <1f28bc3c-3489-4fc7-b5de-20824631e5df@gmx.net>
Date: Wed, 8 May 2024 20:08:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH net-next v5 5/6] net: tn40xx: add mdio bus support
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9wbZONoYNuw9Vy1PuV1whGUVS5OsRcpxQtgOeFx9BjKmMhbO4/Q
 zTnEubR4tbwUFLWgfCKwMngOaE0czWNuz7WeGMMkICz6pcj+Pi7eZsEVwmFxPucSP+ePppv
 TJpM8nDuBNwW3jjpsUONVNAfxayrJVzZzo819gvRneoatd/nWmzWUHNqwTOcJm132xX2NQ4
 VORygeKttu6kUPSE3bBEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i2HirBnq3as=;Gwn4e7JiWPJwJqSi67Q6e+A5RA7
 mfqQdH2uoImRtnCpt78pCDGKxX8ODHsSSbuTB3iMc7H5b0peVA2w8DDP9f2MOLh6Cf0Veq1n9
 1af305s6XLtqNC+ehBH8h00XY40qyzFnxlFDLOjM1Jm0t05ZOpjF95eRVVmaKZiqDSm+XCVe6
 YbWxLaBxeBU8XJcgRcd3e/wy+ORnlQMR7AE/DpkT0/8LOhfqJPCym27/y1O97INbDp4Ghloy0
 HITna2PyzVssz/JHOCbBpE4h3TkJBSeznf3vi2ifR0VJuTPcmSRLyAbfai+/3Q41KNpJZJAoa
 yRkvw9UR7UctPzLXWlixGvF345Sukk1CV5Y8jeL5QtMz/B6jZrvQPULj6LRFs4Ncxxqq+m6kg
 c/SiRvGw3rjJMbyZh6ZgzyASwBgCj/1PTHIyYNYzThpagKY/yGdesfpCDat/UXJp8qPuut9Rh
 lANgwKWKn7caUv5bli0u/YLV2OrDYnhkYYUFcVb2CoBLTI+F2T/khsNTt29sITL1iJPvyluQu
 h3H9Tg20AhjwpVLZW6Jz8GrVRL/TQ6MuFOhFSx2CiKVpOmlbNBjfw2iD2+q6KHF1jb8NNlLkw
 Q/TCSgOKnbk8v7mEavCHNMx2veNJRg3j2h1biYXlNmXhKgnOxZN5VdbL9vOVZDAn8VblNZd4V
 91IutSvM6GghcLUjtt5x5cATSkB4YF40OsNbAJ2J72VAIN4S75c3LHNU9vIiENkKHldJJ30fZ
 75FcsQDb8+bVXfqiSS289tFUFA+q8zu/wUtolAaD1evP2Nl/LlQIuCmhhez/e9qkZ9y/7D49p
 fPTa1lPtXWBUdUuuFBGUIe0pWLW31UVBweZiU1D0gSeLI=

 > +static int tn40_mdio_read(struct tn40_priv *priv, int port, int device=
,
 > +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 u16 re=
gnum)
 > +{
 > +=C2=A0=C2=A0=C2=A0 void __iomem *regs =3D priv->regs;
 > +=C2=A0=C2=A0=C2=A0 u32 tmp_reg, i;
 > +
 > +=C2=A0=C2=A0=C2=A0 /* wait until MDIO is not busy */
 > +=C2=A0=C2=A0=C2=A0 if (tn40_mdio_get(priv, NULL))
 > +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EIO;
 > +
 > +=C2=A0=C2=A0=C2=A0 i =3D ((device & 0x1F) | ((port & 0x1F) << 5));

instead of using numbers for the masks, you may use here the constants
defined in uapi/linux/mdio.h, to make the code more understandable

i =3D (device & MDIO_PHY_ID_DEVAD) | ((port << 5) & MDIO_PHY_ID_PRTAD);

 > +=C2=A0=C2=A0=C2=A0 writel(i, regs + TN40_REG_MDIO_CMD);
 > +=C2=A0=C2=A0=C2=A0 writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
 > +=C2=A0=C2=A0=C2=A0 if (tn40_mdio_get(priv, NULL))
 > +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EIO;
 > +
 > +=C2=A0=C2=A0=C2=A0 writel(((1 << 15) | i), regs + TN40_REG_MDIO_CMD);

similarly here:

writel((MDIO_PHY_ID_C45 | i), regs + TN40_REG_MDIO_CMD);

 > +=C2=A0=C2=A0=C2=A0 /* read CMD_STAT until not busy */
 > +=C2=A0=C2=A0=C2=A0 if (tn40_mdio_get(priv, NULL))
 > +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EIO;
 > +
 > +=C2=A0=C2=A0=C2=A0 tmp_reg =3D readl(regs + TN40_REG_MDIO_DATA);
 > +=C2=A0=C2=A0=C2=A0 return lower_16_bits(tmp_reg);
 > +}
 > +
 > +static int tn40_mdio_write(struct tn40_priv *priv, int port, int devic=
e,
 > +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 =
u16 regnum, u16 data)
 > +{
 > +=C2=A0=C2=A0=C2=A0 void __iomem *regs =3D priv->regs;
 > +=C2=A0=C2=A0=C2=A0 u32 tmp_reg =3D 0;
 > +=C2=A0=C2=A0=C2=A0 int ret;
 > +
 > +=C2=A0=C2=A0=C2=A0 /* wait until MDIO is not busy */
 > +=C2=A0=C2=A0=C2=A0 if (tn40_mdio_get(priv, NULL))
 > +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EIO;
 > +=C2=A0=C2=A0=C2=A0 writel(((device & 0x1F) | ((port & 0x1F) << 5)),

and also here, similarly:

writel((device & MDIO_PHY_ID_DEVAD) | ((port << 5) & MDIO_PHY_ID_PRTAD),

 > +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regs + TN40_RE=
G_MDIO_CMD);
 > +=C2=A0=C2=A0=C2=A0 writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
 > +=C2=A0=C2=A0=C2=A0 if (tn40_mdio_get(priv, NULL))
 > +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EIO;
 > +=C2=A0=C2=A0=C2=A0 writel((u32)data, regs + TN40_REG_MDIO_DATA);
 > +=C2=A0=C2=A0=C2=A0 /* read CMD_STAT until not busy */
 > +=C2=A0=C2=A0=C2=A0 ret =3D tn40_mdio_get(priv, &tmp_reg);
 > +=C2=A0=C2=A0=C2=A0 if (ret)
 > +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EIO;
 > +
 > +=C2=A0=C2=A0=C2=A0 if (TN40_GET_MDIO_RD_ERR(tmp_reg)) {
 > +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_err(&priv->pdev->dev, "MDIO =
error after write command\n");
 > +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EIO;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 return 0;
 > +}

=2D-
Cheers,
Hans


