Return-Path: <netdev+bounces-223904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDE8B7C6E9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E942A7B01
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41445309DAF;
	Wed, 17 Sep 2025 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y7XNHAG5"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537EA3093CD;
	Wed, 17 Sep 2025 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097571; cv=none; b=rYOY8RIwRuMaJLHVr8u1rrE9IQYr7SRe9PNdxJmXFsuPsJ5I7GdlZdLmrZX4wPAfOAd2QnP8fVAM5TLtuCLvJ7qEb4ta5PLV55AQPkBxPeAMjmU/w2D/85Y8+ZqJKCpPHdd/IY6fx+SF6IQ/4oLFqj0xpS8R2tmsapYALcu191E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097571; c=relaxed/simple;
	bh=wqrcB4gYD5mVJxcH2ytWpjivIlK8sLuOolm6xMajBcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AS8KegV6JtSJCqFUFPSIsEZrDhUy5rsfRCSp37dWgLNMhIPQYZLFUBHGmfyBX6XhPuzL4mlU6mwMBvgqA6BRtBQ/oWTYyPbjF95w4tHvNHb0OCF5OVMkem+nD5HXvVD27j1Egg8FaD5Qx2BIw4Kuv9mIwuUTJxEK2ew7aSAq4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y7XNHAG5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=pdAyvfPdpXiDT5nwEE5JM65rIqzPvI29m/mgKeUTFRg=;
	b=Y7XNHAG5lANhswermEkPD8FEkAPMDsI5v49iHOX1x3pFkplI0GMjwJ70FHytCl
	b3Vohkrp79HmxUCoJxx5QB89z7Y+SBbF9jaa3Gh2kGy164HvtC/2NLy4/upRzPlZ
	JvbK7r8PHXzwf+i5LZAyUJiarSVnMb4MVnxeksJZARYpY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDn98VZcMpok55fBw--.48704S2;
	Wed, 17 Sep 2025 16:24:57 +0800 (CST)
From: yicongsrfy@163.com
To: andrew@lunn.ch,
	Frank.Sae@motor-comm.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: avoid config_init failure on unattached PHY during resume
Date: Wed, 17 Sep 2025 16:24:57 +0800
Message-Id: <20250917082457.1200792-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9393c232-06d8-464e-ac94-597eaeda2630@lunn.ch>
References: <9393c232-06d8-464e-ac94-597eaeda2630@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn98VZcMpok55fBw--.48704S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUe3ktUUUUU
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUAnL22jKa2GznAAAsO

On Thu, 11 Sep 2025 14:58:32 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Some PHY chips support two addresses, using address 0 as a broadcast address
> > and address 1 as the hardware address. Both addresses respond to GMAC's MDIO
> > read/write operations. As a result, during 'mdio_scan', both PHY addresses are
> > detected, leading to the creation of two PHY device instances (for example,
> > as in my previous email: xxxxmac_mii_bus-XXXX:00:00 and xxxxmac_mii_bus-XXXX:00:01).
>
> I would say the PHY driver is broken, or at least, not correctly
> handling the situation. When the scan finds the PHY at address 0, the
> PHY driver is probed, and it should look at the strapping and decided,
> if the strapping has put the PHY at address 0, or its the broadcast
> address being used. If it is the broadcast address, turn off broadcast
> address, and return -ENODEV. phylib should then not create a PHY at
> address 0. The scan will continue and find the PHY at its correct
> address. Your problem then goes away, and phylib has a correct
> representation of the hardware.

+To: Frank <Frank.Sae@motor-comm.com> (maintainer:MOTORCOMM PHY DRIVER)

Hi Andrew, thank you again for your reply!

Recently I conducted the following tests:
Following your suggestion, to avoid compatibility issues caused by
disabling broadcast address (after all, we don't know if any vendor
might directly use address 0 as the PHY's hardware address——otherwise
we could simply start scanning from address 1),I modified the logic
only for one specific chip in motorcomm.c, aiming to prevent phylib
from creating a phy_device instance at address 0:

static int yt8521_probe(struct phy_device *phydev) {
    ...
    if (/* phydev->mdio.addr == 0 AND phy_addr0 broadcast enable */)
        return -ENODEV;
    ...
}

However, this had no effect, for the following reasons:
1. `get_phy_device` does not invoke the driver's probe function,
    so it always succeeds.
2. Subsequently, during the `phy_device_register` probe, the entire
   call chain contains calls without return value handling, so we
   cannot rely on the driver's return value to determine whether to
   create the `phy_device`.

An example of `dump_stack()` output:
```
[    4.509504]  yt8521_probe+0x34/0x330 [motorcomm]  ==> checking inside driver
[    4.509513]  phy_probe+0x78/0x2b0 [libphy]
[    4.509529]  really_probe+0x184/0x3d0
[    4.509532]  __driver_probe_device+0x80/0x178
[    4.509534]  driver_probe_device+0x40/0x118
[    4.509536]  __device_attach_driver+0xb8/0x158
[    4.509538]  bus_for_each_drv+0x84/0xe8
[    4.509540]  __device_attach+0xd4/0x1b0
[    4.509542]  device_initial_probe+0x18/0x28     ==> allows asynchronous initialization
[    4.509543]  bus_probe_device+0xa8/0xb8         ==> no return value here
[    4.509545]  device_add+0x510/0x700
[    4.509549]  phy_device_register+0x58/0xb0 [libphy]
[    4.509562]  mdiobus_scan+0x80/0x1a8 [libphy]
[    4.509576]  __mdiobus_register+0x208/0x4b0 [libphy]
```

The existing framework appears unable to handle this situation.
Yet, there are at least two vendors (I have hardware from two
different vendors) whose PHY chips have broadcast addressing on
address 0 enabled by default.

Does this mean we can only force these vendors to disable it by default?


