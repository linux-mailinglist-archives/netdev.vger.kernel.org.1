Return-Path: <netdev+bounces-140605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23B79B7287
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 03:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41E7B22EE6
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952CD175BF;
	Thu, 31 Oct 2024 02:34:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABE1BD9C0
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 02:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342060; cv=none; b=Q1NfwbF/gF3l1yMLiIQyVAk4UwKCJ7pu0pFsUn3oBOsBcItsRLG/J0mHqihSAs3P54aCyVvu4v0xtyNPosQcn/TOntod422QV6U0CSxAifstuWL/19/pt/cfffCuJV6IhfmKYTqn70hlRjsnarLiPe58+D+YHgT4pQiRHlsyuzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342060; c=relaxed/simple;
	bh=lGkZj3ihnhclOqxtyVd42hLTVnfsqZadFXgO/dFAj+w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C4EvQ+UhsSfIwzSeEoKU7/TzlH/hUo+m3oa8eohcx8dto2jUg/M6rDpcFSWFLkdf4b1ZfinY7DHDhGwuRCEJdQYLSNZCCZJ4xtcD5LLpcNIthxHNMmwOOIlfjtnXFfetvPkf5oi9AZfSNJKXglBBjHmOTf79jmOUbZ9Qbg7fzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xf7L92qJnz10PL3;
	Thu, 31 Oct 2024 10:32:01 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 6341714038F;
	Thu, 31 Oct 2024 10:34:13 +0800 (CST)
Received: from DESKTOP-8F1OVF5.china.huawei.com (10.136.114.27) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Oct 2024 10:34:12 +0800
From: chengyechun <chengyechun1@huawei.com>
To: <netdev@vger.kernel.org>, <j.vosburgh@gmail.com>, <andy@greyhouse.net>
CC: <vfalico@gmail.com>
Subject: [PATCH] enable port after switch
Date: Thu, 31 Oct 2024 10:34:08 +0800
Message-ID: <20241031023408.31008-1-chengyechun1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500016.china.huawei.com (7.185.36.197)

After switching the best aggregator,
change the backup value of the corresponding slave node to 0

Signed-off-by: chengyechun <chengyechun1@huawei.com>

---
 drivers/net/bonding/bond_3ad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index b19e0e41b..b07e42950 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1830,6 +1830,8 @@ static void ad_agg_selection_logic(struct aggregator *agg,
                                __disable_port(port);
                        }
                }
+               port = best->lag_ports;
+               __enable_port(port);
                /* Slave array needs update. */
                *update_slave_arr = true;
        }
--
2.33.0

