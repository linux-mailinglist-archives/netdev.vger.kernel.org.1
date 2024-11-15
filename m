Return-Path: <netdev+bounces-145186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C00969CD9B8
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59CB1B2305B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D29174EE4;
	Fri, 15 Nov 2024 07:14:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73433A32
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731654886; cv=none; b=bLNxZ7gU/vKzULZsEdJdJIjhQ31R/Gl4ZFtSqtYvpUgpHQ4urHYJ+VlfmkMvDHNeLCN0T2WnifKoiZdVsnpIK66ZKiE93t8mf/hjJdJ+QYLCfDFCGgftLio91A35fT67bbFQmzGgHxkXNbXHAvt8vkXOzNH+wGm75AAYEbgK62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731654886; c=relaxed/simple;
	bh=9AmgxxOLS8mqk3kQantZPGpPnVglNhOEhEXpSW672xI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZkUhXtkWi3enu42NBFesloL7z1an1p+9uFfI0RGVzwT0zK68eNPs5qGMpTamgvaDHGH5Jp4grKQcPTL/NgsmbRCFNF6V25fSVdv1VefbDuQ+GB6blQ0HUGwpRXHzaT+gkmPZiRrWf1KVMinA4jfQY81v3W0fNoo09CY/KrvAerg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp86t1731654743t3c21mjr
X-QQ-Originating-IP: SFCi8xKvph9l2q2Y1+L8c3dMeW/ndL3WaXGiV8vJgew=
Received: from wxdbg.localdomain.com ( [115.206.160.29])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Nov 2024 15:12:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16770981959892933605
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.co,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: txgbe: fix null pointer to pcs
Date: Fri, 15 Nov 2024 15:35:08 +0800
Message-Id: <20241115073508.1130046-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NEaes6yu2o+mSNtccq7LsB49D/AqC67rl7wf/IDL1EByZWsEqzv1hB7B
	7v2lytEhLJ+6dQGinX5HvcT0Uvua8Tw/JKxcg44sxKsZOWlbiPVrUAK6xi9iIolEguPwVF0
	K1NjuG6oBXtbIRkTQ92b31k+NPbnzgNE4sNXJDZ1gIGMfR5bGPwYAxl1XxBKXtB0020KUF5
	t1ROjma5vrO/aS+j8V7QBZQnlxlPX3OV+ejOvQfPrHStE0NarHfEmLrTKyNNmLboLl5s+EO
	CU340MDGTBiYJrT09tQNcYQVqlCIlIpni9zlK0tKfayACFwwf9hn+SIAgb1ax8JEHv8VMDq
	2WXklUNEXh+QObmu5ef8+NivSSL7yRNDriFoGw+r0vAmy6omDS2/VkEqIy5JrGm6noivJAI
	+Nw8EQLBzJLubNds7RFDc77y50sEIkW5Dbaz5z5werGKtLVYaSxh+6BlJo1UzNgMU2wXQn4
	7sGX/jCX+5CkCMPS9r51c7rcsHR3DQohKSDMmcSxnYbJuJWBsFkXnUdgKM71vOj6rBLENLC
	C8U/lGTZdGlX/XVszbcMXpyuUvZuyEEAl/QHxoLa46Rbboi9liu15DBT6imR6EEPWdvJcP5
	Oaa7o14e+FBSl7dn5WFpwbhpXSjzDHAOBySdH08A0teC9rAa/5FuY1AJAbF5DutDVrf9ojm
	vhpWt4zFCmzHf3jFL2gH4KFb2BRbdcQxvXFIUWCxHB55i12ujzDPuwTSzNK1Gmx2MtoSafn
	jgjB3jZbhndZ9+tBasiFFwcNI83xUKUbGyF0/OWw7VTjbQnfgHlM4oARfrPVrmAwALMjunL
	8l07sxLNvtvaP+oYZv9D+7NppglSe7jljimC2WXE3f9YTokEvKMUpcxUk8v6FoOnnQ7R4fU
	3sDxAAs33uEQFIIT/zIqQBw7V7ovmvOX11VPQxkQqob5Y9d1K5uivL6D5VdHdZvGH+YDSgk
	bGNNWgvVJZ9NFWG8nXeg0Qhb0Kh6UKOr+1HvMn4DfmPuENN0eRnRGxbn0/htoJrdQ7zo=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

For 1000BASE-X or SGMII interface mode, the PCS also need to be selected.
Only return null pointer when there is a copper NIC with external PHY.

Fixes: 02b2a6f91b90 ("net: txgbe: support copper NIC with external PHY")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 2bfe41339c1c..f26946198a2f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -162,7 +162,7 @@ static struct phylink_pcs *txgbe_phylink_mac_select(struct phylink_config *confi
 	struct wx *wx = phylink_to_wx(config);
 	struct txgbe *txgbe = wx->priv;
 
-	if (interface == PHY_INTERFACE_MODE_10GBASER)
+	if (wx->media_type != sp_media_copper)
 		return &txgbe->xpcs->pcs;
 
 	return NULL;
-- 
2.27.0


