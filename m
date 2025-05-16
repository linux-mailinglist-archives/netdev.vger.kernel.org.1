Return-Path: <netdev+bounces-191125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86EABA241
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 19:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964381BA2DBA
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620D24888D;
	Fri, 16 May 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEZRlcwg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434CBA31
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418114; cv=none; b=cJS6/Fxx1qPhhMKDI8V0m01RObu5Q1Y8LEnRHGYI74NXZolH99DkCEAnsoxs1P0N+3szbejry4PgG2U6ZNouKnjE91MpsHOyrqgeAK7JhyrQicQkYgX4fw5qGV2XI91dRS3kNjxgQGxL/Qzp2MJPV11/6BCDYBCshd1md/+UcIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418114; c=relaxed/simple;
	bh=M8DCtvg0xAzMmBPx7RaYFWqdyuOPEkxnzCaa8SwaB6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpzQyYf4AmVyiwb9MTmDgZxcRpJstlrV6V3I98SQnjMMfQEw37TUz/xVrZzcZgC96M3QOmBA1i14WqpDYeun1wX3H9F1FuhmjeOinYYuAyFljoIzGZTgY42l2b8mlXhSRaC4elEP9kdZFAzgHaTlQSnsZREmwjRTz07ODCnH1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jEZRlcwg; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-48b7747f881so26321cf.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747418111; x=1748022911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3FhLrCYH5Y47YZNjJKUMTUCmfALLfoq2jnT5Wwy7jk=;
        b=jEZRlcwgDIr3wvto2rN1kr9h9qmsQfVkBT0PB+SZaRNy/uxcu4BkDVPy8BSVJvxk79
         GOayTktR9TsCDSey0Q0H96kTeyU0WPOlFObt0wRWyanvCfIREdc5+5q5qgmZi3n9Pk5u
         CgrT2L6zY5oSGZYU5rsIshE4oU81UnnBISKj9Vg14q5meSRguby4Ilpi117yu/UpP7BD
         aBvlNA2uaKJ+TXEnZTbhmry+klTCAIDqARVQajgmaSPjy3HpMd+pY7MUrQDjIY4Z+D7U
         8xYdGjV4n0PFGrfIcoLcmMmO3dpqpaH8ClAxKd5RvGAMEqdQBs8zuwFVbvrWuMz6KLs8
         tROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747418111; x=1748022911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3FhLrCYH5Y47YZNjJKUMTUCmfALLfoq2jnT5Wwy7jk=;
        b=iKQut5L5kvgBC4UV3QA+Q25SH7c9XKI48GgvZhj5OM9pFB2nuhQ4h3iO+6dKtyNwwC
         7X8OTTvOF+4yLuEUvBF0LP9MoVxAMY2oFEVSO9MR7rrjEeRx/cRIA9xZ1/70WJfXHmB+
         8jWyy0PMwQJU9mi9nl4pSBNSK2Tb+7VXRLb1m5HsEGBBf30695Ym3wznm/4uQhPD4KWT
         HeP4K3W4tCNYoAX6ejDx2nhpdAoAfwwzTYz7y/Jy4sL8WrwNwjUJR/pQ/U1CXoyihDaV
         CATmSlYffK7l9YTNDOmngckwYs+1BgiKsY2Pbi0i32KYATXIWM8hvh51u4GgAT1SH42G
         zjUw==
X-Gm-Message-State: AOJu0YwoRH7KIAcG/9ESsDf00JLJP+uNAOHuNUrO8EeJdBzL8xlkSh4T
	XpMJEkZFsqHevML2/bSZfxWF9tvPlM+dvVIRN3ZI6LG0DhisJJTmFk4mcoQF7z6D7rOdAB2kPnv
	cOE0CfnrZ05caDHFRrzfngfc8QHOqYW+cN5ek/Z5V//DRTB1zaef01DjRwKQ=
X-Gm-Gg: ASbGncsZ20b2zNOMwmGwcPMdsJfdEt4RD9b1LYtqAfVBMQvM+xoWjddx7SBieuQLtTr
	woME5EFBJ1xNTdTODPz8cv3zg5d1He3H5q65gISYcPL8n0w3H/1bV7879GZ+3gyKTHZrRtMr9jP
	zjFQOa9NaSxp+BkUBDRUYIfeM2YsNlCrr5HvNrGnkp0laXhqNTYUAoee3ri/WhLZcJij45se7vt
	C9j
X-Google-Smtp-Source: AGHT+IFISTrvIFWlXqHycpT9/TCXtEUOLr+afezkSVHlshfSC7ehTTQSeXhbvo9IHAQJHoOpP33EnueqEL5ItQez994=
X-Received: by 2002:a05:622a:1aa3:b0:477:63b7:3523 with SMTP id
 d75a77b69052e-4958cd1b9fdmr175281cf.4.1747418110889; Fri, 16 May 2025
 10:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFYr1XPb=J0qeGt0Tco1z7QURmBH8TiWP0=uH0zhU=wCQKCtpA@mail.gmail.com>
 <CADVnQy=upW8ACnF5pN0d_AJtGi_OwT2VWc4Jg1nJ47Np-Qj66g@mail.gmail.com> <CAFYr1XOKceKP50Nc=T02McTa0FNdRNB0zEQUVop8PDW4F-dxuw@mail.gmail.com>
In-Reply-To: <CAFYr1XOKceKP50Nc=T02McTa0FNdRNB0zEQUVop8PDW4F-dxuw@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 16 May 2025 13:54:54 -0400
X-Gm-Features: AX0GCFtjs8uezxSTF2k8QZeHKdf0l1gQpWWsmeLgLYWYLjLyhfHADgRZyfEWo94
Message-ID: <CADVnQy=C+9ogbtS7fVM9cev5iT+6Fz88H2FTKcjwKFnDbsUe2A@mail.gmail.com>
Subject: Re: Potential bug in Linux TCP vegas implementation
To: Anup Agarwal <anupa@andrew.cmu.edu>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 7:20=E2=80=AFPM Anup Agarwal <anupa@andrew.cmu.edu>=
 wrote:
...
> From cccf2ef01acade18015977fabda56a619aa2084f Mon Sep 17 00:00:00 2001
> From: Anup Agarwal <anupa@andrew.cmu.edu>
> Date: Tue, 13 May 2025 22:57:19 +0000
> Subject: [PATCH] tcp: tcp_vegas fix diff computation
>
> Commit 8d3a564da34e5844aca4f991b73f8ca512246b23 changed the algebraic
> expression for computing "diff =3D expected throughput - actual
> throughput" compared to the prior implementation. This change was not
> intended by that commit. This commit reverts this change ensuring that
> the kernel implementation better reflects the algorithm description in
> the original Vegas paper and the original Linux implementation.
> ---
>  net/ipv4/tcp_vegas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_vegas.c b/net/ipv4/tcp_vegas.c
> index 786848ad37ea..fd4ca1fbdf63 100644
> --- a/net/ipv4/tcp_vegas.c
> +++ b/net/ipv4/tcp_vegas.c
> @@ -224,7 +224,7 @@ static void tcp_vegas_cong_avoid(struct sock *sk, u32=
 ack, u32 acked)
>   * and the window we would like to have. This quantity
>   * is the "Diff" from the Arizona Vegas papers.
>   */
> - diff =3D tcp_snd_cwnd(tp) * (rtt-vegas->baseRTT) / vegas->baseRTT;
> + diff =3D tcp_snd_cwnd(tp) * (rtt-vegas->baseRTT) / rtt;
>
>   if (diff > gamma && tcp_in_slow_start(tp)) {
>   /* Going too fast. Time to slow down
> --
> 2.34.1

Hi Anup,

Many thanks for the patch!

> I am not fully sure about the process for communicating the patch.
> It seems like Linux uses emails instead of pull requests.
> I am also not sure about the standard of
> unit/integration/performance testing for such changes.

Here are some notes on the process:

Please  read the following for documentation on the process for
networking patches:
  https://docs.kernel.org/process/maintainer-netdev.html
  https://docs.kernel.org/process/submitting-patches.html

I would suggest including in the commit message more of the details
you shared earlier in this thread about the nature of the bug and
rationale for your bug fix.

I would suggest adding some commit message text like the following:

The following 2008 commit:

8d3a564da34e ("tcp: tcp_vegas cong avoid fix")

...introduced a bug in Vegas implementation.

And then would suggest pasting in your previous notes:

"""
Before this commit, the implementation compares "diff =3D cwnd * (RTT -
baseRTT) / RTT" with alpha_pkts. However, after this commit, diff is
changed to "diff =3D cwnd * (RTT - baseRTT) / baseRTT". This small
change in denominator potentially changes Vegas's steady-state
performance properties.

Specifically, before the commit, Vegas's steady-state rate is "rate =3D
alpha_pkts / delay", by substituting rate =3D cwnd/RTT and delay =3D RTT -
baseRTT in the equation "diff =3D alpha_pkts" (i.e., when flows do not
have incentive to change cwnd). After the commit, we get "rate =3D
alpha_pkts/delay * baseRTT/RTT". When baseRTT is small this is close
to "rate =3D alpha_pkts / delay^2".

"rate =3D alpha_pkts / delay" is the key to ensuring weighted
proportional fairness which Vegas has been analyzed to ensure (e.g.,
in https://www.cs.princeton.edu/techreports/2000/628.pdf or
https://link.springer.com/book/10.1007/978-0-8176-8216-3).
"rate =3D alpha_pkts/delay^2" would not give proportional fairness. For
instance on a parking lot topology, proportional fairness corresponds
to a throughput ratio of O(hops), whereas the delay^2 relation gives a
throughput ratio of O(hops^2) (derived in
https://arxiv.org/abs/2504.18786).
"""

While you are changing this pline, please address the style issue in
this line (missing space around the - operator). So instead of:

  diff =3D tcp_snd_cwnd(tp) * (rtt-vegas->baseRTT) / rtt;

Please use something more like:

  diff =3D tcp_snd_cwnd(tp) * (rtt - vegas->baseRTT) / rtt;

Please compile and test your change on top of the "net" branch:

git remote add net git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net=
.git
git fetch net
git checkout net/main
git cherry-pick $YOUR_PATCH_SHA1

Then please compile, boot, and test the patch, and add a few sentences
about how you tested the patch, and what results you saw. Sadly, I
don't think there are any automated tests for Linux TCP vegas in the
kernel source tree, so for this commit, I would suggest the minimal
testing would be something like reporting throughput and average RTT
and average loss rate for:

(1) a test with a single Vegas flow
(2) a test with multiple Vegas flows sharing a bottleneck

(Reporting the bottleneck bandwidth and min_rtt for each case, and
whether the test was with netem or a real network, etc.)

Please add a Signed-off-by: footer in the commit message, if you can
certify the items documented here:

  https://docs.kernel.org/process/submitting-patches.html#sign-your-work-th=
e-developer-s-certificate-of-origin

Since this is a bug fix, please add a Fixes: footer in the commit
message before your Signed-off-by: footer, so maintainers know what
commit has the bug you are fixing, so they know how far back in
history to backport the fix for stable releases. In this case, based
on the commit you mentioned you are fixing, I think we want:

Fixes: 8d3a564da34e ("tcp: tcp_vegas cong avoid fix")

You can run "git log" in your Linux source directory to get a sense of
the formatting for the Signed-off-by:  and Fixes:  footer.

Finally, please check the patch for style/formatting problems with the
checkpatch.pl script:

  ./scripts/checkpatch.pl *.patch

After compiling and testing the patch, adding those footers, and
verifying the patch with scripts/checkpatch.pl, please format the
patch and email it to the mailing list:

git format-patch --subject-prefix=3D'PATCH net' HEAD~1..HEAD

git send-email \
  --to 'David Miller <davem@davemloft.net>' \
  --to 'Jakub Kicinski <kuba@kernel.org>' \
  --to 'Eric Dumazet <edumazet@google.com>' \
  --cc 'netdev@vger.kernel.org'  *.patch


Thanks!
neal

