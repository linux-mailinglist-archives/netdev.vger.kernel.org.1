Return-Path: <netdev+bounces-174168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B33A5DB0E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37260188BF51
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D94923E33C;
	Wed, 12 Mar 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fgl/kPnY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7123C8AB;
	Wed, 12 Mar 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777589; cv=none; b=SFBHwiS8FjGyrwQ/u/MHF3TPFwhQ2yOX7g/CGZ9+2/eQuKKt1EUq6WXs41QDhUcxVJVBibZTL60FX+NPR5nXpHxkwKTaJzUU8TJdRveHQvsJXoqoZtghb99QHyueG7Du73+dyBYmzL/ifvWv9fQBaiR+CyLZnwI0WDvdECkBqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777589; c=relaxed/simple;
	bh=zpVEj/Z0/zd3i/AJFV7MDl6B+Q7yGagVxm2zpHnOD3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNweDHr9t1eVNYkYdhGJcRzzbnhmEpArQ0UFxV3EZZBBJmVBVFE/88pJGiNIgtjiwXvXIS+Dl7Z6kELeKdUV1HPaiDDpScWwic0o0mXgcB8Kef4a27FJ2mZhOXACzT/CHmYE05WEM1/sDx09rKJKh9ZklkXq+NlBzErtkl0m5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fgl/kPnY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741777589; x=1773313589;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zpVEj/Z0/zd3i/AJFV7MDl6B+Q7yGagVxm2zpHnOD3w=;
  b=Fgl/kPnYI8LjyhQ4d8i69DtKwOGusz3J+Ae/BZ5D4nafZpfHMsU7UnxX
   9B2Pcri1JyDcwlFfrPCL/xl/zIbia2+gMoGHqYPIBbmpso3y5JbeeVnxP
   Pu6JnLTy4eHlDwF+QwasiNO0WVHQza4X98ksSW2/XaCOC3fvuryr6LOKs
   y1AdLp2sCEUPIveoKSsacdGsDtiYNgDTsGqx06ojgUB4uqFL2kP+TVANp
   i6/wMjNcs4PO6yogUrJsz4CGjjlU6EHyKCAdZNpkvDI4ZntREwmDwoH5q
   lsslixtcQFdyOJqn/dQ2/1L5xt8JoViobBJCHs28MH0qgsawbD0XHHl4m
   w==;
X-CSE-ConnectionGUID: 3PfZszVJQYqFMZ2t5DQgYA==
X-CSE-MsgGUID: d4bl0TsLQliYguTfdWd7yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53841909"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="53841909"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:06:28 -0700
X-CSE-ConnectionGUID: FTcHnpSoR1On2p12HpUfcQ==
X-CSE-MsgGUID: 1vDNffJDSfyoLH+Tbkug3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="125669067"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.56]) ([172.28.180.56])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:06:25 -0700
Message-ID: <93f1c6d0-a1fe-4154-a31d-20cc878476d9@linux.intel.com>
Date: Wed, 12 Mar 2025 12:06:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 git@amd.com, harini.katakam@amd.com
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250312095411.1392379-3-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-12 10:54 AM, Suraj Gupta wrote:
> AXI 1G/2.5G ethernet IP has following synthesis options:
> 1) SGMII/1000base-X only.
> 2) 2500base-X only.
> 3) dynamically switching between (1) and (2).
> Add support for 2500base-X only configuration.

Hi, thanks for the patch.

nit: a discrepancy between the commit description for and the comments 
in the code for 3)

Maybe adding that information here in the commit description would make 
sense as well? Or giving a bit of a background that SGMII/1000base-X is 
already implemented in the driver and you are adding 2500base-X only 
support.

> +	/* AXI 1G/2.5G ethernet IP has following synthesis options:
> +	 * 1) SGMII/1000base-X only.
> +	 * 2) 2500base-X only.
> +	 * 3) Dynamically switching between (1) and (2), and is not
> +	 * implemented in driver.
> +	 */

For the rest of the patch, it looks good to me but I'd rather have 
someone more experienced provide the Reviewed-By tag if they find the 
patch appropriate.

Best regards,
Dawid

