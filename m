Return-Path: <netdev+bounces-110562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2209092D1CD
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 14:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8431C225EE
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324119149D;
	Wed, 10 Jul 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="tAZqzLe8"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2A190485;
	Wed, 10 Jul 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615347; cv=none; b=ZP2tXPhJgQx+5BNZ6kNIwxOEKoWppolHTVKLrR6VoK5YenG8sqzYwD1Qmb2YGJdK6KFdhXfWJohaSicR33zQoUCC5o2tBvItV9VYPRVYev6sRq6zK1UP+4qIlFNtBQcdGjW8d2cio8yTBnTRCjzmDvWONBk0Qs4J5G8zjyEfvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615347; c=relaxed/simple;
	bh=GQAIShZYr71kjsZCpzZl/eG1rV3WF2cCx2mE38nKZ4k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YB/czq2nXkTMBr2EC/bLyYP12VOY3amWFT4uMTGHtZWt5dr7eQ8dcWws9Jluvu9lHJqdwb4ZO8MS6K6dCsti9ee5F8e2qlCJIhUr/3DyLSwjJYjC27ckjN4x0DrK3GkDnSBlhy6GqHQC8UbEFp9e0TsO0vVtyLySEeDQV4dHqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=tAZqzLe8; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id BE195100002;
	Wed, 10 Jul 2024 15:41:42 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1720615302; bh=TMMii64hLBF2fPDulrY0mamojXuv/hUwycAgbvgPCVE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=tAZqzLe8/E1Qunux37pPDHSj9VIi+92RRuKI3olX8dDF4gl1qSY9P6ZmTU4k9VSbh
	 MR47HzSNFig1fWyezAKHFBdaTtdQ4frKtnMsm9Vr/u7R7I63mLm1AZa+Kgj18YVt5c
	 IRJ9TtVk3dza1UanVYuTWvED4/jsiP9DVPjHkPMgtwriCre3zfAO9aeVGNI9/ndgBb
	 epld8A3XoznXHWlj3TSQ7pzmBRnpTio4d9dF8jCtJQM4TLK2jDF81iSya4NN9h0uom
	 YhX/A9cByLxDvf7aczvobBUxKXo+QO4ISJt1yZrqPQC+sUaUFr53G9ChUumMgRCe5q
	 fy2PmGBbKLJ/g==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed, 10 Jul 2024 15:40:19 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 15:39:59 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v4] ice: Adjust over allocation of memory in ice_sched_add_root_node() and ice_sched_add_node()
Date: Wed, 10 Jul 2024 15:39:49 +0300
Message-ID: <20240710123949.9265-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186432 [Jul 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/10 11:05:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/10 05:16:00 #25942711
X-KSMG-AntiVirus-Status: Clean, skipped

In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
devm_kcalloc() in order to allocate memory for array of pointers to
'ice_sched_node' structure. But incorrect types are used as sizeof()
arguments in these calls (structures instead of pointers) which leads to
over allocation of memory.

Adjust over allocation of memory by correcting types in devm_kcalloc()
sizeof() arguments.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v4:
  - Remove Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
  - Add Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
    (https://lore.kernel.org/all/6d8ac0cf-b954-4c12-8b5b-e172c850e529@intel.com/)
v3: https://lore.kernel.org/all/20240708182736.8514-1-amishin@t-argos.ru/
  - Update comment and use the correct entities as suggested by Przemek
v2: https://lore.kernel.org/all/20240706140518.9214-1-amishin@t-argos.ru/
  - Update comment, remove 'Fixes' tag and change the tree from 'net' to
    'net-next' as suggested by Simon
    (https://lore.kernel.org/all/20240706095258.GB1481495@kernel.org/)
v1: https://lore.kernel.org/all/20240705163620.12429-1-amishin@t-argos.ru/

 drivers/net/ethernet/intel/ice/ice_sched.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index ecf8f5d60292..6ca13c5dcb14 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -28,9 +28,8 @@ ice_sched_add_root_node(struct ice_port_info *pi,
 	if (!root)
 		return -ENOMEM;
 
-	/* coverity[suspicious_sizeof] */
 	root->children = devm_kcalloc(ice_hw_to_dev(hw), hw->max_children[0],
-				      sizeof(*root), GFP_KERNEL);
+				      sizeof(*root->children), GFP_KERNEL);
 	if (!root->children) {
 		devm_kfree(ice_hw_to_dev(hw), root);
 		return -ENOMEM;
@@ -186,10 +185,9 @@ ice_sched_add_node(struct ice_port_info *pi, u8 layer,
 	if (!node)
 		return -ENOMEM;
 	if (hw->max_children[layer]) {
-		/* coverity[suspicious_sizeof] */
 		node->children = devm_kcalloc(ice_hw_to_dev(hw),
 					      hw->max_children[layer],
-					      sizeof(*node), GFP_KERNEL);
+					      sizeof(*node->children), GFP_KERNEL);
 		if (!node->children) {
 			devm_kfree(ice_hw_to_dev(hw), node);
 			return -ENOMEM;
-- 
2.30.2


