Return-Path: <netdev+bounces-156032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B4A04B54
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8A53A08A8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64C1D63EB;
	Tue,  7 Jan 2025 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ynpekgH1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F8155300
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283760; cv=none; b=HQ3mARm8Kzfy9mYt6DELha+uw8L1AFqeKAS7uldYd3FZcEkKm/aqggm1DzSEjE2pLHEMcJR7GxmY526KXmcod7O5XLs/7ub3EOJPa2g59FGiAXkKPVC0AbjqK09LWcjyMlmP/v2Kh8we656YV/fk1dHEhJeG9hQGjeej5Ocf2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283760; c=relaxed/simple;
	bh=g/uG0KFA2xFsVWS/tHYquXFG1lyxkDkwgZMRHqYNkGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9ReFvvAkg52yt+04UhA1CSr45OULw7qsvxowO4SBHsdrS8XqssosWAd0EPm4mQDl2b0MTJHFLtnESqP83ffKcu55FCZEqWvjC4XNx4qHNxeZTT2+PPnWX5xxRlfaUZ6/KXUOsPW3M/jqixXZVo6gpKV5nXAaXYGBv1eKNEPfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ynpekgH1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaef00ab172so1836673866b.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 13:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736283757; x=1736888557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQM4WxF8oWBwm75fqpNmGwOava6C5bIeY6O8JlEfnng=;
        b=ynpekgH1Jbb1XmjT/orCAUGXGEy9OKxh6ejpbQDn4aE4CwotYYtVRV+GDxyCZporlC
         xhI8VLOzWS1elxR6wz9r9rKfJZ6iHbGvSk4pigjMTg9F2uhXsuu8GtoJ5LmyeeJDzzTz
         wX8j6LuwDtNpzCi22Os3ZTG8bxRe8d4uPFxBiH4paeD39qTQ20kb46nFNnG0zscDI2j+
         L7+8FEBHA4Ae2Vz1Oj5JeajesbsghX/BbX/sj7JP1CIR7ByUcsf28kJMbWj1xeNk9Olr
         6UaZXxfSkeT5x+FjnZEWt83bcvbBLyXOvMeUZWIIWATYUx5hpUgDlf4jS0s+oNNDC7Sc
         HvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736283757; x=1736888557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQM4WxF8oWBwm75fqpNmGwOava6C5bIeY6O8JlEfnng=;
        b=KaJp2TsIir5Je+a1ehvYuwcXks2GCG2MkAc892CJOXW1Ty2EJbxRc+vV31ATHEQ5NK
         YPn7Lw6IvEmkOA6HLlVQOFI4BtIBviLqS3YNnDyitEEC2X1RJhfy6X3IFZNptry4rNRX
         mF2TCPvW/pOr5UA4CojBMb12x+3PerHS878oSeAZYkJY8hc78E94aPd1K+XZEPyTM94f
         CNz5wyjBzitVq+mKYVN0CN3L7qHSoVOHwLNwE46eShbqoFzihraTC2ovut/vVyUsr1HS
         CNhMag0AJEElMhR/Vd4bdFOuMN3NOIC21/gnu+RRal8wUIpc88WhdVln/1qbwt1ApHav
         wdPw==
X-Forwarded-Encrypted: i=1; AJvYcCUjnGhMiuUTcty/nuDiOwpAL0kdYf4uJ718r5DCL4+H7imDeIgtS/pU7gsoybL73Ly/PGrvuYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqeaCb7qsGljie1dBC6xRTMIdVvlnhRXNXTfB1krbTv2KTF+G
	/NubPI5Y/k/ZRIAdtuYfKRXwdbeRKomZu0s7mi+X8/Y9Q/fdipvaa9ocXZlD4uSsEgArKB2DaHb
	K+8OMgR225s4VMW0fNdPgiAwXw2oTADbbjuG8
X-Gm-Gg: ASbGncubQm/x+AGBeLXETeX6APY+ar9js2/VvZYNN82e9zqqxVWKV/CpPGB5Ko+67HM
	yrDdpkMXkikw32FBni2HWza9/h5TEYBaG+4S3xw==
X-Google-Smtp-Source: AGHT+IEfAicJQSd1ccYJ590JHEEoXjf5m5jsR8COcOEer9R/sgxpuAiarbYij8Fo3e4rvlFiuEOmJq1HTHmL0gtEz8w=
X-Received: by 2002:a05:6402:270d:b0:5d9:ad1:dafc with SMTP id
 4fb4d7f45d1cf-5d972e639famr540344a12.25.1736283756630; Tue, 07 Jan 2025
 13:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106181219.1075-1-ouster@cs.stanford.edu> <20250106181219.1075-7-ouster@cs.stanford.edu>
 <20250107061510.0adcf6c6@kernel.org> <CAGXJAmz+FVRHXh=CrBcp-T-cLX3+s6BRH7DtBzaoFrpQb1zf9w@mail.gmail.com>
In-Reply-To: <CAGXJAmz+FVRHXh=CrBcp-T-cLX3+s6BRH7DtBzaoFrpQb1zf9w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Jan 2025 22:02:25 +0100
X-Gm-Features: AbW1kvbNzMw_dGuUGhdVC3tk7WVNJhVzlfq-N940NePrcZb4EfbMRA3Sfyt9HDU
Message-ID: <CANn89iJKq=ArBwcKTGb0VcxexvA3d96hm39e75LJLvDhBaXiTw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 06/12] net: homa: create homa_peer.h and homa_peer.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 9:54=E2=80=AFPM John Ousterhout <ouster@cs.stanford.=
edu> wrote:
>
> I have removed the cast now.
>
> -John-
>
>
> On Tue, Jan 7, 2025 at 6:15=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Mon,  6 Jan 2025 10:12:12 -0800 John Ousterhout wrote:
> > > +void homa_dst_refresh(struct homa_peertab *peertab, struct homa_peer=
 *peer,
> > > +                   struct homa_sock *hsk)
> > > +{
> > > +     struct dst_entry *dst;
> > > +
> > > +     spin_lock_bh(&peertab->write_lock);
> > > +     dst =3D homa_peer_get_dst(peer, &hsk->inet);
> > > +     if (!IS_ERR(dst)) {
> > > +             struct homa_dead_dst *dead =3D (struct homa_dead_dst *)
> > > +                             kmalloc(sizeof(*dead), GFP_KERNEL);
> >

While you are at it, I suggest you test your patch with LOCKDEP enabled,
and CONFIG_DEBUG_ATOMIC_SLEEP=3Dy

Using GFP_KERNEL while BH are blocked is not good.

