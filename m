Return-Path: <netdev+bounces-88191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE48A63C8
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9E8284467
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 06:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AC46CDAC;
	Tue, 16 Apr 2024 06:32:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E106CDB9
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249155; cv=none; b=h1kUcaHnnc8mGtBraLfw0kf4iDqq4SOBTFSPk3Gk1FRWAnA80be9jPAh8+oQ9IVx3M6uEiSZLCi8wEx19HpMau0KeRzOFHVW9+tq2iDv76+GbBgqsf/VbN3QVHoyVUBlw/PO3u+0nkdCLSR1tw279LyVd51HQ3cvWeQND910x9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249155; c=relaxed/simple;
	bh=9Vc71un514p74x18MImyplPgW3gmr/ZFsOoF7D/k5Hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoJJ50BZp69Nc7RZ6XJLM6KJYSYEoV7vRFN8XT/io/bwlBSSeo0eoKaCYAUOBkHf6FhhrFfUEnjlVtfM7sycFLatw9Si+4gsED0x1ddv83r2HDQIpxLwhaK8xv9yCN3dBZqJPc5gmR8e8U87GeJUiE7GOVuXHBlYmVtJsWxumMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1713249016tuhlww3k
X-QQ-Originating-IP: GhTBCQNHGnDOXHKa5vE6fGaGAxBW5MKgVpNTE8EEn40=
Received: from lap-jiawenwu.trustnetic.com ( [125.119.246.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 14:30:15 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: ixaqywFXUt+DpjwdxfM/94ROoUDHF/V8xc4CCC6hEDuQj9MxkEYw0c3/tyAoM
	VVPmzo5Cpc5+UpKh13gUQJ+BddGaDBW5h9AvQM2O537vWUwJJHP53MCGUpJy4IgDtdjMY+T
	nXOuKbcVfFDGqOPQEdrkitDo8aN2BSuOp40dbgN/1+NmhbTBiLn+ZZ+/cMRFF3RmFk/y3Wg
	82pPv2p6KYFMa7ey9TzufrU6EQoS6sv/QafOS30qubagqYQRbph+LVya55SpNlWCwdLHBVA
	GchZVSwYWHl3rXfoa0b3xp0h3MxRGmu5ejB0XzYxbf1C77s1zBL0KSwxEv+ejpofrPqpq44
	YV7dQAu0J1+NxgX2eO5O5qeIwmuHB3y1Ojo3mHPLGHBOZ7mltMHHIgHonkXfPi8lBtnh4my
	gfCvlzXXIPY=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13933789540555387258
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net 3/5] net: wangxun: fix to change Rx features
Date: Tue, 16 Apr 2024 14:29:50 +0800
Message-Id: <20240416062952.14196-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240416062952.14196-1-jiawenwu@trustnetic.com>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Fix the issue where some Rx features cannot be changed.

Fixes: 6dbedcffcf54 ("net: libwx: Implement xx_set_features ops")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 6dff2c85682d..5c511feb97f2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2690,12 +2690,14 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 		wx->rss_enabled = false;
 	}
 
+	netdev->features = features;
+
 	if (changed &
 	    (NETIF_F_HW_VLAN_CTAG_RX |
 	     NETIF_F_HW_VLAN_STAG_RX))
 		wx_set_rx_mode(netdev);
 
-	return 1;
+	return 0;
 }
 EXPORT_SYMBOL(wx_set_features);
 
-- 
2.27.0


