Return-Path: <netdev+bounces-181846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60DDA8692D
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0397A94ED
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E179A281375;
	Fri, 11 Apr 2025 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="m7uRqGHI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F591EFF9F
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414291; cv=none; b=TkNhN5w4P0en1P1+08NTKbdVw4lnlNq+B7w3oom0nNf7x5EXY/nSTOjfLCgv7qL7M0hVvfTLnRFJyvARSyzBULqGaffHcNjcOEonjDiZEwHI/Fnd7VNex53mvxq1MNpwSgRbxVnX80KQywi8vJu5HQlZbwT2ZYMc1cOd+IbEpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414291; c=relaxed/simple;
	bh=oaNqsFco8JB343GgH+vp2v1xQsTL7LDWQMR9zV8jthc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkpBJsfhpruB6LpUvThUbat9jSnFbEzsr8AqvlPUKSl5Pg7IteyAzgUEADt5JBZcWXUEeCkgokmHGcT54A1iMhX1lW9kGkTZigazBHeAxJjou1+2dHer40yF1sIqqyl0wkd1p7HNhx2yQxSYE7YPnnTuA3nXERd5GgDAwwAwHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=m7uRqGHI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c55d853b54so38923385a.0
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 16:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744414289; x=1745019089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oaNqsFco8JB343GgH+vp2v1xQsTL7LDWQMR9zV8jthc=;
        b=m7uRqGHI/kvtHs1mxQ6JB8Q70XLQK4bLc8vYXyz10/vdlRKn9HUeFVH36okz1JMURK
         VNKfc9QZAXD3zLs17F+2EE2NtJKmROGv7v0VH0J6eKRKTHoPvdpRvO4qR4muNqWmhF3+
         2/cRO3fPs+wt4LG2nrOwA8SVpeDzWYGT6Hu6k1ESdTyJYy/HdovKa/h9ryIpNZWdnmse
         rZgd3hYIZmpkbTbQiiRqh3BTCjW+PBQPyoDJpXkk31BBx+5SQ3t+BaZlYhbbKJcfNJTG
         Xm+NQrJ/Ecien+tQl94RL9a86w/nUSS8KL+HthppF4ihAQA5j1O8ey4w+H5u/3/8Ig4A
         ABiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744414289; x=1745019089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaNqsFco8JB343GgH+vp2v1xQsTL7LDWQMR9zV8jthc=;
        b=fOa5S8NJaeRSH9kP47+EpNUPE8COrXLaRIb89kWWTfbtRLUfGGog+ClTgBh8YJGLjY
         pT83+1BRJFJ9LkZ/rIhMNfAP8NHicuuLwF6YOgBYOwHr4PF7ZeDZr4WlYm8Uch6yjkTI
         S55vmGhbd23o//rqdphrO/kfyV0jWpa/vMd//k5Ow3Y/kA8EU1NeBbDScgWCRe7CNlBv
         81VqVF2/LBW4aJdCoYAbfKmPjRHtc+/V7+SxOgAxiew/v2uhTYGlZ1jC+4DcpSP3NMwr
         FoRF2wa3EUCgEfzoGUkg/8TR/OaSRk1eIyIIMiB74MixpXn/hsyIBtz0c7rgEp5fpQ+S
         inTA==
X-Forwarded-Encrypted: i=1; AJvYcCXpa8NH9Jj8eec8pHbo5bv2W2yvYit96BaTsj0aS3UOADoy8As9HZ6ha2znwi5ziOscGJ4MGzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7l2vy2CgIzrNUpQJL6ugC5WJsz/uEYmGQ/KoLZANS5JewyD+2
	4276GPJ4IQ2AKDOjDKTe8uRKA7wQ7GRL41VeOZtfubNXG63hrii5ox7owPUhuZW9u4zdDKPnU7U
	aH5k1iT4+3UKmTPy2kx1g8bE/6p8wOt33Q6PFenXy2XpFwW/MXMxGsg==
X-Gm-Gg: ASbGncvu9v9wsCnsdKEGv0oIjLpVkiHKCvdOygmOMr1dNsGlVBhF2lC8R+LV/Wk4e4d
	ebFOrM/P3jzdCSK35CV3VBxRnRj3jvMLFZW+MPgZvuDCibn9/s0YmMOVuNElTgz4/o0CyHed3nb
	nesZjNyiWYnGUlXGInC9ZfOoZUfOtbIXqERmCjjAWmDKSN6Aj/syQfmLM=
X-Google-Smtp-Source: AGHT+IGkg/TunTKQ9MZqeKHN0v4VF2s22ofNt6dIFsFbrFnD6SK4Iked54QNCaE8x41fNL3Sh1TDfTs5P6GH1oTZuMo=
X-Received: by 2002:a05:6214:c2a:b0:6e8:c713:3222 with SMTP id
 6a1803df08f44-6f23f1562f3mr27189726d6.11.1744414288706; Fri, 11 Apr 2025
 16:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411173551.772577-1-jordan@jrife.io> <20250411173551.772577-3-jordan@jrife.io>
 <7ed28273-a716-4638-912d-f86f965e54bb@linux.dev>
In-Reply-To: <7ed28273-a716-4638-912d-f86f965e54bb@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Fri, 11 Apr 2025 16:31:18 -0700
X-Gm-Features: ATxdqUF051zKjiKZ9y2V8ZlQOt_x0rfHGFQUz1tGhdHyUI74aVc70jqLVMEm8vs
Message-ID: <CABi4-ojQVb=8SKGNubpy=bG4pg1o=tNaz9UspYDTbGTPZTu8gQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Since the cookie change is in the next patch, it will be useful to mention it is
> a prep work for the next patch.

Sure, will do.

> The resized == true case will have a similar issue. Meaning the next
> bpf_iter_udp_batch() will end up skipping the remaining sk in that bucket, e.g.
> the partial-bucket batch has been consumed, so cur_sk == end_sk but
> st_bucket_done == false and bpf_iter_udp_resume() returns NULL. It is sort of a
> regression from the current "offset" implementation for this case. Any thought
> on how to make it better?

Are you referring to the case where the bucket grows in size so much
between releasing and reacquiring the bucket's lock to where we still
can't fit all sockets into our batch even after a
bpf_iter_udp_realloc_batch()? If so, I think we touched on this a bit
in [1]:

> > Barring the possibility that bpf_iter_udp_realloc_batch() fails to
> > grab more memory (should this basically never happen?), this should
> > ensure that we always grab the full contents of the bucket on the
> > second go around. However, the spin lock on hslot2->lock is released
> > before doing this. Would it not be more accurate to hold onto the lock
> > until after the second attempt, so we know the size isn't changing
> > between the time where we release the lock and the time when we
> > reacquire it post-batch-resize. The bucket size would have to grow by
> > more than 1.5x for the new size to be insufficient, so I may be
> > splitting hairs here, but just something I noticed.
>
> It is a very corner case.
>
> I guess it can with GFP_ATOMIC. I just didn't think it was needed considering
> the key of the hash is addresses+ports. If we have many socks collided on the
> same addresses+ports bucket, that would be a better hashtable problem to solve
> first.
>
> The default batch size is 16 now. On the listening hashtable + SO_REUSEPORT,
> userspace may have one listen sk binding on the same address+port for each
> thread. It is not uncommon to have hundreds of CPU cores now, so it may actually
> need to hit the realloc_batch() path once and then likely will stay at that size
> for the whole hashtable iteration.

Would it be worth using GFP_ATOMIC here so that we can hold onto the
spinlock and guarantee the bucket size doesn't change?

Some alternatives I can imagine are:

1) Loop until iter->end_sk == batch_sks, possibly calling realloc a
couple times. The unbounded loop is a bit worrying; I guess
bpf_iter_udp_batch could "race" if the bucket size keeps growing here.
2) Loop some bounded number of times and return some ERR_PTR(x) if the
loop can't keep up after a few tries so we don't break the invariant
that the batch is always a full snapshot of a bucket.
3) Set some flag in the iterator state, e.g. iter->is_partial,
indicating to the next call to bpf_iter_udp_realloc_batch() that the
last batch was actually partial and that if it can't find any of the
cookies from last time it should start over from the beginning of the
bucket instead of advancing to the next bucket. This may repeat
sockets we've already seen in the worst case, but still better than
skipping them.

I kind of like the GFP_ATOMIC thing if possible.

[1]: https://lore.kernel.org/bpf/c53cee32-02c0-4c5a-a57d-910b12e73afd@linux.dev/

-Jordan

