Return-Path: <netdev+bounces-237891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F76C5140B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E0854F118B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A462ECD37;
	Wed, 12 Nov 2025 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eBIRplON";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eBIRplON"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD22C026D;
	Wed, 12 Nov 2025 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937972; cv=none; b=SfrhynyePARJm29yQjjzQQP3ioko0e9RascI+jzcZ/h2yqVERaXz3Gp36OJRaWfNsmBwpqJA3XEepkajLcKzxxd3zFvZA0KjXxuLDZmN8JmSipGf4u3z/oMgwCgXWFG+3/YZo5MBI92FVz2V3UxiZJ1orfTWfDhzSH/s9BAGIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937972; c=relaxed/simple;
	bh=PHnnkaO19JvgvLObhrULFV6oSIZSftfgUoBzbq4qieY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JETt44W6hHGAC2VhBVzOIJ8mBgTCcDExHLSOrjO9nMIl60MvuMWW77E8a0o7N3DInheZLrAU1uylAf4KbD9suxyidE13qnhbYJwJNmumy4VEX8v3bUYxPkWWX4/x9eoiJAglbJPBq4A5uaaOz2b9Mf5wtwFxU95CZ1Du0eANf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eBIRplON; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eBIRplON; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DtmNzYi5JFbr/28DJPf5U2A+MzUDv+eLIejQD94XcTs=;
	b=eBIRplONbiLFvbqtiY/JnfS9MTJXqUGJ3JsM8fbOclYjRB1894FGLq2vhdBANWzEF6ANr0j+D
	BAPVOkFxZhOb8h9cYCyVLP06ins5W44xzJPcBLwIklyVTXYp4HNm2GcvJ+zUgw0PjXiovwTF82m
	8NDNzoz/aHrzM3etq1Q+ZQQ=
Received: from canpmsgout10.his.huawei.com (unknown [172.19.92.130])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4d5y4f1Yh5z1BH9l;
	Wed, 12 Nov 2025 16:58:58 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DtmNzYi5JFbr/28DJPf5U2A+MzUDv+eLIejQD94XcTs=;
	b=eBIRplONbiLFvbqtiY/JnfS9MTJXqUGJ3JsM8fbOclYjRB1894FGLq2vhdBANWzEF6ANr0j+D
	BAPVOkFxZhOb8h9cYCyVLP06ins5W44xzJPcBLwIklyVTXYp4HNm2GcvJ+zUgw0PjXiovwTF82m
	8NDNzoz/aHrzM3etq1Q+ZQQ=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d5y340cy1z1K9YM;
	Wed, 12 Nov 2025 16:57:36 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E88441402CF;
	Wed, 12 Nov 2025 16:59:13 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Nov
 2025 16:59:03 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <idosch@nvidia.com>,
	<razor@blackwall.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] vxlan: Remove unused declarations eth_vni_hash() and fdb_head_index()
Date: Wed, 12 Nov 2025 17:20:55 +0800
Message-ID: <20251112092055.3546703-1-yuehaibing@huawei.com>
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
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 1f763fa808e9 ("vxlan: Convert FDB table to rhashtable") removed the
implementations but leave declarations.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/vxlan/vxlan_private.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 99fe772ad679..b1eec2216360 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -188,8 +188,6 @@ int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 		       const unsigned char *addr, union vxlan_addr ip,
 		       __be16 port, __be32 src_vni, __be32 vni,
 		       u32 ifindex, bool swdev_notify);
-u32 eth_vni_hash(const unsigned char *addr, __be32 vni);
-u32 fdb_head_index(struct vxlan_dev *vxlan, const u8 *mac, __be32 vni);
 int vxlan_fdb_update(struct vxlan_dev *vxlan,
 		     const u8 *mac, union vxlan_addr *ip,
 		     __u16 state, __u16 flags,
-- 
2.34.1


