Return-Path: <netdev+bounces-212049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FF2B1D83A
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5526E1AA3FE0
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B5254AE4;
	Thu,  7 Aug 2025 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8wUd7ug"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A68625393E
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570869; cv=none; b=TZqSAtFj7maqbN2h++Ce2FjwegVqYlbUa5yhLnETvd4vyY8c/csMp8Ngn3SHKmEXAQd5zudPpTUsWhGi2m/dGNnRpvTdiTrPUD7wAH/hlnwpJ9fWjvNx+yH4EJOGntToT9qCp2oZsgu0qZ5NrZ8l3YHbn8cS/italRwCMhZuSTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570869; c=relaxed/simple;
	bh=+egBy+RMpqLtNh79AR9yQ2T/2DAqtjLVFMqu+wyMIP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB2UIl1tMMFO46Ye438pyZjjBs7GwrExCRGgdiCmPglJsVh6Lz/wjeeMBIxUCc+o4UJSx46QBkYmuB5UPpzCayxyt/6rV5rIHdR7YYRBk922q3X3F72RGIV/jB2ByE2Hlly8egBBRVIq4u51mUapDftt2LUFRRqDOQUKOl5ZP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8wUd7ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5277DC4CEEB;
	Thu,  7 Aug 2025 12:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754570868;
	bh=+egBy+RMpqLtNh79AR9yQ2T/2DAqtjLVFMqu+wyMIP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8wUd7ugI+2eJCVQlgR+OWX8+BpJQNJTOm6DQpGqSByBgbhWZ4JMAe4XUxtOwcUHQ
	 ZamyIuuHFEKz0UhGPx01ZSJcNMDpG+tPY0tqtokc6dam69DCtoqxhjzWwIpA5biQ9r
	 CMBRVoGYIdMh68PaqAxLX62m1Xy6PI9Iiu1llWywiYt+A8zMlqmCW/v5nvmeSv7r1b
	 5F/Iq1i3cCuCQONi46KeKCIyflVwZ+3RqCLqYGUKKHEXYLkUqgrDstXnlmXLb4wOSw
	 DgBDrwpoig72ZM19FeM5ZOgqTzP3lAEA6ac22715rowvudm/PNG4umLM6RC3iFDwY+
	 i8DGTMrazccHw==
Date: Thu, 7 Aug 2025 13:47:44 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
	ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH net-next v4] ibmvnic: Increase max subcrq indirect
 entries with fallback
Message-ID: <20250807124744.GJ61519@horms.kernel.org>
References: <20250806184449.94278-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806184449.94278-1-mmc@linux.ibm.com>

On Wed, Aug 06, 2025 at 11:44:49AM -0700, Mingming Cao wrote:
> POWER8 support a maximum of 16 subcrq indirect descriptor entries per
>  H_SEND_SUB_CRQ_INDIRECT call, while POWER9 and newer hypervisors
>  support up to 128 entries. Increasing the max number of indirect
> descriptor entries improves batching efficiency and reduces
> hcall overhead, which enhances throughput under large workload on POWER9+.
> 
> Currently, ibmvnic driver always uses a fixed number of max indirect
> descriptor entries (16). send_subcrq_indirect() treats all hypervisor
> errors the same:
>  - Cleanup and Drop the entire batch of descriptors.
>  - Return an error to the caller.
>  - Rely on TCP/IP retransmissions to recover.
>  - If the hypervisor returns H_PARAMETER (e.g., because 128
>    entries are not supported on POWER8), the driver will continue
>    to drop batches, resulting in unnecessary packet loss.
> 
> In this patch:
> Raise the default maximum indirect entries to 128 to improve ibmvnic
> batching on morden platform. But also gracefully fall back to
> 16 entries for Power 8 systems.
> 
> Since there is no VIO interface to query the hypervisor’s supported
> limit, vnic handles send_subcrq_indirect() H_PARAMETER errors:
>  - On first H_PARAMETER failure, log the failure context
>  - Reduce max_indirect_entries to 16 and allow the single batch to drop.
>  - Subsequent calls automatically use the correct lower limit,
>     avoiding repeated drops.
> 
> The goal is to  optimizes performance on modern systems while handles
> falling back for older POWER8 hypervisors.
> 
> Performance shows 40% improvements with MTU (1500) on largework load.
> 
> --------------------------------------
> Changes since v3:
> Link to v3: https://www.spinics.net/lists/netdev/msg1112828.html
> - consolidate H_PARAMTER handling & subcrq ind desc limit reset for RX/TX
>   into a helper function
> - Cleanup and clarify comments in post migration case
> - Renamed the limits to be a clear and simple name

Thanks for the updates.

I'm sorry for not mentioning this in my review of v3, but net-next
is currently closed for the merge window. Could you please repost,
or post a v4, once it re-opens. That should happen once v6.17-rc1
has been released. Probably early next week (week of 11th August).

My minor nits below notwithstanding this looks good to me.
So feel free to include.

Reviewed-by: Simon Horman <horms@kernel.org>

N.b.: I will be on a break when net-next reopens.
      So please don't wait for feedback from me then.

> 
> Changes since v2:
> link to v2: https://www.spinics.net/lists/netdev/msg1104669.html
> 
> -- was Patch 4 from a patch series v2. v2 introduced a module parameter
> for backward compatibility. Based on review feedback, This patch handles
> older systems fall back case without adding a module parameter.
> 
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> Reviewed-by: Brian King <bjking1@linux.ibm.com>
> Reviewed-by: Haren Myneni <haren@linux.ibm.com>
> ---

These days it is preferable to put the revision history here.
Rather than above your Signed-off-by line, as is currently the case.

>  drivers/net/ethernet/ibm/ibmvnic.c | 59 ++++++++++++++++++++++++++----
>  drivers/net/ethernet/ibm/ibmvnic.h |  6 ++-
>  2 files changed, 56 insertions(+), 9 deletions(-)

Or here.

> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c

...

> @@ -6369,6 +6400,19 @@ static int ibmvnic_reset_init(struct ibmvnic_adapter *adapter, bool reset)
>  			rc = reset_sub_crq_queues(adapter);
>  		}
>  	} else {
> +		if (adapter->reset_reason == VNIC_RESET_MOBILITY) {
> +			/* After an LPM, reset the max number of indirect
> +			 * subcrq descriptors per H_SEND_SUB_CRQ_INDIRECT
> +			 * hcall to the default max (e.g POWER8 -> POWER10)
> +			 *
> +			 * If the new destination platform does not support
> +			 * the higher limit max (e.g. POWER10-> POWER8 LPM)
> +			 * H_PARAMETER will trigger automatic fallback to the
> +			 * safe minimium limit.

minimum

> +			 */
> +			adapter->cur_max_ind_descs = IBMVNIC_MAX_IND_DESCS;
> +		}
> +
>  		rc = init_sub_crqs(adapter);
>  	}

...

> diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h

> index 246ddce753f9..480dc587078f 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.h
> +++ b/drivers/net/ethernet/ibm/ibmvnic.h
> @@ -29,8 +29,9 @@
>  #define IBMVNIC_BUFFS_PER_POOL	100
>  #define IBMVNIC_MAX_QUEUES	16
>  #define IBMVNIC_MAX_QUEUE_SZ   4096
> -#define IBMVNIC_MAX_IND_DESCS  16
> -#define IBMVNIC_IND_ARR_SZ	(IBMVNIC_MAX_IND_DESCS * 32)
> +#define IBMVNIC_MAX_IND_DESCS 128
> +#define IBMVNIC_SAFE_IND_DESC 16
> +#define IBMVNIC_IND_MAX_ARR_SZ (IBMVNIC_MAX_IND_DESCS * 32)

nit: maybe move towards using tabs before the values here?

+#define IBMVNIC_MAX_IND_DESCS	128
+#define IBMVNIC_SAFE_IND_DESC	16
+#define IBMVNIC_IND_MAX_ARR_SZ	(IBMVNIC_MAX_IND_DESCS * 32)

...

-- 
pw-bot: deferred

