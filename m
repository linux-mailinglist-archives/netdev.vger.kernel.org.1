Return-Path: <netdev+bounces-178941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BA0A799A1
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBC87A35F8
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BC78F39;
	Thu,  3 Apr 2025 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOwP5WGi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E82E3366
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743643641; cv=none; b=ruZZkuYvS4PggV3slYUnj1E/SP+Gj2dtunYLeqEqstQcX/WYE1xIuhGN7WAVTLxmmyxcKx6l/WwZDDDvC2KvJTY1BTeh2fW+uHTvjIvppIcy3pqUOUeJrfp5cOnjI8T7LsLhHA/ohqmiy9vVWBz4md7nnjh/Qri56gXq8qbV+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743643641; c=relaxed/simple;
	bh=VuBibpfHnxLv29Z/zMefbQRpw8Mybu4qWjKr090SLc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWvdGyjdsdsEYsLv4tJfFQ+FH/EityfAgJ3HBlJHI01ngYY97g359WDmW2zldZWph5D9ub51pz13DaU1NI7GAgSpx+Ph994TJQkXv4srzhJ5ZmjWy0zKnzLq21dDbhIRCp9apSA83Lt7BAfCcgcjVI9BXefYZxmvp6UZYiXR5BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOwP5WGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DC5C4CEDD;
	Thu,  3 Apr 2025 01:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743643640;
	bh=VuBibpfHnxLv29Z/zMefbQRpw8Mybu4qWjKr090SLc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YOwP5WGi8p0XbDLZK9IJ1K2kX1jObjaNfJr3CHofyWWRd1HfF/qkeNGUR3Z8zfBgl
	 bbtaIkMuRJEYb6jpkx+zxq9g1c3iVZJcz70KV4UmTzRDzmZLAy4UcaU9heJ0xqOHgN
	 SuuFe/fvqLI0rMvTCC2h08b5MgfQJA6hjGe44N0FsQO+1n0oI7j24JYFFRtDl3D+aT
	 EThq0CFWUlgQQ7XmndkJMnREuyeAzf2oXY6jXRTPS8QgSi4AMwoJenxixWnIqUg6L+
	 AbUO+SEOz6KdlUqOq6dPTPxZTObhFFFZGl12LWwebmqZO2Uuh1yFhsL1iCyApetzTQ
	 oYIuhNdZjFjhw==
Date: Wed, 2 Apr 2025 18:27:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>, sdf@fomichev.me
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ap420073@gmail.com, asml.silence@gmail.com, dw@davidwei.uk
Subject: Re: [PATCH net 2/2] net: avoid false positive warnings in
 __net_mp_close_rxq()
Message-ID: <20250402182719.26c390fe@kernel.org>
In-Reply-To: <20250402162428.4afc90cb@kernel.org>
References: <20250331194201.2026422-1-kuba@kernel.org>
	<20250331194308.2026940-1-kuba@kernel.org>
	<CAHS8izNWqPpeRvnF4no8VOs0YpFCahG9WNsVB8VLuaWsUy_-+w@mail.gmail.com>
	<20250402162428.4afc90cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 16:24:28 -0700 Jakub Kicinski wrote:
> On Wed, 2 Apr 2025 11:52:50 -0700 Mina Almasry wrote:
> > >         netdev_lock(dev);
> > > -       __net_mp_close_rxq(dev, ifq_idx, old_p);
> > > +       /* Callers holding a netdev ref may get here after we already
> > > +        * went thru shutdown via dev_memory_provider_uninstall().
> > > +        */
> > > +       if (dev->reg_state <= NETREG_REGISTERED)
> > > +               __net_mp_close_rxq(dev, ifq_idx, old_p);    
> > 
> > Not obvious to me why this check was moved. Do you expect to call
> > __net_mp_close_rxq on an unregistered netdev and expect it to succeed
> > in io_uring binding or something?  
> 
> Yes, iouring state is under spin lock it can't call in here atomically.
> device unregister may race with iouring shutdown.
> 
> Now that I look at it I think we need
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index be17e0660144..0a70080a1209 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11947,6 +11947,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
>                 unlist_netdevice(dev);
>                 netdev_lock(dev);
>                 WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
> +               dev_memory_provider_uninstall(dev);
>                 netdev_unlock(dev);
>         }
>         flush_all_backlogs();
> @@ -11961,7 +11962,6 @@ void unregister_netdevice_many_notify(struct list_head *head,
>                 dev_tcx_uninstall(dev);
>                 netdev_lock_ops(dev);
>                 dev_xdp_uninstall(dev);
> -               dev_memory_provider_uninstall(dev);
>                 netdev_unlock_ops(dev);
>                 bpf_dev_bound_netdev_unregister(dev);
> 
> since 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> we drop the lock after setting UNREGISTERING so we may call .uninstall
> after iouring torn down its side.
> 
> Right, Stan?

Actually, if I don't split the check here things will just work. 
Let me do that in v2. Thanks for flagging!

