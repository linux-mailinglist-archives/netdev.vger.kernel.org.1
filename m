Return-Path: <netdev+bounces-51763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1CA7FBEF8
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DCC2825A9
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9837D10;
	Tue, 28 Nov 2023 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZt8Gu8W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A237D00
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 16:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F40CC433C8;
	Tue, 28 Nov 2023 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701187734;
	bh=lcIfSc8SstynVkPEZPUhrQkYMGebylOmH6ZE2Byhoeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZt8Gu8WjPsizT79ERo87BEdC1i2n8F+Opf8RfHwpntI/tZm1ejm0/OIlUaDoAGpZ
	 n6+Sb3u4UU5Uox12b8Z8gxgXLinAUiCK3mUxuf9+QYj5vV8ciBIPqE4QgttCzDcr+2
	 W09VQqcxwmhv4Ezipbvq7uzUKg2cM6BBah5wlhaMTKXCghE5u3VHfe8XIVv0fOGWge
	 Q86HZyoyaQaIjgiCvWMzPnjzMFhd4JGJhMfDChmbENrDW4u95kV+MFq5Ow/rUkAn75
	 yrTi7UvHPYz+1Oruwy5ptJ3iR1I5wrXQMVLhC7NcE+t9k8D0e9abiV4nZa627oYYrj
	 08l9W9bJEJxSA==
Date: Tue, 28 Nov 2023 18:08:49 +0200
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
Message-ID: <20231128160849.GA6535@unreal>
References: <20231122014804.27716-1-saeed@kernel.org>
 <20231122014804.27716-10-saeed@kernel.org>
 <ZV3GSeNC0Pe3ubhB@nanopsycho>
 <20231122093546.GA4760@unreal>
 <ZV3O7dwQMLlNFZp3@nanopsycho>
 <20231122112832.GB4760@unreal>
 <ZWXW5o9XIb0RHpkb@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWXW5o9XIb0RHpkb@nanopsycho>

On Tue, Nov 28, 2023 at 01:02:46PM +0100, Jiri Pirko wrote:
> Wed, Nov 22, 2023 at 12:28:32PM CET, leon@kernel.org wrote:
> >On Wed, Nov 22, 2023 at 10:50:37AM +0100, Jiri Pirko wrote:
> >> Wed, Nov 22, 2023 at 10:35:46AM CET, leon@kernel.org wrote:
> >> >On Wed, Nov 22, 2023 at 10:13:45AM +0100, Jiri Pirko wrote:
> >> >> Wed, Nov 22, 2023 at 02:47:58AM CET, saeed@kernel.org wrote:
> >> >> >From: Jianbo Liu <jianbol@nvidia.com>
> 
> [...]
> 
> 
> >while we are in eswitch. It is skipped in lines 1556-1558:
> >
> >  1548 static void
> >  1549 mlx5e_vport_rep_unload(struct mlx5_eswitch_rep *rep)
> >  1550 {
> >  1551         struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
> >  1552         struct net_device *netdev = rpriv->netdev;
> >  1553         struct mlx5e_priv *priv = netdev_priv(netdev);
> >  1554         void *ppriv = priv->ppriv;
> >  1555
> >  1556         if (rep->vport == MLX5_VPORT_UPLINK) {
> >  1557                 mlx5e_vport_uplink_rep_unload(rpriv);
> >  1558                 goto free_ppriv;
> >  1559         }
> 
> Uplink netdev is created and destroyed by a different code:
> mlx5e_probe()
> mlx5e_remove()
> 
> According to my testing. The uplink netdev is properly removed and
> re-added during reload-reinit. What am I missing?

You are missing internal profile switch from eswitch to legacy,
when you perform driver unload.

Feel free to contact me or Jianbo offline if you need more mlx5 specific
details.

Thanks

> 
> 
> 
> >  1560
> >  1561         unregister_netdev(netdev);
> >  1562         mlx5e_rep_vnic_reporter_destroy(priv);
> >  1563         mlx5e_detach_netdev(priv);
> >  1564         priv->profile->cleanup(priv);
> >  1565         mlx5e_destroy_netdev(priv);
> >  1566 free_ppriv:
> >  1567         kvfree(ppriv); /* mlx5e_rep_priv */
> >  1568 }
> >
> 
> [...]
> 
> 

