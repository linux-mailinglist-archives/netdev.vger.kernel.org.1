Return-Path: <netdev+bounces-240179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B415DC70F93
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 21:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D32872B685
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563D33191A2;
	Wed, 19 Nov 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FSh8cnju"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80130F803
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582510; cv=none; b=RdFki8bA8D/UXWgB3D32otLcIhBZrmA983PBZ8JUCZyMyWaQCkLr1QbLR4/WJohq3DktF+S9c/6KEAEyRAIXnzCW/1Bzl6emNBKn44zx4M256hB2+xSM7juZjIuBXrKjluYbMUTiEvLZyRcAocvnAPUa2pMBtACZOmnEOH9gw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582510; c=relaxed/simple;
	bh=kK7HurzhWKVoO+dxNY6gqaAM6WI4gGw7TbxJ/QpxOuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiyIskPsimIlX21iz9jajfZFZBFGdwCTiud2Yd58DyD7zO40OtL3AxWx5i8j9iKsheE6DycbX8+xRWkBJR1docv/FAB/nyyoiX7Bgqxf6728aNBPA6NsN/oLTVbh6R924SZfL0Nlt5L5Drl8EaDAM5nYJXFR+hzvr4Z2HF9h26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=FSh8cnju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F074AC116B1
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 20:01:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FSh8cnju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763582505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD7b8TcgRMmO1CAUcyDsShEJadk1xG3qrQTC8wGE1S8=;
	b=FSh8cnjuro3G/nOPstCDrm7vXz1jROY88vuM/crsROP4SOTRRM7X6vEPUwS/IIr7t/snkj
	kbpVsx9TyN+1UDzRegwewnBVjTUJ6XDt1FPoCvQKiVFWm7STrgG+C3o7txeCKnrf1CzPLD
	kXa8pSpy+XI5+kHBke011N78TcoxLe0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 931c236d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Wed, 19 Nov 2025 20:01:45 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-657464a9010so18855eaf.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:01:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXm83K/wXPZP00z+QgmGrsFam3ogcRVOP7+Rx/PUwurpiNMt7hmSUTVKZ2e9UJPLfU3zQmPLyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9Can4hepLZK5X+69W0SF350iVdz85z5arqnZyzpq07qW/teV
	nRg7Nys9GTDSrSyZOrQX1JiLjpkxTvS3c8rKx9o6FDmSk5U9YRXtxE7zh196/2VPlJ2xZ/Nynsi
	ggJiyEsgMwKZ80oy38jjUTrSf5bx4CyM=
X-Google-Smtp-Source: AGHT+IGx+a53yU4H/nb0fEWsNKD8FC5saE55qDH6g7ph/RauN+KSj2eyR88v5e2yxkC+qq9i75TwrlsXLmHnRcdiaFY=
X-Received: by 2002:a05:6820:2005:b0:657:6678:1b48 with SMTP id
 006d021491bc7-65784a21b97mr39172eaf.3.1763582503276; Wed, 19 Nov 2025
 12:01:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105183223.89913-1-ast@fiberby.net> <20251105183223.89913-5-ast@fiberby.net>
 <aRvWzC8qz3iXDAb3@zx2c4.com> <f21458b6-f169-4cd3-bd1b-16255c78d6cd@fiberby.net>
 <aRyLoy2iqbkUipZW@zx2c4.com> <9871bdc7-774d-4e35-be5f-02d45063d317@fiberby.net>
 <aRz4rs1IpohQpgWf@zx2c4.com> <20251118165028.4e43ee01@kernel.org>
 <f4d147da-3299-4ae7-b11e-b4309625e2c9@fiberby.net> <CAHmME9rzr8EGkTy3TduTXK45-w1CwEYnRLX=SjkAqo1CTTgVHA@mail.gmail.com>
 <36bdb7f1-fb64-44b5-8848-6c3a8d37b88d@fiberby.net>
In-Reply-To: <36bdb7f1-fb64-44b5-8848-6c3a8d37b88d@fiberby.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 19 Nov 2025 21:01:32 +0100
X-Gmail-Original-Message-ID: <CAHmME9roZ3EJfqXh1Avf1JZv+V+uGVgwCboZ+rV8M8-XOTA07Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkebx_ZL4YfTCdBoJIcoTVanhzI5wlwILMAbN4mRIEpB9tqH4kbQS7YgJ8
Message-ID: <CAHmME9roZ3EJfqXh1Avf1JZv+V+uGVgwCboZ+rV8M8-XOTA07Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/11] netlink: specs: add specification for wireguard
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 8:47=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> On 11/19/25 7:22 PM, Jason A. Donenfeld wrote:
> > On Wed, Nov 19, 2025 at 8:20=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnese=
n <ast@fiberby.net> wrote:
> >> B) Add a "operations"->"function-prefix" in YAML, only one funtion get=
s renamed.
> >>
> >>      wg_get_device_start(), wg_get_device_dump() and wg_get_device_don=
e() keep
> >>      their names, while wg_set_device() gets renamed to wg_set_device_=
doit().
> >>
> >>      This compliments the existing "name-prefix" (which is used for th=
e UAPI enum names).
> >>
> >>      Documentation/netlink/genetlink-legacy.yaml |  6 ++++++
> >>      tools/net/ynl/pyynl/ynl_gen_c.py            | 13 +++++++++----
> >>      2 files changed, 15 insertions(+), 4 deletions(-)
> >>
> >> Jason, would option B work for you?
> >
> > So just wg_set_device() -> wg_set_device_doit()?
>
> Sorry, no, wg_get_device_dump{,it} too.

Fine by me.

