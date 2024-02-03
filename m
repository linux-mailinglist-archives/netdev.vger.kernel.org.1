Return-Path: <netdev+bounces-68856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C58B8488B5
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3542D1C2266E
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0156617CD;
	Sat,  3 Feb 2024 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0PDKFCwM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9BDDA6
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706992549; cv=none; b=SvRuVYGlcMk/nP5UPB4g8i1CKi852q+VvE8eM+18HadQhWkD3z9bRba15FqYjWkW0Vp48Zs8I0KU3uVgAJ0Zr/R9fWa8rsRdd7aj8ehrhdcM81bn+lNXf3fkFlVmF+Q4r/CdefJw7BInJLYObxQ19GUZPRNKHXqDCcLUBFFWw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706992549; c=relaxed/simple;
	bh=Xj5wcsU6SPjO6K/Gzvl3Ih3QeqLNzvWW+2n18YN3RmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePU6F/7qn4M/F4kUuubH0qe2p+wmG54TzsDCREHus8vhWZFvRyf7SgW+MG23IUSyxNvjv5RaIu5cFDWvIjOeR2ovS2R7mWduy2t0p2W4QlUhEn7ZPbpMUbvwekDaQ5+gEInI216+r+ItBUYViPmaHrOjuSMiKjBneEmHne4rDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0PDKFCwM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ckcBhNq/PHGXLGT0NkZ9e4hANiRKHn4d8+V8aLvsmFM=; b=0PDKFCwMbMsTBoNGD995wo7mYJ
	C4pgwO1X4CMDz5ADOP6bkyCEtU55jHL+jcv/jyjhdn23cJohwrN7fUkOSioPMPQ2tryvIlkh58gv7
	f4AJivX5/wblJnmlhhU51p58suflmDi6VJN6ks+nlMkhox5uXIqJJzP7lx1y3VmgPnTU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWMje-006vNP-NZ; Sat, 03 Feb 2024 21:35:34 +0100
Date: Sat, 3 Feb 2024 21:35:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] net: phy: add helper
 phy_advertise_eee_all
Message-ID: <3f25417e-105d-43d5-a74a-0cf613e7fa88@lunn.ch>
References: <0d886510-b2b7-43f2-b8a6-fb770d97266d@gmail.com>
 <20bfc471-aeeb-4ae4-ba09-7d6d4be6b86a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20bfc471-aeeb-4ae4-ba09-7d6d4be6b86a@gmail.com>

On Sat, Feb 03, 2024 at 08:53:15PM +0100, Heiner Kallweit wrote:
> Per default phylib preserves the EEE advertising at the time of
> phy probing. The EEE advertising can be changed from user space,
> in addition this helper allows to set the EEE advertising to all
> supported modes from drivers in kernel space.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

