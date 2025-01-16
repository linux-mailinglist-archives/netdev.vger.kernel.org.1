Return-Path: <netdev+bounces-158944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA52A13E2A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786D0164915
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C520B1DE2D7;
	Thu, 16 Jan 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04lk+pfM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431386329
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042406; cv=none; b=YGEzjsaFSkObRNbjuCfSKu2RoGEUC3avzbdQS49D/jfeDEsb2lXmFikyn40me9DtxbRhhJIEWDasJfQNdYqaQBwqOdJf580xnnaCdl3lgxUgIcYSwnhyrbOkHvRSJ4oEeSKiOTbdlnjtRjiGYvy0YMccxBPogkK0Hds2Cvb74zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042406; c=relaxed/simple;
	bh=N6kk26sm2fNwjo4EoPh6g3i5ilDYshORRrt132FmVMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dg+jkrkAn4PuPstUGWNOPY3lHnafSQBRlwnEsBqyhqQOKOulrQym+C0EsJ0qJTen0kKeCSkIPlV21F9xtYBldPrMa9XJrlTCkIGWJC2Y5c8jmrJ1+pf4ehZRt4VzBT8EVa7+48RN5HCFJLlPgQV4E0lrE+8Dn4a3r/S9yQanOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=04lk+pfM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467896541e1so271251cf.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737042404; x=1737647204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6kk26sm2fNwjo4EoPh6g3i5ilDYshORRrt132FmVMI=;
        b=04lk+pfMHU3SSBT4rZMBJnvNFRzEfIyD+BvjJPv9xdnUZqeIM19weJwUvrqJS+ta8q
         oMQgWhZMn1B/+cvAhub3aQnoOSldmRuKdCJtFLNAUfjA0OoNSkcdtc5XE1KULJCKF4A+
         TBmBgGew3g6FJ0PPo4C+Z4d3CjvyEgV3fdXhFD20pennuli89T1Tt5HDHiiwM5KBhC9a
         90S51O5Xsb44j7S2RyDOekjfz7IkoD587C/BUBC99q2XtohspxAD/m3Oa4LOFzJF6pMu
         wUT0EGa9fp2E+StBnF9ZTTEzCzaUcT38YQqFGv+0L/00wc9VAdmoIMBvxFhYpsMoM3o6
         1u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737042404; x=1737647204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6kk26sm2fNwjo4EoPh6g3i5ilDYshORRrt132FmVMI=;
        b=NoN8TSy3fdt1BqggATffZi0olowBdFA65Yg2JCj0ZOfZ734jtwHEv4o+qvTEkvkUFA
         bLxnpHh5P2ANi5eFE4hPsGSaarPGxm9wIBjU0G4dqCnaeDJjxScRaLD80vSHPXIftYc6
         MvCeD/cZXlZoeh9H5Wy5x2rAYgnLotNbuHvKvJHnW93l53mXf4pq9TItltUagcCLgIE1
         7POm3jWiQBdkL0ZblgoXD+STsWwYqzQifAPUOo8wyqJAckvITWnJBS4fP9a0rmzlV9Of
         /vKkciu9VPxochKSBCCxDAOzORZlMiPQqA0qzUWCJKMwPGevlMvdpHahVcbOSj7fb5cX
         dxTw==
X-Forwarded-Encrypted: i=1; AJvYcCUhaz90PhlC7vUROtEW6Z7awU9p03VSEGQNgWQ9yWn3jEZEJFtgO2tkW/r9TU3Yks7yFnkASzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMpzVPAHYkDG2xOJWgTBO1h8bYX6WoVPqLBghpTeITOrslGmF
	wHGift1acDUpnxliSiI5jmeIwp308hdrn7xM6dJZwHcJ1qF/QaKgT8WWYJatq5dQq8qMcE+yEix
	ivPHfFsc9NStauo7zVCG0+znflyxPcCy1pYcE
X-Gm-Gg: ASbGncvDvNvHnbAeWD5C4+6mH2QYT5voruPZ1olBVRfQf5XyVVFhccODMULC2jcOZBF
	Odvk/jzBmvGAVjj/CFdimlA4lfzJmR4fY5W5iamzq8q/VQxxLVj3FGK/lOy2CLNsgSgkRb9w=
X-Google-Smtp-Source: AGHT+IFBQQaJlLPvmKVRSg8fGWlgDEhNJjoUmZcVqbl0G1ub+WDIDp29Q7FIpFN6ep9BqmakvmtOSIx2718UI0GyXS4=
X-Received: by 2002:ac8:7f11:0:b0:462:b2f5:b24c with SMTP id
 d75a77b69052e-46e054c6e87mr3122901cf.29.1737042403501; Thu, 16 Jan 2025
 07:46:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115010450.2472-1-ma.arghavani.ref@yahoo.com>
 <20250115010450.2472-1-ma.arghavani@yahoo.com> <CAL+tcoAtzuGZ8US5NcJwJdBh29afYGZHpeMJ4jXgiSnWBr75Ww@mail.gmail.com>
 <501586671.358052.1737020976218@mail.yahoo.com> <CAL+tcoA9yEUmXnHFdotcfEgHqWSqaUXu1Aoj=cfCtL5zFG1ubg@mail.gmail.com>
 <CADVnQy=3xz2_gjnM1vifjPJ_2TpT55mc=Oh7hO_omAAi9P6fxw@mail.gmail.com> <CANn89iJfx3CBJYBS01Mz9z3twjsP3xvSSOamno-cYSSzv3gSxw@mail.gmail.com>
In-Reply-To: <CANn89iJfx3CBJYBS01Mz9z3twjsP3xvSSOamno-cYSSzv3gSxw@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 16 Jan 2025 10:46:27 -0500
X-Gm-Features: AbW1kvZYPWUhO48qbhKquxQzv1-DSIy1UnC5gVMXzvhqlhu2F06WxkjFRVkMoXI
Message-ID: <CADVnQyndHKQ62_9psR1SD9LLtP_johFm-Q+tuaW3E5OYO+sGrg@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp_cubic: fix incorrect HyStart round start detection
To: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Mahdi Arghavani <ma.arghavani@yahoo.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"haibo.zhang@otago.ac.nz" <haibo.zhang@otago.ac.nz>, 
	"david.eyers@otago.ac.nz" <david.eyers@otago.ac.nz>, "abbas.arghavani@mdu.se" <abbas.arghavani@mdu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 10:30=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Jan 16, 2025 at 3:42=E2=80=AFPM Neal Cardwell <ncardwell@google.c=
om> wrote:
> >
> > On Thu, Jan 16, 2025 at 6:40=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Thu, Jan 16, 2025 at 5:49=E2=80=AFPM Mahdi Arghavani <ma.arghavani=
@yahoo.com> wrote:
> > > >
> > > > Hi Jason,
> > > >
> > > > I will explain this using a test conducted on my local testbed. Ima=
gine a client and a server connected through two Linux software routers. In=
 this setup, the minimum RTT is 150 ms, the bottleneck bandwidth is 50 Mbps=
, and the bottleneck buffer size is 1 BDP, calculated as (50M / 1514 / 8) *=
 0.150 =3D 619 packets.
> > > >
> > > > I conducted the test twice, transferring data from the server to th=
e client for 1.5 seconds:
> > > >
> > > > TEST 1) With the patch applied: HyStart stopped the exponential gro=
wth of cwnd when cwnd =3D 632 and the bottleneck link was saturated (632 > =
619).
> > > >
> > > >
> > > > TEST 2) Without the patch applied: HyStart stopped the exponential =
growth of cwnd when cwnd =3D 516 and the bottleneck link was not yet satura=
ted (516 < 619). This resulted in 300 KB less delivered data compared to th=
e first test.
> > >
> > > Thanks for sharing these numbers. I would suggest in the v3 adding th=
e
> > > above description in the commit message. No need to send v3 until the
> > > maintainers of TCP (Eric and Neal) give further suggestions :)
> > >
> > > Feel free to add my reviewed-by tag in the next version:
> > > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > >
> > > Thanks,
> > > Jason
> >
> > Mahdi, a few quick questions about your test logs, beforePatch.log and
> > afterPatch.log:
> >
> > + What is moRTT? Is that ca->curr_rtt? It would be great to share the
> > debug patch you used, so we know for certain how to interpret each
> > column in the debug output.
>
> +1
>
> Debug patches can alone add delays...
>
>
>
> >
> > + Are both HYSTART-DELAY and HYSTART-ACK-TRAIN enabled for both of thos=
e tests?

I like Jason's suggestion to include your test results in the v3
commit message. Please also include a phrase about which Hystart
mechanism triggered in each case.

Perhaps something like the following, just above the footers (with an
empty line separating this text and the following footers):

---
I tested with a client and a server connected through two Linux
software routers. In this setup, the minimum RTT is 150 ms, the
bottleneck bandwidth is 50 Mbps, and the bottleneck buffer size is 1
BDP, calculated as (50M / 1514 / 8) * 0.150 =3D 619 packets.

I conducted the test twice, transferring data from the server to the
client for 1.5 seconds:

Before: Without the patch applied: HYSTART-DELAY stopped the
exponential growth of cwnd when cwnd =3D 516 and the bottleneck link was
not yet saturated (516 < 619). This resulted in 300 KB less delivered
data compared to the first test.

After: With the patch applied: HYSTART-ACK-TRAIN stopped the
exponential growth of cwnd when cwnd =3D 632 and the bottleneck link was
saturated (632 > 619).
---

(with all lines wrapped in a way that makes scripts/checkpatch.pl happy...)

Eric mentioned:
> Debug patches can alone add delays...

Yes, this is a good point. To avoid introducing delays, you probably
want to run your emulation test without the debug patch, and simply
use "nstat -n" before the test and "nstat" after the test to see (a)
the type of Hystart mechanism that triggered (b) the cwnd at which it
triggered.

(I'm still interested in your debug patch so we know for certain how
to interpret your previously shared log files.)

Mahdi, your tcp_cubic.c patch looks OK to me, so I'm running your
patch and tests through our kernel test pipeline to see what we get.

thanks,
neal

