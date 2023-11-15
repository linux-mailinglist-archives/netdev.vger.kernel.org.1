Return-Path: <netdev+bounces-48106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E97537EC884
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B561F23A92
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653439FF6;
	Wed, 15 Nov 2023 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SAu7ZZ/A"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498582E651
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 16:28:44 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C516D8E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:28:42 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507bd644a96so9967891e87.3
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700065721; x=1700670521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jsVx/Q3YhVxHOvs8227jfNskpZuE2YqOrJ9wOZRuNEs=;
        b=SAu7ZZ/AlLN/TSSg/g452fDGlbYSynZ1FJC5N5Evn7gop+Vf5JpnMefH1T8qOsiD0l
         vVG4647qBCRTY2avAp7e7ry6xjjYSsJcFT2vYr8fPnGJ513y/mpoJqxUKJ+azK/OSpBW
         fN1aSL+IEINQz+ioRFO7szjwMz9a4ZvOQmodo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065721; x=1700670521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsVx/Q3YhVxHOvs8227jfNskpZuE2YqOrJ9wOZRuNEs=;
        b=HfF7UYq1D6vLzyQ6lEDzaJKqJy7Mv/heq1GEZZFNea+4R1H58oMEAaf7hY3wVzGNu8
         is92/B2zgeiT3w4GDO0nStzNFzaVwkNfSz0QHqF5cWmKlcMo/kfevtLifvnhNFlxyzIb
         8TEsBnK6FC9EKpfwrotrxBKX9LuuDCDNUs63paOyQ9jjKiie3UG+c6WgHh5JMJByUpET
         CpPwly1aftC9PSqtWIYTSNG9BCgrAqsgRLQhNA1RDiNYC2QtlYrkZmvfv1pVbBmldxg5
         Hgl8tizUjZcIWt0tQwwIGBmsxwzfrcT/Q5UN8DF0MmIm5wvBIq+vHwaZDYGRiOTJsltA
         +WUg==
X-Gm-Message-State: AOJu0YwUavarBTOKM8nxYpOsqXvX1OWQR4N23O6e25YyD5Fj60fgrZuV
	qcpuUTemlcJhv4GdDWTHfY1dyYN9iemiChvSlhmS48Aq
X-Google-Smtp-Source: AGHT+IGaf22ehBzeQkQT3tqnkyOlwmDMIKDkhenCYF3hjnWKOeFvm3OVf657mImURG2lxkXsOHfG2A==
X-Received: by 2002:a05:6512:238b:b0:50a:7575:1339 with SMTP id c11-20020a056512238b00b0050a75751339mr10620887lfv.18.1700065721088;
        Wed, 15 Nov 2023 08:28:41 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q3-20020a19a403000000b005057372589dsm1685719lfc.256.2023.11.15.08.28.40
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:28:40 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c85a5776a0so12384091fa.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:28:40 -0800 (PST)
X-Received: by 2002:a05:6512:12cf:b0:503:3781:ac32 with SMTP id
 p15-20020a05651212cf00b005033781ac32mr12684125lfg.41.1700065720301; Wed, 15
 Nov 2023 08:28:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-9-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-9-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Nov 2023 11:28:22 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjytv+Gy-Ra0rhLCAW_120BvnzLC63tfkkZVXzGgD3_+w@mail.gmail.com>
Message-ID: <CAHk-=wjytv+Gy-Ra0rhLCAW_120BvnzLC63tfkkZVXzGgD3_+w@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] iov_iter: Add benchmarking kunit tests
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
> Add kunit tests to benchmark 256MiB copies to a KVEC iterator, a BVEC
> iterator, an XARRAY iterator and to a loop that allocates 256-page BVECs
> and fills them in (similar to a maximal bio struct being set up).

I see *zero* advantage of doing this in the kernel as opposed to doing
this benchmarking in user space.

If you cannot see the performance difference due to some user space
interface costs, then the performance difference doesn't matter.

Yes, some of the cases may be harder to trigger than others.
iov_iter_xarray() isn't as common an op as ubuf/iovec/etc, but that
either means that it doesn't matter enough, or that maybe some more
filesystems could be taught to use it for splice or whatever.

Particularly for something like different versions of memcpy(), this
whole benchmarking would want

 (a) profiles

 (b) be run on many different machines

 (c) be run repeatedly to get some idea of variance

and all of those only get *harder* to do with Kunit tests. In user
space? Just run the damn binary (ok, to get profiles you then have to
make sure you have the proper permission setup to get the kernel
profiles too, but a

   echo 1 > /proc/sys/kernel/perf_event_paranoid

as root will do that for you without you having to then do the actual
profiling run as root)

                Linus

