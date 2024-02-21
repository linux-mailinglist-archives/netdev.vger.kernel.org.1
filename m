Return-Path: <netdev+bounces-73742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F47485E100
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C251F23AD7
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0099E8172D;
	Wed, 21 Feb 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="ikvTe2Uf"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041A3811FB
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529082; cv=none; b=Rn03xJPYBu88IFyfK4C6y5AVcQVOJj8wY5OHx+BlVCGjNXWJEiEZi1Icu0xiOFlFzY49VbIdO0KelV6PIdXXW7HQ/u2UYP2kbloJk5YlSsOKGPfhcqVjvWd05iZJzWLL4LHyTvWSf8uwulJICfpamBVF8h5IGj9RRpXJD/mmtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529082; c=relaxed/simple;
	bh=dzsevf/+CdP8M3qdgApf3jNT7O7kKB5a/8VoJ2OT+50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZayFO7tZKmR3c21dMMaUxb/0JIrv4/frKffqjnVQ/ztgrW6vKjzaV2NfLqh47A0PAglknuIjXrjFttwlO1D0A/ZuOytEC4hjPahhpUcgoJpNG3Utc5VxTMX5rdaOxDCsVC6nqIrvbtc57aUVMkLFtYFKQcDRzBUs46eWatI+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=ikvTe2Uf; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202402211524327b77766109fe0dbd97
        for <netdev@vger.kernel.org>;
        Wed, 21 Feb 2024 16:24:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ejzWMYY30WdJgyz3tcmDkJ2YklCBWqJN9zZnZI3iYyk=;
 b=ikvTe2UfEQ0FaHmOYRhe/jw2CNATKijeT8+bvXkC7/rJbPWbGUELvXSItHR3x1p5ipxyz4
 c8zD/KvCKGWmzrU5cUaHVGycrSkWiOxeo0tz3RpEGsb3JPIqdtEnYly9kNhF8H27H8P08Z2m
 MTz+4W0OEENQXiju8/aTrEYadhGas=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	jan.kiszka@siemens.com
Subject: [PATCH net-next v3 06/10] net: ti: icssg-prueth: Adjust IPG configuration for SR1.0
Date: Wed, 21 Feb 2024 15:24:12 +0000
Message-ID: <20240221152421.112324-7-diogo.ivo@siemens.com>
In-Reply-To: <20240221152421.112324-1-diogo.ivo@siemens.com>
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Correctly adjust the IPG based on the Silicon Revision.

Based on the work of Roger Quadros, Vignesh Raghavendra
and Grygorii Strashko in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icssg_config.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 99de8a40ed60..15f2235bf90f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -20,6 +20,8 @@
 /* IPG is in core_clk cycles */
 #define MII_RT_TX_IPG_100M	0x17
 #define MII_RT_TX_IPG_1G	0xb
+#define MII_RT_TX_IPG_100M_SR1	0x166
+#define MII_RT_TX_IPG_1G_SR1	0x1a
 
 #define	ICSSG_QUEUES_MAX		64
 #define	ICSSG_QUEUE_OFFSET		0xd00
@@ -202,23 +204,29 @@ void icssg_config_ipg(struct prueth_emac *emac)
 {
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
+	u32 ipg;
 
 	switch (emac->speed) {
 	case SPEED_1000:
-		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_1G);
+		ipg = emac->is_sr1 ? MII_RT_TX_IPG_1G_SR1 : MII_RT_TX_IPG_1G;
 		break;
 	case SPEED_100:
-		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
+		ipg = emac->is_sr1 ? MII_RT_TX_IPG_100M_SR1 : MII_RT_TX_IPG_100M;
 		break;
 	case SPEED_10:
+		/* Firmware hardcodes IPG for SR1.0 */
+		if (emac->is_sr1)
+			return;
 		/* IPG for 10M is same as 100M */
-		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
+		ipg = MII_RT_TX_IPG_100M;
 		break;
 	default:
 		/* Other links speeds not supported */
 		netdev_err(emac->ndev, "Unsupported link speed\n");
 		return;
 	}
+
+	icssg_mii_update_ipg(prueth->mii_rt, slice, ipg);
 }
 
 static void emac_r30_cmd_init(struct prueth_emac *emac)
-- 
2.43.2


