Return-Path: <netdev+bounces-128188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659219786B0
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEFE5B21FC1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D5F481C0;
	Fri, 13 Sep 2024 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbzdB1uy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A4824A1;
	Fri, 13 Sep 2024 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248395; cv=none; b=XgIDqJ2sqjlcuE2rbI1GgPjiJVdc8DekR/R7+lTrgjwuNZF83/UoZ1m974hAU/UZyAxt5XD5cKqcsYWCFz3jUIxTIF0lQ3+bGMR+KpXjXfeIxZDK09ttmMDEtvq3ZFyhwPBD/o38INN97Xb4xYis5TBsYJCM4C1P+ai0W/alD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248395; c=relaxed/simple;
	bh=ObHm9oMxbmCJwWODc6eiOXIrFNOf7ZHrYCnahzJSUa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IM1eU+k0xHFMt0T4o8G4HuEx93EI/wUSFr8yG37HPQdST3DQsTUcWqlDy9F8Df7gCA968wQ849vQxUxNmQHTYlWjvqSIEvh4jxY5P4jf9zDtcvLqH39wFEkUeZu6oaQDtKNpS9erK9t3zwIxebZcwIXopPrz0IBqcnw1a1w33GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbzdB1uy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726248395; x=1757784395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ObHm9oMxbmCJwWODc6eiOXIrFNOf7ZHrYCnahzJSUa4=;
  b=GbzdB1uyJJOFkvCxm2v+wdqUR/D1f982cONtPJLJ4GgXIVGZayXKzL5U
   JnasY7STzyapn8LxMP/c/AUkdMZAcv67O5Ri10Y4/m6hbFvDQbqKYLFHb
   kN7povQEce1FZCoFHDBeJWkLI0uvL9CQa5WF+Nqy439wbE2N2yWWD8vqR
   mZjxkDu0BSeEFcxPo4XkIc4gZ5aqlhKkoM8KUca4Z+jLsRmW+zx/U0z90
   2L91+s9kVGnxg+Hh+hy3RRAEEast4WPvFXAfyZxdWyc4FYYyszwzJFL7B
   XN0jo7WwdK5rgnIRAK2Wj3eYrVR7QWarcslQWrWbbQAQ7horN9kgob/q+
   Q==;
X-CSE-ConnectionGUID: k2BCW+4mTnS6prtcBMNWQw==
X-CSE-MsgGUID: gxs3pk1aQyWdgFUnUq/sHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="42635315"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="42635315"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:26:34 -0700
X-CSE-ConnectionGUID: SK6hDug6RKKKjj8UKtvKRQ==
X-CSE-MsgGUID: VzO7Zkh+S56pVvvgEFcX8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68061739"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.177]) ([10.125.108.177])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:26:30 -0700
Message-ID: <45aeb8f4-b452-4ecf-8dcc-1b0a9f89e2ae@intel.com>
Date: Fri, 13 Sep 2024 10:26:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/20] cxl: preclude device memory to be used for dax
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-19-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240907081836.5801-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d8c29e28e60c..45b4891035a6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3699,6 +3699,9 @@ static int cxl_region_probe(struct device *dev)
>  	case CXL_DECODER_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_DECODER_RAM:
> +		if (cxlr->type != CXL_DECODER_HOSTONLYMEM)
> +			return 0;
> +

While it's highly unlikely that someone puts pmem on a type2 device, the spec does not forbid it. Maybe it makes sense to just return 0 above this switch block entirely and skip this code block?


>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'

