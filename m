Return-Path: <netdev+bounces-122465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1399616B4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2C81F25650
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07C1D3638;
	Tue, 27 Aug 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK7cyntl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767A3C08A;
	Tue, 27 Aug 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782640; cv=none; b=e+8TjwRslMVLMp5Sl5457N6L4r+0YEqZfHyBb1kVfh1PMSMvslS3WR1wb9XBnFH17sU+Uq1+jZ7pBfwcaZksTCEcnDuPda8vOkwKMu170XFSLR2HWjrvc4Xe7m1x+rGHxs+X6wMCpqfwTvqcJiO97aRYGiD30ugJ8LQoroskgBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782640; c=relaxed/simple;
	bh=gcl02sZ8zY4Sbj87xC+8jQ2kT4jVPmE12J9aZjcwUZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2Gpb2FeDRI8+hZBlONOQ3fsfwW0Pty1X7LUX31XewL1FdbaRVP43X2hzWPVw1JhZytJ/v5312SalrI4ZK3I9+tPkY+KyLvrUy92T26WMz09Rft4hGKnxq3lFJYCZ6jaZR6KrmVoaP2j2gWMzbi5R/d2IMcQz71y2Jdea11dBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK7cyntl; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d2ceca81cso21637985ab.3;
        Tue, 27 Aug 2024 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724782638; x=1725387438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFTh1rX9JNOdXndk7oSWnCFWoM4tQrJ2iIxnW5wh1fg=;
        b=QK7cyntly9iuF1AICtZyhd0Ad8C8Tu/WPnaAVZ/CFOi25R7DrA9cTSUsgOMlTUlvDt
         /nHiveR7AEbJYcuEXc3ibppreAoOfdMg7ZQwO6jceqeK7YnEnaGUqqgKfg1CkHcZ+obl
         3A5SpZ5dnhvB3gd00h8bkE3v7GI/SlChudf50MoHXcJDiL3Uxub3sn0bGT9pjBfbiv2L
         R2GgiERXkV/WUKXm95iFjKe4TSSGN9WP+3okL31lWrFU4j6wop/KAtptY1+jIMczs00E
         Of3tJW1AsEmxsRVaIElnWn14khS6/A72xiIPuVNvOq8TSu3TUexHzgqsmPKFxpeN96P3
         OtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782638; x=1725387438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFTh1rX9JNOdXndk7oSWnCFWoM4tQrJ2iIxnW5wh1fg=;
        b=Uv8ZfKDM7y9Cr1Verofw9UVLfvbWtZ1flet3cfzt4s29e3iYJEcPEwnPlLJd7wpK6Y
         Ar1vd+YTTl+1JwJ/s5VDWP2YQbZvGOKKJ3orvcG77REP49FPrSQchI7ZcuVuL/ivnTzV
         MWgO2FeuhCZABKQCNYXci3dkxucp+06ZuFlM3rKGmytR+MasYteVHGFA1qyUG406OgPr
         egXPlz05ILeimmAMLbbDAb/FEDCYBcBKBIdveTjOb/fBAarZ01IW1vZYf08f5qduQK4R
         2yFs7YPkcYYV3aDTKS1wC0/AFkDNwnN1yo+qQghE/61Dp49jtCoehYoIH4HUHqS3dHyq
         PKug==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZN6e995FCsl7XSuEQEhrXtDMvzQhhRYYbVcwmM4pc3kYGLFKf/YpibCq4YTOtJT6PSXFNA6g@vger.kernel.org, AJvYcCXXw7N0+8FVQopfp9O6aA3Lh9bMCd5QF+iKPxiF/1Bi6N2j8c69UnwAcrs0dMZunBpT8YMkImsIFWAmQqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEITDlgwhhdMinIuobhWBc+AfP5Egl9S2IdPcp+GXRp2SQkWvT
	2lb1Wp36gaXuN8jZrqw1Kkg1Pg6jXLpqSjhMHOrFinDQQaRNj3BuI6NevF6NyPAzrHXj1hYMlpX
	maY0dFdcLx9Vu1q3tOrPyrV+wzig=
X-Google-Smtp-Source: AGHT+IEZXGRDParlE6BB6GZu+cFJebRDr2ihaXIrU1wdiVkXYpgsCutJxNzPure14FOUb3ZJyBTVpRICH14pQUEqoQ4=
X-Received: by 2002:a05:6e02:1987:b0:39d:63b7:f7f3 with SMTP id
 e9e14a558f8ab-39e3c9c0be4mr169607615ab.22.1724782638436; Tue, 27 Aug 2024
 11:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826124021.2635705-1-linyunsheng@huawei.com>
 <20240826124021.2635705-7-linyunsheng@huawei.com> <CAKgT0Uc7tRi6uGTpx2n9_JAK+sbPg7QcOOOSLK+a41cFMcqCWg@mail.gmail.com>
 <82be328d-8f04-417f-bdf2-e8c0f6f58057@huawei.com>
In-Reply-To: <82be328d-8f04-417f-bdf2-e8c0f6f58057@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 27 Aug 2024 11:16:40 -0700
Message-ID: <CAKgT0UcEuYanVEaRViuJ5v8F7EXKJLr4_yP=ZkiMdamznt0FoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 06/13] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 5:06=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/27 0:46, Alexander Duyck wrote:
> > On Mon, Aug 26, 2024 at 5:46=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> Currently there is one 'struct page_frag' for every 'struct
> >> sock' and 'struct task_struct', we are about to replace the
> >> 'struct page_frag' with 'struct page_frag_cache' for them.
> >> Before begin the replacing, we need to ensure the size of
> >> 'struct page_frag_cache' is not bigger than the size of
> >> 'struct page_frag', as there may be tens of thousands of
> >> 'struct sock' and 'struct task_struct' instances in the
> >> system.
> >>
> >> By or'ing the page order & pfmemalloc with lower bits of
> >> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
> >> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
> >> And page address & pfmemalloc & order is unchanged for the
> >> same page in the same 'page_frag_cache' instance, it makes
> >> sense to fit them together.
> >>
> >> After this patch, the size of 'struct page_frag_cache' should be
> >> the same as the size of 'struct page_frag'.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>  include/linux/mm_types_task.h   | 19 ++++++-----
> >>  include/linux/page_frag_cache.h | 60 +++++++++++++++++++++++++++++++-=
-
> >>  mm/page_frag_cache.c            | 51 +++++++++++++++-------------
> >>  3 files changed, 97 insertions(+), 33 deletions(-)
> >>

...

> >>  void page_frag_cache_drain(struct page_frag_cache *nc);
> >
> > So how many of these additions are actually needed outside of the
> > page_frag_cache.c file? I'm just wondering if we could look at moving
>
> At least page_frag_cache_is_pfmemalloc(), page_frag_encoded_page_order(),
> page_frag_encoded_page_ptr(), page_frag_encoded_page_address() are needed
> out of the page_frag_cache.c file for now, which are used mostly in
> __page_frag_cache_commit() and __page_frag_alloc_refill_probe_align() for
> debugging and performance reason, see patch 7 & 10.

As far as the __page_frag_cache_commit I might say that could be moved
to page_frag_cache.c, but admittedly I don't know how much that would
impact the performance.

> The only left one is page_frag_encode_page(), I am not sure if it makes
> much sense to move it to page_frag_cache.c while the rest of them are in
> .h file.

I would move it. There is no point in exposing internals more than
necessary. Also since you are carrying a BUILD_BUG_ON it would make
sense to keep that internal to your implementation.

