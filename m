Return-Path: <netdev+bounces-65989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5626283CCF7
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 20:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3808B23BE8
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 19:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7261350D7;
	Thu, 25 Jan 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xK8jQsnz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A20134759
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212527; cv=none; b=m91XbfM5yL99Pfjucc/+jHWInDU7CJxkTA2DZciQr1yKo/q14hrgr73/9pbPCer8QQOpCUTyTw2nzsSq5fnAj1J8vNkKOkeC9x7RmHm+LtY81s+GD/LwrBMfu2K3L4LN6JMd8itWrsFk6dkNYy5J19p8d7YQdLY/QQG+oSNQcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212527; c=relaxed/simple;
	bh=SY4UZ1JGCGMF3kvYPK751nmnx2JsrIIyeNc4ZQTCIL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9oFxOacUjI02zdaNi2Fz3hYUH34j6M5BjfHZOubEL8CSVCVVzw1hBCKgjs5O2rlxAlUNCFS7m2+QhX4PDNkx+IzJ4Pcw77+xPd2Ok/Gl/Q9I1LxRUybBCIuC7RktD3+c+QvfHUUWK/68gVkiu1/HVukyx9+nv02rnoSgk12xxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xK8jQsnz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YFuXmu95D8OjumfgEKxIJpvhU5j/7YKoXBYCI815W7g=; b=xK8jQsnzDcQThqxOP6z6CH0NKe
	B7ZJv7+WKUtZoKoNmSAOUzkYJXA2M0avKIqEDykAc4K2+loI175m9aOqc7h72cdjGsZZQajNN2Ftv
	islj4s3rPwZFoaUa0+jHG+cVQRCw7/hq5lZMYdgsWuBKSIj4Yoy4kbq+W9FWKu5ypsuQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT5oQ-0067JR-QJ; Thu, 25 Jan 2024 20:54:58 +0100
Date: Thu, 25 Jan 2024 20:54:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Haber <mh+netdev@zugschlus.de>
Cc: alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jisheng Zhang <jszhang@kernel.org>, netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
 <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
 <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>

> I have checked out 2eb85b750512cc5dc5a93d5ff00e1f83b99651db (which is
> the first bad commit that the bisect eventually identified) and tried
> running:
> 
> [56/4504]mh@fan:~/linux/git/linux ((2eb85b750512...)) $ make BUILDARCH="amd64" ARCH="arm" KBUILD_DEBARCH="armhf" CROSS_COMPILE="arm-linux-gnueabihf-" drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst
>   SYNC    include/config/auto.conf.cmd
>   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
>   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
>   HOSTCC  scripts/kallsyms
>   UPD     include/config/kernel.release
>   UPD     include/generated/uapi/linux/version.h
>   UPD     include/generated/utsrelease.h
>   SYSNR   arch/arm/include/generated/asm/unistd-nr.h
>   SYSTBL  arch/arm/include/generated/calls-oabi.S
>   SYSTBL  arch/arm/include/generated/calls-eabi.S
>   CC      scripts/mod/empty.o
>   MKELF   scripts/mod/elfconfig.h
>   HOSTCC  scripts/mod/modpost.o
>   CC      scripts/mod/devicetable-offsets.s
>   UPD     scripts/mod/devicetable-offsets.h
>   HOSTCC  scripts/mod/file2alias.o
>   HOSTCC  scripts/mod/sumversion.o
>   HOSTLD  scripts/mod/modpost
>   CC      kernel/bounds.s
>   CC      arch/arm/kernel/asm-offsets.s
>   UPD     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
>   CHKSHA1 include/linux/atomic/atomic-arch-fallback.h
>   CHKSHA1 include/linux/atomic/atomic-instrumented.h
>   MKLST   drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst
> ./scripts/makelst: 1: arithmetic expression: expecting EOF: "0x - 0x00000000"
> [57/4505]mh@fan:~/linux/git/linux ((2eb85b750512...)) $
> 
> That is not what it was suppsoed to yield, right?

No. But did it actually generate
drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst Sometime errors
like this are not always fatal.

> My bisect eventually completed and identified
> 2eb85b750512cc5dc5a93d5ff00e1f83b99651db as the first bad commit.

I can make a guess.

-       memset(&priv->xstats, 0, sizeof(struct stmmac_extra_stats));

Its removed, not moved later. Deep within this structure is the
stmmac_txq_stats and stmmac_rxq_stats which this function is supposed
to return, and the two syncp variables are in it as well.

My guess is, they have an invalid state, when this memset is missing.

Try putting the memset back.

I also guess that is not the real fix, there are missing calls to
u64_stats_init().

	Andrew

