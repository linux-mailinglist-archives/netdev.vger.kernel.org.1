Return-Path: <netdev+bounces-110254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA83192B9C6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0996D1C2115F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784FF158A02;
	Tue,  9 Jul 2024 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INv1g0DR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBEE2B9D4;
	Tue,  9 Jul 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529112; cv=none; b=ASf/UeahEzne7jBmgsHL3mulyK2HJy3UIPUJYQRRvQPxPsz2BN09cz1kUX0CZG8yNTkjWBkBSfDPPI+9+qKQTQG5N6E7S2RkkeBu5XGs2yHWW4kdRRLsDk1dr6vNb98pnMZjDKZtoFN2p/kDvx1rbKerZLIi1Wen2gsk5T7znIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529112; c=relaxed/simple;
	bh=yFQzCYDWKZHNil0VhVLf1v51X/j/lFsJuPiW6woxYgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTksF++7NstfuBttOvHARrwpejihufW6iJqPLbb9M559UfYeBscyGFHcsIHkSOhGD0i4UFAEvyFrOg7uehlACtGe5WruwfuMF0i0QL2+UP0OCNdgkA+JhMDpoDhW2+CDo03t1HfTOmIutq8dUh3exDVmlB8G4nuOavkx+lKWi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INv1g0DR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77c349bb81so448200366b.3;
        Tue, 09 Jul 2024 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720529109; x=1721133909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xE7ByKNc5E5Jc1wKL8KG6ET8SWs9CYKJyRRw08AComY=;
        b=INv1g0DRn8vMQP7t7zwdRyP4Kr+rFf/gCovPoFtWyOfGAJw0NuCYlHZesU18GYWIBK
         54f5yD6PaMP5ZAkxA+8tjW1EkVyWWBVFBkU4JXD6mQ2Fxhk3SJYvh82aMB1OkH8WcJh5
         nWKMy/K9mLii7PTEBFmLqMFiWZoNMQGpBoxNCi7ChzOwTZAPQK+TxbC5VQNPEzKuxoTC
         BJSpbagpocuYFOU24kT1l34pB5pTBagxT1fYdNl3UMUmA4KRYys0Bnc81bHRS1FZvZBi
         PlrIxQU0RjZFKohXxzuVEzXKmfkX6UoHU/x8wk1iLQBC3B7z4D+z91e5UDLRX0/kZsiw
         5k+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529109; x=1721133909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE7ByKNc5E5Jc1wKL8KG6ET8SWs9CYKJyRRw08AComY=;
        b=bdAsrhe8J3pSNkWN++togviGMhTLG1J973NJ4kDTsgTRv831ZP14E/LhxYctmwThUf
         b2u5KxzBRtk43/v/d1dD2k/PYFS9jYnsa2uLm4+SuT4j5fXNPCa4ajjefKxXhc5x/sR2
         3WaOKPnCrkuAPuRuSsH14vPcq7Os7BQIHCHLJCmnk+qbJzXClbTvZ/JtRlB6mdvB0ZAx
         70vU6v0LtToedej7e84X89+UiYx2ZGHRyb2apyWX0kBLAZoWiI/j8SAcUEmzlAUBLvX4
         2mdDFQyXpyw8UUTme3PMyIqhT3mnSN7FPIY6UniRK280zexrxuVBtR/ICbo/9xkDe20e
         D3ng==
X-Forwarded-Encrypted: i=1; AJvYcCWdrEUme9nOq8RFBo4sM7Xiv2jceGDJ1RSAy75S6UxRueRcPq1MK5AXPl/GR3+bXUAR1JVpTYazmDCS5naT6CgCctUSVerS6JpBcDD+bV5ycDVP7lKq0bZPKmbQngAh5YiahpCxhaUikzNP/FHZnctE9UGXUhjt+Of5gylxf0XW3w==
X-Gm-Message-State: AOJu0Yz9QX7MSoDoy3L00PqkEQu61B43FEeOmpgjXfP4Lh/YzFQiKVtZ
	QmMro0yLX8tRz22Z/UX1V9FhuB10KSMcn5znZPVVPNd6riGNkpd+
X-Google-Smtp-Source: AGHT+IELiYQOG9o7ZSqxbSBQOf8eGO2u0vcUtyNN0rM9xp2ommpq7yGdxF9YDBi3Kan0LNQHUsKGnA==
X-Received: by 2002:a17:906:c090:b0:a77:de81:c7b0 with SMTP id a640c23a62f3a-a780b6b2ef8mr153437066b.22.1720529108645;
        Tue, 09 Jul 2024 05:45:08 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a87204esm74507766b.222.2024.07.09.05.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:45:07 -0700 (PDT)
Date: Tue, 9 Jul 2024 15:45:03 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: John Thomson <git@johnthomson.fastmail.com.au>, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] net: dsa: generate port ifname if exists or
 invalid
Message-ID: <20240709124503.pubki5nwjfbedhhy@skbuf>
References: <20240608014724.2541990-1-git@johnthomson.fastmail.com.au>
 <20240608014724.2541990-1-git@johnthomson.fastmail.com.au>
 <20240613114314.jxmjkdbycqqiu5wn@skbuf>
 <Zm2mOZGPuPstMdlB@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm2mOZGPuPstMdlB@makrotopia.org>

On Sat, Jun 15, 2024 at 03:33:30PM +0100, Daniel Golle wrote:
> Sounds fine generally. Where would you store the device-specific renaming
> rules while making sure you don't need to carry the rules for all devices
> onto every single device? Would you generate a device-specific rootfs for
> each and every device? For obvious reasons this is something we'd very
> much like to avoid, as building individual filesystems for ~ 1000 devices
> would be insane compared to having a bunch (< 100) of generic filesystems
> which some of them fitting a large group (ie. same SoC) of boards.
> Most OpenWrt devices out there are based on the same SoCs, so currently
> the devices in the popular targets like MT7621 or IPQ40xx all share the
> same target-wide kernel **and rootfs**.
> 
> tl;dr: The good thing about the 'label' property is certainly that such
> board- specific details are kept in DT, and hence a generic rootfs can
> deal with it.
> 
> As having the 'label' property applied also for non-DSA netdevs by the
> kernel has been rejected we did come up with a simple userland
> implementation:
> 
> https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=2a25c6ace8d833cf491a66846a0b9e7c5387b8f0
> 
> For interfaces added at a later stage at boot, ie. by loading kernel modules
> or actual hotplug, we could do the same in a hotplug script.
> 
> So yes, dropping support for dealing with the 'label' property in kernel
> entirely would also fix it for us, because then we would just always deal
> with it in userland (still using the same property in DT, just not applied
> by the kernel).

2 thoughts come to my mind.

First there is the focus on the user, which in the case of OpenWrt is
the home user. What does he want? We are debating where to put a fixed
Ethernet interface name, but does the user want it to be fixed?
Like, if I were looking in my system log, I would certainly prefer if I
saw 'Network device 'printer'/'nas'/'pc' link is up' rather than 'eth1',
even if it says 'eth1' on the chassis.

With that in mind, I would say it would be preferable to ship
architecture-wide udev naming rules, which essentially give each
netdev a predictable name according to its SoC position. Then give
the user the possibility to use that udev rule file as a _framework_
and name the interfaces as he wishes. The OpenWrt wiki for a board can
list a diagram with the correlations between SoC interface names and
chassis labels, in case the user desires to preserve that (the board
will be used on a bench and the labels will always be visible, rather
than being more easily recognizable by their role).

Then there is the fact that we are dealing with low-cost boards with
low-cost/low-effort design. Ilya Lipnitskiy brought forward a case where
the chassis had labeled the ports 'eth0', 'eth1', 'eth2', ..., which is
clearly a design problem since it conflicts with the way in which the
kernel naturally wants to name the devices ('eth0' is the initial name
for the DSA master, but also the chassis label for a DSA user port...
yay...).

I don't honestly think you can/should fix low-effort design.

But, if you insist that putting fixed netdev names in the device tree is
the best option, I suppose that could be considered a low-effort
solution which belongs to the same general theme.

But I don't see why not go low-cost all the way. Since 'label creates
(avoidable) conflicts with DSA, why don't you just name all of them
'openwrt,netdev-name' or something, and proudly own that low-cost
solution as a downstream scheme which needs no kernel support
whatsoever (you parse it from the init scripts as you already do)?
U-Boot also is another example of a project which uses additional device
tree properties for its own purpose.

