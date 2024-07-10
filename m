Return-Path: <netdev+bounces-110606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A1592D6D2
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEFB2810A7
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F5218FC93;
	Wed, 10 Jul 2024 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ESGdkA3Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B81189F54
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720630080; cv=none; b=q4xXDXLsFbBVgIkyKVqHBoSwBS4PT5Lj0Eu+CfgJbXZnCqD7+5MBKu4SerHM6sThzxhzf9gwblnnSHTrNVcoWVuHEj0VujxTJZ+Wizu2lc+KQHDlCa+j+b2K8Y65eXBhxoWwEhhXYQm68CFw0UFE+uogepxeWsz4+4zFVkd1s9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720630080; c=relaxed/simple;
	bh=RiCPr+tWg6vpr3zycp2rkAOQ3u/ZSnyNDx1+AHEcWMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ravePTn1kfcqIafu/L72yi4XqAp/djPZr73a92U9Gn6noY98rtEVhIAMMTwFqkxjFNcXUp8S88TKBXy9JceCmMGzkjmWUo4HfqtcgufUBNvK38KEVYZ0f9bwFCfCxLHBcLqoifY+P2BPpCu/RBy8H1PMgB41Kx0TSViFXWTR8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ESGdkA3Q; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720630079; x=1752166079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwacjsFj4vQ0goPNtUhs2YfiNLTdBry9WX0OZRJCji8=;
  b=ESGdkA3Qx+Y7Fdio02jHI3fJOHULSlhPzdlxjUeFCBtsiGJ3Tarf0W+V
   5oCTtUZPptKWpAmDd6KHK+3oxCRV7s1uo6witwq/5V4awUqYh6hgLq/3h
   WMoYrH9obcrliLxpXxy6SmvhjlhSLqLKe5bDzpKtsE0BR5uq83C3cqcsG
   E=;
X-IronPort-AV: E=Sophos;i="6.09,198,1716249600"; 
   d="scan'208";a="645130028"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:47:52 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:47392]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.52:2525] with esmtp (Farcaster)
 id e1b777d8-6fa9-4955-8f97-ef02cea444db; Wed, 10 Jul 2024 16:47:51 +0000 (UTC)
X-Farcaster-Flow-ID: e1b777d8-6fa9-4955-8f97-ef02cea444db
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 16:47:50 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 16:47:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <dima@arista.com>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 0/2] tcp: Make simultaneous connect() RFC-compliant.
Date: Wed, 10 Jul 2024 09:47:40 -0700
Message-ID: <20240710164740.85061-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240710014456.77159-1-kuniyu@amazon.com>
References: <20240710014456.77159-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Tue, 9 Jul 2024 18:44:55 -0700
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 9 Jul 2024 12:52:09 -0700
> > On Mon, 8 Jul 2024 11:08:50 -0700 Kuniyuki Iwashima wrote:
> > >   * Add patch 2
> > 
> > Hi Kuniyuki!
> > 
> > Looks like it also makes BPF CI fail. All of these:
> > https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-07-09--15-00&executor=gh-bpf-ci&pw-n=0
> > But it builds down to the reuseport test on various platforms.
> 
> Oh, thanks for catching!
> 
> It seems the test is using TFO, and somehow fastopen_rsk is cleared,
> but a packet is processed later in SYN_RECV state...

The test used MSG_FASTOPEN but TFO always failed due to lack of
proper configuration, this should be fixed.

IP 127.0.0.1.36477 > 127.0.0.1.53357: Flags [S], seq 2263448885:2263448893, win 65495, options [mss 65495,sackOK,TS val 2871616407 ecr 0,nop,wscale 7], length 8
IP 127.0.0.1.53357 > 127.0.0.1.36477: Flags [S.], seq 3767023264, ack 2263448886, win 65483, options [mss 65495,sackOK,TS val 2871616407 ecr 2871616407,nop,wscale 7], length 0

But this wasn't related, just red-herring.

I just missed that the ACK of 3WHS was also processed by newly created
SYN_RECV sk in tcp_rcv_state_process() called from tcp_child_process().

So, (sk->sk_state == TCP_SYN_RECV && !tp->fastopen_rsk) cannot deduce
the cross SYN+ACK case.

We need to use (sk->sk_state == TCP_SYN_RECV && sk->sk_socket).

Will post v3.

Thanks!

