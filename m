Return-Path: <netdev+bounces-189857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE2AAB3F9C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B726019E6678
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D7296FDF;
	Mon, 12 May 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrew.cmu.edu header.i=@andrew.cmu.edu header.b="Z1Utt1a5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B76296FD9
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071857; cv=none; b=fajG1tl+az/rO39aS28ciBBo+HsrCbdW9OTqzXjoy6QxeOK7mmD3sJ60FdP40qlk2wurKC/PXXp3IKX535o/AI10+BQs5kWxBhZz0aMVqDD61P+YuqdDZDByA3jz7AdqelZQPmCLxpJZadUauCmpKNRXfxS4aSiOshDftGSiWLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071857; c=relaxed/simple;
	bh=YDxNpw4qVAHD26tWYX1P7IPbtKx1OUnwZz8ULeCaaUY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AWM+dC6ftlFj+mTYItnO2J92mZPJ/nj3o1iJZuUjxXHRC7MZ28R9L0+W8lVoV5Sy7aB73j75nIBdwyP1/qTaqKLLllN+3Vd1Ul+hIbZqNs96aI2wLuceU0KweglAojoArisBYKyfOMGRS6y0Rms8sdRXtMulKJEFK6bsMJRUQME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andrew.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=andrew.cmu.edu header.i=@andrew.cmu.edu header.b=Z1Utt1a5; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andrew.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-326bb1d3e34so43016901fa.3
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrew.cmu.edu; s=google-2021; t=1747071850; x=1747676650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YDxNpw4qVAHD26tWYX1P7IPbtKx1OUnwZz8ULeCaaUY=;
        b=Z1Utt1a5GajP9VXvBzrpxD9EBbNdFCZEjXVuyCCTHvW1VjXaTFwdz5DCM0ASqm2rJX
         ptZzG1A4AbnF+Xk2bjgNip9EccroLM6Kg/fi7Jk1aHJofJcZu5iCxnXz+Zq5MuU68LfQ
         y5VYOVsGYSN6se+84FMziDrZ8USGexzfXwU0WuIwtrEn/Ua87WWm1NrqLqN4e1puQUwF
         gnGYoSYuNfDDRsgzJWcs5hi8bLIC30ugro3JT858bgeXYe3GnQZpAZ3dBukH2MYoIxoO
         0EeEtSBJVWZmOo0007nx/KesszcV3GgqAWSuPSFXLuqjYyO9MvrY96WyssnW4qQJqTA1
         VJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747071850; x=1747676650;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDxNpw4qVAHD26tWYX1P7IPbtKx1OUnwZz8ULeCaaUY=;
        b=JaBG67u+kncHblM+mIpUiSh8gV1xL122kuVoylYJnNR9w27YN4dLemCoWtd7VrXpn7
         25zgN61GXJ6BU20YTPHtZdBF6QLTCPTh6146D3NxqCgk+EkJTivvuDJI34VVD7ZfHgzW
         6yJLx3Jdhx/yG+0CRqy/qr5yhX1urEvxYZbea5PZaQNVQJqbHDLnGy1OxEpl1iBzJe7j
         2iTpwcNU6HxbwGxyFq7SxiuPaMu5/m4itPQJZN1De9qSgmDqCDXU4j/XByHsJnoTwqDk
         D01p0xYEaSfSakMCpjFT1HkPNONPxVTgsZIH3DCfy/nDu9fUZFNjP8tav2yd2QX6rnDy
         Bk2w==
X-Gm-Message-State: AOJu0YyBtfuZ35RPgMkgMUlUjpQAStWjlpSsQPoU8tTbGz2fLmkJY5CM
	Gb3fWPfOd05HffBBdW9oHaEFYUuZrxLqiP+qkqk0CTXaUul78gyOEVmUQJsDr3oA8TAtAcDTvVl
	l/HHDmqc9/z6lyRB/z3v+C3qgv37FkAEvd1fZ0kEyAbN1tKBMgQ==
X-Gm-Gg: ASbGnctvSzJwWyNrQuYTgAtnN5arlmfFtFn/kun1s20WqjfG/9F4X4XubuNEgloiIT5
	Bxo+KhiNnvLSiIQqFdSuMOiDHVJnDwN/+jlmdt2vuSDhFmNKDqh6/YCBs90L976JlKl+OmWKVvK
	j8gK/wMwu3tOg9/sPa5XK5CRIlnuVJpA9r
X-Google-Smtp-Source: AGHT+IFYWg1Ba6c5Rq+j2lHq7BBtD60EA0zxPTrfErMfAPUfwtUkUo5X8CWKIp3/8MwjamyDSnQ/iK3whFoEccL5CWQ=
X-Received: by 2002:a05:651c:221b:b0:30b:d0d5:1fc6 with SMTP id
 38308e7fff4ca-326c45f48damr56929961fa.23.1747071850340; Mon, 12 May 2025
 10:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anup Agarwal <anupa@andrew.cmu.edu>
Date: Mon, 12 May 2025 13:43:34 -0400
X-Gm-Features: AX0GCFtyvxMY3rcHRBhWd1ihEGWIWwgGjhMfeBhADKQ8JpQBZfnqQDLbbgdkop0
Message-ID: <CAFYr1XPb=J0qeGt0Tco1z7QURmBH8TiWP0=uH0zhU=wCQKCtpA@mail.gmail.com>
Subject: Potential bug in Linux TCP vegas implementation
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Neal,

I am reaching out to you since you are listed as a point of contact
for Linux TCP (https://docs.kernel.org/process/maintainers.html) and
http://neal.nu/uw/linux-vegas/ seems to indicate that you also wrote
the initial Vegas implementation in Linux kernel.

I believe this commit
https://github.com/torvalds/linux/commit/8d3a564da34e5844aca4f991b73f8ca512246b23
introduced a bug in Vegas implementation.

Before this commit, the implementation compares "diff = cwnd * (RTT -
baseRTT) / RTT" with alpha_pkts. However, after this commit, diff is
changed to "diff = cwnd * (RTT - baseRTT) / baseRTT". This small
change in denominator potentially changes Vegas's steady-state
performance properties.

Specifically, before the commit, Vegas's steady-state rate is "rate =
alpha_pkts / delay", by substituting rate = cwnd/RTT and delay = RTT -
baseRTT in the equation "diff = alpha_pkts" (i.e., when flows do not
have incentive to change cwnd). After the commit, we get "rate =
alpha_pkts/delay * baseRTT/RTT". When baseRTT is small this is close
to "rate = alpha_pkts / delay^2".

"rate = alpha_pkts / delay" is the key to ensuring weighted
proportional fairness which Vegas has been analyzed to ensure (e.g.,
in https://www.cs.princeton.edu/techreports/2000/628.pdf or
https://link.springer.com/book/10.1007/978-0-8176-8216-3).
"rate = alpha_pkts/delay^2" would not give proportional fairness. For
instance on a parking lot topology, proportional fairness corresponds
to a throughput ratio of O(hops), whereas the delay^2 relation gives a
throughput ratio of O(hops^2) (derived in
https://arxiv.org/abs/2504.18786).

In practice, this issue or fixing it is perhaps not as important
because of the 3 reasons below. However, since this seems to be a
clear algebraic manipulation mistake in the commit and is an easy fix,
the issue can perhaps be fixed nonetheless. Please let me know in case
I missed something and this was instead an intentional change.

(R1) Few people (outside of perhaps congestion control evaluation) use Vegas.
(R2) To trigger this issue, one needs both low baseRTT and low
capacity (to ensure delay is large enough to matter (see R3 below)).
This implies low BDP networks at which point cwnd clamps may kick in.
Alternatively, large alpha_pkts value could trigger the issue instead
of low capacity.
(R3) In my empirical tests, I start seeing issues due to RTprop
(baseRTT) misestimation long before this issue.

Best,
Anup

