Return-Path: <netdev+bounces-100736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CFC8FBC7C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4305B22F1E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA56914884D;
	Tue,  4 Jun 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kZHYxDO/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9F801;
	Tue,  4 Jun 2024 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529219; cv=none; b=A7ga2kf+aTp5jrsw6N5ccvCplubkG1lH+Y7C4EpI3CV1lHQ82JgsYgp3pknK4rMPgTuMtuh4qAeW/7yspsykdCMGheLG8Va9yYrfQHETVizF9XZTBj4Lf0QXu5ZWDHaLTOl+xWRTEnkvcCWy7+06eZpScXpy0RiURV73oiIqGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529219; c=relaxed/simple;
	bh=RfYADli4pR43LR8z8+OGq/B16AAsfprRCkUGcCgzMbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qihTp39lqd/gg3s5YsRYiIwf4Nwr5V5N5YvuBoCaU1XhrApdvA00LSSFZr/NdXIt9xRYLJgjxKZf2glGVeDUU9n861gLc+txRNg/7NbBJr9FMK56hGhu+/TxxNyEjDDcM4nNVZp9ERpbMFP1/Emv0m3osVDF+fDxVmtX1/C1hbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kZHYxDO/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wsZATjoAW728C9PCBeyQtYSddogYGOk05sPShVwPjac=; b=kZHYxDO/WVRlIL3QNyFnI4rCsk
	YgvhSkh9mfhdWR2/JAqlpW0Wm1xbMoXf1OfqcG2i8nQPHDS6Nyn9WFlVsg6jcCjFUP8DcarUZlL10
	c0F9boXbmKWcoT01q59knzKrEBXXaQal4jFdnx6tMjlKBFYYKQEnCtDfAiD8Q8OzkHP8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sEZnp-00Gq9r-2O; Tue, 04 Jun 2024 21:26:37 +0200
Date: Tue, 4 Jun 2024 21:26:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ang, Tien Sung" <tien.sung.ang@intel.com>,
	"G Thomas, Rohan" <rohan.g.thomas@intel.com>,
	"Looi, Hong Aun" <hong.aun.looi@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Tham, Mun Yew" <mun.yew.tham@intel.com>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Message-ID: <734c0d46-63f2-457d-85bf-d97159110583@lunn.ch>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <48176576-e1d2-4c45-967a-91cabb982a21@lunn.ch>
 <DM8PR11MB5751469FAA2B01EB6CEB7B50C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <48673551-cada-4194-865f-bc04c1e19c29@lunn.ch>
 <DM8PR11MB5751194374C75EC5D5889D6AC1F32@DM8PR11MB5751.namprd11.prod.outlook.com>
 <322d8745-7eae-4a68-4606-d9fdb19b4662@linux.intel.com>
 <BL3PR11MB57488DF9B08EACD88D938E2FC1F82@BL3PR11MB5748.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR11MB57488DF9B08EACD88D938E2FC1F82@BL3PR11MB5748.namprd11.prod.outlook.com>

On Tue, Jun 04, 2024 at 06:05:35AM +0000, Ng, Boon Khai wrote:
>  
> > You should generalize the existing functions into some other file within
> > stmmac/ folder and call those functions from both dwmac4_core and
> > dwxgmac2_core.
> > Do the rework of existing function & callers first and add the new bits in
> > another patch in the patch series.
> >
> 
> Hi Ilpo, do you mean I should create a new file for example,
> stammc_vlan.c,  and move the common vlan function inside?
> so that it can be called either from dwmac4_core, dwxgmac2_core 
> or stmmac_main.c? or maybe I should just consolidate them into
> stmmac_main.c?

Do you have access to all the reference documentation for the IP
driven in dwmac4_core.c, dwxgmac2_core.c and stmmac_main.c? Is it just
VLAN which is the same, and everything else is different? Or are other
blocks of the hardware also identical and the code should be shared?
If VLAN is all that is identical, then stammc_vlan.c would make sense.

If there is more in common, you can start the cleanup of the mess this
driver is by moving the VLAN code into a shared file, but make the
naming of that file more generic so more shared code can be added with
later cleanups.

       Andrew

