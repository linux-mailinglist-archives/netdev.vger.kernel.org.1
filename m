Return-Path: <netdev+bounces-149452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5369E5AA5
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D5F288E48
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5285921D5BD;
	Thu,  5 Dec 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOkXS2Py"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B721D589;
	Thu,  5 Dec 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414638; cv=none; b=lV85faes27mdriXZWqgyG+uESERIC3NJyyL5WQD1O6zMqYsB70VrQWKOsMaZp+W5zkgEUz5sm6cVn2IbUtBfYhthaEVa47AUR2+SUFbfkGtx04X5Ne5aSN49Pm7N1HVJAi2FYOpkp2V+G70quaiqPZw2pbijkx/HZdbbaOUz3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414638; c=relaxed/simple;
	bh=fdRoo8mK8zv4B6iF3Pzi2UBC4gLb+tTJv2sowA1+qhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV51045KklZHmcELH5b8xoj0WLsPzWNsFA6LOXAZbdgfA3idFqW0LF0a+TSLX97KjGmwr5NL/+pzptEZy7EbIOYvPDZAU0tab1ZydCgksNee6YrwMEqV6MIGK+sbZ3l0odUW4PKqCnh/YcICchAaz4H2OV/OEtaRfBYLYNq+4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOkXS2Py; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d071ac3f35so184264a12.3;
        Thu, 05 Dec 2024 08:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733414633; x=1734019433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2Xy8fR4klMdtV76o+AOWxUczteB2M7hrx0J1kUwdMc=;
        b=WOkXS2Py0tG/NM4VEsRM0cRytkzjCxGH4Jqed7ZhFiSz79GbhKWOsZ3RtGRgnZC4ru
         8aqsKbloAC0RP7GzFEi4K38fYl9YbSrG9jFSpDIphnjkaQ9LRyzsrPDHXKQloMw+uCTd
         KYsnLaVPoAl6T/WZ01kaZGCLnkGkSjlR9gY275PqD2aIC58b7/YhiByBg+he8mN2rjIj
         WyoZ54vKvx6yrn7YqFCr8WWZ/3U1vp7Gf3pV/9H/TB8YQatzsRya4rlA7E1L9dbC5EZW
         Ct2ryyNIf+xpNkaAbGujpfSOHuDACaVDHzlTFSWm3jHGfj5YGGfPyGH22Nvx7/k/D8I2
         4z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733414633; x=1734019433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2Xy8fR4klMdtV76o+AOWxUczteB2M7hrx0J1kUwdMc=;
        b=w07cIxUaojlyYr2io8n4rbRDabEclxSp8jtKmWU2pgFi9zt+ddVaeuHzy9bzP+bt64
         BJBYqHhjDXyXLmBjAQVKvx5TqEC4DuPuTbSgLCRLpBtR0v8sY7jSEHM7fVOSNqXCOTye
         8xkblP8DWiICtENGgeSE45Z+huHGzuGpfAm/5dFbVdtV4qMn/Luyv5YbHuH2RFKySAwI
         4TmpBtRnCbWBfn4cYzwnobcG+BuUn4HGM6sIl3KbRYVqqQKK1XEM09EKSQXcv88WopiW
         FHcNCyNEn2S/6h2zue/0NL1ZTONKckQcDht/HKFUEh62OPfg+WcuauwZlUi+55SEAYW0
         MthA==
X-Forwarded-Encrypted: i=1; AJvYcCVDhy2JaXgAkmjcWSao7svk0A12rZbZn/wtD7iCIiC2+HEzwOdYa3YQ1DFBB91ewow4xT5DRT73L+j+nHoz@vger.kernel.org, AJvYcCVPp5MthCRb8qZEwsPM7ljyuxkoWitmKUxQTrvE6ikpH7Ra3BY3wwmZ4gVXAwzfMBh+vX+5LKE8QwaR@vger.kernel.org, AJvYcCWUAMklKu0H2YzGWg99cscIt3LYhMFC4KTNvRFXw11Y7uFDtw/ddG1ukqy2pCGuEo6t2n1H2MvT@vger.kernel.org
X-Gm-Message-State: AOJu0YxLugoaUyGyoejyaCuxOnVAczhEI8F6jf7GdiEpxztOMM3589HG
	IpIROSya5XTss+XM5AI1g+mDGG1/LpYD4cQ9vugjP5cyyOz3vr2v
X-Gm-Gg: ASbGncv1jl0NC+p4+2BJV8ls7sLYQCVnhdNSQl8UxLI2A/1ppbhhgs9bYXzLHy8C6MS
	yx2JwtSNbnu4tpz0+UEcZKcEnkNnGr/009NnkkNxEk7zBqZKHRrww/iwVnYaENRWuU6fa1JPGCA
	d+oU2CUtDjnukRjpvCw1aT2uoYlC8ClH6DtmE9LbvypTR+345vBoNk/vmM+HmB617Kk1xpbXR8L
	iFtKhFWak1qrRzmlsqH6w7ZlszvQed97vpVzac=
X-Google-Smtp-Source: AGHT+IGJbttEx625sbvfZB6qmADeEHHoDaiWaHna5evY6Uo+8Z7yDeoc1B7PgSItB+aXhyAsOqRfgw==
X-Received: by 2002:a05:6402:3595:b0:5ce:f524:c15d with SMTP id 4fb4d7f45d1cf-5d10cbabbdbmr4365917a12.11.1733414632304;
        Thu, 05 Dec 2024 08:03:52 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a25e20sm944126a12.16.2024.12.05.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:03:47 -0800 (PST)
Date: Thu, 5 Dec 2024 18:03:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v9 1/4] net: dsa: add devm_dsa_register_switch()
Message-ID: <20241205160344.hnshthreouyjecxq@skbuf>
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205145142.29278-2-ansuelsmth@gmail.com>

On Thu, Dec 05, 2024 at 03:51:31PM +0100, Christian Marangi wrote:
> Some DSA driver can be simplified if devres takes care of unregistering
> the DSA switch. This permits to effectively drop the remove OP from
> driver that just execute the dsa_unregister_switch() and nothing else.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

The premise is false. *No* DSA drivers can safely be simplified if
devres is let to take care of calling dsa_unregister_switch().

See, no remove() method of a DSA driver calls dsa_unregister_switch()
directly, but instead they all test dev_get_drvdata() against NULL first.
See this patch set for a full explanation:
https://lore.kernel.org/netdev/20210917133436.553995-1-vladimir.oltean@nxp.com/
but the short explanation is that the parent bus can implement its own
.shutdown() as .remove(), which for the DSA switch device means that
during shutdown/reboot, both .shutdown() *and* .remove() will be called.
The DSA framework is only prepared for either dsa_unregister_switch()
*or* dsa_switch_shutdown() to be called. It doesn't work if *both* are
called, so we have this mechanism where .shutdown() will set the device
drvdata to NULL, so that .remove() will become a no-op. But that mechanism
will become void if we start to drop the driver's remove() and rely on
devres to call dsa_unregister_switch().

Demo for sja1105 driver with the spi-fsl-dspi.c controller driver as parent.

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index f8454f3b6f9c..b9c92a5e5f5f 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3404,17 +3404,7 @@ static int sja1105_probe(struct spi_device *spi)
 			return -ENOMEM;
 	}
 
-	return dsa_register_switch(priv->ds);
-}
-
-static void sja1105_remove(struct spi_device *spi)
-{
-	struct sja1105_private *priv = spi_get_drvdata(spi);
-
-	if (!priv)
-		return;
-
-	dsa_unregister_switch(priv->ds);
+	return devm_dsa_register_switch(dev, priv->ds);
 }
 
 static void sja1105_shutdown(struct spi_device *spi)
@@ -3466,7 +3456,6 @@ static struct spi_driver sja1105_driver = {
 	},
 	.id_table = sja1105_spi_ids,
 	.probe  = sja1105_probe,
-	.remove = sja1105_remove,
 	.shutdown = sja1105_shutdown,
 };
 

root@debian:~# reboot
[   52.421866] watchdog: watchdog0: watchdog did not stop!
[   52.515700] systemd-shutdown[1]: Using hardware watchdog 'sp805-wdt', version 0, device /dev/watchdog0
[   52.525256] systemd-shutdown[1]: Watchdog running with a timeout of 5min 44s.
[   52.977392] systemd-shutdown[1]: Syncing filesystems and block devices.
[   53.041107] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
[   53.070259] systemd-journald[277]: Received SIGTERM from PID 1 (systemd-shutdow).
[   53.123590] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
[   53.156518] systemd-shutdown[1]: Unmounting file systems.
[   53.170735] (sd-remount)[632]: Remounting '/' read-only with options ''.
[   53.229253] EXT4-fs (mmcblk0p2): re-mounted e092e674-ed6c-4216-b216-58d8390ae85d ro. Quota mode: none.
[   53.313634] systemd-shutdown[1]: All filesystems unmounted.
[   53.319334] systemd-shutdown[1]: Deactivating swaps.
[   53.324625] systemd-shutdown[1]: All swaps deactivated.
[   53.329943] systemd-shutdown[1]: Detaching loop devices.
[   53.342596] systemd-shutdown[1]: All loop devices detached.
[   53.348263] systemd-shutdown[1]: Stopping MD devices.
[   53.354180] systemd-shutdown[1]: All MD devices stopped.
[   53.359633] systemd-shutdown[1]: Detaching DM devices.
[   53.365699] systemd-shutdown[1]: All DM devices detached.
[   53.371178] systemd-shutdown[1]: All filesystems, swaps, loop devices, MD devices and DM devices detached.
[   53.381033] watchdog: watchdog0: watchdog did not stop!
[   53.424144] systemd-shutdown[1]: Syncing filesystems and block devices.
[   53.431313] systemd-shutdown[1]: Rebooting.
[   53.458710] sja1105 spi2.0 sw0p0: Link is Down
[   53.477004] mscc_felix 0000:00:00.5 swp0: Link is Down
[   53.486054] fsl_enetc 0000:00:00.2 eno2: Link is Down
[   53.518865] Unable to handle kernel NULL pointer dereference at virtual address 000000000000002c
[   53.527921] Mem abort info:
[   53.530776]   ESR = 0x0000000096000004
[   53.534612]   EC = 0x25: DABT (current EL), IL = 32 bits
[   53.539988]   SET = 0, FnV = 0
[   53.543124]   EA = 0, S1PTW = 0
[   53.546315]   FSC = 0x04: level 0 translation fault
[   53.551282] Data abort info:
[   53.554211]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   53.559792]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   53.564904]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   53.570476] user pgtable: 4k pages, 48-bit VAs, pgdp=0000002083f73000
[   53.577029] [000000000000002c] pgd=0000000000000000, p4d=0000000000000000
[   53.584079] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   53.590374] Modules linked in:
[   53.593442] CPU: 0 UID: 0 PID: 1 Comm: systemd-shutdow Tainted: G                 N 6.12.0-10714-gc118f6e3b41e-dirty #2585
[   53.604532] Tainted: [N]=TEST
[   53.613010] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   53.619999] pc : dsa_tree_conduit_admin_state_change+0x44/0xf8
[   53.625864] lr : dsa_unregister_switch+0x194/0x2a8
[   53.630674] sp : ffff80008002b940
[   53.633997] x29: ffff80008002b960 x28: ffff330a40938000 x27: ffff330a40cff818
[   53.641168] x26: ffffba4f5bb05000 x25: 0000000000000001 x24: ffff330a42e19400
[   53.648338] x23: ffff330a42e13668 x22: ffff330a435a5890 x21: ffff330a42dc7000
[   53.655507] x20: ffff330a42e5e080 x19: ffff330a435a5880 x18: 0000000000000000
[   53.662676] x17: ffffba4f5be23118 x16: ffffba4f5bb0d088 x15: 0000000000000108
[   53.669845] x14: ffffba4f5c02b550 x13: 0000000000000004 x12: ffff330a40938908
[   53.677014] x11: ffffba4f5b2ae418 x10: 0000000000000000 x9 : 0000000000000000
[   53.684183] x8 : 0000000000000000 x7 : ffffba4f5917fbe0 x6 : 0000000000000000
[   53.691352] x5 : 0000000000000020 x4 : ffff80008002b620 x3 : 0000000000000000
[   53.698521] x2 : 0000000000000000 x1 : ffff330a42dc7000 x0 : ffff330a435a5880
[   53.705691] Call trace:
[   53.708142]  dsa_tree_conduit_admin_state_change+0x44/0xf8 (P)
[   53.714001]  dsa_unregister_switch+0x194/0x2a8 (L)
[   53.718811]  dsa_unregister_switch+0x194/0x2a8
[   53.723272]  devm_dsa_unregister_switch+0x1c/0x30
[   53.727994]  devm_action_release+0x20/0x38
[   53.732107]  devres_release_all+0xc4/0x130
[   53.736217]  device_release_driver_internal+0x1d0/0x280
[   53.741464]  device_release_driver+0x24/0x38
[   53.745751]  bus_remove_device+0x154/0x170
[   53.749862]  device_del+0x1f8/0x3e8
[   53.753361]  spi_unregister_device+0x90/0xe8
[   53.757646]  __unregister+0x1c/0x38
[   53.761147]  device_for_each_child+0x6c/0xc8
[   53.765432]  spi_unregister_controller+0x50/0x158
[   53.770153]  dspi_remove+0x28/0x98
[   53.773567]  dspi_shutdown+0x1c/0x30
[   53.777154]  platform_shutdown+0x30/0x48
[   53.781089]  device_shutdown+0x174/0x238
[   53.785025]  kernel_restart+0x4c/0x128
[   53.788788]  __arm64_sys_reboot+0x200/0x2e8
[   53.792987]  invoke_syscall+0x4c/0x110
[   53.796752]  el0_svc_common+0xb8/0xf0
[   53.800429]  do_el0_svc+0x28/0x40
[   53.803757]  el0_svc+0x4c/0xc0
[   53.806823]  el0t_64_sync_handler+0x84/0x108
[   53.811109]  el0t_64_sync+0x198/0x1a0
[   53.814786] Code: 0a490949 37000489 37b00468 f9421828 (b9402d09)
[   53.820901] ---[ end trace 0000000000000000 ]---
[   53.825600] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   53.833306] Kernel Offset: 0x3a4ed7800000 from 0xffff800080000000
[   53.839420] PHYS_OFFSET: 0xfff0cd1640000000
[   53.843615] CPU features: 0x080,0002012c,00800000,8200421b
[   53.849120] Memory Limit: none
[   53.852184] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

This will need a lot more thought before it makes its appearance as a
tool in the DSA toolbox. Otherwise it is just an avoidable source of
problems.

