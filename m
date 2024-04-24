Return-Path: <netdev+bounces-90738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52BA8AFDF7
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 03:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715541F23CC2
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 01:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1D6139;
	Wed, 24 Apr 2024 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LO1Y7OKI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76B200BF
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922783; cv=none; b=FHukxbR1ZiEsudn/84m/f1d9Frg0EJLllxzaPPMeovtHbW0nCZ1ISb9fALmvLm2eQazmMIo4tuEu9C7hR7MRYMopkZC0KbQ+goWjX0yuxtYhfz0ivayHsdGFVOyfi7HiWXz7lrQW882VHmUBcRtD7pRVZAli5hqSwvFPO9b6Af0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922783; c=relaxed/simple;
	bh=MYkH/CFfcy5QwaDUQ7q0RYMcPcb17Bl5DJRAIeYM6zY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOcJOjNX+yeCSD9mXyFie2eNsyLvAIBTAaHr9GrhIEsDL7+LLcgfT6jUuJCHwm23RqvZ+SdLXANlSA/lrEOhZfvmseYz8JFYr0eHklCDQWLPdwnh5knkKDMi6HK7x1aI0l0x8080N8armBXjvIXCcmKvwEiBRuMXQ8v9gk3nz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LO1Y7OKI; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713922782; x=1745458782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehAcdT1HxEs7NOlZ7U/XAwwhZn8XbLrfbeVSobntrPA=;
  b=LO1Y7OKIaDQLr1pz2ouierLDWRUIN1Uj2ZQYZpa2MMOGfnzEVnLsHl/s
   WT5uRoEViYt2y/FoN6mLgOZx2chD4FlWDWqp5WLghuUVKz2xEiTGhzKSP
   RUg8NhRCn7J9k9PMk6tTDmwHcUUZZUiso8ICMoH7eELWrJip2kPd+qsis
   U=;
X-IronPort-AV: E=Sophos;i="6.07,222,1708387200"; 
   d="scan'208";a="414215744"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 01:39:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:12874]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.56:2525] with esmtp (Farcaster)
 id 96922871-7aec-4779-90f0-2002d2c89d79; Wed, 24 Apr 2024 01:39:35 +0000 (UTC)
X-Farcaster-Flow-ID: 96922871-7aec-4779-90f0-2002d2c89d79
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 01:39:31 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 01:39:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net v3] af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
Date: Tue, 23 Apr 2024 18:39:21 -0700
Message-ID: <20240424013921.16819-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <5a2dc473-5b99-4798-8f23-c5316610af8e@oracle.com>
References: <5a2dc473-5b99-4798-8f23-c5316610af8e@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <rao.shoaib@oracle.com>
Date: Tue, 23 Apr 2024 18:18:24 -0700
> On 4/23/24 17:15, Kuniyuki Iwashima wrote:
> > From: Rao Shoaib <Rao.Shoaib@oracle.com>
> > Date: Mon, 22 Apr 2024 02:25:03 -0700
> >> Read with MSG_PEEK flag loops if the first byte to read is an OOB byte.
> >> commit 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")
> >> addresses the loop issue but does not address the issue that no data
> >> beyond OOB byte can be read.
> >>
> >>>>> from socket import *
> >>>>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
> >>>>> c1.send(b'a', MSG_OOB)
> >> 1
> >>>>> c1.send(b'b')
> >> 1
> >>>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> >> b'b'
> >>
> >> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> >> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
> >> ---
> >>  net/unix/af_unix.c | 26 ++++++++++++++------------
> >>  1 file changed, 14 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> index 9a6ad5974dff..ed5f70735435 100644
> >> --- a/net/unix/af_unix.c
> >> +++ b/net/unix/af_unix.c
> >> @@ -2658,19 +2658,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >>  		if (skb == u->oob_skb) {
> >>  			if (copied) {
> >>  				skb = NULL;
> >> -			} else if (sock_flag(sk, SOCK_URGINLINE)) {
> >> -				if (!(flags & MSG_PEEK)) {
> >> +			} else if (!(flags & MSG_PEEK)) {
> >> +				if (sock_flag(sk, SOCK_URGINLINE)) {
> >>  					WRITE_ONCE(u->oob_skb, NULL);
> >>  					consume_skb(skb);
> >> +				} else {
> >> +					skb_unlink(skb, &sk->sk_receive_queue);
> >> +					WRITE_ONCE(u->oob_skb, NULL);
> >> +					if (!WARN_ON_ONCE(skb_unref(skb)))
> >> +						kfree_skb(skb);
> >> +					skb = skb_peek(&sk->sk_receive_queue);
> > 
> > I added a comment about this case.
> 
> OK. I will sync up.
> > 
> > 
> >>  				}
> >> -			} else if (flags & MSG_PEEK) {
> >> -				skb = NULL;
> >> -			} else {
> >> -				skb_unlink(skb, &sk->sk_receive_queue);
> >> -				WRITE_ONCE(u->oob_skb, NULL);
> >> -				if (!WARN_ON_ONCE(skb_unref(skb)))
> >> -					kfree_skb(skb);
> >> -				skb = skb_peek(&sk->sk_receive_queue);
> >> +			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
> >> +				skb = skb_peek_next(skb, &sk->sk_receive_queue);
> >>  			}
> >>  		}
> >>  	}
> >> @@ -2747,9 +2747,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
> >>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> >>  		if (skb) {
> >>  			skb = manage_oob(skb, sk, flags, copied);
> >> -			if (!skb && copied) {
> >> +			if (!skb) {
> >>  				unix_state_unlock(sk);
> >> -				break;
> >> +				if (copied || (flags & MSG_PEEK))
> >> +					break;
> >> +				goto redo;
> > 
> > Here, copied == 0 && !(flags & MSG_PEEK) && skb == NULL, so it means
> > skb_peek(&sk->sk_receive_queue) above returned NULL.  Then, we need
> > not jump to the redo label, where we call the same skb_peek().
> > 
> > Instead, we can just fall through the if (!skb) clause below.
> > 
> > Thanks!
> 
> Yes that makes sense. I will submit a new version with the jump to redo
> removed.

If skb_peek_next() returns NULL, should it also fall down to the
!skb case ?

TCP is blocked in the situation.

So, I think this hunk in unix_stream_read_generic() is not needed.

---8<---
>>> from socket import *
>>> 
>>> s = socket()
>>> s.listen()
>>> 
>>> c1 = socket()
>>> c1.connect(s.getsockname())
>>> c2, _ = s.accept()
>>> 
>>> c1.send(b'h', MSG_OOB)
1
>>> c2.recv(5, MSG_PEEK)
^C
---8<---

