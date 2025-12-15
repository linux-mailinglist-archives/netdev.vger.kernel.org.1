Return-Path: <netdev+bounces-244772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1357DCBE547
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8626830011B5
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667BA261B71;
	Mon, 15 Dec 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty7e65Dd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4165D1898F8
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809564; cv=none; b=RHWPegdDvPShRIMWtB93yhYgfgtaFrZ/ORsBamVNC6OTWtx6akr/dG7s0UT5l4zYQ+3WgEhtp+5KRyM3WcH4TFwn5foHGC8QT0BcY0AtI9DI1bLnNOZ8RW2sjJH+uBmFWtGTklTRdRmnIHb9TVlnNetzP0/POGpdwPEzN6nGArg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809564; c=relaxed/simple;
	bh=3NGg7h6VupPWi0xMjm0X5TrbirWmgw7NiurTa5OD018=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWwW31Mkw5mJncUwpefnEqcWM+seZgbkc0bspW6O/2Td0k6IjRD5GDYn8aAU0Kq1oRzzWAir93i/7actZ4p29qUCEzOQIcZjZOvhkqOnYTd/lchOsZgZXygV/AC+PmZubCXlnjmlyxed3YHBN6KLRceGsucvCnV2Vak/w/7Uolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty7e65Dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D79C4CEF5;
	Mon, 15 Dec 2025 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765809563;
	bh=3NGg7h6VupPWi0xMjm0X5TrbirWmgw7NiurTa5OD018=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ty7e65DdD+aIvHa0EOs7D5ObsOVWmvNtHKv++yGdRenVF1ytjJsXDDT7iFHZh1OZs
	 yLsgRgF03XeRf0PSGzWXA3xWN6RDvpoOVUg7UMpixidYIsgl5InaWUi9co6xAB/DkI
	 nFihkT7uBhu7BOBDb/ZbkHIF6LnuerWsuJiLsMDTAY6UgroUkRPYfoei2P7rSzfvM1
	 uXEPQlIzHr3d57pg9Uo/GtrH9KqVOC4p6lqQ+cQDLiM2IW/5V0vm/Q+yua7/5Axr7J
	 +DTS8YrSHePd6xsShd6eWZp4YAog8xPMHAtGlrJDm9Svz9V4wAlCjW/TG8Y0lB7ild
	 J/u9f1SGi2MPQ==
Date: Mon, 15 Dec 2025 14:39:19 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Move net_devs registration in a
 dedicated routine
Message-ID: <aUAdlzPgf_lQKgLM@horms.kernel.org>
References: <20251214-airoha-fix-dev-registration-v1-1-860e027ad4c6@kernel.org>
 <aUAXJ01iHnSJtItt@horms.kernel.org>
 <aUAcHVULgJTpdGzT@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUAcHVULgJTpdGzT@lore-desk>

On Mon, Dec 15, 2025 at 03:33:01PM +0100, Lorenzo Bianconi wrote:
> > On Sun, Dec 14, 2025 at 10:30:07AM +0100, Lorenzo Bianconi wrote:
> > > Since airoha_probe() is not executed under rtnl lock, there is small race
> > > where a given device is configured by user-space while the remaining ones
> > > are not completely loaded from the dts yet. This condition will allow a
> > > hw device misconfiguration since there are some conditions (e.g. GDM2 check
> > > in airoha_dev_init()) that require all device are properly loaded from the
> > > device tree. Fix the issue moving net_devices registration at the end of
> > > the airoha_probe routine.
> > > 
> > > Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > 
> > Hi Lorenzo,
> > 
> > As a fix this patch looks good to me.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Hi Simon,
> 
> thx for the review.
> 
> > 
> > But I am somewhat surprised that the netdev isn't unregistered earlier
> > both in airoha_remove() and the unwind ladder of airoha_probe().
> 
> do you mean moving unregister_netdev() before
> airoha_qdma_stop_napi()/airoha_hw_cleanup()? I was thinking about it to be
> honest :)
> Since it is not related to this fix, I will post a patch as soon as net-next is
> open again.

Yes, that is what I was thinking.
And I agree that this is net-next material unrelated to this fix.

While you are there, I would look at making the unwind ladder
in probe follow the same pattern as remove, if possible.
I think that might mean moving airoha_ppe_deinit().

But perhaps you already thought of that too.
Or there is some good reason not to do so.



