Return-Path: <netdev+bounces-182396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EBEA88AA8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03E1189A7D2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF0428A1FB;
	Mon, 14 Apr 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jWPjvl2A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040328A1D8;
	Mon, 14 Apr 2025 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653794; cv=none; b=kt1SQi5AcACFLUrGAbHz3Glyi7y/S5ZFlJCTIkkn1P5HFmDgAsNUAZLEo9jiiotbVkK33kzVEf4i60ABEnHUDGSueMDDfMviOTb5eMPvGPQOg4FJ2YYgENGXwGrCkgKXqB+aIXOwL58onmyotEj7Drwuyxez/4x+PLw7J6+tdm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653794; c=relaxed/simple;
	bh=IvCN0e3lwsHf7OdOMBKG5+Nd/K9HqBR64ZQRpqFZl1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbVq8FW4cdZmAcpHBHbC0VISNJpZlldi0SlS7prK4gw4+TUznFXd0k9fr2o5FqoQ4jj/iOmmsCtH1Ih3Q60JlWmDOzbB2oOM2SJo6jNLfuPgT0+tHZQp26GH3VyTkPW43C9piY0w/VFAmlzhmqsxgrJlpz6Mrh/xeAjTTsBGFlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jWPjvl2A; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744653793; x=1776189793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yuqhv70Qpdlh41BSvGFlFVdrjtED8FZobMK/ZVdtmRw=;
  b=jWPjvl2ANJrWGwnDVyadm2b2CaV4yI6w8SbFJ8T4GRL0iDeeh9CM9J1A
   R68d9UK3aXUMa7Ko5l1b+0IlfwSyOpghRL4aaylmt+1JbYhT5QgNwhV+8
   +AD59D6tg6NT+tWwVg7jMZOcDv+P4AU3PUF9PQrMqTv4WU2ZTYvrxuSe6
   o=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="288344776"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:03:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:3005]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 8731aede-ab58-43d1-809e-d3097ff60170; Mon, 14 Apr 2025 18:03:08 +0000 (UTC)
X-Farcaster-Flow-ID: 8731aede-ab58-43d1-809e-d3097ff60170
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:03:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:03:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <cratiu@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
	<syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] general protection fault in rtnl_create_link
Date: Mon, 14 Apr 2025 11:01:59 -0700
Message-ID: <20250414180257.24176-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414103727.0ea92049@kernel.org>
References: <20250414103727.0ea92049@kernel.org>
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

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 14 Apr 2025 10:37:27 -0700
> On Sun, 13 Apr 2025 19:30:46 -0700 Kuniyuki Iwashima wrote:
> > diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
> > index 5706835a660c..270e157a4a79 100644
> > --- a/include/net/netdev_lock.h
> > +++ b/include/net/netdev_lock.h
> > @@ -30,7 +30,8 @@ static inline bool netdev_need_ops_lock(const struct net_device *dev)
> >  	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
> >  
> >  #if IS_ENABLED(CONFIG_NET_SHAPER)
> > -	ret |= !!dev->netdev_ops->net_shaper_ops;
> > +	if (dev->netdev_ops)
> > +		ret |= !!dev->netdev_ops->net_shaper_ops;
> >  #endif
> 
> This is a bit surprising, we pretty much never validate if dev has ops.
> 
> I think we're guaranteed that IFF_UP will not be set if we just
> allocated the device, so we can remove the locks in rtnl_create_link()
> and to double confirm add a netdev_ops_assert_locked_or_invisible() 
> in netif_state_change() ?

Removing the lock from NEWLINK makes sense, but my concern
was NETDEV_CHANGE, which will requires more caution ?

commit 04efcee6ef8d0f01eef495db047e7216d6e6e38f
Author: Stanislav Fomichev <sdf@fomichev.me>
Date:   Fri Apr 4 09:11:22 2025 -0700

    net: hold instance lock during NETDEV_CHANGE

