Return-Path: <netdev+bounces-171947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48CA4F8F6
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D41188A2D4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6585F1FC10D;
	Wed,  5 Mar 2025 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Kl+L+zMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84481F5850
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163922; cv=none; b=pjlbfHqZhMXRsIeOX4mVXeqHgVAqHRT9c4R1pC7KMbiAyrrPgHOjcamLxSybUY5/L1pA7v0Hnr43NKkJGhsoXIZUNAT6P4020pr1fZEd7B6JmBOUvHri4ndVKL92XtXb84omb0/DDiGXH8y+xhvGfORkxBBt+iCNgA9I6IN29zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163922; c=relaxed/simple;
	bh=2289srtRYhO2XLtWnNt1zZSHjLPywnfuAh4PjO7nRns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgFKCpr+KEom5+igfd6Hi0SKZ/6g3/5MM87ss6KR8p0LotRTEM+UT2rmdzdG1xKh6Uh4AAo3Q8alwqde+YqlIIePAisAt6Mk50iE759dR0HJuW9bypymq+7WDX6EFE7h1T/8YJqrC64LBstYFByFmPoGI0so9urwkWHlgmb7Ozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Kl+L+zMZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf615d5f31so692037266b.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 00:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741163918; x=1741768718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYkJMTg/+M64ocsPQ4ifBCCKMe3+ghvTVTjmpHLBzpE=;
        b=Kl+L+zMZ5y2wtmXdHQcWCMxvz8/K9zmYwbo25EZDOf5tNggVPJ4tsL9c0IBH+258+C
         qKp/P07gOTYQaYaGNpXD5zsGyp5yKQS39Mrxw6tiwb9YsTvf8tnBY3ig/B1Rg0Da4YUz
         aPy+fZWhkCFIhohkDoCX51BTfV0ynU1B7euG2wNiNTfFmU1HS1iG4S84WwbnDnSZVq0y
         FaqAmZxJeomHCn3nqNa8bVbAiG19omINJYusbzPG8XNKBuEB8RLHKoqvn3dlcN5W6uVR
         OH3f5HlYX6DqAwC1/H1XASikZlB0gsS2+Xaf3Jisa3VA8nkkTDX+lh/3rg+JcW3zCjtY
         uG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163918; x=1741768718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYkJMTg/+M64ocsPQ4ifBCCKMe3+ghvTVTjmpHLBzpE=;
        b=RzLTiGeDnm9xuvFkp9lbsu97dwrGxWCNgfiK24WVGuEMJUtASSh6xateXLP9/LKiux
         Q6QbKfh41fJt2uY0nmRqM+Wtsg0HHOcdEm8txiDssJ1veQh9zEU5jwO1yNfaShzfAqR4
         Wfij+2wZnOdrPiBolaLYGZSin7+jk7VOm3etNtxTOn4LDNAA1vGhbRqxBuDtjXFH5PlT
         MsgYsQVF+x/bT2ayDhBC1Ei4I8+JcWcQ+eGZQiF3+PSm+0+bfW/LPv0zag5u/NH7VUkc
         61Mwp7f4XIfE4NeQkL4yymTSrn4oj08Ym0gpKfgcYEyY4E+opIsdfiguEyROEgJq0nH4
         kVZg==
X-Forwarded-Encrypted: i=1; AJvYcCVmh/zVQxSVY3l3NjSlx8dZfygJqR9GjK24J9aHhaFY3B0J+Fo+vEYk56IHVvaG7UOMDmovrG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsHZgJ7Rv01q1tveUdRj9t0i5gM+ksdIb23P7CR8LP9SB5sH3
	ltDPsxmzEg8VLPVYphN8bnRQXF9hXvh0UVbXVowVarZrFJ7yuy2T+6VmJwHU9+Y=
X-Gm-Gg: ASbGncvvxshKMhWz7Of5tFhcRN0JQUkIG+UFQB+qOcOGNu2S9vaS6xen63X8xtn7TnR
	sUHFMx35ey+D+caUx4Np+5n8NrJH4GpG2XwPv5q5m0QWUNV1n2luKaECawDAWWBi+xg0nSuZ9g5
	sFrCIO47qd058+Dy5jOupc8cMyvQDuDFiMRFlRYLxkdDEYTU5FOe+7QTJODgPG6kyn8/kcpHjD8
	NiwKQsN8CnxIUqFmTVd4zUdHGjnIzOJ1RGOa7k9zblhLePdQ4nKFtMpUZYsGo5ElZPaSleg0vfV
	BdaMU73NqBSVx28Z6QxESvGIppVdNYgvh5PNqbs0YM0qS3Vu4l974IYwha4UOaEgBqRqf8dOe1j
	n
X-Google-Smtp-Source: AGHT+IElgGUiKsdceMJGHW/USzAGMtLne0NJyyzCA7jjzyWv3l7S4LlPXebJjKkvecpJUtsWxeoP+w==
X-Received: by 2002:a17:907:3e11:b0:ac2:b73:db4b with SMTP id a640c23a62f3a-ac20d842dc5mr197841066b.4.1741163917771;
        Wed, 05 Mar 2025 00:38:37 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac052702e83sm431265666b.21.2025.03.05.00.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:38:37 -0800 (PST)
Message-ID: <4108bfd8-b19f-46ea-8820-47dd8fb9ee7c@blackwall.org>
Date: Wed, 5 Mar 2025 10:38:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Jarod Wilson <jarod@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304131120.31135-1-liuhangbin@gmail.com>
 <20250304131120.31135-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250304131120.31135-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 15:11, Hangbin Liu wrote:
> The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
> a warning:
> 
>   BUG: sleeping function called from invalid context at...
> 
> Fix this by moving the IPsec deletion operation to bond_ipsec_free_sa,
> which is not held by spin_lock_bh().
> 
> Additionally, delete the IPsec list in bond_ipsec_del_sa_all() when the
> XFRM state is DEAD to prevent xdo_dev_state_free() from being triggered
> again in bond_ipsec_free_sa().
> 
> For bond_ipsec_free_sa(), there are now three conditions:
> 
>   1. if (!slave): When no active device exists.
>   2. if (!xs->xso.real_dev): When xdo_dev_state_add() fails.
>   3. if (xs->xso.real_dev != real_dev): When an xs has already been freed
>      by bond_ipsec_del_sa_all() due to migration, and the active slave has
>      changed to a new device. At the same time, the xs is marked as DEAD
>      due to the XFRM entry is removed, triggering xfrm_state_gc_task() and
>      bond_ipsec_free_sa().
> 
> In all three cases, xdo_dev_state_free() should not be called, only xs
> should be removed from bond->ipsec list.
> 
> At the same time, protect bond_ipsec_del_sa_all and bond_ipsec_add_sa_all
> with x->lock for each xs being processed. This prevents XFRM from
> concurrently initiating add/delete operations on the managed states.
> 
> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
> Suggested-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 53 +++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index e45bba240cbc..06b060d9b031 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -537,15 +537,22 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  	}
>  
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		spin_lock_bh(&ipsec->xs->lock);
> +		/* Skip dead xfrm states, they'll be freed later. */
> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
> +			goto next;
> +
>  		/* If new state is added before ipsec_lock acquired */
>  		if (ipsec->xs->xso.real_dev == real_dev)
> -			continue;
> +			goto next;
>  
>  		ipsec->xs->xso.real_dev = real_dev;
>  		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
>  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
>  			ipsec->xs->xso.real_dev = NULL;
>  		}
> +next:
> +		spin_unlock_bh(&ipsec->xs->lock);
>  	}
>  out:
>  	mutex_unlock(&bond->ipsec_lock);
> @@ -560,7 +567,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  	struct net_device *bond_dev = xs->xso.dev;
>  	struct net_device *real_dev;
>  	netdevice_tracker tracker;
> -	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
>  	struct slave *slave;
>  
> @@ -592,15 +598,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>  out:
>  	netdev_put(real_dev, &tracker);
> -	mutex_lock(&bond->ipsec_lock);
> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -		if (ipsec->xs == xs) {
> -			list_del(&ipsec->list);
> -			kfree(ipsec);
> -			break;
> -		}
> -	}
> -	mutex_unlock(&bond->ipsec_lock);
>  }
>  
>  static void bond_ipsec_del_sa_all(struct bonding *bond)
> @@ -617,8 +614,18 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  
>  	mutex_lock(&bond->ipsec_lock);
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {

Second time - you should use list_for_each_entry_safe if you're walking and deleting
elements from the list.

> +		spin_lock_bh(&ipsec->xs->lock);
>  		if (!ipsec->xs->xso.real_dev)
> -			continue;
> +			goto next;
> +
> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
> +			/* already dead no need to delete again */
> +			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> +				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);

Have you checked if .xdo_dev_state_free can sleep?
I see at least one that can: mlx5e_xfrm_free_state().

> +			list_del(&ipsec->list);
> +			kfree(ipsec);
> +			goto next;
> +		}
>  
>  		if (!real_dev->xfrmdev_ops ||
>  		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
> @@ -631,6 +638,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
>  				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
>  		}
> +next:
> +		spin_unlock_bh(&ipsec->xs->lock);
>  	}
>  	mutex_unlock(&bond->ipsec_lock);
>  }
> @@ -640,6 +649,7 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
>  	struct net_device *bond_dev = xs->xso.dev;
>  	struct net_device *real_dev;
>  	netdevice_tracker tracker;
> +	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
>  	struct slave *slave;
>  
> @@ -659,11 +669,22 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
>  	if (!xs->xso.real_dev)
>  		goto out;
>  
> -	WARN_ON(xs->xso.real_dev != real_dev);
> +	mutex_lock(&bond->ipsec_lock);
> +	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		if (ipsec->xs == xs) {
> +			/* do xdo_dev_state_free if real_dev matches,
> +			 * otherwise only remove the list
> +			 */
> +			if (real_dev && real_dev->xfrmdev_ops &&
> +			    real_dev->xfrmdev_ops->xdo_dev_state_free)
> +				real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
> +			list_del(&ipsec->list);
> +			kfree(ipsec);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&bond->ipsec_lock);
>  
> -	if (real_dev && real_dev->xfrmdev_ops &&
> -	    real_dev->xfrmdev_ops->xdo_dev_state_free)
> -		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
>  out:
>  	netdev_put(real_dev, &tracker);
>  }


