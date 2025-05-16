Return-Path: <netdev+bounces-190913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCC0AB93CB
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 03:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477CE4A3E34
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E15220F2C;
	Fri, 16 May 2025 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="oBQs0h17"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F6323AD
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 01:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747360289; cv=none; b=VzcVKnBj9+xKqRA6tROSpXW+VMksbTL79x/i3QkBULEBKt9s/Ms2wfS9hp7iHQCOuP/cDAWsJUACidqXhN8wYtUjmtJmqaTBMH4MgTljQKUXxKkYFeN2E9S6xY004b0WnZjiGtUQ0yjWbhM12kmZZLaf54GiHQQMoPg/9vgD7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747360289; c=relaxed/simple;
	bh=3Ano1EREaReOL8fQotMGvV9no1FgqaH63YAxtkmDwEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6s2RvJHlaSA9N4m/DsT+e/7DIA1EV00qyI9CSCsDDZlWVEmEbfP9Wc50Y59r2Y0ujBPAwbT8FPsg5LyYvp4q9ZSR2lj81OycW/P+IxMGgUjT574IaRjcqAlUUrjfAOwsmrTx54vrfkh+OG9g3QhYrkj7oTMzcMwG6a/w+EYdIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=oBQs0h17; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747360288; x=1778896288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lI70L4Ogh0UdMi47Bmoiyc9kRuhuL+253tNouocIUw0=;
  b=oBQs0h17yzjShPXBnIsRVolXUnxD2noI1NcXaFmnEbk2SRNODRCiPqf7
   7bZTXixUGvgNWgZTr+4bigN0xwKfyDDJKHHmZ7BSYDVCAsM9xdHLSnRMO
   4tfhxuk8QqBJO4onQMyU8r4SyO8jHcDdf4xMlN5OqX47sV1y5rthn409L
   3IkOP/ZS7fGnayi/19Gr2op9sz4BYqLExhA/HcViU5hiDi3ZZF6fJg3BA
   dErLL3Y8V5SvCLpTQJAl8qtTf9fz5DrSZ6or+xnur00SQ4K/FDMHfH5YL
   23LQxPUErRVVkNEFCg9zlxj2zaB6b6aoDxySgs29WiAB3oUzyJc+12jh+
   A==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="50469526"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 01:51:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:25533]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.241:2525] with esmtp (Farcaster)
 id ab75bb16-f06c-4ba8-90b2-76886166cb01; Fri, 16 May 2025 01:51:25 +0000 (UTC)
X-Farcaster-Flow-ID: ab75bb16-f06c-4ba8-90b2-76886166cb01
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 01:51:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 01:51:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>
Subject: Re: [PATCH net-next] net: let lockdep compare instance locks
Date: Thu, 15 May 2025 18:49:07 -0700
Message-ID: <20250516015114.40011-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516012459.1385997-1-kuba@kernel.org>
References: <20250516012459.1385997-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 15 May 2025 18:24:59 -0700
> AFAIU always returning -1 from lockdep's compare function
> basically disables checking of dependencies between given
> locks. Try to be a little more precise about what guarantees
> that instance locks won't deadlock.
> 
> Right now we only nest them under protection of rtnl_lock.
> Mostly in unregister_netdevice_many() and dev_close_many().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/netdev_lock.h | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
> index 2a753813f849..75a2da23100d 100644
> --- a/include/net/netdev_lock.h
> +++ b/include/net/netdev_lock.h
> @@ -99,16 +99,29 @@ static inline void netdev_unlock_ops_compat(struct net_device *dev)
>  static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
>  				     const struct lockdep_map *b)
>  {
> -	/* Only lower devices currently grab the instance lock, so no
> -	 * real ordering issues can occur. In the near future, only
> -	 * hardware devices will grab instance lock which also does not
> -	 * involve any ordering. Suppress lockdep ordering warnings
> -	 * until (if) we start grabbing instance lock on pure SW
> -	 * devices (bond/team/veth/etc).
> -	 */
> +#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
> +	const struct net_device *dev_a, *dev_b;
> +
> +	dev_a = container_of(a, struct net_device, lock.dep_map);
> +	dev_b = container_of(b, struct net_device, lock.dep_map);
> +#endif
> +
>  	if (a == b)
>  		return 0;
> -	return -1;
> +
> +	/* Locking multiple devices usually happens under rtnl_lock */
> +	if (lockdep_rtnl_is_held())
> +		return -1;
> +
> +#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
> +	/* It's okay to use per-netns rtnl_lock if devices share netns */
> +	if (net_eq(dev_net(dev_a), dev_net(dev_b)) &&
> +	    lockdep_rtnl_net_is_held(dev_net(dev_a)))

Do we need

  !from_cleanup_net()

before lockdep_rtnl_net_is_held() ?

__rtnl_net_lock() is not held in ops_exit_rtnl_list() and
default_device_exit_batch() when calling unregister_netdevice_many().


> +		return -1;
> +#endif
> +
> +	/* Otherwise taking two instance locks is not allowed */
> +	return 1;
>  }
>  
>  #define netdev_lockdep_set_classes(dev)				\
> -- 
> 2.49.0
> 

