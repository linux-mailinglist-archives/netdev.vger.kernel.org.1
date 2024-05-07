Return-Path: <netdev+bounces-93937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4D88BDAD2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 07:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239A61C2120B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 05:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB276CDCB;
	Tue,  7 May 2024 05:52:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2846F6CDAF;
	Tue,  7 May 2024 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061166; cv=none; b=OUiYqBUkTDR+T39uxylGQhUfVP91muG1Fh4khNUEXbtvczJqhKxtxcKkm1MCMf6McOeD2i6l3YDmnTD76csbktzaJjQQkq2V1381I+TSC1+Bo+3Dtdk1MnC/CnrQ4fv6e1D12E3tavYTsqJSy7ZYAmD7NApa8VsLMoAsvgJFJuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061166; c=relaxed/simple;
	bh=YjkmmEfXWCaLJD7QxPp6Hwb51t98Ph3yh4aNnsAL6o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=a6CyNsCJvvPRfeS+D+r0E0fvqVNNMqsbKsvZqXfqsgkwSEz5T05hBLPo2rNT26Ug7b0AitmwnJWk0+0T6B931TOnzRoHktr/11Fzhx7wJWdI3OTgixI5lJ4RUqTjNgM1jw06G8AZV4O/YbutoSirFMeuL0QxbSkOgqBwGnheax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [221.192.179.90])
	by mail-app2 (Coremail) with SMTP id by_KCgCnw6KdwTlmejJDAA--.29603S2;
	Tue, 07 May 2024 13:52:32 +0800 (CST)
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
Subject: [PATCH net v4 2/4] ax25: Fix reference count leak issues of ax25_dev
Date: Tue,  7 May 2024 13:52:28 +0800
Message-Id: <873a4f366024c151442c7306902b16957f623c11.1715059894.git.duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1715059894.git.duoming@zju.edu.cn>
References: <cover.1715059894.git.duoming@zju.edu.cn>
X-CM-TRANSID:by_KCgCnw6KdwTlmejJDAA--.29603S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4rXr4Utr1rur1UtFykGrg_yoW8KF1kpF
	Wa9FW5ArWktr4Utr4DWr1xWr1jvryqk393AryUuF1Ikw1rX3sxJr1rtr4DXryUGryfZF48
	Xw17Wrs8ZFWkuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOHUqUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMOAWY4-AkEPQA+sj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The ax25_addr_ax25dev() and ax25_dev_device_down() exist a reference
count leak issue of the object "ax25_dev".

Memory leak issue in ax25_addr_ax25dev():

The reference count of the object "ax25_dev" can be increased multiple
times in ax25_addr_ax25dev(). This will cause a memory leak so far.

Memory leak issues in ax25_dev_device_down():

The reference count of ax25_dev is set to 1 in ax25_dev_device_up() and
then increase the reference count when ax25_dev is added to ax25_dev_list.
As a result, the reference count of ax25_dev is 2. But when the device is
shutting down. The ax25_dev_device_down() drops the reference count once
or twice depending on if we goto unlock_put or not, which will cause
memory leak.

As for the issue of ax25_addr_ax25dev(), it is impossible for one pointer
to be on a list twice. So add a break in ax25_addr_ax25dev(). As for the
issue of ax25_dev_device_down(), increase the reference count of ax25_dev
once in ax25_dev_device_up() and decrease the reference count of ax25_dev
after it is removed from the ax25_dev_list.

Fixes: d01ffb9eee4a ("ax25: add refcount in ax25_dev to avoid UAF bugs")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v4:
  - Make the fix procedure of ax25_dev as a separate update steps.

 net/ax25/ax25_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index d4e1e36a6a8..6a572fe1046 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -38,6 +38,7 @@ ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
 		if (ax25cmp(addr, (const ax25_address *)ax25_dev->dev->dev_addr) == 0) {
 			res = ax25_dev;
 			ax25_dev_hold(ax25_dev);
+			break;
 		}
 	spin_unlock_bh(&ax25_dev_lock);
 
@@ -90,7 +91,6 @@ void ax25_dev_device_up(struct net_device *dev)
 	list_add(&ax25_dev->list, &ax25_dev_list);
 	dev->ax25_ptr     = ax25_dev;
 	spin_unlock_bh(&ax25_dev_lock);
-	ax25_dev_hold(ax25_dev);
 
 	ax25_register_dev_sysctl(ax25_dev);
 }
@@ -131,7 +131,6 @@ void ax25_dev_device_down(struct net_device *dev)
 unlock_put:
 	dev->ax25_ptr = NULL;
 	spin_unlock_bh(&ax25_dev_lock);
-	ax25_dev_put(ax25_dev);
 	netdev_put(dev, &ax25_dev->dev_tracker);
 	ax25_dev_put(ax25_dev);
 }
-- 
2.17.1


