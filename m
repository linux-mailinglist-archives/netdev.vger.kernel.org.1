Return-Path: <netdev+bounces-101440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8458FE9D7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE401F2713F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A8198E63;
	Thu,  6 Jun 2024 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceBZO1xW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21519B5B0;
	Thu,  6 Jun 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683072; cv=none; b=icv+JIMx7oQWDUb1L9v/4IEkr1KmZJG2TeKO2WhXfjV8ibNcq71Pvw/hk3lLaOCQeCxhpuxiaIu6O4q1gQdIpqIUPog+DlOoMvpkHo4xGd0JJ+bZhLy7SjBdw9u/yYFLOnkwdNvLPi/uRjl+LB0ZlYTK3athUHEDK1AilOvep8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683072; c=relaxed/simple;
	bh=fcBQjYioVUltQGvCZYRZa8rLmNoWhnsqh/6yL9atVp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBV/BHw290J2twNN70jX1NcKB10JkOotXVAdnwdf8/ULc4b0jPT46gKuRaVkJeEr2r0GrTrbTVdZipeExf20JZjEsVH7yggDs96mqbce00Yc9R/kH1v656whK1s1V6s2EvWiERTFzcvY4W27r9NKzxFndtEcYG3LpoUQK1lyf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceBZO1xW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f63642ab8aso9428395ad.3;
        Thu, 06 Jun 2024 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717683070; x=1718287870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR3SI/2MLA0reUuRphqbW0P2EIeFEX7Al2MMDtpbjzY=;
        b=ceBZO1xW4C1ea7aNw0k3euxlOvK7h74PQ87Eb/4sO6viGOsyvVAQsRMq8yuu4UTDkX
         gtepZci1Oj4j6j8UIjzieyzjq8gwKcKdd4cyQheiYleDVrSqjOYw5+cveXIvQc+0gjOk
         pBn9QtkwVtvwWfn+d/HKoHFt589DLPz5hwNpy5kBAudGDQDAVzk2hMNq08DUHA0l0Z5f
         l1HAQum6cEOw01gxqzBaNjXPJrTFz1KevTq/C0frVtpluQqHOm/XZvRHkdtf1oRYf1bm
         pQgvw3m56tF0M3VnUoc9spgE3d17WbWpNcQfy/q/fn2Qr/wzkqF4fGzaNIcp+mrfrEdl
         +JBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683070; x=1718287870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kR3SI/2MLA0reUuRphqbW0P2EIeFEX7Al2MMDtpbjzY=;
        b=qDjrMnKFkCkEqGFmScYzvv26gvctQSNh0HpCUcblLPj8PNa2/gcALo/tXBE79EMPLi
         K9CllFbL9odjxsjcM8GSRgbW1xaYnnXFS8JFPB3oXArzcHBK8xD5FZqJh2HjCWzRhTSg
         NKGpicq8aVSJYMntD7AtjpNmFb71yy39kGGMqxjHUzSa1gvFkTosT/NPlbQuzNINtMQ8
         s60tat1/XIpt0I9ehJbrUJVqCrfibsA69xjv0UeIk94sZGoYG/5eWEFf17dmNb9RDXHF
         nUzpkMIEM0ZQFYQTaEK5vpOBcUKssmlordr+y2AHM3GpII1zFrHtn7u+dlWzwefZ3Qe3
         NF+A==
X-Forwarded-Encrypted: i=1; AJvYcCU8HYMmNfVnToS5i80giECOga+RkGDMh7fonWBdXjN4JZKHtOSAwHr8OMQObL+Um6/wL3rqoCAhmRMt/CCCCFZIEPECKTDyYpi9MpCfeBcFpSg/N10xBaNpsFoodxMdisBxu/sy7DVGNV3iHgaIcx4VpdOK/EaqIZKwBaJ3Fi0x9YbTX1cJlnZlSexOppaNZUjN1GgigU+JuxIhPVt4FqepeO3Z
X-Gm-Message-State: AOJu0YxBxADGVIH+XtzbBC5WkfZB5tYQ/nHOme5T1kRf4+jAS4liIypp
	UG5ljOOf10M4qWj3w/JtC2ZnvquY1m7f5FiZNGnd/S2GoWdwmx8641pZ0KSDaIlINDEWWtp0ZQr
	sLnlyvnwNP0HQU6UbqAcMeg7F0MQ=
X-Google-Smtp-Source: AGHT+IENoX1Lgfbq+QM42oL4DR+kk/tMO4gvcmL0LAo6bkbFqSRadnxhf6EfvMJ1fy/O3tEd+g1vZ1ytDUG+ig1f23E=
X-Received: by 2002:a17:903:2303:b0:1f6:3d8:cc09 with SMTP id
 d9443c01a7336-1f6a5a5c7e0mr68656045ad.45.1717683069513; Thu, 06 Jun 2024
 07:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com>
 <20240606-tcp_ao-tracepoints-v3-3-13621988c09f@gmail.com> <92c1cb53-ec2b-4153-b97d-c2b8c0fdfaf2@kernel.org>
In-Reply-To: <92c1cb53-ec2b-4153-b97d-c2b8c0fdfaf2@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 6 Jun 2024 15:10:55 +0100
Message-ID: <CAJwJo6akA4Oi2457qP-cK=Gi1hVLThwye6odgb7OuJZk1f119g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] net/tcp: Move tcp_inbound_hash() from headers
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

[re-sending as replying from mobile phone never works in plain text]

On Thu, 6 Jun 2024 at 10:12, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi Dmitry,
>
> On 06/06/2024 02:58, Dmitry Safonov via B4 Relay wrote:
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > Two reasons:
> > 1. It's grown up enough
> > 2. In order to not do header spaghetti by including
> >    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
> >
> > While at it, unexport and make static tcp_inbound_ao_hash().
>
> Thank you for working on this.
>  > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> > ---
> >  include/net/tcp.h | 78 +++--------------------------------------------=
--------
> >  net/ipv4/tcp.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 68 insertions(+), 76 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index e5427b05129b..2aac11e7e1cc 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1863,12 +1863,6 @@ tcp_md5_do_lookup_any_l3index(const struct sock =
*sk,
> >       return __tcp_md5_do_lookup(sk, 0, addr, family, true);
> >  }
> >
> > -enum skb_drop_reason
> > -tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
> > -                  const void *saddr, const void *daddr,
> > -                  int family, int l3index, const __u8 *hash_location);
> > -
> > -
> >  #define tcp_twsk_md5_key(twsk)       ((twsk)->tw_md5_key)
> >  #else
> >  static inline struct tcp_md5sig_key *
> > @@ -1885,13 +1879,6 @@ tcp_md5_do_lookup_any_l3index(const struct sock =
*sk,
> >       return NULL;
> >  }
> >
> > -static inline enum skb_drop_reason
> > -tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
> > -                  const void *saddr, const void *daddr,
> > -                  int family, int l3index, const __u8 *hash_location)
> > -{
> > -     return SKB_NOT_DROPPED_YET;
> > -}
>
> It looks like this no-op is still needed, please see below.
>
> >  #define tcp_twsk_md5_key(twsk)       NULL
> >  #endif
> >
>
> (...)
>
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index fa43aaacd92b..80ed5c099f11 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -4456,7 +4456,7 @@ int tcp_md5_hash_key(struct tcp_sigpool *hp,
> >  EXPORT_SYMBOL(tcp_md5_hash_key);
> >
> >  /* Called with rcu_read_lock() */
> > -enum skb_drop_reason
> > +static enum skb_drop_reason
> >  tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
> >                    const void *saddr, const void *daddr,
> >                    int family, int l3index, const __u8 *hash_location)
> > @@ -4510,10 +4510,72 @@ tcp_inbound_md5_hash(const struct sock *sk, con=
st struct sk_buff *skb,
> >       }
> >       return SKB_NOT_DROPPED_YET;
> >  }
> > -EXPORT_SYMBOL(tcp_inbound_md5_hash);
> >
> >  #endif
> >
> > +/* Called with rcu_read_lock() */
> > +enum skb_drop_reason
> > +tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
> > +              const struct sk_buff *skb,
> > +              const void *saddr, const void *daddr,
> > +              int family, int dif, int sdif)
> > +{
> > +     const struct tcphdr *th =3D tcp_hdr(skb);
> > +     const struct tcp_ao_hdr *aoh;
> > +     const __u8 *md5_location;
> > +     int l3index;
> > +
> > +     /* Invalid option or two times meet any of auth options */
> > +     if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
> > +             tcp_hash_fail("TCP segment has incorrect auth options set=
",
> > +                           family, skb, "");
> > +             return SKB_DROP_REASON_TCP_AUTH_HDR;
> > +     }
> > +
> > +     if (req) {
> > +             if (tcp_rsk_used_ao(req) !=3D !!aoh) {
> > +                     NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
> > +                     tcp_hash_fail("TCP connection can't start/end usi=
ng TCP-AO",
> > +                                   family, skb, "%s",
> > +                                   !aoh ? "missing AO" : "AO signed");
> > +                     return SKB_DROP_REASON_TCP_AOFAILURE;
> > +             }
> > +     }
> > +
> > +     /* sdif set, means packet ingressed via a device
> > +      * in an L3 domain and dif is set to the l3mdev
> > +      */
> > +     l3index =3D sdif ? dif : 0;
> > +
> > +     /* Fast path: unsigned segments */
> > +     if (likely(!md5_location && !aoh)) {
> > +             /* Drop if there's TCP-MD5 or TCP-AO key with any rcvid/s=
ndid
> > +              * for the remote peer. On TCP-AO established connection
> > +              * the last key is impossible to remove, so there's
> > +              * always at least one current_key.
> > +              */
> > +             if (tcp_ao_required(sk, saddr, family, l3index, true)) {
> > +                     tcp_hash_fail("AO hash is required, but not found=
",
> > +                                   family, skb, "L3 index %d", l3index=
);
> > +                     return SKB_DROP_REASON_TCP_AONOTFOUND;
> > +             }
> > +             if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family=
))) {
> > +                     NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFO=
UND);
> > +                     tcp_hash_fail("MD5 Hash not found",
> > +                                   family, skb, "L3 index %d", l3index=
);
> > +                     return SKB_DROP_REASON_TCP_MD5NOTFOUND;
> > +             }
> > +             return SKB_NOT_DROPPED_YET;
> > +     }
> > +
> > +     if (aoh)
> > +             return tcp_inbound_ao_hash(sk, skb, family, req, l3index,=
 aoh);
> > +
> > +     return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
> > +                                 l3index, md5_location);
>
> Many selftests are currently failing [1] because of this line: if
> CONFIG_TCP_MD5SIG is not defined -- which is currently the case in many
> selftests: tc, mptcp, forwarding, netfilter, drivers, etc. -- then this
> tcp_inbound_md5_hash() function is not defined:
>
> > net/ipv4/tcp.c: In function =E2=80=98tcp_inbound_hash=E2=80=99:
> > net/ipv4/tcp.c:4570:16: error: implicit declaration of function =E2=80=
=98tcp_inbound_md5_hash=E2=80=99; did you mean =E2=80=98tcp_inbound_ao_hash=
=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >  4570 |         return tcp_inbound_md5_hash(sk, skb, saddr, daddr, fami=
ly,
> >       |                ^~~~~~~~~~~~~~~~~~~~
> >       |                tcp_inbound_ao_hash
>
> Do you (or any maintainers) mind replying to this email with this line
> [2] so future builds from the CI will no longer pick-up this series?
>
> pw-bot: changes-requested

Ugh, it seems I can falter on a plain place.
I should have rechecked this for v3.

pw-bot: changes-requested

Thanks for the report,
           Dmitry

