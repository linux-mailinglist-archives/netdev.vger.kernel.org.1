Return-Path: <netdev+bounces-63883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ABA82FE8E
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 02:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044B21F24403
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 01:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0EF15B7;
	Wed, 17 Jan 2024 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WSVO/x5f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCE138C
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 01:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456289; cv=none; b=lKL/vZ1iAWaeDW9gSVtMQ+wVtErSVTcXAM+RWyNbxpLEXzTcD/oe+r5n7yda0bDqjEROr5UWjOunA8uiTdZkfeaGGS2+wy/jeMY+usqRk+uuV4CW+wMZN3isfDdh7AaG4hVi4eu2czpn5hQEnbm7DcPFTzpgPWn/7DgBukDpoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456289; c=relaxed/simple;
	bh=JiFl8+epB08Zl1NjWmOkd5YBmmVt1tz60AanHbyhe74=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=R4d0u7l9mlHLN2Cus3nNITtldCxrdK1EqJgI+bJTluwsvT4SE+yM2GSgKBpggicbTxbsIttD8lskkUrQYSH0QBvIIHwJcRlUizWiljCK6IPtZ530hJQNBFgzhg9+trSlHZRb7ta6JuJ/wW8QWg0iOfTmAfjyGAbb3yHod4LYkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WSVO/x5f; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd9cb17cbeso7965171fa.1
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 17:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1705456286; x=1706061086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuqIUbDsdh5jhxBSCU/cWA/zJ4KgisT+JkTQXpz8Tck=;
        b=WSVO/x5fPuwycl8CKwhFYhlFQ2iuk+/Q+WP73E2OWp47eDqAZvO8JOgOZjyBuc1Cn0
         AJ7awd+USytZferI/JjYDnK67pQQrV5LeAtKJVvaG9Zmsj8neM14oOZHOoqqBD4ko1OG
         Y9uUJfNsm1Nxaf6gicO+7IZ5oQXUS0ez+d+psJGBMCIoDgING/OxL8ZoXImz2aVj9UxK
         6wAva0pJ0yom/6k82pjnXIAxA9fGYmiwIIPI+eFR+y+cZB1/dORnG4JYWuI0JJdouju4
         60ve3QcDn5mP1VKCyT/c/DWIcNwNCr1vSLp7yQMGiYORvEAih8Lc79pNC3TfBI2n/GiM
         MzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705456286; x=1706061086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuqIUbDsdh5jhxBSCU/cWA/zJ4KgisT+JkTQXpz8Tck=;
        b=WjqQXJxFgwpG7i6UefSHaW9Sa0rrJPEJtmxbkHtv+iREaBpuMMBZWfK933qWlNllm4
         IpegcMJWdPbDLzbNe7ejbbgV6eR5kH48Gaw89x7SPc8eWf/W2A6QF3TdWJLFAL6MLg5S
         qTZa7DvwaOOCzmbWq/vZ6PYSEIsD7C8L1E1qFaYs4rDbrMh02CGMs05YLa0ma6eZRJfG
         7OrpVjOyjvkuw7mtnvt921npJpypX1Ek++Y+29iO7RKi0n3xP3GW1kTXcML3c8bD0M5+
         voCr6JanJTIVrvz5dTfTr7f2OxFrckU0xow8XBo8PTAW5hDYyNNsiVDDg3cjKG7RrcCW
         AdTg==
X-Gm-Message-State: AOJu0YwJQwpWadFpTtkzhS5Mcs/uHeIsnZLln1y8IKOUhMl/zUvzI38d
	fQu+5ZF5UZY7n2JFzLesqCgSZ1fVOULrp8VvGVsEH/nznFpj6A==
X-Google-Smtp-Source: AGHT+IGSZGVErl8CE6vVHqGEfu+HqhgYcJ1/cHQdOu9XRTxwKHDsrmulx1Hy8i6xvbz0AzG309SuCm4l5ayMKINp6R4=
X-Received: by 2002:a2e:4e02:0:b0:2cd:3731:9c52 with SMTP id
 c2-20020a2e4e02000000b002cd37319c52mr278711ljb.2.1705456285645; Tue, 16 Jan
 2024 17:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116193542.711482-1-tmenninger@purestorage.com>
 <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch> <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>
 <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch>
In-Reply-To: <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch>
From: Tim Menninger <tmenninger@purestorage.com>
Date: Tue, 16 Jan 2024 17:51:13 -0800
Message-ID: <CAO-L_46kqBrDdYP7p3He0cBF1OP7TJKnhYK1NR_gMZf2n_928A@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
To: Andrew Lunn <andrew@lunn.ch>
Cc: f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 3:21=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Hi Andrew,
> >
> > It bubbles up as EIO (the translation happens in get_phy_c45_ids when
> > get_phy_c45_devs_in_pkg fails) and ultimately causes the probe to fail.
> >
> > The EIO causes the scan to stop and fail immediately - the way I read
> > mdiobus_scan_bus_c45, only ENODEV is permissible.
>
> O.K. At minimum, this should be added to the commit message.
>
> However, i'm wondering if this is the correct fix. I would prefer that
> the scan code just acts on the -EOPNOTSUPP the same was as
> -ENODEV. Maybe the error code from phy_c45_probe_present() should be
> returned as is. And mdiobus_scan_bus_c45() is extended to handle
> -EOPNOTSUPP ?
>
>             Andrew

Noted about the commit message.

To return -EOPNOTSUPP high enough up that the mdiobus_scan function(s) can
directly handle it would mean at minimum, these functions have -EOPNOTSUPP
added to their respective list of possible return values:
    - get_phy_c45_ids (static)
    - phy_get_c45_ids
    - get_phy_device
    - mdiobus_scan (static)
    - mdiobus_scan_c22 (static)
    - mdiobus_scan_c45 (static)

I didn't look beyond to see whether any callers of phy_get_c45_ids or
get_phy_device also return errors as-are, but it feels a little broad in
scope to me.

My impression is still that the read_c45 function should agree with the
phy_read_c45 function, but that isn't a hill I care to die on if you still
think otherwise. Thoughts?

