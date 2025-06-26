Return-Path: <netdev+bounces-201597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163E3AEA098
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA0D1889325
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD12E7F3A;
	Thu, 26 Jun 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtDMayuX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3582E764B
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948273; cv=none; b=Pf38YP/Ug49AW2x2FBVMoCYtZpLmV9/DqD0lp855GXMsZYab7u1HUxdtHAQTiN/fACyJUcMvm7lTpdljvBs1s5LueYlpbwZna1RYYl+VfxlCQ3WLv3QG9BuyLm4VZBc8TppzUEMrm8fmB1TUsPVBITn05tZyT3zZ7GK0tISW3p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948273; c=relaxed/simple;
	bh=nwVQ728QT5EuIWdIAijRXKl5sJq76dEIeMNft3nHbLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBe89at/KvuoyoV6yVK9dme1iYX3gY9MhXEi4jl0XxC03WaxWQZ/AzB/CcpWzVdmdhfDd0HlqSIeLT9YozCorlZuLAtGsRPcXxS4dWWeKddUX4hDtF+RjXCbcFapaM4oGXUv/fnqBzezdYHzXe0jfGTqey/vSHgFXyKx6yeMhrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NtDMayuX; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a7f46f9bb6so11272231cf.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750948271; x=1751553071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTdcDRh13hQCfw+HnO8ec2lnP3IFKLOhT7+qZA51NlU=;
        b=NtDMayuXcGQ286tK8MeP6vIqIMK5W1AytC/L11NEs30gp9+jXV9Bh1AnW79SpXHB19
         xdpeH9x+fWfl6J9ERpyfdr0fBfbC5nAkFh+8l7XQHs9zyBncRdG50i4keSVuXTCOAW2o
         EFi2LJmZghfselpppJGn1UWzEpy5lasAqIs5NkED8X2bgdnV4JJumd8N9fqXBUiHjNoD
         Jsyl1r55SqFY+ZUMXghWiG01g+IY6e6qt/1LmWv1l1Tg3dnd0M/iM01TynSpsMAp/0xm
         GVthVjthn7o2J3alPk5bdQdPyMAbAV0C4/YMr7KFApQuftmOBbDoIbhf+QkJcFHGDkXe
         jNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750948271; x=1751553071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTdcDRh13hQCfw+HnO8ec2lnP3IFKLOhT7+qZA51NlU=;
        b=vUwUyp5Wfez1QTOAkiAaELE0APFbbS9/MEUqLNuBohgX99Ey7pNJ7jU2YYz4NR7NCa
         Fq9mbvYSiBYP0YByywmJ/qJswsb62b5idY8r4yut/U2fsGG/uSVVQ9u8R8ffC1SuPKwR
         SdZiDr/Iu8zG3rtnxGzWSyp01wrH/0QU1Yt53CyiX+EXT2AyoQ2wK7rllRep2wZuK9Tt
         oFqceJUFbcEaFq/7f/P5ZY3MUIZLBfJZZGGKEBuOIzvDttoD3NMb+oNxheNeiRJDzvbq
         87gR4sVGAIPGi/yd+nYm/U25juauT2ohoFYUPRihC8udi+GRj/gN5DzMzeVfqxrrt8+d
         fnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlvvNy31uLLxg6dA9mAGkXPvuMOOcfCcN1TLYDcoskWm9ppDLb7O03LEwYRtuKnKfKjMSIK2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/TDCzSJYpY+u4ElX6YV3VUxbNvxzSUBmatbsxxT/v6Fsbh3gP
	2UexFN90X7Qxw0j2Fy2cpXsLLiEuEFg1kpNwSF9V3r6DdkimclYivcPePzUvmTLQSzSKZ9AO+ns
	60efnCHmSANDQJ/5V30KwFe2I+y6t/anV0XyMYWADPS5RNdVNbSUCX8MaPSk=
X-Gm-Gg: ASbGncv6Erp6ScE8kgLG0PWykV0gcmV2vCWd73uIa18fNPvT2fxrgbBcmBVjhFHXs3k
	rd7slasaLqMNwYdr8jQvl5lvIkxXY4EkAjKBKzwODnsecICUlh3a3pp/Vp5Ilw2rWIbdb+Kkie2
	HFYbL9dlgar2hlDW6SJpN7UyARgxNAL342fNi1fPpCbmE=
X-Google-Smtp-Source: AGHT+IGOwjpQDS3xUsavbVdj9EQ4+rdVS+tUUoAFj+FR3f4QomLNxBhpRAev6/PgXbHv3nXqYNaXQzR7sKpxbD7bF54=
X-Received: by 2002:ac8:5a4b:0:b0:4a7:6ddf:f7d6 with SMTP id
 d75a77b69052e-4a7c05f4aa4mr95903891cf.10.1750948271092; Thu, 26 Jun 2025
 07:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-4-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-4-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:30:59 -0700
X-Gm-Features: Ac12FXzJZonqmi6jy5qi3uqES-hVfv5qq-K7w67Otjj72T2KrMnSYzu3wmfy7IM
Message-ID: <CANn89i+9rX722bpuQV+nNYU1O8fSXhQ_XndzCbD1whN_b_E84w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/15] ipv6: mcast: Check inet6_dev->dead
 under idev->mc_lock in __ipv6_dev_mc_inc().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> Since commit 63ed8de4be81 ("mld: add mc_lock for protecting
> per-interface mld data"), every multicast resource is protected
> by inet6_dev->mc_lock.
>
> RTNL is unnecessary in terms of protection but still needed for
> synchronisation between addrconf_ifdown() and __ipv6_dev_mc_inc().
>
> Once we removed RTNL, there would be a race below, where we could
> add a multicast address to a dead inet6_dev.
>
>   CPU1                            CPU2
>   =3D=3D=3D=3D                            =3D=3D=3D=3D
>   addrconf_ifdown()               __ipv6_dev_mc_inc()
>                                     if (idev->dead) <-- false
>     dead =3D true                       return -ENODEV;
>     ipv6_mc_destroy_dev() / ipv6_mc_down()
>       mutex_lock(&idev->mc_lock)
>       ...
>       mutex_unlock(&idev->mc_lock)
>                                     mutex_lock(&idev->mc_lock)
>                                     ...
>                                     mutex_unlock(&idev->mc_lock)
>
> The race window can be easily closed by checking inet6_dev->dead
> under inet6_dev->mc_lock in __ipv6_dev_mc_inc() as addrconf_ifdown()
> will acquire it after marking inet6_dev dead.
>
> Let's check inet6_dev->dead under mc_lock in __ipv6_dev_mc_inc().
>
> Note that now __ipv6_dev_mc_inc() no longer depends on RTNL and
> we can remove ASSERT_RTNL() there and the RTNL comment above
> addrconf_join_solict().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

