Return-Path: <netdev+bounces-207795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CD5B0894B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913B61898A06
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736FA289E17;
	Thu, 17 Jul 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daIaCpDy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE54289E0F;
	Thu, 17 Jul 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744579; cv=none; b=h8ZF86Z47Dbed9Ot3SUeHM0BllDRcMgA7MnjNCMqVK7lKyJpCww0N42Xscj1xLLpp/EYeY4YXL7qxOJ4rfPuPKLwqVwZiPnvahNzQu3u439dvcUGQ+FnePJ3fk39r3CKmT/dG5vUJIXjFwpPSrvTBKAXIGz0tb0zjHDA0YOjILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744579; c=relaxed/simple;
	bh=PeRZn0vzFIsX5vcaApJyGGbknSYq0vd9WAI4xB1Xxcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d70uLyXUq5JkQla9sTQNO17fj6cm7EfnVdH9rFq8NBdgnSHB5L00oD7KOHAcI4RP5S3y8OM8D6mIGU/nHNlc4h+nHzd98WXXqZu4ACmVNfcuzKsAkt+RiYyXxQDm2yqRvtd4cefCciyhiQsfQhi+fa/yrwNT/XfiRAx3xjSoNdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daIaCpDy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752744578; x=1784280578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PeRZn0vzFIsX5vcaApJyGGbknSYq0vd9WAI4xB1Xxcs=;
  b=daIaCpDydpqERdFAdV2xkYBzc5XO6b9WBBMay9Cg7jGb5bZL8ZplusIC
   K9qyXyozOGM+3TZJMMF5ztM1I1Fj88qYqJcxRYkkCu8rw6Iy949ObyKCo
   h8VKS+jw8pJE61PqMoSJtNC+Z4uMSgCGi8YMMSgN+9FsMvVQnBHKs0VC1
   JwBD5r4mseEBblf7l4MhRBTCP5IINjnluv9PxR+W/5aGM/GAbBK9kyM4I
   D0o7zDQuCPcy3MmMg+jBZQaGSsJUBcrnHKwNYPRI6dULWnxLlezDyRB4f
   feKuYsd5rrcvUNYn6xBL77YUpZGdfHdMG4ZngKqaqbfwi9NJPfjyJQVRa
   Q==;
X-CSE-ConnectionGUID: He5EEZ4xRByyOQL7QXqajA==
X-CSE-MsgGUID: vQSx8/zVR2qyRzjsLJEb/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="66080637"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="66080637"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 02:29:37 -0700
X-CSE-ConnectionGUID: kTMDdV3RTKKJ60e/F1mtvw==
X-CSE-MsgGUID: AdDq3+OvQXeQF1kxDk/1CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="188685491"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.72]) ([172.28.180.72])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 02:29:35 -0700
Message-ID: <b5b46a1f-41e1-4a25-bb6c-885ad2851aeb@linux.intel.com>
Date: Thu, 17 Jul 2025 11:29:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbevf: remove unused
 fields from struct ixgbevf_adapter
To: Yuto Ohnuki <ytohnuki@amazon.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250717084609.28436-1-ytohnuki@amazon.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250717084609.28436-1-ytohnuki@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-17 10:46 AM, Yuto Ohnuki wrote:
> Remove hw_rx_no_dma_resources and eitr_param fields from struct
> ixgbevf_adapter since these fields are never referenced in the driver.
> 
> Note that the interrupt throttle rate is controlled by the
> rx_itr_setting and tx_itr_setting variables.
> 
> This change simplifies the ixgbevf driver by removing unused fields,
> which improves maintainability.
> 
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
> ---
>   drivers/net/ethernet/intel/ixgbevf/ixgbevf.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> index 4384e892f967..3a379e6a3a2a 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> @@ -346,7 +346,6 @@ struct ixgbevf_adapter {
>   	int num_rx_queues;
>   	struct ixgbevf_ring *rx_ring[MAX_TX_QUEUES]; /* One per active queue */
>   	u64 hw_csum_rx_error;
> -	u64 hw_rx_no_dma_resources;
>   	int num_msix_vectors;
>   	u64 alloc_rx_page_failed;
>   	u64 alloc_rx_buff_failed;
> @@ -363,8 +362,6 @@ struct ixgbevf_adapter {
>   	/* structs defined in ixgbe_vf.h */
>   	struct ixgbe_hw hw;
>   	u16 msg_enable;
> -	/* Interrupt Throttle Rate */
> -	u32 eitr_param;
>   
>   	struct ixgbevf_hw_stats stats;
>   

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid

