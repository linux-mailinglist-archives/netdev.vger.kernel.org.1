Return-Path: <netdev+bounces-189968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 783D6AB4A14
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 05:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F1A1B422C0
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3F01A238D;
	Tue, 13 May 2025 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="k0qsrK/x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F544C63
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106426; cv=none; b=M6pD/wuUGIylrAVTqCpNLlAsOKWAWBfLVG7HDNiQNo8dmuHewzldjwQzKuDJjq3uHiGW8xMEBpukvvYPeDsgVgcwt/7AYEtaZer6L8r9QNd654ttxqZ4kIJ5y6CrjlkQxLXDD6vNz793xQ2ldv7IsfO2CkcGXE2aEGkDU582VW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106426; c=relaxed/simple;
	bh=S9213ov5xhJdgPRHrpI48j9SFGCtm1w+FQlA46U/YU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPOTh1RRaZp+STvqG89O/3jftsUObmxxfLnrZx0yLPgutAiqdu9QNswFU4ypmlniaQa+/bzDgMfnRFs3YL/ycT5OVVOM4lHc45ckHf+wEAPDoNDDnao6Ndn/m1s6K7uRLiPkU3o291asw4t4o4t8YL4/TVmtX94FOI7rma2SA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=k0qsrK/x; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747106424; x=1778642424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZrBILqJwTKMbl2YY3Wc5tJ1lY+mYSLfgVG5F2Bz2us=;
  b=k0qsrK/xguya08XJfOZnV+wAOm/J+wkIalQxmlz3ZQX6M+hohLmelL4x
   89NqyfT/OsIEeO3jRK1c7EJvejxuK7+f9aeYAvBIao+0o40JW9Aqtu0rM
   BWhg9q/hXX7eXDR4aazXCWW6sAqOcDrMgv2JCPAfeLNjQOdgA9fUzypR6
   CyhAG4yF5S9N7QbtQ2dmf2aAah0QMuqpKk2gBv2ABEEdiRKSUGv75TYlB
   DBq7pmsdL/47rkggMQYaWWIsuhGS6S/KNC8UeLbyrDqk+bQw56AfP+WhQ
   5fKGhGo6RUkGyQRpQyKpqncRhmxRyf5oVpF/EVM9Kw5XZBRCGHiaxRyt8
   A==;
X-IronPort-AV: E=Sophos;i="6.15,284,1739836800"; 
   d="scan'208";a="199782931"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:20:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:15827]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.68:2525] with esmtp (Farcaster)
 id 1788cebf-886f-4ea8-bd19-9f13aff455f1; Tue, 13 May 2025 03:20:22 +0000 (UTC)
X-Farcaster-Flow-ID: 1788cebf-886f-4ea8-bd19-9f13aff455f1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 03:20:22 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 03:20:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v2 net-next 7/9] af_unix: Inherit sk_flags at connect().
Date: Mon, 12 May 2025 20:20:07 -0700
Message-ID: <20250513032012.95677-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6822b2e9e484d_104f1029457@willemb.c.googlers.com.notmuch>
References: <6822b2e9e484d_104f1029457@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 12 May 2025 22:48:09 -0400
> Kuniyuki Iwashima wrote:
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Date: Mon, 12 May 2025 15:38:13 -0400
> > > Kuniyuki Iwashima wrote:
> > > > For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
> > > > are inherited from the parent listen()ing socket.
> > > > 
> > > > Currently, this inheritance happens at accept(), because these
> > > > attributes were stored in sk->sk_socket->flags and the struct socket
> > > > is not allocated until accept().
> > > > 
> > > > This leads to unintentional behaviour.
> > > > 
> > > > When a peer sends data to an embryo socket in the accept() queue,
> > > > unix_maybe_add_creds() embeds credentials into the skb, even if
> > > > neither the peer nor the listener has enabled these options.
> > > > 
> > > > If the option is enabled, the embryo socket receives the ancillary
> > > > data after accept().  If not, the data is silently discarded.
> > > > 
> > > > This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but not
> > > > for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file descriptor is
> > > > sent, it’s game over.
> > > 
> > > Should this be a fix to net then?
> > 
> > Regarding SO_PASS{CRED,PIDFD,SEC}, this patch is a small optimisation
> > to save unnecessary get_pid() etc, like 16e572626961
> > 
> > And, SO_PASSRIGHTS is not yet added here, so this is not a fix.
> 
> Ack, thanks.
>  
> > Maybe I should have clarified like "this works but would not for SO_PASSRIGHTS".
> > 
> > 
> > > 
> > > It depends on the move of this one bit from socket to sock. So is not
> > > a stand-alone patch. But does not need all of the previous cleanup
> > > patches if needs to be backportable.
> > > 
> > > > 
> > > > To avoid this, we will need to preserve SOCK_PASSRIGHTS even on embryo
> > > > sockets.
> > > > 
> > > > A recent change made it possible to access the parent's flags in
> > > > sendmsg() via unix_sk(other)->listener->sk->sk_socket->flags, but
> > > > this introduces an unnecessary condition that is irrelevant for
> > > > most sockets, accept()ed sockets and clients.
> > > 
> > > What is this condition and how is it irrelevant? A constraint on the
> > > kernel having the recent change? I.e., not backportable?
> > 
> > Commit aed6ecef55d7 ("af_unix: Save listener for embryo socket.") is
> > added for a new GC but is a standalone patch.
> > 
> > If we want to use the listener's flags, the condition will be like...
> > 
> > 	if (UNIXCB(skb).fp &&
> > 	    ((other->sk_socket && other->sk_socket->sk_flags & SOCK_PASSRIGHTS) ||
> > 	     (!other->sk_socket && unix_sk(other)->listener->sk->sk_socket->sk_flags && SOCK_PASSRIGHTS)))
> 
> No need to change as this stays as net-next.
> 
> Might we helpful to replace "a recent commit" with the full commit reference.

Will do.

Thanks!

