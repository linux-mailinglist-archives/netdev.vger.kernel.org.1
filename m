Return-Path: <netdev+bounces-157360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE45EA0A0B8
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 04:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B43A6C83
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 03:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDCB17BB6;
	Sat, 11 Jan 2025 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Li4aAtpz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419F14EC46
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736567055; cv=none; b=dY9jHmSd2d6pguZ1+ssM8daa2TNS6VXZDEbOHNMFbM0erhqso8MGPgvApI7NEuQwSAURqJG/PK/3sd8eLxlhC6KQnVYmsPOnD5BcQN8rPuXqd2lW/fo1X6xqBHqAwKnYZr15JH72eyXerlbqZjCc80APdpcpPcM2yX/z1cFG14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736567055; c=relaxed/simple;
	bh=x+0qqG9QwZWVL35ZHMIevNjim+czdYj663VRq0ZZfN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTDV52wOac6/C59txQqHp5MgtxxXQgSyrMsjY7hysXzNdJ5beRMmD88BNyjhkTOW/hvcEaS4XtdVYIsP43HYVg7hwcgMEGcatWHr3AEJ7O0lxHYMAvd7ZlEpQ5XWSRLWMd6eBlXA2+SAkgNRzUTI6znX3cRZh7/b7cFUHzNmIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Li4aAtpz; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736567054; x=1768103054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sn8zRHw6JsEvosRpyglZVO4wxvYM3UM40osZG5XiSMc=;
  b=Li4aAtpzIqiseY6TGLIkd7mz95Ix0HIIceXS22bYlaqkUkC72/8TJEyL
   jYN4bBPzqeziguKsKARl8I6Ubmv4My8kM0KGAyYmXEBw1/Wf5yw+QMCaB
   Kze2Mrf1rE95RNw6OESh6VGUmt7/86wRJOvPOYZZJRx3S+tpdgMY5X8k9
   U=;
X-IronPort-AV: E=Sophos;i="6.12,306,1728950400"; 
   d="scan'208";a="400093011"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 03:44:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:56041]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.22:2525] with esmtp (Farcaster)
 id f1f04095-8c94-4406-b45e-59978379a846; Sat, 11 Jan 2025 03:44:07 +0000 (UTC)
X-Farcaster-Flow-ID: f1f04095-8c94-4406-b45e-59978379a846
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 11 Jan 2025 03:44:00 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.249.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 11 Jan 2025 03:43:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jdamato@fastly.com>
CC: <davem@davemloft.net>, <donald.hunter@redhat.com>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 06/12] af_unix: Reuse out_pipe label in unix_stream_sendmsg().
Date: Sat, 11 Jan 2025 12:43:47 +0900
Message-ID: <20250111034347.28116-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <Z4GYD_9dqOi7mXOj@LQ3V64L9R2>
References: <Z4GYD_9dqOi7mXOj@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Joe Damato <jdamato@fastly.com>
Date: Fri, 10 Jan 2025 13:58:39 -0800
> On Sat, Jan 11, 2025 at 12:22:31AM +0900, Kuniyuki Iwashima wrote:
> > From: Simon Horman <horms@kernel.org>
> > Date: Fri, 10 Jan 2025 11:43:44 +0000
> > > On Fri, Jan 10, 2025 at 06:26:35PM +0900, Kuniyuki Iwashima wrote:
> > > > This is a follow-up of commit d460b04bc452 ("af_unix: Clean up
> > > > error paths in unix_stream_sendmsg().").
> > > > 
> > > > If we initialise skb with NULL in unix_stream_sendmsg(), we can
> > > > reuse the existing out_pipe label for the SEND_SHUTDOWN check.
> > > > 
> > > > Let's rename do it and adjust the existing label as out_pipe_lock.
> > > > 
> > > > While at it, size and data_len are moved to the while loop scope.
> > > > 
> > > > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  net/unix/af_unix.c | 23 +++++++++--------------
> > > >  1 file changed, 9 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > > index b190ea8b8e9d..6505eeab9957 100644
> > > > --- a/net/unix/af_unix.c
> > > > +++ b/net/unix/af_unix.c
> > > 
> > > ...
> > > 
> > > > @@ -2285,16 +2283,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> > > >  		}
> > > >  	}
> > > >  
> > > > -	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) {
> > > > -		if (!(msg->msg_flags & MSG_NOSIGNAL))
> > > > -			send_sig(SIGPIPE, current, 0);
> > > > -
> > > > -		err = -EPIPE;
> > > > -		goto out_err;
> > > > -	}
> > > > +	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
> > > 
> > > Hi Iwashima-san,
> > > 
> > > I think you need to set reason here.
> > > 
> > > Flagged by W=1 builds with clang-19.
> > 
> > Hi Simon,
> > 
> > I didn't set it here because skb == NULL and kfree_skb()
> > doesn't touch reason, and KMSAN won't complain about uninit.
> > 
> > Should I use SKB_NOT_DROPPED_YET or drop patch 6 or leave
> > it as is ?
> > 
> > What do you think ?
> 
> My vote is that SKB_NOT_DROPPED_YET is not appropriate here.

Thanks, I felt the same.

> 
> Maybe SKB_DROP_REASON_SOCKET_CLOSE since it is in SEND_SHUTDOWN
> state?

This will look confusing too, so I'll drop this patch.

