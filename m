Return-Path: <netdev+bounces-163323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6669A29EB8
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34E118891FB
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D423B1339A4;
	Thu,  6 Feb 2025 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XeEVF0C1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175F26ACD;
	Thu,  6 Feb 2025 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808537; cv=none; b=o5vaDFPD+enILM7ipJJT1HGx1C9/zwsSKL/mijIwjpfCWcmxarRtPGj1iigqB4tqRUhDLXbLwr94jv8TXEYZT7yfAfmfN7geqIZIKt0k9IABveTYFm+Ax4uaT4/3QOozHAvb8BPf8C0Mziq17NtPNDxNbAzz84Yf3toDGqxkC1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808537; c=relaxed/simple;
	bh=uEkC8AyPD4Fb3fQjLKAq4+ZamiFbVbnCIjXewv18gyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKbw4i/FtE4YnZPeUFFBfSEywgxFxaHCCkgl/h72G82V6RwyAtZtG5Piw3rm6az2HbDpmZ0LtztWyan/noJz3O/DX8SfFUNC9/hkaS8qzkCoN2y5wVzO63glzguEbmgejkGyjjQl3LwVQFhkI+mRnI3pubF7CSPoU9AEIo+mB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XeEVF0C1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738808537; x=1770344537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uEkC8AyPD4Fb3fQjLKAq4+ZamiFbVbnCIjXewv18gyk=;
  b=XeEVF0C1S/BPHQZUco4tFg/3VhBOlZIux958+ffj6Iz/ihFDVWm6vAiT
   6/iaooUqL6xpNmriQ5W4RS6TdsrjB7R9/cqrbg1lTSdygzwOa/fufn1P/
   1n39IHUp75Skju+8EOM0wA6POScvbdyay9HKolecPv1ThZKTxM8eHVuSn
   0iX+p5iP09g1wGDAY4L8uQ+JWvdb3KCFo3bgrwXlg+cbsMJOfOVFom3Q0
   eLJIGfCFMfEF13mh5hKQgZTEMlXPJYJklQ88u2Omc0WLEMnRJHVUJ4pz3
   oUl8gdh4YkUwFSnR5UkUEhJRjrLCtM4AblNo1dIXg12VtoGQFMvdO1Yeq
   Q==;
X-CSE-ConnectionGUID: i+DrsVpESDuqpJv1yelidg==
X-CSE-MsgGUID: oLOyNbuYRmiRwEJzf8mXcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39096045"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="39096045"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:22:16 -0800
X-CSE-ConnectionGUID: W6Q6U9DXR1edt5B9hcX8PA==
X-CSE-MsgGUID: tg8iji2aSfKqHi2AdolNjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="141957433"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.114.122]) ([10.247.114.122])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:22:07 -0800
Message-ID: <f272cb2a-1167-4e34-9209-ffdbbb107bdd@linux.intel.com>
Date: Thu, 6 Feb 2025 10:22:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/7] stmmac: intel: configure SerDes according
 to the interface mode
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
 Andrew Halaney <ahalaney@redhat.com>, Serge Semin <fancer.lancer@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
 <20250204061020.1199124-5-yong.liang.choong@linux.intel.com>
 <Z6IDWiRF73sdVWob@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <Z6IDWiRF73sdVWob@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/2025 8:08 pm, Russell King (Oracle) wrote:
> On Tue, Feb 04, 2025 at 02:10:17PM +0800, Choong Yong Liang wrote:
>> +	int (*config_serdes)(struct net_device *ndev,
>> +			     void *priv,
>> +			     phy_interface_t interface);
> 
> Since you call this from phylink's mac_finish() method, I would much
> rather the call down into platform code was also called the same so
> we don't end up with a proliferation of methods called from that
> function. As such, please also arrange for it to pass the AN mode as
> well.
> 
> Thanks.
> 

Hi Russell,

Thank you for your feedback on the patch. Based on your suggestion, I have 
updated the code to align with the mac_finish() method and included the AN 
mode as well. The updated function signature is as follows:

int (*mac_finish)(struct net_device *ndev,
                   void *priv,
                   unsigned int mode,
                   phy_interface_t interface);

Could you please confirm if this meets your expectations, or if there are 
any further adjustments needed?

