Return-Path: <netdev+bounces-186965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38739AA4603
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996674637CB
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21174218EB9;
	Wed, 30 Apr 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDBYw/qy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FE2DC768
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003334; cv=none; b=URpjSyiZTIpa2+VfjWQSqIqC7fH9fnqeqRQDOyhLt05yn/YHj1WWgEUfc63V1jRTWq8rZEatsHsA3lK17pJexygbcEUcRanl9cvcSGat7AFtzocNeExByFuMsvEsy1dpkJp3V2MtxfXWfWUP1ccRZgGDcyPpnZ5BMzUqMMvusFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003334; c=relaxed/simple;
	bh=MAtLAD56QOPPSbm74mSzW0LRN2+jjBX+qq4vmsqEOYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+hPW4KBKRMs9O2oMNf9UBrlAEMRWINwuv71phTNU81IOCB3YawdDEG+OstAjK6UC1sZXhQJi3AZTDU0/iLG37wLbkRaFGvyR0aum7E+6KEqRs1+x+Dj5n12Hpo9+mpbifqxJOh4UzvubNUEgS084U3IuMOMHmvY5G2I+Y0S8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDBYw/qy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746003333; x=1777539333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MAtLAD56QOPPSbm74mSzW0LRN2+jjBX+qq4vmsqEOYI=;
  b=mDBYw/qyjXdchDhe0Esjt2S84zqHdUZrQmvoSZI0sbAJFfqzNHkin0SE
   c+qCiWbTyEuTM9JcDeCs67OEnB5FLcm8H857wgOwl2MQc87CsDLQEcMGv
   WNS2JFOQdXnjK1IsR1xFfdKyKVEs6XZJD3fqcNN5aktlvRastKF1m5sG4
   pmH2fIfDqV753pScpceLU9xvSk6Hz/Lh40fYVjIQKFZxEGMTlmCSul5PY
   1OD/jpZFZ3GZJDjkNHp68ebuST2eBRlKixbnaJi5s5svOEyFrab9woJuN
   PpgN9cYz4ZgZlNGLbfM4aTavhzr/Se6KONEr+eCqlXCtSZF4p+0LhsYwr
   A==;
X-CSE-ConnectionGUID: W+/JDetkRoirTTvdtY+Lzg==
X-CSE-MsgGUID: 9+/MibyaRSaLmIkJTQ/ekg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="51473558"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51473558"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 01:55:32 -0700
X-CSE-ConnectionGUID: 9zYzTEY/S9OmEGRlOgoJjw==
X-CSE-MsgGUID: s009mo7cQjSj0j7CF7wssg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="133961827"
Received: from gomezolx-mobl.ger.corp.intel.com (HELO [10.245.87.99]) ([10.245.87.99])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 01:55:30 -0700
Message-ID: <d1485d62-a746-4660-82d2-35965a349a34@linux.intel.com>
Date: Wed, 30 Apr 2025 10:55:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ixgbe: fix ndo_xdp_xmit()
 workloads
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 magnus.karlsson@intel.com, michal.kubiak@intel.com,
 =?UTF-8?Q?Tobias_B=C3=B6hm?= <tobias.boehm@hetzner-cloud.de>,
 Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
References: <20250429155205.1444438-1-maciej.fijalkowski@intel.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250429155205.1444438-1-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-04-29 5:52 PM, Maciej Fijalkowski wrote:
> Currently ixgbe driver checks periodically in its watchdog subtask if
> there is anything to be transmitted (consdidering both Tx and XDP rings)

typo: s/consdidering/considering

> under state of carrier not being 'ok'. Such event is interpreted as Tx
> hang and therefore results in interface reset.
> 
> This is currently problematic for ndo_xdp_xmit() as it is allowed to
> produce descriptors when interface is going through reset or its carrier
> is turned off.
> 
> Furthermore, XDP rings should not really be objects of Tx hang
> detection. This mechanism is rather a matter of ndo_tx_timeout() being
> called from dev_watchdog against Tx rings exposed to networking stack.
> 
> Taking into account issues described above, let us have a two fold fix -
> do not respect XDP rings in local ixgbe watchdog and do not produce Tx
> descriptors in ndo_xdp_xmit callback when there is some problem with
> carrier currently. For now, keep the Tx hang checks in clean Tx irq
> routine, but adjust it to not execute it for XDP rings.

suggestion: s/adjust it to not execute it/adjust it to not execute

Best regards,
Dawid

