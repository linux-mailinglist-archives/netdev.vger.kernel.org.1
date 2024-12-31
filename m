Return-Path: <netdev+bounces-154622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F0C9FEE54
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 10:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB91882B7B
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE5F18E056;
	Tue, 31 Dec 2024 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7tse4mo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295FF18893C
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735637184; cv=none; b=YPuJUvtZCZsKVnA1EXRQpEZr9fyYoK2jcj+QVj3mVhcmfwt3EX35sfJweTmvEiCipq5LkwqDXIq4DkFPavX6ZCXt+XIjo6Pjgs5KdG3GOazqLpU33NPiZqWF4CW7imgMTPFcAw2Uigv5dTrSOFu0sxGbE3SR0sEcs2nYPu3UtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735637184; c=relaxed/simple;
	bh=ywfmuqBmXRPqF0Q7AOsbWBgoEgRiXpFq7xv1uMDz3lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1PetpRUHlsHzzCBxCNN+IQ0xBA/pWCNtPKWQbBAu3wVoL8yw+HG6bKH854qLaLNDHb8LCbtCkuphUy0ZEX0XTp+icQkzeUmQWC46ufSULaHoUYsaHySxcPiStN+UJv0HsBqqkDlfWXM9Tukiu6U8aB7iIKTXMHZ8mgg56QoSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7tse4mo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so14079266a12.1
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 01:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735637181; x=1736241981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5SXkBAsp8F9VQm+SK8XeFii/r51RJYtN2Lc7kbZ254=;
        b=j7tse4moYXiUoHYHaBOq4f8TX+kEgt3YbygI8Fh9xCczfvh/9rZEYLd6euPl6zcBt7
         WrIi7drh81+eVtjLQ7UBfC72T8RP0vn+5KR+F5HJcnbHyg0B+CEP2x+5jvn71Wy1H1t6
         irrGOTGaCMT0ROvy6l4LccjjC+PFzzsODwNAkDlM+tUBMfmz5vMkO3X7uiktqrr4+uOR
         gG+fvT5ps/txu9O1r7TByMgatCarAapIIMxlkNK+51A/SSh3eajPUn5u5wfuwkAX0C3A
         G10CZMXDkJIgpvkUO6E470LRHudtfHtu/QfM1RhDOR2mY+plQot29tQrOOTewv6B0HV6
         eSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735637181; x=1736241981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5SXkBAsp8F9VQm+SK8XeFii/r51RJYtN2Lc7kbZ254=;
        b=wUWs7Te3HQxQM8GLJb//SpHKLfaaHuGKVnv7/3G8a2axipfgfEATHAfYDluU33zFv4
         H+2MV2kg4WioFZCkGyD6m4dELGP76F+Aay0Z2XirAPkTZDgzh18U/T7ibVo1U4bGZBdQ
         ZioDlUY2wZknQvJZ9ifM1EBMbpsvHkpbFxH14LviJ9ueP33N5JgvYxd4RNM85KdXB6XO
         qByWeRd57bg16lBTSr4DQa+e8qrIuelO0Lmb1M3x8C0sVIrOYS65snS2dEJ/T5v+SI8T
         l4jv3YfW81lsssKP3guH3+PcWyXdVpHu1OR2gokcf7fHgLC4E28pNVxzCq9bG7lCo30I
         NjGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTHEQFCLK8dGPW3CUsJyqChWq4CfbeaInT4FE5es7AZ+CmieH5QgEloctmvbPkG46eSTyVVqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybZS532vHBDHTjydgmrYRgaRrntHwkP+YvrFt+lKY9KWzSdWDN
	VcaYaG9VVkoWVdSpAE2xTLN7LWOt1/Vz+XJlNwV5YTioehCGke7bhwSC15M+l1d8vnZPtZBSbTK
	mqxKwm9+cZvZbS96EHiXyOmGHQ6DLgxwH8YdR
X-Gm-Gg: ASbGncsTPHwV05rAajwkgELi/eO4HJweY2sLGuLJ3wnAoIX+1XGNOyxq1wC7Lvg74UB
	pSaDe0dBInfgSeAwqt6BExJ/L09DwbyeJx9XW
X-Google-Smtp-Source: AGHT+IEbOs5TVSlh5kiCq2cQ8aj1KD8xP1fK7v0bA5f+Jylbm4FmGScfUsHnEwmd1OD2CIN32IlRIeFp7xb5rCxtl+E=
X-Received: by 2002:a05:6402:210f:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d81de1c921mr88324415a12.32.1735637179824; Tue, 31 Dec 2024
 01:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231055207.9208-1-laoar.shao@gmail.com>
In-Reply-To: <20241231055207.9208-1-laoar.shao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Dec 2024 10:26:08 +0100
Message-ID: <CANn89iL2qZwc7YQLFC8FQzrn_doD4o13+Bk-0+63aGEFFo_7xA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: Define tcp_listendrop() as noinline
To: Yafang Shao <laoar.shao@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 6:52=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> The LINUX_MIB_LISTENDROPS counter can be incremented for several reasons,
> such as:
> - A full SYN backlog queue
> - SYN flood attacks
> - Memory exhaustion
> - Other resource constraints
>
> Recently, one of our services experienced frequent ListenDrops. While
> attempting to trace the root cause, we discovered that tracing the functi=
on
> tcp_listendrop() was not straightforward because it is currently inlined.
> To overcome this, we had to create a livepatch that defined a non-inlined
> version of the function, which we then traced using BPF programs.
>
>   $ grep tcp_listendrop /proc/kallsyms
>   ffffffffc093fba0 t tcp_listendrop_x     [livepatch_tmp]
>
> Through this process, we eventually determined that the ListenDrops were
> caused by SYN attacks.
>
> Since tcp_listendrop() is not part of the critical path, defining it as
> noinline would make it significantly easier to trace and diagnose issues
> without requiring workarounds such as livepatching. This function can be
> used by kernel modules like smc, so export it with EXPORT_SYMBOL_GPL().
>
> After that change, the result is as follows,
>
>   $ grep tcp_listendrop /proc/kallsyms
>   ffffffffb718eaa0 T __pfx_tcp_listendrop
>   ffffffffb718eab0 T tcp_listendrop
>   ffffffffb7e636b8 r __ksymtab_tcp_listendrop
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> --

Are we going to accept one patch at a time to un-inline all TCP
related functions in the kernel ?

My understanding is that current tools work fine. You may need to upgrade y=
ours.

# perf probe -a tcp_listendrop
Added new events:
  probe:tcp_listendrop (on tcp_listendrop)
  probe:tcp_listendrop (on tcp_listendrop)
  probe:tcp_listendrop (on tcp_listendrop)
  probe:tcp_listendrop (on tcp_listendrop)
  probe:tcp_listendrop (on tcp_listendrop)
  probe:tcp_listendrop (on tcp_listendrop)
  probe:tcp_listendrop (on tcp_listendrop)
  probe:tcp_listendrop (on tcp_listendrop)

You can now use it in all perf tools, such as:

perf record -e probe:tcp_listendrop -aR sleep 1

