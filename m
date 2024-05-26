Return-Path: <netdev+bounces-98085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749B08CF3F7
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 12:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E0B1C20BE6
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735CEB660;
	Sun, 26 May 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkUfQALU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1EB946C
	for <netdev@vger.kernel.org>; Sun, 26 May 2024 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716721038; cv=none; b=G8GNw8ftg9+qGDAsAi4RTJmwSZPwqDgsEQ+oo6kz/5FA9oAANEzIFxNobzeW5spMY69KKSWIPOvnlNKGLxmvGfV/vI3fdwPVA4fqdgM72gE0OpMbTTWeqVJmdrN+ID99khLR64ysYsyqNR03c5+7bURJZuxmXnOwYVfmMBn3Yv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716721038; c=relaxed/simple;
	bh=QJZKS5XK50PFb7yB5dE8Z2KwtFi2UIIE2VpRvjS2mvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQUAbORyYBwYJBTNsUAXp/eajRucem/v511mcZJhCVnRsNPXMkMjBZwSqYOGDhohIpTEhVBjtyE4tSE4uTzjfTV6dbNglA0sA07c0T/K4ZjWhScPQOW2FN7yVKqryP4HhKb0T8+7YGjC0hHJIoCa6oyFmv5satUGTHEkHXdxs2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkUfQALU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339E7C2BD10;
	Sun, 26 May 2024 10:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716721037;
	bh=QJZKS5XK50PFb7yB5dE8Z2KwtFi2UIIE2VpRvjS2mvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkUfQALUPIAnqLna55993P0mpcZuLuR8DLpbQSpcLewCdNeF2H4tbPN3zgmxSZclO
	 G85eWcMokxL/xjanp4J9Nizk4OqT6AMZAI4v0q2BmVHt4SFTGzH2odH2drNblMvlsd
	 nM4hRP3jYsJaZvNOJHqhClfJZ2zoXEIGbffZ3Wg9Bsekui3AOzFaWln9yWfXf5v4QL
	 ZfGh5LNk5RiG7nmQ7wZyfGEj2dBgWZzuy3oyJl7SUR3GxdEfZVjUZ5l2Dus+KgeMok
	 aZr3ovUhiKELqnSMOQmMSpE0fMZ8G28QSe/maIe/1HN51IpOMnHFZGplhRuJjH09su
	 KDysA8J7LF8wg==
Date: Sun, 26 May 2024 13:57:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Message-ID: <20240526105713.GB96190@unreal>
References: <20240513100246.85173-1-jianbol@nvidia.com>
 <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
 <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
 <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
 <4d6e7b9c11c24eb4d9df593a9cab825549dd02c2.camel@nvidia.com>
 <Zk7l6MChwKkjbTJx@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zk7l6MChwKkjbTJx@gauss3.secunet.de>

On Thu, May 23, 2024 at 08:44:56AM +0200, Steffen Klassert wrote:
> On Thu, May 23, 2024 at 02:22:38AM +0000, Jianbo Liu wrote:
> > On Wed, 2024-05-22 at 11:34 +0200, Steffen Klassert wrote:
> > > 
> > > Maybe we should directly remove the device from the xfrm_state
> > > when the decice goes down, this should catch all the cases.
> > > 
> > > I think about something like this (untested) patch:
> > > 
> > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > index 0c306473a79d..ba402275ab57 100644
> > > --- a/net/xfrm/xfrm_state.c
> > > +++ b/net/xfrm/xfrm_state.c
> > > @@ -867,7 +867,11 @@ int xfrm_dev_state_flush(struct net *net, struct
> > > net_device *dev, bool task_vali
> > >                                 xfrm_state_hold(x);
> > >                                 spin_unlock_bh(&net-
> > > >xfrm.xfrm_state_lock);
> > >  
> > > -                               err = xfrm_state_delete(x);
> > > +                               spin_lock_bh(&x->lock);
> > > +                               err = __xfrm_state_delete(x);
> > > +                               xfrm_dev_state_free(x);
> > > +                               spin_unlock_bh(&x->lock);
> > > +
> > >                                 xfrm_audit_state_delete(x, err ? 0 :
> > > 1,
> > >                                                         task_valid);
> > >                                 xfrm_state_put(x);
> > > 
> > > The secpath is still attached to all skbs, but the hang on device
> > > unregister should go away.
> > 
> > It didn't fix the issue.
> 
> Do you have a backtrace of the ref_tracker?
> 
> Is that with packet offload?

We saw same failure with crypto and packet offloads.

> 
> Looks like we need to remove the device from the xfrm_policy
> too if packet offload is used.

When we debugged it, we found that this line [1] was responsible for
elevated reference count. XFRM policy cleaned properly.

Thanks

[1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c#L332

> 

