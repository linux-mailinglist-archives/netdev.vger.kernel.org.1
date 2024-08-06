Return-Path: <netdev+bounces-115994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017C4948B85
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F381C21C4E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 08:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BEE1BD03B;
	Tue,  6 Aug 2024 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJiAOChX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC573165F00
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933945; cv=none; b=Kdc1/5mWLuLQStFZJ3r+Aw1yH4u1GHI9yrlaNrp3dDGDUrPjkKOpoMi1pUJi5DF8SKjrvJBl0GHU1vKJaYbiUrE1Dv8I++4nYVTyoqe+kzolMFBcIYXcvqQB3IDvaJPdvrZPWMqbV5xSN0TCs66a6mN33XPXOXY91bEUEIGbKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933945; c=relaxed/simple;
	bh=bzjFl03z7mKoRmaW9b2zz5U4zB0PjHpDSCtcZk43QzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laCcj1YFeLXz2vlmnS8DeL6Q5AebuC9IbIqtAPCkMlJ2lob3zL8Gp9a264OBQJHF1Jctrfvp0Wsy7Nrtr1O8NkvyIQTDS7SGRmbDva4sHtysXOjFjFNyWluqYrG92PW13XgPSaOpQ6OVNqRfRXFzFPFONUINNbggd1T9CrYUvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJiAOChX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7104f939aa7so299173b3a.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 01:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722933943; x=1723538743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2a6enoXvYi58QDDvTVD9zmpzX4m8VIPdQ59FnjkcToo=;
        b=iJiAOChXve5osdpq79zVJoA8vQe2KhDMu7y1V+zY6TJQqSjp9KcfZk+9Hlu64EgTE/
         7qRF5I+9O3D+ZgP4nXrBPwqQm6Kz39hTJ+EA53Xyrc/PIU1a9jxINKzlIBXXm5B7wO3a
         yJhLkb8uAMnDFqY3eoZLdkMfYc1Fz/yKnXkY6Y8BaDo3IuYmnOveTfwcAf9SQ2OAioeK
         XW/s5FGuqmcyCDk2wS8jq/Vbb0g0ckUaFyfph/nnSJggISTXRxfpWbApUAvxXfyyMv5M
         QfLH0d1VNyZ1jaTdah6d1bfyvRDVZEYi9QlO74rO+wwtRIOQ/ryEw3fgwjrHXKpaydkc
         qrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722933943; x=1723538743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a6enoXvYi58QDDvTVD9zmpzX4m8VIPdQ59FnjkcToo=;
        b=q1JLuWpGS9rCbZDCzBpgPyeYdh++R6ULuboimDBRfBQaRWSkwYKHUsUx3W9Ix9r1BS
         zQKxo+xpB6NdlglgCiA/pdMrm9B9+G6qiGiEmdnt+zCnIncfgN5cwOiKFplBRpsoVv6t
         XXX2TPTVCdFJiOz2odmzBy5v/PJsuapvAjOjG2aLfiX4ibsyoHYUP2DSogwYXEToHeWY
         hV89FN0cUPuTqdu5mjGbO4S3LhdfzaiIvw6/cBmtLbD1s46PpwVqPNiSiwzWugJgYUgF
         zXr6YOhe6SOyimhXOnmdLTWCTFPDnfhtFfYlgXSC/l9ufv8i8xrUSvBZtUeaRw/0fiA7
         v9jg==
X-Forwarded-Encrypted: i=1; AJvYcCUyTruvzKxaiJtMEzwCxuuICgweAqlViMh2iVRNhyTR2AS+9T4JnLnWKPSKY585F2vAKUFHFvwlWhfVP/rnjTbI3X2u5Qp9
X-Gm-Message-State: AOJu0YwbX6/3ikG3j4EHKurguqsf1a1DMdxbrcJAaWbNuv6+9V4GjUe2
	uR73VquSUw7XZNg6CTfqXGeE65waPuXsGmXmWWKoQXJeO7DUAv3V
X-Google-Smtp-Source: AGHT+IGEFg1Epm67TcStXyXeeCPQGKWm/Ed5QdtpqwAFDrSf/uOADg3grfxVWW9QiEJzPW+MQ8D5Sg==
X-Received: by 2002:a05:6a00:b88:b0:704:2f65:4996 with SMTP id d2e1a72fcca58-7106cfa2faamr17973424b3a.11.1722933942928;
        Tue, 06 Aug 2024 01:45:42 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec73f0bsm6789024b3a.94.2024.08.06.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 01:45:42 -0700 (PDT)
Date: Tue, 6 Aug 2024 16:45:36 +0800
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
Message-ID: <ZrHisKjAQPtbBJFa@Laptop-X1>
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

Do we need to check netif_is_bond_master(slave->dev) here?

Thanks
Hangbin

