Return-Path: <netdev+bounces-163324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B81A29EBB
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A62167B56
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74674126C13;
	Thu,  6 Feb 2025 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/KZ4PMq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104D26ACD;
	Thu,  6 Feb 2025 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808608; cv=none; b=uaVJlB4JvoCh2p1Vexgs8ml/I/3nqmLC9uUKTJRLY4lacuW3ZKtm1L+ko9M2A2Xaw2ubeH0hRH2MFr63USNLFqaQ89EOMXo5HUsQSNPdBb9EhzUWz13RRxPUvG5R3y0ymQJhglB7pRvIsT5uFtWfQavg/af78mhkhvqheFUe5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808608; c=relaxed/simple;
	bh=MX/9vrVMWFYRt4Rmji6I71xtTK2XSPOEL24m4oemfv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4qjKNcTvi6GTMTE23kOgkOAWWrdd7R8gdQmnFxbu9197e189U2TR1BsC7+CLvWt3W9GzYLwvBnPcNDsvkJXpDABzb2GBV9NW9TtrSdMxPQ6H3wKoNZIiaxl+zqMJrUSW3yA9klRS0u3rnz+Cgb+8P5ozhxsIaYWuMqVOk1/fxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/KZ4PMq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738808607; x=1770344607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MX/9vrVMWFYRt4Rmji6I71xtTK2XSPOEL24m4oemfv0=;
  b=S/KZ4PMq7WF/gYuI8RXuhLzQEpKo13v+7CihM5xA7zhEVJRgiMrVfFM5
   PT9934gj3/jgcMOt/PR3HJ70ZpTxW+1V+2l4iu4znPs9a4HoziCHmgMo3
   RtP1l/5a9v8gJDsZSKlqNPWGav8zzWzE2l5/rj4ccx4DvMqyJJjFuayl0
   ccslGIb1xkPuMdUS37gyvtJdcoq0Gkos2tWR5WTuQAvgyFE7aHiPyDcDe
   ooelGd8SwYM9D5o9/oqQh4MUJWCssUNqKcu6rWyR2fhL7kFWVjO+Qt+sS
   cOAW1a3M+Ie3JT1BpI8HqAPMDgRsmLbOZf6QAIQM3mR/dkVTlvdWBLHLS
   Q==;
X-CSE-ConnectionGUID: xJ/LPEodTbCTFW3QhUGQlA==
X-CSE-MsgGUID: tE7084xZSuWPJJxm/8+jEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56945591"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="56945591"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:23:26 -0800
X-CSE-ConnectionGUID: 9N2QkdZTQnGEp6akn4nL/A==
X-CSE-MsgGUID: E5VLiOZUS+ykXC3zAo3hKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="110858842"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.114.122]) ([10.247.114.122])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:23:18 -0800
Message-ID: <603921dc-4cc0-4bc6-960a-00ce6f8dfd5a@linux.intel.com>
Date: Thu, 6 Feb 2025 10:23:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/7] stmmac: intel: configure SerDes according
 to the interface mode
To: Simon Horman <horms@kernel.org>
Cc: Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
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
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Halaney <ahalaney@redhat.com>, Serge Semin <fancer.lancer@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
 <20250204061020.1199124-5-yong.liang.choong@linux.intel.com>
 <20250204181339.GM234677@kernel.org>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <20250204181339.GM234677@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/2/2025 2:13 am, Simon Horman wrote:
>> +static int intel_config_serdes(struct net_device *ndev,
>> +			       void *intel_data,
>> +			       phy_interface_t interface)
>> +{
>> +	struct intel_priv_data *intel_priv = intel_data;
>> +	struct stmmac_priv *priv = netdev_priv(ndev);
>> +	int ret = 0;
>> +
>> +	if (!intel_tsn_lane_is_available(ndev, intel_priv)) {
>> +		netdev_info(priv->dev,
>> +			    "No TSN lane available to set the registers.\n");
>> +		goto pmc_read_error;
>> +	}
>> +
>> +	if (intel_priv->pid_modphy == PID_MODPHY1) {
>> +		if (interface == PHY_INTERFACE_MODE_2500BASEX) {
>> +			ret = intel_set_reg_access(pid_modphy1_2p5g_regs,
>> +						   ARRAY_SIZE(pid_modphy1_2p5g_regs));
>> +		} else {
>> +			ret = intel_set_reg_access(pid_modphy1_1g_regs,
>> +						   ARRAY_SIZE(pid_modphy1_1g_regs));
>> +		}
>> +	} else {
>> +		if (interface == PHY_INTERFACE_MODE_2500BASEX) {
>> +			ret = intel_set_reg_access(pid_modphy3_2p5g_regs,
>> +						   ARRAY_SIZE(pid_modphy3_2p5g_regs));
>> +		} else {
>> +			ret = intel_set_reg_access(pid_modphy3_1g_regs,
>> +						   ARRAY_SIZE(pid_modphy3_1g_regs));
>> +		}
>> +	}
>> +
>> +	priv->plat->phy_interface = interface;
>> +
>> +	if (ret < 0)
>> +		goto pmc_read_error;
> 
> Perhaps this is an artifact of earlier refactoring,
> but the condition above seems to be without meaning
> as in either case the code goes directly to pmc_read_error.
> 
>> +
>> +pmc_read_error:
>> +	intel_serdes_powerdown(ndev, intel_priv);
>> +	intel_serdes_powerup(ndev, intel_priv);
>> +
>> +	return ret;
>> +}
>> +
>>   static void common_default_data(struct plat_stmmacenet_data *plat)
>>   {
>>   	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
> 
> ...
> 

Hi Simon,

You are right.
I will perform the cleanup on the code and submit the next version.

Thank you for your feedback.

