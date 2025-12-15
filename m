Return-Path: <netdev+bounces-244763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 952F1CBE3BA
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 192363022D38
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9518930F807;
	Mon, 15 Dec 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJQvjIL6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5CE30EF75
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807915; cv=none; b=MY9UQy+tem2a/t6bg0+gvhL754AkwjWU+3tT6ApkZlHbvodcbVFy6BnXtMgK3fXUfdWHYvjOhQ+gGnOKbF4n6xY8AugWK12QYxK1ahw7xbkmj1ag0ZqT9cj4e7LJTswt+gOyWhF+N1pdpoB5VTtoMwVFRNnojekrK9HxNsIrUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807915; c=relaxed/simple;
	bh=JCdGuaJKJaJZynKZlHlxSVrlzoFaBengO+enakJZ+U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8ow9pOq/NrFBZrX4/x7eW45ghwH9nQlZ2+iTkb8P+OBP2t9Ynzl/I5AwjVbxDvGFKGPPlfjC+9+mCG/sQ/9EUxirsDKxq4h2IFV1WIMae4fuFT/An1QLNotWYvLID1qaguihDFtIo6KGUJnUjp13ejvEdCL1Lh7mn7me2LHVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJQvjIL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54174C4CEF5;
	Mon, 15 Dec 2025 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807915;
	bh=JCdGuaJKJaJZynKZlHlxSVrlzoFaBengO+enakJZ+U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJQvjIL6gxdZ9lq7hBcRDLXcvO2lqxdFeLCu31Zjbir9N/GPDiOkhsZS/lgGCdoKS
	 sa06tO1xqWcY1TkRyiFkUzRxxZftHTIbBFtA9bMJ2AByXx/9gK0FpdXpdIbTgmVsw4
	 MXs3RRCfOX9BNl2NLNtzJxDOHfEqC4TidFh52fq1STTO+oLaBIbGObT/LhCrEuM0S9
	 5zqeo+FID4dgFjSJPlnC98fBsAaCU6DzicsCYpd0jYznYQvL0tzkLUGGmMHpsIOPDm
	 OSKBVViV8JUA9nemO+lqTzTG2fcFMbV3q3xXHL5aHm+hSNWEe/egnX8tarAgHSe0El
	 AeNM1+zxFB+6w==
Date: Mon, 15 Dec 2025 14:11:51 +0000
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
Message-ID: <aUAXJ01iHnSJtItt@horms.kernel.org>
References: <20251214-airoha-fix-dev-registration-v1-1-860e027ad4c6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214-airoha-fix-dev-registration-v1-1-860e027ad4c6@kernel.org>

On Sun, Dec 14, 2025 at 10:30:07AM +0100, Lorenzo Bianconi wrote:
> Since airoha_probe() is not executed under rtnl lock, there is small race
> where a given device is configured by user-space while the remaining ones
> are not completely loaded from the dts yet. This condition will allow a
> hw device misconfiguration since there are some conditions (e.g. GDM2 check
> in airoha_dev_init()) that require all device are properly loaded from the
> device tree. Fix the issue moving net_devices registration at the end of
> the airoha_probe routine.
> 
> Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

As a fix this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

But I am somewhat surprised that the netdev isn't unregistered earlier
both in airoha_remove() and the unwind ladder of airoha_probe().

