Return-Path: <netdev+bounces-190679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642EFAB8462
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BFF9E4F6B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9AD297B99;
	Thu, 15 May 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxeJelsw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C02224B04
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306378; cv=none; b=gpi/dU9adD4JaI1TbD7NGPWGTuIXs/CPVowt9b/6FQGs79iNIHVUWwYnhhmXbKIpvM3EL3BAM/AWwKJcf8wD+FI9NVRoeDZHsS+M0hSNf1kuf4OhU326HJo+hQbO0hRMCSdPBj17Z8COolwp9FEgpEaAIPZxixBa369qGMHVmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306378; c=relaxed/simple;
	bh=ovFJnUrpIEp4+ba9a6q5iRMCX72A5K+Jk4wxyKuysrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuKdWIs6Pax9O1bkrXS1tEpX2uvlfs2FmksYiUEzVjGI+xy2sXZMW/WTnufOe9hufRs+QEjxsirfv6Tcp2yHcwyhxsRd3gigcC/s6VnmtTfxpJ+KWk56/Ld7iMSD6uc7tIOOKd/43Nad6XfbT22oug5pazhBY4VjExmhmck3aoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxeJelsw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747306378; x=1778842378;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ovFJnUrpIEp4+ba9a6q5iRMCX72A5K+Jk4wxyKuysrw=;
  b=VxeJelswaxEVZ9QUbzOMvCrE3FIV29/SS/5fUpWnuX0BC920lk8tjlK5
   HVtBPvlfSe5ubpwbgZfkyR5q9oFf92D6Fit5qGALR0Y8+76pG8spJfgwj
   cALel6FGu8UAl/DKu4kBVy09z5Ri7y0I2JG8XXWh0shPEBqTpratvyDEp
   MkzrTF1nnRWTgVtDnDnCY/dVW6HKvGuGbMv4cNgKIHWJbFsh4symU8ym4
   f3Xz75szHWJn6Mh0U6R2ooDvQOHHRxv6Stz22Ta1qGMVA6byxp1Pssckz
   D6ajyud7GJLnIJnheI7fn3FDyK4zflvWgIRzHnjON1ax9C7ecBi4cs+xC
   Q==;
X-CSE-ConnectionGUID: 5UAtxkyAQd2Qz5UzSj4EUw==
X-CSE-MsgGUID: JYUSK0OURnKVBYqFHDf/1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66641232"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="66641232"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 03:52:57 -0700
X-CSE-ConnectionGUID: vXcliIivSTyFGvZjGVwE8A==
X-CSE-MsgGUID: roBxfZv1TSCgUz6qCwmjGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="139234033"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.119.244]) ([10.245.119.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 03:52:55 -0700
Message-ID: <c13179c7-74e2-4843-a052-571f6f0c033d@linux.intel.com>
Date: Thu, 15 May 2025 12:52:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/2] ice: add link_down_events
 statistic
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250409113622.161379-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250409113622.161379-4-martyna.szapar-mudlaw@linux.intel.com>
 <55ae83fc-8333-4a04-9320-053af1fd6f46@molgen.mpg.de>
 <4012b88a-091d-4f81-92ab-ad32727914ff@linux.intel.com>
 <355fc4f1-0116-4028-a455-ec76772f19b3@molgen.mpg.de>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <355fc4f1-0116-4028-a455-ec76772f19b3@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/12/2025 11:27 AM, Paul Menzel wrote:
> Dear Martyna,
> 
> 
> Thank you for your reply.
> 
> Am 14.04.25 um 15:12 schrieb Szapar-Mudlaw, Martyna:
> 
>> On 4/9/2025 2:08 PM, Paul Menzel wrote:
> 
>>> Am 09.04.25 um 13:36 schrieb Martyna Szapar-Mudlaw:
>>>> Introduce a new ethtool statistic to ice driver, `link_down_events`,
>>>> to track the number of times the link transitions from up to down.
>>>> This counter can help diagnose issues related to link stability,
>>>> such as port flapping or unexpected link drops.
>>>>
>>>> The counter increments when a link-down event occurs and is exposed
>>>> via ethtool stats as `link_down_events.nic`.
>>>
>>> It’d be great if you pasted an example output.
>>
>> In v2 (which I just submitted) the generic ethtool statistic is used 
>> for this, instead of driver specific, so I guess no need to paste the 
>> example output now.
> 
> I think it’s always good also as a reference how to test the patch. I 
> just saw your v3. Should you resent, it’d be great if you added the 
> example output.
> 
> […]

Done in v4 updated cover letter.

> 
> 
> Kind regards,
> 
> Paul


