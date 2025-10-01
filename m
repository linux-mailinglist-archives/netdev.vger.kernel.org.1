Return-Path: <netdev+bounces-227454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963BBAFBC2
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 10:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7B3C4E2426
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F028489B;
	Wed,  1 Oct 2025 08:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E696119DF5F
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308722; cv=none; b=OJVTXQ1Q1eLp3cbX+OweCFE/VmdPvg/twRj9iwJdapXpW9c/dKMtgaQVO+ZJ35Ref1s2z4Jc2yuii0cLlNn1+5PP+WEmtVFCzIolamccY4f3/jDiECWwokak+EJ86kWExA/J+JCilqARUhI2Da71gIisq08PxVbEM2s03yzhIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308722; c=relaxed/simple;
	bh=YXxqZhHvVCrfQKAVL9HvF3Qy579n1KlGnF1ayZ64yuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEAoVeymhWux1/y/JN+CcIZbEIHgdqgNjqfhhuWNwrM4U2DAl9N92A4JwPRHv+JEx82JxWIpCEKpEhcNfgNBBp112sY6YHrmkvDzAprX760BVHre7RJ/K9gDU55hsKXJL7MEOXFm6YmnV+IfCGRCaJieRido5bzCgTRZUp6GE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v3sYv-0002sc-Ox; Wed, 01 Oct 2025 10:51:49 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3sYu-001Nty-0q;
	Wed, 01 Oct 2025 10:51:48 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3sYu-006Sbg-0S;
	Wed, 01 Oct 2025 10:51:48 +0200
Date: Wed, 1 Oct 2025 10:51:48 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout
 error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
Message-ID: <aNzrpEaYwoNwcbrd@pengutronix.de>
References: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Sep 30, 2025 at 02:19:02PM +0530, Bhanu Seshu Kumar Valluri wrote:
> Syzbot reported read of uninitialized variable BUG with following call stack.
> 
> lan78xx 8-1:1.0 (unnamed net_device) (uninitialized): EEPROM read operation timeout
> =====================================================
> BUG: KMSAN: uninit-value in lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
> BUG: KMSAN: uninit-value in lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
> BUG: KMSAN: uninit-value in lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
>  lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
>  lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
>  lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
>  lan78xx_bind+0x711/0x1690 drivers/net/usb/lan78xx.c:3766
>  lan78xx_probe+0x225c/0x3310 drivers/net/usb/lan78xx.c:4707
> 
> Local variable sig.i.i created at:
>  lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1092 [inline]
>  lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
>  lan78xx_reset+0x77e/0x2cd0 drivers/net/usb/lan78xx.c:3241
>  lan78xx_bind+0x711/0x1690 drivers/net/usb/lan78xx.c:3766
> 
> The function lan78xx_read_raw_eeprom failed to properly propagate EEPROM
> read timeout errors (-ETIMEDOUT). In the fallthrough path, it first
> attempted to restore the pin configuration for LED outputs and then
> returned only the status of that restore operation, discarding the
> original timeout error.
> 
> As a result, callers could mistakenly treat the data buffer as valid
> even though the EEPROM read had actually timed out with no data or partial
> data.
> 
> To fix this, handle errors in restoring the LED pin configuration separately.
> If the restore succeeds, return any prior EEPROM timeout error correctly
> to the caller.
> 
> Reported-by: syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=62ec8226f01cb4ca19d9
> Fixes: 8b1b2ca83b20 ("net: usb: lan78xx: Improve error handling in EEPROM and OTP operations")
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

