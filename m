Return-Path: <netdev+bounces-209772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE3B10BAB
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016137A3342
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B12D6638;
	Thu, 24 Jul 2025 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbXbdoWl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0E2741A1
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364274; cv=none; b=KYf0/PnFy0VEvQhkBB7l7h4/Vv1i5Lk+r2dec/HTA/OGVl56YUftc6aZ/CjBYQxz6fKrgZ2a/Wj2SwIB+DRpg1Bz7Id2hYY0U1ImChvyjdKDPkVKzDGcdLf9l5tzOce0E/LJz+dN5reAObrFOCqBfJKjH2cd71q0RjeqOvBW9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364274; c=relaxed/simple;
	bh=wyW1+aAuMGqDsX9ZH3or0rzHcWvzot1QAO3bxcNViSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mupVzMwla04MQZ+MgEV1BZUq+upXBVPsDJWP2WBOQwze4KjlyQxB1P4OmasxDqF8XZHvXWz9pY5hYaWRMRnN99uN/Kcz/8h7I2spPriBc6N7TmAIGQ59H+3kWi037eSt1PdHawzWWXexua3bkhcbPqiaNY+7sz48QaSYevIstVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbXbdoWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD92FC4CEED;
	Thu, 24 Jul 2025 13:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753364274;
	bh=wyW1+aAuMGqDsX9ZH3or0rzHcWvzot1QAO3bxcNViSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbXbdoWlhdITtoWCWqiI9LATJtzJWoAoQ+2PVuCA/XpRJY3Lyttgim4e1+LVDp2we
	 nX4SWuuOB20/9vKmkbChexUyY8MtE5K2xUjehAn7LisT4kRhY9yNxskRx22iBH1kve
	 E48tYob2gX0HfjEARlnNsq28Cx/NPxxcyFObiT4X7kpCXMcwqOU4gbFLQ0UDX+VYeC
	 TV9Ko8/NW9JFcuLEhsJ+NtaeNVv8TIoyXpUXudYqX9dgcXlsFgNWsixPJWEPVR8Wmw
	 S5305iyXMU/n+cgwmabP2yXFY2aHOc7Aaxs5tCWn5MOeDNZY3T3rTPHQluG1sLy3PN
	 igW6Agez9uIDQ==
Date: Thu, 24 Jul 2025 14:37:47 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5.0 16/19] net/mlx5e: Configure PSP Rx flow
 steering rules
Message-ID: <20250724133747.GN1150792@horms.kernel.org>
References: <20250723203454.519540-1-daniel.zahka@gmail.com>
 <20250723203454.519540-37-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723203454.519540-37-daniel.zahka@gmail.com>

On Wed, Jul 23, 2025 at 01:34:47PM -0700, Daniel Zahka wrote:

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c

...

> +int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
> +{
> +	enum accel_fs_psp_type i;
> +	struct mlx5e_psp_fs *fs;
> +	int err;
> +
> +	if (!priv->psp)
> +		return 0;
> +
> +	fs = priv->psp->fs;
> +	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
> +		err = accel_psp_fs_rx_ft_get(fs, i);
> +		if (err)
> +			goto out_err;
> +	}
>  
> -	fs->rx_fs = accel_psp;
>  	return 0;
> +
> +out_err:
> +	i--;
> +	while (i >= 0) {

In practice i may be unsigned.
And if so this condition will always be true.

Flagged by Smatch.

> +		accel_psp_fs_rx_ft_put(fs, i);
> +		--i;
> +	}
> +
> +	return err;
>  }

...

