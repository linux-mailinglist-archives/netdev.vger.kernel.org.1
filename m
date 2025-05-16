Return-Path: <netdev+bounces-191150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24998ABA467
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F1A077E3
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 19:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49F22750EB;
	Fri, 16 May 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrew.cmu.edu header.i=@andrew.cmu.edu header.b="QYoFLfyu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2ED19006B
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425284; cv=none; b=ZIdBMu7d+Ye24/23iYx3UZVXyWjZW/V+wskrY1NOETy7T3I9wbqCzKLLPO9tuJOAiRPM6sy3/V5QKIh+xMhexgLKZaM1Z5C3VDGQtBRCwjmDuHEy8J3NFB29VYjmpGHTM+y8KAsJmxBoOEOvCPDRDieT8zQBPldrpwdrRwuDxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425284; c=relaxed/simple;
	bh=Hh0XgANPIGTPvpA7Tx65HjDj812Cr19Md6liBAFM+D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtTkJRXOxut+6HbrNMe46n0yhKSG1g2mRI5HtyXtAAXIP9fdRw8BDT7lesI2kQ1c8rFu83VVkUBuQpUjBNYeqSAP0dUtj5Le6p7MIa0s0KbnZsFbnxDxVIb5fefppES01rwYs3IJXdMdXXE1u/x7VJrENCf/KOAWerL8yJuYgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andrew.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=andrew.cmu.edu header.i=@andrew.cmu.edu header.b=QYoFLfyu; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andrew.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso19959631fa.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrew.cmu.edu; s=google-2021; t=1747425277; x=1748030077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY9NNilNC+wkSs/cKXf1UYGYzrTFWINZfgzdjcwUhLQ=;
        b=QYoFLfyuCeah4UdRmfezA5UAo9SlYpCxvsGnPLmmr898S+XitLnnIqSTBny7JxfBC7
         ZxQjcED5i5lTW3Qh01keBJCy99ErMKMfnScKzcMMGm1MT/6OMohEQTd7NCqavZWz8DTU
         8vI52qazDjQAcvXH5M/n247JRF9kd6zxOGITpr7e+MDSTsYSbVRBEKj/41fKWd02JfAn
         ZGMeqGOey7vkI9NKk0r9e1apLSlzVtX9U2w6xYLNGJkRYPvUCPBINcZlLafztCU9Vt8s
         vDdvHxL2EBPN0ebqF9vKAOqgaSgLJc24v5UnxtMyRSyC9S0OIauD3Ys1JJroYDJmGsnB
         qVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747425277; x=1748030077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yY9NNilNC+wkSs/cKXf1UYGYzrTFWINZfgzdjcwUhLQ=;
        b=myeT8xQCJ70RbLeqTn1ArP82v8lVfgeRv5VkB4dFpJ8Qtb3T6KFkvtmFALv69YyUkH
         AiS0j4AGCURecF/9SYcLGoOVPr18dbSXuW5CtYABzP30El3/F0mu7IuBlaaZeo+fbPyY
         SY3thFrltmnFrXxDfokJBoydHRdpiVU5sRWHs81J+TFyV/1UA5ZJPWNLouBnVqoTNRUz
         ybbRV6H+JPaA0OYUKSliFGKlomEp4rXVrWV2lYfIh8V6iIhScuZO8Z4P8lBsGyc60UiJ
         cWpfzuzP6yB2MZaO+tY0aDLKxDB7x4FskDuGKjD8s7ktFMX5ukK+7W7VYdpfAwIUjQUV
         HwFg==
X-Gm-Message-State: AOJu0YwO24omm9c/4w60AHYlPM2Xx8h0ISvTlfh3xxespvB+kDs/Tlky
	Gdb7BhjwT0/R/F8fw6ilGnDF02BzVKCLxUXuqID5psW+ocIwjeniMH8OVauQKmpLn7lpf/45dJ0
	S8JcLuGJ0QYS09Gc+0EzUqnIL/yZ/0fu4cCrSuNJrgpn5tc1IPIc=
X-Gm-Gg: ASbGnctKaOevrlMc00vPDXKFORWbUECsqsxcVP/bfTRtfEi5N63vw5O9l/hAimAZsCp
	qQcanflIMH96sVbfM1nS0gDzlJv0j3K19320QjwsK/EmN3Q918eQ8bPeoH8qHkur/Ew42L+gkZI
	DwcmNSMZAwNb7wQAJfHtIAY+RJ8o+mp0Lw
X-Google-Smtp-Source: AGHT+IG1tKG06x+CjZPaotRrM4RDpV8UB4zpeBC1iyMOVwrDjpFxFOFP6u2awmQuad99sbUX493YLeKA8zvakLQO2cI=
X-Received: by 2002:a05:651c:144c:b0:30c:160b:c75f with SMTP id
 38308e7fff4ca-328097bfdf6mr13725211fa.36.1747425277273; Fri, 16 May 2025
 12:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFYr1XPb=J0qeGt0Tco1z7QURmBH8TiWP0=uH0zhU=wCQKCtpA@mail.gmail.com>
 <CADVnQy=upW8ACnF5pN0d_AJtGi_OwT2VWc4Jg1nJ47Np-Qj66g@mail.gmail.com>
 <CAFYr1XOKceKP50Nc=T02McTa0FNdRNB0zEQUVop8PDW4F-dxuw@mail.gmail.com> <CADVnQy=C+9ogbtS7fVM9cev5iT+6Fz88H2FTKcjwKFnDbsUe2A@mail.gmail.com>
In-Reply-To: <CADVnQy=C+9ogbtS7fVM9cev5iT+6Fz88H2FTKcjwKFnDbsUe2A@mail.gmail.com>
From: Anup Agarwal <anupa@andrew.cmu.edu>
Date: Fri, 16 May 2025 15:54:00 -0400
X-Gm-Features: AX0GCFuyuSUkCE-JoELZtu62qqvxZTPcAiubOvTP9o98rIK8MmZkLi9Z-lZAoBs
Message-ID: <CAFYr1XNeLcCx4pur-RTHGcn_2hE-w6TYFFuOKFFohAXxTxCSag@mail.gmail.com>
Subject: Re: Potential bug in Linux TCP vegas implementation
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the detailed guidance Neal. I will get back to you with
this. I am assuming this is low priority/there is no pressing timeline
on this.


On Fri, May 16, 2025 at 1:55=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Tue, May 13, 2025 at 7:20=E2=80=AFPM Anup Agarwal <anupa@andrew.cmu.ed=
u> wrote:
> ...
> > From cccf2ef01acade18015977fabda56a619aa2084f Mon Sep 17 00:00:00 2001
> > From: Anup Agarwal <anupa@andrew.cmu.edu>
> > Date: Tue, 13 May 2025 22:57:19 +0000
> > Subject: [PATCH] tcp: tcp_vegas fix diff computation
> >
> > Commit 8d3a564da34e5844aca4f991b73f8ca512246b23 changed the algebraic
> > expression for computing "diff =3D expected throughput - actual
> > throughput" compared to the prior implementation. This change was not
> > intended by that commit. This commit reverts this change ensuring that
> > the kernel implementation better reflects the algorithm description in
> > the original Vegas paper and the original Linux implementation.
> > ---
> >  net/ipv4/tcp_vegas.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_vegas.c b/net/ipv4/tcp_vegas.c
> > index 786848ad37ea..fd4ca1fbdf63 100644
> > --- a/net/ipv4/tcp_vegas.c
> > +++ b/net/ipv4/tcp_vegas.c
> > @@ -224,7 +224,7 @@ static void tcp_vegas_cong_avoid(struct sock *sk, u=
32 ack, u32 acked)
> >   * and the window we would like to have. This quantity
> >   * is the "Diff" from the Arizona Vegas papers.
> >   */
> > - diff =3D tcp_snd_cwnd(tp) * (rtt-vegas->baseRTT) / vegas->baseRTT;
> > + diff =3D tcp_snd_cwnd(tp) * (rtt-vegas->baseRTT) / rtt;
> >
> >   if (diff > gamma && tcp_in_slow_start(tp)) {
> >   /* Going too fast. Time to slow down
> > --
> > 2.34.1
>
> Hi Anup,
>
> Many thanks for the patch!
>
> > I am not fully sure about the process for communicating the patch.
> > It seems like Linux uses emails instead of pull requests.
> > I am also not sure about the standard of
> > unit/integration/performance testing for such changes.
>
> Here are some notes on the process:
>
> Please  read the following for documentation on the process for
> networking patches:
>   https://docs.kernel.org/process/maintainer-netdev.html
>   https://docs.kernel.org/process/submitting-patches.html
>
> I would suggest including in the commit message more of the details
> you shared earlier in this thread about the nature of the bug and
> rationale for your bug fix.
>
> I would suggest adding some commit message text like the following:
>
> The following 2008 commit:
>
> 8d3a564da34e ("tcp: tcp_vegas cong avoid fix")
>
> ...introduced a bug in Vegas implementation.
>
> And then would suggest pasting in your previous notes:
>
> """
> Before this commit, the implementation compares "diff =3D cwnd * (RTT -
> baseRTT) / RTT" with alpha_pkts. However, after this commit, diff is
> changed to "diff =3D cwnd * (RTT - baseRTT) / baseRTT". This small
> change in denominator potentially changes Vegas's steady-state
> performance properties.
>
> Specifically, before the commit, Vegas's steady-state rate is "rate =3D
> alpha_pkts / delay", by substituting rate =3D cwnd/RTT and delay =3D RTT =
-
> baseRTT in the equation "diff =3D alpha_pkts" (i.e., when flows do not
> have incentive to change cwnd). After the commit, we get "rate =3D
> alpha_pkts/delay * baseRTT/RTT". When baseRTT is small this is close
> to "rate =3D alpha_pkts / delay^2".
>
> "rate =3D alpha_pkts / delay" is the key to ensuring weighted
> proportional fairness which Vegas has been analyzed to ensure (e.g.,
> in https://www.cs.princeton.edu/techreports/2000/628.pdf or
> https://link.springer.com/book/10.1007/978-0-8176-8216-3).
> "rate =3D alpha_pkts/delay^2" would not give proportional fairness. For
> instance on a parking lot topology, proportional fairness corresponds
> to a throughput ratio of O(hops), whereas the delay^2 relation gives a
> throughput ratio of O(hops^2) (derived in
> https://arxiv.org/abs/2504.18786).
> """
>
> While you are changing this pline, please address the style issue in
> this line (missing space around the - operator). So instead of:
>
>   diff =3D tcp_snd_cwnd(tp) * (rtt-vegas->baseRTT) / rtt;
>
> Please use something more like:
>
>   diff =3D tcp_snd_cwnd(tp) * (rtt - vegas->baseRTT) / rtt;
>
> Please compile and test your change on top of the "net" branch:
>
> git remote add net git://git.kernel.org/pub/scm/linux/kernel/git/netdev/n=
et.git
> git fetch net
> git checkout net/main
> git cherry-pick $YOUR_PATCH_SHA1
>
> Then please compile, boot, and test the patch, and add a few sentences
> about how you tested the patch, and what results you saw. Sadly, I
> don't think there are any automated tests for Linux TCP vegas in the
> kernel source tree, so for this commit, I would suggest the minimal
> testing would be something like reporting throughput and average RTT
> and average loss rate for:
>
> (1) a test with a single Vegas flow
> (2) a test with multiple Vegas flows sharing a bottleneck
>
> (Reporting the bottleneck bandwidth and min_rtt for each case, and
> whether the test was with netem or a real network, etc.)
>
> Please add a Signed-off-by: footer in the commit message, if you can
> certify the items documented here:
>
>   https://docs.kernel.org/process/submitting-patches.html#sign-your-work-=
the-developer-s-certificate-of-origin
>
> Since this is a bug fix, please add a Fixes: footer in the commit
> message before your Signed-off-by: footer, so maintainers know what
> commit has the bug you are fixing, so they know how far back in
> history to backport the fix for stable releases. In this case, based
> on the commit you mentioned you are fixing, I think we want:
>
> Fixes: 8d3a564da34e ("tcp: tcp_vegas cong avoid fix")
>
> You can run "git log" in your Linux source directory to get a sense of
> the formatting for the Signed-off-by:  and Fixes:  footer.
>
> Finally, please check the patch for style/formatting problems with the
> checkpatch.pl script:
>
>   ./scripts/checkpatch.pl *.patch
>
> After compiling and testing the patch, adding those footers, and
> verifying the patch with scripts/checkpatch.pl, please format the
> patch and email it to the mailing list:
>
> git format-patch --subject-prefix=3D'PATCH net' HEAD~1..HEAD
>
> git send-email \
>   --to 'David Miller <davem@davemloft.net>' \
>   --to 'Jakub Kicinski <kuba@kernel.org>' \
>   --to 'Eric Dumazet <edumazet@google.com>' \
>   --cc 'netdev@vger.kernel.org'  *.patch
>
>
> Thanks!
> neal

