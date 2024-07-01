Return-Path: <netdev+bounces-107985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB691D5D4
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 03:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B5A1C20EAF
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 01:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C329A3D62;
	Mon,  1 Jul 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEtXO8td"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462E847B;
	Mon,  1 Jul 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719798031; cv=none; b=QHUrAb3Iw7f/hUIILp89NK0Cfj9jIGURMeZyGv5dxGKzWEdmbs7rnef5K8iui7ah7fNhlnOZl/jfactH8cBowUpghGI9PmoqZeD5wAHMNbk3iK9X1asOtCDYT2QtOpG47KOaWHut3iDKQl1nj7jESdjABC/z8uBsqN5JS7wNWMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719798031; c=relaxed/simple;
	bh=8N1kTPTMUy3OyP8Thfs9SN31LDGnJJ5vniYo0Oy95II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBMBwELmacsfsWC93GS3l2Me8aarJHwdh5gmnj06PDOgW3fm9OXP7I2wW0ncc7RBk6MLj+rgUTHRVVVPK6FxU6e1lRxlZKI62nfjFJJh8iKrLRKikbJ4r4owCY5xkmHDx8yKH2aY+OXA8tsvYFwSB7IS7N3dX/hPd+Tv55iu9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEtXO8td; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdfb69724so3041343e87.1;
        Sun, 30 Jun 2024 18:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719798028; x=1720402828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SwnfzGgZbXchQuvwIi7BwMqkkcPzYDSZ1lkWRl6NvOM=;
        b=jEtXO8td6vultGKSKEtKfTEeiV3gFQhzZ2CGbBGrsHfPRTceyYnBrF44KCLpx26tyY
         x4XswVgAaACK5NUptwc7siH15kAyI5MTEvRHgXCAjrz4zoyHFOOK9JjhILk2b7rTmPID
         UFVLwgspOCtGtdjAhyxiCv50tEASZJPEV+hixeeZ3t4I3hPWEZsk9aA/H2D8eq/V/QPw
         rt1N3pie2HafW6yVNJMBjocPHxILXmvFV2pv7UbvSLlgcNgbJC42XbkfkstZTWty+fZc
         gDPhcHBd9fRe/+YrmWvIZk14K5eoLX9kv2D0pMXzPMJJ5ydCtJLmOUqg4WH2k4YN//Bx
         422A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719798028; x=1720402828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwnfzGgZbXchQuvwIi7BwMqkkcPzYDSZ1lkWRl6NvOM=;
        b=Olo8j6s+BlZ5QXOt4GRqnbEEn4j0erJN/2BUm7uIDWr4XKWF3HcRsEa1dbjv6Aw4Vs
         Tp34MF1nTNYiJ7XYYeCqLYT7Er9gU8Lvd5Yt3GIUcseKx5DOjjwlLxpMBThOi+T1BHvH
         TtP894VJ+TQUS2erSm7DzKOGXCYsYEfijZcc451prvSf1jHUiCjM7DhNvW5ihaAO/FzA
         WNMHrmXm8vQTdIJhcjsaT/of+Wcx98Oy19nNspsPl1Ns4w90rcPy5z6KalhIDFdzOhO2
         Eurc/bkToe3JSKNFBUPlPZCAgxideB1doKf7OJYcHKy70AiDLgRJlPMb760kh3DqLXcW
         GCzg==
X-Forwarded-Encrypted: i=1; AJvYcCVW+/TgaFKp0/o5iIyxLuB4veYPWYsXJCgfriEgsVM3E+WUwF2/uCnfd0ys85n92LTNcNrN+kVxQD1q28ppfffRBXavjqLv6VIYRIr3ADhv25h/187QzyYlzmpO7FbT/+YcAYXZ0p70huBqx8FkH1ozW9O4uCfzZC8lAJxsHkxDmg==
X-Gm-Message-State: AOJu0YwLqsXDDReP9FnN9f43Xuzxl1hvH3lpTUVegHNQqDQnwhgxDrVT
	DajdIMbuHQAuRzprGaComodAvbSzJgszn9F9KvUx+yohT2BocmOn
X-Google-Smtp-Source: AGHT+IE7kAt6EsHOnTzUdCIGnBj2h9mmrLiQhrSexUxPRaRVqV6UHVmgj5fZQR2jnaMRamWK2GFoig==
X-Received: by 2002:a05:6512:6c3:b0:52c:def3:44b with SMTP id 2adb3069b0e04-52e8268b40amr2615295e87.31.1719798027768;
        Sun, 30 Jun 2024 18:40:27 -0700 (PDT)
Received: from mobilestation ([176.213.1.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0fff6sm1173823e87.81.2024.06.30.18.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 18:40:27 -0700 (PDT)
Date: Mon, 1 Jul 2024 04:40:24 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/10] dt-bindings: net: Add Synopsys DW xPCS
 bindings
Message-ID: <a2quritc5udbpebvymbbhez2e4g5qk774trpzvsmtzgd4bpc4y@ckaqnqyrkszx>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627004142.8106-7-fancer.lancer@gmail.com>
 <20240627-hurry-gills-19a2496797f3@spud>
 <e5mqaztxz62b7jktr47mojjrz7ht5m4ou4mqsxtozpp3xba7e4@uh7v5zn2pbn2>
 <20240628221246.GA296233-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628221246.GA296233-robh@kernel.org>

On Fri, Jun 28, 2024 at 04:12:46PM -0600, Rob Herring wrote:
> On Thu, Jun 27, 2024 at 08:10:48PM +0300, Serge Semin wrote:
> > On Thu, Jun 27, 2024 at 04:51:22PM +0100, Conor Dooley wrote:
> > > On Thu, Jun 27, 2024 at 03:41:26AM +0300, Serge Semin wrote:
> > > > +  clocks:
> > > > +    description:
> > > > +      Both MCI and APB3 interfaces are supposed to be equipped with a clock
> > > > +      source connected via the clk_csr_i line.
> > > > +
> > > > +      PCS/PMA layer can be clocked by an internal reference clock source
> > > > +      (phyN_core_refclk) or by an externally connected (phyN_pad_refclk) clock
> > > > +      generator. Both clocks can be supplied at a time.
> > > > +    minItems: 1
> > > > +    maxItems: 3
> > > > +
> > > > +  clock-names:
> > > > +    oneOf:
> > > > +      - minItems: 1
> > > > +        items:
> > > > +          - enum: [core, pad]
> > > > +          - const: pad
> > > > +      - minItems: 1
> > > > +        items:
> > > > +          - const: pclk
> > > > +          - enum: [core, pad]
> > > > +          - const: pad
> > > 
> > 
> > > While reading this, I'm kinda struggling to map "clk_csr_i" to a clock
> > > name. Is that pclk? And why pclk if it is connected to "clk_csr_i"?
> > 
> > Right. It's "pclk". The reason of using the "pclk" name is that it has
> > turned to be a de-facto standard name in the DT-bindings for the
> > peripheral bus clock sources utilized for the CSR-space IO buses.
> > Moreover the STMMAC driver responsible for the parental DW *MAC
> > devices handling also has the "pclk" name utilized for the clk_csr_i
> > signal. So using the "pclk" name in the tightly coupled devices (MAC
> > and PCS) for the same signal seemed a good idea.
> 

> It is? That's really just the name of the bus clock for APB (Arm 
> Peripheral Bus). If there's a name that matches the docs, use that. 
> Though I'd drop 'clk_' part.

Yes, it's normally should have been utilized for APB, but as I see it
the name utilization has gone wider than to just the ARM Peripheral
bus clock. The DW MAC clock-names DT-property bindings is just one
example of that.

Anyway. Ok. I'll convert the name to "csr". (I'll drop the _i suffix
too since it's obvious that the clock signal is the connected to the
device input pin.)

-Serge(y)

> 
> Rob

