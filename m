Return-Path: <netdev+bounces-165005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60233A2FFDF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FA0163907
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540FA1805E;
	Tue, 11 Feb 2025 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VBaxIdxg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8444A926;
	Tue, 11 Feb 2025 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739235798; cv=none; b=eQD88ERSZcm0SRFZL78paosmPFiuKbXT9Bcu2/pwFC6CE78Wcx+F3Fukl4IW8I5hgXEu13Z7vVE3sugoBR3nYSlyPpt7Kdi56aGLl+lJspWdFkuxJyV0wH32kq0ugvc+O3bxExXfZ1tktXq9u07DwqGoQZw9Fqq4pBf5UjZhs/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739235798; c=relaxed/simple;
	bh=Q8SteR0xQ+W5zhzpyNRGWAeTdWHV1Vb+deP945UWrt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gV+MvaG6rF2oCkI0bxhNCsbeg0VJx/Cm62yH3u92fK9IWBak1wTQtNUH/lZF007Rf++2t27VG4KdbWEE1zb5ndwYUADwMLCBwkAN/nKFk/Q3YptT10fieYXH2vKbCxN8T5VsShIS5dkuyLEvwZyG59j6o7pq+rdDcHU65f87Q2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VBaxIdxg; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739235796; x=1770771796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xUUg1yuQKtP1h8QaYFTbfvGPsnE/orfe6HrxTpu+9KQ=;
  b=VBaxIdxg3k6pvyc6tBMn4ewCS5RmB80agqN0dWC/B+x7A3riKDi8KHCM
   w7Tp5FZ63K+PC1f/2S3ovRQAY4iy/oLBmQ0vcOahsGAOAXsYTmN/58gbg
   P0H1DRQoEgqzyfnwtonxhis3yBT0JPDLy4CAPcMx0lGMFl0Etv9ZvOtes
   c=;
X-IronPort-AV: E=Sophos;i="6.13,276,1732579200"; 
   d="scan'208";a="168553968"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:03:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:8862]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.31:2525] with esmtp (Farcaster)
 id c17c5f3f-50a1-4724-9928-16fa2a65b1ed; Tue, 11 Feb 2025 01:03:14 +0000 (UTC)
X-Farcaster-Flow-ID: c17c5f3f-50a1-4724-9928-16fa2a65b1ed
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 11 Feb 2025 01:03:13 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.10.138) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Feb 2025 01:03:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kernel-team@meta.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <ushankar@purestorage.com>
Subject: Re: [PATCH net-next v2 2/2] net: Add dev_getbyhwaddr_rtnl() helper
Date: Tue, 11 Feb 2025 10:03:00 +0900
Message-ID: <20250211010300.84678-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210-arm_fix_selftest-v2-2-ba84b5bc58c8@debian.org>
References: <20250210-arm_fix_selftest-v2-2-ba84b5bc58c8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Mon, 10 Feb 2025 03:56:14 -0800
> Add dedicated helper for finding devices by hardware address when
> holding rtnl_lock, similar to existing dev_getbyhwaddr_rcu(). This prevents
> PROVE_LOCKING warnings when rtnl_lock is held but RCU read lock is not.

No one uses dev_getbyhwaddr() yet, so this patch itself doens't fix
the warninig.

You are missing patch 3 to convert arp_req_set_public().  Other call
sites are under RCU.


> 
> Extract common address comparison logic into dev_comp_addr().
> 
> The context about this change could be found in the following
> discussion:
> 
> Link: https://lore.kernel.org/all/20250206-scarlet-ermine-of-improvement-1fcac5@leitao/
> 
> Cc: kuniyu@amazon.com
> Cc: ushankar@purestorage.com
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/netdevice.h |  2 ++
>  net/core/dev.c            | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0deee1313f23a625242678c8e571533e69a05263..6f0f5d327b41bfd5e0ccf9a3e63d6082bdf45d14 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3271,6 +3271,8 @@ static inline struct net_device *first_net_device_rcu(struct net *net)
>  }
>  
>  int netdev_boot_setup_check(struct net_device *dev);
> +struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
> +				   const char *hwaddr);
>  struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
>  				       const char *hwaddr);
>  struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c7e726f81406ece98801441dce3d683c8e0c9d99..2a0fbb319b2ad1b2aae908bc87ef19504cc42909 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1121,6 +1121,12 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
>  	return ret;
>  }
>  
> +static bool dev_comp_addr(struct net_device *dev, unsigned short type,
> +			  const char *ha)
> +{
> +	return dev->type == type && !memcmp(dev->dev_addr, ha, dev->addr_len);
> +}
> +
>  /**
>   *	dev_getbyhwaddr_rcu - find a device by its hardware address
>   *	@net: the applicable net namespace
> @@ -1129,7 +1135,7 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
>   *
>   *	Search for an interface by MAC address. Returns NULL if the device
>   *	is not found or a pointer to the device.
> - *	The caller must hold RCU or RTNL.
> + *	The caller must hold RCU.
>   *	The returned device has not had its ref count increased
>   *	and the caller must therefore be careful about locking
>   *
> @@ -1141,14 +1147,38 @@ struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
>  	struct net_device *dev;
>  
>  	for_each_netdev_rcu(net, dev)
> -		if (dev->type == type &&
> -		    !memcmp(dev->dev_addr, ha, dev->addr_len))
> +		if (dev_comp_addr(dev, type, ha))
>  			return dev;
>  
>  	return NULL;
>  }
>  EXPORT_SYMBOL(dev_getbyhwaddr_rcu);
>  
> +/**
> + *	dev_getbyhwaddr - find a device by its hardware address
> + *	@net: the applicable net namespace
> + *	@type: media type of device
> + *	@ha: hardware address
> + *
> + *	Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
> + *	rtnl_lock.
> + *
> + *	Return: pointer to the net_device, or NULL if not found
> + */
> +struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
> +				   const char *ha)
> +{
> +	struct net_device *dev;
> +
> +	ASSERT_RTNL();
> +	for_each_netdev(net, dev)
> +		if (dev_comp_addr(dev, type, ha))
> +			return dev;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(dev_getbyhwaddr);
> +
>  struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
>  {
>  	struct net_device *dev, *ret = NULL;
> 
> -- 
> 2.43.5

