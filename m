Return-Path: <netdev+bounces-97746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E341A8CCFA2
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208AB1C20AA7
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8640113D50F;
	Thu, 23 May 2024 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrL63GpL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145D13CFA3
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457744; cv=none; b=cFKZGoZzGcRsY68PGTEDD+L0TARCXz0S1tvBOqkvjmSXFXgOSfTFhPzXMbft+nwYdpsa6jS4PRzlUByn+WdbVkGLWZUnOgul7iR6F+4GjCngBqO7aYCHdjwSX8J6yK1Vpy/Eb4FeDbtT8intnPWDyqAm5jCXKQ+LUn2SJNCsnAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457744; c=relaxed/simple;
	bh=OW78gFu3fxkSCm5XipqIu07RQCbCOgK3+qNyocyS6x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewP4He3MWuhicvqL+LBm+5O43l/u8A7g9iIsPpLR/LrIEmIRscqbHcyiZEqqUwMf9MSd/seuJ/59FGUicJirmBEnXu0d9z8iR5DJ/dcDpQbko9CeOizLqBHZO707HqdoPejlBMW0uMJA84eGLu1id7NKjDvwpvUXC0dhM+9vFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrL63GpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94183C2BD10;
	Thu, 23 May 2024 09:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716457744;
	bh=OW78gFu3fxkSCm5XipqIu07RQCbCOgK3+qNyocyS6x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrL63GpLSXoSILGm3JnHi9p3ebZYoIyKOT3LfcOL1Aq5MhT24ZAXbDUerbomuHC3F
	 /8Cee9rjc2t30OQ6/NTomQk4ctMGlnIYJ/Z0f54fkyON7VkLhegrfu2yVXoDu6yIas
	 wVfuNHO5vhAW9dLM703nVZvtu9VmIERVGM+pKKDubdtl8Rn84ZALBQx4TG4AYb4yW7
	 8vjOOeLkPiHy3TlRnzWKKa1VT38WEjYP1OeKY6pcvz1AFKuaHPDm+ekysakvOaftZE
	 J5AJ9Je6Dy4glDuTnJshPYcmKXRLvHcBE+HhwVq8MKN/zgdQp8tJDQhbJ8kDBnGICI
	 ZebriRhGUrO8Q==
Date: Thu, 23 May 2024 10:48:59 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Baron <jbaron@akamai.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>
Subject: Re: [PATCH net 8/8] net/mlx5e: Fix UDP GSO for encapsulated packets
Message-ID: <20240523094859.GK883722@kernel.org>
References: <20240522192659.840796-1-tariqt@nvidia.com>
 <20240522192659.840796-9-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522192659.840796-9-tariqt@nvidia.com>

On Wed, May 22, 2024 at 10:26:59PM +0300, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> When the skb is encapsulated, adjust the inner UDP header instead of the
> outer one, and account for UDP header (instead of TCP) in the inline
> header size calculation.
> 
> Fixes: 689adf0d4892 ("net/mlx5e: Add UDP GSO support")
> Reported-by: Jason Baron <jbaron@akamai.com>
> Closes: https://lore.kernel.org/netdev/c42961cb-50b9-4a9a-bd43-87fe48d88d29@akamai.com/
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Thanks,

This patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

While looking over this patch, I noticed that it seems
that a similar pattern to the mlx5e_tx_get_gso_ihs() code
modified here appears in at least the MANA and NFP drivers.
So perhaps we could consider a helper in future.

