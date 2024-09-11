Return-Path: <netdev+bounces-127575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F5975C61
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352031F2448E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475011B4C29;
	Wed, 11 Sep 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YqRjlVvP"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0357A155759;
	Wed, 11 Sep 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090048; cv=none; b=DyrBdfDMhu+fQK8Rs5ceTAn0ErRHkg92f2nVuVG54H/ckh5Zd3gsJMezOwW2SLTUZFoQeSxOeeIVJneVRJIqbwjib9b8bqQqqpEOg96+4rZ2b4cxn441hAjfG5NddKh4McnADbrDZbzZV9SYiivxR+nd7u+fjRv+Pc994TdNHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090048; c=relaxed/simple;
	bh=qN8YMbE+d2ymnDXdbH4Hx/kcwVBIJqZAoWpEOTNc2tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgQGAZ/2ZpSjzNjUf7OFStVSRREDiYwhjRAYHZnzOibtPEwflWMHnYQ3R7cU/pHRE1ZoAGzZN29ur0JnoY5+pJsMc/8UTREKF784d6OxffecTsMoZ6TV6EoTwwdF+GlFOni7tjwjgqeNDGYF1A/CG8UEKF5Fsbp+g8GLlQRTqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YqRjlVvP; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 728551C000B;
	Wed, 11 Sep 2024 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726090044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdYXHEU/uOE2Sd6g81/m5K7/IKN+TbDNAlXuginIRhQ=;
	b=YqRjlVvP2tfn8WuvsoeqBmym460fVkKFf8kd6eC/OkjfcI1QacbuoMIG4OtaX0CKw5Gi1K
	18wD+303mrjKp/JXo84nmo8MrW/6IHm+BYMe2enxyLck1PQVnLRZT1A88dKqBZzhZU+wRf
	VCVDovDAOu6vfg3szPxGBTtEmoQt+5XumzwVyUZ/xxs3k2RDofD8z4x2GF5W5wIQicJpaX
	VWyDyGv6+R0sAWamdWpwpJkPZeXq2HssIGDJ1l88/qNkOtzV9hiaUCnUi+lxEat+f9EBPP
	GU5iVN8motal+hpm70qPIxAhInwHLQod22uDMmMdnKUkAsJPEqBOJjuaWRjk0Q==
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
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 7/7] netlink: specs: introduce phy-set command along with configurable attributes
Date: Wed, 11 Sep 2024 23:27:11 +0200
Message-ID: <20240911212713.2178943-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Update the ethnl specification to include the newly introduced loopback
and isolated attributes, and describe the newly introduced
ETHTOOL_PHY_SET command.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6a050d755b9c..f17ddd8783f7 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1132,6 +1132,12 @@ attribute-sets:
       -
         name: downstream-sfp-name
         type: string
+      -
+        name: isolate
+        type: u8
+      -
+        name: loopback
+        type: u8
 
 operations:
   enum-model: directional
@@ -1950,4 +1956,18 @@ operations:
             - upstream-index
             - upstream-sfp-name
             - downstream-sfp-name
+            - isolate
+            - loopback
       dump: *phy-get-op
+    -
+      name: phy-set
+      doc: Set configuration attributes for attached PHY devices
+
+      attribute-set: phy
+
+      do:
+        request:
+          attributes:
+            - header
+            - isolate
+            - loopback
-- 
2.46.0


