Return-Path: <netdev+bounces-51242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13627F9CFD
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 10:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 266BFB20CCA
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7F017981;
	Mon, 27 Nov 2023 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiIt2aC1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC8EE1
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 01:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701079148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kvh51KetYyGRq3Y4c+9aHpBnOSnRibKuiBPQPWPMC40=;
	b=EiIt2aC1gQhhe9F/uHn8G49gJ5qjPmR6XmB/JG6oxkcQb68lSsAQrs/FtrGjWasu/NG8Y6
	PbVaK5rQ/qcvr5/gsHNHLes5d//J782Ce3ygLQbiCKRdvuORqqXvrpLMJGNS1fK69eEnfb
	pRqL624mvNH52OCMjascjBMs2Zyvvak=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ZGORpPfLO82XX09Rq-Dp1Q-1; Mon, 27 Nov 2023 04:59:07 -0500
X-MC-Unique: ZGORpPfLO82XX09Rq-Dp1Q-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-540f4715d09so199519a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 01:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701079146; x=1701683946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kvh51KetYyGRq3Y4c+9aHpBnOSnRibKuiBPQPWPMC40=;
        b=vdM82TZ2yW/A85qe9m88mG2PRcEOqsYgqaMuMLO4EOxplQcO2nYDt1ZHqQW6v6pEF4
         uqgeEFGMLVUDVRp/0Xq/qcMdgO3GPpRtsnoHtrDxgk7XRSpSAuB5aY06K0mHOiKcTdrF
         KMZteHFrDR9EDZv7+KRT+zhG5GYppcgRijVqhLyK5qLBh571cJPV/LjVSR+v4DxiOCQI
         wBp7vdTgJRtMeA5YZ31HEOKfgx/Ib77DiIsSfVSHql1O31Fu92og1+DINHPfVyRElaAj
         mB2TnG7BeIXOxBqEMNQDSMCud2lsQAFcC+pflB3omOLFRpCXJQSo9w4sLC8Jg6qUHXlf
         bYAg==
X-Gm-Message-State: AOJu0Yy/8A2I+nG/BRVbT4p/1kZvuUbxxgclEJryiEDAGh6wNIawybM5
	PmNbQBgcKa3FBOzsQWeQQpkxSov16ujY3RK7K8WrR3tR1aGQRcJ3rR1VkfhNha3vKHfYGoTpuOD
	RhBJuLD7sLn93vdLvToCzcyIQ
X-Received: by 2002:aa7:d884:0:b0:548:b2b1:fe9f with SMTP id u4-20020aa7d884000000b00548b2b1fe9fmr7131412edq.4.1701079145940;
        Mon, 27 Nov 2023 01:59:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeOVdJWT0+sZkkstJgKKTCEblmHMzfxv9dgDZ7AdV1c/dXcZ4qHBl9zlpW1jMggPF6l1GovQ==
X-Received: by 2002:aa7:d884:0:b0:548:b2b1:fe9f with SMTP id u4-20020aa7d884000000b00548b2b1fe9fmr7131400edq.4.1701079145592;
        Mon, 27 Nov 2023 01:59:05 -0800 (PST)
Received: from gerbillo.redhat.com (host-87-11-7-253.retail.telecomitalia.it. [87.11.7.253])
        by smtp.gmail.com with ESMTPSA id i14-20020a05640200ce00b0054866f0c1b8sm5024019edu.69.2023.11.27.01.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:59:05 -0800 (PST)
Message-ID: <0d5145b231d9b7c8d2f32277ce5ab56bb1859bff.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 4/4] af_unix: Try to run GC async.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>,  netdev@vger.kernel.org
Date: Mon, 27 Nov 2023 10:59:03 +0100
In-Reply-To: <20231123014747.66063-5-kuniyu@amazon.com>
References: <20231123014747.66063-1-kuniyu@amazon.com>
	 <20231123014747.66063-5-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-22 at 17:47 -0800, Kuniyuki Iwashima wrote:
> If more than 16000 inflight AF_UNIX sockets exist and the garbage
> collector is not running, unix_(dgram|stream)_sendmsg() call unix_gc().
> Also, they wait for unix_gc() to complete.
>=20
> In unix_gc(), all inflight AF_UNIX sockets are traversed at least once,
> and more if they are the GC candidate.  Thus, sendmsg() significantly
> slows down with too many inflight AF_UNIX sockets.
>=20
> However, if a process sends data with no AF_UNIX FD, the sendmsg() call
> does not need to wait for GC.  After this change, only the process that
> meets the condition below will be blocked under such a situation.
>=20
>   1) cmsg contains AF_UNIX socket
>   2) more than 32 AF_UNIX sent by the same user are still inflight
>=20
> Note that even a sendmsg() call that does not meet the condition but has
> AF_UNIX FD will be blocked later in unix_scm_to_skb() by the spinlock,
> but we allow that as a bonus for sane users.
>=20
> The results below are the time spent in unix_dgram_sendmsg() sending 1
> byte of data with no FD 4096 times on a host where 32K inflight AF_UNIX
> sockets exist.
>=20
> Without series: the sane sendmsg() needs to wait gc unreasonably.
>=20
>   $ sudo /usr/share/bcc/tools/funclatency -p 11165 unix_dgram_sendmsg
>   Tracing 1 functions for "unix_dgram_sendmsg"... Hit Ctrl-C to end.
>   ^C
>        nsecs               : count     distribution
>   [...]
>       524288 -> 1048575    : 0        |                                  =
      |
>      1048576 -> 2097151    : 3881     |**********************************=
******|
>      2097152 -> 4194303    : 214      |**                                =
      |
>      4194304 -> 8388607    : 1        |                                  =
      |
>=20
>   avg =3D 1825567 nsecs, total: 7477526027 nsecs, count: 4096
>=20
> With series: the sane sendmsg() can finish much faster.
>=20
>   $ sudo /usr/share/bcc/tools/funclatency -p 8702  unix_dgram_sendmsg
>   Tracing 1 functions for "unix_dgram_sendmsg"... Hit Ctrl-C to end.
>   ^C
>        nsecs               : count     distribution
>   [...]
>          128 -> 255        : 0        |                                  =
      |
>          256 -> 511        : 4092     |**********************************=
******|
>          512 -> 1023       : 2        |                                  =
      |
>         1024 -> 2047       : 0        |                                  =
      |
>         2048 -> 4095       : 0        |                                  =
      |
>         4096 -> 8191       : 1        |                                  =
      |
>         8192 -> 16383      : 1        |                                  =
      |
>=20
>   avg =3D 410 nsecs, total: 1680510 nsecs, count: 4096
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/af_unix.h |  2 +-
>  include/net/scm.h     |  1 +
>  net/core/scm.c        |  5 +++++
>  net/unix/af_unix.c    |  6 ++++--
>  net/unix/garbage.c    | 10 ++++++++--
>  5 files changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index c628d30ceb19..f8e654d418e6 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -13,7 +13,7 @@ void unix_notinflight(struct user_struct *user, struct =
file *fp);
>  void unix_destruct_scm(struct sk_buff *skb);
>  void io_uring_destruct_scm(struct sk_buff *skb);
>  void unix_gc(void);
> -void wait_for_unix_gc(void);
> +void wait_for_unix_gc(struct scm_fp_list *fpl);
>  struct unix_sock *unix_get_socket(struct file *filp);
>  struct sock *unix_peer_get(struct sock *sk);
> =20
> diff --git a/include/net/scm.h b/include/net/scm.h
> index e8c76b4be2fe..1ff6a2855064 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -24,6 +24,7 @@ struct scm_creds {
> =20
>  struct scm_fp_list {
>  	short			count;
> +	short			count_unix;
>  	short			max;
>  	struct user_struct	*user;
>  	struct file		*fp[SCM_MAX_FD];
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 880027ecf516..c1aae77d120b 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -35,6 +35,7 @@
>  #include <net/compat.h>
>  #include <net/scm.h>
>  #include <net/cls_cgroup.h>
> +#include <net/af_unix.h>
> =20
> =20
>  /*
> @@ -105,6 +106,10 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct =
scm_fp_list **fplp)
>  			return -EBADF;
>  		*fpp++ =3D file;
>  		fpl->count++;
> +#if IS_ENABLED(CONFIG_UNIX)
> +		if (unix_get_socket(file))
> +			fpl->count_unix++;
> +#endif
>  	}
> =20
>  	if (!fpl->user)
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 1e6f5aaf1cc9..bbad3959751d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1925,11 +1925,12 @@ static int unix_dgram_sendmsg(struct socket *sock=
, struct msghdr *msg,
>  	long timeo;
>  	int err;
> =20
> -	wait_for_unix_gc();
>  	err =3D scm_send(sock, msg, &scm, false);
>  	if (err < 0)
>  		return err;
> =20
> +	wait_for_unix_gc(scm.fp);
> +
>  	err =3D -EOPNOTSUPP;
>  	if (msg->msg_flags&MSG_OOB)
>  		goto out;
> @@ -2201,11 +2202,12 @@ static int unix_stream_sendmsg(struct socket *soc=
k, struct msghdr *msg,
>  	bool fds_sent =3D false;
>  	int data_len;
> =20
> -	wait_for_unix_gc();
>  	err =3D scm_send(sock, msg, &scm, false);
>  	if (err < 0)
>  		return err;
> =20
> +	wait_for_unix_gc(scm.fp);
> +
>  	err =3D -EOPNOTSUPP;
>  	if (msg->msg_flags & MSG_OOB) {
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 8bc93a7e745f..73091d6b7fc4 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -184,8 +184,9 @@ static void inc_inflight_move_tail(struct unix_sock *=
u)
>  }
> =20
>  #define UNIX_INFLIGHT_TRIGGER_GC 16000
> +#define UNIX_INFLIGHT_SANE_USER 32

I don't have any relevant usage stats for unix sockets, but out of
sheer ignorance on my side '32' looks a bit low. Why/how did you pick
such value?

> -void wait_for_unix_gc(void)
> +void wait_for_unix_gc(struct scm_fp_list *fpl)
>  {
>  	/* If number of inflight sockets is insane, kick a
>  	 * garbage collect right now.
> @@ -195,7 +196,12 @@ void wait_for_unix_gc(void)
>  	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC)
>  		queue_work(system_unbound_wq, &unix_gc_work);
> =20
> -	flush_work(&unix_gc_work);
> +	/* Penalise users who want to send AF_UNIX sockets
> +	 * but whose sockets have not been received yet.
> +	 */
> +	if (fpl && fpl->count_unix &&
> +	    READ_ONCE(fpl->user->unix_inflight) > UNIX_INFLIGHT_SANE_USER)
> +		flush_work(&unix_gc_work);

flush_work() will be called even when=C2=A0'unix_tot_inflight' is (much)
less then 'UNIX_INFLIGHT_TRIGGER_GC'. Could that cause some regressions
for workload with moderated numbers of fd in flights, where the GC was
never triggered before this series?

Thanks!

Paolo


