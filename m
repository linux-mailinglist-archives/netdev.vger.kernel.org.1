Return-Path: <netdev+bounces-252457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEMWKTtbcmn5iwAAu9opvQ
	(envelope-from <netdev+bounces-252457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:15:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9896AFB3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33F1D3051067
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E139CEDD;
	Thu, 22 Jan 2026 16:39:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466293904C7;
	Thu, 22 Jan 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099968; cv=none; b=qCSGLS5XTVgayUkrKx5sftBVXylnxO4iG1Cae+6NQTgScXywYeeJKvv6RHgPfwM9shR4e2tK+xEjUfz3os/wjgrToP/fNGXIL115ekTyDKvWj7eOWUIjwN5eOISmbjKrKL76VEAFV3OQ41yELqvfcFfpJgV68NzhKN9W2BoRYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099968; c=relaxed/simple;
	bh=Wwhplcf9tpzruHjL2huv7otfWsh1za017z9Cjw9WmXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7gwuKWPz0PQLGnwFXAChb15GZVTWdKVB7GaoD5fxPebBzbMdyNIZ41zMTfLSLWxqP6BCAnyDrYdCb7YE7LxfhxgquRZeGFfvU4Fw2AvXpXhya60BHbxMDMaCBncFtem+bWysipSL1bmrcI8Qlq3H9eLMcEwdnOTRx9c5xu5u/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vixiJ-000000001Rc-2mA4;
	Thu, 22 Jan 2026 16:39:19 +0000
Date: Thu, 22 Jan 2026 16:39:16 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v6 4/6] net: dsa: lantiq: clean up phylink_get_caps
 switch statement
Message-ID: <423daf99b3d60f510ff048a261c62d3de7d39321.1769099517.git.daniel@makrotopia.org>
References: <cover.1769099517.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769099517.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,gl-inet.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-252457-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[hauke-m.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SURBL_MULTI_FAIL(0.00)[makrotopia.org:query timed out];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	DBL_FAIL(0.00)[sin.lore.kernel.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RBL_VIRUSFREE_UNKNOWN_FAIL(0.00)[104.64.211.4:query timed out];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	TAGGED_RCPT(0.00)[netdev,dt];
	BLOCKLISTDE_FAIL(0.00)[185.142.180.65:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,makrotopia.org:email]
X-Rspamd-Queue-Id: 1C9896AFB3
X-Rspamd-Action: no action

Use case ranges for phylink_get_caps and remove the redundant "port N:"
from the comments.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v6: rebase on top of current net-next
v5: no changes
v4: no changes
v3: no changes
v2: new patch

 drivers/net/dsa/lantiq/lantiq_gswip.c | 12 +++---------
 drivers/net/dsa/lantiq/mxl-gsw1xx.c   | 11 +++++------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 0377fc0079b54..4d699d8c16f91 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -33,8 +33,7 @@ static void gswip_xrx200_phylink_get_caps(struct dsa_switch *ds, int port,
 					  struct phylink_config *config)
 {
 	switch (port) {
-	case 0:
-	case 1:
+	case 0 ... 1:
 		phy_interface_set_rgmii(config->supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_MII,
 			  config->supported_interfaces);
@@ -44,9 +43,7 @@ static void gswip_xrx200_phylink_get_caps(struct dsa_switch *ds, int port,
 			  config->supported_interfaces);
 		break;
 
-	case 2:
-	case 3:
-	case 4:
+	case 2 ... 4:
 	case 6:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
@@ -75,10 +72,7 @@ static void gswip_xrx300_phylink_get_caps(struct dsa_switch *ds, int port,
 			  config->supported_interfaces);
 		break;
 
-	case 1:
-	case 2:
-	case 3:
-	case 4:
+	case 1 ... 4:
 	case 6:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index c9cc277e382c2..ba72111a53ad0 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -511,14 +511,12 @@ static void gsw1xx_phylink_get_caps(struct dsa_switch *ds, int port,
 				   MAC_10 | MAC_100 | MAC_1000;
 
 	switch (port) {
-	case 0:
-	case 1:
-	case 2:
-	case 3:
+	case 0 ... 3: /* built-in PHYs */
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
 		break;
-	case 4: /* port 4: SGMII */
+
+	case 4: /* SGMII */
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  config->supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
@@ -529,7 +527,8 @@ static void gsw1xx_phylink_get_caps(struct dsa_switch *ds, int port,
 			config->mac_capabilities |= MAC_2500FD;
 		}
 		return; /* no support for EEE on SGMII port */
-	case 5: /* port 5: RGMII or RMII */
+
+	case 5: /* RGMII or RMII */
 		__set_bit(PHY_INTERFACE_MODE_RMII,
 			  config->supported_interfaces);
 		phy_interface_set_rgmii(config->supported_interfaces);
-- 
2.52.0

