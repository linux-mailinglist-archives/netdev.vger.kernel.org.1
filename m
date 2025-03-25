Return-Path: <netdev+bounces-177444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC60A7039B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F68D1888455
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CC025A2B9;
	Tue, 25 Mar 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="GFYk7dep"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC1257AED;
	Tue, 25 Mar 2025 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912704; cv=none; b=ZPlCF3MwDlyQOcM7FNnsKk53zlPd5CGL0l5TZ4AB4yXVR5FCujXEEAQjiTVLdEv4gpJ7li49Y13D7WOfEE7eWxKoUyCvr0/k8yr4HqgEXm4QI2xleS63QCIvQc4RRnT3GxvGiWs3ZLzJbketVLbB0CyOmhjEB/HnbPD0/EAHQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912704; c=relaxed/simple;
	bh=i+jJluvfmw7QTM79kGVnkPJFy3jfLDA7MJjNItHHP2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTQtmgzv0qpXvuHjZJtI1JjvavO3KBl0iu4hoZ7UgEXBdknvnaHI3zoRxnLfi7hu1oGW0aaQq6OdgkbXkuvOiJ+6eeeqS/QukBshGnUvU64emO+ZbSKwLn3EuVLv8KJjmUEBwBytNcLlA3E6JBz4piYyasTFs80JYhaKgzDS9Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=GFYk7dep; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 8A476C001B;
	Tue, 25 Mar 2025 17:18:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 8A476C001B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1742912320; bh=VpnvlnY8bY5vnElrzVp5C0j7oZyYs6XQRrZNSP6s5wc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=GFYk7depy8+PUULfLypFldRXPm69P1R2EpnI/HPh/gzhPDbHGD7EbYP5kp1c46UFH
	 AL3Bgc8zd7xeHzq4dnmPN7RdE29NgjePU6XLdqyoslRZpqWS0slyfZYqynhwA34o1G
	 XoTXSYHBoDgAcDLZ9p6vgTIV9okw3ygf+jTfN3JuzSwrZNcPafj8fiKmsy71NtzIa6
	 oINBOX3R/+2EpQnRjUFxth40jim2FUGf+yjKEaRwEh3ivuwPU7ZjrDfimQSsafSa3n
	 ezCej509S7FPxeGfpCiVYtxSI7wnD4WfDch6o9Yf8U5ovWEtpgu0T8zUezlGNxF336
	 YZjngfybQ3DBQ==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Tue, 25 Mar 2025 17:18:40 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Mar 2025 17:18:38 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net 2/4] ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_pernet_exit()
Date: Tue, 25 Mar 2025 17:17:21 +0300
Message-ID: <20250325141723.499850-3-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325141723.499850-1-i.abramov@mt-integration.ru>
References: <20250325141723.499850-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.200.124.61:7.1.2;ksmg01.maxima.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192091 [Mar 25 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/25 08:37:00 #27838357
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

It's pointless to call WARN_ON() in case of an allocation failure in
device_rename(), since it only leads to useless splats caused by deliberate
fault injections, so avoid it.

Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 net/ieee802154/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index f9865eb2c7cf..77760ed4e528 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -351,11 +351,14 @@ static struct notifier_block cfg802154_netdev_notifier = {
 static void __net_exit cfg802154_pernet_exit(struct net *net)
 {
 	struct cfg802154_registered_device *rdev;
+	int err;
 
 	rtnl_lock();
 	list_for_each_entry(rdev, &cfg802154_rdev_list, list) {
-		if (net_eq(wpan_phy_net(&rdev->wpan_phy), net))
-			WARN_ON(cfg802154_switch_netns(rdev, &init_net));
+		if (net_eq(wpan_phy_net(&rdev->wpan_phy), net)) {
+			err = cfg802154_switch_netns(rdev, &init_net);
+			WARN_ON(err && err != -ENOMEM);
+		}
 	}
 	rtnl_unlock();
 }
-- 
2.39.5


