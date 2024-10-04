Return-Path: <netdev+bounces-132233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2D99910ED
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD3CB23D28
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF3412C54B;
	Fri,  4 Oct 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ogIm5fT+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFE139579
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074743; cv=none; b=uPRKslAI3O31w1wqFN8x2Lu7q8D12FL5OmM0TS1mqjXlOfsiXlcRfLAKsEWzsDH1lvnQB3G/xSATGCqy3ET5MOCS7LsuFjEKJ7lEEL0AaPstIpG1QwIljuL+Ug7xemqsY2D4LMt5CQ9x4B2f6kgpIIKFrrKQwWgoPyhgerY/gco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074743; c=relaxed/simple;
	bh=6ICmoPBD+Vete1YK7ovV1pleNnuyeAESsDur5j/iK5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIcT3HZbj3tDtQOm9T2Zi8dgkqQcHnuvx4JN44Y5wipCyRWDW9wjzsgD5U45xr4hGNfKZB7gWl3xMVFTLF1+q4e9ko+Op5dz25luAFPnpfF38dObXLgwTXVEPYxt7g+BNc1E6dotKcYyyxE6/WCioJHfcinTjeGN6d+RSFh0rMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ogIm5fT+; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728074742; x=1759610742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+m63GeCFkvLU2b9BeWWdLhd76/izXciDvImy8ghkL9A=;
  b=ogIm5fT+OjEU43JQAn888/U5QJU4ZprAaWcboq4p7G3gAxAhoF8nA/nN
   jjIThjVb2zfVLPGNGijyR1QrH6wONfP/U9aaaFEEXOD8+rJQQMihlzKUL
   58c54mHJbC0WBF8EpCpF6dvCoQBLwMwzEspuRrs38O04pO8yGVU3dKkMV
   k=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="663814088"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 20:45:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:48529]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.107:2525] with esmtp (Farcaster)
 id 75738f66-f47f-4407-9156-4f70c5089dac; Fri, 4 Oct 2024 20:45:37 +0000 (UTC)
X-Farcaster-Flow-ID: 75738f66-f47f-4407-9156-4f70c5089dac
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 20:45:36 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 20:45:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 2/4] rtnetlink: Add per-netns RTNL.
Date: Fri, 4 Oct 2024 13:45:26 -0700
Message-ID: <20241004204526.68765-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004132145.7fd208e9@kernel.org>
References: <20241004132145.7fd208e9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 4 Oct 2024 13:21:45 -0700
> On Wed, 2 Oct 2024 08:12:38 -0700 Kuniyuki Iwashima wrote:
> > +#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
> > +void __rtnl_net_lock(struct net *net);
> > +void __rtnl_net_unlock(struct net *net);
> > +void rtnl_net_lock(struct net *net);
> > +void rtnl_net_unlock(struct net *net);
> > +int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b);
> > +#else
> > +#define __rtnl_net_lock(net)
> > +#define __rtnl_net_unlock(net)
> > +#define rtnl_net_lock(net) rtnl_lock()
> > +#define rtnl_net_unlock(net) rtnl_unlock()
> 
> Let's make sure net is always evaluated?
> At the very least make sure the preprocessor doesn't eat it completely
> otherwise we may end up with config-dependent "unused variable"
> warnings down the line.

Sure, what comes to mind is void casting, which I guess is old-school
style ?  Do you have any other idea or is this acceptable ?

#define __rtnl_net_lock(net) (void)(net)
#define __rtnl_net_unlock(net) (void)(net)
#define rtnl_net_lock(net)	\
	do {			\
		(void)(net);	\
		rtnl_lock();	\
	} while (0)
#define rtnl_net_unlock(net)	\
	do {			\
		(void)(net);	\
		rtnl_unlock();	\
	} while (0)

