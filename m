Return-Path: <netdev+bounces-183498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813A4A90D83
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA041907CF7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5939A232792;
	Wed, 16 Apr 2025 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdIBDBh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B91FF1B0
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744837162; cv=none; b=dBng9GENvAIMdNiIJ1f9qGDhTxNUJJVdI055kJpJ1cJIt/XYSDkOQRibbsRlIRbYgcIiPFc/KGY503gWgVrMcvMZSL33uJdkuw2k2Py3taAkmIN/CowuSLE12yKPRNb3ysSyrO3P3OBdrx8nVOzuit2oWfkiRaa9K8ghJOpqJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744837162; c=relaxed/simple;
	bh=IBCtM4W5KQm0VIXhhgxKkcnr89rBb+zyKpougE+2sAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5deewxJf0ceSMsp6tEniTyTHtLR8HOV9cpUYo7qVavktQbi/US5xPAXw5GLDItxHKrXSSKsAsjs4e1djbE3NVJp+4ICvQ047cFB7bZoHl/ewz0c91Jx/F1ANpSxvp6Uu5GTCnrGkz106qY4p8ktPdPUxrXd4GmPDJtewbmdJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdIBDBh6; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86fab198f8eso44770241.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 13:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744837158; x=1745441958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXE/9C66AFaMxZnOf2usyfKl+C3GS8D2aGdJg640enA=;
        b=UdIBDBh66lG86/zeyPFnnOfj0WuOai1bM2urRQxN3AhVVw/F8zZ25wVnSQO2FM7Hd1
         wiFUdXvzYku1EKxw0oH83YBFUAbRV60B/SmYyIGRrgOdQX/Crh5prS2IxWuZTyzepGnM
         lwUrrJ9qftCUeFyhIwb51E3Jruw0U33GqZKg5/s0hR+gZxnrVv/lj5mLqyNHqrWnIn3W
         Ug3M67kuqgUQJBGdYIJX01Bq4MSSLWWvK9Jk6qsevhtwY0nek+vrLUhVi2Wh9i6Dcjr9
         6OBu1sRcFu8035Suh4DgZnGnNJLnX5KFegVzpn5mu2pR2Q/9fcril6EqG226x+Z1LBRo
         8ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744837158; x=1745441958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXE/9C66AFaMxZnOf2usyfKl+C3GS8D2aGdJg640enA=;
        b=msGabqLt14BQ2n+/NDPSMUcGcpvHNfAhd9o+s5FxMLOefT/7n85XKidDDurvUSZAe5
         gHNYcC5+X6ZvfI2N77Ykh+EbJTvIjHOIkVYNz7l6aYmpOmeSxHNV4kVeh3gyOfOG0a67
         JueWlwWpiuRJOQzB6VjUF+iS0ApqtV4q2Id9oKo4cf0IFxnYmLtwaeqyY3VyTw5G8Ut3
         deyPcFXZNmpU8K7TC4CYHWIfkkIc2uvuhvQ/UfkbF/Bn1H/G84ZF/zVFUrm5MonF3XIG
         jqggBQ8qqZ2+LYh9U2VkG7n/0Tmbdv8nXKKJBQO6M4cxqITKcvCl5W6lIV17ULJn/amf
         MeHQ==
X-Gm-Message-State: AOJu0YyJCfmopSmfnuE/y32bXo4ctfGufPIdtclM5sd6bF1f/ofWIWl0
	ecFxMO9cDesg8X1PA61gVUCmJTHUnWPp9LGskVooDjj3dLqLsVAKP1Js51gRjTUWRkCrkxgPvs5
	UwoLpaDkq6QEOkOeLlewL/mUE2nQ=
X-Gm-Gg: ASbGncviOkjdKseeFNIRQQamU3xscd2Ybjb+Et9GfHoCKCtf7LOLgAps6IN2BZ4wLJy
	dpGiFfUvGvoWN8qO4MdN8aNrNs0EHIwHK7d+MEfXjk+Md4FieDrSsQjKYd7zVGvhvI8oFcPsMTo
	v0zc4bmeKdu61XynYvRbpVJuK3Cf7itvQvW9eEedeOgGdDYZU0G3DiiCR3XHPzvDo=
X-Google-Smtp-Source: AGHT+IG928ltOQHmXyGCIWtK1xhVIFJ74ZYrkuDVdQ5SIr2z2KUoJf9ItT9crq3QD+XAlKFR5h1Aa7W3G1Ro/dqRJdc=
X-Received: by 2002:a05:6102:3b09:b0:4c3:6a7e:c9f3 with SMTP id
 ada2fe7eead31-4cb591b80b8mr2503396137.3.1744837157970; Wed, 16 Apr 2025
 13:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410175140.10805-3-luizcmpc@gmail.com> <d44f79b3-6b3e-4c20-abdf-3e7da73e932f@redhat.com>
In-Reply-To: <d44f79b3-6b3e-4c20-abdf-3e7da73e932f@redhat.com>
From: =?UTF-8?Q?Luiz_Carlos_Mour=C3=A3o_Paes_de_Carvalho?= <luizcmpc@gmail.com>
Date: Wed, 16 Apr 2025 17:59:05 -0300
X-Gm-Features: ATxdqUGYSOG-_gdgCmvZjzvNHMn6DiK2rPIdOlbz8HV2oqfdg3n6sQSr9IM5QGg
Message-ID: <CAHx7jf_kZhR__FU--grcZgVd3bC4SZXScn3CJJBZBpspv9GSnQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND
 is 0
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

The dropped ack is a response to data sent by the peer.

Peer sends a chunk of data, we ACK with an incorrect SEQ (SND.NXT)
that gets dropped
by the peer's tcp_sequence function. Connection only advances when we
send a RTO.

Let me know if the following describes the scenario you expected. I'll
add a packetdrill with
the expected interaction to the patch if it makes sense.

// Tests the invalid SEQs sent by the listener
// which are then dropped by the client.

`./common/defaults.sh
./common/set_sysctls.py /proc/sys/net/ipv4/tcp_shrink_window=3D0`

    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
   +0 bind(3, ..., ...) =3D 0
   +0 listen(3, 1) =3D 0

   +0 < S 0:0(0) win 8 <mss 1000,sackOK,nop,nop,nop,wscale 7>
   +0 > S. 0:0(0) ack 1 <...>
  +.1 < . 1:1(0) ack 1 win 8
   +0 accept(3, ..., ...) =3D 4

   +0 write(4, ..., 990) =3D 990
   +0 > P. 1:991(990) ack 1
   +0 < .  1:1(0) ack 991 win 8           // win=3D8 despite buffer
being almost full, shrink_window=3D0

   +0 write(4, ..., 100) =3D 100
   +0 > P. 991:1091(100) ack 1            // SND.NXT=3D1091
   +0 < .  1:1(0) ack 991 win 0           // failed to queue rx data,
RCV.NXT=3D991, RCV.WND=3D0

 +0.1 < P. 1:1001(1000) ack 901 win 0
   +0 > .  1091:1091(0) ack 1001          // dropped on tcp_sequence,
note that SEQ=3D1091, while (RCV.NXT + RCV.WND)=3D991:
                                          // if (after(seq,
tp->rcv_nxt + tcp_receive_window(tp)))
                                          //     return
SKB_DROP_REASON_TCP_INVALID_SEQUENCE;

 +0.2 > P. 991:1091(100) ack 1001         // this is a RTO, ack accepted
   +0 < P. 1001:2001(1000) ack 991 win 0  // peer responds, still no
space available, but has more data to send
   +0 > .  1091:1091(0) ack 2001          // ack dropped

 +0.3 > P. 991:1091(100) ack 2001         // RTO, ack accepted
   +0 < .  2001:3001(1000) ack 991 win 0  // still no space available,
but another chunk of data
   +0 > .  1091:1091(0) ack 3001          // ack dropped

 +0.6 > P. 991:1091(100) ack 3001         // RTO, ack accepted
   +0 < .  3001:4001(1000) ack 991 win 0  // no space available, but
peer has data to send at all times
   +0 > .  1091:1091(0) ack 4001          // ack dropped

 +1.2 > P. 991:1091(100) ack 4001         // another probe, accepted

  // this goes on and on. note that the peer always has data just
waiting there to be sent,
  // server acks it, but the ack is dropped because SEQ is incorrect.
  // only the probes are advancing the connection, but are back-offed
every time.

// Reset sysctls
`/tmp/sysctl_restore_${PPID}.sh`

Luiz Carvalho

On Tue, Apr 15, 2025 at 8:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 4/10/25 7:50 PM, Luiz Carvalho wrote:
> > The current tcp_acceptable_seq() returns SND.NXT when the available
> > window shrinks to less then one scaling factor. This works fine for mos=
t
> > cases, and seemed to not be a problem until a slight behavior change to
> > how tcp_select_window() handles ZeroWindow cases.
> >
> > Before commit 8c670bdfa58e ("tcp: correct handling of extreme memory sq=
ueeze"),
> > a zero window would only be announced when data failed to be consumed,
> > and following packets would have non-zero windows despite the receiver
> > still not having any available space. After the commit, however, the
> > zero window is stored in the socket and the advertised window will be
> > zero until the receiver frees up space.
> >
> > For tcp_acceptable_seq(), a zero window case will result in SND.NXT
> > being sent, but the problem now arises when the receptor validates the
> > sequence number in tcp_sequence():
> >
> > static enum skb_drop_reason tcp_sequence(const struct tcp_sock *tp,
> >                                        u32 seq, u32 end_seq)
> > {
> >       // ...
> >       if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
> >               return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
> >       // ...
> > }
> >
> > Because RCV.WND is now stored in the socket as zero, using SND.NXT will=
 fail
> > the INVALID_SEQUENCE check: SEG.SEQ <=3D RCV.NXT + RCV.WND. A valid ACK=
 is
> > dropped by the receiver, correctly, as RFC793 mentions:
> >
> >       There are four cases for the acceptability test for an incoming
> >         segment:
> >
> >       Segment Receive  Test
> >         Length  Window
> >         ------- -------  -------------------------------------------
> >
> >            0       0     SEG.SEQ =3D RCV.NXT
> >
> > The ACK will be ignored until tcp_write_wakeup() sends SND.UNA again,
> > and the connection continues. If the receptor announces ZeroWindow
> > again, the stall could be very long, as was in my case. Found this out
> > while giving a shot at bug #213827.
>
> The dropped ack causing the stall is a zero window probe from the sender
> right?
> Could you please describe the relevant scenario with a pktdrill test?
>
> Thanks!
>
> Paolo
>

