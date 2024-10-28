Return-Path: <netdev+bounces-139577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD719B34F1
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 16:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C01B21EE4
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A831DCB2A;
	Mon, 28 Oct 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akwGTSEX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8CC1862BB;
	Mon, 28 Oct 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129486; cv=none; b=B9O3pp00idP1yMwp4bfXk3JssWVjvZTziRgZfV24ggzBiOGYRblM5/8sYzd6xinaKK0Xr2JXhZen7/GrH7m2slhrHl+XiCUeNo9UV3hMRM4QsGs514u2ezV63AlEAenpgbsyv1wEiVJb+Pb4+vzSrp4GHYTw4goqGkkox/VBw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129486; c=relaxed/simple;
	bh=c3wmuMdJ6LAAbDIv7o3xW3/2wvmVNAoTjkjygTiWF6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gii7U4jT5xm8e1fIYDnAiE8+nT9HlL4+NyPeZjTX3TfL3cHdCNj/pmpclDkc7D0yGcqSHMo6ideNisMV71gy86RRiFoUL6WxCIUKJueaV1uGdztmsGO2snTEPjUCZwgNI/cxSzHC9YOJADutIv4FsEYRUSVgzP3oSW6ZuaXGepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akwGTSEX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so44997025e9.0;
        Mon, 28 Oct 2024 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730129482; x=1730734282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdQ4vs11iNmJD8fN5ThoN3BSV2oBoJ+cRoPmnNutZrU=;
        b=akwGTSEXkwLxCgx3h4tpWQPdmxb86qB9xVlWDsVPtteauBJj7eYYCvXSBcsQJuXvDE
         DFya9zTSFN1yLGSO2YwRT9C1GbRiqTMzflNyDrtCpzX0vlqyhaVfuaegg+sJqLNt5kxz
         EMSa20Mg2Cc2go3ogZV7F1oQrAw1jzmgnSvbLlJ75/rHrKZIQ4GLYjfSXxnd/6uS6ENG
         I3xHb2uKcul4j8ox9iw/+WJXIFvTUIClHirIqqeEdWdeEyuXfIbReTqTNkq0+X0KNwyb
         ZNIuBojVBkUL876Rlrts3Bk9t0u5JQezs9LvitLpQ8YBggASOSasu3cTYWky6Irwz59b
         d86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730129482; x=1730734282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdQ4vs11iNmJD8fN5ThoN3BSV2oBoJ+cRoPmnNutZrU=;
        b=PttSM5qk4ANMObdndgGCZMXZY+8LyC8GczA7ttOvkCrdWpgdw1liqaVYD7UTLBNkpy
         4pu06rIEp3jFLdDGqg5GDw36VuzWSxKWOcTNCQjNgBNw9DMsRNgoSM31RT2QH0Alf6cP
         OCGeDBVaAM6YEqOezGvnKdHxNtH8MHtcllxlpCrPiza2jRcnnGnbURBD1XrP9Dp0fprU
         sobtA9sGMORMGUiOC8mM+VAmpyJu/9286W/8MZw131XWfTfQU5eJJj9a3XD9ZjyaPyA1
         VBUfzEXJTYfWOBi3TZvDwBOsdXWST4gZdJowZdfxJEYE4cQhWH5GEVVz1d7uJ8s3tUxm
         TqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIjt2hS3UCdgbgs5K9jTTN9EWNbfWlX3cr0ShZEzyN8U32Cmo8q9pQlLG3pxKVXpToILGlCLUd@vger.kernel.org, AJvYcCVpESIkUTq6RkL4uP7MeUQK2oZV5/ZVUrXcqfqhkMLTVSZaiGSGYCzzO8nlFTLOsnnIVMJ4Z4SjRqTJ8Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWl1Oeo3G8MbMN+/aJWqapCT1AlzIAmhIHCA+roUCfguRH/zIl
	cqjw7IJRaBs+ba+EaFbarlc8fXpNuejLs+uM6vbrH/VTanOxM9tYM+fWZb9wQcrZmy/jHe4Bcra
	8h8sAuMpyW423X+ZfldNmSIRdETo=
X-Google-Smtp-Source: AGHT+IHJOzDlndQVn/Lo0VLu1f2PcdBMfILUNivm5fodUlndiwZCL2w3KID7GCjlNVbZK5g4+g92PYUnVn8fyBUg/do=
X-Received: by 2002:adf:f74b:0:b0:37c:d2f3:b3b0 with SMTP id
 ffacd0b85a97d-38061144954mr6400481f8f.23.1730129481489; Mon, 28 Oct 2024
 08:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
In-Reply-To: <20241028115343.3405838-1-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 28 Oct 2024 08:30:45 -0700
Message-ID: <CAKgT0UdUVo6ujupoo-hdrW95XOGQLCDzd+rHGUVB6_SEmvqFHg@mail.gmail.com>
Subject: Re: [PATCH net-next v23 0/7] Replace page_frag with page_frag_cache (Part-1)
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:00=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> This is part 1 of "Replace page_frag with page_frag_cache",
> which mainly contain refactoring and optimization for the
> implementation of page_frag API before the replacing.
>
> As the discussion in [1], it would be better to target net-next
> tree to get more testing as all the callers page_frag API are
> in networking, and the chance of conflicting with MM tree seems
> low as implementation of page_frag API seems quite self-contained.
>
> After [2], there are still two implementations for page frag:
>
> 1. mm/page_alloc.c: net stack seems to be using it in the
>    rx part with 'struct page_frag_cache' and the main API
>    being page_frag_alloc_align().
> 2. net/core/sock.c: net stack seems to be using it in the
>    tx part with 'struct page_frag' and the main API being
>    skb_page_frag_refill().
>
> This patchset tries to unfiy the page frag implementation
> by replacing page_frag with page_frag_cache for sk_page_frag()
> first. net_high_order_alloc_disable_key for the implementation
> in net/core/sock.c doesn't seems matter that much now as pcp
> is also supported for high-order pages:
> commit 44042b449872 ("mm/page_alloc: allow high-order pages to
> be stored on the per-cpu lists")
>
> As the related change is mostly related to networking, so
> targeting the net-next. And will try to replace the rest
> of page_frag in the follow patchset.
>
> After this patchset:
> 1. Unify the page frag implementation by taking the best out of
>    two the existing implementations: we are able to save some space
>    for the 'page_frag_cache' API user, and avoid 'get_page()' for
>    the old 'page_frag' API user.
> 2. Future bugfix and performance can be done in one place, hence
>    improving maintainability of page_frag's implementation.
>
> Kernel Image changing:
>     Linux Kernel   total |      text      data        bss
>     ------------------------------------------------------
>     after     45250307 |   27274279   17209996     766032
>     before    45254134 |   27278118   17209984     766032
>     delta        -3827 |      -3839        +12         +0
>
> Performance validation:
> 1. Using micro-benchmark ko added in patch 1 to test aligned and
>    non-aligned API performance impact for the existing users, there
>    is no notiable performance degradation. Instead we seems to have
>    some major performance boot for both aligned and non-aligned API
>    after switching to ptr_ring for testing, respectively about 200%
>    and 10% improvement in arm64 server as below.
>
> 2. Use the below netcat test case, we also have some minor
>    performance boot for replacing 'page_frag' with 'page_frag_cache'
>    after this patchset.
>    server: taskset -c 32 nc -l -k 1234 > /dev/null
>    client: perf stat -r 200 -- taskset -c 0 head -c 20G /dev/zero | tasks=
et -c 1 nc 127.0.0.1 1234
>
> In order to avoid performance noise as much as possible, the testing
> is done in system without any other load and have enough iterations to
> prove the data is stable enough, complete log for testing is below:
>
> perf stat -r 200 -- insmod ./page_frag_test.ko test_push_cpu=3D16 test_po=
p_cpu=3D17 test_alloc_len=3D12 nr_test=3D51200000
> perf stat -r 200 -- insmod ./page_frag_test.ko test_push_cpu=3D16 test_po=
p_cpu=3D17 test_alloc_len=3D12 nr_test=3D51200000 test_align=3D1
> taskset -c 32 nc -l -k 1234 > /dev/null
> perf stat -r 200 -- taskset -c 0 head -c 20G /dev/zero | taskset -c 1 nc =
127.0.0.1 1234
>
> *After* this patchset:
>
>  Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D16 test_pop_cpu=3D17 test_alloc_len=3D12 nr_test=3D51200000' (200 runs):
>
>          17.758393      task-clock (msec)         #    0.004 CPUs utilize=
d            ( +-  0.51% )
>                  5      context-switches          #    0.293 K/sec       =
             ( +-  0.65% )
>                  0      cpu-migrations            #    0.008 K/sec       =
             ( +- 17.21% )
>                 74      page-faults               #    0.004 M/sec       =
             ( +-  0.12% )
>           46128650      cycles                    #    2.598 GHz         =
             ( +-  0.51% )
>           60810511      instructions              #    1.32  insn per cyc=
le           ( +-  0.04% )
>           14764914      branches                  #  831.433 M/sec       =
             ( +-  0.04% )
>              19281      branch-misses             #    0.13% of all branc=
hes          ( +-  0.13% )
>
>        4.240273854 seconds time elapsed                                  =
        ( +-  0.13% )
>
>  Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D16 test_pop_cpu=3D17 test_alloc_len=3D12 nr_test=3D51200000 test_align=
=3D1' (200 runs):
>
>          17.348690      task-clock (msec)         #    0.019 CPUs utilize=
d            ( +-  0.66% )
>                  5      context-switches          #    0.310 K/sec       =
             ( +-  0.84% )
>                  0      cpu-migrations            #    0.009 K/sec       =
             ( +- 16.55% )
>                 74      page-faults               #    0.004 M/sec       =
             ( +-  0.11% )
>           45065287      cycles                    #    2.598 GHz         =
             ( +-  0.66% )
>           60755389      instructions              #    1.35  insn per cyc=
le           ( +-  0.05% )
>           14747865      branches                  #  850.085 M/sec       =
             ( +-  0.05% )
>              19272      branch-misses             #    0.13% of all branc=
hes          ( +-  0.13% )
>
>        0.935251375 seconds time elapsed                                  =
        ( +-  0.07% )
>
>  Performance counter stats for 'taskset -c 0 head -c 20G /dev/zero' (200 =
runs):
>
>       16626.042731      task-clock (msec)         #    0.607 CPUs utilize=
d            ( +-  0.03% )
>            3291020      context-switches          #    0.198 M/sec       =
             ( +-  0.05% )
>                  1      cpu-migrations            #    0.000 K/sec       =
             ( +-  0.50% )
>                 85      page-faults               #    0.005 K/sec       =
             ( +-  0.16% )
>        30581044838      cycles                    #    1.839 GHz         =
             ( +-  0.05% )
>        34962744631      instructions              #    1.14  insn per cyc=
le           ( +-  0.01% )
>         6483883671      branches                  #  389.984 M/sec       =
             ( +-  0.02% )
>           99624551      branch-misses             #    1.54% of all branc=
hes          ( +-  0.17% )
>
>       27.370305077 seconds time elapsed                                  =
        ( +-  0.01% )
>
>
> *Before* this patchset:
>
> Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D16 test_pop_cpu=3D17 test_alloc_len=3D12 nr_test=3D51200000' (200 runs):
>
>          21.587934      task-clock (msec)         #    0.005 CPUs utilize=
d            ( +-  0.72% )
>                  6      context-switches          #    0.281 K/sec       =
             ( +-  0.28% )
>                  1      cpu-migrations            #    0.047 K/sec       =
             ( +-  0.50% )
>                 73      page-faults               #    0.003 M/sec       =
             ( +-  0.12% )
>           56080697      cycles                    #    2.598 GHz         =
             ( +-  0.72% )
>           61605150      instructions              #    1.10  insn per cyc=
le           ( +-  0.05% )
>           14950196      branches                  #  692.526 M/sec       =
             ( +-  0.05% )
>              19410      branch-misses             #    0.13% of all branc=
hes          ( +-  0.18% )
>
>        4.603530546 seconds time elapsed                                  =
        ( +-  0.11% )
>
>  Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=
=3D16 test_pop_cpu=3D17 test_alloc_len=3D12 nr_test=3D51200000 test_align=
=3D1' (200 runs):
>
>          20.988297      task-clock (msec)         #    0.006 CPUs utilize=
d            ( +-  0.81% )
>                  7      context-switches          #    0.316 K/sec       =
             ( +-  0.54% )
>                  1      cpu-migrations            #    0.048 K/sec       =
             ( +-  0.70% )
>                 73      page-faults               #    0.003 M/sec       =
             ( +-  0.11% )
>           54512166      cycles                    #    2.597 GHz         =
             ( +-  0.81% )
>           61440941      instructions              #    1.13  insn per cyc=
le           ( +-  0.08% )
>           14906043      branches                  #  710.207 M/sec       =
             ( +-  0.08% )
>              19927      branch-misses             #    0.13% of all branc=
hes          ( +-  0.17% )
>
>        3.438041238 seconds time elapsed                                  =
        ( +-  1.11% )
>
>  Performance counter stats for 'taskset -c 0 head -c 20G /dev/zero' (200 =
runs):
>
>       17364.040855      task-clock (msec)         #    0.624 CPUs utilize=
d            ( +-  0.02% )
>            3340375      context-switches          #    0.192 M/sec       =
             ( +-  0.06% )
>                  1      cpu-migrations            #    0.000 K/sec
>                 85      page-faults               #    0.005 K/sec       =
             ( +-  0.15% )
>        32077623335      cycles                    #    1.847 GHz         =
             ( +-  0.03% )
>        35121047596      instructions              #    1.09  insn per cyc=
le           ( +-  0.01% )
>         6519872824      branches                  #  375.481 M/sec       =
             ( +-  0.02% )
>          101877022      branch-misses             #    1.56% of all branc=
hes          ( +-  0.14% )
>
>       27.842745343 seconds time elapsed                                  =
        ( +-  0.02% )
>
>

Is this actually the numbers for this patch set? Seems like you have
been using the same numbers for the last several releases. I can
understand the "before" being mostly the same, but since we have
factored out the refactor portion of it the numbers for the "after"
should have deviated as I find it highly unlikely the numbers are
exactly the same down to the nanosecond. from the previous patch set.

Also it wouldn't hurt to have an explanation for the 3.4->0.9 second
performance change as it seems like the samples don't seem to match up
with the elapsed time data.

