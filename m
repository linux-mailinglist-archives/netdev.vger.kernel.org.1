Return-Path: <netdev+bounces-48098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5185B7EC835
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C217280E4A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0058E31759;
	Wed, 15 Nov 2023 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h1/7xNMi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62F23174F
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 16:12:40 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB1E1A5
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:12:36 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9becde9ea7bso210223266b.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700064755; x=1700669555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ab4jnXj8Bjx21zU5WbouPNL4gj/h303kBNvkdQgDmY=;
        b=h1/7xNMieJaAuf/jrXyUHehG13wEAiqZ5f8n7rRqeSoXwyqJpaPyqF+CWZ/Du51dXz
         CtnC9ol4Qoa7nTY0AuL3KV6vgQ/KOXXm2rSmEbhZIvpWCi0UG4/xsKK1XUBKU7d7DbZX
         OcRybgUOO5+gFWl/SjNuiPdfh+qS31MXFAvjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064755; x=1700669555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ab4jnXj8Bjx21zU5WbouPNL4gj/h303kBNvkdQgDmY=;
        b=QeIIpWKlSqWA9nsXGrL/S5NT9/TGKX1WRpA9zTSWMG4j0q7A3asq1ZnmYWbdncXJSc
         D/zwJTBl8IURc/4nBXEop3omzqJmjTf1ERKoKUoeALlxxUiJXHZh//x/4uHDrZu5YV85
         AHqtWracYLq4E31n7iiEaAHN6fvnlbqDXej55Yq8pSUBA7magOJw87btBX6Vsmr5hbdN
         12thSH0/ALFxHOLJXiL/pLYokZcXnhg8q6KF97MHVaAq98lq2HkTUPN1E3yOD6zfrt1A
         UHPqmcpVUkIURL4zwyCsA2vK2LitdehBlt4NZ+D1K+Dj1NSCMM6v/1phPfn6/ERGnqR7
         nFKA==
X-Gm-Message-State: AOJu0YwKetJvj6Kvi6n2iKX8aaXCoZ0lS/VHoXwoSTQRfumRVlX5lpK5
	uvuZZMAQqcpbOMj4g/nqPpiJ8m1Ndm3ty4/M7sJi3WXS
X-Google-Smtp-Source: AGHT+IG2CtwXskCnfS5Ee9/ysXasbkjc5A4etpiJytSrG8Gj+MlvWbEkODgPQ+LFFSYOY9bhdR1Arg==
X-Received: by 2002:a17:907:3f27:b0:9f4:1bd6:2d26 with SMTP id hq39-20020a1709073f2700b009f41bd62d26mr1057380ejc.0.1700064754819;
        Wed, 15 Nov 2023 08:12:34 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709063b5200b009adc81bb544sm7255987ejf.106.2023.11.15.08.12.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:12:34 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so2072905a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:12:34 -0800 (PST)
X-Received: by 2002:aa7:da07:0:b0:542:ff1b:6c7a with SMTP id
 r7-20020aa7da07000000b00542ff1b6c7amr5958727eds.9.1700064753769; Wed, 15 Nov
 2023 08:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-6-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-6-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Nov 2023 11:12:17 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com>
Message-ID: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] iov_iter: Create a function to prepare userspace
 VM for UBUF/IOVEC tests
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, loongarch@lists.linux.dev, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
> This requires access to otherwise unexported core symbols: mm_alloc(),
> vm_area_alloc(), insert_vm_struct() arch_pick_mmap_layout() and
> anon_inode_getfile_secure(), which I've exported _GPL.
>
> [?] Would it be better if this were done in core and not in a module?

I'm not going to take this, even if it were to be sent to me through Christian.

I think the exports really show that this shouldn't be done. And yes,
doing it in core would avoid the exports, but would be even worse.

Those functions exist for setting up user space. You should be doing
this in user space.

I'm getting really fed up with the problems that ther KUnit tests
cause. We have a long history of self-inflicted pain due to "unit
testing", where it has caused stupid problems like just overflowing
the kernel stack etc.

This needs to stop. And this is where I'm putting my foot down. No
more KUnit tests that make up interfaces - or use interfaces - that
they have absolutely no place using.

From a quick look, what you were doing was checking that the patterns
you set up in user space came through ok. Dammit, what's wrong with
just using read()/write() on a pipe, or splice, or whatever. It will
test exactly the same iov_iter thing.

Kernel code should do things that can *only* be done in the kernel.
This is not it.

              Linus

