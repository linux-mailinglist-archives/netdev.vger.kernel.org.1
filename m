Return-Path: <netdev+bounces-176214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ED7A695D8
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1DD1896BB6
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981B205AA4;
	Wed, 19 Mar 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZudocCrd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D20204C3A
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403883; cv=none; b=qtJ59KuAkiDuaGAME0tRQgl+1JpGpkkgagh5sgtogQg0MEVA+pJpDZZMagrFsyORgdwILOM/jUZvoCTP8YyyjtAwABryXTJnV5zrMG3qXjZINelS+qporLpxc4TT0rhW9WM+ucbwaKkfRJwnXjSYZJpuqEEIkQzEGm0JcLs8pVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403883; c=relaxed/simple;
	bh=xHwQmrmdOuIs6PYCDdbIWFozyweG4V+76so2ScsTFCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpDLg73q91Bh7BqorusKk51uw7qtLSfg/V4BS+uFI3b5NbRmfCRceu4SoKSeeJg9fRemSjormUAgQUKcs1uHSIHU41PbReSe1TEbpmPq+mi7xoiQT+W7BQ872UFE75x3o5N5yJ7tbhFHm7A9ltMi3qLJirq7H0DvalWcufW3kp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZudocCrd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2264aefc45dso29626735ad.0
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742403880; x=1743008680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfTEntrgNFTQ+7NianD/ZW1MCI2896IIxNfsoj927aQ=;
        b=ZudocCrdeIxz5yixaOfaARaArGk6VJ9VnJhm4x+qCMl9abzTplglc3CNQDuUm/bqGF
         9ehjSIW8WA0WcMRxOPNdi6feCFVcC61ljTLsdxo+cemNxs1+WgVGwv6ClYl0X3ep9Tgg
         P4ZPmmXZpGPh5M+6Sd2h2CtyOmsg0IJC9jNMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403880; x=1743008680;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfTEntrgNFTQ+7NianD/ZW1MCI2896IIxNfsoj927aQ=;
        b=YdWCPcSX3pZLSb1LL22r12k+sOZv6B04g/BT8lAnF/0U0neaVJ1XEw1w38Uex1WN68
         zqamxx0REKkKi6sXkApu8NjAU4+x8dqWXfqkKGQeJS8mqCAIcDcHPTLQFQZqHlu+QPw6
         B0Ka6iTxSMPgZ30wFCDxo4uc7l4ehtUfk0nXMKlMAI8mp9VYr70Vlb6MeIk7bdMQrBtJ
         J9LX2bP+3KAF3xFJqtB8u7xtra/94ojF8QL7865JqC5jqzsvh6NXdajqEKekLeChdHKC
         oh7HavshyUGfqE58rxM9cFlcJwXh2H84BlhtlKuwMn3zlB+NOfMewXcDi6oSVK8S2Nfp
         ATQg==
X-Forwarded-Encrypted: i=1; AJvYcCVVm2hfBfOVmI6yo7zpQBe+UAzkCUC4Y/j+5t5SeV8ai70PjW9wELmjWPRQAw8yf0YEvahkWHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PjcRlLNOPcxy8L+PwkpVVFk98/z811gGjAyxxlGMWF5WpbVO
	DmH3V+W/fCRqPt4MSbLwHgPNCEzflnKmU7cI5jdB0u9hNyHtZ7G420FErZifCZw=
X-Gm-Gg: ASbGncsArM5A62/6+KYnJHhS99PyYgTzgdQMfWNINXZFmydbJ1gEPTWXzNrZNDJFpgg
	ydsTnynOoZbOi0f/iL0OoD6cDU4VDB0hkrLncfyXQHqQKiKDi8AgXH3LvanAmynOZTsW3Blg9Xo
	6c2RMzR+wcJBecVgkoG3DUl+rv7QmSQRkc3pTBkk/CnSb77BhwzdTMVG7NZnDoRP/aCWOrj5+O6
	++9F8LGE/jhTDEou3lUR1YKloFXEA3bWC5P4Lm5SfOAnL0p1Wd9NrTrLn7uYL83cT1xGWD/hOPn
	7YBsfGmtdUynZVdXu/G6BYq3qDUT3SWBK+UMfecPlGIvt/lNAQ+3MmO/p3pQUrW71QgmUL7Btk/
	f7ZwNqsIiSqmZGT6zVsNEChLndIw=
X-Google-Smtp-Source: AGHT+IEueksUXBjAKQcNj3VhWfV1THpBLxF7hLqyCecDq7YAGddkNADabgO+qWlOA2ka1zPDDwfS9Q==
X-Received: by 2002:a17:902:d48c:b0:224:1074:63a2 with SMTP id d9443c01a7336-2265eec4454mr1110355ad.43.1742403880606;
        Wed, 19 Mar 2025 10:04:40 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68885a1sm117239265ad.13.2025.03.19.10.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:04:40 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:04:36 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org>
 <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>

On Wed, Mar 19, 2025 at 10:07:27AM -0600, Jens Axboe wrote:
> On 3/19/25 9:32 AM, Joe Damato wrote:
> > On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
> >> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
> >>> One way to fix this is to add zerocopy notifications to sendfile similar
> >>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
> >>> extensive work done by Pavel [1].
> >>
> >> What is a "zerocopy notification" 
> > 
> > See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> > sendmsg and passes MSG_ZEROCOPY a completion notification is added
> > to the error queue. The user app can poll for these to find out when
> > the TX has completed and the buffer it passed to the kernel can be
> > overwritten.
> > 
> > My series provides the same functionality via splice and sendfile2.
> > 
> > [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
> > 
> >> and why aren't you simply plugging this into io_uring and generate
> >> a CQE so that it works like all other asynchronous operations?
> > 
> > I linked to the iouring work that Pavel did in the cover letter.
> > Please take a look.
> > 
> > That work refactored the internals of how zerocopy completion
> > notifications are wired up, allowing other pieces of code to use the
> > same infrastructure and extend it, if needed.
> > 
> > My series is using the same internals that iouring (and others) use
> > to generate zerocopy completion notifications. Unlike iouring,
> > though, I don't need a fully customized implementation with a new
> > user API for harvesting completion events; I can use the existing
> > mechanism already in the kernel that user apps already use for
> > sendmsg (the error queue, as explained above and in the
> > MSG_ZEROCOPY documentation).
> 
> The error queue is arguably a work-around for _not_ having a delivery
> mechanism that works with a sync syscall in the first place. The main
> question here imho would be "why add a whole new syscall etc when
> there's already an existing way to do accomplish this, with
> free-to-reuse notifications". If the answer is "because splice", then it
> would seem saner to plumb up those bits only. Would be much simpler
> too...

I may be misunderstanding your comment, but my response would be:

  There are existing apps which use sendfile today unsafely and
  it would be very nice to have a safe sendfile equivalent. Converting
  existing apps to using iouring (if I understood your suggestion?)
  would be significantly more work compared to calling sendfile2 and
  adding code to check the error queue.

I would also argue that there are likely user apps out there that
use both sendmsg MSG_ZEROCOPY for certain writes (for data in
memory) and also use sendfile (for data on disk). One example would
be a reverse proxy that might write HTTP headers to clients via
sendmsg but transmit the response body with sendfile.

For those apps, the code to check the error queue already exists for
sendmsg + MSG_ZEROCOPY, so swapping in sendfile2 seems like an easy
way to ensure safe sendfile usage.

As far as the bit about plumbing only the splice bits, sorry if I'm
being dense here, do you mean plumbing the error queue through to
splice only and dropping sendfile2?

That is an option. Then the apps currently using sendfile could use
splice instead and get completion notifications on the error queue.
That would probably work and be less work than rewriting to use
iouring, but probably a bit more work than using a new syscall.

Thanks for taking a look and responding.

