Return-Path: <netdev+bounces-177436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6DAA70386
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE101882048
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE2A259CAC;
	Tue, 25 Mar 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="RjqEDJSL"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659A259CBD;
	Tue, 25 Mar 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912331; cv=none; b=VRvKYkNaKFyBuR8G/LZQgpEXZZwTLiv6Er4X2IL4c14OchzAR2ct8dBRbOB1YOJbKPoTM2/G3YAhcuNJ4COkRltNZijcY+g8mINCZru7AYjr3J0w8bb0s/AhgN/+MFXDCE/metGDuIZhhphIY520ppxF1dgyNaf3OSAvlSBVbYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912331; c=relaxed/simple;
	bh=7mFZoI3oUwSgsrtXYgoQO4zWvGggFBPc0QqMqh4qw+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U514vfBuylbAE+7qDvCMz1fp0TZAOJIuheatpa0Wy6y6KDM/krQHPMXfZV4EE2PSNWf0nF08f2xPYxUF+u81o9aZb85M5cHQ3ELIv5gwEzZEIo9hbLea4ZUnPphAIFwq3gtzQ6A7m00ahQNYd0kAFcQPxnpBpzghovn/2UxFOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=RjqEDJSL; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 85491C001C;
	Tue, 25 Mar 2025 17:18:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 85491C001C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1742912325; bh=Kl/vgxvkF6dodXZC7H99NoGlSRboIwJ+apzfaBVvyhU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=RjqEDJSLlzXSQ2giJRH//e0mYZa0eFVLw8+h0gdhptBKVqS6if41pBTNHjzeFYrCn
	 rdXI6p69dsu51Vr3ZtAOdIQAgg6RZvdXchklmGjK5QXC2CJuuQtS8v5WdaHgM3kbiD
	 xc/fUGKxmk+yQ4c5k9E21xfot/Om2pVdeUOIKEd2gueZRgAP05mVPGTe7sZr+hjRbN
	 msSlbb3gx0xTS1tc+p4VshVnnCebMylkeI3dqo7j/oXXaRGBQwKy2oG7DSnAASuaBI
	 NXifTAesbETyi4L+XnQFRvw8stlBILzA1S41Q/i3JDk1jQDrlX+2VltoHRXz/VQe+V
	 ey1co8Qk/VpLg==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Tue, 25 Mar 2025 17:18:45 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Mar 2025 17:18:43 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net 3/4] cfg80211: Avoid calling WARN_ON() on -ENOMEM in cfg80211_switch_netns()
Date: Tue, 25 Mar 2025 17:17:22 +0300
Message-ID: <20250325141723.499850-4-i.abramov@mt-integration.ru>
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

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 04600794958f ("cfg80211: support sysfs namespaces")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 net/wireless/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 828e29872633..7c0ca2fd3b45 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -201,7 +201,7 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 	wiphy_net_set(&rdev->wiphy, net);
 
 	err = device_rename(&rdev->wiphy.dev, dev_name(&rdev->wiphy.dev));
-	WARN_ON(err);
+	WARN_ON(err && err != -ENOMEM);
 
 	nl80211_notify_wiphy(rdev, NL80211_CMD_NEW_WIPHY);
 
-- 
2.39.5


