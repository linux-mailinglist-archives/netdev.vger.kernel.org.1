Return-Path: <netdev+bounces-169410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93673A43BFC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A41C16707D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD4719F40A;
	Tue, 25 Feb 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxKilS6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045611A9B23
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479967; cv=none; b=kVI97QcesH8rjovB5uWBS8dHiQOdjEVmDOUPZUjQVhbimKYrSpnGC8A8KuC40b/r/NYL9dLeg7rCx+K9g55ENzkHN3TdBkBaZUGInZp+E6Qs/T/hvMhE7R4Qti/ptE+fXun3MqaYrYaAl7yjDb0JaLeaMcnnkxHc7cDA8mAsuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479967; c=relaxed/simple;
	bh=jm1TjXNr0HlBiVfJn47CrMr+vK8LC4djhV7IHSFSZ2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9qMola8qNyRyFQ8apJmI2vQc+fUeOVygAJQkWtNY5clbdJdod5PmUwODZ2XY9QlEtGMbv8vPsmL4h+DLxohiTzpRamkOH3W0DOoIXTEphQUOxq/9oiq7JiJE85IYyzsqgQjEI1HVdN9O/YSw2Yzd+bSctNJQ3d1aOfhynbXgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TxKilS6B; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so7800362a12.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740479964; x=1741084764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQvgarxE6qbBAglzXeEWKk7oj1+TSwuqcucbwvIr4Tk=;
        b=TxKilS6BqdlqTn/gBP0XEumxQCSpK3/DZS/HdraF/41N3pTYUHCT3TaXapMxaoQyqP
         Mlh/qu2qytgomfof3+z+0wt2/OmaYKu0tFMjkvxnjSBNdcWDnvQ06TqEgk3BHa40uv3u
         cOUQQflHxWeU8JUp/eXhsDiNV/XyK6oQfcmtKPiqCGBU/SS+7/Di0yRokmz+j4eVfWsA
         JuMPQYml4Y2ozmhPJhdlu5DdXDVRWsf1TG3b4DqvVKW0UOJZsVzRSCccEQ37pvubFX1K
         cTuZWob/6F7cHaSmWm1+zi/kWxHoRwso1OqfcqtwqHcgpWMa/aTXhsx8ZDtbdS4rkNay
         1HYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479964; x=1741084764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQvgarxE6qbBAglzXeEWKk7oj1+TSwuqcucbwvIr4Tk=;
        b=LCPIS6QGiqkwiw69cilsWDgdzDON2Y/GIV9LSPc48H6zOZGREZgvCK+jauEWiSJn4n
         NrwCtlcK9WPk4dwn+gtFrvRO0+pZIYK1ApZ53F44X19X2E+46t2NLtKsGMFmZ3WARJTx
         Ppwel0hwynh+TH+PCVyA7ivLZDlWKMRpIyq8/nlgmFje3fNHoXhnmuZ6U3fGKDjetcTN
         3HfLBoMweAAV+EwCV6NzN+a01RaRzxvC08WyrTbIeY95WGe15vBqz0rU0Qa+dM91HCns
         12uEqZNMFHfP+YrghmLaRqnso/fYmcqsFr/++ax0L6FuTjselpXyVpaYgnR1SA/3bH4K
         RhEA==
X-Forwarded-Encrypted: i=1; AJvYcCWvuqDLxiLucr5KMa0AbIDQTlYFnClXmkpAe1HNo6L11vqZASKCpgd8oE0OVIcnLFw1YQGM/Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkafGyAmOK4g/6oRW3aqhk8+hApOKA1KxbBq6zZqGFZhvo7vXi
	bqiNUarfdkqITl5j/jh43ymfcZdsS9MrZMVUNRmXLXwRI56eZZl6R5teqWaDgVTBsfRgKQkvfY8
	F6RmmsTapdUWGb0JRq2GDkQKhwl9RYkRKjxEN
X-Gm-Gg: ASbGncv+4TdsFz2kQJqLA7HzY8Gmr+Cs+NinzN7gy93wM7JNzWqYWnV2JjmbzClTTXu
	a0LT6zi03WeXaUKNzBW55hMNkGwmlcMmogfxKVGN6Q56kkMk7Vaz2Tz2v5sEALd663axP8cBhqr
	luG/edC01a
X-Google-Smtp-Source: AGHT+IEDolVoYCFia/B0gFZC1jhe+GO0QlTEYFs0h0OLos3pexFs2RV2Vlvce2zWoqo+o5t0/hhpdWOov4SR8jrcUs8=
X-Received: by 2002:a05:6402:3554:b0:5dc:5a34:1296 with SMTP id
 4fb4d7f45d1cf-5e0b70ef77dmr16960043a12.16.1740479964055; Tue, 25 Feb 2025
 02:39:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224110654.707639-1-edumazet@google.com> <4f37d18c-6152-42cf-9d25-98abb5cd9584@redhat.com>
 <af310ccd-3b5f-4046-b8d7-ab38b76d4bde@kernel.org> <CANn89iJfXJi7CL2ekBo9Zn9KtVTRxwMCZiSxdC21uNfkdNU1Jg@mail.gmail.com>
 <927c8b04-5944-4577-b6bd-3fc50ef55e7e@kernel.org> <CANn89iJu5dPMF3BFN7bbNZR-zZF_xjxGqstHucmBc3EvcKZXJw@mail.gmail.com>
 <40fcf43d-b9c2-439a-9375-d2ff78be203f@kernel.org> <CANn89iLH_SgpWgAXvDjRbpFtVjWS-yLSiX0FbCweWjAJgzaASg@mail.gmail.com>
In-Reply-To: <CANn89iLH_SgpWgAXvDjRbpFtVjWS-yLSiX0FbCweWjAJgzaASg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Feb 2025 11:39:12 +0100
X-Gm-Features: AQ5f1JoTggoBXFS8VT_6EJkWtK6P3pHPX7YpChuS5tjYS6ASNnbm4ayst5hJqB4
Message-ID: <CANn89i+Zs2bLC7h2N5v15Xh=aTWdoa3v2d_A-EvRirsnFEPgwQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: be less liberal in tsecr received while in
 SYN_RECV state
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Jakub Kicinski <kuba@kernel.org>, 
	Yong-Hao Zou <yonghaoz1994@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:37=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Feb 25, 2025 at 11:33=E2=80=AFAM Matthieu Baerts <matttbe@kernel.=
org> wrote:
> >
> > On 25/02/2025 11:21, Eric Dumazet wrote:
> > > On Tue, Feb 25, 2025 at 11:19=E2=80=AFAM Matthieu Baerts <matttbe@ker=
nel.org> wrote:
> > >>
> > >> Hi Eric,
> > >>
> > >> On 25/02/2025 11:11, Eric Dumazet wrote:
> > >>> On Tue, Feb 25, 2025 at 11:09=E2=80=AFAM Matthieu Baerts <matttbe@k=
ernel.org> wrote:
> > >>>>
> > >>>> Hi Paolo, Eric,
> > >>>>
> > >>>> On 25/02/2025 10:59, Paolo Abeni wrote:
> > >>>>> On 2/24/25 12:06 PM, Eric Dumazet wrote:
> > >>>>>> Yong-Hao Zou mentioned that linux was not strict as other OS in =
3WHS,
> > >>>>>> for flows using TCP TS option (RFC 7323)
> > >>>>>>
> > >>>>>> As hinted by an old comment in tcp_check_req(),
> > >>>>>> we can check the TSecr value in the incoming packet corresponds
> > >>>>>> to one of the SYNACK TSval values we have sent.
> > >>>>>>
> > >>>>>> In this patch, I record the oldest and most recent values
> > >>>>>> that SYNACK packets have used.
> > >>>>>>
> > >>>>>> Send a challenge ACK if we receive a TSecr outside
> > >>>>>> of this range, and increase a new SNMP counter.
> > >>>>>>
> > >>>>>> nstat -az | grep TcpExtTSECR_Rejected
> > >>>>>> TcpExtTSECR_Rejected            0                  0.0
> > >>>>
> > >>>> (...)
> > >>>>
> > >>>>> It looks like this change causes mptcp self-test failures:
> > >>>>>
> > >>>>> https://netdev-3.bots.linux.dev/vmksft-mptcp/results/6642/1-mptcp=
-join-sh/stdout
> > >>>>>
> > >>>>> ipv6 subflows creation fails due to the added check:
> > >>>>>
> > >>>>> # TcpExtTSECR_Rejected            3                  0.0
> > >>>>
> > >>>> You have been faster to report the issue :-)
> > >>>>
> > >>>>> (for unknown reasons the ipv4 variant of the test is successful)
> > >>>>
> > >>>> Please note that it is not the first time the MPTCP test suite cau=
ght
> > >>>> issues with the IPv6 stack. It is likely possible the IPv6 stack i=
s less
> > >>>> covered than the v4 one in the net selftests. (Even if I guess her=
e the
> > >>>> issue is only on MPTCP side.)
> > >>>
> > >>>
> > >>> subflow_prep_synack() does :
> > >>>
> > >>>  /* clear tstamp_ok, as needed depending on cookie */
> > >>> if (foc && foc->len > -1)
> > >>>      ireq->tstamp_ok =3D 0;
> > >>>
> > >>> I will double check fastopen code then.
> > >>
> > >> Fastopen is not used in the failing tests. To be honest, it is not c=
lear
> > >> to me why only the two tests I mentioned are failing, they are many
> > >> other tests using IPv6 in the MP_JOIN.
> > >
> > > Yet, clearing tstamp_ok might be key here.
> > >
> > > Apparently tcp_check_req() can get a non zero tmp_opt.rcv_tsecr even
> > > if tstamp_ok has been cleared at SYNACK generation.
> >
> > Good point. But in the tests, it is not suppose to clear the timestamps=
.
> >
> > (Of course, when I take a capture, I cannot reproduce the issue :) )
> >
> > >
> > > I would test :
> > >
> > > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > > index a87ab5c693b524aa6a324afe5bf5ff0498e528cc..0ed27f5c923edafdf4891=
9600491eb1cb50bc913
> > > 100644
> > > --- a/net/ipv4/tcp_minisocks.c
> > > +++ b/net/ipv4/tcp_minisocks.c
> > > @@ -674,7 +674,8 @@ struct sock *tcp_check_req(struct sock *sk, struc=
t
> > > sk_buff *skb,
> > >                 if (tmp_opt.saw_tstamp) {
> > >                         tmp_opt.ts_recent =3D READ_ONCE(req->ts_recen=
t);
> > >                         if (tmp_opt.rcv_tsecr) {
> > > -                               tsecr_reject =3D !between(tmp_opt.rcv=
_tsecr,
> > > +                               if (inet_rsk(req)->tstamp_ok)
> > > +                                       tsecr_reject =3D
> > > !between(tmp_opt.rcv_tsecr,
> > >
> > > tcp_rsk(req)->snt_tsval_first,
> > >
> > > READ_ONCE(tcp_rsk(req)->snt_tsval_last));
> > >                                 tmp_opt.rcv_tsecr -=3D tcp_rsk(req)->=
ts_off;
> > Thank you for the suggestion. It doesn't look to be that, I can still
> > reproduce the issue.
> >
> > If I print the different TS (rcv, snt first, snt last) when tsecr_rejec=
t
> > is set, I get this:
> >
> > [  227.984292] mattt: 2776726299 2776727335 2776727335
> > [  227.984684] mattt: 2776726299 2776727335 2776727335
> > [  227.984771] mattt: 3603918977 3603920020 3603920020
> > [  227.984896] mattt: 3603918977 3603920020 3603920020
> > [  230.031921] mattt: 3603918977 3603920020 3603922068
> > [  230.032283] mattt: 2776726299 2776727335 2776729383
> > [  230.032554] mattt: 2776729384 2776727335 2776729383
> >       ack rx                [FAIL] got 0 JOIN[s] ack rx expected 2
>
> req->num_timeout might not be updated where I thought it was.


Yes, this would be it :

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 728bce01ccd3ddb1f374fa96b86434a415dbe2cb..3555567ba4fb1ccd5c5921e39d1=
1ff08f1d0cafd
100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -477,8 +477,8 @@ static void tcp_fastopen_synack_timer(struct sock
*sk, struct request_sock *req)
         * regular retransmit because if the child socket has been accepted
         * it's not good to give up too easily.
         */
-       inet_rtx_syn_ack(sk, req);
        req->num_timeout++;
+       inet_rtx_syn_ack(sk, req);
        tcp_update_rto_stats(sk);
        if (!tp->retrans_stamp)
                tp->retrans_stamp =3D tcp_time_stamp_ts(tp);

