Return-Path: <netdev+bounces-51489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466C7FAE24
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3301C20DF7
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 23:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1EE48CFC;
	Mon, 27 Nov 2023 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ct2lhh5L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0BF19D
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 15:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701126019; x=1732662019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pjZ9158Gt0Qu6mOdfTkV6CUNjM6yBRdpOuq4OMWc6rg=;
  b=ct2lhh5LS2HcOKD1pjh9KEtzWl3caKf3wPl4rXZ81kcR6tgF2ePjw9Tv
   YIbufjWjr+PjVL5IL02+uDt5veYTJ6+BkI5zscZKly6jfZEEyNm70qniz
   3trR/IZltH1cAluM1Sh8EeB3zUiBkkfO4i45QRxRF21cq6DTeTkKlcMUZ
   U=;
X-IronPort-AV: E=Sophos;i="6.04,232,1695686400"; 
   d="scan'208";a="255815952"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 23:00:17 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id EAB4FA0B96;
	Mon, 27 Nov 2023 23:00:15 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:27116]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.242:2525] with esmtp (Farcaster)
 id 50388c63-66f4-4581-b804-d0a6dc63c0f1; Mon, 27 Nov 2023 23:00:15 +0000 (UTC)
X-Farcaster-Flow-ID: 50388c63-66f4-4581-b804-d0a6dc63c0f1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 27 Nov 2023 23:00:15 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 23:00:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <ivan@cloudflare.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 4/4] af_unix: Try to run GC async.
Date: Mon, 27 Nov 2023 15:00:03 -0800
Message-ID: <20231127230003.53974-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0d5145b231d9b7c8d2f32277ce5ab56bb1859bff.camel@redhat.com>
References: <0d5145b231d9b7c8d2f32277ce5ab56bb1859bff.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Paolo Abeni <pabeni@redhat.com>
Date: Mon, 27 Nov 2023 10:59:03 +0100
> On Wed, 2023-11-22 at 17:47 -0800, Kuniyuki Iwashima wrote:
> > If more than 16000 inflight AF_UNIX sockets exist and the garbage
> > collector is not running, unix_(dgram|stream)_sendmsg() call unix_gc().
> > Also, they wait for unix_gc() to complete.
> > 
> > In unix_gc(), all inflight AF_UNIX sockets are traversed at least once,
> > and more if they are the GC candidate.  Thus, sendmsg() significantly
> > slows down with too many inflight AF_UNIX sockets.
> > 
> > However, if a process sends data with no AF_UNIX FD, the sendmsg() call
> > does not need to wait for GC.  After this change, only the process that
> > meets the condition below will be blocked under such a situation.
> > 
> >   1) cmsg contains AF_UNIX socket
> >   2) more than 32 AF_UNIX sent by the same user are still inflight
> > 
> > Note that even a sendmsg() call that does not meet the condition but has
> > AF_UNIX FD will be blocked later in unix_scm_to_skb() by the spinlock,
> > but we allow that as a bonus for sane users.
> > 
> > The results below are the time spent in unix_dgram_sendmsg() sending 1
> > byte of data with no FD 4096 times on a host where 32K inflight AF_UNIX
> > sockets exist.
> > 
> > Without series: the sane sendmsg() needs to wait gc unreasonably.
> > 
> >   $ sudo /usr/share/bcc/tools/funclatency -p 11165 unix_dgram_sendmsg
> >   Tracing 1 functions for "unix_dgram_sendmsg"... Hit Ctrl-C to end.
> >   ^C
> >        nsecs               : count     distribution
> >   [...]
> >       524288 -> 1048575    : 0        |                                        |
> >      1048576 -> 2097151    : 3881     |****************************************|
> >      2097152 -> 4194303    : 214      |**                                      |
> >      4194304 -> 8388607    : 1        |                                        |
> > 
> >   avg = 1825567 nsecs, total: 7477526027 nsecs, count: 4096
> > 
> > With series: the sane sendmsg() can finish much faster.
> > 
> >   $ sudo /usr/share/bcc/tools/funclatency -p 8702  unix_dgram_sendmsg
> >   Tracing 1 functions for "unix_dgram_sendmsg"... Hit Ctrl-C to end.
> >   ^C
> >        nsecs               : count     distribution
> >   [...]
> >          128 -> 255        : 0        |                                        |
> >          256 -> 511        : 4092     |****************************************|
> >          512 -> 1023       : 2        |                                        |
> >         1024 -> 2047       : 0        |                                        |
> >         2048 -> 4095       : 0        |                                        |
> >         4096 -> 8191       : 1        |                                        |
> >         8192 -> 16383      : 1        |                                        |
> > 
> >   avg = 410 nsecs, total: 1680510 nsecs, count: 4096
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/af_unix.h |  2 +-
> >  include/net/scm.h     |  1 +
> >  net/core/scm.c        |  5 +++++
> >  net/unix/af_unix.c    |  6 ++++--
> >  net/unix/garbage.c    | 10 ++++++++--
> >  5 files changed, 19 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > index c628d30ceb19..f8e654d418e6 100644
> > --- a/include/net/af_unix.h
> > +++ b/include/net/af_unix.h
> > @@ -13,7 +13,7 @@ void unix_notinflight(struct user_struct *user, struct file *fp);
> >  void unix_destruct_scm(struct sk_buff *skb);
> >  void io_uring_destruct_scm(struct sk_buff *skb);
> >  void unix_gc(void);
> > -void wait_for_unix_gc(void);
> > +void wait_for_unix_gc(struct scm_fp_list *fpl);
> >  struct unix_sock *unix_get_socket(struct file *filp);
> >  struct sock *unix_peer_get(struct sock *sk);
> >  
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index e8c76b4be2fe..1ff6a2855064 100644
> > --- a/include/net/scm.h
> > +++ b/include/net/scm.h
> > @@ -24,6 +24,7 @@ struct scm_creds {
> >  
> >  struct scm_fp_list {
> >  	short			count;
> > +	short			count_unix;
> >  	short			max;
> >  	struct user_struct	*user;
> >  	struct file		*fp[SCM_MAX_FD];
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index 880027ecf516..c1aae77d120b 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -35,6 +35,7 @@
> >  #include <net/compat.h>
> >  #include <net/scm.h>
> >  #include <net/cls_cgroup.h>
> > +#include <net/af_unix.h>
> >  
> >  
> >  /*
> > @@ -105,6 +106,10 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
> >  			return -EBADF;
> >  		*fpp++ = file;
> >  		fpl->count++;
> > +#if IS_ENABLED(CONFIG_UNIX)
> > +		if (unix_get_socket(file))
> > +			fpl->count_unix++;
> > +#endif
> >  	}
> >  
> >  	if (!fpl->user)
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 1e6f5aaf1cc9..bbad3959751d 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1925,11 +1925,12 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> >  	long timeo;
> >  	int err;
> >  
> > -	wait_for_unix_gc();
> >  	err = scm_send(sock, msg, &scm, false);
> >  	if (err < 0)
> >  		return err;
> >  
> > +	wait_for_unix_gc(scm.fp);
> > +
> >  	err = -EOPNOTSUPP;
> >  	if (msg->msg_flags&MSG_OOB)
> >  		goto out;
> > @@ -2201,11 +2202,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> >  	bool fds_sent = false;
> >  	int data_len;
> >  
> > -	wait_for_unix_gc();
> >  	err = scm_send(sock, msg, &scm, false);
> >  	if (err < 0)
> >  		return err;
> >  
> > +	wait_for_unix_gc(scm.fp);
> > +
> >  	err = -EOPNOTSUPP;
> >  	if (msg->msg_flags & MSG_OOB) {
> >  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index 8bc93a7e745f..73091d6b7fc4 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -184,8 +184,9 @@ static void inc_inflight_move_tail(struct unix_sock *u)
> >  }
> >  
> >  #define UNIX_INFLIGHT_TRIGGER_GC 16000
> > +#define UNIX_INFLIGHT_SANE_USER 32
> 
> I don't have any relevant usage stats for unix sockets, but out of
> sheer ignorance on my side '32' looks a bit low. Why/how did you pick
> such value?

My take was that the peer should receive the fds in timely manner so that
no one will be punished, but I admit 32 is small enough, which can be
reached by a single SCM_RIGHTS (SCM_MAX_FD == 253) cmsg.  So, probably we
can bump it up to 1024 or 2048 (> (4 or 8) * SCM_MAX_FD).


> > -void wait_for_unix_gc(void)
> > +void wait_for_unix_gc(struct scm_fp_list *fpl)
> >  {
> >  	/* If number of inflight sockets is insane, kick a
> >  	 * garbage collect right now.
> > @@ -195,7 +196,12 @@ void wait_for_unix_gc(void)
> >  	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC)
> >  		queue_work(system_unbound_wq, &unix_gc_work);
> >  
> > -	flush_work(&unix_gc_work);
> > +	/* Penalise users who want to send AF_UNIX sockets
> > +	 * but whose sockets have not been received yet.
> > +	 */
> > +	if (fpl && fpl->count_unix &&
> > +	    READ_ONCE(fpl->user->unix_inflight) > UNIX_INFLIGHT_SANE_USER)
> > +		flush_work(&unix_gc_work);
> 
> flush_work() will be called even when 'unix_tot_inflight' is (much)
> less then 'UNIX_INFLIGHT_TRIGGER_GC'. Could that cause some regressions
> for workload with moderated numbers of fd in flights, where the GC was
> never triggered before this series?

Ah exactly, I'll add work_pending() in v3.

	if (!fpl || !fpl->count_unix)
		return

	if (work_pending(&unix_gc_work) &&
	    READ_ONCE(fpl->user->unix_inflight) > UNIX_INFLIGHT_SANE_USER)
		flush_work(&unix_gc_work)

Thanks!

