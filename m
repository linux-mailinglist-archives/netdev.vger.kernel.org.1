Return-Path: <netdev+bounces-229554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D93BBDE018
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2FE19C39CE
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F23218C6;
	Wed, 15 Oct 2025 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="24j3kz+T"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24F3218C7;
	Wed, 15 Oct 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524090; cv=none; b=lDxCrDve/CXKxDZsP5c5A2Hc9eUzhJEwakGs8Pyz/PdiFpILKzjSwlsXx1RxkHsKftHiElZ2ARMNrKZonyHAXJo/m4wPo/614AuH/J9szUa1foh4aOdmjtkA+sb0CYzpzF99NaZkpxd8MRDi4iIvmcOXF5U8SnpWh141LOQrGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524090; c=relaxed/simple;
	bh=l8tUjOPvN51pq0CiSqJPSMsq7VO5IJLjxaHqlJO8jgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvQ6tbPTJ9/9eCahNpl5FoUfybtlnS2bEHkN2mUc+fhUldJA2znTelMBv7RH6lXDfw1adaVeAPZVxn74ZvISjOGsDSnsONktgK8yuYRwM56fU55EpR1b0E/+QJIIa+rujB+CUQx7n3a+oZ8Qapb/IDA87cuXPff3n9Km3I+eZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=24j3kz+T; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CAF0B4E410D0;
	Wed, 15 Oct 2025 10:27:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9971F606FA;
	Wed, 15 Oct 2025 10:27:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40124102F22B6;
	Wed, 15 Oct 2025 12:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760524077; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8qGWfDBGHqSPGWJIrWnQN9/sHI+wC3nVrrOc3hb1m0A=;
	b=24j3kz+TZBypam4eIYin2oaU8ga44Eb8szSPoPzfttkiNc1sKGA141nc2k50UTsxeDCz81
	79OVEr6ivEuhso/lXvKdjzzQ26imcDA2VyVIFWJc7F5D2/OhaicI1qtW9P5HfMgb7XZx9/
	6tmoA7teAreB/HUcPLDy2IWD47ahrhuKETwxrZtaw4rh8Uho4/T0UkkGbRKsCYCs7KZtjJ
	O01MsgiqKnVANuvlhNENUlQBbfdTWGFRptTcmI5+JeR1AkNZQLqyh8jOWxnVBYyzwRMAib
	X80psGjtblFuZ1kLqAzVUcKXSpFpTxHqZOm8EvV3jLhRgNFMjDzhgQGe/O2fKA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: ethtool: tsconfig: Re-configure hwtstamp upon provider change
Date: Wed, 15 Oct 2025 12:27:23 +0200
Message-ID: <20251015102725.1297985-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When a hwprov timestamping source is changed, but without updating the
timestamping parameters, we may want to reconfigure the timestamping
source to enable the new provider.

This is especially important if the same HW unit implements 2 providers,
a precise and an approx one. In this case, we need to make sure we call
the hwtstamp_set operation for the newly selected provider.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/tsconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index 169b413b31fc..e8333452926d 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -416,7 +416,7 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 			kfree_rcu(__hwprov, rcu_head);
 	}
 
-	if (config_mod) {
+	if (config_mod || hwprov_mod) {
 		ret = dev_set_hwtstamp_phylib(dev, &hwtst_config,
 					      info->extack);
 		if (ret < 0)
-- 
2.49.0


