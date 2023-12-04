Return-Path: <netdev+bounces-53564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D208A803B1B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876821F210CC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E562E626;
	Mon,  4 Dec 2023 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkTKqtOp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C00171D9
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 17:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCAFC433C8;
	Mon,  4 Dec 2023 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701709543;
	bh=kXiqZShYqFrkgxcnQlAJeiEC7SLHjojCuiviqo/pbgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkTKqtOpUkq4C+1jSHAYzbQLw4Qi1aeLrTUcepwZggdtY9ugB8UurxovWcEWx0fNc
	 NP3w/Xa6UtMbkpPfjAJ5mQXUNh8UGS+DQXeZeDUxzvNVGdLKcgS5BiLxx/UIrwLkyo
	 QJVMszIgbTsn4WQp7k5RbmbwoK8VQtTj6OlYAV1m1ImwS5DdPcLxOL1IHYLvcmzwEp
	 jzo7natEYHVP3iEDLN42coHpANdSfTBgYJKtc44ZoeZkTAHXWSh+UUc4n1QW81Oazv
	 5yOu2FJvQAqkc1/Q7BuueKVMm5V30EPsWMz9rMPRNozt6bN8cILtY8P+gWwE3qho3n
	 viBp8M//0JMtg==
Date: Mon, 4 Dec 2023 19:05:38 +0200
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
Message-ID: <20231204170538.GC5136@unreal>
References: <20231122014804.27716-1-saeed@kernel.org>
 <20231122014804.27716-10-saeed@kernel.org>
 <ZV3GSeNC0Pe3ubhB@nanopsycho>
 <20231122093546.GA4760@unreal>
 <ZV3O7dwQMLlNFZp3@nanopsycho>
 <20231122112832.GB4760@unreal>
 <ZWXW5o9XIb0RHpkb@nanopsycho>
 <20231128160849.GA6535@unreal>
 <ZWdP4utCeq4MIJ99@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWdP4utCeq4MIJ99@nanopsycho>

On Wed, Nov 29, 2023 at 03:51:14PM +0100, Jiri Pirko wrote:
> Tue, Nov 28, 2023 at 05:08:49PM CET, leon@kernel.org wrote:
> >On Tue, Nov 28, 2023 at 01:02:46PM +0100, Jiri Pirko wrote:
> >> Wed, Nov 22, 2023 at 12:28:32PM CET, leon@kernel.org wrote:
> >> >On Wed, Nov 22, 2023 at 10:50:37AM +0100, Jiri Pirko wrote:
> >> >> Wed, Nov 22, 2023 at 10:35:46AM CET, leon@kernel.org wrote:
> >> >> >On Wed, Nov 22, 2023 at 10:13:45AM +0100, Jiri Pirko wrote:
> >> >> >> Wed, Nov 22, 2023 at 02:47:58AM CET, saeed@kernel.org wrote:
> >> >> >> >From: Jianbo Liu <jianbol@nvidia.com>
> >> 
> >> [...]
> >> 
> >> 
> >> >while we are in eswitch. It is skipped in lines 1556-1558:
> >> >
> >> >  1548 static void
> >> >  1549 mlx5e_vport_rep_unload(struct mlx5_eswitch_rep *rep)
> >> >  1550 {
> >> >  1551         struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
> >> >  1552         struct net_device *netdev = rpriv->netdev;
> >> >  1553         struct mlx5e_priv *priv = netdev_priv(netdev);
> >> >  1554         void *ppriv = priv->ppriv;
> >> >  1555
> >> >  1556         if (rep->vport == MLX5_VPORT_UPLINK) {
> >> >  1557                 mlx5e_vport_uplink_rep_unload(rpriv);
> >> >  1558                 goto free_ppriv;
> >> >  1559         }
> >> 
> >> Uplink netdev is created and destroyed by a different code:
> >> mlx5e_probe()
> >> mlx5e_remove()
> >> 
> >> According to my testing. The uplink netdev is properly removed and
> >> re-added during reload-reinit. What am I missing?
> >
> >You are missing internal profile switch from eswitch to legacy,
> >when you perform driver unload.
> >
> >Feel free to contact me or Jianbo offline if you need more mlx5 specific
> >details.
> 
> Got it. But that switch can happend independently of devlink reload
> reinit. 

Right, devlink reload was relatively easy "to close" and users would see
the reason for it.


> Also, I think it cause more issues than just abandoned ipsec rules.

Yes, it is.

> 
> 
> >
> >Thanks
> >
> >> 
> >> 
> >> 
> >> >  1560
> >> >  1561         unregister_netdev(netdev);
> >> >  1562         mlx5e_rep_vnic_reporter_destroy(priv);
> >> >  1563         mlx5e_detach_netdev(priv);
> >> >  1564         priv->profile->cleanup(priv);
> >> >  1565         mlx5e_destroy_netdev(priv);
> >> >  1566 free_ppriv:
> >> >  1567         kvfree(ppriv); /* mlx5e_rep_priv */
> >> >  1568 }
> >> >
> >> 
> >> [...]
> >> 
> >> 

