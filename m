Return-Path: <netdev+bounces-163885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD9EA2BF16
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AE03A20A2
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE61D5AD8;
	Fri,  7 Feb 2025 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZWljDPb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B716C684;
	Fri,  7 Feb 2025 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920044; cv=none; b=Um6CpGgH1ecv/1q4GiLx4oX68QJd3okXx6EnQ+o2v+is9DIbAjiSwP34m2mEqh68fZQndjJiBvgZz//bDsQFdJoTS3iE6XYPeTW1rwMeqwqOmT+3vW20tHG7fR3xjfzTayaCzWeiFujUHf5xCiBnwOcm2VvohqJWIU00ZzoXSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920044; c=relaxed/simple;
	bh=hA2SG/by2VlZkg0k+rBAIateDa8Wr9F6Pl3v/Hw6QSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SubGo9z5pVQ5wUQ+ChjUmebZtagaSlMmfBMZHrHxIJ1M2vnZo4L8O3HtlgtDjXh8rM/up5LS1RSfxVzWOkjMAwhyvXFDilGCLA6RnQj9w3b+qoNu1h6FMFrwawhTyV4l18iNyRsKumlINSK6gCqP8NDM4G8tRZ58gXukiTjML1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZWljDPb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738920042; x=1770456042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hA2SG/by2VlZkg0k+rBAIateDa8Wr9F6Pl3v/Hw6QSU=;
  b=fZWljDPb6Dt6BamXlxUgRg/BGeXNvgwfCEJrECIl1AXkmStsvGBxXdd6
   KiBxMDtqf9ELAwe1i3PNFA3SNtfNmIzaQqSSgPrORD+dsHDCSyHT1Zn72
   JvlDEBWozaeJIZwr3xE0ARQdDERWMQwCBmVejzG3Oy1PSqvuq19DOtQhA
   RVjFdS7fgoyNQ1TI3+SEny5dqfXkvTMv8zT0n3tgO/G8XN4rxdauo7zhx
   S/cWcvohZKvHGC7YtNGEzEKwR4N2hEHyudg1KuigqRKFhQ6IaAyHf/JS1
   71oGDga8WKNrWhqV11+sDQ3MDKNj9eovKdIsekPibuJSy8vQ1qW1mtKkA
   g==;
X-CSE-ConnectionGUID: Sfb1Be4gSV6/KJUHXJ31Vw==
X-CSE-MsgGUID: qX5FiCzlRuCILTKoPOQATg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39428950"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="39428950"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 01:20:40 -0800
X-CSE-ConnectionGUID: Rs/q4v6kTrSfo8mlMCbvMQ==
X-CSE-MsgGUID: 4DBwnz/7TVqAchVWKhRZfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148692076"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.39.73]) ([10.247.39.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 01:20:32 -0800
Message-ID: <564ede5d-9f53-40be-9305-63f63b384e15@linux.intel.com>
Date: Fri, 7 Feb 2025 17:20:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/7] net: pcs: xpcs: re-initiate clause 37
 Auto-negotiation
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 David E Box <david.e.box@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com>
 <20250206131859.2960543-3-yong.liang.choong@linux.intel.com>
 <Z6TVmdCZeWerAZKP@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <Z6TVmdCZeWerAZKP@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/2/2025 11:30 pm, Russell King (Oracle) wrote:
> On Thu, Feb 06, 2025 at 09:18:54PM +0800, Choong Yong Liang wrote:
>> The xpcs_switch_interface_mode function was introduced to handle
>> interface switching.
>>
>> According to the XPCS datasheet, a soft reset is required to initiate
>> Clause 37 auto-negotiation when the XPCS switches interface modes.
> 
> Hmm. Given that description, taking it literally, claus 37
> auto-negotiation is 1000BASE-X, not Cisco SGMII (which isn't an IEEE
> 802.3 standard.) Are you absolutely sure that this applies to Cisco
> SGMII?
> 
Hi Russell,

Yes, you are correct that Clause 37 auto-negotiation is for 1000BASE-X. 
However, I do not believe it applies to Cisco SGMII. The XPCS implements 
Clause 37 auto-negotiation for both 1000BASE-X and SGMII.

> If the reset is required when switching to SGMII, should it be done
> before or after configuring the XPCS for SGMII?
> 
A soft reset is required before configuring the XPCS for SGMII. Based on 
the existing XPCS handling in the initial state, the xpcs_create() function 
will be called, and then xpcs->need_reset will be set to true. Later on, 
phylink_major_config() will call xpcs_pre_config() to perform the 
xpcs_soft_reset(), and then it will continue with xpcs_config().

I apologize for missing this patch: 
https://patchwork.kernel.org/project/netdevbpf/patch/E1svfMA-005ZI3-Va@rmk-PC.armlinux.org.uk/

I think I should move xpcs_switch_interface_mode() to xpcs_pre_config() and 
just update xpcs->need_reset instead of implementing my own method for 
calling xpcs_soft_reset().

> Also, if the reset is required, what happens if we're already using
> SGMII, but AN has been disabled temporarily and is then re-enabled?
> Is a reset required?
> 
Good point. I cannot find this scenario in the datasheet. Please allow me 
some time to test this scenario. I will update you with the results.

> What about 1000BASE-X when AN is enabled or disabled and then switching
> to SGMII?
> 
According to the datasheet, a soft reset is required.

>> +static int xpcs_switch_to_aneg_c37_sgmii(const struct dw_xpcs_compat *compat,
>> +					 struct dw_xpcs *xpcs,
>> +					 unsigned int neg_mode)
>> +{
>> +	bool an_c37_enabled;
>> +	int ret, mdio_ctrl;
>> +
>> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
>> +		mdio_ctrl = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
>> +		if (mdio_ctrl < 0)
>> +			return mdio_ctrl;
>> +
>> +		an_c37_enabled = mdio_ctrl & BMCR_ANENABLE;
>> +		if (!an_c37_enabled) {
> 
> I don't think that we need "an_c37_enabled" here, I think simply:
> 
> 		if (!(mdio_ctrl & BMCR_ANENABLE)) {
> 
> would be sufficient.
> 
>> +			//Perform soft reset to initiate C37 auto-negotiation
>> +			ret = xpcs_soft_reset(xpcs, compat);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
>> +	return 0;
> 
> I'm also wondering (as above) whether this soft reset needs to happen
> _after_ xpcs_config_aneg_c37_sgmii() has done its work - this function
> temporarily disables AN while it's doing its work.
> 
Based on the programming sequence in the datasheet, it is not necessary to 
perform a soft reset after xpcs_config_aneg_c37_sgmii() has completed its work.

> I'm also wondering whether AN being disabled is really a deciding
> factor (e.g. when switching from 1000BASE-X AN-enabled to SGMII, is a
> reset required?)
> 

Thank you for pointing this out. The datasheet only mentions performing a 
soft reset when switching to the 1000BASE-X and SGMII interfaces, and it 
does not specify whether AN needs to be enabled or disabled. I thought 
adding a check would reduce the calls to the soft reset. However, I did not 
consider the scenario of switching from 1000BASE-X with AN enabled to SGMII 
with AN enabled. This scenario might cause regression. I will remove all 
the checks and just perform a soft reset when switching to the SGMII interface.

