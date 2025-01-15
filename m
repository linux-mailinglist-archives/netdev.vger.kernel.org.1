Return-Path: <netdev+bounces-158413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A6EA11C01
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A6818851C9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEBE23F26C;
	Wed, 15 Jan 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZyKjNqyJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C74523F260
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736929848; cv=none; b=HpVModOBN/6BaFzYvaPMiRLW3lpsC5FV7Aheu7I5WB5JTTQ/2HUpkc7JQMFt0IGU4qb9v7vTG09MdBAzgXU+gInLZkloXNxSzqTLuwhBUpd80n2v4W20EPNlm0rxjAkzRUk3QN6XOdoBbXpgWijnQ/i4gl+T9C5trjDmmavEIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736929848; c=relaxed/simple;
	bh=6t+/mu5lzz+22dKXKWeM3OinEYrgSNr0wsvYOGsGA7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qThCIRe5QgCJTdUlioJrCoJEVs/lxDuwSYCjMzOxupYu1Cf3ALKCYm+D+teUMoFXxvSeM0mbP8bUX9uhUl9d3sNxuDBNtQPftEOgykVPGu2ImLIBoLCcgmNopKVUWJu6DgiNEQJd4phs8vFXFD+cHqxNdXEcwlMJtnLBxk78uvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZyKjNqyJ; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736929846; x=1768465846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZce2zcbMenbsZWc5WkBbuZjBC9/5JWWKY9+lAPaxxQ=;
  b=ZyKjNqyJ0tVLz2e+0h7KBjgkPX9xbXutyoUK/qHcsvfIjirqn5maYpny
   +OkZYmwKyaPHLcO6KLY+zHRcxG/k1xqJ1edKYB7uj8tdmCd6IvZx0X35y
   QzHot75gMMSNFBQI4TUvSxRYFi9azS5h1jjvurgrh9zxyNI6w2dAWTlOb
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="486100296"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:30:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:43829]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.70:2525] with esmtp (Farcaster)
 id 458cd315-0868-4342-8b95-3bbfc518065e; Wed, 15 Jan 2025 08:30:37 +0000 (UTC)
X-Farcaster-Flow-ID: 458cd315-0868-4342-8b95-3bbfc518065e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:30:37 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:30:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 02/11] net: make netdev_lock() protect netdev->reg_state
Date: Wed, 15 Jan 2025 17:30:23 +0900
Message-ID: <20250115083023.31347-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115035319.559603-3-kuba@kernel.org>
References: <20250115035319.559603-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 14 Jan 2025 19:53:10 -0800
> Protect writes to netdev->reg_state with netdev_lock().
> From now on holding netdev_lock() is sufficient to prevent
> the net_device from getting unregistered, so code which
> wants to hold just a single netdev around no longer needs
> to hold rtnl_lock.
> 
> We do not protect the NETREG_UNREGISTERED -> NETREG_RELEASED
> transition. We'd need to move mutex_destroy(netdev->lock)
> to .release, but the real reason is that trying to stop
> the unregistration process mid-way would be unsafe / crazy.
> Taking references on such devices is not safe, either.
> So the intended semantics are to lock REGISTERED devices.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - reorder with next patch
> v1: https://lore.kernel.org/20250114035118.110297-4-kuba@kernel.org
> ---
>  include/linux/netdevice.h | 2 +-
>  net/core/dev.c            | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 891c5bdb894c..30963c5d409b 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2448,7 +2448,7 @@ struct net_device {
>  	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
>  	 * Drivers are free to use it for other protection.
>  	 *
> -	 * Protects: @net_shaper_hierarchy.
> +	 * Protects: @reg_state, @net_shaper_hierarchy.
>  	 * Ordering: take after rtnl_lock.
>  	 */
>  	struct mutex		lock;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index fda4e1039bf0..6603c08768f6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10668,7 +10668,9 @@ int register_netdevice(struct net_device *dev)
>  
>  	ret = netdev_register_kobject(dev);
>  
> +	netdev_lock(dev);
>  	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
> +	netdev_unlock(dev);

Do we need the lock before list_netdevice() ?

It's not a big deal, so

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

