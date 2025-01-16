Return-Path: <netdev+bounces-158857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F43FA13949
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681E7168826
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127C1DDC0D;
	Thu, 16 Jan 2025 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2kGUGIu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D51DC185
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027660; cv=none; b=pxXB9APJokvrOQmF8VpXJF6qHesdcbDXx6F2iyo56ojn9f7v0LLMfq5xV0C+IKKGmEcBsZ+OxrFQvhUBlt8CxA7+FhdMlns8Oe43LwFgilxCzQhLq5YryqcxbPdVNrNDXKowy+B2eVjZlN3QcEvvb3E9MTxavKNBr064cmwRXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027660; c=relaxed/simple;
	bh=8xqZuUZ5BE3YTY2h9q8sUceLTEJKcWu7T5UBBe61oMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JONwHBH0GoVwbiVZCE+z45NSHie8Nma+YPEdEvGxN1NeCiuryqtg4Ygz8+VVJj5LPsfeVgbvW0DxRyVWiNQKSLHABdhmnlfsvKePCZKcb9aeQNaLZ5LBBfx5CpacwLW7zPNj8xTsT3vQfAzQ4PkVDOv2g3RnhU5HOgib2TTkunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2kGUGIu; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-844eac51429so67310639f.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 03:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737027658; x=1737632458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5xeQm3F89oJ6bCwDLAEMerWatuQ6yIQjhReyDvjVLE=;
        b=F2kGUGIu/+22twVnj3vuGgmPxBJDDbHphvY/JGK/ZI9z5SQ2EAToKziSQPKFOP10X/
         y6hiO8H7rb6psE1ReBZ51SRwE1Xrb26zXbZQPuA0BdvxlKEVusDLNl0VrNEMYhzbmHnz
         0xZBVhlkNEhxpuw32l/uy1GUfJASRzybC1JWjQRU5+nIHnIuqHYokbT2XtKia5nYOUG+
         K6k2eaXTvc/fou9FeW5bMfekjVsijg5RQyFSFE6EnQBxJ/mSOifqp/X5RDWzYnxy3F0c
         SmY+ZDPkTB8u9FlNendB7v7Bf82ytopAGH8CUCMw+TZxwkhlFpjpnimJNF4+MwygkGsu
         gNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027658; x=1737632458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5xeQm3F89oJ6bCwDLAEMerWatuQ6yIQjhReyDvjVLE=;
        b=g85eIHNpH7zaRC6cAmzr/YNMXfeAx2aPCauthBqpQooOnfGswg8oJvXJk04/Zw+fHM
         +QHbR4uvIbUjpO+hSyaEXEoGjcK12agS5JO2J6U7fXQU11qQAtPOmjB9rw2npqQ/Ugcp
         pGigJ47phL83JdUyAx/CwQGLYggZ8361fRO5ax1zcndZlcMUSZO1EuSge3dtDJUxvX+A
         QnAKtJwz1D2k2jjHO5/LZhDD2lf45nCoHRARVGBa/r9qnlAfpy50VYuIONHHyshiGu6C
         GXHMl3OCq3cLtv8Fr9jz1hEdsRXon5qrf47zZhqZCtJuaQKgKSRnZcGDD4p4MDLHsy2j
         ndNw==
X-Gm-Message-State: AOJu0YycxaH2ikgVRFUlJtDrza6v8tMC7+xtfO1ZYlF3LE+fm8eLv2h6
	7kZ3l6WbnI6iqHBo7Gcf2PMfk/Gbuq8/UCUrRLagyHwRYFWf/1REN90tmum3T2CDj8n729plc4I
	TIkFjX/8bnFLHJk/VPUx35xFQFJM=
X-Gm-Gg: ASbGncvUbiv8gfd+qhKldVz5qm3pOQH/PLxABSYeY2bqqqs22mzB0ITREb1d+OwvSGb
	00weobrTlke38keT8dEwSVEDYCddyvjTZMYgijg==
X-Google-Smtp-Source: AGHT+IFeedDPY0PpCoyLYlvurOtd4lSPZeadLI5w/Ea+onNihOXLcCG3ZoUxbSv4cQ7SresE5TErhQwGibLwkr4j8fY=
X-Received: by 2002:a05:6e02:1b02:b0:3ce:69ca:ef99 with SMTP id
 e9e14a558f8ab-3ce69caf036mr194535415ab.6.1737027657702; Thu, 16 Jan 2025
 03:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115010450.2472-1-ma.arghavani.ref@yahoo.com>
 <20250115010450.2472-1-ma.arghavani@yahoo.com> <CAL+tcoAtzuGZ8US5NcJwJdBh29afYGZHpeMJ4jXgiSnWBr75Ww@mail.gmail.com>
 <501586671.358052.1737020976218@mail.yahoo.com>
In-Reply-To: <501586671.358052.1737020976218@mail.yahoo.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 19:40:20 +0800
X-Gm-Features: AbW1kvZpi78x1KvoHPERVKNq4H7dcXSNowmc0YExzFbfbKJCclYJfQ0SqEZRO7o
Message-ID: <CAL+tcoA9yEUmXnHFdotcfEgHqWSqaUXu1Aoj=cfCtL5zFG1ubg@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp_cubic: fix incorrect HyStart round start detection
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"edumazet@google.com" <edumazet@google.com>, "haibo.zhang@otago.ac.nz" <haibo.zhang@otago.ac.nz>, 
	"david.eyers@otago.ac.nz" <david.eyers@otago.ac.nz>, "abbas.arghavani@mdu.se" <abbas.arghavani@mdu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:49=E2=80=AFPM Mahdi Arghavani <ma.arghavani@yahoo=
.com> wrote:
>
> Hi Jason,
>
> I will explain this using a test conducted on my local testbed. Imagine a=
 client and a server connected through two Linux software routers. In this =
setup, the minimum RTT is 150 ms, the bottleneck bandwidth is 50 Mbps, and =
the bottleneck buffer size is 1 BDP, calculated as (50M / 1514 / 8) * 0.150=
 =3D 619 packets.
>
> I conducted the test twice, transferring data from the server to the clie=
nt for 1.5 seconds:
>
> TEST 1) With the patch applied: HyStart stopped the exponential growth of=
 cwnd when cwnd =3D 632 and the bottleneck link was saturated (632 > 619).
>
>
> TEST 2) Without the patch applied: HyStart stopped the exponential growth=
 of cwnd when cwnd =3D 516 and the bottleneck link was not yet saturated (5=
16 < 619). This resulted in 300 KB less delivered data compared to the firs=
t test.

Thanks for sharing these numbers. I would suggest in the v3 adding the
above description in the commit message. No need to send v3 until the
maintainers of TCP (Eric and Neal) give further suggestions :)

Feel free to add my reviewed-by tag in the next version:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

>
>
> Please refer to the log files for more details.
>
> Best wishes,
> Mahdi Arghavani
>
>
>
> On Thursday, January 16, 2025 at 08:20:16 PM GMT+13, Jason Xing <kernelja=
sonxing@gmail.com> wrote:
>
>
>
>
>
> ...
>
> > potentially degrading TCP performance.
>
> Interesting point, I try a few times but don't see the degradation of
> performance actually based on the limited experiments I conducted.
>
> >
> > The issue arises because the changes introduced in commit 4e1fddc98d25
> > ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-lim=
ited flows")
> > moved the caller of the `bictcp_hystart_reset` function inside the `hys=
tart_update` function.
> > This modification added an additional condition for triggering the call=
er,
> > requiring that (tcp_snd_cwnd(tp) >=3D hystart_low_window) must also
> > be satisfied before invoking `bictcp_hystart_reset`.
> >
> > This fix ensures that `bictcp_hystart_reset` is correctly called
> > at the start of a new round, regardless of the congestion window size.
> > This is achieved by moving the condition
> > (tcp_snd_cwnd(tp) >=3D hystart_low_window)
> > from before calling `bictcp_hystart_reset` to after it.
> >
> > Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detecti=
ons for not-cwnd-limited flows")
> > Signed-off-by: Mahdi Arghavani <ma.arghavani@yahoo.com>
> > Cc: Neal Cardwell <ncardwell@google.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Haibo Zhang <haibo.zhang@otago.ac.nz>
> > Cc: David Eyers <david.eyers@otago.ac.nz>
> > Cc: Abbas Arghavani <abbas.arghavani@mdu.se>
>
> As to the patch itself and corresponding theory, it looks good to me
> according to my limited understanding of the hystart algorithm :)
>
> After this, we can accurately reset at the beginning of each round
> instead of waiting cwnd to reach 16.
>
> Note that tests about big tcp like in the commit 4e1fddc98d25 are not
> running on my machine.
>
>
> > ---
> >  net/ipv4/tcp_cubic.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> > index 5dbed91c6178..76c23675ae50 100644
> > --- a/net/ipv4/tcp_cubic.c
> > +++ b/net/ipv4/tcp_cubic.c
> > @@ -392,6 +392,10 @@ static void hystart_update(struct sock *sk, u32 de=
lay)
> >        if (after(tp->snd_una, ca->end_seq))
> >                bictcp_hystart_reset(sk);
> >
> > +      /* hystart triggers when cwnd is larger than some threshold */
> > +      if (tcp_snd_cwnd(tp) < hystart_low_window)
> > +              return;
> > +
> >        if (hystart_detect & HYSTART_ACK_TRAIN) {
> >                u32 now =3D bictcp_clock_us(sk);
> >
> > @@ -467,9 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock =
*sk, const struct ack_sample
> >        if (ca->delay_min =3D=3D 0 || ca->delay_min > delay)
> >                ca->delay_min =3D delay;
> >
> > -      /* hystart triggers when cwnd is larger than some threshold */
> > -      if (!ca->found && tcp_in_slow_start(tp) && hystart &&
> > -          tcp_snd_cwnd(tp) >=3D hystart_low_window)
> > +      if (!ca->found && tcp_in_slow_start(tp) && hystart)
> >                hystart_update(sk, delay);
> >  }
> >
> > --
> > 2.45.2
> >
> >

