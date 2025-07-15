Return-Path: <netdev+bounces-207255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F982B0667B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 21:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A18B1AA2E70
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243582BF3DB;
	Tue, 15 Jul 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsJCMlsL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300929B20C
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606414; cv=none; b=AhT/zgsZI5o5cOIlXb7LoBCHy3Wg/oM579pxP3ME+Af8MhwMUKZM2LqfeuMvf1dK3ceiun2+tnIdG/6s1mOcjmfHM2mkymkApvSx+lomTqsEaGvPrl0XyIBJiWYPxz7qUrxLge9BNcqd/zENHGQHhZO22wnj8LoelKsTs37tTck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606414; c=relaxed/simple;
	bh=sN4QN3SKsFD89oM64C8vf3kZbJolgxRcrqdfdWWS2SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mi2jfsWxZuHutbNmKbI3iOFL1o2SyezsytsALvyTtGqXIE8kJg0iH4WFdSa+ZLIuBPJlqr8yfnMe7wl8aGc2UpncLp7U8NGrVVLtv+cX0pFGVYLHLIVogTjuK0XWLq1NPen3cpMO4SUjJgduGutS2SOhZV15yCve2K5CJwND390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hsJCMlsL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23dd9ae5aacso35955ad.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 12:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752606410; x=1753211210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzQixld7pSKyZ/Q/HfBpbSkDP1wbVsZogbStCOaFhmk=;
        b=hsJCMlsLzbHtxai+yO9y2t13uxDnw+smI79jHQdXB28pwozThKUPgPpqz0DqToJS1P
         seby5ehtbvjdb3OxmOqIVnAeqIn6Fe4tG/obE5f9RdyBY4VtpDCBBdOFG2ezr/mikkot
         7b4qJh9WfckramIQPdY/4bw9zPxmoTXKh4WViLJYjpe7wgpHBLnJ/UTH9QxO2HsBCafW
         30UVr1cG2vpUUjqzAqvebLgZok8EoAQqlc78lKeN0FsLEMnr9rZC0Mayy9UKRIStXizx
         rW3ERWGuwukR+a9L9/LR4iYGdraR/W9gXR28Ql/aEF5pW+W1apuxhD2KL+ABsG9lcP3U
         XmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752606410; x=1753211210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzQixld7pSKyZ/Q/HfBpbSkDP1wbVsZogbStCOaFhmk=;
        b=HVutDaTA0NTNJ5Omo+NNhleQ8LdMFUyclyZ3600uJ35YaTPpMeoTn/tS/0S3F24aiB
         8BsJC0eY2mTeSD3pVoNDCd6gbcVqYyE5QJqe7Qx260W8L1aIRi1y1XCJZlj07WKkSHIN
         eiRY1bNxb6GnSgYUcfKQwUBhAaD3zbNqZcvmBvteZpKv6X06dfFwEPxEbWsnNxxifZ0k
         77Iipw/S0SssqqXGTd77aqzw2/iVmwBMFQ+zfN5K8RYHfViuBCCdjBAPm9s3b/mHNxv8
         vZ99eGqXp9lscwkEyI2Z4EWWAKSCe50G2iy7DiblF3w14Zpg6an8DSxIQinBxeugkfer
         N6kw==
X-Forwarded-Encrypted: i=1; AJvYcCW6wQit6cGzx74jTnDnbjpGET2xTPKUOT5guYIA7dGhhFfcZHE3HKb9lxYAIF5q6rOhObJ8Rtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgpYze0hznS24M25SpbUL4kiyoh2BwhMoYkXHesAZeL5nBgDX7
	DhdLsYgmxnfQYlsBI4jmdwWYVPwyoV8yBS1KZgEuXqSKvPmdzwPTdg1DAPJWvSFH/ZdHk2i4Dox
	b3z/F1VDIPVK6TLTVyFUUEvVmu1DRP5QtvgV1fctdqG6TLd/tminGWyNLYLM=
X-Gm-Gg: ASbGncvyP/yg40f14trYfNB6OvFbMiIqt9snYZCQHWL9UsWJOcSodpp77u2//J9N0MR
	Zgh3jZrbthTfRhNWifP1UVWZeAyup1NritCPmRDKdEb/aq6aANV88of8cQppkDfvYrrTeA+CisA
	i4kC5428rmc4YtCjg0MPNMpQ65+eKr2qlbUaoCx4M7BLUmFvPzk/5TuA2xJM0e2Vc1K0OGxHG+8
	2I4r8Qsq8iKZc37m5RAlfrcOpD6fd8pC6RHnA==
X-Google-Smtp-Source: AGHT+IERW8BNAcLICEi0xDHHwbh6I9mZCyIk3Mt306+jQnPwqHCieheEaqBVCmnvb9hqZyStUnuqxe9DuyWkdC9x3QM=
X-Received: by 2002:a17:902:cec3:b0:235:f298:cbbb with SMTP id
 d9443c01a7336-23e24c6e119mr315625ad.26.1752606409905; Tue, 15 Jul 2025
 12:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714120047.35901-1-byungchul@sk.com> <20250714120047.35901-3-byungchul@sk.com>
 <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com> <9bed2f6e-6251-4d0c-ad1e-f1b8625a0a10@gmail.com>
In-Reply-To: <9bed2f6e-6251-4d0c-ad1e-f1b8625a0a10@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 15 Jul 2025 12:06:36 -0700
X-Gm-Features: Ac12FXwyUUoU8xGdECWjpzai5Qr9bPwFw8HDcAUKWZbO5pnAVYeauYEt5y8_8Qs
Message-ID: <CAHS8izMYLw3JfonoQ7n4ZaWivdBVKqZejgyRiAku5j1rx7gBPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of
 page to access ->pp in __netmem_get_pp()
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, akpm@linux-foundation.org, 
	andrew+netdev@lunn.ch, toke@redhat.com, david@redhat.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	jackmanb@google.com, wei.fang@nxp.com, shenwei.wang@nxp.com, 
	xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com, 
	tariqt@nvidia.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, 
	mbloch@nvidia.com, danishanwar@ti.com, rogerq@kernel.org, nbd@nbd.name, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, aleksander.lobakin@intel.com, 
	horms@kernel.org, m-malladi@ti.com, krzysztof.kozlowski@linaro.org, 
	matthias.schiffer@ew.tq-group.com, robh@kernel.org, imx@lists.linux.dev, 
	intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:36=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 7/14/25 20:37, Mina Almasry wrote:
> > On Mon, Jul 14, 2025 at 5:01=E2=80=AFAM Byungchul Park <byungchul@sk.co=
m> wrote:
> ...>> +static inline struct netmem_desc *pp_page_to_nmdesc(struct page *p=
age)
> >> +{
> >> +       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
> >> +
> >> +       /* XXX: How to extract netmem_desc from page must be changed,
> >> +        * once netmem_desc no longer overlays on page and will be
> >> +        * allocated through slab.
> >> +        */
> >> +       return (struct netmem_desc *)page;
> >> +}
> >> +
> >
> > Same thing. Do not create a generic looking pp_page_to_nmdesc helper
> > which does not check that the page is the correct type. The
> > DEBUG_NET... is not good enough.
> >
> > You don't need to add a generic helper here. There is only one call
> > site. Open code this in the callsite. The one callsite is marked as
> > unsafe, only called by code that knows that the netmem is specifically
> > a pp page. Open code this in the unsafe callsite, instead of creating
> > a generic looking unsafe helper and not even documenting it's unsafe.
> >
> >>   /**
> >>    * __netmem_get_pp - unsafely get pointer to the &page_pool backing =
@netmem
> >>    * @netmem: netmem reference to get the pointer from
> >> @@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clear_lsb(n=
etmem_ref netmem)
> >>    */
> >>   static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> >>   {
> >> -       return __netmem_to_page(netmem)->pp;
> >> +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
> >>   }
> >
> > This makes me very sad. Casting from netmem -> page -> nmdesc...
>
> The function is not used, and I don't think the series adds any
> new users? It can be killed then. It's a horrible function anyway,
> would be much better to have a variant taking struct page * if
> necessary.
>
> > Instead, we should be able to go from netmem directly to nmdesc. I
> > would suggest rename __netmem_clear_lsb to netmem_to_nmdesc and have
> > it return netmem_desc instead of net_iov. Then use it here.
>
> Glad you liked the diff I suggested :) In either case, seems
> like it's not strictly necessary for this iteration as
> __netmem_get_pp() should be killed, and the rest of patches work
> directly with pages.

Good catch, in that case lets just delete __netmem_get_pp and there is
no need to add a netmem_nmdesc unless we find some other call site
that needs it.

--=20
Thanks,
Mina

