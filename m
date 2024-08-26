Return-Path: <netdev+bounces-122039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361FC95FA4A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B231F22619
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE8B199EAC;
	Mon, 26 Aug 2024 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q1SkOqg/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4BA199E9C
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702587; cv=none; b=PwOdYT54JPizmWZnTuRoT3wD+VWWUQliWscUrdEF9Gu6RbGF+LkDDklOAuI5qkX4BIq+UeDprRT35tThkhfzOQMv67fDRVDvj9EYbpW7J8qID0NX8QsREHZgHDiRT9KXrHdA1XUX+3hGVlamtCrYkLxSUYUjkH+emnbRWF1XuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702587; c=relaxed/simple;
	bh=g5xOaai0fgTbYlUKqLFRHlFw5MNLDbz9WCMjdzLGo3Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chhM4RmnoMkTdU3oWp3ZX6BKGAhoPLICG+Ygf7pNf19d0AsbZhY7lJHYv0WgBMmIVz8ojkWrz3zZPbfIykeMcX2nVc18VpeCw2LH6RCuVNG3fAytfpLf0ViGvARhOq9HI/oNH2v2buskodKCwr6bWqN3KC3o3jN+z+z/iJLNJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q1SkOqg/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso5544625a12.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724702584; x=1725307384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VApVdDfxKyIda0Fc340q9PZEeoaKy91HY6fQC9GFL0U=;
        b=Q1SkOqg/iPU9Fa6gnkjlcaGewZkWbNJZulREbKAONKaBqfdeBSHESx46Si+roYQwKc
         wSwRmavWe2pSINYwNiD1rhTJp9VfNhkdp0gFy1y8sxmp3uHzNbHB1fU7uR3leFYG4WBq
         Pq0lQcHaA952ynFfejUsFrrgS/0Num1IbS1jtO0klPEnqHu9ok5Elh39LRMImxTi9U9q
         osYAJExt2jS7qwxqRm1huXY7DO4pCQ0KJiCfEGkVzZDBg/o8zXujlIRe/XeDZpDbqazr
         uwtM6LFIeCONkSeG59m6TtTktvJnYP1KUoGm38XCmFMAVJ3Kj9Mtb/DYnH9o1Exwdlrj
         B3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724702584; x=1725307384;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VApVdDfxKyIda0Fc340q9PZEeoaKy91HY6fQC9GFL0U=;
        b=JBmx1cM4TzlWdijs6yzROzcXUaJrxekDSFk1MosPf+EEZ5s29jsOgTNyP8JiBYTm3P
         HmN9uEDXwHi7/dhLBf3bP/clJ9iSDtnDrjRLXG80AN5y8VyblXBa4pEHamOZjWwwgyTI
         xGb3sZ2auU4OJjWZOzFfe5LZ4I5p7yhINAiKSvGRYPpolFOlQVA+oyIxnyMrMlRgbayv
         4wvz2NRQs4ZdXdBjmzuYRLy3HJWhPKB1dlflFxhrK3uSPxGYq4fViXMTr2mT22YC/asF
         3yLjOi1/P2vynCk1tkYULa43cvrLff5f7RJB2KNEMLse9MZ/tYB3BkQFMapZttUtAsz2
         xodA==
X-Forwarded-Encrypted: i=1; AJvYcCWtFSf82DKjaztU3pKY85aJpTu3gVJP/Tyrhw6aSDOyF4RgiZjkt3SvOM6iCFadW0r3gEc4FFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrRttsGhC/UKcsxEXCHWAY89Lc3qSd6nrE6iiBwurj3/h3o9S1
	ykLzcx0G2nnwieFt25Aq3YKqNzvXWb59+vVH6W60y+NJA9WGohmhVNwKz1GEhhk=
X-Google-Smtp-Source: AGHT+IEJun9KfUteMfL59uNTGUHEpSrl0T1D6SDZ8OvEGiIZBnAyJPah0ll1ZtxJIi9VNurPdw/FLQ==
X-Received: by 2002:a05:6402:40c5:b0:5be:dc90:d13f with SMTP id 4fb4d7f45d1cf-5c08915b944mr8842242a12.5.1724702583173;
        Mon, 26 Aug 2024 13:03:03 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1f62bcsm137523a12.35.2024.08.26.13.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:03:02 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 26 Aug 2024 22:03:09 +0200
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 10/11] net: macb: Add support for RP1's MACB variant
Message-ID: <ZszffZoaK7WRRdjc@apocalypse>
Mail-Followup-To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <775000dfb3a35bc691010072942253cb022750e1.1724159867.git.andrea.porta@suse.com>
 <c0b904d8-073d-47ec-9466-28ae3a212dac@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b904d8-073d-47ec-9466-28ae3a212dac@broadcom.com>

Hi Florian,

On 10:01 Wed 21 Aug     , Florian Fainelli wrote:
> On 8/20/24 07:36, Andrea della Porta wrote:
> > RaspberryPi RP1 contains Cadence's MACB core. Implement the
> > changes to be able to operate the customization in the RP1.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> 
> You are doing a lot of things, all at once, and you should consider
> extracting your change into a smaller subset with bug fixes first:
> 
> - one commit which writes to the RBQPH the upper 32-bits of the RX ring DMA
> address, that looks like a bug fix
> 
> - one commit which retriggers a buffer read, even though that appears to be
> RP1 specific maybe, if not, then this is also a bug fix
> 
> - one commit that adds support for macb_shutdown() to kill DMA operations
> 
> - one commit which adds support for a configurable PHY reset line + delay
> specified in milli seconds
> 
> - one commit which adds support for controling the interrupt coalescing
> settings
> 
> And then you can add all of the RP1 specific bits like the AXI bridge
> configuration.
> 
> [snip]
> 
> > @@ -1228,6 +1246,7 @@ struct macb_queue {
> >   	dma_addr_t		tx_ring_dma;
> >   	struct work_struct	tx_error_task;
> >   	bool			txubr_pending;
> > +	bool			tx_pending;
> >   	struct napi_struct	napi_tx;
> >   	dma_addr_t		rx_ring_dma;
> > @@ -1293,9 +1312,15 @@ struct macb {
> >   	u32			caps;
> >   	unsigned int		dma_burst_length;
> > +	u8			aw2w_max_pipe;
> > +	u8			ar2r_max_pipe;
> > +	bool			use_aw2b_fill;
> >   	phy_interface_t		phy_interface;
> > +	struct gpio_desc	*phy_reset_gpio;
> > +	int			phy_reset_ms;
> 
> The delay cannot be negative, so this needs to be unsigned int.
> 
> > +
> >   	/* AT91RM9200 transmit queue (1 on wire + 1 queued) */
> >   	struct macb_tx_skb	rm9200_txq[2];
> >   	unsigned int		max_tx_length;
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> > index 11665be3a22c..5eb5be6c96fc 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -41,6 +41,9 @@
> >   #include <linux/inetdevice.h>
> >   #include "macb.h"
> > +static unsigned int txdelay = 35;
> > +module_param(txdelay, uint, 0644);
> > +
> >   /* This structure is only used for MACB on SiFive FU540 devices */
> >   struct sifive_fu540_macb_mgmt {
> >   	void __iomem *reg;
> > @@ -334,7 +337,7 @@ static int macb_mdio_wait_for_idle(struct macb *bp)
> >   	u32 val;
> >   	return readx_poll_timeout(MACB_READ_NSR, bp, val, val & MACB_BIT(IDLE),
> > -				  1, MACB_MDIO_TIMEOUT);
> > +				  100, MACB_MDIO_TIMEOUT);
> 
> Why do we need to increase how frequently we poll?

Thanks for your feedback, I will save all your precious suggestions for a future patch that
will enable the macb ethernet.
As stated in the cover letter, right now this specific patch is not intended to be upstreamed
as is but it's just here for testing purposes, hence its 'raw' state.
For sure the ethernet contained in RP1 will be one of the first device I will try to bring
upstream, so I'll apply your comments there. Maybe the next time I will also add a better
explanation about the state of a specific patch in the commit comment itself, and not only
in the cover letter, just to be more explicit.

Many thanks,
Andrea 

> -- 
> Florian
> 

