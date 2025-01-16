Return-Path: <netdev+bounces-158983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0925BA14016
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 18:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E977A4A7B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF90114D28C;
	Thu, 16 Jan 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+5eHCMA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173747081E
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047021; cv=none; b=nlGcu5wzIOlOoo5ZLOWZ7jTZQo3VNO6cmviUhUhVfnLemR6lderAYxhEdNmPeQMMMtIwcCl99nGiiLJPChG7D1mqyOUZFWBVx9bvVBHoePh2qeE8PMhAoh8jZ/NYah2BssWC603xDw5ywwMNZdJhZdQm3dQvJsuXfGD1UTME0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047021; c=relaxed/simple;
	bh=fkwxZFEqnU6AbSh+8p8cbNH6HKuVVX8YCMbpLMBvrFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhdV8bVWj4l74JN+HhI0NZNnwBFSHHFIuOea7/qDBB0yeliccpT5MzgHTcNEaH+JrjFZNX1SfVd6Kc9QSwNdEt1BU/0xJivE7b8Fe4+IRY0JTM6OhkAyes0v6NoiaJFmprlwD39rEG9NWmO5NdYyH7TKmEjhxv5Q/gWkKhQTblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+5eHCMA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4678c9310afso264491cf.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737047019; x=1737651819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkwxZFEqnU6AbSh+8p8cbNH6HKuVVX8YCMbpLMBvrFc=;
        b=T+5eHCMAx2kUC2NrB8dipI8gi9IcZvsgEYSJSuAi5Uj63pDvdSr4ZMKTLH8mNoAXFX
         P04Jc5LW6nZAuiOjxwPfdCCOHNUMBpQgQSMpIOkvd1DpqT5g2uecrvMyHkElBOlk2TYE
         pnMCAc0zJHQZTOw17bIzKzWivDrySqiTJYgB477dz0wF472Ijfi4TIYNCJ7xn9pGncaq
         r+r9BRFOn6U4mzKOpo1w/NYjtoMp8msI8Jgsd7wOVRNz8nFpN1s43Ee2DRm1vlF9kbHf
         e/Tncl+y9Lv6JkooxS/rAKMIy3U5v1L9nKUWaXSPKjQ19OUdUyi6ho0DlnvUCuDKZf/9
         awzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047019; x=1737651819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkwxZFEqnU6AbSh+8p8cbNH6HKuVVX8YCMbpLMBvrFc=;
        b=dYkOJbMsRxo8X4DPQhLgVtuRgkcAfIeeatrKR4c07LTIhPdKJ80Ov7vqX5XdVkPyg1
         jMQc72eGP3BCaIIlT3h++dpwWeGL4953xDt1rgN4MpkMkgfL10FwqqryzxrpPpi0APuc
         9R/ANgfoy/LU84aHrn2KDoEdFtRv9a+NOGIfKEUbcJ7TFYtckRci2dPFD7QgXPakqFef
         MsHICKrLcIwqlkaxG85DI2UbjEU+z/Y8bvVv/BoCfiqoddoVI3PtVBkeMd5ZQzrcAOFN
         lbecXjGEQGotJRznXgHveRIWKB/zrUjLp32TapqV9++Ar5/BDk0DyX6/5dZ4SjmgsT7H
         bRew==
X-Forwarded-Encrypted: i=1; AJvYcCWjhBT518qNng3HJYeYpnBasloCC0Aztdx3lcclqt3f7uaoqY1KfTr7I9Rfk2HFrimUsfje6wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxlC9hlV5bfWHQ/5qkLMAF0J4xLLgX04L1bUCK5Jfn7I7WyWby
	wFYc6hmrlejqzW1kEJqsIHr5pRZaoYZKh3SqL49zswsyDK09GkDFg3HtnyPfMFHxb8LrOOpJLdb
	LVbLv/tsG8Qj66BmKj4bRcRu2t0YmNa4KtEuu
X-Gm-Gg: ASbGnct/bo052oSqxSN1OoYUNQR7fEmBCHTbzmYn8Ow5/9KAC3fShBTim0bwfh3yaCi
	CX5lq/uGA2F47v/XIrwg0/LLaEfmOUTNUvQAw4DDRB/IpSMgkuqwPyPJaaIf5PzgiNc5VLpg=
X-Google-Smtp-Source: AGHT+IGnk+jUUo7pUXIJ3Hw9bg1zlxz30zfPCrY0NagbzVbEUEqyz/PcdYrFq1J+vGjckaQL5f6+5uod+jNZBR3rzuI=
X-Received: by 2002:a05:622a:191f:b0:467:84a1:df08 with SMTP id
 d75a77b69052e-46e054bc8ecmr3305011cf.23.1737047018590; Thu, 16 Jan 2025
 09:03:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115010450.2472-1-ma.arghavani.ref@yahoo.com>
 <20250115010450.2472-1-ma.arghavani@yahoo.com> <CAL+tcoAtzuGZ8US5NcJwJdBh29afYGZHpeMJ4jXgiSnWBr75Ww@mail.gmail.com>
 <501586671.358052.1737020976218@mail.yahoo.com> <CAL+tcoA9yEUmXnHFdotcfEgHqWSqaUXu1Aoj=cfCtL5zFG1ubg@mail.gmail.com>
 <CADVnQy=3xz2_gjnM1vifjPJ_2TpT55mc=Oh7hO_omAAi9P6fxw@mail.gmail.com>
 <CANn89iJfx3CBJYBS01Mz9z3twjsP3xvSSOamno-cYSSzv3gSxw@mail.gmail.com> <CADVnQyndHKQ62_9psR1SD9LLtP_johFm-Q+tuaW3E5OYO+sGrg@mail.gmail.com>
In-Reply-To: <CADVnQyndHKQ62_9psR1SD9LLtP_johFm-Q+tuaW3E5OYO+sGrg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 16 Jan 2025 12:03:22 -0500
X-Gm-Features: AbW1kvax3OqnJ_QJS0qt-xxr9S03NWypcg99YWytc9Iy5uu6rZM931pifzW5MZk
Message-ID: <CADVnQymHGF=X_b32Vfp+ZtpNf+t535Lw0vqnxO4M20Z-0bWqEw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp_cubic: fix incorrect HyStart round start detection
To: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Mahdi Arghavani <ma.arghavani@yahoo.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"haibo.zhang@otago.ac.nz" <haibo.zhang@otago.ac.nz>, 
	"david.eyers@otago.ac.nz" <david.eyers@otago.ac.nz>, "abbas.arghavani@mdu.se" <abbas.arghavani@mdu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 10:46=E2=80=AFAM Neal Cardwell <ncardwell@google.co=
m> wrote:
>
> On Thu, Jan 16, 2025 at 10:30=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Thu, Jan 16, 2025 at 3:42=E2=80=AFPM Neal Cardwell <ncardwell@google=
.com> wrote:
> > >
> > > On Thu, Jan 16, 2025 at 6:40=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Thu, Jan 16, 2025 at 5:49=E2=80=AFPM Mahdi Arghavani <ma.arghava=
ni@yahoo.com> wrote:
> > > > >
> > > > > Hi Jason,
> > > > >
> > > > > I will explain this using a test conducted on my local testbed. I=
magine a client and a server connected through two Linux software routers. =
In this setup, the minimum RTT is 150 ms, the bottleneck bandwidth is 50 Mb=
ps, and the bottleneck buffer size is 1 BDP, calculated as (50M / 1514 / 8)=
 * 0.150 =3D 619 packets.
> > > > >
> > > > > I conducted the test twice, transferring data from the server to =
the client for 1.5 seconds:
> > > > >
> > > > > TEST 1) With the patch applied: HyStart stopped the exponential g=
rowth of cwnd when cwnd =3D 632 and the bottleneck link was saturated (632 =
> 619).
> > > > >
> > > > >
> > > > > TEST 2) Without the patch applied: HyStart stopped the exponentia=
l growth of cwnd when cwnd =3D 516 and the bottleneck link was not yet satu=
rated (516 < 619). This resulted in 300 KB less delivered data compared to =
the first test.
> > > >
> > > > Thanks for sharing these numbers. I would suggest in the v3 adding =
the
> > > > above description in the commit message. No need to send v3 until t=
he
> > > > maintainers of TCP (Eric and Neal) give further suggestions :)
> > > >
> > > > Feel free to add my reviewed-by tag in the next version:
> > > > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > > >
> > > > Thanks,
> > > > Jason
> > >
> > > Mahdi, a few quick questions about your test logs, beforePatch.log an=
d
> > > afterPatch.log:
> > >
> > > + What is moRTT? Is that ca->curr_rtt? It would be great to share the
> > > debug patch you used, so we know for certain how to interpret each
> > > column in the debug output.
> >
> > +1
> >
> > Debug patches can alone add delays...
> >
> >
> >
> > >
> > > + Are both HYSTART-DELAY and HYSTART-ACK-TRAIN enabled for both of th=
ose tests?
>
> I like Jason's suggestion to include your test results in the v3
> commit message. Please also include a phrase about which Hystart
> mechanism triggered in each case.
>
> Perhaps something like the following, just above the footers (with an
> empty line separating this text and the following footers):
>
> ---
> I tested with a client and a server connected through two Linux
> software routers. In this setup, the minimum RTT is 150 ms, the
> bottleneck bandwidth is 50 Mbps, and the bottleneck buffer size is 1
> BDP, calculated as (50M / 1514 / 8) * 0.150 =3D 619 packets.
>
> I conducted the test twice, transferring data from the server to the
> client for 1.5 seconds:
>
> Before: Without the patch applied: HYSTART-DELAY stopped the
> exponential growth of cwnd when cwnd =3D 516 and the bottleneck link was
> not yet saturated (516 < 619). This resulted in 300 KB less delivered
> data compared to the first test.
>
> After: With the patch applied: HYSTART-ACK-TRAIN stopped the
> exponential growth of cwnd when cwnd =3D 632 and the bottleneck link was
> saturated (632 > 619).
> ---
>
> (with all lines wrapped in a way that makes scripts/checkpatch.pl happy..=
.)
>
> Eric mentioned:
> > Debug patches can alone add delays...
>
> Yes, this is a good point. To avoid introducing delays, you probably
> want to run your emulation test without the debug patch, and simply
> use "nstat -n" before the test and "nstat" after the test to see (a)
> the type of Hystart mechanism that triggered (b) the cwnd at which it
> triggered.
>
> (I'm still interested in your debug patch so we know for certain how
> to interpret your previously shared log files.)
>
> Mahdi, your tcp_cubic.c patch looks OK to me, so I'm running your
> patch and tests through our kernel test pipeline to see what we get.

Your tcp_cubic.c patch passes our internal packetdrill test suite,
with your updated/added packetdrill scripts, and one additional
reasonable tweak for an internal test that is not upstream yet (in
which the flow now exits slowstart with a cwnd of 28 instead of 24).

So I would suggest sending the v3 version of the patch with the tweaks
we have suggested above for the commit message. And hopefully we can
get a consensus to merge the v3 version of the patch, if we get a
consensus that we like the v3 commit message.

thanks,
neal

