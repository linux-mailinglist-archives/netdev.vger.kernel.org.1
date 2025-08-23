Return-Path: <netdev+bounces-216188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E62B32684
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 04:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8ACB023D4
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 02:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E5D205E3E;
	Sat, 23 Aug 2025 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChGZuFk2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67F1F4611
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755917841; cv=none; b=TTDN/YfiHH08EEEd/OEdgJqZYhiDad2URkAF1FTSwhwvhCDidYer1EKFU77pMv1tYhkNpOJNataEUjwY9O3+NwqKfkn53wUstZWHpAIydmygFUrljZyqvi0xf6nocfUVQG5HoQozNdO6Q/xVSq+Hm8Gq9Y0vObZxGM2dRKtgHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755917841; c=relaxed/simple;
	bh=OcLV71MdYFOq76d4qfml5W1hIbK/g8zNRA7O5EvR8Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OK5D47qIvhg9CgqVCHfea/OqyJusNFQ2BUrdnOvAzVYIO01ZKJjpAnb54AoDepEYJQ+9qIgLuD4ISIUDclr5O5GawAfW4CqWjr70vL73tSIeGy0jVBeqFYzAh8vcTb1ZXvVsiFSoAN9zfg/sH0XCd1uefW6Jf/omytvKqY9rFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChGZuFk2; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-51ee4b270c4so37634137.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 19:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755917838; x=1756522638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGn6fyohXbbp+DWXbJ9Mwrsso9RlQ9TXwtEH42isnTU=;
        b=ChGZuFk2jqW7jVSqfSct+uNo6Fi0s3iVavpgB5aYK9f5hBXaYfzRjt3VmzVXSjSCD6
         jHZoFBFdrxf5iH0ruEBulT/b/rk12l9lRhC0QMOT4y8hvI/8qB2cvOKQ91w+kSMYt9yM
         VxxnCiIfG5z8RSzCagIvIxDumGKn1Kk/loc7/lj3c9MKsYyeT4H9ayT8d1MlCE2Fv+Tw
         QUXA1TTQGlhK2Wftnhh0zpR3XN1R7osGQpE0Vr6/qV0W5bIDOcqS9ggnTu2cgh8THzca
         MExtvkbZ1SqCFOf6cd6r6NA0DBehy3zVz2va/Vc7idtfXmKXJiFmXp3y1LsipVGQrK0a
         sw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755917838; x=1756522638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGn6fyohXbbp+DWXbJ9Mwrsso9RlQ9TXwtEH42isnTU=;
        b=Mnc9TW/nSVeWzHZk514ou/+kh8PJuRl9KPEb7x8s5Fd46eMupU33AgQSQ2MihKLAAf
         3WEHcADGYr0jUiRbS1lw2fbqNW+an0KUQzFEGXxlUqONiUZqbWgUvmYnxdj9CxT6NTBc
         3DcaWan4vTVlFyT6ghFhWhHlhQNgbkqVtAvW/DuEK4kBHHqcWipWFu5hbR2VXUpUtgVX
         UwegpQmKf5p6O22ic8UGGOdG3F6y5r8yIp4Y1wYpy/Tib6SRUVfg4C6Rpb4MLPZxzx+K
         UEN3PK7aOG8m7+y09/ywAqsarDqsJkEw9oD6XFKhL4Khb7D6xwikQcdv8Zqs9oXcX7Wh
         793g==
X-Forwarded-Encrypted: i=1; AJvYcCV48qBaLL4V7xmr3M+o2gkphPtw1t2E6R+mEbBxCmqPgE76N3oSUtzGZ3IcUMoS9EW7agh7rxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxivNOy0Aj5tHdKaNc3YQnc4XSqHynJkkFBqdWxZrWN8D5JoOT1
	prNLaRYoac1sqOEgJ3134UEKzcGBQdDpHdpJE9EoBZqTmVBPl0ai8bslIsPi8bjhm75qy8kaud0
	wZtar2WktnNvPJJYAihRZx2HBE1sJHOU=
X-Gm-Gg: ASbGncshgKzqTULb9pNb30Sb/aOday0fmWN8kLTqCpgBtCIMAmhY5pJi9Q+An2W3EM/
	KYs9wpHEdoBTVbP7i8QcwVI0M590bs6K4U117DLbOuN5s90XbtIAP7YDFyQjEqJntssBCFYmeee
	aAZ4KGcyONT3IL1zFWCCwlL1LyWqVDbeqEtGuQx3Ym0LGoSRmlAVJM/zHdEAhXVyT2WE3jt53WQ
	4N5oJ8sUdYLVvaZ5aTmkVLrzp9c8ze9vjwvKgIQ
X-Google-Smtp-Source: AGHT+IG51e1EI0QA+dAdhOL8prvOpNnHqQibsKUNCGzsVmFJEakjfRZQcDIz5JTi6wK9zYkLgF7/vONDTC65GKoXfFw=
X-Received: by 2002:a05:6102:4187:b0:50d:feb0:316e with SMTP id
 ada2fe7eead31-51be7c585fbmr2391796137.2.1755917837916; Fri, 22 Aug 2025
 19:57:17 -0700 (PDT)
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
 <CANn89i+75pe6-xQUpnL3K8pD7frgPiqbKmruuDUZ_wUzAeAtzw@mail.gmail.com>
 <CANn89iKTTapH58UFpF-Ui7JAUOCt1_xin2e0ugMWEgy8vpdgMg@mail.gmail.com>
 <CAHx7jf_brd2KYyPnMS7pdTUzqm+x8WVToTAo=xRB3fMVGHf1TQ@mail.gmail.com> <CANn89iL=S+pKz5GDfHR7x6BoFd_-2G_txV4ZXR7AWKeLNAR1HA@mail.gmail.com>
In-Reply-To: <CANn89iL=S+pKz5GDfHR7x6BoFd_-2G_txV4ZXR7AWKeLNAR1HA@mail.gmail.com>
From: =?UTF-8?Q?Luiz_Carlos_Mour=C3=A3o_Paes_de_Carvalho?= <luizcmpc@gmail.com>
Date: Fri, 22 Aug 2025 23:57:06 -0300
X-Gm-Features: Ac12FXzT3C72bGDb8m6TLrS8VZSJmhRY3gCisd6kyA1RAR1b0vfhhDuv50DvH-k
Message-ID: <CAHx7jf_HP3HOENCWa-nb3tMa4U_RXgXpYL38CsVmuMFqhyUpDw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND
 is 0
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric, it's been a few months.

After coming back to this, I was able to implement a fix as suggested
but it forced me to add
a new field to tcp_sock tracking the maximum advertised seq end (max
rcv_nxt + rcv_wnd).
Although a simple solution, I wonder if this scenario justifies adding
a new field to the already
decently large tcp_sock, for a seemingly rare occurrence. A constant
"wiggle room" for pure ACK SEQs
could also be defined and doesn't require a new field, but is less
correct. Unless there's something
I am not seeing here, and there's another way to fix this.

I'd appreciate your opinion on this. If this is a no-go, I'll happily
continue hacking around the kernel.

Thank you for your time
Luiz Carvalho

On Wed, Apr 16, 2025 at 8:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Apr 16, 2025 at 3:49=E2=80=AFPM Luiz Carlos Mour=C3=A3o Paes de C=
arvalho
> <luizcmpc@gmail.com> wrote:
> >
> > On Wed, Apr 16, 2025 at 7:37=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Apr 16, 2025 at 3:32=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Wed, Apr 16, 2025 at 3:30=E2=80=AFPM Luiz Carlos Mour=C3=A3o Pae=
s de Carvalho
> > > > <luizcmpc@gmail.com> wrote:
> > > > >
> > > > > On Wed, Apr 16, 2025 at 6:40=E2=80=AFPM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 16, 2025 at 1:52=E2=80=AFPM Luiz Carlos Mour=C3=A3o=
 Paes de Carvalho
> > > > > > <luizcmpc@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Paolo,
> > > > > > >
> > > > > > > The dropped ack is a response to data sent by the peer.
> > > > > > >
> > > > > > > Peer sends a chunk of data, we ACK with an incorrect SEQ (SND=
.NXT) that gets dropped
> > > > > > > by the peer's tcp_sequence function. Connection only advances=
 when we send a RTO.
> > > > > > >
> > > > > > > Let me know if the following describes the scenario you expec=
ted. I'll add a packetdrill with
> > > > > > > the expected interaction to the patch if it makes sense.
> > > > > > >
> > > > > > > // Tests the invalid SEQs sent by the listener
> > > > > > > // which are then dropped by the peer.
> > > > > > >
> > > > > > > `./common/defaults.sh
> > > > > > > ./common/set_sysctls.py /proc/sys/net/ipv4/tcp_shrink_window=
=3D0`
> > > > > > >
> > > > > > >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> > > > > > >    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > > > > > >    +0 bind(3, ..., ...) =3D 0
> > > > > > >    +0 listen(3, 1) =3D 0
> > > > > > >
> > > > > > >    +0 < S 0:0(0) win 8 <mss 1000,sackOK,nop,nop,nop,wscale 7>
> > > > > > >    +0 > S. 0:0(0) ack 1 <...>
> > > > > > >   +.1 < . 1:1(0) ack 1 win 8
> > > > > > >    +0 accept(3, ..., ...) =3D 4
> > > > > > >
> > > > > > >    +0 write(4, ..., 990) =3D 990
> > > > > > >    +0 > P. 1:991(990) ack 1
> > > > > > >    +0 < .  1:1(0) ack 991 win 8           // win=3D8 despite =
buffer being almost full, shrink_window=3D0
> > > > > > >
> > > > > > >    +0 write(4, ..., 100) =3D 100
> > > > > > >    +0 > P. 991:1091(100) ack 1            // SND.NXT=3D1091
> > > > > > >    +0 < .  1:1(0) ack 991 win 0           // failed to queue =
rx data, RCV.NXT=3D991, RCV.WND=3D0
> > > > > > >
> > > > > > >  +0.1 < P. 1:1001(1000) ack 901 win 0
> > > > > >
> > > > > > This 'ack 901' does not seem right ?
> > > > >
> > > > > It's indeed incorrect, the bug still occurs if it were 991. Sorry=
 for that.
> > > > >
> > > > > >
> > > > > > Also your fix would not work if 'win 0' was 'win 1' , and/or if=
 the
> > > > > > initial wscale was 6 instead of 7 ?
> > > > >
> > > > > It indeed does not work if win=3D1, but that's unlikely to happen=
 unless
> > > > > you enable shrink_window, and probably
> > > > > suggests the mentioned loss of precision.
> > > > >
> > > > > Now, regarding the scale, it does happen with wscale=3D6 if your =
second
> > > > > write sends < 64 bytes.
> > > > > This is true with any other scale. Would happen if it were wscale=
=3D1
> > > > > and the second write sent 2 bytes, etc.
> > > > >
> > > > > Happens as far as SND.NXT - (SND.UNA + SND.WND) < 1 << wscale.
> > > > >
> > > > > >
> > > > > > >    +0 > .  1091:1091(0) ack 1001          // dropped on tcp_s=
equence, note that SEQ=3D1091, while (RCV.NXT + RCV.WND)=3D991:
> > > > > > >                                           // if (after(seq, t=
p->rcv_nxt + tcp_receive_window(tp)))
> > > > > > >                                           //     return SKB_D=
ROP_REASON_TCP_INVALID_SEQUENCE;
> > > > > >
> > > > > > I assume that your patch would change the 1091:1091(0) to 991:9=
91(0) ?
> > > > >
> > > > > Precisely.
> > > > >
> > > > > >
> > > > > > It is not clear if there is a bug here... window reneging is ou=
tside
> > > > > > RFC specs unfortunately,
> > > > > > as hinted in the tcp_acceptable_seq() comments.
> > > > >
> > > > > Yeah, that got me thinking as well, but although it isn't covered=
 by
> > > > > the RFC, the behavior did change since
> > > > > 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze"),
> > > > > which is a relatively recent patch (Jan 2025).
> > > > > Currently, the connection could stall indefinitely, which seems
> > > > > unwanted. I would be happy to search for other
> > > > > solutions if you have anything come to mind, though.
> > > > >
> > > > > The way I see it, the stack shouldn't be sending invalid ACKs tha=
t are
> > > > > known to be incorrect.
> > > >
> > > > These are not ACK, but sequence numbers. They were correct when ini=
tially sent.
> >
> > Yes, I meant invalid ACK packets, with "incorrect" sequence numbers
> > (more advanced than they should have been for this specific ZeroWindow
> > scenario). The server has enough knowledge to know what the other peer
> > expects (the RFC 793 quote in the original message), thus the "known
> > to be incorrect". I am, however, new to the spec and stack.
> >
> > >
> > > You might try to fix the issue on the other side of the connection,
> > > the one doing reneging...
> >
> > Would that be adjusting tcp_sequence as per RFC 793, page 69?
> >
> >         If the RCV.WND is zero, no segments will be acceptable, but
> >         special allowance should be made to accept valid ACKs, URGs and
> >         RSTs.
> >
> > My initial idea was to change tcp_sequence slightly to pass the test
> > if RCV.WND is 0. My assessment was that it could go against the
> > mentioned test (SEG.SEQ =3D RCV.NXT), and would also require some bigge=
r
> > changes to tcp_validate_incoming as tcp_rcv_established would still
> > need to drop the SKB but process the ACK. I'd be happy to give it a
> > shot anyway.
>
> Please do not focus on RWIN 0, but more generally.
>
> If a peer sent a ACK @seq WIN (@X << wscale), at some point in the past,
> then it should accept any SEQ _before_  @seq + (@X << wscale),
> especially from a pure ACK packet.
>
> Reneging (ie decrease RWIN) makes sense as a way to deal with memory stre=
ss,
> but should allow pure acks to be accepted if there sequence is not too
> far in the future.
>
> tcp_receive_window(const struct tcp_sock *tp)
> ...
> s32 win =3D tp->rcv_wup + tp->rcv_wnd - tp->rcv_nxt;
>
>
> ...
> if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
>     return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
>
>
> -->
>
> if (after(seq, max_admissible_seq(tp))
>     return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
>
> Reneging would no retract max_admissible_seq() as far as
> tcp_sequence() is concerned.

