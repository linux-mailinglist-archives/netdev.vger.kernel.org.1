Return-Path: <netdev+bounces-158834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB139A1371F
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308483A1C05
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F3C1DD0D4;
	Thu, 16 Jan 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDjARZru"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF711A0731;
	Thu, 16 Jan 2025 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021391; cv=none; b=GgWC+34+V61Rcmta2lAK7Yr4voWnLmI67QDRCBclsJr8QRVomyD03ac8ydMbXnDnu+DAumR8oq3cDuLMIbbeMw43BrwETcZRIp0s+zKhpnPqC5u9pRGADYwdAfhthCz46jihoatPs5wjPGU2ZMXOROJz1SyAx3KwtTI7Pr8vDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021391; c=relaxed/simple;
	bh=hZHwfCafp/2jaIcxq0xCA2JGNMReouh9aUpppvq7Rnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCP9wqQ59giWOZksuB1EvIUXX4AfW07HRpz/svBLCQvqgHUthg9k/vT2KDNgvBaMqH50Rr12ayisqeLR93bY6JML6TVZFzN8Q1lCKOODNGcnfPr2zy3nsCzFK6P6U6NcDPSWp45XQ1K1cF8zvJqKHXhfgNqAj9G7boUAS5aiv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDjARZru; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so397478f8f.0;
        Thu, 16 Jan 2025 01:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737021387; x=1737626187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jv50vXLyCohKkolh8HL4ExMX3KlgCPYX7TMDlSK4yyQ=;
        b=XDjARZrus829y+9lDfMDsrHCWkBNLgqeRb0MXH3k/qmVJ3R6s+ANAhUVOWPm8SdemE
         RljfMMTBAS3wD8NBDLEYTPThzr21PjVcwcdM5iUIyO409YIwFG1dOZNnY5Q+Q0WDUw3T
         aao3aVEI5+6uI7W0QSu4TzGvArXOJetQfRS3OFxg2Lrj7kgF01DCKuA1TAxaVnHylXLX
         FdEVl1RQLYDzBEFRYBl/LAn22i2oKc7JGIqz02zWtJQWGOW3pJuRhOmVnfvT3VG718FD
         9L20uth9C0SZ6uTFPgV0JSdwq8tuqtMUC6taYShl5OQA+gQ4YiuFgZLjFVyQUWJAYJjy
         IhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737021387; x=1737626187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv50vXLyCohKkolh8HL4ExMX3KlgCPYX7TMDlSK4yyQ=;
        b=VCYC64CNRaBuYeJwoPU650cHhXG8GwX2CAO2BsbDYYhNQI1/PSAY78N3mtVPjVARP2
         WkJYYsJnHGI27peR1iiVknWT9TE4IOndQfzedouSsEe2tRD9nZqQkij0cGbsy7uLEJi0
         cAesOzUQCjfH3XD18wgwnLHXPGvIpdYQHKAR9JH/iELNDmzdLlOrUlZ6UUDKq+h5YVEy
         hiiUzT0L7TISJ2sN98cZCYGgX/iPhWP2OWqqOBGZ+JdTMLYtDrojnlbRBon6qUCFfd9W
         yjMsktOrAS+IvTd9Mtk0BQ18yL1/4M35x2bghqTZX/L89172kC2lLIi72Zq1gFfVFwW1
         b8gw==
X-Forwarded-Encrypted: i=1; AJvYcCUv6Wl63f239MGbAQhWavBzJUtZFyJaRFkeDsl/tMhe5a8ZUQ4CuKnw59zJxUSNlkJkKmKb2yUn5y1a@vger.kernel.org, AJvYcCW/Dz4eP4BS6vNjDQZ14AGvwsGW3GL08zMf3h7L+XroCpZThhuNDD+XnOMk1C2Qxuil+ui9As/mnL8mIKza@vger.kernel.org, AJvYcCXL+wV8/69ajyy9uVisXKpZzEalAGmtuHidoylZ3ootauMHp7wZVmtAm+cLKUe3BKs9bVa9lR/Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+nF76sySbJn7J4aUOMFz2d8HsG/cP8TVKVRBYvDiXo1f74ee
	gtarV4QLVtz4QQJ/ZfH0GugFXbAnFWQRXKMhniQEKIQ51RO//PCc
X-Gm-Gg: ASbGnct8Vd+pwi1Kyb6A2PiQ5g6sW5yGopgMTOc4hMHr+bAHx9qhW+gPdlDtuWs0A4K
	ASghUHja64tf1IWTXYhw+KidftvPkAaXJqTyWJl/X6CVlZKRbxTSXHfCRlYX8HJZ/wGFWK2tFIs
	4UHCcqnTcBZiaScC9aIRpGt8GGf4p/k8JAMe3FS4c5HWxT2ywXC7HO7fpByy7SXFP8MHd2heF7c
	OqcdZJZf3+/2IYlgWf7tmZXij4/if6OipzCUXAKEX5xg4p7jjYn
X-Google-Smtp-Source: AGHT+IHzH1W8ReHz81xgqmeQjgmWXXdbxuZnQGUcOlWiMkSjs6qBP8f4LT8IkgM6yePzS/DnvD9siw==
X-Received: by 2002:a5d:64eb:0:b0:386:41bd:53a3 with SMTP id ffacd0b85a97d-38a87310667mr28181865f8f.50.1737021387053;
        Thu, 16 Jan 2025 01:56:27 -0800 (PST)
Received: from debian ([2a00:79c0:650:2c00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bdc0d8e4bsm10844258f8f.42.2025.01.16.01.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 01:56:26 -0800 (PST)
Date: Thu, 16 Jan 2025 10:56:24 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: dimitri.fedrau@liebherr.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: phy: dp83822: Add support for changing
 the transmit amplitude voltage
Message-ID: <20250116095624.GA4526@debian>
References: <20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com>
 <fcffef06-c8d1-4398-bc20-30d252cd2fd2@lunn.ch>
 <20250113141828.GA4250@debian>
 <5118eb9a-ff6e-4e78-8529-d174e09cf52e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5118eb9a-ff6e-4e78-8529-d174e09cf52e@lunn.ch>

Hi Andrew,

Am Mon, Jan 13, 2025 at 04:59:38PM +0100 schrieb Andrew Lunn:
> On Mon, Jan 13, 2025 at 03:18:28PM +0100, Dimitri Fedrau wrote:
> > Hi Andrew,
> > 
> > Am Mon, Jan 13, 2025 at 02:54:28PM +0100 schrieb Andrew Lunn:
> > > On Mon, Jan 13, 2025 at 06:40:11AM +0100, Dimitri Fedrau via B4 Relay wrote:
> > > > Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
> > > > Add support for configuration via DT.
> > > 
> > > The commit message is supposed to answer the question "Why?". Isn't
> > > reducing the voltage going to make the device non conforming? Why
> > > would i want to break it? I could understand setting it a bit higher
> > > than required to handle losses on the PCB and connector, so the
> > > voltages measured on the RJ45 pins are conforming.
> > >
> > - Will add the "Why?" to the commit description. You already answered it.
> > - Yes you are right.
> > - I don't want to break it, the PHY just provides these settings. And I
> >   just wanted to reflect this in the code, although it probably doesn't
> >   make sense.
> > - In my case I want to set it a bit higher to be conforming.
> 
> I have seen use cases for deeply embedded systems where they want to
> reduce it, to avoid some EMC issues and save some power/heat. They
> know the cable lengths, so know a lower voltage won't cause an
> issue. The issue in that case is that the configuration was policy,
> not a description of the hardware. So i pushed for it to be a PHY
> tunable, which can be set at runtime. Your use case is however about
> the hardware, you need a slightly higher voltage because of the
> hardware design. So for this case, i think DT is O.K. But you will
> need to make this clear in the commit message, you want to make the
> device conform by increasing the voltage. And put something in the
> binding description to indicate this setting should be used to tune
> the PHY for conformance. It is not our problem if somebody misuses it
> for EMC/power saving and makes there device non-conform.
> 
Thanks for the explanation. Will add the comment in the commit message.

> > > Also, what makes the dp8382 special? I know other PHYs can actually do
> > > this. So why are we adding some vendor specific property just for
> > > 100base-tx?
> > >
> > I don't think that the dp83822 is special in this case. I just didn't
> > know better. Would be removing the vendor specific property enough ?
> > Or is there already a defined property describing this. Didn't found
> > anything.
> 
> If i remember correctly, there might be a property for
> automotive/safety critical, where there is a choice of two
> voltages. But it might be just deciding which of the two voltages are
> used?
> 
> There is also:
> 
>   ti,cfg-dac-minus-one-bp:
>     description: |
>        DP83826 PHY only.
>        Sets the voltage ratio (with respect to the nominal value)
>        of the logical level -1 for the MLT-3 encoded TX data.
>     enum: [5000, 5625, 6250, 6875, 7500, 8125, 8750, 9375, 10000,
>            10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
>     default: 10000
> 
>   ti,cfg-dac-plus-one-bp:
>     description: |
>        DP83826 PHY only.
>        Sets the voltage ratio (with respect to the nominal value)
>        of the logical level +1 for the MLT-3 encoded TX data.
>     enum: [5000, 5625, 6250, 6875, 7500, 8125, 8750, 9375, 10000,
>            10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
>     default: 10000
> 
> I'm not so much an analogue person, but these don't make too much
> sense to me. A ratio of 10,000 relative to nominal sounds rather
> large. I would of expected a ration of 1 as the default? Since this
> makes little sense to me, i don't think it is a good idea to copy it!
> 

I think the ratio of 10.000 was chosen to avoid truncation when calculating
register values. These are in steps of 6,25%. Using gain in DT seems to me
the more generic way of describing amplitude modification. But converting
the gain to register values might be more challenging in some cases. And
I think we also need to scale when we want to represent it as gain. The
DP83822 allows to modify the amplitude in terms of gain by 1.65% per
step and for 10BASE-TE gain is 9% per step. I don't have any other PHY that
allows me to modify the amplitude, so I'm quite biased. Do you know any other
PHY supporting this ?

> I've not looked at 802.3.... Do we need different settings for
> different link modes?  Are the losses dependent on the link mode?  Are
> the voltages different for different link modes? Is voltage actually
> the best unit, if different link modes have different differential
> voltages? Would a gain make more sense for a generic binding, and then
> let the PHY driver convert that into whatever the hardware uses?
> 

I had a quick look at 802.3, but I don't have much knowledge regarding
the analogue part:

- Different link modes have different differential voltages.
- I would prefer gain instead of voltage, should also fit for fiber
  optics.
- I would prefer separate settings for the link modes. Specs for the
  link modes are quite different, not that I could really judge. Maybe
  someone can help us out ?
- Maybe something like tx-amplitude-100base-tx-gain-milli or
  tx-amplitude-100base-tx-gain-micro ?

[...]

Best regards,
Dimitri Fedrau

