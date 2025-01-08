Return-Path: <netdev+bounces-156162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF43A05311
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED86166A08
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0F319F133;
	Wed,  8 Jan 2025 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bkEZuCDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B6225D7
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736316677; cv=none; b=TBle2FoxV1CAxrCaPfOt5Ia+X259k7g4aJHZeit6ILGIjktqpJP9q0yUlRm2hMCMpXUOxbF6MKQbETUJKT35VVCKOd9MWTZQFIBYLhnL9zhdhFIpfNODWq3Er/yaD4sfzMN0miIXVqwtrtM+ae2dmxe1NDxRRlPwUtQdUh0XFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736316677; c=relaxed/simple;
	bh=GbKJdMLVaFfGdsn46/7g24MRDtjORUBxjW+BBv4ppTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InWrBRmN5GwMmF+bJ2x+AIWkSDtDgeT97z03eTrp0oTTVkd43B6gU1sk3ETz8QlPnV1548sodc9T216+5lC5QtBUW/xfxHSjjSoz8oya4CMKgtnSbUZ2zhTNWmbs4rpNQU05qVt2esRUvgBTOmENMfeOlYe0MvBLvOWqGzKsOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bkEZuCDu; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736316677; x=1767852677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ivjUWeVWFHbced6TbMeo0Y2sSnfGtZuuLTx5LMpRyRc=;
  b=bkEZuCDurQX362oO2kM6PQ0+ZbDLfWcsKulQBTke7f6ytNrNfFVITnch
   zdySHOHpTey9jkGA80lFu2kdV6XABBoPni7gKjDyMw6wEzrdhR6ylRnsX
   YDenaSQdHnTJjSZoIGS9tH8ZmZT1OsYW/hJQHl/sGBJvQkEBkg37PmOJV
   w=;
X-IronPort-AV: E=Sophos;i="6.12,297,1728950400"; 
   d="scan'208";a="484427225"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 06:11:11 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:46234]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.4:2525] with esmtp (Farcaster)
 id 685f5225-b8cb-447f-b4b2-c5281267222e; Wed, 8 Jan 2025 06:11:09 +0000 (UTC)
X-Farcaster-Flow-ID: 685f5225-b8cb-447f-b4b2-c5281267222e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 06:11:03 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 06:10:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 0/2] dev: Hold per-netns RTNL in register_netdev().
Date: Wed, 8 Jan 2025 15:10:50 +0900
Message-ID: <20250108061050.9328-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <3fe814ea-ede2-415a-8b3e-e09a29e4218d@redhat.com>
References: <3fe814ea-ede2-415a-8b3e-e09a29e4218d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 7 Jan 2025 13:55:51 +0100
> On 1/4/25 9:21 AM, Kuniyuki Iwashima wrote:
> > Patch 1 adds rtnl_net_lock_killable() and Patch 2 uses it in
> > register_netdev() and converts it and unregister_netdev() to
> > per-netns RTNL.
> > 
> > With this and the netdev notifier series [0], ASSERT_RTNL_NET()
> > for NETDEV_REGISTER [1] wasn't fired on a simplest QEMU setup
> > like e1000 + x86_64_defconfig + CONFIG_DEBUG_NET_SMALL_RTNL.
> > 
> > [0]: https://lore.kernel.org/netdev/20250104063735.36945-1-kuniyu@amazon.com/
> > 
> > [1]:
> > ---8<---
> > diff --git a/net/core/rtnl_net_debug.c b/net/core/rtnl_net_debug.c
> > index f406045cbd0e..c0c30929002e 100644
> > --- a/net/core/rtnl_net_debug.c
> > +++ b/net/core/rtnl_net_debug.c
> > @@ -21,7 +21,6 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
> >  	case NETDEV_DOWN:
> >  	case NETDEV_REBOOT:
> >  	case NETDEV_CHANGE:
> > -	case NETDEV_REGISTER:
> >  	case NETDEV_UNREGISTER:
> >  	case NETDEV_CHANGEMTU:
> >  	case NETDEV_CHANGEADDR:
> > @@ -60,19 +59,10 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
> >  		ASSERT_RTNL();
> >  		break;
> >  
> > -	/* Once an event fully supports RTNL_NET, move it here
> > -	 * and remove "if (0)" below.
> > -	 *
> > -	 * case NETDEV_XXX:
> > -	 *	ASSERT_RTNL_NET(net);
> > -	 *	break;
> > -	 */
> > -	}
> > -
> > -	/* Just to avoid unused-variable error for dev and net. */
> > -	if (0)
> > +	case NETDEV_REGISTER:
> >  		ASSERT_RTNL_NET(net);
> > +		break;
> > +	}
> >  
> >  	return NOTIFY_DONE;
> >  }
> > ---8<---
> 
> FTR, the above fooled a bit both PW and our scripts: I had to manually
> mangle the cover letter into the merge commit. I guess it would be good
> to avoid patch snips in the cover-letter,

Oh sorry, noted.

Thank you !

