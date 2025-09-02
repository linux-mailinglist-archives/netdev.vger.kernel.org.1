Return-Path: <netdev+bounces-219298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C129B40ED2
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CC1561028
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD11E263F2D;
	Tue,  2 Sep 2025 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TT2bEGIu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2041E5724
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846185; cv=none; b=J1G2a7ck9FNQA4QPEmRHj7gVbNNER60sltYgatsOwrAQOvQvFsaH/iXzbPQPfRvCnMVgiRyFcmvc4CF238+2SHYlRPya/5UFJQyr/mhngP9+qaNDgQc7c0yJgYWr4cRvXXoEQh8s/2rqyhLXpCYVZNlOVkWX9nP6CfEA8vnTXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846185; c=relaxed/simple;
	bh=ueDqfteTwV0kcLXrjHL6fBMfjUDsYfn/YqUkR0y0sY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0DPXbiDCLt2mV9YXFPW5H9kiKriwVxTbz+Bt6PcOku6xmin0SGURoyjK6pHEssyumxzEZU9lm3oWJalq4TvniaJu3GvrnprgAEQOSAunAALd4wLc50wppR36348kl0cCzLhpGhftulFjGVKBbxxgOFWIPoXFHK1oZbdK8P+laM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TT2bEGIu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24884d9e54bso58502415ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 13:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756846184; x=1757450984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOGH1+5CktCvZnzWNdHEm9UWW2g5JWxIvNcEtzlciZI=;
        b=TT2bEGIuRMHkNjfSwWGw1R1g42TYWAY9YQPs8bqZ3+pwNbXhKvirQH5dxNEzLm+qoG
         UgzzZ//4oHLL4IYWPEAFB1jCk/YESlpwnHXA7JBjLKVP+vjus1wViXg017iqH1/zgs2X
         I4USA+X8w79ldmU5Np/8V8SVR4QlLDB7fp68PURU4/yiiMgj1V1lsPZZPFRNnZKPQhNX
         3TdMYjMcOhO4G/lwJ91Ib3AMy6EaCuajKKuJNmF64uOXuwCGudeTsoRtvmv5m7h0Aybu
         FyCu1tQ9ebSLU/BUDXiCewq9wcjWV0yCF8TbvddqFCnk+lbX8WjVQ2ikdbc/w5nTEUAN
         Emow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756846184; x=1757450984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOGH1+5CktCvZnzWNdHEm9UWW2g5JWxIvNcEtzlciZI=;
        b=WabtkdDdF7MUHauQAwPhxG25sr6mOgIOG4JQ18nTNsIUQCRklHXXzN1OCgpJxfa3vp
         6o1tksdOjiKyms0SrCG6agTP+vZAyUmSrTTKoIcJMEKZ8ZZ6htopgGEoKATi9W8XhNLc
         XRgKgdTVWQUK+wMO8LZhXgPyluolDrSLN6fhoZbZXgmXjW5J3K01pvBSHJn8emkpIcbC
         03RYiRQbDKIxta0po9KNJ5PnHbqjAbdSWVtoDI/EUzoDrlY/9hpq0oRekDL8CtzWjZA3
         /M4Vjh601ztEdJc8FWSomW5OukNIokzuL7sW3JBKXC68Iz2o1wnNzwNmdnB9U7HYf/9D
         o2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3jtkppDDD6VfFntWZ41a4UXWqpBl+iWfaDyXHg929BUK1GnPSM/6VJCQeaRJDs8bS48tLPdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFns98T0u/kE51wDY2Y9h1hBfnMMSTmn9hS4Chf0MGRtbLsb7E
	ad2qKb/DtZ1QIibJbWigouiX25+k0hQCCiNylUSxlL1uUnRWJR+eC1VaQm/NckQBlihK+SsBM11
	ohJzMhtl43HpE9OebHWrcA+ACbFC5vDV2rDPNXCo+
X-Gm-Gg: ASbGncvYOO5mKDI+ByWYLi5yCxdvIg5DSK4F2Kf7gq2bUudvY3ipXA+fsCeYGRCWnoM
	JhPx8Y3ptNxYpIFI+/PZvHzYsWdEAQTaY9dwCH1epP6WVB4DtUowFPm+yEcYYEOrBKxjlTVjOeE
	/xbLzHaZd0LbpGbV2O95rsUbyTmaoaxMNPh4twTnxiTIYOHqiC8o+2lzbjavFZ3PWeG493hoE0o
	88zbBc0LhDWn9zp6JBhwFP/eLSYBa4/Q4jw60iiaNkFAGywva9kVmSfgsneoUlGBNgeuEsgKHEz
	ww==
X-Google-Smtp-Source: AGHT+IEuXP0l1bQTsiOgwJNetsxK9P0Z0vtZx/HOCdBfpWaMCDHeU66MV158iMKnRQmTX00FHi6L4dfCqQLNCbes8BA=
X-Received: by 2002:a17:902:ce0a:b0:249:3eec:15cc with SMTP id
 d9443c01a7336-24944b1b8b7mr158993355ad.58.1756846183387; Tue, 02 Sep 2025
 13:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com> <20250829010026.347440-6-kuniyu@google.com>
 <904c1ffb-107e-4f14-89b7-d42ac9a5aa14@linux.dev>
In-Reply-To: <904c1ffb-107e-4f14-89b7-d42ac9a5aa14@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Sep 2025 13:49:32 -0700
X-Gm-Features: Ac12FXwcpqZP7jLBwtindshl-BWYlqreYxSvaS6QQYd8Er1RvdnTOdlXLT7mmwk
Message-ID: <CAAVpQUDfQwb2nfGBV8NEONwaBAMVi_5F8+OPFX3=z+W8X9n9ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next/net 5/5] selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:26=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> > The test does the following for IPv4/IPv6 x TCP/UDP sockets
> > with/without BPF prog.
> >
> >    1. Create socket pairs
> >    2. Send a bunch of data that requires more than 256 pages
> >    3. Read memory_allocated from the 3rd column in /proc/net/protocols
> >    4. Check if unread data is charged to memory_allocated
> >
> > If BPF prog is attached, memory_allocated should not be changed,
> > but we allow a small error (up to 10 pages) in case other processes
> > on the host use some amounts of TCP/UDP memory.
> >
> > At 2., the test actually sends more than 1024 pages because the sysctl
> > net.core.mem_pcpu_rsv is 256 is by default, which means 256 pages are
> > buffered per cpu before reporting to sk->sk_prot->memory_allocated.
> >
> >    BUF_SINGLE (1024) * NR_SEND (64) * NR_SOCKETS (64) / 4096
> >    =3D 1024 pages
> >
> > When I reduced it to 512 pages, the following assertion for the
> > non-isolated case got flaky.
> >
> >    ASSERT_GT(memory_allocated[1], memory_allocated[0] + 256, ...)
> >
> > Another contributor to slowness is 150ms sleep to make sure 1 RCU
> > grace period passes because UDP recv queue is destroyed after that.
>
> There is a kern_sync_rcu() in testing_helpers.c.

Nice helper :)  Will use it.

>
> >
> >    # time ./test_progs -t sk_memcg
> >    #370/1   sk_memcg/TCP       :OK
> >    #370/2   sk_memcg/UDP       :OK
> >    #370/3   sk_memcg/TCPv6     :OK
> >    #370/4   sk_memcg/UDPv6     :OK
> >    #370     sk_memcg:OK
> >    Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> >
> >    real       0m1.214s
> >    user       0m0.014s
> >    sys        0m0.318s
>
> Thanks. It finished much faster in my setup also comparing with the earli=
er
> revision. However, it is a bit flaky when I run it in a loop:
>
> check_isolated:FAIL:not isolated unexpected not isolated: actual 861 <=3D=
 expected 861
>
> I usually can hit this at ~40-th iteration.

Oh.. I tested ~10 times manually but will try in a tight loop.

Thanks!

