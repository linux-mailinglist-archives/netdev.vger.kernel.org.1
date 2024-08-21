Return-Path: <netdev+bounces-120663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A5295A21E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E18B24988
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F214F9DB;
	Wed, 21 Aug 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+wm3+p1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF113A243
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255557; cv=none; b=B0G4xN29YJwKFIJZi4cHqan/zjdxXTYAvMm4B9zQXUIdnjzEBTIPIMLLbA+j9Ta15K9no/ERJygmg3BXXNnN0Wrtqv5PccptLInAdEUWgay2o00V5BKPxSwjSI12QSywsFpBVnnRsCm/6sLrZwZMtvFRzXvHEDRPvvrHqevUH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255557; c=relaxed/simple;
	bh=Z2rk8F1sAa4DjsncrsJTX95BsXswhbabq43OrRH6C/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4Nh9bCUTxkdkIvbc0RBf62nGgYZHurURyBT91dlFFiP1sZI/VlClpARdjqgwklJ6lx+pXiX2lEpjBxQinF044Y6FQo5dlAfy3kP7xKwTzErqFz680rbu89pjdvaS7WLIHhBGPRR/7W1pGBgZtYLYUu9XXBZ/gHG5GgRYugfT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+wm3+p1; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39d4a4e4931so12047095ab.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724255555; x=1724860355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+5BMo6/Z/W0oZYh3JtHgFtjCGzZvmSBqYqy2iscuOg=;
        b=k+wm3+p1flwwYxbLrYVbHDkDqDGCFCrt3mF5i0qHm/RFJGxt0q5+CH8Z30BTV7efth
         kt0wW52EV0jZ1inhOhv9osmjIN1IoohSRQ9OIxu1NWpqY2j+Pw6KDlPquEKjzJzIyMFH
         sZwt5lisBtBdeX075PN6wVm7cL6gco0SeRIB7h7WRtMnmNlg9J76xj46Kzqy27usXnfO
         Q2rnAUao1dnQomdyp4y8ddE0tMnaKDiwqFn4hqR85uLoUB6PM2tYAf1JsDil0lomIQ3P
         4eo7QvS11TSoJGqJ2+Ea6O6Kd20lK1YoDmEQXyQ5E68z1UKd9b0nGUeLGsatEgsvIucs
         yHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724255555; x=1724860355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+5BMo6/Z/W0oZYh3JtHgFtjCGzZvmSBqYqy2iscuOg=;
        b=IVOY/tjy2IFW8Br2wV90MInzRDlbkvsX0nUURnClOV0ZL2FKI4yo0EZnqIHWA3o6f9
         ZnzkxOJQorhuZgtViBAzug0RMPMikh8Q2ejq0upq3DalgqwoINQzfrYIU7q1ZzA/oXuc
         z9u+EZ4ug2N31idwpXsp342twfAa+ZJMRoma8ym1W/0u/GRaaX+mIhPzP6tBKmhD0s2Q
         YraIiixt5UiWC/UIvCEOnogOQrLL8/KWO6ufsHRLFeJFOVwh+Ykm7kqo0ATRtN1LDJxy
         0ol+OW+ut7Wa1hyF8F3SwZlik+8xYr319RBRjNuS0SdudMv8tpExhuCphJFJ0aNpLiwF
         tGIg==
X-Forwarded-Encrypted: i=1; AJvYcCUL3/9Un89Wx7lvS2e2ZYND3QlVlfIiA3pdyZXMEmejvJGN4QFab3s+OI5E3N0//L5w01xlpMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Du0xQNn+W52JRo63mu/BDRo9WR1oeYpbaQHp9I6/nUQtu2zM
	zX8H663bfnXZ0/Xk4XRBgmgp9Jfj1IFLz24zmPVL+D3dgGgEDuicTCEmBCRYmk110g8JVMIYWl6
	G40K+ilbJtckrB0RGbUL344clDLE=
X-Google-Smtp-Source: AGHT+IGUJKeDwysRebWT93N4EdUKB/8NepKXfmay1fsMC0XfdcFuE6KZyD/zbEQaB3BbZXiyyRyffg9PXMSRtKZeHXY=
X-Received: by 2002:a05:6e02:17c9:b0:39d:1a7d:71ea with SMTP id
 e9e14a558f8ab-39d6c3b975amr30266635ab.19.1724255555202; Wed, 21 Aug 2024
 08:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821153325.3204-1-kerneljasonxing@gmail.com> <CANn89iKovApWCsnFWAVTywCmWH9bFfBRCvc75+b_tjASj22SJQ@mail.gmail.com>
In-Reply-To: <CANn89iKovApWCsnFWAVTywCmWH9bFfBRCvc75+b_tjASj22SJQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 21 Aug 2024 23:51:59 +0800
Message-ID: <CAL+tcoCgnjp-iSjpk6ow1TFByKg0YPL+OpphD6aCdOAb826mbA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] tcp: avoid reusing FIN_WAIT2 when trying to
 find port in connect() process
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Jade Dong <jadedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 11:47=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 21, 2024 at 5:33=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > We found that one close-wait socket was reset by the other side
> > due to a new connection reusing the same port which is beyond our
> > expectation, so we have to investigate the underlying reason.
> >
> > The following experiment is conducted in the test environment. We
> > limit the port range from 40000 to 40010 and delay the time to close()
> > after receiving a fin from the active close side, which can help us
> > easily reproduce like what happened in production.
> >
> > Here are three connections captured by tcpdump:
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965525191
> > 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 2769915070
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [F.], seq 1, ack 1
> > // a few seconds later, within 60 seconds
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> > 127.0.0.1.9999 > 127.0.0.1.40002: Flags [.], ack 2
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [R], seq 2965525193
> > // later, very quickly
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> > 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 3120990805
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
> >
> > As we can see, the first flow is reset because:
> > 1) client starts a new connection, I mean, the second one
> > 2) client tries to find a suitable port which is a timewait socket
> >    (its state is timewait, substate is fin_wait2)
> > 3) client occupies that timewait port to send a SYN
> > 4) server finds a corresponding close-wait socket in ehash table,
> >    then replies with a challenge ack
> > 5) client sends an RST to terminate this old close-wait socket.
> >
> > I don't think the port selection algo can choose a FIN_WAIT2 socket
> > when we turn on tcp_tw_reuse because on the server side there
> > remain unread data. In some cases, if one side haven't call close() yet=
,
> > we should not consider it as expendable and treat it at will.
> >
> > Even though, sometimes, the server isn't able to call close() as soon
> > as possible like what we expect, it can not be terminated easily,
> > especially due to a second unrelated connection happening.
> >
> > After this patch, we can see the expected failure if we start a
> > connection when all the ports are occupied in fin_wait2 state:
> > "Ncat: Cannot assign requested address."
> >
> > Reported-by: Jade Dong <jadedong@tencent.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > v3
> > Link: https://lore.kernel.org/all/20240815113745.6668-1-kerneljasonxing=
@gmail.com/
> > 1. take the ipv6 case into consideration. (Eric)
> >
> > v2
> > Link: https://lore.kernel.org/all/20240814035136.60796-1-kerneljasonxin=
g@gmail.com/
> > 1. change from fin_wait2 to timewait test statement, no functional
> > change (Kuniyuki)
> > ---
> >  net/ipv4/tcp_ipv4.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index fd17f25ff288..b37c70d292bc 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -144,6 +144,9 @@ int tcp_twsk_unique(struct sock *sk, struct sock *s=
ktw, void *twp)
> >                         reuse =3D 0;
> >         }
> >
> > +       if (tw->tw_substate =3D=3D TCP_FIN_WAIT2)
> > +               reuse =3D 0;
> > +
>
> sysctl_tcp_tw_reuse default value being 2, I would suggest doing this
> test earlier,
> to avoid unneeded work.

Thanks. I should have thought of that. I will submit it ~24 hours later.

Thanks,
Jason

>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index c2860480099f216d69fc570efdb991d2304be785..9af18d0293cd6655faf4eeb60=
ff3d41ce94ae843
> 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -118,6 +118,9 @@ int tcp_twsk_unique(struct sock *sk, struct sock
> *sktw, void *twp)
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         int ts_recent_stamp;
>
> +       if (tw->tw_substate =3D=3D TCP_FIN_WAIT2)
> +               reuse =3D 0;
> +
>         if (reuse =3D=3D 2) {
>                 /* Still does not detect *everything* that goes through
>                  * lo, since we require a loopback src or dst address

