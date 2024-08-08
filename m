Return-Path: <netdev+bounces-116757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B20694B9BA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E586F28112D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5378146019;
	Thu,  8 Aug 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm0bZxOf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6984A51
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109693; cv=none; b=FsMHa/dgV1ewHYzw53+IdsvF21tuxkfGxyAeBw7MBcrY7qFGHVUDkFZ5NDaw5owZ3W1sIKTXFkclDGUP63qE4ZogBLn212X2NMU70okHZdRCfTYhLNNOOhPbfcMKgTQHc7htBWnGvKIcn8zyRFHUGn3QwHECSlL+RZF/nMg2kmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109693; c=relaxed/simple;
	bh=ZoGu36Gg3tG1OAS/Ma3m1KyIOKKKT5FLi3nIIOLy0n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXh4+tp9EMRMY0HtxqRfDcQzXD8ftoU+Yi1Z94uybdEBxagRXVvzL4m4plYU+cfHsBESb8M7hhHJqWvFkY+AoNjazTr7u7CzHmdO3spYbgQKLRDkDYLhzWt1EUbIaQO+IGIH1n/jGa6ddenKPzaRNq7DwLoUlX0gJ5XfHOKly1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm0bZxOf; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-268a9645e72so542794fac.1
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 02:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723109691; x=1723714491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8sgVCURrbQtCZI3hgjZpn+RLT98heZqa49TcHrpel8=;
        b=Qm0bZxOfLEEj5M6J6i30fFl9Pl4D4tpzOZE4oD+QNvgmTIg+wjkQd5+R4eGF2bU97W
         gpXQkzENyLXARNnVuoYresoOrufdi9HevG/v4BswB2rXze3mb69y1/gXyfr5AdiNYTNU
         jYD6DhiscG5uXeKcjWCQZre08DWqCW7mZDJeeqJVkxQOgOZOp8zOy8rbNpRFJDSYyQln
         J5luP9KQV0WB39s3IluH2puqPrszFeOrqNfOPGL97tNFWfGPvMu5wzMBEROLNa+Gls7v
         O0WLk7lIXcuz1q3donmVRXsx/1LREGBoCW1NKQnhbGQJgu3P2iq75lm5ofYsZwHPAJea
         LZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723109691; x=1723714491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8sgVCURrbQtCZI3hgjZpn+RLT98heZqa49TcHrpel8=;
        b=Q4mzH6/zhWzPtCk7+3rw1INRGqgTu1l/nygXk44OM6uvrL0fq1xrR0iwB7FVVM3K4X
         rI1y8HjFb7RxjFJMNweyn1yt7PEtxAdwEDpP2GhjNw8pJJMsyXbfB6yMTahks20wMmph
         3uYLiwMBsekntNkg68EUiDalcyjxYa9auG0YhCow3AUGV6N1DvKA7EEBF/ItinfekKRY
         ErPEYNHwwmswoE/GKCd4SBY53+sZ6IdybDG1M6On3GKy+gu5Cg7OF59v4ngVamMt7WlO
         fGig1Gb4huXP9+vU067PoI87bjKMJ3Ij19MFZw1qm7wq1Zf4JAd9vvJ2io+4wqa5I8kn
         2s4g==
X-Forwarded-Encrypted: i=1; AJvYcCWj+pyi2pjoWjF1bI5O9Yy9h7zmBJtKdETeS3soqJcFEEYEwg22Gm5DyK3OgSAYXSFQoQ5oAEwjteN7nTii54il+m7RORFm
X-Gm-Message-State: AOJu0YyrY4SAbUtMp/96e5MLnu01sEqLujNPCBVrshXrriKfvnuX05UZ
	SuUORLe/ooIVohHOwSWu7xhlxNdEU2NaDrvN/GyQdq9aN15o56nIfWfwrdrg
X-Google-Smtp-Source: AGHT+IGrf7nkeqbojUZoViItLwgvEbCAKXr27qvcRyosrGy69rwkVl/foVlTruwG31xKYefy7nBG6w==
X-Received: by 2002:a05:6870:a54a:b0:254:94a4:35d2 with SMTP id 586e51a60fabf-2692b7ed9f7mr1466925fac.45.1723109691038;
        Thu, 08 Aug 2024 02:34:51 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2d3c8bsm780954b3a.121.2024.08.08.02.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:34:50 -0700 (PDT)
Date: Thu, 8 Aug 2024 17:34:33 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH net V3 3/3] bonding: change ipsec_lock from spin lock to
 mutex
Message-ID: <ZrSRKR-KK5l56XUd@Laptop-X1>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
 <20240805050357.2004888-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805050357.2004888-4-tariqt@nvidia.com>

On Mon, Aug 05, 2024 at 08:03:57AM +0300, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> In the cited commit, bond->ipsec_lock is added to protect ipsec_list,
> hence xdo_dev_state_add and xdo_dev_state_delete are called inside
> this lock. As ipsec_lock is a spin lock and such xfrmdev ops may sleep,
> "scheduling while atomic" will be triggered when changing bond's
> active slave.
> 
> [  101.055189] BUG: scheduling while atomic: bash/902/0x00000200
> [  101.055726] Modules linked in:
> [  101.058211] CPU: 3 PID: 902 Comm: bash Not tainted 6.9.0-rc4+ #1
> [  101.058760] Hardware name:
> [  101.059434] Call Trace:
> [  101.059436]  <TASK>
> [  101.060873]  dump_stack_lvl+0x51/0x60
> [  101.061275]  __schedule_bug+0x4e/0x60
> [  101.061682]  __schedule+0x612/0x7c0
> [  101.062078]  ? __mod_timer+0x25c/0x370
> [  101.062486]  schedule+0x25/0xd0
> [  101.062845]  schedule_timeout+0x77/0xf0
> [  101.063265]  ? asm_common_interrupt+0x22/0x40
> [  101.063724]  ? __bpf_trace_itimer_state+0x10/0x10
> [  101.064215]  __wait_for_common+0x87/0x190
> [  101.064648]  ? usleep_range_state+0x90/0x90
> [  101.065091]  cmd_exec+0x437/0xb20 [mlx5_core]
> [  101.065569]  mlx5_cmd_do+0x1e/0x40 [mlx5_core]
> [  101.066051]  mlx5_cmd_exec+0x18/0x30 [mlx5_core]
> [  101.066552]  mlx5_crypto_create_dek_key+0xea/0x120 [mlx5_core]
> [  101.067163]  ? bonding_sysfs_store_option+0x4d/0x80 [bonding]
> [  101.067738]  ? kmalloc_trace+0x4d/0x350
> [  101.068156]  mlx5_ipsec_create_sa_ctx+0x33/0x100 [mlx5_core]
> [  101.068747]  mlx5e_xfrm_add_state+0x47b/0xaa0 [mlx5_core]
> [  101.069312]  bond_change_active_slave+0x392/0x900 [bonding]
> [  101.069868]  bond_option_active_slave_set+0x1c2/0x240 [bonding]
> [  101.070454]  __bond_opt_set+0xa6/0x430 [bonding]
> [  101.070935]  __bond_opt_set_notify+0x2f/0x90 [bonding]
> [  101.071453]  bond_opt_tryset_rtnl+0x72/0xb0 [bonding]
> [  101.071965]  bonding_sysfs_store_option+0x4d/0x80 [bonding]
> [  101.072567]  kernfs_fop_write_iter+0x10c/0x1a0
> [  101.073033]  vfs_write+0x2d8/0x400
> [  101.073416]  ? alloc_fd+0x48/0x180
> [  101.073798]  ksys_write+0x5f/0xe0
> [  101.074175]  do_syscall_64+0x52/0x110
> [  101.074576]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> As bond_ipsec_add_sa_all and bond_ipsec_del_sa_all are only called
> from bond_change_active_slave, which requires holding the RTNL lock.
> And bond_ipsec_add_sa and bond_ipsec_del_sa are xfrm state
> xdo_dev_state_add and xdo_dev_state_delete APIs, which are in user
> context. So ipsec_lock doesn't have to be spin lock, change it to
> mutex, and thus the above issue can be resolved.
> 
> Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 75 +++++++++++++++++----------------
>  include/net/bonding.h           |  2 +-
>  2 files changed, 40 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index e550b1c08fdb..56764f1c39b8 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -481,35 +476,43 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  	struct bond_ipsec *ipsec;
>  	struct slave *slave;
>  
> -	rcu_read_lock();
> -	slave = rcu_dereference(bond->curr_active_slave);
> -	if (!slave)
> -		goto out;
> +	slave = rtnl_dereference(bond->curr_active_slave);
> +	real_dev = slave ? slave->dev : NULL;
> +	if (!real_dev)
> +		return;
>  
> -	real_dev = slave->dev;
> +	mutex_lock(&bond->ipsec_lock);
>  	if (!real_dev->xfrmdev_ops ||
>  	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
>  	    netif_is_bond_master(real_dev)) {
> -		spin_lock_bh(&bond->ipsec_lock);
>  		if (!list_empty(&bond->ipsec_list))
>  			slave_warn(bond_dev, real_dev,
>  				   "%s: no slave xdo_dev_state_add\n",
>  				   __func__);
> -		spin_unlock_bh(&bond->ipsec_lock);
>  		goto out;
>  	}
>  
> -	spin_lock_bh(&bond->ipsec_lock);
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		struct net_device *dev = ipsec->xs->xso.real_dev;
> +
> +		/* If new state is added before ipsec_lock acquired */
> +		if (dev) {
> +			if (dev == real_dev)
> +				continue;
Hi Jianbo,

Why we skip the deleting here if dev == real_dev? What if the state
is added again on the same slave? From the previous logic it looks we
don't check and do over write for the same device.

Thanks
Hangbin
> +			dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> +			if (dev->xfrmdev_ops->xdo_dev_state_free)
> +				dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
> +		}
> +
>  		ipsec->xs->xso.real_dev = real_dev;
>  		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
>  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
>  			ipsec->xs->xso.real_dev = NULL;
>  		}
>  	}
> -	spin_unlock_bh(&bond->ipsec_lock);
>  out:
> -	rcu_read_unlock();
> +	mutex_unlock(&bond->ipsec_lock);
>  }

