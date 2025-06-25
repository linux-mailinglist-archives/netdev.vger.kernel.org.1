Return-Path: <netdev+bounces-201307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F95BAE8DF3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 21:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6291C25C55
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EE91F4C8B;
	Wed, 25 Jun 2025 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9UOVePr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644015278E
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878172; cv=none; b=OCBpIG/kyghULLQMBlJBZ5AGOupk/vM740MZTrEpWExfEXP0jsDcAB2h6YgfwFs3+2tatClAi5SWAS4ai/n88jxdWxim0DM+TnNjAR+FKztl7g13wF/+HbIYlEiVEDfxCsDqXtkPrFHi89iwz8p/7Z7X0WecSk0g6kJl1vWqB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878172; c=relaxed/simple;
	bh=Jfatm5KMgC7oxWwBBIa8o65hiTAz9CwIKYnpmuQjYBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3KOSCIKcPHaHDbvG4tiTclxw5SXKmrBDNqLr5jx6apid7oYN0MzbxxcH5OhqHRRmyAHwc7NzUXgXi7y7Ol29aJqj0DNm1r78XRHC/ZWZPSfXPiNuO0kYHDwv9f3pQ539KomooBbOKAhrUza61E2sVURH+QZco9NA1SDZpr3UHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9UOVePr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B03BC4CEEA;
	Wed, 25 Jun 2025 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750878171;
	bh=Jfatm5KMgC7oxWwBBIa8o65hiTAz9CwIKYnpmuQjYBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9UOVePrhigw9fMO7imOqkyPR/JPq15dyC7LTEqzwaVozlY78NuJN20a/6ACm+dUw
	 u/W/JEXyeIZE5E0T9z1kkp+/aqbWZydT8EzbmeK9D6UC3AcFQz2GY12gGHGLceE13X
	 vFJyOvnvT2g9eOgUlA2RQXkGRDjze5py5SBPh217lLLR1z1R7ve2WXdxNYEHfTtntZ
	 gEAJ4Ken4c92WWyVWjV4KVjd+0rYv36gLqMRFX+UGFTqd6Lx90exTXqPVrmtqJKIzM
	 bjDYeyeCsE+h1lRPPdAp9gqb+q/R15V4wJ0BJ+HNq4wgpjAl0vf3J7hDxaZWo9PLsz
	 8IBAKkxoe3KdQ==
Date: Wed, 25 Jun 2025 20:02:47 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
	netdev@vger.kernel.org, Suman Ghosh <sumang@marvell.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Check for DMAC extraction before
 setting VF DMAC
Message-ID: <20250625190247.GO1562@horms.kernel.org>
References: <1750851002-19418-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1750851002-19418-1-git-send-email-sbhatta@marvell.com>

On Wed, Jun 25, 2025 at 05:00:02PM +0530, Subbaraya Sundeep wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> Currently while setting a MAC address of a PF's VF (e.g. ip link set
> <pf-netdev> vf 0 mac <mac-address>), it simply tries to install a DMAC
> based hardware filter. But it is possible that the loaded hardware parser
> profile does not support DMAC extraction. Hence check for DMAC extraction
> before installing the filter.

Makes sense to me, but should this be treated as a bug fix?

> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

...

