Return-Path: <netdev+bounces-191083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B3AABA012
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80021783DB
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0638D1C5485;
	Fri, 16 May 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrew.cmu.edu header.i=@andrew.cmu.edu header.b="NUJdr+x2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51C7D07D
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409931; cv=none; b=YD+YHm8/kveeKnzTiGecdCUirt7CqGG3v4FOkw354CAmbOXDvIFgoL5wha0w/4UTBhhQUlCFJBjCMzSknhmAl4MotqmFG+jiacod7wadzm3dF2f63Cn17eFuEe076IN6kX4Ml0JhwjsOZPQvPcZdUYSTUwZHAkaT6iZjkRzUtak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409931; c=relaxed/simple;
	bh=s5/wpROIcFZoBXqNfMHLOGBong3V9IcRTxWs9SulvHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccGovFmS0hMvaXaxzRmVyL5V+54HosQKz2GpKLAL7d8+VNGM8rMfm9EE0S6vvJ+EPOloflQnEPyAIupS8glJG/UaXGKsA6SghVnTrdQJQzksUlrW7Zi5okMzMwK/Mi01onQ+2T3BQUpaXXX3AeeBE/bKj6vj0KCQBVA/tx7jeNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andrew.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=andrew.cmu.edu header.i=@andrew.cmu.edu header.b=NUJdr+x2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andrew.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-326ca53a7e8so18947601fa.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrew.cmu.edu; s=google-2021; t=1747409923; x=1748014723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTxdjJLL9lqFYv8W2LAbXiMVqeAWz+CAFp9okoAae/4=;
        b=NUJdr+x28rxawQKGakiFl6EQZOYNw14+8QlHaKuzN3ztRTdnu/gqGFybEfTjzGPFRw
         Bi3/6ql2K47gY5GHVoU2ejZ0TuNODwG7H91rX4jGdWldilQ9xUHmZbS7t+ECT4sDa3ht
         CSE4sVL12MqNQDnqjaHP317ZFlrMu/JHmnKB0+kIvvOS9PH2p1E1jK10CocQu/pPHimN
         UaZ7JjlcEKc3oBV1Icjujgj3s8afvu238p6K6R1lSVB7fZ/JpsP94W6OG9wTSpFlOhOX
         cffAYSiTSFQjm+gRx9k86/hqpqpexOaZuYErcTsuMoeOgArAU4S0K5F2rMkzWVPGcsWO
         JOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747409923; x=1748014723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTxdjJLL9lqFYv8W2LAbXiMVqeAWz+CAFp9okoAae/4=;
        b=jdcY6mkeXsNrE0qOK8se17g8qyQX7/6miAeS6cwlQXtImPpaagSrd5hMXJas5tNyrN
         X9wySJ+scK+ms4+/Bj+TqXRVGv4CejOhNPnU3I4X4eGYcmV1Z1AWtOv7hoo5bwqUr2Di
         IjRwjO7ao63zrTSUq7boxMNzVQ55Ca0/Gb0Zl6a8NAHPI+LOmscvkSut6D/scZqe0vLr
         vkCDKkY0c95kvebMskBp3DAADIcKXG6IiaCRuztMKPEzMrStQ8U5gFl8n0zFiJOuJ9/A
         /98MDB5fxt31Cgkxt5ZzLh51PgmZMYlRzr3BoFmbWq4IZ3SynZGuP9oMVnbvrfpGTuIK
         4xUw==
X-Gm-Message-State: AOJu0YzcVuPVvhYP2JkRSlSzh92PP0+B02kOLmMwYhZdRgSppF2/Hu88
	02W2p3IfRXjLG0Z3mtH8S49krZEnP4TNGla3GrIJNgUWb6tqP5oO8aVicegLQlk/LkjHVyrpDLn
	LpeO4o31P3A5kajEgyIiFQ90fFaYOqmJ1XDp8HM9FqJZz0pEwucw=
X-Gm-Gg: ASbGncuUPo7ZzfhfCFys5T3mfPoDXj9TXkj1GsXj46W/vEnttPrEAlQEH5SkPgYc6JR
	T2LBLM6MpHtnAC3mHQGr3/QQ7vC6fg8ixkuqWW3DGPA5WjVHNGA8hbnutJy4f84C5wUFPMy5NY3
	wej+mFlewkECZ7wcd6REo8v6dhhNje4Vm+
X-Google-Smtp-Source: AGHT+IFLlXFiFzS7sA4nJjkGz61G80E8EYrS/onFH7I+qTzyhn41M2HLEjF6nOWCE/5+fIby3WcAD3HC+3s3QG2QpJc=
X-Received: by 2002:a05:651c:3131:b0:30d:e104:a944 with SMTP id
 38308e7fff4ca-328097bfe56mr9803021fa.40.1747409922988; Fri, 16 May 2025
 08:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFYr1XPb=J0qeGt0Tco1z7QURmBH8TiWP0=uH0zhU=wCQKCtpA@mail.gmail.com>
 <CADVnQy=upW8ACnF5pN0d_AJtGi_OwT2VWc4Jg1nJ47Np-Qj66g@mail.gmail.com>
In-Reply-To: <CADVnQy=upW8ACnF5pN0d_AJtGi_OwT2VWc4Jg1nJ47Np-Qj66g@mail.gmail.com>
From: Anup Agarwal <anupa@andrew.cmu.edu>
Date: Fri, 16 May 2025 11:38:06 -0400
X-Gm-Features: AX0GCFu80lWRGILK34mdVk9rLYDyPGQrd8fMGWJRuFtxl3hwUwsmdzTV-qA8WkQ
Message-ID: <CAFYr1XMavsEr36TNu5ZxSwju3uwXgKnA36zqwVnPYeEiaK4RdA@mail.gmail.com>
Subject: Re: Potential bug in Linux TCP vegas implementation
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neal,

(Sorry for potentially duplicate email, I think my previous email got
dropped by the netdev mailing list).
I am happy to do this. I am not fully sure about the process for
communicating the patch. It seems like Linux uses emails instead of
pull requests. I am also not sure about the standard of
unit/integration/performance testing for such changes.

The fix is as simple as the patch below. In the expression for diff,
we just replace the denominator from baseRTT to rtt. I do not
anticipate this requiring any other change for addressing division by
0, integer overflows, or precision loss (e.g., fixed-point
arithmetic). This is because rtt is at least 1 (just like baseRTT),
and numerical values of rtt should lie in a similar range as baseRTT.

I am not fully sure about the precision part as I don't know why the
original 1999 implementation needed fixed-point given the latest one
does not.

Best,
Anup

From cccf2ef01acade18015977fabda56a619aa2084f Mon Sep 17 00:00:00 2001
From: Anup Agarwal <anupa@andrew.cmu.edu>
Date: Tue, 13 May 2025 22:57:19 +0000
Subject: [PATCH] tcp: tcp_vegas fix diff computation

Commit 8d3a564da34e5844aca4f991b73f8ca512246b23 changed the algebraic
expression for computing "diff =3D expected throughput - actual
throughput" compared to the prior implementation. This change was not
intended by that commit. This commit reverts this change ensuring that
the kernel implementation better reflects the algorithm description in
the original Vegas paper and the original Linux implementation.
---
 net/ipv4/tcp_vegas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_vegas.c b/net/ipv4/tcp_vegas.c
index 786848ad37ea..fd4ca1fbdf63 100644
--- a/net/ipv4/tcp_vegas.c
+++ b/net/ipv4/tcp_vegas.c
@@ -224,7 +224,7 @@ static void tcp_vegas_cong_avoid(struct sock *sk,
u32 ack, u32 acked)
  * and the window we would like to have. This quantity
  * is the "Diff" from the Arizona Vegas papers.
  */
- diff =3D tcp_snd_cwnd(tp) * (rtt-vegas->baseRTT) / vegas->baseRTT;
+ diff =3D tcp_snd_cwnd(tp) * (rtt-vegas->baseRTT) / rtt;

  if (diff > gamma && tcp_in_slow_start(tp)) {
  /* Going too fast. Time to slow down
--
2.34.1


On Mon, May 12, 2025 at 2:18=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Mon, May 12, 2025 at 1:44=E2=80=AFPM Anup Agarwal <anupa@andrew.cmu.ed=
u> wrote:
> >
> > Hi Neal,
> >
> > I am reaching out to you since you are listed as a point of contact
> > for Linux TCP (https://docs.kernel.org/process/maintainers.html) and
> > http://neal.nu/uw/linux-vegas/ seems to indicate that you also wrote
> > the initial Vegas implementation in Linux kernel.
> >
> > I believe this commit
> > https://github.com/torvalds/linux/commit/8d3a564da34e5844aca4f991b73f8c=
a512246b23
> > introduced a bug in Vegas implementation.
> >
> > Before this commit, the implementation compares "diff =3D cwnd * (RTT -
> > baseRTT) / RTT" with alpha_pkts. However, after this commit, diff is
> > changed to "diff =3D cwnd * (RTT - baseRTT) / baseRTT". This small
> > change in denominator potentially changes Vegas's steady-state
> > performance properties.
> >
> > Specifically, before the commit, Vegas's steady-state rate is "rate =3D
> > alpha_pkts / delay", by substituting rate =3D cwnd/RTT and delay =3D RT=
T -
> > baseRTT in the equation "diff =3D alpha_pkts" (i.e., when flows do not
> > have incentive to change cwnd). After the commit, we get "rate =3D
> > alpha_pkts/delay * baseRTT/RTT". When baseRTT is small this is close
> > to "rate =3D alpha_pkts / delay^2".
> >
> > "rate =3D alpha_pkts / delay" is the key to ensuring weighted
> > proportional fairness which Vegas has been analyzed to ensure (e.g.,
> > in https://www.cs.princeton.edu/techreports/2000/628.pdf or
> > https://link.springer.com/book/10.1007/978-0-8176-8216-3).
> > "rate =3D alpha_pkts/delay^2" would not give proportional fairness. For
> > instance on a parking lot topology, proportional fairness corresponds
> > to a throughput ratio of O(hops), whereas the delay^2 relation gives a
> > throughput ratio of O(hops^2) (derived in
> > https://arxiv.org/abs/2504.18786).
> >
> > In practice, this issue or fixing it is perhaps not as important
> > because of the 3 reasons below. However, since this seems to be a
> > clear algebraic manipulation mistake in the commit and is an easy fix,
> > the issue can perhaps be fixed nonetheless. Please let me know in case
> > I missed something and this was instead an intentional change.
> >
> > (R1) Few people (outside of perhaps congestion control evaluation) use =
Vegas.
> > (R2) To trigger this issue, one needs both low baseRTT and low
> > capacity (to ensure delay is large enough to matter (see R3 below)).
> > This implies low BDP networks at which point cwnd clamps may kick in.
> > Alternatively, large alpha_pkts value could trigger the issue instead
> > of low capacity.
> > (R3) In my empirical tests, I start seeing issues due to RTprop
> > (baseRTT) misestimation long before this issue.
> >
> > Best,
> > Anup
>
> Hi Anup,
>
> Thanks for catching this!  Your analysis looks correct to me.
>
> Looks like that
> https://github.com/torvalds/linux/commit/8d3a564da34e5844aca4f991b73f8ca5=
12246b23
> commit was merged in 2008, when I was not involved with Linux TCP
> development, so I didn't notice this modification vs my original 1999
> version of Linux TCP Vegas code (
> http://neal.nu/uw/linux-vegas/patches/linux-vegas-v2-patch-2.3 ).
>
> Anup, are you interested in proposing a commit to fix this, and
> sending it to the list? If you are not interested, or don't have time,
> then I can try to find time to do that (of course, properly crediting
> you with reporting the issue and suggesting the fix).
>
> Thanks!
>
> best,
> neal

