Return-Path: <netdev+bounces-174992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6FDA61DDE
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 22:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3251B611FF
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 21:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8415D1AAA1B;
	Fri, 14 Mar 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpfFTQmw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC53BA38;
	Fri, 14 Mar 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741987176; cv=none; b=j1SwkYhVUPs6ROM5/Sj1XWxG7WraAbfTvim73i+IZtl6FDNBRxij8UeAgBCu94XzSYQtYQZyS46XomOjnbAoBm/lAW4iO3n9sEIZgEmk85axiZm8vVBjeLpnFU6ishEBJHASBgNc/NEr69H+UO0+foC3PrdXT3SlfD6EhUjeBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741987176; c=relaxed/simple;
	bh=Pp76rHvfoZISNmTS+tHSg0hiQJz4Ly4DKOyB4PGtOks=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTeT26HMn4ZohWzwkwLXBVNSOlbo5bQ9zyFDK1rKcE5x7YJM5ufRx24iVU+vRil0Ay/BbK2xEu+BXD2xeBB2IoY439vaUrRnzwzBSphkGiYQrK5sMGkr1IYA6WFYJU05N7YqZ+IpVeRFm54JTz5bS2Uvuq82Sm81Jy7JwTVqWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpfFTQmw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso1614505e9.3;
        Fri, 14 Mar 2025 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741987173; x=1742591973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HZ8er8q+qEVjGb0Lf/HTxRYIMaF4zb+ALRXEoQrhDn4=;
        b=YpfFTQmwCkanCj+saq2hSPMEakovvHluxebOYmUKAqc+Ecn+STdbj4ifksGrA0fBTh
         6S0+X2N5fzbQHFNt20agAwQ3jTY5Ye/M7mDT1q5gZ/bybOW8SccU54mhfXtl5BFgigne
         CfuD+/AWfTrsf4h6cAia3DlzuzzsAPwPbMOg+WgWq+cslMkO5bZPdeCMtVlWX7rfNAOV
         QvZg+QbDbDHAfC0AvuJOrHMPj8NH7UR6A3dQWNwowSaTBmMIOGEdYz/26A+cN0yIrbuV
         ir97nI+lL11LUrK2rKfr1lGcC4jiMGGN/tTjxMogYVO7YjtIyKqXTx5Q2494aD2LDfOb
         8C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741987173; x=1742591973;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZ8er8q+qEVjGb0Lf/HTxRYIMaF4zb+ALRXEoQrhDn4=;
        b=DT08u8ESI+dPgD73X61iBWScX3p3igQks9iOtgjIA2rJ/zNizi70v8EE903+oNMLQ2
         /TpZW3g6oJUzwPLexrkO6SE7V/YnwNHJvYq5PyykdAcwuWqb2VyQqpx+mzVQRBLfBI7S
         AAfcL++AfqrXDPq3dULbdjzsYU+92zcrZROLmMIlW7b888t7unEFxIJx2oFU4MiiUcoH
         NpkUtXYWABOVZJr6qrREx5WsbZejo50yzqc9ngduyMEZti/MHc72rWWHkY1u6fpouzty
         TtsxwtXZlC899wAwjvECK84rEFUcTeC8Kzd0/15OSOzvARYdYwN0tHeFF4rg/OLdo1+N
         syLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1lHQOukpvSWxP6WjXaDKAM5viEumJghTLehimFykTb13dxqUaGRZxQLPnU5pUhPViKUpnmPOV@vger.kernel.org, AJvYcCWmzobNIy84FTgos0kDWR7E7rWDaW6PQRw9XFufIGf2wSkpWoiaDbsFDLGHsJQsL3/mcXBK9qhmkg6FwsAn@vger.kernel.org, AJvYcCX2sMfHDMmC9ecvh1Jq8vJfVKeGlgBM+xL1qwYitOkYKRaLMdoYTr5zDer7d0Lt2VYpFQ9rOwWOtc/P@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/X6BbF67v7L3/5mhWxP/vxT/y2W9wC3dd+dcnEcOx+yS9UpQH
	ZUrXJIClFWKQeUnRn8WY97Z9VqalmrNRrwW5D8IlnIpvUIXVf9hU
X-Gm-Gg: ASbGncuJSvrQxCthJ9ekgekxpHY4CyQM6/9+6PYWPlrzv9/f2o/ZvKaSmdgXZsnWFaj
	SncajHg4eY3op9cSmXjtjtq0mmkXXCHVE9wZyCK8SBDnoR1xjYGpF8v9ubZPWCTPeErgJxtRihc
	Ab/nSIf4zYqlywf2nqt8K/rnoPKqkOD8tLH+JOpg7hwH/2c73MQBNp7c5uO11ZVisXLAaL+WHmz
	9QyIiNFTzcVPw2aWxJS1q80B9FVyZZUjBuAllYHL+gg2E4rxuyUj0ZaG0LBRSqZKEAvypYFIOpD
	jSZpU2AH4i/qWemrfi0HCr4xGX4N1G7wBKpp2Rc9vQZNCWLBDpV+hktKmP1l2gXGxmemKvYR4WK
	FBfuii1Mi8Ts=
X-Google-Smtp-Source: AGHT+IHGEcaq+mQYLJLVzszVdST1b7J2O2oqDQ6zwCkCBz8ussqbnvLf9ZC6tI+1i/QCVFDqFROb8g==
X-Received: by 2002:a05:600c:4f0c:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-43d1ec8cac8mr53968935e9.17.1741987172437;
        Fri, 14 Mar 2025 14:19:32 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fd6b2acsm29215905e9.0.2025.03.14.14.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:19:32 -0700 (PDT)
Message-ID: <67d49d64.050a0220.35694d.b7ab@mx.google.com>
X-Google-Original-Message-ID: <Z9SdYeD-Gb1l77AG@Ansuel-XPS.>
Date: Fri, 14 Mar 2025 22:19:29 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 07/13] net: mdio: regmap: add support for
 multiple valid addr
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-8-ansuelsmth@gmail.com>
 <Z83RsW1_bzoEWheo@shell.armlinux.org.uk>
 <67cdd3c9.df0a0220.1c827e.b244@mx.google.com>
 <0c6cb801-5592-4449-b776-a337161b3326@lunn.ch>
 <Z9SZRDykbTwvGW6S@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9SZRDykbTwvGW6S@shell.armlinux.org.uk>

On Fri, Mar 14, 2025 at 09:01:56PM +0000, Russell King (Oracle) wrote:
> On Fri, Mar 14, 2025 at 08:41:33PM +0100, Andrew Lunn wrote:
> > On Sun, Mar 09, 2025 at 06:45:43PM +0100, Christian Marangi wrote:
> > > On Sun, Mar 09, 2025 at 05:36:49PM +0000, Russell King (Oracle) wrote:
> > > > On Sun, Mar 09, 2025 at 06:26:52PM +0100, Christian Marangi wrote:
> > > > > +/* If a non empty valid_addr_mask is passed, PHY address and
> > > > > + * read/write register are encoded in the regmap register
> > > > > + * by placing the register in the first 16 bits and the PHY address
> > > > > + * right after.
> > > > > + */
> > > > > +#define MDIO_REGMAP_PHY_ADDR		GENMASK(20, 16)
> > > > > +#define MDIO_REGMAP_PHY_REG		GENMASK(15, 0)
> > > > 
> > > > Clause 45 PHYs have 5 bits of PHY address, then 5 bits of mmd address,
> > > > and then 16 bits of register address - significant in that order. Can
> > > > we adjust the mask for the PHY address later to add the MMD between
> > > > the PHY address and register number?
> > > >
> > > 
> > > Honestly to future proof this, I think a good idea might be to add
> > > helper to encode these info and use Clause 45 format even for C22.
> > > Maybe we can use an extra bit to signal if the format is C22 or C45.
> > > 
> > > BIT(26) 0: C22 1:C45
> > > GENMASK(25, 21) PHY ADDR
> > > GENMASK(20, 16) MMD ADDR
> > > GENMASK(15, 0) REG
> > 
> > If you look back at older kernels, there was some helpers to do
> > something like this, but the C22/C45 was in bit 31. When i cleaned up
> > MDIO drivers to have separate C22 and C45 read/write functions, they
> > become redundant and they were removed. You might want to bring them
> > back again.
> 
> I'd prefer we didn't bring that abomination back. The detail about how
> things are stored in regmap should be internal within regmap, and I
> think it would be better to have an API presented that takes sensible
> parameters, rather than something that's been encoded.
>

Well problem is that regmap_write and regmap_read will take max 2 value
at the very end (reg and value) so it's really a matter of making the
encoding part internal but encoding it can't be skipped.

You are suggesting to introduce additional API like

mdio_regmap_write(regmap, phy, addr, val);
mdio_mmd_regmap_write(regmap, phy, mmd, addr, val);

And the encoding is done internally?

My concern is the decoding part from the .write/read_bits regmap OPs.
I guess for that also some helper should be exposed (to keep the
decoding/encoding internal to the driver and not expose the
_abomination_)

What do you think?

-- 
	Ansuel

