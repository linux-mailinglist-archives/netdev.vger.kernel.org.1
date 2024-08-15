Return-Path: <netdev+bounces-118897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F7D95371D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C7EB21AB6
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB3A1AAE07;
	Thu, 15 Aug 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrqWkRE6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E7176AA3;
	Thu, 15 Aug 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735561; cv=none; b=uTLpm1+e0rxdvuRDOUpA8Panndvwj+wJjUIkBcl9zF9cAJ9x2MHMFDL5cJ4HBe4WuKjlWJDESsaI/+SYI5EPSZggBy5YGBtPLK//pHA+T93KWXY7g58aHYa9Uf3g5s/af1SnKzWAWcZkVdN2vqjtk5rtA7/KsuYXwFPPPLws9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735561; c=relaxed/simple;
	bh=cYz+TDDhsykODWMTDqbceoQB+zKzHA+X3bE50CBx4m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTdImkX1tQWxf3TJd5CPAt5olcCzCrtNv4GeMK7IQkJ/4b/aDSbIANqqutIer1RubSKItFrVh2WbKLTopNN6dUNUQ5WMSy4DAjv/NFhTpvdXwhUFVvkLKk56ojdU9j8M4NVaVFBbwQ3Cd+OdW5ud/BM70Kt4nj9Df+Mh5lO7uVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrqWkRE6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42803bbf842so9845315e9.1;
        Thu, 15 Aug 2024 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723735558; x=1724340358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGytb5LTYI4euY6Qlrzf7/tyRyLi82Zco7uVwIScyTY=;
        b=VrqWkRE6Sy3uABI2P3Oq1xg/DcLlWrQ/8D/I/Ygxyy0vZ95cbd196lvmXY4ObTphTx
         H97SDiTev5QmVmaqamNpTnUDMxqEo6VbDZthI0Erd7G5Hshzu0P/9o6C/nHrIsqIw6jo
         h13LVwCcW+cSVDqOm5HgliI5ETEGAXvOJl4dIU85O35PVEHPGYw4BKUBddAbmQb2ymWF
         V03vHEltYctPaX6iEaJ5F5kfgxILMmulkPGkcDDGwIeyDL0oZwoXmQFea/x9AejVR2c3
         aljNO3OPD63eW9Qb3JnajUBAk1+QT1GFLnysnYZPaFl8m34pMFt8A6WN7UZeThW1krhj
         KRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723735558; x=1724340358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGytb5LTYI4euY6Qlrzf7/tyRyLi82Zco7uVwIScyTY=;
        b=YJ62NtxSORUibVgOa8dSkmsGCxodc3peYeGLb4Gw9q0ZEykZbYEj9Q+4um8nishPao
         DO/7jLTlnJ4FhXHKIsH9+XVjigPceDyyrKy89bXi0WaqZXOo28fc8VYz///6s4Fj3OMS
         2s/p/eHvU6YyLwPzkR3P8FbtiT486n+oiHxT2x4LhuGmfVAXnol0N0JqhMUEpLWZY3CU
         lPSOH1FXmBsu4Mo/WaUwAgd9i6CKC/0p12GrgOl/eJWrl8e1aZiVm35ez2d7JH8HH8Eg
         BghKOBBcXgprw5fYw891j+ISAWQKjL38LwrYklAx9R9hKlElJD+WUFJxGFq/K/wHlbnT
         Q4BA==
X-Forwarded-Encrypted: i=1; AJvYcCXnJ40ofm9brdLbhcNhgtMCJ+Il46SPWfQprhdVo4BnWbpJ5EUY2jBPSp9UVGHPkwW1q/gSEvmxckd2z+bMYTyWsnDgH4oTEArkM8cDkNfpEXb0zTRjQgZmhMkTwjIy2kxDqgFs
X-Gm-Message-State: AOJu0YzznaFFwQf1AHfXGM5cAwR20o8Vvwirzxspw5C5joMiWY+2qAjj
	tgh8iH+KCr1T7HFwsIvHRVfrKEscagI1GhSBn9cTRr6fdI6nWeSiEBhe/K7dMo19BhweVIFbpDD
	HVAIN38OJ7s9OfrHp6osXl4PqRqOZ2oS7
X-Google-Smtp-Source: AGHT+IF+q+3Fjs27gzFiH+tEX4ugMizHrZJESz/KVjstuzcfFCh03nxywzC6Lzyp8oSUUoYp5HmYF3tulbgjvTqq2Y4=
X-Received: by 2002:a05:600c:511e:b0:426:59d3:8cae with SMTP id
 5b1f17b1804b1-429dd236521mr63021845e9.13.1723735557660; Thu, 15 Aug 2024
 08:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-12-linyunsheng@huawei.com> <d9814d6628599b7b28ed29c71d6fb6631123fdef.camel@gmail.com>
 <7f06fa30-fa7c-4cf2-bd8e-52ea1c78f8aa@huawei.com>
In-Reply-To: <7f06fa30-fa7c-4cf2-bd8e-52ea1c78f8aa@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Aug 2024 08:25:21 -0700
Message-ID: <CAKgT0Uetu1HA4hCGvBLwRgsgX6Y95FDw0epVf5S+XSnezScQ_w@mail.gmail.com>
Subject: Re: [PATCH net-next v13 11/14] mm: page_frag: introduce
 prepare/probe/commit API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:05=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/15 5:00, Alexander H Duyck wrote:

...

> >> +static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
> >> +                                     unsigned int fragsz)
> >> +{
> >> +    nc->pagecnt_bias++;
> >> +    nc->remaining +=3D fragsz;
> >> +}
> >> +
> >
> > This doesn't add up. Why would you need abort if you have commit? Isn't
> > this more of a revert? I wouldn't think that would be valid as it is
> > possible you took some sort of action that might have resulted in this
> > memory already being shared. We shouldn't allow rewinding the offset
> > pointer without knowing that there are no other entities sharing the
> > page.
>
> This is used for __tun_build_skb() in drivers/net/tun.c as below, mainly
> used to avoid performance penalty for XDP drop case:

Yeah, I reviewed that patch. As I said there, rewinding the offset
should be avoided unless you can verify you are the only owner of the
page as you have no guarantees that somebody else didn't take an
access to the page/data to send it off somewhere else. Once you expose
the page to any other entity it should be written off or committed in
your case and you should move on to the next block.


>
> >> +static struct page *__page_frag_cache_reload(struct page_frag_cache *=
nc,
> >> +                                         gfp_t gfp_mask)
> >>  {
> >> +    struct page *page;
> >> +
> >>      if (likely(nc->encoded_va)) {
> >> -            if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_b=
ias))
> >> +            page =3D __page_frag_cache_reuse(nc->encoded_va, nc->page=
cnt_bias);
> >> +            if (page)
> >>                      goto out;
> >>      }
> >>
> >> -    if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
> >> -            return false;
> >> +    page =3D __page_frag_cache_refill(nc, gfp_mask);
> >> +    if (unlikely(!page))
> >> +            return NULL;
> >>
> >>  out:
> >>      /* reset page count bias and remaining to start of new frag */
> >>      nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> >>      nc->remaining =3D page_frag_cache_page_size(nc->encoded_va);
> >> -    return true;
> >> +    return page;
> >> +}
> >> +
> >
> > None of the functions above need to be returning page.
>
> Are you still suggesting to always use virt_to_page() even when it is
> not really necessary? why not return the page here to avoid the
> virt_to_page()?

Yes. The likelihood of you needing to pass this out as a page should
be low as most cases will just be you using the virtual address
anyway. You are essentially trading off branching for not having to
use virt_to_page. It is unnecessary optimization.


>
> >> +struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
> >> +                            unsigned int *offset, unsigned int fragsz=
,
> >> +                            gfp_t gfp)
> >> +{
> >> +    unsigned int remaining =3D nc->remaining;
> >> +    struct page *page;
> >> +
> >> +    VM_BUG_ON(!fragsz);
> >> +    if (likely(remaining >=3D fragsz)) {
> >> +            unsigned long encoded_va =3D nc->encoded_va;
> >> +
> >> +            *offset =3D page_frag_cache_page_size(encoded_va) -
> >> +                            remaining;
> >> +
> >> +            return virt_to_page((void *)encoded_va);
> >> +    }
> >> +
> >> +    if (unlikely(fragsz > PAGE_SIZE))
> >> +            return NULL;
> >> +
> >> +    page =3D __page_frag_cache_reload(nc, gfp);
> >> +    if (unlikely(!page))
> >> +            return NULL;
> >> +
> >> +    *offset =3D 0;
> >> +    nc->remaining =3D remaining - fragsz;
> >> +    nc->pagecnt_bias--;
> >> +
> >> +    return page;
> >>  }
> >> +EXPORT_SYMBOL(page_frag_alloc_pg);
> >
> > Again, this isn't returning a page. It is essentially returning a
> > bio_vec without calling it as such. You might as well pass the bio_vec
> > pointer as an argument and just have it populate it directly.
>
> I really don't think your bio_vec suggestion make much sense  for now as
> the reason mentioned in below:
>
> "Through a quick look, there seems to be at least three structs which hav=
e
> similar values: struct bio_vec & struct skb_frag & struct page_frag.
>
> As your above agrument about using bio_vec, it seems it is ok to use any
> one of them as each one of them seems to have almost all the values we
> are using?
>
> Personally, my preference over them: 'struct page_frag' > 'struct skb_fra=
g'
> > 'struct bio_vec', as the naming of 'struct page_frag' seems to best mat=
ch
> the page_frag API, 'struct skb_frag' is the second preference because we
> mostly need to fill skb frag anyway, and 'struct bio_vec' is the last
> preference because it just happen to have almost all the values needed.

That is why I said I would be okay with us passing page_frag in patch
12 after looking closer at the code. The fact is it should make the
review of that patch set much easier if you essentially just pass the
page_frag back out of the call. Then it could be used in exactly the
same way it was before and should reduce the total number of lines of
code that need to be changed.

> Is there any specific reason other than the above "almost all the values =
you
> are using are exposed by that structure already " that you prefer bio_vec=
?"
>
> 1. https://lore.kernel.org/all/ca6be29e-ab53-4673-9624-90d41616a154@huawe=
i.com/

My reason for preferring bio_vec is that of the 3 it is the most setup
to be used as a local variable versus something stored in a struct
such as page_frag or used for some specialty user case such as
skb_frag_t. In addition it already has a set of helpers for converting
it to a virtual address or copying data to and from it which would
make it easier to get rid of a bunch of duplicate code.

