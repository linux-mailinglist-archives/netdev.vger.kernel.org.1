Return-Path: <netdev+bounces-108909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C77926306
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF5F2881A9
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE02B18FC72;
	Wed,  3 Jul 2024 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fUBB90GY"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1F18A93F;
	Wed,  3 Jul 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015710; cv=none; b=W0Pg1paLbugcczkf0w10eGU+ItPWXa4KBbquvGp7zTlx7DOn+t9EtOAROcY9Rs6Fq+lCcgqrrUDj/eW5trASpsZCR07BGe8AbDmaHT6FguBJel0mX6A5tuow95Ce1VBwn3F5PYADDHfUTiIQ6qFpiqmTboDErfynxxhE7e8V+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015710; c=relaxed/simple;
	bh=PFz35s6+G/TnoRTclOhL1EcNfYit+k9Z7dOJe6YCp4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6B5ELl0TaTfjGzIZF9MIJjNl1x9fG6voGf5LHGpsInTDPzs9TyqCHKlChug5j5gcxO63R5fSz1yRIb72tPaZ8J1hp8z3kgphCsXN936HD9OU+RaiwAsUuHz4KvHGl5uphR7f7fcywGigMma9eJVT7nJE2951Gr5BiO5bCrW24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fUBB90GY; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12A35E000C;
	Wed,  3 Jul 2024 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720015707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=au751q6uXgdNnQ+9HA8qxp8WnsnVyZHIPDFw4WURLBk=;
	b=fUBB90GYdqq5LB6S4Vzh0sNR9RXKpvFd2542DmPLEio0vPJT2Sq6TRLKnpJsfM6SmeOngT
	L3adPAyDK6ttdpAfcyEr1/fXAkrhcU+EpbZ57YOoS/MyQY3G5UHgkVFjdqX4DZSZi4asUC
	TL6dX5z5ShPXkxwtDN2YUTHq+pxqVMYreG9w+dPdTJvmpQ87l75zs5xBNqDw7eQn0aLrfK
	xLVRV1INPogIDhgRXC9vPGUDT6PAxyA8wKTQRGW/xFrtvQqiJ4MW4Z0Me13W8nR2Ug/Fbi
	Cj2P1kynwAEh/v0qKCIQwCwhnzAXpWHkQMsk2YHP84XaT+Nt5vHwYgO4KEZTpQ==
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
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next v15 12/14] net: ethtool: strset: Remove unnecessary check on genl_info
Date: Wed,  3 Jul 2024 16:08:02 +0200
Message-ID: <20240703140806.271938-13-maxime.chevallier@bootlin.com>
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

All call paths coming from genetlink initialize the genl_info structure,
so that command handlers may use them.

Remove an un-needed check for NULL when crafting error messages in the
strset command. This prevents smatch from assuming this pointer may be
NULL, and therefore warn if it's being used without a NULL check.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reported-by: Simon Horman <horms@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202407030529.aOYGI0u2-lkp@intel.com/
---
 net/ethtool/strset.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index c678b484a079..56b99606f00b 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -289,8 +289,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		for (i = 0; i < ETH_SS_COUNT; i++) {
 			if ((req_info->req_ids & (1U << i)) &&
 			    data->sets[i].per_dev) {
-				if (info)
-					GENL_SET_ERR_MSG(info, "requested per device strings without dev");
+				GENL_SET_ERR_MSG(info, "requested per device strings without dev");
 				return -EINVAL;
 			}
 		}
-- 
2.45.1


