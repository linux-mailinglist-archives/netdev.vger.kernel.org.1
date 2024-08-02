Return-Path: <netdev+bounces-115383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57089461EE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 18:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A017B21D95
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9C13634B;
	Fri,  2 Aug 2024 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCQpfM6a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9E136322;
	Fri,  2 Aug 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617007; cv=none; b=L971TOMR6VNAuHvRp1u0qx+LsdsEXLqRm73go0bSZS8JkR2MLnPFWmXOYpyrvnyM/xp8NEOW/TcEmN5zl23950t1tzXuSIA7SLF+TLmGLgzZvU74p5EWAL2+9kn1qTotJrZcXdr/j4q7SJDtUpNiCZ6oseNKrFK58KPf7JWtzi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617007; c=relaxed/simple;
	bh=qfOyy2GKgv2KAWzy8LZkQW5nswVbSAX5Gx3vQkWTFmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEu/I3cY54uy/EdnX0+htMRabFLgSvBn3dskxM3IF7OlDXceGNdQSNpi0mbxOSrHNnAVwj7RwMdEzb4nZQ0wT2QBOniMR1vdgVWU2chWyEooG4+fA+IYsGqyztiUXBwLJWnXnNGi1bqw6zgV+rmKSL6rKfCiLLcD2PD9sgVM/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCQpfM6a; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367990aaef3so4362132f8f.0;
        Fri, 02 Aug 2024 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722617004; x=1723221804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfTIzAiAF3r0Bgvrue30RkaKI+Y4QRU9lsEkdGPK3oE=;
        b=dCQpfM6aoBVim5MEKiBF8ot3LW8B5wwurAPKZVw2uWV/CpP18KdtR0ehV4MzytYO8B
         05wxKSCXo71YMrhfXnmxRfjXOSHcO0SwPFP+r/6bLjCcQ7gVd6XEV+BObc+Qcea8ctFG
         UT2Q4koPmiIS7oQQjkE5U0H/PwOrymXmGi0x9R2/4bgfFzRZWt0SgDwUXAKVlhcf9DwJ
         xt3vNwHYkOakj+wGyBEv3/PSiqDydd+mObyAAqt1zxb4Mpuvy70GNleTS5jebAfPVmUu
         Y20gZ3A27gwZuPiHwDzzTenjf1caAhwiRikcI2EwY7fhCqNz6RKYIJ0JXKn0EBUDAQYL
         mITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722617004; x=1723221804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfTIzAiAF3r0Bgvrue30RkaKI+Y4QRU9lsEkdGPK3oE=;
        b=WXUd1b0X7LFv1o13Skgj+BsfQuenSGMC1taAKhC1HiZ/1Yu8iLTyfmLcyAL1Hf31Ac
         fkf1730Sdn2RjatzlJq64iS3HgkTj/Gin6HtskOuiFEp1eMGcWtbKHUgJ3oPUemj7hvR
         7uAhywDlhhG/6cf+3Z1Yp40HqZg+AmUtSPiiKJkMvD/mYa219pniQfkpzdjyswASkNk6
         oHOfKARGp42mzdxtaIPpg7R5+7yMJXefYhT+0ZDo+SlUKBAHtaJrVNtE7IRZbmRulo9r
         pvmrH+4/os7mQTC67pTQZWUG5euwvOlBYnK9iCtgFFg7UPP8Fo6IjAsu52eqwrNAn3UT
         nP9g==
X-Forwarded-Encrypted: i=1; AJvYcCULmu2lpBHTMyVw/7aMrqTmI2Q/xuoz7pPz8SeKypb6Q1oWTp/iQr/FZvxZrF0JL8dxEWhBGfiM8YWAH5X6sg7Kp7lbklKHHKjUxf452ajGS03KLFqKCcTmmrZBhiwIy7HkPkvQ
X-Gm-Message-State: AOJu0YxDzFfpp+1DHcTZmj/FcND1t0bk93DLxVuCkT0826TAp2Y3B3Pp
	EyGVdoh4w5TXv5SLT90Ug3QiZqeBCY2/1HPrTMVDfHSZKCu0THE7H9vnlM6m/Rz2z4TxA8Ca6JJ
	/idPuH4B+QMjUHkrtkxMiV5ezJ6s=
X-Google-Smtp-Source: AGHT+IE1qaX/xzlkjD1NORh6HKCoaKH3HHSqkYZBx282lGLK+nCdSMJHna0HItXyLdgbxyMssFFqz3Fk8OyHhkRb4qY=
X-Received: by 2002:a5d:6281:0:b0:368:3f60:8725 with SMTP id
 ffacd0b85a97d-36bbc162fd2mr2621001f8f.39.1722617003435; Fri, 02 Aug 2024
 09:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-2-linyunsheng@huawei.com> <CAKgT0Udj5Jskjvvba345DFkySuZeg927OHQya0rCcynMtmGg8g@mail.gmail.com>
 <03c555c5-a25d-434a-aed4-0f2f7aa65adf@huawei.com> <CAKgT0UfXn3By_oSmNKw28biUf_ixXHMgGW_0h_3TZFAoECfPjg@mail.gmail.com>
 <c9cc66e0-195a-4db4-98b8-cdbb986e0619@huawei.com>
In-Reply-To: <c9cc66e0-195a-4db4-98b8-cdbb986e0619@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 2 Aug 2024 09:42:46 -0700
Message-ID: <CAKgT0UdL77J4reY0JRaQfCJAxww3R=jOkHfDmkuJHSkd1uE55A@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/14] mm: page_frag: add a test module for page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 3:02=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/8/1 22:50, Alexander Duyck wrote:
>
> >>
> >> The above was my initial thinking too, I went to the ptrpool thing usi=
ng
> >> at least two CPUs as the below reason:
> >> 1. Test the concurrent calling between allocing and freeing more throu=
ghly,
> >>    for example, page->_refcount concurrent handling, cache draining an=
d
> >>    cache reusing code path will be tested more throughly.
> >> 2. Test the performance impact of cache bouncing between different CPU=
s.
> >>
> >> I am not sure if there is a more lightweight implementation than ptrpo=
ol
> >> to do the above testing more throughly.
> >
> > You can still do that with a single producer single consumer ring
> > buffer/array and not have to introduce a ton of extra overhead for
> > some push/pop approach. There are a number of different
> > implementations for such things throughout the kernel.
>
> if we limit that to single producer single consumer, it seems we can
> use ptr_ring to replace ptrpool.

Right. That is more or less what I was thinking.

> >
> >>
> >>>
> >>> Lastly something that is a module only tester that always fails to
> >>> probe doesn't sound like it really makes sense as a standard kernel
> >>
> >> I had the same feeling as you, but when doing testing, it seems
> >> convenient enough to do a 'insmod xxx.ko' for testing without a
> >> 'rmmod xxx.ko'
> >
> > It means this isn't a viable module though. If it supports insmod to
> > trigger your tests you should let it succeed, and then do a rmmod to
> > remove it afterwards. Otherwise it is a test module and belongs in the
> > selftest block.
> >
> >>> module. I still think it would make more sense to move it to the
> >>> selftests tree and just have it build there as a module instead of
> >>
> >> I failed to find one example of test kernel module that is in the
> >> selftests tree yet. If it does make sense, please provide an example
> >> here, and I am willing to follow the pattern if there is one.
> >
> > You must not have been looking very hard. A quick grep for
> > "module_init" in the selftest folder comes up with
> > "tools/testing/selftests/bpf/bpf_testmod/" containing an example of a
> > module built in the selftests folder.
>
> After close look, it seems it will be treated as third party module when
> adding a kernel module in tools/testing/selftests as there seems to be no
> config for it in Kconfig file and can only be compiled as a module not as
> built-in.

Right now you can't compile it as built-in anyway and you were
returning EAGAIN. If you are going that route then it makes more sense
to compile it outside of the mm tree since it isn't a valid module in
the first place.

> >
> >>> trying to force it into the mm tree. The example of dmapool_test make=
s
> >>> sense as it could be run at early boot to run the test and then it
> >>
> >> I suppose you meant dmapool is built-in to the kernel and run at early
> >> boot? I am not sure what is the point of built-in for dmapool, as it
> >> only do one-time testing, and built-in for dmapool only waste some
> >> memory when testing is done.
> >
> > There are cases where one might want to test on a system w/o console
> > access such as an embedded system, or in the case of an environment
> > where people run without an initrd at all.
>
> I think moving it to tools/testing/selftests may defeat the above purpose=
.

That is why I am suggesting either fix the module so that it can be
compiled in, or move it to selftest. The current module is not a valid
one and doesn't belong here in its current form.

> >
> >>> just goes quiet. This module won't load and will always just return
> >>> -EAGAIN which doesn't sound like a valid kernel module to me.
> >>
> >> As above, it seems convenient enough to do a 'insmod xxx.ko' for testi=
ng
> >> without a 'rmmod xxx.ko'.
> >
> > It is, but it isn't. The problem is it creates a bunch of ugliness in
>
> Yes, it seems a bit ugly, but it supports the below perf cmd, I really
> would like to support the below case as it is very convenient.
>
> perf stat -r 200 -- insmod ./page_frag_test.ko test_push_cpu=3D16 test_po=
p_cpu=3D17

That is fine. If that is the case then it should be in the selftest folder.

> > the build as you are a tristate that isn't a tristate as you are only
> > building it if it is set to "m". There isn't anything like that
> > currently in the mm tree.
>
> After moving page_frag_test to selftest, it is only bulit as module, I gu=
ess
> it is ok to return -EAGAIN?

Yes, I would be fine with it in that case.

