Return-Path: <netdev+bounces-85124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084FD899902
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 11:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C011F21368
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B0915FA95;
	Fri,  5 Apr 2024 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqlFZ+KM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351413D265
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308182; cv=none; b=Q4HODzfzEk/XvW/2eoQ/U1Z+7S5bRgK4AoxrUPhNC2uB3P0kX92I/KqMKM4Rd00Rb/oXSDuvuFYORAfhULYlAQzAM/jEp4uuM2mBlEKngAk70uBZ7hO22T4oDrs78/PUOpYQoySOF35YHfEPgM+BeaMQFniOb5V5r4QOGSGwNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308182; c=relaxed/simple;
	bh=8ZiB82lc4w55lS4CVDn4czf3cYeYnGr7AptU892ODW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9tKXU4H3/jeN7wAOgOEzYjv/B9yIxyaiaQFO9QiKUvXpcxkAToy1Ky3ZNnkgZ9F6qVd7AQO3Thvsj0yPUPHv/iYGWbu8J7rP2ei+GvAg36KHNqywZwVgTOGbajjm/3nHCHiFIj6C3X4Y3i8JDSgAvVosJRN+ZWfCDdqQuoJUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqlFZ+KM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51a58aa543so46710866b.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712308179; x=1712912979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V30TeXv17Y7oiveaL5aNlT3fsCOv4Vv0raEFsqMTvKk=;
        b=UqlFZ+KM58Pam4VW9TyJ9Gcua+r7tPXOfeAnAS8x5SObQGWv1iW3Euu8O/bi4DztYS
         mugb1GPIU/dxuw0gc/G6gFbSq1gnHU9veyDdlBVfcXiVeSdAvg1ZNsowKU4t5YGBgQ25
         k7N/M2JMYcUjh+tqrmAlNF4Ijphiu0lMmzobFLtnVHS6poB3hIkvnFISHRvwB57wU81a
         Cw/o1Jcd75uVSj/8jTffah+RzPZR3oACCcbvadL+8w0fvuy837ljdjUFdBwCmcKiSAhT
         sHCxv7+vzwI3tV+AqrhIjRn3oIXmI+7b1akrCezqqOlNlXzbYOzj2qHxtkcde9scPJC6
         JiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308179; x=1712912979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V30TeXv17Y7oiveaL5aNlT3fsCOv4Vv0raEFsqMTvKk=;
        b=NW5863uTGMAiOJHYCfMnfJ5oy5oJNPZVXB32vsk+uinFg5LTfHveCtP4theO+8wZZl
         PE5hgxuQKPiGMtY9a2fuvCMKLNZ0xusYROGTC1Wjp8yq0E0RriPde19mSFPpn+HGESwj
         3YzjemuvKxA1/VfdBrpClWRFuN0eeeFDIyKlZUD9PHjpt4o5V3yWEdlm/WdUgyb9ItWZ
         uF+RsoGZsyLVi/b4iFlye/lKvc1zTpEbMKW89iqRhB3SClPpOVHum6IdTqqMwzKqciFc
         qtP4F0gea6B8WcsR2TMgZW6ZEx35MGSMRWEVCzxRQKsf3qFd4EjXQogHv/EP36AdHMOO
         fEOA==
X-Forwarded-Encrypted: i=1; AJvYcCUGavZeQT8NRgvAkHH4DNnhOb/o4acAML7FcjepOAcQRQ61ta2cVllDxmb+BZCYjUz8czgYA7SJrStT1o1EEjsO+xrwcLxQ
X-Gm-Message-State: AOJu0YzGUmarS84qLn2MiVXWHpy+QosQqdd5Pmak8yu2uFZMZVOf9a6h
	OCDasrACfYlk8TJalbHX0lK5IRvB7SlUTyS8QHqIe0cYfImBccV7Whv6Psp3m/42tfoKRxUzQt7
	rTde0FklHk0Ztl7bpbpOxf2lz6xM=
X-Google-Smtp-Source: AGHT+IFyFsnMNwqHFq9N6zBtE4chgza0wdbrt59ANAMn2j7ODHSEy8XB/l0Fll9ATia7JJUsW0jBJ2/638MyyhCc7HM=
X-Received: by 2002:a17:906:35c7:b0:a4d:f9af:a749 with SMTP id
 p7-20020a17090635c700b00a4df9afa749mr591014ejb.34.1712308178817; Fri, 05 Apr
 2024 02:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405023914.54872-1-kerneljasonxing@gmail.com>
 <20240405023914.54872-3-kerneljasonxing@gmail.com> <5046e1867c65f39e07822beb0a19a22743b1064b.camel@redhat.com>
In-Reply-To: <5046e1867c65f39e07822beb0a19a22743b1064b.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 17:09:01 +0800
Message-ID: <CAL+tcoCSf=Gd1c_LiN1Bk5xKnJ92_NHyWRDTLEW80LzpSr7okg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] mptcp: add reset reason options in some places
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 4:16=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Fri, 2024-04-05 at 10:39 +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The reason codes are handled in two ways nowadays (quoting Mat Martinea=
u):
> > 1. Sending in the MPTCP option on RST packets when there is no subflow
> > context available (these use subflow_add_reset_reason() and directly ca=
ll
> > a TCP-level send_reset function)
> > 2. The "normal" way via subflow->reset_reason. This will propagate to b=
oth
> > the outgoing reset packet and to a local path manager process via netli=
nk
> > in mptcp_event_sub_closed()
> >
> > RFC 8684 defines the skb reset reason behaviour which is not required
> > even though in some places:
> >
> >     A host sends a TCP RST in order to close a subflow or reject
> >     an attempt to open a subflow (MP_JOIN). In order to let the
> >     receiving host know why a subflow is being closed or rejected,
> >     the TCP RST packet MAY include the MP_TCPRST option (Figure 15).
> >     The host MAY use this information to decide, for example, whether
> >     it tries to re-establish the subflow immediately, later, or never.
> >
> > Since the commit dc87efdb1a5cd ("mptcp: add mptcp reset option support"=
)
> > introduced this feature about three years ago, we can fully use it.
> > There remains some places where we could insert reason into skb as
> > we can see in this patch.
> >
> > Many thanks to Mat for help:)
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/mptcp/subflow.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 1626dd20c68f..49f746d91884 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -301,8 +301,13 @@ static struct dst_entry *subflow_v4_route_req(cons=
t struct sock *sk,
> >               return dst;
> >
> >       dst_release(dst);
> > -     if (!req->syncookie)
> > +     if (!req->syncookie) {
> > +             struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> > +
> > +             if (mpext)
> > +                     subflow_add_reset_reason(skb, mpext->reset_reason=
);
>
> uhm? subflow_add_reset_reason() will do:
>
>         mptcp_ext_add(skb)->reset_reason =3D mpext->reset_reason
>
> The above looks like a no-op.

Ah, my bad. Actually I didn't add the mpext test statement in my original p=
atch.

Yes, you're right. The 'if (mpext)' is totally unnecessary.

>
> Possibly we should instead ensure that subflow_check_req() calls
> subflow_add_reset_reason() with reasonable arguments on all the error
> paths?!?

Absolutely yes, it would be great. The reason I didn't touch them is
I'm still studying how to specify the error kind.

>
> Something alike the (completely untested) following
>
> Cheers,
>
> Paolo
> ---
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6042a47da61b..298c6342a78c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -150,8 +150,10 @@ static int subflow_check_req(struct request_sock *re=
q,
>         /* no MPTCP if MD5SIG is enabled on this socket or we may run out=
 of
>          * TCP option space.
>          */
> -       if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
> +       if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
> +               subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
>                 return -EINVAL;
> +       }
>  #endif
>
>         mptcp_get_options(skb, &mp_opt);
> @@ -219,6 +221,7 @@ static int subflow_check_req(struct request_sock *req=
,
>                                  ntohs(inet_sk((struct sock *)subflow_req=
->msk)->inet_sport));
>                         if (!mptcp_pm_sport_in_anno_list(subflow_req->msk=
, sk_listener)) {
>                                 SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISM=
ATCHPORTSYNRX);
> +                               subflow_add_reset_reason(skb, MPTCP_RST_E=
PROHIBIT);
>                                 return -EPERM;
>                         }
>                         SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNR=
X);
> @@ -227,10 +230,12 @@ static int subflow_check_req(struct request_sock *r=
eq,
>                 subflow_req_create_thmac(subflow_req);
>
>                 if (unlikely(req->syncookie)) {
> -                       if (mptcp_can_accept_new_subflow(subflow_req->msk=
))
> -                               subflow_init_req_cookie_join_save(subflow=
_req, skb);
> -                       else
> +                       if (!mptcp_can_accept_new_subflow(subflow_req->ms=
k)) {
> +                               subflow_add_reset_reason(skb, MPTCP_RST_E=
PROHIBIT);
>                                 return -EPERM;
> +                       }
> +
> +                       subflow_init_req_cookie_join_save(subflow_req, sk=
b);
>                 }
>
>                 pr_debug("token=3D%u, remote_nonce=3D%u msk=3D%p", subflo=
w_req->token,
>

Great! You complete it! Thanks for your instructions.

I'll test it and update it soon.

Thanks,
Jason

