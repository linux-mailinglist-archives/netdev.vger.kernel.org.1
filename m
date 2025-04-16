Return-Path: <netdev+bounces-183521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0540CA90E9E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624A119077BE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935FC23C8A1;
	Wed, 16 Apr 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjo92FIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0189478
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744842643; cv=none; b=utzBZbAcReZByEFNDS8WnLwljOPCy3bJBGyzGvrxS7dbcvdPgkNZpkhEsnyXx9P/H7Q9V8j0d20uiaa3ORTCJs4ko8PX6iBUReVrwnO8TgcjMDz5SkNj29nP4CCdfVqNy1htrdGjp6ENnTBcd05dFM/dbq2quDaXPeTZMe9wuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744842643; c=relaxed/simple;
	bh=A9qD1AwjWAJwZd+t7BkF8OYJMG0FuwP/APZWtWU4i0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwVDWBEhFV3InIIyRvMUYnRC4fcy/olruNtZpAv0PcZ/CFi6Q2coIdThc62YE9qYE75HkoLl4pg/7Gsret4GXzAG66tl2F5cEP4uxBdPNvFpkCW00akiVFgSbFpgKapsUUlv0ycCGzJG8IXR5hkuNrS8HgSNWurgJyiYdMYQS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjo92FIX; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86feb848764so53026241.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744842639; x=1745447439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWRpPegm0xw7P1qXisGI09VxqFc+fU84o/BMDei3onQ=;
        b=mjo92FIXzVWKVMQFpndRGrML4T1N3mClpeoM8U/hOViCJTKuIouhsgfmJQa6G+lJFt
         u5It8FL3r/zIUNL4cY5raf1ZoR6M4F+KCBTyckA4iwwyo7huIIa9sgL8G9re7yMg4nV3
         eiCIpm+yCeVZ3WfI8hzEF8+iYgOdycwx6VDWKR7LnfpUdZg8polFu/b+nQc1oPBERv7G
         psxJQEAOV003nLkLSKUhWyGkd4iTnqea5DQoQAirMAmrfQ3xLJ4TLEyvs9Eaj4FwNQUW
         zHebj9HEdXhf3ABzNHRjU/wc24CG9EvuQRY4a/OYGpZisN1Zb0BzTnDhq7QskuxCirMp
         ZEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744842639; x=1745447439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWRpPegm0xw7P1qXisGI09VxqFc+fU84o/BMDei3onQ=;
        b=rKX8OrcPodO1xvxumk4pakEXQve2uct+P2z8LAllSl+Z22hBPj3S1ThJeIAexFOkmI
         yhMswdStVF4tvUHe21NSOOJdSszxxYb8mlGAjcTJj67kPP/b52q8Niq56jO8sobZLChi
         wSZhNDy7DorUGKVdC7pjSmsRDUMmWvJ2JQHL0pnx/pbrLAZt5UzFCW83iUhWnuMGNL45
         KmC0RIdO9Nqq2Bd+oLMH8aV+ApNMqE3GvyJxnKaEyKL/xw74DZwpeMJwmrNtnnw3Rk5h
         Y7ky1YgEU/mCIds4iWYXWnrhPEXPPJNK45KiitAVLEdHqPTqJBVbeZVncaBhKK9UUH8O
         tfHA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Bf2DWSCJQk568voToQbIVQInxJ/1nctEW2InFX71Hy5Rv7pEmBMo4Gpjt0ABn2bQukhagt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79KhUfmmUHp8A2O2ton0bpM8O9/js1ZeGdOkyGus8RZPw1Fri
	bnKeiOCgt1+LWv85gw3gyV1QLC/qA7ua36JAvDQsIXpuNgKNONixyitReU9m2OYql+xyS3DAAtw
	SsRoyqbTCenekCaG2TW+WJACHxpM=
X-Gm-Gg: ASbGncvQLXDzwwL5NFwRqXeM2hD26NN/vBngRfJdleVWrFrPDZ6z21G0ZptoYN3eNm3
	iBKMWiVU1sPmatC35+1p+GYV7Qgdxn3DPMUz0Xh/cEqT2qM8B9ALRuOrmV8J3vMS31vYBVSy9dj
	FKnikx+I/8NKlzRQANZ/yBHKEKDhwCdpwVtRb8dGPnU6N0/SMEEp66
X-Google-Smtp-Source: AGHT+IEDZvuLsOk+TliJf8k9Vs2Ol/3ejwipfxjqX23YdhssEkjQviwWHQVLKqQBeVjStg/0z7o3PDLFzdv23DBKATA=
X-Received: by 2002:a05:6102:5f0b:b0:4c2:ffc8:93d9 with SMTP id
 ada2fe7eead31-4cb591e6fa2mr2663136137.9.1744842639215; Wed, 16 Apr 2025
 15:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410175140.10805-3-luizcmpc@gmail.com> <d44f79b3-6b3e-4c20-abdf-3e7da73e932f@redhat.com>
 <CAHx7jf-1Hga_tY4-kJ_HNkgkWL6RywCmYhg2yYYX+R+mVwdTvA@mail.gmail.com> <CANn89i+beuSWok=Z=5gFs2E0JQHyuZrdoaT=orFRzBap_BvVzA@mail.gmail.com>
In-Reply-To: <CANn89i+beuSWok=Z=5gFs2E0JQHyuZrdoaT=orFRzBap_BvVzA@mail.gmail.com>
From: =?UTF-8?Q?Luiz_Carlos_Mour=C3=A3o_Paes_de_Carvalho?= <luizcmpc@gmail.com>
Date: Wed, 16 Apr 2025 19:30:27 -0300
X-Gm-Features: ATxdqUFFpRlIAHMZjHZ3Ylqg70YGnRTiALPQVzLRvHJOcPc2kNdtIQmdL3qD_cg
Message-ID: <CAHx7jf807SHbTZhF4LeWsesSPnYxeE6vO37vTGXp+dr-65JP+w@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND
 is 0
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 6:40=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Apr 16, 2025 at 1:52=E2=80=AFPM Luiz Carlos Mour=C3=A3o Paes de C=
arvalho
> <luizcmpc@gmail.com> wrote:
> >
> > Hi Paolo,
> >
> > The dropped ack is a response to data sent by the peer.
> >
> > Peer sends a chunk of data, we ACK with an incorrect SEQ (SND.NXT) that=
 gets dropped
> > by the peer's tcp_sequence function. Connection only advances when we s=
end a RTO.
> >
> > Let me know if the following describes the scenario you expected. I'll =
add a packetdrill with
> > the expected interaction to the patch if it makes sense.
> >
> > // Tests the invalid SEQs sent by the listener
> > // which are then dropped by the peer.
> >
> > `./common/defaults.sh
> > ./common/set_sysctls.py /proc/sys/net/ipv4/tcp_shrink_window=3D0`
> >
> >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> >    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> >    +0 bind(3, ..., ...) =3D 0
> >    +0 listen(3, 1) =3D 0
> >
> >    +0 < S 0:0(0) win 8 <mss 1000,sackOK,nop,nop,nop,wscale 7>
> >    +0 > S. 0:0(0) ack 1 <...>
> >   +.1 < . 1:1(0) ack 1 win 8
> >    +0 accept(3, ..., ...) =3D 4
> >
> >    +0 write(4, ..., 990) =3D 990
> >    +0 > P. 1:991(990) ack 1
> >    +0 < .  1:1(0) ack 991 win 8           // win=3D8 despite buffer bei=
ng almost full, shrink_window=3D0
> >
> >    +0 write(4, ..., 100) =3D 100
> >    +0 > P. 991:1091(100) ack 1            // SND.NXT=3D1091
> >    +0 < .  1:1(0) ack 991 win 0           // failed to queue rx data, R=
CV.NXT=3D991, RCV.WND=3D0
> >
> >  +0.1 < P. 1:1001(1000) ack 901 win 0
>
> This 'ack 901' does not seem right ?

It's indeed incorrect, the bug still occurs if it were 991. Sorry for that.

>
> Also your fix would not work if 'win 0' was 'win 1' , and/or if the
> initial wscale was 6 instead of 7 ?

It indeed does not work if win=3D1, but that's unlikely to happen unless
you enable shrink_window, and probably
suggests the mentioned loss of precision.

Now, regarding the scale, it does happen with wscale=3D6 if your second
write sends < 64 bytes.
This is true with any other scale. Would happen if it were wscale=3D1
and the second write sent 2 bytes, etc.

Happens as far as SND.NXT - (SND.UNA + SND.WND) < 1 << wscale.

>
> >    +0 > .  1091:1091(0) ack 1001          // dropped on tcp_sequence, n=
ote that SEQ=3D1091, while (RCV.NXT + RCV.WND)=3D991:
> >                                           // if (after(seq, tp->rcv_nxt=
 + tcp_receive_window(tp)))
> >                                           //     return SKB_DROP_REASON=
_TCP_INVALID_SEQUENCE;
>
> I assume that your patch would change the 1091:1091(0) to 991:991(0) ?

Precisely.

>
> It is not clear if there is a bug here... window reneging is outside
> RFC specs unfortunately,
> as hinted in the tcp_acceptable_seq() comments.

Yeah, that got me thinking as well, but although it isn't covered by
the RFC, the behavior did change since
8c670bdfa58e ("tcp: correct handling of extreme memory squeeze"),
which is a relatively recent patch (Jan 2025).
Currently, the connection could stall indefinitely, which seems
unwanted. I would be happy to search for other
solutions if you have anything come to mind, though.

The way I see it, the stack shouldn't be sending invalid ACKs that are
known to be incorrect.

>
> >
> >  +0.2 > P. 991:1091(100) ack 1001         // this is a RTO, ack accepte=
d
> >    +0 < P. 1001:2001(1000) ack 991 win 0  // peer responds, still no sp=
ace available, but has more data to send
> >    +0 > .  1091:1091(0) ack 2001          // ack dropped
> >
> >  +0.3 > P. 991:1091(100) ack 2001         // RTO, ack accepted
> >    +0 < .  2001:3001(1000) ack 991 win 0  // still no space available, =
but another chunk of data
> >    +0 > .  1091:1091(0) ack 3001          // ack dropped
> >
> >  +0.6 > P. 991:1091(100) ack 3001         // RTO, ack accepted
> >    +0 < .  3001:4001(1000) ack 991 win 0  // no space available, but pe=
er has data to send at all times
> >    +0 > .  1091:1091(0) ack 4001          // ack dropped
> >
> >  +1.2 > P. 991:1091(100) ack 4001         // another probe, accepted
> >
> >   // this goes on and on. note that the peer always has data just waiti=
ng there to be sent,
> >   // server acks it, but the ack is dropped because SEQ is incorrect.
> >   // only the RTOs are advancing the connection, but are back-offed eve=
ry time.
> >
> > // Reset sysctls
> > `/tmp/sysctl_restore_${PPID}.sh`
> >
> > On Tue, Apr 15, 2025 at 8:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >>
> >>
> >> On 4/10/25 7:50 PM, Luiz Carvalho wrote:
> >> > The current tcp_acceptable_seq() returns SND.NXT when the available
> >> > window shrinks to less then one scaling factor. This works fine for =
most
> >> > cases, and seemed to not be a problem until a slight behavior change=
 to
> >> > how tcp_select_window() handles ZeroWindow cases.
> >> >
> >> > Before commit 8c670bdfa58e ("tcp: correct handling of extreme memory=
 squeeze"),
> >> > a zero window would only be announced when data failed to be consume=
d,
> >> > and following packets would have non-zero windows despite the receiv=
er
> >> > still not having any available space. After the commit, however, the
> >> > zero window is stored in the socket and the advertised window will b=
e
> >> > zero until the receiver frees up space.
> >> >
> >> > For tcp_acceptable_seq(), a zero window case will result in SND.NXT
> >> > being sent, but the problem now arises when the receptor validates t=
he
> >> > sequence number in tcp_sequence():
> >> >
> >> > static enum skb_drop_reason tcp_sequence(const struct tcp_sock *tp,
> >> >                                        u32 seq, u32 end_seq)
> >> > {
> >> >       // ...
> >> >       if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
> >> >               return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
> >> >       // ...
> >> > }
> >> >
> >> > Because RCV.WND is now stored in the socket as zero, using SND.NXT w=
ill fail
> >> > the INVALID_SEQUENCE check: SEG.SEQ <=3D RCV.NXT + RCV.WND. A valid =
ACK is
> >> > dropped by the receiver, correctly, as RFC793 mentions:
> >> >
> >> >       There are four cases for the acceptability test for an incomin=
g
> >> >         segment:
> >> >
> >> >       Segment Receive  Test
> >> >         Length  Window
> >> >         ------- -------  -------------------------------------------
> >> >
> >> >            0       0     SEG.SEQ =3D RCV.NXT
> >> >
> >> > The ACK will be ignored until tcp_write_wakeup() sends SND.UNA again=
,
> >> > and the connection continues. If the receptor announces ZeroWindow
> >> > again, the stall could be very long, as was in my case. Found this o=
ut
> >> > while giving a shot at bug #213827.
> >>
> >> The dropped ack causing the stall is a zero window probe from the send=
er
> >> right?
> >> Could you please describe the relevant scenario with a pktdrill test?
> >>
> >> Thanks!
> >>
> >> Paolo
> >>

