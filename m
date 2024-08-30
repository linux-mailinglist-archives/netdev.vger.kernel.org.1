Return-Path: <netdev+bounces-123870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702B1966B30
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D63283469
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEAF1B8EBA;
	Fri, 30 Aug 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFApY60P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701DF41C79
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052620; cv=none; b=fIKEnjsmVaBbNMNAeOVvjw7DVcJhdX1VIJvTC7HxsskMBCxZ5wvJt1jjYvEWZrdqzQm1OpFIuUPRy5zxvyW41nr2hpE7WtAd/Ien4KfoBt/pykW5u47UZ4VPp/VKv+QFkzJ9onTVtZwnlL8EfTbCBZwFD7OGr7JG47yK5PGbRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052620; c=relaxed/simple;
	bh=K1GZd71bZornzMDeHsaeBij/XosICX/wO1AsIMW5wwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEjlQILclYXJoteMegqKrn4oBm2SM0Qp2oHKdpF2PsU+3HirLk2yJsg5HFeyk/dOj5wMG5XOZFDuYNwixOS5xKWgvAT8KKPxHoVLP6ncJFqidea0JVxvwX46qW+hEWhuWTscCTBAuGUVKJq+CkgJ1uBNdXiP6ZC51+i4UJE3Hks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFApY60P; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7141feed424so1980318b3a.2
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725052619; x=1725657419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nRrcrLXvuM1KnLQqBmpkRNZeURe9jCXqsBppFk4r/Kk=;
        b=GFApY60PZ1glqfgvpF12rzS4P70LZvX/8+o8Cr+6Fl7ptgWrkDXsqii9tFfds4HwEW
         9gIS6RmcvrjnILJ24z5l5WphhXoFNCVSK7w6tLEX1gfjWTxQP5zjzV1fVTTPRg73jvdG
         2B9zbdB5ap6V205AYR8oSnPKHWNtEIh1n/CreiTH2nPOJA8daakNk4+LmnVB//D1Au86
         nkE+hDiDb/56N9dJt+HkWqbg5p2fXOEHBHaYk0rWajJx82u5ppsE03j2r/ihU7TX8gFd
         zkwCsNTSXSrcaLhA3IiyGUO8hD4HpS/ZGvAob4kPI/OMjjgcyZ4XUB9Qxl+v+V4rx/I1
         z3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725052619; x=1725657419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRrcrLXvuM1KnLQqBmpkRNZeURe9jCXqsBppFk4r/Kk=;
        b=KbxaGAxSwVUbVsu4qi6oyWygS3gWN1tnC2PxUEPaUTuwIagClyn4AV7lyEuTIh3Glm
         v6sv5t702ZFTwlYQ1Aft6Z3PnLsMsjmOBhG7UFeO7jd8ouRfFmwhGvMgBuffm9FHW0WE
         w4Fr18n2onZCRSjGPUYjfnjkYdE9ULTRHwVcEDvAiFJbb40X7VwBKcTMrO5rwo77tN8m
         5PgvhGkH+jw3qqrCyNYsHihteAeibWn1R5WzR31inuSnbDc71rTuGTSmw1GSTdwefcxz
         /zh2j5FyT2JLLH9EpRsPMZ9L+KPf/yVvVinww3Z3xYQBAp0DOyHEpFQVBJwRjZwXT1+V
         vV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJlrtOHTyRq8wc0YrEMD1BOtyEsR76YFS/TqjXE3jQt6KK2LGjlkhuRWP8+f432gPTo+ocq2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZJF92Gpsaf/VKwUBVzFc+pSfSkLzq+cDeNHEsapc9a2kMDXN
	PxMC65Tnkf5CsTTHTq51vYAjVgXif/QG8JxpsymnfzvpKBcpRsAI
X-Google-Smtp-Source: AGHT+IH/HdW0rJupr/xAECzzvQeqYLLMXkkbnfVATxqPwZHvnWr3dDkXxdBe2tcaodvZHfyZJpHeoA==
X-Received: by 2002:a05:6a21:a343:b0:1ca:ca29:a754 with SMTP id adf61e73a8af0-1cece4d7269mr1049450637.11.1725052618601;
        Fri, 30 Aug 2024 14:16:58 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56e3f95sm3293268b3a.176.2024.08.30.14.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:16:57 -0700 (PDT)
Date: Fri, 30 Aug 2024 14:16:53 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sunil Goutham <sgoutham@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software
 timestamp from drivers
Message-ID: <ZtI2xWNRuloF2RDF@hoboy.vegasvil.org>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>

On Thu, Aug 29, 2024 at 05:42:53PM +0300, Gal Pressman wrote:

>  drivers/net/bonding/bond_main.c               |  3 ---
>  drivers/net/can/dev/dev.c                     |  3 ---
>  drivers/net/can/peak_canfd/peak_canfd.c       |  3 ---

...

>  drivers/net/ethernet/ti/netcp_ethss.c         |  7 +------
>  drivers/net/ethernet/xscale/ixp4xx_eth.c      |  4 +---
>  drivers/ptp/ptp_ines.c                        |  4 ----
>  46 files changed, 47 insertions(+), 208 deletions(-)

This needs to be broken out into one patch per driver.
That way, one can easily track the Acks.

Thanks,
Richard

