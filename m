Return-Path: <netdev+bounces-151090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034569ECD1B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCE31667E5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB01229142;
	Wed, 11 Dec 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U4h+DLoZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F923FD06
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923492; cv=none; b=KiudNW6TupS+WtG/UOnbKwWfF2nkpuGgMpERI5p/VoIBLk1MSVFROZMcNOXBdHhWppeKPBgyXEYVjdsY6/e/BqlHtyML1cNc4eZmXP6ZP3zweGPgaFEdEZ3mR/q67PIeOwNcMNk8KFBZ5ILBo9VmF3qhuhg3ORK+dt7Um9wAFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923492; c=relaxed/simple;
	bh=XDXsFQQnPxvqPNDW5QArrGdvA+ChGJjNjNMEZLwJ0sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMTFVQNWGO94g/rjsR6n4nt7zebaIeJgw2C+z0P6vhdZp9U2ZubEjhol8vM7TfD1NZWGFA/aKHMBdVuLDePi5K1TCyB8wdQ9GSoMPX1FyF+IElXZCjnQHvOH/CQkxgv2cNnI1/V9BC2Qy3frqtdBeky7yhDUinwSk2Xba/9v0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U4h+DLoZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v9JFD3/eBxX4wwajv6sfQUtiL7bKSNhXLTi6fFjzdms=; b=U4h+DLoZTxxYLz8mpswI/d/wj6
	eKPY/oKiwmfJdqscAdxbFdqQR0Wxrarzv+OYM6hPC+pueav97gbHB5r2bnL6dIgznmf03U8I0xexd
	3Zr4Kw3UkIThB3eGWypZTm0OfNY7lBuOqXbQfbj0635n/PmcwH38jeIAZ6uWB7L/kMOY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tLMhn-0006AC-Ex; Wed, 11 Dec 2024 14:24:43 +0100
Date: Wed, 11 Dec 2024 14:24:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Eggers <ceggers@arri.de>
Cc: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>, netdev@vger.kernel.org
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <7414a217-6031-4470-b913-23ba4ab2b079@lunn.ch>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <zhuujdhxrquhi4u6n25rryx3yw3lm2ceuijcwjmnrr4awt4ys4@53wh2fqxnd6w>
 <njdcvcha6n3chy2ldrf2ghnj5brgqxqujrk4trp5wyo6jvpo6c@b3qdubsvg6ko>
 <5708326.ZASKD2KPVS@n9w6sw14>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5708326.ZASKD2KPVS@n9w6sw14>

> https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-DS00002419D.pdf
> 
> But the text description on page 52 says something different:
> > SCL is expected to stay low when SPI operation is idle. 
> 
> Especially the timing diagrams on page 206 look more like SPI mode 0.

You probably want to Cc: some SPI people. netdev people don't normally
get involved in low level SPI stuff, so are probably not going to give
useful comments.

	Andrew

