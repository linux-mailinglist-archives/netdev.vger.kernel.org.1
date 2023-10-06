Return-Path: <netdev+bounces-38550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C5D7BB62A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADFE28222C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4660D1C2B8;
	Fri,  6 Oct 2023 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6tGswAj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3A1C28C
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684E9C43397;
	Fri,  6 Oct 2023 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696590991;
	bh=/9ry5KltDfiR7VrvMhHB0ZYHyVGwugubCOANKdLFAf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6tGswAjsXMdB6tRqQ2T0pnrSjTOgtO5Jhu8lFi6WFuMYQfgghdZjv7iBzYcstWWx
	 btkRhHPzjKM8my2Waw0lXE3MN7xHnTzI7lt8BAlwpIbgpLUT2Lp3LqeBX8YEkPm2jy
	 d8XeBihAfvwjQDJ7jbgBqbOYeUcH6Ng1keExewCTitN/Og0RKyI13c3FQKXw0Uc5Vi
	 +3fH5fhxKfLqdFce9pmy64pfz3dniuX3TQ4le5qR6j4wPD6NcDO5j8eUDNCOPXuDb0
	 BYbth7IhYR1MXprOPdyIF9hEcLmQWePVuBTtNC4q+7nxAPMN9DPxTK1xZpvNfuPt1/
	 7H7mHHA67/U1g==
Date: Fri, 6 Oct 2023 13:16:27 +0200
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Rose <gregory.v.rose@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] ixgbe: fix crash with empty VF macvlan list
Message-ID: <ZR/si/di5IbSB9Gq@kernel.org>
References: <3cee09b8-4c49-4a39-b889-75c0798dfe1c@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cee09b8-4c49-4a39-b889-75c0798dfe1c@moroto.mountain>

On Thu, Oct 05, 2023 at 04:57:02PM +0300, Dan Carpenter wrote:
> The adapter->vf_mvs.l list needs to be initialized even if the list is
> empty.  Otherwise it will lead to crashes.
> 
> Fixes: c6bda30a06d9 ("ixgbe: Reconfigure SR-IOV Init")

Hi Dan,

I see that the patch cited above added the line you are changing.
But it also seems to me that patch was moving it from elsewhere.

Perhaps I am mistaken, but I wonder if this is a better tag.

Fixes: a1cbb15c1397 ("ixgbe: Add macvlan support for VF")

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> index a703ba975205..9cfdfa8a4355 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> @@ -28,6 +28,9 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
>  	struct vf_macvlans *mv_list;
>  	int num_vf_macvlans, i;
>  
> +	/* Initialize list of VF macvlans */
> +	INIT_LIST_HEAD(&adapter->vf_mvs.l);
> +
>  	num_vf_macvlans = hw->mac.num_rar_entries -
>  			  (IXGBE_MAX_PF_MACVLANS + 1 + num_vfs);
>  	if (!num_vf_macvlans)
> @@ -36,8 +39,6 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
>  	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
>  			  GFP_KERNEL);
>  	if (mv_list) {

I'm not sure it it is worth it, but perhaps more conventional error
handling could be used here:

	if (!mv_list)
		return;

	for (i = 0; i < num_vf_macvlans; i++) {
		...

> -		/* Initialize list of VF macvlans */
> -		INIT_LIST_HEAD(&adapter->vf_mvs.l);
>  		for (i = 0; i < num_vf_macvlans; i++) {
>  			mv_list[i].vf = -1;
>  			mv_list[i].free = true;
> -- 
> 2.39.2
> 
> 

