Return-Path: <netdev+bounces-93939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE18BDADA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 07:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056931C21976
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 05:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C26D1C8;
	Tue,  7 May 2024 05:53:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net (zg8tmtu5ljy1ljeznc42.icoremail.net [159.65.134.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688EE6BFA9;
	Tue,  7 May 2024 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.65.134.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061196; cv=none; b=Kj6stmRptagxePBVAUA9Um5Sj6dt7BehIPL6qNG4BwD8Fz/OMGWuUWyUttFGlVd1ciRJhgIlES65v9lxUV8eFRyXYyEeH5edj83fG51CI1yOO7ON34QPy9nk9l4W1mGp5BQLjAAm3FoIotMv7zWwGT5r/ZXKbHfLZu9UMm+LGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061196; c=relaxed/simple;
	bh=uY/f2XxADkXUxf5Kne/3qFuas5cvVQzyqm+DbipD+Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tTztVvw4HoBEjcVzDxUGSUJAOHnRZC9y0+8VOdy2ZogJZUs2LnVA6DtMRvGLsdClyxSr6Rx4PYCp9Ckq0l3vTsVfNfMnBQ0ETkrfogCw1Bf72qKIggZ68Ia4OHDqC+YcglLDyOOGgLGtSHipj8jv8fblsYeJiGI2dIqOM/E+c7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=159.65.134.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [221.192.179.90])
	by mail-app2 (Coremail) with SMTP id by_KCgBH0Z+3wTlmoTRDAA--.41006S2;
	Tue, 07 May 2024 13:52:58 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	jreuter@yaina.de,
	horms@kernel.org,
	Markus.Elfring@web.de,
	dan.carpenter@linaro.org,
	lars@oddbit.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net v4 4/4] ax25: Change kfree() in ax25_dev_free() to ax25_dev_put()
Date: Tue,  7 May 2024 13:52:55 +0800
Message-Id: <7fdad05adf75ab7e2f6aad4d4c596e0361ce55dd.1715059894.git.duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1715059894.git.duoming@zju.edu.cn>
References: <cover.1715059894.git.duoming@zju.edu.cn>
X-CM-TRANSID:by_KCgBH0Z+3wTlmoTRDAA--.41006S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy3Gr4DGFWrJw4kGFW3KFg_yoWfXFg_uF
	ykCF4xWw1UJFyUCw1rCF4rJrW3Ww1Ygwn3JryfAFZ7t34jya4UJrWkWr1kXF1UWrW2krWS
	qrn5ZrWfAr43tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
	6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO3kuDUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMOAWY4-AkEPQBDse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The object "ax25_dev" is managed by reference counting. Thus it should
not be directly released by a kfree() call in ax25_dev_free(). Replace
it with a ax25_dev_put() call instead.

Fixes: d01ffb9eee4a ("ax25: add refcount in ax25_dev to avoid UAF bugs")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/ax25/ax25_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 05e556cdc2b..d4d29879df2 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -194,7 +194,7 @@ void __exit ax25_dev_free(void)
 	list_for_each_entry_safe(s, n, &ax25_dev_list, list) {
 		netdev_put(s->dev, &s->dev_tracker);
 		list_del(&s->list);
-		kfree(s);
+		ax25_dev_put(s)
 	}
 	spin_unlock_bh(&ax25_dev_lock);
 }
-- 
2.17.1


