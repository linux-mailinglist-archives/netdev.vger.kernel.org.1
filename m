Return-Path: <netdev+bounces-14621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B15E742B97
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E4E1C20AF6
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E1F13AF0;
	Thu, 29 Jun 2023 17:56:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AF813AC3
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 17:56:26 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B7B1FD8
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:56:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d9128494cso1021152a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688061383; x=1690653383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jNOtAlZsxNFXBjiO7ePrUZV0+YgygUmrdD3PxgMZGw4=;
        b=XARa3SVN4NfQv2nZBsfksIva4mbWuedkl+RR8mKV6+zl4hg4QwKPyGPmh8iLekQIYx
         shKSY7SONko44IbPhyA1gMNTRLNPfcaLvpWsSCFwWVquAcn06qUC/Hf6wxdZOiXtLlC5
         R2PKqHLT3uvBSfJjiIXa3LV2xsTuyIYNVjIL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688061383; x=1690653383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNOtAlZsxNFXBjiO7ePrUZV0+YgygUmrdD3PxgMZGw4=;
        b=NVMLr/h1MKzlUspXabN7QOkrACEN1ksZ3Jlh4av3Bd5zoWT98mmw1io3wlFA2ETg8x
         NbBWuo2by04FsAsKDfLKbKR3cgBWVSOmNcRFI2rtuSRsu2N6Itxpspz7BscXqdgyyYrM
         8Jcdk92xTr9hzz/m1wNVOKGc+om4BloyilxuO4XW2/snwym3JPs4wmbzMXxE6deQhqzO
         +gf0mnrRZKd+zbyd6U1ye/CUUjOT9k506qiRpPLC5nrbDB8W4umDWLVdjZHX1tUrWSnU
         RyVBrtG86vE04SP55E6jVAsxKd9ZXvpT2sdheOZf2KdvXzNSaUVO196QjEufk8AZIIhi
         L84w==
X-Gm-Message-State: AC+VfDzbezZBBTB3YWEpFJJU7Mr/Q5N3d5I2BPDJEGbn6F4390QSVec/
	u3+MmSnvHzhj5XnmBSRWgE8P3/4UaDKzuThJ4TrWsKgz
X-Google-Smtp-Source: ACHHUZ7h/KrMQ1wkV6Fsp6IHjcHYX6mgpiYmOq8LKqRSieyVlIvOWdP8dsfBbWZELd3G3x++p1Z3cQ==
X-Received: by 2002:aa7:d1cd:0:b0:51d:b964:814a with SMTP id g13-20020aa7d1cd000000b0051db964814amr5020040edp.34.1688061383776;
        Thu, 29 Jun 2023 10:56:23 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id e13-20020a50fb8d000000b0051d80d7a95bsm5831153edq.14.2023.06.29.10.56.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 10:56:22 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso1005575a12.2
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:56:22 -0700 (PDT)
X-Received: by 2002:a05:6402:f1a:b0:51d:8961:bf07 with SMTP id
 i26-20020a0564020f1a00b0051d8961bf07mr36999eda.3.1688061382069; Thu, 29 Jun
 2023 10:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com>
In-Reply-To: <20230629155433.4170837-1-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Jun 2023 10:56:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
Message-ID: <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
	Dave Chinner <david@fromorbit.com>, Matt Whitlock <kernel@mattwhitlock.name>, 
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 29 Jun 2023 at 08:55, David Howells <dhowells@redhat.com> wrote:
>
> Matt Whitlock, Matthew Wilcox and Dave Chinner are of the opinion that data
> in the pipe must not be seen to change and that if it does, this is a bug.

I'm not convinced.

The whole *point* of vmsplice (and splicing from a file) is the zero-copy.

If you don't want the zero-copy, then you should use just "write()".

So I disagree violently. This is not a bug unless you can point to
some other correctness issues.

The "stableness" of the data is literally the *only* difference
between vmsplice() and write().

> Whilst this does allow the code to be somewhat simplified, it also results
> in a loss of performance: stolen pages have to be reloaded in accessed
> again; more data has to be copied.

No. It literally results in a loss of THE WHOLE POINT of vmsplice().

                    Linus

