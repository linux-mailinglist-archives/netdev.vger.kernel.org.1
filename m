Return-Path: <netdev+bounces-25281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8601F773AF4
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3BF1C21013
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE92412B7D;
	Tue,  8 Aug 2023 15:18:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81812B6C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637C7C433C7;
	Tue,  8 Aug 2023 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691507888;
	bh=HCIa94Zv6SIWWoG/MsBuHuvS7X4QM3uRoNVny9Wk6QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2PYGOMMq1T1P10Tw+P0qnKvFHY5k8+n/73jijKBGi/UqEf3ZiJfA7eUXoLmOsrj1
	 yBEUCFG3n75E+sCS5+BwBGpqrQe6MprzxhqPGrcmE2Yf1RtZ7HBYRtv4MmCwkW+TVy
	 cqb+TcpGywq/DbD54rpLYcNO3vpoMh59Y7HRlchVRT2fpLB5b/b4uhC0ukG33zxrsQ
	 IuEuVhsP+rb8rfaHQSi9+4N2WVfSEbO9oPJjZSdLbGgX/V8fQQaePk2njuV+tQZiLQ
	 2jV3YZcw69xtcOey7jgc8wB0pgB0H28ekvpV5p9wXNb+ygU2aUsdlTu7xZkF+qLXLB
	 mrKph9gxknk6w==
Date: Tue, 8 Aug 2023 17:18:03 +0200
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH mlx5-next 09/14] net/mlx5: Configure MACsec steering for
 egress RoCEv2 traffic
Message-ID: <ZNJcq4UHoxeLYrl7@vergenet.net>
References: <cover.1691403485.git.leon@kernel.org>
 <4e114bd19fe2cd8732c0efffa2f0f90d1dc5ec44.1691403485.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e114bd19fe2cd8732c0efffa2f0f90d1dc5ec44.1691403485.git.leon@kernel.org>

On Mon, Aug 07, 2023 at 01:44:18PM +0300, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Add steering table in RDMA_TX domain, to forward MACsec traffic
> to MACsec crypto table in NIC domain.
> The tables are created in a lazy manner when the first TX SA is
> being created, and destroyed upon the destruction of the last SA.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  .../mellanox/mlx5/core/lib/macsec_fs.c        | 46 ++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> index d39ca7c66542..15e7ea3ed79f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> @@ -95,6 +95,8 @@ struct mlx5_macsec_tx {
>  	struct ida tx_halloc;
>  
>  	struct mlx5_macsec_tables tables;
> +
> +	struct mlx5_flow_table *ft_rdma_tx;
>  };
>  
>  struct mlx5_macsec_rx_rule {
> @@ -173,6 +175,9 @@ static void macsec_fs_tx_destroy(struct mlx5_macsec_fs *macsec_fs)
>  	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
>  	struct mlx5_macsec_tables *tx_tables;
>  
> +	if (mlx5_is_macsec_roce_supported(macsec_fs->mdev))
> +		mlx5_destroy_flow_table(tx_fs->ft_rdma_tx);

Hi Patrisious and Leon,

mlx5_is_macsec_roce_supported() is used here, but it doesn't seem
to be added until a later in this series.

...

