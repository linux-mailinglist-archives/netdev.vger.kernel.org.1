Return-Path: <netdev+bounces-238342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B1494C5773F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F01A634FE74
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4B2DECA5;
	Thu, 13 Nov 2025 12:39:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E1343D6F
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037557; cv=none; b=ckH3aWQ0VeC90fAyUVgqgqiB2Z4RVjbcXRnQ/iCdyYqO7t17dQYXMMWbWdXYSy0Dt4GVqeCBhJsFOI32trCTtXwbvvspCttgo4BrJh1GJkx+Z1RSpdhksBoBV3TxEFuzrPGx3prV46epDdygmgJKzOQvY1Fk+Q87/XqSKBOWlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037557; c=relaxed/simple;
	bh=wUAx63qaDDYq9QMySwSXcrWHK3failLOK9CeNYY8nkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niW+NEu0708SxLddLF51pbffjTjSW25tn09XYfVp/e0tgWyBlnKCSKq4DosmfqB3BO1vkspfbfpS8Iggp/BBpU0EquxxyWckb+XDId99IOdNEVUpToOxFSHcOu1TEiG/MqtcgorlrMgcLWdypWhg0SPK8a/dzTGZmf3ly7uKv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b272a4ca78so113828785a.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 04:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037553; x=1763642353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ej4Y08LCP4RBUwk1DBvcFonxv/hs+fnUu9iWds2bic4=;
        b=FuCVGGTimMEPGOmEb1EgiyzOIAaRluT2CAhrVImF3/6MPtGBTzY2X8CLJeSFOtPZRG
         B+fWx7uEymEx/0HYX/MtaunXMrxv+lDTNLJ5nR/voKXW3jOn2aVAXchpagyyyHivYQaR
         1Ed67nm+y5a0rLuXM4hE7ovdY+IELlm9XaSMc76PeuUOX5/U3/DHOK358HE8ioDtYggu
         SdDk/pKuWmZsgsHmBidhZ4VHRounju9wJoMKz5HOBbPHbaGjG6qZuGqTcfI+Bl6FGC7w
         p42s8JC+P3uJsaWeDPxHbrO6z72jjkZ2yk2d2hxXIZuFCVJcC3HENI5JNiQAYZQhwPP/
         Nv9w==
X-Forwarded-Encrypted: i=1; AJvYcCXX0tSdvl0qKgt4EV7/Obx1Kyg1eGIh3lkor7VTmJwYG4HEypDve1x/fkqUZBoys0GOmhkj3sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVOM6VafHl1JvsFIKIbkXDZ8Yf91C9ut162Nvcr4OqW0eHENm
	8+yOHbl294kTKPeVDtaTNk4smXdWQVm3VOVUYc7VOce6yU69bWIMOUS5hZ9fqGYEkO4=
X-Gm-Gg: ASbGncuexIocoB0LXVA30nIteMiW8zaabUbq+WZaFITxyHZzWEifgUoAYPfutzQ5ST8
	0qEwKoum/XcRnJk0aHNdKDK30+kAlrkQp6V8KEU7XPefJ2Vf3dN/wrz11wnwLVwgWbanavYldcO
	5Rl16yViMPbwRDDcUrh9e56aAqK4QaxV7HuCvR2dRNNKArMsSD/msPEqjHTmSbwQTs3m3kpZAkY
	vorUafArUIoGng6XlznMxjM/J9HL+uGjs0sR9Lf6J19lPtV9hUE/ubdeV5ZSB2gpWGeX3t0I2RE
	2eYdzLB5v7fB2q717jj+s9vBwWf5sH4GrvV0BEEO4rRFa+Sn2COJqma0IltMxnI4XCnkFMqL6Wo
	gChxe4k/Ex1aYf0FzqR4UlsHzlK8tL6euwBuyjLJkj0HRe53psIGZnxcfX38dUBm3BZtzbscPzi
	/mWcIV53PTOByuHthrCpWe/fMEvD7lyrDEQnEwSgc8kw==
X-Google-Smtp-Source: AGHT+IGdWzDzlOO9aHIEPHGNHvbVeoOjvICTsypNtKbKc+8Oj5MVoQXCRpKYJh4bOEM8ikv5oVPUtQ==
X-Received: by 2002:a05:620a:4489:b0:8a2:a5b2:e3d0 with SMTP id af79cd13be357-8b29b7df867mr787728085a.73.1763037553027;
        Thu, 13 Nov 2025 04:39:13 -0800 (PST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeeb46e7sm119916585a.20.2025.11.13.04.39.12
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 04:39:12 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b25ed53fcbso106438985a.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 04:39:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVg2Q49XhXKsMD2/oWML7nllinbstZr830OGdfJkN7xRkhbQiIRaUqlUYUtW89hYcrHO+mniYU=@vger.kernel.org
X-Received: by 2002:a05:6102:508b:b0:4e6:a338:a421 with SMTP id
 ada2fe7eead31-5de07d0b089mr1897550137.6.1763037077259; Thu, 13 Nov 2025
 04:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110114648.8972-1-xuanzhuo@linux.alibaba.com>
 <20251110114648.8972-4-xuanzhuo@linux.alibaba.com> <987c6e54-992e-4074-b46a-b0a3e3aff874@redhat.com>
In-Reply-To: <987c6e54-992e-4074-b46a-b0a3e3aff874@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 13:31:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVY6y8iL0oiUOzh6C52+J4rRtwDFU-_cwXLdsWSdLFXQg@mail.gmail.com>
X-Gm-Features: AWmQ_bm5xahzhn02pUVIPJbjpV50nyOpWpIYTvWk0CnJk4EY3UcNxk91_Dij2L0
Message-ID: <CAMuHMdVY6y8iL0oiUOzh6C52+J4rRtwDFU-_cwXLdsWSdLFXQg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 3/5] eea: probe the netdevice and create adminq
To: Paolo Abeni <pabeni@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>, 
	Philo Lu <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, Dust Li <dust.li@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 12:38, Paolo Abeni <pabeni@redhat.com> wrote:
> On 11/10/25 12:46 PM, Xuan Zhuo wrote:
> > +static int eea_netdev_init_features(struct net_device *netdev,
> > +                                 struct eea_net *enet,
> > +                                 struct eea_device *edev)
> > +{
> > +     struct eea_aq_cfg *cfg;
> > +     int err;
> > +     u32 mtu;
> > +
> > +     cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> > +     if (!cfg)
> > +             return -ENOMEM;
> > +
> > +     err = eea_adminq_query_cfg(enet, cfg);
> > +     if (err)
> > +             goto err_free;
> > +
> > +     mtu = le16_to_cpu(cfg->mtu);
> > +     if (mtu < ETH_MIN_MTU) {
> > +             dev_err(edev->dma_dev, "The device gave us an invalid MTU. Here we can only exit the initialization. %d < %d",
>
> Minor nit: missing trailing '\n'.

And please use %u for unsigned values.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

