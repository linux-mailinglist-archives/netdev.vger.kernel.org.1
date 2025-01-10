Return-Path: <netdev+bounces-157245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B0A09B29
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53DC169DB3
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977DF21CFF4;
	Fri, 10 Jan 2025 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDblew5H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90621D010;
	Fri, 10 Jan 2025 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534482; cv=none; b=iLFyVallBisq/w03ljacssfuezE0GP9o81eTW1p44L241CqcwQnorFS/ROKslpx5IgqZuR0K61hZl9jyz4lHar1n9cRCSgF2vsSBG60kNedesEquw5aryIK5Gou0ypEQ2ZBh4UACt+lIgBoWoUo5OL05RAFOdn9OFAcjR0f+B3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534482; c=relaxed/simple;
	bh=PIYwL3lHK8Q+v+neifn/IUdRe1YuPNt/hGMJ5AKssFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vat3wXuERSGrGkTpsY5X/sEed/LMEWSofz88KmlE6+S97jjic1xsdBPPr44GNhsUpzebskIDFliHC+CxIPq2mSOd8vIvW2hPNTDbOj0Wsn8+xMae4L2/7tInWdPyXfQKUTgyzIZ7fwQsS1HrsurQvZAmiMdhrvu1pUrWpx4AsyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDblew5H; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso22165595e9.0;
        Fri, 10 Jan 2025 10:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736534461; x=1737139261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYVEQZFrMnCWqFl1E+Lf0nbddwHijFEYyMUykqU8UcM=;
        b=kDblew5H+Eaej3RoGYDnFWo9x/w+g0gj6DDR+ihnPVrpTRKBdK0qJwbD89iKBffkSn
         dC44qbw1cUmkjlL+3ll8zf5Kj/lpobZ/q32qnyE9xK+mGDct+V850haGHivkqaCcEi18
         Oh7rU+XCgOLuROPOWnNRny71ziE59RYnGwGNNWU72NOMOD361NEfT2clqsPnfH2+HujQ
         Yiv/ehiVrAb0yfBX/RkDvgifHiqWIZlCDNr1akNmbhiinyqgQ8uCiGUl+I6kIH+tcCHX
         hlSl3lYakdNpXgcji36EvU7i6VHpa3fU+p7gOzo3rny75Bjy5TvznpEIPmsAZlm04EL9
         VJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534461; x=1737139261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYVEQZFrMnCWqFl1E+Lf0nbddwHijFEYyMUykqU8UcM=;
        b=MoaS3L7adtCZM7f1mmTo4upwf0w2db6SwLPDDZvh/t2zx6O7eko63nX25/YxLcZ28M
         jW57A3jU0kQlTnAnHQSHWmuU9XkvZUIaJGLXfxSfJttt+xWh9RmnrS7k6HlkOiEjuW3E
         VHNdHVm2fUK5D1Q8y8PInXx1OiRRnvIGvWFcPLw7Jhv6PWwi6JL5ZJjcwsCRbuXv6Whf
         LixjSioQTbtdsOAKGIAKw9hl+pIbu4XAkL/A/ebUct8wtXcFXpr3spJGionNEmNQdYNm
         QPY9n+Z2Fcv1gc5sPsObl3aFUUmrOBlA+KvQBcPYE26XDx5etHQyc8FCZ5P/YJpMtJKF
         H2AA==
X-Forwarded-Encrypted: i=1; AJvYcCX28S8zSQplpSXOdiA0u5od6wrhRtVADInSNqFDloa+MYUGbMoMF6dTR43uIGcC9MiGH+wyOF59@vger.kernel.org, AJvYcCXfYz/ETibUqhs+BYkswbkV+pawlIBnOAEyfn2EsgahH9+X6rxUB5xVsKJ2UhxhJipc2MGrq3J/i9yrJsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3trsm/KP5nt37Sn4tSEujl/o8Oal/wp4de8nXh7pnYefiaUuD
	vmpo+pfd3LjXiWX+fkiYd0vxAay1KVL1kQUY3lTgN5q+shX0jlNh
X-Gm-Gg: ASbGnctdDp3Za4w1/lMGEvjlwfc3C3bLAw5+8vTcCujdmo5HiGRLtUEBJBTBcT3L71L
	HvJkf1hULC067mXXtYQwar1cWVZHiwTGEUu3yoccG+hWH8tuMFOsS/KQYOjgrdZiv9rd/z7bBzq
	M5EoQUlCXDTAJjTBovFsKZWTP3TnY63N4RPyYBI/wDsLZ7GnZUVF1UWft5ldkdW8gVn7QK0opBe
	p0/jENKoLVHq4Nim4CKWJSeBs6yEQhLcaXTLXSUcbdBOIg7o99x
X-Google-Smtp-Source: AGHT+IGfNoU7LzmkWux1EPRiqTyrN6WAwQava6DXahiuXG4O+Ea/RojEwY+5vAXo4DPVekwHz+nnKQ==
X-Received: by 2002:a5d:6daf:0:b0:385:f64e:f177 with SMTP id ffacd0b85a97d-38a8b0dafa2mr6778840f8f.11.1736534461029;
        Fri, 10 Jan 2025 10:41:01 -0800 (PST)
Received: from debian ([2a00:79c0:6a1:e700:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e3840bfsm5288662f8f.39.2025.01.10.10.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 10:41:00 -0800 (PST)
Date: Fri, 10 Jan 2025 19:40:58 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stefan Eichenberger <eichest@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: Add support for PHY LEDs on
 88q2xxx
Message-ID: <20250110184058.GB208903@debian>
References: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>
 <Z4FYjw596FQE4RMP@eichest-laptop>
 <07b158b8-b745-4886-aa48-3b5be90fd2d9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b158b8-b745-4886-aa48-3b5be90fd2d9@lunn.ch>

Am Fri, Jan 10, 2025 at 06:52:15PM +0100 schrieb Andrew Lunn:
> > > +		if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
> > > +			ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
> > > +						 MDIO_MMD_PCS_MV_RESET_CTRL,
> > > +						 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
> > 
> > If I understand it correctly, this switches the function of the pin from
> > TX_DISABLE to GPIO? Can you maybe add a comment here?
> 
> What is TX_DISABLE used for? I know it from SFPs, where it will
> disable the laser. But here we are talking about a T1 PHY.
> 

If pin input is LOW, then Tx packets will be stopped after link up, but Rx
packets are still received normally. The link will stay up and only idles
will be sent out the Tx media side.

> Do we have to be careful of use cases where the TX_DISABLE pin is
> being used for TX_DISABLE?

The pin can be used for feature described above(default) or as a LED. So
when the LED function should be used we have to setup DT otherwise we
are already fine.

Dimitri

