Return-Path: <netdev+bounces-205221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3724AFDD37
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5F21C2171B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E219A18CC1D;
	Wed,  9 Jul 2025 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFW5uWbE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C23182
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 02:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026503; cv=none; b=d3zM1VhLveepwzjf2eA+X4A5WeRdBfdD6Dom1zqr39MBvLO492ZRAEcphxXK8Si5OuFoP9IKSxKwqIldXNJG5cYypcmfPd2lXNXw2182UnmvosoGFlN05CwVVMiepQSN3u04/ZHTVim3d/FZJkUzmT1SumDaZdpkavuZcivzRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026503; c=relaxed/simple;
	bh=LA5Ad1KVYJHdDXzE5VYdwQ/J980ycmU7O+TuqUwzguQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iehLr3rC53FrPBccv8P2lEBNFsp2h2VfS522FCeLefzVOMVTpLVJpe8zECjlO+HXKIvDGAIsPGbglDOrwPFf8QrB7w2mv8m9qG2F2MeNBDi7uuBnPz5sI7bJK/wbcWa9pNjujVkDn3zPahtEc0txwBeimi4lSXuKom1SCPdbpQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFW5uWbE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748e378ba4fso6024397b3a.1
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 19:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752026501; x=1752631301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHw7MdVPGrx8WIr/oQis8RDiYPaRD+NANMVnq+QHDxk=;
        b=jFW5uWbEKCqGZRZpEcsydWUN/is6MiP/Ns5UPZvB/RojwNCfTH4Jxxg4/E2HM7yF46
         uEMT4khsJf3i7TeW5ogjgaNhcJlb9DW9ZnqFw4QuSn7uRgf92pLaRPx+foMaiqs9Vh5h
         QFAtfPjiZtMobDsAiK0CPTHeEE4MaU3W8FFvzgMh94YvdHAqr7tQdqq5B/4WH2MqNN1U
         gMx48cVZDFvaXoON0VJ4SIyG1F/TAPjRidXatZp3cuuT6aNa+FVAnkndlo66EXW9IlLN
         Y4S3Rt+z+YLJkkyXJ297WG2lTsREc6oTI/DC4sRhziwBU5mVv1BmohNn4fD+Xf69rlJo
         TB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752026501; x=1752631301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHw7MdVPGrx8WIr/oQis8RDiYPaRD+NANMVnq+QHDxk=;
        b=Itu1785bLiAXa9pHXVhX8qkMv9W+xBzd5WM52pk6lJa4NXz+IrzX4E2siGLohl1PkS
         6XksceFl8HkW+0a8FTx55+A5ZwVlT3ttv4NxIDnHCPQRoaFoId4FaUfkbi5uckYbD9V3
         FyhMxxDdE09QVR6/WGd+hm6z5/jM9jiOGmOh0Y3JO2PrHZNj7l8T6NvJpHkNCKFKI6ty
         Vx0ShcGQTBgfAivAhi+WoT7k2J0BMWyH2SVYGvHVDjM2dxNgJUl4h+c/WcRCn4jxVZ3e
         BE7FKU9G/8KzRhbjmgM5QKyoA0LDB43dkf6TFaHGKadDIc2WvuMsrghiQ4UFJdUxJnsK
         k79g==
X-Gm-Message-State: AOJu0YyYabjYDYy7wHIYw/FDfyGmlN2qLgITwMJTyHsB5rB/vx7vn6NX
	zRfCIPIdnkaosrSdvAiy1ccDQVXrG2Lr7tFHVlFQcrIm/hQ5tAFQFju7
X-Gm-Gg: ASbGncse51dRM4qSt8WzcgmQ3/U8xNaveqsPLiepu4l24wGwmqH4Yyj/eJCcDnp3QvK
	BHCmPuwzhhRzGGFvufJJFwEDl1mUtcCewPu6lUdbUOPUfxJA8EySsZ08OXfl+b4rPxTFz7RiIU4
	8wd7TFjTTO/XcvHdZpUn8tzXSvmYLYt2m6mp7X0vhoaFKeYkHKUfNQuOtDh/C284N6CmHhexnxN
	0i/uJHtwM/7qVnpWKxN7HOR2HaVGHkRdoUF/1axEA1dwI81RVWbXrELb6JPG5w0QfmrqrZvmAxD
	+wMgJEnD8XvTeeHtQPHqyEulSWUHblnCtM9YF/wXF1VQhuYkeB9EM1lvROXD1V3eFGI=
X-Google-Smtp-Source: AGHT+IHmaPDvf0hzr9iUV5ra5t4D5QcxDVFc2qkQT1p332i4GGfqTZgiXwGBYUB+BXaKAZ14IJP//g==
X-Received: by 2002:a05:6a21:700c:b0:21f:5598:4c2c with SMTP id adf61e73a8af0-22cd69be9f1mr1144919637.13.1752026501570;
        Tue, 08 Jul 2025 19:01:41 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417dd9asm13505726b3a.72.2025.07.08.19.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:01:41 -0700 (PDT)
Date: Wed, 9 Jul 2025 02:01:34 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Erwan Dufour <mrarmonius@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net, jv@jvosburgh.net,
	saeedm@nvidia.com, tariqt@nvidia.com, erwan.dufour@withings.com,
	cratiu@nvidia.com, leon@kernel.org
Subject: Re: [PATCH net-next v2] xfrm: bonding: Add XFRM packet-offload for
 active-backup
Message-ID: <aG3NfmO5wsQWKaoz@fedora>
References: <20250706145803.47491-2-mramonius@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706145803.47491-2-mramonius@gmail.com>

Hi Erwan,

On Sun, Jul 06, 2025 at 04:58:04PM +0200, Erwan Dufour wrote:
> From: Erwan Dufour <erwan.dufour@withings.com>
> 
> New features added:
> - Use of packet offload added for XFRM in active-backup
> - Behaviour modification when changing primary slave to prevent reuse of IV.

...

> 
> -static void bond_ipsec_add_sa_all(struct bonding *bond)
> +static void bond_ipsec_add_sa_sp_all(struct bonding *bond)
>  {
>  	struct net_device *bond_dev = bond->dev;
>  	struct net_device *real_dev;
>  	struct bond_ipsec *ipsec;
>  	struct slave *slave;
> +	int err;
>  
>  	slave = rtnl_dereference(bond->curr_active_slave);
>  	real_dev = slave ? slave->dev : NULL;
>  	if (!real_dev)
>  		return;
>  
> -	mutex_lock(&bond->ipsec_lock);
> +	mutex_lock(&bond->ipsec_lock_sa);
>  	if (!real_dev->xfrmdev_ops ||
>  	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
>  	    netif_is_bond_master(real_dev)) {
> -		if (!list_empty(&bond->ipsec_list))
> +		if (!list_empty(&bond->ipsec_list_sa))
>  			slave_warn(bond_dev, real_dev,
>  				   "%s: no slave xdo_dev_state_add\n",
>  				   __func__);
> -		goto out;
> +		goto out_sa;
>  	}
>  
> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -		/* If new state is added before ipsec_lock acquired */
> +	list_for_each_entry(ipsec, &bond->ipsec_list_sa, list) {
> +		/* If new state is added before ipsec_lock_sa acquired */
>  		if (ipsec->xs->xso.real_dev == real_dev)
>  			continue;
>  
> -		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
> -							     ipsec->xs, NULL)) {
> -			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
> +		err = __xfrm_state_delete(ipsec->xs);
> +		if (!err)
> +			km_state_expired(ipsec->xs, 1, 0);
> +
> +		xfrm_audit_state_delete(ipsec->xs, err ? 0 : 1, true);

I see you delete ipsec->xs here. Do you mean to prevent reuse of IV?
But I can't find you add the xs back to new slave.

> +	}
> +out_sa:
> +	mutex_unlock(&bond->ipsec_lock_sa);
> +
> +	mutex_lock(&bond->ipsec_lock_sp);
> +	if (!real_dev->xfrmdev_ops ||
> +	    !real_dev->xfrmdev_ops->xdo_dev_policy_add ||
> +	    netif_is_bond_master(real_dev)) {
> +		if (!list_empty(&bond->ipsec_list_sp))
> +			slave_warn(bond_dev, real_dev,
> +				   "%s: no slave xdo_dev_policy_add\n",
> +				   __func__);
> +		goto out_sp;
> +	}
> +	list_for_each_entry(ipsec, &bond->ipsec_list_sp, list) {
> +		if (ipsec->xp->xdo.real_dev == real_dev)
> +			continue;
> +
> +		if (real_dev->xfrmdev_ops->xdo_dev_policy_add(real_dev,
> +							      ipsec->xp,
> +							      NULL)) {
> +			slave_warn(bond_dev, real_dev,
> +				   "%s: failed to add SP\n", __func__);
>  			continue;

Here you do xdo_dev_policy_add(). What about the xdo_dev_state_add()?

>  		}
>  
> -		spin_lock_bh(&ipsec->xs->lock);
> -		/* xs might have been killed by the user during the migration
> -		 * to the new dev, but bond_ipsec_del_sa() should have done
> -		 * nothing, as xso.real_dev is NULL.
> -		 * Delete it from the device we just added it to. The pending
> -		 * bond_ipsec_free_sa() call will do the rest of the cleanup.
> -		 */
> -		if (ipsec->xs->km.state == XFRM_STATE_DEAD &&
> -		    real_dev->xfrmdev_ops->xdo_dev_state_delete)
> -			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
> -								    ipsec->xs);

Here the xdo_dev_state_delete() is called when km.state == XFRM_STATE_DEAD.
Why we remove this?

> -		ipsec->xs->xso.real_dev = real_dev;
> -		spin_unlock_bh(&ipsec->xs->lock);
> +		write_lock_bh(&ipsec->xp->lock);
> +		ipsec->xp->xdo.real_dev = real_dev;
> +		write_unlock_bh(&ipsec->xp->lock);
>  	}
> -out:
> -	mutex_unlock(&bond->ipsec_lock);
> +
> +out_sp:
> +	mutex_unlock(&bond->ipsec_lock_sp);
>  }

Thanks
Hangbin

