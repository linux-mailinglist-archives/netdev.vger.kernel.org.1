Return-Path: <netdev+bounces-191380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619E6ABB511
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAA43A1DFE
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 06:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3474F24469B;
	Mon, 19 May 2025 06:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDGSci3L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02524468E;
	Mon, 19 May 2025 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747636065; cv=none; b=SODsbg3MWr6CoP0xG7FIOan7rt8a+p2D1vviFwXIny61ZhQlzxm3urwimnjtxXF5pZHVaJxLaDDexOk+72VVWpEwTDzl3hFfVCOSegzbzLq+M6h5OI+v+8YQfxuNTDxpIDcFtdOdV23ODTD6CjVkU6kY/h2Z57fY8HupR7rPY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747636065; c=relaxed/simple;
	bh=05be7fLfzW+Lkh9/B6CDCkEvJrnVcJV+48VP51XW+4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQOJncN4Le6bj5892TZPut7AR2WVyhMXLbnfLVoRv2HqXGaccO23pH74/qPw9btzEL/wifvI4FKpcXrQ66e+nBpuQ9H+eufQiPlMFeftPiPo+JJxQqtANdB4gJYfoep5Qeou1C3bg7OdrpXW7nsQOtXqiYxWOoLHDelR9klWj34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDGSci3L; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747636064; x=1779172064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=05be7fLfzW+Lkh9/B6CDCkEvJrnVcJV+48VP51XW+4I=;
  b=dDGSci3L0NxJ6+0HS5/VT4r0p3H0vHaH6SGvrp6ZHtgzzgqKcivfo4Yc
   rDkZmL4T9EsM0Yp5/5SWbkjiOZ4HqqsZkv+RftgT6VKdkZKLADRpPg17l
   hra4dMx9fM35Bkr14/m5VhczfjgnLnYlB5vYCyO4MfG754dHG69FnSNUI
   MxPE3JcA+ScjOIR7xgBPa682cuRWI5/aNLsgpPHVrYC1d+jRkb+/WI+yy
   URLQP/64uJXt5i7viZNjUTy9NklF1D7a2oljkm+Nb0BDF0TxCxuIvR/WW
   0HqdFTPSWzNnoRwUWXkU0lHFXpBj5whuTietw7lry1EIn2pvmmaBTE4rC
   A==;
X-CSE-ConnectionGUID: 3W948e2hQwSCWUOv9wUs0g==
X-CSE-MsgGUID: ZoSeOeUKRnSwZVf+RXL+Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49503810"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49503810"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 23:27:42 -0700
X-CSE-ConnectionGUID: UK5odDNjSF+5FI6KHpYkxA==
X-CSE-MsgGUID: KP5sPoGBQVKkqbLHSlAehg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="170313674"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.73.217]) ([10.247.73.217])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 23:27:38 -0700
Message-ID: <12093d3c-ca0a-46fd-950e-6af1448ee079@linux.intel.com>
Date: Mon, 19 May 2025 14:27:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 8/8] igc: SW pad preemptible frames for
 correct mCRC calculation
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Chwee-Lin Choong <chwee.lin.choong@intel.com>
References: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
 <20250514042945.2685273-9-faizal.abdul.rahim@linux.intel.com>
 <20250516094336.GH1898636@horms.kernel.org>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250516094336.GH1898636@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/5/2025 5:43 pm, Simon Horman wrote:
> On Wed, May 14, 2025 at 12:29:45AM -0400, Faizal Rahim wrote:
>> From: Chwee-Lin Choong <chwee.lin.choong@intel.com>
>>
>> A hardware-padded frame transmitted from the preemptible queue
>> results in an incorrect mCRC computation by hardware, as the
>> padding bytes are not included in the mCRC calculation.
>>
>> To address this, manually pad frames in preemptible queues to a
>> minimum length of 60 bytes using skb_padto() before transmission.
>> This ensures that the hardware includes the padding bytes in the
>> mCRC computation, producing a correct mCRC value.
>>
>> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> Hi Faizal, all,
> 
> Perhaps it would be best to shuffle this patch within this series
> so that it appears before the patches that add pre-emption support.
> That way, when the are added the bug isn't present.
> 

Makes sense, will update. Thanks!

