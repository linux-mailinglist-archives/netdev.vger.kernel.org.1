Return-Path: <netdev+bounces-108903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 004FE92630D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BCF6B2C0C2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE1183098;
	Wed,  3 Jul 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RWcaPmh7"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC271822D2;
	Wed,  3 Jul 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015701; cv=none; b=Em2i+DqpPn1UudnOgdwl6NC6ha5wj2qON7pilrVtQvRP4hdSaXDRgiePkbSH2bleVcc77coGs/S+PiwglWCdavU6koLukq2sQmQlly+SHPsdT/0WkXy1UBShx9Gi60dR0wW8QJzqbCWkbSGIIvHgS7ygJZZdI7taB+Df80lwhdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015701; c=relaxed/simple;
	bh=7FIYxRfvmusJYW3NXDOpm3dJjXJR4Z4Kf/2oD5O5l2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GK5EIittVOsn4Gkw/C4WlFrrXSyrCxrs5oWd63zmtSYgXxesTogCX/Mc9Iisn4yTNmVoRnmwcZQAmYl6pKGPFcxj/lmkAE4Oe0gI2tR4CPhKjaTD3tF41pyVVo3bEPz7VpxRCNHiY/xdrotKgIvrv/SpduixWYaOd74RQD+40OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RWcaPmh7; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 828D0E000E;
	Wed,  3 Jul 2024 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720015698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uy76o+N0EM0sJl+NqRd3EHqRDxABCoWbyTToYzh4nN4=;
	b=RWcaPmh77ujuIim8tXovGLDvE21cGb4oY8Z4Ee4gDtmKlZntrtmR2XRKI94CscJ175Tnix
	/0TKnCoog2nYcoML95jGBWnn3AdYdonnplAUBnFydh1V5XBYy8DzlNsJTefZ7v+6y9r8hA
	dLjluNSfLlQ9huj4hFB7sy4/ZRh+6nNqKWm2e9ppjp7Ads7D/OKXiZt5i2CpXOQbOYmfYL
	4mThWzq7J6xz8y71Uk4uOsT7W9/Yyh7KrimbMskGkE/0L7lPEEgVboqk10QJuzxeVSBKUk
	vGh+wLcMuxf5/jnj/9LHpVLsAYmHzwMa+HmtF/v+kki5LS7ljeHM+TpMvPBRcg==
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
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v15 06/14] netlink: specs: add phy-index as a header parameter
Date: Wed,  3 Jul 2024 16:07:56 +0200
Message-ID: <20240703140806.271938-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240703140806.271938-1-maxime.chevallier@bootlin.com>
References: <20240703140806.271938-1-maxime.chevallier@bootlin.com>
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
index 949e2722505d..4ca7c5b8c504 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -39,6 +39,9 @@ attribute-sets:
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


