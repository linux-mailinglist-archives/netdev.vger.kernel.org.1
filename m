Return-Path: <netdev+bounces-100517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCC08FAFEB
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C811F22EBA
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3BC144D25;
	Tue,  4 Jun 2024 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X7N4nvDB"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898B1448C9;
	Tue,  4 Jun 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497376; cv=none; b=CCG9C6L2Afgg9xSSLooY0c/Jn0KtuKnv8WDVXQt8GsgVkOX4TkV5EENY89/iZTiNY7kaOOezs8SIZFw/ybSLzPVEwUpEid+xpr2g0ekxBm+MGCBsAnyC8riRLgg655VCgxfV/kSfkBGMzREMV/cAj8YzQPUspVAZnMPIYCiuz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497376; c=relaxed/simple;
	bh=fAoFXYYkIkdenvWHNgGiSslpve99mgAMustoo4fOjKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E5Pr8FgAhVIoI6VJ4Gi9d+8nTCQenImx+ODAkzXHv8xJMEA44V+HBOIvtj3YlxXrr1eACSGeR8atPT5p2j/1OWNPY7i3mn3W+onAWP9B+NfQ/OAXN+yEP3X5J6kl8TEkjenDqFNwuFpwr6UtA4ryQ52TPPQEbOEPk3yBqW9Ny68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X7N4nvDB; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3CC0E0009;
	Tue,  4 Jun 2024 10:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717497372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fA411foyqLMzZ1hKOUW4fEs/FNUN6uX3elekeFZ7ooQ=;
	b=X7N4nvDBmnw4RYWneE5CtUu3qx19bfW2W4250fsTMXFe6jFiWec0T/VnjVewnrLKDLBrtR
	MjtespVLF57sWVij73AS/HAQxnI3Mf1SEF+c3giOqJ3uFrCz1wqEbbUx6L1OYk4jU3jtC6
	vLD2Vdn4o4KNeFaRIlJX7RoQo3lvCYEz30GENbZWXAuQRnVKidqkCBJpz26wjnnojWNQFM
	Fkayj7j2VgbS48X54m27vCV5wqYBI19sIjasEkIqo6L6M2ONxLxQ0GPvUNkU2ETvpY3hvo
	yIgdsR5JAe/GYK8F1d6GIIGfa9+T650WqNcqiduSZVGFd0TLjijvbFNfAsDCpQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 04 Jun 2024 12:36:01 +0200
Subject: [PATCH net-next v14 01/14] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-feature_ptp_netnext-v14-1-bfb4632429db@bootlin.com>
References: <20240604-feature_ptp_netnext-v14-0-bfb4632429db@bootlin.com>
In-Reply-To: <20240604-feature_ptp_netnext-v14-0-bfb4632429db@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Timestamping software or hardware flags are often used as a group,
therefore adding these masks will ease future use.

I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
not used at all.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v7:
- Move the masks out of uapi to include/linux/net_tstamp.h

Changes in v9:
- Fix commit message typos
---
 include/linux/net_tstamp.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index eb01c37e71e0..3799c79b6c83 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -5,6 +5,14 @@
 
 #include <uapi/linux/net_tstamp.h>
 
+#define SOF_TIMESTAMPING_SOFTWARE_MASK	(SOF_TIMESTAMPING_RX_SOFTWARE | \
+					 SOF_TIMESTAMPING_TX_SOFTWARE | \
+					 SOF_TIMESTAMPING_SOFTWARE)
+
+#define SOF_TIMESTAMPING_HARDWARE_MASK	(SOF_TIMESTAMPING_RX_HARDWARE | \
+					 SOF_TIMESTAMPING_TX_HARDWARE | \
+					 SOF_TIMESTAMPING_RAW_HARDWARE)
+
 enum hwtstamp_source {
 	HWTSTAMP_SOURCE_NETDEV,
 	HWTSTAMP_SOURCE_PHYLIB,

-- 
2.34.1


