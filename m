Return-Path: <netdev+bounces-112455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28565939277
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 18:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B812819D6
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949AC16E87C;
	Mon, 22 Jul 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWSJXu5p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A642907
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665584; cv=none; b=HcVl9hnTQw1KgnGMTK+SRFrMbrsoTY+Jh9ZzdeP/6+e+LaE1EgvVQO54+Hr3w1tZpqFMS18dfi5dEfeGTpnDiU9Ii/rc6c9pcDT1G7NcH29rTqAUoSx30NuGn2Y3/3cjcN8qWOYe3mgHusRNjIQ/rlCtM78emJRbzrM+j4WSQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665584; c=relaxed/simple;
	bh=UyZaZjuiGAGlsyQJO9G5s022uxUrMSghFksQSEdmGtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRpKz6uzhGhf110sQIvp4SwbVSsyDktpCmJT99mv3j4m5Thd2HJrMSn0rJtX1LrqM5rGOERPKRuq40DRyR2IehGSPKFP5E2x4cn8odEg44q2Vx2BCLETelesQlQWgSKH9fGAVLUz8X5lKUA0IXTezyxokxSiIarsYE2JkTr/h5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWSJXu5p; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721665583; x=1753201583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UyZaZjuiGAGlsyQJO9G5s022uxUrMSghFksQSEdmGtA=;
  b=UWSJXu5pZmp0O984grAZ/F4qTyM7okPuGoNeh+l1vsuNm3lEMmFS8i/e
   zBCv4/fjuPJ4z5ru6RO6yisao87euGzviwp+aMtqShELnRKMJdCQV/PX4
   UhwcU+NPCHAOQQwC7wULKssgC7wfI1Gcj0nq48MD38+qtAyx/OJofKZho
   fzXQEBJSJJOW26FHRJ69B4BNxjjfI2yPmEMe+CMBmAIPW0TSIQXWoaWwp
   qCQk+eLhgjoIWzHJL67DvkFXN6nnnfKvnHM2YX8/ZZv8fd4gUq8pY15HI
   MVE58vmd9KM1uXOQajSpA0dd/qRutaqT4/l4OHrMTwCKz/5B70q8mKQTy
   A==;
X-CSE-ConnectionGUID: kA6Do4/3T4Gs8iBpdh08NQ==
X-CSE-MsgGUID: ceDqzwcZQn6HUAfshaTjuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="18864444"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="18864444"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 09:26:22 -0700
X-CSE-ConnectionGUID: MJfk8nFcR9yhhlSdYKqyrQ==
X-CSE-MsgGUID: A60aTNn1Sya+WZABJyDnMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="82950304"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.94.250.30]) ([10.94.250.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 09:26:21 -0700
Message-ID: <faaf8123-0450-4ddb-ae86-50b8be1385dc@linux.intel.com>
Date: Mon, 22 Jul 2024 18:26:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Introduce
 netif_device_attach/detach into reset flow
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20240722122839.51342-1-dawid.osuchowski@linux.intel.com>
 <cb7758d3-3ba5-404d-b9e4-b22934d21e68@molgen.mpg.de>
 <0e5e0952-7792-4b9b-8264-8edd3c788fa8@linux.intel.com>
 <232df828-baa3-4c87-b5f3-c0dae9d98356@molgen.mpg.de>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <232df828-baa3-4c87-b5f3-c0dae9d98356@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.07.2024 16:35, Paul Menzel wrote:
>> Maybe "Add netif_device_attach/detach" would be the best for this, as 
>> the attaching and detaching doesn't happen only during reset.
> 
> I’d consider it too generic and would mention the place. But if it’s not 
> possible, then it’s not. Maybe:
> 
>> Attach/detach device before starting/stopping queues
>

Okay, will wait for some more feedback from other folks, maybe they'll 
have some input about the naming of the title as well.

>> Once the driver is fully initialized:
>> # echo 1 > /sys/class/net/ens1f0np0/device/reset
>> and then once that is in progress, from another terminal:
>> # ethtool -c ens1f0np0
>>
>> Would you like me to include those in the commit message as well?
> 
> I’d find it helpful, but I am no maintainer.

I will include it in the commit message.

> 
> Kind regards,
> 
> Paul

--Dawid

