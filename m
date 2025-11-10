Return-Path: <netdev+bounces-237281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECF0C486A8
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA3A3AE40F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CAD2E542B;
	Mon, 10 Nov 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjBCbPjF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB792DE1E6;
	Mon, 10 Nov 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796893; cv=none; b=etT8UQpYEqbcffhXi98n1ZNy45T3d+0RxN0d03jJoqN2UadUqLffncIT/z7J1zk/fs4HWuOteX8rotNE5dikfyqXO0KnWzxbugC0EXK+PmTNAT9Bl8LN7DZIKYY3fVcGIh3QQP1qYDEETh0DkAAAQm4+uFEfSE3o20BXKzH6iUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796893; c=relaxed/simple;
	bh=YgbgNsSEiQWlF4PLVZbqV3I1bOvbG0wsgtM8VKg1iBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubVA1rQrrItlSXI+YHuE2wIi8pfl2fv0ulMCsNJ9l2ujKOrkTFldVgi4kLtXPz/9TTcELIS27Jo2G3Q5BAFu07g7/tFECmP6/It7ooC5l5xu9zy1RMpWlY38kel6qQwJNzFW4UbAoKd+Jt+Yj49MGJzrubHtZyGEkdF0Ltp7SH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjBCbPjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AE8C113D0;
	Mon, 10 Nov 2025 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762796892;
	bh=YgbgNsSEiQWlF4PLVZbqV3I1bOvbG0wsgtM8VKg1iBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjBCbPjFf8CCqzZRPr7jq92dA+zmOBYsL5kjYvk8d/64Q+vbzzVG+X8CckDHnq/NZ
	 vwwY6uBXSW+KMCVpKYpm4Mtn6IISmxIy5HhlToTJ9gsV8wCP29n0NUmCF82W91+mQb
	 xVd7VJQNc6abB4NCy94LYfxJmNc7yNXt5b4wTi0KbJt2q5PKFGvgRXkyq/0h//pPcP
	 o46qxF8RR4yaiceZhdwYQM0n6elEUfOrkd85e5H0fl3pkaKhGv8M970YrC/QOQgaVa
	 gfJpGyQBvJiPNwTZxrQIfkdPcFSCl/iysdpvN6x75+9diOKookyBlqnF+j7ydAWQgO
	 tO8Hh78vwbbmA==
Date: Mon, 10 Nov 2025 17:48:08 +0000
From: Simon Horman <horms@kernel.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: irusskikh@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: aquantia: Add missing descriptor cache invalidation
 on ATL2
Message-ID: <aRIlWAR1Px-OFKEr@horms.kernel.org>
References: <20251107052052.42126-1-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107052052.42126-1-kaihengf@nvidia.com>

On Fri, Nov 07, 2025 at 01:20:48PM +0800, Kai-Heng Feng wrote:
> ATL2 hardware was missing descriptor cache invalidation in hw_stop(),
> causing SMMU translation faults during device shutdown and module removal.
> 
> Commit 7a1bb49461b1 ("net: aquantia: fix potential IOMMU fault after
> driver unbind") and commit ed4d81c4b3f2 ("net: aquantia: when cleaning
> hw cache it should be toggled") fixed cache invalidation for ATL B0, but
> ATL2 was left with only interrupt disabling. This allowed hardware to
> write to cached descriptors after DMA memory was unmapped, triggering
> SMMU faults.
> 
> Add shared aq_hw_invalidate_descriptor_cache() helper and use it in both
> ATL B0 and ATL2 hw_stop() implementations for consistent behavior.

I think it would be useful to mention how this bug was found.
And what sort of testing has been conducted: compilation only,
exercised on real hardware, ...

As a bug fix I think this should have a Fixes tag denoting
the commit that introduced the problem. In this case, perhaps:

Fixes: e54dcf4bba3e ("net: atlantic: basic A2 init/deinit hw_ops")

The fixes tag should go immediately above your signed-off-by line,
with no blank lines in between.

> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

And lastly, for reference: as a fix for code present in the net tree, this
should be targeted at that tree, which should be denoted in the Subject
like this:

Subject: [PATCH net] ...

You can see more on process for Networking patches here:
https://docs.kernel.org/process/maintainer-netdev.html

...

