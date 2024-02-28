Return-Path: <netdev+bounces-75902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13086B9C5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 22:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9487E1F212C0
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 21:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AAE8627F;
	Wed, 28 Feb 2024 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B+m69ozj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BE86241
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155289; cv=none; b=WfDmEclLlPGdnabEbd0jHi7SF06RM3e/QLHSiduxRlfkKq6F0ppN0sDxtAaY1jBj+5Zy55rqyLhqlDiYG3XMyzX7f3sPzfZmd7I3joQYOGhJywQ2b7J0pgzh9tDE4h4GsBPWYjQMLOLmLRJacPFUgQWiAuTJkZMcNwTACdiCgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155289; c=relaxed/simple;
	bh=1MRLxMSSbDaZOoH74gZrRBxdj01ORAzox/zNSSQV35k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfGJAABd50qa1FSVemCndudSUfoynYWE8NFsCFgdyAZNxibWvI7C5aej15ajQFEB0vcCoUb1WfKvf0LIYBufqVf34vzX1CtHia00ueRHc4wfSRAsXOoIHJ12b1wNnNlRO/WPBnSbqnb33ybW3A/m+7FhE1GMHjKsEjdJlNTlYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B+m69ozj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56647babfe6so343453a12.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709155286; x=1709760086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibURPhL0TwbuNHb2Ue6c1VsEM5dnOByPcep2Xd5k/OA=;
        b=B+m69ozjwNePNGkNIqZxY5cYxPT5xZkc2iYa3mL8hTrYFU1YOYVnRJsPkJqCi2ymQp
         hTWjmaksS/HCeGz5kk/DM0ms6EkmbZ5//kAhxkq4/NA3lQz8y8UqCP2WwQMif4pCIbFR
         Ue6ZGIY3ca0Oo0WS8pFOfA50DMxhF4102kkC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155286; x=1709760086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibURPhL0TwbuNHb2Ue6c1VsEM5dnOByPcep2Xd5k/OA=;
        b=LN9ddeHufBoTXYTyHmOXbg85S1/naARwLhOSm3llOapXPI0g3rw+FmjGpoSi3VaPsU
         YFtBK1v3Z9c6vfUyKwc8rIPtfk1Q12U9/gF9VN2c8h5xnlQG5LKSMbzwwx1pATPisxKc
         yZu9ZspA5QzFRk2SSoHSrgv4Wwbl71YY6vWn6msMJa1yjCl1k1tQ2ene8JwCGfVYZhut
         ep9BcOU9wD9cwR9+bbG6xbvHhKI8rWzBiQFKFsve51Y3zaDr9NiIHG39gGoHBqtp1zN1
         wiJW5XKJQ0lVwkm/T238SfoRUPtz9N952pkSsk0267kf080HaZhM3Y8LWZPM2X58yaVQ
         BefA==
X-Forwarded-Encrypted: i=1; AJvYcCVQMzbqcLiuXaaVkCvi1iLqTWz6LS3R/fB84n3wxc9aWhm2M8Ofm62ftfDTTbNTr80ZWjYKTNmF7gjErjveXU+oJUHe7hMj
X-Gm-Message-State: AOJu0YzkpKK6B3+j//z3w4Nqk8/xUJoGGN9tOh7JmkR/cn5LMdaYFaEP
	y1iooP6jgLmgmx08nw8GcnIDTIqHNC1o8CLLguCE40W72BA8bo6xi/fawLDUu+Apr1mNXVrE/OZ
	hQAkVBQ==
X-Google-Smtp-Source: AGHT+IH1QMvQdeUx1SfXSmIJ8d6pUn/sanPWBYS6YJZhztbmDVCB4GfGTGXOmwB4q9Mj4lMnoz29aQ==
X-Received: by 2002:a50:9e8e:0:b0:566:16e4:b6b3 with SMTP id a14-20020a509e8e000000b0056616e4b6b3mr119960edf.36.1709155286079;
        Wed, 28 Feb 2024 13:21:26 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id ij13-20020a056402158d00b00565ba75a739sm2103038edb.95.2024.02.28.13.21.24
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 13:21:24 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56647babfe6so343423a12.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:21:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjpTNdAURJxJpvFV8JXP72uh/B9ZpqpuS4IO5TeRfmvXJyFcke93SCkaB5L5vzKjEKIRZA6azUnWHsVV0L0yt63mCy8Mk+
X-Received: by 2002:a17:906:a291:b0:a44:234:e621 with SMTP id
 i17-20020a170906a29100b00a440234e621mr129720ejz.10.1709155284453; Wed, 28 Feb
 2024 13:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
In-Reply-To: <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 13:21:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
Message-ID: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 19:13, Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> After this patch:
>    copy_page_from_iter_atomic()
>      -> iterate_and_advance2()
>        -> iterate_bvec()
>          -> remain = step()
>
> With CONFIG_ARCH_HAS_COPY_MC, the step() is copy_mc_to_kernel() which
> return "bytes not copied".
>
> When a memory error occurs during step(), the value of "left" equal to
> the value of "part" (no one byte is copied successfully). In this case,
> iterate_bvec() returns 0, and copy_page_from_iter_atomic() also returns
> 0. The callback shmem_write_end()[2] also returns 0. Finally,
> generic_perform_write() goes to "goto again"[3], and the loop restarts.
> 4][5] cannot enter and exit the loop, then deadloop occurs.

Hmm. If the copy doesn't succeed and make any progress at all, then
the code in generic_perform_write() after the "goto again"

                //[4]
                if (unlikely(fault_in_iov_iter_readable(i, bytes) ==
                              bytes)) {
                        status = -EFAULT;
                        break;
                }

should break out of the loop.

So either your analysis looks a bit flawed, or I'm missing something.
Likely I'm missing something really obvious.

Why does the copy_mc_to_kernel() fail, but the
fault_in_iov_iter_readable() succeeds?

              Linus

