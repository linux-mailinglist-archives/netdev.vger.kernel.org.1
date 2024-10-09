Return-Path: <netdev+bounces-133972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60703997959
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC2D2842B3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFF41E3DCE;
	Wed,  9 Oct 2024 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Nt7guA5h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1836C149C4F
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518008; cv=none; b=Knl6ZTFI9uIBy8kWs0uVRVLxWk4dDpR38pAgpSYVM83suz5ogMWMMyhBW2ZBurQ3p5CDlnZVwiUkFWq9oJTVm8aVVqt6mM+LVVomh6MUhRMOwt043ksTfvlITD8jDyBJjUELyNPxb1XjloNt7mLzc0/1odjdwLnqaP7e1YDH+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518008; c=relaxed/simple;
	bh=Xr1oA3SKZB8xg5DuV/t1MIuMbUsOg7jGDZzNFibojQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDRkHT8axwWf9/HMrf1ML4mEmD3LxksVbWRFxCszDuHWDvfE0yb3Izk5MukwoI/KCJrTmhX74SbKqRZlxy5CiHRRhkHEJzJSUjqAobzqtsKw10Pc7/Tw8eBcI1ESbPIUve6m6fAsohLhkdhUFyRitSB7jd+06harSdZHCkse7eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Nt7guA5h; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728518007; x=1760054007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zv9d7o7HSVbkZhVs/A/Je3v1xNd8NbAvTxW7dNseq1Q=;
  b=Nt7guA5hgjB1leZuiPsDNpvSZkYB6xAklFR0BWetnF3Hwr3hdzU0O6Su
   xrbts2WYn78D8gsHZ6fhJ3KlnmSP9vR6Brv1HGq5cXp309zZmh3szYcje
   zez5MkypTUbBOGqWYlu3oRxgIjy2tYXVKmHjLyjutAOBenfM43LFUhzFe
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="32029272"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:53:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:10424]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id 9a1af36c-2bec-4cce-ab50-55b28d3657f6; Wed, 9 Oct 2024 23:53:24 +0000 (UTC)
X-Farcaster-Flow-ID: 9a1af36c-2bec-4cce-ab50-55b28d3657f6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:53:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:53:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<jiri@resnulli.us>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/5] ipv4: use READ_ONCE()/WRITE_ONCE() on net->ipv4.fib_seq
Date: Wed, 9 Oct 2024 16:53:17 -0700
Message-ID: <20241009235317.60726-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009184405.3752829-3-edumazet@google.com>
References: <20241009184405.3752829-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  9 Oct 2024 18:44:02 +0000
> Using RTNL to protect ops->fib_rules_seq reads seems a big hammer.
> 
> Writes are protected by RTNL.
> We can use READ_ONCE() when reading it.
> 
> Constify 'struct net' argument of fib4_rules_seq_read()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

