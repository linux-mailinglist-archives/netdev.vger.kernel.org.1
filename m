Return-Path: <netdev+bounces-55351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD580A831
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AEF1C20A54
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25DF37146;
	Fri,  8 Dec 2023 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrHUqZ91"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62647173F;
	Fri,  8 Dec 2023 08:07:47 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so27146861fa.3;
        Fri, 08 Dec 2023 08:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702051665; x=1702656465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CfiPX6OGNhZRjUiwvlyjSmKemrJqXvraxcvBV131SRo=;
        b=mrHUqZ91dhfQgERBnCN1Sm/97xw+v2x/YNlFJzYF6+G/JeSfUYBAK2A90iNepCR3CJ
         fdYWj2JpSCxW517qbEmMD/QLAV5R74rM1FSgST7uvIYsFBJy0gvlNRv5BB8QPz2qCd0w
         NT0b4V7UbT7fdcnPbWHIz2saxPiruZc918DuG0IuVCsnwSuAUIwAeL3VVjCYs6HNfXI6
         xWeTtJNHSzACBGxSGzZdHKPrvKOWTtMZ275JNZd6afN0bI/BH0OZYl0XCPjqTKOtMann
         rQdR39D9zXh0Hy3s6HGXl7Op8TU91T3psdwjpZzGFNjKIJ3aFuaK8O2IiSc69vdVFLIC
         N7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702051665; x=1702656465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfiPX6OGNhZRjUiwvlyjSmKemrJqXvraxcvBV131SRo=;
        b=GUYiIkYFI344ZBapEt/hkew1dg4mqpbxJGff9szzxJ/MTjE9DuGqZXzbBQ0u+eBPRV
         mpKjQSVuSW+AFQwg2t8j30cO4ZhFOwYT6V1fwR/n18pSlem+kZuKFGbZjqNubSsfF98m
         fPQMpAehpFxiw80hQ9fLm5Pk9hck5JkeUtOrguv9c1HBrvRVKjvydcvYfCr2MfDEG2IK
         etipxSiivFhRV5f7cJtrpuf2pUD8voj4Kmvaxhe/9Q0rsUmHu4JBU0R57gmxQR22DEE4
         JWgUOeWKW5HZIikrupD1hHP1CZUfEaNDWsi58OhWmOBnkE8H2uyZPppMa4z+JQBDuVhn
         hzWA==
X-Gm-Message-State: AOJu0YyWX71BJ3SkNQk7wEefJ8LLo04z8sJ5XjPazx4McwOm0+vyVn6S
	2AZgY/dDmyFEhd0pSrZxLPk=
X-Google-Smtp-Source: AGHT+IFERSjKkWw7VFG+TyMdjyfFLR1k0hpAoCtE644pZT7QRiW7cMROY1NVAgannUhObcH9HyaFkw==
X-Received: by 2002:a2e:3008:0:b0:2ca:a3d:dcda with SMTP id w8-20020a2e3008000000b002ca0a3ddcdamr41271ljw.57.1702051665318;
        Fri, 08 Dec 2023 08:07:45 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651c102200b002ca0e0c837asm259858ljm.100.2023.12.08.08.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:07:44 -0800 (PST)
Date: Fri, 8 Dec 2023 19:07:42 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/16] net: mdio: Add Synopsys DW XPCS
 management interface support
Message-ID: <vj3pxanxczwehchksvfeba6g4i3uusbcdy5afixrug64tvlpad@jxtjxite644q>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-10-fancer.lancer@gmail.com>
 <20231205133205.3309ab91@device.home>
 <cv6oo27tqbfst3jrgtkg7bcxmeshadtzoomn2xgnzh2arz4nwy@wq5k7oygto6n>
 <15e6857a-b1d1-465a-945e-6f31edac62fb@lunn.ch>
 <jqwhgthwxfge6y4nv5mdnojqu76m4pi2mt2x6kwqiuqntcwj67@mewh42eey5ny>
 <19ebc244-6d79-4e12-8ac4-fcf046106a07@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ebc244-6d79-4e12-8ac4-fcf046106a07@lunn.ch>

On Thu, Dec 07, 2023 at 03:54:08PM +0100, Andrew Lunn wrote:
> On Thu, Dec 07, 2023 at 04:35:47PM +0300, Serge Semin wrote:
> > Hi Andrew
> > 
> > On Wed, Dec 06, 2023 at 06:01:30PM +0100, Andrew Lunn wrote:
> > > > > You shouldn't use inline in C files, only in headers.
> > > > 
> > > > Could you please clarify why? I failed to find such requirement in the
> > > > coding style doc. Moreover there are multiple examples of using the
> > > > static-inline-ers in the C files in the kernel including the net/mdio
> > > > subsystem.
> > > 
> > 
> > > The compiler does a better job at deciding what to inline than we
> > > humans do. If you can show the compiler is doing it wrong, then we
> > > might accept them.
> > 
> > In general I would have agreed with you especially if the methods were
> > heavier than what they are:
> > static inline ptrdiff_t dw_xpcs_mmio_addr_format(int dev, int reg)
> > {               
> >         return FIELD_PREP(0x1f0000, dev) | FIELD_PREP(0xffff, reg);
> > }               
> >         
> > static inline u16 dw_xpcs_mmio_addr_page(ptrdiff_t csr)
> > {       
> >         return FIELD_GET(0x1fff00, csr);
> > }       
> > 
> > static inline ptrdiff_t dw_xpcs_mmio_addr_offset(ptrdiff_t csr)
> > {
> >         return FIELD_GET(0xff, csr);
> > }
> > 
> > > But in general, netdev does not like inline in .C
> > > file.
> > 
> > I see. I'll do as you say if you don't change your mind after my
> > reasoning below.
> > 
> > > Also, nothing in MDIO is hot path, it spends a lot of time
> > > waiting for a slow bus. So inline is likely to just bloat the code for
> > > no gain.
> > 
> > I would have been absolutely with you in this matter, if we were talking
> > about a normal MDIO bus. In this case the devices are accessed over
> > the system IO-memory. So the bus isn't that slow.
> 

> O.K, so its not slow. But how often is it used? PHYs tend to get
> polled once a second if interrupts are not used. But is the PCS also
> polled at the same time? Does this optimisation make a noticeable
> difference at once per second? Do you have a requirement that the
> system boots very very fast, and this optimisation makes a difference
> when there is heavier activity on the PCS at boot? Is the saving
> noticeable, when auto-neg takes a little over 1 second.
> 
> The best way to make your case is show real world requirements and
> benchmark results.

You do know how to well define your point.) Polling is what currently
implemented in the XPCS driver indeed. So in this case such small
optimization won't be even noticeable. Although theoretically the
IO-access could be performed on the fast paths, in the IRQ context,
but it could be relevant only if the DW XPCS device had the IRQ
feature activated on the particular platform and the DW XPCS driver
supported it. But seeing the driver currently doesn't support it and
the DW XPCS could be also found on the DW MAC SMA MDIO bus
(non-memory-mapped case), always handling IRQ in the hardware IRQ
context would be wrong. Splitting up the handlers would be
over-complication for indeed doubtful reason, since inlining those
methods won't gain significant performance even in that case. And of
course I don't have such strict requirements as you say. So I'll drop
the inline keywords then. Thank you very much for having kept
discussing the topic in order to fully clarify it for me, even though
the issue could have seemed unimportant to spend time for.

-Serge(y)

> 
> 	  Andrew

