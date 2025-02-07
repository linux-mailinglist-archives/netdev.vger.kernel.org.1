Return-Path: <netdev+bounces-164034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F64A2C654
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F5916A6F7
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85672238D2E;
	Fri,  7 Feb 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1S4h2aa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618F8238D26
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940235; cv=none; b=WZ4JL9gY+Q+nYhUeUiIYC7ZYGaBYnYEDAefqHTKq7vUracblhOqU0YTayJjYutcYGQB7FUslQKOE666Yt2k6uuzqDz9T07kAk/8Z7Q17Xi6GVH6kiFDo8zqoDAeEKnDl1MdEusvekuOalmrSfUKlhYecV23qSyXybdnpLA7GcMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940235; c=relaxed/simple;
	bh=5Bld7wfIGwWOXEK781i9Fo+q0vuOhNDcDamVB3lM6sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhR74enzMvqgZiE57TjKZzJenxbIRv3MLyPJ3SqIf9u6Zn7VdIt5qegrmnTAe9AIs2YZ3GwGCS+DCxI1vjGA09MRfzAX4L/f5nwRZlwNCBpsl0pvHv/5ae8DVH6a1nuzSqEANsOjp+r9xX4ySD+pYFCjoBmcRKZIoBwMV5zHxI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1S4h2aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08996C4CED1;
	Fri,  7 Feb 2025 14:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738940234;
	bh=5Bld7wfIGwWOXEK781i9Fo+q0vuOhNDcDamVB3lM6sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1S4h2aauLw15m8I6q0fNLRgJOsiz3Ap8ywkBHofNOjrO/OxbGODm9zNJThtVxsNV
	 EDZk2pddxNormkAd4dMo5GrOIavzso19D0bwoE2VHb9pOtuWljERvgX576T/aLAgBt
	 JOhb22kGVYsfpgnRyIJiUV1CBaUafu6d3HIyddY8TqDxU7OH4JwFZfeHVKbGUfOQYi
	 AXOiDuqjkAfnYInmHSQPXE7/UFG+mGopO9pGsa8I9b9YevKMcQ1TpeU/Wjj1DregYr
	 PDuEC6xtR3dSKQvBpmnYAbCnGfi+QDlmnNntQLQn2aAaTLw80JL4uvyOXTahWTGdXc
	 6aNggYoZbeSwQ==
Date: Fri, 7 Feb 2025 14:57:10 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com, jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com, dawid.osuchowski@intel.com
Subject: Re: [iwl-next v1 3/4] ixgbe: add Tx hang detection unhandled MDD
Message-ID: <20250207145710.GX554665@kernel.org>
References: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
 <20250207104343.2791001-4-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207104343.2791001-4-michal.swiatkowski@linux.intel.com>

On Fri, Feb 07, 2025 at 11:43:42AM +0100, Michal Swiatkowski wrote:
> From: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> 
> Add Tx Hang detection due to an unhandled MDD Event.
> 
> Previously, a malicious VF could disable the entire port causing
> TX to hang on the E610 card.
> Those events that caused PF to freeze were not detected
> as an MDD event and usually required a Tx Hang watchdog timer
> to catch the suspension, and perform a physical function reset.
> 
> Implement flows in the affected PF driver in such a way to check
> the cause of the hang, detect it as an MDD event and log an
> entry of the malicious VF that caused the Hang.
> 
> The PF blocks the malicious VF, if it continues to be the source
> of several MDD events.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> Co-developed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> index aa3b498558bc..e07b56625595 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> @@ -1044,6 +1044,7 @@ struct ixgbe_nvm_version {
>  #define IXGBE_GCR_EXT_VT_MODE_16        0x00000001
>  #define IXGBE_GCR_EXT_VT_MODE_32        0x00000002
>  #define IXGBE_GCR_EXT_VT_MODE_64        0x00000003
> +#define IXGBE_GCR_EXT_VT_MODE_MASK	0x00000003

nit: For consistency I think spaces should be used to indent 0x00000003

>  #define IXGBE_GCR_EXT_SRIOV             (IXGBE_GCR_EXT_MSIX_EN | \
>  					 IXGBE_GCR_EXT_VT_MODE_64)
>  

...

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

...

> +static u32 ixgbe_poll_tx_icache(struct ixgbe_hw *hw, u16 queue, u16 idx)
> +{
> +	IXGBE_WRITE_REG(hw, IXGBE_TXDESCIC, queue * idx);
> +	return IXGBE_READ_REG(hw, IXGBE_TXDESCIC);
> +}
> +
> +/**
> + * ixgbe_check_illegal_queue - search for queue with illegal packet
> + * @adapter: structure containing ring specific data
> + * @queue: queue index
> + *
> + * Check if tx descriptor connected with input queue
> + * contains illegal packet.
> + *
> + * Returns: true if queue contain illegal packet.
> + */
> +static bool ixgbe_check_illegal_queue(struct ixgbe_adapter *adapter,
> +				      u16 queue)
> +{
> +	u32 hdr_len_reg, mss_len_reg, type_reg;
> +	struct ixgbe_hw *hw = &adapter->hw;
> +	u32 mss_len, header_len, reg;
> +
> +	for (u16 i = 0; i < IXGBE_MAX_TX_DESCRIPTORS; i++) {
> +		/* HW will clear bit IXGBE_TXDESCIC_READY when address
> +		 * is written to address field. HW will set this bit
> +		 * when iCache read is done, and data is ready at TIC_DWx.
> +		 * Set descriptor address.
> +		 */
> +		read_poll_timeout(ixgbe_poll_tx_icache, reg,
> +				  !(reg & IXGBE_TXDESCIC_READY), 0, 0, false,
> +				  hw, queue, i);
> +
> +		/* read tx descriptor access registers */
> +		hdr_len_reg = IXGBE_READ_REG(hw, IXGBE_TIC_DW2(IXGBE_VLAN_MACIP_LENS_REG));
> +		type_reg = IXGBE_READ_REG(hw, IXGBE_TIC_DW2(IXGBE_TYPE_TUCMD_MLHL));
> +		mss_len_reg = IXGBE_READ_REG(hw, IXGBE_TIC_DW2(IXGBE_MSS_L4LEN_IDX));
> +
> +		/* check if Advanced Context Descriptor */
> +		if (FIELD_GET(IXGBE_ADVTXD_DTYP_MASK, type_reg) !=
> +		    IXGBE_ADVTXD_DTYP_CTXT)
> +			continue;
> +
> +		/* check for illegal MSS and Header length */
> +		mss_len = FIELD_GET(IXGBE_ADVTXD_MSS_MASK, mss_len_reg);
> +		header_len = FIELD_GET(IXGBE_ADVTXD_HEADER_LEN_MASK,
> +				       hdr_len_reg);
> +		if ((mss_len + header_len) > SZ_16K) {
> +			e_warn(probe,
> +			       "mss len + header len too long\n");

nit: The above two lines can be a single line.

> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * ixgbe_handle_mdd_event - handle mdd event
> + * @adapter: structure containing ring specific data
> + * @tx_ring: tx descriptor ring to handle
> + *
> + * Reset VF driver if malicious vf detected or
> + * illegal packet in an any queue detected.
> + */
> +static void ixgbe_handle_mdd_event(struct ixgbe_adapter *adapter,
> +				   struct ixgbe_ring *tx_ring)
> +{
> +	u16 vf, q;
> +
> +	if (adapter->vfinfo && ixgbe_check_mdd_event(adapter)) {
> +		/* vf mdd info and malicious vf detected */
> +		if (!ixgbe_get_vf_idx(adapter, tx_ring->queue_index, &vf))
> +			ixgbe_vf_handle_tx_hang(adapter, vf);
> +	} else {
> +		/* malicious vf not detected */
> +		for (q = 0; q < IXGBE_MAX_TX_QUEUES; q++) {
> +			if (ixgbe_check_illegal_queue(adapter, q) &&
> +			    !ixgbe_get_vf_idx(adapter, q, &vf))
> +				/* illegal queue detected */
> +				ixgbe_vf_handle_tx_hang(adapter, vf);

It looks like ixgbe_vf_handle_tx_hang() will run for each illegal queue.
Could that be more than once for a given vf? If so, is that desirable?

> +		}
> +	}
> +}
> +
>  /**
>   * ixgbe_clean_tx_irq - Reclaim resources after transmit completes
>   * @q_vector: structure containing interrupt and ring information

...

