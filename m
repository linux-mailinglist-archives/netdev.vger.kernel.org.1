Return-Path: <netdev+bounces-181705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F9CA863D2
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D390A3A78B2
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62021A451;
	Fri, 11 Apr 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR2Tz26S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27312202F70;
	Fri, 11 Apr 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390438; cv=none; b=jGxGl8fvI+8qi2YGh8c7aGwa2pWytG7WoPgDGpwdw//3Pi3KHZcSgdjEetMbSFptqY1l4HY9x8C3/nFRuQRXZyFWU1tOsM3MOGJBQ/vxMttrIF9csW0Vuttso/1zBdBbsy6ekD51z3fgFFTV4+7ZjBTye7C8bG3/WH+PULE2NHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390438; c=relaxed/simple;
	bh=AF4RjAgYfBcqR9rc19DAX62S1KIV6sMe+X020c/P1Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va6xcabhKeVgvHqVZxT3W3C/yvDYrhx/trWhKC+E4uhTTzYs4reZMi5pC3ORg+5RasbAndxLMyt6X+2FbsTPnYioDMkK/JmsGzERJr9DXQMy6wZDbnYoSIkV3r9xkLRbTeibW4oJsUPVgTIw+3zLK6kZaWGrEahBmwjFxr7VDDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR2Tz26S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56C2C4CEE2;
	Fri, 11 Apr 2025 16:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744390437;
	bh=AF4RjAgYfBcqR9rc19DAX62S1KIV6sMe+X020c/P1Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tR2Tz26SEwY/Iqqp+8Dc1SdxxwQ/Oe4pzKoi0FYMsNjzpsuIMXep/4LJxe5x/BUAw
	 ai98mdp8UD9p6MIquQKTK/MRJOOzdOwDkVLhHxoUlmwZdMMXiwelCsSjzeuvl6JrBX
	 pfd/jKpQpyIGLykhtDNcFydRUWQjrslj7kJIBd9jH23sQFoRhBQ8uMk9hT9YlicNkV
	 h6MLif0NZf9/QlHdF7QZ+WA0nEXrkFGUnR/PKvNJKdiojDix9LKDBPe3wij9GhW+Af
	 ZTSSaxokBnI6NGQlPDCBCHkBTtC4neqfozELV2C8BeWchmVQIm7HjvmMDmpuiL1kcC
	 4iZ0NcTVkCj6w==
Date: Fri, 11 Apr 2025 17:53:53 +0100
From: Simon Horman <horms@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ethernet: microchip: lan743x: Fix
 memory allocation failure
Message-ID: <20250411165353.GN395307@horms.kernel.org>
References: <20250410041034.17423-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410041034.17423-1-thangaraj.s@microchip.com>

On Thu, Apr 10, 2025 at 09:40:34AM +0530, Thangaraj Samynathan wrote:
> The driver allocates ring elements using GFP_DMA flags. There is
> no dependency from LAN743x hardware on memory allocation should be
> in DMA_ZONE. Hence modifying the flags to use only GFP_ATOMIC
> 
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
> ---
> v0
> -Initial Commit
> 
> v1
> -Modified GFP flags from GFP_KERNEL to GFP_ATOMIC
> -added fixes tag
> 
> v2
> -Resubmit net-next instead of net

Hi Thangaraj,

Thanks for the update. And sorry for not noticing this
in my earlier review. But I have some more feedback:

* I don't think it is correct to refer to this as fixing a failure
  in the subject.

* I do think the subject prefix can be shortened to 'net: lan743x: '



Perhaps something more like this?

	[PATCH net-next v3] net: lan743x: Allocate rings outside ZONE_DMA

And perhaps also mention in the commit message that this
is consistent with the other caller of lan743x_rx_init_ring_element().

Thanks!

