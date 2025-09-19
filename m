Return-Path: <netdev+bounces-224683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4BBB883AC
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AB61C87020
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 07:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D1D2D322E;
	Fri, 19 Sep 2025 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RBILurRw"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5B82D0C62;
	Fri, 19 Sep 2025 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267574; cv=none; b=In3AlcjS/w00ySdCD05EKW8BUo5mrF1U27pDwrReuM0+dJuSrJagVpYdbibB0VIIdN1W5y6tPbQ4WnnM1wMobvhRpfaw2zF+UnDmLG8xKczzk2+e+CLP0ZJhPExFl7o7eGRmqlxL1BZ9fCTUoA4Tko2V0kFseqLF/Y5Ts3yjq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267574; c=relaxed/simple;
	bh=kwbmyf/POZ28tT+2q7ekT9Rz+cnqE5iApRXmGHlw2AE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDCzkYE5OqZIwyBTmQOF607jKtBg46kz8WHgWn3qLan0wKRVaIRkOkLiSqeWuEfNO0wsxs6D/4scWujuZueDCBOpx2n7DPxBc0UEvTdLLlc5lE9kwf0X6vsSXfBeddAveSZlY+VEV6sm31H69vEEleTak9s6vn+GwWacBMy72mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RBILurRw; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SP
	kvn7GHUfWCWNmKPhYKEzwCIOsNFEeoKi8yT8Kw7Ng=; b=RBILurRwZeN84/3QCu
	rsyCicXGMQmEkvgVnch66lF1Z2GHV26K7oqin1FrCFtRCungzbiD4oPQMUj4EHBC
	aAzbgAD2a/dbqyCL2uxFZb8ZbHpaj5ZjpMx0+zreL9vVf6VasqIwgHaQEYt88Gj8
	LrqGGB2ak6smzZ30Y4NVidJds=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAH5OFyCM1oiBwzDg--.24802S2;
	Fri, 19 Sep 2025 15:38:26 +0800 (CST)
From: yicongsrfy@163.com
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	Frank.Sae@motor-comm.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: avoid config_init failure on unattached PHY during resume
Date: Fri, 19 Sep 2025 15:38:26 +0800
Message-Id: <20250919073826.3629945-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aMqILVD_F7Rm-mfx@shell.armlinux.org.uk>
References: <aMqILVD_F7Rm-mfx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAH5OFyCM1oiBwzDg--.24802S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4rArW3tw1DZw4rXFWrZrb_yoW5uF43pF
	W5JFW8ArykKw4S9F4jqw4qyFyYkrs3Z3y7JryrGryY9rs8XryfCF9ak3WYyr47Wr4v93W2
	v3y7tFWUJFyDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UzT5LUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBFBvL22jKhWBbkAADsQ

On Wed, 17 Sep 2025 11:06:37 +0100, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>
> I don't see that there is anything that a PHY driver can do to solve
> this as the code currently stands, especially if the MAC driver is
> coded to "use the lowest PHY address present on the MDIO bus" (which
> in this case will be your vendor's idea of a broadcast address.)
>
> I really don't think we should start adding hacks for this kind of
> stuff into phylib's core - we can't know that PHY address 0 is a
> duplicate of another address.
>
> The only thing I can come up with is:
>
> 1. There must be a way to configure the PHY to disable its non-
>    standard "broadcast MDIO address" to make it compliant with 802.3.
>    I suggest that board firmware needs to set that to make the PHY
>    compliant.
>
> 2. As a hard reset of the PHY will likely clear that setting, this is
>    another nail in the coffin of PHY hard reset handling in the kernel
>    which has been the cause of many issues. (Another nail in that
>    coffin is that some MACs require the RX clock from the PHY to be
>    running in order to properly reset.)

Thank you for your reply!

Since this issue cannot be fundamentally resolved within phylib,
we need to seek a solution within the PHY driver itself.

Let's return to the original problem: how to solve the suspend/resume
issue caused by a single physical PHY device generating multiple
`phy_device` instances?

A key requirement for a device's suspend/resume functionality is
power saving, which ultimately needs to take effect on the physical
hardware. Therefore, we only need to ensure that one `phy_device`
instance operates on the actual physical device.

Based on this idea, I've made the following modifications:
1.  Add a check within the PHY driver to identify the broadcast address.
2.  In `config_init`, `suspend`, and `resume` functions, if the broadcast
address is encountered, return immediately without further processing.

This approach assumes that the MAC driver correctly uses the PHY's
hardware address, rather than finding address 0 via `phy_find_first`,
which might be the default broadcast address for some PHY chips.

Here is a partial patch:
```
+/**
+ * yt8521_check_broadcast_phyaddr()
+ * - check is it a phydev with broadcast addr.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns true or false.
+ */
+static bool yt8521_check_broadcast_phyaddr(struct phy_device *phydev)
+{
+	if (/* addr 0 is broaddcast OR other broadcast addr */)
+		return true;
+
+	return false;
+}
+

static int yt8521_probe(struct phy_device *phydev) {
    ...
+	/* Logically speaking, it should return directly here,
+	 * although it don't have the expected effect.
+	 */
+	if (yt8521_check_broadcast_phyaddr(phydev))
+		return -ENODEV;
    ...
}

static int yt8521_suspend(struct phy_device *phydev) {
    ...
+	if (yt8521_check_broadcast_phyaddr(phydev))
+		return 0;
    ...
}

static int yt8521_resume(struct phy_device *phydev) {
    ...
+	if (yt8521_check_broadcast_phyaddr(phydev))
+		return 0;
    ...
}

static int yt8521_config_init(struct phy_device *phydev) {
    ...
+	if (yt8521_check_broadcast_phyaddr(phydev))
+		return 0;
    ...
}
```

Testing has confirmed that this fix is effective.

Could you please review if this fix approach is appropriate? If it's acceptable, I will send a complete patch v2.
Thank you very much!


