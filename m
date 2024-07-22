Return-Path: <netdev+bounces-112419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E6938F72
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 14:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62342B21406
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63316DC0A;
	Mon, 22 Jul 2024 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhyr+/CB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE016D9D5
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652937; cv=none; b=Ok5dlLejUJeWYmL27W0VfHKqNc8Nm9IbVYdngChXQ7ufm3FbMFoxWRGnr6rk2NMSAFAf7FKmDMh+Q/ZcAlnDhaUdavVlTNug8fCcbtruGvBtTQjuc3zJZc6ignMKQGoR5/ABh1v2PJfNLDPO3M5DSxCLxG/A2DNtoYsm2S4+27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652937; c=relaxed/simple;
	bh=DyBFFW7PXxxZTzvOnBYu/Hzk9zUKJSSwJt4z4BIad1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiTYSWPdMTqwABHrr/ZVDnc5tRET1MFrxeAC9zZqG8wLgWaMuJFUWSjtlMqrz4vfl+uwVNJ8dKInR1WBpKrMJavlhWpxvQl+U9IWkzp7pi0+miMfpnoliAF7SVvzgbHNFT7X6jWX7T5ITRpFaLFGFFQ7fB5mw/SXqOQk9E2yZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhyr+/CB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721652936; x=1753188936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DyBFFW7PXxxZTzvOnBYu/Hzk9zUKJSSwJt4z4BIad1E=;
  b=lhyr+/CBf9gtMhKvb9/W5VskmwCEPN+xipdlkEUK/PLkKOz02dsCmDWA
   VP0MGUAhZqwrsU5natKnhRxJ+kE8SJoZlisg8P/q+SxGgJ2EQVjZK3QxT
   LH8eJ+dxWZtwbdRrTBDIxFzRwejNdo4yYCR5WSTdk9OgrnS9WXy3cKGwH
   +lZBO6TTh/YDwuPNZrwXnJ/wVaNYQWNGdJhY1DbvxsnKY26IAaLdaMVpd
   BZPaYXXD6OtL3KVlJsVR8wPYPqv8RzXlLSmw3UJ10SHdw+nqe3qhe+KeZ
   wWWDyOj3rg+MZODfQYDmRromU+lMGKX2vz4YBOWBhtYpvks9Xt2QM5zX2
   w==;
X-CSE-ConnectionGUID: S4H2lvioSjy+9VjnH+2JKA==
X-CSE-MsgGUID: 5X30LNBpQnS+UPRxXqzZvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="12648711"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="12648711"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 05:55:36 -0700
X-CSE-ConnectionGUID: uKCb8+AKTnO8/8dGIsYARA==
X-CSE-MsgGUID: iJg+4JGzTZOu7Gyy5sq6+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="82515818"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.94.250.30]) ([10.94.250.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 05:55:34 -0700
Message-ID: <0e5e0952-7792-4b9b-8264-8edd3c788fa8@linux.intel.com>
Date: Mon, 22 Jul 2024 14:55:31 +0200
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
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20240722122839.51342-1-dawid.osuchowski@linux.intel.com>
 <cb7758d3-3ba5-404d-b9e4-b22934d21e68@molgen.mpg.de>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <cb7758d3-3ba5-404d-b9e4-b22934d21e68@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.07.2024 14:37, Paul Menzel wrote:
> Dear Dawid,
> 
> 
> Thank you for your patch.
> 
> Introduce … into
> 
> sounds a little strange to me. Maybe:
> 
>  > Attach to device in reset flow
> 
> or just
> 
>  > Add netif_device_attach/detach
> 
>  > Serialize …

Maybe "Add netif_device_attach/detach" would be the best for this, as 
the attaching and detaching doesn't happen only during reset.

> Am 22.07.24 um 14:28 schrieb Dawid Osuchowski:
>> Ethtool callbacks can be executed while reset is in progress and try to
>> access deleted resources, e.g. getting coalesce settings can result in a
>> NULL pointer dereference seen below.
> 
> What command did you execute?
> 

Once the driver is fully initialized:
# echo 1 > /sys/class/net/ens1f0np0/device/reset
and then once that is in progress, from another terminal:
# ethtool -c ens1f0np0

Would you like me to include those in the commit message as well?

--Dawid


