Return-Path: <netdev+bounces-247498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5319BCFB51A
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 00:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AB0F304EBEE
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E48E2F99BD;
	Tue,  6 Jan 2026 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3+E/RqL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283282D0C79
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740728; cv=none; b=an8UrOJKSvmX+/mcGntXUsmx0oELf/gskktye43uYt/zBPWr6zLVG22/HEap1RkMKTj/YrwDE0s+rO219DajE4Eji7W1l6aF3FU2cdnoP1XbHUYG81PWPoWoYoYgpc8zDDU7sSAB6KiuaP8U/pxGAdXN/R3uBAqhwgyHIAixlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740728; c=relaxed/simple;
	bh=P62+SexSZ9nGF5+uA7R+OXml7+ArJUyCTC0YFM/lEaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6mIwiOvG7Si+ZBzqvzSs8eJdvRdqYg9Ou0fngzF1VXUNDAv62G4HyDyGABmY+ejOiVIBK9Qfjm+oAe55DhxryBN9JFkK6NRwzMHXNFaRZrTYliIrSPC56LUO4gbOWk5878wQqq89n45H161frvveNbn7Jd04LVnuMRCNRGrbA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3+E/RqL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477985aea2bso1938845e9.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 15:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767740724; x=1768345524; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PxapFgVYnsCWIyo0CktW/IQv7jH9MgZJhnDM0z/8zDU=;
        b=X3+E/RqLMUX6mOFwJPA6vJitAKiugRGLsHgmtL5BDloj5Ypf06fI02uDostSKvoAJ5
         IpTt6LVGsQu9h0/zJuZH1BXk0FITV50JBQCRLQufHawsAdVBsHNWTYXdksbpmqAlcLJ2
         JavIR7ZdExmqXGR0q3OU8jv+hO+o2wZPHGXQYlySFKh+YDveJ4ijyMt0aT1legeY5kyk
         xhNxtyK9NjuafLKBdLTe9NwmlO7hr+uI9aas/LxR1Ai3wegF7FR8cAuma7YwJuTGhj5C
         mMKpwNhdAMoV/6cwQK5b3gDnh+k3aKtfajz8KJYu3KPIsurZTkNrQZknc8w6BBWKp44L
         Kd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767740724; x=1768345524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxapFgVYnsCWIyo0CktW/IQv7jH9MgZJhnDM0z/8zDU=;
        b=FhEp1yeee0JrNd6x/uY1xXu9oJKvlHeK7ES9N7WYPerkAP1WziG0pz40h0h/p1Eab7
         hedZWMNqiqi38LpqSnAgiHrsOoRwU0tS0d2S5vx6CxVPcYsr/gqDC93j4f3yQTPtOhtI
         fPx6Lx5fzYQLyDyKM3Aeo1Z9UZXWUPTI/oeed5OJttzFhaUxC75HfqsiwTzpnZ16bwQj
         5vNJNL0uZsWBEVLfbQq1zB+rYmwQJ36GsdYR7ZdBG+MRVZoHM5adrgXqXeNi4eIz2RrZ
         4K3hnJw98Bey2T5siOZ3+nhVNf1F2atgBZDmgaHCwUSnCMY8B9phFtOhPydvwtCvlsRn
         UNBg==
X-Forwarded-Encrypted: i=1; AJvYcCXbukKMd442QXw817cZXyvHDekJ5U71PkfEWuuNfUy/SRXeyysp7wtCBj8eMx30YHh2pMCevNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgocMs1AP00bAjQTO31i6aeTzLuY0yLAmlZ8r2TUum6AUsN9qT
	zGMk2itdkl639ro4FnCk8yQWAKVhwqVn8vMti40Dhqi6z2nG4TBkW1mH
X-Gm-Gg: AY/fxX7aPARrKANTzaUUrk1qZ8vCqtyjcTLjCrDPk6KVI14obZwjbtieDaQf/jr6nYz
	REGuQXzEBbJrnokejSS57cErysP4mqlf2U7Q95J3pB8a4NzrqUzvfPFd3K78Vy6LNNLXKJaokb2
	xlRLqxleXOgb5BRsNY1aNj0BE5AjsC+0nYQkdiLOT3JE40hXHOrtH2SE+zOIXUP7mQEf9Lz7mOj
	Sux59w70B+lu0FWMyKK/AapcCSx8R24rYJg85BU78g/7r55387hG/qiTNmRaDeNkV5ABXdtPet7
	cUIZt8e3RP/0OliqMAbFe9t1gorBHaepGgKuQ6ibInthR6RNkqm/GYJEGO4J09uuD7d8A0FZQcU
	h2/PLAPIivIscqSQJe4uBHLGM422ZDub0G1Auu3lvx1oaCHEwkRHj/iIni/S/Nclv7OrY4cTW0b
	SdwA==
X-Google-Smtp-Source: AGHT+IFHvR3PWQ5ize927SnFuctRZZ+ULpEdYthALC5LDfP2dC/UzHfGiLtVDJjdCER9VVpiUSBv+A==
X-Received: by 2002:a05:600c:8284:b0:468:7a5a:14cc with SMTP id 5b1f17b1804b1-47d84b30091mr2875005e9.3.1767740724036;
        Tue, 06 Jan 2026 15:05:24 -0800 (PST)
Received: from skbuf ([2a02:2f04:d804:300:2df7:9d78:6807:9af8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c86sm68232875e9.3.2026.01.06.15.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:05:23 -0800 (PST)
Date: Wed, 7 Jan 2026 01:05:20 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew rate
 configuration
Message-ID: <20260106230520.xhagmy76ddl7scfs@skbuf>
References: <20260105175320.2141753-1-alexander.sverdlin@siemens.com>
 <20260105175320.2141753-3-alexander.sverdlin@siemens.com>
 <20260105193016.jlnsvgavlilhync7@skbuf>
 <ac648a7e6883e68026f67ae0544b544614006d8f.camel@siemens.com>
 <5cd460761e5b163ac2c5c5af859a53a9ad76d3ba.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cd460761e5b163ac2c5c5af859a53a9ad76d3ba.camel@siemens.com>

On Tue, Jan 06, 2026 at 09:41:13AM +0000, Sverdlin, Alexander wrote:
> Hello Vladimir, Rob!
> 
> On Mon, 2026-01-05 at 22:00 +0100, Alexander Sverdlin wrote:
> > > > +	return regmap_update_bits(gsw1xx_priv->shell, GSW1XX_SHELL_RGMII_SLEW_CFG,
> > > > +				  RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC,
> > > > +				  (RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC) * rate);
> > > 
> > > I don't have a particularly strong EE background, but my understanding
> > > is this:
> > > 
> > > RGMII MACs provide individual slew rate configuration for TXD[3:0] and
> > > for TX_CLK because normally, you'd want to focus on the TX_CLK slew rate
> > > (in the sense of reducing EMI) more than on the TXD[3:0] slew rate.
> > > This is for 2 reasons:
> > > (1) the EMI noise produced by TX_CLK is in a much narrower spectrum
> > >     (runs at fixed 125/25/2.5 MHz) than TXD[3:0] (pseudo-random data).
> > > (2) reducing the slew rate for TXD[3:0] risks introducing inter-symbol
> > >     interference, risk which does not exist for TX_CLK
> > > 
> > > Your dt-binding does not permit configuring the slew rates separately,
> > > even though the hardware permits that. Was it intentional?
> > 
> > thanks for the hint! This is definitely something I need to discuss with HW
> > colleagues and get back to you!
> 
> Vladimir, according to the responsible HW colleague, it's OK and is desired
> to have TXD in "slow" as long as Setup-/Hold-Timing is in spec.
> 
> I do understand, that this is board-specific. Do you propose to introduce
> two separate properties?
> 
> Rob, in such case just "slew-rate" probably wouldn't fit any longer and
> I'd need to go back to "maxlinear,slew-rate-txd" and "maxlinear,slew-rate-txc"
> probably?

I see Rob has reviewed the binding in this form already, but I think the
rule of thumb that we could apply in this case is to still describe the
clock and data slew rates separately. Like Russell points out in a separate
thread, it's simpler to do this from the beginning rather than end up
with 3 properties you'd have to maintain, if you later need individual
control.
https://lore.kernel.org/netdev/aTB0x6JGcGUM04UX@shell.armlinux.org.uk/

Sadly I don't have the expertise to give any advice on how that would
translate into dt-bindings. Does it make sense to implement a full pin
controller device driver for the registers GPIO_DRIVE0_CFG -> RGMII_SLEW_CFG?

