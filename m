Return-Path: <netdev+bounces-50239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9EF7F4FDC
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC161C20B2C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB775CD29;
	Wed, 22 Nov 2023 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p702r9em"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08A8E7;
	Wed, 22 Nov 2023 10:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y1fBGTaRbSsoTo5doogPTMVmvkDbZKH9bppQF/sgZqE=; b=p702r9emhkbRvBPO7sN3lEkiso
	/rQFsZ6XCANykAc95fAd27zoV5bytiHkSvzmB691lItmkNeldjgv/Ra/V+XaDFG1s0YVy8iLLUJBy
	2/8q9JbfiTYx3FuHTMgNAHpa18lX4BM8lLM6QbpZS6V7U2hFtWIq2TTc2wDZPtvkhJbU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5sDs-000uBk-Dl; Wed, 22 Nov 2023 19:45:16 +0100
Date: Wed, 22 Nov 2023 19:45:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: alexandre.torgue@foss.st.com, tali.perry1@gmail.com,
	edumazet@google.com, krzysztof.kozlowski+dt@linaro.org,
	linux-stm32@st-md-mailman.stormreply.com, benjaminfair@google.com,
	openbmc@lists.ozlabs.org, joabreu@synopsys.com, joel@jms.id.au,
	devicetree@vger.kernel.org, j.neuschaefer@gmx.net,
	robh+dt@kernel.org, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, avifishman70@gmail.com,
	venture@google.com, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
Message-ID: <9ad42fef-b210-496a-aafc-eb2a7416c4df@lunn.ch>
References: <20231121151733.2015384-1-tmaimon77@gmail.com>
 <20231121151733.2015384-3-tmaimon77@gmail.com>
 <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch>
 <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>

On Wed, Nov 22, 2023 at 07:50:57PM +0200, Tomer Maimon wrote:
> Hi Andrew,
> 
> Thanks for your comments
> 
> On Tue, 21 Nov 2023 at 18:42, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +void npcm_dwmac_pcs_init(struct npcm_dwmac *dwmac, struct device *dev,
> > > +                      struct plat_stmmacenet_data *plat_dat)
> > > +{
> > > +     u16 val;
> > > +
> > > +     iowrite16((u16)(SR_MII_CTRL >> 9), dwmac->reg + IND_AC_BA_REG);
> > > +     val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > +     val |= PCS_RST;
> > > +     iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > +
> > > +     while (val & PCS_RST)
> > > +             val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > +
> > > +     val &= ~(PCS_AN_ENABLE);
> > > +     iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > +}
> >
> > Is this a licensed PCS implementation? Or home grown? If its been
> > licensed from somebody, it maybe should live in driver/net/pcs, so
> > others can reuse it when they license the same core.

> we are using DWC PCS, I don't see support for DWC PCS and I am not
> sure it is supposed to be supported at /drivers/net/pcs

I've not followed the naming used by Synopsys. Is DWC PCS the same as
XPCS? Does Synopsys have multiple PCS implementations?

> I do see a patch set to support DWC PCS but I don't think it answers my needs
> https://patchwork.ozlabs.org/project/netdev/patch/1559674736-2190-3-git-send-email-weifeng.voon@intel.com/

I _think_ this patch eventually got turned into
driver/net/pcs/pcs-xpcs.c

What exactly does it not do for you?

     Andrew

