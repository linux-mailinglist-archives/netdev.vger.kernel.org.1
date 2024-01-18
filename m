Return-Path: <netdev+bounces-64213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD0831CD2
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 16:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6BC1F21AB3
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8137A2554A;
	Thu, 18 Jan 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYU7To37"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6225639
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593160; cv=none; b=OZmGEsni32BSOgvB7sMhGzRGBsb7GEvloyRMomcy+R0zYwOEXHcF5aLr+3jEX31hMivE1ie77eRBgwbUsQ/ugQaQDiC9aLqQHJx6bggmOtzqLC5qAcXb8gWdgiZzfKuZAZHHjAiLj3Da0IjjqdWH09HFreo1vJBcd2eVZI6Vdrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593160; c=relaxed/simple;
	bh=eoDSeQr8pVcS/FvAM2wMPsYiP72y86cV068knJPCB5g=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=mYVIDtALF9aY/3UpV1Cneq/xEFdbbzDy4vTPUyPSYxNFLjLKZ7F2tTIK/m67U5YJK3XA4ckf1nWJl6G3zpmABDo9FM47gOQDAWkB+Na3y3b6iQMIMIxXVwSjLw5t24GzRYFXwh69+7Wbl9LLwmjQDOtkjVzJ0Yz0wQEqyATfS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LYU7To37; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3600b2c43a8so103795ab.0
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 07:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705593158; x=1706197958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5hc3tdZSax9kmNj7MqnH4qiYeZj7qOKUUj3kHm8TUA=;
        b=LYU7To37tIa0ZtfYKrV4XmtOMkTaId70apCsw9v7jLkUKlXKP8WWOLS1D7J0BXMXp7
         jLO6SFho1ybiJWX/G0znGYaZJBMIsyEcALPSyhQTpPitfocnhTTEJCyUKzPv7pu+MJZ/
         si0loRm0xCWFKt05BCrkzlz0sIRinAAny+2hBsfiqNXqTJSbkteIZr2JiRmm4m8MlW53
         Hxewf4RR9L42p4tKcF8a/yL3DImvpghjw4zX8s2Q3YAGhhSbvHA+7qwlJdkrX9VtxSrl
         I2uxrx0Q0es7sRKJDyU0NGFtqeHlyIjP0oKsMStm3QvVUftRiQ+sMco6/OzazoWNjRA4
         8FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705593158; x=1706197958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5hc3tdZSax9kmNj7MqnH4qiYeZj7qOKUUj3kHm8TUA=;
        b=SeCLV1cjyladujLuF6KEGg2Appxu2d4Vvqq3fDlC7u7gf2epf/3GeEqF+/B8qVnhq5
         007E3gYrK/oS7qMBGhyLCUPMajXGgETQdSR9W+R5nnt0aq9GdEV+dPRdhe8BQ8TBk6xi
         PFLkWa8mHUiMBuztncKwK66zNP6Ee6GggyVp/uwtVmABTf1P2IKivR5UpMoQvDzGcBDC
         pQv7fl/ojeCuIv2uVQK+CKESYLxo8oWkMWT16yUBHSDkfmbnbplOCQbocwSmYEJ7i5Zv
         VOnqb9x4DClAoWMQIif5VIJ1fKFzz0w1mQiMOMwX+1e8faE6L2aXlxarm+WEV95lBL+6
         8q2w==
X-Gm-Message-State: AOJu0Yyrk/AcD35zZRxrz1WvCxBonE8/zQwOf/cco2duzDmSqEY0WWQQ
	Kvpoj8oVlMVI4YjgWGNw1HtsEZftITrKenvp6MPhPgs8Hud75RmZGHy0uwOaSXDURheSy6JIqS5
	BPTsaORx0iNCF5G8dtey/lJ2BFQVmsBLEZ0lC
X-Google-Smtp-Source: AGHT+IGAwESndYfI1N1oc/qGEjaUnVS0eu9bq7GXdbocjvFCsczZHAScqEGAsOZ0ZdEl/vBm4LYjJTcsp0/Wt/i3QZM=
X-Received: by 2002:a92:c5a5:0:b0:360:93a3:311d with SMTP id
 r5-20020a92c5a5000000b0036093a3311dmr69315ilt.17.1705593157956; Thu, 18 Jan
 2024 07:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118143504.3466830-1-edumazet@google.com> <65a9407bd77fc_1caa3f29452@willemb.c.googlers.com.notmuch>
In-Reply-To: <65a9407bd77fc_1caa3f29452@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 16:52:23 +0100
Message-ID: <CANn89i+x9qKCaQVbaf+TO8TJWMaLcW-efhAuNtatFuyrza-UaQ@mail.gmail.com>
Subject: Re: [PATCH net] udp: fix busy polling
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 4:15=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > Generic sk_busy_loop_end() only looks at sk->sk_receive_queue
> > for presence of packets.
> >
> > Problem is that for UDP sockets after blamed commit, some packets
> > could be present in another queue: udp_sk(sk)->reader_queue
> >
> > In some cases, a busy poller could spin until timeout expiration,
> > even if some packets are available in udp_sk(sk)->reader_queue.
> >
> > Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception=
")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/linux/skmsg.h |  6 ------
> >  include/net/sock.h    |  5 +++++
> >  net/core/sock.c       | 10 +++++++++-
> >  3 files changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> > index 888a4b217829fd4d6baf52f784ce35e9ad6bd0ed..e65ec3fd27998a5b82fc2c4=
597c575125e653056 100644
> > --- a/include/linux/skmsg.h
> > +++ b/include/linux/skmsg.h
> > @@ -505,12 +505,6 @@ static inline bool sk_psock_strp_enabled(struct sk=
_psock *psock)
> >       return !!psock->saved_data_ready;
> >  }
> >
> > -static inline bool sk_is_udp(const struct sock *sk)
> > -{
> > -     return sk->sk_type =3D=3D SOCK_DGRAM &&
> > -            sk->sk_protocol =3D=3D IPPROTO_UDP;
> > -}
> > -
> >  #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
> >
> >  #define BPF_F_STRPARSER      (1UL << 1)
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index a7f815c7cfdfdf1296be2967fd100efdb10cdd63..b1ceba8e179aa5cc4c90e98=
d353551b3a3e1ab86 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2770,6 +2770,11 @@ static inline bool sk_is_tcp(const struct sock *=
sk)
> >       return sk->sk_type =3D=3D SOCK_STREAM && sk->sk_protocol =3D=3D I=
PPROTO_TCP;
> >  }
> >
> > +static inline bool sk_is_udp(const struct sock *sk)
> > +{
> > +     return sk->sk_type =3D=3D SOCK_DGRAM && sk->sk_protocol =3D=3D IP=
PROTO_UDP;
> > +}
> > +
>
> Since busy polling code is protocol (family) independent, is it safe
> to assume sk->sk_family =3D=3D PF_INET or PF_INET6 here?

Hmm. This is a valid point.

It seems the only current user of sk_is_udp(), bpf_sk_lookup_assign()
can only be used from inet sockets,

But if we use sk_is_udp() in a core function like sk_busy_loop_end(),
we need to be more careful...

