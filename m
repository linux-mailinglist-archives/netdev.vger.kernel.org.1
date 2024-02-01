Return-Path: <netdev+bounces-68166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91284601B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD2928FA10
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8FD74271;
	Thu,  1 Feb 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on/t3uNS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035C12FB2C
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812824; cv=none; b=ipNXSe93IPr3aRo5QIBmtAtPIx6jzP9eZcrxQeyNBIld5UUBMT27+VAhC9uEtALzsRcp+bPPBVrHMwfjLr4aSi0NMe6muSIb6CD7IDMXELxJl++bd2Gpmd9SgJBgfE658nXE3XCbRUsq2EyGt2dSeayNFBVEKawnRIBs7zCZdi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812824; c=relaxed/simple;
	bh=EavXvVxLpjlqE3esGFobog0or2KVXWyptDAH7zpW1To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF+LCw1TEQ/txyxMwoVFZC+iPz10ZCytI4N7KT1xPEOWerTfuxfYDlvcESd2qysrJNRgk/P9DFkknDn/qQaVME/ix2N0NlsMTDodn3c1JQu0EKzppPx1pzaA3t4C5xQoa/C8SkqJw8i3mT5PaiN1BH8TZwRSxau0dJTPSqwnZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on/t3uNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B128C433C7;
	Thu,  1 Feb 2024 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706812823;
	bh=EavXvVxLpjlqE3esGFobog0or2KVXWyptDAH7zpW1To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=on/t3uNS9+aVK3miPDTwjSmCY3tD3ooPbh5RjjfmMKRQzoVew2BAHtxIWYqsah19+
	 RJKanrgi1ISHEdggHxkWG0ECJIHqeAIzJsOa2Cnsu9KFfPlQPyhSNPBfjqeAfK1S2X
	 YwC3HExLHO4PIr0E34Cwsgjy8yKH6XmPbvkG6cVaeS6we6tt40nGKX+jfrn4eUZ66X
	 0n5+70nJ9zx5ir5H5OzP3TLFwWhXQrdYWD6xRe7jiY9kYYsB3EscZ5iRotgCLyPs8L
	 cg1p+7GETtzavEKDMvmqdhGo63vM+9Iu2K+lCwkOPvhkwKRpncCsxh3/z8lEmKsZji
	 6VbnRgJd2bNnw==
Date: Thu, 1 Feb 2024 12:40:22 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com
Subject: Re: [PATCH iwl-net 2/2] i40e: take into account XDP Tx queues when
 stopping rings
Message-ID: <ZbvlltcGnSsq/Pf7@do-x1extreme>
References: <20240201154219.607338-1-maciej.fijalkowski@intel.com>
 <20240201154219.607338-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201154219.607338-3-maciej.fijalkowski@intel.com>

On Thu, Feb 01, 2024 at 04:42:19PM +0100, Maciej Fijalkowski wrote:
> Seth reported that on his side XDP traffic can not survive a round of
> down/up against i40e interface. Dmesg output was telling us that we were
> not able to disable the very first XDP ring. That was due to the fact
> that in i40e_vsi_stop_rings() in a pre-work that is done before calling
> i40e_vsi_wait_queues_disabled(), XDP Tx queues were not taken into the
> account.
> 
> To fix this, let us distinguish between Rx and Tx queue boundaries and
> take into the account XDP queues for Tx side.
> 
> Reported-by: Seth Forshee <sforshee@kernel.org>
> Closes: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/
> Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

This fixes the issue we're seeing. Thanks!

Tested-by: Seth Forshee <sforshee@kernel.org>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 2c46a5e7d222..907be56965f5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -4926,21 +4926,22 @@ int i40e_vsi_start_rings(struct i40e_vsi *vsi)
>  void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
>  {
>  	struct i40e_pf *pf = vsi->back;
> -	int pf_q, q_end;
> +	u32 pf_q, tx_q_end, rx_q_end;
>  
>  	/* When port TX is suspended, don't wait */
>  	if (test_bit(__I40E_PORT_SUSPENDED, vsi->back->state))
>  		return i40e_vsi_stop_rings_no_wait(vsi);
>  
> -	q_end = vsi->base_queue + vsi->num_queue_pairs;
> -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> -		i40e_pre_tx_queue_cfg(&pf->hw, (u32)pf_q, false);
> +	tx_q_end = vsi->alloc_queue_pairs * (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
> +	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
> +		i40e_pre_tx_queue_cfg(&pf->hw, pf_q, false);
>  
> -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> +	rx_q_end = vsi->base_queue + vsi->num_queue_pairs;
> +	for (pf_q = vsi->base_queue; pf_q < rx_q_end; pf_q++)
>  		i40e_control_rx_q(pf, pf_q, false);
>  
>  	msleep(I40E_DISABLE_TX_GAP_MSEC);
> -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> +	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
>  		wr32(&pf->hw, I40E_QTX_ENA(pf_q), 0);
>  
>  	i40e_vsi_wait_queues_disabled(vsi);
> -- 
> 2.34.1
> 

