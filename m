Return-Path: <netdev+bounces-169415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA0AA43C42
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF66B16E566
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F92D266B6A;
	Tue, 25 Feb 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8/9Fmn9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8191519A6
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480682; cv=none; b=tjzkTTfjDr4aWLukWGMZbjCSHwAA/D5GFcP/Jx7sx1LM9B8zSxbdKa3VpClq5pMR84HtXbonNj2095e1CJgXrY8aO3wJVj7bpS2N3JydpTUWLXGQdv6QAeS5Wp9bCKyIgbKD77VfGmrHYidgRrqHwIMKSkMUWNVrYTgx4+JSCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480682; c=relaxed/simple;
	bh=X7h4j3Wpo7AEKzWrUUfmyhf83fGxaWTM3Y7yaXLqDXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpSglJ5LpAKf56vONqFc7aE8dIeeRbjdDxYmpChWAjzmD8OXJ4yGEJQM43mc47G7G/GqMkFYjco1mrobvkKU067DlMJaIhjXcm5DtVdRbYoWf2/yGRa3x+9PaOmOYf8lEQX+QJ8C0407BDu39wMzcT4K7X1H0kmstYLwTeRWKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8/9Fmn9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so10095624a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740480679; x=1741085479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE0ws/eO5sliQle26k20VW9hxFmYBlGiIBirun2eETY=;
        b=t8/9Fmn9l1pq6mRArQVUFDewQCgf8L+gxloPscRmRX3ZX4o+3VvgdXkO6S/cJjdJDH
         uNt2ab4e4gLvTApySv7FkDUuFozZXubJunHdC+4gN1osr1rA30K1M9fiPFO6GNWb4lks
         TyE09x1iiYQl759B+wZhrj2sQ6/6+a/dX3d/2De8ssJLfo4Rjn3Yby/EhpyynzFfhB1N
         Vgxv8hhewof6kyYwDOOgvow/JYijiHVt2dQjVek1qJjjL5xaxa8NPZgrbfkZ/c6OkHTh
         90RcXj9hXiCOiEHlD9wxse9l1T/tjLhqP35ADESwKE53qrLDhMu0Vj8K6078OmfHvVjE
         coog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480679; x=1741085479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GE0ws/eO5sliQle26k20VW9hxFmYBlGiIBirun2eETY=;
        b=njpQFYDYe8AOmHE64i70O95s8qLuHZKBeZ8jpgrA0LHn01I0j/lH5vVtuaVNy4QIxX
         2SUU5YRfbLNgq/g62KOn5AEKv1JtboOAvWpAPU2CdC+LCIHWYdhnhLnLG7GgJnU4xK/u
         ieIqxvhFUTK0+nhy3AuVULYSqh8KGpejfuyyqOCIZp3FDAfCVX7x5mR/iJ74r33OtiUQ
         +L/qW8ac72Dgg9/Eq0Y8d/YWf+dSOtIEGRBwJKceYiqe+UoksxN0EaWvK82/O/bk2Mqz
         j+Ncxng4utFx2ZqkYEA4u6BuG2NnrRjBoTCu2w2JblIWvYhZzPRByfwySztjKB45cXuL
         FljQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwEySOK+RAT/4tMSyavmzTtPT0WJAdK9XcM9/P4IvwyAch7QSocDBXjcZr9kV4UNDBJBbI9SI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4qAjTew5OHRBvOHowQWl+WG3lGon+g6rmMl8KbmykV1q/F2dE
	pB/nyVuTZ3tKhpXcMmZG0ykuST73Fh2iyB0T0v8p0CQBo9/tLR7eyvdAD4SOx4uASDNkzngLHIk
	kkT/5TUuu+DnMTl9IdKwn60oyrX99xfaBG0rC
X-Gm-Gg: ASbGncs9bzaV2x+UYmdJGh9J5MDIBVbk5Sw8a22U23hUu7RHGX5DEkR1mUPB9H1ddW3
	01NLDPFkUOWgdGj0s+NxFLCL21HM7jkqNyIA+jhcbHWphJfMcNJmAqDH3ofMrTowlUku4goTqQz
	1gOQeZ8Aap
X-Google-Smtp-Source: AGHT+IFkyRZ4tFx/uYTFIhkeqRLbL67bPbMB4cKceXtsgbLMPpRD8hOTQAAROBJyQiOvp43+sy4L2l9WnrmIQsGP0iU=
X-Received: by 2002:a05:6402:1ece:b0:5e0:3447:f6b7 with SMTP id
 4fb4d7f45d1cf-5e4455c2e30mr2188708a12.8.1740480678844; Tue, 25 Feb 2025
 02:51:18 -0800 (PST)
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
 <CANn89iLf5hOnT=T+a9+msJ7=atWMMZQ+3syG75-8Nih8_MwHmw@mail.gmail.com> <8beaf62e-6257-452d-904a-fec6b21c891e@kernel.org>
In-Reply-To: <8beaf62e-6257-452d-904a-fec6b21c891e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Feb 2025 11:51:07 +0100
X-Gm-Features: AQ5f1JoVW81PZ_RzS_u58dQLkz8gpUUZmbzSr5KQq6m6hGWypSUstLiEBdwcYk4
Message-ID: <CANn89i+3M1bJf=gXMH1zK3LiR-=XMRPe+qR8HNu94o2Xzm4vQQ@mail.gmail.com>
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

On Tue, Feb 25, 2025 at 11:48=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> On 25/02/2025 11:42, Eric Dumazet wrote:
> > On Tue, Feb 25, 2025 at 11:39=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> >>
> >
> >>
> >> Yes, this would be it :
> >>
> >> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> >> index 728bce01ccd3ddb1f374fa96b86434a415dbe2cb..3555567ba4fb1ccd5c5921=
e39d11ff08f1d0cafd
> >> 100644
> >> --- a/net/ipv4/tcp_timer.c
> >> +++ b/net/ipv4/tcp_timer.c
> >> @@ -477,8 +477,8 @@ static void tcp_fastopen_synack_timer(struct sock
> >> *sk, struct request_sock *req)
> >>          * regular retransmit because if the child socket has been acc=
epted
> >>          * it's not good to give up too easily.
> >>          */
> >> -       inet_rtx_syn_ack(sk, req);
> >>         req->num_timeout++;
> >> +       inet_rtx_syn_ack(sk, req);
> >>         tcp_update_rto_stats(sk);
> >>         if (!tp->retrans_stamp)
> >>                 tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
> >
> > Obviously, I need to refine the patch and send a V2 later.
>
> Sorry, I still have the issue with this modification. I also checked
> with the previous patch, just to be sure, but the problem is still there
> as well.

I said "req->num_timeout" is not updated where I thought it was.

Look at all the places were req->num_timeout or req->num_retrans are
set/changed.... this will give you some indications.

Do not worry, I will make sure V2 is fine.

>
> (In the v2, do you mind also removing the underscore from the MIB entry
> name (TcpExtTSECR_Rejected) please? It looks like that's the only MIB
> entry with an underscore.)

ok

