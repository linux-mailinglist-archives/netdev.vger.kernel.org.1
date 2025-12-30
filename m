Return-Path: <netdev+bounces-246363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 697FFCE9DE1
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BBBA30039C3
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CDF221271;
	Tue, 30 Dec 2025 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="iWLh48L3"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF525B30D;
	Tue, 30 Dec 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103571; cv=none; b=qSOcsT13c7gHZnKbYLR8o+XsqmiV82eiogJqNJE9yf74qmAaT4WaAyLqHQuStIlZNj4wwHTaRJIr49kUZJDLu/30763nDkdzdvLAl6sNrWoHjYZnvuHTl8tiVodvp+HdfBwrSBpH5V8sGpsPbStmavPWp/+dK6OtgWWj3nR4Gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103571; c=relaxed/simple;
	bh=R6cTzJIr65IqeWxrnssVx7DeLH3WDuC8YTWf64fOzQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hHxUjFiyQho+dW5GcFD4nITaZOSXby4h7pJP/0wrVZmZBX4WRHwxUhXyEd9V/0wCt3GQGO8PF/80I0rMDozgdLH1ECmiJ+q0i/hcbHG/BQWG6h4R1xXa1FBuAInjPvs/upTPcUsT6z6HivmzKVUDfeTXCMpgv4EhVVU+d5SRvac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=iWLh48L3; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AbV86VKicUS9//iTdeImRvdKhU2mPJAy0Der0dsHoTA=;
  b=iWLh48L3popN33eiPWyexJoY3eO9vex7t18Gz7EA09y1F0eqPQWLiVZe
   y5FGzCP1lCU6oNZpy3TxBcWQDtnAtl4wL7i411YFbehelWDXR36k1LIyc
   ndxFUzybFB1TzHSxTJP6kf1o+B2EIt/Y3dRf5cvyg0mXC/a8hv92qplz/
   Y=;
X-CSE-ConnectionGUID: 9BZ1V8NeQqierSOzCQU7Fw==
X-CSE-MsgGUID: Hyu3A/waSgOi6u4ADRBthw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,189,1763420400"; 
   d="scan'208";a="256347549"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 15:06:05 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Daniel Golle <daniel@makrotopia.org>
Cc: yunbolyu@smu.edu.sg,
	kexinsun@smail.nju.edu.cn,
	ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: adjust function name reference
Date: Tue, 30 Dec 2025 15:06:01 +0100
Message-Id: <20251230140601.93474-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no function clk_bulk_prepare_disable.  Refer instead to
clk_bulk_disable_unprepare, which is called in the function
defined just below.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/phy/mediatek/phy-mtk-xfi-tphy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-xfi-tphy.c b/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
index 1a0b7484f525..100a50d0e861 100644
--- a/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
@@ -353,7 +353,7 @@ static int mtk_xfi_tphy_power_on(struct phy *phy)
  * Disable and unprepare all clocks previously enabled.
  *
  * Return:
- * See clk_bulk_prepare_disable().
+ * See clk_bulk_disable_unprepare().
  */
 static int mtk_xfi_tphy_power_off(struct phy *phy)
 {


