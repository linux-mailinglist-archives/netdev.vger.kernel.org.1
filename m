Return-Path: <netdev+bounces-228473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2928BCBD4B
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 08:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE7CC4E53DA
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E968262FF3;
	Fri, 10 Oct 2025 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8U/Q+Vi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1458D14286;
	Fri, 10 Oct 2025 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079320; cv=none; b=GihsF/k+UrigB59Pa814Xv+boX0LJ03gRBDrL8EP2CEO7do+Pa0ZSfM+m7T8QPswLazHpXDUmpZspvnA4eA/qi9sy+woCzqxlaBn3cZT6j0UXOLRFHRNr1bSeW9Seq+cLHauW0shGJ0k7ILRH3phW9jo+Hp49FnB2/XQZhY97lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079320; c=relaxed/simple;
	bh=hZyYjmCjGC/aWO0FIJleRNuNf7fd08tfn9vyJ/aJV0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1hIVPIaxAYXhtQOXeP30FfEKjcnmCF1lW/LKb0RUj5U/ka++XDa5LjmIuau/tAwjh6zkF4W9YH3qjPx4hcqIrCz/RdLMRjXHzWRoVtYJXWipP/c/CrwVmbqWUJ6+E6eyoIHrJ4f+QfZgMowwSYvdArmYKwd7oY1fOJwFeiC53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8U/Q+Vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14BBC4CEF1;
	Fri, 10 Oct 2025 06:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760079319;
	bh=hZyYjmCjGC/aWO0FIJleRNuNf7fd08tfn9vyJ/aJV0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8U/Q+ViHaprrZOwJSTlQZc0FfO664M9Zn0UnDLSBiMDG9bkl5WGE+ZGtQR0Ict4U
	 gWk72Ta9nDdnh1JcyekT+OJgQMvnpcgpFB8vKNCvJDp/GCnO5aSD+TR3G26zvxnppV
	 t4qNbWc9NpxNnojSQJMRdsyxJEQnQRqliSUbG6xoPGYD3b2jVJWfazD+OGuBzIo4gL
	 Hf8QvZM2lhkO9y+qi1epNGQw5cXiLF8s57wNyfSQtK7kvuzx5nebJwlZlDes4suEku
	 pWE8+exurqVoJ/PHu87J7LrRCbuk3EEEJ12g8vYk2dPnZYhf8KhFHXDGe6AsgamWpJ
	 u6XvXpV0wwgmg==
Date: Fri, 10 Oct 2025 07:55:15 +0100
From: Simon Horman <horms@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dlink: handle dma_map_single() failure
 properly
Message-ID: <20251010065515.GA3115768@horms.kernel.org>
References: <20251009155715.1576-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009155715.1576-2-yyyynoom@gmail.com>

On Fri, Oct 10, 2025 at 12:57:16AM +0900, Yeounsu Moon wrote:
> There is no error handling for `dma_map_single()` failures.
> 
> Add error handling by checking `dma_mapping_error()` and freeing
> the `skb` using `dev_kfree_skb()` (process context) when it fails.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
> Tested-on: D-Link DGE-550T Rev-A3
> Suggested-by: Simon Horman <horms@kernel.org>

FWIIW, I don't think my Suggested-by tag is strictly necessary here. I did
suggest an implementation approach. And I'm very happy that you took my
idea on board. But I'd view as more of a tweak in this case. Because the
overall meaning of the patch remains the same as your original version.

> ---
> Changelog:
> v2:
> - fix one thing properly
> - use goto statement, per Simon's suggestion
> v1: https://lore.kernel.org/netdev/20251002152638.1165-1-yyyynoom@gmail.com/

Thanks for the update, this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

