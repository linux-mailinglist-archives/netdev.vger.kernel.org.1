Return-Path: <netdev+bounces-142269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742D19BE17C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377B1284748
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84D01D6182;
	Wed,  6 Nov 2024 09:00:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1C1D7E41;
	Wed,  6 Nov 2024 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883642; cv=none; b=KoK4qPbznYkvkCadCI4djIiJ2BtM2CA1V47GOCI3nve9ie6lrYSjcu8I+Ravl234tCMLDg76jMbzymzpNtO9gZrEIiPELMpeRPwI7qBdro4pjJ+8/l4r8oO7KIaMns2Tu9zZckzpOWPXp8He1wPBuOZzwbeizWS9fCZNf6xhSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883642; c=relaxed/simple;
	bh=fDSS5Ot/nGR8QnyVF4ghfmLTy2d8XgfWck2llWDoaH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ricIpTrA5OOE7/CHNiLa0tJuTMw74xqXCd+1rJqEpay65xKVcO1THJq3/N8JnjZPJXkoJrYYNyAueuI1MzAF80rVxbvVS4Y1ivVWx3/8kCGTdPm9leRYhMEnqvC8jru/CU2GgXKsr5IjisJTaROMzA9fl4+ww3SjRDYTvZGJPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.247])
	by APP-05 (Coremail) with SMTP id zQCowACHbrmkLitnyXFqAA--.1291S2;
	Wed, 06 Nov 2024 16:53:58 +0800 (CST)
From: Wentao Liang <liangwentao@iscas.ac.cn>
To: shannon.nelson@amd.com,
	brett.creeley@amd.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Wentao Liang <Wentao_liang_g@163.com>,
	Wentao Liang <liangwentao@iscas.ac.cn>
Subject: [PATCH v2] drivers: net: ionic: fix a memory leak bug
Date: Wed,  6 Nov 2024 16:53:07 +0800
Message-ID: <20241106085307.1783-1-liangwentao@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHbrmkLitnyXFqAA--.1291S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XFWkCw48tw1xCr4fXr1fJFb_yoW8JrW5pw
	s8JFyYvrn5Xr4UGw1DAw18ZF98ZaySkrW8Grnru3yF9wsxAry8JF17ta47tr97WrWUJF1S
	qr129w15XF98C37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5iihUU
	UUU
X-CM-SenderInfo: xold0wxzhq3t3r6l2u1dvotugofq/

From: Wentao Liang <Wentao_liang_g@163.com>

In line 334, the ionic_setup_one() creates a debugfs entry for
ionic upon successful execution. However, the ionic_probe() does
not release the dentry before returning, resulting in a memory
leak. To fix this bug, we add the ionic_debugfs_del_dev() before
line 397 to release the resources before the function returns.

Fixes: 0de38d9f1dba ("ionic: extract common bits from ionic_probe")
Signed-off-by: Wentao Liang <liangwentao@iscas.ac.cn>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index b93791d6b593..f5dc876eb500 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -394,6 +394,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_pci:
 	ionic_dev_teardown(ionic);
 	ionic_clear_pci(ionic);
+	ionic_debugfs_del_dev(ionic);
 err_out:
 	mutex_destroy(&ionic->dev_cmd_lock);
 	ionic_devlink_free(ionic);
-- 
2.42.0.windows.2


