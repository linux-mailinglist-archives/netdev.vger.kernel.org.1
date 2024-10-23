Return-Path: <netdev+bounces-138289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6A99ACD70
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24D4281D82
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F281C82F1;
	Wed, 23 Oct 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQojqAs3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF911A08C2;
	Wed, 23 Oct 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694106; cv=none; b=nuQyO/8KPmyg+AZl2ygCILjIlUwLJ6bZSh01EuvW5mIV8XQ7Cs18EEB7Y+hVZwXiVLTF3ePeVVFuv/zbTf6fewgpFmgKjFgX6pdO/ZBL8iKLK28EfMbDqSaPa0+C3acWHEiMuw4kqXdwQ8HYD0v19thOpOEdDzrX8IJfQAfXOP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694106; c=relaxed/simple;
	bh=bmjGsHMXAeX5XcBGgjerSHve5jjSHl0wCLRdNvyfgBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QThHoRm6N4Vv5iAC/d1zEJT2SzyfRbaheYraUeAS/dESll47imhwFShlYgLtPixXfu6aQCNRc4w8uCAKSqTgCPRtwKK5VGOEJ23VopspYB1LzNwQgTrZ0P35SMekHwGUTLNClU/H99rJdL8SWLguCob6YHXIG1cyb3HsVXHoOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQojqAs3; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cc2ea27a50so8520476d6.0;
        Wed, 23 Oct 2024 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729694103; x=1730298903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkMJyYR7c7SG8wgO3Jx2FRRIafLBQFGXDU9zueI2iKI=;
        b=bQojqAs3bLiEM/H1henPCE1cRezKseG0b30o8/vvbUYsW6NfB9xyWtfBlNcM29gOQu
         CDd+n6KUzAvdHMdS/knsMFcjKh9Wpb4SGPI1tZOMkmvP+IpIU5JPBifcEiJiaFboPxq8
         yhcAoUY6cR8mY2y9fL0DtHydHnzqnheh6kp1ulc0VVHjWzEUD+VIn7E5/PPMIAroWZXl
         t6Sw/fcWGRmQ9O645jqvj9zymKXv4Pnyy5zlhT2/q049nQZcwliebKLmoiUBsiUQtCpS
         wX4NKxOX4Vw9l69bIgHUJUdE0NIkBgJ3TCJTjZ9Jh9Nugg4zU6KBEEgCDL8BnQmLzOjc
         avZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729694103; x=1730298903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkMJyYR7c7SG8wgO3Jx2FRRIafLBQFGXDU9zueI2iKI=;
        b=RxxTTFXxsMgomgKUPhJ5yryfnCHj9zB4/Ax9uOLmyt+Qr9jhmqLMIYBFnjAOicUDt2
         1HAtBXv1Zkpxy15gM5sePTssNaYzFuNW6EvlSFvLq0Xzmp2+p0kBS2BFJFgQe9MnE6Bz
         xYD3SK5KD+5pdpfUfwIW9VpubESke6i8qkJWEeUhJ72aFoEK8YtCUUJhG+gaFXh67I+J
         oUipvaPMGm94FtS7Zicjw3B93dWIxGxhxVQFzca4/aXkPZEh0sEb4B1wHMuSqfntivI1
         hOIbJ3hi4UN/lR2e9cUanuvaxtIuPdzPEX3BfywYD+16LE3Qwr9qn8JcU/XIalEaJu98
         hUmA==
X-Forwarded-Encrypted: i=1; AJvYcCU7m/mLAMzqELOYaUTZjJLy9Xt9vQcBAuxqF7wgD6u1d+mbCU6UjCou2MPLUXIOU2/9ElE16aFkQPUDD5ixXzpIOLg=@vger.kernel.org, AJvYcCXZ4IR3Hcr70hawAWISMxkk6fECLvQjeqMo1j8ZTqypVik2ujRD3Mt8itmP6GbUu7HVfFJXo5Hd@vger.kernel.org
X-Gm-Message-State: AOJu0YwOijDwWvP5wmkYj4Re0RfGj0C7/VdAhDk/YnNeJWjnuPIL8eJA
	0zbRU9rS2MdjDyTBN49H25NyN/zrdhcxS4rqQPZ9hoZuFW62B3QaQ7+OInZ2Q4S8d/JLg83UZ9d
	Ngwjuo9kOTmHqdznPtG3S5bnTmNo=
X-Google-Smtp-Source: AGHT+IEyMrVpeyVjamwXzDGlQ4tJiXt8MSGfV65lvALJbuOn4a2yF71mGGylnET4KICL9tqp9PVZOFaNDt1jIXyumU8=
X-Received: by 2002:a05:6214:416:b0:6cb:ee9c:7045 with SMTP id
 6a1803df08f44-6ce2178fee0mr134017996d6.2.1729694103589; Wed, 23 Oct 2024
 07:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023123212.15908-1-laoar.shao@gmail.com> <CANn89iJuShCmidCi_ZkYABtmscwbVjhuDta1MS5LxV_4H9tKOA@mail.gmail.com>
In-Reply-To: <CANn89iJuShCmidCi_ZkYABtmscwbVjhuDta1MS5LxV_4H9tKOA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 23 Oct 2024 22:34:27 +0800
Message-ID: <CALOAHbDk48363Bs3OyXVw-PpTLc08-+MEo4bq9kXq1EWtyh24g@mail.gmail.com>
Subject: Re: [PATCH] net: Add tcp_drop_reason tracepoint
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 9:01=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Oct 23, 2024 at 2:33=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > We previously hooked the tcp_drop_reason() function using BPF to monito=
r
> > TCP drop reasons. However, after upgrading our compiler from GCC 9 to G=
CC
> > 11, tcp_drop_reason() is now inlined, preventing us from hooking into i=
t.
> > To address this, it would be beneficial to introduce a dedicated tracep=
oint
> > for monitoring.
>
> This patch would require changes in user space tracers.
> I am surprised no one came up with a noinline variant.
>
> __bpf_kfunc is using
>
> #define __bpf_kfunc __used __retain noinline
>
> I would rather not have include/trace/events/tcp.h becoming the
> biggest file in TCP stack...

I=E2=80=99d prefer not to introduce a new tracepoint if we can easily hook =
it
with BPF. Does the following change look good to you?

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 092456b8f8af..ebea844cc974 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4720,7 +4720,7 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
        return res;
 }

-static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
+noinline static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
                            enum skb_drop_reason reason)
 {
        sk_drops_add(sk, skb);




--
Regards
Yafang

