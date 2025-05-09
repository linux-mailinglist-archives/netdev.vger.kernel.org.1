Return-Path: <netdev+bounces-189399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 357AFAB2005
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 00:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7BC1BC6D23
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16A4262D0B;
	Fri,  9 May 2025 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb4/b2f/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903825F79A
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746830491; cv=none; b=kasH+awYeYna14fTM+hNX8MRa9VHtgVJ2aDO9Ur9VQSBEtkCZKj9sd5wZZ/oZFr4wViVZVjbSSgl2e5qr1wSPfixvRHsprR3Fzui1LZJFisi8MXpV56pu1dC7oZED8VB/yr0TsAMop0oCntHDjTuknFhoTleHjNnlvt6n79VlVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746830491; c=relaxed/simple;
	bh=9v8B8n5iZxVUjjgR2PeQAF1MI8VBoTH95wD3PoXGDkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjbzSkswGjWNItSfmPu+dEMmWt1v5LiEWyvlMq1AG2uMvhWHzjC0wmrI1bO14/PjyiK0h01ytVE/h4aAwAXhWEoq4BhdrT5uBBmseLLajR34E4H7+m9rApl8tk5jlZePEFB7m9cm8JtbWhFd68NO57GaCtVA6H1gtMsX+6sLWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb4/b2f/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22fa414c478so14536885ad.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746830489; x=1747435289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4oSarzxf+plO09lPjRqx8nlAWCuU5KyJGfI8rBZ90I=;
        b=nb4/b2f/F9PL9lluv5LlT/lH6NYBoWIGpRheG/cfEeGRBX70HVmJqMnoOlBHm2IoPO
         Vsrpxp7DXwZgMYQ6PwWhdJt/PVk5l4xZIz+ZaZLIlJsYHzBSGeY6o9jFVaYZH48vJgc5
         Ly7Wl+gZ3G1Z9z53gZHcNoQW+SPSUJJzIfzbcQnWO/OKIzTqOhfG8wr6352XE+KIKdfw
         3X0a5CdFBybJq3W1i8hhiO+e/opg9MtLy8VTou1u16xWZb2M2Nh6Kmama2V1XfucDsXm
         vCr6BdeuRq/cX23gxAXVcebp5csyhp8M+FxYs6bqBKMRCahQUGDLWj7K6suTPCgKHNVS
         9NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746830489; x=1747435289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4oSarzxf+plO09lPjRqx8nlAWCuU5KyJGfI8rBZ90I=;
        b=uPmhkPJfcU35j4fqyd/wCumZwGiP92CmtTjTIveGjQFgLNeyNqQc4J+eDJNdKIk5qG
         XEDHwjXRfhSjQrz1/pnFvrDlKdVEkMarAbo0mXpB6hbtERBVkGej5c04OyqRUoOTMXdg
         o9yCx7tvDTScCy3bgjzrd8+t+81J+u4fqZxUAp0AdfQNEklz1um+nVly5IZLVmaaTOl+
         Pi3wMZpXYf8EgXVUXgiN4PHkVlBLxV9kEt5RlgZ5u1OhWriWQpPvbeC3MY/bssiBtHem
         9GRyGarKEMWmmax7kn9pGlnAVBZX+rxoetBqYEPN8BPnpaym8JZleE3+xLKrcY3Ro/Pk
         81JA==
X-Forwarded-Encrypted: i=1; AJvYcCWaSKeOy4dxxCzDPc/jyw0k31LVd2lZg5VBksolWC3Vpv5Rljmgeu0zsFkT+A4Zi3CuxY+pxNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCiU+28fCAyvKWkKC2Bukp+Nsh/rEHxDh1lzXuopPVHdpZCbbw
	wx/aNY6zQaifr4/FqCrn2DuGTKrVY+5glL+pNTiy+bF9P7TMiz90BPcZ
X-Gm-Gg: ASbGnctmM9ApYJKV3jgsERscTAZcy7n3z4EXX4IChAcR7QLzlWKHlwuoc29PG9i/DQL
	AzIGyycNqhypIF+sJ0lygfKiapwPXX4UKDZTgAxdUKMiTSjfcLn5ErXalPksgjTpD9rdVjr6Qwn
	Jhb6hOmad2p66T/FxKMrD2be4HVHMiFEatE5mZ3yuaEolQrOP4bjpsz+kg6/sHnMYuGyKR5ZJ5W
	64jAm5e0HJSqXGqYARXyrLrLprXhffQvd6NFTu6cRQ+KjRRHZAA6VJFqlKDU96EUVr8HT9E5oa2
	O9zJOhzXWrZjNWf74s+VlGayDelGTT+gxwm4qU3Q5eM5/PMXpwoNIHVPMucFPL4blsi6TBISbty
	MyK6RkK+CfWuOUPitPjG6JXk=
X-Google-Smtp-Source: AGHT+IFk8xAO1xx8Ki38KVTH5SAdl18xoTLag4a4gdaSr+XmwQYtEZsYsH3jhVZHn9+Hab3e1R89ZA==
X-Received: by 2002:a17:902:d484:b0:224:76f:9e4a with SMTP id d9443c01a7336-22fc8b49c5dmr71576445ad.14.1746830488802;
        Fri, 09 May 2025 15:41:28 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc829f645sm22472565ad.226.2025.05.09.15.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 15:41:28 -0700 (PDT)
Date: Fri, 9 May 2025 15:41:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, almasrymina@google.com,
	sdf@fomichev.me, netdev@vger.kernel.org, asml.silence@gmail.com,
	dw@davidwei.uk, skhawaja@google.com, kaiyuanz@google.com,
	jdamato@fastly.com
Subject: Re: [PATCH net v3] net: devmem: fix kernel panic when netlink socket
 close after module unload
Message-ID: <aB6El9LXnOEpgFQy@mini-arch>
References: <20250509160055.261803-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509160055.261803-1-ap420073@gmail.com>

On 05/09, Taehee Yoo wrote:
> Kernel panic occurs when a devmem TCP socket is closed after NIC module
> is unloaded.
> 
> This is Devmem TCP unregistration scenarios. number is an order.
> (a)netlink socket close    (b)pp destroy    (c)uninstall    result
> 1                          2                3               OK
> 1                          3                2               (d)Impossible
> 2                          1                3               OK
> 3                          1                2               (e)Kernel panic
> 2                          3                1               (d)Impossible
> 3                          2                1               (d)Impossible
> 
> (a) netdev_nl_sock_priv_destroy() is called when devmem TCP socket is
>     closed.
> (b) page_pool_destroy() is called when the interface is down.
> (c) mp_ops->uninstall() is called when an interface is unregistered.
> (d) There is no scenario in mp_ops->uninstall() is called before
>     page_pool_destroy().
>     Because unregister_netdevice_many_notify() closes interfaces first
>     and then calls mp_ops->uninstall().
> (e) netdev_nl_sock_priv_destroy() accesses struct net_device to acquire
>     netdev_lock().
>     But if the interface module has already been removed, net_device
>     pointer is invalid, so it causes kernel panic.
> 
> In summary, there are only 3 possible scenarios.
>  A. sk close -> pp destroy -> uninstall.
>  B. pp destroy -> sk close -> uninstall.
>  C. pp destroy -> uninstall -> sk close.
> 
> Case C is a kernel panic scenario.
> 
> In order to fix this problem, It makes mp_dmabuf_devmem_uninstall() set
> binding->dev to NULL.
> It indicates an bound net_device was unregistered.
> 
> It makes netdev_nl_sock_priv_destroy() do not acquire netdev_lock()
> if binding->dev is NULL.
> 
> A new binding->lock is added to protect members of a binding.
> 
> Tests:
> Scenario A:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=$!
>     sleep 10
>     kill $pid
>     ip link set $interface down
>     modprobe -rv $module
> 
> Scenario B:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=$!
>     sleep 10
>     ip link set $interface down
>     kill $pid
>     modprobe -rv $module
> 
> Scenario C:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=$!
>     sleep 10
>     modprobe -rv $module
>     sleep 5
>     kill $pid
> 
> Splat looks like:
> Oops: general protection fault, probably for non-canonical address 0xdffffc001fffa9f7: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> KASAN: probably user-memory-access in range [0x00000000fffd4fb8-0x00000000fffd4fbf]
> CPU: 0 UID: 0 PID: 2041 Comm: ncdevmem Tainted: G    B   W           6.15.0-rc1+ #2 PREEMPT(undef)  0947ec89efa0fd68838b78e36aa1617e97ff5d7f
> Tainted: [B]=BAD_PAGE, [W]=WARN
> RIP: 0010:__mutex_lock (./include/linux/sched.h:2244 kernel/locking/mutex.c:400 kernel/locking/mutex.c:443 kernel/locking/mutex.c:605 kernel/locking/mutex.c:746)
> Code: ea 03 80 3c 02 00 0f 85 4f 13 00 00 49 8b 1e 48 83 e3 f8 74 6a 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 34 48 89 fa 48 c1 ea 03 <0f> b6 f
> RSP: 0018:ffff88826f7ef730 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: 00000000fffd4f88 RCX: ffffffffaa9bc811
> RDX: 000000001fffa9f7 RSI: 0000000000000008 RDI: 00000000fffd4fbc
> RBP: ffff88826f7ef8b0 R08: 0000000000000000 R09: ffffed103e6aa1a4
> R10: 0000000000000007 R11: ffff88826f7ef442 R12: fffffbfff669f65e
> R13: ffff88812a830040 R14: ffff8881f3550d20 R15: 00000000fffd4f88
> FS:  0000000000000000(0000) GS:ffff888866c05000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000563bed0cb288 CR3: 00000001a7c98000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
> <TASK>
>  ...
>  netdev_nl_sock_priv_destroy (net/core/netdev-genl.c:953 (discriminator 3))
>  genl_release (net/netlink/genetlink.c:653 net/netlink/genetlink.c:694 net/netlink/genetlink.c:705)
>  ...
>  netlink_release (net/netlink/af_netlink.c:737)
>  ...
>  __sock_release (net/socket.c:647)
>  sock_close (net/socket.c:1393)
> 
> Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v3:
>  - Add binding->lock for protecting members of a binding.
>  - Add a net_devmem_unset_dev() helper function.
>  - Do not reorder locks.
>  - Fix build failure.
> 
> v2:
>  - Fix commit message.
>  - Correct Fixes tag.
>  - Inverse locking order.
>  - Do not put a reference count of binding in
>    mp_dmabuf_devmem_uninstall().
> 
> In order to test this patch, driver side implementation of devmem TCP[1]
> is needed to be applied.
> 
> [1] https://lore.kernel.org/netdev/20250415052458.1260575-1-ap420073@gmail.com/T/#u
> 
>  net/core/devmem.c      | 14 +++++++++++---
>  net/core/devmem.h      |  2 ++
>  net/core/netdev-genl.c | 13 +++++++++++++
>  3 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 6e27a47d0493..ffbf50337413 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -33,6 +33,13 @@ bool net_is_devmem_iov(struct net_iov *niov)
>  	return niov->pp->mp_ops == &dmabuf_devmem_ops;
>  }
>  
> +static void net_devmem_unset_dev(struct net_devmem_dmabuf_binding *binding)
> +{
> +	mutex_lock(&binding->lock);
> +	binding->dev = NULL;
> +	mutex_unlock(&binding->lock);
> +}

nit: there is just one place where we call net_devmem_unset_dev, why do
we need an extra function? IMHO it makes it harder to read wrt
locking.. Jakub is also hinting the same in
https://lore.kernel.org/netdev/20250509153252.76f08c14@kernel.org/#t ?

>  static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
>  					       struct gen_pool_chunk *chunk,
>  					       void *not_used)
> @@ -117,9 +124,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  	unsigned long xa_idx;
>  	unsigned int rxq_idx;
>  
> -	if (binding->list.next)
> -		list_del(&binding->list);
> -
>  	xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
>  		const struct pp_memory_provider_params mp_params = {
>  			.mp_priv	= binding,
> @@ -200,6 +204,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  
>  	refcount_set(&binding->ref, 1);
>  
> +	mutex_init(&binding->lock);
> +
>  	binding->dmabuf = dmabuf;
>  
>  	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
> @@ -379,6 +385,8 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
>  	xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
>  		if (bound_rxq == rxq) {
>  			xa_erase(&binding->bound_rxqs, xa_idx);
> +			if (xa_empty(&binding->bound_rxqs))
> +				net_devmem_unset_dev(binding);
>  			break;
>  		}
>  	}
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 7fc158d52729..b69adca6cd44 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -20,6 +20,8 @@ struct net_devmem_dmabuf_binding {
>  	struct sg_table *sgt;
>  	struct net_device *dev;
>  	struct gen_pool *chunk_pool;
> +	/* Protect all members */
> +	struct mutex lock;
>  
>  	/* The user holds a ref (via the netlink API) for as long as they want
>  	 * the binding to remain alive. Each page pool using this binding holds
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index dae9f0d432fb..bd5d58604ec0 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -979,14 +979,27 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
>  	struct net_devmem_dmabuf_binding *temp;
> +	netdevice_tracker dev_tracker;
>  	struct net_device *dev;
>  
>  	mutex_lock(&priv->lock);
>  	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
> +		list_del(&binding->list);
> +
> +		mutex_lock(&binding->lock);
>  		dev = binding->dev;
> +		if (!dev) {
> +			mutex_unlock(&binding->lock);
> +			net_devmem_unbind_dmabuf(binding);
> +			continue;
> +		}
> +		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
> +		mutex_unlock(&binding->lock);
> +

Same suggestion as in v2: let's have a short comment here on the lock
ordering (netdev outer, binding inner)?

>  		netdev_lock(dev);
>  		net_devmem_unbind_dmabuf(binding);
>  		netdev_unlock(dev);
> +		netdev_put(dev, &dev_tracker);
>  	}
>  	mutex_unlock(&priv->lock);
>  }
> -- 
> 2.34.1
> 

