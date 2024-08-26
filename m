Return-Path: <netdev+bounces-121979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EEF95F757
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB25F1F2296F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA91198A3E;
	Mon, 26 Aug 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2u6NUpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD2197A8A;
	Mon, 26 Aug 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691667; cv=none; b=PLHSeG52/Ej2UJw98EFJQmnp2Qm1gbMvGo924KX56ypmkjT00FuudEWCCqJhYeQf4m3/dzk8Yqo0gYGPdUJU0766AaD0DsSy+B9H71ByaGrbYDmI3LNbDTo/prkXWd40F/29TM3+QLxfNkpnqIJFhzNXUXQKfeBfDEmMyfb8gxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691667; c=relaxed/simple;
	bh=AcL260or/eTsKKVe+NUMz9kkEtjMWNdjSjASsUcmUaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivd6em4tWl/iMluCbv04jDseJhmv+m+RYueAhtOjbG+cjMyXsD32fR5N8PFjh3kThTG6eoA8+6dLHsTKMm3JuiLbSMuc9ipE9V0yw6UGWjVLsaaqzFLz1/2gXQfk7KCfz1OtVMjdLEYwSYnhwm2pgWYt1cjI8MCD3Vei5eCEa0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2u6NUpi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428101fa30aso40067335e9.3;
        Mon, 26 Aug 2024 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724691664; x=1725296464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4ydZtjipfIDczjm51bqPMppCfyDaZ6I+LqHoxr5iPs=;
        b=I2u6NUpi0C4dPdOuVspYTwIhN4uDrIEt5paxxDL2u2j7LWJvKcxl0F/D6VFKex+jOR
         apLy5Howv4mp3aVaN0QIIgNClQcSz0hF2v9eKTVABfJG5yPSha8N1+Pz2ZAJKYIK8fpO
         YQpwnshmOHBKOfmlNiOXHw/3l2CZ15jLeXNlXG6DGsqp3ubTI5EnEu5DSCA5k6Cw3x8w
         gEgBOUxU6GxCYUG2/UOnq0gaDJGa6C3EW+sS0+rWP93eJEg8ImpK+tiaE1Ttj/HU+Bhb
         sdPFsZFLKDeghuhHdVJrVNi8m4steyVt7lEumQmSIIXQMWRcItbpTtaRa+b0MmAtVjta
         8xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724691664; x=1725296464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4ydZtjipfIDczjm51bqPMppCfyDaZ6I+LqHoxr5iPs=;
        b=c+tBTuHefvcSD1Ej9phtrwmPVjywlv12Y2T+FICqkt5wclPfFG4v2eAxPmMO8MNCQG
         q639B3JqYFuXfLs6+1yo8b1KFODPw7EXGrPX/BbCjjQsAF+9F2kulijhkE4S+W4eTUpK
         /lSy+MyZSwPGYHQ+JqXzQKm8m3Uj5iy6c5FwCYayk6ikf3iX2G76NCWodcsFZ4TWb9Va
         AITnqUdjuL2mP2VzoztQprqj+Vd83e33QChYKrnqTiaTs2KdDVA2jYjze55XYLlvwk3s
         zgl6Is+Gi6RFUzHVcHf6LWpJFY2VmDZLTSWWtb4J5Dwk9djpg4bNj+riZ1K7VQEEC/FK
         /4vw==
X-Forwarded-Encrypted: i=1; AJvYcCXmN2yRXoAJlpTF44VGDdenFzfe0ynct26tVEHeNKqmey2kvIRYLFOF9FaLCZhlbLfH2l5d7SffnPJrSrM=@vger.kernel.org, AJvYcCXvuZk9dfEUtSplx7uf0261ASXsAxwaTs0Q6WHTsMKaqaY6Sw6OQt/bNLhkb7WLloUwqAZXnwle@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgtTrkEr+q3cYRPD6H/nGhsIoIIsLF2SOvrZVpEeNzONQRV/I
	VEAUmPH5AHFgp91qnXHz9+WPaAVle1EoTYNGMquKyyZChYg/LWRBd1RPJw7glLXpkyP7UJicbTo
	/ndfwAZGGAO9LADJxJxBXiV5Asno=
X-Google-Smtp-Source: AGHT+IHynSrDzChnxLMHDn/M5Iab9m1y/ogxb2dC8xJBSJ49uGMJMHFDiyeocp5Q4lOl/XkfTyabY6aubHlNQI2twfk=
X-Received: by 2002:adf:ab18:0:b0:36b:c126:fe5e with SMTP id
 ffacd0b85a97d-3748c7d4e55mr221811f8f.30.1724691663770; Mon, 26 Aug 2024
 10:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826124021.2635705-1-linyunsheng@huawei.com> <20240826124021.2635705-9-linyunsheng@huawei.com>
In-Reply-To: <20240826124021.2635705-9-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 26 Aug 2024 10:00:27 -0700
Message-ID: <CAKgT0Ue+6Gke9YguEDiq6whqQg0DdjPjSDDiRHEeVe5MX80+-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v15 08/13] mm: page_frag: use __alloc_pages() to
 replace alloc_pages_node()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:46=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> It seems there is about 24Bytes binary size increase for
> __page_frag_cache_refill() after refactoring in arm64 system
> with 64K PAGE_SIZE. By doing the gdb disassembling, It seems
> we can have more than 100Bytes decrease for the binary size
> by using __alloc_pages() to replace alloc_pages_node(), as
> there seems to be some unnecessary checking for nid being
> NUMA_NO_NODE, especially when page_frag is part of the mm
> system.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  mm/page_frag_cache.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index bba59c87d478..e0ad3de11249 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -28,11 +28,11 @@ static struct page *__page_frag_cache_refill(struct p=
age_frag_cache *nc,
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>         gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> -       page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
> -                               PAGE_FRAG_CACHE_MAX_ORDER);
> +       page =3D __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
> +                            numa_mem_id(), NULL);
>  #endif
>         if (unlikely(!page)) {
> -               page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> +               page =3D __alloc_pages(gfp, 0, numa_mem_id(), NULL);
>                 if (unlikely(!page)) {
>                         nc->encoded_page =3D 0;
>                         return NULL;

I still think this would be better served by fixing alloc_pages_node
to drop the superfluous checks rather than changing the function. We
would get more gain by just addressing the builtin constant and
NUMA_NO_NODE case there.

