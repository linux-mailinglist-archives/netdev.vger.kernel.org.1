Return-Path: <netdev+bounces-109698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECE9929919
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 19:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F280328356F
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03125502B1;
	Sun,  7 Jul 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyvprIkh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2392B38F87;
	Sun,  7 Jul 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720372386; cv=none; b=KdbuNEeQWc3Y+3q2fJVph7AMTN9HI/A9ZQlKx11mU4v5GflLIIIYrzPwnYuNmwtuO1pEbI/vPJZ3qwIVUaLkWMP5h5Pa4ehjwlv/CG8VG6u/aj2TKVzFdVCZPeq8ep7KFmoYpmvmcrYgX/5OH0dzyuELBSBJo4xif7C7JDwQMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720372386; c=relaxed/simple;
	bh=A2uL4LQ7Q9kbl+U/0hOdWgYvdr/M6AO2OlrcXaPDtoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZP9v6bc8xoex2QhEjErX6+ri61yMYzbv9rdJAs1S1wV59jEfAns/vDTJ76ctESJO3rVewP/oPqHNGjfA8DsMEx4/adowPtwYxo9D3H+vFf2Ss69Q6OtSyhW163PTyxOlOpwlDbcnu9vTyinuirmr5GjvYRn7mxhpoDel11vqdLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyvprIkh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3678fbf4a91so1597126f8f.1;
        Sun, 07 Jul 2024 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720372383; x=1720977183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HjWM7/w5+5DdJAOM+7In7RUfCFAcEzKXxK1slwKZGM=;
        b=KyvprIkhEG5qySx3y9NCgTg9TjpFV5m2vruRNTXFu5zrzihySFGBGXTmA2CvPYJZtF
         UDqNnFgHmIBtEVMlaL2ZlMTNWYh26NcTtlbILShRHAxG91Cc8ZiaA4WnU0uMoyZnaZ4X
         5Xr1FG9LiFtV0M4reFjdrS9h5AONA5KkOKosWEZ+ifACbR2UNx7pyJZjK2PULPeSpTnx
         fzO8X2kLK27s3aFs8S2wWXO6FCMc8oWk9w279WhFo5BMhCqBotyMwqlzMSMKU7IpcAd/
         41CHsAyvfQczgNqgMW3o7ycc/t0MRPKqGeCc9dTanLARvkFGMKXpUsomliKYJx0w+xp5
         phKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720372383; x=1720977183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HjWM7/w5+5DdJAOM+7In7RUfCFAcEzKXxK1slwKZGM=;
        b=la6X6AGip2RaaGhie94pZnw6rn8ODZFDah+/aamcvczyWHabi1vhU5cpAKWB8zKtEH
         5VCgrUdFKCkJ399IsB6lmCmEd0aYmQcXLFxYHYwzhxr6u3HwIn952xfo6c5s+P9SdZ3F
         nveWB919bE7GzRiQDXhmStwCp1sXTLaqpeqsnzkD+WCSni4kZaFoUqOcbcp4glR6Wp+J
         eAlXyDYr3r+hmQ317SZaPGUnA1dyLdRMHVHHLMmMsrtHP5pvDjzHUt2otj1FFZhgmIDw
         bvPKrknYTeqTNtVQ4iBaq2Qh/CPYOzrHXHG19n4QaVGjOmQrfnx1l/cdwIO8JAfj6krP
         oHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk1jeCd83cAxp1/WFGV0v1bxg9fSWXp3j1rcctDQQ+wT7RUVSCbsFhwhNlaQ8K0Xq9+uGlb9gnqUwf/uCBzD8Ywcxzu0OClp1AKxv4NVM3Ptc7Xe5yMj+/LsBGD4RwQD6nr+wE
X-Gm-Message-State: AOJu0YwiC0vd3ojC8B514d2X/O1atdoyxxP7NT8xPmSKzY5S9YVxxddk
	17ujew9lBC55X257EvMloNiUxBV0mxojiKjF6+dYxq0Hu8ynNUbJj+EEi/7qLBUWlrlCFUDQmw/
	sDyaHZ0qZ1gseERsRH/Bs9cCpeEI=
X-Google-Smtp-Source: AGHT+IH41zHheROtY9DzgazXdwYwjDYT4zQzVUIua/dGAi+LwnfedkPtv6ESkE2vU/RY04Ok6fD9MffkQIY1pHS0+7U=
X-Received: by 2002:a5d:6889:0:b0:366:ee7b:591a with SMTP id
 ffacd0b85a97d-3679de74c32mr6152284f8f.71.1720372383195; Sun, 07 Jul 2024
 10:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-11-linyunsheng@huawei.com> <33c3c7fc00d2385e741dc6c9be0eade26c30bd12.camel@gmail.com>
 <38da183b-92ba-ce9d-5472-def199854563@huawei.com> <CAKgT0Ueg1u2S5LJuo0Ecs9dAPPDujtJ0GLcm8BTsfDx9LpJZVg@mail.gmail.com>
 <0a80e362-1eb7-40b0-b1b9-07ec5a6506ea@gmail.com> <CAKgT0UcRbpT6UFCSq0Wd9OHrCqOGR=BQ063-zNBZ4cVNmduZGw@mail.gmail.com>
 <15623dac-9358-4597-b3ee-3694a5956920@gmail.com> <200ee8ff-557f-e17b-e71f-645267a49831@huawei.com>
In-Reply-To: <200ee8ff-557f-e17b-e71f-645267a49831@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 7 Jul 2024 10:12:26 -0700
Message-ID: <CAKgT0UcpLBtkX9qrngJAtpnnxT-YRqLFc+J4oMMVnTCPG5sMug@mail.gmail.com>
Subject: Re: [PATCH net-next v9 10/13] mm: page_frag: introduce
 prepare/probe/commit API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yunsheng Lin <yunshenglin0825@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 5:40=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/6/30 23:05, Yunsheng Lin wrote:
> > On 6/30/2024 10:35 PM, Alexander Duyck wrote:
> >> On Sun, Jun 30, 2024 at 7:05=E2=80=AFAM Yunsheng Lin <yunshenglin0825@=
gmail.com> wrote:
> >>>
> >>> On 6/30/2024 1:37 AM, Alexander Duyck wrote:
> >>>> On Sat, Jun 29, 2024 at 4:15=E2=80=AFAM Yunsheng Lin <linyunsheng@hu=
awei.com> wrote:
> >>>
> >>> ...
> >>>
> >>>>>>
> >>>>>> Why is this a macro instead of just being an inline? Are you tryin=
g to
> >>>>>> avoid having to include a header due to the virt_to_page?
> >>>>>
> >>>>> Yes, you are right.
> >>
> >> ...
> >>
> >>>> I am pretty sure you just need to add:
> >>>> #include <asm/page.h>
> >>>
> >>> I am supposing you mean adding the above to page_frag_cache.h, right?
> >>>
> >>> It seems thing is more complicated for SPARSEMEM_VMEMMAP case, as it
> >>> needs the declaration of 'vmemmap'(some arch defines it as a pointer
> >>> variable while some arch defines it as a macro) and the definition of
> >>> 'struct page' for '(vmemmap + (pfn))' operation.
> >>>
> >>> Adding below for 'vmemmap' and 'struct page' seems to have some compi=
ler
> >>> error caused by interdependence between linux/mm_types.h and asm/pgta=
ble.h:
> >>> #include <asm/pgtable.h>
> >>> #include <linux/mm_types.h>
> >>>
> >>
> >> Maybe you should just include linux/mm.h as that should have all the
> >> necessary includes to handle these cases. In any case though it
> >
> > Including linux/mm.h seems to have similar compiler error, just the
> > interdependence is between linux/mm_types.h and linux/mm.h now.
>
> How about splitting page_frag_cache.h into page_frag_types.h and
> page_frag_cache.h mirroring the above linux/mm_types.h and linux/mm.h
> to fix the compiler error?
>
> >
> > As below, linux/mmap_lock.h obviously need the definition of
> > 'struct mm_struct' from linux/mm_types.h, and linux/mm_types.h
> > has some a long dependency of linux/mm.h starting from
> > linux/uprobes.h if we add '#include <linux/mm.h>' in linux/page_frag_ca=
che.h:
> >
> > In file included from ./include/linux/mm.h:16,
> >                  from ./include/linux/page_frag_cache.h:6,
> >                  from ./include/linux/sched.h:49,
> >                  from ./include/linux/percpu.h:13,
> >                  from ./arch/x86/include/asm/msr.h:15,
> >                  from ./arch/x86/include/asm/tsc.h:10,
> >                  from ./arch/x86/include/asm/timex.h:6,
> >                  from ./include/linux/timex.h:67,
> >                  from ./include/linux/time32.h:13,
> >                  from ./include/linux/time.h:60,
> >                  from ./include/linux/jiffies.h:10,
> >                  from ./include/linux/ktime.h:25,
> >                  from ./include/linux/timer.h:6,
> >                  from ./include/linux/workqueue.h:9,
> >                  from ./include/linux/srcu.h:21,
> >                  from ./include/linux/notifier.h:16,
> >                  from ./arch/x86/include/asm/uprobes.h:13,
> >                  from ./include/linux/uprobes.h:49,
> >                  from ./include/linux/mm_types.h:16,
> >                  from ./include/linux/mmzone.h:22,
> >                  from ./include/linux/gfp.h:7,
> >                  from ./include/linux/slab.h:16,
> >                  from ./include/linux/crypto.h:17,
> >                  from arch/x86/kernel/asm-offsets.c:9:
> > ./include/linux/mmap_lock.h: In function =E2=80=98mmap_assert_locked=E2=
=80=99:
> > ./include/linux/mmap_lock.h:65:30: error: invalid use of undefined type=
 =E2=80=98const struct mm_struct=E2=80=99
> >    65 |         rwsem_assert_held(&mm->mmap_lock);
> >       |                              ^~
> >
> >> doesn't make any sense to have a define in one include that expects
> >> the user to then figure out what other headers to include in order to
> >> make the define work they should be included in the header itself to
> >> avoid any sort of weird dependencies.
> >
> > Perhaps there are some season why there are two headers for the mm subs=
ystem, linux/mm_types.h and linux/mm.h?
> > And .h file is supposed to include the linux/mm_types.h while .c file
> > is supposed to include the linux/mm.h?
> > If the above is correct, it seems the above rule is broked by including=
 linux/mm.h in linux/page_frag_cache.h.
> > .

The issue is the dependency mess that has been created with patch 11
in the set. Again you are conflating patches which makes this really
hard to debug or discuss as I make suggestions on one patch and you
claim it breaks things that are really due to issues in another patch.
So the issue is you included this header into include/linux/sched.h
which is included in linux/mm_types.h. So what happens then is that
you have to include page_frag_cache.h *before* you can include the
bits from mm_types.h

What might make more sense to solve this is to look at just moving the
page_frag_cache into mm_types_task.h and then having it replace the
page_frag struct there since mm_types.h will pull that in anyway. That
way sched.h can avoid having to pull in page_frag_cache.h.

