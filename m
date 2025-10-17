Return-Path: <netdev+bounces-230538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C703BEAEA6
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2377C8131
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8802288C30;
	Fri, 17 Oct 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="DVJDUqr8"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4A2253EC;
	Fri, 17 Oct 2025 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717425; cv=none; b=tch38qhLW3+NH+JIapFriNOgbHl6tEGOohb83Y1sDDDsy6Yl3kXemP4yI5Bx/NBbFQvnRsXHRyDG4Eu3rdHHU6cIm5TH4K8/qy0OJiu1Gz1C92Zz55CE/QVo4+EE2tte9uo/Ir000AC6YOpLWicUbVeIwKVdJjf4JBFWE6S4B1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717425; c=relaxed/simple;
	bh=6KhZzuB5RgPXRnk3z3pqPv5g/6A72xiksTm8KdGgFOc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GfVXYIs9he1S7tPtILRY9WghCT5Ax7fCFh+Gh/3oIejn4bqnsViowmF+ZxmUHmn8GkXm4XoMuuoCXX/Qe+cGW49SFcllWxnnpZtG3LDVOK4NJNUVkba/9YWJ5Yyk6irl3kTCX+LSPaIUdI3/q2ls7B2w7kmcLG062f9j6kKrXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=DVJDUqr8; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 2C860A10D7;
	Fri, 17 Oct 2025 18:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=qdHFeu7J/stvY65dY6buBrBVhFapjPw5TmtVfzS/XXk=; b=
	DVJDUqr8F1ubGCEo4HU7/D7OEq3IWQUG1YSmnvsprjPJLt49uPYTyOtmAJr1DTaq
	9BYcrHWj9bUOCBQ0eUoDNWKQrLakhCD3D7JxOuhDw9uQUNY0yfAs03PxYf7FxZr5
	3aSwEcNaXAV3wKjlwP0G7inQgFY2dYpQ69oWji7rqvFbZR9IIY09x0wZk1iDD8cu
	CtSGJ5zDvGM939Nz1N2lw2bqH+S8BPvsGLSAm3YxyvNEq99O4DBX213qC+Neh71A
	n0obF7nPjePKelFGScADayhQD2rMOCsv87/V3Pt1RqwPguhvpWvRg/OCcYLc3roM
	gToix5XkTrsgZYIIRhHW5IluXOJtXlO33DXfYnItCjLanOHDZn1fc3rRbuC1ExuD
	+q0g/NbQLYOWZFF3ou9+X1Fw0hIwfr+A6Zu60t6y+O3prQvJsPPEcjUJKS0YFAcE
	fokUQBNw7bO/bdsIWrNNgNiNUHPoUVH1bCw22+pIps7FLSJ6x/AQn05YW4zF7AJ5
	XHCrwyZuUWsmnUNIhiFQ7S24tMvEFYXModada3Bi4s3OuELzoVBWdgD6YaZdN2rN
	X9Sd8aDfXYo1M3t4MfcXNgdDklPFJDRJuQU8oDuf2GF+yKFnk11ns84VUSE+V2ko
	xeg2dcSg03zMNx787BOo4v+n4EYha8n4v3osBZI4mzk=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Florian
 Fainelli" <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v3 0/4] net: mdio: implement optional PHY reset before MDIO access
Date: Fri, 17 Oct 2025 18:10:07 +0200
Message-ID: <cover.1760620093.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760717418;VERSION=8000;MC=4017348431;ID=38906;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F647660

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
is controlled by a newly defined DT property, so it should not break
compatibility with existing systems.

There have been several earlier attempts to implement such functionality,
of which I have collected a few in the links section.

The links to my own v1 and v2 versions are also provided.

Link: https://lore.kernel.org/lkml/1499346330-12166-2-git-send-email-richard.leitner@skidata.com/
Link: https://lore.kernel.org/all/20230405-net-next-topic-net-phy-reset-v1-0-7e5329f08002@pengutronix.de/
Link: https://lore.kernel.org/netdev/20250709133222.48802-4-buday.csaba@prolan.hu/
Link: https://lore.kernel.org/all/20251013135557.62949-1-buday.csaba@prolan.hu/
Link: https://lore.kernel.org/all/20251015134503.107925-1-buday.csaba@prolan.hu/

Buday Csaba (4):
  net: mdio: common handling of phy reset properties
  net: mdio: change property read from fwnode_property_read_u32() to
    device_property_read_u32()
  dt-bindings: net: mdio: add phy-id-read-needs-reset property
  net: mdio: reset PHY before attempting to access registers in
    fwnode_mdiobus_register_phy

 .../devicetree/bindings/net/ethernet-phy.yaml |  8 +++
 drivers/net/mdio/fwnode_mdio.c                | 40 +++++++++++---
 drivers/net/phy/mdio_bus.c                    | 39 +-------------
 drivers/net/phy/mdio_device.c                 | 52 +++++++++++++++++++
 include/linux/mdio.h                          |  2 +
 5 files changed, 98 insertions(+), 43 deletions(-)


base-commit: 00922eeaca3c5c2001781bcad40e0bd54d0fdbb6
-- 
2.39.5



