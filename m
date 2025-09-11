Return-Path: <netdev+bounces-222092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B610B53056
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7056A85AD1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B41831A055;
	Thu, 11 Sep 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OK6//3tD"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E6314B8A;
	Thu, 11 Sep 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590010; cv=none; b=Er3ki9Nj5EQVjBl9w1bxH6nk5dHSie4b4vqv8qakgBtbFasOU/Jd0gl2Fet+tO5qrHevXsBbX2OrX+JfWUdavbsxFliT01K2A5Ol9qyCPWBb025Xqh8Bs+yVuqxusygh3KZzwbJBweigoUHUug5GS8hbdI9TRR+lIYlw+boFun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590010; c=relaxed/simple;
	bh=qGc5jx2TlqmbUZ05luhkqYaO/xLYnwqJRdeDDTtSO8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icVPye5fZY5+SeO/y2BUYomGyL6py/7faiJOZKQIgw+NoX6phNBdWWQybCq1LM7otTNsY6RN8fKC2FUBEtLmsP4HMYBK8d4Fe/g0isJZIl/LSSkrB3vuz0um8r1AQodgG9g3YJ9P/d8w3gADSfAuY7Kn2jVw/GC4cW6SE3xFraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OK6//3tD; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CO
	EvvwlmwDoA2pMwxCwzNYrjaVFZy7dLqFs2BwEoIHo=; b=OK6//3tDLUruKVY1Kv
	ky9P3ZkpMmjV4pTgaXXpfAryC3TqorVxaAXrr+LN3tkbOeGjuU3td51LekpDU+xF
	nXYIGO8+bIABGt5WQBTshER3pX/fUwBVdD2UsJEMl0WcsnS5apfmsO4VoAFYULEJ
	5KmwEdRg0XjlUoVZWbDHhhvFs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA3ThalscJozfgyCg--.64583S2;
	Thu, 11 Sep 2025 19:25:26 +0800 (CST)
From: yicongsrfy@163.com
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: avoid config_init failure on unattached PHY during resume
Date: Thu, 11 Sep 2025 19:25:25 +0800
Message-Id: <20250911112525.3824360-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aMFKvS-Dm0hhJVnO@shell.armlinux.org.uk>
References: <aMFKvS-Dm0hhJVnO@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgA3ThalscJozfgyCg--.64583S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWkJrW8Jr4UurW8uw1rZwb_yoW5Xw4kpa
	y3WrWFkr1DJF1fCrWDZr40y34jvanavryUGF9xtr9Yyr15XF9a9wnrKr47ZFW7Crn5Cayj
	qFWjvayjva909aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UzT5LUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUATF22jCq-mYPQABsW

On Wed, 10 Sep 2025 10:54:05 +0100, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>
> On Wed, Sep 10, 2025 at 05:17:03PM +0800, yicongsrfy@163.com wrote:
> > Then, because `phydev->interface != PHY_INTERFACE_MODE_SGMII`, it attempts
> > to enter `ytphy_rgmii_clk_delay_config` to configure the RGMII tx/rx delay.
> > However, since this PHY device is not associated with any GMAC and is not
> > connected via an RGMII interface, the function returns `-EOPNOTSUPP`.
>
> It seems the problem is this code:
>
>         /* set rgmii delay mode */
>         if (phydev->interface != PHY_INTERFACE_MODE_SGMII) {
>                 ret = ytphy_rgmii_clk_delay_config(phydev);
>
> which assumes that phydev->interface will be either SGMII or one of
> the RGMII modes. This is not the case with a PHY that has been
> freshly probed unless phydev->interface is set in the probe function.
>
> I see the probe function decodes the PHYs operating mode and
> configures stuff based on that. Maybe, as it only supports RGMII
> and SGMII, it should also initialise phydev->interface to the initial
> operating condition of the PHY if other code in the driver relies
> upon this being set to either SGMII or one of the RGMII types.
>

Thank you for your reply!

What you mentioned above is correct.
However, there is a particular scenario as follows:

Some PHY chips support two addresses, using address 0 as a broadcast address
and address 1 as the hardware address. Both addresses respond to GMAC's MDIO
read/write operations. As a result, during 'mdio_scan', both PHY addresses are
detected, leading to the creation of two PHY device instances (for example,
as in my previous email: xxxxmac_mii_bus-XXXX:00:00 and xxxxmac_mii_bus-XXXX:00:01).

The GMAC will only attach to one of these PHY addresses. Some GMAC drivers
select the first available PHY address (via calling 'phy_find_first'), leaving
the other address idle and unattached. However, during the system resume
process, it attempts to resume this unused PHY instance.

When resuming this PHY instance, because 'phydev->interface' hasn't been
set to a valid interface mode supported by the chip (such as RGMII or SGMII),
we encounter the EOPNOTSUPP error.

I've tried modifying motorcomm.c as a workaround, but logically speaking,
it's not an ideal solution:
1. If I return 0 from the driver's resume function, mdio_bus_phy_resume will proceed.
2. If I return an error, the system will still report an error.

The key issue is: does the current kernel provide any field or mechanism
to indicate that two PHY addresses (instances) actually refer to the same
physical PHY device?

I haven't found any such mechanism in the kernel. Do you have any
suggestions on how to properly handle this?

Looking forward to your advice. Thank you!


