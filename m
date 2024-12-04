Return-Path: <netdev+bounces-149063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F242A9E3F25
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0AF16143E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6B013D26B;
	Wed,  4 Dec 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="h5r1BFP/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7F156962
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328019; cv=none; b=u7WZDJyNulQBohQuY5rgv6nLh5698e1xZHV8aQaGUr0jNNihnIp8RTQAhvM2JNOb2vxF8h3ugAg6UfCNZ/pELQUk6X//s1Esl3N7budwD35IOpfD0zo5Wafa27bdX44ELcirSIXay+vDOzKCQL2vm++Zfh7vLSSVsCa2Z36qmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328019; c=relaxed/simple;
	bh=jW2bNWS5I+4ucWth3dhvGEKgEGLxS9qVU1U6O24S8DE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmjEv0dPiyL25A8dZjaHmk8qzpbO8QXJxw/1u3DKRDkSaqF/OJe2Ow9QHOZKZq1+mlVlV+CdZiN9b82bzNYdx150gUfB/jqxAXE46Vg1QtxadMRm3O0JtGf6JzrnQl3KCq3sZ1d054ldI8mo97ZvxBuIHCueQQYcokSBNU1no8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=h5r1BFP/; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733328018; x=1764864018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4eigiZYZAgY3jn/dum0w3L5TOD/6rot4USCW9w14mUs=;
  b=h5r1BFP/jXlCI4pnxNjqh3U+Xnp/dCffCfSE1/p8Cc0TchdmCIcA/Dn6
   Yjy0fFqr9Spn0A30uek5/sXPKziXSfuQfAauV8qiSEcJA5ILMqz0iC8q4
   rg2GrCBukc7fXyLoczKNxu7JbXPQK6/+hvudL+tSTPRO20dg13654O8W5
   I=;
X-IronPort-AV: E=Sophos;i="6.12,207,1728950400"; 
   d="scan'208";a="153076506"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 16:00:16 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:29250]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.41:2525] with esmtp (Farcaster)
 id 6f736c2a-0f51-49c7-af66-b0158fb507bf; Wed, 4 Dec 2024 16:00:15 +0000 (UTC)
X-Farcaster-Flow-ID: 6f736c2a-0f51-49c7-af66-b0158fb507bf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 4 Dec 2024 16:00:15 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.3.161) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 4 Dec 2024 16:00:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <ebiederm@xmission.com>, <jmaloy@redhat.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>,
	<tipc-discussion@lists.sourceforge.net>, <ying.xue@windriver.com>
Subject: Re: [PATCH v2 net] tipc: Fix use-after-free of kernel socket in cleanup_bearer().
Date: Thu, 5 Dec 2024 01:00:06 +0900
Message-ID: <20241204160006.61496-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iJ-GfHU=sLWJiuqNcoH+AnBtj9dSxpXHjqbAS_VZ8fzAw@mail.gmail.com>
References: <CANn89iJ-GfHU=sLWJiuqNcoH+AnBtj9dSxpXHjqbAS_VZ8fzAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 16:01:10 +0100
> > diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> > index 439f75539977..b7e25e7e9933 100644
> > --- a/net/tipc/udp_media.c
> > +++ b/net/tipc/udp_media.c
> > @@ -814,10 +814,10 @@ static void cleanup_bearer(struct work_struct *work)
> >                 kfree_rcu(rcast, rcu);
> >         }
> >
> > -       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
> >         dst_cache_destroy(&ub->rcast.dst_cache);
> >         udp_tunnel_sock_release(ub->ubsock);
> >         synchronize_net();
> > +       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
> 
> Note that ub->ubsock->sk is NULL at this point.
> 
> I am testing the following fix, does it make sense to you ?

Ah yes, net needs to be cached before sock_release().

Thanks for catching this !


> 
> diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> index b7e25e7e9933b69aa6a3364e3287c358b7ac9421..1d359de9dd6ad7ff60b6b93f620ff6783e385106
> 100644
> --- a/net/tipc/udp_media.c
> +++ b/net/tipc/udp_media.c
> @@ -807,6 +807,7 @@ static void cleanup_bearer(struct work_struct *work)
>  {
>         struct udp_bearer *ub = container_of(work, struct udp_bearer, work);
>         struct udp_replicast *rcast, *tmp;
> +       struct tipc_net *tn;
> 
>         list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
>                 dst_cache_destroy(&rcast->dst_cache);
> @@ -814,10 +815,14 @@ static void cleanup_bearer(struct work_struct *work)
>                 kfree_rcu(rcast, rcu);
>         }
> 
> +       tn = tipc_net(sock_net(ub->ubsock->sk));
> +
>         dst_cache_destroy(&ub->rcast.dst_cache);
>         udp_tunnel_sock_release(ub->ubsock);
> +
> +       /* Note: we could use a call_rcu() to avoid another synchronize_net() */
>         synchronize_net();
> -       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
> +       atomic_dec(&tn->wq_count);
>         kfree(ub);
>  }

