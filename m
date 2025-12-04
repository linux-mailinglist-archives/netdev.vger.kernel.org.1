Return-Path: <netdev+bounces-243527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C28FBCA320E
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 11:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C343E30250AD
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD042D8DCF;
	Thu,  4 Dec 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPu5zMPV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC52C3271;
	Thu,  4 Dec 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842505; cv=none; b=jn6ofzcZOy5TKj5icHsoqy8C3axYlv2s7eJBrTFqh3772mQ0okbQPU34AMXWba6IbBXCuMsD+fRjgGGRIJ451nOvhbtLQl4iBl5tTrqmG18rXYBBz5Nj9TAtYXeKIFWX3ZJPiBYuwx9g093tiCRHKRNOnIAaLoEPjLm/p0Of53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842505; c=relaxed/simple;
	bh=1IYAj78aY4bMwM2sZqFDzQRKhiEqKcPO1GMXoMySoX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dv8DAPsbKnPah2etxn0QBc5xY7tF1VAQW3N7VfWhbGpGMpB2yg1j88cQfTImM6miyosHuh8/CoySCS4BDI3eXrVTMd+xERogGITm+F20/g6CNJ4n8wScbsX1ia/58Ee13mwtr6pu2YkvM5+d6Y1LCbTSpY/Kfay9H4LoQ5x7wek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPu5zMPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3702C116C6;
	Thu,  4 Dec 2025 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764842504;
	bh=1IYAj78aY4bMwM2sZqFDzQRKhiEqKcPO1GMXoMySoX4=;
	h=From:To:Cc:Subject:Date:From;
	b=IPu5zMPVHz9ak8XWtD8zM+H7m+P89IlmKhvCP+1DPCpnXy8rIassujlAtn3IFXCtv
	 oYePiCzDNVZyXl1jylmT8szGEHBO2iu4uL1O5tGQNIO97O303rCZMRpHW5AHnWMCLt
	 JC9q9ML9mO9vgXW5P62PQNDEhlXgFrXGCCdrxxvp5t9PAmUScDwmYwmFymJvB9c6tE
	 HjiqD2t9a/J7GMGzJ5hBlX5KoWNXsPdm2VC1isyoNa/OmJjQ9fh2J1f0HafsUbhfvs
	 buhE/1Cp++m1ykm9AdJjJOND6kO7qZq8ODCertzmkWVslXZiiWAgoMpCifXREkWpDw
	 1P8T5/UjaQyIA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Roger Quadros <rogerq@ti.com>,
	Basharath Hussain Khaja <basharath@couthit.com>,
	"Andrew F. Davis" <afd@ti.com>,
	Parvathi Pudi <parvathi@couthit.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Meghana Malladi <m-malladi@ti.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ti: icssg-prueth: add PTP_1588_CLOCK_OPTIONAL dependency
Date: Thu,  4 Dec 2025 11:01:28 +0100
Message-Id: <20251204100138.1034175-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The new icssg-prueth driver needs the same dependency as the other parts
that use the ptp-1588:

WARNING: unmet direct dependencies detected for TI_ICSS_IEP
  Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_TI [=y] && PTP_1588_CLOCK_OPTIONAL [=m] && TI_PRUSS [=y]
  Selected by [y]:
  - TI_PRUETH [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_TI [=y] && PRU_REMOTEPROC [=y] && NET_SWITCHDEV [=y]

Add the correct dependency on the two drivers missing it, and remove
the pointless 'imply' in the process.

Fixes: e654b85a693e ("net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0 platforms")
Fixes: 511f6c1ae093 ("net: ti: icssm-prueth: Adds ICSSM Ethernet driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index a54d71155263..fe5b2926d8ab 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -209,6 +209,7 @@ config TI_ICSSG_PRUETH_SR1
 	depends on PRU_REMOTEPROC
 	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
 	  This subsystem is available on the AM65 SR1.0 platform.
@@ -234,7 +235,7 @@ config TI_PRUETH
 	depends on PRU_REMOTEPROC
 	depends on NET_SWITCHDEV
 	select TI_ICSS_IEP
-	imply PTP_1588_CLOCK
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Some TI SoCs has Programmable Realtime Unit (PRU) cores which can
 	  support Single or Dual Ethernet ports with the help of firmware code
-- 
2.39.5


