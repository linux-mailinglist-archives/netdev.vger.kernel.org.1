Return-Path: <netdev+bounces-98326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236A8D0DF4
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 21:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3C8281048
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B5F1607A4;
	Mon, 27 May 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LjxmE6kq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41417727
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838534; cv=none; b=tabJj23i5tVAh76o49K1OGrREsPpV9QPEFykljdlAJzgfIf6tyE533MCLlJ0wJdH5qinui31C6t2XLP9cMlA53vfQjKq7zdPCcACv4k2uM2hHvT06ToSl1YGHMEWadfD+Pcuz95l+S/ux1/cNeOikcVK9VOfU5gdiB+N2WG4n9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838534; c=relaxed/simple;
	bh=ZAC9dibzZkUV27AOfCm+HmzKUnlE6D9L0M0AmO6yPKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QK3WUTECvDN3RN/4wCupnFXIDxn9NVwBVXnAJGO+SSBvXPCDEszHSxgYVUeXc0IiX8zorfbWCT+10nzfTJ4ww6Lcy8XoyVmRBLWa2UAz17ZwEUgiVJmYA9yri8zVaxEDtNTTem6KQezt+Za0vSDA8mpz6Fit/+olzUDrNBZarHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LjxmE6kq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso391941fa.2
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716838530; x=1717443330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YkZYHxtJS2xHnOCsSRDKNUe9pZJf/wZ8lc/xWYyje1g=;
        b=LjxmE6kqLHwFEJ091HnhXeOMbBXkl8JChT2fW1woYY7kN03fF7wVF2FVETAZJB26vM
         yjkgEgpSm3v8Q22XHnrB62iZWQlQ5QHmBvQmlSFmma3L6+sYyPIWWGWXoC3BomNxzs/t
         HyiWLGX0A2XY6c2omgWIQQ7XPfRGb8eSWz85s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716838530; x=1717443330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkZYHxtJS2xHnOCsSRDKNUe9pZJf/wZ8lc/xWYyje1g=;
        b=oqOyo31geOr/BguR8tzKi6XTa4cDvAtzmSOKOxbd04UbW15vG8a3XQq1sQs5Fl/fmM
         hQdMR2bkFC0UJmQRve1pMFg27HSzsHnpLsjM0IPG3mVcBpT1zYdU+HKcl3b5nyBWku7t
         CbjCqwhWHFHDylAINAcvCxiiWIKSkhXQ+KSBOfAWU+XqKHnBwYifLvisxlD54nuRRNi6
         4Yaxcey54l/6JRSI9KUtacNn1e+fEwudStl/TEu+8LN+ndMDW4/nf/6ZIRGwR6ua4jO2
         0o+ghN12qt7b92GkaTEQv7FraIoO5dRA5cBKUlXDgbl/GWp/Va930eQW7Opc8+f5pst/
         GNtw==
X-Gm-Message-State: AOJu0YwgOgaitUXufj4ddiXWtOWrCI9C5eI86wZUyaXhoUZy18zWso0j
	nMFhiuBFEUuJts3Wipc1rEgfPp1Y1P7SyMSjygbRz05a7mtcPAWiAKM8Q2ZQWxl6jkOrdhNbdP/
	4JYp4Gw==
X-Google-Smtp-Source: AGHT+IEj9KtwmuRpkFlWb9Jms4RyDKyGvnbEJipFAFzv5/7FFsScRxTPYuexbRAYsy8TMMoR5cY+HQ==
X-Received: by 2002:a2e:9d91:0:b0:2e9:821a:82fb with SMTP id 38308e7fff4ca-2e9821a837cmr13455721fa.6.1716838529771;
        Mon, 27 May 2024 12:35:29 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578523d3967sm6220713a12.42.2024.05.27.12.35.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 12:35:29 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-354f51ac110so86683f8f.0
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 12:35:29 -0700 (PDT)
X-Received: by 2002:a05:6000:1742:b0:34f:41e7:eb37 with SMTP id
 ffacd0b85a97d-3552fda7295mr8768323f8f.30.1716838528781; Mon, 27 May 2024
 12:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV> <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
 <20240526192721.GA2118490@ZenIV> <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
 <20240526231641.GB2118490@ZenIV> <20240527163116.GD2118490@ZenIV> <CAHk-=wj2VS-ZYPGARrdYVKdexcC1DsERgG1duPojtc0R92w7CA@mail.gmail.com>
In-Reply-To: <CAHk-=wj2VS-ZYPGARrdYVKdexcC1DsERgG1duPojtc0R92w7CA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 May 2024 12:35:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjojZuj_it97tBRZiHm-9bP1zUbmVs-g=M2+=DP-kF8EQ@mail.gmail.com>
Message-ID: <CAHk-=wjojZuj_it97tBRZiHm-9bP1zUbmVs-g=M2+=DP-kF8EQ@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 May 2024 at 12:20, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> With just a couple of helpers it would be mostly a cleanup.

Looking around, I think we could even take four bits. Without any
debugging, 'struct file' is 160 bytes on 32-bit, it would not hurt at
all to just force a 16-byte alignment.

In fact, in practice it is aligned more than that - we already use
SLAB_HWCACHE_ALIGN, which in most cases means that it's 64-byte
aligned.

But to be safe, we should specify the 16 bytes in the
kmem_cache_create() call, and we should just make this all very
explicit:

  --- a/fs/file_table.c
  +++ b/fs/file_table.c
  @@ -512,7 +512,7 @@ EXPORT_SYMBOL(__fput_sync);

   void __init files_init(void)
   {
  -     filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
  +     filp_cachep = kmem_cache_create("filp", sizeof(struct file), 16,
                                SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN |
                                SLAB_PANIC | SLAB_ACCOUNT, NULL);
        percpu_counter_init(&nr_files, 0, GFP_KERNEL);
  --- a/include/linux/fs.h
  +++ b/include/linux/fs.h
  @@ -1025,7 +1025,7 @@ struct file {
        errseq_t                f_wb_err;
        errseq_t                f_sb_err; /* for syncfs */
   } __randomize_layout
  -  __attribute__((aligned(4)));       /* lest something weird
decides that 2 is OK */
  +  __attribute__((aligned(16))); /* Up to four tag bits */

   struct file_handle {
        __u32 handle_bytes;

and while four tag bits isn't something to waste, it looks pretty
reasonable here.

               Linus

