Return-Path: <netdev+bounces-203950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E543FAF8456
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 01:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5FE1C859E0
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 23:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C682DAFC0;
	Thu,  3 Jul 2025 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr9oTdbw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C42D3A68;
	Thu,  3 Jul 2025 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585881; cv=none; b=maxKC5JGhHf0ZMqpW0Rk1MyBbgVo+bv4VoJ+E2+WCb6up5kYrxf7d31tPZZzywtLWMh+n9n5rcYv9cLnptNXQnXoK9cN26M6BsOlrC10SZjBeRfbL2Av4G/OHqAASmLC9vFDA/t56PQqA/ECLoqZcVnxCvt1sw+S+GkHartHxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585881; c=relaxed/simple;
	bh=jKOsI/jyRmP/ZR1ELXGZX/lRu6gek7asQxU3JEmwRw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnI5fnbBV1oK6N6rt57XgX4R7PcWLW9c04R2czvN0dLjFFiICgW1uMMFtw7tLm9/5C+6rXfTZj03/qttGoctty3nkPQp2SC8JsyuchOmimfvJCZgWGWkuoSjrooRW5eQe81Q8AKysUMlfHrr1FWOUjZVYVEFp/qwetz9nKeCw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr9oTdbw; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e0570a9b83so1942045ab.1;
        Thu, 03 Jul 2025 16:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751585879; x=1752190679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6d9RDaCSYgiZ2IRfJxTkeaLPeo+WJhL8/X4lAhPcrLc=;
        b=nr9oTdbwKfpjr7Hw49lon+Rb2bl9frPozgzXr48U4ayOaxfqPhOeS0fu7Cl4ARPJl6
         BpSqjT0hrVgcOPwm1EMLi2QMoP7N2uc5F5JKIC9/d6FPxrn2UZS/fwTsbvTS2cGjGIZe
         roWtiGJRW1izwIUUHOZJNC6+hmtrTdXrlMY73TJ3QjCSI8YwKlTK7ucXtenEnJq+4aVi
         QPhe68g9fAzcIRAcQ5kYW44h2bHG5qgsObUvXdzqNrbDpyyu8FhmNb2HRYi4zuq576oj
         AcAeNH0SLiwvgvxGQ0bi23VnnJqu7K1gozGX+jAh6y2vkCiHOQavuvncMhAuoU1RsAcI
         VaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751585879; x=1752190679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6d9RDaCSYgiZ2IRfJxTkeaLPeo+WJhL8/X4lAhPcrLc=;
        b=Jhm8ZG7ZOvnEBJbyjdquSU7KEYJoLfcRMAq24MzN/MO37j/yhjqJ1QzWvR39iRzHwk
         T5Fjp4XMaZ/yJhnJNgLTCe5T2XXhzqsw8oJ1LhIFuh6e5aI8YZzSNvU9LBG7sWmSITkQ
         O1maJnZH7q6gQVGfrbzI7eqtOhtg4XMM0TxgzWvFjJy/UZ26f0LCnVPDSLlBa8QedANK
         dXkmh8dp6ErYSmWNgF3occCvi3yzxXfz3OMEvGlQ3Da7iCdPH27VZsEajWPYjPM+qle5
         YjzpVKtmRRHxKk0wUFph8MihgIqZ1vQRR8iYtK/ScpxNncmM+HplDO0K8N0dh+KDcTep
         AfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSn/V/JTeQPe6ekuT4+NywIBlYKfV6tOTGKOIolPiNe9M+hMAz4XNkfLMXY2v27YSusRdoz+cOQy4qx60=@vger.kernel.org, AJvYcCWBjPv7RiP5x3aNyplyWShAdU+cYD+37+4+yOwOu/5aCIscmlkUR1rCZJ+a1XrDAWtRgdV5t1tx@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+DN0ClQwmln67ytst9/mkwAGEKNGwFWgi1Po/lQCQyOVpN5d
	7tQoUaphbosD/H2xaz6L7Be5IIMPXMyp1c0YuU6vcx1/H4df1IDLuoOmJey259EdoQMBzrRL8zd
	0bPKa5vSkMux3PPqJSbFp8cXl1VxhAoM=
X-Gm-Gg: ASbGnctSn4Odr97LWDcTq03MJqiHG9klgNM+on4mrY/ehRk/qZ51xs1Oyn6MbPLzgHg
	Gsl66WS6W70hMHXswiGCHgh+3/rsG7DBxHWL9Hlfruei2hN+WcnTQWXxiewoNpWxTZ9Nz4B4ilS
	3PI6+GKlsazzTA7z417j0RQneteQiNUvbB0q/P64rqFXQ=
X-Google-Smtp-Source: AGHT+IFcV7AVZQaKoEbFwz1Q8/qkc5qeVBA7ZFu+HAs6to8j9ZfvrCtzaQ5cF1kjEIYuT6nkb2IlqOs6bi0qsaAygrg=
X-Received: by 2002:a05:6e02:2308:b0:3de:12ba:7d6c with SMTP id
 e9e14a558f8ab-3e1354a1711mr4783055ab.8.1751585878774; Thu, 03 Jul 2025
 16:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530103456.53564-1-e.kubanski@partner.samsung.com>
 <CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p1>
 <aDnX3FVPZ3AIZDGg@mini-arch> <20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>
In-Reply-To: <20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 4 Jul 2025 07:37:22 +0800
X-Gm-Features: Ac12FXyOkjh19DKWQ4CBmEe01NU-HKj1gTgtkLjsbZ-e_xjQ-iGDVhdOFrGyBx4
Message-ID: <CAL+tcoAk3X2qM7gkeBw60hQ6VKd0Pv0jMtKaEB9uFw0DE=OY2A@mail.gmail.com>
Subject: Re: Re: [PATCH bpf v2] xsk: Fix out of order segment free in __xsk_generic_xmit()
To: e.kubanski@partner.samsung.com
Cc: Stanislav Fomichev <stfomichev@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, 
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>, 
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>, 
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 5:28=E2=80=AFPM Eryk Kubanski
<e.kubanski@partner.samsung.com> wrote:
>
> > I'm not sure I understand what's the issue here. If you're using the
> > same XSK from different CPUs, you should take care of the ordering
> > yourself on the userspace side?
>
> It's not a problem with user-space Completion Queue READER side.
> Im talking exclusively about kernel-space Completion Queue WRITE side.
>
> This problem can occur when multiple sockets are bound to the same
> umem, device, queue id. In this situation Completion Queue is shared.
> This means it can be accessed by multiple threads on kernel-side.
> Any use is indeed protected by spinlock, however any write sequence
> (Acquire write slot as writer, write to slot, submit write slot to reader=
)
> isn't atomic in any way and it's possible to submit not-yet-sent packet
> descriptors back to user-space as TX completed.
>
> Up untill now, all write-back operations had two phases, each phase
> locks the spinlock and unlocks it:
> 1) Acquire slot + Write descriptor (increase cached-writer by N + write v=
alues)
> 2) Submit slot to the reader (increase writer by N)
>
> Slot submission was solely based on the timing. Let's consider situation,
> where two different threads issue a syscall for two different AF_XDP sock=
ets
> that are bound to the same umem, dev, queue-id.
>
> AF_XDP setup:
>
>                              kernel-space
>
>            Write   Read
>             +--+   +--+
>             |  |   |  |
>             |  |   |  |
>             |  |   |  |
>  Completion |  |   |  | Fill
>  Queue      |  |   |  | Queue
>             |  |   |  |
>             |  |   |  |
>             |  |   |  |
>             |  |   |  |
>             +--+   +--+
>             Read   Write
>                              user-space
>
>
>    +--------+         +--------+
>    | AF_XDP |         | AF_XDP |
>    +--------+         +--------+
>
>
>
>
>
> Possible out-of-order scenario:
>
>
>                               writer         cached_writer1              =
        cached_writer2
>                                  |                 |                     =
              |
>                                  |                 |                     =
              |
>                                  |                 |                     =
              |
>                                  |                 |                     =
              |
>                   +--------------|--------|--------|--------|--------|---=
-----|--------|----------------------------------------------+
>                   |              |        |        |        |        |   =
     |        |                                              |
>  Completion Queue |              |        |        |        |        |   =
     |        |                                              |
>                   |              |        |        |        |        |   =
     |        |                                              |
>                   +--------------|--------|--------|--------|--------|---=
-----|--------|----------------------------------------------+
>                                  |                 |                     =
              |
>                                  |                 |                     =
              |
>                                  |-----------------|                     =
              |
>                                   A) T1 syscall    |                     =
              |
>                                   writes 2         |                     =
              |
>                                   descriptors      |---------------------=
--------------|
>                                                     B) T2 syscall writes =
4 descriptors
>

Hi ALL,

Since Maciej posted a related patch to fix this issue, it took me a
little while to trace back to this thread. So here we are.

>                  Notes:
>                  1) T1 and T2 AF_XDP sockets are two different sockets,
>                     __xsk_generic_xmit will obtain two different mutexes.
>                  2) T1 and T2 can be executed simultaneously, there is no
>                     critical section whatsoever between them.
>                  3) T1 and T2 will obtain Completion Queue Lock for acqui=
re + write,
>                     only slot acquire + write are under lock.
>                  4) T1 and T2 completion (skb destructor)
>                     doesn't need to be the same order as A) and B).
>                  5) What if T1 fails after T2 acquires slots?

What does it mean by 'fails'. Could you point out the accurate
function you said?

>                     cached_writer will be decreased by 2, T2 will
>                     submit failed descriptors of T1 (they shall be
>                     retransmitted in next TX).
>                     Submission of writer will move writer by 4 slots
>                     2 of these slots have failed T1 values. Last two
>                     slots of T2 will be missing, descriptor leak.

I wonder why the leak problem happens? IIUC, in the
__xsk_generic_xmit() + copy mode, xsk only tries to send the
descriptor from its own tx ring to the driver, like virtio_net as an
example. As you said, there are two xsks running in parallel. Why
could T2 send the descriptors that T1 puts into the completion queue?
__dev_direct_xmit() only passes the @skb that is built based on the
addr from per xsk tx ring.

Here are some maps related to the process you talked about:
case 1)
// T1 writes 2 descs in cq
[--1--][--2--][-null-][-null-][-null-][-null-][-null-]
                      |
                      cached_prod

// T1 fails because of NETDEV_TX_BUSY, and cq.cached_prod is decreased by 2=
.
[-null-][-null-][-null-][-null-][-null-][-null-][-null-]
     |
     cached_prod

// T2 starts to write at the first unused descs
[--1--][--2--][--3--][--4--][-null-][-null-][-null-]
                                        |
                                        cached_prod
So why can T2 send out the descs belonging to T1? In
__xsk_generic_xmit(), xsk_cq_reserve_addr_locked() initialises the
addr of acquired desc so it overwrites the invalid one previously
owned by T1. The addr is from per xsk tx ring... I'm lost. Could you
please share the detailed/key functions to shed more lights on this?
Thanks in advance.

I know you're not running on the (virtual) nic actually, but I still
want to know the possibility of the issue with normal end-to-end
transmission. In the virtio_net driver, __dev_direct_xmit() returns
BUSY only if the BQL takes effect, so your case might not happen here?
The reason why I asked is that I have a similar use case with
virtio_net and I am trying to understand whether it can happen in the
future.

Thanks,
Jason


>                  6) What if T2 completes before T1? writer will be
>                     moved by 4 slots. 2 of them are slots filled by T1.
>                     T2 will complete 2 own slots and 2 slots of T1, It's =
bad.
>                     T1 will complete last 2 slots of T2, also bad.
>
> This out-of-order completion can effectively cause User-space <-> Kernel-=
space
> data race. This patch solves that, by only acquiring cached_writer first =
and
> do the completion (sumission (write + increase writer)) after. This is th=
e only
> way to make that bulletproof for multithreaded access, failures and
> out-of-order skb completions.
>
> > This is definitely a no-go (sk_buff and skb_shared_info space is
> > precious).
>
> Okay so where should I store It? Can you give me some advice?
>
> I left that there, because there is every information related to
> skb desctruction. Additionally this is the only place in skb related
> code that defines anything related to xsk: metadata, number of descriptor=
s.
> SKBUFF doesn't. I need to hold this information somewhere, and skbuff or
> skb_shared_info are the only place I can store it. This need to be invari=
ant
> across all skb fragments, and be released after skb completes.
>

