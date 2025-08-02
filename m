Return-Path: <netdev+bounces-211465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD4B18F44
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 17:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DE0179F9C
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B14242D9C;
	Sat,  2 Aug 2025 15:53:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3E15C158;
	Sat,  2 Aug 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754149988; cv=none; b=Fj/RZYes2yec+/dAOvTa4o/InRHswewtpOqukKCD3HLaw8M3I5FeVtrU4FmP6HQvM8ueaqaQn3CZH6UCgXdL0SxEfKP3V/Jr01UkB67T1VRb0OGYcET//V2U32dsJLTQuJ9dOz97fiFoejHjDPU29ac5j6lDtYwAXmu6xIzj6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754149988; c=relaxed/simple;
	bh=hbk+NLqpNnQ/UzaZO/46jaA5qKKOGN9uUThhLy3b4M4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUsC0d0Zzzkt5xc90UdapIFsyOt+k2+MlS1qFZxwzP6vP8CJJ9gj2clxQzW0mGiBaGdNWvkQMu0MBr3omt/9n/psgr671Okq9XmF3qRB+i9zguHm/KvG4pHax2H4rv8+Nwp+VPIEsvs6CzK3P40a6fY9Z8A7BVwG/FoJbGqXQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40E0C4CEEF;
	Sat,  2 Aug 2025 15:53:06 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dpll: zl3073x: ZL3073X_I2C and ZL3073X_SPI should depend on NET
Date: Sat,  2 Aug 2025 17:53:02 +0200
Message-ID: <20250802155302.3673457-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When making ZL3073X invisible, it was overlooked that ZL3073X depends on
NET, while ZL3073X_I2C and ZL3073X_SPI do not, causing:

    WARNING: unmet direct dependencies detected for ZL3073X when selected by ZL3073X_I2C
    WARNING: unmet direct dependencies detected for ZL3073X when selected by ZL3073X_SPI
    WARNING: unmet direct dependencies detected for ZL3073X
	Depends on [n]: NET [=n]
	Selected by [y]:
	- ZL3073X_I2C [=y] && I2C [=y]
	Selected by [y]:
	- ZL3073X_SPI [=y] && SPI [=y]

Fix this by adding the missing dependencies to ZL3073X_I2C and
ZL3073X_SPI.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508022110.nTqZ5Ylu-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202508022351.NHIxPF8j-lkp@intel.com/
Fixes: a4f0866e3dbbf3fe ("dpll: Make ZL3073X invisible")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dpll/zl3073x/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfig
index 9915f7423dea370c..5bbca14005813134 100644
--- a/drivers/dpll/zl3073x/Kconfig
+++ b/drivers/dpll/zl3073x/Kconfig
@@ -16,7 +16,7 @@ config ZL3073X
 
 config ZL3073X_I2C
 	tristate "I2C bus implementation for Microchip Azurite devices"
-	depends on I2C
+	depends on I2C && NET
 	select REGMAP_I2C
 	select ZL3073X
 	help
@@ -28,7 +28,7 @@ config ZL3073X_I2C
 
 config ZL3073X_SPI
 	tristate "SPI bus implementation for Microchip Azurite devices"
-	depends on SPI
+	depends on NET && SPI
 	select REGMAP_SPI
 	select ZL3073X
 	help
-- 
2.43.0


