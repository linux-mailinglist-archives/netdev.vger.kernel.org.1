Return-Path: <netdev+bounces-160549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC472A1A21B
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AB9166640
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ADE20D4FF;
	Thu, 23 Jan 2025 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URS7STw2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12F20CCD6
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629141; cv=none; b=lOK0AECtt81ZCnmiDrRP5qYt0lFslIC423M+oPHvWx5JwonIH7N/HNYMfaQiAuw95E4lLiSQS7NGXkDJO7zl18wAF8xeNN2qxPhaPtgMzpPHOF6/lTRG2b5aC7ei3sB65bp4/fgxG4fMRh0m+qlGnKKs94oWC+RxBGD0vih5ZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629141; c=relaxed/simple;
	bh=gXvoSdYpixtFkIqe5bF2z0g9L9R1r/OvhJINMvk/vqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBZqIb7V3NtsFwq3SKmUMmfGPuLYzdt3StlLWvIjAmnhtetLZwseuw49Rv2qJWb6ylmLHjdKFDZUPSZXVpLahOafcF5+2eQpD1rts1NoEOJLgo70RBhlfVtT76HTD1uYY/ZVHZNYkeYvUZqFZ+an1FfmB9RcfkMnrGdywX4KVrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URS7STw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E51C4CED3;
	Thu, 23 Jan 2025 10:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737629140;
	bh=gXvoSdYpixtFkIqe5bF2z0g9L9R1r/OvhJINMvk/vqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URS7STw2RySfSpzp3OouwL2+syn3B7r2D3Ibejo/64rJgDOYV04oB5EmQG/22AezR
	 GzPlyhdiOeLtcIiopX5kqcOYJpCUySjEIy3yi35CxQWMMndOqCjthLut+CMkIwfXhG
	 Kyq5apESxLsoQhY2B9YBgHxvf36S4r7l5gKWU0itsyTN/bZzBJv2irPqtXowCYJ6Fp
	 FgvvYncw4C2CLBC+FqIyS4s9k/jzavfrkl5CzjZ6N/RNq0A20Q2LvetGEMrDBEISEq
	 v7GUzQE0ET1vp8eulTepA5SDRjYrpYO9wWTr7WiVEJSO6z8EHmHrDcAf4UrWHoWcDO
	 i0ch7e359WLmg==
Date: Thu, 23 Jan 2025 10:45:36 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
	jacob.e.keller@intel.com, xudu@redhat.com, mschmidt@redhat.com,
	jmaxwell@redhat.com, poros@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v4 iwl-net 3/3] ice: stop storing XDP verdict within
 ice_rx_buf
Message-ID: <20250123104536.GL395043@kernel.org>
References: <20250122151046.574061-1-maciej.fijalkowski@intel.com>
 <20250122151046.574061-4-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122151046.574061-4-maciej.fijalkowski@intel.com>

On Wed, Jan 22, 2025 at 04:10:46PM +0100, Maciej Fijalkowski wrote:
> Idea behind having ice_rx_buf::act was to simplify and speed up the Rx
> data path by walking through buffers that were representing cleaned HW
> Rx descriptors. Since it caused us a major headache recently and we
> rolled back to old approach that 'puts' Rx buffers right after running
> XDP prog/creating skb, this is useless now and should be removed.
> 
> Get rid of ice_rx_buf::act and related logic. We still need to take care
> of a corner case where XDP program releases a particular fragment.
> 
> Make ice_run_xdp() to return its result and use it within
> ice_put_rx_mbuf().
> 
> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 61 +++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 -
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 43 -------------
>  3 files changed, 35 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c

...

> @@ -1139,23 +1136,27 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
>   * returned by XDP program;
>   */
>  static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> -			    u32 *xdp_xmit, u32 ntc)
> +			    u32 *xdp_xmit, u32 ntc, u32 verdict)

Hi Marciej,

Sorry, there is one more Kernel doc nit. As reported by the Kernel Test
Robot, verdict should be added to the Kernel doc for this function.

With that addressed feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

...

