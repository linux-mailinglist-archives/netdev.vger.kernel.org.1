Return-Path: <netdev+bounces-110111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D3492B020
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613A71F21972
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7BE13DDCD;
	Tue,  9 Jul 2024 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R8VdnUsS"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F58738DFC;
	Tue,  9 Jul 2024 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506657; cv=none; b=mJug1Wm1B9fzV4MYNfzp+MpGRSW9Yk3WFi+G8jZls9zoE4j7WkjDC33vWN6ACxsfeS09jiWeCugJsYZ/9E1Kx0uboRLI4FhZ98Y7o8D5U/uV3BQ/wWhvm+mOGLjNfJ8dVDv0c/kDQyjyurun6+RpU7s/NSj+//ch4qUgwNOTCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506657; c=relaxed/simple;
	bh=W5+LuA/aZqt9mYs2A8G42YYZb+ZP3zBw+jTnLIL0nXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+CL3biBZs58AmeyV2PxSZOM6STZ6dp5rpo4tkGc/Vl+SUnKAZLb+Ovw5i93HiR6BYff0gAuwJ5W+aN5AIl4wyPpWSOk9Hua6ZPPJWlDdVnjvpIzROIoem+3bW4TthuQ4cWSCvkn7vTgVsmMfLeJYnfY3Hp47Ke7U+5UGKfQ5/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R8VdnUsS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 387661BF20C;
	Tue,  9 Jul 2024 06:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720506653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGn3SAa2oNlb0g/UrHcq5L+V5J9nhsuHwGCXN8X9B58=;
	b=R8VdnUsSMv3SGP4BsifReOoOIGkV5LsS9wytHggSxe4lklTYLUik+OeEjcvFf+yr3PHw2N
	QD5sNwqJN/bxAwXjsuh2OM4agO64RbP9zdGKjaDUj4X3+dBVJHol8zEOI6kDTqUqADYfQJ
	yzGNXt7DWdzxxppSP+FQubgIJo7kf9O7yw9rWANhqB2se67VCJwfEuWJ65585D4kL4QTVn
	iIpE/+58CVdtFPjC+extXgHV3ATX00vWqt+N/a9fQwxSMA02BxDqyY5evYwXN3gsfnJP7G
	xlkqAyrXnRU2bOmE6VIR3od62YbJq478sCNwhpXGthaEX9Qs6DsAnJL2HjwyUQ==
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
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v17 06/14] netlink: specs: add phy-index as a header parameter
Date: Tue,  9 Jul 2024 08:30:29 +0200
Message-ID: <20240709063039.2909536-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
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
index 495e35fcfb21..586f1da8eb7b 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -54,6 +54,9 @@ attribute-sets:
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


