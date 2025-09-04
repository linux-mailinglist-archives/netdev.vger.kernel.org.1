Return-Path: <netdev+bounces-220005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0E7B442CC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD9737A3846
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FB9230BFD;
	Thu,  4 Sep 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyDC5mFU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AB2367D5
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003561; cv=none; b=cJ6gb91S6G6Y6hhj6OsqYSsCDFIqCQ13euzfX68dVEkHuAesJnTmhSH5bcBCjEst9qaUNuZ5bPAvWi5A7LnY0jKcHpTLVIuUowFD7na9WbnZexlQi8l1elURQe4RUJ3vPUablaRD3iMHrNykE2XfpNuFZfGy72BsMxbR582SYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003561; c=relaxed/simple;
	bh=BvROoAfWNQZYt8G5mPhouMAjqjIj4gbb1TW+dEw2vf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1As53kiLOvzLGYJFuukTB3saO4erCwxHkIMlLYuOhbPOdWAG2w0mZUva4RwsL2rK2aSA+F0vLd7Ph68fgCnZ6NLEH1EW/qp7YlBHzjpCPgg1i2ikZLEIL6UleREPUQAqmFm4k/m7+NkHSPETposbJp6IZMwl2FwMF4Gbxyke+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cyDC5mFU; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e970acf352fso1308756276.2
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757003559; x=1757608359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/crohoCGv1mndICz85vpLaxv48KbceC+BaykPdI2Sik=;
        b=cyDC5mFUFULCQxuOvbc5BZpIi21jCrUROM2hl/ZqRZt+OpaABj0JtQltIYEauJp3mu
         kPVkhzWZAkH6DgIazrv4USkxtD8XFjs/Ey+FPW2KsNBy+9d/DKNDNHrJ4m2bFo/f4mfQ
         eI1H2Bp3GnJqKYhUx+fZLukfMRms3LR8YB6c5QF5CvMCQR662EgQmSgaZagDkh4nk8ZS
         /n9RZemUl2CTAf142MWd59vc2qlRCRWml2r0OCXmpa7igP7BO6KRBXSstQk+nyi3MK5o
         DLmNa/nwj6iLJyoWt00PCrX/m2irRVbhjK3LybLRREZKaDzwRdayEaoeQ3oRkWo1Pp3P
         1fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003559; x=1757608359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/crohoCGv1mndICz85vpLaxv48KbceC+BaykPdI2Sik=;
        b=otd93XpSS4iBgoj3VHQrRbIXn3Pvfc/bV/NhMNKBLMR8LfIGTwtK+RhYKg66ltYiVV
         nzUrNHzGN4xR9Ta2AbFEALqTUnpB1Mg18l2TVK1Oak8dmONOYiDB8oTI7NTKxASgHAbT
         FVxgBmp7m8lpv5pfhzrbWBmYqAma8Z1XxG9ItFTnASMnlvJROw4QSrfkMeSJ/iCebGXQ
         m3jmvvHbESq8Yh4qZYfl7/PJ/s356m0u/KWIBGl4MH1Tw3nouflqRjbk8RptDugqxwp/
         ArPJsQe26KY2bsv/rVuf76PrJ7ZQfrVpYGq1iRTEfHNnRIm2AF+3R8kIP2iqzOqDifun
         QVeA==
X-Forwarded-Encrypted: i=1; AJvYcCW15bq9LA5hFAdnU92q8gF5mZko1uPGl+EigqThS5pQChZjj7SCCpX4N86yGVFbjQbGLC/3SUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPDQi+LY7cMJjcHxPIjmVQdllHqV0QNPV7ONQYkpO6N5Lc30N
	zaCRUi+wNZSguX1+JJZ1XhE4xd186RxeHhTrhhOOlrWesnFtns1M2p0ccLIUBtt1p1M02lyKUl+
	mUaHxJmbjzYMdDd8aoyj6oSCeorUATX9CR0EOBQZs
X-Gm-Gg: ASbGncvMTmriKJvIY0tOxdLSfvs8Ogx+0R1wX3FTuk8xc66OouJtFyUogMfgtFN6i7q
	fbPqS4p3WvMIhVtNANnstaxkkZH/7F53CoX2m9jANZIKUFn4oCvbOVb9kKmXLB4iqE6yJXdmw87
	whTfoUQUSi4MnSkJUydrPWIKbJre0wTdkgdbRNXC7SaY+Kc1d2vfwP5/v+QGt48+qD9Et7En+Em
	g1qDerRx1uSWkeRA2a2eP2ZiMb0ItXlDxoMG9RPRBPLgulAO6hAFKRObNh/XDfDZvG3
X-Google-Smtp-Source: AGHT+IFFIWQL/9vpK56G1aiVtW3XTTs76JduzccxIcho+hapHj3emrN7hctanqku3GSOXsxn6DkC7hrqGRk7gFMsTRE=
X-Received: by 2002:a05:6902:4a02:b0:e96:f92d:b7ce with SMTP id
 3f1490d57ef6-e98a5787dfcmr20493546276.19.1757003558654; Thu, 04 Sep 2025
 09:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904132554.2891227-1-edumazet@google.com> <20250904092432.113c4940@kernel.org>
In-Reply-To: <20250904092432.113c4940@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Sep 2025 09:32:26 -0700
X-Gm-Features: Ac12FXzya6bjmyujK7KWRkbaAmfIuEuxCq63r0GWDG3Iz6CI5ByHlWOonnVgeBw
Message-ID: <CANn89iKpty_j6C5_Fpt1NZhr1fhaMeRHsb2+9MM_0aPh9dCHjQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] ipv6: snmp: avoid performance issue with RATELIMITHOST
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  4 Sep 2025 13:25:50 +0000 Eric Dumazet wrote:
> > Addition of ICMP6_MIB_RATELIMITHOST in commit d0941130c9351
> > ("icmp: Add counters for rate limits") introduced a performance
> > drop in case of DOS (like receiving UDP packets
> > to closed ports).
> >
> > Per netns ICMP6_MIB_RATELIMITHOST tracking uses per-cpu
> > storage and is enough, we do not need per-device and slow tracking
> > for this metric.
>
> CI says:

Oh right I forgot the snmp_get_cpu_field64_batch() call.

I will send a V2 tomorrow.

Thank you

