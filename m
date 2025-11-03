Return-Path: <netdev+bounces-235014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBFFC2B469
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709EE1893CA7
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A9630215B;
	Mon,  3 Nov 2025 11:19:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F152FF66D;
	Mon,  3 Nov 2025 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168743; cv=none; b=Dzx6OihTa+zMvYS5QfCaRQrruCUsrCvU04p9TjgEgmHo7qeQFHg5qKZAV6MmfwtJrTVAnvmfA1bYV17m/7Z+IlP3QyeN7iS0q/Y/LAKzIOIcmcuOjWy4M8Co7cdTDSFDE79nZpSTHqKXkGuqkekGirDlypxcwJifwzQELEe5LGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168743; c=relaxed/simple;
	bh=fNrIgV1o+9irXV/ZRLy8p0aur9okmV7+4DLYLSB7u8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5VdqUX+OlHCtolLYtyPxoIhekoWZRIgUb0aU8cxi326m3jR9duzte9n3mavPYxLbd8TKL1Ug0uqN1Zj3fzG6zYxNvHkc6jsQNkUjhzjM7mB75qRRd0GrnD4s9V9kT/ow7MVUBpnwCWezrlu5UEQmnaCE/JGwQYB6AwNjfBBmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAC3JfSWjwhpZ7I6AQ--.23373S2;
	Mon, 03 Nov 2025 19:18:47 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Herve Codina <herve.codina@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] net: wan: framer: pef2256: Fix missing mfd_remove_devices() call
Date: Mon,  3 Nov 2025 19:18:44 +0800
Message-ID: <20251103111844.271-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3JfSWjwhpZ7I6AQ--.23373S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1xJrW8urW7tw1UAF4UCFg_yoW8ZFyrpw
	43Aa909ry5Jw48W34xZ3Z5uFy5Awn7K3W0grWxu3s3ur98AFWUW348ZFy2yw45GrWxta13
	JFWxJF1rCF98JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb8hL5UUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkPA2kISHP2FwAAs5

The driver calls mfd_add_devices() but fails to call mfd_remove_devices()
in error paths after successful MFD device registration and in the remove
function. This leads to resource leaks where MFD child devices are not
properly unregistered.

Add mfd_remove_devices() call in the error path after mfd_add_devices()
succeeds, and add the missing mfd_remove_devices() call in pef2256_remove()
to properly clean up MFD devices.

Fixes: c96e976d9a05 ("net: wan: framer: Add support for the Lantiq PEF2256 framer")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/net/wan/framer/pef2256/pef2256.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wan/framer/pef2256/pef2256.c b/drivers/net/wan/framer/pef2256/pef2256.c
index 1e4c8e85d598..d43fbf9bb27d 100644
--- a/drivers/net/wan/framer/pef2256/pef2256.c
+++ b/drivers/net/wan/framer/pef2256/pef2256.c
@@ -821,27 +821,34 @@ static int pef2256_probe(struct platform_device *pdev)
 
 	ret = pef2256_setup_e1(pef2256);
 	if (ret)
-		return ret;
+		goto err_mfd_remove;
 
 	framer_provider = devm_framer_provider_of_register(pef2256->dev,
 							   framer_provider_simple_of_xlate);
-	if (IS_ERR(framer_provider))
-		return PTR_ERR(framer_provider);
+	if (IS_ERR(framer_provider)) {
+		ret = PTR_ERR(framer_provider);
+		goto err_mfd_remove;
+	}
 
 	/* Add audio devices */
 	ret = pef2256_add_audio_devices(pef2256);
 	if (ret < 0) {
 		dev_err(pef2256->dev, "add audio devices failed (%d)\n", ret);
-		return ret;
+		goto err_mfd_remove;
 	}
 
 	return 0;
+
+err_mfd_remove:
+	mfd_remove_devices(pef2256->dev);
+	return ret;
 }
 
 static void pef2256_remove(struct platform_device *pdev)
 {
 	struct pef2256 *pef2256 = platform_get_drvdata(pdev);
 
+	mfd_remove_devices(pef2256->dev);
 	/* Disable interrupts */
 	pef2256_write8(pef2256, PEF2256_IMR0, 0xff);
 	pef2256_write8(pef2256, PEF2256_IMR1, 0xff);
-- 
2.50.1.windows.1


