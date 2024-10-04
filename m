Return-Path: <netdev+bounces-132047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116239903F2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA1EB20A86
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52E621732A;
	Fri,  4 Oct 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0WWyqB4g"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBE2139C6;
	Fri,  4 Oct 2024 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048039; cv=none; b=LMqb/0R78dzXqp3WRAbY4xnpR3dzvzzBlbJ+3JZZff/2maiTPspxpjrL200ThkS3OLmkrwrwtLVaL1jTaIxTdk0pNQZQxsxfbYarZ6B5swQrvdlzhQuOFFc/sequgLHERn0QSRCzCiS8vvK79nXRePvdXSJr1ftrfqHgwi4w5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048039; c=relaxed/simple;
	bh=KmyIuWKSCAIec9Kz7ykRLXXXQBHQhKcUie7XEf3f4pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cGnx250dSzNXYWZst0V29l3je8+3la5AiW6QLKhIgmOHtOxaREeJtURc1NWTHmz2+ceSDhoEaY9RV+2L9V07gz9HWiTPmIObf/aWUCaLaF8Ey3fDGZbSj+/UaLydC7/QNshaw2YKDUQ5wKR4NedRv2khtTKJgQxnducYKXH4Ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0WWyqB4g; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048038; x=1759584038;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KmyIuWKSCAIec9Kz7ykRLXXXQBHQhKcUie7XEf3f4pk=;
  b=0WWyqB4g1ipaEin8DyRtysUuMEe6YGD4qZ1Sf6iK0yvz3nrl0+uYfewh
   sP4AkUgEN7OR6BpxqJdKNb3WRQiPMEfBXVadbXf6HCh60W0jrnO5kSh0s
   373ltSoyp7dMn8aE1fYYxx7FJiNoLTyxVMkvk64K5jErQG+YP+Ybhgccd
   O8WAhkXC+vwiVHRcUjgF+5jMcWIkK33mmQnW7eVdRC7Eo5GNRHzd7dUL6
   3w1PpxmCScHrufqfAbN3MJXxhMyi/0itL+0EYVaLu9A9/H319uLEMfNih
   3SPf83tyjiU3GpM3WzBEdfMC9OZ5ocyoEh2ORb5SPw08FiDxgjz1MW/Ch
   Q==;
X-CSE-ConnectionGUID: Ejn4MYkwTnyyTXQz7FKjZw==
X-CSE-MsgGUID: xohJ5q78TD+fHwYQQKhIcQ==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="35903137"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:27 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:24 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:33 +0200
Subject: [PATCH net-next v2 07/15] net: sparx5: use SPX5_CONST for
 constants which do not have a symbol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-7-d3290f581663@microchip.com>
References: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
In-Reply-To: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>, <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

Now that we have indentified all the chip constants, update the use of
them where a symbol is not defined for the constant.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 1fa98158b0a8..6c50d7875207 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -522,7 +522,7 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
 		 sparx5,
 		 LRN_AUTOAGE_CFG_1);
 
-	for (idx = 0; idx < 3; idx++)
+	for (idx = 0; idx < sparx5->data->consts->n_sio_clks; idx++)
 		spx5_rmw(GCB_SIO_CLOCK_SYS_CLK_PERIOD_SET(clk_period / 100),
 			 GCB_SIO_CLOCK_SYS_CLK_PERIOD,
 			 sparx5,
@@ -550,16 +550,21 @@ static u32 qlim_wm(struct sparx5 *sparx5, int fraction)
 
 static int sparx5_qlim_set(struct sparx5 *sparx5)
 {
+	const struct sparx5_consts *consts = sparx5->data->consts;
 	u32 res, dp, prio;
 
 	for (res = 0; res < 2; res++) {
 		for (prio = 0; prio < 8; prio++)
 			spx5_wr(0xFFF, sparx5,
-				QRES_RES_CFG(prio + 630 + res * 1024));
+				QRES_RES_CFG(prio +
+					     consts->qres_max_prio_idx +
+					     res * 1024));
 
 		for (dp = 0; dp < 4; dp++)
 			spx5_wr(0xFFF, sparx5,
-				QRES_RES_CFG(dp + 638 + res * 1024));
+				QRES_RES_CFG(dp +
+					     consts->qres_max_colour_idx +
+					     res * 1024));
 	}
 
 	/* Set 80,90,95,100% of memory size for top watermarks */
@@ -605,7 +610,7 @@ static int sparx5_start(struct sparx5 *sparx5)
 	int err;
 
 	/* Setup own UPSIDs */
-	for (idx = 0; idx < 3; idx++) {
+	for (idx = 0; idx < consts->n_own_upsids; idx++) {
 		spx5_wr(idx, sparx5, ANA_AC_OWN_UPSID(idx));
 		spx5_wr(idx, sparx5, ANA_CL_OWN_UPSID(idx));
 		spx5_wr(idx, sparx5, ANA_L2_OWN_UPSID(idx));

-- 
2.34.1


