Return-Path: <netdev+bounces-101772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2BA900043
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3856D1C20E26
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A404C15F303;
	Fri,  7 Jun 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Lh0rEY/A"
X-Original-To: netdev@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B7B15CD7D;
	Fri,  7 Jun 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754628; cv=none; b=GNcbysluJZ+HzYaj0g4Y8/ETOtE863Z+QEBHtBxb50yLZm5rw1VcUSq99kN/Mx69m0Zzc6+TXc8mxgYQDxkN0ofkGz+TmdzkzOk4eRy1Y4gw7GV+AJKYpWeMobmFWNWdDgsrh9Iv+GROBElUf9mPyaiWhOR4dUaXKbQuxVgMEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754628; c=relaxed/simple;
	bh=rLfqKnBrl/JeZDlnCLR6XMpnZNF7Dk5Orfjdv9CwB+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=moJ28iIgjtfp2CBFNYaZJfjWWMzTWltmElrzAeXZ86VlbHyMNvhyLYL+eV/VyrlGuvMGAVkkTlNnvPBn8LbUKr6+dSAdsaIDN+kvk9XW1XeaB2N8a6x5WnSQPjE9DeW5wjBNDVtgB+5emq+v4O3ylOBHPThtr7t90Vol3r74EUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Lh0rEY/A; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ezWsI
	hM4Hh8p+QSv6p+yh190SDsAVLFSlr3UVPG0n3g=; b=Lh0rEY/Avpk51PMZDnOiN
	DP7nOigge3P2OsGu31V4U3KIVXPrE/mZOcH21tNQP4uCbu6js2/HLKq2bplKqFN/
	7+ypgabAtjWanzK6XlGN8fAnk1SMAUQrmdkOeZRwmR6NFeJrz2gg3+wZzdvq9lSu
	Gn4d2zV/JfGZqFhFbMDPRw=
Received: from localhost.localdomain (unknown [112.97.63.251])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3fxzf2mJm_EwiBw--.9011S2;
	Fri, 07 Jun 2024 18:03:12 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v1 2/2] net: wwan: Fix SDX72 ping failure issue
Date: Fri,  7 Jun 2024 18:03:09 +0800
Message-Id: <20240607100309.453122-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fxzf2mJm_EwiBw--.9011S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7JFWkWFy7JF4xXF1kZryUAwb_yoW8Jr4rpa
	yUKFZIkrWxJ3yUWw4UJayaqFy5ua1qg34ak3yUuwnYqrn0vry3AFZ3XFyUJw1Yya4kAr4U
	CFy8Ary3Xa1kCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRLYFAUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJRP2ZGVOBlO3YwABsP

For SDX72 MBIM device, it starts data mux id from 112 instead of 0.
This would lead to device can't ping outside successfully.
Also MBIM side would report "bad packet session (112)".
So we add a link id default value for these SDX72 products which
works in MBIM mode.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/net/wwan/mhi_wwan_mbim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 3f72ae943b29..4ca5c845394b 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -618,7 +618,8 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
 	mbim->rx_queue_sz = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
 
 	/* Register wwan link ops with MHI controller representing WWAN instance */
-	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim, 0);
+	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim,
+		mhi_dev->mhi_cntrl->link_id ? mhi_dev->mhi_cntrl->link_id : 0);
 }
 
 static void mhi_mbim_remove(struct mhi_device *mhi_dev)
-- 
2.25.1


