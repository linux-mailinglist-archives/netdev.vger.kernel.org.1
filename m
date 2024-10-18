Return-Path: <netdev+bounces-137083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447B99A4520
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D711C2308E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58A20403F;
	Fri, 18 Oct 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHxk4GJq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B8A2040A7;
	Fri, 18 Oct 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273183; cv=none; b=hJJQo0IlEFhVXF8G5vqizr9lUynzllEnzWyw8+fGq4P5ekH12TrHMOCNDQvsvQTaspABCepUiA0lPZhzkFfn2n16oR2CWI4KCzeJ036+Qysut3F/+e4YkAJIYcFRmmCx4hwxEnkpO/IpggJgfuu+dowoUWA80FNE03VxvJiUvqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273183; c=relaxed/simple;
	bh=yUJF5lQ/HksuBemm3uZw6pkqyzUQSmaorwLeuiHQFlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLKCw16GKaJ6+PLF6+y5i3ICX680KTHQEcAfEyyb8p0m2roYusiUk4mAZG//+6UZpqlmyy9pWSvO0XRgBrCE1EflQ90TmJFQwj+PqS8ZyU4nG02Xy/2D4Lek6RfCadIpyfNDzB9T/mM1JNn4ETR8CNT1F4Ne27g5v1NKOxnCXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHxk4GJq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431195c3538so21731165e9.3;
        Fri, 18 Oct 2024 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729273179; x=1729877979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJoEoIi8PCw2HyhDJP4sL8slKSJjLQ+CubKYpgJKLQE=;
        b=aHxk4GJqdAU5RavPuQy+h1/qn2g9zcKdMAtyHn9Z/6vNWfvOnq/52euGUXboSUdUm8
         DV4TvXToRJTIkcndPr8+MuzvQDH70cuuZXpeyv+vbKeUQ8hQK4x8IL75PNLVt7T1YogX
         au8LL2AwgBZ5AR040wyoCk3rJBjpA6ekAly80DYeLUnY+ULD+XRYJXUDT06CI28gpMVK
         nZm3NXwxjKUyCwZI3OlVAb/ajLZf+C75gJ/42nRgt5vAVJhSuladalA4kR7vcP3hBYbl
         fbzBB1sRP6jxQpQikl+h0GFOJImTkF61cNeqWzim5hQA7MOVamOr+Pe24lAzjLK/pnhs
         Jjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729273179; x=1729877979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJoEoIi8PCw2HyhDJP4sL8slKSJjLQ+CubKYpgJKLQE=;
        b=dhRaEy9exf19m5fiNN0Hyx+YJYqkck44OAuIjZgll8mzoBuOm7NBEEdD7qShCzlGt/
         jB9WM0h5Dd4mXB/bCpebA8PWW9+A0Xda7VAGbfqyd4Q6g5tn8x2PqJAElLKWprbcm9ia
         A8s9Lp9MLbECNFA0sURjSHuLMw7V+8HOl9POiTJP+GppHPdPCwFb1qBm0ltQ0HpuMrXI
         NfCizqemPp5MrmkZ7ZDu3vI2VKZx6szhdUSEzlwCCfuWK/VT2XLhdC1xHytQ7x0H293i
         JdiSmBv4IYMYoeXOJU4eT/xoA9khCPFKbSvMPplY/w5iLiYpM/hd2PvZb2edd/F6nRPG
         OMLA==
X-Forwarded-Encrypted: i=1; AJvYcCVA32vQ+xBmOInIDgOrMkKkhNbitn5pMldyNgWmikMP+COpysABF8FCZX9CevN/BBQ/AYm2iylt@vger.kernel.org, AJvYcCW07Em0gMI/iCyFviL0Bw5MUiDOzKw2/vSlm+MUigNrQZEbT1B7GjigoXx6z4w7JLRl8tFbHHriIL3CceU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfLg2Bu5LUVNX5pDCLuFWuyWpy2C0oV56k0aZVdd5Ev+75RlQ
	lmuyPCBodmUAA3qqiDZyjqym6ARjM/vKFzOoZ0ItRx0Y/adVD30efrYzgffRPtVaIU6/wn8PW4A
	jYmSXMAyffEnGnIJtn3KVfrjb8Sk=
X-Google-Smtp-Source: AGHT+IHWLp+B1UjmgXd+KI44SKKzL6vpcvzDVhwqnh8ZXuHdNSpF5VtKvJi95ezinOvIFYvB92b9N56AVNtHJmhbClg=
X-Received: by 2002:a5d:5e04:0:b0:37e:d715:3f39 with SMTP id
 ffacd0b85a97d-37ed7154007mr247491f8f.10.1729273177846; Fri, 18 Oct 2024
 10:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
In-Reply-To: <20241018105351.1960345-1-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 18 Oct 2024 10:39:01 -0700
Message-ID: <CAKgT0Uft5Ga0ub_Fj6nonV6E0hRYcej8x_axmGBBX_Nm_wZ_8w@mail.gmail.com>
Subject: Re: [PATCH net-next v22 00/14] Replace page_frag with page_frag_cache
 for sk_page_frag()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 4:00=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> After [1], there are still two implementations for page frag:
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

So I still think this set should be split in half in order to make
this easier to review. The ones I have provided a review-by for so far
seem fine to me. I really think if you just submitted that batch first
we can get that landed and let them stew in the kernel for a bit to
make sure we didn't miss anything there.

As far as the others there is a bunch there for me to try and chew
through. A bunch of that is stuff not related necessarily to my
version of the page frag stuff that I did so merging the two is a bit
less obvious to me. The one thing I am wondering about is the behavior
for why we are pulling apart the logic with this "commit" approach
that is deferring the offset update which seems to have to happen
unless we need to abort.

My review time is going to be limited for the next several weeks. As
such I will likely not be able to get to a review until Friday or
Saturday each week so sending out updates faster than that will not
get you any additional reviews from me.

Thanks,

- Alex

