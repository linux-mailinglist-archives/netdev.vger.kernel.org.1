Return-Path: <netdev+bounces-189398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2008BAB1FF5
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 00:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9434A17E5ED
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 22:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB1239E9D;
	Fri,  9 May 2025 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guHiEzBM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148814B965
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746829975; cv=none; b=Tc7NbqTxcBQYnTjplffIDupgk03Ss591SCFZQ7Nuu/wnKhUFwbnhUUBcplWZoUtp3q+ruqDVK+I3sfXA/RN6DUlsNyiOPse1zQmkJYwS0jd2cllZMSx5d/HUdYK9AG2mmUdUnB4HuA3p4BRZ8uilG8M/7ZJIBBu24l7Qzrn550k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746829975; c=relaxed/simple;
	bh=EPQeCyWb/8ZWQ8ykZlp1d0JHpYJmVGvqNsxf6SSpk6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBi9+aUAdoQsrlDiJA78VZFQ8wYqWCvFJdmdqnTjehor1GBcM3de9lwPzhBI4bb5FZQ6lV/p0GJoJRxH9oNaeNV7SB3VJ6gzy4WYFH0BrG/50TaukVO4I59HKCmh5GupY3ttziVqfXPjPXXG5P1cOuXO3rljsKwPGQ0MezK95QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guHiEzBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65B6C4CEE4;
	Fri,  9 May 2025 22:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746829974;
	bh=EPQeCyWb/8ZWQ8ykZlp1d0JHpYJmVGvqNsxf6SSpk6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=guHiEzBMTUjRcdQ3yL3/W6sJ1ZpLxl9xQ/AE+TO5cEhdkYSSPugwbPJNxRF+rCDuK
	 1CFlQw6gB+286QkNQfgPJLbGhRge7fEn2kdXXzomGFnOHJ9L9DK/qzA4G0epsb0rVb
	 MgX5FI9ctEiRTJyga1c9mMdF6nBOZTJZqLPfmpwIJIxsHi21QkfmGAigVJaN3M0RXW
	 U0gpXXHAWLf3ULEeGQNLBSmZ+8sh31e4HrIe5K84pb47vS/wVci8Bie065Yzj68D80
	 2hTyTUFCuCxPIBbxgmOj/o7oIkyqLGNy6Wf/g+7ur9THgKxVaDMVVkpEbKKo8XLMBt
	 qRN0dXmYMNv3A==
Date: Fri, 9 May 2025 15:32:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, sdf@fomichev.me,
 netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk,
 skhawaja@google.com, kaiyuanz@google.com, jdamato@fastly.com
Subject: Re: [PATCH net v3] net: devmem: fix kernel panic when netlink
 socket close after module unload
Message-ID: <20250509153252.76f08c14@kernel.org>
In-Reply-To: <CAHS8izNgKzusVLynOpWLF_KqmjgGsE8ey_SFMF4zVU66F5gt5w@mail.gmail.com>
References: <20250509160055.261803-1-ap420073@gmail.com>
 <CAHS8izNgKzusVLynOpWLF_KqmjgGsE8ey_SFMF4zVU66F5gt5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 May 2025 12:43:42 -0700 Mina Almasry wrote:
> > @@ -117,9 +124,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> >         unsigned long xa_idx;
> >         unsigned int rxq_idx;
> >
> > -       if (binding->list.next)
> > -               list_del(&binding->list);
> > -  
> 
> Unfortunately if you're going to delete this, then you need to do
> list_del in _all_ the callers of net_devmem_unbind_dmabuf, and I think
> there is a callsite in netdev_nl_bind_rx_doit that is missed?
> 
> But also, it may rough to continually have to remember to always do
> list_del when we do unbind. AFAIR Jakub asked for uniformity in the
> bind/unbind functions. Can we instead do the list_add inside of
> net_devmem_bind_dmabuf? So net_devmem_bind_dmabuf can take the struct
> list_head as an arg and do the list add, then the unbind can do the
> list_del, so it is uniform, but we don't have to remember to do
> list_add/del everytime we call bind/unbind.
> 
> Also, I suspect that clean up can be a separate patch.

Right. Let's leave it for a cleanup. And you can also inline
net_devmem_unset_dev() in that case. My ask was to separate
devmem logic from socket logic more clearly but the "new lock"
approach doesn't really go in such direction. It's good enough
for the fix tho.

> > +       struct mutex lock;
> >
> >         /* The user holds a ref (via the netlink API) for as long as they want
> >          * the binding to remain alive. Each page pool using this binding holds
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index dae9f0d432fb..bd5d58604ec0 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -979,14 +979,27 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
> >  {
> >         struct net_devmem_dmabuf_binding *binding;
> >         struct net_devmem_dmabuf_binding *temp;
> > +       netdevice_tracker dev_tracker;
> >         struct net_device *dev;
> >
> >         mutex_lock(&priv->lock);
> >         list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
> > +               list_del(&binding->list);
> > +
> > +               mutex_lock(&binding->lock);
> >                 dev = binding->dev;
> > +               if (!dev) {
> > +                       mutex_unlock(&binding->lock);
> > +                       net_devmem_unbind_dmabuf(binding);
> > +                       continue;
> > +               }
> > +               netdev_hold(dev, &dev_tracker, GFP_KERNEL);
> > +               mutex_unlock(&binding->lock);
> > +  
> 
> Consider writing the above lines as something like:
> 
> mutex_lock(&binding->lock);
> if (binding->dev) {
>     netdev_hold(binding->dev, &dev_tracker, GPF_KERNEL);
> }
> 
> net_devmem_unbind_dmabuf(binding);
> 
> if (binding->dev) {
>    netdev_put(binding->dev, &dev_tracker);
> }
> mutex_unlock(&binding->lock);
> 
> i.e., don't duplicate the net_devmem_unbind_dmabuf(binding); call.

I think it's fine as is.

> Other than that, I could not find issues. I checked lock ordering. The
> lock hierarchy is:
> 
> priv->lock
>   binding->lock
>     netdev_lock(dev)

Did you mean:

  priv->lock
    netdev_lock(dev)
      binding->lock

