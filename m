Return-Path: <netdev+bounces-243697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0BDCA608A
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 04:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BCFA31A145A
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 03:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4B122126D;
	Fri,  5 Dec 2025 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWhAvi2E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0918DB35
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 03:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764906542; cv=none; b=XqDo4yKpvq1xBk8n6nmAwgQst4joc7LDxube8YqWywZHuZF2JUqvyROiJ2tkNO6nM/7/w+qqz05lxq3wVJOaGV1L+fI38LFGmuVLjdNBAFBNUxadoG1ktQLPKkV5joFQZPl3P8/FSo0FDRYLKfszUENwHkurlikm/9mANS9QlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764906542; c=relaxed/simple;
	bh=3STjZMvZGruhTg8FZAxnCcajn5vkV5nAjjwgv99KJIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgpxCZ4JvnXQy+MEnhRn6X2IAV4oMcLibx1xTgzYpnD3L8tYVuHbWdXEPeqlndgneU4utOql7ZMQAcu47bszNaj4kvcox1rFxZhbjGjOFpB6+nSqvNZOgBznHJqPQZrpaidpqW2ZWdCA7crUkznJa4Vbm8ya3TmV677tPs2bAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWhAvi2E; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b80fed1505so1863023b3a.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 19:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764906540; x=1765511340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HfGYu8tlT+v5FKtpKu3jG09y1CFNCQI1JR5ty/+MzwQ=;
        b=XWhAvi2EYQfrTm/zbfD57NrjqyXDzIon3j16U65PTzmnh6G34O+fwfQ1aVwcjpevLq
         Ly9/6v0SCjbA/99EPC1KRQvIPxznLUylqFY1+JMs9DAWxo8ELKyhiuxKsN+fV+nEAApI
         iSDU8Xjy8pG9v5lKO+H/XIakaIHAE6cE6hR6GfK2DCytcnvPkUZH5ui/FMH1B/pHHS2w
         /Yusrxrz1xt0Xsy7fa0lm18pr9UFILkSVtvZX0DKCtlCh4F9OQyUbteQgIokVjnrqtzG
         hcv2nJpit2+0MdMx/R+h0o5SC+ynhJ6ApxdsneURmmuD9x9szNaqC+ly8UjXE3V4NGP6
         cihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764906540; x=1765511340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfGYu8tlT+v5FKtpKu3jG09y1CFNCQI1JR5ty/+MzwQ=;
        b=n+KokmA4D7+K/VdAF0sOFXFfGsKnmzBS/TKEhsjRexUCgdlVdObjPT1vmTHQKjfv8E
         MLpwSnsySsk2KoLzC4fVy0MJkO/vw/l1V92LEfY4xQx2Oto4nooHC0O7AIDdOWYd3Y7j
         paBEQvAM8ZAvuKVHu9Cbb7Ispi2fI+z92fUoUcyHGySS9c/jgyhmncIe4lUvjKiwoJGo
         47G7RqnvkSHz8M7xMUX9URgxiYH3NVtcXIfB6HNviARi06FuOddL4zSWomwEam9yPRx4
         SeLXK5lKJVY1Z4wC6sgX0jxsB8z6fe63V0Uek6b5UOef9lkCSSeNEEvVCOXgDQhHbsO4
         +Xig==
X-Gm-Message-State: AOJu0Ywp2z1B7JEksBjsNyE1L6Nyg1PXTcdwXno6v5ghAEeQFDA/K1Qi
	mBoLciDHGYo3YGxSFqr2zDlJtJZGBKbXeDhbAp3TU+3Azfp+3BMN9mcu
X-Gm-Gg: ASbGncsXWm+wzREL+WJlqBVt8nJ4/zBn9AuhPhwS4pNov1UBRqZGjLiV5Tsu1D6Xp5C
	Tib4gFVHAkmV4LuR4PAh+frTYd04NWJ++dM0hsxNCogpiSve6kltHremsX91kc2t5aypkk3lQoy
	SWXWEhD16Cr8NjCcjTDBsBQA/UNSwbeRkhEPBUNhxorixj8VJor/NYLHbUe2FYtdKMFxVwwWKb0
	uA5HJlrw8LdVdv4cdLzoacn7tlggV9blniNfeE2Kr0j93s+n3/kf6M2OlipipXcgCWDZnf4i5nY
	hOBYak/2oVfI3wvFqHWNHZEl2Rm1yNTwKcLbMtYeGy/58gd1TegeNxE5Gfvmu2+9jb5kPqtg2Vh
	ycXc3/9wlq02KD7Ry5ovUN9MrXFk5H/ogVeRNGikI3dKEHy66Jr+MdVq48VZ5lTpIV/fQlPfmVG
	FfGw2Rp2q3Ixh/O+LAOoTB+PtWUw==
X-Google-Smtp-Source: AGHT+IE5ldraQtVD4/voId+uJgq9SKeon1ya3DDXPsDMWnI4D2jTS8G0L+Jj2b6KQXPSJIMRKNYQLw==
X-Received: by 2002:a05:6a00:1788:b0:7ae:8821:96c7 with SMTP id d2e1a72fcca58-7e00dfd1453mr10992782b3a.17.1764906539974;
        Thu, 04 Dec 2025 19:48:59 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a062ac40sm3575520b3a.25.2025.12.04.19.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 19:48:59 -0800 (PST)
Date: Fri, 5 Dec 2025 03:48:51 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [RFC PATCH ipsec 2/2] bonding: Maintain offloaded xfrm on all
 devices
Message-ID: <aTJWI3aybYO-NHg5@fedora>
References: <20251121151644.1797728-1-cratiu@nvidia.com>
 <20251121151644.1797728-3-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121151644.1797728-3-cratiu@nvidia.com>

On Fri, Nov 21, 2025 at 05:16:44PM +0200, Cosmin Ratiu wrote:
> The bonding driver manages offloaded SAs using the following strategy:
> 
> An xfrm_state offloaded on the bond device with bond_ipsec_add_sa() uses
> 'real_dev' on the xfrm_state xs to redirect the offload to the current
> active slave. The corresponding bond_ipsec_del_sa() (called with the xs
> spinlock held) redirects the unoffload call to real_dev. Finally,
> cleanup happens in bond_ipsec_free_sa(), which removes the offload from
> the device. Since the last call happens without the xs spinlock held,
> that is where the real work to unoffload actually happens.
> 
> When the active slave changes to a new device a 3-step process is used
> to migrate all xfrm states to the new device:
> 1. bond_ipsec_del_sa_all() unoffloads all states in bond->ipsec_list
>    from the previously active device.
> 2. The active slave is flipped to the new device.
> 3. bond_ipsec_add_sa_all() offloads all states in bond->ipsec_list to
>    the new device.
> 
> There can be two races which result in unencrypted IPSec packets being
> transmitted on the wire:
> 
> 1. Unencrypted IPSec packet on old_dev:
> CPU1 (xfrm_output)                   CPU2 (bond_change_active_slave)
> bond_ipsec_offload_ok -> true
>                                      bond_ipsec_del_sa_all
> bond_xmit_activebackup
> bond_dev_queue_xmit
> dev_queue_xmit on old_dev
> 				     bond->curr_active_slave = new_dev
> 				     bond_ipsec_add_sa_all
> 
> 2. Unencrypted IPSec packet on new_dev:
> CPU1 (xfrm_output)                   CPU2 (bond_change_active_slave)
> bond_ipsec_offload_ok -> true
>                                      bond->curr_active_slave = new_dev
>                                      bond_ipsec_migrate_sa_all
> bond_xmit_activebackup
> bond_dev_queue_xmit
> dev_queue_xmit on new_dev
> 				     bond_ipsec_migrate_sa_all finishes
> 
> This patch fixes both these issues. Bonding now maintain SAs on all
> devices by making use of the previous patch that allows the same xfrm
> state to be offloaded on multiple devices. This consists of:
> 
> 1. Maintaining two linked lists:
> - bond->ipsec_list is the list of xfrm states offloaded to the bonding
>   device.
> - Each slave has its own bond->ipsec_offloads list holding offloads of
>   bond->ipsec_list on that slave.
> These lists are protected by the existing bond->ipsec_lock mutex.
> 
> 2. When a slave is added (bond_enslave), bond_ipsec_add_sa_all now
>    offloads all xfrm states to the new device.
> 
> 3. When a slave is removed (__bond_release_one), bond_ipsec_del_sa_all
>    now removes all xfrm state offloads from that device.
> 
> 4. When the active slave is changed (bond_change_active_slave), a new
>    bond_ipsec_migrate_sa_all function switches xs->xso.real_dev and
>    xs->xso.offload handle for all offloaded xfrm states.
>    xdo_dev_state_advance_esn is also called on the new device to update
>    the esn state.
> 
> 5. Adding an offloaded xfrm state to the bond device must now iterate
>    through active slaves. To make that nice, RTNL is grabbed there. The
>    alternative is repeatedly grabbing each slave under the RCU lock,
>    holding it, releasing the lock to be able to offload a state, then
>    re-grabbing the RCU lock and releasing the slave. RTNL seems cleaner.
> 
> 6. bond_ipsec_del_sa (.xdo_dev_state_delete for bond) is unchanged, it
>    now only deletes the state from the active device and leaves the rest
>    for the xdo_dev_state_free callback, which can grab the required
>    locks.
> 
> Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 283 +++++++++++++++++---------------
>  include/net/bonding.h           |  22 ++-
>  2 files changed, 164 insertions(+), 141 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 4c5b73786877..979e5aabf8d2 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -452,6 +452,61 @@ static struct net_device *bond_ipsec_dev(struct xfrm_state *xs)
>  	return slave->dev;
>  }
>  
> +static struct bond_ipsec_offload*
> +bond_ipsec_dev_add_sa(struct net_device *dev, struct bond_ipsec *ipsec,
> +		      struct netlink_ext_ack *extack)
> +{
> +	struct bond_ipsec_offload *offload;
> +	int err;
> +
> +	if (!dev->xfrmdev_ops ||
> +	    !dev->xfrmdev_ops->xdo_dev_state_add ||
> +	    netif_is_bond_master(dev)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Slave does not support ipsec offload");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	offload = kzalloc(sizeof(*offload), GFP_KERNEL);
> +	if (!offload)
> +		return ERR_PTR(-ENOMEM);
> +
> +	offload->ipsec = ipsec;
> +	offload->dev = dev;
> +	err = dev->xfrmdev_ops->xdo_dev_state_add(dev, ipsec->xs,
> +						   &offload->handle, extack);
> +	if (err)

Here we need to free the offload.

> +		return ERR_PTR(err);
> +	return offload;
> +}
> +
> +static void bond_ipsec_dev_del_sa(struct bond_ipsec_offload *offload)
> +{
> +	struct xfrm_state *xs = offload->ipsec->xs;
> +	struct net_device *dev = offload->dev;
> +
> +	if (dev->xfrmdev_ops->xdo_dev_state_delete) {
> +		spin_lock_bh(&xs->lock);
> +		/* Don't double delete states killed by the user
> +		 * from xs->xso.real_dev.
> +		 */
> +		if (dev != xs->xso.real_dev ||
> +		    xs->km.state != XFRM_STATE_DEAD)
> +			dev->xfrmdev_ops->xdo_dev_state_delete(dev, xs,
> +							       offload->handle);
> +		if (xs->xso.real_dev == dev)
> +			xs->xso.real_dev = NULL;
> +		spin_unlock_bh(&xs->lock);
> +	}
> +
> +	if (dev->xfrmdev_ops->xdo_dev_state_free)
> +		dev->xfrmdev_ops->xdo_dev_state_free(dev, xs, offload->handle);
> +
> +	list_del(&offload->list);
> +	list_del(&offload->ipsec_list);
> +	kfree(offload);
> +}
> +
[...]

> -static void bond_ipsec_add_sa_all(struct bonding *bond)
> +static void bond_ipsec_add_sa_all(struct bonding *bond, struct slave *new_slave,
> +				  struct netlink_ext_ack *extack)
>  {
> +	struct net_device *real_dev = new_slave->dev;
>  	struct net_device *bond_dev = bond->dev;
> -	struct net_device *real_dev;
>  	struct bond_ipsec *ipsec;
>  	struct slave *slave;
>  
> -	slave = rtnl_dereference(bond->curr_active_slave);
> -	real_dev = slave ? slave->dev : NULL;
> -	if (!real_dev)
> -		return;
> +	INIT_LIST_HEAD(&new_slave->ipsec_offloads);
>  
>  	mutex_lock(&bond->ipsec_lock);
> -	if (!real_dev->xfrmdev_ops ||
> -	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
> -	    netif_is_bond_master(real_dev)) {
> -		if (!list_empty(&bond->ipsec_list))
> -			slave_warn(bond_dev, real_dev,
> -				   "%s: no slave xdo_dev_state_add\n",
> -				   __func__);
> -		goto out;
> -	}
> -
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		struct bond_ipsec_offload *offload;
>  		struct xfrm_state *xs = ipsec->xs;
>  
> -		/* If new state is added before ipsec_lock acquired */
> -		if (xs->xso.real_dev == real_dev)
> -			continue;
> -
> -		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs,
> -							     &xs->xso.offload_handle,
> -							     NULL)) {
> +		offload = bond_ipsec_dev_add_sa(slave->dev, ipsec, extack);

Here should be real_dev.

> +		if (IS_ERR(offload)) {
>  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
>  			continue;
>  		}

If we add offload failed on the slave, what would happen during migrate?

Thanks
Hangbin

