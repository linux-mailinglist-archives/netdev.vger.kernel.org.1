Return-Path: <netdev+bounces-118267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6449511CE
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 03:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95231C224CE
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C88617997;
	Wed, 14 Aug 2024 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFTuBrdj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476F11717
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600793; cv=none; b=lZ3rg6nar09K9UznsRMXHWy77RGO5V3DdRhqX2wdGSxXl/DKcn+Ppll5i6L2sDsPU9bnFo+ZodGZHUy83VNv5+yLm2XDKsikHfcA6+bdo2ARoEr3OIGGyca+Pn45zVk5ERx9IgiDROtD3/SxEd4enNL8p4JobfCBXzz1t92aVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600793; c=relaxed/simple;
	bh=/OrHxf6AXTmrIWFQyJT/hiHTErF2ptbkM57wZ6tswgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2VFGqsaSeEX2VQnFjCOymN5YpSYnRueH3nvH182H/NACJ2q1Y6vKjnlQoAog5th56M1ch8T9OKsCqvIowJue+FZsQXR08LUQeczsQ04QSJTGQfd2plV/LUZQmdQMTbExS3elhkt+4Pw9reHxXIpshn+pnMFI/kUoo+lei7Ic7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JFTuBrdj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-530c2e5f4feso6256619e87.0
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 18:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723600790; x=1724205590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzzNdF5iNnzpieS5Ligys37NO/pKXpD+wBcB/wlqJb4=;
        b=JFTuBrdjc16NRUau/5iv5R3KRiWQxg3L8FxDEpH17inLj2DKGNz/u9oY966hpdLEKU
         F/hvprZ6Y+zh9HlvB2j4oZfziKb7kPVVmzfYIFubg9VtvDC4yYMHHh2V//8LHYRhyLWS
         vT8lxR2KqE57nbU4eFHkYSQU1A3WuQtGLEbExG8YlU5gD86tR/8qie/Nr3m8LqPMx5Um
         OPbPLqRuHEuJ+ulLYgetIYycanJdtMlyu0bF5HQquIAJFb6YuX7dkW1NHyjRuIGcrmIX
         MrhpcKDlkWjyiLdbxjj+y+Ie9bzhC1ChPyxBE/7Ik52s3cLINVJsNLVzSkNikEP2Dv5N
         ZLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723600790; x=1724205590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzzNdF5iNnzpieS5Ligys37NO/pKXpD+wBcB/wlqJb4=;
        b=VMo0z5FcUL9YZj6SUmm5wibIYCIcr2aeL8yf+hWQN87Z8zQyagrkDJPZ/uF2VAqBR1
         bQp6xxbz0AG1GZBGknPcrwfmlVpqz3YdQZw35iktzcbPNqBVM39ZrGDMGd1bksO80JEL
         UN/1U8K4HptTimgRYd+mf8+cKlQRvS3LhZ/5/uuc+Ipfgk7SwSSHjYflV93DJ8Fc0cEs
         prXy8uthKBFlCH1DO5sxou2Hq4Gv7gZj+zHv0WAFABPa8bQhd6JeCe2JJAjqX61QQbpP
         Ics5smYIK5jrF3ybaYjGQ+GyYz2CGJnEJ5Ru3BN35l1UQuVrmERA8LFo345d6J+LeEyX
         LfxA==
X-Forwarded-Encrypted: i=1; AJvYcCXH92dF9I000a3MaQ4IkCr8WaGTF4pEwqxUsSwRuv7rA/A7O0abyc12SAzc8RNR9i8RqsUvL9W6GuUHkunUoGn001PhQh1Y
X-Gm-Message-State: AOJu0Yz4JpLgkaSY8hq64d0znJWX4TIOnjCU8aqmU8gCIkuGz9a7WsV4
	9+F2EjjZC0tv/18tiCaGted+UiB98W8JhJ90B+fH94UWMMC8VfT8M1pgjQ5VReDH5K+ydDc4KeI
	OLjV3jk4HaMWJZxW3LfybUC+6Y5dWp2EEBHR5gfi9lj7Gua6q/6o0
X-Google-Smtp-Source: AGHT+IGCGrqQmmg8ztkB7M/wQl27U3EOMBOByb97D5jbCPg6FwTIshiaHaG2pN9qxAOLg8ew/sK2cw2Ck0Ylf+5oavg=
X-Received: by 2002:a2e:9081:0:b0:2ec:42db:96a2 with SMTP id
 38308e7fff4ca-2f3aa1f04b9mr6050991fa.29.1723600789265; Tue, 13 Aug 2024
 18:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810223130.379146-1-mrzhang97@gmail.com>
In-Reply-To: <20240810223130.379146-1-mrzhang97@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 13 Aug 2024 21:59:31 -0400
Message-ID: <CADVnQykdo-EyGeZxPjLEmAFcT9HyNU5ijvV53urHRcobhOLJHw@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic fix to achieve at least the same throughput
 as Reno
To: Mingrui Zhang <mrzhang97@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org, 
	Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 10, 2024 at 6:34=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail.com>=
 wrote:
>
> This patch fixes some CUBIC bugs so that  "CUBIC achieves at least
> the same throughput as Reno in small-BDP networks"
> [RFC 9438: https://www.rfc-editor.org/rfc/rfc9438.html]
>
> It consists of three bug fixes, all changing function bictcp_update()
> of tcp_cubic.c, which controls how fast CUBIC increases its
> congestion window size snd_cwnd.

Thanks for these fixes! I had some patches under development for bugs
(2) and (3), but had not found the time to finish them up and send
them out... And I had not noticed bug (1).  :-) So thanks for sending
out these fixes! :-)

A few comments:

(1) Since these are three separate bug fixes, in accordance with Linux
development standards, which use minimal/narrow/focused patches,
please submit each of the 3 separate fixes as a separate patch, as
part of a patch series (ideally using git format-patch).

(2) I would suggest using the --cover-letter flag to git format-patch
to create a cover letter for the 3-patch series. You could put the
nice experiment data in the cover letter, since the cover letter
applies to all patches, and so do the experiment results.

(3) Please include a "Fixes:" footer in the git commit message
footeres, to indicate which patch this is fixing, to enable backports
of these fixes to stable kernels. You can see examples in the Linux
git history. For example, you might use something like:

Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")

You can use the following to find the SHA1 of the patch you are fixing:

   git blame -- net/ipv4/tcp_cubic.c

(4) For each patch title, please use "tcp_cubic:" as the first token
in the patch title to indicate the area of the kernel you are fixing,
and have a brief description of the specifics of the fix. For example,
some suggested titles:

tcp_cubic: fix to run bictcp_update() at least once per round

tcp_cubic: fix to match Reno additive increment

tcp_cubic: fix to use emulated Reno cwnd one round in the future

(5) Please run ./scripts/checkpatch.pl to look for issues before sending:

  ./scripts/checkpatch.pl *patch

(6) Please re-test before sending.

> Bug fix 1:
>         ca->ack_cnt +=3D acked;   /* count the number of ACKed packets */
>
>         if (ca->last_cwnd =3D=3D cwnd &&
> -           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
> +           (s32)(tcp_jiffies32 - ca->last_time) <=3D min(HZ / 32, usecs_=
to_jiffies(ca->delay_min)))
>                 return;
>
>         /* The CUBIC function can update ca->cnt at most once per jiffy.
>
> The original code bypasses bictcp_update() under certain conditions
> to reduce the CPU overhead. Intuitively, when last_cwnd=3D=3Dcwnd,
> bictcp_update() is executed 32 times per second. As a result,
> it is possible that bictcp_update() is not executed for several
> RTTs when RTT is short (specifically < 1/32 second =3D 31 ms and
> last_cwnd=3D=3Dcwnd which may happen in small-BDP networks),
> thus leading to low throughput in these RTTs.
>
> The patched code executes bictcp_update() 32 times per second
> if RTT > 31 ms or every RTT if RTT < 31 ms, when last_cwnd=3D=3Dcwnd.
>
> Bug fix 2:
>         if (tcp_friendliness) {
>                 u32 scale =3D beta_scale;
>
> -               delta =3D (cwnd * scale) >> 3;
> +               if (cwnd < ca->bic_origin_point)
> +                       delta =3D (cwnd * scale) >> 3;
> +               else
> +                       delta =3D cwnd;
>                 while (ca->ack_cnt > delta) {           /* update tcp cwn=
d */
>                         ca->ack_cnt -=3D delta;
>                         ca->tcp_cwnd++;
>                 }
>
> The original code follows RFC 8312 (obsoleted CUBIC RFC).
>
> The patched code follows RFC 9438 (new CUBIC RFC).
>
> "Once _W_est_ has grown to reach the _cwnd_ at the time of most
> recently setting _ssthresh_ -- that is, _W_est_ >=3D _cwnd_prior_ --
> the sender SHOULD set =CE=B1__cubic_ to 1 to ensure that it can achieve
> the same congestion window increment rate as Reno, which uses AIMD
> (1,0.5)."

Since ca->bic_origin_point does not really hold _cwnd_prior_ in the
case of fast_convergence (which is very common), I would suggest using
a new field, perhaps called ca->cwnd_prior, to hold the actual
_cwnd_prior_ value. Something like the following:

-               delta =3D (cwnd * scale) >> 3;
+               if (cwnd < ca->cwnd_prior)
+                       delta =3D (cwnd * scale) >> 3;
+               else
+                       delta =3D cwnd;

Then, in __bpf_kfunc static u32 cubictcp_recalc_ssthresh(struct sock *sk):

         else
                 ca->last_max_cwnd =3D tcp_snd_cwnd(tp);
        +ca->cwnd_prior =3D tcp_snd_cwnd(tp);

How does that sound?


Thanks again for these fixes!

Best regards,
neal

