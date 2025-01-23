Return-Path: <netdev+bounces-160544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EB6A1A20A
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046D91882455
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893E20DD73;
	Thu, 23 Jan 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+R+SER/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6449020CCD6
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628988; cv=none; b=s72brT3hpyFw8fZnpecvkbwbZsaVSZWqt3E/GNPhQbI2T4W8QxMyAEELp+A4XarWcEDFulCkrBgeJZA0+ctYnTjRpMUeI0nYLFw9ia2P2xQINDu9XmFmItfNPADrvCuXNitWo5MWqtky+7w2AQwTsucvSA8ZRdLZAvalw8DmBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628988; c=relaxed/simple;
	bh=2GQbGUS1wJQc4Ky9t4ihKM4Dc3qUZ8b7Jo6+U6rH8LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXfr/NyNi1XqjG35Pdek0WoHnHYZES3gBhc7URa2SHfhTve4BSgRy6MPNGZ2IrJht7vDrhPsD6IcJIAgKdV1qcOC6xkAtBSMzH59rzbUkkAeoVpy80XEnCyvjzWqqCQh6nUuj7zl0umPKZoCSG3joNnzcGqZkshz0klubxuGtaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+R+SER/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200BCC4CED3;
	Thu, 23 Jan 2025 10:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737628988;
	bh=2GQbGUS1wJQc4Ky9t4ihKM4Dc3qUZ8b7Jo6+U6rH8LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+R+SER/dr+BbH6v7s1u8zD9TbUMoH+k8bDIXLNX0uKzxQxUrYohb9FehVjMPIoKX
	 2W4OiyytV71o4s9je1JZsgQku1h7TsIt8Fhwbg+qXun6Uv5wjrk9q98RBEOQZmLNuR
	 3xoMpxcOzjq38ZsiElB7G+hdMwyNe5pMAhW4klwAtLv5lpYvJSJkDU3ok8sUe3uszd
	 RjZjLPyfJ77BeM2o0MtberEZC13THr22HXB49ORHt+Jjk/2Er7TmybO6ho2AQHh7CV
	 bgw5T2ZmoVkRMAuV5+0YxWM78BDGDZtnh9dUVRuJjqoP1Z/XdiusBwdB08+Mt5kuj/
	 NDOSvZ/6UFMaA==
Date: Thu, 23 Jan 2025 10:43:03 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
	jacob.e.keller@intel.com, xudu@redhat.com, mschmidt@redhat.com,
	jmaxwell@redhat.com, poros@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v4 iwl-net 1/3] ice: put Rx buffers after being done with
 current frame
Message-ID: <20250123104303.GJ395043@kernel.org>
References: <20250122151046.574061-1-maciej.fijalkowski@intel.com>
 <20250122151046.574061-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122151046.574061-2-maciej.fijalkowski@intel.com>

On Wed, Jan 22, 2025 at 04:10:44PM +0100, Maciej Fijalkowski wrote:
> Introduce a new helper ice_put_rx_mbuf() that will go through gathered
> frags from current frame and will call ice_put_rx_buf() on them. Current
> logic that was supposed to simplify and optimize the driver where we go
> through a batch of all buffers processed in current NAPI instance turned
> out to be broken for jumbo frames and very heavy load that was coming
> from both multi-thread iperf and nginx/wrk pair between server and
> client. The delay introduced by approach that we are dropping is simply
> too big and we need to take the decision regarding page
> recycling/releasing as quick as we can.
> 
> While at it, address an error path of ice_add_xdp_frag() - we were
> missing buffer putting from day 1 there.
> 
> As a nice side effect we get rid of annoying and repetitive three-liner:
> 
> 	xdp->data = NULL;
> 	rx_ring->first_desc = ntc;
> 	rx_ring->nr_frags = 0;
> 
> by embedding it within introduced routine.
> 
> Fixes: 1dc1a7e7f410 ("ice: Centrallize Rx buffer recycling")
> Reported-and-tested-by: Xu Du <xudu@redhat.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

