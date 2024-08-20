Return-Path: <netdev+bounces-119960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03274957AC0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B0D1C209F0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A893712E5B;
	Tue, 20 Aug 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHJYXjiL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEB815AC4
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116065; cv=none; b=pRrLBll+E4jMTB45lxeL+D9Fn07E+6Mywp9t+4zHfAuDtnR1hDV6eqNwujiRxmLnEgVznIN4249cNuyPxRC1p4wXsE8RcFGQQZb8OjedJrJG+L0igFvxWWuo06RXrMzogC64GHQxJODlKIIBRne8rYw7lLFu/FOwRd1J+CsYnmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116065; c=relaxed/simple;
	bh=R5EWHRRgULrkrgsvftgyhz11ARuffjoc2UftL9CnaXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMn2OYQjwKv79bRFZCGIeNnimcxwRQxOnEqsDh2oTJKLntEL3tCg2dROM/utt2mucUeIhzdvUmI5I30nqaS93TpfWKrO+0XHHv/yPInxNxukujXu95wpcBiH5a6DHvDwvFWbPE0sKprL7/GwpIxLKXxE6DGPNIDN7BNLHQI5juI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHJYXjiL; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d37d9767dso9415665ab.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 18:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724116063; x=1724720863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyRnzDkG/Pln44P5pCQmOiQQdovqH8KptYz9pT67ZgQ=;
        b=IHJYXjiLaqZ2lupEqTCztk8eQ/ZxuRYfN2imbcSWSpO3zh1mvr05YoI6mOixLpNZWX
         RgHXdFv04lNZkHkGVX8tJx46n09jVLJmGsxq8k7zWy1vsdZP1ocXo/qb/s9b+GHQSdVh
         toSPLChnVVTA5/F84jESx0qFZzJNJg3hux3X1AD9fW19q+Vh+9uUDeVuNef2ZOdOO9Uv
         38SlmLEG5eo+Zbw2hSMkXkh1wCFYx1HaVCxyVnK8Y7iIPqRvKSSWA3zho7oRRYySdcsh
         TUd5DTdwlx9rxjHk2eiMTWuRExSkgY2N2h1m70DIL1wxG/ytH+e7Rg4KnbgV96hy2Xev
         7Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116063; x=1724720863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyRnzDkG/Pln44P5pCQmOiQQdovqH8KptYz9pT67ZgQ=;
        b=KJnl9wENZLARENOZ5oFcWw/T91noX5yJUPKbj7UKnTy6wWyRCgJOyBozBNAdNHyjSC
         F15qDEZ+mR0q38yPujWJ5oYGPkA85t/rt6ywC/gZOfaQ0v8fZUDRsTJxGEI9qNHWjMD/
         SLZzFusTjxn0lKAKZqyDf96QfCb9jceNeL9iFWljkl6+ru7XNiMkabsZSFZfNh4HsFn4
         XUQ696EY2Z4AWe21tHxa/3gd2gE7S0rY7nBoen62Wef2I0OY5Wo5i+ZQpXCrWjZ0izkh
         NLuTbmLkASC+ZWwy0tx++PdnI21UFiWdz7/wSc4X9g/uR5vrZg9GKSCaygs4ZjskD5Yw
         i7yg==
X-Gm-Message-State: AOJu0YxzicrzKapPcFZVrJru7kBmCizZsCwGXgFJZHLhv0VxCzjdjXWb
	LviRqNShmh8ihJOntm9TpZrLf+sv2Gt9Qn2g0nV3AHaynAGuXxbRbEMDwK3FSNlS+aSQxQ1iTe8
	QIP81PFyQshufGrk5k25eqmpjqDA=
X-Google-Smtp-Source: AGHT+IGTtaDbkc153y3v1BQBxHWN1uD3/LHsH1y41QDQhnc9eNJLt0/GWoLaFDJ8OgWe1HQ+v5uffzAlr87WonU4BDI=
X-Received: by 2002:a05:6e02:50b:b0:39d:2c94:45e0 with SMTP id
 e9e14a558f8ab-39d2c9446b0mr113872285ab.26.1724116063166; Mon, 19 Aug 2024
 18:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815113745.6668-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240815113745.6668-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Aug 2024 09:07:07 +0800
Message-ID: <CAL+tcoDURf_krTOSKxM8fhPgR9h7rGaqTPFERVai=n3v6bG-sg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: avoid reusing FIN_WAIT2 when trying to
 find port in connect() process
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, ncardwell@google.com, 
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Jade Dong <jadedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Thu, Aug 15, 2024 at 7:37=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> We found that one close-wait socket was reset by the other side
> which is beyond our expectation, so we have to investigate the
> underlying reason. The following experiment is conducted in the
> test environment. We limit the port range from 40000 to 40010
> and delay the time to close() after receiving a fin from the
> active close side, which can help us easily reproduce like what
> happened in production.
>
> Here are three connections captured by tcpdump:
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965525191
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 2769915070
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [F.], seq 1, ack 1
> // a few seconds later, within 60 seconds
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [.], ack 2
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [R], seq 2965525193
> // later, very quickly
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 3120990805
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
>
> As we can see, the first flow is reset because:
> 1) client starts a new connection, I mean, the second one
> 2) client tries to find a suitable port which is a timewait socket
>    (its state is timewait, substate is fin_wait2)
> 3) client occupies that timewait port to send a SYN
> 4) server finds a corresponding close-wait socket in ehash table,
>    then replies with a challenge ack
> 5) client sends an RST to terminate this old close-wait socket.
>
> I don't think the port selection algo can choose a FIN_WAIT2 socket
> when we turn on tcp_tw_reuse because on the server side there
> remain unread data. If one side haven't call close() yet, we should
> not consider it as expendable and treat it at will.
>
> Even though, sometimes, the server isn't able to call close() as soon
> as possible like what we expect, it can not be terminated easily,
> especially due to a second unrelated connection happening.
>
> After this patch, we can see the expected failure if we start a
> connection when all the ports are occupied in fin_wait2 state:
> "Ncat: Cannot assign requested address."
>
> Reported-by: Jade Dong <jadedong@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> Link: https://lore.kernel.org/all/20240814035136.60796-1-kerneljasonxing@=
gmail.com/
> 1. change from fin_wait2 to timewait test statement, no functional
> change (Kuniyuki)
> ---
>  net/ipv4/inet_hashtables.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 9bfcfd016e18..b95215fc15f6 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -563,7 +563,8 @@ static int __inet_check_established(struct inet_timew=
ait_death_row *death_row,
>                         continue;
>
>                 if (likely(inet_match(net, sk2, acookie, ports, dif, sdif=
))) {
> -                       if (sk2->sk_state =3D=3D TCP_TIME_WAIT) {
> +                       if (sk2->sk_state =3D=3D TCP_TIME_WAIT &&
> +                           inet_twsk(sk2)->tw_substate =3D=3D TCP_TIME_W=
AIT) {
>                                 tw =3D inet_twsk(sk2);
>                                 if (sk->sk_protocol =3D=3D IPPROTO_TCP &&
>                                     tcp_twsk_unique(sk, sk2, twp))
> --
> 2.37.3
>

Not rushing you, so please please don't get me wrong. I'm a little bit
worried if this email is submerged in the mailing list. So please also
help me review this one :)

Thanks,
Jason

