Return-Path: <netdev+bounces-244137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B611CB03B3
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 15:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAEE3034EE6
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 14:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FE27A442;
	Tue,  9 Dec 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgDT/CZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D6225CC79
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765289772; cv=none; b=FnfxIzCGxdUcJ5FGYAhWEwYh3+ChXBDjdTdI8fjrh2kCdFS0nrWrnstTjwVhhN3jQGa3AJNSF/dIWQhw2GFyM9BicqAYSdAaNQdEZoGvczavnbaE8+xpma4c4V/ptyTBCYkZyxyT2//EMJJkWVwuEyeKaoaAm6EK7j+R/3e53uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765289772; c=relaxed/simple;
	bh=ObJQRj35e3yqnSavRIIuBMYvs+Iakm3iCJonVEahKtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6sIeshs+SGjM0heW72eZwXkT1mJ44VSwdSFj5fVxx+43kYOn94wlJea4aVNjEq+pp8LwouGkTLjdNOyfc5/LbfFYpZX5CAfjCs3TvrTsffZj63TOfQjlzvOfOgrfkZJZxsNKvfAZu2c21DShbPnUCUkdapS9NxqNsDx01D/rT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgDT/CZ9; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6574d7e451dso3468067eaf.0
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 06:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765289770; x=1765894570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTCpCM5eQQT+LNew2iNT1MCWNL6y4aTIGwqOYDOo1Aw=;
        b=KgDT/CZ9pyHXZfFZAwx2TQ0aXkBy5o/cu6qNS3SE+qPEcDfvi0ukPbv0B5IJthmywM
         HWLfUzwFCnuQSsvGaImfNU8Dtql6J00SBxvr64j0oJiJkv0HxUCg9GPb5UduurrozAvR
         5duzlSptonOHv+F4YODe8u6c2LJhGu3KIS/lHM854DUhSe9OcACcFFbr2BYH6j0Y1U7r
         Nv1FniwmjkD7IYJVCFDrRyhbRvZkezHVx1jX358XKqu8siCzPgaY2OJwDHHF+gQ2yNry
         JyYz6NYT5oEY/srxZkoFQBxBc3r9dETHxXNg/3JTlu/VXAcql9PfjFrOsGwWontDYe9L
         90Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765289770; x=1765894570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTCpCM5eQQT+LNew2iNT1MCWNL6y4aTIGwqOYDOo1Aw=;
        b=H7VGoMWrSUu4WI8TuTa0mcFTA4vwHFTaqTPMZLNNun/QfZnOrQF3kMgJCe1twy4OP5
         9nYr+hHgk9FnieCcMLhbXwg+4jP0pt0gEM6Yaqgf2J1ofI4Lg4f8Bx8trZ/UB7RaLErL
         +9KJSK7CD6XCl0djGisOEMEg9dH7RBFl8RPvGIgZW6Zb0VRISq3sr7wQdAuO5s0JbDei
         XFWcBWsAxZ1df1g0EesPRYPd5r8sSWcVjKjFOxjB2w0zSrvM9NI5nhvERujoGT7UAG6u
         vS0ZtKQ8Cv1jI29QXH/hPsXJA7UKcplhE5SZ9HzU7mFWdcSrmG/9NzgAFzm2U6e8gqYP
         KKSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD6/yaT+noWjASmkSxyLKyLsWuEyvGaOwEUHQFZZfFp0UhYzMjfnAFNed7Bv7ZEY+gWo1jKI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvEV8pa3Mubxy+VC2W6yDxi/0YX4gQBLb8ZzMYzOsUanWLzZlJ
	2LxwiSSuYL6GqsomSIbztV90Y0jsg6HKTmayRfTw40wWUP8RenJCqW8ezFc5dFkaNxn2sQT7Gq3
	Dc4M15p3T2zgMTq05FvHcg+6aifbzxic=
X-Gm-Gg: ASbGncvGGhf52peaZ12RRFFFZ20+u2VRwsldGNbktOKtIouUCjOWEqyvB6Q3ctntC8r
	fSte5iksOpiQrHnmdGsGkOGpl18d3PyBs7Ej1Uxn2aLHmnEGMmdSZhf8PzQzsSkWnn1OZjGwUTo
	FeB2JeCBKEVeCtgco2n/ITfOV20V5jxyu4AT0Dmrs/4yJIvRVsWO0VLVMohiavvbuN1a5lS6yCG
	YyX/f/nZ3M1mfbn2vF04Iv8FwWoYZGCRBAGQParxsaSmlkXb3h/d4nRdi4K5OAYzlqTQQ==
X-Google-Smtp-Source: AGHT+IGPMqlgWHIaMp7E5vVJZ+Kw8xiwpJ/jT2d2L4xHn6G9TNOzpaO9ZrHeA1eoKhkU0mdlrVEdIBgQ/VLLCaSUiyk=
X-Received: by 2002:a05:6820:6ae4:b0:659:9a49:8f72 with SMTP id
 006d021491bc7-6599a9736aamr4955015eaf.55.1765289770034; Tue, 09 Dec 2025
 06:16:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209031628.28429-1-kerneljasonxing@gmail.com>
 <6937d508.a70a0220.38f243.00c9.GAE@google.com> <CAL+tcoDfvz9fR4XK6FPH8Ng+OfF67UX86=fZL2xxZGnuA2Rs5g@mail.gmail.com>
In-Reply-To: <CAL+tcoDfvz9fR4XK6FPH8Ng+OfF67UX86=fZL2xxZGnuA2Rs5g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 9 Dec 2025 22:15:33 +0800
X-Gm-Features: AQt7F2obHLWItrZASuCEOfprudVlFROW94sp8_ik3Y9kP4YAauQjAnXys-nnZlE
Message-ID: <CAL+tcoDQ6MyuGRE8mJi_cafqyO0wfgOw5WTqnCvKGbQBhKOGpA@mail.gmail.com>
Subject: Re: [syzbot ci] Re: xsk: move cq_cached_prod_lock to avoid touching a
 cacheline in sending path
To: syzbot ci <syzbot+ci28a5ab4f329a6a88@syzkaller.appspotmail.com>
Cc: ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, jonathan.lemon@gmail.com, 
	kernelxing@tencent.com, kuba@kernel.org, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 8:12=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Tue, Dec 9, 2025 at 3:52=E2=80=AFPM syzbot ci
> <syzbot+ci28a5ab4f329a6a88@syzkaller.appspotmail.com> wrote:
> >
> > syzbot ci has tested the following series
> >
> > [v4] xsk: move cq_cached_prod_lock to avoid touching a cacheline in sen=
ding path
> > https://lore.kernel.org/all/20251209031628.28429-1-kerneljasonxing@gmai=
l.com
> > * [PATCH RFC net-next v4] xsk: move cq_cached_prod_lock to avoid touchi=
ng a cacheline in sending path
> >
> > and found the following issue:
> > BUG: unable to handle kernel NULL pointer dereference in xp_create_and_=
assign_umem
> >
> > Full report is available here:
> > https://ci.syzbot.org/series/d7e166a7-a880-4ea1-9707-8889afd4ebe8
> >
> > ***
> >
> > BUG: unable to handle kernel NULL pointer dereference in xp_create_and_=
assign_umem
> >
> > tree:      net-next
> > URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/net=
dev/net-next.git
> > base:      0177f0f07886e54e12c6f18fa58f63e63ddd3c58
> > arch:      amd64
> > compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1=
~exp1~20250708183702.136), Debian LLD 20.1.8
> > config:    https://ci.syzbot.org/builds/d327cc4b-7471-413b-b244-519c6d1=
6d43b/config
> > C repro:   https://ci.syzbot.org/findings/c8f7aeaf-0e2e-43dd-ae9c-ea2dd=
8db8d34/c_repro
> > syz repro: https://ci.syzbot.org/findings/c8f7aeaf-0e2e-43dd-ae9c-ea2dd=
8db8d34/syz_repro
>
> Interesting. Only rx logic is initialized while tx not. That causes

Actually, it should not happen or we can say the usage is against what
we expect because at the first time cq and fq need to be both
initialized and then the shared umem function can be used[1]. But the
repro tries to directly use the shared umem at the first time.

[1]:
net/xdp/xsk.c +1401
Corresponding patches can be seen here:
commit 7361f9c3d71 ("xsk: Move fill and completion rings to buffer pool")
commit fe2308328cd2f ("xsk: add umem completion queue support and mmap")

The above two patches make sure that in xdp_umem_validate_queues()
(which was renamed to xsk_validate_queues()) doesn't allow _only one_
of them to be initialized at the first time. To put it in a simpler
way, cq and fq are required to be initialized. So now what I have in
my mind is can we have the same test when using XDP_SHARED_UMEM?

I think this repro found an existing bug before this patch, IIUC.

Thanks,
Jason

