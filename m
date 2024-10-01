Return-Path: <netdev+bounces-130903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C7298BE98
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C589B1C23C53
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1091CB500;
	Tue,  1 Oct 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A1dJKqYX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E21C9EBC;
	Tue,  1 Oct 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790719; cv=none; b=X7jC43XK9ttKblcjKMEti5FDcUpptv2WlrVCQCvljRUkP0yCeOichCbkBqYBgk1+IP/HTWTrs0xt0fgFJuf4n7MeCG3fqq+ebme4JFXpq/N/k2rN0gD2bUhcvtbl/1EvMFC+ZHV6pV7utUlrpus62sXNOuRl/P4R6RVkg5jUsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790719; c=relaxed/simple;
	bh=cS1/Jb4bAW3LR0cuIrZX464ZGlD8jNzAc34k6vz3YWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=vBxIhmcoVGLa4CnmheIQc0UN95e/x3VQiardJh2G91kT6nWWoXgmKyC0Thk2lH/GqBYOaoClCHEWge0/D+uAaHS3mRKejf5IYjX0rbjPPx3apbF9SqlUXMKrrBrJFv8hBnG7S13pD8eMMFWY+7zhRoBQpGpSsZtMWmOBxk9zIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A1dJKqYX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790717; x=1759326717;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cS1/Jb4bAW3LR0cuIrZX464ZGlD8jNzAc34k6vz3YWM=;
  b=A1dJKqYX40euUW3aduWQI21A478kRSghLPS0TLjI/HeE4vefVXiHYUbO
   JGZCuO72FVAjLI5SJ0KpLszatVJ3GOMIYqmVB02CNNc1nL+Q+FhSo8gfQ
   2r4FvoXoKw/4Ctcu6xR5dump2BZ+k+ZkotgRdhSfTVEgbF5cdd2GG7RXX
   gGBnGpSejkCnvVzbaKxxhPMV4iTsxOqDsnnoywOH5cHatpYFg2a5RzLpD
   4gFJiHu52qTZbRBRI+9XwWmSo6RPL41ZTaLBGdZ8mK/RnDxtFdPPOVFh4
   sFiCsYm/PXTa5rIKbVIj8/pLCrMGPX4p7ZY/apKndqA6ruUCq1LQ1aKcw
   Q==;
X-CSE-ConnectionGUID: Cvj7zfnKQLmxTbAcCPAKFQ==
X-CSE-MsgGUID: RvII0DCaSLiALB5MIKUZjg==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="32447685"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:25 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:23 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:38 +0200
Subject: [PATCH net-next 08/15] net: sparx5: use SPX5_CONST for constants
 which do not have a symbol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-8-8c6896fdce66@microchip.com>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

Now that we have indentified all the chip constants, update the use of
them where a symbol is not defined for the constant.

Constants are accessed using the SPX5_CONSTS macro. Note that this macro
might hide the use of the *sparx5 context pointer. In such case, a
comment is added.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 063f02fd36c3..4b3e6986af55 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -524,7 +524,7 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
 		 sparx5,
 		 LRN_AUTOAGE_CFG_1);
 
-	for (idx = 0; idx < 3; idx++)
+	for (idx = 0; idx < SPX5_CONST(n_sio_clks); idx++)
 		spx5_rmw(GCB_SIO_CLOCK_SYS_CLK_PERIOD_SET(clk_period / 100),
 			 GCB_SIO_CLOCK_SYS_CLK_PERIOD,
 			 sparx5,
@@ -551,11 +551,15 @@ static int sparx5_qlim_set(struct sparx5 *sparx5)
 	for (res = 0; res < 2; res++) {
 		for (prio = 0; prio < 8; prio++)
 			spx5_wr(0xFFF, sparx5,
-				QRES_RES_CFG(prio + 630 + res * 1024));
+				QRES_RES_CFG(prio +
+					     SPX5_CONST(qres_max_prio_idx) +
+					     res * 1024));
 
 		for (dp = 0; dp < 4; dp++)
 			spx5_wr(0xFFF, sparx5,
-				QRES_RES_CFG(dp + 638 + res * 1024));
+				QRES_RES_CFG(dp +
+					     SPX5_CONST(qres_max_colour_idx) +
+					     res * 1024));
 	}
 
 	/* Set 80,90,95,100% of memory size for top watermarks */
@@ -600,7 +604,7 @@ static int sparx5_start(struct sparx5 *sparx5)
 	int err;
 
 	/* Setup own UPSIDs */
-	for (idx = 0; idx < 3; idx++) {
+	for (idx = 0; idx < SPX5_CONST(n_own_upsids); idx++) {
 		spx5_wr(idx, sparx5, ANA_AC_OWN_UPSID(idx));
 		spx5_wr(idx, sparx5, ANA_CL_OWN_UPSID(idx));
 		spx5_wr(idx, sparx5, ANA_L2_OWN_UPSID(idx));

-- 
2.34.1


