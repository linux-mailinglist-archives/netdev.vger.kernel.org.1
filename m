Return-Path: <netdev+bounces-189273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EF8AB16D9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042AA16FFE7
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A0626FDB9;
	Fri,  9 May 2025 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KUNMSg0x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA79E21D5B6
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799718; cv=none; b=cWUSa8L1fEJqdyFQODfluyP0V4w8ZIuULFA4OKeUcMLha8q17KuZfVhGzQAf98D7t542U/qfggfpmcBgdUmGk/ZE5n3AJz/oSqic/RamF743eWYIwsxwwKEVYufWEkwPMBGXeMF9AwWZIFVtkxc0NWsQn7YjjhmSdPEF3ovz/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799718; c=relaxed/simple;
	bh=yB9tD82kZsx4nMI0j7OrKYBQSWlkAqwno2nGol5/f0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOnxSbxaAIHjGS2FxrHLmjgb44ro/W8vMjsWbfPkbl2R9oE7t7HW2iGqxj+Yg16OA1UAbcMMPSVOhkU3MWxRIOtnIAw600OnvsnUyo/g4ZFHrxQhJfhmcu+aIYjvmHJLvO+4OEIeeHPzcqsD+GtIVjJSDShEzoRhAc440tpRSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KUNMSg0x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e1eafa891so204725ad.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746799716; x=1747404516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFqbnVNc9dUbim4PbQYLYQFSIiUpvMdYWkhdEyrUVQI=;
        b=KUNMSg0xxq8UD0Icd5mup/857PZeisTv+UK+WJp20PZzIb7msFlwY52zuwtfwojcK8
         h4UAZA0sRKR9YThn6DVg3C2gyrY+ea3cKQUwrGbPzy/g8KvryDyKEwCpL4C1wWzw7oSX
         ZpAzRfEwTeulI+YiJVStxJIFEn/fpaxHTNIbzMoaS4ywWjFsWer75IZ3THRon4ZThQgU
         PlV0HRmIRzx7zByb2IvQKQp5ma0zpt+4hcXKfhR794ns/ohtVioo9pzKoYBqpb+9ZHSJ
         ZD5fbFMW1CjYlnZ+3hN/NtdUWAbZYfWDD/pIKMDRY2a5TlkSkoyZsudmoQ8AKZVTg+RB
         5fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746799716; x=1747404516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFqbnVNc9dUbim4PbQYLYQFSIiUpvMdYWkhdEyrUVQI=;
        b=HrdgvdvtqvUOD37NmXM3MLiVv0Ht+GYJ/gs8zxznsiUdaCCsl1xLq4bStxaCUczeID
         D0PURZzCH6QZhK7VQr/oFKPJppxmw2Mfgv3tstQwGcbeJuXMU/LC0rEh2KpMkU7oi+RF
         2RgOQpF1Wl/Naoowndos/xl03/Ij+qHHcleJfUJlPTVv8KYjzl0Tofw9xpr+X796z3AU
         THIVj3hxRcqCXNqev5XFsNs72ejkHu8fSsv6uoqRcaPpL1/cJw2iD3zVMwbvRgZA4Fof
         d9VPj8C9uQnpezKQOU8fJcig8Tcgg4YP4S241m5ZAoeKV3slYm3TTYZkwcqe6zNgBtk4
         VKXA==
X-Forwarded-Encrypted: i=1; AJvYcCVmSI8YempSfl97MZfkoV9iRJpx9gqduvLVq+sunnnp/b7mJL/nmZoQ8e6xX46DCD0QqwKVok8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZn4jAaxKJgyVnMBwcgfstaT6IG04Xt5cIcn2y5ulDBNJZ47q
	CAR49cUEHKepVySLdIYYcc2QUgoesb0VEChdW8kaocMS6D57qtjtLt/bZTtdTy37jtVvAM1dF78
	tQudxY+OpMWU1wvIWZUfSirEBA4JtY8JIpZP3
X-Gm-Gg: ASbGnctIg5QrOVKEokmdp5QCgXtENhnooJQ/5ceiua7CzxVbx0i1AEv6v2YAEyInniz
	1YUQpZlvrdcN9D+JMIxT3VODOR9zyaNuHC5GDMP5yFrjuYA60eoJnHpx/oFxbjvhhoz3YESDXjR
	ovR3E+oN5YPi6+Mok/cc2Smt66MdvkN/SkYQ==
X-Google-Smtp-Source: AGHT+IGwAYiqOkI69U23WzHUisbNBNCgh5LKXHUJCNsnc9/k2TMV/9VsQx1gC7vPeTFcX4NQS+9fo9X8M2DV4yPtZDU=
X-Received: by 2002:a17:903:1d1:b0:21f:56e5:daee with SMTP id
 d9443c01a7336-22fc950b8c9mr2937835ad.6.1746799715468; Fri, 09 May 2025
 07:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509115126.63190-1-byungchul@sk.com> <20250509115126.63190-3-byungchul@sk.com>
 <CAHS8izOVynwxo4ZVG8pxqocThRYYL4EqRHpEtPPFQpLViTUKLA@mail.gmail.com>
In-Reply-To: <CAHS8izOVynwxo4ZVG8pxqocThRYYL4EqRHpEtPPFQpLViTUKLA@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 May 2025 07:08:23 -0700
X-Gm-Features: ATxdqUESv5rvoqSiI-S_NcuOU50UhlEM7rerRk6BBS4ZPkn6WrJLg_cavsMJdRE
Message-ID: <CAHS8izP3knY42632AcfTHcpgpSz49gP0j6CnyswUoHW6JtC3=w@mail.gmail.com>
Subject: Re: [RFC 02/19] netmem: introduce netmem alloc/put API to wrap page
 alloc/put API
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

j

On Fri, May 9, 2025 at 6:39=E2=80=AFAM Mina Almasry <almasrymina@google.com=
> wrote:
>
> On Fri, May 9, 2025 at 4:51=E2=80=AFAM Byungchul Park <byungchul@sk.com> =
wrote:
> >
> > To eliminate the use of struct page in page pool, the page pool code
> > should use netmem descriptor and API instead.
> >
> > As part of the work, introduce netmem alloc/put API allowing the code t=
o
> > use them rather than struct page things.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/net/netmem.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 45c209d6cc689..c87a604e980b9 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -138,6 +138,24 @@ static inline netmem_ref page_to_netmem(struct pag=
e *page)
> >         return (__force netmem_ref)page;
> >  }
> >
> > +static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
> > +               unsigned int order)
> > +{
> > +       return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
> > +}
> > +
> > +static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid=
,
> > +               unsigned long nr_netmems, netmem_ref *netmem_array)
> > +{
> > +       return alloc_pages_bulk_node(gfp, nid, nr_netmems,
> > +                       (struct page **)netmem_array);
> > +}
> > +
> > +static inline void put_netmem(netmem_ref netmem)
> > +{
> > +       put_page(netmem_to_page(netmem));
> > +}
>
> We can't really do this. netmem_ref is an abstraction that can be a
> struct page or struct net_iov underneath. We can't be sure when
> put_netmem is called that it is safe to convert to a page via
> netmem_to_page(). This will crash if put_netmem is called on a
> netmem_ref that is a net_iov underneath.
>

On a closer look, it looks like this put_netmem is only called from
code paths where you are sure the netmem_ref is a page underneath, so
this is likely fine for now. There is a net_next series that is adding
proper put_netmem support [1]. It's probably best to rebase your work
on top of that, but this should be fine in the meantime.

[1] https://lore.kernel.org/netdev/20250508004830.4100853-1-almasrymina@goo=
gle.com/

--
Thanks,
Mina

