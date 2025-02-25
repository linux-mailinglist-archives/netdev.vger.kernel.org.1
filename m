Return-Path: <netdev+bounces-169534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FC5A447B2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083671894CC2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9131990AB;
	Tue, 25 Feb 2025 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaBvy0/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F518EFDE
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503508; cv=none; b=AmKZWMiotB5cEB7d7IP6MqwK9xvl/99mhKbU5+ESmRyfE1UHKhRdHsE59+XniuhC4n+8hZwcPkvKWgoYGywa92ns2GBL7B4PANDZHZcRmDpQKxOJA7PbonPopv0yjPdNzOWyUyNXAPCqUpNoIf0sMib1jitnzYmUrm/jv+cxBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503508; c=relaxed/simple;
	bh=dq2HwDMFJbfHqz3LWRh4ZbB/3CnluR4KT6ZtqjY+8qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fb5n3ltr56vMAxgL5VPDyebw38+yq4lUxWAUBpynS3cADisIVWo2jS5ifI+OXfRZUlN5fa6Sghm0kZ8bMBfxWr6EulWBEK95d9v8AOgIKdM63vWQGEq3lgFfShwBtQUPEd0d3e7MpwXp+1u2X8+VgInaYjNq0bfI9eH/FvNhaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaBvy0/h; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so10921340a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740503505; x=1741108305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX/UFQKVxNWtqobGwPugKP6hUKAYPzOjGX8S5OEysSc=;
        b=UaBvy0/hOrr6lNNoE4mnrPhnmEosjvy+LOCkq2m+loF6YmXSs3lU0erFRlC1HA84FV
         SqXIEgfImDwMJlxXsCcn3mo3C4lu9+z7frapZnkdpFzmMb5UK2yqLz7u1hR4DPxdqfJ5
         V1c0gYKs5pB+/qqNOOdwZ7xMgXWsD2drW0440+4O1BrISfb8YE7KvauWmBMCVhWX3CDA
         SQ8qcVySuFoqnFvPJ2HStO2oyiV7W2sc+/3ZtDtlNREreEp8Czz4KUD6cxLkthBV2oq4
         ug2sqQzcUzELUhZyP9upuqT4IYsKpI9RHLEsUmiHvSS+PrCMBCLMnj0eg1M3ZlK1us4d
         Stjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503505; x=1741108305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PX/UFQKVxNWtqobGwPugKP6hUKAYPzOjGX8S5OEysSc=;
        b=TuFEnwRisUgmVW6nvmUj/EqpYlATtrxPFEN5N9ujOcCAiyZphk2boCjyLvi0km5Io9
         CRkr7N+6LSPsU8OFE9aqzCcRNLKNXaDZi4FbDt4083sr2axJW9S7jyMrm2NlTkx42S+u
         xaEcahq1uZ6cZLpfMa1PATITdyFrZEcAJm4Q3fODsgb5fp5LjHQfGWIq0wbQVlExkrb8
         qbNPC9efmSlbaAr8t9COhQBJlmQicNOqYFdvToPeLmp17wkK66kF3AuPYXvB66le+3gW
         u7CTpZwH1FF3kogHNkVWXL2aOP+wKEvLSikeI3ClESRikjdNegJpwC1uOkciqs+ddQ9a
         l5qw==
X-Forwarded-Encrypted: i=1; AJvYcCXgvSs+q00XN/0H2ziRZlT7LPr7I7KPXfmphDo5xSwng7gf8WwpdA4ThkKbnKzeBb1tXlqGABA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoKRrJRS9DdX5FSSoleGGWLU8mbd5n+oGTICGIFreiiWEW3UhH
	4Wi6HskBJz7hv3xJj2J+2TuJiDkzW8HyYj5JtVB2r72r9x6r4vXQX0ujYi2gO+NwEXJQZgnx8O6
	JTDmiHgnFPXSTEmT22RTrGS8Dtl3pwPui1HgA
X-Gm-Gg: ASbGnctQ8FsYwnp52jtS2xOvbvKkAwf0vl4rJZ2i6zcTxeY+by8AigjajJVjegpal6X
	vZb4HUhwxUyM8CQCCdWF4N2pUK56bDCOvOMh6uE5CfjQo9Rboli2kDId/j/FOMY2NmPpSDt6Nqa
	faZs7sZwAF
X-Google-Smtp-Source: AGHT+IGsOEhrfZVReRZTEF4NkZzFeIsFEDSTlB+bI/9s/lG7ORr51aPs/QdT4me0mcXlPNX/RYv+/Z2DiP+DvwpRb9Y=
X-Received: by 2002:a05:6402:3512:b0:5e0:51a9:d410 with SMTP id
 4fb4d7f45d1cf-5e44a254ae9mr3760745a12.25.1740503504578; Tue, 25 Feb 2025
 09:11:44 -0800 (PST)
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
 <CANn89i+Zs2bLC7h2N5v15Xh=aTWdoa3v2d_A-EvRirsnFEPgwQ@mail.gmail.com>
 <CANn89iLf5hOnT=T+a9+msJ7=atWMMZQ+3syG75-8Nih8_MwHmw@mail.gmail.com>
 <8beaf62e-6257-452d-904a-fec6b21c891e@kernel.org> <CANn89i+3M1bJf=gXMH1zK3LiR-=XMRPe+qR8HNu94o2Xzm4vQQ@mail.gmail.com>
 <f970e46e-7153-4000-beef-f2d621998a8e@kernel.org>
In-Reply-To: <f970e46e-7153-4000-beef-f2d621998a8e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Feb 2025 18:11:31 +0100
X-Gm-Features: AQ5f1JpwV6D95WYtE2WrzXfOdCefExP5LHMfufMmiQhLxErk4-C-1aKdSZTDu5A
Message-ID: <CANn89iLZSO+Swf78jV0mc9jLUFLiqOtcjbTWsoYmdr=jn0SUxg@mail.gmail.com>
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

On Tue, Feb 25, 2025 at 5:56=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> On 25/02/2025 11:51, Eric Dumazet wrote:
> > On Tue, Feb 25, 2025 at 11:48=E2=80=AFAM Matthieu Baerts <matttbe@kerne=
l.org> wrote:
> >>
> >> On 25/02/2025 11:42, Eric Dumazet wrote:
> >>> On Tue, Feb 25, 2025 at 11:39=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> >>>>
> >>>
> >>>>
> >>>> Yes, this would be it :
> >>>>
> >>>> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> >>>> index 728bce01ccd3ddb1f374fa96b86434a415dbe2cb..3555567ba4fb1ccd5c59=
21e39d11ff08f1d0cafd
> >>>> 100644
> >>>> --- a/net/ipv4/tcp_timer.c
> >>>> +++ b/net/ipv4/tcp_timer.c
> >>>> @@ -477,8 +477,8 @@ static void tcp_fastopen_synack_timer(struct soc=
k
> >>>> *sk, struct request_sock *req)
> >>>>          * regular retransmit because if the child socket has been a=
ccepted
> >>>>          * it's not good to give up too easily.
> >>>>          */
> >>>> -       inet_rtx_syn_ack(sk, req);
> >>>>         req->num_timeout++;
> >>>> +       inet_rtx_syn_ack(sk, req);
> >>>>         tcp_update_rto_stats(sk);
> >>>>         if (!tp->retrans_stamp)
> >>>>                 tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
> >>>
> >>> Obviously, I need to refine the patch and send a V2 later.
> >>
> >> Sorry, I still have the issue with this modification. I also checked
> >> with the previous patch, just to be sure, but the problem is still the=
re
> >> as well.
> >
> > I said "req->num_timeout" is not updated where I thought it was.
>
> I think that in case of SYN+ACK retransmission, req->num_timeout is
> incremented after tcp_synack_options():
>
>   reqsk_timer_handler()
>   --> inet_rtx_syn_ack()
>     --> tcp_rtx_synack()
>       --> tcp_v6_send_synack()
>         --> tcp_make_synack()
>           --> tcp_synack_options()
>   then: req->num_timeout++
>
> > Look at all the places were req->num_timeout or req->num_retrans are
> > set/changed.... this will give you some indications.
>
> I'm probably missing something obvious, but if the goal is to set
> snt_tsval_first only the first time, why can we not simply set
>
>   tcp_rsk(req)->snt_tsval_first =3D 0;
>
> in tcp_conn_request(), and only set it to tsval in tcp_synack_options()
> when it is 0? Something like that:
>
>
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 217a8747a79b..26b3daa5efd2 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -7249,6 +7249,7 @@ int tcp_conn_request(struct request_sock_ops *rsk=
_ops,
> >         tcp_rsk(req)->af_specific =3D af_ops;
> >         tcp_rsk(req)->ts_off =3D 0;
> >         tcp_rsk(req)->req_usec_ts =3D false;
> > +       tcp_rsk(req)->snt_tsval_first =3D 0;
> >  #if IS_ENABLED(CONFIG_MPTCP)
> >         tcp_rsk(req)->is_mptcp =3D 0;
> >  #endif
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 485ca131091e..020c624532d7 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -943,7 +943,7 @@ static unsigned int tcp_synack_options(const struct=
 sock *sk,
> >                 opts->options |=3D OPTION_TS;
> >                 opts->tsval =3D tcp_skb_timestamp_ts(tcp_rsk(req)->req_=
usec_ts, skb) +
> >                               tcp_rsk(req)->ts_off;
> > -               if (!req->num_timeout)
> > +               if (!tcp_rsk(req)->snt_tsval_first)
> >                         tcp_rsk(req)->snt_tsval_first =3D opts->tsval;
> >                 WRITE_ONCE(tcp_rsk(req)->snt_tsval_last, opts->tsval);
> >                 opts->tsecr =3D READ_ONCE(req->ts_recent)
>
>
> Or is the goal to update this field as long as the timeout didn't fire?
> In this case maybe req->num_timeout should be updated before calling
> inet_rtx_syn_ack() in reqsk_timer_handler(), no?
>
> > Do not worry, I will make sure V2 is fine.
>
> I don't doubt about that, thank you! :)

I can see you are super excited to see this patch landing ;)

I sent the V2, after running all my tests.

