Return-Path: <netdev+bounces-124295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F21968D3F
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C391C20810
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0A719CC09;
	Mon,  2 Sep 2024 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUdnNIYh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB519CC02
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301169; cv=none; b=iKK3kpSvX+52I9VfX/t5ptFmmoidm1tMgBN75n5VDkVF7+JiSBfo5nP/CjBOzVTmHKlwQntvIqeN9NcdU1KVRTZWhjX/gSm0imLEsTrwB6BXcEbHqVGFbUF/+volLcP1Tn72IuYofZZyThAnrURdV4yKrgU0rvKSyfG8SKwt9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301169; c=relaxed/simple;
	bh=DP4HGv1xf4VCd8C4H0eYgTW8lwtQX3Lh/P7tubMC0l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XigGqK6gjKkTdjERFlGZK41LDoz21UgDYJZdV02Z0mbcpXu8bRLdJ8Ck8wcQbIsm30a3PPWiRYtUti0FUl2gLVZAIP7mVrraj7PSmrHhunbGCO3c53WNsWh6mfhc37MMb9am4h8OymrEOsvobbCPjyRUsHCy2zKeK7TMSBFEHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUdnNIYh; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f50966c448so51064321fa.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725301166; x=1725905966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19iTH2LdXRY8nzQULMp0j1OBNY6dxexn5fJYYaFPDAw=;
        b=dUdnNIYhjZ/4wanlJKLkJ4/RUNcC2gBNeoCKxzUZpyARz8Z+mA/9H3UWGuYMVyyZvA
         YVg16zFZDj7sh0fiN0ppnRzVAyuKmJic44gxEX6XO+WeeAaiDPPWy7zNgTdrX7I4xpxI
         Bi82FNQ7yNgru2UXoAHfpeIrXqIxAzmjYHImkISUFC8+/bA6gOpbbFwzWdoZca39A1nX
         mi80VM78iBfxBjTWhW9TQd6RsPBp8173lXW/JEHdUbafrxxk8Lmot4GTOTKNivnY4NfJ
         teTtZbFwW7mnE+aKRg66NKjXWuOSrdWbcRIZQoGF7uFCRKr+TFTuzBDUMNYKiJFYhvor
         hC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725301166; x=1725905966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19iTH2LdXRY8nzQULMp0j1OBNY6dxexn5fJYYaFPDAw=;
        b=k5Wr+yu1XLAmFl1uDYoXobUkJt6cpaAj6odXhgRljXBx1ccMJraDRFE1to1gOComhL
         J6i3WNNo/EqJSjV2p6ZsONImUEktkATBaF+CtKj9sWxGsLlmQeXGzX1JBTxmE6xvQp3t
         2pRh2RRcb/wki+vTy/SDCrbtIHSxIZq25EeU9R5exViWkl0AWum/2/kAqqxdjylssFou
         fYNNEVozN7+nwdftFk841uxDeccqggJFuDdwD7o6jJudOQQY7VoOBAj2MQjiHVpaR9qC
         IoAtQ9tO/RVRTc01jFzSaVXIjeDtgJwP0akn54hjX5ht6n82TLnclrPaVgu95ux1mYt2
         yaQg==
X-Forwarded-Encrypted: i=1; AJvYcCVqZDjaDx+ypGCtrZBHd9CQMIZssweI/UBaPQOHdSwLP3SbYo5Ic+156eTqMYkg+JPSz1saMCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRHIr0vdQC2uXc7elHbmaoEYfXYxFE1k+WCHzZUFx2UbEXjRO
	DHc7vlXXrwTHupCMS4x+eddVGyP4SZg/Q6/dJ+/p/WqmIoT7DnPUqe7vTFQZaawl34VJrEogd9j
	cVM8csgqllwRtVhmJQbFUtQws6B8=
X-Google-Smtp-Source: AGHT+IGvB9vFL7FidDh94hA1wk+8UK3n3jBYFWrGgOQPD6ptXDdiFktx3beYwV2AjHauEBpdCVC4fegVRDMxL2/luoI=
X-Received: by 2002:a2e:be08:0:b0:2f0:1a8f:4cd2 with SMTP id
 38308e7fff4ca-2f6104f284dmr134362431fa.33.1725301165762; Mon, 02 Sep 2024
 11:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901112803.212753-1-gal@nvidia.com> <20240901112803.212753-16-gal@nvidia.com>
In-Reply-To: <20240901112803.212753-16-gal@nvidia.com>
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Date: Mon, 2 Sep 2024 20:19:13 +0200
Message-ID: <CAHzn2R3Et_=e-JbC-P7ABecNdLnNM2deiyauatpNrGVCsGwnbg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 15/15] net: mvpp2: Remove setting of RX
 software timestamp
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Sunil Goutham <sgoutham@marvell.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Dimitris Michailidis <dmichail@fungible.com>, 
	Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jijie Shao <shaojijie@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Russell King <linux@armlinux.org.uk>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>, 
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Edward Cree <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>, 
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>, 
	Richard Cochran <richardcochran@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

niedz., 1 wrz 2024 o 13:31 Gal Pressman <gal@nvidia.com> napisa=C5=82(a):
>
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index 0d62a33afa80..1f01c6febc6b 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -5268,8 +5268,6 @@ static int mvpp2_ethtool_get_ts_info(struct net_dev=
ice *dev,
>
>         info->phc_index =3D mvpp22_tai_ptp_clock_index(port->priv->tai);
>         info->so_timestamping =3D SOF_TIMESTAMPING_TX_SOFTWARE |
> -                               SOF_TIMESTAMPING_RX_SOFTWARE |
> -                               SOF_TIMESTAMPING_SOFTWARE |
>                                 SOF_TIMESTAMPING_TX_HARDWARE |
>                                 SOF_TIMESTAMPING_RX_HARDWARE |
>                                 SOF_TIMESTAMPING_RAW_HARDWARE;
>

Reviewed-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>

Thanks!

