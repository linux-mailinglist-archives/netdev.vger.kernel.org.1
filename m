Return-Path: <netdev+bounces-127679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49918976145
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECEE1C21741
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D3F190662;
	Thu, 12 Sep 2024 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uc6ZkvVI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A029319007E;
	Thu, 12 Sep 2024 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121800; cv=none; b=Tvd4hJNW43qaSMUuygegSGR8cDm9O1jf6Kf13zr7I0N5soQdJUWUE6Xou8NvXGR8vFrpa+qLHdzByw7ut125rPA2lB88wLjBztbLc7fNd1DwrUB8ad/uw/4X6W/4k3JdVKN+K9QFBw7ZH9zkqsRPu/2YAfKwptjuWWWrKdT8MgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121800; c=relaxed/simple;
	bh=3te06F52EECb2zHYBCV9siwUvxC5m1Tha4fFDOs3ZDo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvAB+E56Gb9iFTUtLnKSx0wKeypq0WiJ1LoTjb3A4cnA7vJDJkxFIFmwT7HFtWDg16fZDJSxTMd7WMKJJ8yTABT7utGEFEn7xsIaxixK9x1sbPZBV+lWuNVj2BTWcUnBZB9Q31eqzofk0pgkE55NuB7QICW+XJmdtYCGQG5AeoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uc6ZkvVI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726121799; x=1757657799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3te06F52EECb2zHYBCV9siwUvxC5m1Tha4fFDOs3ZDo=;
  b=uc6ZkvVIKrikXVd07HRBM5nCwQd8EgzFRh1UGHv/InvnzBdgKbLLmA7x
   Ml4eQXNlMiqEov9C2Va0EhdWWTET5gMqP8ulRlJ1bh3LytAKFL8K2bDt6
   KWsPlf1E0q/rK0drpBoO+AEbdtJ5mCrhgzvhn1ViSW7GEwW0KP+EtBK5X
   l8CtEL2DtchvbrCzUwDbw8hndJ9gxTN7pAOuNvTQ1Ffd/IdcKX63VEYFB
   R5BHmTFpIUm2xeMaHgcCS+dG5Tb6FVH+GRcF64CMZoHRpteflVQXd3bpk
   qwML6fPbFHW2MSuIWj/feLLM+yj5mzZ95pdG+cccMabiS9+Z1pKy/kGCm
   A==;
X-CSE-ConnectionGUID: 7K3ZszrYS2q1e5jxC3SWdA==
X-CSE-MsgGUID: 6c+WZ7KDSwaApPmAU8bS9g==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="31684618"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 23:16:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 23:15:56 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 11 Sep 2024 23:15:55 -0700
Date: Thu, 12 Sep 2024 11:42:05 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>, <andrew@lunn.ch>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Message-ID: <ZuKGNc3GaALRYnuA@HYD-DK-UNGSW21.microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
 <e542d2fc-0587-45a3-bc58-ee0a078a626a@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e542d2fc-0587-45a3-bc58-ee0a078a626a@wanadoo.fr>

Hi Christophe,

Thank you for review the patches.

The 09/11/2024 18:44, Christophe JAILLET wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Le 11/09/2024 à 18:10, Raju Lakkaraju a écrit :
> > Support for SFP in the PCI11x1x devices is indicated by the "is_sfp_support_en"
> > flag in the STRAP register. This register is loaded at power up from the
> > PCI11x1x EEPROM contents (which specify the board configuration).
> > 
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > ---
> > Change List:
> > ============
> > V1 -> V2:
> >    - Change variable name from "chip_rev" to "fpga_rev"
> > V0 -> V1:
> >    - No changes
> > 
> >   drivers/net/ethernet/microchip/lan743x_main.c | 34 +++++++++++++++----
> >   drivers/net/ethernet/microchip/lan743x_main.h |  3 ++
> >   2 files changed, 30 insertions(+), 7 deletions(-)
> > 
> >       netif_dbg(adapter, drv, adapter->netdev,
> >                 "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Dis");
> > +     netif_dbg(adapter, drv, adapter->netdev,
> > +               "SFP support %sable\n", adapter->is_sfp_support_en ?
> > +               "En" : "Dis");
> 
> Hi,
> 
> Maybe using str_enable_disable() or str_enabled_disabled()?
> 

Accepted. I will use str_enabled_disabled( ).

> CJ
> 
> > +
> > +     return 0;
> >   }
> > 
> 

-- 
Thanks,                                                                         
Raju

