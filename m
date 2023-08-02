Return-Path: <netdev+bounces-23674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF0D76D1A6
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF78C1C21059
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118A8BFB;
	Wed,  2 Aug 2023 15:19:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4436C79FF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5061C433C8;
	Wed,  2 Aug 2023 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690989538;
	bh=MpJddWF59Y3r4C5rdMlYJbaG4nJtsvWkijQnPbA5m0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKbDOd95vbAuoKLM9gIV+Ydy+T7t+w4aZttd+5ACEgtOVn8oXIQ9aIyq3Zdy9jkox
	 nLfQpbtiRyULUYFp93OcLWKzpTUfWTgZNZpOfjCVAbZ47ccxRwCbXsQ3HZtAlcEF4q
	 Ewv46l78pDi2bLYuxCehVV542hX1VDjUwpobgK0d69Ar4+OyLU0mogxf4slCutbHDg
	 LlZWlZIR/OwONvKJJJ4HX/5GpRxfQs0UeuCyHvj9U1DUzJo+tfyDw0v40Zw8FINGIa
	 mMDCrqYbO2CqB5N5/YCODYb9jXHYECCcdPzn8t37faCcZdKixaaxgwLmmn4FLXg6y2
	 uenMUm+byM7kQ==
Date: Wed, 2 Aug 2023 17:18:54 +0200
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4][next] i40e: Replace one-element array with
 flex-array member in struct i40e_package_header
Message-ID: <ZMpz3re48diGmG/Z@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <768db2c3764a490118f6850d24f6e49998494b6c.1690938732.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <768db2c3764a490118f6850d24f6e49998494b6c.1690938732.git.gustavoars@kernel.org>

On Tue, Aug 01, 2023 at 11:05:31PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct i40e_package_header with flexible-array
> member.
> 
> The `+ sizeof(u32)` adjustments ensure that there are no differences
> in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/335
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c  | 4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> index 7e8183762fd9..0db6f5e3cfcc 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> @@ -220,7 +220,7 @@ static bool i40e_ddp_is_pkg_hdr_valid(struct net_device *netdev,
>  		netdev_err(netdev, "Invalid DDP profile - size is bigger than 4G");
>  		return false;
>  	}
> -	if (size < (sizeof(struct i40e_package_header) +
> +	if (size < (sizeof(struct i40e_package_header) + sizeof(u32) +

Hi Gustavo,

would it make more sense to use struct_size() here?

>  		sizeof(struct i40e_metadata_segment) + sizeof(u32) * 2)) {
>  		netdev_err(netdev, "Invalid DDP profile - size is too small.");
>  		return false;
> @@ -281,7 +281,7 @@ int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
>  	if (!i40e_ddp_is_pkg_hdr_valid(netdev, pkg_hdr, size))
>  		return -EINVAL;
>  
> -	if (size < (sizeof(struct i40e_package_header) +
> +	if (size < (sizeof(struct i40e_package_header) + sizeof(u32) +
>  		    sizeof(struct i40e_metadata_segment) + sizeof(u32) * 2)) {
>  		netdev_err(netdev, "Invalid DDP recipe size.");
>  		return -EINVAL;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index 388c3d36d96a..c3d5fe12059a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -1456,7 +1456,7 @@ struct i40e_ddp_version {
>  struct i40e_package_header {
>  	struct i40e_ddp_version version;
>  	u32 segment_count;
> -	u32 segment_offset[1];
> +	u32 segment_offset[];
>  };
>  
>  /* Generic segment header */
> -- 
> 2.34.1
> 
> 

