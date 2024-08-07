Return-Path: <netdev+bounces-116397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DDE94A52B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FA528203A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5801D363F;
	Wed,  7 Aug 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0AV+5ab"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D111D173E
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025492; cv=none; b=lzZqj7+E2Q0dVhbDb/+lqIYPqHPnLPZC+FtiUAQ4wYsIqKFjPgMtVIUJd88z/syoCrI8k5STE9gc2OFUH9loDe6JWLaBuvR3WnGhngskAxIRksLqU3EMKzzoyWVwCYl5Gv69Rcf8dKubFv/6sCoKMV9XdebiJ/SmyChFd7uWRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025492; c=relaxed/simple;
	bh=WjpcEdgGymYyliLbCcBCxhuOLydUfle3DQyVOM4wYDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg47I3rIU4OHFqoatSHyQbg6zsa0km0BjzR19+HhTHHF6BDUZNJLWQaLttsRF3p02o3LrUnJXx4k/Ysb6NFGf20Bv1R0w/CkhplKk2020ltxhjcIsCXE53StfmyB5hllPTX6hshq5DjSViSpL2OT0X5T4LpR8mwwgnlJcndIWV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0AV+5ab; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc4fcbb131so13788675ad.3
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 03:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723025489; x=1723630289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpqnZiwSkxCS0ZV0E1CRt+es1CfiVeWn+Bfy/PfEU20=;
        b=D0AV+5abDUQo9pNMi6BRYj9RNG3gO7rcLJc3ucQ649p9HiOH1aMvC+6oJUZ7wvh4SR
         mmnGg/ytEN+shRA2auBUhQw0lspC8Zl5DVJwgYBFc+oFIs4ObxfGFqE/Hq/2uQGflmp/
         IjmlS4lLduRIO7ALLXHg0+2O5Px7sgOQEs11Gg0D+JLI87i5dsLa+g59U2Ti4uHX7RKm
         injY03Ij9z3snEQO6Z8DU77xWbADwdAA8gcFd6ZGl0BWtxDP+/T7x1yKuiWdM3Cr0Tl4
         R3csZ7eKCRR7b6GvKHWGbKAff+czxHox06YEgt15cyWQZZGy2P3wZLQvf8NYbowjHrEl
         P6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723025489; x=1723630289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpqnZiwSkxCS0ZV0E1CRt+es1CfiVeWn+Bfy/PfEU20=;
        b=B9ousanzFoex3BSe6xBSJtkWF40hsi8K1D64J7Fo7flpFdR3ofnZ6Wr7U/5zA8o+Hg
         kYqv5s0UkPeSATDu0oXcz1rglx0SMyH9r1YnbpOBvlapGIGyQ14gWIlmaV1iLYel4oMJ
         pl4l7wtHDzKV+hyVr701l0n8g6+RZ3OdJcQkn8NPcPBlfew+vWrzf7qZextBwj9RecfC
         QJjoJEQveE1QO6uYfNRqRRklPEAKzgu7n/mVAw7Q6p9F16R6Eo+OB4UVgKsxF3/LaXzX
         DQCq0pWdtdOXaZUhgWpke4pO/yFFqQT2O6Adidr2PniJbKJg6klxCjoLkRMcO+JyU/Zf
         IGCw==
X-Forwarded-Encrypted: i=1; AJvYcCXCe0CJicXOzIIcekMXeXyPelmZnqWVgRCr0k1s33BAbai+qbhg2QwahtR7oKDfNpk+++SmXh98ToD9+w6z8eW6I1tuhBpy
X-Gm-Message-State: AOJu0YxAqizyYNMd3YE2mxpxLZxRX21jvbAU5jdAypew2ttggJvX3VLu
	pfmzE9xgAo4bdUACIGCQi3Bwp2KSvpcc/jU80a/1LNC5SCQDZ1Ih
X-Google-Smtp-Source: AGHT+IHNlmebuqRD/9Aysj0Z4zZXPG8ARUgiFWIyN5cejo0qimoyjEQiD2xXEfAb56nW4HvTFOJBfg==
X-Received: by 2002:a17:902:d4c4:b0:1fc:3daa:52 with SMTP id d9443c01a7336-1ff5722d9c5mr243350915ad.11.1723025489100;
        Wed, 07 Aug 2024 03:11:29 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f58702sm102994125ad.103.2024.08.07.03.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:11:28 -0700 (PDT)
Date: Wed, 7 Aug 2024 18:11:22 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Message-ID: <ZrNISr5dB_KB4Uat@Laptop-X1>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
 <20240805050357.2004888-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805050357.2004888-2-tariqt@nvidia.com>

On Mon, Aug 05, 2024 at 08:03:55AM +0300, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> Add this implementation for bonding, so hardware resources can be
> freed after xfrm state is deleted.
> 
> And call it when deleting all SAs from old active real interface.
> 
> Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 1cd92c12e782..eb5e43860670 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -581,6 +581,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  				   __func__);
>  		} else {
>  			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> +			if (slave->dev->xfrmdev_ops->xdo_dev_state_free)
> +				slave->dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
>  		}
>  		ipsec->xs->xso.real_dev = NULL;
>  	}
> @@ -588,6 +590,35 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  	rcu_read_unlock();
>  }
>  
> +static void bond_ipsec_free_sa(struct xfrm_state *xs)
> +{
> +	struct net_device *bond_dev = xs->xso.dev;
> +	struct net_device *real_dev;
> +	struct bonding *bond;
> +	struct slave *slave;
> +
> +	if (!bond_dev)
> +		return;
> +
> +	rcu_read_lock();
> +	bond = netdev_priv(bond_dev);
> +	slave = rcu_dereference(bond->curr_active_slave);
> +	real_dev = slave ? slave->dev : NULL;
> +	rcu_read_unlock();
> +
> +	if (!slave)
> +		return;
> +
> +	if (!xs->xso.real_dev)
> +		return;
> +
> +	WARN_ON(xs->xso.real_dev != real_dev);
> +
> +	if (real_dev && real_dev->xfrmdev_ops &&
> +	    real_dev->xfrmdev_ops->xdo_dev_state_free)
> +		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
> +}
> +
>  /**
>   * bond_ipsec_offload_ok - can this packet use the xfrm hw offload
>   * @skb: current data packet
> @@ -632,6 +663,7 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
>  static const struct xfrmdev_ops bond_xfrmdev_ops = {
>  	.xdo_dev_state_add = bond_ipsec_add_sa,
>  	.xdo_dev_state_delete = bond_ipsec_del_sa,
> +	.xdo_dev_state_free = bond_ipsec_free_sa,
>  	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
>  };
>  #endif /* CONFIG_XFRM_OFFLOAD */
> -- 
> 2.44.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

