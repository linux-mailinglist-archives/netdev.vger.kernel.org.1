Return-Path: <netdev+bounces-233608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F4CC164CC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30A81542505
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5435C225402;
	Tue, 28 Oct 2025 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1BEcJJLy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F75345CB1
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673598; cv=none; b=mxwjbkP3MgBYUzbq343Mg4wy455msSVfI43pMEeuC/7qghKRd34nXFqwG9Ooo4DJt+8zoCcaseSZDhnAJCzaIu5lYZdjv3AIZEf5Vgsse5NZ4PsloJdgM8Eg3n3sfsxHDDu4z5sgjXuYKXpMrzCE2PB+dCiHJA+xmWEY4AmCn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673598; c=relaxed/simple;
	bh=zbeFB5x+OiO/YBlHryfxJUhkT1VVN+D+SSFnhU3x8NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mfhm6Z+o107lwyc1TBV2gtmbslBZRHM7nVPUv5s7CDJgpbnQK+UnIOkBkwO25bUn+D+AUGrt8izrOD5MQr0wTdz9erkx15eTKIHplw/9S2W3WmwKduSSf6LQkKCx/QNVlNFMwuEMJx6Y+DiCKZeBXynK3m7VbQPvpjK3gWZ9HQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1BEcJJLy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290deb0e643so58406805ad.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761673596; x=1762278396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZsqDuuVhLg2NXCb+AK09lT0i/+l6zu9Qik25XigEBg=;
        b=1BEcJJLy4qnXOuqgJLVDM14sgdOzCgZUQrwBkZ0emRZlk3uVYEY3ou0f5wqWdXbIR1
         PDhnCWnwDid77QrN1aM4YKaA/CBqmxIgYtystHvdt8mCpEnR3CZjSmVq90ipAbs3AjoK
         z6sYey6ZeJ8VffM9XF2yNv8r5O7nRvQA53YQotFGcSA92AWhMV0xVOrlyaU8tzw7tBFv
         /OU7U7z9EnEVhEWIjdIMu9RsiP4mu0TDNjwrDjFVMji7g6Q76x/k2tlty6ft/NPI2XKk
         TngJzDUaAH10lPjE7VaUFpkAKrOlFvza4glhgW8C0wv7fy6NEFJRKNeMRxdtVSmlfWo/
         6KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673596; x=1762278396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZsqDuuVhLg2NXCb+AK09lT0i/+l6zu9Qik25XigEBg=;
        b=l21Psk9bEJJgVHU4ur6uAU6CHcWL0tXzmmAkdvlrDBDDP9b/Y7UjmI/H2mp1qh+raC
         jHaAVz3kqtw/fDveP8WtePb3M3qxZ/aAmJAFkMolcJJj6t/B6m5wZsAGfGwqOwLqklqW
         yKzHO6ute+n1TiHSNmw/33KcwBeUpButJ7i+UXkjwf5tZf/UTBtd5IyEiEkNlBtoSIqX
         /OMS9WYvj6GnbLpUS+3XrwN5sSNXKOcB3AC8/NrevSPdJ0iGUr1tE3L3VFPyoK7zRNzx
         U9ltQ53hN6HG4hSwB39sG5ePtwc6GXIj+8/vBdxm92Qdrsaiz0t6Yf0N8O+iAEWXRxOW
         f2Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXWRvdC1HnbgiwVsvkyuJEfHS788G6J/uTwEHmls3FLav7E1dTHSsT8cBmav9LJFhxes/B5JAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvIJUgCZWvf2YDf5cqYLnccjqBc/ElgLB6q1dkicLgYz82T0gZ
	DmOAQ+4pLy2OV5xC1IfCIs5uCKAGVfLX0XDZUN/+OLW/2Ff/F0XPj5JyLoxMFINN6HDmSIc1aSa
	+/3dnqGIs9imQQaEBZ7PAJ7YjB7xAHTs1WT4Kjodt
X-Gm-Gg: ASbGncsMsnDSkmMQ8gkBa56oK8w6itb9D1czxXfYnEEBLytuCikozskg6sQtp+yWIvv
	o3dBGXJXU36UXVaKBJd87qwlP91dzn+GM1w2PS1SkrKrA0zAmEIT7KAuwKQm+rk1rrNK9P4oYGy
	1q03/RW20VZQIgaMXFPAvtY58JvTPBQyoKit3iGoF8FYRcFPTzlHlOGe5uhw3B/jemt2Vl+bW9M
	7vxHLPCPw4JoEjw7vfJ8fW9Jj1gPhR1oQc5cXRqK3OoktAYwGoE1EUUk+xr1DusyiO3/dl9pXcE
	V4jUCaD78aBtCTYKjaN2HG7fiw==
X-Google-Smtp-Source: AGHT+IEyAtvA64a9Fz09y7bkrGKSTDnLoZo59oLJkzz4zp6Jx0c74zjHwyphq+qc6DK8/4/JpG8+oZMDB3LfYAyEiLE=
X-Received: by 2002:a17:902:cf0e:b0:27e:f16f:61a3 with SMTP id
 d9443c01a7336-294dee49b4dmr322365ad.23.1761673595961; Tue, 28 Oct 2025
 10:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com> <20251028033812.2043964-11-kuniyu@google.com>
 <aQEAPIZOxe4aHt2z@debian>
In-Reply-To: <aQEAPIZOxe4aHt2z@debian>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Oct 2025 10:46:24 -0700
X-Gm-Features: AWmQ_bmj7K_zk_YCx_ylvGk23YBOVm_V_QYVwlWDfCIKqrFzpudcmjMtlCabihE
Message-ID: <CAAVpQUBDcAw-6kivPdcmJtwXsRHP3XRaOV2j0zOU_T0EMCOGoA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 10/13] mpls: Convert mpls_dump_routes() to RCU.
To: Guillaume Nault <gnault@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:41=E2=80=AFAM Guillaume Nault <gnault@redhat.com=
> wrote:
>
> On Tue, Oct 28, 2025 at 03:37:05AM +0000, Kuniyuki Iwashima wrote:
> > @@ -2768,6 +2773,8 @@ static const struct rtnl_msg_handler mpls_rtnl_ms=
g_handlers[] __initdata_or_modu
> >       {THIS_MODULE, PF_MPLS, RTM_NEWROUTE, mpls_rtm_newroute, NULL, 0},
> >       {THIS_MODULE, PF_MPLS, RTM_DELROUTE, mpls_rtm_delroute, NULL, 0},
> >       {THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_rou=
tes, 0},
> > +     {THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_rou=
tes,
> > +      RTNL_FLAG_DUMP_UNLOCKED},
>
> I can't see any reason to keep the old RTM_GETROUTE declaration here.
> It's going to be overridden by the one with RTNL_FLAG_DUMP_UNLOCKED.

Oh I think I made a mistake while rebasing and reordering patches :)

Will remove it in v2.

Thanks!

---
pw-bot: cr

