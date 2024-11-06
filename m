Return-Path: <netdev+bounces-142517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3069BF7A6
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311A1282BF2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AB204F72;
	Wed,  6 Nov 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX40vlPe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8366D13A26F;
	Wed,  6 Nov 2024 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922948; cv=none; b=E9hY+K9u/MscrLYTfFk9OKg/BkdUoTFenXLDLjT+TZpzaJKDJ8WZRJhqJygp+WP2WeSijsxYoN9l7tXSOXPAop5C/4zPGa9rXE+cZmyzyYXpMJWfnFi6Pu57HhwADZ9E3FMqQf4KYd3jbQr46X1oVuSvnzJxiFTdn8ldThFJ6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922948; c=relaxed/simple;
	bh=YtJF6qhvib+xrJJljfZ0Ni7jfLYA0Jur/MNeDlgIMVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pyg0auxwnNRILL29keEBaNHLrjbRV5d1Vu8qexSv1QCcK8Yh4AAm3YrHPN9XmFwvnQxXRipuWOQ7x4PqPhG/VXYjWaCD1ygshR0Rr4wYQQKSQGWpgAu6T3EDOl1ruD12OHNM4iMDJGbhBBvrqj5z3iWEFADBwf5KEH1Bl0FhogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX40vlPe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43163667f0eso1842445e9.0;
        Wed, 06 Nov 2024 11:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730922945; x=1731527745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz8jpFca6SqfJ60+obKhkJJRmDB3H7XKSoVY6XiXXVw=;
        b=YX40vlPejbkWq4PrxeSZQncbBh2mRd6l+dOxw4bEw350CsWqhRyaUkFdRyUKdCJPaK
         H0TBzQJHra/8gjTTbuLTWGpPWWZfLUtbudvQYXZil9bw52A4TK3QAYe30merMKxUH3WX
         DTN9H0FFuNXaq6KvzDIjnan0ev2eOypAwIHAKS7+UjvaMzBk5S5VlLHSZBA9WVGr8i1s
         +OOh0iIM4nmpr5WN8J+DK5bNSF2hTUjq/lS7ft0wJk+k0Idy9EqWr6HxQ21JH3xqcX2C
         QpQLPkDkx9vZJLFvBUW3Z7plkekDjB+Lpxt9ipQi+RsblHJ9Og+mEGOOLR3zAq6IFVtF
         ASDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730922945; x=1731527745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sz8jpFca6SqfJ60+obKhkJJRmDB3H7XKSoVY6XiXXVw=;
        b=rb2ts7ctzxy/GNpzB3tvSaKx8GcigMdy+KQge2JUs4usB8Ln0f2mHlMyW+40HPeUYF
         vnqN7ryt3k2+kRqBk0KwdXYFbuwjkwIdDLHhdOvfYbkxYmriRcGgn8m6FUaA6I7vkyKF
         t9+94W8pkpt/VqZpEzmbKNoXpvTr6SN7GHQiyDzgRUDIblmM/hXIZLFCLvLgqvZIYrg6
         V4pBX4dGUGakL2utVihU3IgOiHMW8Y9z5vEyFTYePy7mrmaqYb043KCxAjsrzzYJIJPd
         majq9wyL0nrcRBNEGjv9yJZ2tYZ606q1KTLxRukxzsGy3YfaD9rfyQlWtV/EnuNXZ71C
         yF4g==
X-Forwarded-Encrypted: i=1; AJvYcCUeT2J8D65Auhw7TAwKmHb/4blWLVjpT2sHu2HkYXhA2BTb91eN04IIV3gAEO1wevHrG/nG3t9j0KyEx/0=@vger.kernel.org, AJvYcCWSs9eaC3TX3UbiUzc/iJvKQJgPYOPZy7Y1uDJZERtQI3WYloDYVSkJLnwRP2wYTi/AluNhGx20@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmgl2u0f+DML4U7ct+T84bsaV2bfyjxNfmt/5iW8wByWmkkzsb
	ziV25QDHKtF3fRc+rhjqopVux4zPW3NznBChiXXAab8zg1CLVEC9Jh1ufpm0PsKyqGxwds42kRL
	ooii7OK3/AJ4Wc/H+xaO+1DcCmcA=
X-Google-Smtp-Source: AGHT+IF2udQRzmHpiQvlWHqISilnXK7IsefQOlaY9vSnZF5qmLudxSk4K2ExJY2MYgmJugH+Y57WGNpI1w2K1sv76WY=
X-Received: by 2002:a5d:6d0b:0:b0:37d:509e:8742 with SMTP id
 ffacd0b85a97d-381c7a480f3mr17102742f8f.1.1730922943951; Wed, 06 Nov 2024
 11:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com> <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <0c146fb8-4c95-4832-941f-dfc3a465cf91@kernel.org> <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
 <18ba4489-ad30-423e-9c54-d4025f74c193@kernel.org> <b8b7818a-e44b-45f5-91c2-d5eceaa5dd5b@kernel.org>
In-Reply-To: <b8b7818a-e44b-45f5-91c2-d5eceaa5dd5b@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 6 Nov 2024 11:55:07 -0800
Message-ID: <CAKgT0UfkyLsfZGm0+T0Jyv=jO=tvS11vtD8MSR7s-EdZ4nGM+g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com, 
	Robin Murphy <robin.murphy@arm.com>, IOMMU <iommu@lists.linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>, Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 7:57=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 06/11/2024 14.25, Jesper Dangaard Brouer wrote:
> >
> > On 26/10/2024 09.33, Yunsheng Lin wrote:
> >> On 2024/10/25 22:07, Jesper Dangaard Brouer wrote:
> >>
> >> ...
> >>
> >>>
> >>>>> You and Jesper seems to be mentioning a possible fact that there mi=
ght
> >>>>> be 'hundreds of gigs of memory' needed for inflight pages, it would
> >>>>> be nice
> >>>>> to provide more info or reasoning above why 'hundreds of gigs of
> >>>>> memory' is
> >>>>> needed here so that we don't do a over-designed thing to support
> >>>>> recording
> >>>>> unlimited in-flight pages if the driver unbound stalling turns out
> >>>>> impossible
> >>>>> and the inflight pages do need to be recorded.
> >>>>
> >>>> I don't have a concrete example of a use that will blow the limit yo=
u
> >>>> are setting (but maybe Jesper does), I am simply objecting to the
> >>>> arbitrary imposing of any limit at all. It smells a lot of "640k oug=
ht
> >>>> to be enough for anyone".
> >>>>
> >>>
> >>> As I wrote before. In *production* I'm seeing TCP memory reach 24 GiB
> >>> (on machines with 384GiB memory). I have attached a grafana screensho=
t
> >>> to prove what I'm saying.
> >>>
> >>> As my co-worker Mike Freemon, have explain to me (and more details in
> >>> blogposts[1]). It is no coincident that graph have a strange "sealing=
"
> >>> close to 24 GiB (on machines with 384GiB total memory).  This is beca=
use
> >>> TCP network stack goes into a memory "under pressure" state when 6.25=
%
> >>> of total memory is used by TCP-stack. (Detail: The system will stay i=
n
> >>> that mode until allocated TCP memory falls below 4.68% of total memor=
y).
> >>>
> >>>   [1]
> >>> https://blog.cloudflare.com/unbounded-memory-usage-by-tcp-for-receive=
-buffers-and-how-we-fixed-it/
> >>
> >> Thanks for the info.
> >
> > Some more info from production servers.
> >
> > (I'm amazed what we can do with a simple bpftrace script, Cc Viktor)
> >
> > In below bpftrace script/oneliner I'm extracting the inflight count, fo=
r
> > all page_pool's in the system, and storing that in a histogram hash.
> >
> > sudo bpftrace -e '
> >   rawtracepoint:page_pool_state_release { @cnt[probe]=3Dcount();
> >    @cnt_total[probe]=3Dcount();
> >    $pool=3D(struct page_pool*)arg0;
> >    $release_cnt=3D(uint32)arg2;
> >    $hold_cnt=3D$pool->pages_state_hold_cnt;
> >    $inflight_cnt=3D(int32)($hold_cnt - $release_cnt);
> >    @inflight=3Dhist($inflight_cnt);
> >   }
> >   interval:s:1 {time("\n%H:%M:%S\n");
> >    print(@cnt); clear(@cnt);
> >    print(@inflight);
> >    print(@cnt_total);
> >   }'
> >
> > The page_pool behavior depend on how NIC driver use it, so I've run thi=
s
> > on two prod servers with drivers bnxt and mlx5, on a 6.6.51 kernel.
> >
> > Driver: bnxt_en
> > - kernel 6.6.51
> >
> > @cnt[rawtracepoint:page_pool_state_release]: 8447
> > @inflight:
> > [0]             507 |                                        |
> > [1]             275 |                                        |
> > [2, 4)          261 |                                        |
> > [4, 8)          215 |                                        |
> > [8, 16)         259 |                                        |
> > [16, 32)        361 |                                        |
> > [32, 64)        933 |                                        |
> > [64, 128)      1966 |                                        |
> > [128, 256)   937052 |@@@@@@@@@                               |
> > [256, 512)  5178744 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [512, 1K)     73908 |                                        |
> > [1K, 2K)    1220128 |@@@@@@@@@@@@                            |
> > [2K, 4K)    1532724 |@@@@@@@@@@@@@@@                         |
> > [4K, 8K)    1849062 |@@@@@@@@@@@@@@@@@@                      |
> > [8K, 16K)   1466424 |@@@@@@@@@@@@@@                          |
> > [16K, 32K)   858585 |@@@@@@@@                                |
> > [32K, 64K)   693893 |@@@@@@                                  |
> > [64K, 128K)  170625 |@                                       |
> >
> > Driver: mlx5_core
> >   - Kernel: 6.6.51
> >
> > @cnt[rawtracepoint:page_pool_state_release]: 1975
> > @inflight:
> > [128, 256)         28293 |@@@@                               |
> > [256, 512)        184312 |@@@@@@@@@@@@@@@@@@@@@@@@@@@        |
> > [512, 1K)              0 |                                   |
> > [1K, 2K)            4671 |                                   |
> > [2K, 4K)          342571 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [4K, 8K)          180520 |@@@@@@@@@@@@@@@@@@@@@@@@@@@        |
> > [8K, 16K)          96483 |@@@@@@@@@@@@@@                     |
> > [16K, 32K)         25133 |@@@                                |
> > [32K, 64K)          8274 |@                                  |
> >
> >
> > The key thing to notice that we have up-to 128,000 pages in flight on
> > these random production servers. The NIC have 64 RX queue configured,
> > thus also 64 page_pool objects.
> >
>
> I realized that we primarily want to know the maximum in-flight pages.
>
> So, I modified the bpftrace oneliner to track the max for each page_pool
> in the system.
>
> sudo bpftrace -e '
>   rawtracepoint:page_pool_state_release { @cnt[probe]=3Dcount();
>    @cnt_total[probe]=3Dcount();
>    $pool=3D(struct page_pool*)arg0;
>    $release_cnt=3D(uint32)arg2;
>    $hold_cnt=3D$pool->pages_state_hold_cnt;
>    $inflight_cnt=3D(int32)($hold_cnt - $release_cnt);
>    $cur=3D@inflight_max[$pool];
>    if ($inflight_cnt > $cur) {
>      @inflight_max[$pool]=3D$inflight_cnt;}
>   }
>   interval:s:1 {time("\n%H:%M:%S\n");
>    print(@cnt); clear(@cnt);
>    print(@inflight_max);
>    print(@cnt_total);
>   }'
>
> I've attached the output from the script.
> For unknown reason this system had 199 page_pool objects.
>
> The 20 top users:
>
> $ cat out02.inflight-max | grep inflight_max | tail -n 20
> @inflight_max[0xffff88829133d800]: 26473
> @inflight_max[0xffff888293c3e000]: 27042
> @inflight_max[0xffff888293c3b000]: 27709
> @inflight_max[0xffff8881076f2800]: 29400
> @inflight_max[0xffff88818386e000]: 29690
> @inflight_max[0xffff8882190b1800]: 29813
> @inflight_max[0xffff88819ee83800]: 30067
> @inflight_max[0xffff8881076f4800]: 30086
> @inflight_max[0xffff88818386b000]: 31116
> @inflight_max[0xffff88816598f800]: 36970
> @inflight_max[0xffff8882190b7800]: 37336
> @inflight_max[0xffff888293c38800]: 39265
> @inflight_max[0xffff888293c3c800]: 39632
> @inflight_max[0xffff888293c3b800]: 43461
> @inflight_max[0xffff888293c3f000]: 43787
> @inflight_max[0xffff88816598f000]: 44557
> @inflight_max[0xffff888132ce9000]: 45037
> @inflight_max[0xffff888293c3f800]: 51843
> @inflight_max[0xffff888183869800]: 62612
> @inflight_max[0xffff888113d08000]: 73203
>
> Adding all values together:
>
>   grep inflight_max out02.inflight-max | awk 'BEGIN {tot=3D0} {tot+=3D$2;
> printf "total:" tot "\n"}' | tail -n 1
>
> total:1707129
>
> Worst case we need a data structure holding 1,707,129 pages.
> Fortunately, we don't need a single data structure as this will be split
> between 199 page_pool's.
>
> --Jesper

Is there any specific reason for why we need to store the pages
instead of just scanning the page tables to look for them? We should
already know how many we need to look for and free. If we were to just
scan the page structs and identify the page pool pages that are
pointing to our pool we should be able to go through and clean them
up. It won't be the fastest approach, but this should be an
exceptional case to handle things like a hot plug removal of a device
where we can essentially run this in the background before we free the
device.

Then it would just be a matter of modifying the pool so that it will
drop support for doing DMA unmapping and essentially just become a
place for the freed pages to go to die.

