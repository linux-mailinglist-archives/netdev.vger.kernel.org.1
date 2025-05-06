Return-Path: <netdev+bounces-188414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2258DAACC65
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A13487A7697
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735F723D2B1;
	Tue,  6 May 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/MnaRZd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692A27875C
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553316; cv=none; b=Z8dRyMpiXTc24nT67TY8LWzwabpjNsxKVO6kfe22GYnoHF24FU09J8AmY/AHPoo/c04vV40ibKNstcC3ySZdwD0uw4hhNWnsFJCtgYp4ClgmIH7y8GLFGNsLqH87DzpbqMEFZCqsCokvE3a7KOnLY/XD0tuZ73qgZ8U/CYR8KtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553316; c=relaxed/simple;
	bh=GgOloDDnKJK0kdBJTbbTiLZ1m0ZX6NOUFCT7f1FB5kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NANCgVgrBUpk4JPX4oEzNPwnSEp3yyJS9LXCc0Dzm11/NvHvAFJHELQGKwaCWulNLfIfnX6KNiRSKbu1H2nzJx9zuDok2tKibPCGKCSvhV/YgvFQW5QpLqwepJqZG5h1tf19l/qiXfztqQ7Tz1fFHW86zA/g9RDUhJGF1rMMtNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/MnaRZd; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af908bb32fdso117057a12.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746553314; x=1747158114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=crAXTrWkIaZwbaZVx/o+i97Mlf1K/Nj1IwTOkaSlBw4=;
        b=j/MnaRZd1CHmDj853TEHohVqkUeX28opHcqEIprx4gC/tDdADf94uQ3sOzZchhWUX6
         b1bY2RInuWlT2wgz/SP8P8v86NftrxwpVYAxz0ZuFamEuuITN3Q+UUGyI0HgQ32LQVTI
         JAKv9VRMZguVI0JEp/vKwbrX/UBT7/JwYGRSCZCS7sZr9XZCVLD3bcGsNvvMrd4vTb0s
         +RmuzY9YhIGO8mJiA0La9c4DU8T8NVn2pC/jVJwNT9IctjzmFbu4BKi2GVu8boeZXmNI
         iHwnj9Z5rSXMkm4xEmuoZ3ZjnqMAe26LcU3GRbFP/jSZXz1n5sWEJWnLdciD+fwtCGNw
         vVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746553314; x=1747158114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crAXTrWkIaZwbaZVx/o+i97Mlf1K/Nj1IwTOkaSlBw4=;
        b=JU2rc+tft+pihQOS/IrXv2Fl0p+ZoajG5ArCbEu9ynnIDCsEaGWMIXs0wNvfZEng30
         1+fPMKOD3o1FVT505MwOo6ZoB76mq0pI5HnMonL7QJjjXfuBRZr0gN+olswEnaqfY5Pc
         7Qk+Zkw/q47vR91972qN/mzhvx0393GvToHXsTELTK7nZjj6eFKr5AaacRKNw91Pdhbl
         56kPWiLOKzxnvtRV3S/UUOsVtdIP7c16pMd9ms7KdOOvq9Ao/GIruh4LukKF48djPQzj
         o4Zo6YkyXwQ9A1UMBZ8hTKeVIMoJ5wdiCM/k9vURHtUW+1cbaGLI/Kl9zsPCiCzfXNr7
         KeJg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3DizcQBi6o8OTo8/K+LIpMps/QE0fM7MUv+wBQXt2bDEuOHHv1+1p3SP5U2Hg3TupelwCPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm1bliMSbSnbfRJGQk4EinjpAc3cyc1ZrTgnrm87WJkmhhGDoG
	KeSs1EV4eQbPnWOgtaCv2T2r2w3ERv1eqmrmk8oFknflosSn2U8=
X-Gm-Gg: ASbGncv7RASBp0xLEthOBYI/7gj+lRou1yJJ1OqVEanzPjJODyJCUhpszosiFj2DXZq
	i+/zDUAld9YL4B0qQWJMvuUowwrdTbV91yVw3ZxJrl4ey414kcbHuHcwvb47ae2wO7nmzswXcEw
	T5Xh+gRo1FhzryCaCmIeaztgCyclZmTaNmjYXgWruD4f01AOo7RDj/aRAj98mhQPYwcwYhLyUK8
	qGQGQosSfSYFZWsnZZPlWxb0JdLlzYkxteZBHhAUQRaUwHyKFaSA55z5/OQMX/dp56pPdQW+a5e
	BO7f/cdSKXnoXW76FFOy16chEuxSnzTl8GO2E4UV1uUX3ILoDgoq0t+idwblDhOykZFDj3IqAnA
	=
X-Google-Smtp-Source: AGHT+IGo8vIhkm9uRznp8JWSPNcpHuTEV0akIkXOGEfvPrx6U+Pjn9o2Vg3EVelUh6O3uI3fS500Jg==
X-Received: by 2002:a05:6a20:c88a:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-2146ea3fb74mr743512637.11.1746553313718;
        Tue, 06 May 2025 10:41:53 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b1fb3c3f272sm7754294a12.57.2025.05.06.10.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 10:41:53 -0700 (PDT)
Date: Tue, 6 May 2025 10:41:52 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
	almasrymina@google.com, sdf@fomichev.me, netdev@vger.kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, skhawaja@google.com,
	willemb@google.com, jdamato@fastly.com
Subject: Re: [PATCH net v2] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <aBpJ4GDED8cu4dKh@mini-arch>
References: <20250506140858.2660441-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506140858.2660441-1-ap420073@gmail.com>

On 05/06, Taehee Yoo wrote:
> Kernel panic occurs when a devmem TCP socket is closed after NIC module
> is unloaded.
> 
> This is Devmem TCP unregistration scenarios. number is an order.
> (a)socket close    (b)pp destroy    (c)uninstall    result
> 1                  2                3               OK
> 1                  3                2               (d)Impossible
> 2                  1                3               OK
> 3                  1                2               (e)Kernel panic
> 2                  3                1               (d)Impossible
> 3                  2                1               (d)Impossible
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
> It inverts socket/netdev lock order like below:
>     netdev_lock();
>     mutex_lock(&priv->lock);
>     mutex_unlock(&priv->lock);
>     netdev_unlock();
> 
> Because of inversion of locking ordering, mp_dmabuf_devmem_uninstall()
> acquires socket lock from now on.
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
>  net/core/devmem.c      |  6 ++++++
>  net/core/devmem.h      |  3 +++
>  net/core/netdev-genl.c | 27 ++++++++++++++++++---------
>  3 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 6e27a47d0493..636c1e82b8da 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -167,6 +167,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
>  
>  struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +		       struct netdev_nl_sock *priv,
>  		       struct netlink_ext_ack *extack)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
> @@ -189,6 +190,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  	}
>  
>  	binding->dev = dev;
> +	binding->priv = priv;
>  
>  	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
>  			      binding, xa_limit_32b, &id_alloc_next,
> @@ -376,12 +378,16 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
>  	struct netdev_rx_queue *bound_rxq;
>  	unsigned long xa_idx;
>  
> +	mutex_lock(&binding->priv->lock);
>  	xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
>  		if (bound_rxq == rxq) {
>  			xa_erase(&binding->bound_rxqs, xa_idx);
> +			if (xa_empty(&binding->bound_rxqs))
> +				binding->dev = NULL;
>  			break;
>  		}
>  	}
> +	mutex_unlock(&binding->priv->lock);
>  }
>  
>  static const struct memory_provider_ops dmabuf_devmem_ops = {
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 7fc158d52729..afd6320b2c9b 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -11,6 +11,7 @@
>  #define _NET_DEVMEM_H
>  
>  #include <net/netmem.h>
> +#include <net/netdev_netlink.h>
>  
>  struct netlink_ext_ack;
>  
> @@ -20,6 +21,7 @@ struct net_devmem_dmabuf_binding {
>  	struct sg_table *sgt;
>  	struct net_device *dev;
>  	struct gen_pool *chunk_pool;
> +	struct netdev_nl_sock *priv;
>  
>  	/* The user holds a ref (via the netlink API) for as long as they want
>  	 * the binding to remain alive. Each page pool using this binding holds
> @@ -63,6 +65,7 @@ struct dmabuf_genpool_chunk_owner {
>  void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
>  struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +		       struct netdev_nl_sock *priv,
>  		       struct netlink_ext_ack *extack);
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
>  int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 230743bdbb14..b8bb73574276 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -859,13 +859,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto err_genlmsg_free;
>  	}
>  
> -	mutex_lock(&priv->lock);
> -
>  	err = 0;
>  	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
>  	if (!netdev) {
>  		err = -ENODEV;
> -		goto err_unlock_sock;
> +		goto err_genlmsg_free;
>  	}
>  	if (!netif_device_present(netdev))
>  		err = -ENODEV;
> @@ -877,10 +875,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto err_unlock;
>  	}
>  
> -	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->extack);
> +	mutex_lock(&priv->lock);
> +	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, priv, info->extack);
>  	if (IS_ERR(binding)) {
>  		err = PTR_ERR(binding);
> -		goto err_unlock;
> +		goto err_unlock_sock;
>  	}
>  
>  	nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> @@ -921,18 +920,17 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  	if (err)
>  		goto err_unbind;
>  
> -	netdev_unlock(netdev);
> -
>  	mutex_unlock(&priv->lock);
> +	netdev_unlock(netdev);
>  
>  	return 0;
>  
>  err_unbind:
>  	net_devmem_unbind_dmabuf(binding);
> -err_unlock:
> -	netdev_unlock(netdev);
>  err_unlock_sock:
>  	mutex_unlock(&priv->lock);
> +err_unlock:
> +	netdev_unlock(netdev);
>  err_genlmsg_free:
>  	nlmsg_free(rsp);
>  	return err;
> @@ -948,14 +946,25 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
>  	struct net_devmem_dmabuf_binding *temp;
> +	netdevice_tracker dev_tracker;
>  	struct net_device *dev;
>  
>  	mutex_lock(&priv->lock);
>  	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
>  		dev = binding->dev;
> +		if (!dev) {
> +			net_devmem_unbind_dmabuf(binding);
> +			continue;
> +		}
> +		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
> +		mutex_unlock(&priv->lock);
>  		netdev_lock(dev);
> +		mutex_lock(&priv->lock);
>  		net_devmem_unbind_dmabuf(binding);
> +		mutex_unlock(&priv->lock);
>  		netdev_unlock(dev);
> +		netdev_put(dev, &dev_tracker);
> +		mutex_lock(&priv->lock);

nit: this feels like it deserves a comment on the lock ordering (and,
hence, why this dance is needed). The rest looks good!

