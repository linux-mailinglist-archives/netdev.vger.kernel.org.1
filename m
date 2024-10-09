Return-Path: <netdev+bounces-133686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E700996AD7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5E61F287F8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C51E0DD4;
	Wed,  9 Oct 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y2XQ8E24"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582981E0481;
	Wed,  9 Oct 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478231; cv=none; b=bXIEJeJ2Roim6CP0YfBMYGQ0QRMDXZ/wYS7cDsbgjtR9lkZ7pwQ7fKWWWhnOBnSee37vZdLuIBSHwZiHqsR/F2ZVcb0BykrMRcodOlfSiUF80oUaq8XPP8Lv/IRAnM9eFbJzLZcpuG3hYqqPNzbrXIiUsNL6kp3sJifHnaG/7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478231; c=relaxed/simple;
	bh=+cAN/DObeXKW4IbTzwkaHNX54Rvjuw73IqC40UCh5mU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=LpPmaDnfB3ZbzJevHhCKyz4Xc3ikIC4DM4SIj2WshxAc7jKymHXWXk7KFfr9BNhHcCVv0ZXxtOLRB9rAmXfLQPdknLqRPJuEwwoFp+qFM+vjlzYmb1mwBKmKyVxJYkwVu87YvDFmx9/S7JQOynKR8jbXa/9aWXArUQ4dKbVlnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y2XQ8E24; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728478230; x=1760014230;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=+cAN/DObeXKW4IbTzwkaHNX54Rvjuw73IqC40UCh5mU=;
  b=Y2XQ8E24TXKYlifDPU66jrRyeHK5rDfC/pTiPzn1nVp3rhkDHp/MzFNR
   Kmk2570Tqdm2IxFbFmzJamdoB4hJ99vQloSDMTSnHwG3dw+OQVBAOiX24
   14Nz3cQtvPUxOl6AXhOtQBQ4dHChAcTzBpz4zCdnrFM6uaCisaMPOPa5R
   I++9GD1q9eDnIv9LfwAM7Vo/hInPFFOC1r2eSnS4AyUixwxqvaoKF15pQ
   d2mgFskadeWMlsjE+alIf1z+Vc3BZIrVbVDrZGEcEgPvkcveYeNyDCmqo
   2BUG8LsgYNmJwoFdBSZO2LYn3l0DxLpTKTa7APpFoCwCfYPRXWr9uqkqD
   g==;
X-CSE-ConnectionGUID: rgdn3Zg6SYizt573EhBTnQ==
X-CSE-MsgGUID: ONyLJOPvRxWofXOlnD6HwQ==
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="32790654"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2024 05:50:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 9 Oct 2024 05:50:19 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 9 Oct 2024 05:50:17 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 9 Oct 2024 14:49:56 +0200
Subject: [PATCH net] net: sparx5: fix source port register when mirroring
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241009-mirroring-fix-v1-1-9ec962301989@microchip.com>
X-B4-Tracking: v=1; b=H4sIAPN7BmcC/x2MQQqDQAwAvyI5N7DqtmC/Ij1k11RzMJasiCD+3
 djjDMwcUNiEC7yrA4w3KbKoQ/2oIE+kI6MMztCEJtYhdDiL2WKiI35lR3p2bRpyoleM4M3P2PX
 /14PyCh+XiQpjMtI83auZROE8L50RWzZ7AAAA
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

When port mirroring is added to a port, the bit position of the source
port, needs to be written to the register ANA_AC_PROBE_PORT_CFG.  This
register is replicated for n_ports > 32, and therefore we need to derive
the correct register from the port number.

Before this patch, we wrongly calculate the register from portno /
BITS_PER_BYTE, where the divisor ought to be 32, causing any port >=8 to
be written to the wrong register. We fix this, by using do_div(), where
the dividend is the register, the remainder is the bit position and the
divisor is now 32.

Fixes: 4e50d72b3b95 ("net: sparx5: add port mirroring implementation")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
index 15db423be4aa..459a53676ae9 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
@@ -31,10 +31,10 @@ static u64 sparx5_mirror_port_get(struct sparx5 *sparx5, u32 idx)
 /* Add port to mirror (only front ports) */
 static void sparx5_mirror_port_add(struct sparx5 *sparx5, u32 idx, u32 portno)
 {
-	u32 val, reg = portno;
+	u64 reg = portno;
+	u32 val;
 
-	reg = portno / BITS_PER_BYTE;
-	val = BIT(portno % BITS_PER_BYTE);
+	val = BIT(do_div(reg, 32));
 
 	if (reg == 0)
 		return spx5_rmw(val, val, sparx5, ANA_AC_PROBE_PORT_CFG(idx));
@@ -45,10 +45,10 @@ static void sparx5_mirror_port_add(struct sparx5 *sparx5, u32 idx, u32 portno)
 /* Delete port from mirror (only front ports) */
 static void sparx5_mirror_port_del(struct sparx5 *sparx5, u32 idx, u32 portno)
 {
-	u32 val, reg = portno;
+	u64 reg = portno;
+	u32 val;
 
-	reg = portno / BITS_PER_BYTE;
-	val = BIT(portno % BITS_PER_BYTE);
+	val = BIT(do_div(reg, 32));
 
 	if (reg == 0)
 		return spx5_rmw(0, val, sparx5, ANA_AC_PROBE_PORT_CFG(idx));

---
base-commit: 36efaca9cb28a893cad98f0448c39a8b698859e2
change-id: 20241009-mirroring-fix-a593bdcba644

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


