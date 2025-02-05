Return-Path: <netdev+bounces-163299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8157A29DB9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E327118876A7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5379D21A928;
	Wed,  5 Feb 2025 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="vTfZw+H9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EF618A6BA
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738799841; cv=none; b=heJNZo//jz3SBPoaN0Y4q/m5535W5ISJoeGY+97sxNP+wwK0VseaqA3J+opPvvgVQRN2oVukP0ugMVbaUF3MZ6fF5XIGt/s5G4rI1X85n1lorQwLjWbFXo+JUsQDHUHoPZK0i3FBtTcnhwv9FymGAejv81jPnlGoLBcZZY/Twj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738799841; c=relaxed/simple;
	bh=9VFT+9vBuiK8LSZcNPInEiaEcp9z6caDPIiH7ymsxRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/vELrEHgg2wDUfpUCcJUzD35reBfdrWMgrJDslLuIRfrS1MyS2UxrIcM78yk6WOcRagTHGh2/FINGZGcPxcWVw+N8JBFXKUW/d2o7s4q6qmGgrtR+/D8WgzU3xJ9B4LDN9LfiOpsZLGp1GJ0n9BjmL+vyhM8I4N6HsSITZolFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=vTfZw+H9; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gTGgjEMkWArr6fmdr0OsM990M02NUJRjXuhcs8HIK6Q=; t=1738799839; x=1739663839; 
	b=vTfZw+H9HxtturUEqOna/ty3uXWeNS1gkGw3z0Hrwk1f/uv8nidpaqPN3g+qEpaNPQPEovMo2fS
	/cBKlf1ZRuN76k0ajOu0bSk8nz+5kvSxvHFs1eqgfmIfz5C4geDRQkMVyxH3siEg8HM2rExPr6q11
	beTyJhUGv0oiSXQj5a5hRKs6Kc99MOQ74KgpDevCEsY4yf9H+CFs2atB/X8bgZEAg12CrBeNACgbj
	KE8eg6vm24gvBXxJW+lUF+BY9v/NbfnX/+1TQhVgTA7zeavBE9m1NTlXB7zCdrZql3EhCFLKx/p0A
	MwsqTQQORBKl/TY1VcKs8/q6z7ploo3LioIQ==;
Received: from mail-oo1-f51.google.com ([209.85.161.51]:47293)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tfpGa-0001UW-UZ
	for netdev@vger.kernel.org; Wed, 05 Feb 2025 15:57:13 -0800
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f31d3b4f8cso91892eaf.2
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 15:57:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXe/6KqzrYtZeQqa8ZRou56+nGt8+RdeoZgy26rSRAA8Y9tVhna7Am9DxADiytmSW5aSXFGLcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsL+1JW83665lXY+BvpoNT+UD5EDdsf4B/M6TsQN+wCIlRlXM
	jIgNZLgI8StsIZ+vCMLK3M0iSTiwqJZOUazkaipfm3z35BRJ0ETRXmpmo6/CwOKjomf/PZ5DDU7
	SOyImJIGP8sVftEy+iYQazFcXOYE=
X-Google-Smtp-Source: AGHT+IGfVmW7ySQaGkMePXTbpDhYzIj40Vgpk1oEzcR/Z7SzXcfeKAtc0ae+98K+yp8ntX1tv4yvy+pSzponApC/ltY=
X-Received: by 2002:a05:6870:6120:b0:296:df26:8a6e with SMTP id
 586e51a60fabf-2b8051a3113mr3562133fac.35.1738799832329; Wed, 05 Feb 2025
 15:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-9-ouster@cs.stanford.edu>
 <9083adf9-4e3f-47d9-8a79-d8fb052f99b5@redhat.com> <CAGXJAmxWOmPi-khSUugzOOjMSgVpWnn7QZ28jORK4sL9=vrA9A@mail.gmail.com>
 <82cdba95-83cb-4902-bb2a-a2ab880797a8@redhat.com> <CAGXJAmxLqnjnWr8sjooJRRyQ2-5BqPCQL8gnn0gzYoZ0MMoBSw@mail.gmail.com>
 <e7cdcca6-d0b2-4b59-a2ef-17834a8ffca3@redhat.com> <CAGXJAmx7ojpBmR7RiKm3umZ7QDaA8r-hgBTnxay11UCv42xWdA@mail.gmail.com>
 <9a3a38c2-3752-4ad2-a473-4d8f47ce7bc6@lunn.ch>
In-Reply-To: <9a3a38c2-3752-4ad2-a473-4d8f47ce7bc6@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 5 Feb 2025 15:56:36 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzD7AR7vf54CVGHnRqwJnJFpO_aEQ5s8w-OdXjw0c8FKg@mail.gmail.com>
X-Gm-Features: AWEUYZlmC8OGtLR3Kf55MA6_DOg8v8AWQyGVshJ6uiGfvsvlykylhX3V6ewIIJw
Message-ID: <CAGXJAmzD7AR7vf54CVGHnRqwJnJFpO_aEQ5s8w-OdXjw0c8FKg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 3.2
X-Spam-Level: ***
X-Scan-Signature: 1620fcb02ed1792cf65161168a9fe1e9

On Mon, Feb 3, 2025 at 9:58=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > If that happens then it could grab the lock instead of the desired
> > > > application, which would defeat the performance optimization and de=
lay the
> > > > application a bit. This would be no worse than if the APP_NEEDS_LOC=
K
> > > > mechanism were not present.
> > >
> > > Then I suggest using plain unlock/lock() with no additional spinning =
in
> > > between.
> >
> > My concern here is that the unlock/lock sequence will happen so fast
> > that the other thread never actually has a chance to get the lock. I
> > will do some measurements to see what actually happens; if lock
> > ownership is successfully transferred in the common case without a
> > spin, then I'll remove it.
>
> https://docs.kernel.org/locking/mutex-design.html
>
> If there is a thread waiting for the lock, it will spin for a while
> trying to acquire it. The document also mentions that when there are
> multiple waiters, the algorithm tries to be fair. So if there is a
> fast unlock/lock, it should act fairly with the other waiter.

The link above refers to mutexes, whereas the code in question uses spinloc=
ks.

I spent some time today doing measurements, and here's what I found.

* Without the call to homa_spin the handoff fails 20-25% of the time
(i.e., the releasing thread reacquires the lock before the "needy"
thread can get it).

* With the call to homa_spin the handoff fails 0.3-1% of the time.
This happens because of delays in the needy thread, typically an
interrupt that keeps it from retrying the lock quickly. This surprised
me as I thought that interrupts  were disabled by spinlocks, but I
definitely see the interrupts happening; maybe only *some* interrupts
(softirqs?) are disabled by spinlocks?

* I tried varying the length of the spin to see how that affects the
handoff failure rate. In case you're curious:

200ns             0.3-1.0%
100ns             0.4-1.0%
50ns              0.4-1.6%
20ns              1.3-3.9%
10ns              3.3-6.4%

* Note: the call to homa_spin is "free" in cases where the lock is
successfully handed off, since the thread that calls homa_spin will
attempt to reacquire the spinlock, and the lock won't become free
again until well after homa_spin has returned (without the call to
homa_spin the thread just spends more time spinning for the lock). It
only adds overhead in the (rare) case of a handoff failure.

* Interestingly, the lock transfer seems to happen a bit faster with
the homa_spin call than without it. I measured transfer times (time
from when one thread releases the lock until the other thread acquires
it) of 205-225 ns with the call to homa_spin, and 220-250 ns without
the call to homa_spin. This improvement in the common case where the
transfer succeeds more than compensates for the 100ns of wasted time
when the transfer fails.

Based on all of this, I'm going to keep the call to homa_spin but
reduce the spin time to 100ns (I want to leave some leeway in case
there is variation between architectures in how long it takes the
needy thread to grab the lock). I have fleshed out the comment next to
the code to provide more information about the benefits and to make it
clear that the benefits have been measured, not just hypothesized.

-John-

