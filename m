Return-Path: <netdev+bounces-122121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055295FF46
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D35B20E62
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EED71773A;
	Tue, 27 Aug 2024 02:45:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844F175AB
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726706; cv=none; b=AKs11BdQz9J/jAXvLml+T3uynPRLLbWb6WHFjMbJCABz/YG3D0gQzRGTjvZ742ElxWNlvVR5Tc8jh838j/25haVwNLLHc9gQElOakh6Q3SZwxQUwYLscGfMDJ1wno75UuKcKhBoQCJAmmVWqASI1AMiHajBytInqEKkt9qYs8r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726706; c=relaxed/simple;
	bh=Ul9iJUX23pdklvWim5EAP6jDRbMEQ+YSQOKACCo8WGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDWcBEknXFwVgeVTI9sdNRWt2D3i18A24D7Gcy/cHrZCD0zau4kvvkSEh3DUo6zTFbdAC9hk6KPcLCANUOblLYRVNXje9OnjdUa6ZpYtC06+coznEWQQwqX0EfH2RhcFOT4VcbPoT/EZKBVRNvb2XqMRxHrI8Q6RSFd0f2f24kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WtBfr31Jzz1xvNc;
	Tue, 27 Aug 2024 10:43:00 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 78DAF140154;
	Tue, 27 Aug 2024 10:44:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 10:44:57 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <sam@mendozajonas.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <lihongbo22@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v2 1/2] net/ncsi: Use str_up_down to simplify the code
Date: Tue, 27 Aug 2024 10:52:45 +0800
Message-ID: <20240827025246.963115-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827025246.963115-1-lihongbo22@huawei.com>
References: <20240827025246.963115-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

As str_up_down is the common helper to reback "up/down"
string, we can replace the target with it to simplify
the code and fix the coccinelle warning.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/ncsi/ncsi-manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5ecf611c8820..13b4d393fb2d 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1281,7 +1281,7 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 				netdev_dbg(ndp->ndev.dev,
 					   "NCSI: Channel %u added to queue (link %s)\n",
 					   nc->id,
-					   ncm->data[2] & 0x1 ? "up" : "down");
+					   str_up_down(ncm->data[2] & 0x1));
 			}
 
 			spin_unlock_irqrestore(&nc->lock, cflags);
-- 
2.34.1


