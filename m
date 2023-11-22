Return-Path: <netdev+bounces-49971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF81E7F41C4
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4A41C20906
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E323FB07;
	Wed, 22 Nov 2023 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFG4oREa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D31A5A1
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 09:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D00CC433C8;
	Wed, 22 Nov 2023 09:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700645750;
	bh=rXJIO2WdMbC3II3u80IXsesKa9cPu5Um+PqE540tZv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFG4oREaxQZEFgJju1beGhGRL9h8waBEBVyBAVY9Sgqca0BBzXeW7niBw+UoEikSL
	 CvCFMv9l1FgshF0bRVNbS0XWWr/5jE8Bu6vtzMjO7p6LbkpoPbQz3LHZnAcLrTIwNJ
	 QSE7Ez8+AC36Qi3+0C+IGo5+WYgtQz+5bsjGuJSQxe2508UoZdL0+DWKI2do/Y9+EY
	 LYAw9aszmyle+v1gWY5EIAGlaBQ0jYWDlgN/1n2MwLTPBJkjp+cQLiWyYKIQaS5llw
	 2fosutF/l1yfuJ6Cc8BT2jeZCD/1SXKbZHhN+A57Up45dc26qk33jFmr5NEbwpN5Ca
	 kHBMjCd0qhy9g==
Date: Wed, 22 Nov 2023 11:35:46 +0200
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
Message-ID: <20231122093546.GA4760@unreal>
References: <20231122014804.27716-1-saeed@kernel.org>
 <20231122014804.27716-10-saeed@kernel.org>
 <ZV3GSeNC0Pe3ubhB@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV3GSeNC0Pe3ubhB@nanopsycho>

On Wed, Nov 22, 2023 at 10:13:45AM +0100, Jiri Pirko wrote:
> Wed, Nov 22, 2023 at 02:47:58AM CET, saeed@kernel.org wrote:
> >From: Jianbo Liu <jianbol@nvidia.com>
> >
> >When devlink reload, mlx5 IPSec module can't be safely cleaned up if
> >there is any IPSec rule offloaded, so forbid it in this condition.
> >
> >Fixes: edd8b295f9e2 ("Merge branch 'mlx5-ipsec-packet-offload-support-in-eswitch-mode'")
> >Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> >Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> >---
> > drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  5 +++++
> > drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  2 ++
> > .../mellanox/mlx5/core/eswitch_offloads.c         | 15 +++++++++++++++
> > 3 files changed, 22 insertions(+)
> >
> >diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> >index 3e064234f6fe..8925e87a3ed5 100644
> >--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> >@@ -157,6 +157,11 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
> > 		return -EOPNOTSUPP;
> > 	}
> > 
> >+	if (mlx5_eswitch_mode_is_blocked(dev)) {
> >+		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported if IPSec rules are configured");
> 
> That sounds a bit odd to me to be honest. Is pci device unbind forbidden
> if ipsec rules are present too? This should be gracefully handled
> instead of forbid.

unbind is handled differently because that operation will call to
unregister netdevice event which will clean everything.

devlink reload behaves differently from unbind.

Thanks

