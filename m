Return-Path: <netdev+bounces-122195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2086B960504
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD37280A49
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75571991C8;
	Tue, 27 Aug 2024 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvleFXTk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE2158DD0;
	Tue, 27 Aug 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749194; cv=none; b=c1kZflU0W+NMbg/CHtx+HpUbt9ZiFE+lVXu7eZFndorC5rGDQc6XvrCVy12BFP8/EtIHuSUz44DRjRwC/blYf/UrxGIRSc833e89w4N6fS1HlTRVMwzyStZVjtXrqxHKoxmR0+UAkQVpfNVLGasIIHtZeDqwX2fkZWEByaj8c/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749194; c=relaxed/simple;
	bh=+TT0uroKW11xXpPExGJDmmlkdjN9uj2GaHpKRvERy/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNuajCe65j3Uiv2oaH91BiVt7c4klihi7rom3RLgo2GWMUZe7jiDeLl62AlSkWcLjvxKhP4X9i1pLuPaPi4pq2qCwyTu9uUo+yaFzBXQV6SC+3zmlx8wJndhDtf6dWsEV/LjXTUyklQtTItkb5oZRcXJbQsTnFWBpJuVnB2snbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvleFXTk; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7cd90dbf42fso119971a12.3;
        Tue, 27 Aug 2024 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724749192; x=1725353992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X6rwei4gMShKEung6RR21p/awqx+Ne1vZ7IkcdbMxo=;
        b=UvleFXTkUXh+wZbE34sKYUxvOboQfWJO6Z2tqxLjgTUijZ74j6vKaVed0Gm1890AXQ
         bTLe5FRsqVYjqYZ384NTvatqMr89tszPu6ONBcO338Qj/pncV9a88lKWBs1dILzGmBSC
         w3KJgfkwhsm2QR+Ou5pv3N8zcv1ts20zXH9ViXZx5SJOoiNbRkRnW8t/oAPtjALfbqEB
         1SVFEwhtrG0xjkgbKJRxwHGT7v3ybzTG6/pvpHNDIvKZMol5+3yfhXuIqiPJIwTVMT6I
         G/XYOvOEe5VlUALVWGUlS3wKPmE6IOkWTJxvGIJQ47FNEByR2cFWwKPhZlfEmcO2MJbw
         IpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724749192; x=1725353992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+X6rwei4gMShKEung6RR21p/awqx+Ne1vZ7IkcdbMxo=;
        b=ifAab1skhStSFwfz+my679cpT4w3QjMVw71CJOY1JjpceG2eqmjJz/6KTby8rxOa3g
         RjNN0yrouBvxe3Rvn1TaF74mSRek4kFt2BbU4ZJOUZ1OLQDQnI0T6kfl56h7Tkw5HsHV
         WpmTExRDbBBhfgZ3UgceoPbpEYE6rmLHShon1pz4XRrZDCOvCpbGCmEhiyvp48D93f/C
         sLtsU+gd3xVprdfol2HySqMRBb0OuJ9XiaTNscdk9dQqKrexd8ln0hvHd5M0ZU7m83nO
         dSxsU3+zBdHYg1PER1HluqjxpDWA8anBBoIASZ9t1l5t3hA8qtvfAGLvSlTv9F3qN32e
         VcZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4PtXqjDXQOK63ZOljLu7qKcewAOZ0zTiN5TlIhtKURGqI9h8j+qUvkIBVWkpbY9DWhMHxzkmg@vger.kernel.org, AJvYcCXCBcwdFXrMj4nJiHqjD7S5Cl7PSuk7G3BrMSx6iJ0VYTeh7NzRPNYDdiSBgEzBXhpCgVVDWxRRUFZkdrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb05TwTnozV9kbRpsbIxGhRcymP7tC3Ubb/cPWgT2BbiW5ArPx
	Bvyr5f2joMEciSeMVBa2OQfX3uGM+eVRrx0faORNEYlrYG2Tvm1/
X-Google-Smtp-Source: AGHT+IGsrnLoe604GlGw16hpNDIHaKK6u81wwk4WYrqqcJgeFsJVrqpiwiFwpO4tOnMDhGDj3nOCZw==
X-Received: by 2002:a05:6a00:23c2:b0:710:51e4:51f0 with SMTP id d2e1a72fcca58-714458c8c51mr9210519b3a.4.1724749192455;
        Tue, 27 Aug 2024 01:59:52 -0700 (PDT)
Received: from localhost.localdomain ([49.0.197.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342fc87asm8423217b3a.142.2024.08.27.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:59:52 -0700 (PDT)
From: sunyiqi <sunyiqixm@gmail.com>
To: kerneljasonxing@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sunyiqixm@gmail.com
Subject: Re: Re: [PATCH] net: do not release sk in sk_wait_event
Date: Tue, 27 Aug 2024 16:59:32 +0800
Message-Id: <20240827085932.905688-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAL+tcoBw1CKpPDkbiNGrrUFiqBEhHHx9vWhqfpfV1bbu3F1i5A@mail.gmail.com>
References: <CAL+tcoBw1CKpPDkbiNGrrUFiqBEhHHx9vWhqfpfV1bbu3F1i5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 15 Aug 2024 19:14:12 Jason Xing <kerneljasonxing@gmail.com> wrote:
> On Thu, Aug 15, 2024 at 5:50 PM sunyiqi <sunyiqixm@gmail.com> wrote:
> >
> > When investigating the kcm socket UAF which is also found by syzbot,
> > I found that the root cause of this problem is actually in
> > sk_wait_event.
> >
> > In sk_wait_event, sk is released and relocked and called by
> > sk_stream_wait_memory. Protocols like tcp, kcm, etc., called it in some
> > ops function like *sendmsg which will lock the sk at the beginning.
> > But sk_stream_wait_memory releases sk unexpectedly and destroy
> > the thread safety. Finally it causes the kcm sk UAF.
> >
> > If at the time when a thread(thread A) calls sk_stream_wait_memory
> > and the other thread(thread B) is waiting for lock in lock_sock,
> > thread B will successfully get the sk lock as thread A release sk lock
> > in sk_wait_event.
> >
> > The thread B may change the sk which is not thread A expecting.
> >
> > As a result, it will lead kernel to the unexpected behavior. Just like
> > the kcm sk UAF, which is actually cause by sk_wait_event in
> > sk_stream_wait_memory.
> >
> > Previous commit d9dc8b0f8b4e ("net: fix sleeping for sk_wait_event()")
> > in 2016 seems do not solved this problem. Is it necessary to release
> > sock in sk_wait_event? Or just delete it to make the protocol ops
> > thread-secure.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Link: https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
> > Signed-off-by: sunyiqi <sunyiqixm@gmail.com>
> > ---
> >  include/net/sock.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index cce23ac4d514..08d3b204b019 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1145,7 +1145,6 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
> >
> >  #define sk_wait_event(__sk, __timeo, __condition, __wait)              \
> >         ({      int __rc, __dis = __sk->sk_disconnects;                 \
> > -               release_sock(__sk);                                     \
> >                 __rc = __condition;                                     \
> >                 if (!__rc) {                                            \
> >                         *(__timeo) = wait_woken(__wait,                 \
> > @@ -1153,7 +1152,6 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
> >                                                 *(__timeo));            \
> >                 }                                                       \
> >                 sched_annotate_sleep();                                 \
> > -               lock_sock(__sk);                                        \
> 
> Are you sure that you want the socket lock to be held possibly for a
> really long time even if it has to wait for the available memory,
> which means, during this period, other threads trying to access the
> lock will be blocked?
> 
> Thanks,
> Jason

You're correct. Sorry for my poor knowledge of kernel. But I think kcm socket
UAF vulnerability is not the last one which use kernel API correctly(?) but
result in vulnerability.

Though the kcm developer can fix(and already fixed) this issue by adding more
lock in kcm sock, but, just the same question, what's the root cause of this
issue? Is kcm socket code or sk_wait_event release the sock?

Thanks,
Yiqi Sun

