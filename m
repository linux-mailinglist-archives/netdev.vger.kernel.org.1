Return-Path: <netdev+bounces-183534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E7A90EEA
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F4717176C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023F2245008;
	Wed, 16 Apr 2025 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUxIgXZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2824887A
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843784; cv=none; b=W7hivHZQqYkHVaEuqwSo/T914TRtnG0CW3C8eikKliHiANz8m+o1KjfJo76Ty6tuxCX4LU8iexhHjyQ+M90awc1quHBvaqiEGEIqNiz6aKt3SoliIA5r8qBILXHE7qHQgDsOqQvKJYk6Phy9p+h16xjWHtOiWk32fv2Rs9IGD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843784; c=relaxed/simple;
	bh=JkdVpEWgagg/YQOenBfUZyuowb183sW38lpIHO0swNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUF0+WS6TYHq+eprGz1B7ZMKn2DUUu9pU5L54/Uz8zFZQ08sXzjvW9jdeyZWxliXdT6jzCKo7YHwkN6k//ELGkimPd6OElxLtqg3UPhwHGwzp5FVPVcSdCQN3jSNTXaGf0ojMc+D4ILde2dq7JEoCdeRWEoiAE9zW3augoyZvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUxIgXZT; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86d3907524cso76206241.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744843782; x=1745448582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S79bMo4UquEm5/mxAw0yl5hXwqAvoeQuG+oHzMjrcrM=;
        b=mUxIgXZTlAn/lxh3MZlBNWSEjHnR9XQmwE79FAjBl1rt46l4iH6rrwmz9k+K7EWmrw
         EGhAFW2+9nfQFW4S0bfzU/I5dHAuGb2Siwqs5vg1DkSajwhnXdMaloeIaIUNIBRjD5p1
         mcXAEIQDQjPZNL67IFQ+ZMlvx04BjvBGYH9bZGwflCJjuE2mPlAHSia6piHVV1c37PHM
         04vytnLnQ0LRcs4lIwNY3ExgbQ/UYFUxNPYH+t7AaLBNMv5LPktD7Y/3WX7Ouo/gGyCC
         KlHD8/mRh1M3K4++5V0pBtSlWKsdd/WMra2vw6hTzcWIIxR+ksxQWPoqSzdEZRjRZT/Z
         smwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843782; x=1745448582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S79bMo4UquEm5/mxAw0yl5hXwqAvoeQuG+oHzMjrcrM=;
        b=gupyS1hfqiailPc35in6QkmTy+/JABOb0xavilWoc9Vw2o1BYxOBEduQGTUJtKNUf5
         smV/UcHsXvKOCjip0L1PmKeeuD+eFdMDFMRavfm19TVMdZ74Bs2mnPjHgh4WqeM8zDuh
         VJZ39mNbAvMhJTNG3hUacFdUMLrRnhbh1v1uEguSZyOk19+5NFVCAR/Q4tNO4o0XsXuE
         +zCKAqW66blLdsO6x3ADBwSYcIOpPL4iZUa4DLpraDC092a3iFdua6jDLKqfIMe39lpg
         FjZ1fxfDZWVQqa3Plv6scG5nBpsZAbylhvTtaf5j05O12Th43Gthog/Q71CMBulx5bkQ
         ESwg==
X-Forwarded-Encrypted: i=1; AJvYcCXtQ2zi5tPBBhAmVlOQqVfKzKcFZUMb3M/zGIgC8lcq93czoKPoku/JZothvpKUbYyFKVwlidg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35HWpp6YM7nqRNg2Z8wWZPbF7y/Batj5ALys1ArzXeqhxbtNB
	Qd/49Sqbp3oV8aSfFypRVKKCIQ7pbdGyJnJw3Wjc5vQSDLy9voexb75uLScQHFL60+9DwjdFIW1
	iu5j65o+TbafvwdeOZDvYFD1vWFU=
X-Gm-Gg: ASbGncs9SiTjld2U1uIG+yIejfAh5JP75dHRjM0xBvYppCWpXVQ+Nh+v1xreVirKlxS
	9ktnkztc98tibqKm1H7QGL7+9llEbLkX+1yFmGCTfsp2QoOn1YRZENBfhMNwNyxqiDVhiDaVjpi
	OmwCzGfXNRPd1pKarEicksUsdFcxrwgstCvG4LiLe2lSCZfX++7sST
X-Google-Smtp-Source: AGHT+IG3be1aczwb8QHruMYM6ZXtj+HSoeVeqJyZReE10JTPPS0df4AlXamfjqJOXmmAlOySEPTkLAMA1QbUZvKb5bI=
X-Received: by 2002:a05:6102:5617:b0:4bb:cf34:374d with SMTP id
 ada2fe7eead31-4cb5927b5d5mr2418732137.20.1744843781824; Wed, 16 Apr 2025
 15:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410175140.10805-3-luizcmpc@gmail.com> <d44f79b3-6b3e-4c20-abdf-3e7da73e932f@redhat.com>
 <CAHx7jf-1Hga_tY4-kJ_HNkgkWL6RywCmYhg2yYYX+R+mVwdTvA@mail.gmail.com>
 <CANn89i+beuSWok=Z=5gFs2E0JQHyuZrdoaT=orFRzBap_BvVzA@mail.gmail.com>
 <CAHx7jf807SHbTZhF4LeWsesSPnYxeE6vO37vTGXp+dr-65JP+w@mail.gmail.com>
 <CANn89i+75pe6-xQUpnL3K8pD7frgPiqbKmruuDUZ_wUzAeAtzw@mail.gmail.com> <CANn89iKTTapH58UFpF-Ui7JAUOCt1_xin2e0ugMWEgy8vpdgMg@mail.gmail.com>
In-Reply-To: <CANn89iKTTapH58UFpF-Ui7JAUOCt1_xin2e0ugMWEgy8vpdgMg@mail.gmail.com>
From: =?UTF-8?Q?Luiz_Carlos_Mour=C3=A3o_Paes_de_Carvalho?= <luizcmpc@gmail.com>
Date: Wed, 16 Apr 2025 19:49:30 -0300
X-Gm-Features: ATxdqUGy3YokJMx2ZvAxzUB3Z_cb0GCug7mqfvkyi3Bndsc6ID3ac6VgdW48F9U
Message-ID: <CAHx7jf_brd2KYyPnMS7pdTUzqm+x8WVToTAo=xRB3fMVGHf1TQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND
 is 0
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 7:37=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Apr 16, 2025 at 3:32=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Apr 16, 2025 at 3:30=E2=80=AFPM Luiz Carlos Mour=C3=A3o Paes de=
 Carvalho
> > <luizcmpc@gmail.com> wrote:
> > >
> > > On Wed, Apr 16, 2025 at 6:40=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Wed, Apr 16, 2025 at 1:52=E2=80=AFPM Luiz Carlos Mour=C3=A3o Pae=
s de Carvalho
> > > > <luizcmpc@gmail.com> wrote:
> > > > >
> > > > > Hi Paolo,
> > > > >
> > > > > The dropped ack is a response to data sent by the peer.
> > > > >
> > > > > Peer sends a chunk of data, we ACK with an incorrect SEQ (SND.NXT=
) that gets dropped
> > > > > by the peer's tcp_sequence function. Connection only advances whe=
n we send a RTO.
> > > > >
> > > > > Let me know if the following describes the scenario you expected.=
 I'll add a packetdrill with
> > > > > the expected interaction to the patch if it makes sense.
> > > > >
> > > > > // Tests the invalid SEQs sent by the listener
> > > > > // which are then dropped by the peer.
> > > > >
> > > > > `./common/defaults.sh
> > > > > ./common/set_sysctls.py /proc/sys/net/ipv4/tcp_shrink_window=3D0`
> > > > >
> > > > >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> > > > >    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > > > >    +0 bind(3, ..., ...) =3D 0
> > > > >    +0 listen(3, 1) =3D 0
> > > > >
> > > > >    +0 < S 0:0(0) win 8 <mss 1000,sackOK,nop,nop,nop,wscale 7>
> > > > >    +0 > S. 0:0(0) ack 1 <...>
> > > > >   +.1 < . 1:1(0) ack 1 win 8
> > > > >    +0 accept(3, ..., ...) =3D 4
> > > > >
> > > > >    +0 write(4, ..., 990) =3D 990
> > > > >    +0 > P. 1:991(990) ack 1
> > > > >    +0 < .  1:1(0) ack 991 win 8           // win=3D8 despite buff=
er being almost full, shrink_window=3D0
> > > > >
> > > > >    +0 write(4, ..., 100) =3D 100
> > > > >    +0 > P. 991:1091(100) ack 1            // SND.NXT=3D1091
> > > > >    +0 < .  1:1(0) ack 991 win 0           // failed to queue rx d=
ata, RCV.NXT=3D991, RCV.WND=3D0
> > > > >
> > > > >  +0.1 < P. 1:1001(1000) ack 901 win 0
> > > >
> > > > This 'ack 901' does not seem right ?
> > >
> > > It's indeed incorrect, the bug still occurs if it were 991. Sorry for=
 that.
> > >
> > > >
> > > > Also your fix would not work if 'win 0' was 'win 1' , and/or if the
> > > > initial wscale was 6 instead of 7 ?
> > >
> > > It indeed does not work if win=3D1, but that's unlikely to happen unl=
ess
> > > you enable shrink_window, and probably
> > > suggests the mentioned loss of precision.
> > >
> > > Now, regarding the scale, it does happen with wscale=3D6 if your seco=
nd
> > > write sends < 64 bytes.
> > > This is true with any other scale. Would happen if it were wscale=3D1
> > > and the second write sent 2 bytes, etc.
> > >
> > > Happens as far as SND.NXT - (SND.UNA + SND.WND) < 1 << wscale.
> > >
> > > >
> > > > >    +0 > .  1091:1091(0) ack 1001          // dropped on tcp_seque=
nce, note that SEQ=3D1091, while (RCV.NXT + RCV.WND)=3D991:
> > > > >                                           // if (after(seq, tp->r=
cv_nxt + tcp_receive_window(tp)))
> > > > >                                           //     return SKB_DROP_=
REASON_TCP_INVALID_SEQUENCE;
> > > >
> > > > I assume that your patch would change the 1091:1091(0) to 991:991(0=
) ?
> > >
> > > Precisely.
> > >
> > > >
> > > > It is not clear if there is a bug here... window reneging is outsid=
e
> > > > RFC specs unfortunately,
> > > > as hinted in the tcp_acceptable_seq() comments.
> > >
> > > Yeah, that got me thinking as well, but although it isn't covered by
> > > the RFC, the behavior did change since
> > > 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze"),
> > > which is a relatively recent patch (Jan 2025).
> > > Currently, the connection could stall indefinitely, which seems
> > > unwanted. I would be happy to search for other
> > > solutions if you have anything come to mind, though.
> > >
> > > The way I see it, the stack shouldn't be sending invalid ACKs that ar=
e
> > > known to be incorrect.
> >
> > These are not ACK, but sequence numbers. They were correct when initial=
ly sent.

Yes, I meant invalid ACK packets, with "incorrect" sequence numbers
(more advanced than they should have been for this specific ZeroWindow
scenario). The server has enough knowledge to know what the other peer
expects (the RFC 793 quote in the original message), thus the "known
to be incorrect". I am, however, new to the spec and stack.

>
> You might try to fix the issue on the other side of the connection,
> the one doing reneging...

Would that be adjusting tcp_sequence as per RFC 793, page 69?

        If the RCV.WND is zero, no segments will be acceptable, but
        special allowance should be made to accept valid ACKs, URGs and
        RSTs.

My initial idea was to change tcp_sequence slightly to pass the test
if RCV.WND is 0. My assessment was that it could go against the
mentioned test (SEG.SEQ =3D RCV.NXT), and would also require some bigger
changes to tcp_validate_incoming as tcp_rcv_established would still
need to drop the SKB but process the ACK. I'd be happy to give it a
shot anyway.

