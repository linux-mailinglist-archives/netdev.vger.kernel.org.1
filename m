Return-Path: <netdev+bounces-42304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F1B7CE242
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07091C20A81
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174C03C069;
	Wed, 18 Oct 2023 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu0yRV8x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AD37151
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12435C433C7;
	Wed, 18 Oct 2023 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697645342;
	bh=4MR7iDZ+ixMX3Hkqy8fTKzN7HrpxuhyU6baJRTI8kUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xu0yRV8xDJ2jramzFaTKjJu286TbqXgRtm6Fnu6t/XIWQN67j4ZKJzisW2q9Xc+43
	 aJP9Clv7ivguDYTQHxjOOg/UJX5LkCg35QqWSOk1mRuBGg4Ce8MxOKRICXSTUxQrFD
	 Z40rGO35IXupws5F9Y5gw5++KTerH/+BA213yF1MxOmm8HnglybT/1Mp2CJQeC2Ox6
	 /K6wEwD7y/RXAUVJvasd/7I7i5569LnWUiB7OBB9nj2O8wtl16qcrf6WQnu7LHd/8r
	 KCUYy6pEUiOMQx3fr0Dj+JxVLpZsI9C8CU2Ai/yYzsrCpleBTM3FBS+0Kf8RtHn68Q
	 +JZA55NQnJxww==
Date: Wed, 18 Oct 2023 18:08:55 +0200
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Coiby Xu <coiby.xu@gmail.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin <ayal@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH net-next v2 08/11] net/mlx5: devlink health: use retained
 error fmsg API
Message-ID: <20231018160855.GT1940501@kernel.org>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
 <20231017105341.415466-9-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017105341.415466-9-przemyslaw.kitszel@intel.com>

On Tue, Oct 17, 2023 at 12:53:38PM +0200, Przemek Kitszel wrote:
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

...

> @@ -288,52 +206,31 @@ int mlx5e_health_rsc_fmsg_dump(struct mlx5e_priv *priv, struct mlx5_rsc_key *key

Hi Przemek,

The code above this hunk looks like this:

        do {
                cmd_err = mlx5_rsc_dump_next(mdev, cmd, page, &size);
                if (cmd_err < 0) {
                        err = cmd_err;

clang-16 W=1 warns that err, which is used as the return value of the
function, will be uninitialised if the loop never hits this condition.

Smatch also warns about this.

>  			goto destroy_cmd;
>  		}
>  
> -		err = mlx5e_health_rsc_fmsg_binary(fmsg, page_address(page), size);
> -		if (err)
> -			goto destroy_cmd;
> -
> +		mlx5e_health_rsc_fmsg_binary(fmsg, page_address(page), size);
>  	} while (cmd_err > 0);
>  
>  destroy_cmd:
>  	mlx5_rsc_dump_cmd_destroy(cmd);
> -	end_err = devlink_fmsg_binary_pair_nest_end(fmsg);
> -	if (end_err)
> -		err = end_err;
> +	devlink_fmsg_binary_pair_nest_end(fmsg);
>  free_page:
>  	__free_page(page);
>  	return err;
>  }

...

