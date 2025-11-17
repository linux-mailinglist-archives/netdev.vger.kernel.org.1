Return-Path: <netdev+bounces-239060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719ABC6331F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBF13A75BF
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333132ABCE;
	Mon, 17 Nov 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="seo49pMH"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2F32AACC;
	Mon, 17 Nov 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372060; cv=none; b=UyVra7lpbCIrYdIblOSmTWqsgr339bBnSv/1kxmrJLCSV1k/HDG1NruWgMHZ3mzOWUdBGXITVXabT16x4JF9tX3N6roK5f1/xTT3modLiFWCkotYPnxh5kXwMSttY716CDMNdTVB5fptg2VuUVaojyVvMiN8gtJ+6n10PNKW3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372060; c=relaxed/simple;
	bh=Qii6I/zM5zF+eHm66yWTRdNsEwrojJmFv0kDuraJ9lg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZeJ0Ho6eC7a4TB2Pex/t/kWbhuOo6xPx9fZbGGAmuTEVSAjzEO2lNMWsJZCMB+EOL7QItWhY6uUnaVBqdgYW1I3WELe8pewPzXqo2P0p4Kz/Kgk8Wh3BPfBb7MpxGxrgujWWTuxI3A++QuLuAXrXDUDk0kep/2GIe5TwiIvRwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=seo49pMH; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9DE54A0D3B;
	Mon, 17 Nov 2025 10:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=k/TG8VDVjfE+drvmkp1QDO0s4ywAHeFsWDRI3xi7XtQ=; b=
	seo49pMHJ9sgaHYHxjKoVoyhuBv6RImZhp+agRbnXz9zrBrhy8sioJ21xyWPkNIq
	Kdbf6eXZQ+lrIBlCGe1NUsnU6JRYijXj/Du84ppG3BP6q338pO8KVkn7BvEQk7Od
	O8/lBElDDFqXrDbc8l3ErgXc6QRf8/UKSHrM46LFFzKTT5swL2dAu04dcRKxTsBP
	qkxRUjY6fRJLPEQ0HzXGRVL0QSSwYGS2catxOqqIQQ4PuLfIBqXXLAE8STfi9HvQ
	RJ3cj8Ba2oXPs+y4vY7FiJk/vzSCw0svYmj0N1GO/pk/37Bgl6U3/E+GillrYUKI
	aI+d/ovAeYSyPNk7fGZSE40ItYaQnsy3Rj5TsURPtncqIcIZ60f2+wt40GmWQq7a
	Ct5BB6fRueL/0UR0XrPC0oxVUlfasOMepPnTxCWF7gedI0/Qh61Y2+I5DrK8g20n
	InAIvmK4/LHtau0tSs3ibX3gunpPHh5uZK3i3nYJGPM9+p0VJk7HsfYKee/+UDNs
	o7tOqWM6Y4G79OXbTeHyNbsKv8nU4m4INl7bfVlS5sXwsGVhgU+09Wd98BQA+Fct
	Gu+IvUJ7jj4QZrv89RNOAsUz3OT5jq8wN0BojgcutfzYBl+mz2BLT3vGATU7hIs1
	qvlEtCKdyw5aAehlNd2cj4uHs+UAZqPKpbY9YrmcAH8=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v2 0/3] net: mdio: improve reset handling of mdio devices
Date: Mon, 17 Nov 2025 10:28:50 +0100
Message-ID: <cover.1763371003.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763371741;VERSION=8002;MC=3747753318;ID=73150;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F617362

This patchset refactors and slightly improves the reset handling of
`mdio_device`..

The patches were split from a larger series, discussed previously in the
links below.

The difference between v1 and v2, is that the leak fix was applied to the 
base already. See links for v1 and for the now separate leak fix.

Link: https://lore.kernel.org/all/cover.1761732347.git.buday.csaba@prolan.hu/
Link: https://lore.kernel.org/all/cover.1761909948.git.buday.csaba@prolan.hu/
Link: https://lore.kernel.org/all/4b419377f8dd7d2f63f919d0f74a336c734f8fff.1762584481.git.buday.csaba@prolan.hu/

Buday Csaba (3):
  net: mdio: move device reset functions to mdio_device.c
  net: mdio: common handling of phy device reset properties
  net: mdio: improve reset handling in mdio_device.c

 drivers/net/mdio/fwnode_mdio.c |  5 ----
 drivers/net/phy/mdio_bus.c     | 39 ++-----------------------
 drivers/net/phy/mdio_device.c  | 53 ++++++++++++++++++++++++++++++++++
 include/linux/mdio.h           |  2 ++
 4 files changed, 57 insertions(+), 42 deletions(-)


base-commit: c9dfb92de0738eb7fe6a591ad1642333793e8b6e
-- 
2.39.5



