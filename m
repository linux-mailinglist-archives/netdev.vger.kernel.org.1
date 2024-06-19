Return-Path: <netdev+bounces-104902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1401690F0F6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CA8284110
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC21CAB1;
	Wed, 19 Jun 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDSpWYoa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DF2E633;
	Wed, 19 Jun 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808170; cv=none; b=I0+u+H133FWfLAoh4oS2ANfxywejtZFNGLZK0xtlXT+RyJH5wG8mHisumDjf/zxC+U3HiT4LdwF+mv855803v/0+6oZ/33CVtWG7az+rCBNI5EdZnoRkey1YNoFJTAzZDFX9nopykLUoadKsqkOKtrU0eM43iNjKdQED8MYRfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808170; c=relaxed/simple;
	bh=J4W6rkn0pCXifgtTMyBXz5GweHPbTyEY/MQztGwLmcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojbt+RmjPssgII4lXC0prLtoaZ1qAkq3NcSM/4/m0mzROUEOrFPzWSQ2WNHjyLD6Rr9FFjitze/Odf0ooIG7jb/TvCuVAZRmJ1dbn3ztzAHEhkZzvoMiEWTsKm4EOp5Jt/IQw0fUkWe02LEgs+dYiVIrvhe6T5bEEZ+99VQ3hKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDSpWYoa; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso5979800e87.3;
        Wed, 19 Jun 2024 07:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718808167; x=1719412967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+ycexqOhT+vgEOCrNgBNQyt2+cArhyIE1264Wo59F0=;
        b=NDSpWYoapjbuAq0N9UKsGRZqdfZIS7fFbMOR4f3M2Dci7EnapXS59k9efVzp+TdBBV
         3Kua2Gtfjsa8I0MhqzDrJ4pr9z7r+dWLb/MJOUP8BKG1H6f9uyXYe2D6M6MQKcsn3A7p
         J3HvLU4FNd5pDyHt6i6zgLJOYPS/Jpt8nBIzgV2J19SyJqDfhF+hXsandQz4YeecfRtA
         LiJoMJ2dQrGv7HswLl1KxeEs7WXcZw1dAOJndnOerzqi5KqElyc+zAPKgTX77XDjOaT+
         OfjeYE4ZNDArYu0Ub9tYhuGLj0Lo2HkGMxsunVPAEkwu8sIlORR/Pcyyinl1K1XzYfnj
         ehNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718808167; x=1719412967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+ycexqOhT+vgEOCrNgBNQyt2+cArhyIE1264Wo59F0=;
        b=hmiGC5I0nXrHVBb7xmECcU139qyrxt5NnSnkPuh+L+yc9+PZjPs2O6Np0uThduAwoi
         LKqBzfY9nziQ2dPXZA9ynMZkkCxSyYQ+99J18I3XKAs3lhk62QoUFA1u+SIUAv27Zafk
         WO/d+eaNne0hPaHQ9n58Ke8frol3fV3HmgmB19LlQ66MsPaa6K+OpmG37YupMPslX61X
         NE7AFeMt/sfBs3I4EjqBoTzi8LC2T8q+qn1jNBPCyv3yPuxSrmTVLKa4x9Bgggqr2rWk
         GtjoeJde2kwOgY/Ruc9mHPog1ltUkzVo56sAx+PkrYiDYe6HcLLrKkgVio2dm9zYt1dY
         6ZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtobNVfPmn/AvHyznwCAcGZHDxon+W6Qq4U0pYrAoNhEV7piVhfFIP9pxVCK0GxHEUA6lDaRTin8jXtlRrMyAkkbTZypH96hwqZ43vDJdt5R+uhP0nBJYf8fq4k52+1QkZ/e/8
X-Gm-Message-State: AOJu0Yz+YhAvh+bjPRiIJoVTHYepV6Zo/CCHgg4l0LoEHYnvM6SCXSkk
	JkFIFXNLdBXEnWJWoBNqFUPnFRe7IVZgbtGOT+9jUdsMu96iZWIw
X-Google-Smtp-Source: AGHT+IFujPFCfRlqBD159YcXjyTvKEmWFQkPSsXY2EGM1Ddhy12Fct98Jk0mOWVs5KiMxECPXpcYUQ==
X-Received: by 2002:a05:6512:3d04:b0:52b:c262:99b3 with SMTP id 2adb3069b0e04-52ccaa5693emr2005971e87.11.1718808166454;
        Wed, 19 Jun 2024 07:42:46 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f57ed951dsm661648366b.196.2024.06.19.07.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:42:45 -0700 (PDT)
Date: Wed, 19 Jun 2024 17:42:43 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240619144243.cp6ceembrxs27tfc@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
 <20240619134248.1228443-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619134248.1228443-1-lukma@denx.de>
 <20240619134248.1228443-1-lukma@denx.de>

On Wed, Jun 19, 2024 at 03:42:48PM +0200, Lukasz Majewski wrote:
> The KSZ9477 allows HSR in-HW offloading for any of two selected ports.
> This patch adds check if one tries to use more than two ports with
> HSR offloading enabled.
> 
> The problem is with RedBox configuration (HSR-SAN) - when configuring:
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 interlink lan3 \
> 	supervision 45 version 1
> 
> The lan1 (port0) and lan2 (port1) are correctly configured as ports, which
> can use HSR offloading on ksz9477.
> 
> However, when we do already have two bits set in hsr_ports, we need to
> return (-ENOTSUPP), so the interlink port (lan3) would be used with

EOPNOTSUPP

> SW based HSR RedBox support.
> 
> Otherwise, I do see some strange network behavior, as some HSR frames are
> visible on non-HSR network and vice versa.
> 
> This causes the switch connected to interlink port (lan3) to drop frames
> and no communication is possible.
> 
> Moreover, conceptually - the interlink (i.e. HSR-SAN port - lan3/port2)
> shall be only supported in software as it is also possible to use ksz9477
> with only SW based HSR (i.e. port0/1 -> hsr0 with offloading, port2 ->
> HSR-SAN/interlink, port4/5 -> hsr1 with SW based HSR).
> 
> Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Changes for v2:
> - Add more verbose description with Fixes: tag
> - Check the condition earlier and remove extra check if SoC is ksz9477
> - Add comment in the source code file
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 2818e24e2a51..72bb419e34b0 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3906,6 +3906,13 @@ static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* KSZ9477 can only perform HSR offloading for up to two ports */
> +	if (hweight8(dev->hsr_ports) >= 2) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot offload more than two ports - use software HSR");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	/* Self MAC address filtering, to avoid frames traversing
>  	 * the HSR ring more than once.
>  	 */
> -- 
> 2.20.1
> 

How do you know you are rejecting the offloading of the interlink port,
and not of one of the ring ports? Basing this off of calling order is
fragile, and does not actually reflect the hardware limitation.

