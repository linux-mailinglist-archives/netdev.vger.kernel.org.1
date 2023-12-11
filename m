Return-Path: <netdev+bounces-56061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A9C80DAD9
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 20:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29031F216D7
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8852F82;
	Mon, 11 Dec 2023 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJQ8f+4z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6FA51C37
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 19:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E439C433C7;
	Mon, 11 Dec 2023 19:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702322745;
	bh=5PCDJcoJLtnGpRV0DAjYRK8BuRBZFwRiLOSsdq1VC4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJQ8f+4zwstIOdI5SABdp1eyca+2SHXI3CYUyYwelTY7g+FxxA6gq8iEZaJJaIqYe
	 0ZsFUxruMDzia2FJIXsEMGYiIqMrgDWu8JxCdf5+5nnE4Bvm77/WwoR9CuBn6/SQi/
	 uqEWP2j1JC0NqER8BRvclRgLvHuTGp2NjIey2OphPKieEB4+HA72uKqEW1f6Dx09P4
	 fypwV+lT3Zb5oyOJJYWBLO3kvpzFDSHu+RSoXXCcogkAsM4MmUSkmjd1tscyplcPIk
	 vRe/R41pRDbGWhyO8bV7m0hdTOrus/HCZR7OlYMiK6j7XsZ5beNRBHJk2nShLN7ZUh
	 PNt06r1IF77fQ==
Date: Mon, 11 Dec 2023 19:25:40 +0000
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com,
	Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: Re: [PATCH net-next 6/7] sfc: add debugfs entries for filter table
 status
Message-ID: <20231211192540.GR5817@kernel.org>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <fc28d967fbffd53f61a1d42332ee7bc64435df7c.1702314695.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc28d967fbffd53f61a1d42332ee7bc64435df7c.1702314695.git.ecree.xilinx@gmail.com>

On Mon, Dec 11, 2023 at 05:18:31PM +0000, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Filter table management is complicated by the possibility of overflow
>  kicking us into a promiscuous fallback for either unicast or multicast.
>  Expose the internal flags that drive this.
> Since the table state (efx->filter_state) has a separate, shorter
>  lifetime than struct efx_nic, put its debugfs nodes in a subdirectory
>  (efx->filter_state->debug_dir) so that they can be cleaned up easily
>  before the filter_state is freed.
> 
> Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

...

> index 4ff6586116ee..a4ab45082c8f 100644
> --- a/drivers/net/ethernet/sfc/mcdi_filters.c
> +++ b/drivers/net/ethernet/sfc/mcdi_filters.c
> @@ -1348,6 +1348,20 @@ int efx_mcdi_filter_table_probe(struct efx_nic *efx, bool multicast_chaining)
>  	INIT_LIST_HEAD(&table->vlan_list);
>  	init_rwsem(&table->lock);
>  
> +#ifdef CONFIG_DEBUG_FS
> +	table->debug_dir = debugfs_create_dir("filters", efx->debug_dir);
> +	debugfs_create_bool("uc_promisc", 0444, table->debug_dir,
> +			    &table->uc_promisc);
> +	debugfs_create_bool("mc_promisc", 0444, table->debug_dir,
> +			    &table->mc_promisc);
> +	debugfs_create_bool("mc_promisc_last", 0444, table->debug_dir,
> +			    &table->mc_promisc_last);
> +	debugfs_create_bool("mc_overflow", 0444, table->debug_dir,
> +			    &table->mc_overflow);
> +	debugfs_create_bool("mc_chaining", 0444, table->debug_dir,
> +			    &table->mc_chaining);
> +#endif
> +
>  	efx->filter_state = table;
>  
>  	return 0;
> @@ -1518,6 +1532,10 @@ void efx_mcdi_filter_table_remove(struct efx_nic *efx)
>  		return;
>  
>  	vfree(table->entry);
> +#ifdef CONFIG_DEBUG_FS
> +	/* Remove debugfs entries pointing into @table */
> +	debugfs_remove_recursive(table->debug_dir);
> +#endif
>  	kfree(table);
>  }
>  

Hi Edward,

I think debugfs.h needs to be included so that debugfs_*() are defined.

...

-- 
pw-bot: changes-requested


