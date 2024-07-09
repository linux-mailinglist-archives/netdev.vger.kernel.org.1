Return-Path: <netdev+bounces-110283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA2D92BB95
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8631F2185C
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A495158D8C;
	Tue,  9 Jul 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHnQ2z7W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5441257D;
	Tue,  9 Jul 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532499; cv=none; b=Z/7SmvdxVrKyALzM3dDpPVyrfyjxJq4NkZiuHpA7aCJ+Z7naWy1/XqxLDYKDPdbZnSxjcvy/NQWUkc9RIGWpbps3PoJ0Rmb3y/9rO0M1PrMBtU59PJoDQOvbJJV3kMmBwrBiOZzqepanv5IfZsDpMYpDlhMd04tD3ERo9E9/Zmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532499; c=relaxed/simple;
	bh=edKsd7lVU36DkC4pKlEVskQhPjFrWIAFUu2EbrmsWTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNtLD3s/1dgx2xjCN91Tda73JgUQyv58PLUh3JJbxR2Fg3/ESQQV+R0jk8kl2kCZkbqEtta3jR2GRAFyCj2b/h6Ej7PxMvN4Mm/mKxQ3SVlllgyqkwAQrhqAv7A3//2tOOnUZj7OIsZZgoEXW+R8Iuw5gqJhTeUEJ8frnl7L3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHnQ2z7W; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so13383865e9.1;
        Tue, 09 Jul 2024 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720532496; x=1721137296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knWPJfcPnK6qjC655MgiE/tsLpIcwsRamnwiOz/QKYg=;
        b=RHnQ2z7W+NdR4+liJGEOrKFi3mWvLLpxdvbhTsIYR/s97mlRtkFwdBjFFScdcPyKcy
         X+zC2XlWJOqQ1k3NwSJG2eDrjcWYktuG6Y5nx568PcgRIuH/t2AkN7dDiQ84RdrXPyu4
         UheciTX5Wm/G1jV08EfkrPNR/OJnNJnCQtebXkhlRu9HZ1mqpnoVqTzEUctrqwxWUz1y
         KVVfys0LXyPYtGKiufLEtKtRDiS1mM/fF2xqsYXYWv5HQQkwwpaxrwT1VSkTRdV74C42
         RMi2wi5JZpuxBG4x3CO3rqQV24PLG8tyxDfRYITzcPE/IJaa2LS4nr+352Dytn8Rmxg5
         c/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532496; x=1721137296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knWPJfcPnK6qjC655MgiE/tsLpIcwsRamnwiOz/QKYg=;
        b=uX/mZcpHUyu3CLdZYMdiSBs0cdXXp+JGGq90kGNWobxMOu+WUJoX5kXEnlc7LsEmau
         EWcy8wrTpqrtamP+eOROeLzZ41U/NcO+zsYBPqiRQR1ra2SEX+Ls92P+NiYRA8lcBN0v
         Pjro9iioYrWUk1Kc1KPr37e2O56GHfhF6UCoSXMUFC9u/wTXMThROCYc1dMyvRG5g7ea
         CvtDGCr6iAr7o0mEO8d0hVzfHBm5h0uFtjzICH7nLaOuNQSSJBp9AKAKJ83vEFOd0VNT
         oSQOuDJOXvT7PyxqpnMB1z5coP9vhfPe4AAB392iT34TZHPTpnOUIH07xmuu4pWVYfBl
         xHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJFyNEB+wMlQL/adYrs3I7dm6bT+XVs86+qvalEbiSnLJzDN3D24BZCZeNeeXl7bQ7sgWbWeJCBqJfvn8weE2Rz3i8Q1NL0oqJkwJP0V4bBX43VYEQtbia2LhuZkDeNVZLEhrI
X-Gm-Message-State: AOJu0YxqX2q9PSBqfZuJ8TEaX7hSDL3Uce2ZJdBqKRyKTebSC1/hNZd6
	ulGXAGOq5iReODL0Mj21FxR7l73m8BdGXSseAGTsM3vPnskK4FDC9Ifs1mSubuWPJNUlDO/7xKL
	CVJnuw3+pVrmDFiReqHf2/CxEOtnZBQ==
X-Google-Smtp-Source: AGHT+IFmBVEwha1tc7CN+fLxQ0HlyLl7ulTFXUR8JuKEwrRVK3HqtTJSTw6UjD9BxhUhGU4c/0ZN+lgIEnyyqX/kAFU=
X-Received: by 2002:a05:600c:2e0a:b0:426:6f15:2e4d with SMTP id
 5b1f17b1804b1-426707da1b5mr15586755e9.9.1720532495871; Tue, 09 Jul 2024
 06:41:35 -0700 (PDT)
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
 <CAKgT0UcpLBtkX9qrngJAtpnnxT-YRqLFc+J4oMMVnTCPG5sMug@mail.gmail.com>
 <83cf5a36-055a-f590-9d41-59c45f93e7c5@huawei.com> <CAKgT0UdH1yD=LSCXFJ=YM_aiA4OomD-2wXykO42bizaWMt_HOA@mail.gmail.com>
 <2b7ecaca-9a17-e057-8897-d0684b31591d@huawei.com>
In-Reply-To: <2b7ecaca-9a17-e057-8897-d0684b31591d@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 9 Jul 2024 06:40:59 -0700
Message-ID: <CAKgT0UdBdDWrE_KDC8k=mM4gFuKrCSU1FmhwJwo8oaiHXnp+5w@mail.gmail.com>
Subject: Re: [PATCH net-next v9 10/13] mm: page_frag: introduce
 prepare/probe/commit API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yunsheng Lin <yunshenglin0825@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:58=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/7/8 22:30, Alexander Duyck wrote:
> > On Mon, Jul 8, 2024 at 3:58=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> On 2024/7/8 1:12, Alexander Duyck wrote:
> >>
> >> ...
> >>
> >>> The issue is the dependency mess that has been created with patch 11
> >>> in the set. Again you are conflating patches which makes this really
> >>> hard to debug or discuss as I make suggestions on one patch and you
> >>> claim it breaks things that are really due to issues in another patch=
.
> >>> So the issue is you included this header into include/linux/sched.h
> >>> which is included in linux/mm_types.h. So what happens then is that
> >>> you have to include page_frag_cache.h *before* you can include the
> >>> bits from mm_types.h
> >>>
> >>> What might make more sense to solve this is to look at just moving th=
e
> >>> page_frag_cache into mm_types_task.h and then having it replace the
> >>> page_frag struct there since mm_types.h will pull that in anyway. Tha=
t
> >>> way sched.h can avoid having to pull in page_frag_cache.h.
> >>
> >> It seems the above didn't work either, as asm-offsets.c does depend on
> >> mm_types_task.h too.
> >>
> >> In file included from ./include/linux/mm.h:16,
> >>                  from ./include/linux/page_frag_cache.h:10,
> >>                  from ./include/linux/mm_types_task.h:11,
> >>                  from ./include/linux/mm_types.h:5,
> >>                  from ./include/linux/mmzone.h:22,
> >>                  from ./include/linux/gfp.h:7,
> >>                  from ./include/linux/slab.h:16,
> >>                  from ./include/linux/resource_ext.h:11,
> >>                  from ./include/linux/acpi.h:13,
> >>                  from ./include/acpi/apei.h:9,
> >>                  from ./include/acpi/ghes.h:5,
> >>                  from ./include/linux/arm_sdei.h:8,
> >>                  from arch/arm64/kernel/asm-offsets.c:10:
> >> ./include/linux/mmap_lock.h: In function =E2=80=98mmap_assert_locked=
=E2=80=99:
> >> ./include/linux/mmap_lock.h:65:23: error: invalid use of undefined typ=
e =E2=80=98const struct mm_struct=E2=80=99
> >>    65 |  rwsem_assert_held(&mm->mmap_lock);
> >
> > Do not include page_frag_cache.h in mm_types_task.h. Just move the
> > struct page_frag_cache there to replace struct page_frag.
>
> The above does seem a clever idea, but doesn't doing above also seem to
> defeat some purpose of patch 1? Anyway, it seems workable for trying
> to avoid adding a new header for a single struct.
>
> About the 'replace' part, as mentioned in [1], the 'struct page_frag'
> is still needed as this patchset is large enough that replacing is only
> done for sk_page_frag(), there are still other places using page_frag
> that can be replaced by page_frag_cache in the following patchset.
>
> 1. https://lore.kernel.org/all/b200a609-2f30-ec37-39b6-f37ed8092f41@huawe=
i.com/

The point is you need to avoid pulling mm.h into sched.h. To do that
you have to pull the data structure out and place it in a different
header file. So maybe instead of creating yet another header file you
can just place the structure in mm_types_task.h and once you have
dealt with all of the other users you can finally drop the page_frag
structure.

