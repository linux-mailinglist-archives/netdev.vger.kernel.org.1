Return-Path: <netdev+bounces-159901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CAFA17597
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 02:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BB418893A0
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3751219E0;
	Tue, 21 Jan 2025 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gku4jSlZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E22581;
	Tue, 21 Jan 2025 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422173; cv=none; b=nABeylFGrLsc81koVI7UcuCSw2QW+dL46p0Kh1MQ4rqcW5l1mfFPFClIo9CwBSXQZffWR29mfvQwbnKSVlWLT6MW14sikRfaSa8RDG2gpAl4XhksBlnKSwLLaM8uAk/9iE6rdqjn0OvTfYOP/0hoRmBDLX924mF/KUPcQrVkxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422173; c=relaxed/simple;
	bh=jGbgE76AT36z69skjXf/jXVQZgWZyTJT1fcneGSG91I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePji5gEehBzDm9HNKVQHB9qF3jhq3tmezkRHllh8THJ/rDOw8zH2Md83qXSxQNe0W5IJgIC2MW1x8s1+M9eAx2J0L6bQXeaG6HtpQd3IypVq6TtiLmeH49dxgDt0U+3/ubDG4EKSjHAZiJsG0wzzHyjT7KIh/0QtiMXrtzHHHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gku4jSlZ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce6b289e43so47735865ab.3;
        Mon, 20 Jan 2025 17:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737422171; x=1738026971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXs936r+LXqZsbsTHRNBZU6iqOQzXWeC+RhcvNCK3jw=;
        b=Gku4jSlZx3jN4i5fu2Ac084eFwBfVZ+K22aTk0hECSvj9Gg66gp0a9cPIvUmiH89/+
         V/u1imAkU/OjFgmnh2KndjD0j0D4hAk5/N0HPBg+HzFQBCyrQWnrPAcf8LWLrcnbRFEJ
         Xlj7v0bKawTk5O8CSSjj0r+LdI/wQ2uRWxYHQD1IN51l9KO5ItaJZuUp6MmcKuqltqj+
         1zf3YV9jTWHeMKSQ9Z+G4TCY/k5GVnxPIskczV66ZZ97T8RHzXManF1XE++dYUj++EUA
         3dwcHWzMvq7FAFBFuUJILU3bE7NBVqVg/VVrksFbNVVukluZoPs/rtZnk4aymsx8dSb0
         hx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422171; x=1738026971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXs936r+LXqZsbsTHRNBZU6iqOQzXWeC+RhcvNCK3jw=;
        b=oIGcUFU+/dBocO/eb7nketDXPHvyMlb3o6STRac1jhAR+4YxlWWUIoDpFO/Tn2XqUX
         1sdmWLrPJJbjvQFYcn+rxgirqAecOuzmx8/3tGPDdcrUAYqa+1lsL51HsayIkL0Ve0Xp
         HmiVkWQORLjAfxLcNxmV/foz/E1PwnHVnIKm8WOx27frTqho0g3hJSYfB++Ab7GPACrh
         Sn35d9tBO4weIUuwUGBKmgBrbVpDeAP6+EB7bDZcGioFlqPQ/qpNtVOu3hWaH3YMkzus
         K9Fe7GuJpmSVEPdFhdijNxxEc+wTcKoVJpKq3weQJrplfyCNKIESs5hg5qFA6RMeqzn/
         +2xg==
X-Forwarded-Encrypted: i=1; AJvYcCUWCB+D9jLBoLkiDkFHI0g0Br0K1Oq9J44AuEVisFgnnDmpPG7ZyC3q0fXI4IBbhyg1+T5xg5KMy36jl1DVhATL4aIc@vger.kernel.org, AJvYcCVFUVruIYOuWQMZKCgSXQRFmF3RgWywcecMJECOUrrFuj7wot74i/S6Vlkg1f12fYmTDCTx234+@vger.kernel.org, AJvYcCWgU4UMEMFq2QlM/juIJsBoN48t07AGAKG9+wJFnsBlDhieM0Y4HaRvcLy1nDdlTvjqynMsfmbaFfTwVig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6+Ti7h6ROuWKwXPS6oeJQjI23mSrxk7w6F4DzJTlIfDURtch
	Di69GHQCmJloh6RbLCEBEX/nIX0vbN3IZp2cEgxue5rsUsD88ZdC4uM6PK8JszpB34ljXXffR6C
	oXwUrxoew7zmPtY6e9RBYwVbotaw=
X-Gm-Gg: ASbGncuQrpv8llLRH0QQmSMCkH6S7KezfTpcBvRA3Bu4O1MoKfDki7aAXgMCzvsJx8s
	16e2LBQPuZd3tSmn0ig/cKVNfhxAfY+zAVBsGiTLYrt9m8JMrfww=
X-Google-Smtp-Source: AGHT+IHbGSYiAAZzxwQbO+7zKbK8MWVNrbmhYiIAUI9xbhjrQ1oHgEYGn17ivq7GOxXA2hWTesL1TEz2zSCGBkU5kYY=
X-Received: by 2002:a05:6e02:23c3:b0:3a7:9347:544c with SMTP id
 e9e14a558f8ab-3cf743ba928mr127662285ab.5.1737422171218; Mon, 20 Jan 2025
 17:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
 <CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com>
 <20250120-panda-of-impressive-aptitude-2b714e@leitao> <CAL+tcoCzStjkEMdNw5ORYbQy3VnVE9A6aj6HcmQvGj3VG1VypA@mail.gmail.com>
 <20250120-daring-outstanding-jaguarundi-c8aaed@leitao>
In-Reply-To: <20250120-daring-outstanding-jaguarundi-c8aaed@leitao>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Jan 2025 09:15:35 +0800
X-Gm-Features: AbW1kvZZDheWMiZAlgrus7-N4_geCWlUiSBfC8zRcwFphC-AMy3m31FDSyo6ybs
Message-ID: <CAL+tcoC+hVZU2rx6vVQO_BjAAfjLXvqCOVDHkDoBHYuykqS1dg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] trace: tcp: Add tracepoint for tcp_cwnd_reduction()
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 9:20=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
>
> On Mon, Jan 20, 2025 at 09:06:43PM +0800, Jason Xing wrote:
> > On Mon, Jan 20, 2025 at 9:02=E2=80=AFPM Breno Leitao <leitao@debian.org=
> wrote:
> > > On Mon, Jan 20, 2025 at 08:08:52PM +0800, Jason Xing wrote:
> > > > On Mon, Jan 20, 2025 at 8:03=E2=80=AFPM Breno Leitao <leitao@debian=
.org> wrote:
> > > > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > > > index 4811727b8a02258ec6fa1fd129beecf7cbb0f90e..fc88c511e81bc12ec=
57e8dc3e9185a920d1bd079 100644
> > > > > --- a/net/ipv4/tcp_input.c
> > > > > +++ b/net/ipv4/tcp_input.c
> > > > > @@ -2710,6 +2710,8 @@ void tcp_cwnd_reduction(struct sock *sk, in=
t newly_acked_sacked, int newly_lost,
> > > > >         if (newly_acked_sacked <=3D 0 || WARN_ON_ONCE(!tp->prior_=
cwnd))
> > > > >                 return;
> > > > >
> > > > > +       trace_tcp_cwnd_reduction(sk, newly_acked_sacked, newly_lo=
st, flag);
> > > > > +
> > > >
> > > > Are there any other reasons why introducing a new tracepoint here?
> > > > AFAIK, it can be easily replaced by a bpf related program or script=
 to
> > > > monitor in the above position.
> > >
> > > In which position exactly?
> >
> > I meant, in the position where you insert a one-line tracepoint, which
> > should be easily replaced with a bpf program (kprobe
> > tcp_cwnd_reduction with two checks like in the earlier if-statement).
> > It doesn't mean that I object to this new tracepoint, just curious if
> > you have other motivations.
>
> This is exactly the current implementation we have at Meta, as it relies =
on
> hooking into this specific function. This approach is unstable, as
> compiler optimizations like inlining can break the functionality.
>
> This patch enhances the API's stability by introducing a guaranteed hook
> point, allowing the compiler to make changes without disrupting the
> BPF program's functionality.

Surely it does :) The reason why I asked is that perhaps one year ago
I'm trying to add many tracepoints so that the user space monitor can
take advantage of these various stable hook points. I believe that
there are many other places which might be inlined because of gcc,
receiving a few similar reports in recent months, but there is no
guarantee to not touch some functions which obviously break some
monitor applications.

I'm wondering that except for this new transepoint, if we can design a
common usage for the monitor program, so that people who are
interested will work on this together? Profiling is becoming more and
more important nowadays, from the point of my view.

Thanks,
Jason

