Return-Path: <netdev+bounces-181724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35C9A864BF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B81177FB0
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A5232367;
	Fri, 11 Apr 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sKQWu3YD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457DC231C9C
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392598; cv=none; b=Sbh9Hjy7bWFp0aEmGdVlsgkRPfAaLoPpAQGhV2/YoB9QurwLHdcuyoGbSEeBWFc7TRMXCiZ7mAe0LlzuK43ocL7uT8bMcW2LbPY/WYIQRokL8SbpDHF8Shvdg/8/9DpWlyrjbQWftffioEcOREW4x0N0ZdTyinqGlbFyVH26O+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392598; c=relaxed/simple;
	bh=wukxpWXxfQgRAmuEQ26w8VVefMr/cw7IZTgU3rpzGKE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QjL7NZbT0wtJd0AT/D2j0T/lCplGJfJmzOaPB5gUQZeCjVSSpg1MV7nsuUsunOBzu5fa2tqvMzHigGiQmLUP83Rd/RDnzd3zktZqkpnXQm8FLOmG9HYwKbJwVTsYp6VAwltii++ejCPMDpNSLHUttG1PBDZfEV1dPguzt4+0qZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sKQWu3YD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2ZvKUvd6az/nWtVro7yi4KrKw+tjTF6b5A48Jnp2ySE=; b=sKQWu3YDJ2SCMdnp6zksojOAbH
	AoYX85kLR3aCfVv85JlK04PfbRsFTP7UEenXmaaqt+LLeKttmAT2ZO7ruKRZ/qiQ5IELJYjmSONGY
	AUN9BBgW812NB8yIwGbIiRNEdrQ2nYG1AjCebYKMQT+s0nwJa8Ubs5IqsXN+phwesB1p0TMCYrYyK
	tn5wBGwwHc0fTK7Atj3tByH3LlnJC3e2XNpZvPyieIbDh1LFjMsu7NPKcq9pXvbjOcQYwZRDIWwgS
	CRn2bexwx5gbIQtoWXasaHG3X60YDFQpQqvA32vQ5ae6TAEyU/GiGGQxX7sfpyU5yolHgt/jecmog
	UcX9ji3g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41392)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3ICP-0003hO-1e;
	Fri, 11 Apr 2025 18:29:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3ICO-0004m2-0T;
	Fri, 11 Apr 2025 18:29:52 +0100
Date: Fri, 11 Apr 2025 18:29:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [BUG] unbinding mv88e6xxx device spews
Message-ID: <Z_lRkMlTJ1KQ0kVX@shell.armlinux.org.uk>
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

Unbinding a mv88e6xxx device spews thusly:

[ 1499.372164] 8<--- cut here ---
[ 1499.375412] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[ 1499.384463] [00000000] *pgd=00000000
[ 1499.388126] Internal error: Oops: 5 [#1] SMP ARM
[ 1499.392774] Modules linked in: caam_jr ofpart caamhash_desc reset_gpio caamalg_desc tag_dsa crypto_engine cmdlinepart authenc libdes i2c_mux_pca954x mv88e6xxx at24 lm75 spi_nor mtd dsa_core eeprom_93xx46 caam vf610_adc error industrialio_triggered_buffer fsl_edma kfifo_buf virt_dma spi_gpio spi_bitbang sfp iio_hwmon sff mdio_mux_gpio industrialio mdio_i2c mdio_mux rpcsec_gss_krb5 auth_rpcgss
[ 1499.427797] CPU: 0 UID: 0 PID: 561 Comm: bash Tainted: G        W          6.14.0+ #965
[ 1499.435834] Tainted: [W]=WARN
[ 1499.438813] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
[ 1499.445270] PC is at devlink_region_destroy+0x8/0x28
[ 1499.450309] LR is at mv88e6xxx_teardown_devlink_regions_global+0x20/0x2c [mv88e6xxx]
[ 1499.458500] pc : [<c09cc4b8>]    lr : [<bf13ba88>]    psr: 800d0013
[ 1499.464780] sp : e09b5e40  ip : c2f5bf00  fp : 00000000
[ 1499.470020] r10: 00000000  r9 : c0a79388  r8 : c2c085d4
[ 1499.475260] r7 : 00000000  r6 : c2dc0748  r5 : c1caaaf8  r4 : 00000000
[ 1499.481802] r3 : c2f5bf00  r2 : 00000000  r1 : 00000000  r0 : 00000000
[ 1499.488346] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[ 1499.495506] Control: 10c5387d  Table: 842d404a  DAC: 00000051
[ 1499.501263] Register r0 information: NULL pointer
[ 1499.506000] Register r1 information: NULL pointer
[ 1499.510728] Register r2 information: NULL pointer
[ 1499.515456] Register r3 information: slab task_struct start c2f5bf00 pointer offset 0 size 2304
[ 1499.524220] Register r4 information: NULL pointer
[ 1499.528947] Register r5 information: non-slab/vmalloc memory
[ 1499.534630] Register r6 information: slab kmalloc-64 start c2dc0740 pointer offset 8 size 64
[ 1499.543124] Register r7 information: NULL pointer
[ 1499.547853] Register r8 information: slab kmalloc-4k start c2c08000 pointer offset 1492 size 4096
[ 1499.556780] Register r9 information: non-slab/vmalloc memory
[ 1499.562463] Register r10 information: NULL pointer
[ 1499.567278] Register r11 information: NULL pointer
[ 1499.572093] Register r12 information: slab task_struct start c2f5bf00 pointer offset 0 size 2304
[ 1499.580935] Process bash (pid: 561, stack limit = 0xe09b4000)
[ 1499.586705] Stack: (0xe09b5e40 to 0xe09b6000)
[ 1499.591092] 5e40: c1caaaf4 c1caaaf8 c2dc0748 bf13ba88 c2bdfa00 c1ca8040 c2dc0748 bf134844
[ 1499.599297] 5e60: c2bdfa00 c2f13800 c2dc0748 bf0b8620 c2dc0740 c2bdfa00 bf148000 c284e444
[ 1499.607504] 5e80: c2c085d4 bf0b9350 c1ca8040 c2c08590 bf148000 c284e444 c2c085d4 c0a79388
[ 1499.615712] 5ea0: 00000000 bf136b30 c284e400 c2c08590 bf148000 c066f838 c284e400 c05e15f8
[ 1499.623919] 5ec0: c0ac99bc c284e400 00000010 bf148000 c2a9e010 c05df3bc 00000010 c2959dc0
[ 1499.632127] 5ee0: c2a9e000 e09b5f40 c2a9e010 c02f9388 00000000 00000000 c2b68460 e09b5f88
[ 1499.640334] 5f00: c02f927c 00000010 00000000 00000000 00000000 c02608a4 c2caa1b0 00000000
[ 1499.648541] 5f20: b6999000 e09b5fb0 00010000 00000010 00ce6b00 00000000 00000001 00000000
[ 1499.656748] 5f40: c2b68460 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[ 1499.664948] 5f60: 00000000 00000000 c2b68460 c2b68460 00000000 00000000 c0008584 c2f5bf00
[ 1499.673155] 5f80: 00000004 c0260adc 00000000 00000000 00000000 00000074 00ce6b00 b6ca5db0
[ 1499.681354] 5fa0: 00000004 c0008320 00000074 00ce6b00 00000001 00ce6b00 00000010 00000000
[ 1499.689561] 5fc0: 00000074 00ce6b00 b6ca5db0 00000004 00000010 00000010 00000000 00000000
[ 1499.697769] 5fe0: 00000004 bef1b880 b6c3d5b3 b6bc6746 60070030 00000001 00000000 00000000
[ 1499.705956] Call trace:
[ 1499.705981] [<c09cc4b8>] (devlink_region_destroy) from [<bf13ba88>] (mv88e6xxx_teardown_devlink_regions_global+0x20/0x2c [mv88e6xxx])
[ 1499.720797] [<bf13ba88>] (mv88e6xxx_teardown_devlink_regions_global [mv88e6xxx]) from [<bf134844>] (mv88e6xxx_teardown+0x30/0x3c [mv88e6xxx])
[ 1499.733871] [<bf134844>] (mv88e6xxx_teardown [mv88e6xxx]) from [<bf0b8620>] (dsa_tree_teardown_switches+0x94/0xc4 [dsa_core])
[ 1499.745857] [<bf0b8620>] (dsa_tree_teardown_switches [dsa_core]) from [<bf0b9350>] (dsa_unregister_switch+0xdc/0x184 [dsa_core])
[ 1499.757799] [<bf0b9350>] (dsa_unregister_switch [dsa_core]) from [<bf136b30>] (mv88e6xxx_remove+0x34/0xbc [mv88e6xxx])
[ 1499.768948] [<bf136b30>] (mv88e6xxx_remove [mv88e6xxx]) from [<c066f838>] (mdio_remove+0x1c/0x30)
[ 1499.778077] [<c066f838>] (mdio_remove) from [<c05e15f8>] (device_release_driver_internal+0x180/0x1f4)
[ 1499.787394] [<c05e15f8>] (device_release_driver_internal) from [<c05df3bc>] (unbind_store+0x54/0x90)
[ 1499.796588] [<c05df3bc>] (unbind_store) from [<c02f9388>] (kernfs_fop_write_iter+0x10c/0x1cc)
[ 1499.805181] [<c02f9388>] (kernfs_fop_write_iter) from [<c02608a4>] (vfs_write+0x2a4/0x3dc)
[ 1499.813500] [<c02608a4>] (vfs_write) from [<c0260adc>] (ksys_write+0x50/0xac)[ 1499.820681] [<c0260adc>] (ksys_write) from [<c0008320>] (ret_fast_syscall+0x0/0x54)
[ 1499.828383] Exception stack(0xe09b5fa8 to 0xe09b5ff0)
[ 1499.833460] 5fa0:                   00000074 00ce6b00 00000001 00ce6b00 00000010 00000000
[ 1499.841660] 5fc0: 00000074 00ce6b00 b6ca5db0 00000004 00000010 00000010 00000
[ 1499.849863] 5fe0: 00000004 bef1b880 b6c3d5b3 b6bc6746
[ 1499.854947] Code: e8bd41f0 eae1baa6 e92d4070 e1a04000 (e5905000)
[ 1499.861264] ---[ end trace 0000000000000000 ]---
[ 1499.896270] fec 400d0000.ethernet eth0: Graceful transmit stop did not complete!
[ 1499.903874] fec 400d0000.ethernet eth0: Link is Down

and the nice thing is, because it's using rootfs over eth0 (which is not
the NIC used for DSA) that's the end of the platform without hard
rebooting.

Again, won't be able to do anything with this after Sunday for a few
months, and I'm otherwise completely focused on PTP stuff right now.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

