Return-Path: <netdev+bounces-93718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB468BCEF1
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 15:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A51C22CDF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2854676408;
	Mon,  6 May 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHhZEtQp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDB8763F0
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002230; cv=none; b=RXnf9Y/GqCvxOkJrTZMAW3oPSWejojAn0IwYr5MpO/qo/7QxtUs0IDjMz6SGLXbmBuCwS/UPDUFjUHzCDU7ENsi6hDe5eG1++9bMk3fEIWy/5kuMjGOfTNRP4LN8QGALr0I9cjVIRTCXw3UqAVomAJzDEJ2URxmx9oDbxkGkBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002230; c=relaxed/simple;
	bh=ugTgxnL/98dquGDLxHmEewi6njvv1ZdZbDmdVa1Si7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrDjcSIx7bsO6J8rlHk+RcIpAvor+o365io6wOdXwda35EPEXMK6gIDBqDt/AIigTZkZGE7sjWKqLXeCo2q9+UP7WtE6tOVZ1SnOpGcoBp87Of/5K1J8B06Z3vBBtqGO5YJiGV/PYiAPGxrwKDt2zm/HBlGj6Y3YmDwzJ73Fx1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHhZEtQp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715002229; x=1746538229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ugTgxnL/98dquGDLxHmEewi6njvv1ZdZbDmdVa1Si7Y=;
  b=NHhZEtQpPt8JUjO1Jkc8LYAeqj2T36upQYWBu2TyExe9OFBmvEEaJCRU
   zlagctrK/9qJHlyKtSUPoodebF+QxiOe7Gcet7tjG0d0YY7wciq7tTZ95
   I2tF8NQHUjvYHYJRHhb4yQm3Wg8vwTmC8+qPX1ThYa9Y0cVf73ScxsYNY
   YnchCfOtgLFdympHHXxB8NzqXiHEqGwrce/M0iMtSuiG6BmTLbTS1oDFH
   pID+yPLPvVWq4EcqLKFqheb4flKRPmsaJRz2BmZ2nxa8tLnwwvtfhAksE
   LayYR0V0WHRUrsP3nuDp7jwgiG/gftY0hdkitzF+QiTfSzxnteAdQmLAO
   A==;
X-CSE-ConnectionGUID: 6eWdwcSsSgScMu5bBxbEXg==
X-CSE-MsgGUID: b5NNe+CGS5eidWHfa69rFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22157141"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="22157141"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 06:30:29 -0700
X-CSE-ConnectionGUID: OKgXfV44QKOMKHdOGDoxxw==
X-CSE-MsgGUID: lOLsKArER8SPrLt3q20o1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="59347912"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.246.18.70]) ([10.246.18.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 06:30:25 -0700
Message-ID: <382a4740-cc05-4897-94e3-aac4f12b2300@linux.intel.com>
Date: Mon, 6 May 2024 15:30:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: Do not get coalesce settings while in reset
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Simon Horman <horms@kernel.org>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20240430181434.1942751-1-anthony.l.nguyen@intel.com>
 <20240501195641.1e606747@kernel.org>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20240501195641.1e606747@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.05.2024 04:56, Jakub Kicinski wrote:
> Did you not add locks around reset to allow waiting instead of returning
> -EBUSY to user space? I feel like we've been over this...

Will use the approach with ice_wait_for_reset() in next revision, thanks

--Dawid

