Return-Path: <netdev+bounces-139980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCCF9B4E5D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4360B1F2320F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC94194A52;
	Tue, 29 Oct 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxSOE+Tk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F7802;
	Tue, 29 Oct 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216753; cv=none; b=oFae4WHjNZxtkCFR+esW8EvsIkam2fT/TpB6HLOsuTnQzh7oIRv0P1G6qJdKv+Gk3RtyajO4fN0crCwx+zPCngQD2eV5F1jUHoN/QcIF6eQRd5DZGwQRM9cTVoiVaS9Gi3cUka1EpbrrmhfBNTOAf5+9OpgMkIDOoM/F1ektqhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216753; c=relaxed/simple;
	bh=fuX65lgpFRP3KkR50Ce9GsTOs636jzdyePmpIEh81jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esTFz/32wHNAs88cBmZo7KUWqSb6ntwbQ0AMFYKA8F8WnEgpLScVBHhJYne1BPYkgSZkmrlS9k1HXJ2xWRqxAw29Vz0A3I8jM5/p6G+yZ9QybWEqcHgCqJGElyF+aiJAMQcOCmU3sjhkhMAlQRSzTRfZyTagaULmJs/cyFjCZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxSOE+Tk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so53521455e9.3;
        Tue, 29 Oct 2024 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730216749; x=1730821549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66bPwhKpwBfWPtZQFUTRwh4k/Kr/jGoFRaplIb/urhQ=;
        b=BxSOE+TkgXQFrAgLOSV5jssr5GYYm7wVl//U1nxTGsEj0g302++gRaG16v8/HQzSEs
         Mleea5PDvOBAoDy+Cfhm4FRhvByYoqJtx3KSMRltiuOtxjzr6V63ndDqG6PFM8P1F0Mf
         +Xg99mZnYTe4CU0I+ifU/sFDRyWtPA+JCbQXuQgCLcfqxwIDeos+UzDvWvFqtT1VgL1T
         8rh0SwAR07VQthwFjGl5nReG+46CAQqhi+xhu7leqWySUrc3xujdCI+LRqBsYEkeiF7E
         5LOfcOEmGqk/dV4nZ/GVgRxUq3I7UrN1nAM1M1uPwBay+hAWzzzDhBk1V+G5f6yXZawV
         v3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730216749; x=1730821549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66bPwhKpwBfWPtZQFUTRwh4k/Kr/jGoFRaplIb/urhQ=;
        b=n1e+Fr4Wd6gEki7xTEQ4x138fllPMCTjK0qcZHyFaTS2c8Bv/EK22yiHVszH8vGHPj
         i0ZOjI3hAshuaSqD9BC67kduYnpGhi0/+pRz4YFam8n8BdBC4wxIdO4S1ClAyLr4ku4c
         pM3GORKdQ0gQam73OJVk5E+D14Ci1vz/4XBVN9Y28DNuwp0mPzGDznUC4MkIsjpGKcom
         1RNSrjjhVT5BPcvJUPXs3dfMHRlek3HbRRwem0br6F6A7dnSrRnEWAvP6LKtQdf20bN1
         m5RBYrr/dCbuGjRY6yEFWJ+Z953kwrA+cEr/7g1BdQY6tM7/3k0iK3ffNs6UcGSAO2dW
         BTpw==
X-Forwarded-Encrypted: i=1; AJvYcCWJdvJdj4JjWZ4Do+MrJO3VGuNc1uNh2Cnbnykl3RaqrnVuaVCNC1NyJj++jai5tAW7nhDZMMdOzdZ9KCI=@vger.kernel.org, AJvYcCXBiF587DAh4iyDvvSsoIJNiDW0UrRGmwzUnBWTK51hZYIs+h6QnyXmxf74VfkoBGqsBBgiYRPW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Jyeic6q131u/WHlOjX+MnEm/O3FTQxWPLwytSkwX9YcVfD3h
	3oCNWlfDDZa64dbF77LZW1j96pwOFvZZXrScrBeoBxz2hIEJm6qwEW9IBIpVy2wvNxm9Ug5spI0
	Wh85aYjVpntnJSkQHQvyOIt96414Q0g==
X-Google-Smtp-Source: AGHT+IHjdP0h77G5PKkwY5FAMADMzotz+qaNx7ZVIir4IUyDNtdiKXwpdMqyd4HrTmzhtUJc+f5ugwaBXjqng2JEcRc=
X-Received: by 2002:a05:600c:4fd3:b0:431:52b7:a485 with SMTP id
 5b1f17b1804b1-431bb98fc9fmr1818785e9.19.1730216748967; Tue, 29 Oct 2024
 08:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
 <CAKgT0UdUVo6ujupoo-hdrW95XOGQLCDzd+rHGUVB6_SEmvqFHg@mail.gmail.com> <472a7a09-387f-480d-b66c-761e0b6192ef@huawei.com>
In-Reply-To: <472a7a09-387f-480d-b66c-761e0b6192ef@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 29 Oct 2024 08:45:11 -0700
Message-ID: <CAKgT0UdzFYyWjku=RfD7QXjTGeBFiBKQcKPXJW-Jx8YYuxePxA@mail.gmail.com>
Subject: Re: [PATCH net-next v23 0/7] Replace page_frag with page_frag_cache (Part-1)
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 2:36=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/10/28 23:30, Alexander Duyck wrote:
>
> ...
>
> >>
> >>
> >
> > Is this actually the numbers for this patch set? Seems like you have
> > been using the same numbers for the last several releases. I can
>
> Yes, as recent refactoring doesn't seems big enough that the perf data is
> reused for the last several releases.
>
> > understand the "before" being mostly the same, but since we have
>
> As there is rebasing for the latest net-next tree, even the 'before'
> might not be the same as the testing seems sensitive to other changing,
> like binary size changing and page allocator changing during different
> version.
>
> So it might need both the same kernel and config for 'before' and 'after'=
.
>
> > factored out the refactor portion of it the numbers for the "after"
> > should have deviated as I find it highly unlikely the numbers are
> > exactly the same down to the nanosecond. from the previous patch set.
> Below is the the performance data for Part-1 with the latest net-next:
>
> Before this patchset:
>  Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D16 test_pop_cpu=3D17 test_alloc_len=3D12 nr_test=3D51200000' (200 runs):
>
>          17.990790      task-clock (msec)         #    0.003 CPUs utilize=
d            ( +-  0.19% )
>                  8      context-switches          #    0.444 K/sec       =
             ( +-  0.09% )
>                  0      cpu-migrations            #    0.000 K/sec       =
             ( +-100.00% )
>                 81      page-faults               #    0.004 M/sec       =
             ( +-  0.09% )
>           46712295      cycles                    #    2.596 GHz         =
             ( +-  0.19% )
>           34466157      instructions              #    0.74  insn per cyc=
le           ( +-  0.01% )
>            8011755      branches                  #  445.325 M/sec       =
             ( +-  0.01% )
>              39913      branch-misses             #    0.50% of all branc=
hes          ( +-  0.07% )
>
>        6.382252558 seconds time elapsed                                  =
        ( +-  0.07% )
>
>  Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D16 test_pop_cpu=3D17 test_alloc_len=3D12 nr_test=3D51200000 test_align=
=3D1' (200 runs):
>
>          17.638466      task-clock (msec)         #    0.003 CPUs utilize=
d            ( +-  0.01% )
>                  8      context-switches          #    0.451 K/sec       =
             ( +-  0.20% )
>                  0      cpu-migrations            #    0.001 K/sec       =
             ( +- 70.53% )
>                 81      page-faults               #    0.005 M/sec       =
             ( +-  0.08% )
>           45794305      cycles                    #    2.596 GHz         =
             ( +-  0.01% )
>           34435077      instructions              #    0.75  insn per cyc=
le           ( +-  0.00% )
>            8004416      branches                  #  453.805 M/sec       =
             ( +-  0.00% )
>              39758      branch-misses             #    0.50% of all branc=
hes          ( +-  0.06% )
>
>        5.328976590 seconds time elapsed                                  =
        ( +-  0.60% )
>
>
> After this patchset:
> Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D16 test_pop_cpu=3D17 test_alloc_len=3D12 nr_test=3D51200000' (200 runs):
>
>          18.647432      task-clock (msec)         #    0.003 CPUs utilize=
d            ( +-  1.11% )
>                  8      context-switches          #    0.422 K/sec       =
             ( +-  0.36% )
>                  0      cpu-migrations            #    0.005 K/sec       =
             ( +- 22.54% )
>                 81      page-faults               #    0.004 M/sec       =
             ( +-  0.08% )
>           48418108      cycles                    #    2.597 GHz         =
             ( +-  1.11% )
>           35889299      instructions              #    0.74  insn per cyc=
le           ( +-  0.11% )
>            8318363      branches                  #  446.086 M/sec       =
             ( +-  0.11% )
>              19263      branch-misses             #    0.23% of all branc=
hes          ( +-  0.13% )
>
>        5.624666079 seconds time elapsed                                  =
        ( +-  0.07% )
>
>
>  Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D16 test_pop_cpu=3D17 test_alloc_len=3D12 nr_test=3D51200000 test_align=
=3D1' (200 runs):
>
>          18.466768      task-clock (msec)         #    0.007 CPUs utilize=
d            ( +-  1.23% )
>                  8      context-switches          #    0.428 K/sec       =
             ( +-  0.26% )
>                  0      cpu-migrations            #    0.002 K/sec       =
             ( +- 34.73% )
>                 81      page-faults               #    0.004 M/sec       =
             ( +-  0.09% )
>           47949220      cycles                    #    2.597 GHz         =
             ( +-  1.23% )
>           35859039      instructions              #    0.75  insn per cyc=
le           ( +-  0.12% )
>            8309086      branches                  #  449.948 M/sec       =
             ( +-  0.11% )
>              19246      branch-misses             #    0.23% of all branc=
hes          ( +-  0.08% )
>
>        2.573546035 seconds time elapsed                                  =
        ( +-  0.04% )
>

Interesting. It doesn't look like too much changed in terms of most of
the metrics other than the fact that we reduced the number of branch
misses by just over half.

> >
> > Also it wouldn't hurt to have an explanation for the 3.4->0.9 second
> > performance change as it seems like the samples don't seem to match up
> > with the elapsed time data.
>
> As there is also a 4.6->3.4 second performance change for the 'before'
> part, I am not really thinking much at that.
>
> I am guessing some timing for implementation of ptr_ring or cpu cache
> cause the above performance change?
>
> I used the same cpu for both pop and push thread, the performance change
> doesn't seems to exist anymore, and the performance improvement doesn't
> seems to exist anymore either:
>
> After this patchset:
>  Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D0 test_pop_cpu=3D0 test_alloc_len=3D12 nr_test=3D512000' (10 runs):
>
>          13.293402      task-clock (msec)         #    0.002 CPUs utilize=
d            ( +-  5.05% )
>                  7      context-switches          #    0.534 K/sec       =
             ( +-  1.41% )
>                  0      cpu-migrations            #    0.015 K/sec       =
             ( +-100.00% )
>                 80      page-faults               #    0.006 M/sec       =
             ( +-  0.38% )
>           34494793      cycles                    #    2.595 GHz         =
             ( +-  5.05% )
>            9663299      instructions              #    0.28  insn per cyc=
le           ( +-  1.45% )
>            1767284      branches                  #  132.944 M/sec       =
             ( +-  1.70% )
>              19798      branch-misses             #    1.12% of all branc=
hes          ( +-  1.18% )
>
>        8.119681413 seconds time elapsed                                  =
        ( +-  0.01% )
>
>  Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D0 test_pop_cpu=3D0 test_alloc_len=3D12 nr_test=3D512000 test_align=3D1' =
(10 runs):
>
>          12.289096      task-clock (msec)         #    0.002 CPUs utilize=
d            ( +-  0.07% )
>                  7      context-switches          #    0.570 K/sec       =
             ( +-  2.13% )
>                  0      cpu-migrations            #    0.033 K/sec       =
             ( +- 66.67% )
>                 81      page-faults               #    0.007 M/sec       =
             ( +-  0.43% )
>           31886319      cycles                    #    2.595 GHz         =
             ( +-  0.07% )
>            9468850      instructions              #    0.30  insn per cyc=
le           ( +-  0.06% )
>            1723487      branches                  #  140.245 M/sec       =
             ( +-  0.05% )
>              19263      branch-misses             #    1.12% of all branc=
hes          ( +-  0.47% )
>
>        8.119686950 seconds time elapsed                                  =
        ( +-  0.01% )
>
> Before this patchset:
>  Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D0 test_pop_cpu=3D0 test_alloc_len=3D12 nr_test=3D512000' (10 runs):
>
>          13.320328      task-clock (msec)         #    0.002 CPUs utilize=
d            ( +-  5.00% )
>                  7      context-switches          #    0.541 K/sec       =
             ( +-  1.85% )
>                  0      cpu-migrations            #    0.008 K/sec       =
             ( +-100.00% )
>                 80      page-faults               #    0.006 M/sec       =
             ( +-  0.36% )
>           34572091      cycles                    #    2.595 GHz         =
             ( +-  5.01% )
>            9664910      instructions              #    0.28  insn per cyc=
le           ( +-  1.51% )
>            1768276      branches                  #  132.750 M/sec       =
             ( +-  1.80% )
>              19592      branch-misses             #    1.11% of all branc=
hes          ( +-  1.33% )
>
>        8.119686381 seconds time elapsed                                  =
        ( +-  0.01% )
>
>  Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D0 test_pop_cpu=3D0 test_alloc_len=3D12 nr_test=3D512000 test_align=3D1' =
(10 runs):
>
>          12.306471      task-clock (msec)         #    0.002 CPUs utilize=
d            ( +-  0.08% )
>                  7      context-switches          #    0.585 K/sec       =
             ( +-  1.85% )
>                  0      cpu-migrations            #    0.000 K/sec
>                 80      page-faults               #    0.007 M/sec       =
             ( +-  0.28% )
>           31937686      cycles                    #    2.595 GHz         =
             ( +-  0.08% )
>            9462218      instructions              #    0.30  insn per cyc=
le           ( +-  0.08% )
>            1721989      branches                  #  139.925 M/sec       =
             ( +-  0.07% )
>              19114      branch-misses             #    1.11% of all branc=
hes          ( +-  0.31% )
>
>        8.118897296 seconds time elapsed                                  =
        ( +-  0.00% )

That isn't too surprising. Most likely you are at the mercy of the
scheduler and you are just waiting for it to cycle back and forth from
producer to consumer and back in order to allow you to complete the
test.

