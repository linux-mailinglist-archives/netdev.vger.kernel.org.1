Return-Path: <netdev+bounces-15487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD6E747F82
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 10:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8534C1C2042F
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4770E3D71;
	Wed,  5 Jul 2023 08:24:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B816F20E8
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 08:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA9CC433C8;
	Wed,  5 Jul 2023 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688545438;
	bh=jL2t6AUn6hzbYzzckYRgVf8ByWotOQ4NEXr2JAdtcG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYj6Fq/hWszOWdJeF3FLgviiHyu+RFMMAEv9MVzuLlx+/5qZkje15/10LtaGmFqts
	 EW4sAT73wesgPmKBoIgnkjjDMQ3ofzkMuj4IccJ74fFLmAXMmrPOIIf+2s516fiMDS
	 9kDlWt58wbmSz3X/ColOvvMhIiUHPBZaFVocdlSYd4LntXEeVDVY7Enp1y2n4X9WxU
	 8ItoG+XjmvgpBQ0/SvbrVnEgqmnL26c5oVxRjH58gqgLL5+1my5bf4TRu/6WM7MDbx
	 IpqL0xd/mieDiqTkIVIqEpzfT5Rl3MGHJj3/L6ahYeq4/r8v+WFnoClLmIhAIrNV4/
	 RjDUIrGURgbHg==
Date: Wed, 5 Jul 2023 11:23:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Simon Horman <simon.horman@corigine.com>
Cc: Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	valex@nvidia.com, kliteyn@nvidia.com, mbloch@nvidia.com,
	danielj@nvidia.com, erezsh@mellanox.com, saeedm@nvidia.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net] net/mlx5: DR, fix memory leak in
 mlx5dr_cmd_create_reformat_ctx
Message-ID: <20230705082353.GJ6455@unreal>
References: <20230704033308.3773764-1-shaozhengchao@huawei.com>
 <ZKQvbCkdeVWWCzEw@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKQvbCkdeVWWCzEw@corigine.com>

On Tue, Jul 04, 2023 at 03:40:44PM +0100, Simon Horman wrote:
> On Tue, Jul 04, 2023 at 11:33:08AM +0800, Zhengchao Shao wrote:
> > when mlx5_cmd_exec failed in mlx5dr_cmd_create_reformat_ctx, the memory
> > pointed by 'in' is not released, which will cause memory leak. Move memory
> > release after mlx5_cmd_exec.
> > 
> > Fixes: 1d9186476e12 ("net/mlx5: DR, Add direct rule command utilities")
> > Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
> > index 7491911ebcb5..cf5820744e99 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
> > @@ -563,11 +563,11 @@ int mlx5dr_cmd_create_reformat_ctx(struct mlx5_core_dev *mdev,
> >  		memcpy(pdata, reformat_data, reformat_size);
> >  
> >  	err = mlx5_cmd_exec(mdev, in, inlen, out, sizeof(out));
> > +	kvfree(in);
> >  	if (err)
> >  		return err;
> >  
> >  	*reformat_id = MLX5_GET(alloc_packet_reformat_context_out, out, packet_reformat_id);
> > -	kvfree(in);
> >  
> >  	return err;
> >  }
> 
> Hi Zhengchao Shao,
> 
> I agree this is a correct fix.
> However, I think a more idiomatic approach to this problem
> would be to use a goto label. Something like this (completely untested!).

Thanks, your change looks more natural to me.

> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
> index 7491911ebcb5..8c2a34a0d6be 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
> @@ -564,11 +564,12 @@ int mlx5dr_cmd_create_reformat_ctx(struct mlx5_core_dev *mdev,
>  
>  	err = mlx5_cmd_exec(mdev, in, inlen, out, sizeof(out));
>  	if (err)
> -		return err;
> +		goto err_free_in;
>  
>  	*reformat_id = MLX5_GET(alloc_packet_reformat_context_out, out, packet_reformat_id);
> -	kvfree(in);
>  
> +err_free_in:
> +	kvfree(in);
>  	return err;
>  }
>  

