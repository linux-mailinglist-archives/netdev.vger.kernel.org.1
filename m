Return-Path: <netdev+bounces-301078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aCPgNHciOWpVnQcAu9opvQ
	(envelope-from <netdev+bounces-301078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:54:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47C6AF3B4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:54:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301078-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301078-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECAFB300E29F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A0C2E2DF2;
	Mon, 22 Jun 2026 11:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBBE2E040D;
	Mon, 22 Jun 2026 11:54:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129264; cv=none; b=Xc7hCS3R33nv+syCU+/msFWqvc3kQvQwZpHTpK9YHBHh5lL6KslMahR2YTy3tGLKNJOF4M9bGA3ltxIyWEnWF0yHrkmfRn+UeK+bh0hFACBSmnGdRu9TwrCjJH3A3GdbCVTQke/ZVXMbRNGZZF4dzvTwOUxyFOaFblrvB0lMes4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129264; c=relaxed/simple;
	bh=zb21KzLXAgnRALbkzFvdIAa5XrZDwTtMTqswp9or0Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W0tk8UHEv+SaXMwWXhyuxsXHLDtixoKIla0MeUIPKJ+11qZME72HsbPmHQeM4U0t5GxOCxHRG5CN0kelW2IwfHxIgZmtocmpxNPFkjyUS/tTAnCLE/lB+V1AMp3w9xasKxFCUSOqilFcrs5egkCuEKfZ7BRWWdCtUEbadDOIovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [117.182.74.238])
	by APP-03 (Coremail) with SMTP id rQCowACXdZxeIjlqRYqGFQ--.43340S2;
	Mon, 22 Jun 2026 19:54:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v2] net: mdio: airoha: fix reset control leak in error path
Date: Mon, 22 Jun 2026 19:54:03 +0800
Message-Id: <20260622115403.39772-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXdZxeIjlqRYqGFQ--.43340S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy7uFWUAw17Cr15XF4kXrb_yoW8Xr48pr
	4jk34ayFWUtr4rJay8Aw4rZasI93Zxta4UGrZIv3ySvr1fGrW7XrW2yFyvgFyUCFW0qry5
	Cr42ya18uF4DA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoGA2o43cr+VwAAsk
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301078-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sto.lore.kernel.org:server fail,iscas.ac.cn:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E47C6AF3B4

In airoha_mdio_probe(), after calling reset_control_deassert(),
if clk_set_rate() fails, the function returns immediately without
calling reset_control_assert(). This leaves the reset line
deasserted and causes a reference count leak on shared reset
controllers.

Fix this by reorganizing the error handling to use a goto label,
ensuring reset_control_assert() is called on all error paths
before returning.

Also add error checking for reset_control_deassert().
Fixes: 67e3ba978361 ("net: mdio: Add MDIO bus controller for Airoha AN7583")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/mdio/mdio-airoha.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mdio/mdio-airoha.c b/drivers/net/mdio/mdio-airoha.c
index 52e7475121ea..4c1b2415687c 100644
--- a/drivers/net/mdio/mdio-airoha.c
+++ b/drivers/net/mdio/mdio-airoha.c
@@ -246,15 +246,17 @@ static int airoha_mdio_probe(struct platform_device *pdev)
 
 	ret = clk_set_rate(priv->clk, freq);
 	if (ret)
-		return ret;
+		goto err_reset_assert;
 
 	ret = devm_of_mdiobus_register(dev, bus, dev->of_node);
-	if (ret) {
-		reset_control_assert(priv->reset);
-		return ret;
-	}
+	if (ret)
+		goto err_reset_assert;
 
 	return 0;
+
+err_reset_assert:
+	reset_control_assert(priv->reset);
+	return ret;
 }
 
 static const struct of_device_id airoha_mdio_dt_ids[] = {
-- 
2.39.5 (Apple Git-154)


