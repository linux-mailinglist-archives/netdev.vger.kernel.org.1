Return-Path: <netdev+bounces-183558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF25A910A2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 02:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6AB189371E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F6B1B6CE5;
	Thu, 17 Apr 2025 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sifd1XKu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFAA1B4F0A
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849633; cv=none; b=jtGlXGPjHAQn6qgUiaXUHu+7SLZh9GRnlBsBIZZeICxz0C4aNtTFy/fe8Q5qoVgjNuMpDMUd0W5JxjLev68NY5DG18kr72Xbia6KzHSpOPmUF39xAunhzAHPNVXmnx9tiAVOJc54Wm53LDL09kAG/jBcXrV0xGp6SFW3dDQR9io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849633; c=relaxed/simple;
	bh=6zpg9CIYBbQVZ81Qpr/rxnC/o6hbieDwrRx6oGV6ymg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCUFhHspWEs4wT8hipQ9SHA/EwxYBUfxNQIc80jZy3vOHUZVCmBQWvUldpHMCMuMPz4skFs1IxZae84EF17lCojyDtzGfT3KAQv4n1S3sx7AgEkzBR1ku3CCUAQxeQ5dogK7q0IkOt1HPWfJKwiyX33757uQM3mJucW7Vcx+z/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sifd1XKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89174C4CEEA;
	Thu, 17 Apr 2025 00:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849633;
	bh=6zpg9CIYBbQVZ81Qpr/rxnC/o6hbieDwrRx6oGV6ymg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sifd1XKukk3Uky5kcI3saB/PdiszV20L51PmSHrIjWOp7+rWqRUoIpmJ6/Eqjh3I0
	 q174TXlFuxNpI04gzqKO0XE8MEbMnPrbaIQNcY+a9Cou4TtRtmshjeYkuotkZtpfQ7
	 1cHTwFSLzXIBLXRtrkoofulEBVx8ecaSV7xPxirKq96KTcrMjTeGUiJs87uhBIsUnJ
	 tK2RFmXx+5En+MMGsxkRsc5hD5IaI9Kj7PMRuRLS7a/eu2e43jHg7nn1LjtvJWNDru
	 IoCTnEzHFJfoxdkXcPfmVafu95l2DR4O5cK4c8PlcLzJqfRDw/pxkQgGHdIlODHsys
	 pTpp4LpFw3c3A==
Date: Wed, 16 Apr 2025 17:27:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Taehee Yoo
 <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 skhawaja@google.com, simona.vetter@ffwll.ch, kaiyuanz@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <20250416172711.0c6a1da8@kernel.org>
In-Reply-To: <CAHS8izNUi1v3sjODWYm4jNEb6uOq44RD0d015G=7aXEYMvrinQ@mail.gmail.com>
References: <20250415092417.1437488-1-ap420073@gmail.com>
	<CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
	<Z_6snPXxWLmsNHL5@mini-arch>
	<20250415195926.1c3f8aff@kernel.org>
	<CAHS8izNUi1v3sjODWYm4jNEb6uOq44RD0d015G=7aXEYMvrinQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 08:47:14 -0700 Mina Almasry wrote:
> > Right, tho a bit of work and tricky handling will be necessary to get
> > that right. We're not holding a ref on binding->dev.
> >
> > I think we need to invert the socket mutex vs instance lock ordering.
> > Make the priv mutex protect the binding->list and binding->dev.
> > For that to work the binding needs to also store a pointer to its
> > owning socket?
> >
> > Then in both uninstall paths (from socket and from netdev unreg) we can
> > take the socket mutex, delete from list, clear the ->dev pointer,
> > unlock, release the ref on the binding.
> 
> I don't like that the ref obtained by the socket can be released by
> both the socket and the netdev unreg :( It creates a weird mental
> model where the ref owned by the socket can actually be dropped by the
> netdev unreg path and then the socket close needs to detect that
> something else dropped its ref. It also creates a weird scenario where
> the device got unregistered and reregistered (I assume that's
> possible? Or no?) and the socket is alive and the device is registered
> but actually the binding is not active.

I agree. But it's be best I could come up with (and what we ended up
with in io-uring)...

> > The socket close path would probably need to lock the socket, look at
> > the first entry, if entry has ->dev call netdev_hold(), release the
> > socket, lock the netdev, lock the socket again, look at the ->dev, if
> > NULL we raced - done. If not NULL release the socket, call unbind.
> > netdev_put(). Restart this paragraph.
> >
> > I can't think of an easier way.
> >  
> 
> How about, roughly:
> 
> - the binding holds a ref on dev, making sure that the dev is alive
> until the last ref on the binding is dropped and the binding is freed.
> - The ref owned by the socket is only ever dropped by the socket close.
> - When we netdev_lock(binding->dev) to later do a
> net_devmem_dmabuf_unbind, we must first grab another ref on the
> binding->dev, so that it doesn't get freed if the unbind drops the
> last ref.

Right now you can't hold a reference on a netdevice forever.
You have to register a notifier and when NETDEV_UNREGISTER triggers
you must give up the reference you took. Also, fun note, it is illegal
to take an "additional reference". You must re-lookup the device or
otherwise safely ensure device is not getting torn down.

See netdev_wait_allrefs_any(), that blocks whoever called unregister
until all refs are reclaimed.

> I think that would work too?
> 
> Can you remind me why we do a dev_memory_provider_uninstall on a
> device unregister? If the device gets unregistered then re-registered
> (again, I'm kinda assuming that is possible, I'm not sure) 

It's not legal right now. I think there's a BUG_ON() somewhere.

> I expect it
> to still be memory provider bound, because the netlink socket is still
> alive and the userspace is still expecting a live binding. Maybe
> delete the dev_memory_provider_uninstall code I added on unregister,
> and sorry I put it there...? Or is there some reason I'm forgetting
> that we have to uninstall the memory provider on unregister?

IIRC bound_rxqs will point to freed memory once the netdev is gone.
If we had a ref on the netdev then yeah we could possibly potentially
keep the queues around. But holding refs on a netdev is.. a topic for
another time. I'm trying to limit amount of code we'd need to revert
if the instance locking turns out to be fundamentally broken :S

