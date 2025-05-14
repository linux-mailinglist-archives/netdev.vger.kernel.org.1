Return-Path: <netdev+bounces-190322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB02DAB6358
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84063188E3D0
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CA0201004;
	Wed, 14 May 2025 06:42:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590FC201032;
	Wed, 14 May 2025 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204926; cv=none; b=Qv7e7WEohNipRcJ2t0XcMtnOG6lu15jY5mAIlLdxpYdMZhT5jIe3sEPVhnNCrQgudaL7hSD3/97P31ccA8E5MhKHod1FoEpMcYzNhyLSB5cHlqJAafL345TfuAecjCjfC6aypySN9ETgBykuJyoit/nmTWMGvw0oFQI5NJU8E+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204926; c=relaxed/simple;
	bh=+7twghZ6n/HSHp/zDA5F7VuniUgpxiLvUlKenwUOllI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bbX3UGWqqMLSCmJJ3c90gvO0Kln8zyKGNjC+zn3CcSeypHEgBAgxt0a8TiuO3cr4tksu0jyriOrugfCe8ehwB2k300LwRXj7VaF1zdm8oimEUblSRkoynjBeBCE30XD2+Z4iuqgOmhAFUNiAFbgylUmiEcy/joMXrf3s0KJ70Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowADXfjsvOyRo8fb1FA--.59329S2;
	Wed, 14 May 2025 14:41:51 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: taras.chornyi@plvision.eu,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next] net: prestera: Use to_delayed_work()
Date: Wed, 14 May 2025 14:40:53 +0800
Message-Id: <20250514064053.2513921-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADXfjsvOyRo8fb1FA--.59329S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1xJF4fZw4fGFyxtF47urg_yoWDurc_ur
	9rXryDGr45Wr4fKw4Ygr43Zr9YyryDZrykGw42qrZrC3y8XF1aqr10yF4xJayDGr4rXFnx
	Gr1Sqr1fZ3srKjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x0JU5R67UUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Use to_delayed_work() instead of open-coding it.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/ethernet/marvell/prestera/prestera_counter.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_counter.c b/drivers/net/ethernet/marvell/prestera/prestera_counter.c
index 4cd53a2dae46..634f4543c1d7 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_counter.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_counter.c
@@ -336,8 +336,7 @@ prestera_counter_block_get_by_idx(struct prestera_counter *counter, u32 idx)
 
 static void prestera_counter_stats_work(struct work_struct *work)
 {
-	struct delayed_work *dl_work =
-		container_of(work, struct delayed_work, work);
+	struct delayed_work *dl_work = to_delayed_work(work);
 	struct prestera_counter *counter =
 		container_of(dl_work, struct prestera_counter, stats_dw);
 	struct prestera_counter_block *block;
-- 
2.25.1


