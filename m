Return-Path: <netdev+bounces-169450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D68A43FAC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502CF176ED9
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0238B20F076;
	Tue, 25 Feb 2025 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lIYRhJ5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456C267F62
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487840; cv=none; b=PVnm58Rl6UiYGgqB9MZcfXS03waumjUwUQ/RJLMefZREzFik1v1yKWcKBna1RMwOfho3+PD0wlSIu42cFQGZTGO9p/RP3srHYCE4TCJLNBsW2EJi0XW3J7ue+tuhkujkmQQfB/r23URoIWoOCIc17fTam4cvuZssSblxiv/ll1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487840; c=relaxed/simple;
	bh=bzo9A1z2PLSqNUE/pf/yuRbUWyA81F2CNc8glyCOMi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFECdqhGKRpvsbMjaL/uGUl5VwnRXsA5O06RkiiasTHV2GJTTMRzBR8hv+KfkouhLbeUtScjW+rDgH9JRbWSA5mylXr9oZ77GvxOtj1qNsyCcD+Nw5y2iRsmnfbyEtfdOgaTl5VKQHUvuaXWp0+vRfFpcxXpyJi18BnE0RTjcrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lIYRhJ5W; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so9701131a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 04:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740487837; x=1741092637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbBbp6AJ1g83a8GGg4QaZAcU4qJhTbZxnq3Jc34b55g=;
        b=lIYRhJ5Wad9O3Q8aA25+FVH0M3hxeHLhh55zzfiu/5dSHU4O4Z8VETExmIgByFJyt2
         bB8+3VwyDmOhIrX2j/kaLYl5llIkYlsI/mXWj7dcVoTAzKoC2aKjbAn9/AT2p0dj65v4
         tWgiMvnPE/bOTYq0Pui6Xh/YyMmWgCKs6WeOspx0rShHbatLXiqgyQh0f3hIgQ1kdyv8
         qUV/RXsRo14ebZrQlMd9sm2YMkBbtM5bP6z1YWq9KgCsjf/Yred7rBiCMag9AAaN6w20
         oRA8lBSbj+MPs1vSRABP8WAJfuoTsAJgORRp6wGmQyTDFiEY5rpd5XW29hqzxof4sU2X
         7H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740487837; x=1741092637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbBbp6AJ1g83a8GGg4QaZAcU4qJhTbZxnq3Jc34b55g=;
        b=V/K2G5859QO7b1dnljYk1Q2a6q7fzvhOuJMC+37njR/iidME1F3QpLzuLPXfG2ZDQE
         m62OWC1V9U23ai/xWRV891eM/E2G69JL6XoWLoSSDnQdmurKp/MHpbbbqXLrDQIXgirf
         vI8CMDoJONq+qXe3s18KfDme2q3il3/z2/LWr/BMoCjUlexS/KaMBqviCIaqXefLnwUn
         sp1Oz3kaPjIegNmZlhi+gd8rL3jqDueQoFwL2fCNbAwiIaa9S0f8IjD6rXDJQHT+PwIu
         Sce9bA7uPjdNFao9BPlSRjG0XIi2vvh3Wzt8CezBjlgWDYzKCek7+u6z9W/H00IVbAR3
         q8jw==
X-Forwarded-Encrypted: i=1; AJvYcCXUu3ia66LxP6z0wi8KCWfCugIZW0AQ1d2I8yvwDM5qlXxAGPQ2/f6PmQQNs9LY10V9kCuHr5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHraMJ6iaW90vRfTTExa8Gn7X8RloqqUYZjf9aIPV70i7EbrIL
	jCuc74kIG9AFC+baV8Erz5VNb2c0zsVxK7W/X3dwo9I4hhaKE+ADQBRDxWUxfY06A24aDBVXUip
	QuPwLjpM2qTojHvHRRuGlKnEu6H508GQH3wgF
X-Gm-Gg: ASbGncuRVPQq0zVqg5mF3iJ/n+/Knpb92zKnPPQQIYtYrFZT97XaAZ9ZsbZmvtDfV7u
	y3sd8sJgsVlyZLYpH6rQtP99qCPcx8CkGB+ReElKsiRFoEV0KQoNAHBAuiRw/ruwNForXw5V6O4
	TLA2qWdjKb
X-Google-Smtp-Source: AGHT+IGXvIEPJm3QCaHKZkEOXjf+DHVWAiHlTRaKnZVfflmYoW0ay/HhjbMf9mAyIZETZHAEgTmBMAt0RhdX4uBjgkk=
X-Received: by 2002:a05:6402:1d4f:b0:5de:d932:a54c with SMTP id
 4fb4d7f45d1cf-5e0a1200077mr24017946a12.2.1740487837339; Tue, 25 Feb 2025
 04:50:37 -0800 (PST)
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
In-Reply-To: <CANn89i+3M1bJf=gXMH1zK3LiR-=XMRPe+qR8HNu94o2Xzm4vQQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Feb 2025 13:50:26 +0100
X-Gm-Features: AQ5f1Jo5i-QZAJCHoSGvjbfzI4QCVPxooWP0szzNgfaHL63wAR3eTjJdAtexKBw
Message-ID: <CANn89iL-oCk=FqGzeDi4PN_PX6r8tQZ-zwxObi=R_8=9QzkbQw@mail.gmail.com>
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

On Tue, Feb 25, 2025 at 11:51=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Feb 25, 2025 at 11:48=E2=80=AFAM Matthieu Baerts <matttbe@kernel.=
org> wrote:
> >
> > On 25/02/2025 11:42, Eric Dumazet wrote:
> > > On Tue, Feb 25, 2025 at 11:39=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > >>
> > >
> > >>
> > >> Yes, this would be it :
> > >>
> > >> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > >> index 728bce01ccd3ddb1f374fa96b86434a415dbe2cb..3555567ba4fb1ccd5c59=
21e39d11ff08f1d0cafd
> > >> 100644
> > >> --- a/net/ipv4/tcp_timer.c
> > >> +++ b/net/ipv4/tcp_timer.c
> > >> @@ -477,8 +477,8 @@ static void tcp_fastopen_synack_timer(struct soc=
k
> > >> *sk, struct request_sock *req)
> > >>          * regular retransmit because if the child socket has been a=
ccepted
> > >>          * it's not good to give up too easily.
> > >>          */
> > >> -       inet_rtx_syn_ack(sk, req);
> > >>         req->num_timeout++;
> > >> +       inet_rtx_syn_ack(sk, req);
> > >>         tcp_update_rto_stats(sk);
> > >>         if (!tp->retrans_stamp)
> > >>                 tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
> > >
> > > Obviously, I need to refine the patch and send a V2 later.

In v2 I will no longer read req->num_timeout

First SYNACK is sent with syn_skb being set.

Subsequent RTX SYNACK have a NULL syn_skb :

tcp_rtx_synack()

res =3D af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL, NU=
LL);

