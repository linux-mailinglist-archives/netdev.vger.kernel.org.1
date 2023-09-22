Return-Path: <netdev+bounces-35902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 195E57AB99F
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 20:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 479BE281CC8
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13FD43AAD;
	Fri, 22 Sep 2023 18:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477742BFB
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 18:51:45 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72371AC
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:51:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50433d8385cso2889506e87.0
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695408701; x=1696013501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah1VmvWzOnKnkyFlWIeYuTucJzJ+3NRjWIwcRi6c2zI=;
        b=gUMtpuuZgd32imWpVt1I7YnW+cEerBc320Ihg65yQmykUY3zIBOd9MLMicEoD+a2Xm
         npHUWFKlF2ulKzljni7S7jP/b/outfpNwJeNJ5pu3ieNCDQJ2ONyjc9zx+ZUl5D59Cub
         HxZQVjOG478tQGpLvoHh5kuZ7KAKa+/HLD0/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408701; x=1696013501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ah1VmvWzOnKnkyFlWIeYuTucJzJ+3NRjWIwcRi6c2zI=;
        b=dtKojckNj8mx4YZmH4rb5EPNle24E2kmS+0yBwtQhdPHVwD2XXonDLbA6CdjzBpY7F
         0Y4M0dAyVuQh2KMt3yC1mcsJfKNHmWX6H3ekSB336/ue1lBxssrgv4Pg4cHOx6gvxH+8
         e/LeoUk/+oOfKYLthO5E0ZMQ4FRki/lhna0XXMYpzYz/4bKCp67PjLooGrbeLrjJUs/K
         s9oMTjbiO1T451iqkfeAhk8uzVR9/c5m147gc813M5bhDMLjdpbrmn9Y6iwCAEHDPSAR
         GJRbOQVf6Kz2c7HQBNEfTaDW0Vte/iV5A60J/flG43aPgQGPnSZsaaiUc1wJw5bT5EEh
         GabA==
X-Gm-Message-State: AOJu0Yy3rgQXjySh0WYImN2CZSxllAMmInxE+PY76NHW/lhZH43QwTtb
	3RxiXOYRJYB1jed8dvXzoWGEqf9chUw9jtvGKXaXN8nd
X-Google-Smtp-Source: AGHT+IGSEHYZ4MG4/3oMPjilbWrg7LeRSTZ3Lai4QVnZg2fSgknGj9NntPfTumnA6sJnsCbkgJLHeg==
X-Received: by 2002:a05:6512:3ea:b0:4ff:aeef:b582 with SMTP id n10-20020a05651203ea00b004ffaeefb582mr296050lfq.66.1695408701457;
        Fri, 22 Sep 2023 11:51:41 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id m26-20020a056402051a00b00532d2b5126bsm2555827edv.94.2023.09.22.11.51.40
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 11:51:41 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so3068810a12.0
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:51:40 -0700 (PDT)
X-Received: by 2002:aa7:c98b:0:b0:533:310b:a8aa with SMTP id
 c11-20020aa7c98b000000b00533310ba8aamr309019edt.13.1695408696292; Fri, 22 Sep
 2023 11:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922120227.1173720-1-dhowells@redhat.com> <20230922120227.1173720-10-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-10-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Sep 2023 11:51:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyv0cs056T8TvY1f0nOf+Gsb6oRWetxt+LiFZUD4KQCw@mail.gmail.com>
Message-ID: <CAHk-=whyv0cs056T8TvY1f0nOf+Gsb6oRWetxt+LiFZUD4KQCw@mail.gmail.com>
Subject: Re: [PATCH v6 09/13] iov_iter: Add a kernel-type iterator-only
 iteration function
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 22 Sept 2023 at 05:03, David Howells <dhowells@redhat.com> wrote:
>
> Add an iteration function that can only iterate over kernel internal-type
> iterators (ie. BVEC, KVEC, XARRAY) and not user-backed iterators (ie. UBUF
> and IOVEC).  This allows for smaller iterators to be built when it is known
> the caller won't have a user-backed iterator.

This one is pretty ugly, and has no actual users.

Without even explaining why we'd care about this abomination, NAK.

If we actyually have some static knowledge of "this will only use
iterators X/Y/Z", then we should probably pass that in as a constant
bitmask to the thing, instead of this kind of "kernel only" special
case.

But even then, we'd want to have actual explicit use-cases, not a
hypothetical "if you have this situation here's this function".

                 Linus

