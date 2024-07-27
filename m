Return-Path: <netdev+bounces-113380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0CD93E08F
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 20:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5BB281BA7
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18C718309B;
	Sat, 27 Jul 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3ts2yxk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0F17F4F2;
	Sat, 27 Jul 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722105014; cv=none; b=QcuazTReKoAoiA1sFUtEhBYUWtlzv8Ie1f8miV5/3WTkrH2z24YIVJ6vNqStlXoX0UbKPj0xdxaTO6eMdKzwmRY4Lxr8eHs9Oj/XKs8UrJmmiCqIFaWMVGlHRp4aSdzov/m2kC34hGbNaTT6Yb3BxyYpfuAE8vbaog0RYskUq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722105014; c=relaxed/simple;
	bh=D2NayIw+YZ5M3thPrvmQwPrfZUHKh9LHHRYlSF4IZVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4O0Zk6ztHBBgoUEmZEiUusKxpIRPu5lNVt1lvmQgPotwT6MhEZsENy8NVrNRMI9kQhDBRgP8dtRu8PbOj0jZO+p2Vmi6Zmoka+832IZFbPF/hJvSZT2jJ+qdbwo5hKHMnQjN+CamWEiKRme01gQxYcUAgDiaY8DEoEV9aS6nD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3ts2yxk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb576db1c5so1301442a91.1;
        Sat, 27 Jul 2024 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722105013; x=1722709813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e2tIbGkJ5FaHNotzNwzZQOrcMVRMXKevboQ1vZRbHCI=;
        b=e3ts2yxkIm8+jONcaNaUilo3JQidfgIO9EHSA+9XSzbn8a4vhH7cvr/klmi7yoEfrl
         ZEyip1TMSU2qxfvcRmvwuCEFUEa7A48JfiOQAwq1fTs58Qi/7bVGV2iTX2GfNzX/o0rr
         Wwid23kOd+4Fe5N0eEXFVp7rD4pM0w/VQUCSgTuKkUml8R9uFZEKw4H5o9dYF42iOF7H
         kN4SiCvqvmn9BkoW93puub7vLEmxomYp12SaHoqWpF//Dz/EerIwmxkWr+7u02VoQ71m
         ScXvrx2TYrNdSNzI/91iAZ6MnHW2M12VsSINdo5krkkKd57vGj8LrY96XY/tQWD+k2fJ
         hnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722105013; x=1722709813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2tIbGkJ5FaHNotzNwzZQOrcMVRMXKevboQ1vZRbHCI=;
        b=NEt2v3AH9awtMjpT8hPT7wlljb8+A0n2vvir9xm6FI1xUufyJKwo/+jW2HAHasifTj
         4PuwldotAvorRnaqtsUsBj2zPFzeUkm+NybvkhgkbmkqjWsre2Ai0CmXdcwHMwow4JKI
         Z0ovRUY/ktZ/PgvhIM+317xpYu6VDFKWkQkEVjnYWDkmsBSYM/LaSZolxEMLlmqz2Z37
         k2ijHXjZjThs91PfU+Zsq/Xup+jG9nwrc5oTOPtq2q7y8Zii59IRbn/zT+9PWPtpDMpe
         KlPu3CufNlrk1pyduEj1YG7aG+OxdjCtO+dzSYvjvUlSVPmFTGAwRm2Vfo4qgUtpR15Z
         NwOA==
X-Forwarded-Encrypted: i=1; AJvYcCWQB66iqzF2GBeRd7ZMGhHxAacDOQkt4xTEdy3wJeJU2oPHU5k5KHBbz6dRVbdFjOy839oHJ2Y3/nmRqUYMJgbzlFb/79UDzwG5xfU8Ab3qUzgTCREBZN/NLJ5E8F+bm1Xcy0Em
X-Gm-Message-State: AOJu0Ywm0tUH3TY1YGubyvzn0umm5W0wYTpjJPIfKOrk3kEQQZm3DY1X
	acjS7jabL26RhSA/SEBV9m0hAlfI8f+7s0s0WrzV1fd/XKZOW4UxtiWqsNiXJ41/m2Yq/6imumY
	dw56W3zdCEwPC60U3dlMmjrFYyok=
X-Google-Smtp-Source: AGHT+IFyEr0kvwb/7knRP4TFENc52rWZnHuDTR0zpFZ72RAEBTpzzmI4od9i8/ZA53QP/uYmbCHVDMCQe5LTBYf83dk=
X-Received: by 2002:a17:90a:d146:b0:2ca:1c9e:e012 with SMTP id
 98e67ed59e1d1-2cf7e09cda9mr2904890a91.6.1722105012623; Sat, 27 Jul 2024
 11:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-tcp-ao-static-branch-rcu-v1-1-021d009beebf@gmail.com> <20240726193403.1b15a2af@kernel.org>
In-Reply-To: <20240726193403.1b15a2af@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 27 Jul 2024 19:30:05 +0100
Message-ID: <CAJwJo6bAAFv+02J7W_Yz0=LZUrvgpx=e6dFmQbWoy7AFKDbj-Q@mail.gmail.com>
Subject: Re: [PATCH net] net/tcp: Disable TCP-AO static key after RCU grace period
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Sat, 27 Jul 2024 at 03:34, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 25 Jul 2024 06:00:02 +0100 Dmitry Safonov via B4 Relay wrote:
> > @@ -290,9 +298,7 @@ void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
> >                       atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
> >               call_rcu(&key->rcu, tcp_ao_key_free_rcu);
> >       }
> > -
> > -     kfree_rcu(ao, rcu);
> > -     static_branch_slow_dec_deferred(&tcp_ao_needed);
> > +     call_rcu(&ao->rcu, tcp_ao_info_free_rcu);
>
> Maybe free the keys inside tcp_ao_info_free_rcu, too?
> IIUC you're saying that new sock is still looking at this ao under RCU
> protection - messing with the key list feels a tiny bit odd since the
> object is technically "live" until the end of the RCU grace period.

Yeah, I think that's possible.
Looking at it now, I think it also needs
: rcu_assign_pointer(tp->ao_info, NULL)
above, rather than a plain null-assign.

Will fix and send v2.

Thanks,
             Dmitry

