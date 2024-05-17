Return-Path: <netdev+bounces-97038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17FC8C8D96
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 23:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118371C20BDC
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 21:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D31DFE1;
	Fri, 17 May 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgemail.eu header.i=@georgemail.eu header.b="I0cn/pgb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A29393;
	Fri, 17 May 2024 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980556; cv=none; b=elvGQZ7Uy/bF0u2OMZGkr/aeQ3A2G1PEKGgVeariARrOEOryi5ZBtXtxHYmzIQFF/3X/CJZn/cNCYgp74uvGTziDBnJJaQMyFLVziWeAfcXkLiwGhOCekW3VwNU8P9ISxhHcZaS4irTbEPPTxlVMZFDIBXsVB8553+Q5AzpGUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980556; c=relaxed/simple;
	bh=XZ5me8/J7T42PW5eoCeLmIyHORHTZR9AvKTz3ubGHKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4YOjp/mL6tcR2BCFPeZXgL91Xrt5RGsB6roIVBDpvqzEAWt7fMKKtAZxROuNoeKeYRLi1UZqob96v1IZet+D0FbUYEMr4JRye6Fl2bfa0V3atKnNlNNHeU03ZQcZ/ZyNXasH0IvWn0i7hgIQfo+wXvqzeotRAvQQ49lr2wmwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=georgemail.eu; spf=pass smtp.mailfrom=georgemail.eu; dkim=pass (2048-bit key) header.d=georgemail.eu header.i=@georgemail.eu header.b=I0cn/pgb; arc=none smtp.client-ip=85.220.129.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=georgemail.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgemail.eu
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp6.goneo.de (Postfix) with ESMTPS id 38140240539;
	Fri, 17 May 2024 23:15:46 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 44690240488;
	Fri, 17 May 2024 23:15:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgemail.eu;
	s=DKIM001; t=1715980545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yG9V3x5znA/PPQLlkG+UCqZf359eOQIgdROgM+lPFGQ=;
	b=I0cn/pgbh/lJcePAjbqnK/ynKq3a/wP+bdYOg7ZoNK4ckxBvEOZQ0/RtJpbdJmfov91OfO
	0c//tzUKmIKQ3w3B292KwNx+U9RUfk3+MXxHoNM5a5qxsdL/o3P1X4zTgX96lW8Vopj/4e
	Odzh9/jW8+K4vXa150BF018OoZz6cxFNCxxJutPUDPBSfEZru80jqezdwoHF1qkrQxFCmP
	Tk/BRSa4y4DhOopMbBeYZcoAop06uIJNtPVFRYAeNxnkI4TC4nXkuFudcKwLqpU6+hSsh7
	Wms1szgB2otOjOdyz53/SOlY+0LrQ0dzEoXJxBAGQDytKwMyuE4SknEeoqcQww==
Received: from couch-potassium (unknown [IPv6:2a02:8071:5250:1240:f4e6:f6d2:6d95:e0c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id B2FB524030E;
	Fri, 17 May 2024 23:15:44 +0200 (CEST)
Date: Fri, 17 May 2024 23:15:43 +0200
From: Leon Busch-George <leon@georgemail.eu>
To: Conor Dooley <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org, Matthias Brugger
 <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] net: add option to ignore 'local-mac-address'
 property
Message-ID: <20240517231543.325d6838@couch-potassium>
In-Reply-To: <20240517-unscrew-handsfree-c0fe02c67b3d@spud>
References: <20240517123909.680686-1-leon@georgemail.de>
	<7471f037-f396-4924-8c8d-e704507de361@lunn.ch>
	<20240517-unscrew-handsfree-c0fe02c67b3d@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: 8b1131
X-Rspamd-UID: 49483c

Hi :-)

On Fri, 17 May 2024 17:13:18 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, May 17, 2024 at 04:07:08PM +0200, Andrew Lunn wrote:
> > On Fri, May 17, 2024 at 02:39:07PM +0200, Leon M. Busch-George
> > wrote:
> > 
> > > Restore the ability to set addresses through the device tree by
> > > adding an option to ignore the 'local-mac-address' property.
> > 
> > I'm not convinced you are fixing the right thing here.
> > 
> > To me, this is the bootloader which is broken. You should be fixing
> > the bootloader.
> 
> IMO this is firmly in the "setting software policy" category of
> properties and is therefore not really welcome.
> If we can patch the DT provided to the kernel with this property, how
> come the bootloader cannot be changed to stop patching the random MAC
> address in the first place?

.. and ..

On Fri, May 17, 2024 at 04:07:08PM +0200, Andrew Lunn wrote:

> I'm not convinced you are fixing the right thing here.
> 
> To me, this is the bootloader which is broken. You should be fixing
> the bootloader.

I agree changing the bootloader is the better approach and I'm absolutely
willing to accept if this isn't the way of the kernel. Also, since posting
this, I was made aware that it's possible to remove the 'ethernet0' alias
to stop the unwanted activity.
There's no longer much reason for me to work on this.

There's only that slight annoyance of configuring a mac address assignment
on the device tree and the kernel silently ignoring it.
But, I guess, that doesn't happen if the proprietary bootloader isn't
creating "local-mac-address" properties - rather than only changing existing
ones (which is what mainline U-Boot does).

On altering/replacing the bootloader:
It is not always possible or feasible to replace proprietary bootloaders on
proprietary hardware. Many of the routers I work with effectively become
bricks if the bootloader doesn't work. If it has one of these chunky DIP SPI
NORs, then might be possible to restore using the right hardware but the two
devices mentioned in the commit both have QFP NAND that I cannot read
without the help of software running on the board.

> One concession might be, does the bootloader correctly generate a
> random MAC address? i.e. does it have the locally administered bit
> set? If that bit is set, and there are other sources of a MAC
> address, then it seems worth while checking them to see if there is
> a better MAC address available, which as global scope.

I like that idea! All the addresses that were generated on a few reboots for
testing have it set.

Let's hope we wont get a reason to implement that too soon :-D

kind regards,
Leon

