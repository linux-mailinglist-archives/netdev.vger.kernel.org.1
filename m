Return-Path: <netdev+bounces-183539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291D8A90F10
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B48444B83
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E836922371B;
	Wed, 16 Apr 2025 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBMhcYhL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39541B0F23
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744844461; cv=none; b=ikGdx101JoDEl3199FTMo/IYqyDq65YgBvIB4as081yFnTFBrAyvp6Fdzq4iHwhksTIDGO9ckBqRu3RmkkondiUgQKmJl1RiCvV2WfeeeqDSEC6gVkv9xREaylaPZST2PbpfKGAh6Fq8WUrXRJbWxmV/ZJwbDW4b5c6p/69Y2Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744844461; c=relaxed/simple;
	bh=EKWQCWDUZx4qHwi8chMThxHbn8mkRL7OFYxk3eiVn8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjyvmVCYbdM6m4LJ5pJau1IwOG9ljX8kkiHBg2nFHaHblx5oSxVtfi+XTblz8lyi2DxS2c0NTx7cvLarZAIYH/TqyLujE56GjXfE7l2O7g6DgWCzyAaZkoPa6lsGcwcTFv+set8279h5zCXPNmIP4qoQztyYrSgdNPFBZf+AkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBMhcYhL; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4774193fdffso2229511cf.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744844459; x=1745449259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP3orIY5lTAbQwWPTCPGFz88tYuHiHszruRj+XK4zJk=;
        b=aBMhcYhLUlApc+EemMLkUF9TrfK6iv4qqV1WjmRg2GggQd1O65WCfp8n87Q50daZ3E
         /AQ8zVbJlittYjO+EcqIf+8wegY/qGZkOcAafnYYrGTYccxdqMXGZ0XU+GFoB/3i9F0E
         bZ1g78hHrBlKuQmhf+kPC8jiaouhf5dQzRkjP2Z/Hj8j5rV19IuRzpoSIxQizRemOZCs
         MDO+Ebrqogc2lYluHZE++mEHO7SxCQMEwuCgw5jf/wSwnxbNVXr1f2CWNYhXotH6xzMs
         baqrlyAcnqtE9su5Eyu9/f98v5Vdk7j/7y0uutWanrskqZ4x1u+4MdQSaWLr6QbQZyPX
         JEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744844459; x=1745449259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tP3orIY5lTAbQwWPTCPGFz88tYuHiHszruRj+XK4zJk=;
        b=rzdrjyQdacCWJ8iGpBewDtWD0xDKuMm6pfjF0gTUbSKkA90wz5gj4lNYhKQ56oI3wz
         /63fo1AT8kwQUXW1o9A1XZklbEg7p4MTlCElPTXhuBIceAZ6bab5WunKw4kuLQKCQjQQ
         vZYOeVSFW/kf6g4Uq8vC7Yh5qiRVrGZghdx0P/sZbIr5tcjQwf/NWtsDiKCXc01n0w58
         ei5XrTZQpKjZGkMgRZ8/3QW67vOH9p0RCckIGPchF9g1GufTSWQcoJTbK6t471vYbHtZ
         lh3rCCCeZ8uHeZdoGW/qFGXYtyr8+6csxUiZ91zGz4gP0jVIx4uPOnj8VV8FSSw2oVdc
         p3Qg==
X-Forwarded-Encrypted: i=1; AJvYcCW4PX01M67gxfKZ/wIip9AmBHNap7TePzwhecW7FILpjcmBUEM4Nkx5HCGpqNSmCzAxH/x39fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfnj0dSGDM61cJTHXLsCiISdrbG8QZosWLJT4+GmWP8AKKO5Qu
	EEbCbEUkpzEhWFJxGm5axHA9uC7QCq/qtdseLuUpw8kb7P9Qof1je6uMcA0mxWy434mHz/+asq4
	ljJcVj6AKbrM9INgxwWqy9VhHrjWGCjdKa3cz
X-Gm-Gg: ASbGncvRdUJRhEI+ulXdf7rRGvvy1muGlu/WZUVZ8Ztlo4bGoZzrrlOQR7SGxDojlTm
	Tgd3ybK5hMYtBiPyxieURW7rwQEbWdPzzGV4SkG8LnO8x0kEJcUe+yK9nY5pRqqlYGXEw62b7s1
	ay44kfzZdwXi8XkdHnWHYAVaZ7CCbuMHibEa2Q214NVmmf9CCQ3MCM
X-Google-Smtp-Source: AGHT+IE4BgJWjdoWOVtbFg3nBuU6Dk1HIezy9XhJ5nQ+kRuVf1aMSWegZs3bZBpdB1uDckJTNrjknc8oAIm7OkbmFyM=
X-Received: by 2002:ac8:5811:0:b0:477:6f1f:e1d6 with SMTP id
 d75a77b69052e-47ad809743dmr60636481cf.3.1744844458401; Wed, 16 Apr 2025
 16:00:58 -0700 (PDT)
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
 <CANn89iKTTapH58UFpF-Ui7JAUOCt1_xin2e0ugMWEgy8vpdgMg@mail.gmail.com> <CAHx7jf_brd2KYyPnMS7pdTUzqm+x8WVToTAo=xRB3fMVGHf1TQ@mail.gmail.com>
In-Reply-To: <CAHx7jf_brd2KYyPnMS7pdTUzqm+x8WVToTAo=xRB3fMVGHf1TQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Apr 2025 16:00:47 -0700
X-Gm-Features: ATxdqUFAR-5kdIVFWRCSSJX5bpcSrdq-Cc1gQszmRHVZmeSTV_7R0-uW1K_MGtY
Message-ID: <CANn89iL=S+pKz5GDfHR7x6BoFd_-2G_txV4ZXR7AWKeLNAR1HA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND
 is 0
To: =?UTF-8?Q?Luiz_Carlos_Mour=C3=A3o_Paes_de_Carvalho?= <luizcmpc@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 3:49=E2=80=AFPM Luiz Carlos Mour=C3=A3o Paes de Car=
valho
<luizcmpc@gmail.com> wrote:
>
> On Wed, Apr 16, 2025 at 7:37=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Apr 16, 2025 at 3:32=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Apr 16, 2025 at 3:30=E2=80=AFPM Luiz Carlos Mour=C3=A3o Paes =
de Carvalho
> > > <luizcmpc@gmail.com> wrote:
> > > >
> > > > On Wed, Apr 16, 2025 at 6:40=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Wed, Apr 16, 2025 at 1:52=E2=80=AFPM Luiz Carlos Mour=C3=A3o P=
aes de Carvalho
> > > > > <luizcmpc@gmail.com> wrote:
> > > > > >
> > > > > > Hi Paolo,
> > > > > >
> > > > > > The dropped ack is a response to data sent by the peer.
> > > > > >
> > > > > > Peer sends a chunk of data, we ACK with an incorrect SEQ (SND.N=
XT) that gets dropped
> > > > > > by the peer's tcp_sequence function. Connection only advances w=
hen we send a RTO.
> > > > > >
> > > > > > Let me know if the following describes the scenario you expecte=
d. I'll add a packetdrill with
> > > > > > the expected interaction to the patch if it makes sense.
> > > > > >
> > > > > > // Tests the invalid SEQs sent by the listener
> > > > > > // which are then dropped by the peer.
> > > > > >
> > > > > > `./common/defaults.sh
> > > > > > ./common/set_sysctls.py /proc/sys/net/ipv4/tcp_shrink_window=3D=
0`
> > > > > >
> > > > > >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> > > > > >    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > > > > >    +0 bind(3, ..., ...) =3D 0
> > > > > >    +0 listen(3, 1) =3D 0
> > > > > >
> > > > > >    +0 < S 0:0(0) win 8 <mss 1000,sackOK,nop,nop,nop,wscale 7>
> > > > > >    +0 > S. 0:0(0) ack 1 <...>
> > > > > >   +.1 < . 1:1(0) ack 1 win 8
> > > > > >    +0 accept(3, ..., ...) =3D 4
> > > > > >
> > > > > >    +0 write(4, ..., 990) =3D 990
> > > > > >    +0 > P. 1:991(990) ack 1
> > > > > >    +0 < .  1:1(0) ack 991 win 8           // win=3D8 despite bu=
ffer being almost full, shrink_window=3D0
> > > > > >
> > > > > >    +0 write(4, ..., 100) =3D 100
> > > > > >    +0 > P. 991:1091(100) ack 1            // SND.NXT=3D1091
> > > > > >    +0 < .  1:1(0) ack 991 win 0           // failed to queue rx=
 data, RCV.NXT=3D991, RCV.WND=3D0
> > > > > >
> > > > > >  +0.1 < P. 1:1001(1000) ack 901 win 0
> > > > >
> > > > > This 'ack 901' does not seem right ?
> > > >
> > > > It's indeed incorrect, the bug still occurs if it were 991. Sorry f=
or that.
> > > >
> > > > >
> > > > > Also your fix would not work if 'win 0' was 'win 1' , and/or if t=
he
> > > > > initial wscale was 6 instead of 7 ?
> > > >
> > > > It indeed does not work if win=3D1, but that's unlikely to happen u=
nless
> > > > you enable shrink_window, and probably
> > > > suggests the mentioned loss of precision.
> > > >
> > > > Now, regarding the scale, it does happen with wscale=3D6 if your se=
cond
> > > > write sends < 64 bytes.
> > > > This is true with any other scale. Would happen if it were wscale=
=3D1
> > > > and the second write sent 2 bytes, etc.
> > > >
> > > > Happens as far as SND.NXT - (SND.UNA + SND.WND) < 1 << wscale.
> > > >
> > > > >
> > > > > >    +0 > .  1091:1091(0) ack 1001          // dropped on tcp_seq=
uence, note that SEQ=3D1091, while (RCV.NXT + RCV.WND)=3D991:
> > > > > >                                           // if (after(seq, tp-=
>rcv_nxt + tcp_receive_window(tp)))
> > > > > >                                           //     return SKB_DRO=
P_REASON_TCP_INVALID_SEQUENCE;
> > > > >
> > > > > I assume that your patch would change the 1091:1091(0) to 991:991=
(0) ?
> > > >
> > > > Precisely.
> > > >
> > > > >
> > > > > It is not clear if there is a bug here... window reneging is outs=
ide
> > > > > RFC specs unfortunately,
> > > > > as hinted in the tcp_acceptable_seq() comments.
> > > >
> > > > Yeah, that got me thinking as well, but although it isn't covered b=
y
> > > > the RFC, the behavior did change since
> > > > 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze"),
> > > > which is a relatively recent patch (Jan 2025).
> > > > Currently, the connection could stall indefinitely, which seems
> > > > unwanted. I would be happy to search for other
> > > > solutions if you have anything come to mind, though.
> > > >
> > > > The way I see it, the stack shouldn't be sending invalid ACKs that =
are
> > > > known to be incorrect.
> > >
> > > These are not ACK, but sequence numbers. They were correct when initi=
ally sent.
>
> Yes, I meant invalid ACK packets, with "incorrect" sequence numbers
> (more advanced than they should have been for this specific ZeroWindow
> scenario). The server has enough knowledge to know what the other peer
> expects (the RFC 793 quote in the original message), thus the "known
> to be incorrect". I am, however, new to the spec and stack.
>
> >
> > You might try to fix the issue on the other side of the connection,
> > the one doing reneging...
>
> Would that be adjusting tcp_sequence as per RFC 793, page 69?
>
>         If the RCV.WND is zero, no segments will be acceptable, but
>         special allowance should be made to accept valid ACKs, URGs and
>         RSTs.
>
> My initial idea was to change tcp_sequence slightly to pass the test
> if RCV.WND is 0. My assessment was that it could go against the
> mentioned test (SEG.SEQ =3D RCV.NXT), and would also require some bigger
> changes to tcp_validate_incoming as tcp_rcv_established would still
> need to drop the SKB but process the ACK. I'd be happy to give it a
> shot anyway.

Please do not focus on RWIN 0, but more generally.

If a peer sent a ACK @seq WIN (@X << wscale), at some point in the past,
then it should accept any SEQ _before_  @seq + (@X << wscale),
especially from a pure ACK packet.

Reneging (ie decrease RWIN) makes sense as a way to deal with memory stress=
,
but should allow pure acks to be accepted if there sequence is not too
far in the future.

tcp_receive_window(const struct tcp_sock *tp)
...
s32 win =3D tp->rcv_wup + tp->rcv_wnd - tp->rcv_nxt;


...
if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
    return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;


-->

if (after(seq, max_admissible_seq(tp))
    return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;

Reneging would no retract max_admissible_seq() as far as
tcp_sequence() is concerned.

