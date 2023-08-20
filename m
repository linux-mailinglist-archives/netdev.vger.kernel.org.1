Return-Path: <netdev+bounces-29150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB31781D4C
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B65C1C208C1
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDAD15AA;
	Sun, 20 Aug 2023 09:59:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC910F1
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 09:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC04C433C7;
	Sun, 20 Aug 2023 09:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692525571;
	bh=X91QKg7Fc5nMnO2vsMXj3t2MpczDXtEgtfY3MkuBHbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tw8H8klr/L/35MQP7T/CdKiVTZQ9TdGsJ6ZTZjxCAQTdFmu0HZCrqIEct/ySec9PN
	 at+iU+bQNI4c0sI/ITB80RiWwTqhFRRHHNxsEPdWecuyCQTasM4IhGSEF9YzePI+qG
	 WYTGyhOl3N0k/QNGVf2B9T/82JslYbGkyv1JoqiiFWSLh5DSytDv56ucZK2MIY588u
	 yx7mD7+fLwILebYZfVDwroXG4453Xm2APiApI14vJPe0JMLqKzL014J72LLfd10jLA
	 8IK/Mq9FPLQyPSNP3ao/nOgqbSm0Jqn/5rQJMWJtks/nFF7Pi1qh92YFRBl7VrgFfB
	 fnWkxZpBSuafQ==
Date: Sun, 20 Aug 2023 12:59:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Get upper device only if device
 is lagged
Message-ID: <20230820095926.GE1562474@unreal>
References: <cover.1692168533.git.leon@kernel.org>
 <117b591f5e6e130aeccc871888084fb92fb43b5a.1692168533.git.leon@kernel.org>
 <ZN+dX1hkUbEIHid4@nvidia.com>
 <ZN+fdgo4givpj12R@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN+fdgo4givpj12R@nvidia.com>

On Fri, Aug 18, 2023 at 01:42:30PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 18, 2023 at 01:33:35PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 16, 2023 at 09:52:23AM +0300, Leon Romanovsky wrote:
> > > From: Mark Bloch <mbloch@nvidia.com>
> > > 
> > > If the RDMA device isn't in LAG mode there is no need
> > > to try to get the upper device.
> > > 
> > > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/infiniband/hw/mlx5/main.c | 22 +++++++++++++++-------
> > >  1 file changed, 15 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > > index f0b394ed7452..215d7b0add8f 100644
> > > --- a/drivers/infiniband/hw/mlx5/main.c
> > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > @@ -195,12 +195,18 @@ static int mlx5_netdev_event(struct notifier_block *this,
> > >  	case NETDEV_CHANGE:
> > >  	case NETDEV_UP:
> > >  	case NETDEV_DOWN: {
> > > -		struct net_device *lag_ndev = mlx5_lag_get_roce_netdev(mdev);
> > >  		struct net_device *upper = NULL;
> > >  
> > > -		if (lag_ndev) {
> > > -			upper = netdev_master_upper_dev_get(lag_ndev);
> > > -			dev_put(lag_ndev);
> > > +		if (ibdev->lag_active) {
> > 
> > Needs locking to read lag_active
> 
> Specifically the use of the bitfield looks messed up.. If lag_active
> and some others were set only during probe it could be OK.

All fields except ib_active are static and set during probe.

> 
> But mixing other stuff that is being written concurrently is not OK to
> do like this. (eg ib_active via a mlx5 notifier)

What you are looking is the following change, did I get you right?

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 9d0c56b59ed2..ee73113717b2 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1094,7 +1094,7 @@ struct mlx5_ib_dev {
        /* serialize update of capability mask
         */
        struct mutex                    cap_mask_mutex;
-       u8                              ib_active:1;
+       bool                            ib_active;
        u8                              is_rep:1;
        u8                              lag_active:1;
        u8                              wc_support:1;

> 
> Jason

