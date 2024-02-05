Return-Path: <netdev+bounces-69085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4AE849893
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DF0286D67
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EAE182C3;
	Mon,  5 Feb 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sn8jNGpH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94118E08
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131616; cv=none; b=FylCbi2WmmG4qEu/IXr2enVhAkLyD2MO8i0HkVFxI0FbCdqNn2+f27LQKido7OPb+2+PllyQK91NsfKDBbEA+RxjJ8fYw93HeFb+/wVyrfLEGfZelOXeG5dwiRJH3GhVyfvAiZ9M8E+0kpfzxqeCEDFRfVYmiQM+9v1dskfrCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131616; c=relaxed/simple;
	bh=qiyJcgmXr99ZarDMYq7VLCkuujzBIzl3EqIkNIzXRhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0JXG5wYNQpFK9xHj5PXtGF9jiHBqQIuxHYEu5PoVctjbxPMiMIlqr+8M5MWzJTvH/f8W0cp1mxG2b+3MM40J+Yde5y43ZI/vUcr5hVPRw9iiW0F4wCk1BjKLJjP7vtcGqyMlUz0fmCFGc7FvI2HdiU1tIgWfqNO9rmEZtHWaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sn8jNGpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77B6C433C7;
	Mon,  5 Feb 2024 11:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707131616;
	bh=qiyJcgmXr99ZarDMYq7VLCkuujzBIzl3EqIkNIzXRhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sn8jNGpHH/MLlXJThUYm7xb917OyH2VY7m8M+bLEnFKBBiNHS8qFqbhsXjq59pcR9
	 NvrTIwhjXOLBN1yHFdzOdv/BW8KDn5Uu3TaQcJI+3gpSYN2i+GmGR8rpeuyHyOn1Xc
	 mz87kxGDILwXHkhhFzneKT6NXnzCwvRdzl60lJH6GI7iUY7rXL+k2J8NCxJnmZQYOG
	 SWC63lCXTpon7o10Qt3XnQ7tDkePAkaxSQSLi5y04roI88m7tu4bvfX4tQjoCbOqDS
	 1WAAoHcctsj/QHT5K3e5x6VPe2cNVym8R/iU9tNL+BDPtSrStCP0DpIeyWEK1EJ1L/
	 il8NId+MlPWEw==
Date: Mon, 5 Feb 2024 11:13:32 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com
Subject: Re: [PATCH iwl-net 1/2] i40e: avoid double calling i40e_pf_rxq_wait()
Message-ID: <20240205111332.GH960600@kernel.org>
References: <20240201154219.607338-1-maciej.fijalkowski@intel.com>
 <20240201154219.607338-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201154219.607338-2-maciej.fijalkowski@intel.com>

On Thu, Feb 01, 2024 at 04:42:18PM +0100, Maciej Fijalkowski wrote:
> Currently, when interface is being brought down and
> i40e_vsi_stop_rings() is called, i40e_pf_rxq_wait() is called two times,
> which is wrong. To showcase this scenario, simplified call stack looks
> as follows:
> 
> i40e_vsi_stop_rings()
> 	i40e_control wait rx_q()
> 		i40e_control_rx_q()
> 		i40e_pf_rxq_wait()
> 	i40e_vsi_wait_queues_disabled()
> 		i40e_pf_rxq_wait()  // redundant call
> 
> To fix this, let us s/i40e_control_wait_rx_q/i40e_control_rx_q within
> i40e_vsi_stop_rings().
> 
> Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


