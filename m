Return-Path: <netdev+bounces-55342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ABA80A74F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F92BB20A11
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F8A30338;
	Fri,  8 Dec 2023 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ho2aF/Al"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C3C10F9
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 07:26:51 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7258F20002;
	Fri,  8 Dec 2023 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702049208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkUR566s/hMJ34B/RAcdlIK32F95BKSNkwmJJuVcOzE=;
	b=ho2aF/Aldtwb1rtDTUQFstvL6KNTOAPuP7gwrby+ZM7ORG3fqfzC44SfxGOJiX7lYFB7ql
	2JdmNqyQasZoT3kYbgEqW9A1I7O6tuDdCPfPUnU3ebm9RTOwKB4o11WZKRIitcPn7kCndt
	UFb3ALMWuLcno+gCtkt0+90gdib0tBQik/2tDPx3nqT25oSip7LvVrcccFz/Fiy9jomdou
	zCfOLThTlXRMUH6teC0t3bKV1LinP86ikGjypliTA+NgYLEXKxnyTt0Wq43KHAjLf6WqoX
	XIEVgHyQt3dib2LH5TihCSmg+Go/ug7Qgnn/TO4LrXFQKn0QgOScOjSrM3wEOw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Sven Auhagen <sven.auhagen@voleatech.de>, thomas.petazzoni@bootlin.com
Cc: netdev <netdev@vger.kernel.org>
Subject: Re: mvneta crash in page pool code
In-Reply-To: <ea0efd7d-8325-4e38-88f8-5ad63f1b17bc@lunn.ch>
References: <ea0efd7d-8325-4e38-88f8-5ad63f1b17bc@lunn.ch>
Date: Fri, 08 Dec 2023 16:26:48 +0100
Message-ID: <871qbwemvb.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Hi Andrew,

> Hi Folks
>
> I just booted net-next/main on a Marvell RDK with an mvneta. It throws
> an Opps and dies.
>
> My setup might be a little bit unusual, i have NFS root over one of
> the instances of mvneta, and a Marvell switch on the other
> instance. So i included a bit more context.
>
> I don't have time to debug this at the moment. Maybe later i can do a
> bisect.

is it solved by
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=ca8add922f9c ?

The errors messages look similar.

Gregory

>
> 	Andrew
>
> [    3.824226] Sending DHCP requests .
> [    5.765176] mvneta f1070000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
> [    6.484392] ., OK
> [    6.526471] IP-Config: Got DHCP answer from 10.0.1.1, my address is 10.0.1.11
> [    6.533686] IP-Config: Complete:
> [    6.537006]      device=eth0, hwaddr=00:50:43:39:2e:52, ipaddr=10.0.1.11, mask=255.255.255.0, gw=10.0.1.1
> [    6.546697]      host=10.0.1.11, domain=home.lunn.ch, nis-domain=(none)
> [    6.553363]      bootserver=0.0.0.0, rootserver=10.0.1.1, rootpath=
> [    6.553375]      nameserver0=192.168.0.1
> [    6.582776] mvneta f1074000.ethernet eth1: Link is Down
> [    6.592817] 8<--- cut here ---
> [    6.596057] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when write
> [    6.605231] [00000000] *pgd=00000000
> [    6.608858] Internal error: Oops: 805 [#1] SMP ARM
> [    6.613691] Modules linked in:
> [    6.616777] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc2-00619-g7e0222686316 #47
> [    6.624839] Hardware name: Marvell Armada 370/XP (Device Tree)
> [    6.630711] PC is at page_pool_unlist+0x40/0x64
> [    6.635297] LR is at xas_store+0x328/0x61c
> [    6.639438] pc : [<c0887cb8>]    lr : [<c0af6fd8>]    psr: 60000153
> [    6.645746] sp : e0821cf0  ip : 00000009  fp : c10fab10
> [    6.651006] r10: 00000020  r9 : 00000020  r8 : c0c74584
> [    6.656264] r7 : 00000000  r6 : c3a57348  r5 : 00000000  r4 : c3a57000
> [    6.662834] r3 : 00000000  r2 : 00000000  r1 : ffffc005  r0 : c1091bb4
> [    6.669404] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> [    6.676677] Control: 10c5387d  Table: 00004019  DAC: 00000051
> [    6.682460] Register r0 information: non-slab/vmalloc memory
> [    6.688167] Register r1 information: non-paged memory
> [    6.693261] Register r2 information: NULL pointer
> [    6.698001] Register r3 information: NULL pointer
> [    6.702741] Register r4 information: slab kmalloc-1k start c3a57000 pointer offset 0 size 1024
> [    6.711430] Register r5 information: NULL pointer
> [    6.716171] Register r6 information: slab kmalloc-1k start c3a57000 pointer offset 840 size 1024
> [    6.725030] Register r7 information: NULL pointer
> [    6.729771] Register r8 information: non-slab/vmalloc memory
> [    6.735472] Register r9 information: non-paged memory
> [    6.740562] Register r10 information: non-paged memory
> [    6.745738] Register r11 information: non-slab/vmalloc memory
> [    6.751525] Register r12 information: non-paged memory
> [    6.756700] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> [    6.762751] Stack: (0xe0821cf0 to 0xe0822000)
> [    6.767144] 1ce0:                                     c3a57000 c08869c0 c3a57000 00000001
> [    6.775380] 1d00: c0dc5d5c 00000001 c2280580 c108132c c18e0000 c0886aa4 00000001 c2280580
> [    6.783616] 1d20: c108132c c223a840 c223a880 c06c4478 c223a840 00000000 000000c0 00000001
> [    6.791851] 1d40: c2280580 c06c4588 0000002b c0f6c040 000005b8 c2280000 c2280580 00000000
> [    6.800086] 1d60: 000005b8 00000001 c228017c c06c4d88 c1003f18 00000000 c2280000 e0821dc4
> [    6.808321] 1d80: 00000000 00000000 00001103 c0846bbc 01010101 c06c74a4 c2280000 c2280000
> [    6.816556] 1da0: 00000000 3cc0b587 c2280000 00000000 00001102 c084d598 c10fab10 0040003f
> [    6.824791] 1dc0: 00030000 c2280040 c2280040 3cc0b587 c2280000 c18f6000 00000100 00001103
> [    6.833026] 1de0: c473e1c0 c34b73c0 c0df3094 c084d6e0 00000000 c473e180 c18f6000 c473e180
> [    6.841261] 1e00: c18f6000 c0f4fbd8 c2280000 c0f2c39c c18f6060 3cc0b587 00000000 00000000
> [    6.849496] 1e20: c109bae0 0101000a c10fab1c 00000000 c0df307c c0f2df68 c109bae4 c109baec
> [    6.857730] 1e40: c109bae8 c030caa8 00000001 00000002 00000001 00000005 c10f8fc0 ffff8c4e
> [    6.865965] 1e60: 43004400 10624dd3 51eb851f c2419c08 c0c0f614 000001cf 00000000 00000002
> [    6.874198] 1e80: 00000000 00000000 00000000 00000002 0101000a 00000000 00000000 00000002
> [    6.882433] 1ea0: 00000000 00000000 00000000 00000003 00000000 00000000 00000000 00000000
> [    6.890667] 1ec0: 00000000 00000000 00000000 3cc0b587 00000000 c10c6f40 c0f2cee8 c1944000
> [    6.898903] 1ee0: c18e0000 00000000 c0f47858 c0e018f8 c0e5c274 c0102098 c1944049 00000000
> [    6.907138] 1f00: c1944048 c0143400 00000062 c0dad800 000000f4 00000000 00000000 c0f004d0
> [    6.915373] 1f20: 00000007 00000007 c0f01200 c1944055 00000000 3cc0b587 c0f5ec0c 000000f4
> [    6.923607] 1f40: 00000008 3cc0b587 c0f5f2fc 00000008 c1944000 c0f47838 000000f4 c0f012c0
> [    6.931842] 1f60: 00000007 00000007 00000000 c0f004d0 e0821f6c c0f004d0 00000000 c1003ec0
> [    6.940076] 1f80: c0b084d8 00000000 00000000 00000000 00000000 00000000 00000000 c0b084f0
> [    6.948311] 1fa0: 00000000 c0b084d8 00000000 c010014c 00000000 00000000 00000000 00000000
> [    6.956545] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    6.964780] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [    6.973018]  page_pool_unlist from page_pool_release+0x168/0x1bc
> [    6.979089]  page_pool_release from page_pool_destroy+0x90/0x180
> [    6.985151]  page_pool_destroy from mvneta_rxq_drop_pkts+0xf8/0x1c0
> [    6.991486]  mvneta_rxq_drop_pkts from mvneta_cleanup_rxqs+0x48/0x9c
> [    6.997897]  mvneta_cleanup_rxqs from mvneta_stop+0xb8/0xec
> [    7.003523]  mvneta_stop from __dev_close_many+0xa0/0x124
> [    7.008972]  __dev_close_many from __dev_change_flags+0xd8/0x208
> [    7.015031]  __dev_change_flags from dev_change_flags+0x18/0x54
> [    7.021004]  dev_change_flags from ic_close_devs+0x68/0xdc
> [    7.026543]  ic_close_devs from ip_auto_config+0x1080/0x10a8
> [    7.032253]  ip_auto_config from do_one_initcall+0x48/0x1f4
> [    7.037881]  do_one_initcall from kernel_init_freeable+0x1b8/0x21c
> [    7.044128]  kernel_init_freeable from kernel_init+0x18/0x12c
> [    7.049929]  kernel_init from ret_from_fork+0x14/0x28
> [    7.055022] Exception stack(0xe0821fb0 to 0xe0821ff8)
> [    7.060112] 1fa0:                                     00000000 00000000 00000000 00000000
> [    7.068347] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    7.076581] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    7.083245] Code: e59423ec e3010bb4 e34c0109 e3530000 (e5823000) 
> [    7.089456] ---[ end trace 0000000000000000 ]---
> [    7.094169] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    7.101894] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

