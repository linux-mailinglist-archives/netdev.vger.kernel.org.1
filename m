Return-Path: <netdev+bounces-115328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7904D945DCF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 14:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E002EB22BD8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090514AD38;
	Fri,  2 Aug 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lzk5p4mz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87A1E488
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722601988; cv=none; b=aeJyKSpl9DkHRFuP/rqLBHXc9MbIbzHr5IbQehDn/Gko+AXqbZj1qn2ZqPy9xvKBJfLaZ4eQuBgQkEouwRUBf423Bx2swLjBA5xYxhHqQ6KRhwalKiFqEfJnJScgpnPTOl7WHmPzaBVMHBToHWRaphFf7JeAdxt0W7DjZVWInlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722601988; c=relaxed/simple;
	bh=YN6Hq7/hqGjjsOcGNfXA4kJVAik7BLOU47hUukUaJuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoKtZU1wh8t7+1RaCDWJl+kMp6t8e+ca4FF/8QaQtYF9NURFwXozK46Fnz+LQe6zRbGu90rNJmcoHzIWyCGUZ/BNlslKQyJsdd6CkANrHWSp9zp1MdJnDM2bUbqh4XEVCZ9cXkEFxlaLPoWiBxKzbRYmsp/Fc5QgmR4ofV7Xr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lzk5p4mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB756C32782;
	Fri,  2 Aug 2024 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722601988;
	bh=YN6Hq7/hqGjjsOcGNfXA4kJVAik7BLOU47hUukUaJuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lzk5p4mzXDryo2kSeLkPvOoddfC7O3rbCzNztnSQhkHuXUteTZz62CnU0VIqKzY21
	 esal+xoUHB9frvGByjix9Y43276wS2u2kKHslgdrFJIKp/b/bxzOaHHtz/1yiN7DYB
	 BAZsipTQuPj6Nm8YsJ9CIUQYNpmZuFIRcx5yNvQ7RR7C3YcTR8xgg9HQxOPWDbc4gt
	 HXOrPt5CCPZydNcxzuAb+hgWgdn3Jj/E2l5voNoWkVwSlb9uo9INrYUFJYL/Nj8N+1
	 BLLu1YmMP8+reWXGMMMhb2mnEEg9TiqKtpKDVgWqIKWeMj3Crdm6HHjbnwsFB6b7Ai
	 f6an4IjDIGBeA==
Date: Fri, 2 Aug 2024 13:33:03 +0100
From: Simon Horman <horms@kernel.org>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
	jeroendb@google.com, shailend@google.com, hramamurthy@google.com,
	jfraker@google.com
Subject: Re: [PATCH net] gve: Fix use of netif_carrier_ok()
Message-ID: <20240802123303.GC2503418@kernel.org>
References: <20240801205619.987396-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801205619.987396-1-pkaligineedi@google.com>

On Thu, Aug 01, 2024 at 01:56:19PM -0700, Praveen Kaligineedi wrote:
> GVE driver wrongly relies on netif_carrier_ok() to check the
> interface administrative state when resources are being
> allocated/deallocated for queue(s). netif_carrier_ok() needs
> to be replaced with netif_running() for all such cases.
> 
> Administrative state is the result of "ip link set dev <dev>
> up/down". It reflects whether the administrator wants to use
> the device for traffic and the corresponding resources have
> been allocated.
> 
> Fixes: 5f08cd3d6423 ("gve: Alloc before freeing when adjusting queues")
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

...

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c

...

> @@ -1847,7 +1847,7 @@ int gve_adjust_queues(struct gve_priv *priv,
>  	rx_alloc_cfg.qcfg = &new_rx_config;
>  	tx_alloc_cfg.num_rings = new_tx_config.num_queues;
>  
> -	if (netif_carrier_ok(priv->dev)) {
> +	if (netif_running(priv->dev)) {
>  		err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
>  		return err;
>  	}

Hi Praveen,

Not for this patch, but I am curious to know if this check is needed at
all, because gve_adjust_queues only seems to be called from
gve_set_channels if netif_running() (previously netif_carrier_ok()) is true

...

