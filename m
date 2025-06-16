Return-Path: <netdev+bounces-198057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F41D2ADB1C2
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7EA188AEC1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5763C298CDC;
	Mon, 16 Jun 2025 13:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B72701D0;
	Mon, 16 Jun 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080348; cv=none; b=I/ipGHtS9/6La2xKLSEuOkbD4iaBkcVkMbtXk4iNsXx3g5dycnryrO4bEdlfm3eWOzZb2dJxHlqEefDQKZalAbF/rTc5iWTnjL94hv+cWtVoYQfVo9bq5zlp0jYdHqOUU2tsV4I33mFzecc1vFxRBT3FIl4k5m8XZVQ4009F1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080348; c=relaxed/simple;
	bh=7jLZI80Hgb1SAIJq13IgdmwGWGYWoNlMu8efq1m7Cjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q1whjYCxWO2jZosEdeAtC1LIdQ9EHxM5SwItDIhxNwyhR7fR+fQMfGSo4M2fheU0MokM7BkxQ5reFU7XH99RuRggKddczhNhmgb6HA4rA9TQEzgRZeh2xM4B8qcIPfI8mgaMT3oTXXn8gckp8VcSsanCwQymcyMs5btXVuABbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bLW1Y1h7Pz2TSN3;
	Mon, 16 Jun 2025 21:24:17 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E0F6140279;
	Mon, 16 Jun 2025 21:25:43 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Jun 2025 21:25:42 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <mkubecek@suse.cz>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH ethtool] ethtool: hibmcge: fix wrong register address in pretty print of ethtool -d command
Date: Mon, 16 Jun 2025 21:18:40 +0800
Message-ID: <20250616131840.812638-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The addresses of mac_addr_h and mac_addr_l are wrong,
they need to be swapped.

Fixes: d89f6ee9c12a ("hibmcge: add support dump registers for hibmcge driver")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 hibmcge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hibmcge.c b/hibmcge.c
index 921efd2..ca81bc0 100644
--- a/hibmcge.c
+++ b/hibmcge.c
@@ -36,8 +36,8 @@ static const struct hbg_offset_name_map hbg_spec_maps[] = {
 	{0x0004, "event_req"},
 	{0x0008, "mac_id"},
 	{0x000c, "phy_addr"},
-	{0x0010, "mac_addr_h"},
-	{0x0014, "mac_addr_l"},
+	{0x0010, "mac_addr_l"},
+	{0x0014, "mac_addr_h"},
 	{0x0018, "uc_max_num"},
 	{0x0024, "mdio_freq"},
 	{0x0028, "max_mtu"},
-- 
2.33.0


