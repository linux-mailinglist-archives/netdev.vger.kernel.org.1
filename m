Return-Path: <netdev+bounces-66549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62B383FB24
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 01:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDC91F23567
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 00:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F31138F;
	Mon, 29 Jan 2024 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVyVm9iu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF227111C
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706486993; cv=none; b=KUW4+N+LtE2oQrHjNzL3EJ3ePbcRYkwD05+FWm55jdfIu1DoiGKFJch2x8JhYqhJEtWZf6eLG3XgcA7VjXz57RDb1En7C+hEIXgqtNjgEdTPnNtHs38zSzDCGTahQNnYrlktyd/vdFz/0GwdHLoI3mWSMhNKxenTwMni6T8NvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706486993; c=relaxed/simple;
	bh=4AckhELB2eYoFlZRscbt26fpOVLGINPtgCASFA+F8bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UorIVzOOpcoC89BVOVv7iFf+JsUo8H7iNpsLLm+BwJwsQNY1atnF+XjWE9WV7C4x8+6MVjbRf0SgQr3gPV3L8AWDyTfTQxgBSIQ47Dcpg4CfLQn2gH+NOGcNHbUpfL7BW7dVCBe6Yn1APxfRlDXniRGlRZafh6OCk9JMTlT91sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVyVm9iu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eac018059so2449368e87.0
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 16:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706486990; x=1707091790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZQzwRQ2CIyuukA3Krm3Tr0keJqXQjupkeh7l1uJiyI=;
        b=WVyVm9iuNK9LAIbX2JeeiH+OmOPEPEl5V6JoFATDPWBfGr9BfQV6YTPj6k/SZHpnCm
         xhK8Ae3VHk/Zpf0SHPB/ry3Myo3vJ5B3+3ptinhIJgoy9iA1oSs7EyNT9BeUPVklySC7
         eeKiMcsphGQFUIBHPfxbkg1F9uouvft3MBuknkuhQhqb+l6vgupQPnLGz6jfMPa2QW/L
         Ogvm5m+WHrCyVAIiGlEB8I3XimVsMi7AOHy0zmWxuifmR7qKLsjZjYSD8vKsuExk1NnR
         uMhimJBywcp8hWW/g9xtxQMQ9y6w1XA+TEdp35gLPXFEERp6/WpPcv1y70E8zNUy43BH
         VxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706486990; x=1707091790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZQzwRQ2CIyuukA3Krm3Tr0keJqXQjupkeh7l1uJiyI=;
        b=qNgiIvd/LOBdmICDg8LHM69rRKexvD5MxR8XD5y4EEy9T7qafclNLKzn574Ki3M0Hq
         BqTOgyyTHZn5dHgzUqYN16Od/MuizsSKtwu0/ND4NyhIfV9X9N+cdApgS5ERjUJlDBNq
         f2pXU2z78Mh9M/5vgoP3j4ScVCOyRZZ9MrXWO4xu0eW0t8HGlgxOD/CDa49YX3xzEGPZ
         JJhLtAccK1fVVgzT6UwuhDSJJ5rxAuxuqECt8Ze8jiSceUD9lzoBWe/1myJCeQl2fvq/
         xrOCs7VT6L/YGVnzPoDbtc0cw6faBzEsWAcV5mi3CpOTcF+oSmxpwKlINhr7mrsMzcnT
         nHww==
X-Gm-Message-State: AOJu0Yzh7tgE0p3ebdOEP/8eAiJNtYW8cI1ZMn+O9feUzY6PQp1wFgML
	cc9jb7i+/7TCQiD5eg4IcBNJVGcFNlZ2mAg9JhEEnZic24+4krSL0rWviKaPW6Cnp795/4F3PoS
	wRue/yhXF1jL3krZ1zRMEIWtYTbo=
X-Google-Smtp-Source: AGHT+IHNpA60wBc9bK+LluLV23Jvn1k4CD5Fco7E9CNH4Gn84H2nKwWtne/NP7UYy7nvezFMD/IlbwlEV6TKNHFPLj4=
X-Received: by 2002:a05:6512:20c5:b0:511:8a1:2bd6 with SMTP id
 u5-20020a05651220c500b0051108a12bd6mr1500375lfr.66.1706486989715; Sun, 28 Jan
 2024 16:09:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123215606.26716-1-luizluca@gmail.com> <20240123215606.26716-6-luizluca@gmail.com>
 <20240125104524.vfkoztu4kcabxdlc@skbuf>
In-Reply-To: <20240125104524.vfkoztu4kcabxdlc@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 28 Jan 2024 21:09:38 -0300
Message-ID: <CAJq09z5TE_VSGmyWdNfb+o7ymg2qsfGhjky-AXY+Pv5_0V7RLw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 05/11] net: dsa: realtek: common rtl83xx module
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"

> On Tue, Jan 23, 2024 at 06:55:57PM -0300, Luiz Angelo Daros de Luca wrote:
> > Some code can be shared between both interface modules (MDIO and SMI)
> > and among variants. These interface functions migrated to a common
> > module:
> >
> > - rtl83xx_lock
> > - rtl83xx_unlock
> > - rtl83xx_probe
> > - rtl83xx_register_switch
>
> For API uniformity, I would also introduce rtl83xx_unregister_switch()
> to make it clear that there is a teardown step associated with this.
>
> > - rtl83xx_remove
>
> No rtl83xx_shutdown()?

I was avoiding one-line functions. However, I'll add those functions
for API uniformity. In the end, it will naturally untangle some other
problems you mentioned in other patches.

> You could centralize the comments from the mdio and smi interfaces into
> the rtl83xx common layer.

I'll use a more generic kdoc for each interface and a detailed one in common.

>
> >
> > The reset during probe was moved to the end of the common probe. This way,
> > we avoid a reset if anything else fails.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> > diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> > index 57bd5d8814c2..26b8371ecc87 100644
> > --- a/drivers/net/dsa/realtek/realtek-mdio.c
> > +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> > @@ -303,3 +194,5 @@ EXPORT_SYMBOL_NS_GPL(realtek_mdio_shutdown, REALTEK_DSA);
> >  MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
> >  MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
> >  MODULE_LICENSE("GPL");
> > +MODULE_IMPORT_NS(REALTEK_DSA);
> > +
>
> Stray blank line at the end of the file.

OK. I'll remove all of them.

> > diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> > new file mode 100644
> > index 000000000000..57d185226b03
> > --- /dev/null
> > +++ b/drivers/net/dsa/realtek/rtl83xx.c
> > @@ -0,0 +1,201 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include <linux/module.h>
> > +
> > +#include "realtek.h"
> > +#include "rtl83xx.h"
> > +
> > +/**
> > + * rtl83xx_lock() - Locks the mutex used by regmaps
> > + * @ctx: realtek_priv pointer
> > + *
> > + * This function is passed to regmap to be used as the lock function.
> > + * It is also used externally to block regmap before executing multiple
> > + * operations that must happen in sequence (which will use
> > + * realtek_priv.map_nolock instead).
> > + *
> > + * Context: Any context. Holds priv->map_lock lock.
>
> Not "any context", but "sleepable context". You cannot acquire a mutex
> in atomic context. Actually this applies across the board in this patch
> set. The entry points into DSA also take mutex_lock(&dsa2_mutex), so
> this also applies to its callers' context.

Yes. I'll update all kdocs that might use a lock. I guess just the
unlock that is actually "any context".
I believe it will be much easier to write a kdoc when all called
symbols also have a kdoc with a Context: field. It would avoid all
kdoc writers to dig down the stack with every called function. It's a
good move to require kdoc for all exported symbols.

> > + * Return: nothing
> > + */
> > +void rtl83xx_lock(void *ctx)
> > +{
> > +     struct realtek_priv *priv = ctx;
> > +
> > +     mutex_lock(&priv->map_lock);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(rtl83xx_lock, REALTEK_DSA);
> > +
> > +/**
> > + * rtl83xx_unlock() - Unlocks the mutex used by regmaps
> > + * @ctx: realtek_priv pointer
> > + *
> > + * This function unlocks the lock acquired by rtl83xx_lock.
> > + *
> > + * Context: Any context. Releases priv->map_lock lock
> > + * Return: nothing
> > + */
> > +void rtl83xx_unlock(void *ctx)
> > +{
> > +     struct realtek_priv *priv = ctx;
> > +
> > +     mutex_unlock(&priv->map_lock);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(rtl83xx_unlock, REALTEK_DSA);
> > +
> > +/**
> > + * rtl83xx_probe() - probe a Realtek switch
> > + * @dev: the device being probed
> > + * @interface_info: reg read/write methods for a specific management interface.
>
> Leave this description more open-ended, otherwise it will have to be
> modified when struct realtek_interface_info gains more fields.

OK, it makes sense. However I'm not sure management interfaces might
differ in anything but the reg read/write.

>
> > + *
> > + * This function initializes realtek_priv and read data from the device-tree
>
> s/read/reads/
> s/device-tree/device tree/

OK

> > + * node. The switch is hard resetted if a method is provided.
> > + *
> > + * Context: Any context.
> > + * Return: Pointer to the realtek_priv or ERR_PTR() in case of failure.
> > + *
> > + * The realtek_priv pointer does not need to be freed as it is controlled by
> > + * devres.
> > + *
> > + */
> > +struct realtek_priv *
> > +rtl83xx_probe(struct device *dev,
> > +           const struct realtek_interface_info *interface_info)
> > +{
> > +     const struct realtek_variant *var;
> > +     struct realtek_priv *priv;
> > +     struct regmap_config rc = {
> > +                     .reg_bits = 10, /* A4..A0 R4..R0 */
> > +                     .val_bits = 16,
> > +                     .reg_stride = 1,
> > +                     .max_register = 0xffff,
> > +                     .reg_format_endian = REGMAP_ENDIAN_BIG,
> > +                     .reg_read = interface_info->reg_read,
> > +                     .reg_write = interface_info->reg_write,
> > +                     .cache_type = REGCACHE_NONE,
> > +                     .lock = rtl83xx_lock,
> > +                     .unlock = rtl83xx_unlock,
>
> Too many levels of indentation.

OK

> > +/**
> > + * rtl83xx_remove() - Cleanup a realtek switch driver
> > + * @ctx: realtek_priv pointer
>
> s/ctx/priv/

I was missing some kernel warnings with too much debug output (V=s1c).

> > --- /dev/null
> > +++ b/drivers/net/dsa/realtek/rtl83xx.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#ifndef _RTL83XX_H
> > +#define _RTL83XX_H
> > +
> > +#include <linux/regmap.h>
>
> I don't think anything from this header needs regmap.h?
> For testing what is needed, you can create a dummy.c file which includes
> only rtl83xx.h, and add just the necessary headers so that dummy.c
> builds cleanly.
>

It is a leftover from the time probe was receiving a regmap_config. It
is, indeed, missing in rtl83xx.c.

Regards,

Luiz

