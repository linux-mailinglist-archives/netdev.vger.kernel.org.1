Return-Path: <netdev+bounces-94720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB18C05B6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 22:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBD41F214AE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 20:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9192612E1D0;
	Wed,  8 May 2024 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TT9UIy0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62CF130ADF
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200241; cv=none; b=UaGGuPToGUukv4H3hIEQXo6kD3mT27JF6lgDPD1vyePWmupBjR0knzVZnKE2A3PhVSyyC5x6kyUpe32kkEPTmG6NHLpCPG9PT8TPBLjV6Iz9cUFmR8N5YM5VHB8A9hOqQwLAi+Ya+iLRQgWv5XsQZYqC3gq9wSGYbvdrlL4HfSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200241; c=relaxed/simple;
	bh=zOl9HVl3y8XtVeCwAaqUtijXV/5MTC/74k62X/Dlb5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a69raQ3jWcesxnwVigNdnzgbPU7iMqT10GrjOU76vq0ujZuHfw0A/DNJQ3tLV3/E7ubLd4f1vWFiDk8LaEeJ/xi4LlMbJ0Xcpo5eOZxElxK/lbO2Xoksi+AQ+fP1b6exDpYiqu3E0qVzs+Wh4EP1ilhZcfPT5HDxgJapcWDXhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TT9UIy0/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34db9a38755so95291f8f.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715200237; x=1715805037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F432Mmzo2KbPB7zLL8TQgTksqYX2Z4HB/ng5dERojy8=;
        b=TT9UIy0/1FPDDmjSqGWcmNuLKZzer0E9cle1/Gpz7UPkgOeJ3rhfIMoXQTd1K5gRus
         aeJllR5nzcPtC2t0T9ClAIpmgtiuV4DM8tPKx5RboDPgTXT1J9Sfmd/6dHzWxFrW/64p
         d5UoCXQ5sAAuBjyucPptmyqJTQHCmlHitIJ5oNlGB5sFOf0YbTeBnLtB7VDi16HWVUCa
         aXcielBKa3yzzw57FBLvCJSUQ8Ib7n4dYHAC5A2E7ETid3vciIgwuS2zo2WfCnzext99
         Q4bRmjE2atp4ocaIC6dNGu6wP4HMeskyZtg73hPg3GObuAnaXrVIAJrDcDPTddI+tfhW
         o0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715200237; x=1715805037;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F432Mmzo2KbPB7zLL8TQgTksqYX2Z4HB/ng5dERojy8=;
        b=e9BQk7apOJdFAVuqGU0UAQzDxTezwnHLnarF78ZDPWu3H4AqOk01f+Iez0WBJuV9Ww
         BKQVP82OXVVwb0+hbk7v1NHMQ4Rp8m0ucEJXi8PJauLofJbGnSRjva7F/bcJy/uDzszv
         vNjRRonIrNg0EgnQDtz5pM9cFNhd3FgsIv/f6+quI5iccjhN6wwTWZTlLa4TDfGh3ABI
         g729xXGMofX8eFC8yxaCoTyZLEukA1haXF6baMbE4WppRkqofPfvHUEKtQxziW4RYMuj
         BTP9M1MtTgy7/zsCPZsTQpgImnjO6j2NVbYpOLjH4pDPP+v1Jf93nu79v6JAf+W82q2Y
         vJKw==
X-Gm-Message-State: AOJu0YwtqzOQ9rLNorWDf7c4Fbctf8nikPFjXYS0T37isbLrJa4KQcdt
	NgvcZf5zLCJm+6HXtgWJIF1iZXuZQTu/wqPJwlD5OjLeOLsAZna8rh9wwgOD6/A=
X-Google-Smtp-Source: AGHT+IEn1VGeF8zcq3kzzbSJKtRXueLhMLK/SA5uXOentWMwZk68Lr+1JCrBx8cuOhhLjjhCFUZpuQ==
X-Received: by 2002:a05:600c:310d:b0:41b:d08e:8ce with SMTP id 5b1f17b1804b1-41f71accac9mr35207915e9.33.1715200236897;
        Wed, 08 May 2024 13:30:36 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:bde3:ac66:2f53:6468? ([2001:67c:2fbc:0:bde3:ac66:2f53:6468])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882085c5sm34475435e9.40.2024.05.08.13.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 13:30:36 -0700 (PDT)
Message-ID: <60cae774-b60b-4a4b-8645-91eb6f186032@openvpn.net>
Date: Wed, 8 May 2024 22:31:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net> <ZjujHw6eglLEIbxA@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZjujHw6eglLEIbxA@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/05/2024 18:06, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:20 +0200, Antonio Quartulli wrote:
>> An ovpn_peer object holds the whole status of a remote peer
>> (regardless whether it is a server or a client).
>>
>> This includes status for crypto, tx/rx buffers, napi, etc.
>>
>> Only support for one peer is introduced (P2P mode).
>> Multi peer support is introduced with a later patch.
>>
>> Along with the ovpn_peer, also the ovpn_bind object is introcued
>                                                           ^
> typo: "introduced"

thanks

> 
>> as the two are strictly related.
>> An ovpn_bind object wraps a sockaddr representing the local
>> coordinates being used to talk to a specific peer.
> 
>> diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
>> new file mode 100644
>> index 000000000000..c1f842c06e32
>> --- /dev/null
>> +++ b/drivers/net/ovpn/bind.c
>> +static void ovpn_bind_release_rcu(struct rcu_head *head)
>> +{
>> +	struct ovpn_bind *bind = container_of(head, struct ovpn_bind, rcu);
>> +
>> +	kfree(bind);
>> +}
>> +
>> +void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *new)
>> +{
>> +	struct ovpn_bind *old;
>> +
>> +	spin_lock_bh(&peer->lock);
>> +	old = rcu_replace_pointer(peer->bind, new, true);
>> +	spin_unlock_bh(&peer->lock);
>> +
>> +	if (old)
>> +		call_rcu(&old->rcu, ovpn_bind_release_rcu);
> 
> Isn't that just kfree_rcu? (note kfree_rcu doesn't need the NULL check)

yeah, you're right. I think ovpn_bind_release_rcu() was more complex in 
the past, but got reduced step by step...will directly use kfree_rcu().

> 
>> +}
> 
> 
>> diff --git a/drivers/net/ovpn/bind.h b/drivers/net/ovpn/bind.h
>> new file mode 100644
>> index 000000000000..61433550a961
>> --- /dev/null
>> +++ b/drivers/net/ovpn/bind.h
> [...]
>> +static inline bool ovpn_bind_skb_src_match(const struct ovpn_bind *bind,
>> +					   struct sk_buff *skb)
> 
> nit: I think skb can also be const here

right

> 
> 
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>> index 338e99dfe886..a420bb45f25f 100644
>> --- a/drivers/net/ovpn/io.c
>> +++ b/drivers/net/ovpn/io.c
>> @@ -13,6 +13,7 @@
>>   #include "io.h"
>>   #include "ovpnstruct.h"
>>   #include "netlink.h"
>> +#include "peer.h"
>>   
>>   int ovpn_struct_init(struct net_device *dev)
>>   {
>> @@ -25,6 +26,13 @@ int ovpn_struct_init(struct net_device *dev)
>>   	if (err < 0)
>>   		return err;
>>   
>> +	spin_lock_init(&ovpn->lock);
>> +
>> +	ovpn->events_wq = alloc_workqueue("ovpn-events-wq-%s", WQ_MEM_RECLAIM,
>> +					  0, dev->name);
> 
> I'm not convinced this will get freed consistently if
> register_netdevice fails early (before ndo_init).  After talking to
> Paolo, it seems this should be moved into a new ->ndo_init instead.

oh good point. I didn't consider that register_netdevice could fail that 
early.

> 
>> +	if (!ovpn->events_wq)
>> +		return -ENOMEM;
>> +
>>   	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
>>   	if (!dev->tstats)
>>   		return -ENOMEM;
>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> index cc8a97a1a189..dba35ecb236b 100644
>> --- a/drivers/net/ovpn/main.c
>> +++ b/drivers/net/ovpn/main.c
>> @@ -37,6 +39,9 @@ static void ovpn_struct_free(struct net_device *net)
>>   	rtnl_unlock();
>>   
>>   	free_percpu(net->tstats);
>> +	flush_workqueue(ovpn->events_wq);
>> +	destroy_workqueue(ovpn->events_wq);
> 
> Is the flush needed? I'm not an expert on workqueues, but from a quick
> look at destroy_workqueue it calls drain_workqueue, which would take
> care of flushing the queue?

you're right. drain_workqueue calls __flush_workqueue as often as needed 
to empty the queue.
Therefore I can get rid of my flush_worqueue invocation.

> 
>> +	rcu_barrier();
>>   }
>>   
> 
> [...]
>> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
>> index ee05b8a2c61d..b79d4f0474b0 100644
>> --- a/drivers/net/ovpn/ovpnstruct.h
>> +++ b/drivers/net/ovpn/ovpnstruct.h
>> @@ -17,12 +17,19 @@
>>    * @dev: the actual netdev representing the tunnel
>>    * @registered: whether dev is still registered with netdev or not
>>    * @mode: device operation mode (i.e. p2p, mp, ..)
>> + * @lock: protect this object
>> + * @event_wq: used to schedule generic events that may sleep and that need to be
>> + *            performed outside of softirq context
>> + * @peer: in P2P mode, this is the only remote peer
>>    * @dev_list: entry for the module wide device list
>>    */
>>   struct ovpn_struct {
>>   	struct net_device *dev;
>>   	bool registered;
>>   	enum ovpn_mode mode;
>> +	spinlock_t lock; /* protect writing to the ovpn_struct object */
> 
> nit: the comment isn't really needed since you have kdoc saying the same thing

True, but checkpatch.pl (or some other script?) was still throwing a 
warning, therefore I added this comment to silence it.

> 
>> +	struct workqueue_struct *events_wq;
>> +	struct ovpn_peer __rcu *peer;
>>   	struct list_head dev_list;
>>   };
>>   
>> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
>> new file mode 100644
>> index 000000000000..2948b7320d47
>> --- /dev/null
>> +++ b/drivers/net/ovpn/peer.c
> [...]
>> +/**
>> + * ovpn_peer_free - release private members and free peer object
>> + * @peer: the peer to free
>> + */
>> +static void ovpn_peer_free(struct ovpn_peer *peer)
>> +{
>> +	ovpn_bind_reset(peer, NULL);
>> +
>> +	WARN_ON(!__ptr_ring_empty(&peer->tx_ring));
> 
> Could you pass a destructor to ptr_ring_cleanup instead of all these WARNs?

hmm but if we remove the WARNs then we lose the possibility to catch 
potential bugs, no? rings should definitely be empty at this point.

Or you think I should just not care and free any potentially remaining item?

> 
>> +	ptr_ring_cleanup(&peer->tx_ring, NULL);
>> +	WARN_ON(!__ptr_ring_empty(&peer->rx_ring));
>> +	ptr_ring_cleanup(&peer->rx_ring, NULL);
>> +	WARN_ON(!__ptr_ring_empty(&peer->netif_rx_ring));
>> +	ptr_ring_cleanup(&peer->netif_rx_ring, NULL);
>> +
>> +	dst_cache_destroy(&peer->dst_cache);
>> +
>> +	dev_put(peer->ovpn->dev);
>> +
>> +	kfree(peer);
>> +}
> 
> [...]
>> +void ovpn_peer_release(struct ovpn_peer *peer)
>> +{
>> +	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
>> +}
>> +
>> +/**
>> + * ovpn_peer_delete_work - work scheduled to release peer in process context
>> + * @work: the work object
>> + */
>> +static void ovpn_peer_delete_work(struct work_struct *work)
>> +{
>> +	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
>> +					      delete_work);
>> +	ovpn_peer_release(peer);
> 
> Does call_rcu really need to run in process context?

Reason for switching to process context is that we have to invoke 
ovpn_nl_notify_del_peer (that sends a netlink event to userspace) and 
the latter requires a reference to the peer.

For this reason I thought it would be safe to have 
ovpn_nl_notify_del_peer and call_rcu invoked by the same context.

If I invoke call_rcu in ovpn_peer_release_kref, how can I be sure that 
the peer hasn't been free'd already when ovpn_nl_notify_del_peer is 
executed?


> 
>> +}
> 
> [...]
>> +/**
>> + * ovpn_peer_transp_match - check if sockaddr and peer binding match
>> + * @peer: the peer to get the binding from
>> + * @ss: the sockaddr to match
>> + *
>> + * Return: true if sockaddr and binding match or false otherwise
>> + */
>> +static bool ovpn_peer_transp_match(struct ovpn_peer *peer,
>> +				   struct sockaddr_storage *ss)
>> +{
> [...]
>> +	case AF_INET6:
>> +		sa6 = (struct sockaddr_in6 *)ss;
>> +		if (memcmp(&sa6->sin6_addr, &bind->sa.in6.sin6_addr,
>> +			   sizeof(struct in6_addr)))
> 
> ipv6_addr_equal?
> 

definitely. thanks

>> +			return false;
>> +		if (sa6->sin6_port != bind->sa.in6.sin6_port)
>> +			return false;
>> +		break;
> 
> [...]
>> +struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
>> +{
>> +	struct ovpn_peer *peer = NULL;
>> +
>> +	if (ovpn->mode == OVPN_MODE_P2P)
>> +		peer = ovpn_peer_get_by_id_p2p(ovpn, peer_id);
>> +
>> +	return peer;
>> +}
>> +
>> +/**
>> + * ovpn_peer_add_p2p - add per to related tables in a P2P instance
>                                ^
> typo: peer?

yeah

> 
> 
> [...]
>> +/**
>> + * ovpn_peer_del_p2p - delete peer from related tables in a P2P instance
>> + * @peer: the peer to delete
>> + * @reason: reason why the peer was deleted (sent to userspace)
>> + *
>> + * Return: 0 on success or a negative error code otherwise
>> + */
>> +static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
>> +			     enum ovpn_del_peer_reason reason)
>> +{
>> +	struct ovpn_peer *tmp;
>> +	int ret = -ENOENT;
>> +
>> +	spin_lock_bh(&peer->ovpn->lock);
>> +	tmp = rcu_dereference(peer->ovpn->peer);
>> +	if (tmp != peer)
>> +		goto unlock;
> 
> How do we recover if all those objects got out of sync? Are we stuck
> with a broken peer?

mhhh I don't fully get the scenario you are depicting.

In P2P mode there is only peer stored (reference is saved in ovpn->peer)

When we want to get rid of it, we invoke ovpn_peer_del_p2p().
The check we are performing here is just about being sure that we are 
removing the exact peer we requested to remove (and not some other peer 
that was still floating around for some reason).

> 
> And if this happens during interface deletion, aren't we leaking the
> peer memory here?

at interface deletion we call

ovpn_iface_destruct -> ovpn_peer_release_p2p -> 
ovpn_peer_del_p2p(ovpn->peer)

so at the last step we just ask to remove the very same peer that is 
curently stored, which should just never fail.

makes sense?

> 
>> +	ovpn_peer_put(tmp);
>> +	tmp->delete_reason = reason;
>> +	RCU_INIT_POINTER(peer->ovpn->peer, NULL);
>> +	ret = 0;
>> +
>> +unlock:
>> +	spin_unlock_bh(&peer->ovpn->lock);
>> +
>> +	return ret;
>> +}
> 
> [...]
>> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
>> new file mode 100644
>> index 000000000000..659df320525c
>> --- /dev/null
>> +++ b/drivers/net/ovpn/peer.h
> [...]
>> +/**
>> + * struct ovpn_peer - the main remote peer object
>> + * @ovpn: main openvpn instance this peer belongs to
>> + * @id: unique identifier
>> + * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
>> + * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
>> + * @tx_ring: queue of outgoing poackets to this peer
>> + * @rx_ring: queue of incoming packets from this peer
>> + * @netif_rx_ring: queue of packets to be sent to the netdevice via NAPI
>> + * @dst_cache: cache for dst_entry used to send to peer
>> + * @bind: remote peer binding
>> + * @halt: true if ovpn_peer_mark_delete was called
>> + * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
>> + * @lock: protects binding to peer (bind)
>> + * @refcount: reference counter
>> + * @rcu: used to free peer in an RCU safe way
>> + * @delete_work: deferred cleanup work, used to notify userspace
>> + */
>> +struct ovpn_peer {
>> +	struct ovpn_struct *ovpn;
>> +	u32 id;
>> +	struct {
>> +		struct in_addr ipv4;
>> +		struct in6_addr ipv6;
>> +	} vpn_addrs;
>> +	struct ptr_ring tx_ring;
>> +	struct ptr_ring rx_ring;
>> +	struct ptr_ring netif_rx_ring;
>> +	struct dst_cache dst_cache;
>> +	struct ovpn_bind __rcu *bind;
>> +	bool halt;
>> +	enum ovpn_del_peer_reason delete_reason;
>> +	spinlock_t lock; /* protects bind */
> 
> nit: the comment isn't really needed, it's redundant with kdoc.

like before, also here I had a warning which I wanted to silence.

> 
>> +	struct kref refcount;
>> +	struct rcu_head rcu;
>> +	struct work_struct delete_work;
>> +};
> 

Thanks a lot!


-- 
Antonio Quartulli
OpenVPN Inc.

