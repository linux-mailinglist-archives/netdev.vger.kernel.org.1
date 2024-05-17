Return-Path: <netdev+bounces-96859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5B78C810F
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 08:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59EC282DA3
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 06:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7B14280;
	Fri, 17 May 2024 06:53:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82551427B
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715928820; cv=none; b=dGf5brKu2qvYyIIHwjBwhiYa8K9IEpa8x0tjjXN7FI+BchlWXSU4aBIYPDzIOSIZn9HgukSEYbO7WtrOxcrKWJdhEAUKsyyX29gznN6owDgDAu1S+SzaiTzVJye68qwJHIkTBy2iWumXEgB/QOeUyvUE1Lrnl7fY7a6Zc9HTa6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715928820; c=relaxed/simple;
	bh=Isw9q+lacS4xFR3TdK4BDvDFNIchijuWj8CLDqaEU1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+YTIyhxSfsyhVYZFGKLXwcRUDWAjW3uLXOaVBp38PND0/kHliQmgC/4Ve/CIMScpAONheubBAZMxsMw1zFVI7PNQX9AA/uEu+Od/mabW2Ba7lI0f0mJe01ITzeBsoyD08QDOeONRHnFRAODlc7ehYn9OoeCC7bz72neXDlk3as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz11t1715928719te9poa
X-QQ-Originating-IP: MZ4bwugqRUz7KnyYIva/YiItJpoRr6TQ6LYjx7k6rbs=
Received: from lap-jiawenwu.trustnetic.com ( [115.206.162.36])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 May 2024 14:51:58 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: LXSsMpCYUN7HA4CRdK6OYhhhYU1lh5HMxxDdiNt0eam8Gdxu/8/a/oLNmMGCG
	i6GxOyazy6EYy2gSPQ0ieQkYrNKZ64HZZkvMxrIp8BxhD07NYDm6oo+nVb1WzbnhQJ8URHe
	/gofMd/H7Ni0EpJ+LiQxwBBRhv4G1OzkPJSVAPaBZhh/l80FYwUPYCPPdMZAJi/C98+hp4H
	UfFDIzRy6uD5+bAmgJRD5CBjE9GVOVEWm9YdcSfkpxogfNRS0DZPi7Y62qau4F3AM1FyWic
	fYYi1TNJCj4q4QsgSNF5O2rUpYkU0LjjgRvpedLfXb0iTO/lRtZ/wKYoYRUBtx3nZorRt0f
	SMKookBU1aVICekbIfwS9KTDEttLMBlx9nvwBGcd7hksrmmEuKKwf9OhRj4hOhujO0B2Ymq
	qSJsRTpX5GY3sseC4QOwXQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 18138072189727822758
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v5 1/3] net: wangxun: fix to change Rx features
Date: Fri, 17 May 2024 14:51:38 +0800
Message-Id: <20240517065140.7148-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240517065140.7148-1-jiawenwu@trustnetic.com>
References: <20240517065140.7148-1-jiawenwu@trustnetic.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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


