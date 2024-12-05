Return-Path: <netdev+bounces-149190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D029E4B85
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 01:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5907C1880371
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 00:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CCE17543;
	Thu,  5 Dec 2024 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Jjzv3WYn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6187B653
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359869; cv=none; b=nSkeQBPiUh22RS3ntXLaT6KmdU53NnvOGQ4/8zUpNH0ETmMMZcsccs/+6IBr/PMQZpJLH+0JPHuY7BVS4kf5sCjvhBOn8mmLyZIFhwj+Nq6Wo7OXR+Q2fO4m2qDhXqKp7SGeWJhz+fTDoul402Hkz5ge6yv5g+QviGl7bMdzwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359869; c=relaxed/simple;
	bh=0A1C2wOceygIIGt7kCi2IHb+cVzwzRCHz7cXIlWWEKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnlDSUMqYmBeWLPlY9cFPpLkT+LsIzxlBCQFkyY86C9+6N7lcpiVtzx7UcvDGoOwBHCYShAki1v15aLfEkM3aIcCQhlMKuJgt38/9uujbyEKQCPze6qIMJtZHcTAiMoFqAXk6mborJPX9B1AfOOIegsthxVjWsovQaLBCW9uChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Jjzv3WYn; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733359868; x=1764895868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pAp3O1tgutBaN3j+3iEG0vIx9SPoUXtb7+qBZ1enwcw=;
  b=Jjzv3WYnCxH5rf2O+tG6uH9cGkQuucsQF36dNWiSgviq5zib9HR6/IOu
   SuP2/xhRVkvs6trImxLX1Ha9S75RD56p1rLlL4ylwhR3zDOVLmQVj1oGP
   UyNIx7NqAdDe+NOB3zXVRaLNu1M284wGNizNirmxfQ8vwdao6Lys8Qul1
   s=;
X-IronPort-AV: E=Sophos;i="6.12,209,1728950400"; 
   d="scan'208";a="150469758"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:47:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:10786]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.230:2525] with esmtp (Farcaster)
 id 35b4a92f-92ef-403c-9249-437585cc3927; Thu, 5 Dec 2024 00:47:28 +0000 (UTC)
X-Farcaster-Flow-ID: 35b4a92f-92ef-403c-9249-437585cc3927
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Dec 2024 00:47:28 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.3.161) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Dec 2024 00:47:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <ebiederm@xmission.com>, <jmaloy@redhat.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>,
	<tipc-discussion@lists.sourceforge.net>, <ying.xue@windriver.com>
Subject: Re: [PATCH v2 net] tipc: Fix use-after-free of kernel socket in cleanup_bearer().
Date: Thu, 5 Dec 2024 09:47:20 +0900
Message-ID: <20241205004720.92043-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iLzMCgkKLGjnyZ8YMd4ft81sfQyueC52TROuVx0ua0qYg@mail.gmail.com>
References: <CANn89iLzMCgkKLGjnyZ8YMd4ft81sfQyueC52TROuVx0ua0qYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 17:09:40 +0100
> On Wed, Dec 4, 2024 at 5:00 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Wed, 4 Dec 2024 16:01:10 +0100
> > > > diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> > > > index 439f75539977..b7e25e7e9933 100644
> > > > --- a/net/tipc/udp_media.c
> > > > +++ b/net/tipc/udp_media.c
> > > > @@ -814,10 +814,10 @@ static void cleanup_bearer(struct work_struct *work)
> > > >                 kfree_rcu(rcast, rcu);
> > > >         }
> > > >
> > > > -       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
> > > >         dst_cache_destroy(&ub->rcast.dst_cache);
> > > >         udp_tunnel_sock_release(ub->ubsock);
> > > >         synchronize_net();
> > > > +       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
> > >
> > > Note that ub->ubsock->sk is NULL at this point.
> > >
> > > I am testing the following fix, does it make sense to you ?
> >
> > Ah yes, net needs to be cached before sock_release().
> >
> > Thanks for catching this !
> >
> 
> 
> BTW the following construct in tipc_exit_net()
> 
> while (atomic_read(&tn->wq_count))
>      cond_resched();
> 
> should really be replaced by a completion or something like that :/

Agreed.

Also, synchronize_net() in cleanup_bearer() looks unnecessary
given udp_tunnel_sock_release() sets NULL to sk_user_data and
calls synchronize_rcu(), and tipc_udp_recv() doesn't work then.

