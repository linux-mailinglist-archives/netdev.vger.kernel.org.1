Return-Path: <netdev+bounces-92083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A918B554C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE4F284EF1
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9F374C1;
	Mon, 29 Apr 2024 10:27:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29A5382
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386461; cv=none; b=khT2BGstMV7X7/b17vteRUR72Dj72ew/WlmQtosN+82DsZPelPuBvml1wjb+5UbCNk7GTZ1VnCvuuTUfmfkgx/CIrsgUJfFX4mVoXf/0j4f2ERFpvO663I+mJY8vFi9MCNJYMY86BV/Jdi7zpHBhWDvSnKP3EZeLaEmv9ZN7cGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386461; c=relaxed/simple;
	bh=c1Pvz5bor76UIC4G1W7Qtphp4AFswvnk4C9b4WNAvew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stZZQW3NNQiKTA5RmSR/L7HWiVoCZ15rNGW2PPmISPEVi6otQIS/gIXsKhCR1fH45360oJ9SvQyp+uNdViE57NmzP9z6A8+dinsUuMhCzZ6d18ezBzRNbbdGyqhvVoOo42DcvlXOvtQbiwURKK6pk1VYqc5HKLRS8NG/302+hC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz15t1714386343tnpm2c
X-QQ-Originating-IP: sDTphYgYByCuezisPuKCWedjhJx9mRnKKtBlGzCp3UU=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.150.70])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Apr 2024 18:25:42 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: H21jX+7aWYbN+T+OTv7ttKspaXt9NCa/0BwwC97zjb7M1WyFn4S83wDGy1RC+
	j1wBAUYNRcoVPitC3395ksMur7GbjQdIl/ptDE7rXU8OFPumq11rmoTguk72ZEDjs9ZZUHX
	zglTUi3wDYKfTlq5uvlp2EXEI8PwovIvc8+/z7wq5L1R41/zu3F8zqOuUMJHyKTorSHjurn
	/4elmQXf4ad6pspO/R5qwHVJ4u/4fES6swW/9d9kbOFe1VVTt4wclrwLpoPCqUDphOXLGLY
	0vddjvV8B+//vbxLHm0eVlqTAvYmOJrhqVlb0w0YJH42MHxxytxxSAWiVONirxTEu6p5xo8
	iFNuobynzt0kBmubOIHyBQ5U9+zwCo6nIi14txL10y+VYv+lNa47FZlJEuLVjxf8vYkyr2p
	x83xyUevZGUnoy3EngNVBQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1081951874092602875
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
Subject: [PATCH net v2 2/4] net: wangxun: fix to change Rx features
Date: Mon, 29 Apr 2024 18:25:17 +0800
Message-Id: <20240429102519.25096-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240429102519.25096-1-jiawenwu@trustnetic.com>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Fix the issue where some Rx features cannot be changed.

When using ethtool -K to turn off rx offload, it returns error and
displays "Could not change any device features". And netdev->features
is not assigned a new value to actually configure the hardware.

Fixes: 6dbedcffcf54 ("net: libwx: Implement xx_set_features ops")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 6fae161cbcb8..667a5675998c 100644
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


