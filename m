Return-Path: <netdev+bounces-142616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0469BFC7E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC5A1C21F79
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F228DF78;
	Thu,  7 Nov 2024 02:18:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3314293;
	Thu,  7 Nov 2024 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945914; cv=none; b=M/uZVCnnIkyCfiHuZja/ZidPktL6Z29BBl7u2daNScqQgaG+oolRh8a1itMoOXZRtoh3ISpqheNSSUmXuBS+BMM/Pz3y8blkiavtl45a14WNBjv3drdMAR5QkcSmSip8hQyUZlPnU/5oWrniwkIBUtWE9GhhxBAJCVYTkrmeCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945914; c=relaxed/simple;
	bh=uKhdSx6UBNzsMAWz7DujzJFXch+r/GhwCzFuIiVCqUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCcY8WOTQxpODcKjAv0iZ38yXqcFrKQadPqQ6PrEWqeNxMbh80iv8Cwsm1v/fooexX/B5vMzKUosf8NWKs5eSHZB7KzNF/aKL5MMtZoZ/w64/OwRTSs2EYv6EnWu6hw2Wn9slfcWci8NI4IECJ2xObhZIXKQ7twZCKA9Jly9Apw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.247])
	by APP-03 (Coremail) with SMTP id rQCowAB3F+1oIyxnBIWlAA--.43918S2;
	Thu, 07 Nov 2024 10:18:20 +0800 (CST)
From: Wentao Liang <liangwentao@iscas.ac.cn>
To: shannon.nelson@amd.com,
	brett.creeley@amd.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Wentao Liang <Wentao_liang_g@163.com>
Subject: [PATCH net v3] drivers: net: ionic: add missed debugfs cleanup to ionic_probe() error path
Date: Thu,  7 Nov 2024 10:17:56 +0800
Message-ID: <20241107021756.1677-1-liangwentao@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3F+1oIyxnBIWlAA--.43918S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr43JFy7tFWkJw1kAr1xAFb_yoW8Jr47pa
	n8JFyYqry8Xr47Gw1DAw48ZF98ZayS9rW8Grnruw4F9rsxAa48JF17tFy7Kr97WrWUGF1S
	qry29w15XF98G37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bYYLPUUUUU=
X-CM-SenderInfo: xold0wxzhq3t3r6l2u1dvotugofq/

From: Wentao Liang <Wentao_liang_g@163.com>

The ionic_setup_one() creates a debugfs entry for ionic upon
successful execution. However, the ionic_probe() does not
release the dentry before returning, resulting in a memory
leak.

To fix this bug, we add the ionic_debugfs_del_dev() to release
the resources in a timely manner before returning.

Fixes: 0de38d9f1dba ("ionic: extract common bits from ionic_probe")
Signed-off-by: Wentao Liang <Wentao_liang_g@163.com>
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


