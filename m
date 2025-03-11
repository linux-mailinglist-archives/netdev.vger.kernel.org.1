Return-Path: <netdev+bounces-173738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25737A5B892
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 06:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD52B1890C0B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 05:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E61EB1A3;
	Tue, 11 Mar 2025 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPNJQ9WO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094BF320F;
	Tue, 11 Mar 2025 05:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741671230; cv=none; b=XZiwXdRMdgkl9RmbpszxDZYYA/DovCi+EtcRwvBm2FY44vezRSDYQ4ZD/LfMUduh25riE4PXml9k1n/6t45un3bfXVkdeL6dAn3eg9csE8NTx9zMkQIeNmMkv/e0Roov7e1fVdjviNLCJxw1qZYgbAjwVJZ345p44DQ8ciTQ08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741671230; c=relaxed/simple;
	bh=DLYuGmG8iFWf5LcT050MwmMyWf6njd/yrSqW870b0NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kq+7V+qIMUaOck/6JqMh6gwNSgTnfnCXlIw+JPCjIwPWbgewxrOXmmYf3sfCXJuwRq5KG5ICpYUA8YW+Kq6UoAIpOi3UFfZJF7TNARjiS/fKgDsBIU9lhMB8SyCUlyeB/Ce8Lxuoz/3QTzjy7dfylP/ciieI0nzoJTxf/ejZQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPNJQ9WO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741671229; x=1773207229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DLYuGmG8iFWf5LcT050MwmMyWf6njd/yrSqW870b0NQ=;
  b=OPNJQ9WO6owtRiG51u+pD9WpnMUnZXJcfsF0Hk+kBgMbWLk+TX6xHMbJ
   OHZwngz3pK/euluvYvI2LYYlDfBuFsDg20l9BTlkrQc7agvabwmp1jnJW
   K5evkPWdt6RQRkXCQ/y0FFDRTUHZ7qN7Wyc1bQn80brjeAUPwGX0dHzxm
   Iq0SvZgtvTpKvfIrGwoBD3Ji9owwXECjPC9lRJ7WopeZN4MY8ugcnbkBR
   I1W0E4gjLhdl9eE9RYJpqs4h3G06mTBbqrGivQF90Pjd+rSPGuOrc6U/4
   apk5PIuTFsK9wx8ru41YAx0Sh7+OroLMGufMotJwHLDOJFBgmhl5bu2Yx
   g==;
X-CSE-ConnectionGUID: IfEg6M00RiGDIwGV+PMVHg==
X-CSE-MsgGUID: luwnjhpdRSaWxN3gEvg08g==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42602730"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="42602730"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 22:33:47 -0700
X-CSE-ConnectionGUID: CWULG/1UQUuYYhAiVQ7Zew==
X-CSE-MsgGUID: nO6dDApWTfWOLHIaR7SBuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="143395086"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.21.123]) ([10.247.21.123])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 22:33:44 -0700
Message-ID: <3bc2cc11-3a87-479e-a0e0-c593e3214540@linux.intel.com>
Date: Tue, 11 Mar 2025 13:33:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] stmmac: intel: Fix warning message for
 return value in intel_tsn_lane_is_available()
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250310050835.808870-1-yong.liang.choong@linux.intel.com>
 <20250310152014.1d593255@kmaincent-XPS-13-7390>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <20250310152014.1d593255@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/2025 10:20 pm, Kory Maincent wrote:
> On Mon, 10 Mar 2025 13:08:35 +0800
> Choong Yong Liang <yong.liang.choong@linux.intel.com> wrote:
> 
>> Fix the warning "warn: missing error code? 'ret'" in the
>> intel_tsn_lane_is_available() function.
>>
>> The function now returns 0 to indicate that a TSN lane was found and
>> returns -EINVAL when it is not found.
>>
>> Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the
>> interface mode")
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> 
> This patch is a fix it should go net instead net-next.
> Could you resend the patch with net prefix?
> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> Thank you!

Hi Kory,

Thank you for your feedback. I understand that the patch is a fix. However, 
since the code is not yet in the 'net' tree, we are unable to apply the fix 
there.

I'm not sure if there is another way to handle this fix other than sending 
it to the 'net-next' tree. I would appreciate any guidance you might have 
on this matter.

