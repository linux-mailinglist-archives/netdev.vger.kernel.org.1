Return-Path: <netdev+bounces-243432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9348BCA0AF6
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 18:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62DA63004F1B
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 17:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE1633D6D5;
	Wed,  3 Dec 2025 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDKDP+3d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D433D6CF
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784544; cv=none; b=mV0BlnyGX94f3+80a4Q0xQQDRRLprb+q05Df0Ju3OSjGlXJExsTsKXRLvnHRyfshWg9u4BOinpdeYxN/wRhTbD61GCYG4Ry7LcS/8zzGAyIdUA00pWaNP4Alcb3HBIDo6tCW+QtJWhkWQOW8GJdWdwccLCBz+ZktfyGgS3IJj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784544; c=relaxed/simple;
	bh=AvqzK8zD6EfK3T603NCxKSyzUlkzmLXlkCu1DMZCXd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp94+/h2STN5woL1z6IwBW/dXMhgs+JUNAqAp2UIop4LTmzx+pQpJSMp7UOYDyEqzomqrzASgpHgWm2R01IM2397E+19P63AciLVOIfXc2EFaA/RGI5L81PvPZIMtl1R3IDdZZ6EOczsrj871/QaNn/x0zSq8uCxkKHRhaGPxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDKDP+3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2667CC4CEF5;
	Wed,  3 Dec 2025 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784544;
	bh=AvqzK8zD6EfK3T603NCxKSyzUlkzmLXlkCu1DMZCXd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDKDP+3dCBmnIndFhJmrSaw9ozK1p4r/lF8llnYRc6HMJw2L+jl2Tn05CBozoKdZr
	 fIfTgyH4TRjZrmHX42rpCmV0jv6PAKcsYCbRUnA3XxCK2W2CW4g/I8QHd9Y8fqpkPf
	 bRP/wn0KtdkiJCjTpwongeERZbQGve30N0+bgUmwEA/HgUBaIaa8iNTze9wS/3VVUf
	 TEQdIvVFGk3+BDxpYf7WJjB3ZjTP4pJiH7OPPWe3ahFaYbXWmk6OdtmaRcNSJyLsQT
	 diVyKEzG7EpI8EDLny2hXwmdPKTe6B3CBR7eo/ZZEsJjeBX2xhuXn7jkBU5mqL11HP
	 ZSsmDGWiNq/wQ==
Date: Wed, 3 Dec 2025 17:55:40 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net 3/3] mlxsw: spectrum_mr: Fix use-after-free when
 updating multicast route stats
Message-ID: <aTB5nBUI6a3YBRlr@horms.kernel.org>
References: <cover.1764695650.git.petrm@nvidia.com>
 <f996feecfd59fde297964bfc85040b6d83ec6089.1764695650.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f996feecfd59fde297964bfc85040b6d83ec6089.1764695650.git.petrm@nvidia.com>

On Tue, Dec 02, 2025 at 06:44:13PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Cited commit added a dedicated mutex (instead of RTNL) to protect the
> multicast route list, so that it will not change while the driver
> periodically traverses it in order to update the kernel about multicast
> route stats that were queried from the device.
> 
> One instance of list entry deletion (during route replace) was missed
> and it can result in a use-after-free [1].
> 
> Fix by acquiring the mutex before deleting the entry from the list and
> releasing it afterwards.

...

> Fixes: f38656d06725 ("mlxsw: spectrum_mr: Protect multicast route list with a lock")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


