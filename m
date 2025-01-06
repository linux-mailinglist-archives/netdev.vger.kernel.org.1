Return-Path: <netdev+bounces-155381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F80A020CC
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6887B1885BB5
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75671DB924;
	Mon,  6 Jan 2025 08:33:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C91BC58
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152406; cv=none; b=sbhE1FmJsPWMTBUHULFWo3wjQU7999aywnuN8KnAFOWzpWY8BOWRiKopNaaygq+gtG2L3gMXXbAI7u3JSYr5N84mxJ/mYCj/1587XpGcgVUDKL3NLQUq40Sfv/rj+q6Wirn6NJy9ynDwGg2cIhc1ObkY1MlPrM3XfOonZyPHJBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152406; c=relaxed/simple;
	bh=njLUNVG87o9EtiZ+NhMDK8cl3t/mwBSSfynfcR8M9u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GqITue95gi+S1slvhN/QNPuHG6PCU6lEMw7BU+VseFAGLWkg5pKqBxs+waDwzXiqoQQ/YNMzATTtxIoeBLj5fYAKljuzPWkIkOzT0PFcyeQnlbOUh4zvqts3aSwSVWvAzSeGUi/H43AAC5L5HIy8PV9sovNJELmwSckxhfVpYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tUiXr-0003U2-8g; Mon, 06 Jan 2025 09:33:07 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tUiXm-0078Kp-0s;
	Mon, 06 Jan 2025 09:33:03 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tUiXm-004MXK-30;
	Mon, 06 Jan 2025 09:33:02 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v5 6/8] ethtool: add helper to prevent invalid statistics exposure to userspace
Date: Mon,  6 Jan 2025 09:32:59 +0100
Message-Id: <20250106083301.1039850-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106083301.1039850-1-o.rempel@pengutronix.de>
References: <20250106083301.1039850-1-o.rempel@pengutronix.de>
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

Introduce a new helper function, `ethtool_stat_add`, to update 64-bit
statistics with proper handling of the reserved value
`ETHTOOL_STAT_NOT_SET`. This ensures that statistics remain valid and
are always reported to userspace, even if the driver accidentally sets
`ETHTOOL_STAT_NOT_SET` during an update.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
changes v2:
- add "Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>"
---
 include/linux/ethtool.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 4bf70cfec826..c0d3e3f62faf 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -371,6 +371,22 @@ static inline void ethtool_stats_init(u64 *stats, unsigned int n)
 		stats[n] = ETHTOOL_STAT_NOT_SET;
 }
 
+/**
+ * ethtool_stat_add - Add a value to a u64 statistic with wraparound handling
+ * @stat: Pointer to the statistic to update
+ * @value: Value to add to the statistic
+ *
+ * Adds the specified value to a u64 statistic. If the result of the addition
+ * equals the reserved value (`ETHTOOL_STAT_NOT_SET`), it increments the result
+ * by 1 to avoid the reserved value.
+ */
+static inline void ethtool_stat_add(u64 *stat, u64 value)
+{
+	*stat += value;
+	if (*stat == ETHTOOL_STAT_NOT_SET)
+		(*stat)++;
+}
+
 /* Basic IEEE 802.3 MAC statistics (30.3.1.1.*), not otherwise exposed
  * via a more targeted API.
  */
-- 
2.39.5


