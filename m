Return-Path: <netdev+bounces-253428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEiJF/JKd2msdwEAu9opvQ
	(envelope-from <netdev+bounces-253428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:07:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A6B877D8
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB26301BF6B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6068331A40;
	Mon, 26 Jan 2026 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZOzUlq3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B133123E;
	Mon, 26 Jan 2026 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425637; cv=none; b=FJDDeU31ctfT10mbqc4/9OCXkOlAhnQ+FjEVZHs0alcMUSdWmumCb62iEzSpmybK9rC3gIwbQ1yljxpCW8p5lIBldkHMs34W88tHdO0zyrR2PmdudDmFJVDHr82Ox1QxiMd0Hz7P6qzRTyJqdeqw2Ur/zZBjOuIaBH+qNVzpPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425637; c=relaxed/simple;
	bh=LXLrhUZxLUxTcyVYzqQUsHyRbc1axwLfFo5VxiFg8dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1v14u7DHotuEZG2VPUuw7mi+wNEy9+NNnHu6cGSPamo12rBbmS9h7k8s0+2YMxeZJgaEuFlKveVyiJx12i4fZ18erdXwWGxDz0LYbMGRB7BigFea5ZIVLBN5p0dTlcVdFqTD81OCXd3+s2NksAdiP1vpVZQsj+ulK1kP10bmDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZOzUlq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E8DC116C6;
	Mon, 26 Jan 2026 11:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769425637;
	bh=LXLrhUZxLUxTcyVYzqQUsHyRbc1axwLfFo5VxiFg8dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZOzUlq32pSpghI7TdCPsXE6gW7nYNtoLHvKyeZg2gXpQuorjM1Dz0cRkU/sS+6r4
	 N0FJUD3tvAA9ZaXAV8Bb1HTfuBPo5ygoT2wx0/s6G/uLBbLQkE7HIofeu48i3rLxNN
	 PrBpIvycItiCcuZs/8Dfx3Tbbh9nTX4LWvV5PdoSze3AXxPU4QceqM+BJP3CRQxG0x
	 3AzPvVjmbIwoKYnWWNRMWSRi8etAjw0wF/Y/KjTcUWTW7s1svHgPKYaQaI7gNJH6pH
	 RdhKdtPlsxhj9bCXf1Em9WBkJYSOsbAVl+FFFuWnivDnHbu+lKcNu5yZ8zp+lBNOrP
	 pfUcSOxDm+jRw==
Date: Mon, 26 Jan 2026 13:07:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	Boris Pismenny <borisp@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>,
	Kristian Evensen <kristian.evensen@gmail.com>,
	Raed Salem <raeds@mellanox.com>, Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Network Development <netdev@vger.kernel.org>,
	Aviad Yehezkel <aviadye@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
Message-ID: <20260126110712.GJ13967@unreal>
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
 <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
 <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp>
 <aXIGxmCB2QU86-iA@secunet.com>
 <447378de-3cc9-44f5-872e-a1fc477f591e@I-love.SAKURA.ne.jp>
 <aXIKwNJv59KnsnLw@secunet.com>
 <5811ec38-907e-4788-8a0e-7758f12dc9d0@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5811ec38-907e-4788-8a0e-7758f12dc9d0@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-253428-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,mellanox.com,davemloft.net,strlen.de,gmail.com,nvidia.com,gondor.apana.org.au];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0A6B877D8
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:07:46PM +0900, Tetsuo Handa wrote:
> On 2026/01/22 20:32, Steffen Klassert wrote:
> > On Thu, Jan 22, 2026 at 08:28:31PM +0900, Tetsuo Handa wrote:
> >> On 2026/01/22 20:15, Steffen Klassert wrote:
> >>> Hm, I'd say we should not try to offload to a device that does
> >>> not support NETIF_F_HW_ESP.
> >>
> >> I was about to post the patch below, but you are suggesting that "do not allow calling
> >> xfrm_dev_state_add()/xfrm_dev_policy_add() if (dev->features & NETIF_F_HW_ESP) == 0" ?
> > 
> > As said, I think this is the correct way to do it. But let's wait
> > on opinions from the hardware people.
> 
> OK. I guess something like below.
> 
>  net/xfrm/xfrm_device.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 52ae0e034d29..19aa61609d24 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -292,6 +292,13 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
>  		dst_release(dst);
>  	}
>  
> +	if (!(dev->features & NETIF_F_HW_ESP)) {
> +		NL_SET_ERR_MSG(extack, "Device doesn't support offload");
> +		xso->dev = NULL;
> +		dev_put(dev);
> +		return -EINVAL;
> +	}

Steffen, Tetsuo

If by "HW people" you mean me, we always set NETIF_F_HW_ESP when adding
the .xfrm_dev_*_add() callbacks.

  1334 void mlx5e_ipsec_build_netdev(struct mlx5e_priv *priv)
  1335 {
  1336         struct mlx5_core_dev *mdev = priv->mdev;
  1337         struct net_device *netdev = priv->netdev;
  1338
  1339         if (!mlx5_ipsec_device_caps(mdev))
  1340                 return;
  1341
  1342         mlx5_core_info(mdev,
  1343                        "mlx5e: IPSec ESP acceleration enabled\n");
  1344
  1345         netdev->xfrmdev_ops = &mlx5e_ipsec_xfrmdev_ops;
  1346         netdev->features |= NETIF_F_HW_ESP;
  1347         netdev->hw_enc_features |= NETIF_F_HW_ESP;

So we are left with two possibilities: either the device registered XFRM
ops without setting NETIF_F_HW_ESP, or netdev->features was modified
without clearing the xfrmdev_ops pointer.

Which device is triggering the syzcaller crash?

Thanks

> +
>  	if (!dev->xfrmdev_ops || !dev->xfrmdev_ops->xdo_dev_state_add) {
>  		xso->dev = NULL;
>  		dev_put(dev);
> @@ -367,7 +374,8 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
>  	if (!dev)
>  		return -EINVAL;
>  
> -	if (!dev->xfrmdev_ops || !dev->xfrmdev_ops->xdo_dev_policy_add) {
> +	if (!dev->xfrmdev_ops || !dev->xfrmdev_ops->xdo_dev_policy_add ||
> +	    !(dev->features & NETIF_F_HW_ESP)) {
>  		xdo->dev = NULL;
>  		dev_put(dev);
>  		NL_SET_ERR_MSG(extack, "Policy offload is not supported");
> 
> 
> 
> On 2026/01/22 20:15, Steffen Klassert wrote:
> >> But I have a question regarding security_xfrm_state_delete()/security_xfrm_policy_delete().
> >>
> >> xfrm_dev_state_flush_secctx_check() calls security_xfrm_state_delete() which can make
> >> xfrm_dev_state_flush() no-op by returning an error value.
> >> xfrm_dev_policy_flush_secctx_check() calls security_xfrm_policy_delete() which can make
> >> xfrm_dev_policy_flush() no-op by returning an error value.
> >>
> >> Since xfrm_dev_state_flush()/xfrm_dev_policy_flush() are called by NETDEV_UNREGISTER
> >> event (which is a signal for releasing all resources that prevent "struct net_device"
> >> references from dropping), making xfrm_dev_state_flush()/xfrm_dev_policy_flush() no-op (by
> >> allowing security_xfrm_state_delete()/security_xfrm_policy_delete() to return an error) is
> >> a denial-of-service bug.
> > 
> > This means that the calling task doesn't have the permission to delete the
> > state, some LSM has a policy the does not grant this permission.
> 
> But NETDEV_UNREGISTER event can fire without explicit request from a user.
> Roughly speaking, current behavior is that
> 
>   while (security_xfrm_state_delete() != 0) {
>     schedule_timeout_uninterruptible(10 * HZ);
>     pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
>              dev->name, netdev_refcnt_read(dev));
>   }
>   while (security_xfrm_policy_delete() != 0) {
>     schedule_timeout_uninterruptible(10 * HZ);
>     pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
>              dev->name, netdev_refcnt_read(dev));
>   }
> 
> might be executed upon e.g. termination of a userspace process.
> 
> > 
> >>
> >> Therefore, I wonder what are security_xfrm_state_delete() and security_xfrm_policy_delete()
> >> for. Can I kill xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy_flush_secctx_check() ?
> > 
> > This might violate a LSM policy then.
> 
> But LSM policy that results in system hung upon automatic cleanup logic is so stupid.
> I want to kill xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy_flush_secctx_check()
> in order to eliminate possibility of system hung.
> 

