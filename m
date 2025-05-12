Return-Path: <netdev+bounces-189753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC41FAB37E3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE1A1887D79
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6648E292915;
	Mon, 12 May 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idxXPxJe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9228D837;
	Mon, 12 May 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054427; cv=none; b=HVVDA2pK1CRQbm1NjjLw3qqHHmw2OtcSQE8BRYebWgIdgaJaCT8AC6GOX/c/I7Aj/vi4C7cMoTTx/YbczRcXbyg7iP1KSr0lcDVJtR/r9AdBLaoMJ8wWcNkIdp2lphJxCmgXXIrghkTu+6QHKAddkUGGQ4Qf2noYzTxiZikFcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054427; c=relaxed/simple;
	bh=KpWgUl+JRrMT0YJo41Vo2z7Q6b3NHVQzf75ZkY8ylv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlkJsf4XeZ1p/v+2rImPY4i6IR4izgy6QrTm9HIi4dMln0aXyt/g6GziwnM3ZprgGap3elF6MLp+gO3yup4XchNG8MSYhqHUBMBFBuju/0T3Oixo9iaz1oaGTLIaQPuUdPcjJlArfn/aceePaToDX9Iqxba2uSjs57hX7WmWEl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idxXPxJe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747054425; x=1778590425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KpWgUl+JRrMT0YJo41Vo2z7Q6b3NHVQzf75ZkY8ylv8=;
  b=idxXPxJeD2GKPzXWvAHGvJkzZpGPi/D9UkVX14EA2qWeWePYfgc1wLOq
   iWNOENzDZZnpGCpt2iblp8SUX4bTLr8W3E+y/J45yR99jkLtRe00c5z2x
   RYguuuUIze4H1/vt6wYnDF5p6cGjHu2XurU1cxZ1XGgSeDHkS1UK1xylz
   8BbO9TxwcouKmsxQrtgTi/wi9zNvzq5MbR5sbie06VVfovsqXVYJtVWzG
   0oXvU1j2Fv2hcOMZqWYe3JeIMyPqzPm2rRWuS+4we6ZI3v1Gj7lqnC63N
   gapcJuSZY29haIhqzc2br0jODW+venaBkHP9mHmEptDL6vBiKeUD3W8uM
   w==;
X-CSE-ConnectionGUID: MKiVQX7KSSm3ht+atQmBEA==
X-CSE-MsgGUID: EPfy5Cg+QsSfJHGMR1sAlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59512059"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="59512059"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 05:53:44 -0700
X-CSE-ConnectionGUID: sGbWtMAaR3CYm2dhlGHzXQ==
X-CSE-MsgGUID: 8X7CkiVtQx6t8ybs+bx4hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="137069230"
Received: from hlagrand-mobl1.ger.corp.intel.com (HELO [10.245.102.40]) ([10.245.102.40])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 05:53:41 -0700
Message-ID: <170f287e-23b1-468b-9b59-08680de1ecf1@linux.intel.com>
Date: Mon, 12 May 2025 14:53:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ixgbe/ipsec: use memzero_explicit() for stack SA structs
To: Zilin Guan <zilin@seu.edu.cn>, anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20250512105855.3748230-1-zilin@seu.edu.cn>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250512105855.3748230-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-05-12 12:58 PM, Zilin Guan wrote:
> The function ixgbe_ipsec_add_sa() currently uses memset() to zero out
> stack-allocated SA structs (rsa and tsa) before return, but the gcc-11.4.0
> compiler optimizes these calls away. This leaves sensitive key and salt
> material on the stack after return.
> 
> Replace these memset() calls with memzero_explicit() to prevent the
> compiler from optimizing them away. This guarantees that the SA key and
> salt are reliably cleared from the stack.
> 
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Thanks for your patch.

Please use the correct target iwl-net for fixes, iwl-next for features 
and others.

Maybe add a tag? Fixes: 63a67fe229ea ("ixgbe: add ipsec offload add and 
remove SA")

In the future when sending patches against Intel networking drivers 
please send them directly To: intel-wired-lan@lists.osuosl.org and Cc: 
netdev@vger.kernel.org.

> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index 07ea1954a276..e8c84f7e937b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -678,7 +678,7 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs,
>   		} else {
>   			/* no match and no empty slot */
>   			NL_SET_ERR_MSG_MOD(extack, "No space for SA in Rx IP SA table");
> -			memset(&rsa, 0, sizeof(rsa));
> +			memzero_explicit(&rsa, sizeof(rsa));
>   			return -ENOSPC;
>   		}
>   
> @@ -727,7 +727,7 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs,
>   		ret = ixgbe_ipsec_parse_proto_keys(xs, tsa.key, &tsa.salt);
>   		if (ret) {
>   			NL_SET_ERR_MSG_MOD(extack, "Failed to get key data for Tx SA table");
> -			memset(&tsa, 0, sizeof(tsa));
> +			memzero_explicit(&tsa, sizeof(tsa));

As for the code change itself, LGTM.

Acked-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid

>   			return ret;
>   		}
>   

