Return-Path: <netdev+bounces-19291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC8075A2FA
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 02:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC091C211F1
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1D2263B5;
	Thu, 20 Jul 2023 00:00:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFB61BB5D
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 00:00:39 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18DE69
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:00:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98e39784a85so294040766b.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689811236; x=1690416036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=COIx9PJNSvI0bd/8+R1trZjf1/QUjd+w4gApApqhVyk=;
        b=f27uBH5wU40J6riZ8XwAdu5idKfrXkSHcghdnN6AxybPW7XLVW7uyDYy7hU43eE8Up
         qV56o4+luFJ0imm+OIgFp+7iYU6l+GY3f7/ZhEmtxonWjMcLeQm5SeHmNb34uzzhAhJg
         9WNz6EL2DDfow6JT0oiDsp7KEwsHms98ha+Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689811236; x=1690416036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COIx9PJNSvI0bd/8+R1trZjf1/QUjd+w4gApApqhVyk=;
        b=cwoM+siPysPGqmEMAfp/bQIlYuP+VU6AvPOwmNxxIYGpF5SpJwSMjANRRxgqyOZJkW
         Iz+rnqWF1/ZtOlpAU508MnOIqX2NNjv7SJ/A0AizIAzSz+x9YqdaIpSFelLxFu6J17yj
         eRNN2xVyMBn3rDTG2sKh0/f86wUxfp4sr8MVrmjH2+ZTT0G4i6cHEbPpgJ1jjq5+qXJO
         eX7YIOTalfaRLIJGaJXXbCJ6GGQ/8rPvR4x4dsWqBc3MMe+NcpmHj/jxQtdbOPd8Vhvs
         U7DrXxD0wfx3LV/S5KTA+cv9TfGDMRfHketrpcWzeZp5dOCNlILvznylsUMxc6oydWte
         9MYg==
X-Gm-Message-State: ABy/qLZEvaCnAKqKAqXXhKNLSdbVdU31aRijCXsNlZVNP4YY0yxI12su
	fyyZ0hZ7Br2pjeu5Og2D5BGWlWcox4+WX8QqmyxMVXnn
X-Google-Smtp-Source: APBJJlFvBAg3TdAi8mHSQd4RLPz/ZfYNEhfqHwc0042Qu4RmfyyMkoLJO8byzjv0a2KvzUO+YN6Xww==
X-Received: by 2002:a17:906:20d8:b0:993:f4cd:34dd with SMTP id c24-20020a17090620d800b00993f4cd34ddmr4278339ejc.34.1689811236464;
        Wed, 19 Jul 2023 17:00:36 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id ke16-20020a17090798f000b0098e34446464sm2949816ejc.25.2023.07.19.17.00.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 17:00:34 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so567738a12.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:00:34 -0700 (PDT)
X-Received: by 2002:a50:fc13:0:b0:51d:914a:9f3d with SMTP id
 i19-20020a50fc13000000b0051d914a9f3dmr3806792edr.10.1689811234438; Wed, 19
 Jul 2023 17:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org> <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
 <6609f1b8-3264-4017-ac3c-84a01ea12690@mattwhitlock.name> <CAHk-=wh7OY=7ocTFY8styG8GgQ1coWxds=b09acHZG4t36OxWg@mail.gmail.com>
 <0d10033a-7ea1-48e3-806b-f74000045915@mattwhitlock.name>
In-Reply-To: <0d10033a-7ea1-48e3-806b-f74000045915@mattwhitlock.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jul 2023 17:00:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwdG9KnADHQg9_F9vXFMKYFRcbSyb=0btFnzr2ufpQ6Q@mail.gmail.com>
Message-ID: <CAHk-=wgwdG9KnADHQg9_F9vXFMKYFRcbSyb=0btFnzr2ufpQ6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To: Matt Whitlock <kernel@mattwhitlock.name>
Cc: Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 19 Jul 2023 at 16:41, Matt Whitlock <kernel@mattwhitlock.name> wrote:
>
> Then that is my request. This entire complaint/discussion/argument would
> have been avoided if splice(2) had contained a sentence like this one from
> sendfile(2):
>
> "If out_fd refers to a socket or pipe with zero-copy support, callers must
> ensure the transferred portions of the file referred to by in_fd remain
> unmodified until the reader on the other end of out_fd has consumed the
> transferred data."
>
> That is a clear warning of the perils of the implementation under the hood,
> and it could/should be copied, more or less verbatim, to splice(2).

Ack. Internally in the kernel, the two really have always been more or
less of intermingled.

In fact, I think splice()/sendfile()/tee() could - and maybe should -
actually be a single man-page to make it clear that they are all
facets of the same thing.

The issues with TCP_CORK exist for splice too, for example, for
exactly the same reasons.

And while SPLICE_F_MORE exists, it only deals with multiple splice()
calls, it doesn't deal with the "I wrote a header before I even
started using splice()" case that is the one that is mentioned for
sendfile().

Or course, technically TCP_CORK exists for plain write() use as well,
but there the portable and historical fix is simply to use writev()
and send it all in one go.

So it's hopefully only when you use sendfile() and splice() that you
end up with "oh, but I have multiple different *kinds* of sources, and
I want to cork things until I've dealt with them all".

            Linus

