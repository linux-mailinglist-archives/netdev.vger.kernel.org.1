Return-Path: <netdev+bounces-183522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F327A90EA4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C9E4475DE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91130229B2E;
	Wed, 16 Apr 2025 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HaLBpPls"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275A18D63E
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744842773; cv=none; b=ePjxczwjqXHxzFcPBgZM/tsYIKjzMPXvCtB6erc0tJEj9KxqREyX4/BFzK0ku3U4HDmQ5043CdL7Jn0qM0/BkshYDK6hQHJK84cUioikgsK+zRgNwWlQuneMocjakTUo590ko1zu4a4Q9F+5Xm9T/DiomQqbKt7ncpCvPn/z558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744842773; c=relaxed/simple;
	bh=xDdDfg1dr2oMmwJlp1YIqFHumjcYRHgbXNz+NpGeKTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxKS00rORKPTnQ6EgkBUYZszy8hoOSpD2iNGF45kTxkI4WKTYHSG4kOk7dx1OIrjCneYdEYkZD829fDrbZd5HfyWRDgB/nsa5P/DcfgJs4YNlRg17VS1uQVH7366JTs+JQ0mhtBYtR4QMax8p2g3/csUSkEuYfcmiYs0ITPAUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HaLBpPls; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c53b9d66fdso12386585a.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744842769; x=1745447569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwa/GJzxIoK8YfwWLd61EtD/9jfMqAZjcMbSvU4zX1w=;
        b=HaLBpPls0AWIM+hi8E4ltJESK/hGxnmR8Czw3C/FUSAYJMM6kxN2GobaClBSjH5j0H
         a2QqX3FDl9V9Gex2EFOyMUcQLgVclDLQRrBIu+0rdEMcH/lvV1W0NI986zpCoNMrp+vc
         fetlI4wMKs+fN4UKvcAi85HoBiLzYwdc9SVIlmErZFY/mg762PFdweedy3fHyP9TFgkV
         uyCRrBteDDGaxJliguMAHudysZ80whWqpayKyw4IXavexLABZv+acibx1YWYsKk4ySJi
         ThQDwaZ908ND9w0qMe+n7ZoJtFsJsAVHko5snV2up/T4L5xFEp40VfaU1tewCVtyXJ5H
         E6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744842769; x=1745447569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwa/GJzxIoK8YfwWLd61EtD/9jfMqAZjcMbSvU4zX1w=;
        b=Hh7Eb24D7HMS+byyLVU9rBME1dHdL0PB84FUob4BF7J/ww57tRh35+vW7XhENheJdA
         hBejAXs5LQXQjKwG9d2DVfOAVW4bT8COLWFJFHkCtij0StyGpYXvH3dHsH8FN6PUYqZr
         zBhZdD4FwNUb9mYnqZjzi8e+U7wQsJHe4q+iqINOcS0DPAHE8WlMq35q+TheokoUXb5W
         MLjYFgS7ofQm+IdmNC5SIWX8hWlDhBeV4l1umbptIugJppZgLWenxrewrwiq3D54g7wM
         vbU/C04IAudhqeQl9M4cVj+rBzKo2ztO0EnqKanCRuuGZ6aljkAsRnrgod473Z40K7nn
         l+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV0xLAup7ZQZNpBW4l3sk1a+VaHuJlWQJb8/xSAuq+HLtS/IWHnZGl+PAOe47sn5YKPCorQNW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44x5UcLDJMQW7UkkejyWxLJQ7C1NYs0zs+rXVaeNukqeLuzGF
	qwT3qxJN+kKCKHaSnq+jawHsF+O3DsE+5RdxbJXfyvIIf+k5jf9POeFHg5TpXJFahzKDOEDCNgC
	6vXU3a9pCe6MV3P//A041OyqgmH/lm5b7nOH4
X-Gm-Gg: ASbGncuQFH3pt+zK1FH2UyOPuvJPmI23wML1xOrNJVWmTjhkZ0KRjgYkZde3xwpU4Fl
	b+3pS9jD7EiNNfZO6i4vjDaos3TL9Oxnbjy4PIXwx8Ag3zXQYWcwqpqMIuyVLGFmpbJFcvwTjXC
	rg4tG0tS32ldeHUreZdb9odsrL4lQTRqkGHFqAbnndjFhXF7xKGkYg
X-Google-Smtp-Source: AGHT+IEjaFxHjkkzVx2xjewYNe+QyO23N8Ylf2mn48a+pBI5NzBAsVepnNNjmefpF8kB8xR9OOvlLCgpr21i9TTyBxs=
X-Received: by 2002:a05:620a:3908:b0:7c7:b5e9:6428 with SMTP id
 af79cd13be357-7c918fed965mr628225285a.22.1744842769024; Wed, 16 Apr 2025
 15:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410175140.10805-3-luizcmpc@gmail.com> <d44f79b3-6b3e-4c20-abdf-3e7da73e932f@redhat.com>
 <CAHx7jf-1Hga_tY4-kJ_HNkgkWL6RywCmYhg2yYYX+R+mVwdTvA@mail.gmail.com>
 <CANn89i+beuSWok=Z=5gFs2E0JQHyuZrdoaT=orFRzBap_BvVzA@mail.gmail.com> <CAHx7jf807SHbTZhF4LeWsesSPnYxeE6vO37vTGXp+dr-65JP+w@mail.gmail.com>
In-Reply-To: <CAHx7jf807SHbTZhF4LeWsesSPnYxeE6vO37vTGXp+dr-65JP+w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Apr 2025 15:32:38 -0700
X-Gm-Features: ATxdqUHmZiOcS3Mt9rDbZuSujFqkkyhaTYbR--q5fGjybVkzkAWT9t84nm1r1Uw
Message-ID: <CANn89i+75pe6-xQUpnL3K8pD7frgPiqbKmruuDUZ_wUzAeAtzw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND
 is 0
To: =?UTF-8?Q?Luiz_Carlos_Mour=C3=A3o_Paes_de_Carvalho?= <luizcmpc@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 3:30=E2=80=AFPM Luiz Carlos Mour=C3=A3o Paes de Car=
valho
<luizcmpc@gmail.com> wrote:
>
> On Wed, Apr 16, 2025 at 6:40=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Apr 16, 2025 at 1:52=E2=80=AFPM Luiz Carlos Mour=C3=A3o Paes de=
 Carvalho
> > <luizcmpc@gmail.com> wrote:
> > >
> > > Hi Paolo,
> > >
> > > The dropped ack is a response to data sent by the peer.
> > >
> > > Peer sends a chunk of data, we ACK with an incorrect SEQ (SND.NXT) th=
at gets dropped
> > > by the peer's tcp_sequence function. Connection only advances when we=
 send a RTO.
> > >
> > > Let me know if the following describes the scenario you expected. I'l=
l add a packetdrill with
> > > the expected interaction to the patch if it makes sense.
> > >
> > > // Tests the invalid SEQs sent by the listener
> > > // which are then dropped by the peer.
> > >
> > > `./common/defaults.sh
> > > ./common/set_sysctls.py /proc/sys/net/ipv4/tcp_shrink_window=3D0`
> > >
> > >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> > >    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > >    +0 bind(3, ..., ...) =3D 0
> > >    +0 listen(3, 1) =3D 0
> > >
> > >    +0 < S 0:0(0) win 8 <mss 1000,sackOK,nop,nop,nop,wscale 7>
> > >    +0 > S. 0:0(0) ack 1 <...>
> > >   +.1 < . 1:1(0) ack 1 win 8
> > >    +0 accept(3, ..., ...) =3D 4
> > >
> > >    +0 write(4, ..., 990) =3D 990
> > >    +0 > P. 1:991(990) ack 1
> > >    +0 < .  1:1(0) ack 991 win 8           // win=3D8 despite buffer b=
eing almost full, shrink_window=3D0
> > >
> > >    +0 write(4, ..., 100) =3D 100
> > >    +0 > P. 991:1091(100) ack 1            // SND.NXT=3D1091
> > >    +0 < .  1:1(0) ack 991 win 0           // failed to queue rx data,=
 RCV.NXT=3D991, RCV.WND=3D0
> > >
> > >  +0.1 < P. 1:1001(1000) ack 901 win 0
> >
> > This 'ack 901' does not seem right ?
>
> It's indeed incorrect, the bug still occurs if it were 991. Sorry for tha=
t.
>
> >
> > Also your fix would not work if 'win 0' was 'win 1' , and/or if the
> > initial wscale was 6 instead of 7 ?
>
> It indeed does not work if win=3D1, but that's unlikely to happen unless
> you enable shrink_window, and probably
> suggests the mentioned loss of precision.
>
> Now, regarding the scale, it does happen with wscale=3D6 if your second
> write sends < 64 bytes.
> This is true with any other scale. Would happen if it were wscale=3D1
> and the second write sent 2 bytes, etc.
>
> Happens as far as SND.NXT - (SND.UNA + SND.WND) < 1 << wscale.
>
> >
> > >    +0 > .  1091:1091(0) ack 1001          // dropped on tcp_sequence,=
 note that SEQ=3D1091, while (RCV.NXT + RCV.WND)=3D991:
> > >                                           // if (after(seq, tp->rcv_n=
xt + tcp_receive_window(tp)))
> > >                                           //     return SKB_DROP_REAS=
ON_TCP_INVALID_SEQUENCE;
> >
> > I assume that your patch would change the 1091:1091(0) to 991:991(0) ?
>
> Precisely.
>
> >
> > It is not clear if there is a bug here... window reneging is outside
> > RFC specs unfortunately,
> > as hinted in the tcp_acceptable_seq() comments.
>
> Yeah, that got me thinking as well, but although it isn't covered by
> the RFC, the behavior did change since
> 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze"),
> which is a relatively recent patch (Jan 2025).
> Currently, the connection could stall indefinitely, which seems
> unwanted. I would be happy to search for other
> solutions if you have anything come to mind, though.
>
> The way I see it, the stack shouldn't be sending invalid ACKs that are
> known to be incorrect.

These are not ACK, but sequence numbers. They were correct when initially s=
ent.

