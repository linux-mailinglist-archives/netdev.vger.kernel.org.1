Return-Path: <netdev+bounces-139026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AAB9AFDB4
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E731C213E3
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1318C1D3585;
	Fri, 25 Oct 2024 09:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE211B6CF6;
	Fri, 25 Oct 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847517; cv=none; b=Sk9P8pvP2ewZPj0a7oHXyzHyEo3LZ6X1Do94oeemHmHkPVfAlCigsVB0Pqw1j7jjulEdLDLxPtk4hW8v+i4E2I8YVMGoTeQ/Nv3ofdY4lkiMEhLmELwkrJLhrViXxlhW9wu12uIOXzCjhgvlYHWc1wQMBLlkOY2Umtme/FPvZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847517; c=relaxed/simple;
	bh=04+J6j55e/vuZr5unczAqU49D9E/KvjzdZkFKQ/0gkk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EgPLp0uY+xIR5Y6piuLQoJD5asNRsGbZewDmkWQFgcqoDjH/B83WZY+r/Gx3IR3sdhR+yUR6bDEFmhYQ/ycbyJ5tF0EPe/xGlZCJIg8FNHUCXRDAFHGlgfE6U+8XMLFafcVnR+q9ZToOqu7htJErcebsXD7dHv6Miqg4bEnQr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id WLL00042;
        Fri, 25 Oct 2024 17:11:42 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 17:11:41 +0800
Received: from localhost.localdomain (10.94.19.204) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 17:11:41 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <rogerq@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <jpanis@baylibre.com>, <dan.carpenter@linaro.org>,
	<grygorii.strashko@ti.com>, <u.kleine-koenig@baylibre.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] net: ethernet: ti: am65-cpsw: fix NULL deref check in am65_cpsw_nuss_probe
Date: Fri, 25 Oct 2024 17:11:39 +0800
Message-ID: <20241025091139.230117-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 20241025171142de145c96ebba91c5a170e9182a71026d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

In am65_cpsw_nuss_probe() devm_kzalloc() may return NULL but this
returned value is not checked.

Fixes: 1af3cb3702d0 ("net: ethernet: ti: am65-cpsw: Fix hardware switch mode on suspend/resume")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 6201a09fa5f0..7af7542093e8 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3528,6 +3528,9 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	common->ale_context = devm_kzalloc(dev,
 					   ale_entries * ALE_ENTRY_WORDS * sizeof(u32),
 					   GFP_KERNEL);
+	if (!common->ale_context)
+		return -ENOMEM;
+
 	ret = am65_cpsw_init_cpts(common);
 	if (ret)
 		goto err_of_clear;
-- 
2.31.1


