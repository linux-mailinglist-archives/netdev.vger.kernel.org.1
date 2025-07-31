Return-Path: <netdev+bounces-211209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2EEB172AD
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB216229F5
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF47263D;
	Thu, 31 Jul 2025 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jjv0QZtt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B91EB39
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970501; cv=none; b=S1T7sSgo2Tz74T1YIyffTWT7u25DV5ievQuIeZIuWWHWylsgH8tjEVKoZ59kKvC1X9jv8cQgRXE7jgY/YTSlGUSZtCkXDIa9weRx7kjylDt8+LOLTFQ+umZNnPBq+D32xkImK+MCcE0Dj6HuAQW7Q3zP6XlTacwfLmWlI8ITXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970501; c=relaxed/simple;
	bh=USDdoxuGA6Bj5xoS+OOkVS1MDngFx2fcJgdzQZqOgew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV2/A/63Z5xmBUF8/zjp8JqX5zVMVbh4Lo5Y9fm/yKkjDTaWta6njUxtaL3zWk1Y67p7U9G7nosKJnDVnmUXKQCbJIshhIpkWD/TmKe/P6IW6y/NgFkIUzUn6Ue2OLaAj0p9vz9wSujUYU7oNbA0yYUJYEb84/Qj83FIdtWSZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jjv0QZtt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dIHqboV7OhWBWWVRbKz+QfM9hEbHqpdnTvADZiKtNiI=; b=jjv0QZttDeWBQoiS1/NFLQHnKK
	vyelbtFJ35bPwWupYEGfEUsPpL2UqxZUKqmqwdtDCaL/ZvZOUWsWrKSmCwGEhuQDmb0PIsT4+sBia
	sWeNjseyPLfOrWFJwBngX8jrIHSjTO/if1ICpnKxfDof+sn2cS7vkiiPjuO1Rc8XyDyGZhyJR3Y4L
	kCg8SDEvk+3k1yNvrjft3k3x7RzGyVDaQC8FiB2YItHs3iUulU95mKs+kwW+xPwtKLVJ1Ggds8xJH
	Y0FzJei9QG5k8AV/6T/I/i+dVinXnuu0cmlI8YSBOuPvMdS73PEhnWyMKPdVbJN9YCiMfWKKDTyJI
	Zhgsgymg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33824)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhTqY-00054d-1e;
	Thu, 31 Jul 2025 15:01:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhTqT-000152-10;
	Thu, 31 Jul 2025 15:01:21 +0100
Date: Thu, 31 Jul 2025 15:01:21 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: markus.stockhausen@gmx.de
Cc: 'Heiner Kallweit' <hkallweit1@gmail.com>, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michael@fossekall.de, daniel@makrotopia.org,
	netdev@vger.kernel.org, jan@3e8.eu
Subject: Re: AW: [PATCH v2] net: phy: realtek: convert RTL8226-CG to c45 only
Message-ID: <aIt3Mf-_NC8HehHt@shell.armlinux.org.uk>
References: <20250731054445.580474-1-markus.stockhausen@gmx.de>
 <d0e1c087-f701-402e-b842-3444fbce7f27@gmail.com>
 <059901dc0209$a817de50$f8479af0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059901dc0209$a817de50$f8479af0$@gmx.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 31, 2025 at 12:55:40PM +0200, markus.stockhausen@gmx.de wrote:
> As soon as this bit is set to one mode the bus will block most
> accesses with the other mode. E.g. In c22 mode registers 13/14
> are a dead end. So the only option for the bus is to limit access
> like this.

Why would a bus implementation block access to clause 22 registers
13/14 when operating in clause 22 mode? Or is the above badly phrased?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

