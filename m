Return-Path: <netdev+bounces-125214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A5996C521
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A04B23E04
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0E41DA114;
	Wed,  4 Sep 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kXoHkyYr"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C1A4778C;
	Wed,  4 Sep 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470310; cv=none; b=fAqk3CBdYA93OIx8aHB2vGA5srvZwyyI/v/a29isynGKnD6YBuba0X6fyP3V4ZJVD52cSWbF55qdVyyASBG3mMortZGYIxlRgDWvXADRoUFVC+k+nEb0mhKsIy2/0NhVH8BiPzR4deqGUeKmMQl9Vzvmo6fAnMJOBn4DCnqxAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470310; c=relaxed/simple;
	bh=E/E5JhbrfT57vP8uFB1keC/eE1gu7TCG6Aj5vvTUcKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOElj/dW4/dwUGFOSSE9muRnpZ2KpcpGhCSkcnqdtxIe1qn5rWQxRpuDEQ1PPOFKoCG7wdKRaIbIVzUR3A+T67BgPjcP7QVjppeAbewoilo9NpiM3UBBWC8+kWB77V+tuQ36YQNgccAWtnRf5Z/RphAiyQIfcUs0u6mkw66tSrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kXoHkyYr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2EBB31BF207;
	Wed,  4 Sep 2024 17:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725470305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b5GPOiRWglxmB+1s+UM7/QwT5TJ9jmKJ77MFU2A6G9o=;
	b=kXoHkyYrjZc3bzBJ+Hy6K7klwuT/Yy3gwaBaKzoxSu8SEMgH3PI4RfnHb2Op3qodkVXA5I
	Gc8FGaposZQHUKPcfVXS+27HpKH9AxXdFWzjeLP+MZmuCK9kyBtNzt4dvxsPIzoCTAbzI5
	kyK7vc6GMRfH9q6gwAjyyoXCa+MCR/41W7h4qeJXTjBtd+JCuU6aEqC4l+zvJ1kujjHfu9
	eb4Qp4gP30/KZcsCHtwk/k783BscSQ41mu7GDpAICndx736DJD0o+oUgVSJDVVl9oomadk
	0sFVS0OomQxXutr91dQfPscDdjZaeFvFd3JtpJOH5ufW8eRQeE6vjsUFvWFv7Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 0/8] net: ethernet: fs_enet: Cleanup and phylink conversion
Date: Wed,  4 Sep 2024 19:18:13 +0200
Message-ID: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

This is V3 of a series that cleans-up fs_enet, with the ultimate goal of
converting it to phylink (patch 8).

The main changes compared to V2 are :
 - Reviewed-by tags from Andrew were gathered
 - Patch 5 now includes the removal of now unused includes, thanks
   Andrew for spotting this
 - Patch 4 is new, it reworks the adjust_link to move the spinlock
   acquisition to a more suitable location. Although this dissapears in
   the actual phylink port, it makes the phylink conversion clearer on
   that point
 - Patch 8 includes fixes in the tx_timeout cancellation, to prevent
   taking rtnl twice when canceling a pending tx_timeout. Thanks Jakub
   for spotting this.

Link to V2: https://lore.kernel.org/netdev/20240829161531.610874-1-maxime.chevallier@bootlin.com/
Link to V1: https://lore.kernel.org/netdev/20240828095103.132625-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (8):
  net: ethernet: fs_enet: convert to SPDX
  net: ethernet: fs_enet: cosmetic cleanups
  net: ethernet: fs_enet: drop the .adjust_link custom fs_ops
  net: ethernet: fs_enet: only protect the .restart() call in
    .adjust_link
  net: ethernet: fs_enet: drop unused phy_info and mii_if_info
  net: ethernet: fs_enet: use macros for speed and duplex values
  net: ethernet: fs_enet: simplify clock handling with devm accessors
  net: ethernet: fs_enet: phylink conversion

 .../net/ethernet/freescale/fs_enet/Kconfig    |   2 +-
 .../ethernet/freescale/fs_enet/fs_enet-main.c | 444 ++++++++----------
 .../net/ethernet/freescale/fs_enet/fs_enet.h  |  27 +-
 .../net/ethernet/freescale/fs_enet/mac-fcc.c  |  17 +-
 .../net/ethernet/freescale/fs_enet/mac-fec.c  |  15 +-
 .../net/ethernet/freescale/fs_enet/mac-scc.c  |  11 +-
 .../ethernet/freescale/fs_enet/mii-bitbang.c  |   5 +-
 .../net/ethernet/freescale/fs_enet/mii-fec.c  |   5 +-
 8 files changed, 219 insertions(+), 307 deletions(-)

-- 
2.46.0


