Return-Path: <netdev+bounces-102484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19116903339
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A193828ACF1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8972171E77;
	Tue, 11 Jun 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fQ7lWrmr"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C54B657;
	Tue, 11 Jun 2024 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718089885; cv=none; b=Q8kWljtByKF8E46NndhcrCRv5Qrb8VjRi9SdbuelR7QLJLkZuo0F9h1NYyUMZEF9gVavb/Pb3x0VQCJV6jEUkdK7nL3EYm1eE2KdRtr+q3d33C0bdC45pW11fWJIv+TfRg1Z04Ij35CDbuKaKFa6cBvYa11mA4ENcMYy43oy4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718089885; c=relaxed/simple;
	bh=S/+Xkivq6IhVJaiax56t6bbl+j9bKb4Vi8iCoKSPCuo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic9+uN3fOEeEBWzZRdYKLOaa7l00uDElZwX70l2pA6sT+ZCl15xT2h9z4pdsJ05kpVkg1DTAdUoYflgZvN7MXF/+0K2bGYnzipLDruX58hyUTbmSGpw+6gJv1HJkeMbvQMXLj34CBKiT2LMtAZKcgCGmi9OO7WZEtsCytMcmdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fQ7lWrmr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718089882; x=1749625882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S/+Xkivq6IhVJaiax56t6bbl+j9bKb4Vi8iCoKSPCuo=;
  b=fQ7lWrmr5s3/PV5K6RvrbUrPOq0sF93xWBYB5QlUXcyYv70IlMHNy+SV
   1rN4i4fQt4ntqSzH9DmFVHAAYxR2XROpcltJo+I/8mNiahShR6x6yO+qs
   NnXFK4Fa5QLp4XvkCk0Ir2Fe3i4D3RGBeW1v3CVvlCt4ru0yei7HJHoNv
   1+3kiihcM72OmMUyCJu9cjUyUbfrY8T4i0R/Bf1gN5QF524guwfObBw30
   tO8c68jq3C4i9pl1S9ViEgDTy+Oo120G3HTGUXJOg71G6IrABfhseVps9
   CRR4hyQC95+voQQo23143GU/UJ2L5l6eCgeWSI+1p1uJMKvc6DefCB2Lj
   Q==;
X-CSE-ConnectionGUID: ZAOYpDyHSrmaJOE3+iJT+w==
X-CSE-MsgGUID: pUAy/F8kSkqqLxXpBzXmfQ==
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="27254456"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jun 2024 00:11:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 11 Jun 2024 00:10:51 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 11 Jun 2024 00:10:51 -0700
Date: Tue, 11 Jun 2024 09:10:51 +0200
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
Message-ID: <20240611071051.65e5n3bn7e4zm7lq@DEN-DL-M31836.microchip.com>
References: <202406052200.w3zuc32H-lkp@intel.com>
 <20240611062753.12020-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240611062753.12020-1-Raju.Lakkaraju@microchip.com>

Hi Raju,

Is this not supposed to be v4?
Because I can see v3 here:
https://www.spinics.net/lists/netdev/msg1002225.html

The 06/11/2024 11:57, Raju Lakkaraju wrote:
> This patch series implement the following fixes:
> 1. Disable WOL upon resume in order to restore full data path operation
> 2. Support WOL at both the PHY and MAC appropriately 
> 3. Remove interrupt mask clearing from config_init 
> 
> Patch-3 was sent seperately earlier. Review comments in link: 
> https://lore.kernel.org/lkml/4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch/T/
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>                        
> Reported-by: kernel test robot <lkp@intel.com>                                  
> Closes: https://lore.kernel.org/oe-kbuild-all/202406052200.w3zuc32H-lkp@intel.com/

I think you should drop the 'Reported-by' and 'Closes' tags because the
issue that is getting closed is the one that you introduced in one of
your previous version of the patch series.

> 
> Raju Lakkaraju (3):
>   net: lan743x: disable WOL upon resume to restore full data path
>     operation
>   net: lan743x: Support WOL at both the PHY and MAC appropriately
>   net: phy: mxl-gpy: Remove interrupt mask clearing from config_init
> 
>  .../net/ethernet/microchip/lan743x_ethtool.c  | 44 ++++++++++++--
>  drivers/net/ethernet/microchip/lan743x_main.c | 46 ++++++++++++---
>  drivers/net/ethernet/microchip/lan743x_main.h | 28 +++++++++
>  drivers/net/phy/mxl-gpy.c                     | 58 ++++++++++++-------
>  4 files changed, 144 insertions(+), 32 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

-- 
/Horatiu

