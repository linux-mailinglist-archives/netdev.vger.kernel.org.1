Return-Path: <netdev+bounces-165110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802EFA307E4
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02703A4B0C
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147C1F238D;
	Tue, 11 Feb 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiABRgNo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4771F2389
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268131; cv=none; b=CfKNyQKW4RbH20c89fj2BnhTm4gQw3NVu3jeKv6TmKGPp8s2LC4Fj+4POB54SQ72UJ58RQdoNaQmWDTQUr56h6jkZ0Vhyy9Q3GAWis+WdYbtMvbd4uAlBrF1ILwudAiJq2C5hy155CRqX9HD7K5WT4WLws7IIcITl2selugCvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268131; c=relaxed/simple;
	bh=2XFOQGto3PgiVagmbsZZvoYAv2IJ2PJRYkFrOjY6j5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOYB4ok/Iym2Y4e2GXGSlygaZumCJnb6S61EXSXTUhQtgUAPhCxPGaegCPeHq9yWiMFjYHEaNxGtbVDg0CyypoD10amM/P/nHgeHto/0iwrmvj/u1shdPKJSAegUAFzYJgivjXzDrJS09iFwZxEDgPvWUpscOMKuVMcCXCgp1U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiABRgNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768D9C4CEE6;
	Tue, 11 Feb 2025 10:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739268131;
	bh=2XFOQGto3PgiVagmbsZZvoYAv2IJ2PJRYkFrOjY6j5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiABRgNoVvDoqW9Y4SAkclBCh+0y82rW/cDGb4kHx4P5H1g8Ct0Kbd4RpuhpKHLvL
	 IzXaNzavUysztdEqLb6fLivNcd7ah7tHDl6A70mBfr/fAJ8UYtwh/i/6KaxaxiLGZN
	 3JY41WNrpLgnaCmobYey5dXLALshVoB2yAVrKxnCLFETOnpwyGx0LRiwr5+jcLh2Gl
	 6c4g5/n6xna7tebU6QalYjPnW9RIIcMezMIFoX8fD02s29P6iyC0fHsBN4PiVFI46i
	 IuAOjJdjKvidhSHAczcRLOGmnUYQouMQYJaC9ZvjUw6ITLNzVIKx3N8rfWznk/M649
	 p9GGYWwfQp/Vw==
Date: Tue, 11 Feb 2025 10:02:07 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com, jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com, dawid.osuchowski@intel.com
Subject: Re: [iwl-next v1 3/4] ixgbe: add Tx hang detection unhandled MDD
Message-ID: <20250211100207.GG554665@kernel.org>
References: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
 <20250207104343.2791001-4-michal.swiatkowski@linux.intel.com>
 <20250207145710.GX554665@kernel.org>
 <Z6mTraxmxHzsvrZ3@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6mTraxmxHzsvrZ3@mev-dev.igk.intel.com>

On Mon, Feb 10, 2025 at 06:50:37AM +0100, Michal Swiatkowski wrote:
> On Fri, Feb 07, 2025 at 02:57:10PM +0000, Simon Horman wrote:
> > On Fri, Feb 07, 2025 at 11:43:42AM +0100, Michal Swiatkowski wrote:

...

> > > +/**
> > > + * ixgbe_handle_mdd_event - handle mdd event
> > > + * @adapter: structure containing ring specific data
> > > + * @tx_ring: tx descriptor ring to handle
> > > + *
> > > + * Reset VF driver if malicious vf detected or
> > > + * illegal packet in an any queue detected.
> > > + */
> > > +static void ixgbe_handle_mdd_event(struct ixgbe_adapter *adapter,
> > > +				   struct ixgbe_ring *tx_ring)
> > > +{
> > > +	u16 vf, q;
> > > +
> > > +	if (adapter->vfinfo && ixgbe_check_mdd_event(adapter)) {
> > > +		/* vf mdd info and malicious vf detected */
> > > +		if (!ixgbe_get_vf_idx(adapter, tx_ring->queue_index, &vf))
> > > +			ixgbe_vf_handle_tx_hang(adapter, vf);
> > > +	} else {
> > > +		/* malicious vf not detected */
> > > +		for (q = 0; q < IXGBE_MAX_TX_QUEUES; q++) {
> > > +			if (ixgbe_check_illegal_queue(adapter, q) &&
> > > +			    !ixgbe_get_vf_idx(adapter, q, &vf))
> > > +				/* illegal queue detected */
> > > +				ixgbe_vf_handle_tx_hang(adapter, vf);
> > 
> > It looks like ixgbe_vf_handle_tx_hang() will run for each illegal queue.
> > Could that be more than once for a given vf? If so, is that desirable?
> > 
> 
> Yes, it will be called for each hanged queue of a given VF. I assume
> this is fine, as the function is counting the hang events, not resetting
> VF.

Thanks for the clarification, much appreciated.

I missed that this is just accounting and agree this seems fine.

...

