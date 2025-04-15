Return-Path: <netdev+bounces-182859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E8BA8A30C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE4B7A7389
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4C20F081;
	Tue, 15 Apr 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbnes0bU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31B23372C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731602; cv=none; b=ayvBnzACzV/dEVC3d9cvCRc68sl9oCaKhnNSpii0jyYIvvGxodGh2/xR5SeeE7M1zczde4CYV17eDqNFQqRsefwG59ByfJZ0ZX7dh8rJ2bbEBalx5wlI55t/YfNWaSbVhqo8FX7weyMrYRGte3UnGQMO5irMIOD2RtvELwL1Wx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731602; c=relaxed/simple;
	bh=qg4wAivsMP8RywXlKYTJ+PIR8bbeDUpnSp0qyvD0CmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWrUA82hMw887z3RfmKywQ2Caty3HOkv0Xmg2Q3gZRjGDJ9TtCdXvWclplko++5PbGC8nzQXULn72SKvmb/s0wC2LdB8PLlbLOI/eFBpI/5i8Oaz4HjCxdy2C3m8/uoaQl3Mzd8tH8B5yyJanLXH39EKk8M2901cIWyhSiMYnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbnes0bU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240aad70f2so271275ad.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744731600; x=1745336400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeIb/X6LUJd0puJOYgEpsyhyK4cnQAwP4cBidqFaUFw=;
        b=kbnes0bUaqMuFMP/9c3EW5sQRho/oNPuDffvvVO/DHeCOTEtXp3gDs2enSfuDV2wxb
         FHtlZ8JK0Urjk6Bp7fvh/3FR1ARIw/3NCCbJDAQB+9A7AjZ/kgPfz5ujk/RYsHd5lTUo
         TSBohTMsY0US/yyIVUjC5LYLIkGsd6ZBvFLpZAzG/JnceQRDV2Aoxukiyvn2UNRjRcVg
         3w4HE35Bmjr7wvbnD6dCbJREHvj5CyffiSe9GYYRo8Ib7cNjgmNjlfBR4dmK5HyFjBE1
         fZD+VxVU9V26QR7/xdpiP5dEua0TUdcWTBOeBuKyeVcLXyevH2y5SCdjSTTkJP9AZhzT
         zOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744731600; x=1745336400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeIb/X6LUJd0puJOYgEpsyhyK4cnQAwP4cBidqFaUFw=;
        b=H6gRAfNzl2fAJBlTc5UKssprtU0dmy5haLoFmaEvNTs5Bkc3CGzCltjsuuC9+awNXh
         /xbFs3cLlinnLjdnBaHafh4h211AWceMLP0DP2lgKLWy/Ojpe5xFnKgBea7+vII5s0Ck
         6sXd77kqjZvkxhESSNGCcSiJqN/7TACur/bp8RhiAIcHoTgZgYQFQ7hm2kLw05rVh3sT
         D9PaRh8NzhMyQ0n1+q+PfMyHIfVNnChA7j82E5RxJG2vV1XNQn3K7XHFaBlfJFCL4prC
         NUjGxBFBjOsD4SQ0yMbE0++1aWZi5i/N8qtCfWUn25lHz2dCszdEbbUG1BdBoUAT7zZ/
         DFTA==
X-Forwarded-Encrypted: i=1; AJvYcCUiP50sAy3N2LA/Z35fF3hxxNySyodiAT3UGpUOEdKb+1u57ZUDW+vv8fD2nhWFZRymGQbTzZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9MEatGjlIXhT/zms3WGt6F0PI4ZBE97IJO4RoZ7cpFO0tdUOH
	x2cYZ4J/Y9zJV0l2m7EjTWv0cD7lCf1G9c2kvwtXaRc5/xzJc69BXGDYdVhvjMxr0Dq4v9CeJat
	9tZKlDLKRzk7w6dY+39vEqgroSMndN22xhof6gnJ3iwCR0crVnwCp4ho=
X-Gm-Gg: ASbGncu3ar1OojnvzTGYd0vBlJNko77RsafsuOoQs8MCK3EiIdMPLUG8SkkyqK5+F8G
	homJU4mziEitfoq1NXOl2bCDNgreC3mosb0ob74UA65RyFokIZkKp0UYyHYRnKWQ8O/+YSvXYT/
	ow1UcJ4yjnw4v4e6hLUWDs710=
X-Google-Smtp-Source: AGHT+IFLhlUUvSgNVTxL04KKX3RG9sx072ZCun2lap9939vdMyJNLUBNnSRPH2j0J6W4S7CVvCvpIa6UIVdzBlU5+P0=
X-Received: by 2002:a17:902:ef47:b0:21f:40e8:6398 with SMTP id
 d9443c01a7336-22c259d7af2mr3024275ad.26.1744731600188; Tue, 15 Apr 2025
 08:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414013627.GA9161@system.software.com>
In-Reply-To: <20250414013627.GA9161@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 15 Apr 2025 08:39:47 -0700
X-Gm-Features: ATxdqUEEAYYuf9kY0rmh0iT4BhHq7nirTrK82B1hkM9j1bmivYLkzqZcnzQa_eo
Message-ID: <CAHS8izO_9gXzj2sUubyNSQjp-a3h_332pQNRPBtW6bLOXS-XoA@mail.gmail.com>
Subject: Re: [RFC] shrinking struct page (part of page pool)
To: Byungchul Park <byungchul@sk.com>, Jesper Dangaard Brouer <hawk@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: willy@infradead.org, ilias.apalodimas@linaro.org, kernel_team@skhynix.com, 
	42.hyeyoo@gmail.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 6:36=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Hi guys,
>
> I'm looking at network's page pool code to help 'shrinking struct page'
> project by Matthew Wilcox.  See the following link:
>
>    https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
>
> My first goal is to remove fields for page pool from struct page like:
>

Remove them, but put them where? The page above specificies "Split the
pagepool bump allocator out of struct page, as has been done for, eg,
slab and ptdesc.", but I'm not familiar what happened with slab and
ptdesc. Are these fields moving to a different location? Or being
somehow removed entirely?

>    struct {     /* page_pool used by netstack */
>         /**
>          * @pp_magic: magic value to avoid recycling non
>          * page_pool allocated pages.
>          */
>         unsigned long pp_magic;
>         struct page_pool *pp;
>         unsigned long _pp_mapping_pad;
>         unsigned long dma_addr;
>         atomic_long_t pp_ref_count;
>    };
>
> Fortunately, many prerequisite works have been done by Mina but I guess
> he or she has done it for other purpose than 'shrinking struct page'.
>

Yeah, we did it to support non-page memory in the net stack, which is
quite orthogonal to what you're trying to do AFAICT so far. Looks like
maybe some implementation details are shared by luck?

> I'd like to just finalize the work so that the fields above can be
> removed from struct page.  However, I need to resolve a curiousity
> before starting.
>
>    Network guys already introduced a sperate strcut, struct net_iov,
>    to overlay the interesting fields.  However, another separate struct
>    for system memory might be also needed e.g. struct bump so that
>    struct net_iov and struct bump can be overlayed depending on the
>    source:
>
>    struct bump {
>         unsigned long _page_flags;
>         unsigned long bump_magic;
>         struct page_pool *bump_pp;
>         unsigned long _pp_mapping_pad;
>         unsigned long dma_addr;
>         atomic_long_t bump_ref_count;
>         unsigned int _page_type;
>         atomic_t _refcount;
>    };
>
> To netwrok guys, any thoughts on it?

Need more details. What does struct bump represent? If it's meant to
replace the fields used by the page_pool referenced above, then it
should not have _page_flags, bump_ref_count should be pp_ref_count,
and should not have _page_type or _refcount.

> To Willy, do I understand correctly your direction?
>
> Plus, it's a quite another issue but I'm curious, that is, what do you
> guys think about moving the bump allocator(=3D page pool) code from
> network to mm?  I'd like to start on the work once gathering opinion
> from both Willy and network guys.
>

What is the terminology "bump"? Are you wanting to rename page_pool to
"bump"? What does the new name mean?

--=20
Thanks,
Mina

