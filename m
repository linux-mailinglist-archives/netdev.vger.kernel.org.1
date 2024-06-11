Return-Path: <netdev+bounces-102531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB5E90392F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D421C23B67
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E25178380;
	Tue, 11 Jun 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hOU2iZ71"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4A174EC1;
	Tue, 11 Jun 2024 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102778; cv=none; b=h89lVU5C+v9AQBZKbEq20Uooveaqko1k+yARan47IKd8r2iFdJ3mV+HzYBwjV2lXO9zucvO1Tqixk00h+JU28mwkUgvwEY7Lmpq3JzmjAfN+ALRdM8ln6a9POo70lh0byZxaFUZhDvHqONoL9zWv5FyizXKXAhVeCmd3xXRofxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102778; c=relaxed/simple;
	bh=4TSoFH28pB7Lu+/lE2dCqcs0oPJH8qkuGmHC1tVnGC4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcNpgZQPBxsgIP77meq8NQ+KlcK5xakNQkrmkTzSUajqvp5+vkpOfd7mLeP3DEP0x5k8SvwqQHt2BF2n1HiH2jos2rzK5PqGIgibcEwoeyEi35gA4rnQw9oCe3geTsqQitpIUpQ52e1O8nz924QdFmfl5R91kTQcRLfCZCQr8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hOU2iZ71; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718102776; x=1749638776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4TSoFH28pB7Lu+/lE2dCqcs0oPJH8qkuGmHC1tVnGC4=;
  b=hOU2iZ716RHX4AcynPgbl7r92GYBAhcl1ze0vwp6vg5IOcUpFZ/oqs2j
   0xRpG+wIVpiKXvckHJcNQtSNX7B6wyWFadSoey4EqIM+CiB+uzLVqq/9Z
   YSmubeKmKZRr0G/qltKJP06YNpQfBKJXHk0WD1P1jAtv5h+H7npcmG60o
   NUPj5//xvXu6R/+LXpzNv2nUgITXUFBenVarXv3SoMJgNj1//+zzEgqxn
   EAZx1/RUO6OergVrRmKPyD8M4jGMVykLhKUowyGNEttdiLNiQRCFJYXAR
   Bkqu82J3GiihZsx62DTYxdv/RkaRLH6tPMP4z1uMk35tx5IhHSTzqJEdj
   w==;
X-CSE-ConnectionGUID: HKNdurkMQ2Ggz/eZHEil9w==
X-CSE-MsgGUID: QrJi9OqDTUWo+/GXWEgcCg==
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="27263922"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jun 2024 03:46:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 11 Jun 2024 03:45:44 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 11 Jun 2024 03:45:44 -0700
Date: Tue, 11 Jun 2024 12:45:44 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
CC: <lkp@intel.com>, <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
	<bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <hkallweit1@gmail.com>, <hmehrtens@maxlinear.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<lxu@maxlinear.com>, <netdev@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <pabeni@redhat.com>, <sbauer@blackbox.su>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net V3 0/3] net: lan743x: Fixes for multiple WOL related
 issues
Message-ID: <20240611104544.pjtqkx4dhdnngpaq@DEN-DL-M31836.microchip.com>
References: <202406052200.w3zuc32H-lkp@intel.com>
 <20240611062753.12020-1-Raju.Lakkaraju@microchip.com>
 <20240611071051.65e5n3bn7e4zm7lq@DEN-DL-M31836.microchip.com>
 <ZmgEUrA6xM9vtDxD@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ZmgEUrA6xM9vtDxD@HYD-DK-UNGSW21.microchip.com>

The 06/11/2024 13:31, Raju Lakkaraju wrote:
> Hi Horatiu,
> 
> There is no new changes except "kernel test robot" reported issue.

So there is no change in the code, you just added the tags between this
version and the previous one where the robot complained?
Because to me it looks like you added an extra #ifdef in 2/3 patch.

> 
> I fix the issue and sent the patch along with other old patches.
> Also add "Reported-by" and "Closes" tags to all patches and
> --in-reply-to=202406052200.w3zuc32H-lkp@intel.com.
> i.e.
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406052200.w3zuc32H-lkp@intel.com/

It doesn't say to add only if you fix the issue in a separate patch and
not just for a new version of the patch/commit.
Or I miss reading this?

> 
> Is it sufficient? or
> Do you need to generete new version of patches ?

Every time when you do a change in your patch until is accepted, you
will need to generate a new version.
Don't forget about 24h rule. That you need to wait 24h before you can
send a new version.

> 
> Thanks,
> Raju
> The 06/11/2024 09:10, Horatiu Vultur wrote:
> > Hi Raju,
> > 
> > Is this not supposed to be v4?
> > Because I can see v3 here:
> > https://www.spinics.net/lists/netdev/msg1002225.html
> > 
> > The 06/11/2024 11:57, Raju Lakkaraju wrote:
> > > This patch series implement the following fixes:
> > > 1. Disable WOL upon resume in order to restore full data path operation
> > > 2. Support WOL at both the PHY and MAC appropriately 
> > > 3. Remove interrupt mask clearing from config_init 
> > > 
> > > Patch-3 was sent seperately earlier. Review comments in link: 
> > > https://lore.kernel.org/lkml/4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch/T/
> > > 
> > > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>                        
> > > Reported-by: kernel test robot <lkp@intel.com>                                  
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202406052200.w3zuc32H-lkp@intel.com/
> > 
> > I think you should drop the 'Reported-by' and 'Closes' tags because the
> > issue that is getting closed is the one that you introduced in one of
> > your previous version of the patch series.
> > 
> > > 
> > > Raju Lakkaraju (3):
> > >   net: lan743x: disable WOL upon resume to restore full data path
> > >     operation
> > >   net: lan743x: Support WOL at both the PHY and MAC appropriately
> > >   net: phy: mxl-gpy: Remove interrupt mask clearing from config_init
> > > 
> > >  .../net/ethernet/microchip/lan743x_ethtool.c  | 44 ++++++++++++--
> > >  drivers/net/ethernet/microchip/lan743x_main.c | 46 ++++++++++++---
> > >  drivers/net/ethernet/microchip/lan743x_main.h | 28 +++++++++
> > >  drivers/net/phy/mxl-gpy.c                     | 58 ++++++++++++-------
> > >  4 files changed, 144 insertions(+), 32 deletions(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > > 
> > 
> > -- 
> > /Horatiu
> 
> -- 
> Thanks,                                                                         
> Raju

-- 
/Horatiu

