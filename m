Return-Path: <netdev+bounces-96960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE718C873C
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF75FB22EA1
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BF4548F8;
	Fri, 17 May 2024 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/q6X3js"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885A535D0
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715952752; cv=none; b=A7YvsC1XfkxIrJuA+//UZtuOFO9+YmIdNtbzrWYEycEJC3WqPgomrYw1ZMlMkenlAZ30ofbvaioFoUxxekM/4DAy3vpStlGYt1bb4dnOwDGIp+G40TtEm0/kXUYLWN9uZHuN72qRZi81vfQjX83TVueqfTFL3DxkHvnQr0R+RhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715952752; c=relaxed/simple;
	bh=pUPpyXx5LbjQffb41UqAO017lGj76vlZdkx9yDtypEI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j2KVvoCsh7ClYXR8VTWlcsFy2dsmDyJBwqzWmw3hei5Ydyv7IdZ8/bMrEnZJ6gGzyyiVSwnEbZ/EWZ01APW/0DzcgA3KsYu4MWY4nhhDH3t2BSxbo7Tv9hvdvt69pZK1SLsXPp5PG6T1RK8Da45e8PpRn89TjUtj47GDOizlprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/q6X3js; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715952751; x=1747488751;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=pUPpyXx5LbjQffb41UqAO017lGj76vlZdkx9yDtypEI=;
  b=F/q6X3jsLRls2slYwocwsl6+E4aQa1VLfTGwz0/tgh218bkPc24LWVZf
   IWrMK6A9IRoAJ53YCYsvmZsuRf6+Q6eV/bFdDmm5F7wvF3hxu829xDbI9
   1UMVgsPgVqhfY/f9UX8K67rh1Tv9PWnDZbiQ0OYAKGMe1r1CenV57NY4K
   fM0ludMNRniwKIHMHRnfUGndxKNMV/jlGy59Alz8CD6hCn0okXm6MXnYM
   SPChBNlAIKCHnfK3hpr2qSJqRgcLLO/BpemxcexT6GJ2MHEURY/idi3d7
   k6sCFFe+tZtGyIEzJo+KjJNNRgHwtPXgp+BzQrjGz7/3cyrMNA4ppRv1q
   Q==;
X-CSE-ConnectionGUID: HgN0eSKeSNSFNZLvSA0hmw==
X-CSE-MsgGUID: 1VuP+Le4Sla4/GRHGB/cnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15955550"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="15955550"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:32:30 -0700
X-CSE-ConnectionGUID: HPOFUpkQQI6ZTuuiDaEb5A==
X-CSE-MsgGUID: KZGa3QJDSzSijrDKiCgVcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="55004908"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.245.83.4]) ([10.245.83.4])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:32:26 -0700
Message-ID: <24d3e9ed-0e56-40d6-b53f-e379855aa740@linux.intel.com>
Date: Fri, 17 May 2024 15:31:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: Do not get coalesce settings while in reset
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Simon Horman <horms@kernel.org>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
 larysa.zaremba@intel.com
References: <20240430181434.1942751-1-anthony.l.nguyen@intel.com>
 <20240501195641.1e606747@kernel.org>
 <382a4740-cc05-4897-94e3-aac4f12b2300@linux.intel.com>
Content-Language: pl
In-Reply-To: <382a4740-cc05-4897-94e3-aac4f12b2300@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.05.2024 15:30, Dawid Osuchowski wrote:
> On 02.05.2024 04:56, Jakub Kicinski wrote:
>> Did you not add locks around reset to allow waiting instead of returning
>> -EBUSY to user space? I feel like we've been over this...
> 
> Will use the approach with ice_wait_for_reset() in next revision, thanks
> 
> --Dawid

Hey Jakub,

I went ahead with the approach of using ice_wait_for_reset() [1], 
however this resulted in a new problem in the reset flow. I want to 
prove why I think returning immediately with -EBUSY (or perhaps -EAGAIN) 
is the correct way in this particular case.

The issue has to deal with the way both the ethtool handler and the 
adapter reset flow call rtnl_lock() during operation. If we wait for 
reset completion inside of an ethtool handling function such as 
ice_get_coalesce(), the wait will always timeout due to reset being 
blocked by rtnl_lock() inside of ice_queue_set_napi() (which is called 
during reset process), and in turn we will always return -EBUSY anyways, 
with the added hang time of the timeout value (in case of [1] it's 10 
seconds).

There are other places where similar deadlock can occur, not only in 
ice_queue_set_napi() and Larysa is currently working on an extensive 
solution to this problem.

--Dawid

[1] 
https://lore.kernel.org/netdev/20240506153307.114104-1-dawid.osuchowski@linux.intel.com/

