Return-Path: <netdev+bounces-69442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE39484B352
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE4A1F2466A
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBA512B14E;
	Tue,  6 Feb 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXlpARtc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69F56754
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218431; cv=none; b=D9dM5siQw+k2/FZzPy8D+ww0EwJVG9AziCr9ORVs5+piMypwXS1liGkVWahvdNlfyknnLfBkw1DMksFkKCpsoxFFtuT/mlnb/iO4A5whOTyRjgib94y1gLp/61gamm7kYIcywfc5+P1j+Opf+v1objky00ZSwhCFm+SfotKFTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218431; c=relaxed/simple;
	bh=OlB2OEQmd/K1b98VvESLu2jUoZA2XBUHEXhD14Hc9Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMK2je3Wei69Vy0iYROH5CRrSR8z7FML4GjBc0jGnj2fCXCWtSd2Uy694lykNq/hR4TjQyTZMwKsUiSj1GU24ZT90UqHwE/tYHM8W4MjVMd/bQpDhImU7yqF1bskLtcSAYkeAjpR+aHA8agPBPDXECyMQ3AQgnXkGv67AEyyXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXlpARtc; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d04c0b1cacso68740301fa.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 03:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707218427; x=1707823227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZUkF6qQkW68JTbbtNstjqI5lBDrxSml80X/oZkP6Jk=;
        b=LXlpARtc/HYXY/h4HHa6DcYG140dYmr3wZ2O1gu+HRWVELHRrsrAzMH/j94z44kFzi
         fS+ytOMsns09ExkFm96LfRHHCrExpDDhGe0MAU51aLnSDdJw/rnJINIilQbC8yAwhAbE
         rVrpyXmzbt3giOHAcI8WlUdi0V6sOSUbqQmv69h6pv/HlUUnX8Y54aSx8HiRqAm2Ph9M
         UjrAx9NAfpv4+OQNkABDygtfbQtPHngFz1bJAtQARqRdOF5vtXT+w+PCi4eyX1q5c2L2
         jPz9kllMEcaOQaR8b1U8thfkmDcgay/T4h0f2/eVdtGUJpK1D0lKSXimOjE5W10GPuJv
         D9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707218427; x=1707823227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZUkF6qQkW68JTbbtNstjqI5lBDrxSml80X/oZkP6Jk=;
        b=NZMmie6dzMI+q4rgTsrf40pT5xDO9oSuncSVMI+hxO6T+USyDaGEadVqM+ziFyiiKg
         LzlI/Y/+kE1yDqIBGI//NA/hIhGNqY5F/D+WpIgu/Pv7hqU4zChFKDnZNze9/ryLlYl4
         3TDWYZ2BKBFUWnN2lrhdICB67IjVqXSaGet9NGNKqASp2VkYfKvSgowUaSjAUQtT0dcH
         Kzsr3Nx4JoHDeLC/TExj2jNeKeAYzIuLTdCDt8LFLc/Qtn8ZJ41+xsquAG6CvOGknfNb
         fI62P6QscjQCd0pPTJrQTXnfgaLliVoAq7PgWB/JYqyDqSMapiCsYtbKgwdlQUxLyCZU
         rQJA==
X-Gm-Message-State: AOJu0YzH/DiGNv+1uI4MnoQ3UETCaJQZ6/FvKD0qTEbRizq9S0NfeGNX
	pJ6sfPNN1sTUMlLKjTLlMx5w6suPjMWVUeZOlHJw8Wq7vgFJq7u3
X-Google-Smtp-Source: AGHT+IHW2LkipLfX++vRM5dnDW6bduLO6JoK+Xv12mfq908JaY4bohgwFQKI2raGy/UuCHKa9YF1yA==
X-Received: by 2002:a05:651c:d5:b0:2d0:9a6e:106 with SMTP id 21-20020a05651c00d500b002d09a6e0106mr1807106ljr.43.1707218427282;
        Tue, 06 Feb 2024 03:20:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU8bYPaI3YnkZ9qObyT85rw9Qb8bPNkodfCON7S9bFI2g3Gp2FvLh44VCCd1nIXzAo0B9ZFUZHtoKmw+OQMBaV5wFUEi7okjcvOXXM2erXPOjb2kpL6G22QFBuiiDxoK62+79Axr25HLQzomCTTxoabKgEC2Q5nVG8/eAPeYqmzjybtC7L5U0VDv6jimT00eScRUEXmoFWrHQoy3wtd4iCl/tkWxKedPbgMIkuq47/ABLm/5r/7cJoiXPdk3E90Hc5G4oq0BOHzzsY5lEZiw0pj/ZVTylnhpxd+cczPUjdXgfGHAk79FgB1d4SYFWw1jADQfLv476Yi5kPH5rDzo4WAEiwm3ylHTfG+XHn2Fl6lOAbfhRwwUpDPEezP1PpSaoAcqI+VzkDkTvSJFE9b+NAljPTwmWk4DRrfUT0XLJHBiewTLqEcedFIVxU7avLKHC8Jv3sXOM6R47W+czO/we8MjegmMxPPxHvL1/B6S69QKyryLLaQ0z5D6n1yxpePuHLyPLfs/SPeAiByM6CY2ON4RYmCGC38j62t9GNjhe/HPkTT1bVj15MwCZ9hF2VResSHXmFFl2sBxcrn43PwVPRFnRzwiVcmxFVBn6IDAjWjss6UE8nGcT2wFH1M7A0qGkPic7nTD3FIe474uaTpFMN8kXtxKQh016Lr3LRc1OtlM/Qa6YHANwJb08xUVXOqcN7vTIAf9axrZ6QvTYzz7XIjyEv9
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id kt12-20020a170906aacc00b00a36c7eb251bsm1029561ejb.157.2024.02.06.03.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 03:20:27 -0800 (PST)
Date: Tue, 6 Feb 2024 13:20:24 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next v2 6/6] net: dsa: b53: remove
 eee_enabled/eee_active in b53_get_mac_eee()
Message-ID: <20240206112024.3jxtcru3dupeirnj@skbuf>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
 <E1rWbNI-002cCz-4x@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rWbNI-002cCz-4x@rmk-PC.armlinux.org.uk>

On Sun, Feb 04, 2024 at 12:13:28PM +0000, Russell King (Oracle) wrote:
> b53_get_mac_eee() sets both eee_enabled and eee_active, and then
> returns zero.
> 
> dsa_slave_get_eee(), which calls this function, will then continue to
> call phylink_ethtool_get_eee(), which will return -EOPNOTSUPP if there
> is no PHY present, otherwise calling phy_ethtool_get_eee() which in
> turn will call genphy_c45_ethtool_get_eee().

Nitpick: If you need to resend, the function name changed to
dsa_user_get_eee().

> 
> genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> with its own interpretation from the PHYs settings and negotiation
> result.
> 
> Thus, when there is no PHY, dsa_slave_get_eee() will fail with

Here too.

> -EOPNOTSUPP, meaning eee_enabled and eee_active will not be returned to
> userspace. When there is a PHY, eee_enabled and eee_active will be
> overwritten by phylib, making the setting of these members in
> b53_get_mac_eee() entirely unnecessary.
> 
> Remove this code, thus simplifying b53_get_mac_eee().
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/dsa/b53/b53_common.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index adc93abf4551..9e4c9bd6abcc 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -2227,16 +2227,10 @@ EXPORT_SYMBOL(b53_eee_init);
>  int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
>  {
>  	struct b53_device *dev = ds->priv;
> -	struct ethtool_keee *p = &dev->ports[port].eee;
> -	u16 reg;
>  
>  	if (is5325(dev) || is5365(dev))
>  		return -EOPNOTSUPP;
>  
> -	b53_read16(dev, B53_EEE_PAGE, B53_EEE_LPI_INDICATE, &reg);
> -	e->eee_enabled = p->eee_enabled;
> -	e->eee_active = !!(reg & BIT(port));
> -

I know next to nothing about EEE and especially the implementation on
Broadcom switches. But is the information brought by B53_EEE_LPI_INDICATE
completely redundant? Is it actually in the system's best interest to
ignore it?

>  	return 0;
>  }
>  EXPORT_SYMBOL(b53_get_mac_eee);
> -- 
> 2.30.2
> 

