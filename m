Return-Path: <netdev+bounces-26002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2DB77664C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 19:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECCD281BA7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B101D2E9;
	Wed,  9 Aug 2023 17:21:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6021AA83
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 17:21:47 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176E61B6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 10:21:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so11714686e87.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 10:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691601704; x=1692206504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1XYH3jJ0fFMcP87tUDEXy9T7rFDPHtJSPapZra9b610=;
        b=RqP3PpkgFUk5/+sLrwi/fNb6ViR7Ib+J+zMxnUPUMB/ArHXJxShRVbtUbMxdBMXg7N
         HLcgcWBi1yypE0jvljNMGPtmh0xdF41Upun8L3x3E7v2cTWPCZSDFMDjNlvEjoHuzhqM
         TMxHfYcJBnzTl/7BkVkC7ZpBfQ4Mjuu3a0MYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601704; x=1692206504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XYH3jJ0fFMcP87tUDEXy9T7rFDPHtJSPapZra9b610=;
        b=iDjMFAH+99yjhJltD+tqD6J99fZzEwqhkRg3H0EnIWHnLuVZdGlINvmGHF95UQzJpw
         0MwjmSm6pKH69R9IHFYb22ypReNNnRITM4kYnOLyxQJph+Wl8gDDOdhiyTLhodNMuu0p
         /XR1U1wtt8H4X+v6AUw/iNMg7EYMuS9t1K5m4KuHfIMziAbVRKwIPkhLd8spWmqq21EQ
         yTTUQ6oocKLucJbRAlSvzaChQr0bF6tB1PzVX//ms2s+DTlEXSXhAOVP+jbOCzCDBGRk
         gS6YUiOqemiaaG1MGHiQnCYaJq7gKgG6P6dJxIgWg3sz3kn23Oa3vuwdADwevMYvgodY
         zhGA==
X-Gm-Message-State: AOJu0YyqVInMGIPlONDrWuW8SeK21WbwRYt6y7B9iNSHhpurLKnBJQ4T
	B7BblEudJ2XyY2kvVwkquSyvj5wnihdL/jOm1xuJ9Bp8
X-Google-Smtp-Source: AGHT+IH/S71Nug3j8U+FUduAb7o2SlvDDKbuxGbguSQWCbBSWY9M056SlC0vJ/LRLtKeJ34dUQ8btA==
X-Received: by 2002:a05:6512:3118:b0:4fd:cae7:2393 with SMTP id n24-20020a056512311800b004fdcae72393mr2679125lfb.2.1691601704118;
        Wed, 09 Aug 2023 10:21:44 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m3-20020a195203000000b004fbc6a8ad08sm2366142lfb.306.2023.08.09.10.21.43
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 10:21:43 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so697171fa.2
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 10:21:43 -0700 (PDT)
X-Received: by 2002:a2e:9ccb:0:b0:2b6:dd9a:e1d3 with SMTP id
 g11-20020a2e9ccb000000b002b6dd9ae1d3mr2399575ljj.44.1691601702926; Wed, 09
 Aug 2023 10:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87edkce118.wl-tiwai@suse.de> <20230809143801.GA693@lst.de>
 <CAHk-=wiyWOaPtOJ1PTdERswXV9m7W_UkPV-HE0kbpr48mbnrEA@mail.gmail.com>
 <87wmy4ciap.wl-tiwai@suse.de> <CAHk-=wh-mUL6mp4chAc6E_UjwpPLyCPRCJK+iB4ZMD2BqjwGHA@mail.gmail.com>
In-Reply-To: <CAHk-=wh-mUL6mp4chAc6E_UjwpPLyCPRCJK+iB4ZMD2BqjwGHA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Aug 2023 10:21:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXUWPf6PySkmQXGG0vFPvCtKKX4Mwh5Wvsw1ZGjN2ggg@mail.gmail.com>
Message-ID: <CAHk-=wiXUWPf6PySkmQXGG0vFPvCtKKX4Mwh5Wvsw1ZGjN2ggg@mail.gmail.com>
Subject: Re: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 9 Aug 2023 at 10:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Right now the kernel buffer init is a *bit* more involved than the
> above ubuf case:
>
>         struct iov_iter iter;
>         struct kvec kvec = { kptr, len};
>
>         iov_iter_kvec(&iter, ITER_SRC/DEST, &kvec, 1, len);
>
> and that's maybe a *bit* annoying, but we could maybe simplify this
> with some helper macros even without ITER_KBUF.

Looking at the diff that Christoph quoted, you possibly also want

        strncpy_from_iov()

and honestly, that's a bit of an odd operation for the traditional
iov_iter use, but it certainly shouldn't be _hard_ to implement.

I'd probably initially implement it as a special case that only deals
with the "one single buffer" case (whether user space or kernel
space), since that would presumably be what you'd ever have, but
extending it to the generic case later if people actually need it
would not be problematic - those "iterate_and_advance()" macros in
lib/iovec.c are all about that horror.

               Linus

