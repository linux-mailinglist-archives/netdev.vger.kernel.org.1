Return-Path: <netdev+bounces-253902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PLVNjLIeGmNtQEAu9opvQ
	(envelope-from <netdev+bounces-253902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:14:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0449F9574A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4669302ACBD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D73286409;
	Tue, 27 Jan 2026 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QYF7parS"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E327FB35
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522865; cv=none; b=h6vFbOn/orGeN8IAj7JW0qCjvVwwSBrwWC0nmv5uO/1FuFU4HzpzYn5EqU9m3Cpr+7amdKBTo6HmfjW2bZOcC0VWrSrqng405pmG168QMbHSw6wZZpjqHa4yR1G8YOrQyU7UsVquEBq9O5W1Ctat2tNeg1eCChHnCjl/t3nSBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522865; c=relaxed/simple;
	bh=vr+L/Eun3ObRos0c06KgLswjkuveuhohAcdVe7672QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIaWRwcslZY21j8pC7pcrT6ReftBS+o6r5+Nhg5EMDiOaNWwLGm36cyT2tS0Q5QHjnZOGQhd9cYZz2K4YwACVJ0emCNQZj5/1ue4jiKHX1/+uu2jcXU0q/m37GjA5uXs3y8I6N6PKJNabcV4HBEj8QVU5q1NvSGkGqOx75tK8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QYF7parS; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769522850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRz7VB1P4wFGPbX+B9FpSKtSA+/27OVKZWSWtgmkfM0=;
	b=QYF7parSSqex8ih+x2a06z63aHh7DFFju4QhHNpOS5u1pNAwmpXJlbxIqe3BNg+UfxOHKf
	z3fC8G8iUp4w0WA6RJZmVJKjPTzm73v9d1rKylx3Xs1oJI7IwOL0kXqbKV390bXURQ+1gt
	63cb3z7h2Zn4mmPQO5LSK72+mwwyvd4=
From: Menglong Dong <menglong.dong@linux.dev>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: edumazet@google.com, brauner@kernel.org, davem@davemloft.net,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, realwujing@gmail.com, yuanql9@chinatelecom.cn
Subject:
 Re: [PATCH v2] netns: optimize netns cleaning by batching unhash_nsid calls
Date: Tue, 27 Jan 2026 22:07:15 +0800
Message-ID: <6232955.lOV4Wx5bFT@7950hx>
In-Reply-To: <20260126112451.1071143-1-realwujing@gmail.com>
References:
 <CANn89i+pyHq-jfqoaXpk_07LVCn+REmW1wPTbKmxV7ykZCEHfg@mail.gmail.com>
 <20260126112451.1071143-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-253902-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[google.com,kernel.org,davemloft.net,vger.kernel.org,redhat.com,gmail.com,chinatelecom.cn];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0449F9574A
X-Rspamd-Action: no action

On 2026/1/26 19:24, Qiliang Yuan wrote:
> Currently, unhash_nsid() scans the entire net_namespace_list for each
> netns in a destruction batch during cleanup_net(). This leads to
> O(M_batch * N_system * M_nsids) complexity, where M_batch is the
> destruction batch size, N_system is the total number of namespaces,
> and M_nsids is the number of IDs in each IDR.
> 
> Reduce the complexity to O(N_system * M_nsids) by introducing an
> 'is_dying' flag to mark namespaces being destroyed. This allows
> unhash_nsid() to perform a single-pass traversal over the system's
> namespaces. In this pass, for each survivor namespace, iterate
> through its netns_ids and remove any mappings that point to a marked
> namespace, effectively eliminating the M_batch multiplier.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>

I said it many times. Don't send a new version by replying your
previous version, which is not friend to the reviewers, OK?

And target tree show be added. In this patch, it should be "net-next".

> ---
> v2:
>  - Remove unrelated ifindex and is_dying initialization in preinit_net.
>  - Move is_dying = true to __put_net() to avoid an extra loop in cleanup_net.
> v1:
>  - Initial proposal using 'is_dying' flag to batch unhash_nsid calls.
> 
>  include/net/net_namespace.h |  1 +
>  net/core/net_namespace.c    | 46 ++++++++++++++++++++++++++-----------
>  2 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index cb664f6e3558..bd1acc6056ac 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -69,6 +69,7 @@ struct net {
>  
>  	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
>  	u32			ifindex;
> +	bool			is_dying;
>  
>  	spinlock_t		nsid_lock;
>  	atomic_t		fnhe_genid;
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index a6e6a964a287..50fdd4f9bb3b 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -624,9 +624,10 @@ void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid)
>  }
>  EXPORT_SYMBOL_GPL(net_ns_get_ownership);
>  
> -static void unhash_nsid(struct net *net, struct net *last)
> +static void unhash_nsid(struct net *last)
>  {
>  	struct net *tmp;
> +
>  	/* This function is only called from cleanup_net() work,
>  	 * and this work is the only process, that may delete
>  	 * a net from net_namespace_list. So, when the below
> @@ -636,20 +637,34 @@ static void unhash_nsid(struct net *net, struct net *last)
>  	for_each_net(tmp) {
>  		int id;
>  
> -		spin_lock(&tmp->nsid_lock);
> -		id = __peernet2id(tmp, net);
> -		if (id >= 0)
> -			idr_remove(&tmp->netns_ids, id);
> -		spin_unlock(&tmp->nsid_lock);
> -		if (id >= 0)
> -			rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
> -					  GFP_KERNEL);
> +		for (id = 0; ; id++) {
> +			struct net *peer;
> +			bool dying;
> +
> +			rcu_read_lock();
> +			peer = idr_get_next(&tmp->netns_ids, &id);
> +			dying = peer && peer->is_dying;
> +			rcu_read_unlock();
> +
> +			if (!peer)
> +				break;
> +			if (!dying)
> +				continue;
> +
> +			spin_lock(&tmp->nsid_lock);
> +			if (idr_find(&tmp->netns_ids, id) == peer)
> +				idr_remove(&tmp->netns_ids, id);
> +			else
> +				peer = NULL;
> +			spin_unlock(&tmp->nsid_lock);
> +
> +			if (peer)
> +				rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0,
> +						  NULL, GFP_KERNEL);
> +		}
>  		if (tmp == last)
>  			break;
>  	}
> -	spin_lock(&net->nsid_lock);
> -	idr_destroy(&net->netns_ids);
> -	spin_unlock(&net->nsid_lock);
>  }
>  
>  static LLIST_HEAD(cleanup_list);
> @@ -688,8 +703,12 @@ static void cleanup_net(struct work_struct *work)
>  	last = list_last_entry(&net_namespace_list, struct net, list);
>  	up_write(&net_rwsem);
>  
> +	unhash_nsid(last);
> +
>  	llist_for_each_entry(net, net_kill_list, cleanup_list) {
> -		unhash_nsid(net, last);
> +		spin_lock(&net->nsid_lock);
> +		idr_destroy(&net->netns_ids);
> +		spin_unlock(&net->nsid_lock);
>  		list_add_tail(&net->exit_list, &net_exit_list);
>  	}
>  
> @@ -739,6 +758,7 @@ static DECLARE_WORK(net_cleanup_work, cleanup_net);
>  void __put_net(struct net *net)
>  {
>  	ref_tracker_dir_exit(&net->refcnt_tracker);
> +	net->is_dying = true;
>  	/* Cleanup the network namespace in process context */
>  	if (llist_add(&net->cleanup_list, &cleanup_list))
>  		queue_work(netns_wq, &net_cleanup_work);
> 





