Return-Path: <netdev+bounces-142018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF989BCF85
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED57C286A81
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F002B1D5AD7;
	Tue,  5 Nov 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJifk7BK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6573F14A91
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817295; cv=none; b=KxW/9f7aWOSjWvuMkC3+XWSvDMWZqtXdDjXekAND0MfDu8XdqVMhaVBFuJJhR5mQAU5m72+eO2nT0T+c9KSUGjpS7LclrwTDGI8tYzzp7yeUIg6sOaF0QXHVynEBtN5W1iwExnZU62k93LskjyXu811fh7LZcGuHmOWs2s2oPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817295; c=relaxed/simple;
	bh=4rbb9/pHRWz1ceBly15RIQpOvzet1T/MW22eNyXjD6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXYm5a7pMYG/O1fNeWUUoBlCXKeK2R8dq3ekrQj6nKaDbnHXORxeRbliDWs/rzURidf3MSyb49NYPvE2byjNDgulT5NIvM4HlfNxw9+Wwf5fCOxuk9M0Ne03geKxfeLkTwuOv/ra86tUwLRpnCFtt+n/pXebCQMBuexquNVdeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJifk7BK; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83ab6cbd8b1so219310539f.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 06:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730817293; x=1731422093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPb35C6164ct1jmcUPO5yumJslFvMnTm7jGLlF6eV0Y=;
        b=JJifk7BK6mBH4L846/154iAGEissf4Cr5twUTf/NnZvWFmpi7/VbO1ity2PkF1oC8S
         MCWbM+IyDGfoaqURE/6eY094n0zt2rPeRI5iCtZa/GLTUv26iCcbU8svsk9akn4TlJAw
         olSo7qetuBKTfxOXwCdXfOdNaH2tiqhjHUcq9OsdvaabBmmq7o6CwGCKYhBVnEOAoPfn
         zpX9ZiEMV89ajRzDFGd6MOtTcu74US50uiY/GnM4TELA5gC8RJt0D5DjDODOZRbYc1bQ
         /sjtRl+hD3uWDAkAsaBKVs6mjFH7msJBnhDKOGYe4l2fltxtBdRwz+NH+SaorKCPoSfa
         nuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730817293; x=1731422093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPb35C6164ct1jmcUPO5yumJslFvMnTm7jGLlF6eV0Y=;
        b=k3+1hldX7SbhCpU8V2npb00uh1mf/o33gfRtXgM7ai0qcLWGV6Ear1VyGeiQWnN1bA
         aOWowZ2+YdJNSogdsEPuuc3tU6BL89vbpnb5lHCwVpWks/UxdFGEZHZREVCWSfVKZweM
         t6DNQO+08xBTfsXfCrtjRRZ5L6cuEINSU5acAres5g/09NH+fLQpnjD1CUepFtHyVwg7
         4GGPY7MYFhoOgBivz+44ZqptOoNdL275u3IKs86b0UqkckJmerDEhAUBj5qIH78398BQ
         rbhK4QEKnUkPd7hSpGx+FIjaWxdXfUVGVevFwZgHFxcNsdKzCHhFHx8ep4wuuwfywXJI
         QMUQ==
X-Gm-Message-State: AOJu0Yxkhz7NsNxn630w2p8ZTSsQjm+NGZ4vx1jr+GEihiDI3FLf7kax
	f5Hyjk/zSUSZr4MFJsCYnUo4falkrf/EdsVH6sQBMrDasNAz5vW/27sUs9ZF2dvBNI1Gu3CV/GU
	zdvbjL1fO6IEc4JzmaTCumPQ9Tew=
X-Google-Smtp-Source: AGHT+IGaJajpHMcOi+8M3nrd26U80x+0chxziVgq09UKbPXSyoRgbf1t1uRdnDsI+/Pw7CLe1O8wg8d5bG7YkCOjM+I=
X-Received: by 2002:a05:6602:140b:b0:83a:c4e1:7d50 with SMTP id
 ca18e2360f4ac-83b7190c4dbmr1838386439f.2.1730817293496; Tue, 05 Nov 2024
 06:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102125136.5030-1-annaemesenyiri@gmail.com> <ZyekEJHEzJnyX6_j@shredder>
In-Reply-To: <ZyekEJHEzJnyX6_j@shredder>
From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Tue, 5 Nov 2024 15:34:42 +0100
Message-ID: <CAKm6_Rv8yUvoY1XpEZVb6ve1s8XtodxTHYBCXqakQwnmhMGhQg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] support SO_PRIORITY cmsg
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ido Schimmel <idosch@idosch.org> ezt =C3=ADrta (id=C5=91pont: 2024. nov. 3.=
, V, 17:25):
>
> On Sat, Nov 02, 2024 at 01:51:34PM +0100, Anna Emese Nyiri wrote:
> > The changes introduce a new helper function,
> > `sk_set_prio_allowed`, which centralizes the logic for validating
> > priority settings. This series adds support for the `SO_PRIORITY`
> > control message, allowing user-space applications to set socket
> > priority via control messages (cmsg).
> >
> > Patch Overview:
> > Patch 1/2: Introduces `sk_set_prio_allowed` helper function.
> > Patch 2/2: Implements support for setting `SO_PRIORITY` via control
> > messages.
> >
> > v2:
> > - Suggested by Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> >   introduce "sk_set_prio_allowed" helper to check priority setting
> >   capability
> > - drop new fields and change sockcm_cookie::priority from "char" to
> >   "u32" to match with sk_buff::priority
> > - cork->tos value check before priority setting
> >   moved from __ip_make_skb() to ip_setup_cork()
> > - rebased on net-next
> >
> > v1:
> > https://lore.kernel.org/all/20241029144142.31382-1-annaemesenyiri@gmail=
.com/
> >
> > Anna Emese Nyiri (2):
> >   Introduce sk_set_prio_allowed helper function
> >   support SO_PRIORITY cmsg
> >
> >  include/net/inet_sock.h |  2 +-
> >  include/net/ip.h        |  3 ++-
> >  include/net/sock.h      |  4 +++-
> >  net/can/raw.c           |  2 +-
> >  net/core/sock.c         | 19 ++++++++++++++++---
> >  net/ipv4/ip_output.c    |  7 +++++--
> >  net/ipv4/raw.c          |  2 +-
> >  net/ipv6/ip6_output.c   |  3 ++-
> >  net/ipv6/raw.c          |  2 +-
> >  net/packet/af_packet.c  |  2 +-
> >  10 files changed, 33 insertions(+), 13 deletions(-)
>
> Please consider adding a selftest for this feature. Willem already
> extended tools/testing/selftests/net/cmsg_sender.c so that it could be
> used to set SO_PRIORITY via setsockopt. You can extend it to set
> SO_PRIORITY via cmsg and then use it in a test like
> tools/testing/selftests/net/cmsg_so_mark.sh is doing for SO_MARK.

Of course, I will send the test. However, I would first like to
clarify which option I should assign in cmsg_sender for setting
priority via cmsg. The -P option is already used for setting priority
with setsockopt(), and -p is used to specify the protocol.

