Return-Path: <netdev+bounces-168280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA0AA3E629
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F047F3BEA2F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189EC214237;
	Thu, 20 Feb 2025 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXNz1nBK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D91F666B;
	Thu, 20 Feb 2025 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085035; cv=none; b=YEjM3671s33hOhLTrHQFqjG8aeVzI9/OSYeUMAkqe31QwTZ+H7aHpxRR6x6hAufq//vPzTL7Vlukx/2W8mgnkax0gQmj2kQv0DzdbuaI0D+VH/Aj+dVkIVBm1TQ0Nhsb0CgBlcjwx4fKB+fSwUOToFDevQJegPctxtq37LCN2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085035; c=relaxed/simple;
	bh=dlZNfarQey9h0/TyxX8JMP4ofEsYAogngKHqVFHdG+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bf+Ye//yFNbuqaYSoKzUmdVjYqy74KG+WzZVbrWi27zO2AvMFrNkHqbYUttuzkytM2z3FsUQXAe7T8JkdcEkZ1mI8xX6mEu1TbSzFZu8rUdnFYqvSqSVXGDZs4/tBxwLnXGmUCGWgG2hVu6bASmXQFQ5g3qn0Xc/JvK29i+yYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXNz1nBK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30761be8fa8so14490501fa.2;
        Thu, 20 Feb 2025 12:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740085031; x=1740689831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwmANW11KcJ+o8GEIBk1sW/g+43on2pUAfhOGICBmhk=;
        b=fXNz1nBKcqu02fLNmjJBQOu3o8+iDqjrdz5Pwjzevn3paPhBYacIYAUDfmNQ24DwYy
         G5ul13no4nNuTRkGShF6k/Zo/QX0ktCYJt6D2WrgGae+SZBz2nf3bClNkebUrM0pMvH3
         rcfPz7Tn13a7dTKQKgZALfYuAor4n54n+qMCaPpnWidsQon0pJWJoyykObM72w7P3e5+
         BOBTSKRfbwDvPpm13qcGLX3skKCpt6tzC2X6Rdl24bkWIpfFu90hz1B8oc7Ka8r8MuHl
         9CG/mu6ciz0cWqfqM+zOiiZOVxXSGFJUKaqfc2u8yElYH8IzOgsRHUoVGJo0H6pSJiRb
         jppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740085031; x=1740689831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwmANW11KcJ+o8GEIBk1sW/g+43on2pUAfhOGICBmhk=;
        b=lsv+Puoefjmdih0t7w3r0UquanF4josfKo5yT4b+jYu6wMzgqdEg2z+0dakBntVh5M
         LXEfUJGKvqFsfKG3BF9T/iqskwTaqhhtQ3B/EmUuJeyMJnrqIUEbTRRGfEBy89snco6P
         BgFo07lxmpN7+KxicxHk3kChz/7SGrU7f+rbmnr/kMgM8tZbBmzvXiW0uBQLMlN85e8L
         RIvFoH48/pV7gsbMmUPuRZfhOH/L9BfzO00xvSsEJD3Vn1GkEoB5VXHauR50vSHn5F2S
         Obgvf2n5WLiOz1Ysm9l0WGSqdXxAhAEKI2gQ1qEemzYMMgUakuBS5fyQvkNLIBD66PhF
         80LA==
X-Forwarded-Encrypted: i=1; AJvYcCUd6dHhjW0MRnC5OTWJcxeQi5DuWtiRbrLE+q6Cl4o3VksRykgKngIlBdym5t9NB6zQafiWQtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPt8VplO9rKtCr/SMhjsGcs5RMtSPRwaWF45G0pJOZhfv6kKW
	YTacRhbJ9EaZ+C6Q1Z1qJQHYnZVqDzq21LC+m1U+TE/RVI35he7m2bsmh5JnrnsWTresXJsH77t
	GbKBVE5ZT8nvfTgHgQDDnPutsIoq6Dv3oNGg=
X-Gm-Gg: ASbGncvlRfxrIcRfMSRGszWsxCZcyRKvfLIHmS08lfUfx7A6LwIdLA0YZRFYSleEU5b
	zjA+Ry8J8WMcdFY8sI3CIjdnkLYD4vNZsJJBDvf8GU0Y09QUbswBT4nNBdIrv81CG4gzjgss=
X-Google-Smtp-Source: AGHT+IHjKlzi4inFbnRyYsAxgjJ5CEHo4alCTy1GdaEVU9lgdOJ+LExmaprvddP8a8hLPsV48bltQVkazwwifdohhVw=
X-Received: by 2002:a05:651c:1512:b0:309:1d34:1089 with SMTP id
 38308e7fff4ca-30a59777b2amr3014411fa.0.1740085031086; Thu, 20 Feb 2025
 12:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220202402.1986578-1-luiz.dentz@gmail.com>
In-Reply-To: <20250220202402.1986578-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Feb 2025 15:56:58 -0500
X-Gm-Features: AWEUYZljrNKvrUtsOJQuYpVBKifIK_icaUHFVaCZtN1qRCzToO30gBDQg7KmiMI
Message-ID: <CABBYNZJqMOhbVvJEKMOAvQOv2_3NnJW2VPCd5rwvGck5Bscecw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2025-02-20
To: davem@davemloft.net, kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 20, 2025 at 3:24=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> The following changes since commit dd3188ddc4c49cb234b82439693121d2c1c69c=
38:
>
>   Merge branch 'net-remove-the-single-page-frag-cache-for-good' (2025-02-=
20 10:53:32 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git t=
ags/for-net-2025-02-20
>
> for you to fetch changes up to fe476133a67a15bbe8c1357209e31b8d9a8e00c1:
>
>   Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO (2025-02-2=
0 13:25:13 -0500)
>
> ----------------------------------------------------------------
> bluetooth pull request for net:
>
>  - btusb: Always allow SCO packets for user channel
>  - L2CAP: Fix L2CAP_ECRED_CONN_RSP response
>  - hci_core: Enable buffer flow control for SCO/eSCO
>
> ----------------------------------------------------------------
> Hsin-chen Chuang (1):
>       Bluetooth: Always allow SCO packets for user channel
>
> Luiz Augusto von Dentz (2):
>       Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
>       Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
>
>  drivers/bluetooth/btusb.c  | 6 ++++--
>  net/bluetooth/hci_core.c   | 2 ++
>  net/bluetooth/l2cap_core.c | 9 +++++++--
>  3 files changed, 13 insertions(+), 4 deletions(-)

Please hold on pulling these changes, there is actually a problem with
Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO, I will
send a new pull once that is resolved.

--=20
Luiz Augusto von Dentz

