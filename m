Return-Path: <netdev+bounces-218095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92041B3B14F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F527B4257
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3541F0E2E;
	Fri, 29 Aug 2025 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="b/3CNK/9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55901EF39F
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436650; cv=none; b=FRnfrQ7F6vp27N3i6Z2fpwtDxIUE48WSBLu7b6GsiBAQcRDmkXKQNeBP7Dsl6t2zSw44LHWCVLvZvMDzi3lizcmYAy8pp9NsbHp0Y9sBuX6CvB7F1TyBzwmT2i0ZiRMBWfo7jVutncncUY3FNHzK0iZVQW4qBcGoHCEtUksvcGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436650; c=relaxed/simple;
	bh=+j8uQkZRU/15mrWUk5SNBRC9DmIhvTlLuPUcBVQW5Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQKm0WITYAddvZa/1Ibhm4jXxY0ikerwZ+juYCzovE0WX7Ba1/a4jAs3go/r8sulVZoIqMMWq/1qD61y4OzyeQ+BubLhJDzuSoEsLPmdgaFTnjuyZlJp5Ztk8hwQiGrTMxzREraISwPgQE6jgT9pj5eVhxDlhNIRicNYbcGweM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=b/3CNK/9; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+j8uQkZRU/15mrWUk5SNBRC9DmIhvTlLuPUcBVQW5Ms=; t=1756436648; x=1757300648; 
	b=b/3CNK/9204ZdhYlWUy3IrgqvHBixbAYHm4f8xMzCxQeScoCWt5slnHeueD7ftHQ/8c7oQ+hp9D
	1k/m2Fxf9F2sIB7zSoXHRltec59TAJN8gla40tzdt0GyUq+cQtOYPlGpCMTLvYQQr098ujjUtArdP
	CQ3ioQcvIVuz5GmSuX0lwyZzjViyP5ieMEtMFBWQTmyPvbfh/e6tv7+nUupOenKKKpEpcflDXiDr9
	zflkgGDX5tEnXCBsLGDffc2XMZeEpj1cD+QVhS3SoUZRVN7hznyuFXvd2wnYpO6cMlh0AjpdqVjGx
	fs7iricBgljsHVzssNlfsbHmaS4XIv9oI7OQ==;
Received: from mail-oi1-f176.google.com ([209.85.167.176]:56796)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1urpPG-0004EA-3R
	for netdev@vger.kernel.org; Thu, 28 Aug 2025 20:04:02 -0700
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-435de70ed23so91115b6e.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 20:04:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YymdIlmxEpTokFc+Dn8z8Sc/edSGAViRgDes7dJYEJfHbz982vG
	IlTj97Zr4xMSmDxSJTkNRD0CmwZ56JDslwZh7DMNOZ6k+wJcihf7nBPURmqXDmz8eURSBO/kWjx
	EluxfRmDn24WVB1P7OKbPiqhaqmHdb2g=
X-Google-Smtp-Source: AGHT+IG9LM3Eplrqa2dKwXYWJYpUdHxJ8iw2m0//m0/jkqk8nU1xsrBVPGsBMwi11Np6SRiLJph3XZlsPEdwcGDfPVk=
X-Received: by 2002:a05:6808:218d:b0:437:e23b:e705 with SMTP id
 5614622812f47-437e23be75bmr1447641b6e.46.1756436641445; Thu, 28 Aug 2025
 20:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-4-ouster@cs.stanford.edu>
 <ce4f62a8-1114-47b9-af08-51656e08c2b5@redhat.com> <CAGXJAmzwk87WCjxrxQbTn3bM8nemKcnzHzOeFTBJiKWABRf+Nw@mail.gmail.com>
 <6d99c24c-a327-471b-964f-cfe02aef7ce2@redhat.com>
In-Reply-To: <6d99c24c-a327-471b-964f-cfe02aef7ce2@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 28 Aug 2025 20:03:25 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzpibzh+4FvM4mcvkXeT8f0AhMK00eqie7J8NEU9Z9xWg@mail.gmail.com>
X-Gm-Features: Ac12FXzepwSf8eUDlCH4_Ff0O-lPKk9qrsbYTh2525kLRFObC_tZXuEl9XWIocI
Message-ID: <CAGXJAmzpibzh+4FvM4mcvkXeT8f0AhMK00eqie7J8NEU9Z9xWg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/15] net: homa: create shared Homa header files
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 078eb853d78558c6c655f7b6c94b391a

On Wed, Aug 27, 2025 at 12:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:

> The TSC raw value depends on the current CPU.

This is incorrect. There were problems in the first multi-core Intel
chips in the early 2000s, but they were fixed before I began using TSC
in 2010. The TSC counter is synchronized across cores and increments
at a constant rate independent of core frequency and power state.

You didn't answer my question about which time source I should use,
but after poking around a bit it looks like ktime_get_ns is the best
option? Please let me know if there are any problems with using this.
Interestingly, ktime_get_ns actually uses TSC (RDTSCP) on Intel
platforms. ktime_get_ns takes about 14 ns per call, vs. about 8 ns for
get_cycles. I have measured Homa performance using ktime_get_ns, and
this adds about .04 core to Homa's total core utilization when driving
a 25 Gbps link at 80% utilization bidirectional. I expect the overhead
to scale with network bandwidth, so I would expect the overhead to be
0.16 core at 100 Gbps. I consider this overhead to be significant, but
I have modified homa_clock to use ktime_get_ns in the upstreamed
version.

> > If not, I would prefer to retain
> > the use of TSC until someone can identify a real problem. Note that
> > the choice of clock is now well encapsulated, so if a change should
> > become necessary it will be very easy to make.
>
> AFAICS, in the current revision there are several points that could
> cause much greater latency - i.e. the long loops under BH lock with no
> reschedule. I'm surprised they don't show as ms-latency bottle-necks
> under stress test.

If you see "long loops under BH lock with no reschedule" please let me
know and I will try to fix them. My goal is to avoid such things, but
I may have missed something.

-John-

