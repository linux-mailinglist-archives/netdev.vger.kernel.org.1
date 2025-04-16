Return-Path: <netdev+bounces-183524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D093A90EB1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90D63AB309
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D285233120;
	Wed, 16 Apr 2025 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExbFGIHE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134518D63E
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843070; cv=none; b=ECJ00/OVMZ3zYpSjWXld8SwKpm0ConH1cPJ77moE49wEkiVzDYsSrcVVpyirazwm9SB5OoyvEj9uc6IbI5WVygDvnFfuVj78kzmXiotp9H6nCHiCy5RjPeVkQQo6Kaw6WpfaDFl3fYxsmv99nMHotMEeFpcu6bV5YNjFCTEnjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843070; c=relaxed/simple;
	bh=yaj5RHPdWA9SJ9g8P1pUxkWQrMzfLAPvPY6KR4kflEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5IRd37WMF612mpgLmuevuqgd+fue8y/3cNe34XYWioMboQ5uOPO7Z4tmVUm6seAyybZUmN0P5mOczPsrLpC2vvWuVkEpEqjqrVROP9uBQ94ZXb0ViFVKMNslGEE0rpRNXaVIFBM+DiKYTbJWiL4ikDDCbH1+ZXtsnT/eVyqnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ExbFGIHE; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so12963796d6.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744843065; x=1745447865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w45Qb5cZ5Ni3Eiqk0ykXkSdp+JMvg3KmVvOKXD7dN6c=;
        b=ExbFGIHE3CZn4MPe6Ooo9T7MPGtE8xhJCf4zVTpmoOU+PigsNhsTJcqrQaJZZGm3vC
         MrH16BiyzA+IPMQSOWGrScZfSglo4spnkBWWY4lGpfRPhtt3zPe9IXaGrQqKBP+5n8ZP
         aP9EFgwfLuVQ7Fy86c58PJaA3tooQvCeT2j30ChyVNCXSZ8TVPk9iul24pM6A48XCv84
         6KqA/peRMI6dkd4hAVkDMYthWNcz3pU1ehE98yOjs3sCpl0NKyi2ZQh5KXzTGgupoViN
         sB4rwwP8DjJAy4NPV6oPU8+BoK29JHf9CnPVahJX/HFfJkgDHvrN2wnzab0FnZGsVwdV
         SuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843065; x=1745447865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w45Qb5cZ5Ni3Eiqk0ykXkSdp+JMvg3KmVvOKXD7dN6c=;
        b=MAPSX91sYam7U0G/9WlArWy5FA6QJ6N0fwebfOhV3M27R2i9yTGHqgf3i03gejhf+f
         b1ZZwYZgBr39e0QifBpgfHC2zTr5CMDe3AbhmV9D3i+X5syMA7YZHNBgn1ogpIpJ2O/4
         jYtncI/kjGD4GpDUfDAzTFh8dsir/io2ZQLP7ay/vH+gaQ8LU2IK9Zdb/hW24pal89TT
         yLpuhb8yk/zA3uEsJkixlUCUUhl2W2f5g2nILDHCB1W2UhfcR+3W9yK13yeQ3uMo/MS6
         AZAm1/Fm62TuK/Fub5nC86FGDKYYgUCZ3AXgyPJs/fDcCITLvlfA6BVGxiiPrFaWynBh
         CJFg==
X-Forwarded-Encrypted: i=1; AJvYcCUJRuXuGfvk2nHDJhNqOU7+Qp/O4LNzt3NXR0YruErK2/A/HUdp3x9Pqi0J23qC0VCeZQ5qZVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWs1ekNnfNQthITww45f31kIgJhq3e2SQEby2oE7C5hZMMhvT
	zDOprPHHpzoFu0q8EmeRS5JvUJf1YPL6agzQtTj8Kkp5ZJ456rrQkQih23XKN9KdCg6mOxs72L7
	d2b02OcCYyzjjsK5EJ5UPsCQc9gNq1PgIGNE+
X-Gm-Gg: ASbGnctK3N8BsOSAjEFl+UHJlTk5f6zqh1pWeU7Ev0WA2+rID8vOJWadNcoNuwKMAc5
	in3azrdw3WaymQiQEr7zQdUsc36PEq97TvTv/PTGCdi6EiBZF7f6LbluUqspWbAjYZkS8fgF9Va
	XZmvvk+Azy4ttLk9e8bUUIXY8htuOkLh7EdCQhjCKTwm68hDY1/Kfy
X-Google-Smtp-Source: AGHT+IHE7zfV0vbaoSGpidi5cOCNUiPk0s6TLrc/BsVQc0r0906oXzXgzI9mmHnmjCeBBPBmL3yq5QZGAzfriwUsZK4=
X-Received: by 2002:a05:6214:21cd:b0:6ea:d604:9e4f with SMTP id
 6a1803df08f44-6f2ba75c939mr11118876d6.19.1744843065415; Wed, 16 Apr 2025
 15:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410175140.10805-3-luizcmpc@gmail.com> <d44f79b3-6b3e-4c20-abdf-3e7da73e932f@redhat.com>
 <CAHx7jf-1Hga_tY4-kJ_HNkgkWL6RywCmYhg2yYYX+R+mVwdTvA@mail.gmail.com>
 <CANn89i+beuSWok=Z=5gFs2E0JQHyuZrdoaT=orFRzBap_BvVzA@mail.gmail.com>
 <CAHx7jf807SHbTZhF4LeWsesSPnYxeE6vO37vTGXp+dr-65JP+w@mail.gmail.com> <CANn89i+75pe6-xQUpnL3K8pD7frgPiqbKmruuDUZ_wUzAeAtzw@mail.gmail.com>
In-Reply-To: <CANn89i+75pe6-xQUpnL3K8pD7frgPiqbKmruuDUZ_wUzAeAtzw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Apr 2025 15:37:34 -0700
X-Gm-Features: ATxdqUG7ZzNKSYVxSVN6eCAcRkPQu4Nqsz_EgOzRxAgq-z-6uYfc74n1g_6Z4Ts
Message-ID: <CANn89iKTTapH58UFpF-Ui7JAUOCt1_xin2e0ugMWEgy8vpdgMg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND
 is 0
To: =?UTF-8?Q?Luiz_Carlos_Mour=C3=A3o_Paes_de_Carvalho?= <luizcmpc@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 3:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Apr 16, 2025 at 3:30=E2=80=AFPM Luiz Carlos Mour=C3=A3o Paes de C=
arvalho
> <luizcmpc@gmail.com> wrote:
> >
> > On Wed, Apr 16, 2025 at 6:40=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Apr 16, 2025 at 1:52=E2=80=AFPM Luiz Carlos Mour=C3=A3o Paes =
de Carvalho
> > > <luizcmpc@gmail.com> wrote:
> > > >
> > > > Hi Paolo,
> > > >
> > > > The dropped ack is a response to data sent by the peer.
> > > >
> > > > Peer sends a chunk of data, we ACK with an incorrect SEQ (SND.NXT) =
that gets dropped
> > > > by the peer's tcp_sequence function. Connection only advances when =
we send a RTO.
> > > >
> > > > Let me know if the following describes the scenario you expected. I=
'll add a packetdrill with
> > > > the expected interaction to the patch if it makes sense.
> > > >
> > > > // Tests the invalid SEQs sent by the listener
> > > > // which are then dropped by the peer.
> > > >
> > > > `./common/defaults.sh
> > > > ./common/set_sysctls.py /proc/sys/net/ipv4/tcp_shrink_window=3D0`
> > > >
> > > >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> > > >    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > > >    +0 bind(3, ..., ...) =3D 0
> > > >    +0 listen(3, 1) =3D 0
> > > >
> > > >    +0 < S 0:0(0) win 8 <mss 1000,sackOK,nop,nop,nop,wscale 7>
> > > >    +0 > S. 0:0(0) ack 1 <...>
> > > >   +.1 < . 1:1(0) ack 1 win 8
> > > >    +0 accept(3, ..., ...) =3D 4
> > > >
> > > >    +0 write(4, ..., 990) =3D 990
> > > >    +0 > P. 1:991(990) ack 1
> > > >    +0 < .  1:1(0) ack 991 win 8           // win=3D8 despite buffer=
 being almost full, shrink_window=3D0
> > > >
> > > >    +0 write(4, ..., 100) =3D 100
> > > >    +0 > P. 991:1091(100) ack 1            // SND.NXT=3D1091
> > > >    +0 < .  1:1(0) ack 991 win 0           // failed to queue rx dat=
a, RCV.NXT=3D991, RCV.WND=3D0
> > > >
> > > >  +0.1 < P. 1:1001(1000) ack 901 win 0
> > >
> > > This 'ack 901' does not seem right ?
> >
> > It's indeed incorrect, the bug still occurs if it were 991. Sorry for t=
hat.
> >
> > >
> > > Also your fix would not work if 'win 0' was 'win 1' , and/or if the
> > > initial wscale was 6 instead of 7 ?
> >
> > It indeed does not work if win=3D1, but that's unlikely to happen unles=
s
> > you enable shrink_window, and probably
> > suggests the mentioned loss of precision.
> >
> > Now, regarding the scale, it does happen with wscale=3D6 if your second
> > write sends < 64 bytes.
> > This is true with any other scale. Would happen if it were wscale=3D1
> > and the second write sent 2 bytes, etc.
> >
> > Happens as far as SND.NXT - (SND.UNA + SND.WND) < 1 << wscale.
> >
> > >
> > > >    +0 > .  1091:1091(0) ack 1001          // dropped on tcp_sequenc=
e, note that SEQ=3D1091, while (RCV.NXT + RCV.WND)=3D991:
> > > >                                           // if (after(seq, tp->rcv=
_nxt + tcp_receive_window(tp)))
> > > >                                           //     return SKB_DROP_RE=
ASON_TCP_INVALID_SEQUENCE;
> > >
> > > I assume that your patch would change the 1091:1091(0) to 991:991(0) =
?
> >
> > Precisely.
> >
> > >
> > > It is not clear if there is a bug here... window reneging is outside
> > > RFC specs unfortunately,
> > > as hinted in the tcp_acceptable_seq() comments.
> >
> > Yeah, that got me thinking as well, but although it isn't covered by
> > the RFC, the behavior did change since
> > 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze"),
> > which is a relatively recent patch (Jan 2025).
> > Currently, the connection could stall indefinitely, which seems
> > unwanted. I would be happy to search for other
> > solutions if you have anything come to mind, though.
> >
> > The way I see it, the stack shouldn't be sending invalid ACKs that are
> > known to be incorrect.
>
> These are not ACK, but sequence numbers. They were correct when initially=
 sent.

You might try to fix the issue on the other side of the connection,
the one doing reneging...

