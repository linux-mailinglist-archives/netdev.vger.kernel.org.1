Return-Path: <netdev+bounces-120086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363839583D4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671FAB21C4C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E16118E025;
	Tue, 20 Aug 2024 10:13:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422FB18CBE9
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148793; cv=none; b=NoKlbqeyoyU36ULcoK14mNCek/OaBej5ULQR8vvg7HyjpE7GUxs9b0O1nHzEbfcpsL/67uTKyc2gBLQxETAXBGqoiMAVYUBNlYNBmv8WgBuWunaV7HCwJOIqw3hrg8MX4iyIm45i0FSDAJvCaA3GA6B4g1xp8c9vdqt4VeIoKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148793; c=relaxed/simple;
	bh=oV/jIdqp/DXdYa0dv1FWGCSk28K+vEjzmiWwafeZUl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUxpHwnHMx3xUucJ0hffHHtw/m5I0wi9z8Dx9vyAcjAii7yeHjebtzuezR1YFxZ7fWtUWhsuV880HpYeMqVurbpSgwdbEJ/Q9E+YbNbUPhxQ8Q2e8A58a6ESzWcOjs+Tm31H8C8W4MJqLjVQoIO2/kGsdCCnlOaq+FhxTtdot2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sgLrG-0000go-W4; Tue, 20 Aug 2024 12:12:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sgLrG-001kNf-Hn; Tue, 20 Aug 2024 12:12:58 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sgLrG-006JuP-1X;
	Tue, 20 Aug 2024 12:12:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v2 1/3] ethtool: Extend cable testing interface with result source information
Date: Tue, 20 Aug 2024 12:12:54 +0200
Message-Id: <20240820101256.1506460-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240820101256.1506460-1-o.rempel@pengutronix.de>
References: <20240820101256.1506460-1-o.rempel@pengutronix.de>
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

Extend the ethtool netlink cable testing interface by adding support for
specifying the source of cable testing results. This allows users to
differentiate between results obtained through different diagnostic
methods.

For example, some TI 10BaseT1L PHYs provide two variants of cable
diagnostics: Time Domain Reflectometry (TDR) and Active Link Cable
Diagnostic (ALCD). By introducing `ETHTOOL_A_CABLE_RESULT_SRC` and
`ETHTOOL_A_CABLE_FAULT_LENGTH_SRC` attributes, this update enables
drivers to indicate whether the result was derived from TDR or ALCD,
improving the clarity and utility of diagnostic information.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- update Documentation/netlink/specs/ethtool.yaml
- use u8 instead of u32 for _src
- update comments
---
 Documentation/netlink/specs/ethtool.yaml     |  6 ++++++
 Documentation/networking/ethtool-netlink.rst |  5 +++++
 include/uapi/linux/ethtool_netlink.h         | 11 +++++++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 1bbeaba5c6442..af999ccd0adf8 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -659,6 +659,9 @@ attribute-sets:
       -
         name: code
         type: u8
+      -
+        name: src
+        type: u8
   -
     name: cable-fault-length
     attributes:
@@ -668,6 +671,9 @@ attribute-sets:
       -
         name: cm
         type: u32
+      -
+        name: src
+        type: u8
   -
     name: cable-nest
     attributes:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 3f6c6880e7c48..295e75619abdf 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1307,12 +1307,17 @@ information.
  +-+-+-----------------------------------------+--------+---------------------+
  | | | ``ETHTOOL_A_CABLE_RESULTS_CODE``        | u8     | result code         |
  +-+-+-----------------------------------------+--------+---------------------+
+ | | | ``ETHTOOL_A_CABLE_RESULT_SRC``          | u8     | information source  |
+ +-+-+-----------------------------------------+--------+---------------------+
  | | ``ETHTOOL_A_CABLE_NEST_FAULT_LENGTH``     | nested | cable length        |
  +-+-+-----------------------------------------+--------+---------------------+
  | | | ``ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR``   | u8     | pair number         |
  +-+-+-----------------------------------------+--------+---------------------+
  | | | ``ETHTOOL_A_CABLE_FAULT_LENGTH_CM``     | u32    | length in cm        |
  +-+-+-----------------------------------------+--------+---------------------+
+ | | | ``ETHTOOL_A_CABLE_FAULT_LENGTH_SRC``    | u8     | information source  |
+ +-+-+-----------------------------------------+--------+---------------------+
+
 
 CABLE_TEST TDR
 ==============
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 9074fa309bd6d..445e2d434686f 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -569,10 +569,20 @@ enum {
 	ETHTOOL_A_CABLE_PAIR_D,
 };
 
+/* Information source for specific results. */
+enum {
+	ETHTOOL_A_CABLE_INF_SRC_UNSPEC,
+	/* Results provided by the Time Domain Reflectometry (TDR) */
+	ETHTOOL_A_CABLE_INF_SRC_TDR,
+	/* Results provided by the Active Link Cable Diagnostic (ALCD) */
+	ETHTOOL_A_CABLE_INF_SRC_ALCD,
+};
+
 enum {
 	ETHTOOL_A_CABLE_RESULT_UNSPEC,
 	ETHTOOL_A_CABLE_RESULT_PAIR,		/* u8 ETHTOOL_A_CABLE_PAIR_ */
 	ETHTOOL_A_CABLE_RESULT_CODE,		/* u8 ETHTOOL_A_CABLE_RESULT_CODE_ */
+	ETHTOOL_A_CABLE_RESULT_SRC,		/* u8 ETHTOOL_A_CABLE_INF_SRC_ */
 
 	__ETHTOOL_A_CABLE_RESULT_CNT,
 	ETHTOOL_A_CABLE_RESULT_MAX = (__ETHTOOL_A_CABLE_RESULT_CNT - 1)
@@ -582,6 +592,7 @@ enum {
 	ETHTOOL_A_CABLE_FAULT_LENGTH_UNSPEC,
 	ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR,	/* u8 ETHTOOL_A_CABLE_PAIR_ */
 	ETHTOOL_A_CABLE_FAULT_LENGTH_CM,	/* u32 */
+	ETHTOOL_A_CABLE_FAULT_LENGTH_SRC,	/* u8 ETHTOOL_A_CABLE_INF_SRC_ */
 
 	__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT,
 	ETHTOOL_A_CABLE_FAULT_LENGTH_MAX = (__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT - 1)
-- 
2.39.2


