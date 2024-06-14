Return-Path: <netdev+bounces-103577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEC0908B0F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B193DB29089
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9628B1957F3;
	Fri, 14 Jun 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwhuS9Yf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC413BAC8
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365822; cv=none; b=pSnwalkpM7ArxQZw9sIrQ7prtxvVaiFup6613OLgdIG55Me00TB2I5PA136Vno4v6VR06pqLwf6SM5ITqtkkxDgLX9haCky5A6yPo0lk92Oz7oebhDy++uLHcIgPKNu9iKl/Q5U3xK99gPdGflUotcBvAj4aQJtgOkh+XQruICM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365822; c=relaxed/simple;
	bh=s/NHgsRPhg79AyLDcm5X+0db5evorzesVrH7Hi4YS4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpkFVJN8HV1Ks3BAl4xVusd1lPL562FSFzqL4yPZMkQihP+AqNmF340z89YQHPUGf7wS121klbqhfGhYtzK9v/oShkKODTO6U9j7B7r+3eYJzyRtbijGmwTU7k8tJq+PFKKTAE8HBl9AoOePxuH9xVOyjaQ6ZzsgHbxUmzyK8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwhuS9Yf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718365821; x=1749901821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s/NHgsRPhg79AyLDcm5X+0db5evorzesVrH7Hi4YS4I=;
  b=mwhuS9Yfy1fcdO3KKclveVM9otY701djGB15Wk/T76tqGOOO59vdmYbe
   p7gHP4GwnyISjVGilwBCYMdVOgLxtqJDEDr6yfFhitWzoMCoyCjV/ZnUk
   UNHRyDyp1Y2UB4Ay8POh6wXJggPsMwvTzqcfiuL82ImPOO07wlZSeYbJA
   mVfH+CF155yK2ietchP7fmlR75V6kZ34WInNgQ+Cb4JllBhrNhtF/vASG
   MsN2rTg7T+aeZtLPiMB9U7TNbPG70RDalGmPNSOePpQl5uAuXfKa2Kb0g
   12QnG+jr7gJ4A9DIV+s/3nC/pS72gzawOV+tf6RZ8izGv7iNdD2Y/ipoN
   w==;
X-CSE-ConnectionGUID: KrM1Q8/vQxaZPzfuz4labQ==
X-CSE-MsgGUID: zwQp8u8dTsWilrJNp5Idog==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="18167913"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="18167913"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 04:50:20 -0700
X-CSE-ConnectionGUID: bJre1s3DQk6VgfvXUZvahg==
X-CSE-MsgGUID: /cr7co2sQ0KVG9wtaMnpiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44848221"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.245.80.1]) ([10.245.80.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 04:50:18 -0700
Message-ID: <25a9d840-b0c9-4ccc-a663-d975e6e92548@linux.intel.com>
Date: Fri, 14 Jun 2024 13:50:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v5] ice: Do not get coalesce settings while in
 reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Simon Horman <horms@kernel.org>, larysa.zaremba@intel.com
References: <20240607121552.15127-1-dawid.osuchowski@linux.intel.com>
 <20240610194756.5be5be90@kernel.org>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20240610194756.5be5be90@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.2024 04:47, Jakub Kicinski wrote:

> Why does the reset not call netif_device_detach()?
> Then core will know not to call the driver.
Will use this approach in new patch, thanks.

--Dawid

