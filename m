Return-Path: <netdev+bounces-212720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BEBB21A67
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC1F1A25C7F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA722D8798;
	Tue, 12 Aug 2025 01:52:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3FF212B05
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963520; cv=none; b=LSfUPc5NXsmHg33mK0E4QRq7jPH6qImm1zpxH58RyLsEX95deHrFpZ+jYMLzRkjfRZBrFk+k3hFHLRgfWbGe492pais1SjbHtkGib6xGMyFsaDMSagcdAcP0ScIdo2KDx8t1gpS9msA5azOvtCfL54/Jg9evujI4gBqumN0HIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963520; c=relaxed/simple;
	bh=jnUdPUIMFKVF7SxzQjmOnhFbiuf424/+sxKqR81qgYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRJ/rrVOH2sza6fannBvJ1GrKtRj49hsfdj1efTv4gPVLXw4J8DBDpzVl9UE383A7+rMfxizFgaollzHY0BG9rV89CUF9fVnmFUl0zSDaspXwIMTHAf7qgr1DdosUFJCB/FS5CpQAIvxjhFwz2fEIPtYK/FI10fVZ2CPtIfuvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1754963443tf857f099
X-QQ-Originating-IP: KHfAFLT8LDXLCOvR52wiwIj+XHkX63B+IKfFBWVmktw=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.182.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 09:50:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14266096083781844644
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 2/4] net: wangxun: limit tx_max_coalesced_frames_irq
Date: Tue, 12 Aug 2025 09:50:21 +0800
Message-Id: <20250812015023.12876-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250812015023.12876-1-jiawenwu@trustnetic.com>
References: <20250812015023.12876-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NSQm2ODd9qLZ1jrEdsF6Wspm6h6dJTQ5B310sqTQvpGODhx0nAqMuCth
	rs45cq/4zpKcO9fQaifDWkBdK4vheovhQgMR77fbAcwF8FB0iFX0Kz79mI1MQtT18ri+Zez
	9GUw4DsLW7GRghdGFrYz8DVHWoMuHBVUb82ai/joBISSJZz0zNA1CsPz4hAPVPguqhODO5J
	C4V7uBy6MPl6Q8yt2e2Y7vblgCjVpYCx0PGxrEVdQi7KxTb9N3jRdRT2eAkq8nOOFfusSvM
	JB+dh/FriJKyceUdwn4SqC0Df8Mnnw+LF8xxS5VCnOJ/sh0BuKCNUpoUOjsJLWzZQviqJqj
	bxhpW+3AR7aJa6IdGJrjxCv4R5xaf+zlWnbyI90dXwPfelOEYIEVJ/PyBC86M+lP/8H8TZ9
	crGHs8hyOZYK2gPmakNxSQW6VI2OuTpzaZBjrRao769e3jnUCdZl6Eoq1pvnceNtA7D7TjR
	vIlihbX70CeJiz2ECO0adGFJ/VbiSAhfnEN+XyfuOuEFvr85UkCJP5t9VeUFdmzYnZKJaTM
	P/TFT5NR+FvOhhqcycrMU1bvQ5amVltivcP/eXdczMkNN1wSk9R5Pow/B8sKoeiobyq/8pC
	FJsPKe4YXSVqdkMYOTjoAgce98ZLZ3hRYmpzuzXezM3HETKcTd8qGCn4LNKQ6+RQ8wAqkQ1
	JY8EeNdxx5onXsDv0o3FfG20qJ1YadXZZwBgyid7XldLvGFZayO66X/XZTNZL+YiVUZz1m5
	Yht1FR2oPLWOEK/Hn3d6ob7LoHpdXEDPd4f9Xo3j7rrAEkML7qRM4oYPGiSdDhQxu0OVdG+
	VKWCMPOFyqbvVNIcG0NL4cEcCzRj7T3oMOmqOjE1Mgc5S1LRXG4wiZABPq02++L5I8q6KF0
	n2XEP/7NCAHHBksD5+7qeQxU9j1fKFVAq+ESiOTeuOC83M4J0RI2qAAXls0H/QmkpQrpjeP
	sIMT+fuGAczsnsidIVcccB5DLZtyiUktJdPg+zyQE9zy7IJlLJe+i+9heFsSrDvhju3wtR3
	DtA3909h/hM5p0y7J6ZQF3dI2zWgnNXiLEuvtp6Y/aHyr1RGQG
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Add limitation on tx_max_coalesced_frames_irq as 0 ~ 65535, because
'wx->tx_work_limit' is declared as a member of type u16.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index d9412e55b5b2..590a5901cf77 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -334,8 +334,11 @@ int wx_set_coalesce(struct net_device *netdev,
 			return -EOPNOTSUPP;
 	}
 
-	if (ec->tx_max_coalesced_frames_irq)
-		wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
+	if (ec->tx_max_coalesced_frames_irq > U16_MAX  ||
+	    !ec->tx_max_coalesced_frames_irq)
+		return -EINVAL;
+
+	wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
 
 	switch (wx->mac.type) {
 	case wx_mac_sp:
-- 
2.48.1


