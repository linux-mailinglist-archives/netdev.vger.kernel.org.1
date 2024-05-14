Return-Path: <netdev+bounces-96312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 459028C4EFA
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F4D2829D8
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85F7131726;
	Tue, 14 May 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/WyGQgi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA5DDC0
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715679920; cv=none; b=hbBACj6Ch2oeWhvxlJavnTdq8hAPowlTJPBGWmSEy4mg0hYxGcNjL/4ETJE1b80rvlrHYOZrq+LWih6VETYTxPboNbYL6Ifn81xgHfxgJYlK5yG9p04SX/K7pJ4kKw5VgxIsBTYjfSWAt7Qgnc5G08H82K7eI7sJnEMK89Jz7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715679920; c=relaxed/simple;
	bh=yZmq0okcCnqLhmRS4dqO1SD0Urg4yXIMXoYdQDaWbiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMDuwCOMugWkGjqMr2OkpwWz5T3r3KqfXZkikRCMpeXp2ICi6oUTd2hsZNUex7e60xGflzywXcQ87oQCkK3qrgko3sihp1NF6Wo537zKplj4UgnCEL+2BS0VILp//In8iU083eZZ6iAx3/S2lJZsKErmd6dXXvRIn6ST5S2hH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/WyGQgi; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso10059a12.0
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715679917; x=1716284717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=airENu6ylEqFhN1vdFCDs5txD+xlGqEzSphkcNeMR+8=;
        b=B/WyGQgied0fH7g4QMJqQerCm03bEb1IaBQHsZNcbs5Fm6Jd8V3kB8+6nE0wM0NRTm
         8JiMQCgYSJAm5+0ExReFMbJfKbdPthbG+3qzXXWAGxEhivXq7DKALWh6sgiBRDS/muVz
         otyzylFEO4eHVI38OcoDJ5EQ86YYWxh91NBb0m7a6HIOx8ELbQkCT3bg474TQmdEQdlV
         8HDs93i5NwTB65ZUpfFRI7a+mHnUj9fy+4khLaFGvgzElNBpVp3Quw/hnmhxe1ZqmfCH
         lZuR+rZBs/LqdJTQk9bMGPqNeYEvZ+3ptK2lnlrm8ofNxRsjv1UGwAeXQf8dZrUyXu/m
         qcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715679917; x=1716284717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=airENu6ylEqFhN1vdFCDs5txD+xlGqEzSphkcNeMR+8=;
        b=d/vfSrI2E+OVT5l3dpO9xnSlKayP1o7YCtSVEv3wPMDVL45iB4aEqouhoslZR1z9Lk
         h2me3ubg1OAGsjfYz/j5wabQ0GW2p1tmuyto2WVuRe9t2yrBh0ZzpR4YRPduQcjG+osM
         khEpTylCDUsPyP28yEfxa8a6It+jTuX/wpZ5dHcpT8z0ig6wbFP9cIsJ2gLqTE/2/ThG
         zoGnK7otnMqWnwz1fjOnBh4ajmqFWWhvnGEbZ215Qmo+7GKRmWizCx+eZOhEz0k7TILC
         YejftpgjVZvNCq5YoXiL0wCojxhILnIrcuo+/Pf9XrwauylS6hDC1SqA//NZIXfGWnRq
         b6mg==
X-Forwarded-Encrypted: i=1; AJvYcCXL5vO4/gN5v64PorUsNrApAyoyyKVKuzM3ska+cKiPGtnACvToNMC33MECi3gxWPTZo30vEILZ3qmGIDyfq8/sGFiYa/oO
X-Gm-Message-State: AOJu0Yw8cqCleRhYwdfbcl90DF85Kxyl1xvV3uNZdKLuW1mWrL2j8p/G
	atA5vwR044Xka+HcqzKMumi4ATWZewJ2fZBd2f4w0cZqVKVL4vHqAgSFNlBoGEY9fA2VAQ8gvhV
	wKDAm0KSIhbTb+/SAxygfk3Xdpf09zNlDlS5k
X-Google-Smtp-Source: AGHT+IG1ONB0Ja4FEK6JJKGdAnvXzJGDpubK5BHTglpYDkO3uSRCAfv7zxtjT55vLKe4idWBJ/iQUxhBCPHhn2dRvUw=
X-Received: by 2002:a05:6402:230e:b0:573:8b4:a0a6 with SMTP id
 4fb4d7f45d1cf-574ae59240dmr454751a12.5.1715679916852; Tue, 14 May 2024
 02:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com> <ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
In-Reply-To: <ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 May 2024 11:45:05 +0200
Message-ID: <CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for GRO-scheduled NAPI
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Realtek linux nic maintainers <nic_swsd@realtek.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ken Milmore <ken.milmore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 8:52=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
> default value of 20000 and napi_defer_hard_irqs is set to 0.
> In this scenario device interrupts aren't disabled, what seems to
> trigger some silicon bug under heavy load. I was able to reproduce this
> behavior on RTL8168h.
> Disabling device interrupts if NAPI is scheduled from a place other than
> the driver's interrupt handler is a necessity in r8169, for other
> drivers it may still be a performance optimization.
>
> Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is s=
cheduled already")
> Reported-by: Ken Milmore <ken.milmore@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index e5ea827a2..01f0ca53d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4639,6 +4639,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void =
*dev_instance)
>  {
>         struct rtl8169_private *tp =3D dev_instance;
>         u32 status =3D rtl_get_events(tp);
> +       int ret;
>
>         if ((status & 0xffff) =3D=3D 0xffff || !(status & tp->irq_mask))
>                 return IRQ_NONE;
> @@ -4657,10 +4658,11 @@ static irqreturn_t rtl8169_interrupt(int irq, voi=
d *dev_instance)
>                 rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>         }
>
> -       if (napi_schedule_prep(&tp->napi)) {
> +       ret =3D __napi_schedule_prep(&tp->napi);
> +       if (ret >=3D 0)
>                 rtl_irq_disable(tp);
> +       if (ret > 0)
>                 __napi_schedule(&tp->napi);
> -       }
>  out:
>         rtl_ack_events(tp, status);
>

I do not understand this patch.

__napi_schedule_prep() would only return -1 if NAPIF_STATE_DISABLE was set,
but this should not happen under normal operations ?

A simple revert would avoid adding yet another NAPI helper.

