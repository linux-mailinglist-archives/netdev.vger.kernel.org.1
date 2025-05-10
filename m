Return-Path: <netdev+bounces-189444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9369AB219E
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 09:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D661894D53
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 07:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9C51E501C;
	Sat, 10 May 2025 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c53fXv8s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524E11D63E1
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746860618; cv=none; b=G/+4fmHFqooXTP/Vy4H+3NvdIOuEfUMnQGcsQFQEmBLcukbwzN3q6nh7P3LRa2Bx2BwfabjFAtCvcwYWLCkrrqmk4t4bmc9uW/od16f6DbUkMAvbalU9dAAqAESnfxqaH6D2OJ9xglSoY1sKGSIDZ1sGSWn86b8eBXyU2Onepfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746860618; c=relaxed/simple;
	bh=An3Kfh6T1xUz5+x8f8lOhVX0szcuSzyYJydhzIjZPPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwlEQZmZgexuGcYO1kxSpOOKCAQ0WYk8omVLA2RYEUigqpIfjvZhxy539ZW1iIgVe7k1BYplok5twggC4R4U1E4JNWBi2dBNDYsd7+0XMc8R2H2bsjzJJrKu23g4Q8eXBhipNQVNA+82hPeAgD3su16X94LC4/ZPnFxCmUV4xUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c53fXv8s; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70811611315so23537047b3.1
        for <netdev@vger.kernel.org>; Sat, 10 May 2025 00:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746860616; x=1747465416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=esIy1yoJoTXAmmLAi9mdo+nXWf8aN/TLslRpMMWG8TU=;
        b=c53fXv8s3u2EYWW0NrhcAD+JbpOfj6edCl0hcsLt7zTn4VCTVwKvJ6DAKz70fQC652
         4ywBr9auWDQEVJcWVs028+gQG2hXe4QhIp25NwVUiMiqmLg09NvqsXEoPETmmJf1bVO/
         l1gnwX/3kHqvd8bFDdROcnrhY7pzlHzlLJmKa+SnRtq3y443D3HxPVjZmwuqFfz3177q
         FZbbL263S+VHCfoCCvdLyNoDjFJON+6tBeuKgkoQppj35Sw4aq2jMcwMPhDHHNAP8luV
         mELpS54icXZjkWhJJIAJCMCMJJZY/D9IwWKYsLyKnzXQDTeZGwwo/4f2lEX5/l5QLWRC
         DlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746860616; x=1747465416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esIy1yoJoTXAmmLAi9mdo+nXWf8aN/TLslRpMMWG8TU=;
        b=s60yU8W3yjXT4uoEsTGbfdZtfIWBCebK6EfwhS4drW2X57kw0JhuOkDZvQ/isnRUPw
         V1JXlb9KPXrUEx3Ivb2iw4WX0PWjB5MydzNv+a1gk8VkQMKKbw0efEOB0BBevAJMwVcU
         whHoiS1T232XQfMa+iJBZfEHW8FOIsNLB/4FK9Hxt4N+aeTC/t/9R6SNv/DHIyUrkIcq
         NvOju8vamgtO5lRWad8/N+Hh53kmqvs1u/TEqpft22aAyJvaEsoAo1sDtxBvqK+S3V0y
         ttTnpC0qQ0ZHhCYXgxYM+jaVteY12A4zIDd6uhiS75DqmV/Y8HFhEXNSshYgtqK/CY1T
         yVkg==
X-Forwarded-Encrypted: i=1; AJvYcCVamgZBEyds5uknNZXyqDYsP4ONC99q8LhTV5X6y6N4Ab6C0Le2f9lUr8wDs/vbjTATOvWQbo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd9xViHVSGXIQ2/uyah/4jm3iS+++I2Y1HOhOHIQMoz5AiLwDK
	5b6lPPk3kBTdcGIdDERlvVh61aF1udFNRk/JeN3paqigXunsA+OC+bqwS9JvvTBozjoNChOFoso
	de2M0cbPr1wSi6EsqgbbCCG+ylVWUghH129anrA==
X-Gm-Gg: ASbGncso5JWT8EMNtIdW2e22teJGD6ZBRHawp7cg+iaX1uMBrFXWJyFagAUj17hfG1h
	k6eqNUFlV8w25Lhb23hqUG6mvLiyZ2Zpi/qok+GzUUNu+IJ81FF5/rkZGcYIcwuD9yJsjGyvyQx
	QXhkjV+F0R3p5lv6T0+prubGwVSMIAc2qg
X-Google-Smtp-Source: AGHT+IGOGUAXd2eYucc2l24LwrEQEK6gIw37E5MMB9UU/rZM/aVnHskCdc6S2rR1KxunaQrrcpQluF1iHGaUJOnujEc=
X-Received: by 2002:a05:690c:7487:b0:6fb:1f78:d9ee with SMTP id
 00721157ae682-70a3fa17f4amr88459647b3.15.1746860616084; Sat, 10 May 2025
 00:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414013627.GA9161@system.software.com> <20250414015207.GA50437@system.software.com>
 <20250414163002.166d1a36@kernel.org>
In-Reply-To: <20250414163002.166d1a36@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 10 May 2025 10:02:59 +0300
X-Gm-Features: AX0GCFt1hYf3LtiCNfvyCjgHPrAs-p_3q4IUNgEYUKRuXuiWPNp2D6dhxySBkAE
Message-ID: <CAC_iWjKr-Jd7DsAameimUYPUPgu8vBrsFb0cDJiNSBLEwqKF1A@mail.gmail.com>
Subject: Re: [RFC] shrinking struct page (part of page pool)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, almasrymina@google.com, 
	kernel_team@skhynix.com, 42.hyeyoo@gmail.com, linux-mm@kvack.org, 
	hawk@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub

[...]

> > >
> > >    struct bump {
> > >     unsigned long _page_flags;
> > >     unsigned long bump_magic;
> > >     struct page_pool *bump_pp;
> > >     unsigned long _pp_mapping_pad;
> > >     unsigned long dma_addr;
> > >     atomic_long_t bump_ref_count;
> > >     unsigned int _page_type;
> > >     atomic_t _refcount;
> > >    };
> > >
> > > To netwrok guys, any thoughts on it?
> > > To Willy, do I understand correctly your direction?
> > >
> > > Plus, it's a quite another issue but I'm curious, that is, what do you
> > > guys think about moving the bump allocator(= page pool) code from
> > > network to mm?  I'd like to start on the work once gathering opinion
> > > from both Willy and network guys.
>
> I don't see any benefit from moving page pool to MM. It is quite
> networking specific. But we can discuss this later. Moving code
> is trivial, it should not be the initial focus.

Random thoughts here until I look at the patches.
The concept of devices doing DMA + recycling the used buffer
transcends networking. But I agree with you, that's something we can
discuss on the reviews.

Thanks
/Ilias

