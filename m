Return-Path: <netdev+bounces-114653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA8E9435A4
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F79F285067
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E245C14;
	Wed, 31 Jul 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQdFSpcn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E93AC2B;
	Wed, 31 Jul 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450613; cv=none; b=S8JdQv1/B6KY0/XNJ1EEl0Dbpod2iKiv8l+PGa6ey3LLRNdnWnQUcUOjoxelOkTY5GZVsvrq8qw78xz6D7yKKBhOb0JghPTOtmNx659xVs9V/yNqJMia3cgi6z8bJE4vy3IVZazJ6LIGNadb6hEQl3zZqprQH+YkcoqZa+PIQvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450613; c=relaxed/simple;
	bh=xzFKhRbjcnKDzmXujqezge+NtoXFykA/WIDmhHuWCIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uflTafZFlLkxHse2RQe4CXIJq+8YL6NOxI9PK2PXzytuf784zfSNSsQUQSNy1IGn2kv6S/sxFCUfSGm6JtVcGXqqErT7tCoTBmxk+JDfp1pItGx4zPKZ5+/cylrgtgpOtp0Gkpj4iZKyJ8sOdycWn1U7qQeULDzxXlcl9QfkLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQdFSpcn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367ab76d5e1so2322645f8f.3;
        Wed, 31 Jul 2024 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722450610; x=1723055410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzFKhRbjcnKDzmXujqezge+NtoXFykA/WIDmhHuWCIs=;
        b=AQdFSpcneG5czLwTsupGpDzFheGWgRp1C6AL9ngReyQgZwNpdQiJJt3/Wl8VkSmLce
         0bXBsD+VyRnTXCs2nd5mM/qPQ8LEeSZHV2+M80sPuAMJu4mKzc1yIJgoJwNoGhOwBgXp
         NUoyduQMxuCliHPtRkbyiFDT3TWp9i1J8XvQ0nFaFatoOj5OnDF+oYikJMEQbfLxTfvL
         t73eNQ+AhKH0rl7dgzErD6eiiamXgqBlFT6YR9wQ20fCAjFtIXPtYjnYw8RgN5TKtrz6
         IOnVJT5wXrFxftgEwLVQ6/zqIkJsoX0uCy2oZmqtcAGLDR7vdoc5xMaJv4JxQejswDRl
         oz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722450610; x=1723055410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzFKhRbjcnKDzmXujqezge+NtoXFykA/WIDmhHuWCIs=;
        b=pt0t7VZ8cX5G3Lufw4jIu1UHlvVhIbsb8kXA7wWD84C+vo7f3jpCpOlMJ2wbxXkKMJ
         Gqhfs/5Edc3/4K54ZaXflu8+fabqOBtZCnDf1C5ugLaSBEgYosEZFLyQL0fGqOQZpYue
         sSgz7NbVrLVO2KUpakUz2Zx4VX1viFr+I94dnRslcwOBfx5qea4bfyh7ban8dvChCpxD
         hQOER2chGhojcmTHRoiVorlrxtsP8HrVcI9t69KBh/Vk5mRf2I1nm/FQwA2j+n5qHP9x
         rqaXxYQkDfmNesALuaafXlAtRqFpNUiGmFZ2XEkc61ULdsXeLQ30HkUV3QnczEHvk+6S
         INYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTTSWnR+tkiG5E05Kln7v+/B8KoZt4V80GMMonQBXfqzNjxzxO6mkJqxiUiEbdm5kRXvKKeGJZYJeWK3o=@vger.kernel.org, AJvYcCUueQwmEV+oYV0tLHVkMqtdQx9sTdpCwSujN0ACe6c0Wk6XWw0os+QgE5S4SpoS2HmN6X+E1qkB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6FB8nR8sEjDcr+MwRPLbLiAvuv72hmvnErAUXz0/JdrjL5M3
	pRsZpVQdG7ErtDkiOEdwIAFU2QdkTf3K7VFEMPx7uxVN6HdZJ6fpZQS5QqidlnaaagQ7Ln/ojTT
	7ZNeCee4p78i0wsRtsq6dhoOiIm1fyA==
X-Google-Smtp-Source: AGHT+IH+al8QxOSqxSgNhgRT8STt0ekdoEAUUJ1Wlbp5jr9AL/AtJiPkqmwH128b1nAkyeI5YJI1pCz+mf1pT0GrpO4=
X-Received: by 2002:a5d:6a09:0:b0:368:7fbc:4062 with SMTP id
 ffacd0b85a97d-36baadee061mr96135f8f.33.1722450610095; Wed, 31 Jul 2024
 11:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731124505.2903877-1-linyunsheng@huawei.com> <20240731124505.2903877-2-linyunsheng@huawei.com>
In-Reply-To: <20240731124505.2903877-2-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 31 Jul 2024 11:29:33 -0700
Message-ID: <CAKgT0Udj5Jskjvvba345DFkySuZeg927OHQya0rCcynMtmGg8g@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/14] mm: page_frag: add a test module for page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 5:50=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Basing on the lib/objpool.c, change it to something like a
> ptrpool, so that we can utilize that to test the correctness
> and performance of the page_frag.
>
> The testing is done by ensuring that the fragment allocated
> from a frag_frag_cache instance is pushed into a ptrpool
> instance in a kthread binded to a specified cpu, and a kthread
> binded to a specified cpu will pop the fragment from the
> ptrpool and free the fragment.
>
> We may refactor out the common part between objpool and ptrpool
> if this ptrpool thing turns out to be helpful for other place.

This isn't a patch where you should be introducing stuff you hope to
refactor out and reuse later. Your objpoo/ptrpool stuff is just going
to add bloat and overhead as you are going to have to do pointer
changes to get them in and out of memory and you are having to scan
per-cpu lists. You would be better served using a simple array as your
threads should be stick to a consistent CPU anyway in terms of
testing.

I would suggest keeping this much more simple. Trying to pattern this
after something like the dmapool_test code would be a better way to go
for this. We don't need all this extra objpool overhead getting in the
way of testing the code you should be focused on. Just allocate your
array on one specific CPU and start placing and removing your pages
from there instead of messing with the push/pop semantics.

Lastly something that is a module only tester that always fails to
probe doesn't sound like it really makes sense as a standard kernel
module. I still think it would make more sense to move it to the
selftests tree and just have it build there as a module instead of
trying to force it into the mm tree. The example of dmapool_test makes
sense as it could be run at early boot to run the test and then it
just goes quiet. This module won't load and will always just return
-EAGAIN which doesn't sound like a valid kernel module to me.

