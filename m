Return-Path: <netdev+bounces-143086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8E9C11B0
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B791C21D70
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30247192B73;
	Thu,  7 Nov 2024 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kCRkvYNy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63155EC0
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018660; cv=none; b=lx/PrNjfpRu69U1wGbJPdDQCNsTzp7Evof51L5IlSQ8ZeGl2qig3P42JWQbY40Q5h6+AqWN9MVri4xBZOKVWAbyu/nL6HGeAUqUDq38wg/s0NuyHhHSr8Y/LDkDBiT+nYlK2dxt2qJ2eD2jPEKd9OEDIqv1n75NhgV09HNwvJqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018660; c=relaxed/simple;
	bh=H+00nN1+L12P/YEUMog2t8fgocJ/gblHIEJ2ETHqHK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0LFG878eZeWRe5LkAY/VHODPUZJ7bSVy/BI0Nr8e/YgbsyET86pOMZY04MfLThtbyAXhRMI/lYSUID/YFXEapxEiigDsQmuDy6KqhPO1moiwE8F20NsvfkV03qsMlsa6lowAT9piAOYwsf7mhZsxeIfHGTvb5QLUS69XG+QZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kCRkvYNy; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731018658; x=1762554658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3DjX391ST8sz8X0dFsWUzdE4yHewexYdyj849Sw1lK8=;
  b=kCRkvYNy1uTc0vZWH0BX/r4Gn9BinqYjOlqCfPCVTwrvbfeswufbKCl4
   wJ0/ArpThRFwFqeuqU369rbrq9dXgn/GuSwLIv36BR2Aj4gOaK7vCSr2V
   yVLXCcfqiKvd7rPhJmsEAUZg/vjlb7HBQ74/ObIDJdoPT4o/klg/ombUF
   0=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="441130415"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 22:30:54 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:35395]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.147:2525] with esmtp (Farcaster)
 id e99f36b5-3ad3-4992-846a-d9153c618c6f; Thu, 7 Nov 2024 22:30:54 +0000 (UTC)
X-Farcaster-Flow-ID: e99f36b5-3ad3-4992-846a-d9153c618c6f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 22:30:53 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 22:30:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next] Avoid traversing addrconf hash on ifdown
Date: Thu, 7 Nov 2024 14:30:48 -0800
Message-ID: <20241107223048.17156-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241107161323.2921985-1-gnaaman@drivenets.com>
References: <20241107161323.2921985-1-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Thu,  7 Nov 2024 16:13:23 +0000
> struct inet6_dev already has a list of addresses owned by the device,
> enabling us to traverse this much shorter list, instead of scanning
> the entire hash-table.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> ---
>  net/ipv6/addrconf.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index d0a99710d65d..9c57c993e1ec 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3846,12 +3846,12 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
>  {
>  	unsigned long event = unregister ? NETDEV_UNREGISTER : NETDEV_DOWN;
>  	struct net *net = dev_net(dev);
> -	struct inet6_dev *idev;
>  	struct inet6_ifaddr *ifa;
>  	LIST_HEAD(tmp_addr_list);
> +	struct inet6_dev *idev;
>  	bool keep_addr = false;
>  	bool was_ready;
> -	int state, i;
> +	int state;
>  
>  	ASSERT_RTNL();
>  
> @@ -3890,28 +3890,24 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
>  	}
>  
>  	/* Step 2: clear hash table */
> -	for (i = 0; i < IN6_ADDR_HSIZE; i++) {
> -		struct hlist_head *h = &net->ipv6.inet6_addr_lst[i];
> +	read_lock_bh(&idev->lock);
> +	spin_lock_bh(&net->ipv6.addrconf_hash_lock);

No need to nest _bh.


>  
> -		spin_lock_bh(&net->ipv6.addrconf_hash_lock);
> -restart:
> -		hlist_for_each_entry_rcu(ifa, h, addr_lst) {
> -			if (ifa->idev == idev) {
> -				addrconf_del_dad_work(ifa);
> -				/* combined flag + permanent flag decide if
> -				 * address is retained on a down event
> -				 */
> -				if (!keep_addr ||
> -				    !(ifa->flags & IFA_F_PERMANENT) ||
> -				    addr_is_local(&ifa->addr)) {
> -					hlist_del_init_rcu(&ifa->addr_lst);
> -					goto restart;
> -				}
> -			}
> +	list_for_each_entry(ifa, &idev->addr_list, if_list) {
> +		addrconf_del_dad_work(ifa);

while at it, please add newline here


> +		/* combined flag + permanent flag decide if
> +		 * address is retained on a down event
> +		 */
> +		if (!keep_addr ||
> +		    !(ifa->flags & IFA_F_PERMANENT) ||
> +		    addr_is_local(&ifa->addr)) {
> +			hlist_del_init_rcu(&ifa->addr_lst);
>  		}

and remove unnecessary {}.


> -		spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
>  	}
>  
> +	spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
> +	read_unlock_bh(&idev->lock);
> +
>  	write_lock_bh(&idev->lock);
>  
>  	addrconf_del_rs_timer(idev);
> -- 
> 2.34.1
> 

