Return-Path: <netdev+bounces-153393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655BD9F7D40
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD03168FBF
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEA1224B01;
	Thu, 19 Dec 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1UiBsM7D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D9224AFC
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619096; cv=none; b=iOSRrRVrnCmGIiESKG+3S7k8QC/37kdigpXfUNbLO5uOItC3MLeP+hCRCKkcyMCUH+wqYM//FIpKb6vhACL3aZghcaSFNI7LIQaivbwp+Kw/TL1ztWk82Pq6e1lH+MnHv+M9ZKqXHWoc9pRdq1hD3s73KvbGLyLFNOTs158IF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619096; c=relaxed/simple;
	bh=Ca2/4BHIL+hhFfG0cON5c5tXtxbkGPkC1wh4oOX1vVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAxeBsy6r6AcQnZU40ekv5tDd42MNW+X+X8nvNY36MvlX4xtOgNutL4ZRdUqi+chK6pZ4/32shcA2DsHFUhSMlFSAdulr1zbwFinhF2zzc3viix3gsJRRU5p9zhjyybl0JIKv2/5AqUU8mjZmpRNWD31yzuwzoXvS5/txHtH2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1UiBsM7D; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a818cd5dcbso105ab.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734619094; x=1735223894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca2/4BHIL+hhFfG0cON5c5tXtxbkGPkC1wh4oOX1vVo=;
        b=1UiBsM7D1jcNyEteAxHFKxtnFCZuN94mfszfBecukwF5dwp7wW88nXAMiPqdAFv2Vd
         ZoOIKTMLwwcUTevZnYKJMwlRfrnFRGtzUrdD/18IL5nzrc2AWKzH16op7IDtNHVTK6ta
         u1uAoCCZscuoB5igkHcRWIUME0xTkEkGdRVedl+bhIo0RjbTa4wQR9ep65bR440BKdIw
         PAvoRezrG3Ysz0He312LnkPAxt1Wo7GKBWFsM+xMGSdtlxo4QvS9DlxD9OOPOT+f9uOj
         +TsyrZZFn8cbKBf0SjQG6059BkDXEOtMxIW3jdMdvxAaB1k034noIEHcjZmFjP/REs9D
         KGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619094; x=1735223894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ca2/4BHIL+hhFfG0cON5c5tXtxbkGPkC1wh4oOX1vVo=;
        b=T28aLyYzjyiL2IPZfuyTVIfaRjTfKK++arJtJtnn/y5ZaTS3dG+WqMjLpanR83ngnL
         T4qpR2SAZvVkZBz8ihwrBMbjfPUD/ngQYH2ozsSd5yTMDbe2dSsKWkZ+Vt56EntNlkrq
         Yv+ZDAufDhjAcXkGQuW2/4Z8fQSz0d2ZDmtEdHMonYQab36kfOmPVUZvSkSFZTzk7dKp
         FkNyhddItvMA6VtKwIiwpbDlk7lpiYd0KV1fR9j+4r8ZUOVx57lGI0s08LxELFswsGRn
         1+RpC/Qie9FeIi3X1L5FILTrx3+mcuVoipYDPxnd6w8Azv65oLXfD5TaGHnnoE1OaoV4
         CrHA==
X-Forwarded-Encrypted: i=1; AJvYcCVDicOOw4P+Z/ABbuZvIo4ebiSk6m6hBdtx1VibzWRwFTyQ2XTcrTsAaBzxA3FqUCNVExISVDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXr6IzRPUbM0DOJzAOayhtu58HOzwOLzjELs5YyUJkY/No38e
	KAkFMTeNiGNCRd45b49zRnvze8ZfjZD+BKVGuqwEdMzHblLDSzUjrrR3NVHP5NeuzyBzPWuhiz+
	Muz10pICztuH0h/DQHvl/MMMPgfgDATuVbRaQ
X-Gm-Gg: ASbGnctbZJgfAERGgTsTMP5Tdgtemz3kjaTecPhlrcTKwVT1zok8YqENFJWG3vLOGvG
	IQ4CaLj9w1coghJ4IOEuWVIX5Ni/BvTvHiVMgHDiaMqXpMN30H4NzycmtcB/aNc/CcUQUVA==
X-Google-Smtp-Source: AGHT+IGHpXmhKXRU5RcWd1eJ5xmmDHOj2lWKNqyyxfzzQmVsOBj8zGH9hww+wBq3wtqfYnB+S9iYd3TQqMdLEi7CZ2o=
X-Received: by 2002:a05:6e02:8ea:b0:3b4:1cef:4f97 with SMTP id
 e9e14a558f8ab-3c2530c5b49mr31755ab.2.1734619093680; Thu, 19 Dec 2024 06:38:13
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218090057.76899-1-yuyanghuang@google.com> <CANn89i+1-it-nLix4JHdbt0TRTOoC1GX-0RstfqBmW2b1D_1mg@mail.gmail.com>
In-Reply-To: <CANn89i+1-it-nLix4JHdbt0TRTOoC1GX-0RstfqBmW2b1D_1mg@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 19 Dec 2024 23:37:36 +0900
X-Gm-Features: AbW1kvZfleDPhWBCVOYDpGIfRdOiciBWstbNF2SKqnL0dWq6tvgQTVOSWp7YP20
Message-ID: <CADXeF1HCZ70fEsPWYR+puAa_cbVwmjnF8fn9WDpg1FyNhukYsQ@mail.gmail.com>
Subject: Re: [PATCH net-next, v2] netlink: support dumping IPv4 multicast addresses
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, pruddy@vyatta.att-mail.com, 
	netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Per review feedback in a separate patch:

Link: https://lore.kernel.org/netdev/CADXeF1Gg7H+e+47KihOTMdSg=3DKXXe=3Deir=
HD01=3DVbAM5Dvqz1uw@mail.gmail.com/T/#t

>+EXPORT_SYMBOL(inet_fill_ifmcaddr);

This EXPORT_SYMBOL should be removed.

Thanks,
Yuyang


On Wed, Dec 18, 2024 at 10:33=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Dec 18, 2024 at 10:01=E2=80=AFAM Yuyang Huang <yuyanghuang@google=
.com> wrote:
> >
> > Extended RTM_GETMULTICAST to support dumping joined IPv4 multicast
> > addresses, in addition to the existing IPv6 functionality. This allows
> > userspace applications to retrieve both IPv4 and IPv6 multicast
> > addresses through similar netlink command and then monitor future
> > changes by registering to RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR.
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > ---
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

