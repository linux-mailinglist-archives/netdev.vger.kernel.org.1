Return-Path: <netdev+bounces-189905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602DAB475B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966F37AD404
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5872026560C;
	Mon, 12 May 2025 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jR8OMbmN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77617186A
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747089466; cv=none; b=IjmIc3hMLnYNxmOtSrWTzD9GlYaPJDpIEyer73o5hEI8MNIxifJc8T1sUgbprJVJjZ8nWzrc5o1OHHbUVqYyOJC2PsqPtrWzFWodtOQ5ho0eSkbHKuWNqt1S+k9TWiWDnowlRJKv2N8CE8obvzUKK8NjQsFjifKYM98n5EGWOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747089466; c=relaxed/simple;
	bh=kCZz7Dt/5bahgqStKl8wvJ63Iolyfl7Ls3R8Nop0qVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUS7QyoGIJqzYtCoZGhJGUvzyDasr1KtFz3RhlGpe/x5Vn4rf3ZMKEe7Msc5g63IrTsTB+1IPqPQRBmbVR8rdXjHnof7RfPbPPTxXJ8DV3RS8lyiaffOJ8/CY8D9xxeOcyXm05Dr+yiwmGAhv89SpLxBVue7kCtm72gGwnFYZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jR8OMbmN; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747089464; x=1778625464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0w1JQiWQb3coK15mFV2B19SaNhTz6Y8mrn2QAdFlM/I=;
  b=jR8OMbmNzPqS26ug+ZAXTBtZljuFySYk2tBbv7ubcMZUraifcbwG2ez2
   Cl1JuECEeSyeLZuHYw0rBwdZ6nQMaooD6opqRVxEcjKyeQ6c/3NkYVJD8
   rOsxSPw/5b87Oa5eAI5SXDLuK/p7AJtCBQEqSJsE23+EcrfpcbWVSiw89
   CqPC790HX0mKa8RjLqyfzuz+QCtFi+ICuKfJIvMUUs/ORn6jRO5H2lHHk
   GVC1s344GhO1by67pKHaYyHvXHP1CU6eVEv+h3izsigMflbBl7vCMQ942
   pD/UniF5oo0ucAq1A7Yy1yY+EgwzTB+e9Fh1QbdLQH9K5nmGhhf/9ZDq9
   w==;
X-IronPort-AV: E=Sophos;i="6.15,283,1739836800"; 
   d="scan'208";a="497856924"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 22:37:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:32385]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.161:2525] with esmtp (Farcaster)
 id 2c255045-ff80-4405-8bb2-bedaab2d9576; Mon, 12 May 2025 22:37:39 +0000 (UTC)
X-Farcaster-Flow-ID: 2c255045-ff80-4405-8bb2-bedaab2d9576
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 12 May 2025 22:37:39 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 12 May 2025 22:37:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v2 net-next 7/9] af_unix: Inherit sk_flags at connect().
Date: Mon, 12 May 2025 15:34:55 -0700
Message-ID: <20250512223729.58686-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68224e25b13ac_eb9592943d@willemb.c.googlers.com.notmuch>
References: <68224e25b13ac_eb9592943d@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 12 May 2025 15:38:13 -0400
> Kuniyuki Iwashima wrote:
> > For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
> > are inherited from the parent listen()ing socket.
> > 
> > Currently, this inheritance happens at accept(), because these
> > attributes were stored in sk->sk_socket->flags and the struct socket
> > is not allocated until accept().
> > 
> > This leads to unintentional behaviour.
> > 
> > When a peer sends data to an embryo socket in the accept() queue,
> > unix_maybe_add_creds() embeds credentials into the skb, even if
> > neither the peer nor the listener has enabled these options.
> > 
> > If the option is enabled, the embryo socket receives the ancillary
> > data after accept().  If not, the data is silently discarded.
> > 
> > This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but not
> > for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file descriptor is
> > sent, it’s game over.
> 
> Should this be a fix to net then?

Regarding SO_PASS{CRED,PIDFD,SEC}, this patch is a small optimisation
to save unnecessary get_pid() etc, like 16e572626961

And, SO_PASSRIGHTS is not yet added here, so this is not a fix.

Maybe I should have clarified like "this works but would not for SO_PASSRIGHTS".


> 
> It depends on the move of this one bit from socket to sock. So is not
> a stand-alone patch. But does not need all of the previous cleanup
> patches if needs to be backportable.
> 
> > 
> > To avoid this, we will need to preserve SOCK_PASSRIGHTS even on embryo
> > sockets.
> > 
> > A recent change made it possible to access the parent's flags in
> > sendmsg() via unix_sk(other)->listener->sk->sk_socket->flags, but
> > this introduces an unnecessary condition that is irrelevant for
> > most sockets, accept()ed sockets and clients.
> 
> What is this condition and how is it irrelevant? A constraint on the
> kernel having the recent change? I.e., not backportable?

Commit aed6ecef55d7 ("af_unix: Save listener for embryo socket.") is
added for a new GC but is a standalone patch.

If we want to use the listener's flags, the condition will be like...

	if (UNIXCB(skb).fp &&
	    ((other->sk_socket && other->sk_socket->sk_flags & SOCK_PASSRIGHTS) ||
	     (!other->sk_socket && unix_sk(other)->listener->sk->sk_socket->sk_flags && SOCK_PASSRIGHTS)))

