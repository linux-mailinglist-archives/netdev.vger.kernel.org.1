Return-Path: <netdev+bounces-189862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9558AB4379
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 20:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB34E3AD0FD
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15584297A59;
	Mon, 12 May 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKcAGgJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C71C8639
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073884; cv=none; b=ss+zqO+IuAg4ecegviz5g8IyQHxwn6IDD5McMfb1wyCDvAT8/TCuUe/xZkMb6kvgDIx1IlRGXinG2kJitHeK1szLqkmCVaEcJRw5nPIbZOYIs1STjRy6wz8tjP+KlBijBSkjeC5uQOUFt0IYTcDALIMhfGUIiZRD5CkWFCLpTqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073884; c=relaxed/simple;
	bh=7aSTAKaJ8Mt1wjN/Nh/kCUO5fBHc8c8L7/WY2VA0CTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ath5T3V0Mc3hrcgU1gh837pX7ESt1+oOB9ldZmTX4Fd2sQaZrpXEM/0GE/132Wf8kzKzMPPFlgzMlCBqsMM3jZ5GO3T6+mLnAjICMo90BmNED1fQCKNNQUR5EZjWZBi6dsy+5P0MJiyjfUqmtVF51MHEnOe4RdJVUp42lcCFH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKcAGgJ7; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47666573242so53911cf.0
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747073881; x=1747678681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Zh4kUKhImIOLPQ3/fGdKiYbPpW5x0H5/e7VVOH+d2c=;
        b=uKcAGgJ7lkLUQ3AK59t8DK2cpasyqFAwWfOGEaJ7s10U7pbVB0k4F/3StA+2uQTJ5N
         xQUDpvK1fBgp4GPPI1g+mXWg8BDze/GIK9svM95tdL30x7p7VicaIdjuohnYPdjGgT6J
         yRMAAT84yxZC08F6X72On09V6D16GZ4W4spWanQj7cl/Jmaiio9mNlcumSFeQX8guTBU
         jHVtLYM0tpzTyeXClmljLwXHt21ip7bcZwEZyl8SUx2+kicyqniw6yDC3QiovPslwBOv
         KF8kj8zDaijoVeBd2Hvh13DzQeRKHN4L2PJro10hIz9wXuAqOqlmrn3ehS4EC47xiXAh
         feXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747073881; x=1747678681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Zh4kUKhImIOLPQ3/fGdKiYbPpW5x0H5/e7VVOH+d2c=;
        b=Nfk9P9PwjPj8fSFHCHWJLUK1ix8bUl7cnlxGXeY7CLLUprpTkJHd+t+4b87AoIIA8T
         M3mmnDyYX3hqXt1fofsR5rtgmEzGPaX7NE8spOUosUOsuumB5uFMvGvSTjISbrS2nGAs
         dXKjA1pu5QkihLoND2+DIuq+f1ckE8LU0WFDF1blQSzOfSms62neanZxd+KRdr98zgDb
         1CZgvPqn/zUrJyfgw3mcpL340DnUe/Px3NMwsgbmEX05V+1p+8D3J5RJ/xPabo6p3de0
         rFJWuqnptWAU73W4n+yvVp59ZteI9qyDEqIr6BrjoAGLDYE3jysTEYNN+zQWthxq3wuv
         JtwA==
X-Gm-Message-State: AOJu0YwmOfsfiYsmYynVIE9xh+zvSbD8FrKzM5sCvh9hv9OjRbXQxO+3
	UPma/VE8+UsnKHixve++PGwXgtM+H3ahGv59c/GSjAhE2ECUNyxp1GLNcCIWPcgx5O2bbY4HLac
	eNXhD3i9PBufedekx94yPy/wnTYipzdBFNHcZ2vcY
X-Gm-Gg: ASbGncuIsk4f0thH4MKFXVNoIpdhNO5zVlluD4U6PDEJFWLUYTFAPcNVzGi9DwaTS2C
	CJatSZBfjQIn8p4/XUgS4EDWlhQgAu3yFowMYTOZY/CsAkUJfp4op720wK5MFrsj5MtkMPi/re1
	wOckwyUl1QYKmvKJ59wafzEf0sLdVw8FEtW9siHxyXnfqUNm4z6o/AmPlflzGv9Wm0Cw==
X-Google-Smtp-Source: AGHT+IH/+3ca22+4m8ZxtBfmmsN42qLQte5dxMWYCOYlhw3Y02MzPvqf6aIii2tTrAQd2RqtRbuyryXp+H/EZG8zids=
X-Received: by 2002:a05:622a:190a:b0:477:1f86:178c with SMTP id
 d75a77b69052e-494880f4d18mr217721cf.26.1747073880887; Mon, 12 May 2025
 11:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFYr1XPb=J0qeGt0Tco1z7QURmBH8TiWP0=uH0zhU=wCQKCtpA@mail.gmail.com>
In-Reply-To: <CAFYr1XPb=J0qeGt0Tco1z7QURmBH8TiWP0=uH0zhU=wCQKCtpA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 12 May 2025 14:17:44 -0400
X-Gm-Features: AX0GCFtfu8llrOXooMGTqLc5W_MivVCoVB6KwNX3H3wivNAnOjuWfSReqxEVHV4
Message-ID: <CADVnQy=upW8ACnF5pN0d_AJtGi_OwT2VWc4Jg1nJ47Np-Qj66g@mail.gmail.com>
Subject: Re: Potential bug in Linux TCP vegas implementation
To: Anup Agarwal <anupa@andrew.cmu.edu>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 1:44=E2=80=AFPM Anup Agarwal <anupa@andrew.cmu.edu>=
 wrote:
>
> Hi Neal,
>
> I am reaching out to you since you are listed as a point of contact
> for Linux TCP (https://docs.kernel.org/process/maintainers.html) and
> http://neal.nu/uw/linux-vegas/ seems to indicate that you also wrote
> the initial Vegas implementation in Linux kernel.
>
> I believe this commit
> https://github.com/torvalds/linux/commit/8d3a564da34e5844aca4f991b73f8ca5=
12246b23
> introduced a bug in Vegas implementation.
>
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
>
> In practice, this issue or fixing it is perhaps not as important
> because of the 3 reasons below. However, since this seems to be a
> clear algebraic manipulation mistake in the commit and is an easy fix,
> the issue can perhaps be fixed nonetheless. Please let me know in case
> I missed something and this was instead an intentional change.
>
> (R1) Few people (outside of perhaps congestion control evaluation) use Ve=
gas.
> (R2) To trigger this issue, one needs both low baseRTT and low
> capacity (to ensure delay is large enough to matter (see R3 below)).
> This implies low BDP networks at which point cwnd clamps may kick in.
> Alternatively, large alpha_pkts value could trigger the issue instead
> of low capacity.
> (R3) In my empirical tests, I start seeing issues due to RTprop
> (baseRTT) misestimation long before this issue.
>
> Best,
> Anup

Hi Anup,

Thanks for catching this!  Your analysis looks correct to me.

Looks like that
https://github.com/torvalds/linux/commit/8d3a564da34e5844aca4f991b73f8ca512=
246b23
commit was merged in 2008, when I was not involved with Linux TCP
development, so I didn't notice this modification vs my original 1999
version of Linux TCP Vegas code (
http://neal.nu/uw/linux-vegas/patches/linux-vegas-v2-patch-2.3 ).

Anup, are you interested in proposing a commit to fix this, and
sending it to the list? If you are not interested, or don't have time,
then I can try to find time to do that (of course, properly crediting
you with reporting the issue and suggesting the fix).

Thanks!

best,
neal

