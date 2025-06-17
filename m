Return-Path: <netdev+bounces-198793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC1EADDD8F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A8A19400F0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18DD1E8335;
	Tue, 17 Jun 2025 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDn1j1Y0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB228FFE1
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194140; cv=none; b=ZmtPgYhWcdgLyqSFyQ1UO9AETONxWWi4OvmFIO0zkA6kjDy7A0rhK7+opw6Qj9Hs3Dg3HZDmnEqVeVZifF0x+Xq4em9JmV6K6TRkIn08Qtyo1eDYGBjmhXUvwDfqtLO56n6A8ns9qsGO+W6PtykUOBEsNOFYtyZEjSZ1dC6grj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194140; c=relaxed/simple;
	bh=bbJvFUQkw3L5PkboYUMBfNQJNB7Cj+N0QgAqzbHFUjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEPIEtuvAp6WSOiJhY7CtCY1XnjyS0ScDEpKTFdIzm2gTX7flkUhCtWC4EgjD5I0DSfj+s0r67vKnhcmizvBUhcTiPFRidQKeetOwD5DqRsYWotN6FCtATV8OdUtiH8yK2N4Coixrkcmq3cahQo795PlU7Di3vmcLVgmh6QM2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDn1j1Y0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2348ac8e0b4so11075ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750194138; x=1750798938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJpTkL6dnMUxXhqmmFV6413864xvIfSCiGQ5PuutKRk=;
        b=aDn1j1Y0l7AYNZt7Qy2X/e0gj9YhLQyvqm5fO3SG1G8YnpRudZJlswM9i1g/sLnTmF
         sbK03Wq2AEDVQTVRZ/cSFGIZLx+IjFb8gYhKVxvWBe09v4Bnrc9Ge1dBAInBw5m8BmQh
         i7sTsW8G+fteiiRuitK8u7d+5+lS8p8TRMcOJbBGTi8b+B5WelEd3mFtSbIW+2sRp26y
         kGWI+VC7sTUvztAHKIQhkqIjEkA8P6TN+r9F+R6EP0O20xnOBi/ht4pTgW5rrnBUSKBW
         FbLA2i6ben0GVHPNh8AZ3cRGFxNf/yzICjzPnzlzYPKgQXWuO1dpG91TpYDFPVzuOUkw
         TduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194138; x=1750798938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJpTkL6dnMUxXhqmmFV6413864xvIfSCiGQ5PuutKRk=;
        b=WkxBcAWATzKaF3pxDuT7693wtt8xHeOnIB8ZuMou3D0tKH8f8ZR0oLzh0Zcs6fk0kO
         V+v2WibhUEGTTtYg3Z5xNyAWGu045Bfd3WzEb60tZMvmXO/FWHUJ21QuUX91KJL0zVwc
         wRPrSbpA6hRZhNoh71GUOcemLEU4yJFgMA+JuuxDxCSh14SeLdf7shc7d8lfyrwGGzST
         wgtjWrlQGQLz36ELQHlzv58WZfTq6gMormjfhYW/1zf5EKyNYqb8VILoBaQAoiQfehUQ
         dS8iwRSJ5X8Jb0veu08mx8dQvO1cVkr6Y0OQUy8/h2L7J7rakNuFKNo7Kl2txWOMSQUn
         UZFg==
X-Forwarded-Encrypted: i=1; AJvYcCX73BoufttMqLe7M5nEWjzqJtXdO2Iwn7nhuTI/Ytem0EOCk5EORgq7j/SgeRI6bdPRXJI64b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEmD6NtB9Qq/EQWJSWee/Cuu2P9UsDzd3CyCDv1WN038OJxE4
	o/6vzYPFhCyblt00ztNw6XvgXZuQUByXg1f3TH8VH+eTQkn/5CFhjXuKvl0kV2L404nNbQVDcp4
	xkutm3a9mjbUx7Bx6G1cnP7sb+0pJ7s2stOd8UVhO
X-Gm-Gg: ASbGncvT9v/7UTdu2TPXFcuAGeVmmwhR7vn3nzmwoW6SP6zD47CvZrV4WiYo7sGwEqv
	VNWUG5cL2+A146VWwcpxkFrDGkv8IRaUPg38DxA+sx84ICP7Z2gkiC4URYBUj9+47KzxMCPAj6X
	M+D/fJ7pVIh8hOulWqOKw4/7UmJN5hWsZYBqk92PmEZ2yOPW54+XTRvfUH8bmvrC2LqECliEhcv
	w==
X-Google-Smtp-Source: AGHT+IHgMRu1fKsSV7XOy4vWnT6+ZEd1bH1oAglzGxguVpljDMbdpGfPlD9igC63Hsmb+pjcSFZ3ktzSSxCDH6UqpcY=
X-Received: by 2002:a17:902:694c:b0:231:ddc9:7b82 with SMTP id
 d9443c01a7336-2366eef033amr6826765ad.13.1750194138053; Tue, 17 Jun 2025
 14:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616080530.GA279797@maili.marvell.com> <d152d5fa-e846-48ba-96f4-77493996d099@huawei.com>
In-Reply-To: <d152d5fa-e846-48ba-96f4-77493996d099@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 17 Jun 2025 14:02:05 -0700
X-Gm-Features: AX0GCFvUw1z75ffCbqGSTrvshjJ_0t0dfFX0hDbMSAmZ2EGaeyX7sOFJGQGhBUs
Message-ID: <CAHS8izNBNoMfheMbW5_FS1zMHW61BZVzDLHgv0+E0Zn6U=jD-g@mail.gmail.com>
Subject: Re: [RFC]Page pool buffers stuck in App's socket queue
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 11:34=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.c=
om> wrote:
>
> On 2025/6/16 16:05, Ratheesh Kannoth wrote:
> > Hi,
> >
> > Recently customer faced a page pool leak issue And keeps on gettting fo=
llowing message in
> > console.
> > "page_pool_release_retry() stalled pool shutdown 1 inflight 60 sec"
> >
> > Customer runs "ping" process in background and then does a interface do=
wn/up thru "ip" command.
> >
> > Marvell octeotx2 driver does destroy all resources (including page pool=
 allocated for each queue of
> > net device) during interface down event. This page pool destruction wil=
l wait for all page pool buffers
> > allocated by that instance to return to the pool, hence the above messa=
ge (if some buffers
> > are stuck).
> >
> > In the customer scenario, ping App opens both RAW and RAW6 sockets. Eve=
n though Customer ping
> > only ipv4 address, this RAW6 socket receives some IPV6 Router Advertise=
ment messages which gets generated
> > in their network.
> >
> > [   41.643448]  raw6_local_deliver+0xc0/0x1d8
> > [   41.647539]  ip6_protocol_deliver_rcu+0x60/0x490
> > [   41.652149]  ip6_input_finish+0x48/0x70
> > [   41.655976]  ip6_input+0x44/0xcc
> > [   41.659196]  ip6_sublist_rcv_finish+0x48/0x68
> > [   41.663546]  ip6_sublist_rcv+0x16c/0x22c
> > [   41.667460]  ipv6_list_rcv+0xf4/0x12c
> >
> > Those packets will never gets processed. And if customer does a interfa=
ce down/up, page pool
> > warnings will be shown in the console.
> >
> > Customer was asking us for a mechanism to drain these sockets, as they =
dont want to kill their Apps.
> > The proposal is to have debugfs which shows "pid  last_processed_skb_ti=
me  number_of_packets  socket_fd/inode_number"
> > for each raw6/raw4 sockets created in the system. and
> > any write to the debugfs (any specific command) will drain the socket.
> >
> > 1. Could you please comment on the proposal ?
>
> I would say the above is kind of working around the problem.
> It would be good to fix the Apps or fix the page_pool.
>
> > 2. Could you suggest a better way ?
>
> For fixing the page_pool part, I would be suggesting to keep track
> of all the inflight pages and detach those pages from page_pool when
> page_pool_destroy() is called, the tracking part was [1], unfortunately
> the maintainers seemed to choose an easy way instead of a long term
> direction, see [2].

This is not that accurate IMO. Your patch series and the merged patch
series from Toke does the same thing: both keep track of dma-mapped
pages, so that they can be unmapped at page_pool_destroy time. Toke
just did the tracking in a simpler way that people were willing to
review.

So, if you had a plan to detach pages on page_pool_destroy on top of
your tracking, the exact same plan should work on top of Toke's
tracking. It may be useful to code that and send an RFC if you have
time. It would indeed fix this periodic warning issue.

--=20
Thanks,
Mina

