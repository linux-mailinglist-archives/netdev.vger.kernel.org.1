Return-Path: <netdev+bounces-190438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBAEAB6D0A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062293A69B0
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC0D2040AB;
	Wed, 14 May 2025 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGdFEI17"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D15135970
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230300; cv=none; b=hH79/iKMSJ0WJtkLFjqwhtvGtXVyOf/NRvvgLfm/gCMQXGBmOq4YDbf7OPFIXW5YH/nkJ6Brd60fSLJYSQgt2pVmaN6KEs7fyaNcgd7h+vHy6xZ37OlTyEzN3HHj1zkmWlJhFcOTzWF6EtWtI8ruYgVqfe8eMTMYwnEIv4r4DpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230300; c=relaxed/simple;
	bh=AwRvi0PqxuA5vDvS9U5a3gjbcYXj216Ynmr6dL4SXtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrSMMmHEW8Br10XupRq2ITnBYVDqCJwXKb4Tq5xDukFs4rL4+O+K+IBpB0P1iY+2dsxqDUHmmJRxe9tsJixgnbFi8giqI+zH8PHdEXnD7jZO3ToeG4Mfy6l1H9IYqPuMAnpvRkuUfFlLH00Ce+kb77TDuHsTqNgxnBlHeShnfp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGdFEI17; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747230299; x=1778766299;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AwRvi0PqxuA5vDvS9U5a3gjbcYXj216Ynmr6dL4SXtE=;
  b=WGdFEI17HuFpR5XAqqGf4pSTqBqDpZ8c3Te5Aw7irCvY5TflrEkdEz4v
   785nZ9BfBykEcCuinn4GNkzPqARInNstHp7xEikIjRdy+uWBAuOZVw7Dm
   MYRxcBuOoOTXoRBD9H1ZmCUlB7fC4xuJ5E+0CcyDM5SH/s1UZmVxW+8D3
   yw3WcMo0/zycfhInNfCeV7Fge97PHK0S0WXJqv8kmO8UwKzTdEAHGoQCR
   SW0YqeTvkeEX4NpOFcHOIz4J4as0+xqQmg1sFXIlzHZ2xYrmxMs6zwfFc
   vpL5PhaXK9swrTJ7KOsNlBsi0g4iYc7sdILHZE/p2zjDg/dKesZqoDhZX
   A==;
X-CSE-ConnectionGUID: THKrFtsqQYuFnFHYEdA9MA==
X-CSE-MsgGUID: DyHiuZaoSIKlPnqGSL2gZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48378618"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="48378618"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 06:44:58 -0700
X-CSE-ConnectionGUID: 2mSMoDaIT+CGh30NYb9tNQ==
X-CSE-MsgGUID: Wwxeo7EXSNe8aRKtYnpRNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142080497"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.96.13]) ([10.245.96.13])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 06:44:57 -0700
Message-ID: <3b333c97-4bdd-4238-bfab-b0f137e5b869@linux.intel.com>
Date: Wed, 14 May 2025 15:44:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 0/2] Add link_down_events counters to ixgbe
 and ice drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250512090515.1244601-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250512172146.2f06e09f@kernel.org>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <20250512172146.2f06e09f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jakub,

The link-down events counter increments upon actual physical link-down 
events, doesn't increment when user performs a simple down/up of the 
interface. However there is indeed link down event from firmware - as 
part of interface reinitialization eg. when attaching XDP program, 
reconfiguring channels and setting interface priv-flags. In those cases, 
the interface is stopped and then brought back up.

I will add more these details in the cover letter.

Thank you!
Martyna

On 5/13/2025 2:21 AM, Jakub Kicinski wrote:
> On Mon, 12 May 2025 11:05:14 +0200 Martyna Szapar-Mudlaw wrote:
>> This series introduces link_down_events counters to the ixgbe and ice drivers.
>> The counters are incremented each time the link transitions from up to down,
>> allowing better diagnosis of link stability issues such as port flapping or
>> unexpected link drops.
> 
> To confirm, will the counter increment:
>   - when link is held up by BMC / NC-SI or some other agent
>     and user does down/up on the host?
>   - when user reconfigures channels, attaches XDP etc?
> 
> Would be good to document that in the cover letter.
> 


