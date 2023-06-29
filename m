Return-Path: <netdev+bounces-14630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5329C742BDD
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F298280E23
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6633B14277;
	Thu, 29 Jun 2023 18:19:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A281426A
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:19:58 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB53030C4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:19:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so1588914e87.2
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688062795; x=1690654795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=119MmpmBlik/DZD2cugIRiS/KUlXYi8QMOdrxDs/3Jk=;
        b=fUHWntqopNqgGR09zF8r/4qyuydTLc1DL0oftk32N+n5+LPRuwJTd0kF47/Lz0FNlL
         btWGQuGN4B9C/qdKWV9OwSlxnWgLKV7fMWm6r+FyfKzHhNWZ1zonVW5BzXjRxWm427+Z
         jOgNmjWX6QNOT+qrUbKOQZA2jnsqeKuMR1l9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688062795; x=1690654795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=119MmpmBlik/DZD2cugIRiS/KUlXYi8QMOdrxDs/3Jk=;
        b=YmeJpr1Z7x/WUczbNXVdMahmU8AR8ixo02w1zAUj9sETFqZAkNwjkJjP34+Rnkwy3G
         fQgyK+XdaSCH6KL/y93J8muWJ8GEq0iBeTN/xB6EGKkiTIyhbgPpSHlxa1/rmVY8BAsS
         Fga0cMdc7sz9kIQ3IZYgcoRvz2r7YuRSwrIHLrfxIfwNboEPiMPoLC43JNl1fk0Sw0qS
         3LvHz1vDR5oPfx/BmmI+34e8eOgf8RP7GLtH4BRNtq3NyC9WkkmX9TNcVKsXxvLYHiT5
         99Ww/mTOz2HChkDYey1C4hfnyfTqIT02sXPbUs2msYNUfgk0wxn1gcQF1h8daZzsfP6j
         PR5Q==
X-Gm-Message-State: ABy/qLbW4JW08Ei6AK1BrsALtcecwZ1W6B0fjCbAVE8Yv+3ieh96ex+1
	yCAFj+aQ2RW6auZnaeaqpeLZY/X0dnF9ZBjf688+IUYq
X-Google-Smtp-Source: APBJJlGW+TXD+mP+ysGaWX559/xtaEqOWVnQ3W9rLattCKYrAC/rrr18vVzOA8gag10qF6iI28kzVQ==
X-Received: by 2002:a2e:9804:0:b0:2b6:a10a:1d49 with SMTP id a4-20020a2e9804000000b002b6a10a1d49mr365767ljj.40.1688062794869;
        Thu, 29 Jun 2023 11:19:54 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id gu8-20020a170906f28800b0098f33157e7dsm5493456ejb.82.2023.06.29.11.19.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 11:19:54 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51cb40f13f6so1159354a12.2
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:19:53 -0700 (PDT)
X-Received: by 2002:a05:6402:5147:b0:51d:e30e:5b10 with SMTP id
 n7-20020a056402514700b0051de30e5b10mr1164043edd.40.1688062793473; Thu, 29 Jun
 2023 11:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
 <4bd92932-c9d2-4cc8-b730-24c749087e39@mattwhitlock.name>
In-Reply-To: <4bd92932-c9d2-4cc8-b730-24c749087e39@mattwhitlock.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Jun 2023 11:19:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com>
Message-ID: <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
To: Matt Whitlock <kernel@mattwhitlock.name>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@kvack.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 29 Jun 2023 at 11:05, Matt Whitlock <kernel@mattwhitlock.name> wrote:
>
> I don't know why SPLICE_F_MOVE is being ignored in this thread. Sure, maybe
> the way it has historically been implemented was only relevant when the
> input FD is a pipe, but that's not what the man page implies. You have the
> opportunity to make it actually do what it says on the tin.

First off, when documentation and reality disagree, it's the
documentation that is garbage.

Secondly, your point is literally moot, from what I can tell:

       SPLICE_F_MOVE
              Unused for vmsplice(); see splice(2).

that's the doc I see right now for "man vmsplice".

There's no "implies" there. There's an actual big honking clear
statement at the top of the man-page saying that what you claim is
simply not even remotely true.

Also, the reason SPLICE_F_MOVE is unused for vmsplice() is that
actually trying to move pages would involve having to *remove* them
from the VM source. And the TLB invalidation involved with that is
literally more expensive than the memory copy would be.

So no. SPLICE_F_MOVE isn't the answer.

Now, we also have SPLICE_F_GIFT. That's actually a more extreme case
of "not only should you taekm this page, you can actually try to
re-use the end result for your own nefarious purposes".

Now, I would actually not disagree with removing that part. It's
scary. But I think we don't really have any users (ok, fuse and some
random console driver?)

            Linus

