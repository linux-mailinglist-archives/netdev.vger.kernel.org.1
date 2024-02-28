Return-Path: <netdev+bounces-75932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF386BB5B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519B528B679
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 22:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4796E7293F;
	Wed, 28 Feb 2024 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RVg2hVA1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9572925
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161043; cv=none; b=bBiPdyiDECkWgimyI9QM8x1g0wLSM8vZ8KzMck0vGGQWtqvLaRtDXtDoVqScHEFwRHecnLFNTs6kZ3Z8gVghdRU6y2TiBbN44WBCROjgF+DKuslvgkqXglAHuQiSTbpM76lCxsOHTKdWfzPV28xEq3zFvGmeV5kD2Y3zmpgsl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161043; c=relaxed/simple;
	bh=rFdeaF8OvHp8ycIMfjI32IqX3BMfkKmkCnOldjcHl/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNb9HAm6y90X/O56UjajWBZWHsuM4Xz2qU6HcM5iF/TY7rTkEFtxWtZUsgak1zUlBhWYgYlzhVgU47+kz6vqNu1BfNuLt7dX+4Fzs9qA9jNrY9SLzsYu7lxE8O3JZH1mF68zv9fuSbwOMlLUF6zjPhw9InTAzzryR1/1Gl8EDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RVg2hVA1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so445976a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 14:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709161039; x=1709765839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XmDUVGJ7uYNuJQyRX/NAFGYz0phL9n1ekfsCjXQN9T0=;
        b=RVg2hVA1htW9QrV231XmRu8rVE9dxV51l51q/PZmKI+VP0e7zdBrJXCL0nGQqa9K9C
         09+83yEVgQjs1xoJ9udWq6U/MWN7IG479Bsb37f36UhtGM52IpxZf9N5YyuA9SDdJAXd
         Nmd/L3ZsB9AoxeA3ynprcqaMgKBNcmkKqhWSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161039; x=1709765839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmDUVGJ7uYNuJQyRX/NAFGYz0phL9n1ekfsCjXQN9T0=;
        b=WPJB2/Fs5OnHANi2a67H9DasLN7DDy0nyitsOBiINzQumyUU1jRsZD8EXGBYdMQPL0
         3PjXHW7fguHgLVNq2KRE5xxhgxnGQLbfCB0cMAfgxbNMZHM2kQvSbWs3rb+JUpLD/2p3
         Jd7KPyIPTUBOqx2ILqPYmMNt00ZmgZN2O9pZOSqpbqUp4FqMDeRI4mdPM0xSQIfI/zIm
         2UTCCg//RhcAGOrbEfEy69CGJmudMpEwweOZbfsyKuIANAZtI91ICIJOn3DJE2obmFz+
         mGXoza/S1J339Y44UXvgXq3ztrJem0nZyPl1Vf/tikFWm6+NhiDiqCWCBP0klFUxce1g
         fi3w==
X-Forwarded-Encrypted: i=1; AJvYcCVop7YVm7bA4i5mBlOVG8aI2is9iUMSmx2Z4u8l83VTRXjQ45SkDAeSX85Jqe8ozs6ZSSt7sPV4qUvzCbIPmU/tqOanqxbh
X-Gm-Message-State: AOJu0YxeP+6LCXLJ/mVycGDpjX3/wpfeIgElUeGamKwMCwh+92wgNOPr
	woa4gn8vynmP64lVMqt5I8XsUR0E2P44dPw4QAJxy4eEx3AKciMxfl2qefmgNjQ8OJKA4gjZGgm
	u7UsilQ==
X-Google-Smtp-Source: AGHT+IH87ebCWCYMspw6udNEYFf/r5AiiyHT0/WzizRuPw/luOjgDAQ3TPZVBTQImq0vOkZduEsUiQ==
X-Received: by 2002:a05:6402:2156:b0:566:ef8:a81a with SMTP id bq22-20020a056402215600b005660ef8a81amr219582edb.7.1709161039274;
        Wed, 28 Feb 2024 14:57:19 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id s24-20020aa7c558000000b0056664063ca6sm1591edr.44.2024.02.28.14.57.18
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 14:57:18 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3f4464c48dso39042366b.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 14:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3R7szIS1IGfO7ID2MAe3Bm2ytpaRccxMzqOY4X1ZwRf7IY0Il1/5F+Zw7gJwF+PQJT7DSgQvaOAI5bQlMh+vLs0PTAtzv
X-Received: by 2002:a17:906:b7d4:b0:a44:f89:8104 with SMTP id
 fy20-20020a170906b7d400b00a440f898104mr218606ejb.42.1709161037880; Wed, 28
 Feb 2024 14:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
In-Reply-To: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 14:57:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
Message-ID: <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 13:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. If the copy doesn't succeed and make any progress at all, then
> the code in generic_perform_write() after the "goto again"
>
>                 //[4]
>                 if (unlikely(fault_in_iov_iter_readable(i, bytes) ==
>                               bytes)) {
>
> should break out of the loop.

Ahh. I see the problem. Or at least part of it.

The iter is an ITER_BVEC.

And fault_in_iov_iter_readable() "knows" that an ITER_BVEC cannot
fail. Because obviously it's a kernel address, so no user page fault.

But for the machine check case, ITER_BVEC very much can fail.

This should never have worked in the first place.

What a crock.

Do we need to make iterate_bvec() always succeed fully, and make
copy_mc_to_kernel() zero out the end?

                   Linus

