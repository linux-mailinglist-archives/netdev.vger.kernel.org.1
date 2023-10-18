Return-Path: <netdev+bounces-42305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B39E7CE25F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE272B20E41
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEFD3C06B;
	Wed, 18 Oct 2023 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUYLIsGy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A53C067
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDD5C433C7;
	Wed, 18 Oct 2023 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697645462;
	bh=yDdmQ0V9wvojaQKv5dZ7J8a15nZOMdq7QItSFt0CGnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUYLIsGy9I5+Z1057HBBPPERkRSfihNd9Jnqdd/Z2PVzwdx9SgBmx+28ScsxQnKVd
	 EefQEji/0T7rWRsI9Z6xX3abBEBbYZDOwKOqwfxGPrfrm/nfkRZEdExYq6tNZo19D3
	 v3/kQ4U0RdMaRgXVhSEd7QvzIkwEQrpe4ABwTqpKt5Lu3WDYysPlzO7QFK5iKl7H5J
	 TISUG5h0Cu2GrLhQIUNBDbLwlpU+Ec/MwLLhiargMfuqCptfLYZZV6VR8rzH7TKC7T
	 d2SPz9PK/I62E8OviKsMY+MNF3kf9aAy/iiT/mnISKvtpzH9qVZg4ZxOgevlHqMzpA
	 ckVXH7gi6ImnQ==
Date: Wed, 18 Oct 2023 18:10:55 +0200
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
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 11/11] devlink: convert most of
 devlink_fmsg_*() to return void
Message-ID: <20231018161055.GU1940501@kernel.org>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
 <20231017105341.415466-12-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017105341.415466-12-przemyslaw.kitszel@intel.com>

On Tue, Oct 17, 2023 at 12:53:41PM +0200, Przemek Kitszel wrote:

...

> diff --git a/net/devlink/health.c b/net/devlink/health.c
> index 3858a436598e..f4a6de576b6c 100644
> --- a/net/devlink/health.c
> +++ b/net/devlink/health.c
> @@ -566,17 +566,15 @@ static int devlink_health_do_dump(struct devlink_health_reporter *reporter,
>  	if (!reporter->dump_fmsg)
>  		return -ENOMEM;
>  
> -	err = devlink_fmsg_obj_nest_start(reporter->dump_fmsg);
> -	if (err)
> -		goto dump_err;
> +	devlink_fmsg_obj_nest_start(reporter->dump_fmsg);
>  
>  	err = reporter->ops->dump(reporter, reporter->dump_fmsg,
>  				  priv_ctx, extack);
>  	if (err)
>  		goto dump_err;
>  
> -	err = devlink_fmsg_obj_nest_end(reporter->dump_fmsg);
> -	if (err)
> +	devlink_fmsg_obj_nest_end(reporter->dump_fmsg);
> +	if (reporter->dump_fmsg->err)

Hi Przemek,

Smatch warns that err is not set to an error value here.

>  		goto dump_err;
>  
>  	reporter->dump_ts = jiffies;

...

