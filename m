Return-Path: <netdev+bounces-191616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F52ABC7B3
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92FA4A27EF
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ECA20E6E2;
	Mon, 19 May 2025 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4kHjIgp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0017B79FE
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682493; cv=none; b=JuYsUk0AbuCAvYH6EY6Oxw1BK6OgD9qNqo2FuWEqaqsnhUmf1uCgeQqsSTNC2sj02Td5bLfME0K0jKcsQQdGgKxWqvpepER3rxfw2X1cwuv5v16rKwtlqZQ6+Jz7N90rhh7eXTbSP4ghGXqhRP3K4FM7QFi5UMtL88OaSqyT6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682493; c=relaxed/simple;
	bh=ocs4PoPPTWbTf3NMu4FAH3UKU5tSIIh0TWkmyd//WRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYabiOeYlr6a1RE+Sj58rryodine1irAq7GH1XrBqv6JBbmJ20enyvXCQakcic/PdNBx9exj8XM8QUsK2H9ectLcGm/Qywck4o+klr5U94BtvIZZZRe5mp6NDSAxwPSfS1zXtKPoNqu+GT4Nd23q6aVDXhUoJyaGUL3KNgscRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4kHjIgp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-231f61dc510so530695ad.0
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747682490; x=1748287290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBaPdK9KEC1FIJe6XWoniG9ySiw1tVbaWCS/pMC/19A=;
        b=u4kHjIgp2QwBF0deqS5WqZXfAlXIBD8ap0GdG/BbkZwE09frepFEAQuCPKRxurkdes
         ovivD9+urOnbCXE4xxgsJJr1446dQgGQF9SdNhZUXlb4ECUwvhO+anFo4wJILgVPIZ2H
         5BDi/EGx38U6tR0z0UjRt0zG7H037DSIdh/7oqoujSgZfGTV/wkuKMPyohfc4QgNFjuZ
         6VUnPz0tB9S8I8eCfE5ShgMBp7ELCzd/Mzfr3QvIRvcvT6aLihWbTAxbXyT52E2EUF5G
         EwqtZpvrXzT5lfcy8VOM4nHMJP0HwubNhHnQyDS+sMmyCW0tBTVqRXcSLmqClN778E3o
         l2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747682490; x=1748287290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBaPdK9KEC1FIJe6XWoniG9ySiw1tVbaWCS/pMC/19A=;
        b=aT1dV4+G4mRY8bnr3BrRu9S3Rl3nI86P7AC9GPMv9HgzQyLeapM3+dgXHV4PLHTVCa
         BApffd/Vbn/sziGywTEdivJz26mEmJDBMn7c6duOQkkASwIaW8Aef6hq8KTgKlvcvRe3
         qzAItQMchd9A448bvdX8mzR6InytxGrBfw+I7fnok9Sboc6d2VhWGLfNDH9tMPB8HsP8
         DOUVJNVNjNCM9r6lhHHy1aO6J21utWvOThLmbKTXQDvGQXKL/tnD+98UeeJqn1nfKVR/
         y3s02kwpsK4xgnq3UHaBxn/H1BvWNBg6AfBEUJGpSVqffROAgJ8lOPwo3NFTgx8ni0cR
         okRA==
X-Forwarded-Encrypted: i=1; AJvYcCWsCvXcCBS4mF/PFsVXu2DBw1/tlQ4RZo04O9vf8H45lUbE33/X4MPwpSikKAkXloU2aJaFVtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhbZg94z35ojqMeS/v62f6dp52HAalehCTVo78n2a/3Y6Ptt9R
	bz1LQPrB2fCr+NN55xn66+su/51ofUR4dj81q3dUrefmS0sP9dkBawaRVX9iPNXJzyZ1ATcR44r
	6wCb4ssY3JfwQLb8qs/Uu7GaNjSVBYJlSCjmjfQ5e
X-Gm-Gg: ASbGnctcKyKxhe9sKnGry8j2Iq2HKcpIO25fipVcyist7SZR0wfYOONTMmLJUV1CFHm
	dmm9PliUAifCprTxzV2BvVESx5vVZg4UuxLh3X3KG/sYWg6t+yXSeH38j8YSncEX01ocFUgpxTi
	8+byLIWatAr/8Sd61HV8AHogNdEhioGvnzTcz3QbiF1uoP95BFfZC2FOs11a+zPgM=
X-Google-Smtp-Source: AGHT+IFQTBMhjQ4UqSbGbWsEL1d6RocSL1UQvOsthQP8iEU6ov/g1bSMRXI7uUXn0vaXWPww9RbtJgdH1n1G9/yz4js=
X-Received: by 2002:a17:903:228c:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-231ffd0e58dmr5717895ad.12.1747682489831; Mon, 19 May 2025
 12:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513083123.3514193-1-dongchenchen2@huawei.com>
 <CAHS8izOio0bnLp3+Vzt44NVgoJpmPTJTACGjWvOXvxVqFKPSwQ@mail.gmail.com> <34f06847-f0d8-4ff3-b8a1-0b1484e27ba8@huawei.com>
In-Reply-To: <34f06847-f0d8-4ff3-b8a1-0b1484e27ba8@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 May 2025 12:20:59 -0700
X-Gm-Features: AX0GCFuTTbdFDQ3Q3jzbOg1ekJYHd7I6fnzt95zb6m3zDrMKz8yKVB-QpAKu66I
Message-ID: <CAHS8izPh5Z-CAJpQzDjhLVN5ye=5i1zaDqb2xQOU3QP08f+Y0Q@mail.gmail.com>
Subject: Re: [BUG Report] KASAN: slab-use-after-free in page_pool_recycle_in_ring
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 8:11=E2=80=AFPM dongchenchen (A)
<dongchenchen2@huawei.com> wrote:
>
>
> > On Tue, May 13, 2025 at 1:28=E2=80=AFAM Dong Chenchen <dongchenchen2@hu=
awei.com> wrote:
> >> Hello,
> >>
> >> syzkaller found the UAF issue in page_pool_recycle_in_ring[1], which i=
s
> >> similar to syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com.
> >>
> >> root cause is as follow:
> >>
> >> page_pool_recycle_in_ring
> >>    ptr_ring_produce
> >>      spin_lock(&r->producer_lock);
> >>      WRITE_ONCE(r->queue[r->producer++], ptr)
> >>        //recycle last page to pool
> >>                                  page_pool_release
> >>                                    page_pool_scrub
> >>                                      page_pool_empty_ring
> >>                                        ptr_ring_consume
> >>                                        page_pool_return_page //release=
 all page
> >>                                    __page_pool_destroy
> >>                                       free_percpu(pool->recycle_stats)=
;
> >>                                       kfree(pool) //free
> >>
> >>       spin_unlock(&r->producer_lock); //pool->ring uaf read
> >>    recycle_stat_inc(pool, ring);
> >>
> >> page_pool can be free while page pool recycle the last page in ring.
> >> After adding a delay to the page_pool_recycle_in_ring(), syzlog[2] can
> >> reproduce this issue with a high probability. Maybe we can fix it by
> >> holding the user_cnt of the page pool during the page recycle process.
> >>
> >> Does anyone have a good idea to solve this problem?
> >>
> > Ugh. page_pool_release is not supposed to free the page_pool until all
> > inflight pages have been returned. It detects that there are pending
> > inflight pages by checking the atomic stats, but in this case it looks
> > like we've raced checking the atomic stats with another cpu returning
> > a netmem to the ptr ring (and it updates the stats _after_ it already
> > returned to the ptr_ring).
> >
> > My guess here is that page_pool_scrub needs to acquire the
> > r->producer_lock to make sure there are no other producers returning
> > netmems to the ptr_ring while it's scrubbing them (and checking after
> > to make sure there are no inflight netmems).
> >
> > Can you test this fix? It may need some massaging. I only checked it
> > builds. I haven't thought through all the possible races yet:
> >
> > ```
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 2b76848659418..8654608734773 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -1146,10 +1146,17 @@ static void page_pool_scrub(struct page_pool *p=
ool)
> >
> >   static int page_pool_release(struct page_pool *pool)
> >   {
> > +       bool in_softirq;
> >          int inflight;
> >
> > +
> > +       /* Acquire producer lock to make sure we don't race with anothe=
r thread
> > +        * returning a netmem to the ptr_ring.
> > +        */
> > +       in_softirq =3D page_pool_producer_lock(pool);
> >          page_pool_scrub(pool);
> >          inflight =3D page_pool_inflight(pool, true);
> > +       page_pool_producer_unlock(pool, in_softirq);
> >          if (!inflight)
> >                  __page_pool_destroy(pool);
> > ```
> Hi, Mina!
>
> I tested this patch and the problem still exists.
> Although this patch ensures that lock access is safe, the page recycle
> process
> can access the page pool after unlock.
>

Sorry for the very late reply; got a bit busy with some work work.

My initial analysis was wrong as the test shows with the candidate
fix. I took another look, and here is what I can tell so far. The full
syzbot report is here for reference:

https://syzkaller.appspot.com/bug?extid=3D204a4382fcb3311f3858

page_pool_release_retry is supposed to block freeing the page_pool
until all netmems have been freed via page_pool_put_unrefed_netmem
using the inflight logic. What is clear from the syzbot report is that
this inflight logic didn't work properly, because the
page_pool_put_unrefed_netmem call happened after
page_pool_release_retry has allowed the page_pool to be freed
(__page_pool_destroy has already been called).

The inflight logic works by taking the diff between
`pool->pages_state_release_cnt` and `pool->pages_state_hold_cnt`.
pages_state_hold_cnt is incremented when the page_pool allocates a new
page from the buddy allocator. pages_state_hold_cnt is incremented at
the end of the page_pool_put_unrefed_netmem.

We don't expect new pages to be allocated by the page_pool owner after
page_pool_destroy has been called, so pages_state_hold_cnt is supposed
to not move after page_pool_destroy is called I think.
pages_state_release_cnt should be <=3D pages_state_hold_cnt at the time
of page_pool_destroy is called. Then when all the inflight netmems
have been freed via page_pool_put_unrefed_netmem,
pool->pages_state_release_cnt should be =3D=3D to
pool->pages_state_hold_cnt, and the page_pool should be allowed to be
freed.

Clearly this is not working, but I can't tell why. I also notice the
syzbot report is from the bpf/test_run.c, but I don't think we have
reports from prod, so it may be a test issue. Some possibilities:

1. Maybe the test is calling a page_pool allocation like
page_pool_dev_alloc_pages in parallel with page_pool_destroy. That may
increment pages_state_hold_cnt unexpectedly?

2.  Maybe one of the pages_state_*_cnt overflowed or something?

3. Memory corruption?

I'm afraid I'm not sure. Possibly littering the code with warnings for
unexpected cases would give some insight. For example, I think this
would catch case #1:

```
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4011eb305cee..9fa70c60f9b5 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -536,6 +536,9 @@ static struct page
*__page_pool_alloc_page_order(struct page_pool *pool,
        alloc_stat_inc(pool, slow_high_order);
        page_pool_set_pp_info(pool, page_to_netmem(page));

+       /* Warn if we're allocating a page on a destroyed page_pool */
+       DEBUG_NET_WARN_ON(pool->destroy_cnt);
+
        /* Track how many pages are held 'in-flight' */
        pool->pages_state_hold_cnt++;
        trace_page_pool_state_hold(pool, page_to_netmem(page),
@@ -582,6 +585,8 @@ static noinline netmem_ref
__page_pool_alloc_pages_slow(struct page_pool *pool,
                page_pool_set_pp_info(pool, netmem);
                pool->alloc.cache[pool->alloc.count++] =3D netmem;
                /* Track how many pages are held 'in-flight' */
+               /* Warn if we're allocating a page on a destroyed page_pool=
 */
+               DEBUG_NET_WARN_ON(pool->destroy_cnt);
                pool->pages_state_hold_cnt++;
                trace_page_pool_state_hold(pool, netmem,
                                           pool->pages_state_hold_cnt);
@@ -1271,6 +1276,8 @@ void net_mp_niov_set_page_pool(struct page_pool
*pool, struct net_iov *niov)

        page_pool_set_pp_info(pool, netmem);

+       /* Warn if we're allocating a page on a destroyed page_pool */
+       DEBUG_NET_WARN_ON(pool->destroy_cnt);
        pool->pages_state_hold_cnt++;
        trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_cnt=
);
```

If you have steps to repro this, maybe post them and I'll try to take
a look when I get a chance if you can't root cause this further.

--
Thanks,
Mina

