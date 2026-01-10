Return-Path: <netdev+bounces-248712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12769D0D968
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE2113010671
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A1D2517AF;
	Sat, 10 Jan 2026 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="nAo7JSX9"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559528B407
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768064546; cv=none; b=O5pa8PNp3MBuGUdMhBH6/qynpuKEGQKU1iasdZKzFVoHuKDJ75x6qhlFHSsmqAhzpJevplS8CEQjtLR/OqbDI+CXE71ro3AMdWGOe+kQuSYm3t0Zqbu4gAKpgduZEnYhbps+7fhhtafm8b8F3G0hyGV+QvaoEjG1MAnctWEN0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768064546; c=relaxed/simple;
	bh=+HEz+K4Fa485jOVGK6zrpvQleDAot/jEyVxi/6xIInI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmN+wZe1hFagnUPpv1+KfWjEX9q32KSpAhObgAn1AfwTBcErndlNrL23aFLuEr02luCKr1RTqqeteOylOSif8R7dyQ35++27PuqkMk1xNUPg57LmUbY4+rKrq74td7TZjiXSXlAsd/CfydCKqjVVz93PJGFQI7D43TvBqOw1KbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=nAo7JSX9; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 22655 invoked from network); 10 Jan 2026 18:02:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1768064534; bh=TdUcyY8z7TPRWWsioWKt1JEXDLaS36j5QztcwMQNV2M=;
          h=From:To:Cc:Subject;
          b=nAo7JSX9uR9NVIck2I17s/oeIrJ2SQgduFI4206Zh5ZZjrrOtaVRqqfBX0hbwRObF
           p+5tKiz0Fp8YiuZrNZT47TE3pwrmAP3cH3AQpXZeCSz6FRjk4iiXIqvII8TPmZhAAh
           lzYYVnFUH6M83yRmS+vBRJ5YTwE+CrZOwF1uoRUj+OIpUEcCPz2HC6Vlu6hf0QIJRB
           lImeCbO/Zx4nO9R7vzn2b5vb/kDf29lYjRepwfZlKH6oOFNP4qnyHiodsU4X59T98O
           34jcil+Q9/ckqYgADKEHkXgurACyojPkABZjCo47pNGo7HYfJuI3cjn8ZIkjp0GZM9
           n/EiRoHL9nbqQ==
Received: from 83.5.241.112.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.241.112])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <lorenzo@kernel.org>; 10 Jan 2026 18:02:14 +0100
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH] net: airoha: implement get_link_ksettings
Date: Sat, 10 Jan 2026 18:02:05 +0100
Message-ID: <20260110170212.570793-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: b0882427119f6bf4c95d9fe123544b4e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [sWPE]                               

Implement the .get_link_ksettings to get the rate, duplex, and
auto-negotiation status.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 315d97036ac1..00cae2833f09 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2803,6 +2803,7 @@ static const struct ethtool_ops airoha_ethtool_ops = {
 	.get_drvinfo		= airoha_ethtool_get_drvinfo,
 	.get_eth_mac_stats      = airoha_ethtool_get_mac_stats,
 	.get_rmon_stats		= airoha_ethtool_get_rmon_stats,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.get_link		= ethtool_op_get_link,
 };
 
-- 
2.47.3


