Return-Path: <netdev+bounces-138204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C89C9AC981
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E011C2116A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92AE1AAE06;
	Wed, 23 Oct 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqzsaLO+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53551A08C1
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684729; cv=none; b=Y4o6+vhGP+jG+BB5Rk84NATIZC77xo0dt7H5/N+G7sk7LQ/iyrDy7pJPGvb7TQYS7nqoNhqVMOJ3ypl7xatq1r7n2wap58oSHU+DNpEndYaDcShwRip8N01nbqLd8Oa8gx2tIJwuu41zPcMJyd/cdy/0jJuZoDh8TauDobMY7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684729; c=relaxed/simple;
	bh=jCbYZI9crB5D0allmijm0LcgjWiSBS4jJi4uT0FsbXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZzjyZEP9gfj9RKRxfN8/DpbKmKdVhCmGznotMw5FPfXoDi2j/WAz9l7uz2juhN2OWcOVsrlSNeyDVv7yDlFPkQH/u0UiBjEpbOD79UJ61rfEMBz7LCiuzCxq4tWHkwsMjXlyFza9/8XSStMfzOqmPjASaRHDEYNhoIqTN4b01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqzsaLO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FEBC4CEC6;
	Wed, 23 Oct 2024 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729684729;
	bh=jCbYZI9crB5D0allmijm0LcgjWiSBS4jJi4uT0FsbXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqzsaLO+P4p4phQM8ZZ9X/eyaIqSyC46f4ydZowKbEopKCOEt2cl/NgJpU6ESjU49
	 IrQ43gF8MBeYAFyrAzzRlvCNrN8cFnC7Lc3xf/Y3+4nF3mzXVNtc0iq33GASvF0Ci5
	 uBGiSdGNMSeCemURt44DDgeIYSa0xR+S2Z1AVIzeglBHgGqYuj8gMfgJnZyIa0EY6Q
	 vB3kTRT/Q19jgsBL971XXyoSa7mCkxpbT8NCClzvDHK0ZuPoOqOTomOjyXkVlNMZoC
	 PzGC9d+dCIrzxVrrP4bCOHm/bp8PdEpdsN8Rtn+QLVwG4bmTacOPjF6PDPx8G/P8k4
	 IuqrU53BaAfzQ==
Date: Wed, 23 Oct 2024 12:58:44 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>, Chris Mi <cmi@nvidia.com>
Subject: Re: [PATCH net V2] macsec: Fix use-after-free while sending the
 offloading packet
Message-ID: <20241023115844.GO402847@kernel.org>
References: <20241021100309.234125-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021100309.234125-1-tariqt@nvidia.com>

On Mon, Oct 21, 2024 at 01:03:09PM +0300, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> KASAN reports the following UAF. The metadata_dst, which is used to
> store the SCI value for macsec offload, is already freed by
> metadata_dst_free() in macsec_free_netdev(), while driver still use it
> for sending the packet.
> 
> To fix this issue, dst_release() is used instead to release
> metadata_dst. So it is not freed instantly in macsec_free_netdev() if
> still referenced by skb.
> 
>  BUG: KASAN: slab-use-after-free in mlx5e_xmit+0x1e8f/0x4190 [mlx5_core]
>  Read of size 2 at addr ffff88813e42e038 by task kworker/7:2/714
>  [...]

...

> Fixes: 0a28bfd4971f ("net/macsec: Add MACsec skb_metadata_dst Tx Data path support")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Chris Mi <cmi@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/macsec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> V2:
> - Removed NULL check before call to dst_release().

Thanks Jianbo, all, for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

Please do follow up on the unencrypted packet issue flagged
by Sabrina in her review of v1 [1].

https://lore.kernel.org/all/Zw6CntwUyqM6CivS@hog/

...

