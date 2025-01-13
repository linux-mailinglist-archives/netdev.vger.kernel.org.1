Return-Path: <netdev+bounces-157654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66973A0B1D3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388313A27A3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161223315A;
	Mon, 13 Jan 2025 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ1jtblh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F65232392;
	Mon, 13 Jan 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758556; cv=none; b=FspZrHOBO9IA8mwXGEi5bBEFAVZNgxlJKVsRKfPEtc8RYS4mFDAv0M+lS4tM6qsZvQiA/iu+y66cwqa2pqp8HABwLf6oTNRYNfMqwLEQCkEEERQihhb/KYrJeGoq8sdHlxE+gvoeDcHsbXjaHS3Q2kuVVjcaHLW8WeMmi/Kvf8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758556; c=relaxed/simple;
	bh=RkyumqO0vBbsobvhDANMJ/cNgv3P2GbEYzVETYWmWEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDapJ9ALKym1fvrEbqrtKbqGVnP4UPd097/zKUw4CzmRRlmX8rGguARTX3J6R+7BSyc7kI2jUAy56egSjYoKky8EXBHTqAblIEcpnH79tTDviB3ZkvykxIj2qN6/IAYbycVFyZj/oSFOztxNYPZms0QyKXzZ52SgJo5QbMZM5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ1jtblh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2039387f8f.0;
        Mon, 13 Jan 2025 00:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736758553; x=1737363353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvIJlupxd1L8sMhT6L/s3JzDKeQgODsrJTzuOHWpje0=;
        b=cJ1jtblhD26hTFtoUyT499Tc4KCb2wj+yP4dFlReHlMBZcKy4BIo8j99moaYmMbbaD
         9ydTYcxHPWBIaUqDNViIZg1jTvixs4IAwWJ8XVdtWF9hUE9GD8/jZhb0pi49NhMrfBXe
         On/0bs6cHKehIC0iVDXLQm+2hxkZGjK0Ppx5XaAj3ViWEjPTG9GxrMgvPiyR/5iiCNGn
         1WuQPAtfpTEyifG4aLcFTOxSJPeGfLWJcqdkySTgYpA5gB5zOVZ4AwiURceUomYEEynH
         m89fumvcFoJWA2E7eXUadibraBBtji7JONUaX8s5BrmQAiox8kFjcBMfUUeUbdeexAfk
         zNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736758553; x=1737363353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvIJlupxd1L8sMhT6L/s3JzDKeQgODsrJTzuOHWpje0=;
        b=TNciWTYl19becFhaQCJ0kBaFfx9teEpMGsHEBQSx2S9lLlStOtq+/M5WGwtDCi+WOp
         QdEVkn21LQeIBCVvpviqfioMyRXGhiABry59ag/mvKohxDEjBLA5uZzpeRASCdPtmPMI
         oguFh+Euwx0WVbNa6O0kRvGfwqJ9D9KTZs+AF37E/VGQRyxLUwA90WJiYCD+LHoabSrF
         lyuDlGXO8Va46ZhonuOqEuMGffjX0BzpbYqWM0QaOMtq5UpMJaADVvcloqdtzkjEhPLF
         yd/sBlWMr99j4Jkz58cDTvEgOy0fsAsa/28F5z3wQAIctD/4dFRiqf/qXZAAPR7JxLJC
         9KMw==
X-Forwarded-Encrypted: i=1; AJvYcCXsacnpJAU/f9MYKnT8QNfTdMMllLSI/0d6e/B1wFTlkiZPIdcLrv/3gPBCwKk9keL9EyXPyF7T@vger.kernel.org, AJvYcCXwj/vAINGfJAOKcxfuXm2uVG+2vPOmCzzBL68vBh8jylOo0T7Mj4o/bgV+hB3ONUq0YCzkcVwR1V57N5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5F0mlcejUa9RQsnn3bDxwe2bDQHI9zEK8whKC+LlP6wpaVjFg
	+fyCoxHzQEd0LOfZrNcj9kwwoibKlc/WfPld/+VCihS4DCJXF+mR
X-Gm-Gg: ASbGncusp/TxgCPMd+okIXwHHEgbZlgzZGvsLPg/dDWICe2BeQCRIgcjOrS6HNF/KKt
	iTg+/cvIDwtTpBm80KJpFMeM/G9b7VLsgqnXPMj1X9e3C/nO5hYUENCoSF6fsw+bJvyRVS8nEFS
	MA7BTPfnwblfV9++T18OZLaWbHCcDXrHQ0L1Y+mSfNEEXaeJMWfKQYSw5JUb6reiUB9jGudf2Tn
	hnuWTkJ9WVNG/Cc+pQmwIQT+/UJF/GbVeskqDC86ARGDAyKhnT1/w==
X-Google-Smtp-Source: AGHT+IHe6Af3xGNW0qWpOWFhJoujrjl1skyHOC6DLL11aMV9nClbaNWfBtykGyVYp3tqHjO/ScT2WQ==
X-Received: by 2002:a5d:64a1:0:b0:38a:4b8a:ffec with SMTP id ffacd0b85a97d-38a872ef24cmr17575149f8f.33.1736758552677;
        Mon, 13 Jan 2025 00:55:52 -0800 (PST)
Received: from debian ([2a00:79c0:620:b000:ad44:c8fd:4a6a:52bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1ce5sm11784896f8f.94.2025.01.13.00.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 00:55:51 -0800 (PST)
Date: Mon, 13 Jan 2025 09:55:49 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: Add support for PHY LEDs on
 88q2xxx
Message-ID: <20250113085549.GA4290@debian>
References: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>
 <Z4FYjw596FQE4RMP@eichest-laptop>
 <20250110183058.GA208903@debian>
 <Z4THa8DvQJu96Ycl@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4THa8DvQJu96Ycl@eichest-laptop>

Hi Stefan,

Am Mon, Jan 13, 2025 at 08:57:31AM +0100 schrieb Stefan Eichenberger:
> Hi Dimitri,
> 
> On Fri, Jan 10, 2025 at 07:30:58PM +0100, Dimitri Fedrau wrote:
> > Hi Stefan,
> > 
> > Am Fri, Jan 10, 2025 at 06:27:43PM +0100 schrieb Stefan Eichenberger:
> > > Hi Dimitri ,
> > > 
> > > On Fri, Jan 10, 2025 at 04:10:04PM +0100, Dimitri Fedrau wrote:
> > > > Marvell 88Q2XXX devices support up to two configurable Light Emitting
> > > > Diode (LED). Add minimal LED controller driver supporting the most common
> > > > uses with the 'netdev' trigger.
> > > > 
> > > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > > ---
> > > >  drivers/net/phy/marvell-88q2xxx.c | 161 ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 161 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > > > index 5107f58338aff4ed6cfea4d91e37282d9bb60ba5..bef3357b9d279fca5d1f86ff0eaa0d45a699e3f9 100644
> > > > --- a/drivers/net/phy/marvell-88q2xxx.c
> > > > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > > > @@ -8,6 +8,7 @@
> > > >   */
> > > >  #include <linux/ethtool_netlink.h>
> > > >  #include <linux/marvell_phy.h>
> > > > +#include <linux/of.h>
> > > >  #include <linux/phy.h>
> > > >  #include <linux/hwmon.h>
> > > >  
> > > > @@ -27,6 +28,9 @@
> > > >  #define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
> > > >  #define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
> > > >  
> > > > +#define MDIO_MMD_PCS_MV_RESET_CTRL		32768
> > > > +#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE	0x8
> > > > +
> > > >  #define MDIO_MMD_PCS_MV_INT_EN			32784
> > > >  #define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
> > > >  #define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
> > > > @@ -40,6 +44,15 @@
> > > >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
> > > >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
> > > >  
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK		GENMASK(7, 4)
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK	GENMASK(3, 0)
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Receive or Transmit activity */
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x7 /* 1000BT1 link established */
> > > > +
> > > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
> > > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
> > > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
> > > > @@ -95,6 +108,9 @@
> > > >  
> > > >  #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
> > > >  
> > > > +#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
> > > > +#define MV88Q2XXX_LED_INDEX_GPIO	1
> > > 
> > > Not sure if I understand this. TX_ENABLE would be LED0 and GPIO would be
> > > LED1? In my datasheet the 88Q222x only has a GPIO pin (which is also
> > > TX_ENABLE), is this a problem? Would we need a led_count variable per
> > > chip? 
> > > 
> > Yes you understand it correctly.
> > Looking at the datasheets for 88Q212x, 88Q211x and 88Q222x, they have all
> > TX_ENABLE and GPIO pin. Registers are also the same. Did I miss anything ?
> > For which device GPIO pin and TX_ENABLE are the same ?
> > 
> 

> Hmm in my datasheet the bits 4:7 in Register 3:0x8016 are marked as
> reserved. However, maybe my datasheet is outdated. I have the TD-000217
> Rev. 9 from November 10, 2023. It is for the following chips:
> 88Q2220/88Q2220M/88Q2221/88Q2221M/88Q1200M/88Q1201M
> If it is documented in your datasheet, then it is fine. Maybe they just
> forgot to document them in the one I have.
> 
I think this is a mistake in the datasheet. I have a newer datasheet
from October 30, 2024 and it is still wrong in the register description.
When looking at 2.15 LED the missing bits are described. In datasheets for
88Q212x and 88Q211x it is correct. I think the datasheet is a bit messy.

Pin names also slightly differ in pinout and pin description in chapter
1. Maybe this was what you meant with having LED and GPIO pin for
88Q222x devices ? In the description the LED pins is referred as
LED/TX_ENABLE pin. Sorry for the misunderstanding, but I think naming it
TX_ENABLE is still right.

[...]

Best regards,
Dimitri

