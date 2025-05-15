Return-Path: <netdev+bounces-190862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F50AB922F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41FE163C5B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513AD286411;
	Thu, 15 May 2025 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfsPtkaf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11D2192EB
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747346883; cv=none; b=U3krVflWtgv8lYRkw//UMbWA3Bi6HB688J3eJJggsI2SEVpiC6buo9hQY8I7jZ7Xr7ZXpu1cNcc3vn6uYEpI5qXMWdyP6uLsCbAoawcbqS9HISruJDIaSSkc2FuMM7FRfAMfdfthWVLnDRm0wa4yDohV1t4zVhwzoPZQ1Phd8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747346883; c=relaxed/simple;
	bh=b0EIs8RonCskQxE6KbKdGihhSDFy/h1gDx/LWTT6hx8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Uve/oCCOJ1PR+6W+P3N1lOS4rGs7L0lx804wm8laiP2hTQDFMfJRK87qwV+KkcqW9Q1n+ItB1yUsA+oFAiWsyI8Rwh7TOY5PeY5KpAeLSlTg7AM+FzKJij4I6P8XYXxxEkdeZ04L4aXkKd9JJ7gCxp6vOyKVzN3r2u5WkbVURbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfsPtkaf; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f6e6ec07f0so15048846d6.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747346880; x=1747951680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Acewb9kcN4wU6vURmVRGa+lOwIlfiouTxd9JhIzLaPE=;
        b=jfsPtkafz9mIkxUv6ANBvW2z5fUl3Kk4ZEDmRR0qgZ0OlCcL+S/SWqvCppUCY1esdj
         ssNNDA39mJfjlSwvYsPm+Vf/uU/5J1a/OpB27TxYw7oMTfSDqJwJkARozkbIeJ2zA/K+
         fGcWbXbuUuKH6z/FXl/JsW3KDB5u2TNL5guCiiC36ecvjs+8qvMunPY0oDSC84KoImAQ
         KuLDM5cTObyuDGrv3jl4xWm/9yj8BR3ef1C5ZwF1NzaeR5cBSgwB7Fd/n7Q72BlEDePb
         OX+DzTgk7Ae0UlstzI6YEpT5xR5SYhpACTUc62R1udo02PxaQS/TExo6/CJozKLmrni4
         nB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747346880; x=1747951680;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Acewb9kcN4wU6vURmVRGa+lOwIlfiouTxd9JhIzLaPE=;
        b=KHnov3g030hITeF6L3Kbewd1As7AmyCw/ixQiFm4SXYGJl6/3sYJm+zYyx/J/XeAiM
         TODvk5AcXVCItjMyPxn37Fx9SinLHYBc0n67L4dvMYLu5pSfIQZP4s38UahGmLxs9Uf5
         P+T/rOcUU7dtrcNuOID1noocb/RxS2/PYTbwJF7SllB5T0ylTYVyJtxzCvOVodSkVdPE
         Sasgy+jHZD4ucPkh2ojROou5AisceGE07Y3nNfJvba4eeI9mDt43Khs4Iz3C+NlrNYyM
         SpD1UYYaMqIxPhLICAGMyy1yXYCIR5B1iU8Nl0xOenPGFVGssczdzPGHS+sC9EcnNHck
         Eoxw==
X-Forwarded-Encrypted: i=1; AJvYcCUzQaQHbMrX26crjB8925r6DdljVAOP4n5xTnelESOQQlX3B5uSgMY0OZH72oCRfYWeMRHx/Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/4vKzCWA0t7/5M+V6CFzVQ2whSvQ7ThnGBp90265HIY1w6PI
	NmzvCxd2/raKI4OApdOViqQj5ej7z3p3hAR9/Qzamh75fcUDNST4hK+X
X-Gm-Gg: ASbGncv+FPq8BQm+HMc+3LIjWxXfoTKHVD9djmvZeSfuL7g6Rgn20WcmpHEXu74c10p
	vbn1HHGvIfHkVzJzQcXx6QS8AQinTJoZGDIUOmmg8LC2chcl0dLk+OXvh5pDt5fs4LPpP6RnQmv
	mP0UVrpeNg/e2AdPZUXfq3/QhSLk26S9pO3D0jAi7AdzsO9uHkClmLEhWWudXV1qhLgBVB+8W05
	KbfLvvwqxiRuTtMBNXd4VD9NQkG3IywLdsKgwuNCiXpUALfhAwa7GuHKxatWDqeMnbvx8bPLYTQ
	jnkIsG0BAPpDNCr5ZTyIUjxcbjwuZVGFk/lqppWgUHEK3zg46OBbX7m5lO4dbRGp0UYnc2ecMRF
	/N8Itc80YToS6FWkBzsFtOfo=
X-Google-Smtp-Source: AGHT+IGctDJuSAxFCFwxV4GWRiLtZq+MDCcoo6zlhShKUksdIqTpFEgqdgEtEBnW9W69molKhOxkfQ==
X-Received: by 2002:ad4:5b82:0:b0:6f5:41b8:47ed with SMTP id 6a1803df08f44-6f8b0726bbcmr23994546d6.0.1747346880278;
        Thu, 15 May 2025 15:08:00 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b08ac386sm4534526d6.39.2025.05.15.15.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 15:07:59 -0700 (PDT)
Date: Thu, 15 May 2025 18:07:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: brauner@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 kuni1840@gmail.com, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com
Message-ID: <682665bf7cebc_26df0c294aa@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250515203540.85511-1-kuniyu@amazon.com>
References: <682635fea3015_25ebe52945d@willemb.c.googlers.com.notmuch>
 <20250515203540.85511-1-kuniyu@amazon.com>
Subject: Re: [PATCH v3 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC}
 to struct sock.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Thu, 15 May 2025 14:44:14 -0400
> > Kuniyuki Iwashima wrote:
> > > As explained in the next patch, SO_PASSRIGHTS would have a problem
> > > if we assigned a corresponding bit to socket->flags, so it must be
> > > managed in struct sock.
> > > 
> > > Mixing socket->flags and sk->sk_flags for similar options will look
> > > confusing, and sk->sk_flags does not have enough space on 32bit system.
> > > 
> > > Also, as mentioned in commit 16e572626961 ("af_unix: dont send
> > > SCM_CREDENTIALS by default"), SOCK_PASSCRED and SOCK_PASSPID handling
> > > is known to be slow, and managing the flags in struct socket cannot
> > > avoid that for embryo sockets.
> > > 
> > > Let's move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
> > > 
> > > While at it, other SOCK_XXX flags in net.h are grouped as enum.
> > > 
> > > Note that assign_bit() was atomic, so the writer side is moved down
> > > after lock_sock() in setsockopt(), but the bit is only read once
> > > in sendmsg() and recvmsg(), so lock_sock() is not needed there.
> > 
> > Because the socket lock is already held there?
> 
> No, for example, scm_recv_unix() is called without lock_sock(),
> but it's okay because reading a single bit is always a matter
> of timing, when to snapshot the flag, (unless there is another
> dependency or the bit is read more than once).
> 
> With this, write happens before/after the if block:
> 
>                                <-- write could happen here
>   lock_sock()
>   if (sk->sk_scm_credentials) {
>     do something
>   }
>   lock_unlock()
>                                <-- or here (not related to logic)
> 
> but this is same without lock_sock() if the bit is read only
> once:
> 
>                                <-- write could happen here
>   if (sk->sk_scm_credentials) {
>     do something               <-- or here (not related to logic)
>   }
>                                <-- or here (not related to logic)
> 
> So for SOCK_PASSXXX bits, lock_sock() prevents data-race
> between writers as you pointed out, but it does nothing
> for readers.

Essentially you're saying that a single bit read is a natural
word read, so atomic anyway? I.e., yes this is a data race, safe.
Will KCSAN report on the race regardless?

All other single bit cases in sk_getsockopt use sk_flags
and sock_flag, so are not a good existing example. But the single
bit reads in do_tcp_getsockopt do the same. So I guess it's fine.
Indeed constant_test_bit does nothing special either.

Sounds good, thanks.

