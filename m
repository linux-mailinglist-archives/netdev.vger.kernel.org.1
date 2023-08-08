Return-Path: <netdev+bounces-25456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A2077424E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976161C20DF3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328B114F7C;
	Tue,  8 Aug 2023 17:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD91B7FE
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5EAC433C7;
	Tue,  8 Aug 2023 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691516471;
	bh=bQeET287u4FrEtR9uMyzFa0MioeU997vXonpEsqKQAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQ65x6YFs8IkZg+TVeR/YIGyHnQe2U8Lkz1CQ1Ltau5dVdXkdw3HdQj4oCk0cmUOD
	 zwRTz0I8AUs0w48O3j4JD7pUSsrRpxvbAAk9qMpkWIrUCveo7cmmrCBe9Wimh/e80m
	 oUCH0jhi9YpV4Z5saSEUQqBV6zn94LUYeZNUeUrNK0jjtP5nUuYKPWqh5W4hmBX/8y
	 JihQpx/9xGj//B2h7bzeE9Ya6GG9fj9U/Lzyola5XX8ZuUt4Tw1xWubLw6yYLX1ymF
	 MbXvz/DOi0sB0kUEf4hgWzLZQuMEkzDi8sOf84EMQL9C6cvIDlpTYPl+46upxL3LRN
	 YYQpGDfikcejw==
Date: Tue, 8 Aug 2023 20:41:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH mlx5-next 09/14] net/mlx5: Configure MACsec steering for
 egress RoCEv2 traffic
Message-ID: <20230808174107.GA94631@unreal>
References: <cover.1691403485.git.leon@kernel.org>
 <4e114bd19fe2cd8732c0efffa2f0f90d1dc5ec44.1691403485.git.leon@kernel.org>
 <ZNJcq4UHoxeLYrl7@vergenet.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNJcq4UHoxeLYrl7@vergenet.net>

On Tue, Aug 08, 2023 at 05:18:03PM +0200, Simon Horman wrote:
> On Mon, Aug 07, 2023 at 01:44:18PM +0300, Leon Romanovsky wrote:
> > From: Patrisious Haddad <phaddad@nvidia.com>
> > 
> > Add steering table in RDMA_TX domain, to forward MACsec traffic
> > to MACsec crypto table in NIC domain.
> > The tables are created in a lazy manner when the first TX SA is
> > being created, and destroyed upon the destruction of the last SA.
> > 
> > Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  .../mellanox/mlx5/core/lib/macsec_fs.c        | 46 ++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> > index d39ca7c66542..15e7ea3ed79f 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> > @@ -95,6 +95,8 @@ struct mlx5_macsec_tx {
> >  	struct ida tx_halloc;
> >  
> >  	struct mlx5_macsec_tables tables;
> > +
> > +	struct mlx5_flow_table *ft_rdma_tx;
> >  };
> >  
> >  struct mlx5_macsec_rx_rule {
> > @@ -173,6 +175,9 @@ static void macsec_fs_tx_destroy(struct mlx5_macsec_fs *macsec_fs)
> >  	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
> >  	struct mlx5_macsec_tables *tx_tables;
> >  
> > +	if (mlx5_is_macsec_roce_supported(macsec_fs->mdev))
> > +		mlx5_destroy_flow_table(tx_fs->ft_rdma_tx);
> 
> Hi Patrisious and Leon,
> 
> mlx5_is_macsec_roce_supported() is used here, but it doesn't seem
> to be added until a later in this series.

It is my fault, I reordered patches prior to submission and didn't
compile them separately.

Thanks

> 
> ...

