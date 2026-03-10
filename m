Return-Path: <netdev+bounces-265886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEEKALaQr2kragIAu9opvQ
	(envelope-from <netdev+bounces-265886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:32:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98615244D44
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3758301BC36
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF143A63E3;
	Tue, 10 Mar 2026 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="WYExmZzD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F0334D4CF
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113281; cv=none; b=sx+QLoq+jieJ1vZ/IWlrC7uJWitkdCiVRkfwi9igt0ifVZyOEi76m3DvivW0I2u/tWsCi16NaM+pbMirHUUvG+jPkwlyt4vL8iWiNlUFn1ALn2KOmSZD+4feFo8WYfkBKY2ABA+FThobdrdjWULhB6E5tZM/gi8v1ay4/GIHoAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113281; c=relaxed/simple;
	bh=3GTE2BLCNFDmKE+Ue5/OLTk2Qapxkp6/4dwpWTstFRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl8kdw1Afk7S1SC6N/xI/AYL/wjajG1NTw8aI06SqygFirbsU1eUFiCb2jBtMw4K2Uzf/nEuXNcMj3lfqmGOWOkRSkTGc7t8ocWG2ILlPnLpvdiUOlMJ5nDcCZhP/7cs5hn3g1OpXJjq3N4+5mpr2DuJ2gs+F3FQun2gMi9yVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=WYExmZzD; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773113274;
	bh=5/m5WGbRVXtJuhdQ34UpLwjS+/NlykDt8Y/BbaUqvCA=;
	h=From:Subject:Date:Message-ID;
	b=WYExmZzDqV/WAJP1sUCKIiXE2hsUFYjPPgWAjv1ckcmkeMQDn9+0/rwQnzHJFad1E
	 K9etBfjDMwK2GFW4SxXEf80/w0l3OQeqBCbatjN2p/xFTTZuvBNq9LVO9cwcJ7/Uuz
	 auaFIgTb/Qeohc1Yv6MXNBVjOUrmhmxJZrFkBpj0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 69AF8D730000173F; Tue, 10 Mar 2026 11:18:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8737146685004
X-SMAIL-UIID: 0382335DBF6D47A09D3C1E697C097572-20260310-111814-1
From: Hillf Danton <hdanton@sina.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: edumazet@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] atm: lec: fix use-after-free in sock_def_readable()
Date: Tue, 10 Mar 2026 11:18:04 +0800
Message-ID: <20260310031805.752-1-hdanton@sina.com>
In-Reply-To: <20260309155908.508768-1-kartikey406@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98615244D44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[sina.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265886-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,sina.com:dkim,sina.com:mid,appspotmail.com:email]
X-Rspamd-Action: no action

On Mon,  9 Mar 2026 21:29:08 +0530 Deepanshu Kartikey wrote:
> A race condition exists between lec_atm_close() setting priv->lecd
> to NULL and concurrent access to priv->lecd in send_to_lecd(),
> lec_handle_bridge(), and lec_atm_send(). When the socket is freed
> via RCU while another thread is still using it, a use-after-free
> occurs in sock_def_readable() when accessing the socket's wait queue.
> 
> The root cause is that lec_atm_close() clears priv->lecd without
> any synchronization, while callers dereference priv->lecd without
> any protection against concurrent teardown.
> 
> Fix this by converting priv->lecd to an RCU-protected pointer:
> - Mark priv->lecd as __rcu in lec.h
> - Use rcu_assign_pointer() in lec_atm_close() and lecd_attach()
>   for safe pointer assignment
> - Use rcu_access_pointer() for NULL checks that do not dereference
>   the pointer in lec_start_xmit(), lec_push(), send_to_lecd() and
>   lecd_attach()
> - Use rcu_read_lock/rcu_dereference/rcu_read_unlock in send_to_lecd(),
>   lec_handle_bridge() and lec_atm_send() to safely access lecd
> - Use rcu_assign_pointer() followed by synchronize_rcu() in
>   lec_atm_close() to ensure all readers have completed before
>   proceeding. This is safe since lec_atm_close() is called from
>   vcc_release() which holds lock_sock(), a sleeping lock.
> - Remove the manual sk_receive_queue drain from lec_atm_close()
>   since vcc_destroy_socket() already drains it after lec_atm_close()
>   returns.
> 
> v2: Switch from spinlock + sock_hold/put approach to RCU to properly
>     fix the race. The v1 spinlock approach had two issues pointed out
>     by Eric Dumazet:
>     1. priv->lecd was still accessed directly after releasing the
>        lock instead of using a local copy.
>     2. The spinlock did not prevent packets being queued after
>        lec_atm_close() drains sk_receive_queue since timer and
>        workqueue paths bypass netif_stop_queue().
> 
> Note: Syzbot patch testing was attempted but the test VM terminated
>     unexpectedly with "Connection to localhost closed by remote host",
>     likely due to a QEMU AHCI emulation issue unrelated to this fix.
>     Compile testing with "make W=1 net/atm/lec.o" passes cleanly.
> 
> Reported-by: syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f50072212ab792c86925
> Link: https://lore.kernel.org/all/20260309093614.502094-1-kartikey406@gmail.com/T/ [v1]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  net/atm/lec.c | 70 +++++++++++++++++++++++++++++++++------------------
>  net/atm/lec.h |  2 +-
>  2 files changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index fb93c6e1c329..32adf28663a0 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -154,10 +154,19 @@ static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
>  					/* 0x01 is topology change */
>  
>  		priv = netdev_priv(dev);
> -		atm_force_charge(priv->lecd, skb2->truesize);
> -		sk = sk_atm(priv->lecd);
> -		skb_queue_tail(&sk->sk_receive_queue, skb2);
> -		sk->sk_data_ready(sk);
> +		struct atm_vcc *vcc;
> +
> +		rcu_read_lock();
> +		vcc = rcu_dereference(priv->lecd);
> +		if (vcc) {
> +			atm_force_charge(vcc, skb2->truesize);
> +			sk = sk_atm(vcc);
> +			skb_queue_tail(&sk->sk_receive_queue, skb2);
> +			sk->sk_data_ready(sk);
> +		} else {
> +			dev_kfree_skb(skb2);
> +		}
> +		rcu_read_unlock();
>  	}
>  }
>  #endif /* IS_ENABLED(CONFIG_BRIDGE) */
> @@ -216,7 +225,7 @@ static netdev_tx_t lec_start_xmit(struct sk_buff *skb,
>  	int is_rdesc;
>  
>  	pr_debug("called\n");
> -	if (!priv->lecd) {
> +	if (!rcu_access_pointer(priv->lecd)) {
>  		pr_info("%s:No lecd attached\n", dev->name);
>  		dev->stats.tx_errors++;
>  		netif_stop_queue(dev);
> @@ -449,10 +459,19 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
>  				break;
>  			skb2->len = sizeof(struct atmlec_msg);
>  			skb_copy_to_linear_data(skb2, mesg, sizeof(*mesg));
> -			atm_force_charge(priv->lecd, skb2->truesize);
> -			sk = sk_atm(priv->lecd);
> -			skb_queue_tail(&sk->sk_receive_queue, skb2);
> -			sk->sk_data_ready(sk);
> +			struct atm_vcc *vcc;
> +
> +			rcu_read_lock();
> +			vcc = rcu_dereference(priv->lecd);
> +			if (vcc) {
> +				atm_force_charge(vcc, skb2->truesize);
> +				sk = sk_atm(vcc);
> +				skb_queue_tail(&sk->sk_receive_queue, skb2);
> +				sk->sk_data_ready(sk);
> +			} else {
> +				dev_kfree_skb(skb2);
> +			}
> +			rcu_read_unlock();
>  		}
>  	}
>  #endif /* IS_ENABLED(CONFIG_BRIDGE) */
> @@ -468,23 +486,16 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
>  
>  static void lec_atm_close(struct atm_vcc *vcc)
>  {
> -	struct sk_buff *skb;
>  	struct net_device *dev = (struct net_device *)vcc->proto_data;
>  	struct lec_priv *priv = netdev_priv(dev);
>  
> -	priv->lecd = NULL;
> +	rcu_assign_pointer(priv->lecd, NULL);
> +	synchronize_rcu();
>  	/* Do something needful? */
>  
At this point priv->lecd is no longer used, so why not make lecd valid
throughout the lifespan of priv and free it after stopping dev queue,
instead of the tedious rcu trick?

>  	netif_stop_queue(dev);
>  	lec_arp_destroy(priv);
>  
> -	if (skb_peek(&sk_atm(vcc)->sk_receive_queue))
> -		pr_info("%s closing with messages pending\n", dev->name);
> -	while ((skb = skb_dequeue(&sk_atm(vcc)->sk_receive_queue))) {
> -		atm_return(vcc, skb->truesize);
> -		dev_kfree_skb(skb);
> -	}
> -
>  	pr_info("%s: Shut down!\n", dev->name);
>  	module_put(THIS_MODULE);
>  }
> @@ -510,12 +521,14 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type type,
>  	     const unsigned char *mac_addr, const unsigned char *atm_addr,
>  	     struct sk_buff *data)
>  {
> +	struct atm_vcc *vcc;
>  	struct sock *sk;
>  	struct sk_buff *skb;
>  	struct atmlec_msg *mesg;
>  
> -	if (!priv || !priv->lecd)
> +	if (!priv || !rcu_access_pointer(priv->lecd))
>  		return -1;
> +
>  	skb = alloc_skb(sizeof(struct atmlec_msg), GFP_ATOMIC);
>  	if (!skb)
>  		return -1;
> @@ -532,18 +545,27 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type type,
>  	if (atm_addr)
>  		memcpy(&mesg->content.normal.atm_addr, atm_addr, ATM_ESA_LEN);
>  
> -	atm_force_charge(priv->lecd, skb->truesize);
> -	sk = sk_atm(priv->lecd);
> +	rcu_read_lock();
> +	vcc = rcu_dereference(priv->lecd);
> +	if (!vcc) {
> +		rcu_read_unlock();
> +		kfree_skb(skb);
> +		return -1;
> +	}
> +
> +	atm_force_charge(vcc, skb->truesize);
> +	sk = sk_atm(vcc);
>  	skb_queue_tail(&sk->sk_receive_queue, skb);
>  	sk->sk_data_ready(sk);
>  
>  	if (data != NULL) {
>  		pr_debug("about to send %d bytes of data\n", data->len);
> -		atm_force_charge(priv->lecd, data->truesize);
> +		atm_force_charge(vcc, data->truesize);
>  		skb_queue_tail(&sk->sk_receive_queue, data);
>  		sk->sk_data_ready(sk);
>  	}
>  
> +	rcu_read_unlock();
>  	return 0;
>  }
>  
> @@ -618,7 +640,7 @@ static void lec_push(struct atm_vcc *vcc, struct sk_buff *skb)
>  
>  		atm_return(vcc, skb->truesize);
>  		if (*(__be16 *) skb->data == htons(priv->lecid) ||
> -		    !priv->lecd || !(dev->flags & IFF_UP)) {
> +		    !rcu_access_pointer(priv->lecd) || !(dev->flags & IFF_UP)) {
>  			/*
>  			 * Probably looping back, or if lecd is missing,
>  			 * lecd has gone down
> @@ -753,12 +775,12 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
>  		priv = netdev_priv(dev_lec[i]);
>  	} else {
>  		priv = netdev_priv(dev_lec[i]);
> -		if (priv->lecd)
> +		if (rcu_access_pointer(priv->lecd))
>  			return -EADDRINUSE;
>  	}
>  	lec_arp_init(priv);
>  	priv->itfnum = i;	/* LANE2 addition */
> -	priv->lecd = vcc;
> +	rcu_assign_pointer(priv->lecd, vcc);
>  	vcc->dev = &lecatm_dev;
>  	vcc_insert_socket(sk_atm(vcc));
>  
> diff --git a/net/atm/lec.h b/net/atm/lec.h
> index be0e2667bd8c..ec85709bf818 100644
> --- a/net/atm/lec.h
> +++ b/net/atm/lec.h
> @@ -91,7 +91,7 @@ struct lec_priv {
>  						 */
>  	spinlock_t lec_arp_lock;
>  	struct atm_vcc *mcast_vcc;		/* Default Multicast Send VCC */
> -	struct atm_vcc *lecd;
> +	struct atm_vcc __rcu *lecd;
>  	struct delayed_work lec_arp_work;	/* C10 */
>  	unsigned int maximum_unknown_frame_count;
>  						/*
> -- 
> 2.43.0

