Return-Path: <netdev+bounces-56299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA680E712
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C792B1C20D2A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E55958123;
	Tue, 12 Dec 2023 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zglibz5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ECAC7;
	Tue, 12 Dec 2023 01:08:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bce78f145so6232279e87.0;
        Tue, 12 Dec 2023 01:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702372091; x=1702976891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIjPBVeqkpjJISDqusXw3EmS1YdMB1wPejTAPOdPhFM=;
        b=Zglibz5F1zOHeXpIe8espdYCHfBuyKlW4/fsq5XL8o3Fc4XiNRqrNroNkvItm/DJXo
         IGeRiACqfirCe0tyCQC0z8N0t0X47vnus4zWv+yu7fLor4hewtbrjw4TVnBBahVsvyZE
         MLQuxcvvO6CTL4UhS3KOsCLv8dPTRdslPjEG50xD0MRct+6i/dsTJe8WzAJMxoTxkary
         pAuHCIyKdNrz7nb4grYDB6Z/p7xZIeA5d7UKhaUXm+OKrAQsEsLV2w1vD8+u6Lv4JCYC
         XiSGIjMZvh7yerZz0kurkUgyzs/1eGAdvSQLSTOwIaxulSacCiicsxoq9L+ojgvckycm
         gg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702372091; x=1702976891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIjPBVeqkpjJISDqusXw3EmS1YdMB1wPejTAPOdPhFM=;
        b=Vz8nzPZ0X5h1QZ4XnzAXS7NwTR1tM27AYBMvB9xoNzPVSzPE0Ht8SVQKeh/ZvFu7O0
         bm804aeH9xscKKytmL9GmKscOQC3Q2R6wHTzcDPO88UMEqOYqQeJ+c8N2M5I1N716GGb
         qGPxH+AyH7a67fbiYY2muZW6mn5Jxz0j3Wft67Pe1mqA/erkUk5hH2ukl2g6eMgdh3rN
         4AWoN4mxzHAAelV66GX7LIRaOJlh8SodsoZKAHZm/tGVYZOiwF6GhQ+SPIWLMijyIdy9
         BuE/2Gi7aj5ERzlyPrbL4xeL5CG+ozhfoULUJr91xsjT/QrnonNH5YePJfrHSwo6V+4f
         gqsw==
X-Gm-Message-State: AOJu0Yyuj6wDUFTS/w/8yl7Yv0rkKUp9GenrmHenAcKb9tUQ9c0JidBR
	U/NeOZPkVw/X7ryqSJNjYuA=
X-Google-Smtp-Source: AGHT+IHt99lcd5IUKs49PKtCTF0cKUj5I2Ik89wnLq7Asjoik1V8IuHwNphFLryPGu803yiXf3w+fw==
X-Received: by 2002:a05:6512:46f:b0:50b:ed48:247a with SMTP id x15-20020a056512046f00b0050bed48247amr1240510lfd.246.1702372091059;
        Tue, 12 Dec 2023 01:08:11 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t8-20020a19ad08000000b0050c0f5ce8c2sm1290876lfc.124.2023.12.12.01.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:08:10 -0800 (PST)
Date: Tue, 12 Dec 2023 12:08:07 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc: Andrew Lunn <andrew@lunn.ch>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	James Li <James.Li1@synopsys.com>, Martin McKenny <Martin.McKenny@synopsys.com>
Subject: Re: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Message-ID: <ulsdbn3iqzyokqbfejp5krrpbkzz3rqpxfw53m2rfm2ouzs2bz@ys4ynwqwewjo>
References: <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <d202770a-3a3a-4ee2-b0de-b86e2f3e83ce@lunn.ch>
 <CY5PR12MB6372C8770900AFF821325400BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR12MB6372C8770900AFF821325400BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>

On Tue, Dec 12, 2023 at 07:22:24AM +0000, Jianheng Zhang wrote:
> Hi Andrew,  
> 
> > > +static int dwxgmac3_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> > > +{
> > > +	u32 value;
> > > +	int status;
> > >
> > > -		writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
> > > -		return;
> > > +	status = FPE_EVENT_UNKNOWN;
> > > +
> > > +	/* Reads from the XGMAC_FPE_CTRL_STS register should only be performed
> > > +	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
> > > +	 */
> > > +	value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
> > > +
> > > +	if (value & XGMAC_TRSP) {
> > > +		status |= FPE_EVENT_TRSP;
> > > +		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
> > 
> > netdev_info()?  Is this going to spam the logs? Should it be netdev_dbg()
> 
> Yes, netdev_dbg() should be better, let me fix it in the next patch.

Please do not forget to keep this change in the refactoring patch (if
one will be introduced). So instead of preserving the DW QoS Eth FPE
code snipped with netdev_info() utilized, the common FPE
implementation would have the netdev_dbg() calls.

-Serge(y)

> 
> Jianheng
> > 
> > 	Andrew
> 

