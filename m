Return-Path: <netdev+bounces-235705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C171C33E06
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 04:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D6C189DD01
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 03:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC5E223DF9;
	Wed,  5 Nov 2025 03:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CEC2A1BF;
	Wed,  5 Nov 2025 03:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314504; cv=none; b=PpKF/P/aAo2S3pF7COxh43X/Q69d8hqyvxFL+ZQ3GIcWW3SFcXUg4u4O75g6V8FcURFZ1iaNUwOjW/I9ZNEkkJBlYh3gWPi6L+m/baIjJf7y1YJgnKpaSTWathyE2EuNGQrzyyveRPuJoyo7waDKJI6taw/Fw6HtryQx8oZWZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314504; c=relaxed/simple;
	bh=XANd4G32AqWyVQdfBYh557uL85JORhL8u3ZtOFm0xYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ad1lPq9ruJ8quRR2eIMksSpcyzpsiYmkbRNv+6Bv7LAK41LfRyFvRpcxFe972KhqFCQKov3io8lxMOcV5vc8eHHlUATgCMwwATTqZzve8lW0GU0r72fEsWaZWDnAAKR/hwhITd3upaktmPbcs0toWFvWvpbc9WTCXJWYGjq1PxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAHse_0yAppzc2TAQ--.26348S2;
	Wed, 05 Nov 2025 11:48:05 +0800 (CST)
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
Subject: [PATCH v3] net: wan: framer: pef2256: Switch to devm_mfd_add_devices()
Date: Wed,  5 Nov 2025 11:47:16 +0800
Message-ID: <20251105034716.662-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:zQCowAAHse_0yAppzc2TAQ--.26348S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1xJrW3KFyxXryrurWDtwb_yoW8ZF18p3
	47Aa90yry5Jw48K3WUZw4xWFyrX3Z2k3WxJr4UZ34a9r45XFW5t34UXF12ya1UJrWxGa17
	XF4fKrWfCF1DX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUonmRUU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRARA2kKtTRV4wACsd

The driver calls mfd_add_devices() but fails to call mfd_remove_devices()
in error paths after successful MFD device registration and in the remove
function. This leads to resource leaks where MFD child devices are not
properly unregistered.

Replace mfd_add_devices with devm_mfd_add_devices to automatically
manage the device resources.

Fixes: c96e976d9a05 ("net: wan: framer: Add support for the Lantiq PEF2256 framer")
Suggested-by: Herve Codina <herve.codina@bootlin.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
Changes in v3:
  - Also replace mfd_add_devices() with devm_mfd_add_devices()
    in pef2256_add_audio_devices(), which was overlooked by
    previous patch.
Changes in v2:
  - Use devm_mfd_add_devices() instead of manual cleanup.
---
---
 drivers/net/wan/framer/pef2256/pef2256.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/framer/pef2256/pef2256.c b/drivers/net/wan/framer/pef2256/pef2256.c
index 1e4c8e85d598..180edde177c6 100644
--- a/drivers/net/wan/framer/pef2256/pef2256.c
+++ b/drivers/net/wan/framer/pef2256/pef2256.c
@@ -637,7 +637,7 @@ static int pef2256_add_audio_devices(struct pef2256 *pef2256)
 		audio_devs[i].id = i;
 	}
 
-	ret = mfd_add_devices(pef2256->dev, 0, audio_devs, count, NULL, 0, NULL);
+	ret = devm_mfd_add_devices(pef2256->dev, 0, audio_devs, count, NULL, 0, NULL);
 	kfree(audio_devs);
 	return ret;
 }
@@ -812,8 +812,8 @@ static int pef2256_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pef2256);
 
-	ret = mfd_add_devices(pef2256->dev, 0, pef2256_devs,
-			      ARRAY_SIZE(pef2256_devs), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(pef2256->dev, 0, pef2256_devs,
+				   ARRAY_SIZE(pef2256_devs), NULL, 0, NULL);
 	if (ret) {
 		dev_err(pef2256->dev, "add devices failed (%d)\n", ret);
 		return ret;
-- 
2.50.1.windows.1


