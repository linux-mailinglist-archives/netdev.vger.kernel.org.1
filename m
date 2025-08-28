Return-Path: <netdev+bounces-217995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB446B3ABCC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD527B77F7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B384B289E36;
	Thu, 28 Aug 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hierWXIa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6772256C88;
	Thu, 28 Aug 2025 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413582; cv=none; b=KY3GlzvyWUG3StYFfwAkqJXozITOgRGXFMFxkA2dWJYOvPEchsSHIr/GUMDxKY+lkoJ3w6EwxHvROdCnRrPwgGFLS0dLhrYnv3nZpYkz1v8rpVNYp5a1UT6W2IfdRo7gjwEcpUKHjQ6uJSThA86TWJ0jx/hQ/rUL+YFksdHHx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413582; c=relaxed/simple;
	bh=RvA1qVwDQQM+MM5e7wb77TvFi4H6pY4CD65xx/nqysw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9LVZUpT3hebHyoaiEkOZNCAVgUijS3KzbAbp6QuMUdNu//Nb3uTdJkytRgwO4UZDTtACYR5NaObUxruZjgpuBKQ2dLGz7grVmUzwb6S95RmvkzlNZzAdo+X2dLwZCs0NSqJ2/KpD862l3Xvekpt9DV2+pADobLPtICtbNzMIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hierWXIa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afe8493a5b7so18912766b.1;
        Thu, 28 Aug 2025 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756413579; x=1757018379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3KSZjwA0dfm4J2ve71NXpcaU37JmRBnCxu+rJwbrbZg=;
        b=hierWXIaGPLtvzNee8oyubWxbTorXOU+9Zzibany0t7oDdTv9zH6d3wEJnP614RcPE
         fwPhZFvYbhEVLGjezKURoloJUXe5eK1LpadmVnYCwi79UnxSAmhR5yGWRSspjFA6tSI7
         kdwF5Ui9CueQq0hJVK0+QEo9QUCQLxQA+Q7O5eUNCgb/bT2ehj9ALlDPuQH59R177+k6
         9PSVR2yqrFUvxUcbsGmHbC6nUWxpc41de2kRQSvlqczyqZU2dNIemxY8nptreuWQcZQO
         Wu/1tFEj/N0CtCuyemeHDmz4zj3z+0NsVJhPLsIfJKIkqav5odJ32mh+IlV9wHOma01H
         mjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413579; x=1757018379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KSZjwA0dfm4J2ve71NXpcaU37JmRBnCxu+rJwbrbZg=;
        b=edow3bHErOURM8i06iivvgtWfGF0EyOVmtvqTiHZSLaUozVTnlTV9kQrKSlAkeK4ez
         uzfdjBTEl+eSm+/WNvzX6OAvZogsfVZxTSo1Dz+CoAqXWq1khGnKzZrfaRAcTsAzqzUZ
         HI0fvriEDbQ79QKnCPiQxrnRxNZBt1lDtDBdVfFqWV+qTc8iCJW8P+M7IAw4kbIy1+Mm
         k6fTU8UTme9wJiEJsAUb56f5Ps/pdNUbIwBs2ybBomFLiofIoK8TWxNa7vRHWJKnFb7Z
         TwwDNyiTD06xi25bLhJVQojvMaWIxs6c3EBVRIxbBOWnQtBuzOdRQ/N8vkOPcb3TiJyw
         wWJw==
X-Forwarded-Encrypted: i=1; AJvYcCW+odyH/bv59gpHiqfqQ2ZjnFvz1SOve+iiE+AfL2z58l8eiX7o+wFpVDloSFKuPx1mLonfiw+Gbh+mAds=@vger.kernel.org, AJvYcCWObmQhr4O3Fn7O7ZNgvtU6AOjOdmcQ7Kpi9GueTKmHTZcTb5om5UXRdlc/OeGyv9S9MMI0VLp/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Qmdbw2lwUrxghEnDVbBRHjsOfkN2TibchKNytPxWK+7+sUaT
	qchayubyUPuWSFUCwae1qGudbYrZef3QHoNMjPdj4dyBREBWBBPL3/03RSOZlw==
X-Gm-Gg: ASbGncvrb+kG5CK+Ld2r8FwFDpldXM+Q1ojxXIyC9ukHnIB0/unJVJygIns8bLCiLFD
	/ExFNmic3QN2w327h+zLU904TAkdxC32sZmv9qfZ/aS+uKsH3658Xc4BeSI3NkLq9gwIz/eQPsv
	Mtc2aqiqHpSggwZWSKL53t1eOYKqWvcTCKS48MYzw1gbZk8sGjbcltVIRjbtYFj5pE3PP8aRTlH
	6tqnc+o5kcSM6FgVrsLxLWeM5Sr5ngbbH399cAHBEIg0dv43d6DaGoiLwg6i0IARf87Y6r9CVXo
	UsB6PdvzbXzTW0/sjOEl20EOVK15a7zbfSmPVRjH8uk4YoY4vhC10wgebwAn448amxSs4uAm222
	YxHvPa/eSqqaWf8IwnKJthq1b8g==
X-Google-Smtp-Source: AGHT+IHAipygz7am0Uu2myq69DYuiIZAMjblc5x5dWSpwyaYU1FeH0k+gFMBgvjaeJcOApZGAM3exQ==
X-Received: by 2002:a17:907:7b8c:b0:ae0:ba0e:ae59 with SMTP id a640c23a62f3a-afe2943ebfemr1127657466b.7.1756413579012;
        Thu, 28 Aug 2025 13:39:39 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:2cf6:b150:1dce:5f2e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca0e5e2sm36651566b.38.2025.08.28.13.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:39:38 -0700 (PDT)
Date: Thu, 28 Aug 2025 23:39:35 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 3/6] net: dsa: lantiq_gswip: ignore SerDes
 modes in phylink_mac_config()
Message-ID: <20250828203935.c46twi4r7qktxaco@skbuf>
References: <cover.1756228750.git.daniel@makrotopia.org>
 <99d62fca9651f17ed1e94ab01245867bcd775cd8.1756228750.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99d62fca9651f17ed1e94ab01245867bcd775cd8.1756228750.git.daniel@makrotopia.org>

On Wed, Aug 27, 2025 at 12:06:03AM +0100, Daniel Golle wrote:
> We can safely ignore SerDes interface modes 1000Base-X, 2500Base-X and
> SGMII in phylink_mac_config() as they are being taken care of by the
> PCS.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: no changes
> 
>  drivers/net/dsa/lantiq/lantiq_gswip.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
> index acb6996356e9..3e2a54569828 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
> @@ -1444,6 +1444,10 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
>  	miicfg |= GSWIP_MII_CFG_LDCLKDIS;
>  
>  	switch (state->interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		return;
>  	case PHY_INTERFACE_MODE_MII:
>  	case PHY_INTERFACE_MODE_INTERNAL:
>  		miicfg |= GSWIP_MII_CFG_MODE_MIIM;
> -- 
> 2.51.0

Is "miicfg" irrelevant in these 3 modes? Doesn't it have to be set to
GSWIP_MII_CFG_MODE_GMII?

