Return-Path: <netdev+bounces-134629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFF399A8B5
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901F51C22214
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132AD196D9D;
	Fri, 11 Oct 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m+INzFeS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4A79E1
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663482; cv=none; b=b5VG+h/7OxGFDY8i841zuXjirh0lVUAAaGYjNTrJNHoh63L2Jnp8lyzknp3lpGnDyejRtlLjEdvZeIPx3/B/eQVfq3Ns7cO5sZooWuwkDE8GNzSPpOD2Rr7bHcfJlHW32IpTSmzG/CXkxauJ1eL/+Wue1Vz0UsvMuezcjv9Zk2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663482; c=relaxed/simple;
	bh=wQaXXBzmdSwPzDo3+l6LyGev6C0BwkZiX3MuPz/vVt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4iVVGZyb8U4laidWglXJT39qcHciYgAQYQiUtikXstf31nsTbnJQzNjF8hCFzusjX6nwLWi8M+OVErsasK9MWMdNTBUUcZb6oFFFnHcYCRdSW9PrpzZzzuhX2vKyjvHeYiWdzr5/U2FSm3ET0/nPowNNb/O0Xn8tb1ureNfhqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=m+INzFeS; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728663480; x=1760199480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4yVolXS4ygYJ4EHLSGnNlhbJIVixMaa+YdbdfVJpNsY=;
  b=m+INzFeSpPKN7RGcHCUZ8O5RYv0inPpU+0B2VoxCpqz4970C6po820Tm
   5RK4D8DzWZG614n1n6/GH5S3aB1JFAiGKhg0rBka5P8Rw4Gu5pH7gHzXJ
   WveaPgIeY54cGN5hhquL3jh7SNk4abkA8KCKGMlwpjLF3gHXCZk8e6HVc
   w=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="137830654"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 16:17:58 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:47658]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 437482ba-543a-46d3-a842-485b20c15479; Fri, 11 Oct 2024 16:17:58 +0000 (UTC)
X-Farcaster-Flow-ID: 437482ba-543a-46d3-a842-485b20c15479
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 16:17:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 16:17:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lkp@intel.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <llvm@lists.linux.dev>, <netdev@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 12/13] rtnetlink: Call rtnl_link_get_net_capable() in do_setlink().
Date: Fri, 11 Oct 2024 09:17:51 -0700
Message-ID: <20241011161751.6563-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <202410111515.TbOH4hSS-lkp@intel.com>
References: <202410111515.TbOH4hSS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: kernel test robot <lkp@intel.com>
Date: Fri, 11 Oct 2024 15:36:55 +0800
> cc6090e985d7d6 Jiri Pirko        2019-09-30  3264  
> c21ef3e343ae91 David Ahern       2017-04-16  3265  static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
> c21ef3e343ae91 David Ahern       2017-04-16  3266  			struct netlink_ext_ack *extack)
> 0157f60c0caea2 Patrick McHardy   2007-06-13  3267  {
> 3a6cb17da69fbf Kuniyuki Iwashima 2024-10-09  3268  	struct ifinfomsg *ifm = nlmsg_data(nlh);
> 3b1e0a655f8eba YOSHIFUJI Hideaki 2008-03-26  3269  	struct net *net = sock_net(skb->sk);
> 0157f60c0caea2 Patrick McHardy   2007-06-13  3270  	struct nlattr *tb[IFLA_MAX+1];
> 3a6cb17da69fbf Kuniyuki Iwashima 2024-10-09  3271  	struct net_device *dev = NULL;
> b27f78e2575aa2 Kuniyuki Iwashima 2024-10-09  3272  	struct net *tgt_net;
> 3a6cb17da69fbf Kuniyuki Iwashima 2024-10-09  3273  	int err;
> 0157f60c0caea2 Patrick McHardy   2007-06-13  3274  
> 8cb081746c031f Johannes Berg     2019-04-26  3275  	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
> 8cb081746c031f Johannes Berg     2019-04-26  3276  				     ifla_policy, extack);
> 0157f60c0caea2 Patrick McHardy   2007-06-13  3277  	if (err < 0)
> 0157f60c0caea2 Patrick McHardy   2007-06-13  3278  		goto errout;
> 0157f60c0caea2 Patrick McHardy   2007-06-13  3279  
> 4ff66cae7f10b6 Christian Brauner 2018-02-07  3280  	err = rtnl_ensure_unique_netns(tb, extack, false);
> 4ff66cae7f10b6 Christian Brauner 2018-02-07 @3281  	if (err < 0)
> 4ff66cae7f10b6 Christian Brauner 2018-02-07  3282  		goto errout;

Oops, I'll simply remove the errout label in v2.

