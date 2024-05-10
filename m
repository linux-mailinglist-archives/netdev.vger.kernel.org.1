Return-Path: <netdev+bounces-95320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA1A8C1DF7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1A1B20BED
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AF614D716;
	Fri, 10 May 2024 06:19:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAEF1494DE
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715321984; cv=none; b=C+9VlMIn18CmpspvYz1bv1lGxxmTDDvCcn6ZRAq7XmuroPMiLFGEooI1z4HQWvQzlmf34WDn5ecsg9ZtqM1TYwPHcmOL1ngndQK3oBx+V7uem4mLeLBxsQrPp9CB9CED5+nrDGF+ldqsN5L/uyl3ZukSDdFbw1c+ygW0vYmAEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715321984; c=relaxed/simple;
	bh=Isw9q+lacS4xFR3TdK4BDvDFNIchijuWj8CLDqaEU1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L2ELgy+MWirp9S5NnkVAOH9r+N0O7dJ3u/JpeLswKizLaKILM+dwQ5gFNqBj5R4qGWI5cKUoUqfRHjrxe8TyXl2aasRBF8GkmgIVZQGUFFpXRF2GSMGkxYkJBagsWyGXshSTKAWqIVClkeCf1FOv+05C5RjxEhVfZCTiLVe+KHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1715321888tckey8ng
X-QQ-Originating-IP: 6fAINNTC4ZgWtB79BbBKJfgJGovAODuO84uvroWuHwA=
Received: from lap-jiawenwu.trustnetic.com ( [183.129.236.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 May 2024 14:18:07 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: DViCT0MMEKzuxsymtl/rwgPyTRomFoM6IQ2FGiEEF+vDj6slirBG70EOrRrsL
	sOu8F67rZz0ElSsNeTz76Bj8hgFDrEF7UaMJgDABbP3UI1yVspa2jxsIUHuuFx4GYGtZfJp
	SNPPDMeRRNSKk5NCe/dVfy7vtoYgI+IiaUjHPytN6wgWv1ubkDUlRjyw9EJndWlHMYsladA
	fTwoL79CFUSO8wW25diWJ3fw7FE02rXFBS1KSHSqCgghbqgaWLHjrPhWYfp9teDZ1J/YCHX
	jUFgAenqMXdpeyxRTJ6TALqOSR77DF8Gyk/ZxeE73J7dQP6+jYobZ8lzrILDp5SBLTXXgRj
	9TCl+58jhKfcMagYvaeHIe4tK4v0g0qY23WUozQ7nJBClqnykyTvfd8E3ol4axgFMy/ywEB
	8o0fhNeSlJo=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16475699613608088825
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
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 1/3] net: wangxun: fix to change Rx features
Date: Fri, 10 May 2024 14:17:49 +0800
Message-Id: <20240510061751.2240-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240510061751.2240-1-jiawenwu@trustnetic.com>
References: <20240510061751.2240-1-jiawenwu@trustnetic.com>
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


