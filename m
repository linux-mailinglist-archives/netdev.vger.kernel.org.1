Return-Path: <netdev+bounces-107946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5FB91D21A
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A83B1F2143D
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B06152170;
	Sun, 30 Jun 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ1ciBah"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53B139CE5;
	Sun, 30 Jun 2024 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719758163; cv=none; b=lXTn3Jr0rIdckyb5g/eS6+1FktyoXFBIed8JWSbSE6JPXhzgUjw7QJsiNNsl4Loec7YLuo5zKMZQ5l79x6m8zGVhepr4xXgn48gIExk53Tjr9qnwXa/oLbqCo6WQEjbjIEkX3WMk2kBFHcJCUo8MiAbbGKYdO2Xu2TETtChw/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719758163; c=relaxed/simple;
	bh=p1DN8jlbP1vACh8RBgUWJCiqVQO/jYx/h6RZpi7IXz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJJfSvrBB5UlZpgKTvuXcYucfS8mueEwWyNsimCyOgHMhkFIhLqWjRycmuY4S90WxDCaik99qn/5qUV9Wb8yrFWqLu0AqulZ5QbzxbcxGKUzHsCghIkA15RdWJ2gbBy0jUy+1Q61wL5x+X5oBc4beKXGnAIbxHdJKvWP+Pyhzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ1ciBah; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-363bd55bcc2so1163641f8f.2;
        Sun, 30 Jun 2024 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719758160; x=1720362960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1DN8jlbP1vACh8RBgUWJCiqVQO/jYx/h6RZpi7IXz4=;
        b=bZ1ciBahF7lHNsnZog+8IVLLJeEjcGlvlLfX9HEt9Q5/dwkcKWBGhjsjT+Dimd2Qyk
         dBB7Nrvx/+Gn4l8WPvo6R28dEQCpHrS17AJSAm3QIXgNpK4VTyOKxYJndEpe9ixfnFMz
         AvdF68guk+e4Ar0f3/7w3KBvm8dxUngu5ToXgxnIP0dqLFdOTS896b7xFBVkEMRKVtnk
         sDn/wVfSA2b8eO+zokRHNiyXmyVhsABKoLyAcx1EzKwes2gZAMK8laYKjo/QCdyYPE5Q
         y7J1JVjfyCgb9Mo20jaMjN4D7WLuekBsrJEF/s/PmYuV9TjyNmXzZ7pzCFnb/svWYEVI
         Y8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719758160; x=1720362960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1DN8jlbP1vACh8RBgUWJCiqVQO/jYx/h6RZpi7IXz4=;
        b=XGCSR0vJ4amgo9HPKskf8DShw+M+5SQGo27T7ktF0DPbugi1smUY5EnkgtZbJxIbea
         6aDvUILyCK06b2MjfebuEv4bcMof8LAo0aQCgSJwnpYV/+DvS5+y4nWmW5V4Kp1C2Xny
         BLZiXbgLigxr9TorT+uVbT2/sFpFrt4KGbH52tEKiyxbROcPyUwwztKX5ij5vMURxcMw
         Mm6WIosUnWGh217JH3ZlmymBlpDAb/fKqklgLlSZxw/6s4Hqnl6CGACHYxuy0EiVyiBv
         q1SIEv0FYSmubWbsf+LzKhWm789FOlgV4aSYTQMTtnhkOUzfrdii/jN2QkWf3WjhWC/W
         vk/g==
X-Forwarded-Encrypted: i=1; AJvYcCVSmr5emZwm3ir4YPxnhTGqo58SA8yuNgBm0TC6RCixIbaOa68b/tBfPYoIY9+rCYzo3dieYh/YAEGRhfzwa82WYE69UDVOx2HPYZQENaqJwruBjFE0835506245UPh6sxf9rR5
X-Gm-Message-State: AOJu0YyS/JDLM0sXzxVZvgFRwndIvDb4H3FcZ10UD5cvuuZS/T6D3oNw
	KoSpuldn/uqhmNCRKtyVp8VBjsy8NaZXn/TM5DabRvoyPdY6wRhcfu+C4qOOdD+z3uo92WtIuWp
	FF/NXc+H75Na1dtbjN1NTFuqVyNM=
X-Google-Smtp-Source: AGHT+IHuLnsVtF4Eujtfd6nFrbG9XwDKQHepKIjbjPsPcV+qMlRM18PfqxFJyjmM8ankdGzJGvPcHb9ND6DrjV7gmZM=
X-Received: by 2002:a5d:5f54:0:b0:367:4b4f:15f6 with SMTP id
 ffacd0b85a97d-367756996cdmr2780395f8f.11.1719758160122; Sun, 30 Jun 2024
 07:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-11-linyunsheng@huawei.com> <33c3c7fc00d2385e741dc6c9be0eade26c30bd12.camel@gmail.com>
 <38da183b-92ba-ce9d-5472-def199854563@huawei.com> <CAKgT0Ueg1u2S5LJuo0Ecs9dAPPDujtJ0GLcm8BTsfDx9LpJZVg@mail.gmail.com>
 <0a80e362-1eb7-40b0-b1b9-07ec5a6506ea@gmail.com>
In-Reply-To: <0a80e362-1eb7-40b0-b1b9-07ec5a6506ea@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 30 Jun 2024 07:35:23 -0700
Message-ID: <CAKgT0UcRbpT6UFCSq0Wd9OHrCqOGR=BQ063-zNBZ4cVNmduZGw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 10/13] mm: page_frag: introduce
 prepare/probe/commit API
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 7:05=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail=
.com> wrote:
>
> On 6/30/2024 1:37 AM, Alexander Duyck wrote:
> > On Sat, Jun 29, 2024 at 4:15=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
>
> ...
>
> >>>
> >>> Why is this a macro instead of just being an inline? Are you trying t=
o
> >>> avoid having to include a header due to the virt_to_page?
> >>
> >> Yes, you are right.

...

> > I am pretty sure you just need to add:
> > #include <asm/page.h>
>
> I am supposing you mean adding the above to page_frag_cache.h, right?
>
> It seems thing is more complicated for SPARSEMEM_VMEMMAP case, as it
> needs the declaration of 'vmemmap'(some arch defines it as a pointer
> variable while some arch defines it as a macro) and the definition of
> 'struct page' for '(vmemmap + (pfn))' operation.
>
> Adding below for 'vmemmap' and 'struct page' seems to have some compiler
> error caused by interdependence between linux/mm_types.h and asm/pgtable.=
h:
> #include <asm/pgtable.h>
> #include <linux/mm_types.h>
>

Maybe you should just include linux/mm.h as that should have all the
necessary includes to handle these cases. In any case though it
doesn't make any sense to have a define in one include that expects
the user to then figure out what other headers to include in order to
make the define work they should be included in the header itself to
avoid any sort of weird dependencies.

