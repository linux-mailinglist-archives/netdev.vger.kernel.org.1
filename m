Return-Path: <netdev+bounces-57393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1A81301A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875701F221FD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81894AF7D;
	Thu, 14 Dec 2023 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtNUZRyz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C984116;
	Thu, 14 Dec 2023 04:29:10 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso105467981fa.1;
        Thu, 14 Dec 2023 04:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702556948; x=1703161748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hKkOlqtXnQi1CXioJeNrKbuA1zxevHtK9i/pmWXuhPs=;
        b=PtNUZRyzxvOmLBaakV61+fMGgP483Uod+LvSsurLxiUd8Qj78BlRcuhGw0lxhTyq8/
         L0+r6mQcuhFmW00OmQXO+y7Uk9doVvmGqbfQowRFaUIbx0HvS8G0R1z7uA6idgMZn1l0
         VrInPGM0Bj3kuAMLwGLf4GTi8v3ZqfXgiB0iLqRpHV83ISEdDnUl2OOwVbCiqV1V8xKi
         Lisanbp15YxIcXA/PO532c5J5NtokuTVS4jWjMO+KjPMIDWELW7rtLS/+xxBBQTp30cQ
         tLeDG5Y59193YtD0WcuXArGWCr068RJWac6J5WHCWi98TR/DPZYZDcV+oazdSgTbESxj
         w3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556948; x=1703161748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKkOlqtXnQi1CXioJeNrKbuA1zxevHtK9i/pmWXuhPs=;
        b=TFKRfE7u21pWbKpIAy0DlHL9Z7FwFSpggDyqWucP1grr9a9ipi5OyyKmvCBj/K7m+c
         MaVHoZ9XCigTQdKGmeorzHeFAesfa/dRhGa8SgcOgQPfXO+aHWKgtFB8gxsM1S4wD3Li
         LAKQUwPiq0vZvzFnOAQSi6oxljMDk8W0lkSBxbUNYkRQ8KoO9ugOjUyN/yxuMTXHF6hX
         rmHQgM3/2zPgmm6WWffueEk5AfOp6ufVvrxEwt1PCaYT9/21ypygBonc3OxuXtahDp8O
         HBvq/e3FvrRw3hLe868sWdAFG8jOrcK1BTuAQJppvdtckXAvU7AYNrjPrnE8puax1kk0
         hzEg==
X-Gm-Message-State: AOJu0YxxAJ94kAfv0HVz1tmLK870/Q94xK+J/sK/HgKRyeoAaf4YF+XV
	vJvbu9nQ8QK0lYQ75P6y8OI=
X-Google-Smtp-Source: AGHT+IHT6Syfor5yq9T7eo4jSSMy2o+vRuqPr7cfTtYXt59vOt5802fiJ9vq9yDDRmVoosxtqQtXEg==
X-Received: by 2002:a05:651c:2221:b0:2cc:2012:7509 with SMTP id y33-20020a05651c222100b002cc20127509mr3762737ljq.98.1702556948246;
        Thu, 14 Dec 2023 04:29:08 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j1-20020a2e8241000000b002c9f70a0419sm2040940ljh.140.2023.12.14.04.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:29:03 -0800 (PST)
Date: Thu, 14 Dec 2023 15:28:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/16] net: pcs: xpcs: Add generic DW XPCS
 MDIO-device support
Message-ID: <wz7h5lvxnhw2rav6s54dhv2xbxsks6tlpx3hvywjn3afmkf2av@tbiigyupuga7>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-11-fancer.lancer@gmail.com>
 <20231205111351.xjjuwpbf7kwg3vuh@skbuf>
 <uivunnjv5vi3w3fkc5w2f4lem5bingrgajgjfsu2ih7fuhz6hd@3naeubr5spak>
 <20231205122316.ihhpklv222f5giz3@skbuf>
 <nflj4ajgx3byqhwna2eslldwulbbafmcwba4dwgxo65o5c7pmj@zbgqt2zje4ix>
 <20231208163343.5s74bmirfna3o7yw@skbuf>
 <xhj7jchcv63y2bmnedxqffnmh3fvdxirccdugnnljruemuiurz@ceafs7mivbqp>
 <20231214120016.wgeip3mdro5ihnxe@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214120016.wgeip3mdro5ihnxe@skbuf>

On Thu, Dec 14, 2023 at 02:00:16PM +0200, Vladimir Oltean wrote:
> On Thu, Dec 14, 2023 at 02:54:00PM +0300, Serge Semin wrote:
> > > > > The pcs-rzn1-miic.c driver puts a device_link to the MAC to at least
> > > > > tear down the whole thing when the PCS is unbound, which is saner than
> > > > > crashing the kernel. I don't see the equivalent protection mechanism here?
> > > > 
> > > > You are right. I don't have any equivalent protection here. Thanks for
> > > > suggesting a solution.
> > > 
> > > I think that a device link between the "ethernet" device and the "mdio"
> > > device (controller, parent of the PHY or PCS), if the Ethernet is not a
> > > parent of the MDIO controller, could also solve that. But it would also
> > > require ACK from PHY maintainers, who may have grander plans to address
> > > this snag.
> > 
> > Ok. I'll add it in v2. Let's see what the maintainers think about
> > that.
> 
> Are you not following the parallel discussion on the topic of PCS
> devices having bound drivers?
> https://lore.kernel.org/netdev/ZXnV%2FPk1PYxAm%2FjS@shell.armlinux.org.uk/
> 
> Sadly I don't have much spare time to join that discussion, but it looks
> like you could.

Ok. Thanks for sharing the link. At least I'll follow up the
discussion in order to pick up/wait for a solution they'll come up
with.

-Serge(y)

