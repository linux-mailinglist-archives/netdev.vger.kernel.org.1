Return-Path: <netdev+bounces-217975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43950B3AB0A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6063ADE84
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87ED279DBC;
	Thu, 28 Aug 2025 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4F2xMoQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58E2797A4
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756410230; cv=none; b=NT71BDcYIXIRulFbgT+FH+oI4qF3WAyWndp362cmEoIA8jsVDeIilJLckC3sAzKBZEmlCaPmm48Fow6ZY9MArGlUHNepzMmso5OeQsSlGiayFm3vJ97vCHPlehSyuSub1Vxglv1JgFurFnzakhfdhStbZIpiBzGoB42xsfDoQSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756410230; c=relaxed/simple;
	bh=TnMTKIT2RLMSunGpSoNftY6dzd5Bjjd45dNhptClb9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc4zSK4bIW2tY7N30tWa8RxArVtiNHd2/jMMclMdx/11q5VKX9CUz6XdiEBiFojJdYwV/vzlLd8kB/g25a9D+EcGvM4msk464zIa4IF5vrN07d82eaagaRuF45/G5SaW8SV84SYBXIVon3iVGDmRE9DM/0dt6OMP6JiTx65TuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4F2xMoQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b28184a8b3so15733091cf.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756410228; x=1757015028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvWP1EIagvNp91g+RgveNhCCrgjH/IPh927YjhaOu4c=;
        b=V4F2xMoQ6I0s/KGuhe45bcPTloJdW0zPEs3vpzcWwbLiHUVx9Mginec2Os6XcdfC7b
         xXAbvLQt4p0ixB0akGEuVZQKH4RiGaWWmGixqAZxwFeAThdvmmx0JGK+bSp5+dD68oMs
         CQO3y2CYVd2ZX3rIjYUmQQ3mE1MiSfRApO5xhCKsjmJeLBZPCj0HWd+Zx4bK286NJTSR
         S98GS2udBvZUbgQ/pY5XqHrGsby1Axo90Y9o2NKOd+g17NSUiX2benh7ijXRcHgMBFmy
         EFkglSAVLS7hpdDNlFqD27EpV87BXtUBxkp97eZ52ZC+WNfyA+Bc6GgHkYZLFA6KvmAl
         NMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756410228; x=1757015028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvWP1EIagvNp91g+RgveNhCCrgjH/IPh927YjhaOu4c=;
        b=IK/grDlk8oH+1T/PIKFn5U1Zzf03F8o3vLDVfZcpkoCGYOdGtVAUEovMHwCoFyx0MU
         vKCOCxAC/UfmnhbeTVVncMPxSnlnZpLreRYwWcHguRXNyA7n3wCpdTgcqJqZCdaqPsFB
         vUKUrbkF7wrH2IrOImtphWrVglTZUW+5lcSMBrEBCzNPZrEUR0eaGEcCOXMkuP4udi0A
         nun1bY+YW+qsq/wUV6QIv9KPV/1JpALtSY2PYSaZxBgf2zBQ4PYxwxL2p0g4P0N5KdOw
         X7KyBHdY8Kv77t+Ox3gW9VH0NC/+DRa+5TlQdOLow9uD6sN2xaOdhMMXbO2ltRp+i8/N
         O9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/WGLBLu1FLZcKJbgRwRC/n6vLGakALoN4IVcpjrrT961tMVrJXOpFSvqNnfT+Mg7TVywwipE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4N1SPNZcqjPF6GqvsDE9V8LZkmhwyj1ZYUITkr4NZHbdXaVZM
	wyu5FYRQ2JmVikZ1MxbfBm+wSFDT4kE/HE3WOSPdqyozV+60xrVKLaXWFk/ckpDR4JgYd3xopiH
	9E0HNnEjKQPKBjtChEDY1qOphT31dR7nmbCnWRgiH
X-Gm-Gg: ASbGncv0wO2AmFxxiZrbDp8ht4M16MV21KbTy8XmqQMG0fsa9EJo3Lu02Hphqflf4Q3
	KHQ27AhHpY1+VIOaGDNDwJoTEwYdyEKSHDJDX4pjxFEkLcNGYl4m/gc0+W5GNv61ZQV0R27k0wq
	uvgzw4naI2R3Zmz208kZMONYam4Oun270YqMIcukTC3pPKMzwr88jUeD7qUqe7TxOHPEL5a7DRI
	mLq6RBjDOBYGA==
X-Google-Smtp-Source: AGHT+IG3jqv6msRFu+wEOd5ve7eXnVNwLNaZG7weV85QwzfVsC478io88x5SFE5xNO0tXiiGPcYr0WhENxml0Xs4ZBA=
X-Received: by 2002:a05:622a:5597:b0:4b2:8ac4:ef84 with SMTP id
 d75a77b69052e-4b2aab4d13fmr298360151cf.83.1756410227277; Thu, 28 Aug 2025
 12:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-b4-tcp-ao-md5-rst-finwait2-v2-0-653099bea5c1@arista.com> <20250828-b4-tcp-ao-md5-rst-finwait2-v2-1-653099bea5c1@arista.com>
In-Reply-To: <20250828-b4-tcp-ao-md5-rst-finwait2-v2-1-653099bea5c1@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Aug 2025 12:43:36 -0700
X-Gm-Features: Ac12FXyimLdPLId8dmfUxJvcMZz-eM27JZ-f2qMJtzFIaoF1YxDltULDxGWjeeo
Message-ID: <CANn89iKVQ=c8zxm0MqR7ycR1RFbKqObEPEJrpWCfxH4MdVf3Og@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
To: dima@arista.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:15=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+dima.arista.com@kernel.org> wrote:
>
> From: Dmitry Safonov <dima@arista.com>
>
> Currently there are a couple of minor issues with destroying the keys
> tcp_v4_destroy_sock():
>
> 1. The socket is yet in TCP bind buckets, making it reachable for
>    incoming segments [on another CPU core], potentially available to send
>    late FIN/ACK/RST replies.
>
> 2. There is at least one code path, where tcp_done() is called before
>    sending RST [kudos to Bob for investigation]. This is a case of
>    a server, that finished sending its data and just called close().
>
>    The socket is in TCP_FIN_WAIT2 and has RCV_SHUTDOWN (set by
>    __tcp_close())
>
>    tcp_v4_do_rcv()/tcp_v6_do_rcv()
>      tcp_rcv_state_process()            /* LINUX_MIB_TCPABORTONDATA */
>        tcp_reset()
>          tcp_done_with_error()
>            tcp_done()
>              inet_csk_destroy_sock()    /* Destroys AO/MD5 keys */
>      /* tcp_rcv_state_process() returns SKB_DROP_REASON_TCP_ABORT_ON_DATA=
 */
>    tcp_v4_send_reset()                  /* Sends an unsigned RST segment =
*/
>
>    tcpdump:
> > 22:53:15.399377 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (=
0x0800), length 74: (tos 0x0, ttl 64, id 33929, offset 0, flags [DF], proto=
 TCP (6), length 60)
> >     1.0.0.1.34567 > 1.0.0.2.49848: Flags [F.], seq 2185658590, ack 3969=
644355, win 502, options [nop,nop,md5 valid], length 0
> > 22:53:15.399396 00:00:01:01:00:00 > 00:00:b2:1f:00:00, ethertype IPv4 (=
0x0800), length 86: (tos 0x0, ttl 64, id 51951, offset 0, flags [DF], proto=
 TCP (6), length 72)
> >     1.0.0.2.49848 > 1.0.0.1.34567: Flags [.], seq 3969644375, ack 21856=
58591, win 128, options [nop,nop,md5 valid,nop,nop,sack 1 {2185658590:21856=
58591}], length 0
> > 22:53:16.429588 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (=
0x0800), length 60: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP=
 (6), length 40)
> >     1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658590, win 0, le=
ngth 0
> > 22:53:16.664725 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (=
0x0800), length 74: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP=
 (6), length 60)
> >     1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658591, win 0, op=
tions [nop,nop,md5 valid], length 0
> > 22:53:17.289832 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (=
0x0800), length 74: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP=
 (6), length 60)
> >     1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658591, win 0, op=
tions [nop,nop,md5 valid], length 0
>
>   Note the signed RSTs later in the dump - those are sent by the server
>   when the fin-wait socket gets removed from hash buckets, by
>   the listener socket.
>
> Instead of destroying AO/MD5 info and their keys in inet_csk_destroy_sock=
(),
> slightly delay it until the actual socket .sk_destruct(). As shutdown'ed
> socket can yet send non-data replies, they should be signed in order for
> the peer to process them. Now it also matches how AO/MD5 gets destructed
> for TIME-WAIT sockets (in tcp_twsk_destructor()).
>
> This seems optimal for TCP-MD5, while for TCP-AO it seems to have an
> open problem: once RST get sent and socket gets actually destructed,
> there is no information on the initial sequence numbers. So, in case
> this last RST gets lost in the network, the server's listener socket
> won't be able to properly sign another RST. Nothing in RFC 1122
> prescribes keeping any local state after non-graceful reset.
> Luckily, BGP are known to use keep alive(s).
>
> While the issue is quite minor/cosmetic, these days monitoring network
> counters is a common practice and getting invalid signed segments from
> a trusted BGP peer can get customers worried.
>
> Investigated-by: Bob Gilligan <gilligan@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/net/tcp.h   |  4 ++++
>  net/ipv4/tcp.c      | 27 +++++++++++++++++++++++++++
>  net/ipv4/tcp_ipv4.c | 33 ++++++++-------------------------
>  net/ipv6/tcp_ipv6.c |  8 ++++++++
>  4 files changed, 47 insertions(+), 25 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2936b8175950faa777f81f3c6b7230bcc375d772..0009c26241964b54aa93bc1b8=
6158050d96c2c98 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1931,6 +1931,7 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk=
,
>  }
>
>  #define tcp_twsk_md5_key(twsk) ((twsk)->tw_md5_key)
> +void tcp_md5_destruct_sock(struct sock *sk);
>  #else
>  static inline struct tcp_md5sig_key *
>  tcp_md5_do_lookup(const struct sock *sk, int l3index,
> @@ -1947,6 +1948,9 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk=
,
>  }
>
>  #define tcp_twsk_md5_key(twsk) NULL
> +static inline void tcp_md5_destruct_sock(struct sock *sk)
> +{
> +}
>  #endif
>
>  int tcp_md5_alloc_sigpool(void);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 9bc8317e92b7952871f07ae11a9c2eaa7d3a9e65..927233ee7500e0568782ae4a3=
860af56d1476acd 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -412,6 +412,33 @@ static u64 tcp_compute_delivery_rate(const struct tc=
p_sock *tp)
>         return rate64;
>  }
>
> +#ifdef CONFIG_TCP_MD5SIG
> +static void tcp_md5sig_info_free_rcu(struct rcu_head *head)
> +{
> +       struct tcp_md5sig_info *md5sig;
> +
> +       md5sig =3D container_of(head, struct tcp_md5sig_info, rcu);
> +       kfree(md5sig);
> +       static_branch_slow_dec_deferred(&tcp_md5_needed);
> +       tcp_md5_release_sigpool();
> +}
> +
> +void tcp_md5_destruct_sock(struct sock *sk)
> +{
> +       struct tcp_sock *tp =3D tcp_sk(sk);
> +
> +       if (tp->md5sig_info) {
> +               struct tcp_md5sig_info *md5sig;
> +
> +               md5sig =3D rcu_dereference_protected(tp->md5sig_info, 1);
> +               tcp_clear_md5_list(sk);
> +               call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
> +               rcu_assign_pointer(tp->md5sig_info, NULL);

I would move this line before call_rcu(&md5sig->rcu, tcp_md5sig_info_free_r=
cu),
otherwise the free could happen before the clear, and an UAF could occur.

It is not absolutely clear if this function runs under rcu_read_lock(),
and even if it is currently safe, this could change in the future.

Other than that :

Reviewed-by: Eric Dumazet <edumazet@google.com>

