Return-Path: <netdev+bounces-122742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F96696268E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B269B1C21430
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1916D330;
	Wed, 28 Aug 2024 12:07:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5FA16BE34
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846877; cv=none; b=e1ujYWp8pzANteDgBhzuZCGAoT+Fe2j6MD99K9ctkuj/Fj1EaeZ3tDG2OOcqH1gEPzXG+N50Uyf9YgT71wFlQYUzY/A0x2YuwzWTT2Sm8ocMsLHpr2yLNEuiH6GvckL8EVLtY/fVw3VPffGBri5mz1CIwbDhPie0Qu89ZdD1oY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846877; c=relaxed/simple;
	bh=lZR0qLW3YVcfpWiOjaW5DMRQw6r9rlIxth/srZFI0JQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=alH0gKCgobhkf1QwFOCtIvKnGiVRnEVWkGkFu+6hvzZ7dZhuDZ4soZY97j8WqAk6WmnpTktbFAo+kDuVFUjTNQZg3XhHr9QAGST48i2cqQnjA1NhY0+MMa0D/fCbtRnrqj8hSUpGyyfesKR5DTLNhjsaiM3tdhsCrIAd7hilBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wv34J0d3Hz1HHfd;
	Wed, 28 Aug 2024 20:04:32 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E3F491A016C;
	Wed, 28 Aug 2024 20:07:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 20:07:51 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <elder@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH net-next] net: ipa: make use of dev_err_cast_probe()
Date: Wed, 28 Aug 2024 20:15:51 +0800
Message-ID: <20240828121551.3696520-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Using dev_err_cast_probe() to simplify the code.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/net/ipa/ipa_power.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 65fd14da0f86..c572da9e9bc4 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -242,11 +242,8 @@ ipa_power_init(struct device *dev, const struct ipa_power_data *data)
 	int ret;
 
 	clk = clk_get(dev, "core");
-	if (IS_ERR(clk)) {
-		dev_err_probe(dev, PTR_ERR(clk), "error getting core clock\n");
-
-		return ERR_CAST(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_cast_probe(dev, clk, "error getting core clock\n");
 
 	ret = clk_set_rate(clk, data->core_clock_rate);
 	if (ret) {
-- 
2.34.1


