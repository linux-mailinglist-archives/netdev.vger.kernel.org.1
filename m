Return-Path: <netdev+bounces-66832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D026C8410DA
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 18:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7090B1F21DF4
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C1D76C7A;
	Mon, 29 Jan 2024 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib9BrQxa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCB76C6E
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549798; cv=none; b=MpYuMZxDoVLcLr27xBPOgPSQcwBcau6PYelHq79IrlAhKSYQkMp5EIMf6pNJZ1YKwuvMe1vSt7Jp6JJc3Y9DEX8rzn9fvoAWrYbTN7WeP2sIWTDbSSNNIXFtT2jAVucT6zSIUwVnTwnAIMA7dgDDpr0Y3HJmMq0/jkYK0MnUCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549798; c=relaxed/simple;
	bh=6YJtV2gm6m4Cvxe7I7LkpVcfDhnhPX0Fh1IAg6hRoj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLJosd2zih/vmIC1flEDBBQzN/IZ3nUdPZPd5OslVy7gnFHfBpASYcUpJqqMlLF3yAS3/C+lzvPigaqrj71b1hcm53NUBok0Dpmb/jWrEKYgAaQDWjDm6yKpnKdF2M7PqTNptI+zCc3QF0AF4wBVw0csovb+2wtg2UX5L5H9w6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ib9BrQxa; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51114557c77so1116925e87.0
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 09:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706549795; x=1707154595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vSbNHFql9xzjaXNQGf5Aet0p1kBEiYpTszm5zClmi1o=;
        b=Ib9BrQxaFVBgMvqH14DCnRGkw028KxXKQBNbw0vE1Zj1dKzD7s327VPXV/jnDipNw3
         i3k09ajPVEvSdQRPcc2tVidg2e/FZ0VfS/mhbzcaZzPKEH08fQ04lTnojDg56AFiGf7S
         m001lgGF+pKKHUCEan9Jh+qKwugNB0eY3+x8/xRkZvBt//biLlfHKfPfSXrwX/s8FfVb
         jn0wybv2tQJqanqZV18DTf8ZKcimSwnfW4Y6klmOIJqivjcL29hby910lnU/ovEH3fEX
         zF+iL0Mz9w1HTfP+Du2m3tRDN4ZX0weE7asiUBVoycroksKj8swzZh/78X8y0kfkAANj
         /J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706549795; x=1707154595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSbNHFql9xzjaXNQGf5Aet0p1kBEiYpTszm5zClmi1o=;
        b=k1RUpDXACABUDiEIbw8yPhvoPtyOS6nyN/JG8Fz0myL/G2eDd31vuS0S+iOt70ZCPj
         NhyzqE/6r8Ep788iwe/omjwFsdVRHdl4T5UM8OhjrMVdr4CEfwreUOGGT23YTWqiY3OJ
         mIz8hak+7vYta+sWQ2RlBAPikdEsjHQxfHotp+EdTYkpINCUCPlCj3JZXPtdD93X6Quf
         SH0MrdvpP6VxACQtEJlDcZCmz2MadsZDaMLCrcqEd6W56kC9Jf40gTEOD4/xehZYDrDy
         6VnC7RVCdpyqMlS9OlGcJQy90vPlMtZsOQuWk3mVu7nlgnNjjzRx7oMvjENpxW9/rPhT
         yRGQ==
X-Gm-Message-State: AOJu0Ywd0Iqdpm6Lto73GHCWUWEVFlzgpuuEl/ATp5g5f6QDLOdjt7Hb
	8j5OSzIvP4FR+CwFltaZdX5wAPgp/QXZRasjY+fSHegSvB3m1L1BPv5YsyBrR5LJ2YRPw8ropH5
	FTeKYlvtZUQn05n7vRj623qt9Y7c=
X-Google-Smtp-Source: AGHT+IHs6lGcLSh8XAV8vDiRJQHXurog3yEq1RSHA2IIHgLUdSPgAjgMzk4wrA2ggCwBXt01sv/lfHrmzKwFfSsfENo=
X-Received: by 2002:ac2:5b11:0:b0:50e:6c1d:5dee with SMTP id
 v17-20020ac25b11000000b0050e6c1d5deemr4027691lfn.33.1706549794974; Mon, 29
 Jan 2024 09:36:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123215606.26716-1-luizluca@gmail.com> <20240123215606.26716-5-luizluca@gmail.com>
 <4f81c6d3-b74f-4f61-9862-83ee84258880@gmail.com>
In-Reply-To: <4f81c6d3-b74f-4f61-9862-83ee84258880@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 29 Jan 2024 14:36:23 -0300
Message-ID: <CAJq09z6+jDquvS2he5PBJmDOgYGXwgf_jG9BXowEcEK_U5fMTA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 04/11] net: dsa: realtek: keep variant
 reference in realtek_priv
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, arinc.unal@arinc9.com, 
	ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"

> On 1/23/2024 1:55 PM, Luiz Angelo Daros de Luca wrote:
> > Instead of copying values from the variant, we can keep a reference in
> > realtek_priv.
> >
> > This is a preliminary change for sharing code betwen interfaces. It will
> > allow to move most of the probe into a common module while still allow
> > code specific to each interface to read variant fields.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
>
> [snip]
>
> > diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> > index e9ee778665b2..0c51b5132c61 100644
> > --- a/drivers/net/dsa/realtek/realtek.h
> > +++ b/drivers/net/dsa/realtek/realtek.h
> > @@ -58,9 +58,6 @@ struct realtek_priv {
> >       struct mii_bus          *bus;
> >       int                     mdio_addr;
> >
> > -     unsigned int            clk_delay;
> > -     u8                      cmd_read;
> > -     u8                      cmd_write;
> >       spinlock_t              lock; /* Locks around command writes */
> >       struct dsa_switch       *ds;
> >       struct irq_domain       *irqdomain;
> > @@ -79,6 +76,8 @@ struct realtek_priv {
> >       int                     vlan_enabled;
> >       int                     vlan4k_enabled;
> >
> > +     const struct realtek_variant *variant;
>
> This is not probably performance sensitive but should the variant
> pointer be moved where clk_delay was such that we preserve a somewhat
> similar cacheline alignment?

I'll move it. I guess alignment wasn't considered before with two u8
and still might be misaligned with the "bool leds_disabled;". But, as
you said, it is not performance sensitive.

> Regardless of that:
>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> --
> Florian

Regards,

Luiz

