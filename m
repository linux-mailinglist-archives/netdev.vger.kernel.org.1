Return-Path: <netdev+bounces-105976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A089B914032
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 03:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40681C21537
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 01:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D31525E;
	Mon, 24 Jun 2024 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nasMA0K/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477146B5
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719193655; cv=none; b=GikD8Qtnewi/5g/KZWeFrnLoKc8GPudRxuN8qcI9hSE952PVDRlJr476dq7rBw3EemtC15Pxk3Qm9jnR30raf1lktQ8ryBTgq9gyAAMV8V9gd0uFGHJ6hGKDPW4wKxvQIoXciSimElxjQ/AoO3vctAEHSTCQLwxOmszXvbfJA7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719193655; c=relaxed/simple;
	bh=2472+h18Q1eZecnEQToYbF0Q/fpXkfduP7XOuiGoQng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCSpkyr31tZHNZEkhxP0DAqGLTvayAsDiNYXL5ZcQa8jNPahESU3LWAImYOK2Di9Pgtz2bwxBUW6tTMyma+6jQJTJm8X8LfWk77EEMKhT8MkavFXtMdovmHMqRzyol0z85+vZUsixOG69jVn05wprj7UFhxQ8TphlKEAmbJbR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nasMA0K/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cd8897c73so2474393e87.2
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 18:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719193652; x=1719798452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PTeVeS/vv7tBIYGhxH8DLeEBVm5yQc5MrzaqjpvlKDY=;
        b=nasMA0K/dsvkPGTu238cW64yTj/wsJRMGIyhnsj21WMagTSpX9dpWjTeA+opBiOKpA
         UvKZV6M/WrS2a144eLHeYW6WSfkfdfDQnGS6/4TCZjlf5H/41u/fgT6MWEl8ASWjASsv
         7eEQHHQhxmODhob/ewvK46XwpBpnL7AQWS0th5+qnVaaPC/Niw6awe+LYC0kcKctQoZ7
         /qEn+2vwPgmkF4wyANNDb8ivTuHXowo/T75142fVZYoLJLrC3puLPrSL047267Eow9rb
         uUs3MvhRpGwSFO4Rj1jjfg31SXIlW3L2FEOj39ApzSXOQNEjPKe7NUr15k5V26NjaCR1
         akZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719193652; x=1719798452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTeVeS/vv7tBIYGhxH8DLeEBVm5yQc5MrzaqjpvlKDY=;
        b=xPZh/NmHcNJpLUREsVr5/UbJazCcll8rlPrViWLETtDrLYwH1sLJaNg35+/Xi81XUt
         i2F8iDm6/O5bD8KGv90cUyZOv1RMhxgdsU0XGaB1+QJW5CC54k/tT44snWVDiz597Uf+
         NNfkhnxde7FEvzwVo3OwBmpfDV0WQxF6apKxRJsFZc/K3BMgLGopqKiSUbXdh1KqwkVr
         qSfy+Yy4wEIkKPU+rVXpzC9GqPwhvEjBk1HneEwkQXExGo6AQZQ/z45IbCxT9+djgfLs
         UFSecMNbH7tTeZ63Fu6aX1qvF2y8+IrE3ctxP5s+30PNQ7WZ/ZxExlyEnnpDxTU01gTD
         IF4g==
X-Forwarded-Encrypted: i=1; AJvYcCUfoNu8HR43H96WeSJDkjv2kCt2tS7XyyiJRlqnRaSiyDK9eXLBm+U7vvJ7yUOZulSGxG5AcWbjU4/P8c6M+1NY5JyCv5PV
X-Gm-Message-State: AOJu0YzZNwh7K0SQrQvOxLbnwLrRfvF+YV0Xy2Ie9Qenhmaa2wq/LDXb
	R3rOMFBY/ZFksjLGKGLV9c+g0qUT+/pElzifbun2hAiXbIEVQ2/X
X-Google-Smtp-Source: AGHT+IHtLLRi1CZ3LZdkfL5FbfuZA42wii54hrThtdt2bi6gLHD7vzrqv5tXiwCI7ug5mBJYWzFoVQ==
X-Received: by 2002:a05:6512:31d2:b0:52c:e3bd:c708 with SMTP id 2adb3069b0e04-52ce3bdc757mr1918858e87.10.1719193651739;
        Sun, 23 Jun 2024 18:47:31 -0700 (PDT)
Received: from mobilestation ([89.113.147.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cdef3058bsm532328e87.140.2024.06.23.18.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 18:47:31 -0700 (PDT)
Date: Mon, 24 Jun 2024 04:47:28 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
Message-ID: <xafdw4u5nqknn2qehkke5p4mrj4bnfh33pcmkob5gbl7y5apr4@pkwmf6vphxsh>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
 <wosihpytgfb6icdw7326xtez45cm6mbfykt4b7nlmg76xpwu4m@6xwvqj7ls7is>
 <eb305275-6509-4887-ad33-67969a9d5144@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb305275-6509-4887-ad33-67969a9d5144@loongson.cn>

On Mon, Jun 17, 2024 at 06:00:19PM +0800, Yanteng Si wrote:
> Hi Serge,
> 
> 在 2024/6/15 00:19, Serge Semin 写道:
> > On Wed, May 29, 2024 at 06:19:03PM +0800, Yanteng Si wrote:
> > > Loongson delivers two types of the network devices: Loongson GMAC and
> > > Loongson GNET in the framework of four CPU/Chipsets revisions:
> > > 
> > >     Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
> > > LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> > > LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> > > LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> > > LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
> > You mentioned in the cover-letter
> > https://lore.kernel.org/netdev/cover.1716973237.git.siyanteng@loongson.cn/
> > that LS2K now have GMAC NICs too:
> > " 1. The current LS2K2000 also have a GMAC(and two GNET) that supports 8
> >      channels, so we have to reconsider the initialization of
> >      tx/rx_queues_to_use into probe();"
> > 
> > But I don't see much changes in the series which would indicate that
> > new data. Please clarify what does it mean:
> > 
> > Does it mean LS2K2000 has two types of the DW GMACs, right?
> Yes!
> > 
> > Are both of them based on the DW GMAC v3.73a IP-core with AV-feature
> > enabled and 8 DMA-channels?
> Yes!
> > 
> > Seeing you called the new device as GMAC it doesn't have an
> > integrated PHY as GNETs do, does it? If so, then neither
> > STMMAC_FLAG_DISABLE_FORCE_1000 nor loongson_gnet_fix_speed() relevant
> > for the new device, right?
> YES!
> > 
> > Why haven't you changed the sheet in the commit log? Shall the sheet
> > be updated like this:
> > 
> >      Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
> >   LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> >   LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> > +LS2K2000 CPU         GMAC      0x7a13          v3.73a            8
> >   LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> >   LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
> > 
> > ?
> 
> No! PCI Dev ID of GMAC is 0x7a03. So:
> 
>  LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a 1
>  LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a 1
> +LS2K2000 CPU         GMAC      0x7a03          v3.73a 8
>  LS2K2000 CPU         GNET      0x7a13          v3.73a 8
>  LS7A2000 Chipset     GNET      0x7a13          v3.73a 1
> 
> > 
> > I'll continue reviewing the series after the questions above are
> > clarified.
> 

> OK, If anything else is unclear, please let me know.

Got it. Thanks for clarifying. I'll get back to reviewing the series
tomorrow. Sorry for the timebreak.

-Serge(y)


