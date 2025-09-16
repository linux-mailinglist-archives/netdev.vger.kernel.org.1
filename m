Return-Path: <netdev+bounces-223538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A63DB59702
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95ED217C31D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701593128C7;
	Tue, 16 Sep 2025 13:08:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B98030BF62;
	Tue, 16 Sep 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028135; cv=none; b=l77ZCBz3YkEit3IwN4pQzPhIVWU3qBr65xTDrizLLdJapRcCReoyA2fgGlgQ7BmkTUKZIDtvRtiWXq1mwJen2MxUXeIEisyKq/4XVJ5n3wVVfMRjmzyndMTgI12hVwpXJ+ZlGY7Fr9GrIixWYO0zpPnSuJpxccS/7DCh22fdQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028135; c=relaxed/simple;
	bh=qDj+abcioeDYHEL9GUvWc+GSz1TXk8QkygcWuJ07fKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aRB8QwQiiloEYS0StXFSWIdwo2LVJXHcc0iw9hYI976VXgKdr9iIJ6pixr4wz2tnxsUQs2WGThRDP2yeyumr5/wm/zyuV+bCuzSxbctNjYXefNiHIcWkQVipUMLrbwfkVUDAQehrcTsMTWGlocZT+cS/XLMXsHKXb0/pVV1tBu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [106.117.98.100])
	by mtasvr (Coremail) with SMTP id _____wCnrwNIYclol4g+Ag--.3882S3;
	Tue, 16 Sep 2025 21:08:25 +0800 (CST)
Received: from ubuntu.localdomain (unknown [106.117.98.100])
	by mail-app3 (Coremail) with SMTP id zS_KCgC3uGtEYcloScWmAg--.111S2;
	Tue, 16 Sep 2025 21:08:23 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2 net] cnic: Fix use-after-free bugs in cnic_delete_task
Date: Tue, 16 Sep 2025 21:08:18 +0800
Message-Id: <20250916130818.13617-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgC3uGtEYcloScWmAg--.111S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwYLAWjIa-sOEQBVs1
X-CM-DELIVERINFO: =?B?H8mvOgXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR14TypnDR0EenxcC6lfWFMIVY2RKNCZIKtuJneKdZ8TxEXvvd4crKYD9Q0FFzVH8d5luh
	i0RlUb/Ldsdi21hmwFT6O6Zg8/4WlLuTPc36JYD3j8WAKTIGYr108AJ9d6PROQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1xWr4xJr4DWw45JFWftFc_yoW8Kry5p3
	y5Ga4UXa97Jr13tanrXr48WFn8Cayvya47Gr4fJws5Z34rtF15tryrKFWfua4vyrWkZF1x
	Zrs8Za9xZF90kFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU801v3UUUUU==

The original code uses cancel_delayed_work() in cnic_cm_stop_bnx2x_hw(),
which does not guarantee that the delayed work item 'delete_task' has
fully completed if it was already running. Additionally, the delayed work
item is cyclic, the flush_workqueue() in cnic_cm_stop_bnx2x_hw() only
blocks and waits for work items that were already queued to the
workqueue prior to its invocation. Any work items submitted after
flush_workqueue() is called are not included in the set of tasks that the
flush operation awaits. This means that after the cyclic work items have
finished executing, a delayed work item may still exist in the workqueue.
This leads to use-after-free scenarios where the cnic_dev is deallocated
by cnic_free_dev(), while delete_task remains active and attempt to
dereference cnic_dev in cnic_delete_task().

A typical race condition is illustrated below:

CPU 0 (cleanup)              | CPU 1 (delayed work callback)
cnic_netdev_event()          |
  cnic_stop_hw()             | cnic_delete_task()
    cnic_cm_stop_bnx2x_hw()  | ...
      cancel_delayed_work()  | /* the queue_delayed_work()
      flush_workqueue()      |    executes after flush_workqueue()*/
                             | queue_delayed_work()
  cnic_free_dev(dev)//free   | cnic_delete_task() //new instance
                             |   dev = cp->dev; //use

Replace cancel_delayed_work() with cancel_delayed_work_sync() to ensure
that the cyclic delayed work item is properly canceled and any executing
delayed work has finished before the cnic_dev is deallocated.

Fixes: fdf24086f475 ("cnic: Defer iscsi connection cleanup")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Make commit messages more clearer.

 drivers/net/ethernet/broadcom/cnic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index a9040c42d2ff..73dd7c25d89e 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -4230,7 +4230,7 @@ static void cnic_cm_stop_bnx2x_hw(struct cnic_dev *dev)
 
 	cnic_bnx2x_delete_wait(dev, 0);
 
-	cancel_delayed_work(&cp->delete_task);
+	cancel_delayed_work_sync(&cp->delete_task);
 	flush_workqueue(cnic_wq);
 
 	if (atomic_read(&cp->iscsi_conn) != 0)
-- 
2.34.1


