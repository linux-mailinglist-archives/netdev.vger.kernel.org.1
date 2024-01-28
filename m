Return-Path: <netdev+bounces-66538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B4283FA59
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 23:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3873DB2201B
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 22:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7ED3C699;
	Sun, 28 Jan 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GmUzxYOA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943073C489
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481141; cv=none; b=PLHCldLrIyHxm2u4LD7QZSMStsn3a2VDxqc910ZxwwEc7WPvpOIJ5kXVbO4gO+RZYeFdEbaWinNjmQfJi9dy9t5gZxzq5NNNqwAhrT9LimetKp7a+bzgiG3VzQvf6romjaVjVt8oKGSyLaPTSsROx/pphO1zgYsopws3rq6QIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481141; c=relaxed/simple;
	bh=AEYZz0WbEa5P8+CB+O4anP0MQfywFaLOnhWBqol5b2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiHuMesOVN100vVGzMmujirZ70iO7SLYUvzW3Oy6qsrohybmxiku0dZqi4PkJmrePY2sJqdDCBe1PxQt2TrYrB5IhFasvyoBTL6A4MG4sw+VM1JxRynqXcIErx/VuWCcZyzDX7T1HKGg51EkwYTbNzx6pSx0pD2OOiB439aSK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GmUzxYOA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a35c1793d02so19916466b.3
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 14:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706481137; x=1707085937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bqwd7hhPAgPM5QIH38rfOxpWBqWFIbyQQhTZxa5cgpo=;
        b=GmUzxYOA42m7h/7H4YNdv34VRamsWfZHNZ0+fFrZ+hcwnOSugC+FDjr97BOejvA/B0
         15aSABLiDKGWI+Ddja2wklAoPCVjLPunUNcDlKBoPIj7ovhktc5CpY6AhqBsts39Uo9v
         PoBAqImOt3ALpkfnJXJlAe0T8391j42pTmHrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481137; x=1707085937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqwd7hhPAgPM5QIH38rfOxpWBqWFIbyQQhTZxa5cgpo=;
        b=hkq9U0lDYn63irx8ui1mkKyd3nGk5hcwzLBUu4XCY3JfHShbGJnLh+BR/UnsH21Km1
         rM4NV/NcSr0T6eH9ibrXjukkdUaNPBXKGDWgtToHCApVJhf1Efu2Vlxon1i/J+MEafaR
         jOy7pGwqonjHu1o3iJn6lk2zVdwwWzsByl/RbKQ8xnJnNLlBTWqFsQsIZc5Zm73I4xtK
         5deT5Rxzu5Wm/jTpjofAmkEAMeeph12YJdLXXNpuXtih1R5Vn8pjza4XAdKLBVA5G55E
         SDW6OEUfX33Q3kt3ZxCeBOh/wugT/NdLZe3EW8utPwiGoBfWFW/XtYrzCP3zM3SskTpx
         mSng==
X-Gm-Message-State: AOJu0YxIzhrx2ijmpDu1QQ0rNmxAvg06OqgyQT2pQPQ2sE9RQdzUEaHx
	YxPoC6O3WJriTgywgefcNr9eVjTycF5q6OU+57sRFtPYGNWhzIzvd3N/ooerC/meOC40FrvDkXB
	YZQLDmQ==
X-Google-Smtp-Source: AGHT+IFkk8S8SQBSRYQCmfM+0KBPPYZHRulJ9jM/FCsu2z3VMW1Sl1W5l4StjSm52JRBSOsjwF06bg==
X-Received: by 2002:a17:906:4719:b0:a27:af7:bba5 with SMTP id y25-20020a170906471900b00a270af7bba5mr3093504ejq.22.1706481137596;
        Sun, 28 Jan 2024 14:32:17 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id fx20-20020a170906b75400b00a34b15c5cedsm3293525ejb.170.2024.01.28.14.32.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 14:32:16 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55cc182da17so2087494a12.3
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 14:32:16 -0800 (PST)
X-Received: by 2002:a05:6402:3509:b0:55e:c6e3:5e24 with SMTP id
 b9-20020a056402350900b0055ec6e35e24mr2150353edd.36.1706481136452; Sun, 28 Jan
 2024 14:32:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com>
 <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com> <CAHk-=whxYjLFhjov39N67ePb3qmCmxrhbVXEtydeadfao53P+A@mail.gmail.com>
 <a756a7712dfe4d03a142520d4c46e7a3@AcuMS.aculab.com>
In-Reply-To: <a756a7712dfe4d03a142520d4c46e7a3@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 14:32:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiacNkOUvT_ib9t4HXX9DSsUCFOCAvbPi+WBkdX3KCq2A@mail.gmail.com>
Message-ID: <CAHk-=wiacNkOUvT_ib9t4HXX9DSsUCFOCAvbPi+WBkdX3KCq2A@mail.gmail.com>
Subject: Re: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, "David S . Miller" <davem@davemloft.net>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 14:22, David Laight <David.Laight@aculab.com> wrote:
>
> Hmmmm blame gcc :-)

I do agree that the gcc warning quoting is unnecessarily ugly (even
just visually), but..

> The error message displays as '0' but is e2:80:98 30 e2:80:99
> I HATE UTF-8, it wouldn't be as bad if it were a bijection.

No, that's not the problem. The UTF-8 that gcc emits is fine.

And your email was also UTF-8:

    Content-Type: text/plain; charset=UTF-8

The problem is that you clearly then used some other tool in between
that took the UTF-8 byte stream, and used it as (presumably) Latin1,
which is bogus.

If you just make everything use and stay as UTF-8, it all works out
beautifully. But I suspect you have an editor or a MUA that is fixed
in some 1980s mindset, and when you cut-and-pasted the UTF-8, it
treated it as Latin1.

Just make all your environment be utf-8, like it should be. It's not
the 80s any more. We don't do mullets, and we don't do Latin1, ok?

            Linus

