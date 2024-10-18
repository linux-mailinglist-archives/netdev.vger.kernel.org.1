Return-Path: <netdev+bounces-136856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120EC9A3436
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CCE281C6B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 05:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0EF17B505;
	Fri, 18 Oct 2024 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6s7q19J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E4915CD74
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229322; cv=none; b=pNX7iQJF70ypWlQce8qJPR4eJoQGo0X375zlKqg1oUF804ynVrn2DPrpnhwkD8nNmxDHuRH4AhJ645i0Ys7WfoC8JzHH1n5rJOMJdCHDBvPhkTCUt9zWEpcwxh0rT3KOJl/nat0CeyUZoZEKgIuHJBqdkayDXKZiwGH2hxcwRWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229322; c=relaxed/simple;
	bh=FUBu0uSe7dtrYqWQgUfWvdaCCPAC4msyF9IgfwxdcFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScSrF5sc15yC4iI/iXwghs0ZRwi9eL8GKYEPfZPdUt87uqTnY2PwEgoAUArDNxUlXiFaN/o7nnHOy9ltTeGBtTNGv+VvRIlffXkaBQcDiIon/gQWRu3SCVbCwIfu0kPvMoR3NR+ZATT/I/kzBjC5c7LaGAofqlIQE4FRavkk1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6s7q19J; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso27960521fa.3
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 22:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729229319; x=1729834119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUBu0uSe7dtrYqWQgUfWvdaCCPAC4msyF9IgfwxdcFU=;
        b=P6s7q19JxJmciH5Dg6MblRq2uBoAuCasH8H1NWE9p5NMwBf1c8ER5OPvh0f9u9XQfh
         8cMoAss8EimRAKxj//oF6+HiZ3KF6757VDZ7x9Bu29k4mGtTqfTEeeDbYeK8wg8NXdYS
         QzMhyQcoOVD9nl6O36pt/hEfwkaXVF3tXPJSrwMFEoYlJctXgAdDW/CQUPCxdxSkoH0l
         uT8fgFI/wEJrs8Yjgl1GnN9T4GBWdh/WPVkcHsTVlVfMpBfFc1L343nBzl0DHnF3ms0H
         Y5rWIPc1HMr2ckLbjQIOemylXHg+EFHhI5d5caL6QzezeMLxBSgA/GF1CT1lA483WMpf
         zV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729229319; x=1729834119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUBu0uSe7dtrYqWQgUfWvdaCCPAC4msyF9IgfwxdcFU=;
        b=n6iAFPUdIlUjnbjtFHOUiU1WRALrxy3CdJhsI9SWLE63GJeS4Gs1vcUpnKyzbSzIbn
         7d42TMRuezntpjTa/8mboyQNbNXzD/JC1/juBwwxN8zxjKDbOc3up+pAH9Q4NGEer/ST
         w+1lQCm4w4WxnPCN0ofCeMWVZfQCz5AbV9SuduvsmmSUKdOoHESQ/3Z0jkHZOOw+nYpD
         5mxHAk6xQMQ7nmVGDqUI/XsAOxCQxgN43jOUoPfmy2QiHptHklL04eJe0pHupR0WZexb
         ODeGnmsD8Mwilr4/7Cpk86yvuEJsUB41jz3/cusupHZPdIsMdOhRhvSWy6RArGYTtYEp
         5p5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOC5PuIa6S8w1t/0lJaBWlcsiYIuxSrTiRDQUBJHxNpk8PTMCAyXXrIFFjT/LEdd3nnAX03q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQA2/k6jqgYkvo+60GXQ8WWZ5Y9OYRtDSkWWmIrD45A2OPrtu
	TBokL6KdZD+YgRr69dlbsY/E9kk1l09faHr7/WplcuC2LHwp02FutC1xvXmTHfz7kNkyghwpBx3
	m/eIlYDFdPtDK40LK+OcIf7vRu/6PQPbvoZJ4
X-Google-Smtp-Source: AGHT+IHFW0M46iTYCmRbTPAVvDQ+/CG88AupRx/LApXaVk5JDq6cn0l9i8Fn9SMcUzYkUpIiWbSsI+izNFRrGa1Kzqw=
X-Received: by 2002:a2e:8ecd:0:b0:2fb:4f8e:efd with SMTP id
 38308e7fff4ca-2fb831ef969mr5355631fa.32.1729229318625; Thu, 17 Oct 2024
 22:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+nYHL_BrPZY1KHiFoC5YRYw0D5_5Gyn8XHxgtAijc7-RiLnBA@mail.gmail.com>
In-Reply-To: <CA+nYHL_BrPZY1KHiFoC5YRYw0D5_5Gyn8XHxgtAijc7-RiLnBA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 07:28:27 +0200
Message-ID: <CANn89iL9KHquUS=bUu1EtEnjhLPOpMZePihf1pejy94i3cPiTw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tipc_udp_send_msg
To: Xia Chu <jiangmo9@gmail.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 7:00=E2=80=AFAM Xia Chu <jiangmo9@gmail.com> wrote:
>
> Hi,
>
> We would like to report the following bug which has been found by our mod=
ified version of syzkaller.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> description: KASAN: use-after-free Read in tipc_udp_send_msg
> affected file: net/tipc/udp_media.c
> kernel version: 4.20.0-rc6
> kernel commit: f5d582777bcb1c7ff19a5a2343f66ea01de401c6
> git tree: upstream
> kernel config: attached
> crash reproducer: attached
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Crash log:
> BUG: KASAN: use-after-free in atomic_read include/asm-generic/atomic-inst=
rumented.h:21 [inline]
> BUG: KASAN: use-after-free in refcount_read include/linux/refcount.h:43 [=
inline]
> BUG: KASAN: use-after-free in skb_unref include/linux/skbuff.h:969 [inlin=
e]
> BUG: KASAN: use-after-free in kfree_skb+0xb1/0x430 net/core/skbuff.c:655
> Read of size 4 at addr ffff88804efd5ba4 by task syz-executor.6/14936
>
> CPU: 0 PID: 14936 Comm: syz-executor.6 Not tainted 4.20.0-rc6+ #1

This is an old version of linux, not supported.

What do you expect from us ?

