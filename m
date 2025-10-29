Return-Path: <netdev+bounces-233871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C587C19BC6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 11:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3CA750921C
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A03385A9;
	Wed, 29 Oct 2025 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="tTApARDL"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323C3093BF;
	Wed, 29 Oct 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733438; cv=none; b=jE4VXAaYr0TtGvujqMaPag3pqlFYWmd7iyWrde0tiHUnrGYBgJSjfod1I4Vz3AZb2p7FbSKOvDTxoxoLPoSt1JVvzpww/GuFRh5p0QJBbJZ2zE0XoRzMd/eZwUJbaDqugNiDjjwOVJIbVbutS32LXqys72u/wZo8fZUnJhNRvxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733438; c=relaxed/simple;
	bh=V/9DmmPb/9JaIeRTqSkl7VsKVUgs7AgVUEBSjd48QHc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TUsHp//KxfHRBg766s/fRFHLEQKZ/YInClnD2xfklyG9bK+IRfK9MaDlis26NN/djb33YgsXSrAqlOoRryEKHL2h/NamXu+WxcBzwIegjsLS0CFZ1UeIKCMszw6S5lzAHix8HoNnTzvpDIkixspXlkQ9SVUOl0gOAVZl/Z+opQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=tTApARDL; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 63136A06F4;
	Wed, 29 Oct 2025 11:23:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=2CNOHy1obJz1m4WDYmhomhplFbY455kGhYayJ+bWHiw=; b=
	tTApARDLIgErezT7sLQH0HHvzJ7Z+9ZTUHFy/rYEgCFAl3h9JIeOdYhX0XXoBfUn
	YmzcFOMyxvEnFdByNwGulgU0seHEMg8E2oxvQRcPctBBpM3W0EWgPzGk+MoicqYY
	svyoAfgvddqylbdtc65X0m1AX5ilQ3amemChBI8mKAKD2L0r2ilosDefrPU1DfSB
	9QCLALU+UvxY6Zq6I365jUoRFrluZTaVSYdFyZc9zYVNq/Q1mgAJQHOlocjIGWu6
	S8udkzHKqgrb2vCIJHGiysh/haUT2j4XQW1lMaQqi5wfPlRQ32x3hYJBX04norQO
	RVennBJljEE38MWZiFeJNPTiKmJ8njNr1kiLCevanbNscWJvPUIEqybQ+8mF/ttM
	Zf2Eva6DI0QPDACy4q/ZqWfQ+pXQBh7zDXjjnng6Kd+vHol4r2GwTS7ujRcTFFYr
	jMwbVKEXHnYiEcnLDs/+pwj/9t3j9GLTUYvu6kaBP3AjWozbo3eJ2wbYk1tnTvLC
	szpitB5XIkwCWvHW0Z5xGki8IyRwAbEfPhSK7JYhv1f0oC11R1n2k6m/4A4HmjrW
	Ar7RxkURHeBwKGz/7ub8wYqNcmZ6z74VOaOsKbRNPv9D/Yg9HlPRaJlvpuw9UtKZ
	rH7s9BnV9qW5z3qLaZ0TWsOYatGG95zrfp4VHB1wrh4=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v5 0/4] net: mdio: implement optional PHY reset before MDIO access
Date: Wed, 29 Oct 2025 11:23:40 +0100
Message-ID: <cover.1761732347.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761733431;VERSION=8000;MC=2277792185;ID=148161;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677066

Some Ethernet PHY devices require a hard reset before any MDIO access can
be safely performed. This includes the auto-detection of the PHY ID, which
is necessary to bind the correct driver to the device.

The kernel currently does not provide a way to assert the reset before
reading the ID, making these devices usable only when the ID is hardcoded
in the Device Tree 'compatible' string.
(One notable exception is the FEC driver and its now deprecated
`phy-reset-gpios` property).

This patchset implements an optional reset before reading of the PHY ID
register, allowing such PHYs to be used with auto-detected ID. The reset
is only asserted when the current logic fails to detect the ID, ensuring
compatibility with existing systems.

There have been several earlier attempts to implement such functionality,
of which I have collected a few in the links section.

The links to the previous versions are also provided.
The most notable changes compared to v4 are:
 - -EPROBE_DEFER during the reset is propagated upward, while any other
   errors retain the original error code
 - The info level message for asserting the reset is split into a
   separate commit.

Link: https://lore.kernel.org/lkml/1499346330-12166-2-git-send-email-richard.leitner@skidata.com/
Link: https://lore.kernel.org/all/20230405-net-next-topic-net-phy-reset-v1-0-7e5329f08002@pengutronix.de/
Link: https://lore.kernel.org/netdev/20250709133222.48802-4-buday.csaba@prolan.hu/
Link: https://lore.kernel.org/all/20251013135557.62949-1-buday.csaba@prolan.hu/
Link: https://lore.kernel.org/all/20251015134503.107925-1-buday.csaba@prolan.hu/
Link: https://lore.kernel.org/netdev/cover.1760620093.git.buday.csaba@prolan.hu/
Link: https://lore.kernel.org/netdev/cover.1761124022.git.buday.csaba@prolan.hu/

Buday Csaba (4):
  net: mdio: common handling of phy reset properties
  net: mdio: change property read from fwnode_property_read_u32() to
    device_property_read_u32()
  net: mdio: reset PHY before attempting to access registers in
    fwnode_mdiobus_register_phy
  net: mdio: add message when resetting a PHY before registration

 drivers/net/mdio/fwnode_mdio.c | 48 +++++++++++++++++++++----
 drivers/net/phy/mdio_bus.c     | 39 ++------------------
 drivers/net/phy/mdio_device.c  | 66 ++++++++++++++++++++++++++++++++++
 include/linux/mdio.h           |  3 ++
 4 files changed, 113 insertions(+), 43 deletions(-)


base-commit: 00922eeaca3c5c2001781bcad40e0bd54d0fdbb6
-- 
2.39.5



