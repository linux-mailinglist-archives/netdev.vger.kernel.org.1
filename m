Return-Path: <netdev+bounces-298891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d9qJKHnJLGpoWQQAu9opvQ
	(envelope-from <netdev+bounces-298891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:07:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B5A67D956
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:07:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298891-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298891-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA4573085B90
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63343A16B8;
	Sat, 13 Jun 2026 03:07:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B23387377;
	Sat, 13 Jun 2026 03:07:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781320041; cv=none; b=CBQYqidTylf8ekylQxYqTpALR5ENJZEAAnCjiiMvJZ6j7xXV1jV470OTTh2DbUKbmFsKfOsQJ2Hk/YzL0tqxGqof/O5ioIaXSMnENQAu0kbbC2HJYVtp5enB3kYc5BdDJJcxvDDad1lRwqV6b7jL5I66dUvJ84qUWqSn34g4vI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781320041; c=relaxed/simple;
	bh=vso3F5H4lPE4Hgz++hnZABDyrAjbsTV5sAibi9/koYo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CD/z34D4j+BI+1GTsti76BIIARkddVjyhR4nHiFGbQvgHX4y267QemYm+5pBghC8ZlmBCTRnWZGQvSlmapB9aFfuGHKk/tEtTYoJt21mz4FzAVUPh+Ib70abhgWRvh1W1zv/puAt53BDlg+KjkSQIXTibIaQofUWm6r61Ov1uZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYEiH-000000007jS-2sx6;
	Sat, 13 Jun 2026 03:07:13 +0000
Date: Sat, 13 Jun 2026 04:07:11 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 1/4] net: dsa: mxl862xx: store firmware version
 for feature gating
Message-ID: <91a26a8ffeaa2ce1729f98347e93e779973976bb.1781319534.git.daniel@makrotopia.org>
References: <cover.1781319534.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781319534.git.daniel@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-298891-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17B5A67D956

Query the firmware version at init (already done in wait_ready),
cache it in priv->fw_version, and provide MXL862XX_FW_VER_MIN()
for version-gated code paths throughout the driver.

MXL862XX_FW_VER() packs major/minor/revision into a u32 with
bitwise shifts so that versions compare with natural ordering,
independent of host endianness.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v6: no changes
v5: no changes
v4: no changes
v3: use bitwise shifts in macro instead of endian-specific union
v2: no changes

 drivers/net/dsa/mxl862xx/mxl862xx.c |  3 +++
 drivers/net/dsa/mxl862xx/mxl862xx.h | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index b60482d93a85..2f22adedfbf6 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -257,6 +257,9 @@ static int mxl862xx_wait_ready(struct dsa_switch *ds)
 			 ver.iv_major, ver.iv_minor,
 			 le16_to_cpu(ver.iv_revision),
 			 le32_to_cpu(ver.iv_build_num));
+		priv->fw_version.major = ver.iv_major;
+		priv->fw_version.minor = ver.iv_minor;
+		priv->fw_version.revision = le16_to_cpu(ver.iv_revision);
 		return 0;
 
 not_ready_yet:
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 80053ab40e4c..e3db3711b245 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -3,6 +3,7 @@
 #ifndef __MXL862XX_H
 #define __MXL862XX_H
 
+#include <asm/byteorder.h>
 #include <linux/mdio.h>
 #include <linux/workqueue.h>
 #include <net/dsa.h>
@@ -241,6 +242,25 @@ struct mxl862xx_port {
 	spinlock_t stats_lock; /* protects stats accumulators */
 };
 
+/**
+ * struct mxl862xx_fw_version - firmware version for comparison and display
+ * @major: firmware major version
+ * @minor: firmware minor version
+ * @revision: firmware revision number
+ */
+struct mxl862xx_fw_version {
+	u8 major;
+	u8 minor;
+	u16 revision;
+};
+
+#define MXL862XX_FW_VER(maj, min, rev) \
+	(((u32)(maj) << 24) | ((u32)(min) << 16) | (rev))
+#define MXL862XX_FW_VER_MIN(priv, maj, min, rev) \
+	(MXL862XX_FW_VER((priv)->fw_version.major, (priv)->fw_version.minor, \
+			 (priv)->fw_version.revision) >= \
+	 MXL862XX_FW_VER(maj, min, rev))
+
 /* Bit indices for struct mxl862xx_priv::flags */
 #define MXL862XX_FLAG_CRC_ERR		0
 #define MXL862XX_FLAG_WORK_STOPPED	1
@@ -258,6 +278,8 @@ struct mxl862xx_port {
  * @drop_meter:         index of the single shared zero-rate firmware meter
  *                      used to unconditionally drop traffic (used to block
  *                      flooding)
+ * @fw_version:         cached firmware version, populated at probe and
+ *                      compared with MXL862XX_FW_VER_MIN()
  * @ports:              per-port state, indexed by switch port number
  * @bridges:            maps DSA bridge number to firmware bridge ID;
  *                      zero means no firmware bridge allocated for that
@@ -275,6 +297,7 @@ struct mxl862xx_priv {
 	struct work_struct crc_err_work;
 	unsigned long flags;
 	u16 drop_meter;
+	struct mxl862xx_fw_version fw_version;
 	struct mxl862xx_port ports[MXL862XX_MAX_PORTS];
 	u16 bridges[MXL862XX_MAX_BRIDGES + 1];
 	u16 evlan_ingress_size;
-- 
2.54.0

