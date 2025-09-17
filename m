Return-Path: <netdev+bounces-223867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A5B7EB0B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544C5521373
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 06:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AC82798E8;
	Wed, 17 Sep 2025 06:50:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2D23D281;
	Wed, 17 Sep 2025 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091837; cv=none; b=tiENIeOoexcaSYgjY+SaFwLattdZbdLXLAVn5lhj5vkP34wzPewONH1KP+hvTyWtpW+mQrPVRDXtUieLHs34bZZN1Hqd9y+n/1Q9q/NUVCIOdLPjzAykCb1a33wJe876N+apRmvN+Nhj8IRz6ECxub4owejZLW14pNZ4wsC3Rfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091837; c=relaxed/simple;
	bh=yUebgToB8fNqLYyOXSBAVPWT0p5rZMhaAsCibJB/MRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wd99bOmdegSc2szX7RQVxSC993lf+ldMHVJ/qMSeQECeg9HVniTWEdmuKXLteb9zn+kS4gS462YbIGZkDzmZqVz58bAuvkbE5VVX1ZpMo0Yi7MmnAKISlSXSlVuOQqhvI+1rLQ4lp1/Eoa9Ez+8AsOaoAIxACiVEPhpO7c43TmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cRTHm5Xlbz9sxc;
	Wed, 17 Sep 2025 08:24:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cdMlgPgnLR0b; Wed, 17 Sep 2025 08:24:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cRTHm3mDVz9sxY;
	Wed, 17 Sep 2025 08:24:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4EAAC8B766;
	Wed, 17 Sep 2025 08:24:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ZNb0SINzbGae; Wed, 17 Sep 2025 08:24:04 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C684C8B763;
	Wed, 17 Sep 2025 08:24:03 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Herve Codina <herve.codina@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] net: wan: framer: Add version sysfs attribute for the Lantiq PEF2256 framer
Date: Wed, 17 Sep 2025 08:24:01 +0200
Message-ID: <2e01f4ed00d0c1475863ffa30bdc2503f330b688.1758089951.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758090241; l=3036; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=yUebgToB8fNqLYyOXSBAVPWT0p5rZMhaAsCibJB/MRE=; b=XinTr0sQd/fycGPP9Ahs+KCsT52jn6P0PjWwxzML/HAyXtlvz85bQ/3HFUOcTJvz4KCIavxke xhO9gi/FA+vBoFKf2SdHRX9DHgHLs/OYBcq4bCVaw+bNMDGV58B+AJm
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Lantiq PEF2256 framer has some little differences in behaviour
depending on its version.

Add a sysfs attribute to allow user applications to know the
version.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2:
- Make DEVICE_ATTR_RO(version) static
- Split version_show() prototype into 2 lines to remain under 80 chars

v1: https://lore.kernel.org/all/f9aaa89946f1417dc0a5e852702410453e816dbc.1757754689.git.christophe.leroy@csgroup.eu/
---
 drivers/net/wan/framer/pef2256/pef2256.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wan/framer/pef2256/pef2256.c b/drivers/net/wan/framer/pef2256/pef2256.c
index 1e4c8e85d598..a2166b424428 100644
--- a/drivers/net/wan/framer/pef2256/pef2256.c
+++ b/drivers/net/wan/framer/pef2256/pef2256.c
@@ -37,6 +37,7 @@ struct pef2256 {
 	struct device *dev;
 	struct regmap *regmap;
 	enum pef2256_version version;
+	const char *version_txt;
 	struct clk *mclk;
 	struct clk *sclkr;
 	struct clk *sclkx;
@@ -114,6 +115,16 @@ enum pef2256_version pef2256_get_version(struct pef2256 *pef2256)
 }
 EXPORT_SYMBOL_GPL(pef2256_get_version);
 
+static ssize_t version_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct pef2256 *pef2256 = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", pef2256->version_txt);
+}
+
+static DEVICE_ATTR_RO(version);
+
 enum pef2256_gcm_config_item {
 	PEF2256_GCM_CONFIG_1544000 = 0,
 	PEF2256_GCM_CONFIG_2048000,
@@ -697,7 +708,6 @@ static int pef2256_probe(struct platform_device *pdev)
 	unsigned long sclkr_rate, sclkx_rate;
 	struct framer_provider *framer_provider;
 	struct pef2256 *pef2256;
-	const char *version_txt;
 	void __iomem *iomem;
 	int ret;
 	int irq;
@@ -763,18 +773,18 @@ static int pef2256_probe(struct platform_device *pdev)
 	pef2256->version = pef2256_get_version(pef2256);
 	switch (pef2256->version) {
 	case PEF2256_VERSION_1_2:
-		version_txt = "1.2";
+		pef2256->version_txt = "1.2";
 		break;
 	case PEF2256_VERSION_2_1:
-		version_txt = "2.1";
+		pef2256->version_txt = "2.1";
 		break;
 	case PEF2256_VERSION_2_2:
-		version_txt = "2.2";
+		pef2256->version_txt = "2.2";
 		break;
 	default:
 		return -ENODEV;
 	}
-	dev_info(pef2256->dev, "Version %s detected\n", version_txt);
+	dev_info(pef2256->dev, "Version %s detected\n", pef2256->version_txt);
 
 	ret = pef2556_of_parse(pef2256, np);
 	if (ret)
@@ -835,6 +845,8 @@ static int pef2256_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	device_create_file(pef2256->dev, &dev_attr_version);
+
 	return 0;
 }
 
@@ -849,6 +861,8 @@ static void pef2256_remove(struct platform_device *pdev)
 	pef2256_write8(pef2256, PEF2256_IMR3, 0xff);
 	pef2256_write8(pef2256, PEF2256_IMR4, 0xff);
 	pef2256_write8(pef2256, PEF2256_IMR5, 0xff);
+
+	device_remove_file(pef2256->dev, &dev_attr_version);
 }
 
 static const struct of_device_id pef2256_id_table[] = {
-- 
2.49.0


