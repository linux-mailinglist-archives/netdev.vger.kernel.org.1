Return-Path: <netdev+bounces-142419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 937F59BF00A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29327B21220
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357B2010E5;
	Wed,  6 Nov 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zaudkohm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD518C035
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903119; cv=none; b=KoCOPJFJHfB9PmtcLfUEOdjEPlgJ8aI+ZQcLAuU8YDbADGe63b2sD7bDRSK41ycaocQ2JA8dXvta6TDlt72q4VouyIFkI6f/ckblBnkUBm0aVqHx+ca3Tz0EP5bQ5Pna4OsfYVbNXFLHFNHzRn4tfLmg9HHQn3D54V4AVmQtkg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903119; c=relaxed/simple;
	bh=5XBXm/t219TbQ1bhLbyV7eTIfHv1rGlfcAs1GYwD52I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ip+REtS2oeuZEijHtP7rLMRHJBFL8QmzDWXHCuAEnaWje/tYinAwTioO+wamR7bknv22fbGs3+jCZzl/nV58va/ARwJbv1j4t8qLpgmazRlvqEs32IYrt0wuVDhOzRKMn8lVwjeoLtR5cJNwfuxPHTC9dEUlSC0Lu9BtZnrM+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zaudkohm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so8063156a12.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 06:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730903116; x=1731507916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9ZtsPU722iUHto6wZ5BXURQYo1+yVx5svsngmPvpSY=;
        b=ZaudkohmuDL8fK3bVZWrcrzAjI0+HTRoqR1ggojCKXtErD4lXnqUwXXqELK3M+Jopx
         YTli5/UrcQgeJdA6rfSTlGxS1RS4eCEMyUr86F9BwDsc07dP7Gc+6WlUJI7OMh82W3Vr
         mwxFYddezY97RIUYohEA92vRG1QmdqgOZ5KjY27KWmdJI32/vBtbk72V/cDdjZhlMnHq
         1hR3rtXTGarPYuKkfeTLrdg6bgwMwOZaC+xKCZmoGHYDEMlXD7uTwUBiCwMILrCs9X9i
         p9gH5zP2EkLWVghLTRCOG7ukE4XW7R8PliTQ0oT9Pak0FsDz+SQ6yLIurjMnp9LynkwU
         0J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730903116; x=1731507916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9ZtsPU722iUHto6wZ5BXURQYo1+yVx5svsngmPvpSY=;
        b=X6EaUZX8BiBGJMFGVNKo7WgLaNQOr0nJVs00CcWwP/ifSB2rfhbysRF3fZnpXtETvA
         ZmC9XGOJb4YJE1nKsBwEav913bcseYA8affXNFyCRZFmjdHykTd7QdVbFCHZryqCP4OW
         i4N8L27Qbzsvrpn1s2EXM6Y7H1VEftQvjO/FvhTbD5YcJ+ltsApjTasL/JiuYj1EcktX
         mjh/SryBa5j9OOLs8h8YGbm/XD9l0jcJOjrIywhYb+YTL6sMR/R9b+Z29goAQe6pzcTh
         /9W+H4clOovugHFrd9WtYdl3VFs1kJ8yo1W6yxC6UCCdvTqnfOzxWAJ3iSX8IoVkl+lY
         wJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvL+ddfCzlPxNNyJYBY1l9itIIQa0Oqc9e2/i5mIZ0g+xv1j2g2wAXqzvZwX1XGhNAn5VFmDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZ0cubekU+g7gmn5QMAxzwo50XyA8lHVSKf3dkMPJnbXNVZ3M
	w5RvI/ZDa2nINJBPsebQLNBpa2tn5thZLZ/rwVb0OsquCyXWMMQ7qH9OgHhzC1YOlfM1ZR7dBI4
	Ivj8g/Hg809AM/99dkS4m0TZxrl1cBEATfrbn
X-Google-Smtp-Source: AGHT+IG3P25dOBySYmdhxq/dOWfwi7/cJZf36dd+dSJtk8ssauZbPk/n4U1y0lhU+laNiu0I0pJZ8jUP+y4Wcn3lV1I=
X-Received: by 2002:a05:6402:d0e:b0:5c9:76f3:7d46 with SMTP id
 4fb4d7f45d1cf-5ceb928c9damr13318379a12.21.1730903116303; Wed, 06 Nov 2024
 06:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106022432.13065-1-kuniyu@amazon.com> <20241106022432.13065-8-kuniyu@amazon.com>
 <ZytH1CjCShr23AoC@penguin>
In-Reply-To: <ZytH1CjCShr23AoC@penguin>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Nov 2024 15:25:05 +0100
Message-ID: <CANn89iK8Owkcc=sTWx6pg99MT0UxMAPkH0+JNqkDc52=x+qPMw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 7/7] rtnetlink: Register rtnl_dellink() and
 rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 11:41=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On Tue, Nov 05, 2024 at 06:24:32PM -0800, Kuniyuki Iwashima wrote:
> > Currently, rtnl_setlink() and rtnl_dellink() cannot be fully converted
> > to per-netns RTNL due to a lack of handling peer/lower/upper devices in
> > different netns.
> >
> > For example, when we change a device in rtnl_setlink() and need to
> > propagate that to its upper devices, we want to avoid acquiring all net=
ns
> > locks, for which we do not know the upper limit.
> >
> > The same situation happens when we remove a device.
> >
> > rtnl_dellink() could be transformed to remove a single device in the
> > requested netns and delegate other devices to per-netns work, and
> > rtnl_setlink() might be ?
> >
> > Until we come up with a better idea, let's use a new flag
> > RTNL_FLAG_DOIT_PERNET_WIP for rtnl_dellink() and rtnl_setlink().
> >
> > This will unblock converting RTNL users where such devices are not rela=
ted.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/rtnetlink.h |  1 +
> >  net/core/rtnetlink.c    | 19 ++++++++++++++++---
> >  2 files changed, 17 insertions(+), 3 deletions(-)
> >
>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

