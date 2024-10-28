Return-Path: <netdev+bounces-139690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 860109B3CFC
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B975B214C6
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657771E260A;
	Mon, 28 Oct 2024 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="iKO1UGSx"
X-Original-To: netdev@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37F1E22E6
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151719; cv=none; b=L4doIwpv/OcHpktb5Og6o3vVmlGtgXsVSwmwB0D56qbtt0JEzOldhpsc/DkmmQIQWTHIwaPCK8wqSlsrT2rndm9F/en7ThuuvbJn/U3EPb8ADtqovEh/bwuHXO/H9/LOIigp+ms908S29hXjIcjGux5geVmNFLDREI/gOHj/8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151719; c=relaxed/simple;
	bh=E5vZpcserfbhp5ZMMIf1gnct0CfnKU3oPLTOVd8Domk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdGz3meUaEy0uRr0A7+xb6ThVYAdhXTSN7imbmMvUmq0kgfG8WJ/9qn6Rlcy9B7qIGr5xZ0dKi2auFnv1GL7HaVTLUoE1WEfwY1fhDKdEBPox8NmcGCe7gEMpuNy06vxA5W20cST+QQ12AjzXepm68S7vdq/UCZMYxRtNAoPC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=iKO1UGSx; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sNDOBeLf9sNmKaqKkgwOJ/3ixWSkmfg8hl8GO95hrhs=; b=iKO1UGSxUvfY/nvIJ/FBOqyCyn
	y3oXFzSkuzsSB4MO3P7VeFIMPIPjiNDfuC6UdoNfeioKF+tzJ+uMrOIjnJvmQO3EyHhrPQSv2VscZ
	N3kBODEj8TZ9lrQ9c/jDfMz/UymTyJKyMz6WngNH/RlqFUmtTan1e/lA5biwrbvP2SUU=;
Received: from [88.117.52.189] (helo=hornet.engleder.at)
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1t5WVA-0000000077v-34kX;
	Mon, 28 Oct 2024 21:38:13 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next 0/4] Support loopback mode speed selection
Date: Mon, 28 Oct 2024 21:38:00 +0100
Message-Id: <20241028203804.41689-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Previously to commit 6ff3cddc365b
("net: phylib: do not disable autoneg for fixed speeds >= 1G") it was
possible to select the speed of the loopback mode by configuring a fixed
speed before enabling the loopback mode. Now autoneg is always enabled
for >= 1G and a fixed speed of >= 1G requires successful autoneg. Thus,
the speed of the loopback mode depends on the link partner for >= 1G.
There is no technical reason to depend on the link partner for loopback
mode. With this behavior the loopback mode is less useful for testing.

Allow PHYs to support optional speed selection for the loopback mode.
This support is implemented for the generic loopback support and for PHY
drivers, which obviously support speed selection for loopback mode.
Additionally, loopback support according to the data sheet is added to
the KSZ9031 PHY.

Use this loopback speed selection in the tsnep driver to select the
loopback mode speed depending the previously active speed. User space
tests with 100 Mbps and 1 Gbps loopback are possible again.

Gerhard Engleder (4):
  net: phy: Allow loopback speed selection for PHY drivers
  net: phy: Support speed selection for PHY loopback
  net: phy: micrel: Add loopback support
  tsnep: Select speed for loopback

 drivers/net/ethernet/engleder/tsnep_main.c    | 12 +++++++-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  4 +--
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  4 +--
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  2 +-
 .../stmicro/stmmac/stmmac_selftests.c         |  8 +++---
 drivers/net/phy/adin1100.c                    |  5 +++-
 drivers/net/phy/dp83867.c                     |  5 +++-
 drivers/net/phy/marvell.c                     |  8 +++++-
 drivers/net/phy/micrel.c                      | 28 +++++++++++++++++++
 drivers/net/phy/mxl-gpy.c                     | 11 +++++---
 drivers/net/phy/phy-c45.c                     |  5 +++-
 drivers/net/phy/phy_device.c                  | 14 +++++++---
 drivers/net/phy/xilinx_gmii2rgmii.c           |  7 +++--
 include/linux/phy.h                           | 18 ++++++++----
 net/core/selftests.c                          |  4 +--
 15 files changed, 103 insertions(+), 32 deletions(-)

-- 
2.39.2


