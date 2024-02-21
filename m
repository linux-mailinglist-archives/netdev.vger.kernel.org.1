Return-Path: <netdev+bounces-73525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C682E85CE43
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E29B24381
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCDD273FE;
	Wed, 21 Feb 2024 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXeStNoq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44A25632
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483579; cv=none; b=cAoyJWnM3M3mLfBcXWvp1eD6hpJNVoihkoMbJC0kHT3l0Mx5ARKsjl9MNC06KluwfHZvwLmEflKFbAaruLyVWPpsi7ZEDeuI5wyrtObtt+1iDauMpc3or9miMQq15Ji4njHb6knsKSa/rNa1TinsaquurJGVEmKZMxtZzOOpBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483579; c=relaxed/simple;
	bh=lVpbdrw/HexuWFCjV9W4x4ULV7iuXn41S//m1jxg52c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVIKNk64qG1q5326oBg4Y1tKVpYL8YL96mBVYlUwtzIsIxKeB3Xlc0CUQhQyeIdULEtMyOOYF5PQtKa8Er4WKVoahMozqR+9TS3qL4TOCb+9AuczKby6J233qo0TmOdEQrgE6sDRMCCDSaUaw/ZU2Lm7ePcvUEY3yxr81nrwihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXeStNoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91024C433F1;
	Wed, 21 Feb 2024 02:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708483579;
	bh=lVpbdrw/HexuWFCjV9W4x4ULV7iuXn41S//m1jxg52c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lXeStNoqEsr+zCoKEdRMCRx4X1CGH8E+C24j/l+g5BEWoGcr1SzJdXz43XpQ2VgZ2
	 rTEbFtaWUhEIRZQ5YkudMiWTmqIDHQdYvBQ+P6VMP8a08PAHJr3w/1vmp3meAje1F8
	 7LSybDZY31fKILM+2lwDU74iOLnPWIBpoEk8iNy9e1ADbB41bKo8ujMhY7w15I9/yf
	 6H4qSRoZPtWgVRUVubFbPPWcKpH5/fEgY2dFEskGC9QyQDqc8pjP/GEj/u85svCoYd
	 hToj4D+VRz0fff0cwsuj0QgNB5khirjYPq17DaLW4BGLxy454/0QigjSc1vf0s7dvY
	 vX3HoixkOrHtA==
Date: Tue, 20 Feb 2024 18:46:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>
Subject: Re: [net 08/10] net/mlx5e: RSS, Unconfigure RXFH after changing
 channels number
Message-ID: <20240220184617.41b7de4f@kernel.org>
In-Reply-To: <20240220032948.35305-3-saeed@kernel.org>
References: <20240219182320.8914-1-saeed@kernel.org>
	<20240220032948.35305-3-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 19:29:46 -0800 Saeed Mahameed wrote:
> +	/* Changing the channels number can affect the size of the RXFH indir table.
> +	 * Therefore, if the RXFH was previously configured,
> +	 * unconfigure it to ensure that the RXFH is reverted to a uniform table.
> +	 */
> +	rxfh_configured = netif_is_rxfh_configured(priv->netdev);
> +	if (rxfh_configured)
> +		priv->netdev->priv_flags &= ~IFF_RXFH_CONFIGURED;

The sole purpose of this flag is to prevent drivers from resetting
configuration set by the user. The user can:

	ethtool -X $ifc default

if they no longer care.

