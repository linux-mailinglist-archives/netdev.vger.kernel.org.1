Return-Path: <netdev+bounces-189274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECB5AB16DF
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819471BC3D82
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AED2900AE;
	Fri,  9 May 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCvkRk4k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8CF23D2AF
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799771; cv=none; b=kUjunxFg+fW4y/rWH+Pce/e32zq2aHtBqhpmyqzkPv8c/6yasKgneqk0d/jWxq7G3a3tSbRyhJUtOTu67b6qWK07or8O1fNvexOiLv6dskJGpfxwbeFZFnQ7wthHQz3W4KD/5GzYN/2vzBnEqKlVjZJ3kVEWuWXtkwVdEd7rMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799771; c=relaxed/simple;
	bh=vQwnaN5SIa/H+Y6ee37jwTVs6F3pxmGriu6KQ74VZEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAranQTlsUhwsCZZVGtF4tqqyjMBexuBP6F37Xl334Seh9sVfPJHmshmO+F18EM82GTIko35zppfnQBTrWaN80v7FaDmUQLVYwH6pqKHPb1boFWbjMlL2MYTOF/lNIINd/2U+o3guNx5uyz6RNnQD6xux5YlWq/8PWo4Sfwu2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCvkRk4k; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e42641d7cso234805ad.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746799769; x=1747404569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCiKxL6LvoeyY9W6b3RA5blUeHU2Mmy1DhVz0FZzVWc=;
        b=GCvkRk4kEg52KvSZTakEcYv/YL0uT1qGB5CMIV23CBHwOIbUhemIDQ0yS0+Q/Td11Y
         A4QU4ZF2Xb5wuagf8xxURV7rp6OuO7UPDBzBroBxUF1umxlASerewXL2YsUaufAJ2VqU
         cfLIWXlDOzrbLimqmwWD4ghUt1fu1rVZuMWvfp30TSnaA8vEKP0I5NgGNwKWktK5yokD
         8GvLDqWEeAl1+Xz00br358GmhxA57hhABolgqf2FiZ17mzX0SFLv6rDRshdB1cuJfSGN
         YDuGAfyRWjnm5e8OYCYoy8arW7mDhbXVh7uexECpGojI8ZHO8pylz7C72XPF2lFATSn1
         EMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746799769; x=1747404569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCiKxL6LvoeyY9W6b3RA5blUeHU2Mmy1DhVz0FZzVWc=;
        b=Uaos9mKjFiEKKCoCoTK/9wTw3I0kejWexL0pFCgm1wstJF2M7NgNKR3eVG5dalZfYB
         uC8d/NzPYvidgx4cUXlTC5jRI1I9MJTw8VwwLUumyeHxT6FF+l23dLVuK2oBN8jyYT45
         Y2OR/j7uiUMsYJZr4KBx7f5wWR3cVm2WToiEsIUbNAtbapjYraM37ra3n3xJ0gINg2dH
         MT0k+VWgjsZ2qMOo8XUdzaUYW8tH0OqzuH2iJiavF1L68IomfoDm0GSgouVHChHUaHCf
         MgW33pp70gbZJmJaNBmVGpjn5uo+pX1yjq+MO2vwDucMyrZMgKOCFb1gLSe4TdyNJOyX
         DVag==
X-Forwarded-Encrypted: i=1; AJvYcCXo+9IXGFUA+EHhKTPiZEl/bp+ARy+dcVl6Ldqt0UWu7vlTYURGR0w0HRyCzoBNqLYkAau+6HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywLVmHVV4d31xMu/gMII2N8SKWjirA1EZEiqxIKsNWvnXZ/IEg
	6HcfXhkmiEbJGcWzJCNpTOLTPJ8k9JaXzLDy7q5XYBDw6LaXGl6r0lavMhmoRN+P0ltphl5BS4Q
	UPzQ+qCcPF9FC6yYW596fCjTj2VStSFWFlgG5
X-Gm-Gg: ASbGncvZsT78DX5oALLl8UC+FwehHcA3uanHfuKLtckxt/wuQ/UGxNYjbTg5LmtHW+I
	Q1Q3wLsaZEatD2pEQPmAMpnKYY14nfln142LCEXuQubnmcB1yFukOm8PcAshoXSN5IwGfYai34n
	xoLPHlS+1bRNBSlI4XJ/Mb9PQ=
X-Google-Smtp-Source: AGHT+IGMI/XDr8dUmvgSvSl1rg1l31oGTBGmNKBdui7zTK+cXuKqPn5F0+EqTjHwmKRPbjb5nSBKLROp6YQHQ8mm83g=
X-Received: by 2002:a17:903:1c3:b0:224:a93:704d with SMTP id
 d9443c01a7336-22fca87efcdmr3648795ad.2.1746799768696; Fri, 09 May 2025
 07:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509115126.63190-1-byungchul@sk.com>
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 May 2025 07:09:16 -0700
X-Gm-Features: ATxdqUEcD0TRlngE7OhKXE4b1mDY8XLhym2WmzKEPsqCbaP_I_Y7Ra0p4qdhPME
Message-ID: <CAHS8izPFiytN_bM6cu2X8qbvyVTL6pFMeobW=qFwjgHbg5La9Q@mail.gmail.com>
Subject: Re: [RFC 00/19] Split netmem from struct page
To: Byungchul Park <byungchul@sk.com>, Pavel Begunkov <asml.silence@gmail.com>
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
> The MM subsystem is trying to reduce struct page to a single pointer.
> The first step towards that is splitting struct page by its individual
> users, as has already been done with folio and slab.  This patchset does
> that for netmem which is used for page pools.
>
> Matthew Wilcox tried and stopped the same work, you can see in:
>
>    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infrade=
ad.org/
>
> Mina Almasry already has done a lot fo prerequisite works by luck, he
> said :).  I stacked my patches on the top of his work e.i. netmem.
>
> I focused on removing the page pool members in struct page this time,
> not moving the allocation code of page pool from net to mm.  It can be
> done later if needed.
>
> There are still a lot of works to do, to remove the dependency on struct
> page in the network subsystem.  I will continue to work on this after
> this base patchset is merged.
>
> This patchset is based on mm tree's mm-unstable branch.
>

This series largely looks good to me, but a couple of things:

- For deep changes like this to the page_pool, I think we need a
before/after run to Jesper's currently out-of-tree benchmark to see
any regressions:
https://lore.kernel.org/netdev/20250309084118.3080950-1-almasrymina@google.=
com/

- Also please CC Pavel on iterations related to netmem/net_iov, they
are reusing that in io_uring code for iouring rx rc as well.

--
Thanks,
Mina

