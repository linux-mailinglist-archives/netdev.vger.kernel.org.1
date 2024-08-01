Return-Path: <netdev+bounces-115021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DD5944E7A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA32AB20DCA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216F11A71E1;
	Thu,  1 Aug 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbeyyyWd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE8198A10;
	Thu,  1 Aug 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523868; cv=none; b=CWNgCbFu7t+6mHSapo2KHWin7FJ0uuLMGhBWOE6G5QPQw+wczbZfwsqogjS0cwIX6vS9vKMPblSxEs/FQgknnS4PezC63KFgyu8r/eYd3tHBU6sJ74VexaPnmTaPB1qEUO5/yH7LIl2iqukwSTy5zDIBZl9i+EmOzAL1KfRzRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523868; c=relaxed/simple;
	bh=3aBkTqTpqBRyLAJEM5v6QF4uvKlXcXc/YlfZJtmdnPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcF7lP6ua2M3le5O0ImzxokdgpFrlIWc+x2+5ytT0aBxWKH6onOny5PrN9LNyDWKFvT8XfxYx87KAgxvzZkvcq1nYEdS5vJym1A8ICF4iBDQP5YjJM/qMQXwszJVG8cDHSrDpLuuVmtI6TIWN2L417ZXtGsQWzSl8/7Z/2f+f90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbeyyyWd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3684eb5be64so3975463f8f.3;
        Thu, 01 Aug 2024 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722523864; x=1723128664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rczSTFdLOpaX7aUhoEqBv+g5Ojw1S2oguQ1RPZSdPN8=;
        b=JbeyyyWdDFVMOs3gswZ7zIBmS4uUubVD4DcuPNUu+DuTIdE75sBIYsaWofOae3MEj8
         3MC7x+ecMLaH0ycwkKiiaVXFhw1cZ2XI93qhTx/GFl3NyL4dig2lNzQYqus8zSreLhQV
         0I0+U0XWYMmttbWBGaFsIwspDoQAwGG77cPSo3b6GiFVZ/AKViQB/4YZmzvC8jP8FWGK
         HFOj+O8ydIjolfP9JbZfZl36ASdzE9LktWnF0BfgI8OwuPhVumz3yyIlrk6/3Yf/ylWo
         CsQDsZCDgLQ05wPRK2234aSjA/q8M5MIshWnZCAyKiCLmLywsLkQeKHHIez4DRLcDo4U
         Mx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722523864; x=1723128664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rczSTFdLOpaX7aUhoEqBv+g5Ojw1S2oguQ1RPZSdPN8=;
        b=J0yIGdkO561ib6pjBXwd7MCOywlejJI/4lcrH4t4kGhrG+BQqwaD8qaLEilnRcdWQF
         4IKD2wudHS7Zvpidf3K61qiXM5/hm9a38Y6ZI7S4TcorXTiz8EceJ1DMcS8YGIzoGpZD
         1jiYKkFbXTCRDEN+9QmR6VUCZAq/LjsGV+kOrE+hrUcn4++02dAJTm2KLd9T8wtiYHEY
         u4fyi4bDmyOCU5AHm0f/VMTpn9ZKjXM6DAUV3cv9ZJuoV3/LggTs5/2d9O4C5fgpjNG4
         4AMiN/4jZHaESg+NQDfvOr62xJE0Ys5qIHqJNoC9fSu3MwvL9JQgWVYx32mwJXzhEy5h
         telw==
X-Forwarded-Encrypted: i=1; AJvYcCU0PHpOJz5AuDNfyK5hP0sfJTlQIH5Grzn5nFs/6pkKCmT19sIvZ/4wTxeq3eYmpb3ggb7tO+hOITDQJnMSLSQFWEy/eNGyxokFLazMHIMl8Ja3Gdpgi4hnTPmdIGpqugcGOsZX
X-Gm-Message-State: AOJu0YxxNUT7Rk62qojuJ9dbEZnoHFffmft2z94E+gTzidqVEWx99Eg6
	oOmlWgfznJY5gvwUZGjxO58DN6sxmWGNeptZJ9dQO1Va0BQcKmUpRy3mlkKHy3LYflcJLBT2ZC3
	yf2EmfgnZTXypMDcxlGcx/Y1rGO4TjTt2hvk=
X-Google-Smtp-Source: AGHT+IFBcarHS8O1Pqb+2XFf22lRmwSFx41Gq01tcdJG7Q+ftLMblf/eBxn2kodE3JwR/SJEnUUR52D4GJl1AZJS99Y=
X-Received: by 2002:adf:f952:0:b0:368:7583:54c7 with SMTP id
 ffacd0b85a97d-36bbc0e66c0mr56885f8f.8.1722523864202; Thu, 01 Aug 2024
 07:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-2-linyunsheng@huawei.com> <CAKgT0Udj5Jskjvvba345DFkySuZeg927OHQya0rCcynMtmGg8g@mail.gmail.com>
 <03c555c5-a25d-434a-aed4-0f2f7aa65adf@huawei.com>
In-Reply-To: <03c555c5-a25d-434a-aed4-0f2f7aa65adf@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 1 Aug 2024 07:50:27 -0700
Message-ID: <CAKgT0UfXn3By_oSmNKw28biUf_ixXHMgGW_0h_3TZFAoECfPjg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/14] mm: page_frag: add a test module for page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 5:58=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/8/1 2:29, Alexander Duyck wrote:
> > On Wed, Jul 31, 2024 at 5:50=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> Basing on the lib/objpool.c, change it to something like a
> >> ptrpool, so that we can utilize that to test the correctness
> >> and performance of the page_frag.
> >>
> >> The testing is done by ensuring that the fragment allocated
> >> from a frag_frag_cache instance is pushed into a ptrpool
> >> instance in a kthread binded to a specified cpu, and a kthread
> >> binded to a specified cpu will pop the fragment from the
> >> ptrpool and free the fragment.
> >>
> >> We may refactor out the common part between objpool and ptrpool
> >> if this ptrpool thing turns out to be helpful for other place.
> >
> > This isn't a patch where you should be introducing stuff you hope to
> > refactor out and reuse later. Your objpoo/ptrpool stuff is just going
> > to add bloat and overhead as you are going to have to do pointer
> > changes to get them in and out of memory and you are having to scan
> > per-cpu lists. You would be better served using a simple array as your
> > threads should be stick to a consistent CPU anyway in terms of
> > testing.
> >
> > I would suggest keeping this much more simple. Trying to pattern this
> > after something like the dmapool_test code would be a better way to go
> > for this. We don't need all this extra objpool overhead getting in the
> > way of testing the code you should be focused on. Just allocate your
> > array on one specific CPU and start placing and removing your pages
> > from there instead of messing with the push/pop semantics.
>
> I am not sure if I understand what you meant here, do you meant something
> like dmapool_test_alloc() does as something like below?
>
> static int page_frag_test_alloc(void **p, int blocks)
> {
>         int i;
>
>         for (i =3D 0; i < blocks; i++) {
>                 p[i] =3D page_frag_alloc(&test_frag, test_alloc_len, GFP_=
KERNEL);
>
>                 if (!p[i])
>                         goto pool_fail;
>         }
>
>         for (i =3D 0; i < blocks; i++)
>                 page_frag_free(p[i]);
>
>         ....
> }
>
> The above was my initial thinking too, I went to the ptrpool thing using
> at least two CPUs as the below reason:
> 1. Test the concurrent calling between allocing and freeing more throughl=
y,
>    for example, page->_refcount concurrent handling, cache draining and
>    cache reusing code path will be tested more throughly.
> 2. Test the performance impact of cache bouncing between different CPUs.
>
> I am not sure if there is a more lightweight implementation than ptrpool
> to do the above testing more throughly.

You can still do that with a single producer single consumer ring
buffer/array and not have to introduce a ton of extra overhead for
some push/pop approach. There are a number of different
implementations for such things throughout the kernel.

>
> >
> > Lastly something that is a module only tester that always fails to
> > probe doesn't sound like it really makes sense as a standard kernel
>
> I had the same feeling as you, but when doing testing, it seems
> convenient enough to do a 'insmod xxx.ko' for testing without a
> 'rmmod xxx.ko'

It means this isn't a viable module though. If it supports insmod to
trigger your tests you should let it succeed, and then do a rmmod to
remove it afterwards. Otherwise it is a test module and belongs in the
selftest block.

> > module. I still think it would make more sense to move it to the
> > selftests tree and just have it build there as a module instead of
>
> I failed to find one example of test kernel module that is in the
> selftests tree yet. If it does make sense, please provide an example
> here, and I am willing to follow the pattern if there is one.

You must not have been looking very hard. A quick grep for
"module_init" in the selftest folder comes up with
"tools/testing/selftests/bpf/bpf_testmod/" containing an example of a
module built in the selftests folder.

> > trying to force it into the mm tree. The example of dmapool_test makes
> > sense as it could be run at early boot to run the test and then it
>
> I suppose you meant dmapool is built-in to the kernel and run at early
> boot? I am not sure what is the point of built-in for dmapool, as it
> only do one-time testing, and built-in for dmapool only waste some
> memory when testing is done.

There are cases where one might want to test on a system w/o console
access such as an embedded system, or in the case of an environment
where people run without an initrd at all.

> > just goes quiet. This module won't load and will always just return
> > -EAGAIN which doesn't sound like a valid kernel module to me.
>
> As above, it seems convenient enough to do a 'insmod xxx.ko' for testing
> without a 'rmmod xxx.ko'.

It is, but it isn't. The problem is it creates a bunch of ugliness in
the build as you are a tristate that isn't a tristate as you are only
building it if it is set to "m". There isn't anything like that
currently in the mm tree.

