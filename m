Return-Path: <netdev+bounces-189251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9654AB1568
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C85416D3A0
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101E329186E;
	Fri,  9 May 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZsepdH1l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65332EAC7
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797963; cv=none; b=q3+HtSqBc/caG9/xu2mVW6tjnBNV45dZDP2oJ0K6rP5hUzKzHtaoq2Buj1OcLTgUeHRWJQf+WmPnGR/oP9ad4D+TOXcjBK37IVJ7hI6RgCQi6s8+EUzWOG4gV/kv7XAk5Eshx9jrwCBil1PIzhCdSIVkUwuWHTSsaNzIFzxT+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797963; c=relaxed/simple;
	bh=+SAecJshSRPaIcVA50Z2ct3hxvegOjl9jzM4zGt/nm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHMA3WJopSvy9tgJNTBCgKlqvwCIxeLPv7TxcWPlPQezn0QMuCn8nwc9NaxOcHwov5uhasrZSzeGlfcQrQjlBQWu/iFlIzJicbFfnzfrtfjfcfBwjcjS9NFsKwQK0WEM6S+mhelBVhU/dDRp6LewWPoZJuHeaB7YZajoOPea/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZsepdH1l; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e1eafa891so199035ad.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 06:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746797960; x=1747402760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fxOminYtpWUZQiMgSZHXWpN5MCC4KN4wDDm2MDcmMo=;
        b=ZsepdH1lw0wBjyHOSx274dzRNiFogOj7NxxHd0ef25U1sqyTLf8ekxpudtINOBXihz
         dBg+OgZNb2/CweObE4Xvl0cxFcMiPanuq7SGgSUgpoIF6Eb+owHQdgvGrTVN/6pTcSXE
         NC6Igw0K3vYFAzG36b199BxGNLzntF4gAkb5PX9NRk87u/axbu2gs7nVqmhoKRy4G2j9
         3kcDIEJi+rA5XjRUgJitkxUxs0b3/ANagle9YRV74tlinaLGHBKv62Ys+pjdTIJ30SCT
         hqdpLySXkzmp6RN1UdEY5oyb46ud7yS4JgJj3eg3OTvrRU1fN3UEE5772UHWkCYJ5Pha
         3KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797960; x=1747402760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fxOminYtpWUZQiMgSZHXWpN5MCC4KN4wDDm2MDcmMo=;
        b=YMEcuf/Rbu59lZIzwP+xkrbbzFqTqWF8+0S59XyHi/LhkfY0SwMI08w1FRDC+lk/+s
         L0FV5MQ996dyvZeG5denct0Wdnk/19J64BPcrJXFmdLYrGEjoE7FFIxwAeyRHN0Jjrog
         icHX/l0/bzQ5Mf+OZZDDySGGnj9D7IUsyIqAWcifyW9583ujTl6xjM1jDYAsB23CLNyw
         7xmVKNN+FH33IfRHq4e0C+it6VelrV2aQ2qTsYXUrbBqQ/gbcuuRGyRDagPzP9NLC5sz
         YH8BH+gZiOcJOXbRGioYRcV6xDp+iA6Jw2XIKKAEZeqy92Ex7o7zmwCHiWlWCJUZMDPW
         1tcA==
X-Forwarded-Encrypted: i=1; AJvYcCUSmFGJiIsWwe/PhpduTt0L9/wp8cd+r3Gh7onpbBTYpK344Vek7o1s7fb+Qvq39BdGsdKZ1Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfzA+mnCeKOOARz948TsVbB+pqBX+AYbMHX4w9TIIGFfc9Vtn
	vgj9B2YCBvfbzf+gfNWe6prsoBgjHWFOIuHwNxQLupVy3LkDRDbBf1N5u6pMAkV/SdqH5iYIYQ1
	PwJ5w7Krr2hjI4+5d8++eiOpWjG8YB4xXSsyc
X-Gm-Gg: ASbGncuFBwC9iIPa2e0jbcoDUqAKIjveh6arBUrjrDWa97pSkkm6InNRMHN86bYAEId
	ohihA3+O+plXvdHgIEf7U0fcOZk3hHHD2UulHSffl+hiCrAYTKHMW/Dwa2fFFNzXqxkSLEDJXpF
	/xfGSq9xz9EynYVgwrCHXFYZw=
X-Google-Smtp-Source: AGHT+IEwSfRNnaH95+h5gTCk6s7PbcKJRcNX84WicSnspnOWS7dZFt3dRyIY7kPhGsxUj79tWFtNab4qqD/H8cMPSEI=
X-Received: by 2002:a17:903:2348:b0:223:37ec:63be with SMTP id
 d9443c01a7336-22fc950c1a6mr2674515ad.4.1746797960304; Fri, 09 May 2025
 06:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509115126.63190-1-byungchul@sk.com> <20250509115126.63190-3-byungchul@sk.com>
In-Reply-To: <20250509115126.63190-3-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 May 2025 06:39:07 -0700
X-Gm-Features: ATxdqUF4K-4yNvtDjbyMxyaeg9As7utYfgs1YC3WPlMHOm8ZwsgITBMzbMftwFI
Message-ID: <CAHS8izOVynwxo4ZVG8pxqocThRYYL4EqRHpEtPPFQpLViTUKLA@mail.gmail.com>
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

On Fri, May 9, 2025 at 4:51=E2=80=AFAM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and API instead.
>
> As part of the work, introduce netmem alloc/put API allowing the code to
> use them rather than struct page things.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/netmem.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 45c209d6cc689..c87a604e980b9 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -138,6 +138,24 @@ static inline netmem_ref page_to_netmem(struct page =
*page)
>         return (__force netmem_ref)page;
>  }
>
> +static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
> +               unsigned int order)
> +{
> +       return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
> +}
> +
> +static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
> +               unsigned long nr_netmems, netmem_ref *netmem_array)
> +{
> +       return alloc_pages_bulk_node(gfp, nid, nr_netmems,
> +                       (struct page **)netmem_array);
> +}
> +
> +static inline void put_netmem(netmem_ref netmem)
> +{
> +       put_page(netmem_to_page(netmem));
> +}

We can't really do this. netmem_ref is an abstraction that can be a
struct page or struct net_iov underneath. We can't be sure when
put_netmem is called that it is safe to convert to a page via
netmem_to_page(). This will crash if put_netmem is called on a
netmem_ref that is a net_iov underneath.

Please read the patch series that introduced netmem_ref to familiarize
yourself with the background here:

https://lkml.iu.edu/hypermail/linux/kernel/2401.2/09140.html

--=20
Thanks,
Mina

