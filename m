Return-Path: <netdev+bounces-105879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96D91359F
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 20:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2301DB20ACF
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 18:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE713273FC;
	Sat, 22 Jun 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lZMI/Fpf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9CBC2D6
	for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719081221; cv=none; b=UfXZFjDmpfMFkc/6iKAHGPsGlL9GFuqQqh3tMaeaLYgz/YqNDHp+c59go5yxITRhBELQ7guWC5Ok/N1jVquuwaXiNYFJwtFKdNlXfbYzFrFTE9A1KhPBzgS1gGPNkGsn9zDvBr3tM+V1ctBtkwf+9dlUfxll4H20U86Vb7ooadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719081221; c=relaxed/simple;
	bh=JiUU/hofzlTWJYVtZpBlaS75QnohrS78GuR+U1TlRes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc2NajpvpW7Gu0BpoTU2rA21LUcXKWRiRLEHLAQLmRTQk2BjrE4n9lDeg/TXRESE4s2Wb5y/Tgnv7WXnKUdNfZANLTsYWKZ+aAnx8mihZcbSBY9S8QnsixNF77knOs8Cqq2j7YgtmerK+/nioYYZrgEzai0YFJqcrnigJZu0wkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lZMI/Fpf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xYqlvwPGLLJMZkLapWcq9q4z6+vs/sHkpyjbJV1sQAE=; b=lZMI/Fpfw2ptm6CZTUCErw4p/o
	OuidEr5PA1n64cgjyuHXj+3jLgwUfyHa4//M9ruoZju/sYJnQJas6Q+92RIIrtJQEJ+IXsOqVAxxt
	+4W51nwA6/x7Bat8hrCWloZim7eofDbCRaIyvVKshaNji9Z5ij9IGwQhDql/SPJHoux4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL5YP-000kGO-NI; Sat, 22 Jun 2024 20:33:37 +0200
Date: Sat, 22 Jun 2024 20:33:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	horms@kernel.org, Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com
Subject: Re: [PATCH net v7 3/3] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Message-ID: <cecf8c0f-b86c-4371-805f-00630c17f22a@lunn.ch>
References: <20240621144322.545908-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240621144322.545908-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621144322.545908-4-enguerrand.de-ribaucourt@savoirfairelinux.com>

On Fri, Jun 21, 2024 at 04:43:22PM +0200, Enguerrand de Ribaucourt wrote:
> The errata DS80000754 recommends monitoring potential faults in
> half-duplex mode for the KSZ9477 family.
> 
> half-duplex is not very common so I just added a critical message
> when the fault conditions are detected. The switch can be expected
> to be unable to communicate anymore in these states and a software
> reset of the switch would be required which I did not implement.
> 
> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

