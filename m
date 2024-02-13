Return-Path: <netdev+bounces-71190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEEA852913
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4890C28324E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579E71426A;
	Tue, 13 Feb 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShPu8nEl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C2711724
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707806253; cv=none; b=aBZRw6s3BfpI4dmHCYzplkThurqgIw0LaFHdr63DY0EWCCxPog1h6cJCjPZqrR0cc1Dve1kRtKl1PKz5S9joBJIoxnaq9+2ooYuf9WON6wXdxcvB0uT1Oao2VDHGFT/62UJcogXw4KvknrfcS48kruITt2hx+RU5IbfbQbtNkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707806253; c=relaxed/simple;
	bh=pkfAvsiLQYidoVwVZs66Qwlwzt3DxwXmLPHU5jj3vmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubrmkst4ZetkLgn3MGzSkTa/jV+gOl6MtDYBAYWuXMzSjog6cMP3PdYJ18UUsa6G5foY8FXFN/2d90S2DQ0rlq7EmSxVeieslYGlgjOyakuONnYSAd4Vm7FLq3G15RXVdQ5Dw3zr5fRESYLTqLF21LyL6le6Pwrc/8fJhFFsPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShPu8nEl; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5600d950442so4429831a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707806250; x=1708411050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21trHfN1yOHVqTbKlNpNQCWhPiUjzv8Q1f/uH0l/roc=;
        b=ShPu8nElHVDO5HUW8UGO2wwhDcWK9p4qUBwu9U8gGn9agGUlBktDE1K/oVZNLiO099
         PoMAeLm1h44v2DlRbTGH/PuQB/Jq2px0uJDjFWe8AkGkH28DccvEFExFEX/5b8nKm018
         VsUh1CO4E3QIXsjyLeEM7GoptWl+ewvx4cCojWxYfQIuv3EWyw+3sSgSN2SlK/ZTi9HN
         wOmsUrd4k1kKshjmgJs3pBwRRZNdzH0vALNsJMIHggLN9i4Bi7agW/0qhBa29IfWLFAL
         BalZoyo5FVqHSfmo8SWBTbqXGUMvA55hMkG7B9HJ4KrDjftYoypxvIxT8YYaEJPoJiSr
         MzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707806250; x=1708411050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21trHfN1yOHVqTbKlNpNQCWhPiUjzv8Q1f/uH0l/roc=;
        b=caWXL7bRXgCbn75Ea1buSbLSTewWor3hkyA4Ggf8Yi77Pfi5Qj7Op7JuA6vN/outSx
         PXUCpUhfK4Da9haZswU4Dish0ewn6U5Vg37U9+x5UIEp+6VPlCROVJhQ5DZVd7ajFwjI
         wdGHfQB8mv1x56LOWVZVbylD46Epj3jp6xp8dyE+xpynsCfuX1F6pS4W/vYbuUZsyIbU
         8EuQoMn0Eh4kHFZ4U2cMUOVOSo97HmfQQiy/Gju0tTh2ppoIAnDD0w71hr0wMUNFKbv3
         I+KfTb7jheBSU2RDDXRgpoSbZJyo6d28GGUpXx6eVCNMM+FGJNzU5SaEPdOZHYzpgD5X
         O4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWlGF2SZmApBR4D10uMht0Jhcaz15szaTm2Pn+ZLCiq+Kru2CEUv6Xq1DAgEv7prm8wb5HuujRW6NFJ3VGV+Wl9jRKRDY3N
X-Gm-Message-State: AOJu0YzzUyZiXb48r5KBhxqy1QFtxw79CWE8hzPVDOZV/IYpWJm9sPmI
	wdG16S0iapJ3A1kk3uPEViLdO8AhmWRAtf6OebZpux/uGLNjy1iKuDFnvkSJKUIyOoF0IRFW1Kk
	Ks0z03yHqUh7yodA2H4NIH/VdKXA=
X-Google-Smtp-Source: AGHT+IEAkbYopfjG/IBoLm4IkrBXeQrkoXULwZ3+oNU/1yZJLAiFxP238HXVxEfoGpm+Nl608l+96RYPGhKYKi/mthM=
X-Received: by 2002:a50:ee15:0:b0:560:14c4:58ff with SMTP id
 g21-20020a50ee15000000b0056014c458ffmr6439425eds.28.1707806249674; Mon, 12
 Feb 2024 22:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoAWURoNQEq-WckGs6eVQX6VFpHtw4CC9u4Nc7ab0aD+oA@mail.gmail.com>
 <20240213040658.86261-1-kuniyu@amazon.com>
In-Reply-To: <20240213040658.86261-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Feb 2024 14:36:52 +0800
Message-ID: <CAL+tcoDDF7yCws=Y7i9Rno0o8d36UY4kdQ8aX+L5h7z+qT67Hw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Tue, 13 Feb 2024 09:48:04 +0800
> > On Mon, Feb 12, 2024 at 11:33=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Mon, Feb 12, 2024 at 10:29=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > >
> > > >                         if (!acceptable)
> > > > -                               return 1;
> > > > +                               /* This reason isn't clear. We can =
refine it in the future */
> > > > +                               return SKB_DROP_REASON_TCP_CONNREQN=
OTACCEPTABLE;
> > >
> > > tcp_conn_request() might return 0 when a syncookie has been generated=
.
> > >
> > > Technically speaking, the incoming SYN was not dropped :)
> >
> > Hi Eric, Kuniyuki
> >
> > Sorry, I should have checked tcp_conn_request() carefully last night.
> > Today, I checked tcp_conn_request() over and over again.
> >
> > I didn't find there is any chance to return a negative/positive value,
> > only 0. It means @acceptable is always true and it should never return
> > TCP_CONNREQNOTACCEPTABLE for TCP ipv4/6 protocol and never trigger a
> > reset in this way.
>
> Ah right, I remember I digged the same thing before and even in the
> initial commit, conn_request() always returned 0 and tcp_rcv_state_proces=
s()
> tested it with if (retval < 0).

Good. Thanks for your double check :)

>
> I think we can clean up the leftover with some comments above
> ->conn_request() definition so that we can convert it to void
> when we deprecate DCCP in the near future.

In the next version, I will remove the new
SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE and the comment line which I
added and keep it as the old way, namely, returning 1.

>
>
> >
> > For DCCP, there are chances to return -1 in dccp_v4_conn_request().
> > But I don't think we've already added drop reasons in DCCP before.
> >
> > If I understand correctly, there is no need to do any refinement or
> > even introduce TCP_CONNREQNOTACCEPTABLE new dropreason about the
> > .conn_request() for TCP.
> >
> > Should I add a NEW kfree_skb_reason() in tcp_conn_request() for those
> > labels, like drop_and_release, drop_and_free, drop, and not return a
> > drop reason to its caller tcp_rcv_state_process()?
>
> Most interested reasons will be covered by
>
>   - reqsk q : net_info_ratelimited() in tcp_syn_flood_action() or
>               net_dbg_ratelimited() in pr_drop_req() or
>               __NET_INC_STATS(net, LINUX_MIB_LISTENDROPS) in tcp_listendr=
op()
>   - accept q: NET_INC_STATS(net, LINUX_MIB_LISTENOVERFLOWS) or
>               __NET_INC_STATS(net, LINUX_MIB_LISTENDROPS) in tcp_listendr=
op()
>
> and could be refined by drop reason, but I'm not sure if drop reason
> is used under such a pressured situation.

Interesting. Let us wait for Eric's response.

Thanks,
Jason

>
> Also, these failures are now treated with consume_skb().
>
> Whichever is fine to me, no strong preference.


>
>
> >
> > Please correct me if I'm wrong...
> >
> > Thanks,
> > Jason
> >
> > >
> > > I think you need to have a patch to change tcp_conn_request() and its
> > > friends to return a 'refined' drop_reason
> > > to avoid future questions / patches.

