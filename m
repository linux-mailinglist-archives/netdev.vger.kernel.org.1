Return-Path: <netdev+bounces-191121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC569ABA22F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 19:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19AEA011D4
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653021F872A;
	Fri, 16 May 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="igSUq3EZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA37E1A256B
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417844; cv=none; b=ufHtGnPTrtgBr3SqZ6PFDFedQrlOOWf1nddJgLaMMxkl414X8jJyAx5xag195PqGmtH2PiBpUw0ySAzx/DXqRLkjBfzMj3n3FSWX3jcpR6sucFOT/uH17Wan1wQrf02Akes3SZc6JZEztfkIEqhU2NOaD8jDk2nmV4HcMbuPnmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417844; c=relaxed/simple;
	bh=QsdiqeIitXnGueDjvE2kbgbXtGyFJjStvhyYijorMCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecZqiT2CO1midClDjtDojlY9dOejFvz2yfZMdYiIBpVoWTNhgTnF5Icg4cO8C7fYxYWndnVa5CZ7K5xPFi9cyXG49SFavuzojM/b2482xNtDtti3rZMqjKoEV418UXk+We352PmzrpoZz0ytdNnvsi8f1+Tqrgnfi/z0FSOaf2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=igSUq3EZ; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747417843; x=1778953843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TGglip95A5rvUGMLN9VR2TrgrkAEMnmwPMqDaut9f60=;
  b=igSUq3EZE0pd2V3F6TORsmQqlDDEeJGXTZijkStwZAj+GechR3KF1rn0
   SSNqvs3Ooj0R/TzHTgGqltOkdBLAGuu5MR1wBU1h1Ppw2dVq8LUP9cHSR
   tWhkIF4uWmU+6yKz/Dguz6d3j43NFb2cemkcIAgkhJpFvtOAMvDoYG8W6
   Kn2MioGPtW//5jJyiZdJPxMvdmNN35pGtoCTsWwIdGBV4lLUMC8pKtWKx
   HM61uLFhQmWOhiEUmT5wLPI0lSuYmAaYYksCNBVvfEhz9m1OTF6WeunA5
   WdC5jm9HAthHlyeatYzqtfdIkisJpbJ7dML+z7J1O2FjYY5xcysehOd0k
   g==;
X-IronPort-AV: E=Sophos;i="6.15,294,1739836800"; 
   d="scan'208";a="50822020"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:50:43 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:43250]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.83:2525] with esmtp (Farcaster)
 id edfe2841-a782-4989-bc0b-84d3e55e3ab2; Fri, 16 May 2025 17:50:42 +0000 (UTC)
X-Farcaster-Flow-ID: edfe2841-a782-4989-bc0b-84d3e55e3ab2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 17:50:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 17:50:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>
Subject: Re: [PATCH net-next] net: let lockdep compare instance locks
Date: Fri, 16 May 2025 10:50:04 -0700
Message-ID: <20250516175031.70899-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516101441.5ad5b722@kernel.org>
References: <20250516101441.5ad5b722@kernel.org>
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

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 16 May 2025 10:14:41 -0700
> On Fri, 16 May 2025 08:22:43 -0700 Jakub Kicinski wrote:
> > On Thu, 15 May 2025 19:59:41 -0700 Kuniyuki Iwashima wrote:
> > > > Is the thinking that once the big rtnl lock disappears in cleanup_net
> > > > the devices are safe to destroy without any locking because there can't
> > > > be any live users trying to access them?    
> > > 
> > > I hope yes, but removing VF via sysfs and removing netns might
> > > race and need some locking ?  
> > 
> > I think we should take the small lock around default_device_exit_net()
> > and then we'd be safe?

Agree.  The 'queuing dev for destruction' part will be only racy.


> > Either a given VF gets moved to init_net first
> > or the sysfs gets to it and unregisters it safely in the old netns.
> 
> Thinking about it some more, we'll have to revisit this problem before
> removing the big lock, anyway. I'm leaning towards doing this for now:

This looks good to me.


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
> +	 * mostly happens during batched device removal for now.
> +	 */
> +	return lockdep_rtnl_is_held() ? -1 : 1;
>  }
>  
>  #define netdev_lockdep_set_classes(dev)				\

