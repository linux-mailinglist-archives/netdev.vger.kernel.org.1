Return-Path: <netdev+bounces-151791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36D39F0E1D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668511885087
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02B31E049F;
	Fri, 13 Dec 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PFnJBBZZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C61E1C37
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098094; cv=none; b=QC/4OUVqiY28keMx6bYtDb8kOE1ERNQtlNMTgSXI5vqDZLrUQCkUa8bugOYTTFNox2L77Z0p6GcYlI5UG/DQvE/r7zHBKJ62u8FQJe+iuP1Zr60K9kmUwmch2OqYzfRjRoDTJJHcodPUYCGNUGW7LChqyPRzuze/mWh3C77Mdjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098094; c=relaxed/simple;
	bh=HxzpEOnlJ7Z0QmpO1DnwpvgemPh3gjvb1cg+7HsdmMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3QPmWh4A3eeviRkV0Bh+fU9HuBRI/rf4FrKy7Igr/6x+m2S0giuJ+AcpDIlTMik9X++G0cveFNaSv3tfvHowPVwMUfCNVrjeoOeDTAbwFVpF+35Ts/wiQKln1WU/S2gpAPls80Od330CQmOJ3s02I0TefefjXPExhOk8EHvEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PFnJBBZZ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734098093; x=1765634093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+UttdR5g+ry1dCtKropfWltMziFWRm2OR+TgbolmF8w=;
  b=PFnJBBZZLOWH4Syt2PdPJFXZ0+rTNjqCEh0rDpdGoyZ0Xx2vgrgu6+IE
   FwMc6/syl9f/QLoirJpYP6I4KhgxeS2wzBnr3oOmIwn9kHDXn+tZKDAa9
   EJqHHFPiojVfhZhYuYqkB1fLZiKWWc2ABxqRWX36cbaFX7UfIWq9E7rc4
   I=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="155611601"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 13:54:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:46043]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.231:2525] with esmtp (Farcaster)
 id be889ca0-cdcf-4039-a533-02a48364037b; Fri, 13 Dec 2024 13:54:50 +0000 (UTC)
X-Farcaster-Flow-ID: be889ca0-cdcf-4039-a533-02a48364037b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 13:54:50 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 13:54:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <wenjia@linux.ibm.com>
CC: <alibuda@linux.alibaba.com>, <allison.henderson@oracle.com>,
	<chuck.lever@oracle.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jaka@linux.ibm.com>, <jlayton@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<matttbe@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sfrench@samba.org>
Subject: Re: [PATCH v3 net-next 11/15] socket: Remove kernel socket conversion.
Date: Fri, 13 Dec 2024 22:54:37 +0900
Message-ID: <20241213135437.44216-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <919d9910-a405-40f0-ad0b-fa3e8b908013@linux.ibm.com>
References: <919d9910-a405-40f0-ad0b-fa3e8b908013@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Wenjia Zhang <wenjia@linux.ibm.com>
Date: Fri, 13 Dec 2024 14:45:20 +0100
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index 6e93f188a908..7b0de80b3aca 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -3310,25 +3310,8 @@ static const struct proto_ops smc_sock_ops = {
> >   
> >   int smc_create_clcsk(struct net *net, struct sock *sk, int family)
> >   {
> > -	struct smc_sock *smc = smc_sk(sk);
> > -	int rc;
> > -
> > -	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
> > -			      &smc->clcsock);
> > -	if (rc)
> > -		return rc;
> > -
> > -	/* smc_clcsock_release() does not wait smc->clcsock->sk's
> > -	 * destruction;  its sk_state might not be TCP_CLOSE after
> > -	 * smc->sk is close()d, and TCP timers can be fired later,
> > -	 * which need net ref.
> > -	 */
> > -	sk = smc->clcsock->sk;
> > -	__netns_tracker_free(net, &sk->ns_tracker, false);
> > -	sk->sk_net_refcnt = 1;
> > -	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> > -	sock_inuse_add(net, 1);
> I don't think this line shoud be removed. Otherwise, the popurse here to 
> manage the per namespace statistics in the case of network namespace 
> isolation would be lost.

Now it's counted in sk_alloc().

sock_create_net() below passes hold_net=true to sk_alloc() and if
sk->sk_netns_refcnt (== hold_net) is true, sock_inuse_add() is
called there.

See patch 9 and 10:
https://lore.kernel.org/netdev/20241213092152.14057-10-kuniyu@amazon.com/
https://lore.kernel.org/netdev/20241213092152.14057-11-kuniyu@amazon.com/


> @D. Wythe, could you please check it again? Maybe you have some good 
> testing on this case.
> 
> > -	return 0;
> > +	return sock_create_net(net, family, SOCK_STREAM, IPPROTO_TCP,
> > +			       &smc_sk(sk)->clcsock);
> >   }

