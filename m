Return-Path: <netdev+bounces-109550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D920928C66
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387B42854A4
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C659916D33C;
	Fri,  5 Jul 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="WCqWs5G9"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BD149DEF;
	Fri,  5 Jul 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720197504; cv=none; b=lIoeUHvEnJ+cKGl7xab360p7DT8Y+5eAtfTGLkZGoUCHsBstoO66aBOK4zXDNKWpYn+X4nA6XdurdFnmmt7srUz45rAR3trQtDTOOnafY/lK9D+lqp1Y2qzO6OpdkRGtYXKqgaI+9qR/1YZU4btWGWCW2qsPUNkDJ+cHvFx7dTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720197504; c=relaxed/simple;
	bh=xq+v2dQwSE3AVf5BhabhYvPbecI04ixjFZd9xxG8bYU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yz9FtSZR8uR+mwUIAPNRBIy9UAEZaI15bzEGLc3/xQ7TW+3pt+V8tExqWsWSYPibSw8xh31PEfGRU/hq8bEL9ZUHeQoznwIrD3kelfxXHeiJPfkdxFTKlmPLwdlXKReJgstBm8JdKjPgzoaTfeK3GeTnhIpxiodyXyTsh8YA3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=WCqWs5G9; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 88AC9100002;
	Fri,  5 Jul 2024 19:38:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1720197482; bh=s+XlZT7Zau6TfDZLEbOwy3xPtGFBs9GZzuVmW0T8wrc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=WCqWs5G9OjmuaIJuFPb2XKbdhfiBWqQmmy4zZlEiypH3kqWGlAyi62lgTBJXYB6OD
	 ZKvz3TA7DYr9CH4EFXumApiQuFQH4Zj6fPV8F0on2/F+fMZep+79jKcDh5PSuyoxg4
	 FdvLjlzk5IPvDbo/3ScBccRMFbEWxHOis7n+i+ySqNpzWMy1WHOlSDrkWU+HWPmxj9
	 6mljpmwFq8ViLQp1oGjSaMMOzgmCbEwZxVgvqcZ7t4WUPeAGpF2EueKMwEUBzTRGA4
	 qoIjkrd001ytwaMiCoUH/F7xsP6lOeuOcNuHhmXoUQMH0rPvWYDKtDXjsRbY0vgBT4
	 VdMpoShmJMP3Q==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri,  5 Jul 2024 19:36:53 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 5 Jul 2024
 19:36:33 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net] ice: Adjust memory overrun in ice_sched_add_root_node() and ice_sched_add_node()
Date: Fri, 5 Jul 2024 19:36:20 +0300
Message-ID: <20240705163620.12429-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 186342 [Jul 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/05 14:29:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/05 10:39:00 #25854340
X-KSMG-AntiVirus-Status: Clean, skipped

In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
devm_kcalloc() in order to allocate memory for array of pointers to
'ice_sched_node' structure. But in this calls there are 'sizeof(*root)'
instead of 'sizeof(root)' and 'sizeof(*node)' instead of 'sizeof(node)'.
So memory is allocated for structures instead pointers. This lead to
significant memory overrun.
Looks like it was done for "coverity[suspicious_sizeof] workaround".

Adjust memory overrun by correcting devm_kcalloc() parameters.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dc49c7723676 ("ice: Get MAC/PHY/link info and scheduler topology")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index ecf8f5d60292..d8b6054f3436 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -28,9 +28,8 @@ ice_sched_add_root_node(struct ice_port_info *pi,
 	if (!root)
 		return -ENOMEM;
 
-	/* coverity[suspicious_sizeof] */
 	root->children = devm_kcalloc(ice_hw_to_dev(hw), hw->max_children[0],
-				      sizeof(*root), GFP_KERNEL);
+				      sizeof(root), GFP_KERNEL);
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
+					      sizeof(node), GFP_KERNEL);
 		if (!node->children) {
 			devm_kfree(ice_hw_to_dev(hw), node);
 			return -ENOMEM;
-- 
2.30.2


