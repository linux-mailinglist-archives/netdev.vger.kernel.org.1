Return-Path: <netdev+bounces-215452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EBAB2EB43
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667B11C85F43
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BAC246332;
	Thu, 21 Aug 2025 02:35:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468441A76DE
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743737; cv=none; b=CotsnIyLbfqjLEqr6BTNddDRrkib3JSMQHGBJWSp/ON2LnAoBk1KATdi3HfB/4H3155ju4DYP6L0uq0i69k+EVPBenUnnhqHD9ZkBRcNbul5Vyj5iPUOshRwIp7R1+gifFzTgmYhs7mv9wZke6/WPYi0ToRAgLCGohnTCDBfJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743737; c=relaxed/simple;
	bh=jnUdPUIMFKVF7SxzQjmOnhFbiuf424/+sxKqR81qgYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LljBsf72Evn17A7jO2ZzfRTaEz6nrsG/pKXJYpgapgUhisIP6pzIuUuryFfEwv+nnYeLafgc73U2cdVI1azzYeXhkVG0U4EheOhygazgz6Rjx+xHZK0JYMvT5UeI6Xd687Qb6sOuTdCQOnzbm5agHUBkUx4cqm2DbbWwmMDwdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz16t1755743671tc1247408
X-QQ-Originating-IP: Ry4hweYoAswEgxlhIJNY8vTcK0d2Zgglq3xx0gFs8Xo=
Received: from lap-jiawenwu.trustnetic.com ( [122.233.175.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 10:34:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14626487224544562233
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
Subject: [PATCH net-next v5 2/4] net: wangxun: limit tx_max_coalesced_frames_irq
Date: Thu, 21 Aug 2025 10:34:06 +0800
Message-Id: <20250821023408.53472-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250821023408.53472-1-jiawenwu@trustnetic.com>
References: <20250821023408.53472-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MRun/5VSKCpATZHN2ngO8UhSCpC4PnqAsFhZEtdopC2e3m2PLpYusN3I
	eaWYClAHET99NiLCe8ITF736tyX6zI+YJ/91jEjIFsX1ENdgyVPYS7gSlECcls8piWCDfLC
	JE0GY4I6PAeakj7Jilyrk58tw2kj9JedboWwT3mGRxpD9CIhWdlZXtmAFuNCCMnZLXfz8mx
	jZGqsFQe6Ss5hx5kP7ndH5u8AflUuatfJ+wdvRzC77SZ9bqhZgI5lTW+EsK1Sjbeuvuks/A
	sm+bHuVwlp+gq8nUC2ilBwLfNAmwzgedVONV8iLjw7aZPScCvQ2NZSWtMZu6Q8qCOUBU5Rl
	ahu9NYyaOcwA/cgqbSa4AYAQWfXeryn4Wr5/GAwzamCSzkjAP3Ng9aEt1rHMJRoBoOn85GH
	MZ9DRDuqHl4VBvGZiDE3+EAupDq2SDlXOQ+9O/KH0i3rpwdqRK0MKQL1GsfHxP7onRuSyXr
	8CpVqQ3iKmjBmlWxblbsaTtbK9Qge/oRKFQEyAMtAiMvKYFv0vgKgxvw4ApRybTyt/pvk/A
	fMMbPxFJxW9d0mu9OLbldBugApJaXnnWOf5CBs86tmz9ZLPMrki/IaKobxp4iIdYnFuYg0w
	1up8Xph57UC23E4/dIUNEROYrDmXCun5e1L3hcFmgR38JyF1K68c5EOEyHIQ6628cnXuqb2
	iOvzhaSG3xuFzoX2Y8nCq9pSv9qVJj8rqW9wvdiNIta0jUNczOIXve+ZjrtvXb4MJy7U5hE
	36koJ14pe8B/YFnWIw4ee3Slj5MJpcUj4tTCWs2z1mwLQHQeQZa7kQYQFCm8Memv46DI8iX
	n22a3LwswB9zXjgfTqd0Y6PjFuMsC/XcOwQHO6iJLzoUn558iGFejpuTjvOYwJSvXuP3AHJ
	Okrm6LBQ89jBFpeyj/L1Mv/Syw8aGzcbMW2k5MmmcRWrLKGKIDO22/LIPgphzIdpTZMoWT/
	1RDGRn0R0LkqoSdpC0wkR+IisIA2vXDXPKpkS5+qezr36SGXJWUZB0vJGZ7Fw0tWYLnS1Jr
	X2reulWP8tjzgQU7CYgLuZQRozDtX+1uuNA6UgRmnWINQGWU8gVR4jrhM9Chtxo2KQ5Fm/S
	Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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


