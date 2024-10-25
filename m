Return-Path: <netdev+bounces-139077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41BC9B00BB
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C85B1F23D5F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFA31F8199;
	Fri, 25 Oct 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw91+5c9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F918F2F7;
	Fri, 25 Oct 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854003; cv=none; b=EH5BlwgBrPKWPv7OrnLhMl4eJyCIcHaMOun/j1EgHyN1w35lGSdm+fNvOr/DQQqAqDVr6W8Ys06rD8WxIemhndoSPPZVADTcI147thrAWGElLFLLyeISi9iX24sQ/9BMUNX66kUOpskNhBojBVxbfeIqLQpZkDq4AV+G7FSO34E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854003; c=relaxed/simple;
	bh=6Ps0yBBWgYKMhHYyl2W2InoxQWQn4YPGBsA5qbEFRZc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R23btWSNrbZQGb/piyIpc+VLThEA5T8iOm2gp8iPFu48x6cthcnDFvdY2RRplJUcPzxzF3ZdpZT2uljlyG+uPtAp4TCU2VZ3paetFHUltRNsJpRznwYHRONBVB0p6RM+9Urxyor9tVxNtTZFt+hmnv7vI7pZAxceLDFvA8/ahHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw91+5c9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e13375d3so2269091e87.3;
        Fri, 25 Oct 2024 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729853999; x=1730458799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vYAT0NQ+qVm+2dkwsN0hxFRRjvOuoToskTsqyxD3qRs=;
        b=Qw91+5c9/J1Wpq0NIiauBr54XKC0ERz513nGF6nVwSJRyseZkdymEIbR9YtCzwNINN
         YDMzX0r6L+jNxzfChKHzkM4dwhgAdBeidUiy6aXinO+c7TEbMR9AB5j0GB8qJRnAHFmX
         cMzUnwI+duodAKctl4Cgb3ffI4f/ad8/467pl5b+hW6LKIdkmnPJnPSQPOOvHhY6nUU8
         EIWouxJy+/QKN0ZQwQJRt0pxi15Sew1FAcutd52QfmxUgr3/iA498JoSrWJehVSoW+Dl
         s4UKQxmJlciK32oqM8Y0WXv/ZqIlxjSl54SGQfM+zmEi6aCM2X4IbKHzJuBZwnh6cXLH
         0dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853999; x=1730458799;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYAT0NQ+qVm+2dkwsN0hxFRRjvOuoToskTsqyxD3qRs=;
        b=F3M5yj8FMOD+PrtP2P1tVSskST4prpZCI6j2kJuQvANCkII9aOjJw35elSEo85c7TH
         VcDTFyWnf/Tfk8cjAchjXTE77z37ZbGoYHVJrWHTnXDdp/d7fltSQmVGaMABkQQI4qcA
         A2KxbkgbEMsITJXgDQDZwDxf+n24bxST+0yhFNk9aPwuu6rdH8J+iNOviz/CZs+EqnKY
         LKicw+R2ebgeuJ6zro7iLnDoRAMv34M6pLq7OVsmp24G+0keszb2cIB3vk4vyCndbywS
         TPn9JMdsi/2+QUefdZh6uopP7HFtDajr4sKYmpyohMq2rGxUvAbC8PJ5OQ8XNF4Axy1k
         lHRA==
X-Forwarded-Encrypted: i=1; AJvYcCVz5JoFysn0TMmrmiRSWR33FlhOGOUy8Kbg3KwPsMBckiZLwktqY/fXCYsM6kzt/zXn/nF6y8ky+f5n81Qc@vger.kernel.org, AJvYcCVzWzvF08u5s0pfmrDwTKyq+897boFgFyuuMaU8Q6bgEk6VlDtpXcTXrBAQCy2MR3urfxD3s9aM@vger.kernel.org, AJvYcCXfk1+fO9loNWmk7e/19zBHuuCkSEzkKSB+zImVZbcMGWZA/DNeGKc16UAHlsJpg9wgai3vGmriQakH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxju9O6miCCOUQkyiuQTr8xUzG8982MEitdKY3Guv0xk/Fj2xgG
	qI4jS4u+Mpb+psdRfJQi8enn4crsrZFuUJai3giEcVzomy0NsWqM
X-Google-Smtp-Source: AGHT+IEl/0GC/p6zYFm6STSbQ+OEEJM2dBdSwzUo57zqE6B/riam1zyNj9qbCfaQqjJABP0cnfoh/Q==
X-Received: by 2002:a05:6512:1285:b0:52e:e3c3:643f with SMTP id 2adb3069b0e04-53b1a30c30fmr5396836e87.2.1729853999206;
        Fri, 25 Oct 2024 03:59:59 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5430edsm44822825e9.2.2024.10.25.03.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:59:58 -0700 (PDT)
Message-ID: <671b7a2e.050a0220.4431c.03f5@mx.google.com>
X-Google-Original-Message-ID: <Zxt6Koz2TYiUo9-f@Ansuel-XPS.>
Date: Fri, 25 Oct 2024 12:59:54 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
References: <20241023161958.12056-1-ansuelsmth@gmail.com>
 <20241023161958.12056-4-ansuelsmth@gmail.com>
 <87aad5ff-4876-4611-8cf8-5c20df3559b3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87aad5ff-4876-4611-8cf8-5c20df3559b3@lunn.ch>

On Wed, Oct 23, 2024 at 06:53:14PM +0200, Andrew Lunn wrote:
> > +	/* Enable Asymmetric Pause Capability */
> > +	ret = phy_set_bits(phydev, MII_ADVERTISE, ADVERTISE_PAUSE_ASYM);
> > +	if (ret)
> > +		return ret;
> 
> The PHY driver alone does not decide this. The MAC driver needs to
> indicate it supports asym pause by calling phy_supports_asym_pause().
>

Sorry for the stupid question, I couldn't find this OPs. Any hit how to
handle this?

> > +
> > +	/* Disable EEE */
> > +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
> > +	if (ret)
> > +		return ret;
> 
> Again, the core code should handle this, unless EEE is broken and you
> need to force it off.
>

They confirmed this was done just to handle kernel init condition...
Will drop.

-- 
	Ansuel

