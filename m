Return-Path: <netdev+bounces-230379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2FEBE75FB
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5792E6E112D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FC62D24B6;
	Fri, 17 Oct 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEu1FvJl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822742D23BC;
	Fri, 17 Oct 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691843; cv=none; b=C7VakOvpcqJTqtRxqMVikOmA3N39WUxmRFO018GVnfjgw5w77HxWR0OeoS6iACP31e/mxHibT2m2BXzaz/sOsEsan73hbpzawjsZgB6i9X9gi5VHIlRzEkwILls7k9QL7MnQ8ZoyLqepkzqWOGxWk/EamreMbLOzh5+kRa0E2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691843; c=relaxed/simple;
	bh=QNmXg1NQce/rbsYUus5eRynSuEETKLinHBFOl1Svxwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg3jWpOaq1pxdsjJn07njl22iEvHcSNFHtW0EzlVNsLFKWIVU5hjdW3LclvD0S37bN7fY7PLrxtu9e2AHmOhwuLtf4FOHN5aVKcD/Rns+8cYz1ybIKYRUovo1sytY+QaPNISK5y/xJd7YPR/iM4hYdWpM8T7pox2gQxVErrpYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEu1FvJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E7FC4CEE7;
	Fri, 17 Oct 2025 09:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760691843;
	bh=QNmXg1NQce/rbsYUus5eRynSuEETKLinHBFOl1Svxwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEu1FvJl59Euf2k+r7Ef+qLASph7yf9nBwS6B3hSBC/ugBg/iixO4dRFGCilOWVFM
	 BodWpreE2G9QJpXVRzfXWGxN4lheVRyCoyfoJZOR5BHXxbDCNI0DHC1xBg259LJL/l
	 DMPtjzkNWgB3pBgKdjuHXhMx9+QLA+aTIq4zLNFyOnLG81J/wnIJ4G/0S3ltNdBKeV
	 f7YPZnAyaez95XuxBTkNV5oKP4tJre0uELqlUzfPTwxIzFUKRsesHDxrc9vvnWhdSW
	 5T4CX0WI87P4CKT+9ry5dzjSlFTVwn8dV9JpY50nvA1fqPnTDiv+0D3R0u4z9VJ4Cv
	 V3/stFI6yQFJw==
Date: Fri, 17 Oct 2025 10:03:59 +0100
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mathew McBride <matt@traverse.com.au>
Subject: Re: [PATCH net] dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx
 path
Message-ID: <aPIGf4aY6cbIa2AP@horms.kernel.org>
References: <20251016135807.360978-1-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016135807.360978-1-ioana.ciornei@nxp.com>

On Thu, Oct 16, 2025 at 04:58:07PM +0300, Ioana Ciornei wrote:
> The blamed commit increased the needed headroom to account for
> alignment. This means that the size required to always align a Tx buffer
> was added inside the dpaa2_eth_needed_headroom() function. By doing
> that, a manual adjustment of the pointer passed to PTR_ALIGN() was no
> longer correct since the 'buffer_start' variable was already pointing
> to the start of the skb's memory.
> 
> The behavior of the dpaa2-eth driver without this patch was to drop
> frames on Tx even when the headroom was matching the 128 bytes
> necessary. Fix this by removing the manual adjust of 'buffer_start' from
> the PTR_MODE call.
> 
> Closes: https://lore.kernel.org/netdev/70f0dcd9-1906-4d13-82df-7bbbbe7194c6@app.fastmail.com/T/#u
> Fixes: f422abe3f23d ("dpaa2-eth: increase the needed headroom to account for alignment")
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Tested-by: Mathew McBride <matt@traverse.com.au>

Reviewed-by: Simon Horman <horms@kernel.org>


