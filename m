Return-Path: <netdev+bounces-202382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD1AEDAA0
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6661818998D5
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1301235056;
	Mon, 30 Jun 2025 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgtoOB9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F61E9915;
	Mon, 30 Jun 2025 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282321; cv=none; b=CwcD/LAjW9uCbU0Q3SXTswGUlDVCjGK4z4rufThnb/25hdzVXace9YYcT3OrIcccrCOGAcAB1uLxNkGLinKZHkhfag4c/U/u7vgB83YNGuGdMLhwyTBM66JhkW9T7b4HA0JZ+Ql7T/YfUjgzlgV7Nz+ccix/s60KsK2RE9MjtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282321; c=relaxed/simple;
	bh=/zPtV6dESq3W/I9QbMckyTu4GDaEL5TPBWwywPJ32S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LApTW+3mqC52v4GTLQxnrqCwbUeeKBaq5hdaDwT3DzUC+r3sbno2zPHGDbHcFrQMVeheugwRZfT4Doh37ea4adz0oyLpD5MGwbOTmGsJ9SgF4LEhhzUlMLq2WK8YNwlXShdD8/tcYwBJKKCk+SPktuDv+6fm9D4birwHIhyxnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgtoOB9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31D3C4CEE3;
	Mon, 30 Jun 2025 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751282321;
	bh=/zPtV6dESq3W/I9QbMckyTu4GDaEL5TPBWwywPJ32S0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VgtoOB9vsslvh2n8Etqblw7N5AJFVaQmiRZrFoPCTCh4i54PbjXwP+1ZC7y2HP1qP
	 AkFlhmywwhYYtPjDbPQyjbq6Twn2Wiw2r6TQKe3zb0VmytVO8KInWYObJXlIUPOxeM
	 sxethmiiN5Ne2KMx7N2VEBGnwT7CYc6aST1+rBYyErzNzOZnQYxiIPdhqBGz+OXpeb
	 ZnaGaoK2Eo+AKvWXrjsmmgcH3djTIuhmpxf/Y+/V1H9dxKw0ZC52nN68VnqbX7aPfm
	 0J8u3TdNq9laFK3F5ZA6RqfFMdme1keMqYIZ7pNdzkAMGn3g6R85/uwXYskmzCceEv
	 d/RH8Id6k1YNA==
Date: Mon, 30 Jun 2025 12:18:36 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: thunderx: avoid direct MTU assignment after
 WRITE_ONCE()
Message-ID: <20250630111836.GE41770@horms.kernel.org>
References: <20250629051540.518216-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629051540.518216-1-alok.a.tiwari@oracle.com>

On Sat, Jun 28, 2025 at 10:15:37PM -0700, Alok Tiwari wrote:

...

> @@ -1589,16 +1588,18 @@ static int nicvf_change_mtu(struct net_device *netdev, int new_mtu)
>  		return -EINVAL;
>  	}
>  
> -	WRITE_ONCE(netdev->mtu, new_mtu);
>  
> -	if (!netif_running(netdev))
> +	if (!netif_running(netdev)) {
> +		WRITE_ONCE(netdev->mtu, new_mtu);
>  		return 0;
> +	}
>  
>  	if (nicvf_update_hw_max_frs(nic, new_mtu)) {
> -		netdev->mtu = orig_mtu;
>  		return -EINVAL;
>  	}

nit: curly brackets should be removed here, but see further comment below.

>  
> +	WRITE_ONCE(netdev->mtu, new_mtu);
> +
>  	return 0;
>  }

Could this be more succinctly expressed as follows?
(Completely untested!)

	if (netif_running(netdev) && nicvf_update_hw_max_frs(nic, new_mtu))
		return -ENIVAL;

	WRITE_ONCE(netdev->mtu, new_mtu);

	return 0;

