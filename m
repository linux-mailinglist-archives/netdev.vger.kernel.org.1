Return-Path: <netdev+bounces-190839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7649AAB90D4
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62DD97A3EFF
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CA925DAF4;
	Thu, 15 May 2025 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VbriBDD5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28464185B67
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747341355; cv=none; b=rUPqUAP0wI9o+NS6SLIb+kHoBQwBD4LMjUvcfB0MhZookYSqE+KVPqjShFpy2CXamAnNPGbwVDQTMnya5vl3eCPMYz2prTyS8+w4QjfatCMkyFar6FQIIaCMmcIFfACxv97HuCt/eQErcjdSY9WMD4bLs0Ssff18ufQ+oBLu2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747341355; c=relaxed/simple;
	bh=trPLb0dUo7uwQEYV6uSnMQ80WjDkPb7hLfSsBisNnDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yp05INlCUigVRyvbgpw7mVwedeq/U1b/OVKIw8Y6lN8hMexBINLOraNc2C4fLXv51XjuVEQVHy+ku27wRDIAGEckDKxSOyijJzYci75bLk0XJdTS7jfeot7Vy+y36XR8Djwgq/ouaOhe8TgydAnoCHkHmW/buQ+HIiwh4tH5jpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VbriBDD5; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747341354; x=1778877354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dCItjqNeZSd6mdY6hNdj1if5glTtTT1LXiSi0j3f/n0=;
  b=VbriBDD58ZoApFUlWOLsR0/M0v/gaX/A8VadbF7JHNzBbxRq80Vud2Rq
   TbLrWkKgedG9+DfK64lxxePaLgR4TXnqyewSFanK64Y7tKVrMaqVKEZMP
   vMEBjEk/5rG8bIPpzZDqObvEBiHE8QQSCLwmALO+G/L3RwwT5j+7uSjLR
   DwY5t681Ld/ikCS4EJmm1c6NpwhAdIUKzgL2olXhnlZkQGw8XN+JkzYQL
   nM045APhxyh82Wj1O225W3armDA3ONfU7IymBSYcKAq9RqaJbLXLdQb+2
   WTeGYA/Dyv8fE+Hcb/xWMIHrHFYrOHXc8uErmZTmT17730yRNgRjs51Fh
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="50403725"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 20:35:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:20930]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.48:2525] with esmtp (Farcaster)
 id 745f7d4a-4bce-4438-84fc-67f060d6abdb; Thu, 15 May 2025 20:35:51 +0000 (UTC)
X-Farcaster-Flow-ID: 745f7d4a-4bce-4438-84fc-67f060d6abdb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 20:35:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 20:35:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v3 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
Date: Thu, 15 May 2025 13:35:09 -0700
Message-ID: <20250515203540.85511-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <682635fea3015_25ebe52945d@willemb.c.googlers.com.notmuch>
References: <682635fea3015_25ebe52945d@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 15 May 2025 14:44:14 -0400
> Kuniyuki Iwashima wrote:
> > As explained in the next patch, SO_PASSRIGHTS would have a problem
> > if we assigned a corresponding bit to socket->flags, so it must be
> > managed in struct sock.
> > 
> > Mixing socket->flags and sk->sk_flags for similar options will look
> > confusing, and sk->sk_flags does not have enough space on 32bit system.
> > 
> > Also, as mentioned in commit 16e572626961 ("af_unix: dont send
> > SCM_CREDENTIALS by default"), SOCK_PASSCRED and SOCK_PASSPID handling
> > is known to be slow, and managing the flags in struct socket cannot
> > avoid that for embryo sockets.
> > 
> > Let's move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
> > 
> > While at it, other SOCK_XXX flags in net.h are grouped as enum.
> > 
> > Note that assign_bit() was atomic, so the writer side is moved down
> > after lock_sock() in setsockopt(), but the bit is only read once
> > in sendmsg() and recvmsg(), so lock_sock() is not needed there.
> 
> Because the socket lock is already held there?

No, for example, scm_recv_unix() is called without lock_sock(),
but it's okay because reading a single bit is always a matter
of timing, when to snapshot the flag, (unless there is another
dependency or the bit is read more than once).

With this, write happens before/after the if block:

                               <-- write could happen here
  lock_sock()
  if (sk->sk_scm_credentials) {
    do something
  }
  lock_unlock()
                               <-- or here (not related to logic)

but this is same without lock_sock() if the bit is read only
once:

                               <-- write could happen here
  if (sk->sk_scm_credentials) {
    do something               <-- or here (not related to logic)
  }
                               <-- or here (not related to logic)

So for SOCK_PASSXXX bits, lock_sock() prevents data-race
between writers as you pointed out, but it does nothing
for readers.


> 
> What about getsockopt. And the one READ_ONCE in unix_accept.

And this is same for getsockopt().

Regarding unix_accept(), I used READ_ONCE() here to snapshot
all the flags, but given the value is bit for each, this is
also the matter of timing to snapshot the values.

Also, in the next patch, reading sk->sk_scm_recv_flags will be
done under lock_sock(), so it's done without READ_ONCE().

