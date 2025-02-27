Return-Path: <netdev+bounces-170193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67997A47BD5
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11E3164F08
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF722B8D1;
	Thu, 27 Feb 2025 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPNjd8QA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CE1DDD1;
	Thu, 27 Feb 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655071; cv=none; b=sLiprThhxp/HKSakvwFOR1XNzlBP9iEehm1Cozj2xPhnxHtZ5ar6o4bSZGLtiUcjUSrNByuVYsv2WXLcX5i9DqwmvbJSdVVVpq6mVCrvyxD+IEfRPvAxQHA0ZIeKQYO2DffA+vCI90V8EC7Rw+LuFeh1wMFcPetzbUKHoDDRDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655071; c=relaxed/simple;
	bh=CNhFV9T14sh7OY2SRFlpy7R8+gM04CqgJ0xYvF9HFpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdTIOCSbsRouaWTTTkkv4YyARemOy81YHCM8Ibpgr7OSw0CXP6uWbhIRa0FK7F2B42S5Tb4qdd9np2WFimudh27tJ4k17eXJJCHWVp05zPCu2SEe/LH3cwyDcXLjUiDn6S+NYragqIFRvJtjrjVo8gguc+KBau5+kJe7+i6zkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPNjd8QA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740655070; x=1772191070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CNhFV9T14sh7OY2SRFlpy7R8+gM04CqgJ0xYvF9HFpo=;
  b=jPNjd8QA/cmsBgf2MsfeALyTkg6vEvSV9xzSxwahOdKFiEoNAFU5EwxT
   RDipRbNKcP5tiS2Z1eiaNWjx6pcRT/610pI+TdZBKbiq+dD3FV+UdYGyD
   1FfIZXXOxsi1SzYujA8ynJ5AOY5GFj4xw7tQylVqSIvMfFefdv824ZfUT
   ZVN84HkLX683KbumMMR8DwJTqi8XKGTJtJ8jQwdmF6astiQEGBinMJAFq
   G8L+HlWlPs5YqNL0ibnX8YIjbb3yn839nVa16gChDLfVUMiCm0fELcK2L
   g5i1ABUxm37lv9hxZhx5fzyAAxAPFFs20dxQ/Kv+3Obkak/bWApYT/5Bw
   w==;
X-CSE-ConnectionGUID: bPkUtZsIS4SM4zlGlNy5Bw==
X-CSE-MsgGUID: DO6GtJHJQheOZQrZSPgFuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="58955498"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="58955498"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:17:49 -0800
X-CSE-ConnectionGUID: 3Tb9u1sUQPaKicuPXGkj2w==
X-CSE-MsgGUID: 45DyLiKXRPyvMBlpNWZcDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117172315"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.81.210]) ([10.247.81.210])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:17:41 -0800
Message-ID: <1ff2fcac-d9d5-4c70-a101-f7026b50646a@linux.intel.com>
Date: Thu, 27 Feb 2025 19:17:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 1/6] net: phylink: use pl->link_interface in
 phylink_expects_phy()
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
References: <20250226074837.1679988-1-yong.liang.choong@linux.intel.com>
 <20250226074837.1679988-2-yong.liang.choong@linux.intel.com>
 <Z780cM9bejxhzTXO@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <Z780cM9bejxhzTXO@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/2/2025 11:34 pm, Russell King (Oracle) wrote:
> On Wed, Feb 26, 2025 at 03:48:32PM +0800, Choong Yong Liang wrote:
>> The phylink_expects_phy() function allows MAC drivers to check if they are
>> expecting a PHY to attach. The checking condition in phylink_expects_phy()
>> aims to achieve the same result as the checking condition in
>> phylink_attach_phy().
>>
>> However, the checking condition in phylink_expects_phy() uses
>> pl->link_config.interface, while phylink_attach_phy() uses
>> pl->link_interface.
>>
>> Initially, both pl->link_interface and pl->link_config.interface are set
>> to SGMII, and pl->cfg_link_an_mode is set to MLO_AN_INBAND.
>>
>> When the interface switches from SGMII to 2500BASE-X,
>> pl->link_config.interface is updated by phylink_major_config().
>> At this point, pl->cfg_link_an_mode remains MLO_AN_INBAND, and
>> pl->link_config.interface is set to 2500BASE-X.
>> Subsequently, when the STMMAC link goes down and comes up again,
>> it is blocked by phylink_expects_phy().
> 
> I thought we ascertained that it's not "link goes down" but when the
> interface is taken down administratively. "Link goes down" to most
> people mean an event such as the network cable being unplugged.
> Please fix the patch description.
> 
>> Since phylink_expects_phy() and phylink_attach_phy() aim to achieve the
>> same result, phylink_expects_phy() should check pl->link_interface,
>> which never changes, instead of pl->link_config.interface, which is
>> updated by phylink_major_config().
>>
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> 
> With, and *only* with the above fixed:
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thanks!
> 
Thank you for your feedback and clarification. I will update the patch 
description to accurately reflect the administrative interface down scenario.

