Return-Path: <netdev+bounces-191173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1719AABA4FE
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA9C7A5DD1
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9864D27FB28;
	Fri, 16 May 2025 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EhrzBkrZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAA18E025
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747430039; cv=none; b=dXRAYr748XA5Gt82G1c9LvBIR6TNxIp5R/2Qu1hEAgtg02Cs1kC7uDUgPguLhaWfNOdDY/7GzSbSOFU10EW8CAM39AZxmxhBe12hXgC/GNrw7Q4YuGXO5PpgYWIz2YXJDy0TcVcVtUQcsme0c+Om3adidGILjLnA8ZcUniFXyD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747430039; c=relaxed/simple;
	bh=1n+TH3Yr9/xuNhN98eHMUSpatmAt7CX7dBqo8bMS1f8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1fKCz66kxxd1Ru7N/Yv4xwQkbH8r+ixRd9U9FaxdWGiUTD8DIGW9f16wBYfZImThfnDj0i8c8QAy68UY2KBNOnqjkWJIhJwWb3JV55kbjpsw6A+6dO5JQN/QT15yDmXmH+O4VXE6x7qKIbmyUgGsGKt24F4rRrgrCnaDadFrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EhrzBkrZ; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747430038; x=1778966038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eX2ie6PVLXrmCdB3g6AclIHuh4r8GeGNzk1Zrs8GCDw=;
  b=EhrzBkrZ+wFHI8ZWrPC4aETJ+xH6lex350w8LTPULT+xEumF55EGHasR
   L8512gLRiWelhUsaMSu9gTIsFHrbTm+XE6V3A3T1X6S8IbohmhBMA/1uc
   uQXU8vAnHE1i6PF9Mu/QN9LPp/JnYfo8J39wyMv9c2mL1jR2owF9Qi1Uj
   c04IyZBhonaJGvoZdVykCzLI8fCIuDRYdoZb4hBN4XY21sGCnoyOdzOl2
   EYM+jc/BZLr34MbWs1Eit7N79PNeP3rNldNPau0JBxF9+35kYgyDaGmuq
   xZndfl0mjOG5CMYn1ztIASbcBLKHZrn6YG6ehOtqecaVFBDnTo1FEZgcC
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,294,1739836800"; 
   d="scan'208";a="825633328"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 21:13:52 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:56066]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.48:2525] with esmtp (Farcaster)
 id db9c77ce-a195-4fbf-a112-d5d74357f2b6; Fri, 16 May 2025 21:13:51 +0000 (UTC)
X-Farcaster-Flow-ID: db9c77ce-a195-4fbf-a112-d5d74357f2b6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 21:13:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 21:13:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v4 net-next 7/9] af_unix: Inherit sk_flags at connect().
Date: Fri, 16 May 2025 14:13:24 -0700
Message-ID: <20250516211339.96747-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6827a980d82c4_2d2d1f294e3@willemb.c.googlers.com.notmuch>
References: <6827a980d82c4_2d2d1f294e3@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 16 May 2025 17:09:20 -0400
> Kuniyuki Iwashima wrote:
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Date: Fri, 16 May 2025 15:27:48 -0400
> > > Kuniyuki Iwashima wrote:
> > > > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > Date: Fri, 16 May 2025 12:47:13 -0400
> > > > > Kuniyuki Iwashima wrote:
> > > > > > For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
> > > > > > are inherited from the parent listen()ing socket.
> > > > > > 
> > > > > > Currently, this inheritance happens at accept(), because these
> > > > > > attributes were stored in sk->sk_socket->flags and the struct socket
> > > > > > is not allocated until accept().
> > > > > > 
> > > > > > This leads to unintentional behaviour.
> > > > > > 
> > > > > > When a peer sends data to an embryo socket in the accept() queue,
> > > > > > unix_maybe_add_creds() embeds credentials into the skb, even if
> > > > > > neither the peer nor the listener has enabled these options.
> > > > > > 
> > > > > > If the option is enabled, the embryo socket receives the ancillary
> > > > > > data after accept().  If not, the data is silently discarded.
> > > > > > 
> > > > > > This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but
> > > > > > would not for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file
> > > > > > descriptor was sent, it'd be game over.
> > > > > 
> > > > > Code LGTM, hence my Reviewed-by.
> > > > > 
> > > > > Just curious: could this case be handled in a way that does not
> > > > > require receivers explicitly disabling a dangerous default mode?
> > > > > 
> > > > > IIUC the issue is the receiver taking a file reference using fget_raw
> > > > > in scm_fp_copy from __scm_send, and if that is the last ref, it now
> > > > > will hang the receiver process waiting to close this last ref?
> > > > > 
> > > > > If so, could the unwelcome ref be detected at accept, and taken from
> > > > > the responsibility of this process? Worst case, assigned to some
> > > > > zombie process.
> > > > 
> > > > I had the same idea and I think it's doable but complicated.
> > > > 
> > > > We can't detect such a hung fd until we actually do close() it (*), so
> > > > the workaround at recvmsg() would be always call an extra fget_raw()
> > > > and queue the fd to another task (kthread or workqueue?).
> > > > 
> > > > The task can't release the ref until it can ensure that the receiver
> > > > of fd has close()d it, so the task will need to check ref == 1
> > > > preodically.
> > > > 
> > > > But, once the task gets stuck, we need to add another task, or all
> > > > fds will be leaked for a while.
> > > > 
> > > > 
> > > > (*) With bpf lsm, we will be able to inspect such fd at sendmsg() but
> > > > still can't know if it will really hang at close() especially if it's of
> > > > NFS.
> > > > https://github.com/q2ven/linux/commit/a9f03f88430242d231682bfe7c19623b7584505a
> > > 
> > > Thanks. Yeah, I had not thought it through as much, but this is
> > > definitely complex. Not sure even what the is_hung condition would be
> > > exactly.
> > > 
> > > Given that not wanting to receive untrusted FDs from untrusted peers
> > > is quite common, perhaps a likely eventual follow-on to this series is
> > > a per-netns sysctl to change the default.
> > 
> > Makes sense, I'll add a follow-up patch in the LSM series.
> 
> Only if you think it is useful, of course. I don't mean to ask you to
> do extra work, let alone add APIs unless there are real users.

Ah okay, I'll leave it as is :)

