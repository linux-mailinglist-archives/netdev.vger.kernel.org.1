Return-Path: <netdev+bounces-135916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E53699FCA0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76441F23F86
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 23:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C3F1B0F33;
	Tue, 15 Oct 2024 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y+HFw/5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9281B0F0B
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036494; cv=none; b=ssek1ny2xSSe2GAL7nj8Chi3WGVhindOKVJr2BkqZhHP+BQqG0j9q7yO+aaruaxvwP64hjGOJYbWqLN+0XBEDZ4btFrUbfYjIy2p14GogI0xUucHF9yRp1uo5qrkbsqNmFYgNZIbjhlVqhmD/IWp33q6digovCzgyu9FwanP3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036494; c=relaxed/simple;
	bh=vCJ+T5dD6mLroc7eyvlIb05tnAP2QzJ13yEQDBR6dLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dh6MTzc96sx6ZiOE68JjNZz+kky6IPkdW/AevEGVUknMvrZj+o+nDi9r8meOnWNtQ9mIxIKXhBymAv8JUBrx7Gt5+WIsAHqGpDyyEq1I2bicAhrdxp+RfEHBOx33yiYapPHShR5+NkcF39GFL/IOe+Ui9e/uzlY3sanBGz11ycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Y+HFw/5/; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729036494; x=1760572494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z5DB3gQsjgdXrosW98Zy7OZQem4eEFj6DSgkRzVD378=;
  b=Y+HFw/5/BjPEcRWIRiv1QeZKbp8f0Ds2fH0kegHEScrHY+7osJ3Iq0J+
   6z7FS9vyPu8v4TABsLKVQhP070QkVw9b8QLwa7QLw1VoNS1WVDX+5pd4x
   XtIO4ybM9URkz1cdbghfXbWF5EpeNw6MkMFMJO1uUxjVltWoXAX7E04PA
   E=;
X-IronPort-AV: E=Sophos;i="6.11,206,1725321600"; 
   d="scan'208";a="461100837"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 23:54:49 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:35926]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id ce6f2192-46c9-4409-a686-df5f6cb83067; Tue, 15 Oct 2024 23:54:47 +0000 (UTC)
X-Farcaster-Flow-ID: ce6f2192-46c9-4409-a686-df5f6cb83067
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 23:54:47 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 15 Oct 2024 23:54:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 6/6] Create netdev->neighbour association
Date: Tue, 15 Oct 2024 16:54:41 -0700
Message-ID: <20241015235441.69622-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241015165929.3203216-7-gnaaman@drivenets.com>
References: <20241015165929.3203216-7-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Tue, 15 Oct 2024 16:59:26 +0000
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 61b5f0d4896a..dbfd27f79bb8 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -61,6 +61,19 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
>  static const struct seq_operations neigh_stat_seq_ops;
>  #endif
>  
> +static int family_to_neightbl_index(int family)
> +{

Let's return hlist_head * like this:

static hlist_head *neigh_get_dev_table(struct net_device *dev, int family)
{
	int i;

	switch (family) {
	case default:
		DEBUG_NET_WARN_ON_ONCE(1);
		fallthrough; /* to avoid panic by null-ptr-deref */
	case AF_INET:
		i = NEIGH_ARP_TABLE;
		break;
	case AF_INET6:
		i = NEIGH_ND_TABLE;
		break;
	}

	return &dev->neighbours[i];
}


>  @@ -357,46 +371,45 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
>  			    bool skip_perm)
>  {
>  	int i;
> +	struct neighbour *n;
> +	struct hlist_node *tmp;

nit: reverse xmas tree order.

and cache hlist_head * from neigh_get_dev_table().

>  	struct neigh_hash_table *nht;

nht is no longer used ?


>  
> +	i = family_to_neightbl_index(tbl->family);
> +
>  	nht = rcu_dereference_protected(tbl->nht,
>  					lockdep_is_held(&tbl->lock));
>  
> -	for (i = 0; i < (1 << nht->hash_shift); i++) {
> -		struct neighbour *n;
> -
> -		neigh_for_each(n, &nht->hash_heads[i]) {
> -			if (dev && n->dev != dev)
> -				continue;
> -			if (skip_perm && n->nud_state & NUD_PERMANENT)
> -				continue;
> +	hlist_for_each_entry_safe(n, tmp, &dev->neighbours[i], dev_list) {
> +		if (skip_perm && n->nud_state & NUD_PERMANENT)
> +			continue;
>  
> -			hlist_del_rcu(&n->hash);
> -			write_lock(&n->lock);
> -			neigh_del_timer(n);
> -			neigh_mark_dead(n);
> -			if (refcount_read(&n->refcnt) != 1) {
> -				/* The most unpleasant situation.
> -				   We must destroy neighbour entry,
> -				   but someone still uses it.
> -
> -				   The destroy will be delayed until
> -				   the last user releases us, but
> -				   we must kill timers etc. and move
> -				   it to safe state.
> -				 */
> -				__skb_queue_purge(&n->arp_queue);
> -				n->arp_queue_len_bytes = 0;
> -				WRITE_ONCE(n->output, neigh_blackhole);
> -				if (n->nud_state & NUD_VALID)
> -					n->nud_state = NUD_NOARP;
> -				else
> -					n->nud_state = NUD_NONE;
> -				neigh_dbg(2, "neigh %p is stray\n", n);
> -			}
> -			write_unlock(&n->lock);
> -			neigh_cleanup_and_release(n);
> +		hlist_del_rcu(&n->hash);
> +		hlist_del_rcu(&n->dev_list);
> +		write_lock(&n->lock);
> +		neigh_del_timer(n);
> +		neigh_mark_dead(n);
> +		if (refcount_read(&n->refcnt) != 1) {
> +			/* The most unpleasant situation.
> +			 * We must destroy neighbour entry,
> +			 * but someone still uses it.
> +			 *
> +			 * The destroy will be delayed until
> +			 * the last user releases us, but
> +			 * we must kill timers etc. and move
> +			 * it to safe state.
> +			 */
> +			__skb_queue_purge(&n->arp_queue);
> +			n->arp_queue_len_bytes = 0;
> +			WRITE_ONCE(n->output, neigh_blackhole);
> +			if (n->nud_state & NUD_VALID)
> +				n->nud_state = NUD_NOARP;
> +			else
> +				n->nud_state = NUD_NONE;
> +			neigh_dbg(2, "neigh %p is stray\n", n);
>  		}
> +		write_unlock(&n->lock);
> +		neigh_cleanup_and_release(n);
>  	}
>  }
>  
> @@ -672,6 +685,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
>  	if (want_ref)
>  		neigh_hold(n);
>  	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
> +
> +	error = family_to_neightbl_index(tbl->family);
> +	hlist_add_head_rcu(&n->dev_list, &dev->neighbours[error]);

Let's use neigh_dev_get_table() directly.

> +
>  	write_unlock_bh(&tbl->lock);
>  	neigh_dbg(2, "neigh %p is created\n", n);
>  	rc = n;

