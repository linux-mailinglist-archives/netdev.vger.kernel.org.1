Return-Path: <netdev+bounces-193541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CED2AC461D
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 04:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C9B17484A
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 02:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9F215624D;
	Tue, 27 May 2025 02:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqL1KUYK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380C2CCDB
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748312040; cv=none; b=K2qe5mqvarO4Vc62lTt+baK6vVjSCEStQqIGmWihmujpT9SVOme/X4ziPx82NBcoLy2FHaJAhsQtSsfgmNh4tQ6lH/8Kc5BYTa5LIL26p+CTCaMbHL4LRIKAGYc/JwgS4rb0Gav0XwD7rGReksCETzhnVh47PyzCLJ/fSf+hy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748312040; c=relaxed/simple;
	bh=ahC/kd+J2092JsB6/ArDG+ZFk82XKoLZ2QwLtucY7FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OV43gEYh4f9eK+fFynMR5QzGf2lqPsW2z+iGH6oQJBxhFTq4yEtZkXqdCrIrrPzaZOKBacc/e1LYKbGTnEaqQ3X22U8UheGxyogoQPftXvLI7/g4waUOYXOUUQ2OIKh20U3s8TRth7e4oOqsoAaHS8EcXy3Zt/24P+OpWfiqAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqL1KUYK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2349068ebc7so98835ad.0
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 19:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748312038; x=1748916838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1ZNoI7qsadxWOPLLG4KHlskcQxZNedj0B1MDBOI68s=;
        b=fqL1KUYKCAVUB9f15PQ2yjDrNUihKBa+liF7WtPNoX5INInzX61J7HIJ8oMIhwKjhG
         sCgLrPEz/3abe8tZmeycPgmLLeu3paDukLEy2e886YW+iMN4lc9Y3evCYCbnYoifYBNF
         svAF5H4+4mLLEJpTDsER9EM6Hn141Wu0YR1OIgyaQrLvPVOkQldJzSkGz1kvBZV/zhKG
         t9hZ9Bo7Je3aY0jk0Lz9PYrys/Kwlk1Amxsuenj8KexB5XUywpb0DKGAL2r+o/rDFGN4
         HkRlVkD0uzUQsGbrWkm5zduNyOZpuld4TZv/qMCMG95O0L5F1UTqwwWO757kMKWWXusS
         d6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748312038; x=1748916838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1ZNoI7qsadxWOPLLG4KHlskcQxZNedj0B1MDBOI68s=;
        b=jFnFgKMbCwWl3dtrNtTmpg88afBb9lV1RTHpvonINz9obliuQtvJV+7xjxeAKEIPpG
         reHdkPi675B41Mh8HWE3SSI77C26qiRa4enbY6Qdgff2VGPFYqQf+/I+k3Ut/51btPRV
         AnW/hIyaR/+3HVu/q96rDMHtmx3VjGpiE+1Ci7ZqKByruj8V8km076JhEWQh5ON4doiS
         22VsxOA7GMLwUS452DAmok5cOye1mdgn08+8Czdbj+sff6qhfynYNX2u5odixy3KGvyi
         PXYg+voaHMj4Zg1PHgMoDBxFQHEgrMh1ItiWVfFc5cJPLIshD2EiLw6Q9tsN98Lzkr4V
         nAoA==
X-Forwarded-Encrypted: i=1; AJvYcCVildfrHvkuVe56Sn8tCO8uNoDiTys1wpKGMoMl6Ysucm4r9e5DJVRJATMSMD+n2WwikuqDiME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOnPZZ4tQ+hhGiP5PRMumSHegPPuNvUA+zF28MUwfDepSpcvde
	O43zmvVF0RhanYV7yynXvLWgM4T8CL7B6NfaGIS0i3Iz0Ckgy9Kbe0Kh8YXbRZKG0rnz99nSD+y
	S148xvebw4NSjGsUXASBBxhtor1Hrr4oRrYjNQrhw
X-Gm-Gg: ASbGnctbgvXsrmaUqSyAWlYRqgWcEnMOWV6VkDe9pcx7R1Jonx9lzfROnnftYMY0PR8
	o9t7kizFi6XJ3KDvh7Re1ZZQ+Kg/+A/SP3fl59a/dLBLz7xRONbTn+JhHBLk8eyG/P6Lau0orFG
	kbYi54z8/8+pYS7orG3oM/LqlQ33Wi4gIqMn2uLFv9hgf0
X-Google-Smtp-Source: AGHT+IGbiAy6Z7VdqYFRXgQS+MG05F5Dg/vRxVWf99c9CXesKANWlp3c35h7PzSTSZIMNMhb9pqCXMZXUBP2ymOZBhM=
X-Received: by 2002:a17:902:ccc2:b0:231:e069:6188 with SMTP id
 d9443c01a7336-234593bef04mr3337865ad.0.1748312037710; Mon, 26 May 2025
 19:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523064524.3035067-1-dongchenchen2@huawei.com>
 <a5cc7765-0de2-47ca-99c4-a48aaf6384d2@huawei.com> <CAHS8izP=AuPbV6N=c05J2kJLJ16-AmRzu983khXaR91Pti=cNw@mail.gmail.com>
 <5305c0d1-c7eb-4c79-96ae-67375f6248f1@huawei.com> <CAHS8izPY9BYWzAVR9LNdSP4+-0TsgOoMXvD658i22VFWHZfvfA@mail.gmail.com>
 <72efaa08-807f-4f6b-87c9-6ce07988797a@huawei.com>
In-Reply-To: <72efaa08-807f-4f6b-87c9-6ce07988797a@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 26 May 2025 19:13:44 -0700
X-Gm-Features: AX0GCFt0qT7uzXDBWL1VmdjA3Pj7lsZsYKiXMNz5ZJl74d0V4Btn4kR_s0379d0
Message-ID: <CAHS8izPTDmBKkwdhE3niaKgh_qd9y-Nd2JcjG4-P59erKTCTLQ@mail.gmail.com>
Subject: Re: [PATCH net] page_pool: Fix use-after-free in page_pool_recycle_in_ring
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangchangzhong@huawei.com, 
	syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 6:53=E2=80=AFPM dongchenchen (A)
<dongchenchen2@huawei.com> wrote:
>
>
> > )
> >
> > On Mon, May 26, 2025 at 7:47=E2=80=AFAM dongchenchen (A)
> > <dongchenchen2@huawei.com> wrote:
> >>
> >>> On Fri, May 23, 2025 at 1:31=E2=80=AFAM Yunsheng Lin <linyunsheng@hua=
wei.com> wrote:
> >>>> On 2025/5/23 14:45, Dong Chenchen wrote:
> >>>>
> >>>>>    static bool page_pool_recycle_in_ring(struct page_pool *pool, ne=
tmem_ref netmem)
> >>>>>    {
> >>>>> +     bool in_softirq;
> >>>>>         int ret;
> >>>> int -> bool?
> >>>>
> >>>>>         /* BH protection not needed if current is softirq */
> >>>>> -     if (in_softirq())
> >>>>> -             ret =3D ptr_ring_produce(&pool->ring, (__force void *=
)netmem);
> >>>>> -     else
> >>>>> -             ret =3D ptr_ring_produce_bh(&pool->ring, (__force voi=
d *)netmem);
> >>>>> -
> >>>>> -     if (!ret) {
> >>>>> +     in_softirq =3D page_pool_producer_lock(pool);
> >>>>> +     ret =3D !__ptr_ring_produce(&pool->ring, (__force void *)netm=
em);
> >>>>> +     if (ret)
> >>>>>                 recycle_stat_inc(pool, ring);
> >>>>> -             return true;
> >>>>> -     }
> >>>>> +     page_pool_producer_unlock(pool, in_softirq);
> >>>>>
> >>>>> -     return false;
> >>>>> +     return ret;
> >>>>>    }
> >>>>>
> >>>>>    /* Only allow direct recycling in special circumstances, into th=
e
> >>>>> @@ -1091,10 +1088,14 @@ static void page_pool_scrub(struct page_poo=
l *pool)
> >>>>>
> >>>>>    static int page_pool_release(struct page_pool *pool)
> >>>>>    {
> >>>>> +     bool in_softirq;
> >>>>>         int inflight;
> >>>>>
> >>>>>         page_pool_scrub(pool);
> >>>>>         inflight =3D page_pool_inflight(pool, true);
> >>>>> +     /* Acquire producer lock to make sure producers have exited. =
*/
> >>>>> +     in_softirq =3D page_pool_producer_lock(pool);
> >>>>> +     page_pool_producer_unlock(pool, in_softirq);
> >>>> Is a compiler barrier needed to ensure compiler doesn't optimize awa=
y
> >>>> the above code?
> >>>>
> >>> I don't want to derail this conversation too much, and I suggested a
> >>> similar fix to this initially, but now I'm not sure I understand why
> >>> it works.
> >>>
> >>> Why is the existing barrier not working and acquiring/releasing the
> >>> producer lock fixes this issue instead? The existing barrier is the
> >>> producer thread incrementing pool->pages_state_release_cnt, and
> >>> page_pool_release() is supposed to block the freeing of the page_pool
> >>> until it sees the
> >>> `atomic_inc_return_relaxed(&pool->pages_state_release_cnt);` from the
> >>> producer thread. Any idea why this barrier is not working? AFAIU it
> >>> should do the exact same thing as acquiring/dropping the producer
> >>> lock.
> >> Hi, Mina
> >> As previously mentioned:
> >> page_pool_recycle_in_ring
> >>     ptr_ring_produce
> >>       spin_lock(&r->producer_lock);
> >>       WRITE_ONCE(r->queue[r->producer++], ptr)
> >>         //recycle last page to pool, producer + release_cnt =3D hold_c=
nt
> > This is not right. release_cnt !=3D hold_cnt at this point.
>
> Hi,Mina!
> Thanks for your review!
> release_cnt !=3D hold_cnt at this point. producer inc r->producer
> and release_cnt will be incremented by page_pool_empty_ring() in
> page_pool_release().
>
> > Release_cnt is only incremented by the producer _after_ the
> > spin_unlock and the recycle_stat_inc have been done. The full call
> > stack on the producer thread:
> >
> > page_pool_put_unrefed_netmem
> >      page_pool_recycle_in_ring
> >          ptr_ring_produce(&pool->ring, (__force void *)netmem);
> >               spin_lock(&r->producer_lock);
> >               __ptr_ring_produce(r, ptr);
> >               spin_unlock(&r->producer_lock);
> >          recycle_stat_inc(pool, ring);
>
> If page_ring is not full, page_pool_recycle_in_ring will return true.
> The release cnt will be incremented by page_pool_empty_ring() in
> page_pool_release(), and the code as below will not be executed.
>
> page_pool_put_unrefed_netmem
>    if (!page_pool_recycle_in_ring(pool, netmem)) //return true
>        page_pool_return_page(pool, netmem);
>

Oh! Thanks! I see the race now.

page_pool_recycle_in_ring in the producer can return the page to the
ring. Then the consumer will see the netmem in the ring, free it,
increment release_cnt, and free the page_pool. Then the producer
continues executing and hits a UAF. Very subtle race indeed. Thanks
for the patient explanation.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

