Return-Path: <netdev+bounces-109248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B597927913
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD03B1F222A8
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A601AB520;
	Thu,  4 Jul 2024 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvdH3gxz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E611DA22;
	Thu,  4 Jul 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104250; cv=none; b=nySQ/FkkGQNpGgQWNARuIVk3FLdYAzN/R8Ue96/0T3cAF6OX8Bf5oPkXIKK/+Bh9ko8DVIyinDmbY6GapYebMHfyCXyW03tEXIFKk7yhshmG9p7L0fC0yhbrSIkvzSB1Z5WephyijHdM8QwvtOmW9rV2cg3mjVQoUfa/cCxUfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104250; c=relaxed/simple;
	bh=+wR2M0u9AG8R5RMtm4HhAS4tXAK7wRKpXwsFDX2QmtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjgJuqfXc1NkFLXjKAKGYytcIiu7T079GztSA9bbyZyzN5zj+7uVOSC5jdSFEz4+ujcSjU9xZeFE4j8YG2GicDIGF3/VX059RWtN/lx2p7RH0q9ZSrTTOzDPU2YSE37aDPYFjOri4a9xVZACQXTKOfPVDQz/wbOaOErhFlePm8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvdH3gxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6D5C3277B;
	Thu,  4 Jul 2024 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720104249;
	bh=+wR2M0u9AG8R5RMtm4HhAS4tXAK7wRKpXwsFDX2QmtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PvdH3gxzhmbG1N3mCdfU6Hj8fiK5EIsxsdutaU93CkygEKF4NWnnoNkYHhw+yJE8O
	 kx67za2tKG+oEkKe3mKR2GN/ey1eK4rEzRmbKLgyrOL8pXGqFi2S/kSNyhGoS6xjCk
	 l/7G3AtFYbVkJ/KAMJUHc1fqAjp19FJX8Jc0ZjZKfYcsx6wZiyQHhGaTBe0rNuW76w
	 JHNDp86jTf4QRvLR1Ep5N/m970qtqBDVLHqGNVcl8Tm5qmAyGxRSAFdUFrYYa8c5N6
	 +A6yBOYWLIaSZDX5dbiEeaUzM2ExsnhpHBQ7NxL4bdvj0Pbbl+nfvQ+RmA0qVm6swR
	 nZxz0evSEORzA==
Date: Thu, 4 Jul 2024 07:44:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ks8851: Fix deadlock with the SPI chip variant
Message-ID: <20240704074407.4cb4ebdf@kernel.org>
In-Reply-To: <20240703160053.9892-1-rwahl@gmx.de>
References: <20240703160053.9892-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jul 2024 18:00:53 +0200 Ronald Wahl wrote:
> +		bool need_wake_queue;
> 
>  		netif_dbg(ks, intr, ks->netdev,
>  			  "%s: txspace %d\n", __func__, tx_space);
> 
>  		spin_lock(&ks->statelock);
>  		ks->tx_space = tx_space;
> -		if (netif_queue_stopped(ks->netdev))
> -			netif_wake_queue(ks->netdev);
> +		need_wake_queue = netif_queue_stopped(ks->netdev);
>  		spin_unlock(&ks->statelock);
> +		if (need_wake_queue)
> +			netif_wake_queue(ks->netdev);

xmit runs in BH, this is just one way you can hit this deadlock
better fix would be to make sure statelock is always taken
using spin_lock_bh()
-- 
pw-bot: cr

