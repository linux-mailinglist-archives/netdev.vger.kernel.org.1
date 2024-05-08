Return-Path: <netdev+bounces-94615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876308C000A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FDA1C22A60
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623DB2575A;
	Wed,  8 May 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="feHQf1Ub"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CF77624
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178774; cv=none; b=Pr4I2UuZXM8cXFwbaafnr6hXKzyKidPC3DZwKYos/UlIoKH9UoQ8a4RZ1m+g01q8djWEgzCuSzlBUPKUuBuIp4NvGC7G/yM4yZUWzX2croXbuyR/+sWzb6e/+NgVr5SrPv9D0qji4WG9jjtGV/KYmmz6Ofkj/8H45v7E+72NM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178774; c=relaxed/simple;
	bh=Rvt0FRjOjq3HFrcM20zZK769YoV1zESrYxd4VRtvDV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9TXRg/HeIS0Mkb3QbQwLPqEwq4iQdFp+DpR+vwE7GpKUZBdpTp3PJ0Dj+3lJTn+opiLPMst+nMCREGU86vdLqE7QXJelPJWA2qeg4GhvcdZB1gJ6wBCuVMXnFsxtpfW2xoixvEq87qvItup2EcnGxJt9jKyN7nqvQi3fqEfdnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=feHQf1Ub; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso12699a12.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715178771; x=1715783571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkLfY1ciSibBPQau9xDq8UKiI6bkAs9KYMM1v/xxO6M=;
        b=feHQf1UbrerkFlb24QbefPCxlWi3E7sXVoi0qE1NZX5Gn4i7ugDZYLFCpoSF2vUHVR
         KtSrZ7MfCQR2AIZ4d6REQdiIf/PSrPzlInbmxHvgYtp57wl7dah6WUvdiB5KR4s6qWQu
         9KesP01pQFndHY4kLDZOGgMR0fWEUp709xRAi540IWN7mDec6UEmxq/m6C1mkSGUfqTz
         ZLVYfDHhVF9CF+VKXvDtcwHjBgWzVZrNF6wM0MUO1mC+Afah5rUeVg7vcRFL5yxCQtGP
         /CCBjB0uBsZ5L1zHWHAzkgL2n/jUptyIn8/5RaqzhDl94phrUxYS+31sITpaOPFF4gdl
         +cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715178771; x=1715783571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkLfY1ciSibBPQau9xDq8UKiI6bkAs9KYMM1v/xxO6M=;
        b=aWzan3ZBslTWMDA4dNrZGMBK1FoiDdxvOWZKp8coPOm0EaHdXkLkQNXF43lowtjeBL
         MKD1MGPbcb7+aQXOaepEtzm7uqNgPpiYIVNvTVjJmBUo6lwT4/CzfSuKg79u5G17ckn7
         QZ+mHaBHwA6/ye5tYN6y86s1swdxYhxz+e19+iTtFJZ9YDMndeJeJKU1kEXs5QYdHwzN
         5YuMEQX7vd38vTrhlDsKwNYC2tkRfLpu6hIV0x/DwkNewfpxiIXiN0IbXkO8cHeRixvk
         GQRi0bOqFR+68UeFqf4MrFOO/7gaWpt9FMbaE4Kux7pqd6cG8R7CbFAjzAruIcL8fXGV
         ci+g==
X-Forwarded-Encrypted: i=1; AJvYcCWIRIQPp4r7aiafixVh8eES8mWPWOlcsD8XRijNFQ/iuXy9AfvEKpXYrTBsePCCwgzEjYsewWoyCGUjKrNY2hd2EqtYmwaP
X-Gm-Message-State: AOJu0YzFh8iqoAK/qS+XRcBE8z4bKeWCUjWLmJHXCSU5TPFCLvuNw1tO
	V75OVZUT99xF3bre215/5nryrKYW96bF68yxDNvhyf/JZ03ofX0XhFRFNPhLQCm3OcdNNqrqTpU
	pzfTR0FrNTBLRdTDlNLSxGEAmV2KZ4qesdcsg
X-Google-Smtp-Source: AGHT+IHzV+id9T78pX9Ouwc2CFvxOONuapL13pSZ6l/CsxGEPFjPJFpqYhX71qCnYEu1hxXfTZ2Nl1WZaw8YQgiIhBE=
X-Received: by 2002:a05:6402:3099:b0:572:a154:7081 with SMTP id
 4fb4d7f45d1cf-5731fea28c4mr215902a12.4.1715178770611; Wed, 08 May 2024
 07:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508134504.3560956-1-kuba@kernel.org>
In-Reply-To: <20240508134504.3560956-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 May 2024 16:32:36 +0200
Message-ID: <CANn89iKpZ79f7nP5HtBfmN_m_KyO0MZ5m2Z53RNtQ5Q=e3WC4w@mail.gmail.com>
Subject: Re: [PATCH net] eth: sungem: remove .ndo_poll_controller to avoid deadlocks
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	Erhard Furtner <erhard_f@mailbox.org>, robh@kernel.org, elder@kernel.org, wei.fang@nxp.com, 
	bhupesh.sharma@linaro.org, benh@kernel.crashing.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 3:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Erhard reports netpoll warnings from sungem:
>
>   netpoll_send_skb_on_dev(): eth0 enabled interrupts in poll (gem_start_x=
mit+0x0/0x398)
>   WARNING: CPU: 1 PID: 1 at net/core/netpoll.c:370 netpoll_send_skb+0x1fc=
/0x20c
>
> gem_poll_controller() disables interrupts, which may sleep.
> We can't sleep in netpoll, it has interrupts disabled completely.
> Strangely, gem_poll_controller() doesn't even poll the completions,
> and instead acts as if an interrupt has fired so it just schedules
> NAPI and exits. None of this has been necessary for years, since
> netpoll invokes NAPI directly.
>
> Fixes: fe09bb619096 ("sungem: Spring cleaning and GRO support")
> Reported-and-tested-by: Erhard Furtner <erhard_f@mailbox.org>
> Link: https://lore.kernel.org/all/20240428125306.2c3080ef@legion
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

