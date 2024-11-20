Return-Path: <netdev+bounces-146391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FB99D33C0
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18CE283488
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C1167DAC;
	Wed, 20 Nov 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SXblrgP/"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F566157466;
	Wed, 20 Nov 2024 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732085302; cv=none; b=rTTohinLy4PdgvgSh+Xpj4p0WbkcbSTlKtRixUvYWC9f7RncPhUB6yV9dVjWgDyJs+o+/JsnmxHeeLhVMg8bzM1XFV4Oi0m4r6vX27Nz9/i8+PYEoYC2K92Z08GbJZJX+WYacLmyqfXpJIBvdxXsdJdxoNAXW/k7GfZPLxXpetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732085302; c=relaxed/simple;
	bh=03yhgGmdxKAMM7hG9WNCGsQUI/y8wqpw8cVe4oK+ZEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lg9OSrx8dCcVMzKO3G99roeDiSv4qdWo2tyP96hTKhSNK+ILrsCvZo/xovp8NUJKYb1UNPSANvea3I8wgzNVvlOUJpWbI+fzHIzhez6mjlsoLFY21POPlrRJoUKHtuM1sHN7W6Fz8NEFVeLHrhq11DPGx+ksJYeezroTabhck5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SXblrgP/; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RxxSJ
	zuhen+I5MBVyFiCFH36XjMts/uli22nGaC4/a8=; b=SXblrgP/s223E1obJDxG1
	3ZlhfOOEKXsr8qJpMa5agKnWl7mc2WFcmYD0krKhJOuVg/muS2PIj6t0gYH7WwKG
	IwpKwJhBuHsP7pHk+il8paqY+nsIehYnW02ZMwFLSP72VPtHoe4ws/RZMjRzcrVw
	HKh9lOVNpX3kBY/CntqmH0=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnD1j4hT1nTO3OIQ--.22522S8;
	Wed, 20 Nov 2024 14:47:30 +0800 (CST)
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
Subject: [PATCH 4/4] net: sysfs: convert call_rcu() to kvfree_rcu()
Date: Wed, 20 Nov 2024 06:47:16 +0000
Message-Id: <20241120064716.3361211-5-ranxiaokai627@163.com>
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
X-CM-TRANSID:_____wDnD1j4hT1nTO3OIQ--.22522S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWfWF4DCry8XrW3Xr4Dtwb_yoW8Xw17pr
	45Gr9xt395Xr1kJrZ7Kr1IgF1UWr4jqF15WFn2kw1ftwn8Z34v9F17C340qFn5ArW8JFWU
	Zw4Y9rsxAF48AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdOz3UUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRudTGc9e4T0vgADsP

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

The rcu callback rps_dev_flow_table_release() simply calls vfree().
It's better to directly call kvfree_rcu().

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 net/core/net-sysfs.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 2d9afc6e2161..8ba2251af077 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -947,13 +947,6 @@ static ssize_t show_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 	return sysfs_emit(buf, "%lu\n", val);
 }
 
-static void rps_dev_flow_table_release(struct rcu_head *rcu)
-{
-	struct rps_dev_flow_table *table = container_of(rcu,
-	    struct rps_dev_flow_table, rcu);
-	vfree(table);
-}
-
 static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 					    const char *buf, size_t len)
 {
@@ -1008,7 +1001,7 @@ static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 	spin_unlock(&rps_dev_flow_lock);
 
 	if (old_table)
-		call_rcu(&old_table->rcu, rps_dev_flow_table_release);
+		kvfree_rcu(old_table, rcu);
 
 	return len;
 }
@@ -1046,7 +1039,7 @@ static void rx_queue_release(struct kobject *kobj)
 	flow_table = rcu_dereference_protected(queue->rps_flow_table, 1);
 	if (flow_table) {
 		RCU_INIT_POINTER(queue->rps_flow_table, NULL);
-		call_rcu(&flow_table->rcu, rps_dev_flow_table_release);
+		kvfree_rcu(flow_table, rcu);
 	}
 #endif
 
-- 
2.17.1



