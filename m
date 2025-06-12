Return-Path: <netdev+bounces-196935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5216CAD6FE1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F766175D35
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93642367BC;
	Thu, 12 Jun 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCnIB3NV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDB227586
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730404; cv=none; b=OFqYmiP01kY+cMEkUGDQJIDVjSh408WnXZ58ZYmKwN2wEa6p+yiycNqwC7R0GhU951KzTpuFl5w4JlAb1MOEj4AgD52IYWo+RckpZESFAngrcMYZwbNEipHPunt230JlidiQ2f7VgMb7OlktIC5HNO5Bdd8wMiE+WWNVVFbI5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730404; c=relaxed/simple;
	bh=3l4uyktLM7pniNhGKBmODjbwnTCHSWVkWZo3J/rPiKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8lYAzxdl8GsJP3IThAGqJdJmKEYluRhZqWWkqzINtN1+2Q8/L2aXb5+1Mq9PTG5fnGQSC8N4ibrEwJSqIK2tiLzy5u/JwA6eY+KjaZWWncJbTIrSd3VmmDEpt2Wf99VT591tBBWKD0AxOY0KiAAHi9w6AC5QHRjzUuxz3B6beA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCnIB3NV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a43d2d5569so12492841cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 05:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749730402; x=1750335202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3l4uyktLM7pniNhGKBmODjbwnTCHSWVkWZo3J/rPiKI=;
        b=LCnIB3NVT1MpElwKHd6LvXpZ0OJwzM1+0tAerpzxdGr+WT4qDVbxll3+KnjR6VFjPi
         1dO7alAGBaZy2uCjNkuOjxplswRTTDnPoDB1kkvvIUAx/PGgFNES2+LHcVHb1/B4amGn
         nnDQ+mwfYeOGATQO8lyRdku50fgrICAB1Mfwh0RyPicybB4GmlY924uW/8itFuv/rQpN
         2heXUAfkxw1lb99OR51Arkys5OE+mumrk85m2ZsMYCRXDjRjPdqx7aagu8GF3vD3ZfoS
         O9A5zr6NzdxPm3qQ9TRBDD2dZsOPBelpZkA+lfkWh3q1dFIHs8w1TScfX0OfwZi2/QEV
         /C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749730402; x=1750335202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3l4uyktLM7pniNhGKBmODjbwnTCHSWVkWZo3J/rPiKI=;
        b=qV0J52rPe5W3or8U5TSx36P+l/PdclgW2+nE7eAJSfpKDnmYNX/EbDn3pHD9Xo7jrg
         2mPEyzMMMWhnghGjqywnLcmWiLdkItGVwzzyt0IFpLF3z4etHm8ZRR9ouYhbFnEK8fOZ
         tUarDfJQ7W6EBQLFjALjZBmjkXLo178H9ljJi4N+ILfpWucpAeR0K7K8h/aSGj/8tW2k
         plXPIz/B5O3d9Pa95OhBv+de7foLkcow8dD4gmx6qFeRHoaPRLlb8sU3SavfGdBCynog
         b8Ncuk72SHysFiVNnzS4q5iSHubeKDF1WyJ4C1v+tIbzORMWt+mw1qtPqFYVfCwIUYxB
         K+HA==
X-Forwarded-Encrypted: i=1; AJvYcCWcC42LkMk6veKLbFAgwFVKwUrKsLWQ+tIttDaRqizKl18kvaZSyFCX6YzuRP9cdl73X/iqaBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlF2LdKpbzrLenuS6zthfB71bltsvrCPkY1j3qmMSQyKuxT6XV
	hkjs6Wd4GPisiT9OK5qEDEDdPP0YEUvnmEdflFxlDFxiilDewjecp8/U7ZhhNSJUkZuh5fCrJRC
	oz9zL2sQiHPK9xcVZ7RxnSlH7rfGuHmpwrmOGSEMK
X-Gm-Gg: ASbGnctjIbJIHNQQzK/6U7KWRRqnDIPrR8PBTwfS0GPGhJ/757n4YnibLpDDryH8+ZP
	PYrjktGs8keyrmW+H82xYOq8S2bU3q62Xd2ISXe1HWGd/fEfbAA8zseArM/o8jfU97bD97Xd09F
	W22ECZ/PRqNEadc0b02UqL/zLgrkxoA9FtIP1Agh8IUluOoGgV61L3JQ==
X-Google-Smtp-Source: AGHT+IFP27nE8Udgch0ukg1VB31gHT7n/EbcDgrssa5T0J+5/kwu/sy3Y1Wb/yMR5gUMQ/v0CYyVKWLzkHNWv7FKBeg=
X-Received: by 2002:a05:622a:4d8e:b0:4a6:f9e1:a84d with SMTP id
 d75a77b69052e-4a722919f4emr65018901cf.4.1749730401748; Thu, 12 Jun 2025
 05:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611193551.2999991-1-kuni1840@gmail.com>
In-Reply-To: <20250611193551.2999991-1-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Jun 2025 05:13:10 -0700
X-Gm-Features: AX0GCFuBUTrSFwmeF1yvh6kJ_Jl_dJKbnUIVsya8-yno6leYNkoIxjA-hsKKXtI
Message-ID: <CANn89iLK5pzu6B1h16OphYfyH4yKQj1+DANRNVuzG11F+=s5dw@mail.gmail.com>
Subject: Re: [PATCH v1 net] ipv6: Move fib6_config_validate() to ip6_route_add().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	syzbot+4c2358694722d304c44e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 12:36=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.=
com> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> syzkaller created an IPv6 route from a malformed packet, which has
> a prefix len > 128, triggering the splat below. [0]
>
> This is a similar issue fixed by commit 586ceac9acb7 ("ipv6: Restore
> fib6_config validation for SIOCADDRT.").
>
> The cited commit removed fib6_config validation from some callers
> of ip6_add_route().
>
> Let's move the validation back to ip6_route_add() and
> ip6_route_multipath_add().
>
> [0]:
> Fixes: fa76c1674f2e ("ipv6: Move some validation from ip6_route_info_crea=
te() to rtm_to_fib6_config().")
> Reported-by: syzbot+4c2358694722d304c44e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6849b8c3.a00a0220.1eb5f5.00f0.GAE@=
google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

