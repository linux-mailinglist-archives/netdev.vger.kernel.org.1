Return-Path: <netdev+bounces-181723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E20A864AF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E784C1B8690F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A821F221FBB;
	Fri, 11 Apr 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RY3/GhXL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B22367D0
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392296; cv=none; b=VcBUoU8OfOfNhoLrW2bC+DVdZlrXTggjDIDLdi2eS3D7T8PFGGr3k6/SyBU0SAmlKmPKlz5XUAxhypul1/5N4MXle3MJQtNDy31/rCBCPWbG6oeXzKBI7p5VvVNmltW1f/wXyHEb8cBCkCHm0sW9kLDBHj+YeBxVo6v+nec7cEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392296; c=relaxed/simple;
	bh=Na5waWiBk+f3b24qxXaWHHQJmAHBEy/QHM9IwrVQWdE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z/LIRJhBeIcFy/PsYlcKkwZOJdAoX3w8T26A3Cnp7E7WvPfGOulqB5Qdl1lT4qRJhLRC4l9tU2yz185z63QPq55R8S5NOF4PHenspvIwViHS8Am5VgLI6CcKzkBMmMqjPGFcwieu06p7zne3ylpWGX4Nw22mtzhhv0KF7envMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RY3/GhXL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Xenzcg0MbDbXWrtPxqAuXT1W/PLMqLvkYi0Uj1jj4Ic=; b=RY3/GhXLMrflmtdKqKnwuK8QvU
	CkX/u5MwnKeyEsZAB3B5sUql+EOi/iBCdrlAgu7FTY8Pky+ShAfOY4u3Er5EUmnMuxtjREYA+HIz/
	3127yomeWO8iUt5/cRPJ3zWThFDvltCii245SaoXf26Z0bDvsNsuwJEwOTVtr/Qn0zuYefc5POHnX
	pwIIFratdrkE3KvbDm9T4GogGZamjulYvfAkh+Gzg/jpncDueqIyvQslasu1emFoJcZF2BXOfUc1h
	i1/gJhfckBcB7f9zFVUWXus6NXWvA0Dfbigulp8PHq3ayfWtPE2E3SPpDOD9XXDMiIurHMA4WwogY
	O7ZfIkgA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55188)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3I7R-0003gy-1D
	for netdev@vger.kernel.org;
	Fri, 11 Apr 2025 18:24:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3I7Q-0004lq-1G
	for netdev@vger.kernel.org;
	Fri, 11 Apr 2025 18:24:44 +0100
Date: Fri, 11 Apr 2025 18:24:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: netdev@vger.kernel.org
Subject: [BUG] 6.14: WARNING: CPU: 0 PID: 478 at net/bridge/br_vlan.c:433
 nbp_vlan_flush+0xc0/0xc4
Message-ID: <Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

When executing:

# ifdown br0

on the ZII dev rev B platform with br0 being a bridge between mv88e6xxx
DSA ports, the following was spewed:

[  628.418720] br0: port 9(optical2) failed to delete vlan 1: -ENOENT
[  628.425297] ------------[ cut here ]------------
[  628.430124] WARNING: CPU: 0 PID: 478 at net/bridge/br_vlan.c:433 nbp_vlan_flush+0xc0/0xc4
[  628.438446] Modules linked in: caam_jr ofpart caamhash_desc reset_gpio caamalg_desc tag_dsa crypto_engine cmdlinepart authenc libdes i2c_mux_pca954x mv88e6xxx at24 lm75 spi_nor mtd dsa_core eeprom_93xx46 caam vf610_adc error industrialio_triggered_buffer fsl_edma kfifo_buf virt_dma spi_gpio spi_bitbang sfp iio_hwmon sff mdio_mux_gpio industrialio mdio_i2c mdio_mux rpcsec_gss_krb5 auth_rpcgss
[  628.473585] CPU: 0 UID: 0 PID: 478 Comm: brctl Not tainted 6.14.0+ #965
[  628.473621] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
[  628.473634] Call trace: 
[  628.473655] [<c0009c44>] (unwind_backtrace) from [<c0022b78>] (show_stack+0x10/0x14)
[  628.473740] [<c0022b78>] (show_stack) from [<c0019b5c>] (dump_stack_lvl+0x50/0x64)
[  628.473814] [<c0019b5c>] (dump_stack_lvl) from [<c0043cd4>] (__warn+0x80/0x128)
[  628.473879] [<c0043cd4>] (__warn) from [<c0043ee4>] (warn_slowpath_fmt+0x168/0x16c)
[  628.473927] [<c0043ee4>] (warn_slowpath_fmt) from [<c09b8a8c>] (nbp_vlan_flush+0xc0/0xc4)
[  628.473982] [<c09b8a8c>] (nbp_vlan_flush) from [<c099d21c>] (del_nbp+0xc4/0x2c0)
[  628.474050] [<c099d21c>] (del_nbp) from [<c099de30>] (br_del_if+0x30/0x94)
[  628.474100] [<c099de30>] (br_del_if) from [<c099f438>] (br_ioctl_stub+0xe4/0x38c)
[  628.474155] [<c099f438>] (br_ioctl_stub) from [<c07d3084>] (br_ioctl_call+0x5c/0x94)
[  628.474224] [<c07d3084>] (br_ioctl_call) from [<c0835284>] (dev_ifsioc+0x360/0x61c)
[  628.474303] [<c0835284>] (dev_ifsioc) from [<c0835868>] (dev_ioctl+0x328/0x634)
[  628.474357] [<c0835868>] (dev_ioctl) from [<c07d3564>] (sock_ioctl+0x4a8/0x4ec)
[  628.474410] [<c07d3564>] (sock_ioctl) from [<c0276a80>] (sys_ioctl+0x49c/0xc28)
[  628.474483] [<c0276a80>] (sys_ioctl) from [<c0008320>] (ret_fast_syscall+0x0/0x54)
[  628.474530] Exception stack(0xe0961fa8 to 0xe0961ff0)
[  628.474557] 1fa0:                   007350f0 b6cb0968 00000003 000089a3 becd8c2c 000000d0
[  628.474582] 1fc0: 007350f0 b6cb0968 00000007 00000036 becd8ed4 00000000 00735000 00000000
[  628.474601] 1fe0: b6c22f01 becd8c14 00723085 b6c22f08
[  628.621830] ---[ end trace 0000000000000000 ]---

Unfortunately, because I'm concentrating on PTP stuff right now, I don't
have time to investigate this beyond reporting this, and it's highly
probable that after Sunday, it's going to be a few months before I can
do any further testing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

