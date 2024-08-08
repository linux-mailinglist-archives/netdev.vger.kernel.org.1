Return-Path: <netdev+bounces-116756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFBB94B9AB
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3832844B0
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B1D147C91;
	Thu,  8 Aug 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/G0irLd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35C146D55;
	Thu,  8 Aug 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109337; cv=none; b=R01GnZaIuIUdyVi69GFIKq8uCOkvRUmCd0kWGHS/Wrn1Y3t3M7eA4rc820EHosk0BiUpqrwbxaoMJuO9zHyoLnPbRumFKXfYaEI0W5O4e9Og1xfEC5cA6+4iETPrUHLqNadAbGhlMWQcE8MyVHHFS+oYoU10jATHLCqCMAFCEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109337; c=relaxed/simple;
	bh=ZSJC+ElrR0KuJIX8DXufJLcKD19TF5flBV8yJMH4etE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0NPnUWlxr4R6TJo6gEo+8yNorvmyQSzIsdXEvLyVze6BM2uLIYborkfFvLVNLdOc8Q1aEbgT9Y31hEvsejzZZzGpvAXSNFKWTsj+2IyAENCPPY7kWTR3UKCfbISYwAXgzTsyd4ZXcq7GNIHv+Lr4g/oaOUwUuvnIgrMGNfv9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/G0irLd; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db1e4219f8so506553b6e.3;
        Thu, 08 Aug 2024 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723109335; x=1723714135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tTXttIbpKY7MN+ev3dcFwcWi8Hz7dGmwuXBqb7RF9P8=;
        b=Y/G0irLdXZFVpsjgP2x9i4ATtt00lvyJHjUDAsG/pNd9IJBJcHewD+89ZE84474RVf
         18Y13vQkPGYWRVtsR6WZ3z7hZ1LQqNoCSTXKcK8xCFC29ZVgU4gExCnt9Sxr0mFxxc/W
         R2Xl3/HO87QWaYP6l1bFPpCTZG6+cl2WGVtOE+N8COqYjxQzmDiUD/JRemRy1BAbh0XR
         IMa4lFpW0aE8F8AVJilFtDPP4JtvgEkrzMc+a7WicZAb1DKmbRFcaUB31dstR8Nuzmiv
         TpBdrMigU2LJrapMcziEMyYJ7uAVKv4v2Wm/OQdvtGCuaTmdsIU8JdwlpzgYPZRUvNCK
         dm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723109335; x=1723714135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTXttIbpKY7MN+ev3dcFwcWi8Hz7dGmwuXBqb7RF9P8=;
        b=vMdClLo+tPcI4VvqX9nwulbU7At4/nIGhcorj5VMxSMET7gkz21SDwmes/4vSdxanm
         UDb9qqhhme8myIn3VF7gPWP7pXy2hBghJKO4hTiE6TO20q21Jz9ZykmhTmGw5FrliUtR
         vb0gRLRsJO9louEvnWCcCUUo2umg4Zhbl1bRMQTv7oh2OAWgS2TDI9jEWN6wKDEztmX0
         RtG3H5Gj3a8BS869eO5x5NIarnMmEbyRPR5xn4fURhI5kcpGfHbwucxTXfGK7yRD//Gc
         yDlmX4wEfE6aULlRJLfjAd3fIA5ieYiAo0fFKPq/of57dKGJMhJ2kbZSusF7JdHBE0Rg
         lAmA==
X-Forwarded-Encrypted: i=1; AJvYcCXP7MxkNemTE8RZ6b88w24w1a9IpVrzQwEikYdHh1KwTOU/VuD/jPPo1NbG/d11hhoFUSeA13cPz02QBfhxBwTZadx/QzHQ3UcgY0B3YP/XB2NFC9g8RXQN67CJmYCYLDol8V8mwfxIoP0OA6KANMFJ+WaxsWFWfiSDIpl+xRMgRw==
X-Gm-Message-State: AOJu0YxffOhUjv1jmPaSp1FSSeHv5DsMngfNumVpMtRM1qunttGNU1KN
	kTupV+45P+OJ93o4vJ53wFW745XwSh7gh1GYIeXdxcJ39WI6+LWFzql3QDOWA521sZ1EelPkpfl
	hn3YvhAcca5Rc9CM0NSbDY4eRahrD0PtLfLo=
X-Google-Smtp-Source: AGHT+IELeAEaCYCuwKauWQXUSejmhg8TXmGjaShYGhkXGpm2rHcwLDaVZ7fwoGSLtsnHtZeQXbuQLXpQClVNfU+Z0oY=
X-Received: by 2002:a05:6808:16a0:b0:3dc:1b09:55c9 with SMTP id
 5614622812f47-3dc3b41d26cmr1592841b6e.12.1723109334667; Thu, 08 Aug 2024
 02:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806132606.1438953-1-vtpieter@gmail.com> <20240806132606.1438953-6-vtpieter@gmail.com>
 <0ebe8136f9d088fc9968e5438af5640382c024ac.camel@microchip.com>
In-Reply-To: <0ebe8136f9d088fc9968e5438af5640382c024ac.camel@microchip.com>
From: Pieter <vtpieter@gmail.com>
Date: Thu, 8 Aug 2024 11:28:43 +0200
Message-ID: <CAHvy4AoSJb24ZX4QjFS7UJ2a1nXXnfu7v-7p6FNyC_jCwADA6Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] net: dsa: microchip: apply KSZ87xx family
 fixes wrt datasheet
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	linux@armlinux.org.uk, conor+dt@kernel.org, Woojung.Huh@microchip.com, 
	robh@kernel.org, krzk+dt@kernel.org, f.fainelli@gmail.com, kuba@kernel.org, 
	UNGLinuxDriver@microchip.com, marex@denx.de, edumazet@google.com, 
	pabeni@redhat.com, pieter.van.trappen@cern.ch, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed 7 Aug 2024 at 05:41, <Arun.Ramadoss@microchip.com> wrote:
>
> Hi Pieter,
>
> On Tue, 2024-08-06 at 15:25 +0200, vtpieter@gmail.com wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >
> > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> >
> > The KSZ87xx switches have 32 entries and not 8. This fixes -ENOSPC
> > errors from ksz8_add_sta_mac when configured as a bridge.
> >
> > Add a new ksz87xx_dev_ops structure to be able to use the
> > ksz_r_mib_stat64 pointer for this family; this corrects a wrong
> > mib->counters cast to ksz88xx_stats_raw. This fixes iproute2
> > statistics.
> >
> > Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> > ---
> >
> >  static void ksz9477_phylink_mac_link_up(struct phylink_config
> > *config,
> >                                         struct phy_device *phydev,
> >                                         unsigned int mode,
> > @@ -1262,12 +1297,12 @@ const struct ksz_chip_data ksz_switch_chips[]
> > = {
> >                 .dev_name = "KSZ8795",
> >                 .num_vlans = 4096,
> >                 .num_alus = 0,
> > -               .num_statics = 8,
> > +               .num_statics = 32,
> >                 .cpu_ports = 0x10,      /* can be configured as cpu
> > port */
> >                 .port_cnt = 5,          /* total cpu and user ports
> > */
> >                 .num_tx_queues = 4,
> >                 .num_ipms = 4,
> > -               .ops = &ksz8_dev_ops,
>
> Why don't we rename ksz8_dev_ops also like KSZ88x3_dev_ops or
> KSZ88xx_dev_ops, since it is now used only by KSZ8863 and KSZ8873
> switches.

Hi Arun, indeed that would make more sense. Will rename to
ksz88x3_dev_ops, consistent with the ksz_is_* function names
in ksz_common.h.

Thanks, Pieter

