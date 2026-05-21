Return-Path: <netdev+bounces-290388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pqQIFbf4DmpKDwYAu9opvQ
	(envelope-from <netdev+bounces-290388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:21:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF0E5A4B2B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A91C30788FF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4347F3D7D66;
	Thu, 21 May 2026 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H6R7mMI1"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166483CF687
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365490; cv=none; b=r6uouoASc/xRIIgRK7wjgjMqoOYhdXVrNm9s5RKH77A5TV2QhVlr9CORYYwcMhKSV5I3vQaR+cSGwEGqN4EyHiWMoWPlx3cSF1An/6imrjvuK3pvkWAlPnC2gFfrWVMfPdUVRQO9T8GZ72B4WCbxVO7uRaQ02mfDFaLMyf4bJjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365490; c=relaxed/simple;
	bh=Ryh3pNiRaDGNUG+aq5aomoSP3wBvJiv7DF5w5ZHEYLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEQ2ZxPr4BJFbSlmSKmHlpRuYOQzpqyUGo3CABcGhWt74E+gV0NSN53Rnam6IfObzSJ/RRmkVy36PqEw9MH9l9HRfoXRO7L5lVq9D1asV37ZE9ZEsiQg4ESFxmGYIRlFH9MAnRzeKbd/maM2oFZFWFGFK0pJU+85LISiQb6795U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H6R7mMI1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C139D4E42D0F;
	Thu, 21 May 2026 12:11:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9695F60495;
	Thu, 21 May 2026 12:11:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E4F2107E8B5A;
	Thu, 21 May 2026 14:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779365485; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=FGwSSkN/7kImuL1TsHpYTUZUmks+9te8dr17WUxceZI=;
	b=H6R7mMI1i1+s0M5NaVVu0DjmaMdqOCm+BcVzENj+SGK26mRoXvtVGauVY1sLaUgXYYPj8B
	8wvFvtQ02MTYSFqXzS4DdVetTjeeKZTtH/7dWL3+0gatQwgfaPPgfVdCYTDa2o6SX07ZGT
	oyDlZ9veZy6lgxC7sbl07+JNivwkVHWAp2wWxSh/djUuY986Ru1izXrtId8mheoeSXXljA
	RL4PCyw5nZeOEQ6Icrj5g3OIrQ8HPf8KG39HREQjbNGFz7wKpg0cAyjwcqT3EAPfoI/i2H
	EvBJjPNoEhZhqZpz56o7Rs+89HfR0NZ5Ssw+babFKRgYf8WrMqWh4m/egH4aMg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: [PATCH net-next v11 08/10] netlink: specs: Add ethernet port listing with ethtool
Date: Thu, 21 May 2026 14:10:36 +0200
Message-ID: <20260521121040.1199622-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
References: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-290388-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4EF0E5A4B2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ethernet network interfaces may have more than one front-facing port.
The phy_port infrastructure was introduced to keep track of
these ports, and allow userspace to know about the presence and
capability of these ports. Add a ethnl netlink message to report this
information.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml      | 50 +++++++++++++++++++
 Documentation/networking/ethtool-netlink.rst  | 34 +++++++++++++
 .../uapi/linux/ethtool_netlink_generated.h    | 19 +++++++
 3 files changed, 103 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5dd4d1b5d94b..d1151af335ca 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -210,6 +210,10 @@ definitions:
       -
         name: discard
         value: 31
+  -
+    name: port-type
+    type: enum
+    entries: [mdi, sfp]
 
 attribute-sets:
   -
@@ -1905,6 +1909,32 @@ attribute-sets:
         name: link
         type: nest
         nested-attributes: mse-snapshot
+  -
+    name: port
+    attr-cnt-name: --ethtool-a-port-cnt
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: id
+        type: u32
+      -
+        name: supported-modes
+        type: nest
+        nested-attributes: bitset
+      -
+        name: supported-interfaces
+        type: nest
+        nested-attributes: bitset
+      -
+        name: type
+        type: u32
+        enum: port-type
+      -
+        name: upstream-port
+        type: u32
 
 operations:
   enum-model: directional
@@ -2859,6 +2889,26 @@ operations:
             - worst-channel
             - link
       dump: *mse-get-op
+    -
+      name: port-get
+      doc: Get ports attached to an interface
+
+      attribute-set: port
+
+      do: &port-get-op
+        request:
+          attributes:
+            - header
+            - id
+        reply:
+          attributes:
+            - header
+            - id
+            - supported-modes
+            - supported-interfaces
+            - type
+            - upstream-port
+      dump: *port-get-op
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index e92abf45faf5..bb02042bc9fd 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -2537,6 +2537,39 @@ Within each channel nest, only the metrics supported by the PHY will be present.
 See ``struct phy_mse_snapshot`` kernel documentation in
 ``include/linux/phy.h``.
 
+PORT_GET
+========
+
+Retrieve information about the physical connection points of a network device,
+referred to as "ports". User needs to specify a PORT_ID for the DO operation,
+in which case the DO request returns information about that specific port.
+
+As there can be more than one port, the DUMP operation can be used to list the
+ports present on a given interface, by passing an interface index or name in
+the dump request.
+
+Request contents:
+
+  ===================================== ======  ===============================
+  ``ETHTOOL_A_PORT_HEADER``             nested  request header
+  ``ETHTOOL_A_PORT_ID``                 u32     port id
+  ===================================== ======  ===============================
+
+Kernel response contents:
+
+  ======================================= ======  =============================
+  ``ETHTOOL_A_PORT_HEADER``               nested  request header
+  ``ETHTOOL_A_PORT_ID``                   u32     the port's unique identifier,
+                                                  per netdevice.
+  ``ETHTOOL_A_PORT_SUPPORTED_MODES``      bitset  bitset of supported linkmodes
+  ``ETHTOOL_A_PORT_SUPPORTED_INTERFACES`` bitset  bitset of supported MII
+                                                  interfaces
+  ``ETHTOOL_A_PORT_TYPE``                 u32     the port type
+  ``ETHTOOL_A_PORT_UPSTREAM_PORT``        u32     If any, the index of the MII
+                                                  port that feeds into the this
+                                                  port.
+  ======================================= ======  =============================
+
 Request translation
 ===================
 
@@ -2647,4 +2680,5 @@ are netlink only.
   n/a                                 ``ETHTOOL_MSG_PHY_GET``
   ``SIOCGHWTSTAMP``                   ``ETHTOOL_MSG_TSCONFIG_GET``
   ``SIOCSHWTSTAMP``                   ``ETHTOOL_MSG_TSCONFIG_SET``
+  n/a                                 ``ETHTOOL_MSG_PORT_GET``
   =================================== =====================================
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 8134baf7860f..f9d8794eabc1 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -78,6 +78,11 @@ enum ethtool_pse_event {
 	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
 };
 
+enum ethtool_port_type {
+	ETHTOOL_PORT_TYPE_MDI,
+	ETHTOOL_PORT_TYPE_SFP,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
@@ -840,6 +845,18 @@ enum {
 	ETHTOOL_A_MSE_MAX = (__ETHTOOL_A_MSE_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PORT_HEADER = 1,
+	ETHTOOL_A_PORT_ID,
+	ETHTOOL_A_PORT_SUPPORTED_MODES,
+	ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
+	ETHTOOL_A_PORT_TYPE,
+	ETHTOOL_A_PORT_UPSTREAM_PORT,
+
+	__ETHTOOL_A_PORT_CNT,
+	ETHTOOL_A_PORT_MAX = (__ETHTOOL_A_PORT_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -893,6 +910,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
+	ETHTOOL_MSG_PORT_GET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -954,6 +972,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
 	ETHTOOL_MSG_MSE_GET_REPLY,
+	ETHTOOL_MSG_PORT_GET_REPLY,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
-- 
2.54.0


