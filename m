Return-Path: <netdev+bounces-191527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC7ABBCA7
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 13:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F3C18939E0
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910B275863;
	Mon, 19 May 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMSnTket"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F48274FCD;
	Mon, 19 May 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654688; cv=none; b=QpYvCkHcq08LUkxNDyCa6t9XPeaf11PKuLJYe88cSEwH7uaG6InTYLCb9L1vraNBTw4+kgc6JzjyCI+BITiCrH0DUWAbPHIaS83hgfE48yysOtUpIjc8gX5tbZpQ+OjzaNlPGIaf59jwV6crt6YwB+a915K2dqBYG6/aRVDqdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654688; c=relaxed/simple;
	bh=7TmHIFButu0/rC/hCn0tJ126dw1GXvpkvMpN+ZjRtPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8rhmPTzq58n840UxmfPG9EkRWUcM0EBMXQglCLQQTpIG2BOFtReY5iltip54w5uHznfSzSCGbxi8I05bluycswC+zzmQ+fc3Rv7TlMU5ibaFsMRJ/vfQ2xvvRSlg41xzJP18SyG9HAeRsUiZaW/t1B46z25Swztoffd2h3+JIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMSnTket; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a37535646aso332803f8f.0;
        Mon, 19 May 2025 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747654685; x=1748259485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4PD/r7qfEReGXA3osi3B9vh/FP+woHInGVqSdMby7LA=;
        b=mMSnTketD2fF3BxYO9753tA7mqeLmYq6MhVE9eXPwqAKbjWDrbQAAtLLvwulBg8eg7
         cuMoCu6Qc9Id8rzkTLScvtXeZa0gEmW/6p/5XUikjYdxU+m8MS5qz5DWYtchFxyRAj8N
         +kkKgfbwJM7eyR9jmTuqOarHSz6qlOTX4j3z1vShwhVHDM2rIhZrRPYZ0eh3XVrzakay
         2GurPhZ+GwUU5q4WTuOFdl834kX+KWjHxZ5Aar62i2ka2FT9WaN+Xz9VWdKfLnw52ywG
         m91TvpL7MhQm+KzNZMbTkiOKVuLksL2LHe4ydGIOXWDgGx9Oplq0gL9+E3YKnO0BiyYW
         /MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747654685; x=1748259485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PD/r7qfEReGXA3osi3B9vh/FP+woHInGVqSdMby7LA=;
        b=B7U5IYgsTLxd+UoK9OHgoH/P8T3IMFSPSiewgIeXxPgzln6B4ePgOxeDH+xjGHkWDL
         tczwFogbc3THFIrHb3vKmgZi9lprxY905jY62mHbZ2DDDMNJWuvqvcHjxICPv4VU4i/A
         cLe2J380mr3+cKUNXCpiwlIS2GsPbWnGWtioqQWQjtO9xtoFvho5U+H8Py97TazaDZyw
         rSf+fs4Udx0fRmHVnwIkCDRMcOuAxlBZm5s3OPMrsXQBWvA39w6nOBiDYCWKDOfxS4Dx
         BvYLaMjqnfWOmSTq4gc4ScNvr0FZ/yo6KVXcrDvyGAYReHGd+lxVqk45YvpySlwugAR6
         r2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJyQsqXLwi35J/MIZNOTCE7XpHmtKgcJtcZXb6ZkWXSkR0D2kvO13dHVYvpthw2j6Jmi7qWYeCEVATL+Q=@vger.kernel.org, AJvYcCWBJLDCG3kojTW2VvBtLicGGQWx8zuLTHPoJcfCfOuhXhqg6qYNJ2lH5tIAzCfG3p7+H4Lfr7QP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3z8I3guSL9yHj9j8bYoALbhWjZWEatVmVdWCRwIcttNpu36oM
	fMvoEFP0M6KOqYwuU/++08C2jCjv1DwI46aqeec0gFNM604eB/moYm2SDDVnS13Bwex/fNosOho
	E/+MUxmHVgtZoEI9N+tTOWrOQu5p/wj0=
X-Gm-Gg: ASbGncswDCqC8fxClVESA6FnqtRck697FCUWvmFGeJHQt/KC34/PYpBpc+FLe8Blhwk
	dRvcvCGcIqPyNf11Ean9Tp8mZM0SsS5fhxGt1h9jxo6jsyA/Q/MbazSuDVQ+kkzscEr5wnr07MX
	15ssPcto+Azkt7zv5Waukb9hDZEcM1YVuXMLACUITcqDcp3Ktrd9Hfx0eEXQgNHxaLfjc=
X-Google-Smtp-Source: AGHT+IGlUi0WQ+8Hn7GUf3y+zK6i4y5xQwsE5jb6qnK+zrOMCASls4EDis4EHUhqpiUvC8TUCOfXFXvKlpRA+43TZxE=
X-Received: by 2002:a05:6000:40e1:b0:3a3:71fb:78c6 with SMTP id
 ffacd0b85a97d-3a371fb81admr1801156f8f.16.1747654685503; Mon, 19 May 2025
 04:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515145142.1415-1-zakkemble@gmail.com> <20250515145142.1415-2-zakkemble@gmail.com>
 <20250516175231.4049a53d@kernel.org>
In-Reply-To: <20250516175231.4049a53d@kernel.org>
From: Zak Kemble <zakkemble@gmail.com>
Date: Mon, 19 May 2025 12:37:54 +0100
X-Gm-Features: AX0GCFvFKRUD3QyA0n1hKV8cG9UDCp1h_ldb7fWV2yY32xyfr08_JxkGJiC5Mf8
Message-ID: <CAA+QEuQ+2gFNCqK_txG-Lsye5JmsoKUYHnsmOgK0LSoabc7yeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: bcmgenet: switch to use 64bit statistics
To: Jakub Kicinski <kuba@kernel.org>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks, v3 is here
https://lore.kernel.org/all/20250519113257.1031-1-zakkemble@gmail.com/

On Sat, 17 May 2025 at 01:52, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 15 May 2025 15:51:40 +0100 Zak Kemble wrote:
> > @@ -2315,7 +2358,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
> >               if (unlikely(!(dma_flag & DMA_EOP) || !(dma_flag & DMA_SOP))) {
> >                       netif_err(priv, rx_status, dev,
> >                                 "dropping fragmented packet!\n");
> > -                     ring->errors++;
> > +                     BCMGENET_STATS64_INC(stats, fragmented_errors);
>
> Please refrain from adding new counters in the conversion patch.
>
> >                       dev_kfree_skb_any(skb);
> >                       goto next;
> >               }
>
> > @@ -3402,6 +3455,7 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
> >  static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
> >  {
> >       struct bcmgenet_priv *priv = netdev_priv(dev);
> > +     struct bcmgenet_tx_stats64 *stats = &priv->tx_rings[txqueue].stats64;
> >       u32 int1_enable = 0;
> >       unsigned int q;
>
> Please maintain the coding style of declaring variables from longest
> line to shortest. If there are dependencies the init should happen
> in the body of the function.
>
> > -static struct net_device_stats *bcmgenet_get_stats(struct net_device *dev)
> > +static void bcmgenet_get_stats64(struct net_device *dev,
> > +                                                              struct rtnl_link_stats64 *stats)
>
> the indent is way off here, in general please try to fit in 80chars
> unless the readability suffers.
> --
> pw-bot: cr

