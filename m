Return-Path: <netdev+bounces-219480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A08B4188C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1D8560262
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAD32EBBB9;
	Wed,  3 Sep 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ehgPpuo1"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448542EB87C;
	Wed,  3 Sep 2025 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888162; cv=none; b=Uk1voNy6hL/xWkBCRexOXZ+YGV9y6ZZlryJnTMPbizCbiW2A/v7HAlipEUos2PnAS3kS3cefCnMUumZJw+WDmuqOa97VnY9AvtfXJjFsehTOd/PMbkplG1wowfq4cA0jQW9tAm6VBiy9x5Z9dlEK6MxbMccNRIBmt+lYlwVsEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888162; c=relaxed/simple;
	bh=eO11k6Ra2QsH1VCzI4Q5SU2ncwi5FG6M3i44nrlIkm4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=k5ILvfT4ggy6/jrkEp3C6OVtLtTncPAeLJbI5uiy6WNHjbeNdDJq/ip8+/0hUKkdoU/qIMDX1qVbV5rWyfNCCswhtuOfr2aOYouwV0n3YyjFwYx4GO6fsLOK9SdekFhrkr2LFxiR2Mq8AwwX5/oQqhTHx8HZDcAZ+XFWZydiQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ehgPpuo1; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756888146;
	bh=rxwbLt1/3yvtFHhZm8ytyPfgkNtAZ83DcuhmIdUSo48=;
	h=From:To:Cc:Subject:Date;
	b=ehgPpuo1SK7OsPIWRjezuADbf08ya+hTOBXAChke4Q5Rlo5YZ3uTWB31LLBlbyspa
	 MCjdmx+GxSBrt1TvniBBuYBBblz+XqDaXjWB73TDIdDPEXWC8QJmObYxIGGV8osH+5
	 sDmBMdMsplvT952Pch4bSt2WeqNGfQEU4kH6xQ5I=
Received: from localhost.localdomain ([112.94.77.11])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 5A933850; Wed, 03 Sep 2025 16:22:41 +0800
X-QQ-mid: xmsmtpt1756887761tvydu8a21
Message-ID: <tencent_4E434174E9D516431365413D1B8047C6BB06@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgcVOcqUEsC/Rrco1gqWxRo27AXcUx2WkW06jJpes6cEcTIRCdk7
	 8AqyusGrgbY7Ukwxej1hCZxZK9RM1lmEPhQTNz6mI+N7ypKbAZ6H6g++gVse98wMu/q2f+b4M9u0
	 RNT3AEbxhe4pTrfG+09IeGuzziFGBc2kw8zWDkBKCT1ykdzy6ss4d9H2HgGLPoWugzqbDwllHx74
	 GRe5uvwzjXPXRw1uSkyF/FIKd1xIwf1IURvAGZpObkXYT8W+t5XRsc1+z/klQzw5r8+kSqTIe9bm
	 N9O8BK0/DxoObnbKGT9tuGtljWOiICl2nHOokZcZzahjAw6CLUEFsudQp92FauqWPC1iK3OkhyJT
	 0/67kMYwscJE4SPiX/XXtA0OuiwAHW2qgpFji5e4NRrZuBGwDzP8ORoRPYkMjmBgIK9u/mWxOXgz
	 oxWoZ/lAU9gEc31erSu2RpBijHa4J7giDCed8yK9i9yHe96dIwOEx/tYz2Diet/lXIBDpJ2Bny2y
	 IPFCd/K3u3I6IUSeGVIcI3JtYTFCRpADFaHDECTGh0aWLBwtYjL89xoXqLKDQtM9eTUvFns46cSI
	 ZIXUFE1iK03y/w4uBMjz9NFvAz/+87qllwA+GyVuiY5RdwiH6iozFMgsitX65FgA0pCFNtDkFEgA
	 naIM3PWpVsj6iNo1qU3m17Nq1hmDlgnl08BDxQdsuIiAjyICw4q/1oxKC+wK/W4PN1M5pGBOH9a/
	 g3BjNPohPOvWYpKh1+fCikISnXECbRPU0bMzMJ3KrSWY1cJEIpkLkzIC2xv/aKlwaCWgC0CVXIdL
	 HZJgz1zSU0xwImTrCIQVO5Cd8UswgrB136d6cmwT6DmDDCceuYZBbhrztoG7WlbzHEvYLXCxsxRd
	 cJEUvtTM15v0ZmXPj6CQffEhRB1+0QJXIKGKVEi3AdR9wIFc2vnhqjHkwpUADZVYMXtL58qdJ6gi
	 ogyP7yVJw7QmETVcga7MSLapXbuqvOOIWyxD+9XaIavdx/HBIOdliaUmlsiPgJmr6SX9WVno6ZxA
	 KRFo4Qv+FitPVJxgemQXH2+4YcBYD0SEsee5S55oKCP4iH4pOv+OEnAqr0+0ocw3i+ood4yac8xj
	 rKTVjf
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Conley Lee <conleylee@foxmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	wens@csie.org,
	mripard@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Conley Lee <conleylee@foxmail.com>
Subject: [PATCH] dt-bindings: net: sun4i-emac: add dma support
Date: Wed,  3 Sep 2025 16:22:38 +0800
X-OQ-MSGID: <20250903082238.513066-1-conleylee@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sun4i EMAC supports DMA for data transmission,
so it is necessary to add DMA options to the device tree bindings.

Signed-off-by: Conley Lee <conleylee@foxmail.com>
---
 .../bindings/net/allwinner,sun4i-a10-emac.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml
index eb26623da..d4d8f3a79 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml
@@ -33,6 +33,15 @@ properties:
       - items:
           - description: phandle to SRAM
           - description: register value for device
+  dmas:
+    items:
+      - description: RX DMA Channel
+      - description: TX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
 
 required:
   - compatible
-- 
2.25.1


