Return-Path: <netdev+bounces-249304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0693AD168B1
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D23C9303D922
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CA234B402;
	Tue, 13 Jan 2026 03:44:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78134AB0B;
	Tue, 13 Jan 2026 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275848; cv=none; b=NhMF48w3OFce3oa9qs9vbF5LEQ8wecAZOhStx0B0dVQa+4bGIPyZQdyg91aN30ajiHfQOLFzT+8dheonOHBVDP8u+pgsyNrrhPPShsF1Q0ou95zS5zwHhO3LGrvb34PSBxJsrgSP9G/Zt1ZHAIvWjXhgJDKGko5FcoRnK4gaZpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275848; c=relaxed/simple;
	bh=5bmb4ccOAQIJyUU79IaRSyxfiWCLJngoACm+XPMfnIY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRFaHAnCoLRmC2nDlnXe/CSBS2Gghj7wLsAC3CM6K58GX2FnxAlv498Gxq0Q2kegGocy14cp7/qc37EY11/5O2Wi4Qovhb22bNGR5C5klW36NUjZxUsZd00kYdwsAyY/x7NDJYSHfIc62ejGa8AC0GmESl69jK8ZGHeDRxkbMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfVK6-000000001UW-48k4;
	Tue, 13 Jan 2026 03:44:03 +0000
Date: Tue, 13 Jan 2026 03:44:00 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Michael Klein <michael@fossekall.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] net: phy: realtek: support interrupt also for C22
 variants
Message-ID: <7620084b1de01580edc2d0e1b9548507fb4643a8.1768275364.git.daniel@makrotopia.org>
References: <cover.1768275364.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768275364.git.daniel@makrotopia.org>

Now that access to MDIO_MMD_VEND2 works transparently also in Clause-22
mode, add interrupt support also for the C22 variants of the
RTL8221B-VB-CG and RTL8221B-VM-CG. This results in the C22 and C45
driver instances now having all the same features implemented.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no changes

 drivers/net/phy/realtek/realtek_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 5a7f472bf58e1..18eea6b4b59a6 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -2315,6 +2315,8 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.match_phy_device = rtl8221b_vb_cg_c22_match_phy_device,
 		.name		= "RTL8221B-VB-CG 2.5Gbps PHY (C22)",
+		.config_intr	= rtl8221b_config_intr,
+		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
@@ -2347,6 +2349,8 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.match_phy_device = rtl8221b_vm_cg_c22_match_phy_device,
 		.name		= "RTL8221B-VM-CG 2.5Gbps PHY (C22)",
+		.config_intr	= rtl8221b_config_intr,
+		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
-- 
2.52.0

