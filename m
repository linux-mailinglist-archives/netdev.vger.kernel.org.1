Return-Path: <netdev+bounces-172045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07BDA5008F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FD33A8C80
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99918230BC6;
	Wed,  5 Mar 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFlfE/O5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CF1E531
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181438; cv=none; b=KmBsX8RMZ+9x2hwmZaqHwNG4V+/Myuh4cRz8JPQbvvu5cf+kQ+P5isGdUeXSWQl5TdQCHEEevYI+vMgKl9/iYozF4CTijDtsvjihH7FoMagDrO6hwz0tN031Gwcmut2DH9RzJUmlchLDZD1vmjp0Wqr+7AL24rIHigsn44fQJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181438; c=relaxed/simple;
	bh=qv6kfjqWgUm1Ww2zop913jEHSJdaLvMGKPpK+c/LYhQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K2EvqU/dEvQnrMLg5WUTrUDClUmzBv4GqDk4oW5eTRhv5vpP4D0ZuU5cFshubqsWrqrbiL0b2AGX+cKSEVok9OhZbW951GpPdZfs2D+WF5IasYVbo1VIlb28bB0ihEUPl3DFksZaBYLNPwPAuYFeT535Tp/2NBGzh64eceRQCCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFlfE/O5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741181437; x=1772717437;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=qv6kfjqWgUm1Ww2zop913jEHSJdaLvMGKPpK+c/LYhQ=;
  b=PFlfE/O5RxVgDQaBA/VOBbTklaHE3uKu5LDWyTMmj15YXC4jhHRkKweC
   TUq6puTB0AvONyR8SIcXqY5lxH3KD7e4zoECiXcR0aPX634gggBD6CMAm
   Cnk3jhsbgzZ0ilPxSxno46qLN7adF2Sx1pn38Pnfk8LlyzZ4yRAWKexWv
   h9H90ro24wY/XmmTKc9d11uxdng11+jZmQ6vY5EIDC5ud5KEwCbuXJNkt
   oEblDmbsBSRaJv0PZr6Qs7B+z07Srwh+Xk+FYAi8Zm1edfLp9sMvGyGpw
   3qEY3S9+T1h2nJPNIb0afmvpi+p63ulsoBQ2k4pcEUspiRZWwOeeztL2B
   w==;
X-CSE-ConnectionGUID: s8NoxWOTRAOGWeyd54FSTw==
X-CSE-MsgGUID: EBXZ8G5dRiSpsatv51QcaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53132235"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="53132235"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:30:35 -0800
X-CSE-ConnectionGUID: DQhfG1J3SgS0CWpqLR1I9Q==
X-CSE-MsgGUID: pBZISIueQuWngEfuj9HNfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="149448411"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.99.188]) ([10.245.99.188])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:30:33 -0800
Message-ID: <ad9799ed-5313-4787-b982-c8fc82a281a2@linux.intel.com>
Date: Wed, 5 Mar 2025 14:30:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: refactor the Tx
 scheduler feature
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
References: <20250226113409.446325-1-mateusz.polchlopek@intel.com>
 <20250303095405.GQ1615191@kernel.org>
 <b5e34397-0b81-4132-86d0-498a111cc363@linux.intel.com>
Content-Language: en-US
In-Reply-To: <b5e34397-0b81-4132-86d0-498a111cc363@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/4/2025 2:43 PM, Szapar-Mudlaw, Martyna wrote:
> 
> 
> On 3/3/2025 10:54 AM, Simon Horman wrote:
>> On Wed, Feb 26, 2025 at 12:33:56PM +0100, Mateusz Polchlopek wrote:
>>> Embed ice_get_tx_topo_user_sel() inside the only caller:
>>> ice_devlink_tx_sched_layers_get().
>>> Instead of jump from the wrapper to the function that does "get" 
>>> operation
>>> it does "get" itself.
>>>
>>> Remove unnecessary comment and make usage of str_enabled_disabled()
>>> in ice_init_tx_topology().
>>
>> Hi Mateusz,
>>
>> These changes seem reasonable to me.
>> But I wonder if they could be motivated in the commit message.
>>
>> What I mean is, the commit message explains what has been done.
>> But I think it should explain why it has been done.
> 
> Hi Simon,
> 
> I'm replying on behalf of Mateusz since he's on leave, and we didn't 
> want to keep this issue waiting too long.
> Would such extended commit message make sense and address your concerns?
> 
> "Simplify the code by eliminating an unnecessary wrapper function. 
> Previously, ice_devlink_tx_sched_layers_get() acted as a thin wrapper 
> around ice_get_tx_topo_user_sel(), adding no real value but increasing 
> code complexity. Since both functions were only used once, the wrapper 
> was redundant and contributed approximately 20 lines of unnecessary 
> code. By directly calling ice_get_tx_topo_user_sel(), improve 
> readability and reduce function jumps, without altering functionality.
> Also remove unnecessary comment and make usage of str_enabled_disabled() 
> in ice_init_tx_topology()."
> 
> Thank you,
> Martyna

Sorry, I caused some confusion in the previous version of proposed 
commit message. Here’s the corrected one:

"Simplify the code by eliminating an unnecessary wrapper function. 
Previously, ice_devlink_tx_sched_layers_get() acted as a thin wrapper 
around ice_get_tx_topo_user_sel(), adding no real value but increasing 
code complexity. Since both functions were only used once, the wrapper 
was redundant and contributed approximately 20 lines of unnecessary 
code. Remove ice_get_tx_topo_user_sel() and moves its instructions 
directly into ice_devlink_tx_sched_layers_get(), improving readability 
and reducing function jumps, without altering functionality.
Also remove unnecessary comment and make usage of str_enabled_disabled() 
in ice_init_tx_topology()."

> 
>>
>>> Suggested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>
>> ...
>>
> 
> 


