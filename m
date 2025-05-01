Return-Path: <netdev+bounces-187189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA16AA5926
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 02:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B9F1782E3
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232851E3DF2;
	Thu,  1 May 2025 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P8XVsvcC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C31E2848
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746060537; cv=none; b=gb+4UMPjZ9IA5RG/aflSXGeCJfDS0uvv6N51iLmLk73gkFr3uA2vNzkLjOaUFcXYRxhXOpNkUPJHlHaw6WyMT/ggBPgdeiPRoAjQUwnk+J7wgVAd0O0W1DxYCuYXUjq6OqfJXTZEBrSu2UwgMTkc1HmbrIUzTAGnJspZNCp0yKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746060537; c=relaxed/simple;
	bh=Ds8TmMBuw7jjFlzTjltkIfGXe08pcnBpGA6l+fgZPNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+8UnhULpIdMXSVEWXbynobHlVNupaRYlaMqDNU4UN4iNf6o4J3+79ntWV6kP/5sLqhcdABwaSRJRwlcrUt5mCVp1zRnI7NsG4FotxbigAxZpjWX1gI9K0jTPeAWzrV0V2LSNRHF5+BXilKHZ/fe2qYidWatQGiPiBjU3mZuBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=P8XVsvcC; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746060536; x=1777596536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpuYtmvW5LY27MeIh1sbMXg9diZApPjrsPUVVk04ReM=;
  b=P8XVsvcC5VmqGrzliiB07vy/QypMvqFt5tvAX2hSHE7vJQW7HDqdToR0
   5BK/6jEnLnkR+ZrRg/C0cRDnZ+tLLVSSdS1Ld/34aZvfydO9ziYFPvAUv
   dAMBI/ONSP+cuBkfIefGvtRjjj8HUqibs9wN302Nd7gdAfQBkQow49o2U
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,253,1739836800"; 
   d="scan'208";a="88687929"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 00:48:52 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:12093]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.21:2525] with esmtp (Farcaster)
 id e48674e6-9409-4594-9909-00e6b9f42e3a; Thu, 1 May 2025 00:48:51 +0000 (UTC)
X-Farcaster-Flow-ID: e48674e6-9409-4594-9909-00e6b9f42e3a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 00:48:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 00:48:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dsahern@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>,
	<yi1.lai@linux.intel.com>
Subject: Re: [PATCH v1 net-next] ipv6: Restore fib6_config validation for SIOCADDRT.
Date: Wed, 30 Apr 2025 17:48:37 -0700
Message-ID: <20250501004841.52728-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <86cf6035-c6d9-462c-9a9c-42a6d0368069@kernel.org>
References: <86cf6035-c6d9-462c-9a9c-42a6d0368069@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: David Ahern <dsahern@kernel.org>
Date: Tue, 29 Apr 2025 09:31:33 -0600
> On 4/28/25 6:46 PM, Kuniyuki Iwashima wrote:
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index d0351e95d916..4c1e86e968f8 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -4496,6 +4496,53 @@ void rt6_purge_dflt_routers(struct net *net)
> >  	rcu_read_unlock();
> >  }
> >  
> > +static int fib6_config_validate(struct fib6_config *cfg,
> > +				struct netlink_ext_ack *extack)
> > +{
> > +	/* RTF_PCPU is an internal flag; can not be set by userspace */
> > +	if (cfg->fc_flags & RTF_PCPU) {
> > +		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_PCPU");
> > +		goto errout;
> > +	}
> > +
> > +	/* RTF_CACHE is an internal flag; can not be set by userspace */
> > +	if (cfg->fc_flags & RTF_CACHE) {
> > +		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_CACHE");
> > +		goto errout;
> > +	}
> > +
> > +	if (cfg->fc_type > RTN_MAX) {
> > +		NL_SET_ERR_MSG(extack, "Invalid route type");
> > +		goto errout;
> > +	}
> > +
> > +	if (cfg->fc_dst_len > 128) {
> > +		NL_SET_ERR_MSG(extack, "Invalid prefix length");
> > +		goto errout;
> > +	}
> > +
> > +#ifdef CONFIG_IPV6_SUBTREES
> > +	if (cfg->fc_src_len > 128) {
> > +		NL_SET_ERR_MSG(extack, "Invalid source address length");
> > +		goto errout;
> > +	}
> > +
> > +	if (cfg->fc_nh_id &&  cfg->fc_src_len) {
> 
> extra space after '&&'

I didn't notice I added it in fa76c1674f2e.

Will remove it in v2 and add the missing last-minute change
that caused build failure..

Thanks!

