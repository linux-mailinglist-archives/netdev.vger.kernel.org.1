Return-Path: <netdev+bounces-14633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46739742C03
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F29280CE1
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA42A12B7C;
	Thu, 29 Jun 2023 18:43:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801A12B63
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:43:05 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5B92693
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:43:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991c786369cso124073366b.1
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688064182; x=1690656182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mmhtpqqkJ1KWVH50RxZoMJvMId6WkP/xoN83CJAGivM=;
        b=HMvzagF0myuZ+UEdT1gsNRXhKxGSBimD2rqEuTr2VRNZ9qRno9HbCh6BzpHJy28qbH
         KluJwSPOl8jfxmmq1Qp/P0x58Sv9de2mRH4oS1qbqFLdwHyaar456CsbLQUT10Goc3Bo
         cMJfyTsXV3cekEN8+x/aSW6zoSGGaAr3oceeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688064182; x=1690656182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmhtpqqkJ1KWVH50RxZoMJvMId6WkP/xoN83CJAGivM=;
        b=LmV/ack3kik5QwNgEZIhSVB2o3Q6CRxtTwmoV7uSh+rkvFRL4Bap63/An0TsOjyU2s
         //0Dr7W6DYncXLvocoQ7PaB5bZL/pBplxISVpOOoE3pbGCnJGaa9lbNmZgv3fdBIyMT9
         vm0X6lRkgK9X4OFm4+ZhKqaJShXX7EWMAratn0MoNCjEyfAuDCSwzyzrm2sD8h0VdNsk
         RYx6Ma5IPy1/c6Hp6m4cWkYkHd/QoT+kO4CSDSggb0OfCF9ZnQlFMftmk5C+aJFf/Iaw
         59Q4jeBeAK5VGgmp7twP4h2iotDibM0qn5s0LisZf6EI4FCStOn48ZEahA+DmlEGpr8I
         OVBg==
X-Gm-Message-State: ABy/qLa7Gif/w57DDb0uL0eLCBRXOBbQdJg1Ub6ZPp6zzR0wtsbFCmOl
	bSl44fny4sXv5coghsD9DUdqslrx2UrY/tf6zGvDSlhE
X-Google-Smtp-Source: APBJJlGZACsnBlfTv0PZ4s9lV42lSsLiQXq6Q05ZEeExR4CUD7GgQX3/nkTK3slyjnV9giu+ba3v7Q==
X-Received: by 2002:a17:906:1152:b0:960:ddba:e5c6 with SMTP id i18-20020a170906115200b00960ddbae5c6mr182884eja.22.1688064182182;
        Thu, 29 Jun 2023 11:43:02 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id kt19-20020a170906aad300b009894b476310sm7157455ejb.163.2023.06.29.11.43.01
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 11:43:01 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so1099241a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:43:01 -0700 (PDT)
X-Received: by 2002:aa7:c690:0:b0:51d:9693:5124 with SMTP id
 n16-20020aa7c690000000b0051d96935124mr81608edq.19.1688064180790; Thu, 29 Jun
 2023 11:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
 <4bd92932-c9d2-4cc8-b730-24c749087e39@mattwhitlock.name> <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com>
In-Reply-To: <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Jun 2023 11:42:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgG_2cmHgZwKjydi7=iimyHyN8aessnbM9XQ9ufbaUz9g@mail.gmail.com>
Message-ID: <CAHk-=wgG_2cmHgZwKjydi7=iimyHyN8aessnbM9XQ9ufbaUz9g@mail.gmail.com>
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

On Thu, 29 Jun 2023 at 11:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, we also have SPLICE_F_GIFT. [..]
>
> Now, I would actually not disagree with removing that part. It's
> scary. But I think we don't really have any users (ok, fuse and some
> random console driver?)

Side note: maybe I should clarify. I have grown to pretty much hate
splice() over the years, just because it's been a constant source of
sorrow in so many ways.

So I'd personally be perfectly ok with just making vmsplice() be
exactly the same as write, and turn all of vmsplice() into just "it's
a read() if the pipe is open for read, and a write if it's open for
writing".

IOW, effectively get rid of vmsplice() entirely, just leaving it as a
legacy name for an interface.

What I *absolutely* don't want to see is to make vmsplice() even more
complicated, and actively slower in the process. Unmapping it from the
source, removing it from the VM, is all just crazy talk.

If you want to be really crazy, I can tell you how to make for some
truly stupendously great benchmarks: make a plain "write()" system
call look up the physical page, check if it's COW'able, and if so,
mark it read-only in the source and steal the page. Now write() has
taken a snapshot of the source, and can use that page for the pipe
buffer as-is. It won't change, because if the user writes to it, the
user will just take a page fault and force a COW.

Then, to complete the thing, make 'read()' of a pipe able to just take
the page, and insert it into the destination VM (it's ok to make it
writable at that point).

You can get *wonderful* performance numbers from benchmarks with that.

I know, because I did exactly that long long ago. So long ago that I
think I had a i486 that had memory throughput measured in megabytes.
And my pipe throughput benchmark got gigabytes per second!

Of course, that benchmark relied entirely on the source of the write()
never actually writing to the page, and the reader never actually
bothering to touch the page. So it was gigabytes on a pretty bad
benchmark. But it was quite impressive.

I don't think those patches ever got posted publicly, because while
very impressive on benchmarks, it obviously was absolutely horrendous
in real life, because in real life the source of the pipe data would
(a) not usually be page-aligned anyway, and (b) even if it was and
triggered this wonderful case, it would then re-use the buffer and
take a COW fault, and now the overhead of faulting, allocating a new
page, copying said page, was obviously higher than just doing all that
in the pipe write() code without any faulting overhead.

But splice() (and vmsplice()) does conceptually come from that kind of
background.

It's just that it was never as lovely and as useful as it promised to
be. So I'd actually be more than happy to just say "let's decommission
splice entirely, just keeping the interfaces alive for backwards
compatibility"

                     Linus

