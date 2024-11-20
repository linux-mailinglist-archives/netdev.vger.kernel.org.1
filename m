Return-Path: <netdev+bounces-146388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A09D33BB
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0607B283488
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13321586FE;
	Wed, 20 Nov 2024 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TqWUkayO"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29366184F;
	Wed, 20 Nov 2024 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732085300; cv=none; b=c9sTUOEHgwpFzIfSt3Ez6Skk1yJpFLy13LnYVct6YnYmZVxANqvxzgXWtl/JSxsyjZ9LaN4z3L1MTmkZSfUk1l2Kkqk03Q063RWpNVDUdmJNlHxihKeqBnDUqkRd/xVnjN9GyBjZjA0CODDHABOMSu/wfAuA2FhMqLiuq1gOn8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732085300; c=relaxed/simple;
	bh=n8SLLWK3MQkDR1z3H0Re1trDYjqiMeMiHJSiS1serxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ti3LFY6XxYdBU7ZEM+CeSuwrhUxR5JdeQAh98ylsFpLikLb3lAd0Mnc98yhYNdB30QDzfkTWswCd1Ne0jz3KWHm924n/vXQYX3XKC//VeSWQ6Hqq5WL4EeZeYRnSLc5H5A80E4Q+7RkY8YwjaxXBcZ9+Br9S6Pngq+rLk9/sKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TqWUkayO; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FEtQH
	Q7xxa/NvxCI7Kpu5Ck4lLcNoLVOFcsGOzxZzKs=; b=TqWUkayO7aHCTDFsKQaXT
	cXVDsKQObmdF3MmhUi3GmQhJjskQ0MYLjrpPNkzPReEpNwqPZT6eRp4XWi8A1lGJ
	jC0Tc98WFspo9G+cbsVKycYdqKCBFEHka+jlPlpAEzCh+4Ixz0hqTqfzPRWtvdBq
	qTFi77E0jIjUbbPSp7kYso=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnD1j4hT1nTO3OIQ--.22522S7;
	Wed, 20 Nov 2024 14:47:28 +0800 (CST)
From: Ran Xiaokai <ranxiaokai627@163.com>
To: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	pshelar@ovn.org,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	linux-perf-users@vger.kernel.org,
	netdev@vger.kernel.org,
	dev@openvswitch.org
Subject: [PATCH 3/4] net: openvswitch: convert call_rcu(dp_meter_instance_free_rcu) to kvfree_rcu()
Date: Wed, 20 Nov 2024 06:47:15 +0000
Message-Id: <20241120064716.3361211-4-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120064716.3361211-1-ranxiaokai627@163.com>
References: <20241120064716.3361211-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD1j4hT1nTO3OIQ--.22522S7
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWfGw4kuF4xuryUAF1xAFb_yoWkCwb_ZF
	s8Za1DGF43Ja40qrsrCFs5Xr4fKF1fuF18Xws7Ka92kas8tws5Gr17WFZ3Cr93W3yUCr9a
	qwn0qw1fCF15GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0jsjUUUUUU==
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRudTGc9e4T0vgACsO

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

The rcu callback dp_meter_instance_free_rcu() simply calls kvfree().
It's better to directly call kvfree_rcu().

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 net/openvswitch/meter.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
index cc08e0403909..d99efb9ce1a0 100644
--- a/net/openvswitch/meter.c
+++ b/net/openvswitch/meter.c
@@ -83,14 +83,6 @@ static void dp_meter_instance_free(struct dp_meter_instance *ti)
 	kvfree(ti);
 }
 
-static void dp_meter_instance_free_rcu(struct rcu_head *rcu)
-{
-	struct dp_meter_instance *ti;
-
-	ti = container_of(rcu, struct dp_meter_instance, rcu);
-	kvfree(ti);
-}
-
 static int
 dp_meter_instance_realloc(struct dp_meter_table *tbl, u32 size)
 {
@@ -108,7 +100,7 @@ dp_meter_instance_realloc(struct dp_meter_table *tbl, u32 size)
 			new_ti->dp_meters[i] = ti->dp_meters[i];
 
 	rcu_assign_pointer(tbl->ti, new_ti);
-	call_rcu(&ti->rcu, dp_meter_instance_free_rcu);
+	kvfree_rcu(ti, rcu);
 
 	return 0;
 }
-- 
2.17.1



