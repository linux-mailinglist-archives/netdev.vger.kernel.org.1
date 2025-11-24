Return-Path: <netdev+bounces-241279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09918C82387
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72139348E64
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDED82147E6;
	Mon, 24 Nov 2025 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmkZCgJU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C786323
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011056; cv=none; b=BRoaIJ1b4qhWQMcTHPXc9s3HqGMX0DUTqNsUd2rwmwUb7w+e5c4b8CHb8l6slXnOyknwcqUZW7cDiELFcUKSjONdsXXF8QUs20wRR76NcJPaKVC44zbvNDdHB6HN4s+cQz2VydI70F7reI0tjBKnd9TOFqgrZqRTmVa1FANJV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011056; c=relaxed/simple;
	bh=rPk5YhnJtj1LwWRsw80vqpyFs4AlAonluNVavjpDvV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1z75zb2xWHYZQz6gE1KRqQyGXiEoTNv+780UoXp/DWxRMx3UZ13BKuckiJOFMB6LLBUG3P9lbATb2+Xf/oFxo35StA/rojl+Gu9IkoioBlHysqBGcMbNHrYzeEah8NDq52AOZQ8DkHZR/ytMCjza3saM3fyWifC8zm8ElMYr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmkZCgJU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so4498502b3a.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 11:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764011054; x=1764615854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irTGZ9RmtnPtcWM6dZr/zMSPTv1ymgkdsQCVSK7soQs=;
        b=dmkZCgJUn4754BaMowLtE+XgWJl0bgGkCS9yW32JLeap5F2fHSKCV3O1bYpop0QwZs
         1f8bVwFwuZStJmImCmiKWFY34/t9UFX6K2LfZe7zFTAjd3Vd8vWhqRCD28bZpC43+fJQ
         B7YM3RJjAeezKJelrmhUlOZ9BHhV5xHBPnRfKgq9K+XpFP03lRayizfKiPlw2VW9skOf
         X1f1tPaIG5H6qyPlMpgag7vMcRZvzuxYCmKhhW40AWnJv9yTlUA9aennAOQtdgg3z+gi
         KtSXyJp/AkeAZUkAbU592oL1GGUz1Y6Q0Jxgi4+Q0luEKVfs+M0h2AN1IhhfCe3iEZ7S
         H98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764011054; x=1764615854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=irTGZ9RmtnPtcWM6dZr/zMSPTv1ymgkdsQCVSK7soQs=;
        b=HDl5RK/lTFDbDfGwSyOrQITdOKJKeoHEXzRSzaVqWl7413x5H8XAy4LXBhdPv7jiB+
         nN2FQvHleUPhmsknmvqXjT0+8aS4d+K3grXQ3nOpP9I/RNk8/SsLJbZPR2PgK+z9w61X
         OQi9RUUXPzb0fULosWx2abFU/HrTL90owb3EfATyzYdG5eSLDiXU1txfgrGEyJoXLC8w
         3fbi27IoixzOS3fn8eaxXuvSXTkCi+v4uCw9WCBBlaQU+nk/lKQ0vKWLqiUqCPjb5tr6
         Y/JLuotul0MYoQR4xhSvtn06LaarQ+e0EbwIy3p92O63tSL862qlC6wwzYuP/6Y6Ver8
         hOxg==
X-Gm-Message-State: AOJu0YxaHTmwhM2wJq8mnkaTodmy7Cco8IyjgiaA8LRVtFC7AY2qbbnk
	vKQBbvQj+bjvgjIg109pxglso9e5JOENKl+M7eAAS0Cqia3PGuw3y1nJYEkmnJeGnESdE09fr62
	3KL08F226GG3WNwq9tto2DA/aJx+ucXsPNe5Krd6K
X-Gm-Gg: ASbGncuhvudhM0Sax5ST9tom+0IDm+UoCnNVBRsepb6w19/sBCC9RZSYQr0KFsPb1Kk
	nFlzBnpbRdPmuJR00YCyHQJnyrNOLsa9XD5OO6rbKaDvZbjKZtn5e5CDNA81ekwrIH6/8UHU4HP
	4f9XPKQ56hZHZ0ZGlcpMv9Oo/7eCTK5d3p6ZRzD3LIMGgwU35mF+b4EgbVf1ce9fQ6WuRGrOXeY
	7WoRu9p5l/KgFgAMOlMoeQc6jpAFBFl5UQxegefNMpVHhb9ne8z3J7UU3wlHyQs862VE1TSLfGb
	+DGsWVnncm+gbqWP6j3wNkcweA==
X-Google-Smtp-Source: AGHT+IHhdILwZAF5B62Xet2Qh2IpUjHPStPxSuWfogRjVbXdvRKvZDrFder+I5eJeIMMENVbYGpONfgTOGuSdjoWNog=
X-Received: by 2002:a05:7022:f317:b0:119:e569:f620 with SMTP id
 a92af1059eb24-11c9d84a639mr4894091c88.25.1764011053412; Mon, 24 Nov 2025
 11:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124070722.1e828c53@kernel.org>
In-Reply-To: <20251124070722.1e828c53@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 24 Nov 2025 11:04:02 -0800
X-Gm-Features: AWmQ_bn7GqJ_-hz48urdwKwfbqNz_wdl4jXME_6fMmwZjA7PalAsmwqIiTbVF54
Message-ID: <CAAVpQUC85zujcLMFKFh_+FtvFWcuPLqJQm=Gv0-4HuXkZWjQwQ@mail.gmail.com>
Subject: Re: [TEST] so_peek_off flakes on new NIPA systems
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 7:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Hi Kuniyuki!
>
> We upgraded our system for NIPA recently to netdev foundation one
> (as you know). Looks like net/af_unix: so_peek_off is flaking
> on both debug and non-debug builds quite a lot with:
>
> # # so_peek_off.c:149:two_chunks_overlap_blocking:Expected -1 (-1) !=3D b=
ytes (-1)
> # # two_chunks_overlap_blocking: Test terminated by assertion
> # #          FAIL  so_peek_off.stream.two_chunks_overlap_blocking
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/399761/134=
-so-peek-off/stdout

Thanks for the heads-up!

At this point, a fork()ed child/client is expected to send() data after
1ms while the parent/receiver process blocks at recv() up to 3ms, but
it seems recv() got -1 because fork()ed process was not scheduled
fast enough ?

Probably 3ms is too short when the host is overloaded.
I'll send a patch shortly with .gitignore updates.


>
> The newer system is 10-20% faster it's also moved from AWS Linux to
> Fedora. But I suspect the real reason is that our old system had
> quietly broken compilation of af_unix selftests
> because of Wflex-array-member-not-at-end which AWS Linux gcc doesn't
> understand:
>
> gcc: error: unrecognized command-line option =E2=80=98-Wflex-array-member=
-not-at-end=E2=80=99
> make: *** [../../lib.mk:222: /home/virtme/testing/wt-1/tools/testing/self=
tests/net/af_unix/diag_uid] Error 1

Oh well, maybe the package was gcc (11) instead of gcc14 ?
IIRC, Amazon Linux 2023 provides the newer one as a
namespaced package.

>
> So effectively we're been running some old copy of af_unix tests since
> this flag was added.

Yeah, apparently I no longer run tests on AL :p

and this is not a problem now on Fedora, right ?

