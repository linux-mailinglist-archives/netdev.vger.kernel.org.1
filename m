Return-Path: <netdev+bounces-222235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA55B53A4D
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830C7188E509
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375A635AAA0;
	Thu, 11 Sep 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Vf9qybu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6AE20FA9C
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611494; cv=none; b=Po4hUBwEuwbs0iBgOcTGQIq9eLo8dnsDJmchjioqQjUpOA8AKEzrSotw+Ib/KzNgbLgUR7BGIV17TwpV3WsoFMSvITYPWMVCG7fgv+f0sVtYZjp0Ac42wzrhodKr7zBDPKsoe51PpAa7+YZ2Tb9OcNSsBE+goK8h2RHu4ILSd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611494; c=relaxed/simple;
	bh=cxh+4H+Dyv9ZgyB570+HNiz38jFUkxlLcDwPl7DhWU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbLoLkP0MrdZ3opUccMdVCpn8mWhSvFymEThOt2/5Pur8ShdPcNMhCEwrIff3HoO01fOLLVqn4V7J7dkVF6ynHGvFHmPUmFtVX4uO75K/KK/TXQIlESDpV6e5j42HTyk7AqgnmV0GZpHr0+qdngQqYa0sLEEV9oc/UZZzVTz9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Vf9qybu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445806e03cso11171815ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757611492; x=1758216292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZJX9Ls9qUIIeuSmrxfgz9GZtEQGYFYjv7JYiqFKn2s=;
        b=4Vf9qybu5t8aTadjwr2CnZTgEFNzoxl5XcqMYyqSn8392Cy6UPsBsuAKzu8CPirZuP
         eqCrQykwo8laYb4GNTjLZHflZFZ4vfBX60TWcYIly0e9nV4o/gY3XQzE9J2+rSw/IIij
         Pv/3HaWYoi/d6C/GIdotzuHVihvzzK9QzOJ8iqwjCsuAgF4Gq4cHFjbR/cy3sE4O+S6x
         N0up8QrglMm7Vu/O9USL+3ewqMiOGAarDIXCNz0sIT1bUaPfn0hDFaByV9qPxyBiXgLS
         WHHzsvH9BtiWVFHzLcPtosgFjNSMQT3F9YTfRfgr/f4/Mnv2wQcxV5NN9Ufdhf2LhYxF
         Ferg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757611492; x=1758216292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZJX9Ls9qUIIeuSmrxfgz9GZtEQGYFYjv7JYiqFKn2s=;
        b=J7HfZertPCJNXJAB1mwo1VAgqhEySJoey8QP8ZYQjHgac0vQmJuRo5mIW8ilZnpWh6
         hSJRU9tmUj1gMwOs2k6YUT9FC9hPgvLBgEHSkAfsHc/TyRpSBETCHlC2iOcWDbrBK7Rc
         gwKNHw4Ltz6xSccp02yZRJKcNh1feH9GsyGWkLKheqUFK6EzTHnDdOhPbQvcAvgP+osN
         Z2a/8km3+vWdWwujPpKXOvt0l/XFKFlP76tRJjLcxuU8rPztcC4Mwl2a0ZAqIc2vXHnq
         sc5Rbs+r1vkjMLIPHyWxXiYxl8QSaz8BTAk8R88EO7XClcPEji6Mu7BZdgSpAtdERY0R
         xdkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhTVNFwQbZihpvbJvI7yOKm4E0tp6HAgCaBHSS2UFPamUKawJqZ2bDN6ZIeYdQrh+dtP6UzLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmjY9qs3BMUI6xJLSvRza48dZeBPGIz6wxLg3wc4Oq64IuTjaH
	iB9hyk2dGPjwC54FXJ5D4pyNDdmEZGjwLUPfrdRxDF50R/NnPDicAJgV5ZtxwY8uJppAHC6POJZ
	yxjRdU0p6+szhoaBULzyDS2nE7/abNzmDEkA9rK+r
X-Gm-Gg: ASbGncti6UPCZkKN0wvZm+x5BD0ltMQLc3oBZAtTDRj6yrPqFfrRVTqy7j2HM75X/rN
	K+dTrUHyHDnsCXdzECuaYQB1kMS1oDpaGx09ndmZi8EouN8En2bBHyl+aFMM2aJxmBRVRfAhtIi
	0v/U8NooxIrYAobucdqmMqvaYquP5T8AQSj9IH0izWtzl6GvXA2AVzCV7My5gyNZKf6TkjWeBso
	n1je+y1gYqnd+mYlpVMH8o0Kvc4gR76D2R16oobUjZ/mkPk+seVyEMQJw==
X-Google-Smtp-Source: AGHT+IF9PI+WBeOhwe/vVtnhd/kgT7VZm57CWi/Ig0L3/4y8/BU4l+0969uESYgHjBzCufvcl/JrFazANYC+2TmpiQo=
X-Received: by 2002:a17:902:d490:b0:25c:18d:893 with SMTP id
 d9443c01a7336-25d24bb33f9mr2187015ad.22.1757611491843; Thu, 11 Sep 2025
 10:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com> <20250911030620.1284754-7-kuniyu@google.com>
 <CANn89iJnOZ-bYc9bAPSphiCX4vwy4af2r_QvF1ukVXF7DyA4Kw@mail.gmail.com>
 <CAAVpQUA3cnUz5=2AYQ_6Od_jmHUjS0Cd20NhdzfDxB1GptfsQg@mail.gmail.com> <CANn89i+dyhqbd0wDS+-hRDWXExBvic4ETm1uaM2y1G9H4s69Tg@mail.gmail.com>
In-Reply-To: <CANn89i+dyhqbd0wDS+-hRDWXExBvic4ETm1uaM2y1G9H4s69Tg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Sep 2025 10:24:40 -0700
X-Gm-Features: Ac12FXyUqNzQMeub63OhezAV66a-o26rNFMq501Djk6HARPrAK9rf-c8Hn1AqGY
Message-ID: <CAAVpQUDgfLp3Ca8M0Z-Q1Jf00ufDsJJQCcSASTGBJkKTOGMO9A@mail.gmail.com>
Subject: Re: [PATCH v1 net 6/8] tcp: Use sk_dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check().
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:07=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Sep 11, 2025 at 9:53=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
>
> >
> > Sorry, I missed this one.  I'll drop this patch and send the
> > series to net-next.
> >
>
> No problem.
>
> Main reason for us to use net-next is that adding lockdep can bring new i=
ssues,
> thus we have more time to polish patches before hitting more users.
>
> We also can iterate faster, not having to wait one week for net fan in.

Thank you for explaining the reason.  That makes sense.

Then should we keep or drop Fixes: tag ?  At least it will not land
on the mainline and thus stable until the next merge window.

