Return-Path: <netdev+bounces-208022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ADFB0966D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0483D4E1BBB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 21:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D6C2309B2;
	Thu, 17 Jul 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ol/dfOSG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1712264AE
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752788516; cv=none; b=H9O1goVB+hTE9DXT/8hLNpJRZ1wTTYYNVD2/gVIoBFTXO/C5E8it47aWYyyvuEvkWRC0TiQoHIaGRcdffoZKRSnDfjvSC7EPbuXhN4LQy3H8DhTuswl9ZhZ23PWO01X6A8/XG8/OOFPCWVBq5Ug1uTpRUfFFd5bYNwzLYynjvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752788516; c=relaxed/simple;
	bh=dYT4onUuR63vQ1U/FPLFwrXmlwNIiAFoiKf8LhM8HKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sx0iqEVyxZcLpJyn0tiEn+SXjjw8NcMmvs+a0D2Gnluo5LO2p47z/sU2/VYobAXBsto9qfmGC1bqViuiPlrdTX+wGITkx8CfocN94CVtbqZUtiUjGgSZOdijaJxVXJL7ANH2W3ubgsUr0UvkvihIvq6Cy1cbSwR6ZIVnXAdNXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ol/dfOSG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so1301493a91.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 14:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752788515; x=1753393315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1RVsAatRchXPNwv1tD3AMQfnAtyWtrmL8imZzj0jaU=;
        b=Ol/dfOSGhtfMsli4NMhZZNhGwqsQgXOlZYBOXOrNMV1/AF25JHkq5uHIZ53T8neGdg
         Tf8ZjJpZtQ7oqJuTinXPPn6JTKgRkxRZdGnWlvRAVkBaGtAZEffWZcm4HRjZYRK/u2XH
         4AtTLcfe5JeBQDk7U64zDHCYxnjc+BZqdagV+UC0NvfKTXswo2Y3nWy6wnXmVQyE2D0K
         XQaWR1qvM2FeYl4TEgoDVXKTM59sCfWxmauurUzFUDBYYMllMvd7JzgOkF68v7rNw+2w
         nAUmYNS/fj2wzLzEldwl6M48904GxVwmrKOnmFrnRwNssWSi8igHeeclvpzhKI9sw24Z
         Lyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752788515; x=1753393315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1RVsAatRchXPNwv1tD3AMQfnAtyWtrmL8imZzj0jaU=;
        b=k6s44J7IHgT5LmeaoUaNcg4YwD+e+9I0b2HxAxcu2g1S1siPzCte9Y+WluzHnJlAtE
         POskbKbOKpDT7Vg+N/gUMYFyFk819TkaBgfGoiE1nJVW6R6eHhXUj4tJsolSKSIytgiO
         C3FeAN02ZTh972yWt+o77RVH75w0k++vp7L0xP7vAfDeCyWlNgwRMS9FuGWRSDeL7w/0
         rf1zv2wXO4a+A02nZSOQoZJ1/zYTADVH43CqFSIuxgsfkG66hB5GGaNIIykr4S2YpuxX
         gZsiyvEyeGNbl30bH33pvYDZ5IrbTbzC+Z+r5e+py5jrmZZGFq2rscybbdTZDegHmIa4
         1raw==
X-Forwarded-Encrypted: i=1; AJvYcCWl/S6zESTb9C1lyirx3PHIyzEV5aJ+MyEzlE0IVnCV3ehMgVAJHSFCpaefV9dI68TYAAVW2ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3UkvVcskH8AroCl0wXMxhwbSLxd/whOEfZtimOzVGhxVqTeb
	oWPpwXTzU5tvkWZwOXomRTCKoQEcNNqA/AS/MYtrwbRiGi/R3DN0w0zYI+3Y8uTHQnIzKhzBn4C
	fOpsIh8bXhYy2uhZcZPU7s6MW7/GhKnIx0T6FOVdv
X-Gm-Gg: ASbGncuKt2m6QrwcCkCP86PpMYmlJZJwbGKEDYC74P6Rm54zM7U5DOIw1p9zaNjpC61
	TgVkLAPQKBNmJiXRuZ9Rz6kqP2FpTtm1BmmQQQVw2MSCbDJpL9RVtqcGYIaKUl2oLdYKU5F07vX
	c3cCQf+Nga/0QPiJthGcQ5CY0rb9SOzvqL/qfk1c/Ea6lMe68lcukT/ScNbCWm0cyxCaJk84HK1
	1WtJoiGeE5KH/N5Y0LqwwVHBN5G+lh4MfnvZOnA
X-Google-Smtp-Source: AGHT+IFJ+VcxLXyyUjZfKsbth9zKtPrAaTF5y1GZg9JU7qJ47TLHsTGnbyEHLd9uXo6XsFb8DAiXJk5JvRikRWhYvT8=
X-Received: by 2002:a17:90b:5708:b0:313:2adc:b4c4 with SMTP id
 98e67ed59e1d1-31cc25e6754mr654793a91.24.1752788514570; Thu, 17 Jul 2025
 14:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717185837.1073456-1-kuniyu@google.com> <CAADnVQJdn5ERUBfmTHAdfmn0dLozcY6FHsHodNnvfOA40GZYWg@mail.gmail.com>
 <aHlqiEaG43iqUsOX@strlen.de>
In-Reply-To: <aHlqiEaG43iqUsOX@strlen.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 17 Jul 2025 14:41:42 -0700
X-Gm-Features: Ac12FXwOVNDpIK0boXx9z2Ddijuq6YU-aaoMI6hEk48L6rjvoQhda96DcILS6DE
Message-ID: <CAAVpQUD=_-rsQcva7EkkV6oqOuah+n17NZq3r05yeiE1z9N=Lw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] bpf: Disable migration in nf_hook_run_bpf().
To: Florian Westphal <fw@strlen.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, netfilter-devel <netfilter-devel@vger.kernel.org>, 
	syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 2:26=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > Let's call migrate_disable() before calling bpf_prog_run() in
> > > nf_hook_run_bpf().
>
> Or use bpf_prog_run_pin_on_cpu() which wraps bpf_prog_run().

Thanks, this is cleaner.

>
> > > Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFR=
AG in netfilter link")
> >
> > Fixes tag looks wrong.
> > I don't think it's Daniel's defrag series.
> > No idea why syzbot bisected it to this commit.
>
> Didn't check but I'd wager the bpf prog attach is rejected due to an
> unsupported flag before this commit.  Looks like correct tag is
>
> Fixes: fd9c663b9ad6 ("bpf: minimal support for programs hooked into netfi=
lter framework")

Sorry, I should've checked closely.  This tag looks correct.


>
> I don't see anything that implicitly disables preemption and even 6.4 has
> the cant_migrate() call there.
>
> > > +       unsigned int ret;
> > >
> > > -       return bpf_prog_run(prog, &ctx);
> > > +       migrate_disable();
> > > +       ret =3D bpf_prog_run(prog, &ctx);
> > > +       migrate_enable();
> >
> > The fix looks correct, but we need to root cause it better.
> > Why did it start now ?
>
> I guess most people don't have preemptible rcu enabled.

I have no idea why syzbot found it now, at least it has
supported the netfilter prog since 2023 too.

commit d966708639b67fe767995dfab47bf4296201993f
Author: Paul Chaignon <paul.chaignon@gmail.com>
Date:   Wed Sep 6 13:38:44 2023

    sys/linux: cover BPF links for BPF netfilter programs

