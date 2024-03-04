Return-Path: <netdev+bounces-77203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 476A88709AC
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 19:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E77BB2AD31
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D29578696;
	Mon,  4 Mar 2024 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BbWTIXvV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689A78685
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577166; cv=none; b=N1kyjnNL1/Tvq4Iw2kI+sLI2QrsWZQnvWyeaQfoTs0dmyx2IjDfrtbn4T5VLIjVepYcshaGEXkpUkmdWExr7p9T77/TGzuSmRGGoS6ncBAXaniKjz8hHPNo1DG0V6kDGeO4mFCxX/xq+Q3GgJRalAOfd8zr5OAlitsIb3mFhbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577166; c=relaxed/simple;
	bh=KtfWqAbL60dmDmNJlm82ls0DTRmdSK6fujqZ9REQ7jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/JfVU8w3z9EGWCmKbuQDeJJQvQf8S2psB8zc8swWS24TO5KmkiGGeKNk+2U6iKN42dECP92OfAWS3hTwVG1K9GxWM+59K57j77Km4WiMRhQsRuH2lYmTztjCKI4wPm+DAjFTvv04cLcfWX8UvWx8g57o+6AYF4/tgxSfrtj1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BbWTIXvV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56682b85220so7755067a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 10:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709577163; x=1710181963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LczxhZqLEWu5Pcwo59Oo1yTNgbAQRYyUzuwaCxJZY78=;
        b=BbWTIXvVXccjOIm6D8UrLPSNEOVbttfbMP1WZ4f0oou7KQSadyMmLEJjcYg6b35Rof
         ArKb0L6JTwpK2zZZTd4V4+h4CdxqULG4VZ0zJMb2ytUQUYOxKqYf+I4LtYAblhvjvW59
         1IOUrloYE4kqblgcXfSGJAjvn32ooaRHjFsMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577163; x=1710181963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LczxhZqLEWu5Pcwo59Oo1yTNgbAQRYyUzuwaCxJZY78=;
        b=X/usGNnonmaP3vnX2rw9AdPaRuHxnAwHITUaiyMkI0XC7liKm/jfNRuBkLhUMDo1gS
         v1u17pPH9CU4SzhmyIF9hfzo5FDXxx6pRiofbaPHnvXJMNCSp6Uh0ueP6NeqF2CYxgAF
         RGtS7A/kz/N/K1RX23cqsJ4PvIzdfvpTHTi63MYvQNDEQNO9w9ZJE8TXwQpU++v6wTbo
         MFaB7n37DFyhrH5SaYGkGIDK5H41+4PFbPCzwyswbEZ2NBmnfJps/9/fBEi+3jdEjBMC
         e8pB/eaevZo0XyuI+Z+Gsp1rG8gdbbBjTp8MZ9WEyPQjt7GB8NG8PdGszkM3Q5IiDp4V
         AtlA==
X-Forwarded-Encrypted: i=1; AJvYcCUKI/ycT+w+Eqc5TGW8VZ8VH+aeIuL3cUEZRXes2Mp1YyAQSFd654+rcONyfKhqZPOOL+Al2VSu0uonfHNoQspRNTzanJ7+
X-Gm-Message-State: AOJu0YxnTnKxFvbN3f1He02C4xGRJDxHRTei8gDcx01Q13Pe1T7KshYG
	IiJmdM8GItijL/gMrZvQWdTYs3zXMCEpMTDGjdCFWABW2kU0Y2dsSQbwYlOId5IYzey8JIgBBF7
	T0Jw=
X-Google-Smtp-Source: AGHT+IEDXc+xl3NY4LC8FWaFkvhgQt8TrysdrPqrya4Z8J2K57kCZAo58GuxM/7n697Djypo9iEHuA==
X-Received: by 2002:a17:906:7fce:b0:a43:b565:8780 with SMTP id r14-20020a1709067fce00b00a43b5658780mr6857613ejs.25.1709577162959;
        Mon, 04 Mar 2024 10:32:42 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id e20-20020a17090681d400b00a4555d6815dsm1278060ejx.65.2024.03.04.10.32.42
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 10:32:42 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5656e5754ccso6190254a12.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 10:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGrhxw3v5tEf2noE/n+l1Tg37HNMTFygCN6TrxQ3q2tFxBsxqyavyt13vhc64F+kHG4d4HmO7OvQ8vNsRk9EdVEcRxlIST
X-Received: by 2002:a17:906:8da:b0:a3f:ab4d:f7e3 with SMTP id
 o26-20020a17090608da00b00a3fab4df7e3mr7570338eje.0.1709577161818; Mon, 04 Mar
 2024 10:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com> <769021.1709553367@warthog.procyon.org.uk>
In-Reply-To: <769021.1709553367@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Mar 2024 10:32:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrmt875HJNUY9a-ti0M6M1m6jHEGvCSjcOfXy_E7_X_w@mail.gmail.com>
Message-ID: <CAHk-=wgrmt875HJNUY9a-ti0M6M1m6jHEGvCSjcOfXy_E7_X_w@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: David Howells <dhowells@redhat.com>
Cc: Tong Tiangen <tongtiangen@huawei.com>, Al Viro <viro@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 03:56, David Howells <dhowells@redhat.com> wrote:
>
> That said, I wonder if:
>
>         #ifdef copy_mc_to_kernel
>
> should be:
>
>         #ifdef CONFIG_ARCH_HAS_COPY_MC

Hmm. Maybe. We do have that

  #ifdef copy_mc_to_kernel

pattern already in <linux/uaccess.h>, so clearly we've done it both ways.

I personally like the "just test for the thing you are using" model,
which is then why I did it that way, but I don't have hugely strong
opinions on it.

> and whether it's possible to find out dynamically if MCEs can occur at all.

I really wanted to do something like that, and look at the source page
to decide "is this a pmem page that can cause machine checks", but I
didn't find any obvious way to do that.

Improvement suggestions more than welcome.

               Linus

