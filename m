Return-Path: <netdev+bounces-224666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A751B87B8F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 04:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8031CC1602
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 02:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A521257459;
	Fri, 19 Sep 2025 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkBaOcsk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFBC253954
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248904; cv=none; b=X8DCQVaAIo0zVwrZ+EozS5yq6H0WcePLJJwhVJegBlnyNlw7qYFmzamrNI08vXAyh9lC9G75bF1dD2qTqxoNyct3SpUdNsQPwo7JoetGGrIJyMaR7ANjM3W2OhpcLlD2pWJfBC6rVVUoDEpfaXe2Gj9PY/tu+FstRsD8YYj8g1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248904; c=relaxed/simple;
	bh=IAWzq8wgztEQOpbHtt1PpnYZzxoeakPxyForBjTUOq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7A/QXCOFBB7nO6JHgecNPkvNdp2ktrHYnsOv6AKQUErQHrZduXyIvE/gzonEhDuCS8eu3rAGs8y/JhONXSaDAj9GDrkjiLB900RPlR6ys6BnthnY++MWTP1xXDgh1S/xGU9rZGyTPVXWynSsrp+uABsJ0talBzGd0jSEkkoIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkBaOcsk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so1106110a91.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 19:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758248901; x=1758853701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz29qgUIuz9+hHBOcST4ZFw43ZTaMWItWLb+qR7GC2k=;
        b=hkBaOcskQcaDnG0/7FTR7rcWaQ1PQ4hDl258c7Askx18FNZLQgl6tRnIlEeYlanNsj
         1XyKbbNd3xz60qwxvoL16Lbu+vPkOcztF5NzgejrgrsIc5kKMfDHQGm07DV2uTFpQEOv
         d8FN3yPomhkzlBhgj2k9xYMGnA3S1y7J9Yf+QpzXTxCcV+qAOBFGo52LNo9Iiw56GxOH
         xWjLO8Zts4viEnwQfRKUcSikorWFrxQey7SeF2vhn0Yw1oo8zRN2rYXh3p0Sgajslx4Y
         q1qSZ8G2nWoYVXCzGRIQCuwmDWo2MAjo3UINPTU4561kn6gOPb4kKPqTYzQBw7T5dLcB
         mXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248902; x=1758853702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wz29qgUIuz9+hHBOcST4ZFw43ZTaMWItWLb+qR7GC2k=;
        b=v0WbepHOc7JXl/a14UZtYv0rbh58VNs5NKdQomMlb4rab0rnM2zCaRmC3FxC5rpNQn
         aTQSIKmtEkUTqFB8LVhvDnagscl5q7sbxFjdP26lIVkVCzgQ6tk6qDOenv36SnDOHve7
         eQTXZrM1FPLMX+gjMrnhAPACHF8174UD3E+69UUa+WRkpVCojLZfQdxZA5r/q0oqxIoG
         J8VA8jeaVODDRcF9dsyh86JR5Y+to4bvotAZvIV1UDdprE3m2tnvOFCKLPi9R0h+6FpA
         VBWOXcFme8UBES0NuD3D530Jnq/p9kkDLO1NfSBtzydoKLpGr2wQpVUVfN4jtclFyoy+
         Im1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFZku4RSKwIAn1nY8yAFs/+6PHckfXDKfIxFvOiZHnlrVwxm28a5jcufUSYbTdfaoDeqlB9/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSkaYtQgKo5m9kZAo6Oc/d5whPiyWQ6ytgqNcAtKBdI06yaEUl
	IKLQmlAc27pN9zVhSMStVVh+wYl6+duk/ukgyf+hAVJQbAGnQV2uz6marxmXc+tjx92qgqe+Q3g
	GjmLCBFg41Wg2ZpsmArPV1lBWKbZQGUzL1IsnEjcK
X-Gm-Gg: ASbGncu5w91e0MQzMKvEbH7blg6uUGslCh24OBOJazbLAJVVdUMBZLVm3gQ0amL/+3i
	y9/QFuQDuV/17URoVyyUKR/sZ31D9ZRDTcajWumrn0oIgPQ1INmSnrfgU1mNOclmlWRVpjL+Mt5
	DrhzNI1dRAG9lAd0JPhAPx/wAS+bAA/F46PFWmaJttezZZNSWfEngaMZk3pLUnhKMR+ucNZ1vNg
	8KVyv2VRsCKD9lC7KauN7ZRCkEhHwmzEIr1ZF3i+RBiWFtr/r072jdrkg==
X-Google-Smtp-Source: AGHT+IFeJy1Ue2kDzcZqKJGgrXMi7WDoq9/lFU+pCUu2btx1Ww9dM4IvC8+tlWlmYYLF0bVLogw/J+3jaK9P12vRuh0=
X-Received: by 2002:a17:90b:2886:b0:32e:3c57:8a9e with SMTP id
 98e67ed59e1d1-330983966f1mr2171493a91.35.1758248901349; Thu, 18 Sep 2025
 19:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917191417.1056739-1-kuniyu@google.com> <20250917191417.1056739-7-kuniyu@google.com>
 <a706bb87-46e1-4524-8d35-8f22569a73e7@linux.dev> <CAAVpQUCoMkkGrPfqiL4C_3i5EG_THaYb0gT+qF7jyxreBJTSZw@mail.gmail.com>
 <eacd9a90-8c80-4e23-a193-f09d96fe24ee@linux.dev>
In-Reply-To: <eacd9a90-8c80-4e23-a193-f09d96fe24ee@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 18 Sep 2025 19:28:10 -0700
X-Gm-Features: AS18NWDKMNPmXcswvtm1eocFpjYrtLGXxFIM2OCw897o_xHn9ndsJ3KY2Oz4RX4
Message-ID: <CAAVpQUBPxhBSPwW3jKVGNunmz7-MHwnRgL1RCjSA-WqvnJmGDg@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next/net 6/6] selftest: bpf: Add test for SK_MEMCG_EXCLUSIVE.
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

On Thu, Sep 18, 2025 at 6:14=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/17/25 6:17 PM, Kuniyuki Iwashima wrote:
> >>> +
> >>> +close:
> >>> +     for (i =3D 0; i < ARRAY_SIZE(sk); i++)
> >>> +             close(sk[i]);
> >>> +
> >>> +     if (test_case->type =3D=3D SOCK_DGRAM) {
> >>> +             /* UDP recv queue is destroyed after RCU grace period.
> >>> +              * With one kern_sync_rcu(), memory_allocated[0] of the
> >>> +              * isoalted case often matches with memory_allocated[1]
> >>> +              * of the preceding non-exclusive case.
> >>> +              */
> >> I don't think I understand the double kern_sync_rcu() below.
> > With one kern_sync_rcu(), when I added bpf_printk() for memory_allocate=
d,
> > I sometimes saw two consecutive non-zero values, meaning memory_allocat=
ed[0]
> > still see the previous test case result (memory_allocated[1]).
> > ASSERT_LE() succeeds as expected, but somewhat unintentionally.
> >
> > bpf_trace_printk: memory_allocated: 0 <-- non exclusive case
> > bpf_trace_printk: memory_allocated: 4160
> > bpf_trace_printk: memory_allocated: 4160 <-- exclusive case's
> > memory_allocated[0]
> > bpf_trace_printk: memory_allocated: 0
> > bpf_trace_printk: memory_allocated: 0
> > bpf_trace_printk: memory_allocated: 0
> >
> > One kern_sync_rcu() is enough to kick call_rcu() + sk_destruct() but
> > does not guarantee that it completes, so if the queue length was too lo=
ng,
> > the memory_allocated does not go down fast enough.
> >
> > But now I don't see the flakiness with NR_SEND 32, and one
> > kern_sync_rcu() might be enough unless the env is too slow...?
>
> Ah, got it. I put you in the wrong path. It needs rcu_barrier() instead.
>
> Is recv() enough? May be just recv(MSG_DONTWAIT) to consume it only for U=
DP
> socket? that will slow down the udp test... only read 1 byte and the rema=
ining
> can be MSG_TRUNC?

recv() before close() seems to work with fewer sockets (with the same
bytes of send()s and without kern_sync_rcu()).

And the test time was mostly the same with "no recv() + 1 kern_sync_rcu()"
case (2~2.5s on my qemu), so draining seems better.

#define NR_PAGES        128
#define NR_SOCKETS      2
#define BUF_TOTAL       (NR_PAGES * 4096 / (NR_SOCKETS / 2))
#define BUF_SINGLE      1024
#define NR_SEND         (BUF_TOTAL / BUF_SINGLE)

NR_SOCKET=3D=3D64
      test_progs-1380    [008] ...11  2121.731176: bpf_trace_printk:
memory_allocated: 0
      test_progs-1380    [008] ...11  2121.737700: bpf_trace_printk:
memory_allocated: 576
      test_progs-1380    [008] ...11  2121.743436: bpf_trace_printk:
memory_allocated: 64
      test_progs-1380    [008] ...11  2121.749984: bpf_trace_printk:
memory_allocated: 64
      test_progs-1380    [008] ...11  2121.755763: bpf_trace_printk:
memory_allocated: 64
      test_progs-1380    [008] ...11  2121.762171: bpf_trace_printk:
memory_allocated: 64

NR_SOCKET=3D=3D2
      test_progs-1424    [009] ...11  2352.990520: bpf_trace_printk:
memory_allocated: 0
      test_progs-1424    [009] ...11  2352.997395: bpf_trace_printk:
memory_allocated: 514
      test_progs-1424    [009] ...11  2353.001910: bpf_trace_printk:
memory_allocated: 2
      test_progs-1424    [009] ...11  2353.008947: bpf_trace_printk:
memory_allocated: 2
      test_progs-1424    [009] ...11  2353.012988: bpf_trace_printk:
memory_allocated: 2
      test_progs-1424    [009] ...11  2353.019988: bpf_trace_printk:
memory_allocated: 0

While NR_PAGES sets to 128, the actual allocated page was around 300 for
TCP and 500 for UDP.  I reduced NR_PAGES to 64, then TCP consumed 160
pages, and UDP consumed 250, but test time didn't change.

>
> btw, does the test need 64 sockets? is it because of the per socket snd/r=
cvbuf
> limitation?

I chose 64 for UDP that does not tune rcvbuf automatically, but I saw an er=
ror
when I increased the number of send() bytes and set SO_RCVBUF anyway,
so any number of sockets is fine now.

I'll use 2 sockets but will keep for-loops so that we can change NR_SOCKETS
easily when the test gets flaky.


>
> Another option is to trace SEC("fexit/__sk_destruct") to ensure all the c=
leanup
> is done but seems overkill if recv() can do.

Agreed, draining before close() would be enough.

