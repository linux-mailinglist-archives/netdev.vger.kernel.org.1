Return-Path: <netdev+bounces-250898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F4D39785
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89CF03009C37
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C533C501;
	Sun, 18 Jan 2026 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jgdnyqyD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE0339705;
	Sun, 18 Jan 2026 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768750790; cv=none; b=jkkypIgVs01z8585pRs3nYDNwgIrpFzoYPhiBI1pcdgMxuug3MLtUldMVJnYVAHTd2s8K57x8eMKgA1FGwT+wDNkUApenqsBk6Zd1o4lTNurY5KrANn7FB3CGTt5LVGVE/1Dnb82bIcuKytyUf9GHsL1L31yPIe5TN9k8B7lm6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768750790; c=relaxed/simple;
	bh=3cljaZX4MftJI3x+tD64w8hKKD/Ow5kxsUCyXPDQ17Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHk8ePMpnh68faAX+wsSlNB3akdefbJjjP1DfSOjukGA4oLraOws39BoKIvvs0ouFIuk1TjyT6PTekcaIqAP2hOTgT5MVfGpNZ64SuAV0PoqfnmGSG//qB6svaXIolyDKlLcVvkwerC0PVieDkCMsfuZpchtjZY9jy9AiAoC1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jgdnyqyD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ttrYSm1qqlpDwZLgjLFL+Ecd0cZFbfjpIPt71Gx5Bng=; b=jgdnyqyD2mEHu8WOsUynsa100B
	7/QJDcQxnBpBR4OVKV38/GpuaZoEbYsztXdvhXkRsYLwxW11+Fq+wzqWgBOGgyvBscj5DYQYkyedx
	U3bID7FKV5QPzZ0+1tBBmUowgsbdr1jKbFZy7hTHZGdXXcFcpAVEekKVQ+vU5uxMgszs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhUsM-003Mec-6F; Sun, 18 Jan 2026 16:39:38 +0100
Date: Sun, 18 Jan 2026 16:39:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
Message-ID: <66e8424c-86c9-4ad7-a3a7-3c277bfa5432@lunn.ch>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
 <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
 <5e7c71f6-80dd-408b-a346-888e6febf07a@lunn.ch>
 <fcf7b3f2-eaf3-4da6-ab9a-a83acc9692b0@bootlin.com>
 <fe1bf7b6-d024-447c-a672-e84f4e77f8d7@lunn.ch>
 <91442f3f-0da9-4c52-89ce-2ca0a3188836@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91442f3f-0da9-4c52-89ce-2ca0a3188836@gmail.com>

On Sun, Jan 18, 2026 at 10:43:12AM +0100, Jonas Jelonek wrote:
> Hi,
> 
> On 16.01.26 15:25, Andrew Lunn wrote:
> >> But let's first figure-out if word-only smbus are really a thing
> > Some grep foo on /drivers/i2c/busses might answer that.
> 
> Did that and haven't found any driver in mainline which is word-only.
> All drivers with word access capability have byte access too.

So for the moment, maybe add a WARN_ON() for an I2C bus that only
supports word access, and we can deal with it only if we ever get a
report of it firing.

   Andrew

