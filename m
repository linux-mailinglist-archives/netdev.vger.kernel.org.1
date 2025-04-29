Return-Path: <netdev+bounces-186647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4155FAA00AB
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8317B174ABC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 03:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B721CAA82;
	Tue, 29 Apr 2025 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHcwOhXi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374E15A858;
	Tue, 29 Apr 2025 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897948; cv=none; b=pYBjSPMgOEtojU8OY/PB6AlP9Tg6fhj+l8oeQOJj+gFMSQvPWVt2LCTyXyW6i97ZkH6Lb6bSrHeTeGvY5uUIdR7JH2SG9RYJFGWl81R6B9gutuc3vQ0bt3Kl8wECNU+CRGQ3tCDfM7KjSBPBbPRZ6PX82zTEcb/HH0V2C06T9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897948; c=relaxed/simple;
	bh=owNWzXdUcegkxkFjQ0gPNXIRkW9IOHpRjwUEXrmsCxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FI/D8RqQkqAIo7AF+FTMD7YKim07WYuNF+0I10z31mLynRlUsk4mbOScB/4d0OjRG8lnuTbJQxEJwTgeHxg1zKxOj8104JJJFlH4+t1LJmMfAx+5oofCUA7d+RX9neCEMAmRlAP42y2zKbH3JYoe9eskZ/xmalgWvHdsCo7LRCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHcwOhXi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745897947; x=1777433947;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=owNWzXdUcegkxkFjQ0gPNXIRkW9IOHpRjwUEXrmsCxc=;
  b=EHcwOhXiygM7uSFCworlWmAgXFzwhc7AzrP4Gj8DfjICQ3pR/SEBgH5n
   dr4qhzPkUavaobMa5hHcWwjgxTOWrQBzEEarUcHfI6C8h10T7P0B/mu75
   AHUFuc9X1LMvdZ3ZmglgS0nZQ2cA0woefOczWDFmEsuuhW9AqtlH6Nk7q
   VgRl+detKEmTIhgiEcKXi0m1zE23yNfWqa/8ljjeu0+q7X0hCe6Og61Ia
   zrSAlMTxqaa+K25AN4w9Hf6yEInykcJUZeYBOEKLliWgeCWjRcox6TFAt
   1ak5c1uoojGv3sbTyIEq2O9I89Svzgl6Dr551c2tM6swwEP9+UiRO4XhW
   g==;
X-CSE-ConnectionGUID: xmtHPIpeSVO2s9p8YEt0uQ==
X-CSE-MsgGUID: 2jHNgQ28SqKPL0nnG4eVRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58873402"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="58873402"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 20:39:06 -0700
X-CSE-ConnectionGUID: g3HCxq1rSh+NJOTwvWNEvA==
X-CSE-MsgGUID: bSMXPni1SCitphGWxU3Rng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="156932063"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.22.166]) ([10.247.22.166])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 20:39:04 -0700
Message-ID: <b6852273-314c-46a3-9388-3039a69b3ed8@linux.intel.com>
Date: Tue, 29 Apr 2025 11:39:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 6/8] igc: add preemptible
 queue support in taprio
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Choong, Chwee Lin" <chwee.lin.choong@intel.com>
References: <20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com>
 <20250428060225.1306986-7-faizal.abdul.rahim@linux.intel.com>
 <SJ0PR11MB5866B4EC7D136421FCF6BBC2E5812@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <SJ0PR11MB5866B4EC7D136421FCF6BBC2E5812@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/4/2025 5:11 pm, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Faizal Rahim
>> Sent: Monday, April 28, 2025 8:02 AM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
>> David S . Miller <davem@davemloft.net>; Eric Dumazet
>> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>> <pabeni@redhat.com>; Vladimir Oltean <vladimir.oltean@nxp.com>
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Faizal Rahim <faizal.abdul.rahim@linux.intel.com>;
>> Choong, Chwee Lin <chwee.lin.choong@intel.com>
>> Subject: [Intel-wired-lan] [PATCH iwl-next v1 6/8] igc: add preemptible queue
>> support in taprio
>>
>> igc already supports enabling MAC Merge for FPE. This patch adds support for
>> preemptible queues in taprio.
>>
> Can you mention what "FPE" stands for (e.g., Frame Preemption) for better understanding? Everything else is fine for me.
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 

Will update. Thanks.

