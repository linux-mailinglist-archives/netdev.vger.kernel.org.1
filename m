Return-Path: <netdev+bounces-165362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC3A31BDB
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717173A7A84
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25803D3B8;
	Wed, 12 Feb 2025 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDkWAW8N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48B2AE69
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326818; cv=none; b=ZXBAKLYTtjopjcAZHeiBVn9iok6VeANFq2aGAp4bQNBBX4WJj9Y/RK/k1KpTKlhsBDDTn0fTikO3nhb1KG/X0NZvXV2ztZ4L2+tUos8HAFtWiKVEPRGki52M9mJ3r0+ujrgUAHUwUQ5vVXzHQG2LhKV7hmZXQKWiud1I0a1EZ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326818; c=relaxed/simple;
	bh=z8d1oU6wRhXkHJ/jG+tASq7NOJws2vZt0NFFq32/fLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+sZwcGEuxbTV29WMiKgMNh2wMvRzvyzsthT6lHtIy5aWsAYEp8FlCOntgVXvZUevEwskoUT+yL9pTRqjgAukOr7XTqsVFm+nl4lXGhXInMoPUY3nU1z3HMGJ+dy5HNKmUOqbwdEHVoeK7z8e6BGejbAPdWYGm6LvBtRNg4uVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDkWAW8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4EDC4CEDD;
	Wed, 12 Feb 2025 02:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739326818;
	bh=z8d1oU6wRhXkHJ/jG+tASq7NOJws2vZt0NFFq32/fLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VDkWAW8NsLCmgNbqJf6p24aRKs/53MvuCNsJgkp7A6VZ4fUeuSPCpDXi4+LrX0Uws
	 N7fcuOYkPyxggkG53yzmy7eRJqUqBmgNTm4e9tyQ/Q2cycjbtwBGZrqD5rayvT55Br
	 jzaRSYlXk/d1aJ5LNBu5eIruEIfhxRDj0Ap4H0Nih1GZDZelpsjblD+NqkocK+JgiU
	 zBTKwmzT9GVDorzOmmJSU401osCK3r9rwjCb6OV8imlplZpMGrCmjtvSgaT/RxbQ1J
	 5kUCX9Rjd8rNguu17WmUPaphRXj8BAPhzBgpegWCzqzYFgJwZUkRWOnwIJ9w4ew6eP
	 NhtOipM6iZaXA==
Date: Tue, 11 Feb 2025 18:20:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next 02/11] net: hold netdev instance lock during
 ndo_setup_tc
Message-ID: <20250211182016.305f1c77@kernel.org>
In-Reply-To: <20250210192043.439074-3-sdf@fomichev.me>
References: <20250210192043.439074-1-sdf@fomichev.me>
	<20250210192043.439074-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:20:34 -0800 Stanislav Fomichev wrote:
> Introduce new dev_setup_tc that handles the details and call it from
> all qdiscs/classifiers. The instance lock is still applied only to
> the drivers that implement shaper API so only iavf is affected.

> +int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
> +		 void *type_data)
> +{
> +	const struct net_device_ops *ops = dev->netdev_ops;
> +
> +	ASSERT_RTNL();
> +
> +	if (tc_can_offload(dev) && ops->ndo_setup_tc) {
> +		int ret = -ENODEV;
> +
> +		if (netif_device_present(dev)) {
> +			netdev_lock_ops(dev);
> +			ret = ops->ndo_setup_tc(dev, type, type_data);
> +			netdev_unlock_ops(dev);
> +		}
> +
> +		return ret;
> +	}
> +
> +	return -EOPNOTSUPP;

Why the indent? IMHO this would be cleaner:

	if (!tc_can_offload || !ops...
		return -ENOPNOTSUPP;
	if (!netif_device_present(dev))
		return -ENODEV:

	netdev_lock_ops(dev);
	...

> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 291ab1b4acc4..f2ac7662e4cc 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -1729,10 +1729,7 @@ static int dsa_user_setup_ft_block(struct dsa_switch *ds, int port,
>  {
>  	struct net_device *conduit = dsa_port_to_conduit(dsa_to_port(ds, port));
>  
> -	if (!conduit->netdev_ops->ndo_setup_tc)
> -		return -EOPNOTSUPP;
> -
> -	return conduit->netdev_ops->ndo_setup_tc(conduit, TC_SETUP_FT, type_data);
> +	return dev_setup_tc(conduit, TC_SETUP_FT, type_data);

The netfilter / flow table offloads don't seem to test tc_can_offload(),
should we make that part of the check optional in dev_setup_tc() ?
Add a bool argument to ignore  tc_can_offload() ?

> @@ -855,10 +853,7 @@ void qdisc_offload_graft_helper(struct net_device *dev, struct Qdisc *sch,
>  	bool any_qdisc_is_offloaded;
>  	int err;
>  
> -	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
> -		return;
> -
> -	err = dev->netdev_ops->ndo_setup_tc(dev, type, type_data);
> +	err = dev_setup_tc(dev, type, type_data);

Probably need to handle -EOPNOTSUPP here now?

>  	/* Don't report error if the graft is part of destroy operation. */
>  	if (!err || !new || new == &noop_qdisc)

> -	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
> +	err = dev_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
>  	if (err < 0)
>  		pr_warn("Couldn't disable CBS offload for queue %d\n",
>  			cbs.queue);
> @@ -294,7 +289,7 @@ static int cbs_enable_offload(struct net_device *dev, struct cbs_sched_data *q,
>  	cbs.idleslope = opt->idleslope;
>  	cbs.sendslope = opt->sendslope;
>  
> -	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
> +	err = dev_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);

$ for f in $(git grep --files-with-matches TC_SETUP_QDISC_CBS -- drivers/ ); do \
	d=$(dirname $f); \
	git grep HW_TC -- $d || echo No match in $d; \
done

No match in drivers/net/dsa/microchip
No match in drivers/net/dsa/ocelot
No match in drivers/net/dsa/sja1105
drivers/net/ethernet/freescale/enetc/enetc_pf.c:        if (changed & NETIF_F_HW_TC) {
drivers/net/ethernet/freescale/enetc/enetc_pf.c:                err = enetc_set_psfp(ndev, !!(features & NETIF_F_HW_TC));
drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:         ndev->features |= NETIF_F_HW_TC;
drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:         ndev->hw_features |= NETIF_F_HW_TC;
drivers/net/ethernet/intel/igb/igb_main.c:              netdev->features |= NETIF_F_HW_TC;
drivers/net/ethernet/intel/igc/igc_main.c:      netdev->features |= NETIF_F_HW_TC;
drivers/net/ethernet/microchip/lan966x/lan966x_main.c:                   NETIF_F_HW_TC;
drivers/net/ethernet/microchip/lan966x/lan966x_main.c:  dev->hw_features |= NETIF_F_HW_TC;
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:              ndev->hw_features |= NETIF_F_HW_TC;
drivers/net/ethernet/ti/am65-cpsw-nuss.c:                                 NETIF_F_HW_TC;
drivers/net/ethernet/ti/cpsw_new.c:                               NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_TC;


Looks like some the these qdiscs will need to ignore the features too :(

