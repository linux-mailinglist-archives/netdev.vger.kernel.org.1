Return-Path: <netdev+bounces-187693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4463AA8EFE
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B14D173701
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4983C1F2C56;
	Mon,  5 May 2025 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayLMkAit"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D91A5BAE;
	Mon,  5 May 2025 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436222; cv=none; b=Voijyz+BD9ZJe6lwoNWGLCw3MAsXc7rAuUORTJv+B6iZCkul8R7GXkwV+3KzwVIQUhuc2u95SApGOxLwqUNl6v/XtXXdHxNCb+wFFV0iwAqF+23mDJWH7/gJ5rC54w5OqSzZK3QyuThMJ8ONVCKbuCPzFzrfdt60YLuQossnCJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436222; c=relaxed/simple;
	bh=puuc22v2t/JD2fiBI9QkGj3Q41l34IGpAdd9V3RoJbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsytRX8LKyFJ24PPkqejOEPQnXT9APfVxSHGUXEcDyBEW07drGflMYsNcwE8oe+58sg6rlesY0kSlDa7gvHnCVuFZTopZgFizv44fWoK044XrO+p/mNJs2Bvx4+yMuH7phwtWbEmbZYRxtZ/+GE3wZac7XER91O4ayK75XAGWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayLMkAit; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so14962255e9.1;
        Mon, 05 May 2025 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436218; x=1747041018; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J+vROSkrhHhaFxfGi2oXWznd9/H+mGUL5SpO8laPrVM=;
        b=ayLMkAit5GpVB0bvGGefyc+HyO+sz3C9NIWSAR4BcXcrQP1VGH6UJ59E+AwPNHxPZ9
         L/MvRxs/V53lQKWt3GT4zaDluKjMvYzkXxvb17JcihRaUB9C1IrAcV3xM/qBCpkulqKI
         /XMFngu1fAvGvXj6Y2F35a+mNw5Vc4l92bosd2H/Jtph8e/yVS/AL9lYVBk7C/9tPlv9
         F5WZF+YiCiZOmbtMwEHfbfUpRtbOlZF0sc5UupFo/hPeGI8lgsPDVMrS3ScnX6UFJBSE
         Na1T2/2nBK2O+nyB1e7t11pdiJ4uoY4PdOtV0CYCWpdBeLFYWkJUswpBgyif0+YwGpLc
         P8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436218; x=1747041018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+vROSkrhHhaFxfGi2oXWznd9/H+mGUL5SpO8laPrVM=;
        b=gisGJ++JLVlVYeQLQ+PS5aac/mwAXUcbsiCU6BqYRRkPi/5tg1jkqBN6ZH2PPGy95r
         hZFCUnO9rsxEYUXADagrzFWPPC6lqq/z9URVaQuIRQQoH0+FwCpAP13I4wCZhl27PwOF
         MH6exMGKGFdhejOPcBZGu/2sR9Z5U7zP/JDveiU3CJrEHLVtACKaSwdVonsmGmm1bFqu
         P3PSla1Zmfn3AjQcv0f1BoZ+W18XOTU6vFYXTDpnIstGDyMc90QRWfgvj5LX6MQqzAcU
         maHQB8eGw3kelP+Ht6Eh54YC4seY7jVXuQuhS1JnLh6M6MK4JoBBHOWnNIYrqmNirpG/
         +Bzg==
X-Forwarded-Encrypted: i=1; AJvYcCU6hvpYurLpCeudZHOlq2UvuEoU1vscmtjLAhazBAi1Ooc1KhRyWL8uogskzpJZ/f5CLk0KhLtF3wtJX3o=@vger.kernel.org, AJvYcCWl6eHR2WY8pERqA8Rxc3NAHidXuJQY/OQZBAwQVBiRaJXAB6ypZM1RE8ZvI90UGObFGSNQxb0d@vger.kernel.org
X-Gm-Message-State: AOJu0Yzszeh/llOXkugH4UeIFtXOp0ccUYpKFX9MJ3sYOzALP+Xhr8Gi
	Yn6TmmCmf5bS9ISQ5BxCJSMcpF7LlGJpYXcxzUKBQGUUWEuu9wcn
X-Gm-Gg: ASbGnctjb2Ib+ezYj7K0HqL74a/PjBcAMMwRfFPxe0/iLddHxksJlLulmlpYQ/Jej5N
	wLLtu0GpuQr7qDubjZ79c6VaGr88Qqhkbt6D+uaP9dyRw9DLxm34IVhcPEe3aEBzUX0zZ1UvfYy
	JEPuPqjaVJUNVrL87rDRBg6DaWdkgoHNlg7aywn2CSMikBWeJRsCQ9BYvuWV4KUiJJzTjqEeZfP
	jp8bc9qDBXbUbf/yKxSouc/RqCVD37jk8SXTMDGOl3/CdTrSfaCnz9d8h2Ju8O6IJx0jfRCtecy
	pda96khkpmLVsVBxgbvIi+UKyy/5mDU4eN592g==
X-Google-Smtp-Source: AGHT+IEETkvA9kxggSfQEv6lgC0JK2LQfLov2hirKwFSQLnPT59YeHE1WVZSeMLo3STImaGoKT2/8w==
X-Received: by 2002:a05:6000:310f:b0:3a0:88e5:dbb2 with SMTP id ffacd0b85a97d-3a09fd6b796mr4972409f8f.11.1746436217424;
        Mon, 05 May 2025 02:10:17 -0700 (PDT)
Received: from debian ([2a00:79c0:608:9e00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17074sm9931794f8f.95.2025.05.05.02.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:10:17 -0700 (PDT)
Date: Mon, 5 May 2025 11:10:15 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next v3] net: phy: marvell-88q2xxx: Enable
 temperature measurement in probe again
Message-ID: <20250505091015.GA9329@debian>
References: <20250429-marvell-88q2xxx-hwmon-enable-at-probe-v3-1-0351ccd9127e@gmail.com>
 <20250429200306.GE1969140@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429200306.GE1969140@ragnatech.se>

Hi Niklas,

Am Tue, Apr 29, 2025 at 10:03:06PM +0200 schrieb Niklas Söderlund:
> Hi Dimitri,
> 
> Thanks for your work.
> 
> On 2025-04-29 08:54:25 +0200, Dimitri Fedrau wrote:
> > Enabling of the temperature sensor was moved from mv88q2xxx_hwmon_probe to
> > mv88q222x_config_init with the consequence that the sensor is only
> > usable when the PHY is configured. Enable the sensor in
> > mv88q2xxx_hwmon_probe as well to fix this.
> > 
> > Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> > Changes in v3:
> > - Remove patch "net: phy: marvell-88q2xxx: Prevent hwmon access with asserted reset"
> >   from series. There will be a separate patch handling this and I'm not
> >   sure if it is going to be accepted. Separating this is necessary
> >   because the temperature reading is somehow odd at the moment, because
> >   the interface has to be brought up for it to work. See:
> >   https://lore.kernel.org/netdev/20250418145800.2420751-1-niklas.soderlund+renesas@ragnatech.se/
> > - Link to v2: https://lore.kernel.org/r/20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com
> > 
> > Changes in v2:
> > - Add comment in mv88q2xxx_config_init why the temperature sensor is
> >   enabled again (Stefan)
> > - Fix commit message by adding the information why the PHY reset might
> >   be asserted. (Andrew)
> > - Remove fixes tags (Andrew)
> > - Switch to net-next (Andrew)
> > - Return ENETDOWN instead of EIO when PHYs reset is asserted in
> >   mv88q2xxx_hwmon_read (Andrew)
> > - Add check if PHYs reset is asserted in mv88q2xxx_hwmon_write as it was
> >   done in mv88q2xxx_hwmon_read
> > - Link to v1: https://lore.kernel.org/r/20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com
> > ---
> >  drivers/net/phy/marvell-88q2xxx.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > index 5c687164b8e068f3f09e91cd4dd198f24782682e..5d2fbbf332933ffe06f4506058e380fbc7c52921 100644
> > --- a/drivers/net/phy/marvell-88q2xxx.c
> > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > @@ -513,7 +513,10 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
> >  			return ret;
> >  	}
> >  
> > -	/* Enable temperature sense */
> > +	/* Enable temperature sense again. There might have been a hard reset
> > +	 * of the PHY and in this case the register content is restored to
> > +	 * defaults and we need to enable it again.
> > +	 */
> >  	if (priv->enable_temp) {
> >  		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> >  				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> > @@ -765,6 +768,13 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> >  	struct mv88q2xxx_priv *priv = phydev->priv;
> >  	struct device *dev = &phydev->mdio.dev;
> >  	struct device *hwmon;
> > +	int ret;
> > +
> > +	/* Enable temperature sense */
> > +	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> > +			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> > +	if (ret < 0)
> > +		return ret;
> 
> nit: I wonder if it make sens to create a helper function to enable the 
> sensor? My worry being this procedure growing in the future and only 
> being fixed in one location and not the other. It would also reduce code 
> duplication and could be stubbed to be compiled out with the existing 
> IS_ENABLED(CONFIG_HWMON) guard for other hwmon functions.
>

thanks for testing. Wouldn't it then be better to implement HWMON_T_ENABLE
instead ? Add the enablement into mv88q2xxx_hwmon_write and the user is
responsible for enablement of the sensor ?

Best regards,
Dimitri Fedrau

