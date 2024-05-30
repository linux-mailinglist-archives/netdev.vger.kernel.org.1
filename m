Return-Path: <netdev+bounces-99317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDA58D46FA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0F11C21972
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 08:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994E14C580;
	Thu, 30 May 2024 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1ChtY+M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645FDDA1;
	Thu, 30 May 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057540; cv=none; b=WN8C4nSB3ZoqPJdIDoK0/kupsoK0WbZPItVQCuJ+Nr1acwwiuLm7zK/fF9aVCeyTrg7AtuMSJUwOVBsjDPU6f5gXFMFXIwH1jlpolRFTOy0LfcrlouwBthuxS4yUeynghzgpvhJRt7xmw+AayOqihF1onqdo1l4QnwG70tF7aHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057540; c=relaxed/simple;
	bh=YKqNURWS8n2g55ZrdJEWt/gjHie39zpHSbth/z2c/c4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Kj0+iRJYve1roXup+wFx3IFjBPaJ0bT6kvJxaiCA+TnP4OQU/XDe++3dUmhNVEircWs9OIEcgaFPxZK8T0tdt7YmQXvnWkMJScLty7XAcNQFKgJUjCtkbG9Pf7zd2ypwfmlcH58J85fyiHbZqPmC3ZHoshPCBkzVSmfLa/ZW1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1ChtY+M; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717057539; x=1748593539;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YKqNURWS8n2g55ZrdJEWt/gjHie39zpHSbth/z2c/c4=;
  b=N1ChtY+MSS33jplzjXDIVeMd7XoNBAA1Esgh/Kx8Jwnxp1wCajpJKR+i
   mGeRqP3K5P0a/R0c9nsoUT3s1w0XOYsgqa+sK0BIv9WrHaXaFSOKHFB5w
   VY9gzdVeq/WfkTyPCJXn0m6QpQ55M4kaVQroqHqvxg/j5rYTy6E7IiWSO
   /jP50JJurzN3kmmLzIGsv7uQagUh1fBykKNQFw6BFF7ifeYD/hJTfwu9q
   7+AhUHOblFXE3Lz6IPP7yiwzhTkd2YlqpOCP/JfNm635T5P5+j0JYvp4z
   kaRmLsC3oJFY88agvA4FiRN3eehotmx8DW2rlxIua+O85Oqo/1Oc8pykh
   w==;
X-CSE-ConnectionGUID: EB5Dw9BUTmOXChRBrWTYPg==
X-CSE-MsgGUID: xdA9UZNcTxivVjn4qEekDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17358450"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="17358450"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 01:25:27 -0700
X-CSE-ConnectionGUID: 2ClqADvBRt6M6ADjJgu1dw==
X-CSE-MsgGUID: iXQlDffJQPW0rqXEQT8ZBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="40183270"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.150])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 01:25:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 May 2024 11:25:16 +0300 (EEST)
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>
cc: Andrew Lunn <andrew@lunn.ch>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
    "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
    "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "Ang, Tien Sung" <tien.sung.ang@intel.com>, 
    "G Thomas, Rohan" <rohan.g.thomas@intel.com>, 
    "Looi, Hong Aun" <hong.aun.looi@intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
In-Reply-To: <DM8PR11MB5751194374C75EC5D5889D6AC1F32@DM8PR11MB5751.namprd11.prod.outlook.com>
Message-ID: <322d8745-7eae-4a68-4606-d9fdb19b4662@linux.intel.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com> <20240527093339.30883-2-boon.khai.ng@intel.com> <48176576-e1d2-4c45-967a-91cabb982a21@lunn.ch> <DM8PR11MB5751469FAA2B01EB6CEB7B50C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <48673551-cada-4194-865f-bc04c1e19c29@lunn.ch> <DM8PR11MB5751194374C75EC5D5889D6AC1F32@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 May 2024, Ng, Boon Khai wrote:

> > It is well know this driver is a mess. I just wanted to check you are not adding
> > to be mess by simply cut/pasting rather than refactoring code.
> 
> Okay sure Andrew, will take note on this.
> 
> > static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
> >                               struct dma_desc *rx_desc, struct sk_buff *skb) {
> >         if (hw->desc->get_rx_vlan_valid(rx_desc)) {
> >                 u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);
> > 
> >                 __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
> >         }
> > }
> > 
> > Looks identical to me.
> 
> Yes, some of the functions are identical, the driver has been divided 
> into dwmac4_core.c and dwxgmac2_core.c initially, so to enable the
> rx_hw_vlan, it is porting from dwmac4_core to dwxgmac2_core.
>   
> > The basic flow is the same. Lets look at the #defines:
> > 
> Right, the basic flow is direct copy and paste, and only the function
> name is updated from dwmac4 to dwxgmac2.

> > +static inline bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc
> > +*p) {
> > +	u32 et_lt;
> > +
> > +	et_lt = FIELD_GET(XGMAC_RDES3_ET_LT, le32_to_cpu(p->des3));
> > +
> > +	return et_lt >= XGMAC_ET_LT_VLAN_STAG &&
> > +	       et_lt <= XGMAC_ET_LT_DVLAN_STAG_CTAG; }
> > 
> > static bool dwmac4_wrback_get_rx_vlan_valid(struct dma_desc *p) {
> >         return ((le32_to_cpu(p->des3) & RDES3_LAST_DESCRIPTOR) &&
> >                 (le32_to_cpu(p->des3) & RDES3_RDES0_VALID)); }
> > 
> > #define RDES3_RDES0_VALID		BIT(25)
> > #define RDES3_LAST_DESCRIPTOR		BIT(28)
> > 
> > #define XGMAC_RDES3_ET_LT		GENMASK(19, 16)
> > +#define XGMAC_ET_LT_VLAN_STAG		8
> > +#define XGMAC_ET_LT_VLAN_CTAG		9
> > +#define XGMAC_ET_LT_DVLAN_CTAG_CTAG	10
> > 
> > This does actually look different.
> > 
> 
> Yes, this is the part in the descriptor where dwxgmac2 get the vlan  Valid. 
> it is described in Designware cores xgmac 10G Ethernet MAC version 3.10a
> page 1573.
> 
> > Please take a step back and see if you can help clean up some of the mess in
> > this driver by refactoring bits of identical code, rather than copy/pasting it.
> > 
> 
> Appreciate if you could help to point out which part that I have to cleanup?
> Do you mean I should combine the identical part between dwmac4_core.c
> and dwxgmac2_core.c? or I should update the part that looks different and
> make them the same?

You should generalize the existing functions into some other file within 
stmmac/ folder and call those functions from both dwmac4_core and dwxgmac2_core.
Do the rework of existing function & callers first and add the new bits 
in another patch in the patch series.

Unfortunately, it's hard to catch copy-paste like this from other files 
when not very familiar with the driver.


-- 
 i.


