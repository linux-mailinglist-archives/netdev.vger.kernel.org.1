Return-Path: <netdev+bounces-159823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F015CA170EE
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 18:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C2D165978
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B461E98FA;
	Mon, 20 Jan 2025 17:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1351494CC;
	Mon, 20 Jan 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737392460; cv=none; b=dr6gLe0SgBWHeTmVqHZ2TY4ApH3IwomdFfqeM/ktGjlKCbY5g1Jo5yq1f4cRNpEAwA2OJh9FCrSCth1G8UfTt1qD3pCgrPt38uWnkXIfkL8+jpwwM22tzJEEX/iI1e0s274DFVxLeq7QniuS68MF9iSUklLxb8YTwlB8kc7P2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737392460; c=relaxed/simple;
	bh=1F0Ehs/r8JdKDfeHpnYmVhwcJ8E1h9i7owVErbWz3sY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DnVMu52m4PG/QwyCaW49Z/KuHOmjakceRUW3PMGFZK105ZnOiOnTqP54ik7DX9BD/RQphPKPfUWO8+INejRmt7UeYd28ReU3v/2e8GcOj2Goiorf7a93d/z2WKmT6XHHl/f8JYfbKdTQvSiJ72Pqnl0LCxhuz6jFWOFtavX7ruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [220.197.236.33])
	by APP-01 (Coremail) with SMTP id qwCowABXXtI6gY5n3d1qCA--.65459S2;
	Tue, 21 Jan 2025 01:00:47 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniele Palmas <dnlplm@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] net: usb: qmi_wwan: Add error handling for usbnet_get_ethernet_addr
Date: Tue, 21 Jan 2025 01:00:26 +0800
Message-ID: <20250120170026.1880-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXXtI6gY5n3d1qCA--.65459S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKw4fAw1fGFy5uF1fuF1xXwb_yoW8Jr4DpF
	WUGay8ZF97XrW5Ja4UA3y8Cay5Zw4vkryDCFy7Cws3ur9rA3W7GrWj9a4fKa4UKFW8G3W3
	CF4DCrs8WFs8GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYIA2eOJZ7AQQAAsS

In qmi_wwan_bind(), usbnet_get_ethernet_addr() is called
without error handling, risking unnoticed failures and
inconsistent behavior compared to other parts of the code.

Fix this issue by adding an error handling for the
usbnet_get_ethernet_addr(), improving code robustness.

Fixes: 423ce8caab7e ("net: usb: qmi_wwan: New driver for Huawei QMI based WWAN devices")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/usb/qmi_wwan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index e9208a8d2bfa..7aa576bfe76b 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -779,7 +779,9 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
 	/* errors aren't fatal - we can live with the dynamic address */
 	if (cdc_ether && cdc_ether->wMaxSegmentSize) {
 		dev->hard_mtu = le16_to_cpu(cdc_ether->wMaxSegmentSize);
-		usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
+		status = usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
+		if (status < 0)
+			goto err;
 	}
 
 	/* claim data interface and set it up */
-- 
2.42.0.windows.2


