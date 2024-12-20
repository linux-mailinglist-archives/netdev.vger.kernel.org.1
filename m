Return-Path: <netdev+bounces-153710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FDC9F94D5
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DE81894221
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D685D1A83ED;
	Fri, 20 Dec 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReTsmGGk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1751208AD
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705996; cv=none; b=dWuBM5Q0TBj/z9iC3VtDO4t2DD3GBkN0XH/javjcIH6pYuCioCFroiZbS/afx0jzTZLYqf5xVKm2xPnRqkoDQks61/5mVNwV3ghtckjG+6q3KbavkCr77lNlXnrXLS1qVo49M2/Qs1BDmbIKZFWJkgqFhnhCWXqHyvkb1/5APxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705996; c=relaxed/simple;
	bh=aBRL6Si6HQP5DWl9Q2NNmZHJBb2ue1IOkPO8Lqcu/9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFLNke+G9MWaW72QO3k8dYf9CzGlmSNrCnFPB4cMa/b9BLpY0/+zy4ixBIudx8Dggz6+Jwc4SWDQky1gE8s52jZzbnzZAcDEkzd+36Qan85pyrrcC2T4wAqwL3TGjKO3Pyvw/IxzBTrsiVghlM7vppwIfqNWYED1ZunlvzCJCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReTsmGGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C1BC4CED3;
	Fri, 20 Dec 2024 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734705996;
	bh=aBRL6Si6HQP5DWl9Q2NNmZHJBb2ue1IOkPO8Lqcu/9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ReTsmGGkuYpo0o8UMztrJGVobDizNAQeUP4eX3nNovRuXEu+CAIO1I9e01X6/5M3O
	 BKOAj5BfT6FDfSkDcEStPMKx5/4Q742VMaIMrJak7NXwRfu01n7IL7fO3szJWkBdB1
	 ool42nVOSZHJQemNBFxHMYyebTE5uVA3pzL1wQANlQ+sMxOC8y/giWT+R6OmvP/2T2
	 C2Na0nraBbRL41JmzHyp4NNvVp93kh6bp4v+42EiHt5vE7T45QotxEh9qpL91OdxIk
	 rHFOO8/XwTeHE1mVXWvXRK3MCB7bOfqgVMXzRiQD9nx5HVIN3i7UnN1jdqeNo3QvIO
	 fuseh7/O7dzMA==
Date: Fri, 20 Dec 2024 06:46:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net 4/4] net/mlx5e: Keep netdev when leave switchdev for
 devlink set legacy only
Message-ID: <20241220064634.10b127f9@kernel.org>
In-Reply-To: <ec95c546-114d-402f-b7b9-b3e54b33dbf0@intel.com>
References: <20241220081505.1286093-1-tariqt@nvidia.com>
	<20241220081505.1286093-5-tariqt@nvidia.com>
	<ec95c546-114d-402f-b7b9-b3e54b33dbf0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 09:48:11 +0100 Przemek Kitszel wrote:
> >   	mlx5_core_uplink_netdev_set(mdev, NULL);
> >   	mlx5e_dcbnl_delete_app(priv);
> > -	unregister_netdev(priv->netdev);
> > -	_mlx5e_suspend(adev, false);
> > +	/* When unload driver, the netdev is in registered state  
> 
> /*
>   * Netdev dropped the special comment allowance rule,
>   * now you have to put one line almost blank at the front.
>   */

Incorrect, we still prefer the old comment style, we just give a pass 
now to people who have a strong preference the opposite way.

> > +	 * if it's from legacy mode. If from switchdev mode, it
> > +	 * is already unregistered before changing to NIC profile.
> > +	 */
> > +	if (priv->netdev->reg_state == NETREG_REGISTERED) {
> > +		unregister_netdev(priv->netdev);
> > +		_mlx5e_suspend(adev, false);
> > +	} else {
> > +		struct mlx5_core_dev *pos;
> > +		int i;
> > +
> > +		if (test_bit(MLX5E_STATE_DESTROYING, &priv->state))  
> 
> you have more than one statement/expression inside the if,
> so you must wrap with braces

I'm not aware of that as a hard rule either.

