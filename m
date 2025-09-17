Return-Path: <netdev+bounces-224139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B24B81259
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A060462AE9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687792FA0E9;
	Wed, 17 Sep 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVgTlUEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A990C2F9C3E
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129632; cv=none; b=MAqt/+AvZccM78iC201bW2ii8sIu+zxgiABAxf93KzKSdOsQrWJoxBT60rntKZWgoGkOJIaEXwQLru/jW9yf9Kdhlg0W6+hWHsJl9dsKi/kQ/OEP/ozwLFOWvpFBiG+hEa7ILmRpHM8IL0AJNy0590JtPbm2IkfsFPjN2QZOiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129632; c=relaxed/simple;
	bh=/vy1AWwaIm2CnLmZbXU2CpyIRzkKxxughA8uZl7Q2M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byWGolKUw6hN0WdFmt5RAowWdW7AoL5smTJnbk4DYo0agdQM6PumDWHke97a9Pqq8j2sIUGcOJ/Pp9aa6SSWZ0H0RHE0KnydqAOyQUEtj8UchrnnU5zKnNxJvHmmy4spQAgtSRUJRzX8uqCcAGt+hzG+ihTfhvaM8W6Qm/DFmvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVgTlUEO; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b79773a389so721181cf.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758129629; x=1758734429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+LfTPWxGtESwfNdYqgO0bM4lV3SAmEoBrc7Qa6udhA=;
        b=AVgTlUEOFXUZvlOD5kzof+jZH9Szy9DQ/fbsuSBs+4llvk32vRp32MiURE39FFovC7
         T+COX7JRDYVj6dd/Y/qk7Y6h0p0jea48nMbjaPj5WGJu8tngpwdr//gO3AIRwIl4Nigz
         tOM1r00ZkI8IkbUBBgV9N772ZAeXVmLKRdbWULkjhUFFng29bfmh/HpuhECn1J6KiLS0
         eKLMPwsY7rVVuuTd4xIdti/kK1dlfkAlJBfpvAX9+iLdhpAou6RObMCbIO8sRYwIfgXM
         ZXxMguktQb7PvAyp0m+KvshMZ+1l5XM3UcKhH366UzwkavzXJXlCBrcwXJwpCDpPbO3W
         nK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129629; x=1758734429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+LfTPWxGtESwfNdYqgO0bM4lV3SAmEoBrc7Qa6udhA=;
        b=sdeNt86RV0P1TRre2hQjizYwAptAKt0l/J4QDXwx9jD6mb4zzlgZNG4H3Ya5drc7Gf
         +n2TtbewkdNT6zsnbLINTinWrFU1sx55zpAfgfv7w0F0jfUfMUTNVZbZglp4og3NWxhf
         1tKI8ZTTHeAlv4GBgoK9nUyWkKxd3YSa+1WMzT4rcr3J9GYp+OEWyH4eTzDj+T5SNGJB
         xrqsgGgxnjWWlp96p1/kDU0ouyCA50JbMiMoOu4fGAimLeVn54QVu7SDUPnVuPCZBIfS
         b6yhMANMFO5q0Pf2rlsyF5P/GqnWxQJIaX/Hj8ggr6uq8/ncfe0lUIEjRZJ/cJXmLolJ
         sN4A==
X-Forwarded-Encrypted: i=1; AJvYcCWmksUINFrt7tS3RtoYN0gFpZdahSrbTpL0/kNu7h04xUYs//OKg+kIm3874L17HKCt4sq1Z5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2m1Gg/Ff/f2pulG7g1A6Tk5xy+7tOt3DUqgt9ltgr7FIjSxyj
	7umtd7XEpUe7zAAjIL7edZHDnjUVMFv83wYFwXlSyZLpw7pIxYLr2u8rdlV9cCRahlqYoK0+PEP
	p6dBHXHWsC5TwFuQ5erJSaON8sWkYxYxnQpqwIN0I
X-Gm-Gg: ASbGncuRNbG+jLS3867ZmwkJf5M5EeScQSq60VxKuEuFWC4/SSSxs70SJ/5+9As0kSJ
	EVFDG/robf124uwBze2SFCdSEppiOeuvqtGatkqTt4VHoaGfEfBo3RbRsj2SkDs9XISrIz/SVmv
	3E2L31uW8ZTnQWO6FG0UfgyruHeHJWiH64GxQg+qxrAgvO+lDTmgl7dQQ3THPXUhHymuvSl59bN
	15dHcpYteNXqdQU8nnE0B4=
X-Google-Smtp-Source: AGHT+IFQDui72xfWFBil78fA+RutTLvzXuM23RmVZw5RDPSFC0t/VuO4PKRhCwr70nXCULFwZVkRdnMlqxM9P8muvq8=
X-Received: by 2002:a05:622a:5d3:b0:4b6:9b2:e83e with SMTP id
 d75a77b69052e-4ba66c1e0f8mr31755291cf.24.1758129629027; Wed, 17 Sep 2025
 10:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135337.1736101-1-edumazet@google.com> <CAEWA0a6b5P-9_ERvh9mCWOgbH6OYdTUXWVGgA20CQ5pfDC2sYA@mail.gmail.com>
 <CANn89iLC+Gr9BbyNQq-udVY-EZjtjZxCL9sJEpaySTps0KkFyg@mail.gmail.com> <CAEWA0a4x4XMZKtpz_pNKruC4zwjETVxUuEMs2m_==Dpib_Jrqg@mail.gmail.com>
In-Reply-To: <CAEWA0a4x4XMZKtpz_pNKruC4zwjETVxUuEMs2m_==Dpib_Jrqg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 10:20:17 -0700
X-Gm-Features: AS18NWBe_Ohe6j0QfjVQ8V4ffOaHdFwMRrHPQuT-vJAPZqZF3jpye1GAnMAEvcA
Message-ID: <CANn89iKZDvL9vKbmDa4ivnrm11e0fc65A-MXs8kY4MxR0CnGTw@mail.gmail.com>
Subject: Re: [PATCH net] net: clear sk->sk_ino in sk_set_socket(sk, NULL)
To: Andrei Vagin <avagin@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, stable <stable@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:03=E2=80=AFAM Andrei Vagin <avagin@google.com> w=
rote:
>
>  is
>
> On Wed, Sep 17, 2025 at 8:59=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Sep 17, 2025 at 8:39=E2=80=AFAM Andrei Vagin <avagin@google.com=
> wrote:
> > >
> > > On Wed, Sep 17, 2025 at 6:53=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > Andrei Vagin reported that blamed commit broke CRIU.
> > > >
> > > > Indeed, while we want to keep sk_uid unchanged when a socket
> > > > is cloned, we want to clear sk->sk_ino.
> > > >
> > > > Otherwise, sock_diag might report multiple sockets sharing
> > > > the same inode number.
> > > >
> > > > Move the clearing part from sock_orphan() to sk_set_socket(sk, NULL=
),
> > > > called both from sock_orphan() and sk_clone_lock().
> > > >
> > > > Fixes: 5d6b58c932ec ("net: lockless sock_i_ino()")
> > > > Closes: https://lore.kernel.org/netdev/aMhX-VnXkYDpKd9V@google.com/
> > > > Closes: https://github.com/checkpoint-restore/criu/issues/2744
> > > > Reported-by: Andrei Vagin <avagin@google.com>
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > >
> > > Acked-by: Andrei Vagin <avagin@google.com>
> > > I think we need to add `Cc: stable@vger.kernel.org`.
> >
> > I never do this. Note that the prior patch had no such CC.
>
> The original patch has been ported to the v6.16 kernels. According to the
> kernel documentation
> (https://www.kernel.org/doc/html/v6.5/process/stable-kernel-rules.html),
> adding Cc: stable@vger.kernel.org is required for automatic porting into
> stable trees. Without this tag, someone will likely need to manually requ=
est
> that this patch be ported. This is my understanding of how the stable
> branch process works, sorry if I missed something.

Andrei, I think I know pretty well what I am doing. You do not have to
explain to me anything.

Thank you.

