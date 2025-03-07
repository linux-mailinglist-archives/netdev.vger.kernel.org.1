Return-Path: <netdev+bounces-172787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F73A55FFB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 06:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB5A3B2E8B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 05:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E13718FDDF;
	Fri,  7 Mar 2025 05:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFnWZVL8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26C1474A9;
	Fri,  7 Mar 2025 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325340; cv=none; b=Wsl31VKqkFqWjgtbUmLo1pdNTqjDVq7BbhwJWP6SUJ2h/rSvRHXRsoMtF/QTA95Zo74V2kX/l9rW+jSa/BGERYndZ7HtpP+WeRS+7+BCM4qBYKWsWTO6QRRULIDug1g2yvsLkG8u8VD3HshOEHKsH7T+bjlJzk7PuyfadYN9CB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325340; c=relaxed/simple;
	bh=E2Y/GlpLCkl4xHcskn4WALbBs9h6FoTrMIP+94YBi9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtcOyFxHfxh8kkwLQYIIEKMEb9//A7jTNNPNP4GUAzOEkI0xqKfhke9tGrfFfOeU2pA0sAxARMnoUBcRXfuQ63dMBEtmqfp54aqZsyGLIbUhZ31bDlW/o02I8yZlZqbmEINK589Oo20B/uVQHFOjD6DhLsgxoWbtsky0oy09iDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFnWZVL8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741325339; x=1772861339;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E2Y/GlpLCkl4xHcskn4WALbBs9h6FoTrMIP+94YBi9M=;
  b=iFnWZVL81DmSExEK3uCbWwDBqjMJlVGdPFTWrFpR7GsWRx7wTLoK/Y1a
   NbS4ZL3yVKub6KPWb+QVtpQEEhergeHr6fhwrUgJs30ZWes+RbXXmk/cD
   BT/bwO53A0kKeNvwHBIIKCVUKTiPPeMdx2ojPAJSfilEXA3XT1CEGB16a
   HpeM55PCrsdAfUvfkRdd0xNVQvM+OrYa2/2sMkvxzjzjCschIUqhyolhr
   L4g6l6BHzl5qxSDRsps65WLqd/h0kuf/VurSps8iOFwuEPxS48lTR3sM5
   YYILdfwbxtmfj5jUPyttzdBGp6A0HnXVuDqqiQaILKOjYsbASrtEFQ1ZR
   A==;
X-CSE-ConnectionGUID: CacmsbaOR3O2TuB02K8KoQ==
X-CSE-MsgGUID: qe48wI+ASjyVVjngUuOOcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46142865"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="46142865"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:28:57 -0800
X-CSE-ConnectionGUID: Gav6l5ujTTC3cGO4QrwZ5w==
X-CSE-MsgGUID: +DtmNiMrS1qMuYKKWLnO6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="124261411"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.53.67]) ([10.247.53.67])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:28:49 -0800
Message-ID: <19b78790-d4d3-45db-9b1f-fbe40f8ed795@linux.intel.com>
Date: Fri, 7 Mar 2025 13:28:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 5/6] net: stmmac: configure SerDes according
 to the interface mode
To: david.e.box@linux.intel.com, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
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
 Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
 <20250227121522.1802832-6-yong.liang.choong@linux.intel.com>
 <Z8lLm9Ze9VAx3cE_@surfacebook.localdomain>
 <601c88fb-8ec8-4866-a45d-f28dea6d9625@linux.intel.com>
 <CAHp75VeOKbAsvSuf5+VQnGFmUcN92TNnR2eF1+70h3PjaMdMqA@mail.gmail.com>
 <d7c0094e-7fd3-4113-8d00-91b7a83ffd1f@linux.intel.com>
 <257769403908de3ac6271059e1febee88654fbdc.camel@linux.intel.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <257769403908de3ac6271059e1febee88654fbdc.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/3/2025 4:52 am, David E. Box wrote:
> On Thu, 2025-03-06 at 20:56 +0800, Choong Yong Liang wrote:
>>
>>
>> On 6/3/2025 5:05 pm, Andy Shevchenko wrote:
>>> On Thu, Mar 6, 2025 at 10:39 AM Choong Yong Liang
>>> <yong.liang.choong@linux.intel.com> wrote:
>>>> On 6/3/2025 3:15 pm, Andy Shevchenko wrote:
>>>>> Thu, Feb 27, 2025 at 08:15:21PM +0800, Choong Yong Liang kirjoitti:
>>> ...
>>>
>>>>>> config DWMAC_INTEL
>>>>>>        default X86
>>>>>>        depends on X86 && STMMAC_ETH && PCI
>>>>>>        depends on COMMON_CLK
>>>>>> +    depends on ACPI
>>>>> Stray and unexplained change. Please, fix it. We don't need the
>>>>> dependencies
>>>>> which are not realised in the compile time.
>>>> The dependency on ACPI is necessary because the intel_pmc_ipc.h header
>>>> relies on ACPI functionality to interact with the Intel PMC.
>>> So, that header has to be fixed as ACPI here is really unneeded
>>> dependency for the cases when somebody (for whatever reasons) want to
>>> build a kernel without ACPI support but with the driver enabled for
>>> let's say PCI device.
>>>
>>>
>>> -- With Best Regards, Andy Shevchenko
>>
>> Hi Andy,
>>
>> Thank you for your feedback, Andy.
>> I appreciate your insights regarding the ACPI dependency.
>> The intel_pmc_ipc.h header is under the ownership of David E Box, who
>> focuses on the platform code, while my focus is on the netdev.
>>
>> Hi David,
>>
>> if you could kindly look into making the ACPI dependency optional in the
>> intel_pmc_ipc.h header, it would be greatly appreciated.
>> I am more than willing to provide any support necessary to ensure a smooth
>> resolution.
> 
> Choong you only need put the function under a #if CONFIG_ACPI block and provide
> an alternative that returns an error when the code is not build. Like this,
> 
> #if CONFIG_ACPI
> static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
> *rbuf)
> {
>     ...
> }
> #else
> static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
> *rbuf) { return -ENODEV; }
> #endif
> 
> David
> 
>>
>> This patch series has already been accepted, but we recognize the
>> importance of addressing this issue in the next patch series for upstream.
>> Our goal is to ensure that the driver can be compiled and function
>> correctly in both ACPI and non-ACPI environments.
>>
>> Thank you both for your understanding and collaboration.
> 
> 
Hi Andy and David,

Thank you for the feedback.

The current ACPI dependency for the config DWMAC_INTEL is necessary, but I 
agree on making it optional.

Implementing the suggestion from David using the "#if CONFIG_ACPI" approach 
would address your concern about users who need to build a kernel without 
ACPI support.

If you are okay with this approach, then I will submit the solution for 
upstream.

