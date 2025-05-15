Return-Path: <netdev+bounces-190707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FA4AB852E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AD616923C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314D229826D;
	Thu, 15 May 2025 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5GJrYui"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0092980B8
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309609; cv=none; b=qeIExB8jJ/wvWLj3iPV0VcoHkEyrAqAuUZyI8mYh+MaVChjztZJODdCWpEzzetW1U+p8WjOOFb2qCvqOJFl2VigF178nOP7Npxt+4ELiOPrSsGAGoqtgGhfG5Et6VWyZjCiRDeMtOM5P211htp46zMmZC5HNc5B6ALjyFUXwtZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309609; c=relaxed/simple;
	bh=vxJ1lJpDsokpa+3eqqj8W/hw7hRFfKPXaUCS5sNBDaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNZu6mDKMkUc4l/FAL5JCIdyER1P5Phj0zBrq7q4ljxZ/rZQO8ShcmAMVVIIMuK60FQjOkscrgCLX8EbtS2f23moQr0kXHUkDFB2HFe22xd15TOhy/BXk2GmVYlGj2SZLN92q3U3QKZSal2M46U7Z2tYD3f313B7CpFT+/l2plk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5GJrYui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4AFC4CEE7;
	Thu, 15 May 2025 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747309608;
	bh=vxJ1lJpDsokpa+3eqqj8W/hw7hRFfKPXaUCS5sNBDaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5GJrYui6Neqip2Tdi88KT8vqKUr/aOlX5Mr8fasyFqNbjETDWUYwIOA7LxlACcRU
	 XprmjGC7X7/CLN/CjPZhoUce8NSMNl/ef9cqoVju34XMiYNOOTMCbI1Wh4aS7DF9WO
	 Fxm98Kt9cBE1VsTJ515XLRwTgq69KlZTOW6JwYSRqgjPjD6wg3NdePNGnTHoECTROV
	 aLkV4x/GAb2RPDve7E+bA/Py0uIRCw0ddS7sv4DhkDwTlXn1Mw6n5hHu8gcrXMOLyA
	 1fBs1VOzPa1tkPYCeNurRTVf1yqTTkth9t/ydkcsuWb9vciKZ1gaxT8bOOm8A/532+
	 CM/Klz9/j7nGA==
Date: Thu, 15 May 2025 12:46:44 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com, jacob.e.keller@intel.com,
	jbrandeburg@cloudflare.com, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v3 3/3] ice: fix rebuilding the Tx scheduler tree
 for large queue counts
Message-ID: <20250515114644.GW3339421@horms.kernel.org>
References: <20250513105529.241745-1-michal.kubiak@intel.com>
 <20250513105529.241745-4-michal.kubiak@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513105529.241745-4-michal.kubiak@intel.com>

On Tue, May 13, 2025 at 12:55:29PM +0200, Michal Kubiak wrote:
> The current implementation of the Tx scheduler allows the tree to be
> rebuilt as the user adds more Tx queues to the VSI. In such a case,
> additional child nodes are added to the tree to support the new number
> of queues.
> Unfortunately, this algorithm does not take into account that the limit
> of the VSI support node may be exceeded, so an additional node in the
> VSI layer may be required to handle all the requested queues.
> 
> Such a scenario occurs when adding XDP Tx queues on machines with many
> CPUs. Although the driver still respects the queue limit returned by
> the FW, the Tx scheduler was unable to add those queues to its tree
> and returned one of the errors below.
> 
> Such a scenario occurs when adding XDP Tx queues on machines with many
> CPUs (e.g. at least 321 CPUs, if there is already 128 Tx/Rx queue pairs).
> Although the driver still respects the queue limit returned by the FW,
> the Tx scheduler was unable to add those queues to its tree and returned
> the following errors:
> 
>      Failed VSI LAN queue config for XDP, error: -5
> or:
>      Failed to set LAN Tx queue context, error: -22
> 
> Fix this problem by extending the tree rebuild algorithm to check if the
> current VSI node can support the requested number of queues. If it
> cannot, create as many additional VSI support nodes as necessary to
> handle all the required Tx queues. Symmetrically, adjust the VSI node
> removal algorithm to remove all nodes associated with the given VSI.
> Also, make the search for the next free VSI node more restrictive. That is,
> add queue group nodes only to the VSI support nodes that have a matching
> VSI handle.
> Finally, fix the comment describing the tree update algorithm to better
> reflect the current scenario.
> 
> Fixes: b0153fdd7e8a ("ice: update VSI config dynamically")
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


