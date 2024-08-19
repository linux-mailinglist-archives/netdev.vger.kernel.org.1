Return-Path: <netdev+bounces-119794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D34956F88
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47969280E9F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E21446DC;
	Mon, 19 Aug 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUrvmbS5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A213B7A6;
	Mon, 19 Aug 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083243; cv=none; b=pcKsFBSXtISvSb3TERRa54/vvZzzkEll/u0qs01NF5bB3uCanqP3fTmjNjE5hyMOTpHtoL4yw0Yeo2bPAJ5Wt3n2D2L3bw3keJJxVU/eoD9RMze0UT+qV6c4ZuVJ8YBsyiOtXgHz5JXqa6Z8IMLd3T/jrjuBeoAaOU4WScDTbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083243; c=relaxed/simple;
	bh=5hGCHZ16GYA5B5CVathFNkAzTggSnhUUC7sYohitXJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0/4Jgbtxq1x1+OnSSbKQZWRkospuCkKd7FoikdwuWh/qdMVEtNbt4wRnycxgiyHYhFI3/LareWUuLE3XvKHSii79xcD3tHdSPUEihkAcd6zVrmxGN4CtyLfVDq5eIYg3JKw3TCgCtoHrHVzY4xj78IrUdDkLbSiR19myEUd6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUrvmbS5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4281faefea9so35252225e9.2;
        Mon, 19 Aug 2024 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724083240; x=1724688040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWbJ0BhqL6s2vTUYqgwljUkHYPKs32/xl7KupWHrSQw=;
        b=FUrvmbS5Di8GVuiPHQBm9voyXH2fW2NiWW6brQs23+549mrOHpIVKe9ey29RZVv4Jz
         0qY+b1vYJllCPdd2J8lf2OA9D7kC5+VEJq2HmFCGQPhpL7gzNavN8Tzkbz9csvs2rYKt
         hmGpDfbun7FobyEWqb+rptNXIEBlX1eGMYT6DHXfOX60DdSJzDJKdB5ie7aAddAjQz/j
         FUotWZ/rmgphGan5Fta/cvxy03twGNcU5B3b6H9ey9zW4g9Ax1YMstOeUqlxSdBCtV5D
         YQTLO+4AAYYFGew1CIIUNMhocTqfnV/oDjYCz9Pn+L4WSoHIP2Itg1NJCK3tidJNyjLu
         6GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083240; x=1724688040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWbJ0BhqL6s2vTUYqgwljUkHYPKs32/xl7KupWHrSQw=;
        b=RksiaQ1sXnmF6+XxB3Lx4NX6RdMKpVBRp3lwBPJaIPGmSrwUwec/OdxsvgbbXgcMyI
         66uB9ImVrjVaoilFxqpLn1Gg50trQrShqNJ2XuRE2etvbG4WC4Aa0GA0YOzbSx8EI9wf
         boo2WorNCqqIkjRMhTznHUIYwP/gebTi/KOEWaDEgN/mlOKyEYRL7Wu53/bmc8XBLHbc
         LqWhpRzWWsd6K0UCt0I9ditoVHLs85AP9/4G8QVKWlLvX4mZQLfM7UsEgRpObQfNIE8m
         bplgBtfTicSzeFUMePqmxDz6wAv4zJzgwhT4PLfmg7QTRnqs1u2Civ7hmz/o+Vo35YWx
         HhfA==
X-Forwarded-Encrypted: i=1; AJvYcCVneBJLdFxaKyLMshSucB6sDei8lgAHL9KnedGlC+lNtZVk1uZ8lcpj6iiAAjtcxCLL2l0WqCC/@vger.kernel.org, AJvYcCWWSf6/BW3NXa+6ScNqbs3lmWt+PiZAE8UnyrpPenPXdx77Tb9AkNzEadmxUpbCYiCK/1alm56IB2zSIgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL+rOjMfo4P494LXiXRTkA9BhQCYX2XwPYix5JSWxqWe5FRI08
	JTHsT4oGZraAAfIZelta/pjeV6cff/VKkynMuZUFIxewj6Ga0NiAqX9CzX5ymia2jmduvOXTOSC
	Wiv3MBL4uJvj5BQelf9Y8/FB7rrk=
X-Google-Smtp-Source: AGHT+IFv0JarxFL93l4RwfEzjHDNqs6h6zrrWLAttKmO8FvHt3HiRgMIKiWxxsosOtDijZxju7uE95jYZNxAsaInboA=
X-Received: by 2002:a05:600c:1d95:b0:426:6eb9:db07 with SMTP id
 5b1f17b1804b1-429ed789168mr71821225e9.13.1724083239371; Mon, 19 Aug 2024
 09:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-8-linyunsheng@huawei.com> <0002cde37fcead62813006ab9516c5b2fdbf113a.camel@gmail.com>
 <a036abc3-76a0-450c-afea-2db3c10f0ed5@huawei.com> <CAKgT0UfUVJ6FmVgFWv+uCV9Q7eX8s+Mf6cPVCLyHwk5TxtuKgg@mail.gmail.com>
 <1a6aab37-2783-45a2-8edd-0990b211ac2d@huawei.com>
In-Reply-To: <1a6aab37-2783-45a2-8edd-0990b211ac2d@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 19 Aug 2024 09:00:02 -0700
Message-ID: <CAKgT0UeUhf_FuGRuEBkrqNSGWd3a4FbY=FLhqbdcM+BhdFGjGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v13 07/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 4:56=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/15 23:03, Alexander Duyck wrote:
> > On Wed, Aug 14, 2024 at 8:10=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2024/8/15 0:13, Alexander H Duyck wrote:
> >>> On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> >>>> Currently there is one 'struct page_frag' for every 'struct
> >>>> sock' and 'struct task_struct', we are about to replace the
> >>>> 'struct page_frag' with 'struct page_frag_cache' for them.
> >>>> Before begin the replacing, we need to ensure the size of
> >>>> 'struct page_frag_cache' is not bigger than the size of
> >>>> 'struct page_frag', as there may be tens of thousands of
> >>>> 'struct sock' and 'struct task_struct' instances in the
> >>>> system.
> >>>>
> >>>> By or'ing the page order & pfmemalloc with lower bits of
> >>>> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
> >>>> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
> >>>> And page address & pfmemalloc & order is unchanged for the
> >>>> same page in the same 'page_frag_cache' instance, it makes
> >>>> sense to fit them together.
> >>>>
> >>>> After this patch, the size of 'struct page_frag_cache' should be
> >>>> the same as the size of 'struct page_frag'.
> >>>>
> >>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >>>> ---
> >>>>  include/linux/mm_types_task.h   | 16 +++++-----
> >>>>  include/linux/page_frag_cache.h | 52 ++++++++++++++++++++++++++++++=
+--
> >>>>  mm/page_frag_cache.c            | 49 +++++++++++++++++-------------=
-
> >>>>  3 files changed, 85 insertions(+), 32 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_=
task.h
> >>>> index b1c54b2b9308..f2610112a642 100644
> >>>> --- a/include/linux/mm_types_task.h
> >>>> +++ b/include/linux/mm_types_task.h
> >>>> @@ -50,18 +50,18 @@ struct page_frag {
> >>>>  #define PAGE_FRAG_CACHE_MAX_SIZE    __ALIGN_MASK(32768, ~PAGE_MASK)
> >>>>  #define PAGE_FRAG_CACHE_MAX_ORDER   get_order(PAGE_FRAG_CACHE_MAX_S=
IZE)
> >>>>  struct page_frag_cache {
> >>>> -    void *va;
> >>>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >>>> +    /* encoded_va consists of the virtual address, pfmemalloc bit a=
nd order
> >>>> +     * of a page.
> >>>> +     */
> >>>> +    unsigned long encoded_va;
> >>>> +
> >>>
> >>> Rather than calling this an "encoded_va" we might want to call this a=
n
> >>> "encoded_page" as that would be closer to what we are actually workin=
g
> >>> with. We are just using the virtual address as the page pointer inste=
ad
> >>> of the page struct itself since we need quicker access to the virtual
> >>> address than we do the page struct.
> >>
> >> Calling it "encoded_page" seems confusing enough when calling virt_to_=
page()
> >> with "encoded_page" when virt_to_page() is expecting a 'va', no?
> >
> > It makes about as much sense as calling it an "encoded_va". What you
> > have is essentially a packed page struct that contains the virtual
> > address, pfmemalloc flag, and order. So if you want you could call it
> > "packed_page" too I suppose. Basically this isn't a valid virtual
> > address it is a page pointer with some extra metadata packed in.
>
> I think we are all argeed that is not a valid virtual address by adding
> the 'encoded_' part.
> I am not really sure if "encoded_page" or "packed_page" is better than
> 'encoded_va' here, as there is no 'page pointer' that is implied by
> "encoded_page" or "packed_page" here. For 'encoded_va', at least there
> is 'virtual address' that is implied by 'encoded_va', and that 'virtual
> address' just happen to be page pointer.

Basically we are using the page's virtual address to encode the page
into the struct. If you look, "virtual" is a pointer stored in the
page to provide the virtual address on some architectures. It also
happens that we have virt_to_page which provides an easy way to get
back and forth between the values.

> Yes, you may say the 'pfmemalloc flag and order' part is about page, not
> about 'va', I guess there is trade-off we need to make here if there is
> not a perfect name for it and 'va' does occupy most bits of 'encoded_va'.

The naming isn't really a show stopper one way or another. It was more
the fact that you had several functions accessing it that were using
the name "encoded_page" as I recall. That is why I thought it might
make sense to rename it to that. Why have functions called
"encoded_page_order" work with an "encoded_va" versus an
"encoded_page". It makes it easier to logically lump them all
together.

