Return-Path: <netdev+bounces-183560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78951A910D1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 02:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C7D7AF3C5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D5F64A8F;
	Thu, 17 Apr 2025 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H43/vG4G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E630374C08
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744850127; cv=none; b=UpSLDl3a4FEZD9qKu5zadD6TTE+wNMR+UEFMKIY/QFQ4FQ+oki0UDhbkJZ8LPAZXkj/0tr3mngpnIR0O6q0jIyB+ShOkDnVN90cupmQWqCg48DKpUM+Zkf+2U102i/2qKTyD1hRz/kUDjxlks1XjmgtS7Fk1a+dadtfHT/KTw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744850127; c=relaxed/simple;
	bh=XT4mhzDEcuidEiVJL+m4x4djSuzdROpZ5SiCxTqbKhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZxPILjA8Bjka46AeoBNcW4UkQvPmkoMvV+5z1l5pRcW3/B6BDF6TkrZdnavZV4Yvic+8xIGsjIhX1HEJk4+uFsSop84nUWedNt1CIieJmySge8czb8PsO4V/mmFr1zIDaDXxwt0MHtvtFgqKoLvgAgkJlbsmDDZpeeR6CxcoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H43/vG4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0877C4CEEC;
	Thu, 17 Apr 2025 00:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744850126;
	bh=XT4mhzDEcuidEiVJL+m4x4djSuzdROpZ5SiCxTqbKhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H43/vG4G2JUmVLOOLb6MDfTkRLuxQ3Kr6cYo/bfRRKCXkSbrLCIjvjG/PgQdmBRHb
	 rzOMeYoCtsZB6TSgLw6Dl25mPeetrvUmjZnJmkPpCLYqe5a88ACgzVoHDH5oQtYT0K
	 R1nE1FS+xCmP7bAUhx5fAtM4LTOw4QEzPKVV0xPQ13s8Ciji8eRY+zUkO9X6zBzIFV
	 U6NzSpZdH4KhwpJhZYy3CfEZ5DGacObjcJgcwWcJEJvQ0H1CWpvtD1PD+CIP2vmLEp
	 v7qr0tfrYuJB1OV3ntZ8CiOcVuW4MG6QVAPclxc0flIar1X34OkAw5x4qGNA1NjS7d
	 uB07yaUGWWxxA==
Date: Wed, 16 Apr 2025 17:35:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Mina Almasry
 <almasrymina@google.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 skhawaja@google.com, simona.vetter@ffwll.ch, kaiyuanz@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <20250416173525.347f0c90@kernel.org>
In-Reply-To: <CAMArcTWFbDa5MAZ_iPHOr_jUh0=CurYod74x_2FxF=EAv28WiA@mail.gmail.com>
References: <20250415092417.1437488-1-ap420073@gmail.com>
	<CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
	<Z_6snPXxWLmsNHL5@mini-arch>
	<20250415195926.1c3f8aff@kernel.org>
	<CAMArcTWFbDa5MAZ_iPHOr_jUh0=CurYod74x_2FxF=EAv28WiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 00:01:57 +0900 Taehee Yoo wrote:
> Thank you so much for a detailed guide :)
> I tried what you suggested, then I tested cases A, B, and C.
> I can't see any splats from lockdep, kasan, etc.
> Also, I checked that bindings are released well by checking
> /sys/kernel/debug/dma_buf/bufinfo.
> I think this approach works well.
> However, I tested this simply. So I'm not sure yet about race condition.
> I need more tests targeting race condition.
> 
> I modified the locking order in the netdev_nl_bind_rx_doit().
> And modified netdev_nl_sock_priv_destroy() code looks like:
> 
> void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
> {
>         struct net_devmem_dmabuf_binding *binding;
>         struct net_devmem_dmabuf_binding *temp;
>         struct net_device *dev;
> 
>         mutex_lock(&priv->lock);
>         list_for_each_entry_safe(binding, temp, &priv->bindings, list) {

Not sure you can "for each entry safe here. Since you drop the lock in
the loop what this helper saves as the "temp" / next struct may be 
freed by the time we get to it. I think we need:

	mutex_lock()
	while (!list_empty())
		binding = list_first..

>                 dev = binding->dev;
>                 if (dev) {

nit: flip the condition to avoid the indent

but I think the condition is too early, we should protect the pointer
itself with the same lock as the list. So if the entry is on the list
dev must not be NULL.

>                         netdev_hold(dev, &priv->dev_tracker, GFP_KERNEL);

I think you can declare the tracker on the stack, FWIW

>                         mutex_unlock(&priv->lock);
>                         netdev_lock(dev);
>                         mutex_lock(&priv->lock);
>                         if (binding->dev)
>                                 net_devmem_unbind_dmabuf(binding);

Mina suggests that we should only release the ref from the socket side.
I guess that'd be good, it will prevent the binding itself from going
away. Either way you need to make sure you hold a ref on the binding.
Either by letting mp_dmabuf_devmem_uninstall() be as is, or taking
a new ref before you release the socket lock here.

>                         mutex_unlock(&priv->lock);
>                         netdev_unlock(dev);
>                         netdev_put(dev, &priv->dev_tracker);
>                         mutex_lock(&priv->lock);
>                 }
>         }
>         mutex_unlock(&priv->lock);
> }

