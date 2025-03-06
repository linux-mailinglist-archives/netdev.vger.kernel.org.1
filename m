Return-Path: <netdev+bounces-172452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F146A54B41
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76CD1721EA
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A34201005;
	Thu,  6 Mar 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkGS9KPG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64F1F5FD;
	Thu,  6 Mar 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265778; cv=none; b=bT6ayd0rLI2MKXLWyncItDJrm+0uvjB4zSQL9/ycxXWP9vItmq4Doug9wwLYZ1XzhAxdvvhuOCLwoh2Vitte/IYo/rlbEgtg0homQpYxp3GSS2Og9vOHobjnxV5aG8WLBBAWhz4xIFXD2mTXOqd82nu7lsytRqBmsPHxQ6AVBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265778; c=relaxed/simple;
	bh=9MvqC8ylQ6fQhKk8+WzF1GyYLgjYDw11/grvnNkl7YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0Z0mR/ZPdSUNstBo1urwP+QTIbpQ420Xvyc6zXJbIT75mjFIN4v/NaSD4ZP4mDczIcVeSkRFoscPmUCtVB3xqk5iXoND5WlaWhF3YZzQUjMmsEz+lDy0QhbqsYYghR4lHGjx0wvlcgEPP59yGmiCmlmRWjXMVSqgPQUl68d4n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkGS9KPG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741265777; x=1772801777;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9MvqC8ylQ6fQhKk8+WzF1GyYLgjYDw11/grvnNkl7YI=;
  b=YkGS9KPGJEj5L8AKuEil9/dec2W8/vrKlVBzcx35Mjpauq7LQVriOket
   UFzm3uW2KRFsavALsmV2lvwH5jP05JZYMtjXaLuxadLYnCWikiY0+grxO
   UXPhSldBhXSGlEKK55FF47NeH5FTUH5XKRTVEzXgxdTi5e7XSsimPVaQ9
   JYPTpdqYBwPgo9Orxsc9exYDdHXkpitA1kQtpI0PnXc3czY13wNT9FBds
   B6QZab4+9rg6G00VSo6UITvOhbXABoP/bfVzyJaSRSm9dSzNPMLNmWTaV
   6IhjHUXxvJF4xuc9kdnSYiqC3kT6RW9j2lZnlw+8lpDN/8RcOqyHIoLUO
   A==;
X-CSE-ConnectionGUID: DI0nW+UsRRee2JU5r19tLQ==
X-CSE-MsgGUID: g9o+OhD9QJCPoApFnJqhBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42405062"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42405062"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 04:56:15 -0800
X-CSE-ConnectionGUID: L3j3voWzQZmgIzwPQH5Lpw==
X-CSE-MsgGUID: ExOupyuzT1OX+QCLAmrCfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149940256"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.67.95]) ([10.247.67.95])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 04:56:07 -0800
Message-ID: <d7c0094e-7fd3-4113-8d00-91b7a83ffd1f@linux.intel.com>
Date: Thu, 6 Mar 2025 20:56:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 5/6] net: stmmac: configure SerDes according
 to the interface mode
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <CAHp75VeOKbAsvSuf5+VQnGFmUcN92TNnR2eF1+70h3PjaMdMqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/3/2025 5:05 pm, Andy Shevchenko wrote:
> On Thu, Mar 6, 2025 at 10:39 AM Choong Yong Liang
> <yong.liang.choong@linux.intel.com> wrote:
>> On 6/3/2025 3:15 pm, Andy Shevchenko wrote:
>>> Thu, Feb 27, 2025 at 08:15:21PM +0800, Choong Yong Liang kirjoitti:
> ...
> 
>>>> config DWMAC_INTEL
>>>>       default X86
>>>>       depends on X86 && STMMAC_ETH && PCI
>>>>       depends on COMMON_CLK
>>>> +    depends on ACPI
>>> Stray and unexplained change. Please, fix it. We don't need the dependencies
>>> which are not realised in the compile time.
>> The dependency on ACPI is necessary because the intel_pmc_ipc.h header
>> relies on ACPI functionality to interact with the Intel PMC.
> So, that header has to be fixed as ACPI here is really unneeded
> dependency for the cases when somebody (for whatever reasons) want to
> build a kernel without ACPI support but with the driver enabled for
> let's say PCI device.
> 
> 
> -- With Best Regards, Andy Shevchenko

Hi Andy,

Thank you for your feedback, Andy.
I appreciate your insights regarding the ACPI dependency.
The intel_pmc_ipc.h header is under the ownership of David E Box, who 
focuses on the platform code, while my focus is on the netdev.

Hi David,

if you could kindly look into making the ACPI dependency optional in the 
intel_pmc_ipc.h header, it would be greatly appreciated.
I am more than willing to provide any support necessary to ensure a smooth 
resolution.

This patch series has already been accepted, but we recognize the 
importance of addressing this issue in the next patch series for upstream.
Our goal is to ensure that the driver can be compiled and function 
correctly in both ACPI and non-ACPI environments.

Thank you both for your understanding and collaboration.

