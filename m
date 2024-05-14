Return-Path: <netdev+bounces-96281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE8F8C4CF6
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE434284098
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EDC381B1;
	Tue, 14 May 2024 07:25:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5AB39FCE
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671541; cv=none; b=W+mHQJNCf3LLYXj918jQxEKlnWnSXbMTzXqFbLZ5caCJe2/Dh7gAxvKbetHqhR7ZK9osygIxeS7jsQVib+j+JB0oR4wZfigbCXXssMZRAa4RF5m35qbPHd3miZHS/FPNVhXvOb2OR7NA22tBi6tPtyliKPuhgKxfwRuYJ1WRaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671541; c=relaxed/simple;
	bh=Isw9q+lacS4xFR3TdK4BDvDFNIchijuWj8CLDqaEU1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+6aWxDkwxMPrpMCGPpgBgWwXF/lxlDwFG3gisc3DPGJPZRqKqUj0fG4ZvQMAdwku5cqQX59/jcB0gQOTNvjkoeKLU27M/EsG//Gh5H9xmSlWUa2gx4ocBMfRitjDeME698VwgkZmwD2tM5FMhNWcJAeh99qzctbkMfYrXnmdjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz14t1715671420tobp19
X-QQ-Originating-IP: 9Vrs1OP/Nk5ZtDKNEuN+p3btJZPJgmCBqAPhcfqpzxY=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.144.133])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 May 2024 15:23:39 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: i0EHDzjvW2yTfpQHVZzBcRZrNmIPQ0zFofRDdbV2whwmwGGVhlAGo7AgbDBVk
	cFOx431GFe7LvqI7XPtFb0NcPJbBBcVjsifOUKeIguy6XuhRgyF6NrmQA/x4GD7CIRyygKl
	9nxrlLIyBVjbmeoLs6PqmjteqCktI0wVhNbg7nxtXfgYmTy0jbbLMHEUDjrziEWVQpx1Efm
	N05kRPDkcX5knAZn7j11L/7AlmcLp0DLK2K9TGJ9Q9mB2SywM/rltz2sgWmfKJS2ogdgR0M
	I78vBXPQ1LvStuS+59i/34kOCS3s4gnMIosfrOdVgeHwZiD0q1FMk7NC3wCkU5f23J3U64g
	KlUK5OOZib12BdmyL3HPA0eU3sX0Q6L0ILe37v0pKFaWajqCrfnbSZTm+h9LnhtRO8PD6cK
	f8bXbmqM1Yw=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5943675560058408365
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
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 1/3] net: wangxun: fix to change Rx features
Date: Tue, 14 May 2024 15:23:28 +0800
Message-Id: <20240514072330.14340-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240514072330.14340-1-jiawenwu@trustnetic.com>
References: <20240514072330.14340-1-jiawenwu@trustnetic.com>
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


