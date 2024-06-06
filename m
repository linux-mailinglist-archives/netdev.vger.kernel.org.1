Return-Path: <netdev+bounces-101592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30428FF834
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 01:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E58B21879
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 23:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA9813C814;
	Thu,  6 Jun 2024 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Pr+90Nsd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B84374FB
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716931; cv=none; b=vFISWB6W+FrOsCnSf5r/DVmzBxVWBTSfmacKsr6ATTCxNb1D3lMp2+UWVNPbGjqhyiC7vn3dZ8FqyUYH1D5figzBJOTTvMzXVMnlX3pmQY7DeKaHcNalkuGBK+4eGdWCeu6gu4EqWQrwUw6NQGm3ZGVgc6J+ufgfXCstbeI+Igc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716931; c=relaxed/simple;
	bh=YzcysYWrMedOH2/UKY2h9ou4Yb8BcyUg2ikEZtTdmS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j944flw5vC1O+lSCA8MrxhoHu1Yk7YbH/SJxDsLvsAhoBXo6LNkMbTC+oj/2OQOEUphf+71UE1+FZYdPwyCtjdhuEjLhoAUEEsHUr1QwYY6XgEdiblSpKI04M5VuSqS4e12CgqiM5zopn1tqvGVDHgUjDMNRBWBBAuAHVHv+vo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Pr+90Nsd; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717716930; x=1749252930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IFRRfgLfNyTVrApra4v+MlAZw6sIYCV5CIQY4Ul6FYg=;
  b=Pr+90NsdrpGmggSR2QBrgNopRej5qMiyETr0el0G+IUitvASrK9lUIK8
   9bmQYQjTanMEpUzEnSJGlvAsawwHPWC8Gj9N5PpmZThVKSGgWIegoVP3l
   5BEAWVoeRvy6ifStO3z1Jnl5XQ91btYK6MqWsI7TgbOdhm3HcHFmsAFLI
   g=;
X-IronPort-AV: E=Sophos;i="6.08,219,1712620800"; 
   d="scan'208";a="401726054"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 23:35:27 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:10673]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.252:2525] with esmtp (Farcaster)
 id cb3ffd1c-5b64-4540-b3b2-944c301bc60f; Thu, 6 Jun 2024 23:35:26 +0000 (UTC)
X-Farcaster-Flow-ID: cb3ffd1c-5b64-4540-b3b2-944c301bc60f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 6 Jun 2024 23:35:26 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 6 Jun 2024 23:35:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <Liam.Howlett@oracle.com>, <anjali.k.kulkarni@oracle.com>,
	<davem@davemloft.net>, <dsahern@gmail.com>, <edumazet@google.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 2/2] net: netlink: remove the cb_mutex "injection" from netlink core
Date: Thu, 6 Jun 2024 16:35:12 -0700
Message-ID: <20240606233512.37483-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240606192906.1941189-3-kuba@kernel.org>
References: <20240606192906.1941189-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu,  6 Jun 2024 12:29:06 -0700
> Back in 2007, in commit af65bdfce98d ("[NETLINK]: Switch cb_lock spinlock
> to mutex and allow to override it") netlink core was extended to allow
> subsystems to replace the dump mutex lock with its own lock.
> 
> The mechanism was used by rtnetlink to take rtnl_lock but it isn't
> sufficiently flexible for other users. Over the 17 years since
> it was added no other user appeared. Since rtnetlink needs conditional
> locking now, and doesn't use it either, axe this feature complete.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
> CC: anjali.k.kulkarni@oracle.com
> CC: Liam.Howlett@oracle.com
> CC: jiri@resnulli.us
> ---
>  include/linux/netlink.h  |  1 -
>  net/netlink/af_netlink.c | 18 +++---------------
>  2 files changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index 5df7340d4dab..b332c2048c75 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -47,7 +47,6 @@ struct netlink_kernel_cfg {
>  	unsigned int	groups;
>  	unsigned int	flags;
>  	void		(*input)(struct sk_buff *skb);
> -	struct mutex	*cb_mutex;
>  	int		(*bind)(struct net *net, int group);
>  	void		(*unbind)(struct net *net, int group);
>  	void            (*release) (struct sock *sk, unsigned long *groups);
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 8bbbe75e75db..0b7a89db3ab7 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -636,8 +636,7 @@ static struct proto netlink_proto = {
>  };
>  
>  static int __netlink_create(struct net *net, struct socket *sock,
> -			    struct mutex *dump_cb_mutex, int protocol,
> -			    int kern)
> +			    int protocol, int kern)
>  {
>  	struct sock *sk;
>  	struct netlink_sock *nlk;
> @@ -655,7 +654,6 @@ static int __netlink_create(struct net *net, struct socket *sock,
>  	lockdep_set_class_and_name(&nlk->nl_cb_mutex,
>  					   nlk_cb_mutex_keys + protocol,
>  					   nlk_cb_mutex_key_strings[protocol]);
> -	nlk->dump_cb_mutex = dump_cb_mutex;
>  	init_waitqueue_head(&nlk->wait);
>  
>  	sk->sk_destruct = netlink_sock_destruct;
> @@ -667,7 +665,6 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
>  			  int kern)
>  {
>  	struct module *module = NULL;
> -	struct mutex *cb_mutex;
>  	struct netlink_sock *nlk;
>  	int (*bind)(struct net *net, int group);
>  	void (*unbind)(struct net *net, int group);
> @@ -696,7 +693,6 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
>  		module = nl_table[protocol].module;
>  	else
>  		err = -EPROTONOSUPPORT;
> -	cb_mutex = nl_table[protocol].cb_mutex;
>  	bind = nl_table[protocol].bind;
>  	unbind = nl_table[protocol].unbind;
>  	release = nl_table[protocol].release;
> @@ -705,7 +701,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
>  	if (err < 0)
>  		goto out;
>  
> -	err = __netlink_create(net, sock, cb_mutex, protocol, kern);
> +	err = __netlink_create(net, sock, protocol, kern);
>  	if (err < 0)
>  		goto out_module;
>  
> @@ -2016,7 +2012,6 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
>  	struct sock *sk;
>  	struct netlink_sock *nlk;
>  	struct listeners *listeners = NULL;
> -	struct mutex *cb_mutex = cfg ? cfg->cb_mutex : NULL;
>  	unsigned int groups;
>  
>  	BUG_ON(!nl_table);
> @@ -2027,7 +2022,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
>  	if (sock_create_lite(PF_NETLINK, SOCK_DGRAM, unit, &sock))
>  		return NULL;
>  
> -	if (__netlink_create(net, sock, cb_mutex, unit, 1) < 0)
> +	if (__netlink_create(net, sock, unit, 1) < 0)
>  		goto out_sock_release_nosk;
>  
>  	sk = sock->sk;
> @@ -2055,7 +2050,6 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
>  	if (!nl_table[unit].registered) {
>  		nl_table[unit].groups = groups;
>  		rcu_assign_pointer(nl_table[unit].listeners, listeners);
> -		nl_table[unit].cb_mutex = cb_mutex;
>  		nl_table[unit].module = module;
>  		if (cfg) {
>  			nl_table[unit].bind = cfg->bind;
> @@ -2326,15 +2320,9 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
>  	netlink_skb_set_owner_r(skb, sk);
>  
>  	if (nlk->dump_done_errno > 0) {
> -		struct mutex *extra_mutex = nlk->dump_cb_mutex;
> -
>  		cb->extack = &extack;
>  
> -		if (extra_mutex)
> -			mutex_lock(extra_mutex);
>  		nlk->dump_done_errno = cb->dump(skb, cb);
> -		if (extra_mutex)
> -			mutex_unlock(extra_mutex);
>  
>  		/* EMSGSIZE plus something already in the skb means
>  		 * that there's more to dump but current skb has filled up.
> -- 
> 2.45.2

