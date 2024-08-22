Return-Path: <netdev+bounces-120959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF97895B4A3
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22831C230AC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0ED1C9DE6;
	Thu, 22 Aug 2024 12:07:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FA1C93DC
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328436; cv=none; b=WXIdgDYwmDFYOfs7TPs2J/xEUPl+HF9VyPmFc5MmzwSkciepZuSdIjLKohBpI1lYpJcmln6LD41Rkoz6JPXVl5COIyJwux3bVhMz0mB/HmW42nETMrXUaRHbT/zQ85kM3V6oKplKfdfWGKLh01jzPodPhrbgTmdgHf91wAyryIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328436; c=relaxed/simple;
	bh=0/kZ5kTdGoks6QrkmC3SqdsHYofk1DuEBDq2H7eYYFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWhkTNOp5i4N6ZxrpDMn8V6FBBUSIS5cjkC2/e7m+70ZVMQYq8LJStYJFrvt7fn40AyasLFvBct3UokOyyOi3u6CB7sU4TErZBVU4k5xQig3nRu4mFqPwY1be8tn7hVyS2CoQgf2vNUdNly59KaSGeIIJnFdowwpZ7FdZ4Q5XKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6an-0008Cc-MB; Thu, 22 Aug 2024 14:07:05 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6an-002F7S-6w; Thu, 22 Aug 2024 14:07:05 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6an-005qQP-0S;
	Thu, 22 Aug 2024 14:07:05 +0200
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
Subject: [PATCH net-next v3 1/3] ethtool: Extend cable testing interface with result source information
Date: Thu, 22 Aug 2024 14:07:01 +0200
Message-Id: <20240822120703.1393130-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822120703.1393130-1-o.rempel@pengutronix.de>
References: <20240822120703.1393130-1-o.rempel@pengutronix.de>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
changes v3:
- use u32 instead of u8
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
index 1bbeaba5c6442..057f8916024a6 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -659,6 +659,9 @@ attribute-sets:
       -
         name: code
         type: u8
+      -
+        name: src
+        type: u32
   -
     name: cable-fault-length
     attributes:
@@ -668,6 +671,9 @@ attribute-sets:
       -
         name: cm
         type: u32
+      -
+        name: src
+        type: u32
   -
     name: cable-nest
     attributes:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 3f6c6880e7c48..5ca0b3661379a 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1307,12 +1307,17 @@ information.
  +-+-+-----------------------------------------+--------+---------------------+
  | | | ``ETHTOOL_A_CABLE_RESULTS_CODE``        | u8     | result code         |
  +-+-+-----------------------------------------+--------+---------------------+
+ | | | ``ETHTOOL_A_CABLE_RESULT_SRC``          | u32    | information source  |
+ +-+-+-----------------------------------------+--------+---------------------+
  | | ``ETHTOOL_A_CABLE_NEST_FAULT_LENGTH``     | nested | cable length        |
  +-+-+-----------------------------------------+--------+---------------------+
  | | | ``ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR``   | u8     | pair number         |
  +-+-+-----------------------------------------+--------+---------------------+
  | | | ``ETHTOOL_A_CABLE_FAULT_LENGTH_CM``     | u32    | length in cm        |
  +-+-+-----------------------------------------+--------+---------------------+
+ | | | ``ETHTOOL_A_CABLE_FAULT_LENGTH_SRC``    | u32    | information source  |
+ +-+-+-----------------------------------------+--------+---------------------+
+
 
 CABLE_TEST TDR
 ==============
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 9074fa309bd6d..810c8630bfbed 100644
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
+	ETHTOOL_A_CABLE_RESULT_SRC,		/* u32 ETHTOOL_A_CABLE_INF_SRC_ */
 
 	__ETHTOOL_A_CABLE_RESULT_CNT,
 	ETHTOOL_A_CABLE_RESULT_MAX = (__ETHTOOL_A_CABLE_RESULT_CNT - 1)
@@ -582,6 +592,7 @@ enum {
 	ETHTOOL_A_CABLE_FAULT_LENGTH_UNSPEC,
 	ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR,	/* u8 ETHTOOL_A_CABLE_PAIR_ */
 	ETHTOOL_A_CABLE_FAULT_LENGTH_CM,	/* u32 */
+	ETHTOOL_A_CABLE_FAULT_LENGTH_SRC,	/* u32 ETHTOOL_A_CABLE_INF_SRC_ */
 
 	__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT,
 	ETHTOOL_A_CABLE_FAULT_LENGTH_MAX = (__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT - 1)
-- 
2.39.2


