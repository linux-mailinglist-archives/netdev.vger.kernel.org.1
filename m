Return-Path: <netdev+bounces-93730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5358BCFC9
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27233288535
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EBA13C3DE;
	Mon,  6 May 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Njx4EA39"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804F13C3D6
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004729; cv=none; b=I3vpW+0XcMCV+h8G4hAmCr5oqB/3egR4pWr6ZyzLWCT4oXkHGfKJOz4a6lx3lAWYx2LdYTaA3LtFUDBVX3K72yxFjgGrEMaJCQgmmeRhZkTADlai7x/LKEJ82JVg3dFOgyg1KUIip1ROnFHGy88AuI+QAecpO+iVjY72MpyBcU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004729; c=relaxed/simple;
	bh=ThLfe4up5kK6vDGqsyUeVI6Q46LMoQLl5Y50PLa53uY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZT6s/VXQ/HV7nzQ/YmHOZcoENF3U8LFXE6xr84MqxY65PItp8uYQ/AnF6v3fYE868ww67DSEErxYAkVnenrUh3UJjuVK7oGpmAiU2zrDXnhJf47ZjFtSSQNFHEhZq6aH5bD0807kc8bRqRUvLCYuE+9Sm1nO3UCwCoU/W9P4EQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Njx4EA39; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715004727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8RNjOYzfjfWWOz+mVPO4NC1Z3oW0pU1HAk6sk3HjlxM=;
	b=Njx4EA39/Warygfz4Cg2jEXktTe0tV5Y6hCZdBBJbUmYRhgYBjZ35WopyC7dOQXEAkoUiR
	qebRZcwDxE5JremX7TbgyA3tR76Cld874UETXSC2ZjctBrSnHySzVL4cnK+AUWUn8d5upu
	Dtx8Mr6inU7PBOyGW2Qj3euI1cI8c4Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-p_WNSc1MP1yviPsBN8kkEA-1; Mon, 06 May 2024 10:12:04 -0400
X-MC-Unique: p_WNSc1MP1yviPsBN8kkEA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e096468605so3044601fa.3
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 07:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715004723; x=1715609523;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RNjOYzfjfWWOz+mVPO4NC1Z3oW0pU1HAk6sk3HjlxM=;
        b=tRG53UDCVJmRmPhQk8V/Fnael34rJi9YJFFe5acO2VP6G2nDXPqHWUmxVlHJa50EmJ
         R9BVxZoMaTvhyjY3SrOGEETte9QTkTVr0g+3o4YFUiNwlBawWdmpsYKtIOF0vpG7Fga+
         RxT7PkRfI4ZMwxYJxYoXFQnPdY3pE/f24GzEZJH9bipoIq7ZhnbN0gP8qPJbjfoMwi9W
         kaVIXDNfYBG8hnXKdoUQeRrWSrDnk422Sizgl+apBv5ryhgaYPnmTkV1Rky9a4rDw9pw
         emy9RT4ytGgUxWsiIKm4snf9gvavvMxqtFvs4FsI5ImNJzf+dtxsDi3j/GU6oGdNyYng
         nnZw==
X-Forwarded-Encrypted: i=1; AJvYcCX2PONzs7l0yymr/oejf+/4mDWQxxl2ef5vw0I51TSN2wKJKD1eRVBzkKiAl7vmJ7SesrSuEF124ZoAhVBiczBrLokwo8+K
X-Gm-Message-State: AOJu0YyV8qKMh4Mukrl3WMhMDB31aUwwoZFy9wKNLWy0scoZd89CeNpr
	lD83Jx1tRiSf8TM1DbRsir5V5L+aQYEjzb0zY8eI0jdTEdZk5Jm9suUPNk1Bk86L55oW1BnTTlx
	EEjXHH2qMRLS1GItZ+Lf/25uZkaCN3/vFVZfSFqVA8eFTI7eKDGNWzQ==
X-Received: by 2002:a05:6512:32ac:b0:51f:103b:532b with SMTP id q12-20020a05651232ac00b0051f103b532bmr7337902lfe.3.1715004722635;
        Mon, 06 May 2024 07:12:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeoNToCgncyDftzKe8oWrj3Ws5vhejXzs2cdSxUWcQa2XN5wabpmRpfnbeYPWVj/hFuX6/Tg==
X-Received: by 2002:a05:6512:32ac:b0:51f:103b:532b with SMTP id q12-20020a05651232ac00b0051f103b532bmr7337871lfe.3.1715004722105;
        Mon, 06 May 2024 07:12:02 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b09b:b810::f71])
        by smtp.gmail.com with ESMTPSA id bd23-20020a05600c1f1700b0041bfb176a87sm20016866wmb.27.2024.05.06.07.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:12:01 -0700 (PDT)
Message-ID: <7d46b465dd986bdf07330a7ed8d466674dec4859.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 00/15] locking: Introduce nested-BH locking.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>
Date: Mon, 06 May 2024 16:12:00 +0200
In-Reply-To: <20240506093828.OLP2KzcG@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
	 <0d2eca9e80ae644583248a9e4a4bdee94999a8f8.camel@redhat.com>
	 <20240506093828.OLP2KzcG@linutronix.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-06 at 11:38 +0200, Sebastian Andrzej Siewior wrote:
> On 2024-05-06 10:43:49 [+0200], Paolo Abeni wrote:
> > On Fri, 2024-05-03 at 20:25 +0200, Sebastian Andrzej Siewior wrote:
> > > Disabling bottoms halves acts as per-CPU BKL. On PREEMPT_RT code with=
in
> > > local_bh_disable() section remains preemtible. As a result high prior
> > > tasks (or threaded interrupts) will be blocked by lower-prio task (or
> > > threaded interrupts) which are long running which includes softirq
> > > sections.
> > >=20
> > > The proposed way out is to introduce explicit per-CPU locks for
> > > resources which are protected by local_bh_disable() and use those onl=
y
> > > on PREEMPT_RT so there is no additional overhead for !PREEMPT_RT buil=
ds.
> >=20
> > Let me rephrase to check I understood the plan correctly.
> >=20
> > The idea is to pair 'bare' local_bh_{disable,enable} with local lock
> > and late make local_bh_{disable,enable} no ops (on RT).
> >=20
> > With 'bare' I mean not followed by a spin_lock() - which is enough to
> > ensure mutual exclusion vs BH on RT build - am I correct?
>=20
> I might have I misunderstood your rephrase. But to make it clear:
> > $ git grep -p local_lock\( kernel/softirq.c
> > kernel/softirq.c=3Dvoid __local_bh_disable_ip(unsigned long ip, unsigne=
d int cnt)
> > kernel/softirq.c:                       local_lock(&softirq_ctrl.lock);
>=20
> this is what I want to remove. This is upstream RT only (not RT queue
> only). !RT builds are not affected by this change.

I was trying to describe the places that need the additional
local_lock(), but I think we are on the same page WRT the overall
semantic.

> >=20
> > Note that some callers use local_bh_disable(), no additional lock, and
> > there is no specific struct to protect, but enforce explicit
> > serialization vs bh to a bunch of operation, e.g.  the
> > local_bh_disable() in inet_twsk_purge().
> >=20
> > I guess such call site should be handled, too?
>=20
> Yes but I didn't find much. inet_twsk_purge() is the first item from my
> list. On RT spin_lock() vs spin_lock_bh() is the first item from my
> list. On RT spin_lock() vs spin_lock_bh() usage does not deadlock and
> could be mixed.
>=20
> The only resources that can be protected by disabling BH are per-CPU
> resources. Either explicit defined (such as napi_alloc_cache) or
> implicit by other means of per-CPU usage such as a CPU-bound timer,
> worker, =E2=80=A6. Protecting global variables by disabling BH is broken =
on SMP
> (see the CAN gw example) so I am not too worried about those.
> Unless you are aware of a category I did not think of.

I think sometimes the stack could call local_bh_enable() after a while
WRT the paired spin lock release, to enforce some serialization - alike
what inet_twsk_purge() is doing - but I can't point to any specific
line on top of my head.

A possible side-effect you should/could observe in the final tree is
more pressure on the process scheduler, as something alike:

local_bh_disable()

<spinlock lock unlock>

<again spinlock lock unlock>

local_bh_enable()

could results in more invocation of the scheduler, right?=20

Cheers,

Paolo


