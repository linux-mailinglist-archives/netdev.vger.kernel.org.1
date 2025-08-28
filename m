Return-Path: <netdev+bounces-217686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC31B398D9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 117967B2C61
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062222EE61A;
	Thu, 28 Aug 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="Y9C5JNPy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5A2ED17B
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374790; cv=none; b=SL2SA+/R+LSQoI4WpxFPyPJRqNtdtQ4RpsmLA6WneK4RVikPs0nv2oMJZpG/GwoVI8jiGRFoXQU3kJWL32GlyXcgqXJGDPwBcUexo8LgRMYroevvPnU5vEkd+cDV6uZKxKKsRLtRcjtVLEMG3WnaB5ujQtgOlUuL6OAG/bbGJRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374790; c=relaxed/simple;
	bh=CVa6GmAMluDPsP+Q998eJHpdv/J8OP2iwTb/vFH8cVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heRqx86/RHwOAYuJ6Z3eXfQ5EVCrMp3RJEy7sT5e8gNKaKX/hwEHBSlno6kZ4wS6mHUwG72H3H9aYgJTDTOaqlYA4GlRpElOnyXAI6vg6vE4OI/Lpze1hRG5Ecj57FMjC6n1PG0vQ7fLneOhtZBl/2G15+iAsC8FGXNWAApFkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=Y9C5JNPy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32783de3e87so810378a91.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1756374789; x=1756979589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVa6GmAMluDPsP+Q998eJHpdv/J8OP2iwTb/vFH8cVg=;
        b=Y9C5JNPysytbE40N6Vha+7S53QT2lmAH9vTLgJ4Jkw4kLBnHQ9nMDqVYVUDn5RiJJ4
         MIjWlFHo2Pe7oUsM29VOviL7wkh2GDidQZVJrxNHK+VdpTlqToySyvSTc4qqdtixfBGe
         6n2uI7gzvNc3gWauJTxnBSwYJixbm4ZmPpcTEYWeHj4FrBaSjqc3/gbNiiXA1Cgl5i3B
         LEPePhb9vZZg+6r0FoEz8cnRyi60Nny4quQrxUJaEBfP3syfYpbGk2lc0LEOGLHdFvpk
         psYSvgtjSBpn9gp0NjQvYw4X58stBs71O7O7gMsCv+zkfyFpPbk3zj5jrF2Tn0KTi9Ui
         gYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374789; x=1756979589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVa6GmAMluDPsP+Q998eJHpdv/J8OP2iwTb/vFH8cVg=;
        b=tVpGDm4chk45h2Wz7cYOLeiQ8RKiIBJi6KqHXpg5Km4ryFNx9wMOBkJVuUpWm9rDBW
         C8iWlOkXzu9HgtYlMGGEA9AP3ZVIoOE7SxBuU2LK36w41m0+hq0+f4mDAX4CZmfXbkk0
         FUw05e0BuO1KXD9Yt7dLG+MufNjHxyOdcf1mSs+03VXvB3QkqHdHOkjxFKvt2NQfJ5h4
         2mFgzC96RRTd7kGfvW+u6S7MPYdwRfyx+1U/rK5p2hDi3XvZFOZr1REj8030iVI+DfFP
         Ck1gq8oZeS1JUyJ4wkDJ/5kIHAbaS2uKYtkPvN0kX+XAqa2KW6geD7v30fgQZ/Lg42ez
         yIqg==
X-Forwarded-Encrypted: i=1; AJvYcCWy8Rfe+/WR88D15fFUVzGHk1bQI5XO6WKxUIpcCpss+ILwgLpxY4nQ46ApH3XOseN5sAT8VNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGM7NXpA/fSVQfl3A0ml3z1n68vIzWjgLn1rrmUSQSlR915RzU
	4VtFI4GlxuZrx8ufMj3ZvMgo+mRm5oJTB0EqHOGiSN8rtmJJkClpzMJIeoJGivzPSbOlY5ySIci
	+xm1GnPWh1xHN5KggWy8KM3kL/SKPLBpNJcYbzhY48Q==
X-Gm-Gg: ASbGncuyxf18YShaHHFnUUr56f5Ry9Z0J2pwvqkDk6b6W6p+6Path6aAOHA9gNg5iqj
	2PEYC4sSgjpDfP7+6/qBHYcd3Nfa4HgxmbdXFpPkq96P6PZWL22Y6INN387vWIM7X2IuIIMXQEK
	to5vCHTh4NxBRkzkDOy2RAOlCM6Vp4oEPY3E0DOd+EryDWSZk1lqk88K+Vsav2MyD9VIsi72B+k
	4dkJdBHyRnqZjLP5D40elXyBh3UwX/paw==
X-Google-Smtp-Source: AGHT+IFiPdVsknu0U0byAooRoHYi9Kg867zs/XmQado5OBM8B30B7VRf7vH1HN0s27q1gbRfKpCDHOffF2/n/I7g+k0=
X-Received: by 2002:a17:90b:380a:b0:321:335e:19cc with SMTP id
 98e67ed59e1d1-3275085e80dmr10678185a91.4.1756374788898; Thu, 28 Aug 2025
 02:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827140149.1001557-1-matt@readmodwrite.com> <CAADnVQKs0=iM_QoP9+SN6kG3iZ8hMwqeLWrQ5S3TvBbW4dgk3g@mail.gmail.com>
In-Reply-To: <CAADnVQKs0=iM_QoP9+SN6kG3iZ8hMwqeLWrQ5S3TvBbW4dgk3g@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Thu, 28 Aug 2025 10:52:57 +0100
X-Gm-Features: Ac12FXwXov8EhZrXIVQ2GFdBqP51A06NQPbDibzT34Dfary9rb9a1p7gB-p2qOQ
Message-ID: <CAENh_SQJ4xt0rSimsHXTNDJaEqWV2P7wgh1g-bXB7iE3hHt99Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Add LPM trie microbenchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 27, 2025 at 7:02=E2=80=AFAM Matt Fleming <matt@readmodwrite.c=
om> wrote:
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/lpm_trie_map.c
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>
> I fixed the tag while applying, since it should be //
> also dropped or-later to match .h and the rest.
> I believe that's what you meant.

Yeah that's what I meant. Thanks for fixing this.

