Return-Path: <netdev+bounces-250090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 201C2D23D0B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CD2B3011028
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FAD30CD99;
	Thu, 15 Jan 2026 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd3Xtne0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6732D7DD
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471623; cv=none; b=gVOV6U3jh9Y3erANXkKISgskFxVKU6tsdm8rhthjLtgaMies3lMSlZW9cJb5RqEZB9RBHFmd4olzaZmDgVAMalHjDpyogBPOKD0OA/7CzkuI5c3TzUGLSPJFKQTP55ZFROFvQzzTijNspHbr5cXPEqfRXlPKQDEfdXkwr9OHrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471623; c=relaxed/simple;
	bh=C9salBa3JJaRTcsqyEMlKRwSirzSEEC+xpkxnQnjuWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo5cwGeqO2qVhzCqehWI0q4xOz17k+wY4Gy33AFWUOM2ktPfJAu7Oav4GE5n7/+pwM14lPpC1SCc5OzAwPP81FtQo7XSyV5wCV0WQENU/xMw6jdmzFO6tQQUWqCoWxbIvB9bszXAk88ezxjWoUywM/Mlkd3Cyxgwc9RCNncOO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd3Xtne0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47edb585dffso424675e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 02:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768471619; x=1769076419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5soI2TEmGJb1+jGjzuFngO4vwUM1/XF+/gPL8edafE=;
        b=Qd3Xtne0fBE/drxsSPU8ArQOGI5u0r+zdB+5z4z0cYLE7VeUUyMvqNMSJIve6+/oca
         UCrQfk63vXh6rDy/cQtjirrxb88oE8bVuCgyIijISfAmFzfF+6p7uYkQhBPEstCD1vJF
         OMHGaSjALLXEs+xUf8aj4fF8pK9z748AqHzX6XVubjq27+wGnvZrcbO4OyUdiLbgyxpG
         NqqmIrUY76z8OtvDXeXf1OTu80gfDZGpN2DgjM7UzyyvFJb/O4hifld3F0OQ97ty+kwH
         UEMdeJmQjENlGYGmg6BmnqyJrYTm+9PDjZxC1jAQQP7yPSHHZQHtcMQhWaKhEn8ycszt
         /Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768471620; x=1769076420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5soI2TEmGJb1+jGjzuFngO4vwUM1/XF+/gPL8edafE=;
        b=LjRpsXSRGUywMLQxBAsbC5upsEI66O8ul7UTVgxp7Ep0UMiMt8uQgDOxijkNs40n4v
         ST+Pz8hP49TNMSUbNdlBD0PPsLBd6lVk0dz+FnQEEymoLSEdicPXod+i7mLFqBKwmHk8
         7Fs1hY3If6yvwzQE2BrpgkOcWAObCD+17ygUnBeUnDB8ImmnLhXCldC6Geu3vRBXMC3+
         IniP3Q6/HsRnfp8paKLsU6kQxNG3d4t+dEokk717QC+BpeC3FNsMWGT+Dh8hzp2FiJPN
         DfsEKKzDnq8t74zNRa1L1tO0d4Y4V6JwDp8mJ/8SgKYBY1f6EJAprXgYJ+4NvZ1CcDO9
         QSKA==
X-Forwarded-Encrypted: i=1; AJvYcCVAUHqx3IgodBcZO85VKFIKNmgsC5u5zUT9Sv8yQ8JlHS7pAaGobbpPz3NTkUIGJmm0OSJ8V4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwCYVrzR5Z6oYrZ0fWpE+nvjbdwmwWb0korqnUKG6tkuqmoSkq
	PTlACCIkCzhCliDVDrgCgbez568UDiSRS31HjxOlfwR0eVC1+y/CLg2G
X-Gm-Gg: AY/fxX7sDUA9M+Cq8orwRQSDm3xrgu+4GiVt+D2kgCNScRw1hJSi8lRMFyqWs5olqTD
	+ui3tR9FKJQBKMhr8KoN0mFtcRYBZBw7qANtcMcWOXigbUhA9OENNWg0tz2R7tZ/50JAiUAVk68
	sBwGAOwf/CiRft0BGB+0SNBXq4VSegvwTEQ3dkkfnLZy1ynJQtEa8wql1EPLCtKLlBT1v6CVony
	/wT3AzaGVcurMOmYqN/IZrER8GmVVOXs+X3Y1D7TZk9AwPQ4Y+occZz9Z/uSAMB9lCEHthAiDrK
	uAJ83AMb1Gs+WPNDfYNR9SPJAUKII5HAf744420hYpaJlNLZ7ZP0AKVTu9By7yCFmNdu5foWgHg
	9pqanZlzhlrWlaiVSZbntAzBOYMjQ+sihiQkCSUiTZ0kNlC9jJOp2zlDBX9ocH/V5KzAcfvlVTL
	Mmaq3ocJZW9ZXb
X-Received: by 2002:a05:600c:8217:b0:47e:e20e:bbc0 with SMTP id 5b1f17b1804b1-47ee32e122amr39245435e9.2.1768471619400;
        Thu, 15 Jan 2026 02:06:59 -0800 (PST)
Received: from skbuf ([2a02:2f04:d703:5400:d5b0:b41:b5b3:8c4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6e1b7bsm4945416f8f.34.2026.01.15.02.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:06:58 -0800 (PST)
Date: Thu, 15 Jan 2026 12:06:55 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen Minqiang <ptpt52@gmail.com>,
	Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: Re: [PATCH net-next v2 3/6] net: dsa: lantiq: allow arbitrary MII
 registers
Message-ID: <20260115100655.da2w3zsxmi3ze5rz@skbuf>
References: <cover.1768438019.git.daniel@makrotopia.org>
 <572c7d91f8eb97bd72584018f9b5941dbfb2e46e.1768438019.git.daniel@makrotopia.org>
 <aWhFohyjEnaIeHSS@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWhFohyjEnaIeHSS@makrotopia.org>

On Thu, Jan 15, 2026 at 01:40:50AM +0000, Daniel Golle wrote:
> On Thu, Jan 15, 2026 at 12:57:07AM +0000, Daniel Golle wrote:
> > The Lantiq GSWIP and MaxLinear GSW1xx drivers are currently relying on a
> > hard-coded mapping of MII ports to their respective MII_CFG and MII_PCDU
> > registers and only allow applying an offset to the port index.
> > 
> > While this is sufficient for the currently supported hardware, the very
> > similar Intel GSW150 (aka. Lantiq PEB7084) cannot be described using
> > this arrangement.
> > 
> > Introduce two arrays to specify the MII_CFG and MII_PCDU registers for
> > each port, replacing the current bitmap used to safeguard MII ports as
> > well as the port index offset.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v2:
> >  * introduce GSWIP_MAX_PORTS macro
> > 
> >  drivers/net/dsa/lantiq/lantiq_gswip.c        | 30 ++++++++++++++++----
> >  drivers/net/dsa/lantiq/lantiq_gswip.h        |  6 ++--
> >  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 27 +++---------------
> >  drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 30 ++++++++++++++++----
> >  4 files changed, 56 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
> > index b094001a7c805..4a1be6a1df6fe 100644
> > --- a/drivers/net/dsa/lantiq/lantiq_gswip.c
> > +++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
> > @@ -463,10 +463,20 @@ static void gswip_shutdown(struct platform_device *pdev)
> >  }
> >  
> >  static const struct gswip_hw_info gswip_xrx200 = {
> > -	.max_ports = 7,
> > +	.max_ports = GSWIP_MAX_PORTS,
> >  	.allowed_cpu_ports = BIT(6),
> > -	.mii_ports = BIT(0) | BIT(1) | BIT(5),
> > -	.mii_port_reg_offset = 0,
> > +	.mii_cfg = {
> > +		[0 ... GSWIP_MAX_PORTS - 1] = -1,
> > +		[0] = GSWIP_MII_CFGp(0),
> > +		[1] = GSWIP_MII_CFGp(1),
> > +		[5] = GSWIP_MII_CFGp(5),
> > +	},
> 
> Kernel CI trips with
> warning: initialized field overwritten [-Woverride-init]
> 
> Would it be ok to enclose the gswip_hw_info initializers with
> __diag_push();
> __diag_ignore_all("-Woverride-init",
> 		  "logic to initialize all and then override some is OK");
> 
> like it is done in drivers/net/ethernet/renesas/sh_eth.c?
> 
> Or should I rather keep the .mii_ports bitmap in addition to the array
> to indicate the indexes with valid values?

This is new syntax for me. I don't have an issue either way. It seems
netdev maintainers did already accept it for another Ethernet driver, so
I suppose you could go with __diag_ignore_all().

FWIW, when I had to handle similar things, I opted for the simpler
"spell them out one by one" approach, see sja1110_regs in
drivers/net/dsa/sja1105/sja1105_spi.c. But that shouldn't necessarily be
the only way.

