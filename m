Return-Path: <netdev+bounces-120136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D369586E8
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5D11F21CE9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA319004D;
	Tue, 20 Aug 2024 12:29:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920418FC9F
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156969; cv=none; b=p34dNhs1W5gHMoD2cvWmBhY+odskjsKoLUrATMP7BBCW1I6m+TFnLXhX6RWx6ge50oFJi8f8RS79VIU5QPX0CO7TY1Wn0qbhgIAvp9ztbrHg/GmQ9uONy1WMWS7gqJrUrG/rLj0+QMZZM+gOvpKEpkh9gxtfq7z0OajCNCUHPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156969; c=relaxed/simple;
	bh=8TXXf/eTQLgJZWnSCki17NimkK7a7tjGOH+1WMtspB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F02vxhVINutAk/HOWQFVcyDHi62CvkmeilpXR3wZSZTclnBYSLV3tpORX8C70uYSYcvGVbQtpVMJF2HkDGPjSyk0mAsD2QaaYfnbAXHehGWucVocPq8dWA7DfwDPu3XORBvNjq12fVfbuvBS6JTKvUgs7xvlclWWX1dy4Vcu0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sgNzA-0004My-7x; Tue, 20 Aug 2024 14:29:16 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sgNz8-001lnS-Sw; Tue, 20 Aug 2024 14:29:14 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sgNz8-008Dbm-2e;
	Tue, 20 Aug 2024 14:29:14 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/3] phy: open_alliance_helpers: Add defines for link quality metrics
Date: Tue, 20 Aug 2024 14:29:12 +0200
Message-Id: <20240820122914.1958664-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240820122914.1958664-1-o.rempel@pengutronix.de>
References: <20240820122914.1958664-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Introduce a set of defines for link quality (LQ) related metrics in the
Open Alliance helpers. These metrics include:

- `oa_lq_lfl_esd_event_count`: Number of ESD events detected by the Link
  Failures and Losses (LFL).
- `oa_lq_link_training_time`: Time required to establish a link.
- `oa_lq_remote_receiver_time`: Time required until the remote receiver
  signals that it is locked.
- `oa_lq_local_receiver_time`: Time required until the local receiver is
  locked.
- `oa_lq_lfl_link_loss_count`: Number of link losses.
- `oa_lq_lfl_link_failure_count`: Number of link failures that do not
  cause a link loss.

These standardized defines will be used by PHY drivers to report these
statistics.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/open_alliance_helpers.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/open_alliance_helpers.h b/drivers/net/phy/open_alliance_helpers.h
index 8b7d97bc6f186..f8b392671e20d 100644
--- a/drivers/net/phy/open_alliance_helpers.h
+++ b/drivers/net/phy/open_alliance_helpers.h
@@ -3,6 +3,20 @@
 #ifndef OPEN_ALLIANCE_HELPERS_H
 #define OPEN_ALLIANCE_HELPERS_H
 
+/* Link quality (LQ) related metrics */
+/* The number of ESD events detected by the Link Failures and Losses (LFL) */
+#define OA_LQ_LFL_ESD_EVENT_COUNT		"oa_lq_lfl_esd_event_count"
+/* Time required to establish a link */
+#define OA_LQ_LINK_TRAINING_TIME		"oa_lq_link_training_time"
+/* Time required until the remote receiver is signaling that it is locked */
+#define OA_LQ_REMOTE_RECEIVER_TIME		"oa_lq_remote_receiver_time"
+/* Time required until the local receiver is locked */
+#define OA_LQ_LOCAL_RECEIVER_TIME		"oa_lq_local_receiver_time"
+/* Number of link losses */
+#define OA_LQ_LFL_LINK_LOSS_COUNT		"oa_lq_lfl_link_loss_count"
+/* Number of link failures causing NOT a link loss */
+#define OA_LQ_LFL_LINK_FAILURE_COUNT		"oa_lq_lfl_link_failure_count"
+
 /*
  * These defines reflect the TDR (Time Delay Reflection) diagnostic feature
  * for 1000BASE-T1 automotive Ethernet PHYs as specified by the OPEN Alliance.
-- 
2.39.2


