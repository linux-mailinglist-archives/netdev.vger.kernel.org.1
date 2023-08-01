Return-Path: <netdev+bounces-23321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6C76B8CF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC22281AF6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D071ADC2;
	Tue,  1 Aug 2023 15:40:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0474D1ADC6
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3843C433C9;
	Tue,  1 Aug 2023 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690904405;
	bh=X1mwOoTIB7hJQicL/Hgqt1xt/e11C2x0nJ6bkn43y9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsJl7GDDsBSKKFeF8Ip+VemK5Na+5zrPvm4qpZ6xK/fYu7bSfNOZ30AshNFL5I3j9
	 yKb17kE4P6AwuIofYAtl/B6roFw5SdPgJAITnVGHYZt00zme7fw2xgWcyjFwNLKwRn
	 4kDJS3jCBtMOjJck4ERdinf2VEG7X7F+ThTwyhvBKLJpDL7CouR4K7gPDs3MoyIV8/
	 5IRIQpetqVjCbxAXvKhVjVxFUoLdGyRaA7//vC2sd3gLaPCdrbkwOPEfNc7DAHLWvD
	 7q8GbkOmaIam75Eqt6BiwuVYOhzsv0Wm3/x/NNbSq4duYtWkE3rS7IZ79gcddP6wGk
	 AmVumZfMwlLoQ==
Date: Tue, 1 Aug 2023 17:40:01 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx4: remove many unnecessary NULL values
Message-ID: <ZMknUZudTKGwsEpG@kernel.org>
References: <20230801123422.374541-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801123422.374541-1-ruanjinjie@huawei.com>

On Tue, Aug 01, 2023 at 08:34:22PM +0800, Ruan Jinjie wrote:
> Ther are many pointers assigned first, which need not to be initialized, so
> remove the NULL assignment.

How about something like:

Don't initialise local variables to NULL which are always
set to other values elsewhere in the same function.

> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

...

> diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c

...

> @@ -2294,8 +2294,8 @@ static int mlx4_init_fw(struct mlx4_dev *dev)
>  static int mlx4_init_hca(struct mlx4_dev *dev)
>  {
>  	struct mlx4_priv	  *priv = mlx4_priv(dev);
> -	struct mlx4_init_hca_param *init_hca = NULL;
> -	struct mlx4_dev_cap	  *dev_cap = NULL;
> +	struct mlx4_init_hca_param *init_hca;
> +	struct mlx4_dev_cap	  *dev_cap;
>  	struct mlx4_adapter	   adapter;
>  	struct mlx4_profile	   profile;
>  	u64 icm_size;

This last hunk doesn't seem correct, as it doesn't
seem these aren't always initialised elsewhere in the function
before being passed to kfree().

> -- 
> 2.34.1
> 
> 

