Return-Path: <netdev+bounces-235074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC7AC2BBD3
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 13:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49F88345853
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7152F2D323D;
	Mon,  3 Nov 2025 12:38:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51328EA56;
	Mon,  3 Nov 2025 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173487; cv=none; b=IszigxUHGwowuojacmBL+jEK5EUmP3pT1kZv8WotI73MQga7Zl4PZ+9rclAw6e9LZqLG3cEcMfvSQVi8MYjA1THtz8E1tKj12TqoUh59RurN1Svtvujn6ovZmvCTZ8Ts7715/Fq+/C0ksqsff/Z3xyq0CAvv9yzggjn6h388QVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173487; c=relaxed/simple;
	bh=6g3+T2jQ7KEd3azolW+M64sXtwp3Q4SlTlLhI8uimYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIfpVNRivvQU5bHz7OUvaAk1qNMB489UK5MHoAgmQvPqJULleRSaevIg+LGjpt31H3YlSdsXMGTOdd+/YQHYpLcr5XI4C/n+mAUBveuFu0zGQt0SL4fngdayBN8JaKTr7fJnZGuhKk8T/eBj2jkZsqCExtbRVree1feIujxDpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [114.245.38.183])
	by APP-05 (Coremail) with SMTP id zQCowABXwvAfoghpvcs8AQ--.25013S2;
	Mon, 03 Nov 2025 20:37:51 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: herve.codina@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	thomas.petazzoni@bootlin.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v2] net: wan: framer: pef2256: Switch to devm_mfd_add_devices()
Date: Mon,  3 Nov 2025 20:37:41 +0800
Message-ID: <20251103123741.721-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20251103111844.271-1-vulab@iscas.ac.cn>
References: <20251103111844.271-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXwvAfoghpvcs8AQ--.25013S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1xJrW3KFyxXryrZry3XFb_yoW8GF1Dpw
	47Aa9YkrW5Gw40k3WUZw4xuFyrX3Z2k3WxWr4UXrya9w45JFWrtryUWF12yw45J3yxJa17
	XFWftryrCFn8W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4PA2kIkWweoAABso

The driver calls mfd_add_devices() but fails to call mfd_remove_devices()
in error paths after successful MFD device registration and in the remove
function. This leads to resource leaks where MFD child devices are not
properly unregistered.

Replace mfd_add_devices with devm_mfd_add_devices to automatically
manage the device resources.

Fixes: c96e976d9a05 ("net: wan: framer: Add support for the Lantiq PEF2256 framer")
Suggested-by: Herve Codina<herve.codina@bootlin.com>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
Changes in v2:
  - Use devm_mfd_add_devices() instead of manual cleanup
---
 drivers/net/wan/framer/pef2256/pef2256.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/framer/pef2256/pef2256.c b/drivers/net/wan/framer/pef2256/pef2256.c
index 1e4c8e85d598..4f4433560964 100644
--- a/drivers/net/wan/framer/pef2256/pef2256.c
+++ b/drivers/net/wan/framer/pef2256/pef2256.c
@@ -812,7 +812,7 @@ static int pef2256_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pef2256);
 
-	ret = mfd_add_devices(pef2256->dev, 0, pef2256_devs,
+	ret = devm_mfd_add_devices(pef2256->dev, 0, pef2256_devs,
 			      ARRAY_SIZE(pef2256_devs), NULL, 0, NULL);
 	if (ret) {
 		dev_err(pef2256->dev, "add devices failed (%d)\n", ret);
-- 
2.50.1.windows.1


