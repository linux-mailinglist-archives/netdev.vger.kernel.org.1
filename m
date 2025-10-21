Return-Path: <netdev+bounces-231271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032FBF6CB0
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335EB3ABCC6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F0F33711A;
	Tue, 21 Oct 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UeAchJ+t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B7337109;
	Tue, 21 Oct 2025 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053591; cv=none; b=Err2FYxOpFOAoyqh8QYYjwtF9/EM/yHMDPcG50zsH+u9X5N1cyh4GChUf6pm30wseqnC6IFJYgc1+5KzADrmW/Cjr71Xw9mxaqyJYXy8ZF3O2um/35btbhcLJpdtr1pJN6dl+ZhqnbIUL9KjZmpu4XDvtwOkjQfuLjoOKm3S7YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053591; c=relaxed/simple;
	bh=Au3OrEsCcvTK/TXBFAkTWNShigKKtPoww0ckto4phYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p768qGPhCA92nXg3hKuz+Six7gsFZAU4kWcoB0W9AOGdHJAbrYRqhAe0EgRQZCr/qWuhSskwQRMOoKa99iAHXVF66G6qwho3nRf3c+nMeuE32QsDjNJTqMpDWoidptPkUJ4NICOb87G074Qh8PA0UFCXSV4bl45pS0Ks8CVekBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UeAchJ+t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ud+LTcfAQFSU5N/YiQwiVPQeaCTdctueWoB84H8uXJQ=; b=UeAchJ+tkW3PiG+7+hh4Vshd+1
	KRcsdGuDthlrRQIuKSJTF6Yb3iv+MlDnV4ZDPshGgQKLnMBgwSxd8kTBbZgZSmjISMPRP/lHXZNCZ
	bPUSyQrY1+e21Mz5U3aMdh3deOpPzb/V1vsyW0xqaS0TD4pqtK0z1Jksb+NJatm+usgU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBCTx-00BddN-1s; Tue, 21 Oct 2025 15:32:57 +0200
Date: Tue, 21 Oct 2025 15:32:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robert.marko@sartura.hr>
Cc: daniel.machon@microchip.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	horatiu.vultur@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Subject: Re: [PATCH net] net: phy: micrel: always set shared->phydev for
 LAN8814
Message-ID: <17e75178-582f-495d-97fa-0868c79b7026@lunn.ch>
References: <20251021132034.983936-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021132034.983936-1-robert.marko@sartura.hr>

On Tue, Oct 21, 2025 at 03:20:26PM +0200, Robert Marko wrote:
> Currently, during the LAN8814 PTP probe shared->phydev is only set if PTP
> clock gets actually set, otherwise the function will return before setting
> it.
> 
> This is an issue as shared->phydev is unconditionally being used when IRQ
> is being handled, especially in lan8814_gpio_process_cap and since it was
> not set it will cause a NULL pointer exception and crash the kernel.
> 
> So, simply always set shared->phydev to avoid the NULL pointer exception.
> 
> Fixes: b3f1a08fcf0d ("net: phy: micrel: Add support for PTP_PF_EXTTS for lan8814")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Please could you look at how this patch and

[PATCH net-next v2] net: phy: micrel: Add support for non PTP SKUs for lan8814

work together. It might be this patch is not required because of
changes in that patch?

Thanks
	Andrew

