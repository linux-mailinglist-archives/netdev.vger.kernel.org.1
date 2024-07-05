Return-Path: <netdev+bounces-109486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248269289A5
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5395C1C21AA6
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236191662F6;
	Fri,  5 Jul 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e+vN7FVH"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B615FCED;
	Fri,  5 Jul 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186051; cv=none; b=VtFUeLFwZjnBhvEii5jMVw8FH9gHMclmE60kRUlM1wubcrk9Fnx4p8zkusS/rOsDwh/8DnVVC9h6z1iM3neEXO3KWs9ptGXI1DsfIJqmmG/4NuyUnTesR1tWn/QvJ5Km4Lj355vj3oR01GbMj18NF10FPKjeg40jkPwB3ZWIj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186051; c=relaxed/simple;
	bh=PFz35s6+G/TnoRTclOhL1EcNfYit+k9Z7dOJe6YCp4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2yXyiE+ElL77HbGiRjJ7+whNiBUSrlWr2B+CU5+YyFL6jHsYecMengMMPREImP9Jh0VG1vET28GMORdj8uiZk04Necf2NqMtbffAORqgmuyRHKVWy2sOmAealDfHymHDq8958yYVG4qwCzPPa7vLSNa/Zu/TntYd6xbtss0bPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e+vN7FVH; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A7DB1C0005;
	Fri,  5 Jul 2024 13:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720186047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=au751q6uXgdNnQ+9HA8qxp8WnsnVyZHIPDFw4WURLBk=;
	b=e+vN7FVHI/wvzu78RuLiTO9ZHuaggDzVM9D46l43fo4yyYL5GnR6Yjm9uWEjFVw6qlcREu
	MLEhrchzpoaaHGwK3tS8VOM1xSkhTeR+AIv58i3GFzrpin+Ttd2VnX+LQ4TdF5wIUm6UAn
	P1DLxklrCG/eZpwAeW9Vs8iKsvg3xcuy0Kr4NGDQyID/EPxQ0Q0v9JZtfbyO+yG45Hp6ub
	S6O/6/AUVIta9wgMJc64zP8zgJ1IaWKKg1rzJTaxjBeVFIm7sbBQIfl7b/pbe9rru2GMmb
	RR2ZvQy79loao/WUX8k8b+E18cu4cIRQrkcfXamezZh6uQWUMEK8uAvtAa4l1A==
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
	Romain Gantois <romain.gantois@bootlin.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next v16 12/14] net: ethtool: strset: Remove unnecessary check on genl_info
Date: Fri,  5 Jul 2024 15:27:03 +0200
Message-ID: <20240705132706.13588-13-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
References: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
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


