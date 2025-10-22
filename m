Return-Path: <netdev+bounces-231592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A03BFB165
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E58D480866
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D5311C2F;
	Wed, 22 Oct 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="tp+86uuA"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1D311972;
	Wed, 22 Oct 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124146; cv=none; b=rRGL4UaxKZuvS4NbwfY5Ltn7G3GcI/7BmMB6v34P7FbRhhWZ9Z22B6pKlrREcBPe77XlAo79ZhscpzpukkpmLCqMyNBbdCR1g8Vh3tD5yEdqqNEkfCCfSeHQohqFIe6OeV90Z6febo28SnjR0eqpxyLjggRAZUxMQiJoRwmJX5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124146; c=relaxed/simple;
	bh=eBSJV92Dxekb3m43OQ15e2+Xm5xgtHLYnGlo4Mq9YK4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iD/ob9eswkYsqTwUsYV8P9hMj5vILQP3vAdFC81cBFVcs7GASVTUF7K1rHsA94m01CBmcRu5Y3g9oPkgZl7E/uEk73VAgC++6QG5ajZjCqi8fFLUh9Rt7GxlgwG2qTjsczEGfX/xrFNFSS4OjYGY1H4/PsQ+ms1A/stoK9kanf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=tp+86uuA; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A68BDA078B;
	Wed, 22 Oct 2025 11:08:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=MCwuiOwZycR3vgRWsnGPtWUUmB+YUeTto8A8jrxoezc=; b=
	tp+86uuAgIxYhm7Besi714LlswrxWctQOyj7uVzmO7ETkqCIu1QXZ1lbEv9VCgi2
	pNDB4A8YCGPxbOrj2olbemeMkbwzjvFw1re7X3a9vilpol2yxvVX9LGyQI/ssUrb
	UZc/ewqSEFwGxrYgz5QYzebbQolbmhsND5r1aV8k6gcWMNiL+1RQLczwRKIc3/kN
	OJV3HwoddfHvaiVGjFFOo01nXSUi0jSh/bxqbI6of9g15sWy2B3Fg6cSNZno6sZO
	KRni//Nr7xR58kRJxgJD046m7/1RHAV1AfvvZfqeERn8uiXE9NSTvbexeazO8S37
	MqaFJon1lRRC4TYV+AJn/LR1iMGsBgvsvdXqmnyMu2emSAHkmmx1t7Z7XTniJCff
	nktdeZ+ohHxohv1MqdReB/m2h3b5LrmBQNRxT2iEUEQbQnPxSwfwxJmbRj2Bg5mw
	VZ9niEm+mnwSgbqnucStw6omwPsDCV9lzLXI2pzCNMS0JascP0ptBxBV5yiWUe8l
	PKkFy9C8OPbiu2Lv/NcAZNTauX7MHhWx7CCQKmEsytldBCqUzGXmOfNkMeTwffSa
	5dy4saaRZ05YsIKvddYSZ5kLy4AGsIJpuvJgPWCxCxJw2rY8Ij8PM1IyQDZ9BHSr
	F+WTLDmI3oRqdPdHeJPAZmMQQC3pKccIO8sDXuAUruI=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v4 0/4] net: mdio: implement optional PHY reset before MDIO access
Date: Wed, 22 Oct 2025 11:08:49 +0200
Message-ID: <cover.1761124022.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761124135;VERSION=8000;MC=1687276879;ID=130157;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F647D62

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

The links to my own v1, v2 and v3 versions are also provided.
The most notable change compared to v3, is that the DT binding is removed,
and the hard-reset works as a fallback logic now.

Link: https://lore.kernel.org/lkml/1499346330-12166-2-git-send-email-richard.leitner@skidata.com/
Link: https://lore.kernel.org/all/20230405-net-next-topic-net-phy-reset-v1-0-7e5329f08002@pengutronix.de/
Link: https://lore.kernel.org/netdev/20250709133222.48802-4-buday.csaba@prolan.hu/
Link: https://lore.kernel.org/all/20251013135557.62949-1-buday.csaba@prolan.hu/
Link: https://lore.kernel.org/all/20251015134503.107925-1-buday.csaba@prolan.hu/
Link: https://lore.kernel.org/netdev/cover.1760620093.git.buday.csaba@prolan.hu/

Buday Csaba (4):
  net: mdio: common handling of phy reset properties
  net: mdio: change property read from fwnode_property_read_u32() to
    device_property_read_u32()
  net: mdio: introduce mdio_device_has_reset()
  net: mdio: reset PHY before attempting to access registers in
    fwnode_mdiobus_register_phy

 drivers/net/mdio/fwnode_mdio.c | 46 ++++++++++++++++++++----
 drivers/net/phy/mdio_bus.c     | 39 ++------------------
 drivers/net/phy/mdio_device.c  | 65 ++++++++++++++++++++++++++++++++++
 include/linux/mdio.h           |  3 ++
 4 files changed, 110 insertions(+), 43 deletions(-)


base-commit: 00922eeaca3c5c2001781bcad40e0bd54d0fdbb6
-- 
2.39.5



