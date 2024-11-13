Return-Path: <netdev+bounces-144555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69C9C7BB9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E725128319F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AD1204012;
	Wed, 13 Nov 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="khB17xxz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AB2200C90;
	Wed, 13 Nov 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524193; cv=none; b=dzArGpVG0qRRviL+GyWxur9K7ww+N3fDMzig5UHar4a6AnOdpZcopPW+17K/SvXz3uGMzXDFyRUkaB04UejDPjJ+GypYYYf3qynh11s29eqRlpSDkJAFbKny4zjE1cyY6EnJBG1nj0Pv5XyFaCHxm5kRGnTQCeHizwkhbuE6Nco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524193; c=relaxed/simple;
	bh=un+NX46uMYK+KsNv68izGxWUaJuUbYOpxd89O9S1nmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5mjqAjH1nux4lQ/PHwemrMdLool6zBpbp1OYndGnGGho4eui9LMVvNliBDukzMZ3rkRIIrvca8z9wkGmvau8cfDZcHp5KFu5oMliPrte6FR9PmpNwfOlbJzjMNqC5DwBVrWKJbYg2Y+NU7MUb/NFo4VKmU4/05N0cBTsXu5EPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=khB17xxz; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731524191; x=1763060191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=un+NX46uMYK+KsNv68izGxWUaJuUbYOpxd89O9S1nmY=;
  b=khB17xxzQ7fDDMlmR7i1xmQOSuTKF3vEOWWouIbefFA+jxfvt4b5T1bK
   GzRTXOM6RIchKidgwRDLIKOsdMc7slDvVqvGVgEaMIA9a5VkmBaoXvqKw
   gEEdta1YlJH/idV1+os01t+FM0pm1GwKsiYpv65QIAjmIVJdDNA8rxela
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,151,1728950400"; 
   d="scan'208";a="439549764"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 18:56:28 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:30814]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.96:2525] with esmtp (Farcaster)
 id 73d44386-eebc-4425-9e20-8bc91bca23f2; Wed, 13 Nov 2024 18:56:27 +0000 (UTC)
X-Farcaster-Flow-ID: 73d44386-eebc-4425-9e20-8bc91bca23f2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 13 Nov 2024 18:56:26 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 13 Nov 2024 18:56:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mengkanglai2@huawei.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<fengtao40@huawei.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <yanan@huawei.com>,
	<kuniyu@amazon.com>
Subject: Re: kernel tcp sockets stuck in FIN_WAIT1 after call tcp_close
Date: Wed, 13 Nov 2024 10:56:19 -0800
Message-ID: <20241113185619.54064-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <c08bd5378da647a2a4c16698125d180a@huawei.com>
References: <c08bd5378da647a2a4c16698125d180a@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: mengkanglai <mengkanglai2@huawei.com>
Date: Wed, 13 Nov 2024 12:40:34 +0000
> Hello, Eric:
> Commit 151c9c724d05 (tcp: properly terminate timers for kernel sockets)
> introduce inet_csk_clear_xmit_timers_sync in tcp_close.
> For kernel sockets it does not hold sk->sk_net_refcnt, if this is kernel
> tcp socket it will call tcp_send_fin in __tcp_close to send FIN packet
> to remotes server,

Just curious which subsystem the kernel socket is created by.

Recently, CIFS and sunrpc are (being) converted to hold net refcnt.

CIFS: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef7134c7fc48e1441b398e55a862232868a6f0a7
sunrpc: https://lore.kernel.org/netdev/20241112135434.803890-1-liujian56@huawei.com/

I remember RDS's listener does not hold refcnt but other client sockets
(SMC, RDS, MPTCP, CIFS, sunrpc) do.

I think all TCP kernel sockets should hold netns refcnt except for one
created at pernet_operations.init() hook like RDS.


> if this fin packet lost due to network faults, tcp should retransmit this
> fin packet, but tcp_timer stopped by inet_csk_clear_xmit_timers_sync.
> tcp sockets state will stuck in FIN_WAIT1 and never go away. I think
> it's not right.

