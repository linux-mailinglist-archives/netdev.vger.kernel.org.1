Return-Path: <netdev+bounces-127153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFADC974630
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AE41F26D22
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 22:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1C91AC426;
	Tue, 10 Sep 2024 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="akL3JuPZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC81ABEC9;
	Tue, 10 Sep 2024 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726009176; cv=none; b=AnQiNQxVnPuIM1SVT/JkwZ6v+kOceM4+UtLY/vDf0laGVniK6GvL4Nb9c/i24dmMOeK7W2pc3hzYl1N8YvXgl7QSMK9n8L0sBABUy+1rjRC3nIyBN5q2ZgkdaMVP2KKyCTG2zXRSjZg/VkL9TM5pgRYEOlDplwEu7YHI7pbGzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726009176; c=relaxed/simple;
	bh=QUzpux5lnYnn+c7pRLdFYUnkVr9E8BaYoOh/q/rf+Jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzvaDBSq5cRiQ3GcIRBBWdIPgv4vQbCKO3CZ8Wc/3/ynrcHg2ZnLS1xdMiifCl5+WOJ+udjLsDD0d6n/bPLCPptbb2vi3Pa0D+bNcUCd7qqa6Oz7rhUAOuyScO221jJsq8xu+mU8c53bv4QFJ2yzF9m8DMa16eQ90yQ2692YlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=akL3JuPZ; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726009175; x=1757545175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Dvk8Et4bwnTGxADZlsOQ0cJMTGwPj7/oyjK5hdwxlM=;
  b=akL3JuPZQgJY8wu67FqG/PKHNpXyXnehOBs2nRQbV1yDXiNFja5PbMuB
   18Bsya7GRS5anGvT+pnFY6Lf0SkUm/k0vxziGGfSxdaxaInxbaUvoeipg
   tcjFnH5oBv0ijMEr/csUeVL7XJIkh0uSq1AWe7mYVQxW5JT0IpmW1Mnd2
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,218,1719878400"; 
   d="scan'208";a="432574511"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 22:59:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:9226]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.156:2525] with esmtp (Farcaster)
 id 551096bc-5391-464a-91f8-4e44af82fe58; Tue, 10 Sep 2024 22:59:30 +0000 (UTC)
X-Farcaster-Flow-ID: 551096bc-5391-464a-91f8-4e44af82fe58
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 22:59:30 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 10 Sep 2024 22:59:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Tue, 10 Sep 2024 15:59:20 -0700
Message-ID: <20240910225920.11636-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <d8f99152-e500-4f52-8899-885017bdb362@oracle.com>
References: <d8f99152-e500-4f52-8899-885017bdb362@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shoaib Rao <rao.shoaib@oracle.com>
Date: Tue, 10 Sep 2024 15:30:08 -0700
> My fellow engineer let's first take a breath and calm down. We both are 
> trying to do the right thing. Now read my comments below and if I still 
> don't get it, please be patient, maybe I am not as smart as you are.
> 
> On 9/10/2024 2:53 PM, Kuniyuki Iwashima wrote:
> > From: Shoaib Rao <rao.shoaib@oracle.com>
> > Date: Tue, 10 Sep 2024 13:57:04 -0700
> >> The commit Message:
> >>
> >> syzbot reported use-after-free in unix_stream_recv_urg(). [0]
> >>
> >> The scenario is
> >>
> >>     1. send(MSG_OOB)
> >>     2. recv(MSG_OOB)
> >>        -> The consumed OOB remains in recv queue
> >>     3. send(MSG_OOB)
> >>     4. recv()
> >>        -> manage_oob() returns the next skb of the consumed OOB
> >>        -> This is also OOB, but unix_sk(sk)->oob_skb is not cleared
> >>     5. recv(MSG_OOB)
> >>        -> unix_sk(sk)->oob_skb is used but already freed
> > 
> > How did you miss this ?
> > 
> > Again, please read my patch and mails **carefully**.
> > 
> > unix_sk(sk)->oob_sk wasn't cleared properly and illegal access happens
> > in unix_stream_recv_urg(), where ->oob_skb is dereferenced.
> > 
> > Here's _technical_ thing that you want.
> 
> This is exactly what I am trying to point out to you.
> The skb has proper references and is NOT de-referenced because 
> __skb_datagram_iter() detects that the length is zero and returns EFAULT.

It's dereferenced as UNIXCB(skb).consumed first in
unix_stream_read_actor().

Then, 1 byte of data is copied without -EFAULT because
unix_stream_recv_urg() always passes 1 as chunk (size) to
recv_actor().

That's why I said KASAN should be working on your setup and suggested
running the repro with/without KASAN.  If KASAN is turned off, single
byte garbage is copied from the freed area.

See the last returned values below

Without KASAN:

---8<---
write(1, "executing program\n", 18
executing program
)     = 18
socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT
[   15.657345] queued OOB: ff1100000442c700
) = 1
recvmsg(3,
[   15.657793] reading OOB: ff1100000442c700
{msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB|MSG_WAITFORONE) = 1
sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE
[   15.659830] queued OOB: ff1100000442c300
) = 1
recvfrom(3,
[   15.660272] free skb: ff1100000442c300
"\21", 125, MSG_DONTROUTE|MSG_TRUNC, NULL, NULL) = 1
recvmsg(3,
[   15.661014] reading OOB: ff1100000442c300
{msg_namelen=0, MSG_OOB|MSG_ERRQUEUE) = 1
---8<---


With KASAN:

---8<---
socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT
[  134.735962] queued OOB: ff110000099f0b40
) = 1
recvmsg(3,
[  134.736460] reading OOB: ff110000099f0b40
{msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB|MSG_WAITFORONE) = 1
sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE
[  134.738554] queued OOB: ff110000099f0c80
) = 1
recvfrom(3,
[  134.739086] free skb: ff110000099f0c80
"\21", 125, MSG_DONTROUTE|MSG_TRUNC, NULL, NULL) = 1
recvmsg(3,
[  134.739792] reading OOB: ff110000099f0c80
 {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT (Bad address)
---8<---


> 
> See more below
> > 
> > ---8<---
> > # ./oob
> > executing program
> > [   25.773750] queued OOB: ff1100000947ba40
> > [   25.774110] reading OOB: ff1100000947ba40
> > [   25.774401] queued OOB: ff1100000947bb80
> > [   25.774669] free skb: ff1100000947bb80
> > [   25.774919] reading OOB: ff1100000947bb80
> > [   25.775172] ==================================================================
> > [   25.775654] BUG: KASAN: slab-use-after-free in unix_stream_read_actor+0x86/0xb0
> > ---8<---
> > 
> > ---8<---
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index a1894019ebd5..ccd9c47160a5 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2230,6 +2230,7 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
> >   	__skb_queue_tail(&other->sk_receive_queue, skb);
> >   	spin_unlock(&other->sk_receive_queue.lock);
> >   
> > +	printk(KERN_ERR "queued OOB: %px\n", skb);
> >   	sk_send_sigurg(other);
> >   	unix_state_unlock(other);
> >   	other->sk_data_ready(other);
> > @@ -2637,6 +2638,7 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
> >   	spin_unlock(&sk->sk_receive_queue.lock);
> >   	unix_state_unlock(sk);
> >   
> > +	printk(KERN_ERR "reading OOB: %px\n", oob_skb);
> >   	chunk = state->recv_actor(oob_skb, 0, chunk, state);
> >   
> >   	if (!(state->flags & MSG_PEEK))
> > @@ -2915,7 +2917,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
> >   
> >   			skb_unlink(skb, &sk->sk_receive_queue);
> >   			consume_skb(skb);
> > -
> > +			printk(KERN_ERR "free skb: %px\n", skb);
> 
> This printk is wrongly placed

It's not, because this just prints the address of OOB skb just after
it's illegally consumed without MSG_OOB.  The code is only called
for the illegal OOB during the repro.


> because the skb has been freed above, but 
> since it is just printing the pointer it should be OK, access to any skb 
> field will be an issue. You should move this printk to before 
> unix_stream_read_generic and print the refcnt on the skb and the length 
> of the data and verify what I am saying, that the skb has one refcnt and 
> zero length.

Note this is on top of net-next where no additional refcnt is taken
for OOB, so no need to print skb's refcnt.  Also the length is not
related because chunk is always 1.


> This is the kind of interaction I was looking for. If I have missed 
> something please be patient and let me know.
> 
> Regards,
> 
> Shoaib

