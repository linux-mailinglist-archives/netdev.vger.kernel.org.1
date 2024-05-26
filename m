Return-Path: <netdev+bounces-98107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CED4F8CF681
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 00:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C11DB211D1
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 22:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD3A383AC;
	Sun, 26 May 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PaJeakmI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07A4AD52
	for <netdev@vger.kernel.org>; Sun, 26 May 2024 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716761819; cv=none; b=hJo8zG768AhvybY+OntsJa6owExIoJmultoOR4jCAo+XfFR20TSdUKbDqSAoTcPL2uVRSs0FQeCWB3SXizd6XoL7OU2e6f6Iegx9hwSAg0NBk4sXq4Q/nix+q1lN6IRILQZ5rRlL/kXzTLGL79mC8jgGLb8Yio22dok6TO6kZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716761819; c=relaxed/simple;
	bh=cJJPOPhaSnsG9a5ZvYQMl/CwRR+CoGzIrsqGAa81OUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYL0whDHqsmlyHDnO3WeIwRPEyRekplTK8wxycUY3J5FidHYS9ti6ZfjDMuwYYTo1cJaDmtc2QvKU4trloNGOfFFESUsvgc9dy6UxYm+xTEye6YiKm21Km37/1vvhSZVmlg+tshYwOOFE7dCO1t1ReZbpJTvTuo+5znTaUjL1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PaJeakmI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e96f298fbdso14921971fa.1
        for <netdev@vger.kernel.org>; Sun, 26 May 2024 15:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716761815; x=1717366615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj9aRr4TiFbyRovrKUlKbqQvT+nJ7qhCAc9UhOWM9Fs=;
        b=PaJeakmIFTdhRWC6J9Rt7vJ+Aczv/UQEDHDnyMVtGc0853FDzG6UuXmzgi7/KP9ZHq
         nYlkW5sbSLFaBak5tcmsnkI8vivH2oELrVclXlA9Z+9E7a2xnk8mz4/sVs1J/Nv7lKap
         m64v88Y1qgEUFVHZiudcFpv1w4QmfnGAu3M9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716761815; x=1717366615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yj9aRr4TiFbyRovrKUlKbqQvT+nJ7qhCAc9UhOWM9Fs=;
        b=v+lv7VZy9uKPjfA1kkf1BiQOCLWigR/1St1n1bGwvHHYV9K6Wrw4QPKlhr7YpA6kI3
         tOLrunP7lD/u7Lhrl/KcQd99fCLhsNJVtFA+u+SY2Y1hLDFwiTJPe0sUyrpZijWDYDOT
         KN3qz6SKc2+X3zx3CgaZHbnNa+i/KV9vUNRjIJVHQxm5i2mvZ2jnT/nzWLTzZnV+CZMe
         wkOVKYgmsTjnfLFiDjdMzvDR+btu2ctnF6mCuKbokrxADyMMLLyFU9nq0KB7TxqbSV+f
         0nOU6bwUOckoTMwU2TbAQ63eHYfARlmxRhEu0mEJvtNLRN0rE7L4LZqfAvYbAX/C8/X9
         Qbqg==
X-Gm-Message-State: AOJu0YzTbVF0Qp4qqhVy3ipMm0lpcG4X7arZkKV06J3M8SC0kW6Us0Xh
	H7NEfz1KQ5g/BcoNa4tcEDwV1kimKIHE39s7N/gIxvbrWlvJHNJmlYrzRzt28roj/PCf7KShyEM
	ra2UeSw==
X-Google-Smtp-Source: AGHT+IF5JdbhlJkaK+OwPFijrZbVKg6pqhRKCGQUX43b8bXLNucVHtjJxm+dh92/59QUKn9HbtlczA==
X-Received: by 2002:a2e:83d6:0:b0:2e7:1b8:7b77 with SMTP id 38308e7fff4ca-2e95b0c163cmr48924461fa.22.1716761814647;
        Sun, 26 May 2024 15:16:54 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524bc4d8sm4995288a12.94.2024.05.26.15.16.54
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 15:16:54 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a62614b9ae1so345981966b.0
        for <netdev@vger.kernel.org>; Sun, 26 May 2024 15:16:54 -0700 (PDT)
X-Received: by 2002:a17:906:48d8:b0:a59:a7b7:2b8e with SMTP id
 a640c23a62f3a-a62643e0787mr526403766b.29.1716761813805; Sun, 26 May 2024
 15:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV> <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
 <20240526192721.GA2118490@ZenIV>
In-Reply-To: <20240526192721.GA2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 May 2024 15:16:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
Message-ID: <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 May 2024 at 12:27, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Not really.  The real reason is different - there is a constraint on
> possible values of struct fd.  No valid instance can ever have NULL
> file and non-zero flags.
>
> The usual pattern is this:

[ snip snip ]

Ugh. I still hate it, including your new version. I suspect it will
easily generate the extra test at fd_empty() time, and your new
version would instead just move that extra test at fdput() time
instead.

Hopefully in most cases the compiler sees the previous test for
fd.file, realizes the new test is unnecessary and optimizes it away.

Except we most definitely pass around 'struct fd *' in some places (at
least ovlfs), so I doubt that  will be the case everywhere.

What would make more sense is if you make the "fd_empty()" test be
about the _flags_, and then both the fp_empty() test and the test
inside fdput() would be testing the same things.

Sadly, we'd need another bit in the flags. One option is easy enough -
we'd just have to make 'struct file' always be 8-byte aligned, which
it effectively always is.

Or we'd need to make the rule be that FDPUT_POS_UNLOCK only gets set
if FDPUT_FPUT is set.

Because I think we could have even a two-bit tag value have that "no fd" case:

 00 - no fd
 01 - fd but no need for fput
 10 - fd needs fput
 11 - fd needs pos unlock and fput

but as it is, that's not what we have. Right now we have

  00 - no fd or fd with no need for fput ("look at fd.file to decide")
  01 - fd needs fput
  10 - fd pos unlock but no fput
  11 - fd pos unlock and fput

but that 10 case looks odd to me. Why would we ever need a pos unlock
but no fput? The reason we don't need an fput is that we're the only
thread that has access to the file pointer, but that also implies that
we shouldn't need to lock the position.

So now I've just confused myself. Why *do* we have that 10 pattern?

Adding a separate bit would certainly avoid any complexity, and then
you'd have "flags==0 means no file pointer" and the "fd_empty()" test
would then make the fdput) test obviously unnecessary in the usual
pattern.

             Linus

