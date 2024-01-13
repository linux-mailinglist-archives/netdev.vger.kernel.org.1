Return-Path: <netdev+bounces-63429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF5B82CDA6
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 17:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B38A2B228F8
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FBB1FA1;
	Sat, 13 Jan 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb7hxkxu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FCE23A3
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 16:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87599C433F1;
	Sat, 13 Jan 2024 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705162034;
	bh=5GQBHlI5NK+kObariSZGsmsDAQBcXLBxEc91wBGox/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kb7hxkxuwgVTEr4GOxbq8NLUrwbhDyUAU08vl35eeeK6b30ZMXZ2ZSIS0/bFn040l
	 V3H559XWEV8EST9K2X1dCWfqJHhrJ27SXgvXtv1ROQajxV0BBbdnjJq3gmioBgfalt
	 iqaFsVMW/RnL8LDTa+SLnzfWvcIRcHj6WDU8N4nq5e6JebkZsSYdJJDGAhYJ683LNq
	 gIxdFHxnvwqx9t3NnKqABGs+Dyo+tsCYbN8eqvsDL1h4ZWjAw1uPr5J+RWAFZYHPJt
	 9VlAGJGY91qD7FNLPcGhjC0lW8l4u4mmepc9zXFTEZaeeLAxI9fjshHHx839Gldzix
	 h68sOcTOp4k7g==
Date: Sat, 13 Jan 2024 16:07:11 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Przemyslaw R Karpinski <przemyslaw.r.karpinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v1 1/2] i40e: Add read alternate indirect command
Message-ID: <20240113160711.GK392144@kernel.org>
References: <20240112095945.450590-1-jedrzej.jagielski@intel.com>
 <20240112095945.450590-2-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112095945.450590-2-jedrzej.jagielski@intel.com>

On Fri, Jan 12, 2024 at 10:59:44AM +0100, Jedrzej Jagielski wrote:
> From: Przemyslaw R Karpinski <przemyslaw.r.karpinski@intel.com>
> 
> Introduce implementation of 0x0903 Admin Queue command.
> This indirect command reads a block of data from the alternate structure
> of memory. The command defines the number of Dwords to be read and the
> starting address inside the alternate structure.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemyslaw R Karpinski <przemyslaw.r.karpinski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index de6ca6295742..93971c9c98cc 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -4375,6 +4375,46 @@ static int i40e_aq_alternate_read(struct i40e_hw *hw,
>  	return status;
>  }
>  
> +/**
> + * i40e_aq_alternate_read_indirect
> + * @hw: pointer to the hardware structure
> + * @addr: address of the alternate structure field
> + * @dw_count: number of alternate structure fields to read
> + * @buffer: pointer to the command buffer
> + *
> + * Read 'dw_count' dwords from alternate structure starting at 'addr' and
> + * place them in 'buffer'. The buffer should be allocated by caller.
> + *
> + **/
> +int i40e_aq_alternate_read_indirect(struct i40e_hw *hw, u32 addr, u32 dw_count,
> +				    void *buffer)
> +{
> +	struct i40e_aqc_alternate_ind_read_write *cmd_resp;
> +	struct i40e_aq_desc desc;
> +	int status;
> +
> +	if (!buffer)
> +		return -EINVAL;
> +
> +	cmd_resp = (struct i40e_aqc_alternate_ind_read_write *)&desc.params.raw;
> +
> +	i40e_fill_default_direct_cmd_desc(&desc,
> +					  i40e_aqc_opc_alternate_read_indirect);
> +
> +	desc.flags |= cpu_to_le16(I40E_AQ_FLAG_RD);
> +	desc.flags |= cpu_to_le16(I40E_AQ_FLAG_BUF);
> +	if (dw_count > I40E_AQ_LARGE_BUF / 4)
> +		desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_LB);

nit: Maybe the cast to (u16) can be dropped?
     It isn't present in usage of I40E_AQ_FLAG_LB a few lines further up.

> +
> +	cmd_resp->address = cpu_to_le32(addr);
> +	cmd_resp->length = cpu_to_le32(dw_count);
> +
> +	status = i40e_asq_send_command(hw, &desc, buffer,
> +				       lower_16_bits(4 * dw_count), NULL);
> +
> +	return status;
> +}
> +
>  /**
>   * i40e_aq_suspend_port_tx
>   * @hw: pointer to the hardware structure

...

