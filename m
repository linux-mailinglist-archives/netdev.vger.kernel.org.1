Return-Path: <netdev+bounces-35856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A607AB616
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 18:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 61842B209CA
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB6C25107;
	Fri, 22 Sep 2023 16:35:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4B323E
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 16:35:11 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248A0114
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:35:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c93638322so610129666b.1
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695400508; x=1696005308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOhjx56+C1/SUOCT4pJr+RaAn7PBsJsy8c2/c8L0wsg=;
        b=VXldlrG11szZBfan3YaFaOg1qRTFUXItPvz+d594Ed/RZo0X8fDhhFTcT+Tfee5VSP
         yLE9fyNVXNnPLkw0gSESTe8Z8WM+wGotLZjHCgzE0IfCnJJtL1u/7KVdSA3g4FbBQDNs
         0yJxayfVAnOtmdEA4zWcMbTKTM0gvJiAOw2es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400508; x=1696005308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOhjx56+C1/SUOCT4pJr+RaAn7PBsJsy8c2/c8L0wsg=;
        b=w+ZWxSaAhvX5664ojbF3AYqzg+de4YgGYCt7IfNL9wgexAMJnh85XrHuJqfojNVLIq
         gsH3udCltMF4Kl0A4x4W0pqYVvDKkXVnvwVyKmEOw5YK2a8O2JWlKW4QHKuDEXJTRuID
         RqklWzcC1O4GM+D/gwjgJA+NXuNraCNctPhFuaHCOXGVpm8a4GW96QOtSEcskZzBqqYy
         RqI25uxmmi3XVTLsK4e5TX+TMVaFnmye0QubnpM04Ch80N59csWu/6t33byD3cU/L6/j
         Cng1tfWQYmO4GHbDQwnKy2qkFfPi8K6MMcUhZg8v0uGy+ajMNNxlLQ9soZSc5ms6YKtI
         XpZA==
X-Gm-Message-State: AOJu0YxODzV7EsBl4q9Tq6x9mHAtc5Wnx2XBf1JtNqLpRXSr36eHKYgn
	t7dD52VoDZSdVDc8uwZPt31oPGt4VpeJzX2CDcqrv9+N
X-Google-Smtp-Source: AGHT+IFb6mDrHkfLrnDEwRahWUjmuXa5ZyTOcoAK4WYCx7a3HA7TzfsVXhr8EN0V3mali2KAbi9aaw==
X-Received: by 2002:a17:906:4fce:b0:9aa:206d:b052 with SMTP id i14-20020a1709064fce00b009aa206db052mr4853837ejw.27.1695400508519;
        Fri, 22 Sep 2023 09:35:08 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id p20-20020a1709060e9400b009ae587ce135sm2923883ejf.223.2023.09.22.09.35.07
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 09:35:07 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-532addba879so6128672a12.0
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:35:07 -0700 (PDT)
X-Received: by 2002:a05:6402:27ca:b0:52c:f73:3567 with SMTP id
 c10-20020a05640227ca00b0052c0f733567mr4854122ede.13.1695400507255; Fri, 22
 Sep 2023 09:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922120227.1173720-1-dhowells@redhat.com> <20230922120227.1173720-9-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-9-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Sep 2023 09:34:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW5z-OBA8kbOOoM7dAriOsb1j7n6GaUNjGeg9fPY=JRw@mail.gmail.com>
Message-ID: <CAHk-=wgW5z-OBA8kbOOoM7dAriOsb1j7n6GaUNjGeg9fPY=JRw@mail.gmail.com>
Subject: Re: [PATCH v6 08/13] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 22 Sept 2023 at 05:02, David Howells <dhowells@redhat.com> wrote:
>
> iter->copy_mc is only used with a bvec iterator and only by
> dump_emit_page() in fs/coredump.c so rather than handle this in
> memcpy_from_iter_mc() where it is checked repeatedly by _copy_from_iter()
> and copy_page_from_iter_atomic(),

This looks fine now, but is missing your sign-off...

             Linus

