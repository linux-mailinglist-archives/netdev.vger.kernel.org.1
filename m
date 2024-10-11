Return-Path: <netdev+bounces-134619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D1599A7D5
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC273B2514E
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C1519E979;
	Fri, 11 Oct 2024 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G25Yyrja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E219E826;
	Fri, 11 Oct 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660749; cv=none; b=Zjc1ImgB1VeexAOhXnVbmbONqluksHdtvNWiC0G/dcXbEaum0ftefWwE9atgAQN6mtFivT3JtZOWj5z4BQ0C8eVNzk2P6lB+kMV+qaqLKPl56TOXFPL4iDusvp0Ktt6nXtG4haQ+5B89N3MEqOVuELgdSl7vQVNXv5tYjGUG+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660749; c=relaxed/simple;
	bh=KHtMY4DnKt30qjKFk98EJeqIzi6UHuzama/rdRw5gfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJGs1v3jIIq8UzlI/NHRJ7R295hsHGfYN5YMacH0pdrDtX0YbEHmfkX7jEA/ph23vi9cpQzChGm73SuUTwS2aFsHsutQuM5/+WAKeKy7sJvl6t+8jTL1ixr401V5aIV2pm/K0rujEEinP4yRZ+AM6+ZrRHs0v5o07z8mdt+FgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G25Yyrja; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d533b5412so721914f8f.2;
        Fri, 11 Oct 2024 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728660746; x=1729265546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+vqQ/OBTPe50YYu2gHwxbM1qWgIK36UBNA7yFsEKPQ=;
        b=G25Yyrjar0Rce6dcM4xg3rcmh4ZTDNwFjpYyVTwcq4UiU3mP6e0EVcRd13xx27YibT
         8Bi14V2Duhi+XXz6MGl9/QxGWIFssu5klN44bYUj0fwDQri1tunhvex7rw7xiKBc/q7Y
         V9BfYRzWJHQ7mlV8DA1MwtFFhAlUHVlL1qqSirzV6hJsQzDy8dbT0tTulXYGiEpa7yFC
         NUzAfO9sUGWOSkpgaXbRxj+eGKgGpEVjc3GBpMzea7MxRrYoK04e0qkiBdIWIY9V6ZvW
         YvFhT/qneGv4UpEbst35NClQ/Jphkcg0V/8WDkoR4/ruJdLkkNyE4bQKboK2n2RgpNzW
         Ndfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660746; x=1729265546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+vqQ/OBTPe50YYu2gHwxbM1qWgIK36UBNA7yFsEKPQ=;
        b=gXy1a7mug7u3mXKdeJ/uFQSLnOWgUGLYUozzqFiTO8AdVNdXRdd0p/2BYXmUwiIavC
         B1+JdgfBtnIlvs7zFV33DlIXI79fh00Jzb+CBZimVp8Gw8O9JyvQQDuEzcG3m0qrwv36
         OK2vm13bLPp030CbZl7PnDgXQsaY6j+8aLwsgOfB8k807YAlq5q+nGvFsCS7YD5eDria
         O6FNzrkNNSxTMsC94btGbPyYxJxGm1P1Z26txMuDaGkvhaIus8JerpzOHmIrErJBkwCk
         o9RHx+UBcBMvygIbqWMMs74MXrgXcACYpTORh7W4z73JCDPdiORt1lqVbCSkWdzh73Dm
         SYFg==
X-Forwarded-Encrypted: i=1; AJvYcCV9ICvWI9DjeNif/J/V8fc/8m1XMy3HSX8MyywZ6lYDpKoi7RAs8zoEtVWP5NDXlR1KccVCrnwO@vger.kernel.org, AJvYcCVeuLl1VsItXRqDEGoqZsOatw96BT4H/CzmK9Y6YFWHnYgqgFRYtN+okfHh/rFyFWMZDUagkBPIUxc/uko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIDzFvWwgDmF7fIL5doRvYc8h8a7+/9Yetzq0vgtxUZf1vp23
	ja6JpdfSjVuFzfCUqy+6VK+2bwX/O9g7g/LoI4IGse1D7DWq/l94LKDRh0j0PrVc8KDUmB75InQ
	osP4/MZu0SdmeIZYvM9blzvD7kKI=
X-Google-Smtp-Source: AGHT+IE57rxGZ5cP6vrnw10l3HMnUtL7vF5fWf11QCy0B9FBKpLTFmE2SrVilDbiDdKBq1As6h5FmjHnjLZG3uYwa0w=
X-Received: by 2002:adf:f805:0:b0:37d:5352:c83f with SMTP id
 ffacd0b85a97d-37d551b9618mr2001034f8f.17.1728660746066; Fri, 11 Oct 2024
 08:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-7-linyunsheng@huawei.com> <CAKgT0UdgoyE0BzZoyXzxWYtAakJGWKORSZ25LbO1-=Q_Stiq9w@mail.gmail.com>
 <8bc47d27-b8ea-4573-937a-0056bdd8ea2c@huawei.com> <CAKgT0Uf0g9_P6fUBzueZ-rwq1RCu5TjruZGT+kXjsQi-=jqStQ@mail.gmail.com>
 <7c4b8aae-dcbd-4d45-b7b0-82609cf8a442@huawei.com>
In-Reply-To: <7c4b8aae-dcbd-4d45-b7b0-82609cf8a442@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 11 Oct 2024 08:31:49 -0700
Message-ID: <CAKgT0UdavkCTqvNUZt6JmKK5NrMQmDbNi+S1LLrZeYfp3Ofn5w@mail.gmail.com>
Subject: Re: [PATCH net-next v20 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:40=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/10/10 22:33, Alexander Duyck wrote:
>
> ...
>
> >
> > For the decodes yes. I was referring to page_frag_encode_page.
> > Basically the output from that isn't anything page frag, it is your
> > encoded page type so you could probably just call it
> > encoded_page_encode, or encoded_page_create or something like that.
>
> It is kind of confusing as there is some mix of encode/encoded/decode
> here, but let's be more specific if it is something like below:
>
> static unsigned long encoded_page_create(struct page *page, unsigned int =
order,
>                                          bool pfmemalloc)
> {
>         BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MA=
SK);
>         BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >=3D PAGE_SIZE);
>
>         return (unsigned long)page_address(page) |
>                 (order & PAGE_FRAG_CACHE_ORDER_MASK) |
>                 ((unsigned long)pfmemalloc * PAGE_FRAG_CACHE_PFMEMALLOC_B=
IT);
> }
>
> static inline bool encoded_page_decode_pfmemalloc(unsigned long encoded_p=
age)
> {
>         return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
> }
>
> static unsigned long encoded_page_decode_order(unsigned long encoded_page=
)
> {
>         return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
> }
>
> static void *encoded_page_decode_virt(unsigned long encoded_page)
> {
>         return (void *)(encoded_page & PAGE_MASK);
> }
>
> static struct page *encoded_page_decode_page(unsigned long encoded_page)
> {
>         return virt_to_page((void *)encoded_page);
> }

Yes, this is what I had in mind. Basically the encoded_page is the
object you are working on so it becomes the prefix for the function
name and the action is the suffix, so you are either doing a "create"
to put together the object, or performing a "decode" to get the
individual components.

