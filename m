Return-Path: <netdev+bounces-100996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3629D8FCF45
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DBEB2D975
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87151ABE30;
	Wed,  5 Jun 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mSrsydRT"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3001AB8FE;
	Wed,  5 Jun 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591778; cv=none; b=YNgDAHMIARhec7WB9PifDsBn3dPr36r94HueX2uudBX5QOJMRvP6Qx5xlNgqtYL3C0fU4dG2chRJZ/KBc5CrJJ90Klacg4VY7J4xWcbg1njmg8GCuGv8umiglNxaU/F3wlw1E80QTcpKRPAjriJ+MKZyj/oFnjMPSNpL9xgH7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591778; c=relaxed/simple;
	bh=qT13R1OnRDV3a1afGQ4ExjF7MEbhuPvbGRFaRmw/X1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G277JXDMONo0eQjVALS1tfjR7uBaMQdjx2E9nU48Vaxm8TxJKVdQveweydihPlu/7RNFAq7ZhPgGNdAufekkYUOQOCzs5xV14RMchp+ZvRnPJ+qdJRxI6+6ltV05G6QSwSF8PYj6cXVQluE4TA+SpxkrJU3oU+dtBJrm3Hbo9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mSrsydRT; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4AC672000A;
	Wed,  5 Jun 2024 12:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717591774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oygbDLiuF7e7Ih1qbHzskVfuqfjnaRNnv7o0s99CswA=;
	b=mSrsydRTuAXz/TuLRFVQcLcOGQoh67pEltQx/hw32+8NYPlDlkeyk8YXOuRYOwTMyOQu38
	JtbMOhvBkV7DvbBKVN0eLm+SI+Y9/6tvU7Q4Qv22qKNYB8g/M1Xow0x6GNw0RhR6wsWcwW
	OOiJek0H4aBtzVvqfR6k9MkwlibEcPkLBD848G6d9XWVPs3jHXW2rF6UUkMjSwQqa+MgGl
	/FgkUj8eDCYqjEV+uwrALDsGrie8K17V9rRflaEsAoS5i/oJLVrfMHFm38r4I/aKntTm10
	Fbpjvive+lnzgXhcCVGnBx8hwJZEErZbIsERb4b8qpRLlS/ZVCslyekcNT50vw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next v12 06/13] netlink: specs: add phy-index as a header parameter
Date: Wed,  5 Jun 2024 14:49:11 +0200
Message-ID: <20240605124920.720690-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240605124920.720690-1-maxime.chevallier@bootlin.com>
References: <20240605124920.720690-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Update the spec to take the newly introduced phy-index as a generic
request parameter.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/netlink/specs/ethtool.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 00dc61358be8..38c2ed0da739 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -35,6 +35,9 @@ attribute-sets:
         name: flags
         type: u32
         enum: header-flags
+      -
+        name: phy-index
+        type: u32
 
   -
     name: bitset-bit
-- 
2.45.1


