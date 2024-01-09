Return-Path: <netdev+bounces-62659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498FF82861C
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 13:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1CF1F24942
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A6360BD;
	Tue,  9 Jan 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHzULQnn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4039826AF7
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3368ac0f74dso2268734f8f.0
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 04:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704803821; x=1705408621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7FAzWAT/C+jCQni2zCWQ4AyEq8nrKASrguI0ZEzUC+I=;
        b=GHzULQnninad+6bJglDFUBJJdICi4ScQc2pV8ONnUtx6I+EBPWyIPq/LTd4VGQzibn
         VOs2w0HIyHK47kkPaXbX6SviFyZOmoLk0m7K7pubGv3WCGcejhZ/RWns7NFvmabSB9XE
         GeOyUb6U8LDm6cVTAZGOB58DVCa1hriPIXpMxVOgW9fsZNPsS0ayO0gPneerPEHDHNq0
         96XmGEb03EUPajS6t06fqaFoJ9bXCN5qlptEYAQ2mfnIMScPwMtRTMjMtc61jzMXzCh2
         /cehIFRai5gCuyADWmTyCU4sO6xL5RduQxRURyaBASqg5ykDLgbobDru+o3GPktTXtw8
         Uz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704803821; x=1705408621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FAzWAT/C+jCQni2zCWQ4AyEq8nrKASrguI0ZEzUC+I=;
        b=gm2NHMfNBbdbSsggw9AzEQVSgoIYIGlsjc+oxRbn6AG6rtnGgka8Y0wVM0yk4aYBdW
         MKvEfNH0ASXNVDOoFReJNsYkpaRzZO3JPQNc4hXUycEHKXbdzC6PyXOv6xqtPSP60Bqp
         1zZkCWgJFKjU8rzZHFa97mNZ4oVEI4AbeFvZ2Xc0utnYWraN8zwFi6zUmDDOCx9LyaFP
         33ZaDozuT4m6w0VJ93t2r/8/0OuLeM1vQS5AebDNUFa8vPAAnPtoxktj83tTbebjEIMr
         hOTmkn/UFUbpGbDCQ4ZZbPUp8x9OJZ/ZGLdK/qMqWtrMTiFsGJQtOVxcGtfwNZL3C2MZ
         h77g==
X-Gm-Message-State: AOJu0Yy0sTbWCu6SuKFymAUILhDl19sSFWWOHdmI0g7NaIU2qhTgcLsc
	9WEyV5IPCowuhBdnuBFa78g=
X-Google-Smtp-Source: AGHT+IFaQleOoQWgv9Z4ecMGKHfEzJxNFlbC1vJ/IUKszuLIkNGLPpV8qOVx+5CSiViXCy0vE2ELvA==
X-Received: by 2002:a5d:5406:0:b0:336:5b14:525f with SMTP id g6-20020a5d5406000000b003365b14525fmr644485wrv.132.1704803821281;
        Tue, 09 Jan 2024 04:37:01 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d4571000000b00336e32338f3sm2307640wrc.70.2024.01.09.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:37:01 -0800 (PST)
Date: Tue, 9 Jan 2024 14:36:58 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa
 module
Message-ID: <20240109123658.vqftnqsxyd64ik52@skbuf>
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-4-luizluca@gmail.com>
 <20240108140002.wpf6zj7qv2ftx476@skbuf>
 <CAJq09z6g+qTbzzaFAy94aV6HuESAeb4aLOUHWdUkOB4+xR_vDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6g+qTbzzaFAy94aV6HuESAeb4aLOUHWdUkOB4+xR_vDg@mail.gmail.com>

On Tue, Jan 09, 2024 at 02:05:29AM -0300, Luiz Angelo Daros de Luca wrote:
> > > +struct realtek_priv *
> > > +realtek_common_probe(struct device *dev, struct regmap_config rc,
> > > +                  struct regmap_config rc_nolock)
> >
> > Could you use "const struct regmap_config *" as the data types here, to
> > avoid two on-stack variable copies? Regmap will copy the config structures
> > anyway.
> 
> I could do that for rc_nolock but not for rc as we need to modify it
> before passing to regmap. I would still need to duplicate rc, either
> using the stack or heap. What would be the best option?
> 
> 1) pass two pointers and copy one to stack
> 2) pass two pointers and copy one to heap
> 3) pass two structs (as it is today)
> 4) pass one pointer and one struct
> 
> The old code was using 1) and I'm inclined to adopt it and save a
> hundred and so bytes from the stack, although 2) would save even more.

I didn't notice the "rc.lock_arg = priv" assignment...

I'm not sure what you mean by "copy to heap". Perform a dynamic memory
allocation?

Also, the old code was not using exactly 1). It copied both the normal
and the nolock regmap config to an on-stack local variable, even though
only the normal regmap config had to be copied (to be fixed up).

I went back to study the 4 regmap configs, and only the reg_read() and
reg_write() methods differ between SMI and MDIO. The rest seems boilerplate
that can be dynamically constructed by realtek_common_probe(). Sure,
spelling out 4 regmap_config structures is more flexible, but do we need
that flexibility? What if realtek_common_probe() takes just the
reg_read() and reg_write() function prototypes as arguments, rather than
pointers to regmap_config structures it then has to fix up?

> > > +EXPORT_SYMBOL(realtek_common_probe);
> > > diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> > > index e9ee778665b2..fbd0616c1df3 100644
> > > --- a/drivers/net/dsa/realtek/realtek.h
> > > +++ b/drivers/net/dsa/realtek/realtek.h
> > > @@ -58,11 +58,9 @@ struct realtek_priv {
> > >       struct mii_bus          *bus;
> > >       int                     mdio_addr;
> > >
> > > -     unsigned int            clk_delay;
> > > -     u8                      cmd_read;
> > > -     u8                      cmd_write;
> > >       spinlock_t              lock; /* Locks around command writes */
> > >       struct dsa_switch       *ds;
> > > +     const struct dsa_switch_ops *ds_ops;
> > >       struct irq_domain       *irqdomain;
> > >       bool                    leds_disabled;
> > >
> > > @@ -79,6 +77,8 @@ struct realtek_priv {
> > >       int                     vlan_enabled;
> > >       int                     vlan4k_enabled;
> > >
> > > +     const struct realtek_variant *variant;
> > > +
> > >       char                    buf[4096];
> > >       void                    *chip_data; /* Per-chip extra variant data */
> > >  };
> >
> > Can the changes to struct realtek_priv be a separate patch, to
> > clarify what is being changed, and to leave the noisy code movement
> > more isolated?
> 
> Sure, although it will not be a patch that makes sense by itself. If
> it helps with the review, I'll split it. We can fold it back if
> needed.

Well, I don't mean only the changes to the private structure, but also
the code changes that accompany them.

As Andrew usually says, what you want is lots of small patches that are
each obviously correct, where there is only one thing being changed.
Code movement with small renames is trivial to review. Consolidation of
two identical code paths in a single function is also possible to follow.
The insertion of a new variable and its usage is also easy to review.
The removal of a variable, the same. But superimposing them all into a
single patch makes everything much more difficult to follow.

