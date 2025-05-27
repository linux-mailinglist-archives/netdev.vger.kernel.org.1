Return-Path: <netdev+bounces-193752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1F7AC5B47
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 22:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAFF1BA7955
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241022AF10;
	Tue, 27 May 2025 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxIdKA1G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8022F5E;
	Tue, 27 May 2025 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748377000; cv=none; b=kYfdI94Ko+pXS/+qWM6MjuWr+TbLShZqD3L9N11LXD7+UPU1us+yCsj0mKNzwbC8nKcn47VUb237EgcUbzDGxQ+anu70j+pM+MOuW52Dspfig0hdjNA65w7nWzZwWP4dfVYOr+O97OXCZqBwqtUPvAG95qXgV1+Bs6x86cXcxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748377000; c=relaxed/simple;
	bh=FGqF7J9hCkWnDPN2ywa1l4c3bPKUIJ2p39BiR4jVq3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izq3HzuGkHM0X4DZXhsApOvJ1eQCPqV0mrWhU7zoZRWQmIf5xe/XQRuktyKxbivFdL9yc+s2lviiI68KzoR4NnxY5gqNVt145erlpAsoj+ifWfOKClhFjuet/CbvZtR+aXthDdeSf6mm/N01D5EUkmP98eponhOoW1aKVeiX/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxIdKA1G; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-52b2290e290so2119066e0c.1;
        Tue, 27 May 2025 13:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748376997; x=1748981797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGqF7J9hCkWnDPN2ywa1l4c3bPKUIJ2p39BiR4jVq3s=;
        b=mxIdKA1GBbiMVpDg9u5AFbTsZhJgVxFyw2U/IJjL2DgQa0sdz+DFv85jkJHSbfGkeO
         QLmDJ+Ps18wl8OEDOts6m0fXgpJqHERxbLTAf7q3xWFTCUgTbX+jVu2o+RLg9NsGT8fr
         MV9WMoxh5vbKUiwsrokrJKctWSx2LTC6NB1aW2/hinuIdlTxpwKto4Air/2U9bokumer
         AaW6yF7wxoB9jFjhp6KhQi+AhYAgT5Z00GEtiWpf11tfCDSUkwiOQLeUoZlOms59nwsT
         uIhPajPbxrTK+PlbnKcUO+FHBSByz03D/EqeRFjCIudbJx23Hn6hBSaQ4iABK1Pa36v0
         1qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748376997; x=1748981797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGqF7J9hCkWnDPN2ywa1l4c3bPKUIJ2p39BiR4jVq3s=;
        b=vkFgBTs1S5lJTsJrmOaZ3Wigp7Ph7iRnmOc8ag74nEgaGeOnwzHDFMVB9qhyHjWXi1
         K2JnlIrOq3R9Vpqnyw+ARIebvIdiOorAtccYB/rHK320UVV8e25sPUfqDaNr0Qr62/Mo
         dcxDzWJdmPt+O05zfM3F3i77BEyM4KForR+a4NmoUMdyW1jIjbC4HkIjlCxwEGoBRloY
         ffnMGuU4/j0qVTs0TVMDNLnTQ1JqmEa5i7uNil+zcA0rkrvutgS7buwXUginuoJvHFvK
         BeHki69uBIs6kM87fuCFt44Qc5hev9YdiR0Dx5sWDWFzpAZhoK9El/iziTVXh5IzaTZ+
         iFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyZy5fa+Rsq1bukSQL5ueK2JXRnujrGWPs6OMKEy8t/DAEXM1UhfMpdPNP3Sy/SrLyPwwDRijI4sjzhJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CRrRJGpESPNqyYZKHZDprED12cHl9qF7CC1DRrWVrDOUWLb2
	QZXK4JgK7Iz1/3oAJZBtIDftMKq9F3dohDvUysgYV3CqCSP0sCiwi/G9OTNrXi4xykA6XTbBbhG
	GbqysWvfTNYMXq/1qDdDkOICL8f634Ys=
X-Gm-Gg: ASbGncunkTpIFSnwNmWhakXRO/UwjEcnGAgITBciceShphisJLVcwDEtfc5hYHMwrMx
	mwuiTBqsQ0qXHrXS02cgOWeQvUOxJd72q9sNHCYFaNEEP0h7s8ZDnaQEg925xUjWkzttWzyPmXS
	DGIiq/wEdHpBwN4KcOG/HwKRzUp2l0+RrPew==
X-Google-Smtp-Source: AGHT+IETycDNDAJyxv3VLNHb+TIrTja35S1519qoE+Q/rK9pDA/sheHZNaSXrhFkGJah8hc3P6ff0SwCLKvwf9KpQ8o=
X-Received: by 2002:a05:6122:3d0d:b0:52f:204d:4752 with SMTP id
 71dfb90a1353d-52f2c5ca414mr12169837e0c.11.1748376997259; Tue, 27 May 2025
 13:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch> <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch>
In-Reply-To: <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 May 2025 14:16:26 -0600
X-Gm-Features: AX0GCFv4cap4ZOGqZcta-siDQMwW0SvAemE-pnT7ig2Oyj0apu2kFeIEsXbam6w
Message-ID: <CADvTj4qRmjUQJnhamkWNpHGNAtvFyOJnbaQ5RZ6NYYqSNhxshA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Furong Xu <0x1207@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 2:02=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, May 27, 2025 at 01:21:21PM -0600, James Hilliard wrote:
> > On Tue, May 27, 2025 at 1:14=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Tue, May 27, 2025 at 11:55:54AM -0600, James Hilliard wrote:
> > > > Some devices like the Allwinner H616 need the ability to select a p=
hy
> > > > in cases where multiple PHY's may be present in a device tree due t=
o
> > > > needing the ability to support multiple SoC variants with runtime
> > > > PHY selection.
> > >
> > > I'm not convinced about this yet. As far as i see, it is different
> > > variants of the H616. They should have different compatibles, since
> > > they are not actually compatible, and you should have different DT
> > > descriptions. So you don't need runtime PHY selection.
> >
> > Different compatibles for what specifically? I mean the PHY compatibles
> > are just the generic "ethernet-phy-ieee802.3-c22" compatibles.
>
> You at least have a different MTD devices, exporting different
> clocks/PWM/Reset controllers.

I assume you mean MFD not MTD devices here.

> That should have different compatibles,
> since they are not compatible.

I agree with that for the MFD devices, but we still need a way
to choose the correct one at runtime otherwise initialization
won't succeed AFAIU.

> You then need phandles to these
> different clocks/PWM/Reset controllers, and for one of the PHYs you
> need a phandle to the I2C bus, so the PHY driver can do the
> initialisation.

Well this would be an indirect reference to the i2c bus right?
I mean the phy would reference a reset controller which would
in turn reference the I2C bus right?

> So i think in the end you know what PHY you have on
> the board, so there is no need to do runtime detection.

But we still need to somehow runtime select the correct phy
which in turn references the phandle to the correct reset
controller right?

> What you might want however is to validate the MTD device compatible
> against the fuse and return -ENODEV if the compatible is wrong for the
> fuse.

Sure, that may make sense to do as well, but I still don't see
how that impacts the need to runtime select the PHY which
is configured for the correct MFD.

