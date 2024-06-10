Return-Path: <netdev+bounces-102258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780269021AC
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DC42845DE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B997FBA8;
	Mon, 10 Jun 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RI6pwL8M"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD37FBC3;
	Mon, 10 Jun 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022656; cv=none; b=K42D8K9KLlmo8TPvnkmpOB+Xdsrel30JUPQJ9lbRw8jEHFKPR63QeIQx2OGjVgADGtJ8+uqJmDX/N+UJX6LQwaq61V8eq20j/yt1dh4fPvMvPVMdeqWnban/mVWkj6UgsWPFavU1pxxC5FIzTYlPr35ESylzgxlEnnci6ZNFHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022656; c=relaxed/simple;
	bh=veByNKSd2kQ7TiJKiXGkl7HROTIQBu6OtkQPiB073wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onuxdYCpk6N/qjO2/DTxbhTTqujHyVNVS28CjGqu5zIFyc9bg1H4aTK5/NwGPQ9T3rtRgQEemr6eKoDOKqfsFleE1AiLn178N6zkjubwh3aBarepIinnPzQl6jTsBj9lTJ9ny8PwE3VZFqzqCHDVJiLK8HSiDtrpuUPhwyia6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RI6pwL8M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZAmsJ52qEwd6M60f4uacAxS1bKk0l5sx1M5ZKU+F02g=; b=RI6pwL8Mkl7wa4Jo79n0XYBrkV
	ro9kjR65ptgoMiajSMTClkDTnPMHfm0b9oXxDSfIpRRzYWC97ceiJ6shdT3fyBRH1TdcFTEpWpHLK
	PcxHw8B06RELz2fyisz4uMaNIVSTMtmCeylDOqIYfuOSfftgFcIMawAQmfqj2a/WO4EI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGeAY-00HIOs-FV; Mon, 10 Jun 2024 14:30:38 +0200
Date: Mon, 10 Jun 2024 14:30:38 +0200
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
Message-ID: <3c32c9b9-be77-41c8-97f7-371bd6f8fa16@lunn.ch>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <48176576-e1d2-4c45-967a-91cabb982a21@lunn.ch>
 <DM8PR11MB5751469FAA2B01EB6CEB7B50C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <48673551-cada-4194-865f-bc04c1e19c29@lunn.ch>
 <DM8PR11MB5751194374C75EC5D5889D6AC1F32@DM8PR11MB5751.namprd11.prod.outlook.com>
 <322d8745-7eae-4a68-4606-d9fdb19b4662@linux.intel.com>
 <BL3PR11MB57488DF9B08EACD88D938E2FC1F82@BL3PR11MB5748.namprd11.prod.outlook.com>
 <734c0d46-63f2-457d-85bf-d97159110583@lunn.ch>
 <DM8PR11MB5751CD3D8EF4DF0B138DEB7FC1FB2@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751CD3D8EF4DF0B138DEB7FC1FB2@DM8PR11MB5751.namprd11.prod.outlook.com>

On Fri, Jun 07, 2024 at 04:09:37AM +0000, Ng, Boon Khai wrote:
> > 
> > Do you have access to all the reference documentation for the IP driven in
> > dwmac4_core.c, dwxgmac2_core.c and stmmac_main.c? Is it just VLAN which
> > is the same, and everything else is different? Or are other blocks of the
> > hardware also identical and the code should be shared?
> > If VLAN is all that is identical, then stammc_vlan.c would make sense.
> 
> Hi Andrew, I only have access to the document for 
> dwmac4_core.c and dwxgmac2_core.c

O.K. So please do look at the VLAN code in other places and see if any
can be shared.

, I notice that in the linux mainline
> https://github.com/torvalds/linux/tree/master/drivers/net/ethernet/stmicro/
> stmmac
> 
> it does have stmmac_est.c and stmmac_ptp.c to that support for both
> dwmac4 and dwxgmac2, with that I think it is suitable for introducing
> another file called stmmac_vlan?

Yes, stmmac_vlan.c is O.K.

	Andrew

