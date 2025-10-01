Return-Path: <netdev+bounces-227496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE651BB131F
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 17:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AE8194736C
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F97285CAF;
	Wed,  1 Oct 2025 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgxhURll"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9582853EA;
	Wed,  1 Oct 2025 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334344; cv=none; b=OUG0dputKcXeKlzvHuMFw4BKclgBJDF7qCaB26dlaliAfbjgHddigvkVSJGTibgqUtnJUSKhocjRcRkV3L4pE1cNexU269IDnhmWzV0BqddoAmZ8LBCZ/WzrlwJwTBoYYzTGVgLkHEPD4WUksrDOnEBbbZ00SZTBJa8CyDc8hBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334344; c=relaxed/simple;
	bh=DeMKRKU3xRJZbYNpgvsllh63nE3v4HH/2QRTFBnT5SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0TJ5Fq1a5yUlv1lj5Lif2dAfoDcLPCYmU8We+7gqODI3TdRPWGq/JrjEoF/3Zlw0FT2C1Emd93Wbbwjww48csUxBfYu/VHHLJeEFZVr6haQL7PlOzWgS3ftOfeQuKFJXgfjw5OMU53WSUCyu6RJfUQ0nh4qROoa6FNXbE5DW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgxhURll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22339C4CEF1;
	Wed,  1 Oct 2025 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759334343;
	bh=DeMKRKU3xRJZbYNpgvsllh63nE3v4HH/2QRTFBnT5SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgxhURllZTMoEVbbK3LTCkTiFV5NwTyc1jwXsS/dOVdTALTXX3qd2iERv5SIyKrK6
	 UYCIbTYw0Uj2dYUeSrorDWxtbW/To1aFOHA0wkOjMzcxmOyQ/3229rLAeaiX+9paxy
	 EQK48wlNX9eHftFQtjA/XFVMuzAxX8Egy/fKwLfZwZERDauaTCnbCqls8L2SYy7scN
	 VKsAZdy0lKsaprd9IunnFnrQT8LVSdguG+QBQ3Tx+s3l4I6TyC/0ipvFNkiaj6pLie
	 FXFMlo35UTDt9uf5+JtqjXbItsGmiJM1J7KncEX6kQotyml58ZGCJNQQGLwalbDs0r
	 +AAjeu/iwKDXw==
Date: Wed, 1 Oct 2025 16:58:58 +0100
From: Simon Horman <horms@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V2 3/3] net: ethernet: ti: Remove IS_ERR_OR_NULL checks
 for knav_dma_open_channel
Message-ID: <aN1Pwh3B8xhEoQmh@horms.kernel.org>
References: <20250930121609.158419-1-nm@ti.com>
 <20250930121609.158419-4-nm@ti.com>
 <0cae855b-e842-47a1-9aaf-b2a297ec32d6@intel.com>
 <20251001105416.frbebh5ws2rnxquu@quality>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001105416.frbebh5ws2rnxquu@quality>

On Wed, Oct 01, 2025 at 05:54:16AM -0500, Nishanth Menon wrote:
> On 16:59-20250930, Jacob Keller wrote:
> > 
> > 
> > On 9/30/2025 5:16 AM, Nishanth Menon wrote:
> > > knav_dma_open_channel now only returns NULL on failure instead of error
> > > pointers. Replace IS_ERR_OR_NULL checks with simple NULL checks.
> > > 
> > > Suggested-by: Simon Horman <horms@kernel.org>
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > ---
> > > Changes in V2:
> > > * renewed version
> > > * Dropped the fixes since code refactoring was involved.
> > > 
> > 
> > Whats the justification for splitting this apart from patch 1 of 3?
> > 
> > It seems like we ought to just do all this in a single patch. I don't
> > see the value in splitting this apart into 3 patches, unless someone
> > else on the list thinks it is valuable.
> 
> The only reason I have done that is to ensure the patches are
> bisectable. at patch #1, we are still returning -EINVAL, the driver
> should still function when we switch the return over to NULL.

Maybe we can simplify things and squash all three patches into one.
They seem inter-related.

