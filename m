Return-Path: <netdev+bounces-183360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FDCA907F3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C757447F37
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94D91DC04A;
	Wed, 16 Apr 2025 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vu6phfBE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74A19AD89
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818449; cv=none; b=PwXBh53cfyFWKFTb7PhRZ4IovxhJ/RRSFbhaa4//6iCIi4IM7a0IVbwzTIvY9CuLvvnwYgPQVSWUmg6YqAUaXA7TnGWRSurSUL/eD4bm9OFzjXRNibkfaVpiJ/zRLkvWFKv7dyxaOiZZ3fu5PSnzG01yCL86YQaSbR3zpVhR2LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818449; c=relaxed/simple;
	bh=9BtehcMof8dhM9CDJ+peK/BCoQOf4QNvHvotm/1l6oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHzi88IM2e3iGR8y7vdqsJV4gvbEYA4Mjl7dtMyG+KW4q8u6yzalB9VOAEuII/RB4Krf7VsmheUPqGdbiDkCNG60pz1zCUz8Xg1MRy3DbnwpSARzm9jFrVYwnmbKtCBP1A56NRluD/ko8/I6lyTbNV/huUph3L1aNBAu9njbx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vu6phfBE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so296345ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744818447; x=1745423247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BtehcMof8dhM9CDJ+peK/BCoQOf4QNvHvotm/1l6oY=;
        b=vu6phfBEate8kODrynX1ZYKIkqUZVHMV8vOgfey+VLYPFwVb88JznCONWPm/srjneA
         6nc7VFAy6LQXLTax61sWPgyT/UZy0Q5Eix5BL6R79uxpvv226tmJVEaAv7uUM8SIrmSf
         CfcWeizkNog+QNtnIOVYVbkQHRVCd2FRDT9Vd5yhRUaxgIiurM61wLDn0rXxW4T97p0i
         a0BlSl12+B9djJjVWG2ZeX+ENzVamFCmJr494zj2cH89GmWONaV9rTU85hWeN7QlPFIY
         pPC9IhH/SKRYdTPi5VxfKSaqEqOto6R7xm25fA55Lr3r+ofgrMHQqPUoNEFQ+Jd4XDjP
         RUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744818447; x=1745423247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BtehcMof8dhM9CDJ+peK/BCoQOf4QNvHvotm/1l6oY=;
        b=S0SaE9fhAT0D0P3fXQ+AprFbTyFqaVMDozlalJh3SNm6rgfW05UVc48UxRgywtjIny
         KizGWHPiPs21Uh1fTeQE+Qy8HNeILLygQxa+HOXErntt50lVMveTqmq0+Tbh2lermkTp
         2/Egikepg7nG7evTeevQs3Z3hOQV67Cs4o3Z0mzM9iJK2m7f1dHmoEFUg3owuXhBe9JQ
         rkfCrh4sk3y1SOyb8u661J3eri8P17g0a97EqndQpybpISoBgUh9wxKCCF7OfeVY53Oe
         soA1bE9afFOBHZj3BQumTy8s2CWsK24QRsiGFUXBeuECqPjNGqnTirzR86v2vVlJ7pv4
         c17w==
X-Forwarded-Encrypted: i=1; AJvYcCUp2AFVlK0sENZitnpQZyG/7LkrEQ5/FkGdGeC8BVhJYao7pknZ9eEWi1r47b5Zf9QTLIjF9lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzErIe0IUyb39jDd8eimfV2iBosRdtU+IpXu9UonqnsrkB8RXqG
	yUd+XO288a93sT8+Cna8Mxt3PNGqWJKVrYCPI0253IyDB0KhAaLPxDUZd5Uk+ioRCjgEuykTSuM
	hnrulCnG+wu55H9gDpbNgCl5EgkelVowfLeGo
X-Gm-Gg: ASbGncv0Se8bDGm2d0gvPKsujXG50ETQ99iB6uUI4ZBHedSfNmZIQRnCpzifDtwbC96
	v+kgWHQytDAhtRe6fBKTGXQqAffyhHT3dDzuYQ2VeZlE2D7cDYK1X75+JMpIiVDEDzGYpsGAMkM
	Q7wDAFLLSzJWilc1GqKEr4D/A=
X-Google-Smtp-Source: AGHT+IFl+yHCNEjgdcydlQz7nw5ZanPyENq/cc+l4w7kJvqEqXip9IHeLoacdLKymNvynGMqRuL11Lmq2cQMnAd6AGY=
X-Received: by 2002:a17:903:2405:b0:220:c905:68a2 with SMTP id
 d9443c01a7336-22c3549f4b6mr2009035ad.5.1744818447258; Wed, 16 Apr 2025
 08:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415092417.1437488-1-ap420073@gmail.com> <CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
 <Z_6snPXxWLmsNHL5@mini-arch> <20250415195926.1c3f8aff@kernel.org>
In-Reply-To: <20250415195926.1c3f8aff@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 16 Apr 2025 08:47:14 -0700
X-Gm-Features: ATxdqUFD6p76xRcgzqEDLxOQmK7yvkV2sc3cdFszxb_ytgY42nXCc8-4hS3RPS0
Message-ID: <CAHS8izNUi1v3sjODWYm4jNEb6uOq44RD0d015G=7aXEYMvrinQ@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close after
 module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	skhawaja@google.com, simona.vetter@ffwll.ch, kaiyuanz@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 7:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 15 Apr 2025 11:59:40 -0700 Stanislav Fomichev wrote:
> > > commit 42f342387841 ("net: fix use-after-free in the
> > > netdev_nl_sock_priv_destroy()") and rolling back a few fixes, it's
> > > really introduced by commit 1d22d3060b9b ("net: drop rtnl_lock for
> > > queue_mgmt operations").
> > >
> > > My first question, does this issue still reproduce if you remove the
> > > per netdev locking and go back to relying on rtnl_locking? Or do we
> > > crash somewhere else in net_devmem_unbind_dmabuf? If so, where?
> > > Looking through the rest of the unbinding code, it's not clear to me
> > > any of it actually uses dev, so it may just be the locking...
> >
> > A proper fix, most likely, will involve resetting binding->dev to NULL
> > when the device is going away.
>
> Right, tho a bit of work and tricky handling will be necessary to get
> that right. We're not holding a ref on binding->dev.
>
> I think we need to invert the socket mutex vs instance lock ordering.
> Make the priv mutex protect the binding->list and binding->dev.
> For that to work the binding needs to also store a pointer to its
> owning socket?
>
> Then in both uninstall paths (from socket and from netdev unreg) we can
> take the socket mutex, delete from list, clear the ->dev pointer,
> unlock, release the ref on the binding.
>

I don't like that the ref obtained by the socket can be released by
both the socket and the netdev unreg :( It creates a weird mental
model where the ref owned by the socket can actually be dropped by the
netdev unreg path and then the socket close needs to detect that
something else dropped its ref. It also creates a weird scenario where
the device got unregistered and reregistered (I assume that's
possible? Or no?) and the socket is alive and the device is registered
but actually the binding is not active.

> The socket close path would probably need to lock the socket, look at
> the first entry, if entry has ->dev call netdev_hold(), release the
> socket, lock the netdev, lock the socket again, look at the ->dev, if
> NULL we raced - done. If not NULL release the socket, call unbind.
> netdev_put(). Restart this paragraph.
>
> I can't think of an easier way.
>

How about, roughly:

- the binding holds a ref on dev, making sure that the dev is alive
until the last ref on the binding is dropped and the binding is freed.
- The ref owned by the socket is only ever dropped by the socket close.
- When we netdev_lock(binding->dev) to later do a
net_devmem_dmabuf_unbind, we must first grab another ref on the
binding->dev, so that it doesn't get freed if the unbind drops the
last ref.

I think that would work too?

Can you remind me why we do a dev_memory_provider_uninstall on a
device unregister? If the device gets unregistered then re-registered
(again, I'm kinda assuming that is possible, I'm not sure) I expect it
to still be memory provider bound, because the netlink socket is still
alive and the userspace is still expecting a live binding. Maybe
delete the dev_memory_provider_uninstall code I added on unregister,
and sorry I put it there...? Or is there some reason I'm forgetting
that we have to uninstall the memory provider on unregister?

--=20
Thanks,
Mina

