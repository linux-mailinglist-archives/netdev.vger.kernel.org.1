Return-Path: <netdev+bounces-191350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD5CABB173
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 21:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB333B4F49
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 19:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E003813B58D;
	Sun, 18 May 2025 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bJ/jagXt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159084C8F
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747596822; cv=none; b=J1mbWXX2PMLMmQlPXWVlvzs3Cp7U6C94SjQZbQkmelKN1rp4KREZe5QNN3dWjsrpLQ/ce4LESUTI+MwiOj3dkyHnREYBcckwbAHyyRJO6kwykJjFLT4jWurQHlM5jsV4R3/7Hpqw2ZSs4V2BOb3CzIAzNIl4gW68QYWIq9F9DGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747596822; c=relaxed/simple;
	bh=INAAKKSFpEh1kxV0ciof4ysMsoQguiGS3CcgYFtM8i4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mw3cozocBlVI4mMaLINhhnBy1RKOcFYbqmZ253wZgGgdwWW5ZZQ9MM96ypaczqh0bnekHj2DMdfCU7fnFAZJ3dJjfdSch0ianUKqdN6atDgDkat4WEVcagWSEL9SuxoZaOu1sB7abPbtedLeThycESVAt2tu0NUUVTgDQHt7/+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bJ/jagXt; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747596822; x=1779132822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FqzCP6SC4OzZi0+Ag4zAnIJ0C9yvazxNT/MPREv0hMQ=;
  b=bJ/jagXtYSTb65S/Fdkfe9h73JKGuJ/9maf/t4WuXQonOk8IYkM2GDBr
   jVI3T1P+vnbYX2IQpyx1PIj0DmFeKiAHgfuSK7p3jjpcxNOEfwOt2kJEP
   CeZSzM7Yywb3c37bxIRDsAq2nzbmyIRcAWTUVL4phA9ZFT+RvHkjxFXYQ
   aU1YaypqfVybe5dFRvpt8S96lY7Ml+6mK2bf+KTOYPurvlJCPHfImDRdw
   OSiTe0VD2MHqoAUzTYKUv6PKUb5Nk7pPlw9vjKv4EHncrG2hxyDAG0V3U
   A9+ucudL6DM+i6Axdqe29uswseU95gWNt/ebfeeRtyf2o+JUJA+EbAQFJ
   w==;
X-IronPort-AV: E=Sophos;i="6.15,299,1739836800"; 
   d="scan'208";a="299073279"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 19:33:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:34211]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.122:2525] with esmtp (Farcaster)
 id ac23f9dc-bcf4-4777-b26a-a312afa25e0f; Sun, 18 May 2025 19:33:25 +0000 (UTC)
X-Farcaster-Flow-ID: ac23f9dc-bcf4-4777-b26a-a312afa25e0f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 18 May 2025 19:33:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.56) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 18 May 2025 19:33:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>
Subject: Re: [PATCH net-next v2] net: let lockdep compare instance locks
Date: Sun, 18 May 2025 12:32:52 -0700
Message-ID: <20250518193313.87050-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517200810.466531-1-kuba@kernel.org>
References: <20250517200810.466531-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Sat, 17 May 2025 13:08:10 -0700
> AFAIU always returning -1 from lockdep's compare function
> basically disables checking of dependencies between given
> locks. Try to be a little more precise about what guarantees
> that instance locks won't deadlock.
> 
> Right now we only nest them under protection of rtnl_lock.
> Mostly in unregister_netdevice_many() and dev_close_many().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
> v2:
>  - drop the speculative small rtnl handling
> v1: https://lore.kernel.org/20250516012459.1385997-1-kuba@kernel.org
> ---
>  include/net/netdev_lock.h | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
> index 2a753813f849..c345afecd4c5 100644
> --- a/include/net/netdev_lock.h
> +++ b/include/net/netdev_lock.h
> @@ -99,16 +99,15 @@ static inline void netdev_unlock_ops_compat(struct net_device *dev)
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
>  	if (a == b)
>  		return 0;
> -	return -1;
> +
> +	/* Allow locking multiple devices only under rtnl_lock,
> +	 * the exact order doesn't matter.
> +	 * Note that upper devices don't lock their ops, so nesting
> +	 * mostly happens in batched device removal for now.
> +	 */
> +	return lockdep_rtnl_is_held() ? -1 : 1;
>  }
>  
>  #define netdev_lockdep_set_classes(dev)				\
> -- 
> 2.49.0
> 

