Return-Path: <netdev+bounces-50028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E627F44EB
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 12:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9A11C208B8
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500B524D6;
	Wed, 22 Nov 2023 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY8Z0yV4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EA1863E
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 11:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D04C433C8;
	Wed, 22 Nov 2023 11:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700652516;
	bh=tqgG/96PTXlVkBMRfR2Rmzc+Jz46pRysUuIhvwzL8YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gY8Z0yV4ZklgzEiHroZbKT3RixRckwVf6O8CTIm+77gs5xi/c6Tcjz5j/vcn/sXOX
	 NWIeoMLb3xYgo/K3FvPL0urzMFyhWDyc3cCebcS1ij94N3GqgFeFV8pAclolm3h6xL
	 BOAliUUgOQLKzJZRIuJQkBTjpupnskNVQSbKkYxQ88A7NyM4D0cq2MIDZwL7o0dkW1
	 P1IGcmhD+vIAZZDKPRX+9SERwxyJ0KbUT4BfCjPhgS47nx6j2bjR6O/Ag3pE1TCQyL
	 fsfg0WpV08uSRho+s3kFWY1W4Tg0Vvq/78ei9si/l/j0s7tMaPnczOkdrjZIsev6em
	 lbTsU6aVSHOBQ==
Date: Wed, 22 Nov 2023 13:28:32 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [net 09/15] net/mlx5e: Forbid devlink reload if IPSec rules are
 offloaded
Message-ID: <20231122112832.GB4760@unreal>
References: <20231122014804.27716-1-saeed@kernel.org>
 <20231122014804.27716-10-saeed@kernel.org>
 <ZV3GSeNC0Pe3ubhB@nanopsycho>
 <20231122093546.GA4760@unreal>
 <ZV3O7dwQMLlNFZp3@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV3O7dwQMLlNFZp3@nanopsycho>

On Wed, Nov 22, 2023 at 10:50:37AM +0100, Jiri Pirko wrote:
> Wed, Nov 22, 2023 at 10:35:46AM CET, leon@kernel.org wrote:
> >On Wed, Nov 22, 2023 at 10:13:45AM +0100, Jiri Pirko wrote:
> >> Wed, Nov 22, 2023 at 02:47:58AM CET, saeed@kernel.org wrote:
> >> >From: Jianbo Liu <jianbol@nvidia.com>
> >> >
> >> >When devlink reload, mlx5 IPSec module can't be safely cleaned up if
> >> >there is any IPSec rule offloaded, so forbid it in this condition.
> >> >
> >> >Fixes: edd8b295f9e2 ("Merge branch 'mlx5-ipsec-packet-offload-support-in-eswitch-mode'")
> >> >Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> >> >Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >> >Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> >> >---
> >> > drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  5 +++++
> >> > drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  2 ++
> >> > .../mellanox/mlx5/core/eswitch_offloads.c         | 15 +++++++++++++++
> >> > 3 files changed, 22 insertions(+)
> >> >
> >> >diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> >> >index 3e064234f6fe..8925e87a3ed5 100644
> >> >--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> >> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> >> >@@ -157,6 +157,11 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
> >> > 		return -EOPNOTSUPP;
> >> > 	}
> >> > 
> >> >+	if (mlx5_eswitch_mode_is_blocked(dev)) {
> >> >+		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported if IPSec rules are configured");
> >> 
> >> That sounds a bit odd to me to be honest. Is pci device unbind forbidden
> >> if ipsec rules are present too? This should be gracefully handled
> >> instead of forbid.
> >
> >unbind is handled differently because that operation will call to
> >unregister netdevice event which will clean everything.
> 
> But in reload, the netdevice is also unregistered. Same flow, isn't it?

Unfortunately not, we (mlx5) were forced by employer of one of
the netdev maintainers to keep uplink netdev in devlink reload
while we are in eswitch. It is skipped in lines 1556-1558:

  1548 static void
  1549 mlx5e_vport_rep_unload(struct mlx5_eswitch_rep *rep)
  1550 {
  1551         struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
  1552         struct net_device *netdev = rpriv->netdev;
  1553         struct mlx5e_priv *priv = netdev_priv(netdev);
  1554         void *ppriv = priv->ppriv;
  1555
  1556         if (rep->vport == MLX5_VPORT_UPLINK) {
  1557                 mlx5e_vport_uplink_rep_unload(rpriv);
  1558                 goto free_ppriv;
  1559         }
  1560
  1561         unregister_netdev(netdev);
  1562         mlx5e_rep_vnic_reporter_destroy(priv);
  1563         mlx5e_detach_netdev(priv);
  1564         priv->profile->cleanup(priv);
  1565         mlx5e_destroy_netdev(priv);
  1566 free_ppriv:
  1567         kvfree(ppriv); /* mlx5e_rep_priv */
  1568 }

> 
> >
> >devlink reload behaves differently from unbind.
> 
> I don't see why. Forget about the driver implementation for now. From
> the perspective of the user, what's the difference between these flows:
> 1) unbind->netdevremoval

netdevice can be removed and there is no way to inform users about errors.

> 2) reload->netdevremoval

According to that employer, netdevice should stay.

> 
> Both should be working and do necessary cleanups.

I would be more than happy to see same flow, but this is above my
pay grade and I have little desire to be in the middle between
that netdev maintainer and his management.

Feel free to approach me offline, and I will give you the names.

Thanks

> 
> 
> >
> >Thanks

