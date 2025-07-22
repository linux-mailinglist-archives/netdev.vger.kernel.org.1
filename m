Return-Path: <netdev+bounces-208832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A5AB0D555
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831C218960F3
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1FE2DA74A;
	Tue, 22 Jul 2025 09:09:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550BC2D94B9;
	Tue, 22 Jul 2025 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175360; cv=none; b=lfsliDau40kl4LmYHsRjlnLPGd20a0dn0ie1zFNTjVpqH6HTK7DKXGCmzufcq9Q/vgCiWJIReZOfI/jkzyacZ4+Y+MuhrxWCW0yhSOdZzJhvft1TchNAexxlpuuuLn+CCop2Vmzabyimg+KwfEuENqc3+eRP7aHEq0UiygX/TPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175360; c=relaxed/simple;
	bh=1o/LTkJI+I2+3ykr4kZAtYM62gPlyP8GbeRfcVdGTwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DFQW4DWUyOmjSz/TUoma9tmCWl0KBO48SkSZ2ZKijKNuEviCtg7DXWiZoRoZvxvxwsWt5LhOp36sn4ZS0DO6QzeMFYG/6POtzWdze1IBlELCSkIguZXJ883VEzg73jgDLuzNBQL4mK6OUEgAExshw98nDH3feeXY7CzBiRlI1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bmWY44yTyz14LqZ;
	Tue, 22 Jul 2025 17:04:24 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 3045A147B64;
	Tue, 22 Jul 2025 17:09:14 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Jul
 2025 17:09:12 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>,
	<idosch@nvidia.com>, <petrm@nvidia.com>, <menglong8.dong@gmail.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] vxlan: remove redundant conversion of vni in vxlan_nl2conf
Date: Tue, 22 Jul 2025 17:30:49 +0800
Message-ID: <20250722093049.1527505-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The IFLA_VXLAN_ID data has been converted to local variable vni in
vxlan_nl2conf(), there is no need to do it again when set conf->vni.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 97792de896b7..77dbfe9a6b13 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4036,7 +4036,7 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_ID], "Cannot change VNI");
 			return -EOPNOTSUPP;
 		}
-		conf->vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
+		conf->vni = vni;
 	}
 
 	if (data[IFLA_VXLAN_GROUP]) {
-- 
2.34.1


