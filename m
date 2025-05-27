Return-Path: <netdev+bounces-193726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470A4AC57EB
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962221899E61
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8251F27FD63;
	Tue, 27 May 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGr8IryR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415227CB35
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367539; cv=none; b=JL5GxC52TrsZpux95y+fKv2s2eOWW/otDq5apTaruhH5XtpONPp+mf7g4D4kTvKUuLmvqz28R3fwO+NUnttHA5C+zqad/WT8paxP15Rb9MmyYd9eM789rCkqP9Wm4P0o7uGtjpafF2SwUDOfrentjUQZFJVOMfzrBmcHoYMtJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367539; c=relaxed/simple;
	bh=OJPMh5xqFYFnMRl0GDB91WM2PrQAsBt7zzx7fsTrIDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCcaOjEoQvO7yY3N4Df9FhTgm1PX12/v64eKcgEnmd0gxRLPRz9DGmB72keR4SkNRUBArwbmbnS7DU69mo43mnr8t28XXTpJ1JRKevs/y0JHEDtLKjbIj8v6vBPBZvpQT8VAT3MtThxKBp36FJfwa9N9gnUbM9EVZN/3W04Yn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGr8IryR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2349068ebc7so23245ad.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748367537; x=1748972337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WR/TckUs20kb1rv4R5K8OG+YR6e/KXq2+5xOaVKOB4=;
        b=qGr8IryRKK5ShbqYVWakSqY+gvHv4kZUx6Lhr3beFsPEyod7P/w9AFw4XKFpTPAP1d
         /xEic2Xw7pt4J81Ilv7wTvQllmTI7qxHlNKXEXoTC+zIYsiuF95pOqZQhhYus9o8FkVj
         GcYnJGMiAutJw4f0CnPDnm6a+yS8nSbYlXMUvLt3tUWsQQyA/2VGYlGe1PcwYtkwdibi
         7r3UAO25uJ/82TKHf3zFKyeCJhDAiUswlr2tPdxMRNuuc4P8gdCRPWAg7Tqi7NpiLZEB
         BOGHKZopVE4HXTxgONWI3otwaLSIRqo0mY1Z5xwLq0Yapc4sA9ZAex/5tHmxVOrZl55T
         NOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748367537; x=1748972337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WR/TckUs20kb1rv4R5K8OG+YR6e/KXq2+5xOaVKOB4=;
        b=mWTTwBjx0uFwb/aoPLraBkxBbvZxDaH8yfdExNhbRJydqG2So5zNHUqvG/lthroDMu
         d3FnuRjaFn0KPrkgqZb3CZZNUwE9P5pOdNoqg3DykiUrc8blxweJSYTv+w9xL+Ka4SLx
         Ifamv1QmPmcAq3ZZ7A2/3xY66iJY3WJdj0bPRzjqDJEBz7JmwYf83jhiceM7qDPNTacH
         6bNZZTTaHcJWMzbPJiJqaLDU6T8IxipIGljoKWavmx831fDS2uks/4RoWMtuqREKXsZy
         l/jLUul20Dl+V2tJCXqA7gAt37UARwQ7HNO0WNfv4I1J45QfrQnWN7Y8K2L0ByXlHSuV
         45GA==
X-Forwarded-Encrypted: i=1; AJvYcCVpMe3lJZn7n5qvqcoeL+qNOQHNK+qGa3yq/HTHXTDRcWdF7GQ0pS3I+BTZl47aTRjbbFB2dOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfK7fIiKa+D6n60VdwBe/vEv3ZweQCjT3eH+FQZ2ZYqPCqzGNP
	HWA2coDe0GrscoCcyrY5ZKY6tY6UmIj1tpZ/f3YuamTyBmnbD6oLdZ8YMuGOcNXBhz6pQ4F8v+c
	r6ZI26kkMhsXUZb3NrhVgaKoeEe/U4OrQLQvQBTGM
X-Gm-Gg: ASbGnctkfGgFsc1kDcoLwR9sQBuw77ddwj20ysjUA6wabfp4KZBZOCD03TD484GG5ak
	awm75yixZP+ym8WL+ZhuX3qhDuiBIxZtfzz3jnGvSkW4PvKN2X9KW42iwSG65YS07rydt3e1ToI
	F6WM6XBsR8/srtJQiGGr8YC2MwheyNcsH4TK7uRvV1M3OcsZyj8a+BToB3cfEx48ILBoo624BE
X-Google-Smtp-Source: AGHT+IGlIr7J8YJSwpRcVxrHFh5rOhycHbkimev6L+7ipabq6YlVDkyK6jP8QhgZxpxx7fuXS/9mzfcWIKEJwxvntUE=
X-Received: by 2002:a17:903:2347:b0:234:9fd6:9796 with SMTP id
 d9443c01a7336-2349fd697d0mr2491535ad.19.1748367536832; Tue, 27 May 2025
 10:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-19-byungchul@sk.com>
 <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
 <20250526013744.GD74632@system.software.com> <cae26eaa-66cf-4d1f-ae13-047fb421824a@gmail.com>
 <20250527010226.GA19906@system.software.com> <651351db-e3ec-4944-8db5-e63290a578e8@gmail.com>
In-Reply-To: <651351db-e3ec-4944-8db5-e63290a578e8@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 10:38:43 -0700
X-Gm-Features: AX0GCFvRt9aQZeYORlkyaIrNxbnGXdJdrXvs5uYh9N33ch8nvjT6wHfGGjABJxk
Message-ID: <CAHS8izNYmWTgb+QDA72RYAQaFC15Tfc59tK3Q2d670gHyyKJNQ@mail.gmail.com>
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct page
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 10:29=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 5/27/25 02:02, Byungchul Park wrote:
> ...>> Patch 1:
> >>
> >> struct page {
> >>      unsigned long flags;
> >>      union {
> >>              struct_group_tagged(netmem_desc, netmem_desc) {
> >>                      // same layout as before
> >>                      ...
> >>                      struct page_pool *pp;
> >>                      ...
> >>              };
> >
> > This part will be gone shortly.  The matters come from absence of this
> > part.
>
> Right, the problem is not having an explicit netmem_desc in struct
> page and not using struct netmem_desc in all relevant helpers.
>
> >> struct net_iov {
> >>      unsigned long flags_padding;
> >>      union {
> >>              struct {
> >>                      // same layout as in page + build asserts;
> >>                      ...
> >>                      struct page_pool *pp;
> >>                      ...
> >>              };
> >>              struct netmem_desc desc;
> >>      };
> >> };
> >>
> >> struct netmem_desc *page_to_netmem_desc(struct page *page)
> >> {
> >>      return &page->netmem_desc;
> >
> > page will not have any netmem things in it after this, that matters.
>
> Ok, the question is where are you going to stash the fields?
> We still need space to store them. Are you going to do the
> indirection mm folks want?
>

I think I see some confusion here. I'm not sure indirection is what mm
folks want. The memdesc effort has already been implemented for zpdesc
and ptdesc[1], and the approach they did is very different from this
series. zpdesc and ptdesc have created a struct that mirrors the
entirety of struct page, not a subfield of struct page with
indirection:

https://elixir.bootlin.com/linux/v6.14.3/source/mm/zpdesc.h#L29

I'm now a bit confused, because the code changes in this series do not
match the general approach that zpdesc and ptdesc have done.
Byungchul, is the deviation in approach from zpdesc and ptdecs
intentional? And if so why? Should we follow the zpdesc and ptdesc
lead and implement a new struct that mirrors the entirety of struct
page?

[1] https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

--
Thanks,
Mina

