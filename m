Return-Path: <netdev+bounces-219704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F07B42BB5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D242D7A046B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488922E8E07;
	Wed,  3 Sep 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHPAiRRR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CDC2E03FF
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934310; cv=none; b=o7DLpWOY7GyeGb2+BLufiH9soaVBuTaM+Sn+aeLl9dlT3hFtiTbvHCIn576ngnF3UW3vUBoRaeLV9ir6S64oo+0WvXo1bmgBRO1vPcdld/Y9LasMqwthJ2JQqYfczLbrjcxmsFZjuTFq1rKhTHe2wXlZJGVd+vB5lg/bI1Ts7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934310; c=relaxed/simple;
	bh=wSvLWE3MdJ5mO0ZTEkzxVvuR9/I6ECpQSACReIa8ovE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiI+xcLeqKMDqt5ftY7Jigrvj+OJessp+fPlnmoNLm7PCdyE40e3MTfflYQFz1KfzLx+T5BdOoEYFIIr+a9XeBa6O2eEaZMW5osMhQpfvQdJwqrSurCWaIUPYSB1ym1AunjpGU1YDHioG9krw4ChT1vmzf03gACGBZzPdQr2rTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHPAiRRR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445824dc27so3973685ad.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756934308; x=1757539108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI7TKSUM+JpEjaQC9DEoN1DFyPp7yRcHhc8+lHEzoeE=;
        b=rHPAiRRRY+pC5MjpcXvdTEMYxnXM8VEH5svKXsgituTPK9Lq0z9isDckImu0U7B3JE
         w4IKYhuVSyuKJIRbc5GC507iV86g71V6EKG3CLO1K/GNaUEGEbmHMO5Z2r2qX+irpEOx
         DeztsJ57JFtLIn7xHtRePF2isXpZiUnn1uSUYtyjcEdE5t0t5My0s0b2t6y/fDBIQlpM
         RCNBV/BxDFy9HtfS9i95yfrCsDnw95cVhLmW6O/zPdxu5h59dhxSrz9sWH1bWOk0/R1n
         GM6gn1RGrk7jJsiyFNeCL9sxbEAefN6ftGsJC4qYDLtIL8eKIMxapr4nIUBqdY4qsSlb
         FKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756934308; x=1757539108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mI7TKSUM+JpEjaQC9DEoN1DFyPp7yRcHhc8+lHEzoeE=;
        b=rzj0A3grejDuyYA3wfa103Z0NP7nPV45ZA0lUW+yxmhWj/spH4BJQKpKaa6AF/PAbo
         JYXsUEbnCLuuxfJ4t3e8N2uP0aNkU5QFc2HqqT+KTY4JXvByZLXue8ALi1WNXHhUOZaE
         GNB7gr7VIjf/0x2DTNoFxNfXKakRFOx9tZM6+WZZMMBYz77rmDGsOZJalmfkwAYmU+l8
         AIaLD6Epq+XjfUGIh7vmWLBRhH1kLenI5+q+LKD0fOxWi180EmjP1IYOoWYtsw5FR3vR
         N7NBcYRy60iEWdh6yNRez/zC5n8uRuBQMP/1tX/z1q8swqDmFXyJAMQrh3eMQonUJU+E
         hJyg==
X-Forwarded-Encrypted: i=1; AJvYcCWqqK31GoGlf/6hpzmeTBFi3QMTJCOp/8tRsv7did+y8L9398XBGDEkOdzJagRffyPzCk0yOYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Rvq25hUXXRv7Z78jY6KSjqFxsZ73W8Q5IpTO9npYWgB+/0dS
	jTGgQrpmnChH3jM/RJtkru7i9cpmpLRiD64Sr7U86bkDbIJwP34d/HW8hNPym1nClyOrl34IQ43
	U16EBOHUnYn/kgSCsnElvFXnYVJWzvWlZKCiV1P/Yx4/96ETafD40PpgZBNk=
X-Gm-Gg: ASbGncslNc/FMxiVOm6G6kYsS71V0lVIcjqqQc6v7IzbHeYmgQgpTALfde+ljEqCWE+
	KuCzY5yx/oj+e5CDVe2IllXb5MygMeOSQEXFooGeXUj7sJEt8q5PsEclrlr9gWUrth1XTuB0nNj
	8UArQGC/d0dvITQihzlR+gDuGQTpRr56dXGY984bmN4FF1m27Y1dtti65439WUYOSan48XPGhpt
	ZZnw1iXbFwK6ddmaWi0lZaO8E61qMLqjSwFtlHDPR7Y37wnaE4FbEuREt9TQvzkprDYw7WkCqpf
	t0FGDv/vfoU=
X-Google-Smtp-Source: AGHT+IFRVBRinFY9NwZetD9rLJXnkWpA+2FNApQP1Rlk8pNwEJK/dWO7Ad+HI4hUf/UaN+p+//op+FnxCGVoDS20vSc=
X-Received: by 2002:a17:903:ac8:b0:248:9b68:f522 with SMTP id
 d9443c01a7336-24944ac8802mr194781735ad.43.1756934307629; Wed, 03 Sep 2025
 14:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-0-ef3a9eec3ef3@arista.com> <20250903-b4-tcp-ao-md5-rst-finwait2-v4-1-ef3a9eec3ef3@arista.com>
In-Reply-To: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-1-ef3a9eec3ef3@arista.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Sep 2025 14:18:15 -0700
X-Gm-Features: Ac12FXw4GE8aqXLYsJPeO6BXgTvZxQuBi-HlDhexj0vNOuxbcb8LQ19Iwgx4qZk
Message-ID: <CAAVpQUD1mPPFHx+7eVEVJq1xz1S4PJVDcN6FDsVxPy=ehNiV7w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
To: dima@arista.com
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:30=E2=80=AFPM Dmitry Safonov via B4 Relay
<devnull+dima.arista.com@kernel.org> wrote:
>
> From: Dmitry Safonov <dima@arista.com>
>
> Currently there are a couple of minor issues with destroying the keys
> tcp_v4_destroy_sock():
>
> 1. The socket is yet in TCP bind buckets, making it reachable for

nit: s/bind/ehash/


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
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/net/tcp.h   |  4 ++++
>  net/ipv4/tcp.c      | 27 +++++++++++++++++++++++++++
>  net/ipv4/tcp_ipv4.c | 33 ++++++++-------------------------
>  net/ipv6/tcp_ipv6.c |  8 ++++++++
>  4 files changed, 47 insertions(+), 25 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0fb7923b8367..277914c4d067 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1941,6 +1941,7 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk=
,
>  }
>
>  #define tcp_twsk_md5_key(twsk) ((twsk)->tw_md5_key)
> +void tcp_md5_destruct_sock(struct sock *sk);
>  #else
>  static inline struct tcp_md5sig_key *
>  tcp_md5_do_lookup(const struct sock *sk, int l3index,
> @@ -1957,6 +1958,9 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk=
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
> index 40b774b4f587..da8bfa4d2fb8 100644
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
> +               rcu_assign_pointer(tp->md5sig_info, NULL);
> +               call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(tcp_md5_destruct_sock);

EXPORT_IPV6_MOD_GPL() is preferable.

Other than that

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

