Return-Path: <netdev+bounces-153064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C69F6B3A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FCD188C5AA
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22A51F63F9;
	Wed, 18 Dec 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="XYMrAHMG"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A81C5CD5;
	Wed, 18 Dec 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539638; cv=none; b=kU1xX+AoNiN2j+MR7ZS3YHIyV6imbORQ9O8WnLLOQFJhJ2h7q7OjLO8mBgTfCKj5qKgS1J7D9Ys6enjCQQmIZkFHwcA9Xsvt4kqB7DtHZ3bWyx1HHUuPcy7dkiB7GKjJhdb2M11L8eEnDHLhwa45Bg5dIBVR+OqBzvfoRtdTlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539638; c=relaxed/simple;
	bh=OAoHuQgl3t/ERWiJ5VbkjoMyHRnESBFVdCNTV1w7joY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWUJCncEsL0iSseb1huZLkiESgsKMFk3HwCMSHguza71tjCbnqp46vACS37+vBZtmJrLbnEQlsEXMsVoGP/XCceovIBaSpG+WkSMSKhUaT6etCwFJQYxXW01Fej4ukIw6qOzccteDZSIOiTaWSdwQ8AxTzJT1mbtTy7Z951EjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=XYMrAHMG; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=XIJ1QZJLc3cPNb+OrjpdBKT4GYte0/Yf+h52CfhDBjs=; b=XYMrAHMGa8w/Iwz/
	VDSeEasgN8lS/Wq4J/WtPxDfUI01sY8pQ8q9x6ziror+nHbAXm9BAjt87GsOfoMX/p/LEKWij2QIW
	nHHj/hA/sfZPZh3lYx8eyXs5CSxi/1KwkpccaL0KUkRhL3qX6C21TuH60f2UlCEh4Q9Hnwo5+7vxb
	v/6098nkFovToZ1ZK8Db4QIjZYJfXC95W9WBlNi+RbY2PiY3DnRQICVkQ8Q6kvCWds5ngN09jJqmn
	GZj4vDhh64OtMa7MzzxthXqIYBSaokRmCZuY67hk4Gv83FHMQniN08NDTRd+8a6Fqufb0t5H8H8lD
	7FjSh7vWZKJncz98yw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tNwzZ-0068f8-2I;
	Wed, 18 Dec 2024 16:33:45 +0000
From: linux@treblig.org
To: salil.mehta@huawei.com,
	shenjian15@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next v2 3/4] net: hisilicon: hns: Remove reset helpers
Date: Wed, 18 Dec 2024 16:33:40 +0000
Message-ID: <20241218163341.40297-4-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218163341.40297-1-linux@treblig.org>
References: <20241218163341.40297-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

With hns_dsaf_roce_reset() removed in a previous patch, the two
helper member pointers, 'hns_dsaf_roce_srst',  and 'hns_dsaf_srst_chns'
are now unread.

Remove them, and the helper functions that they were initialised
to, that is hns_dsaf_srst_chns(), hns_dsaf_srst_chns_acpi(),
hns_dsaf_roce_srst() and hns_dsaf_roce_srst_acpi().

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Jijie Shao<shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns/hns_dsaf_main.h    |  3 -
 .../ethernet/hisilicon/hns/hns_dsaf_misc.c    | 67 -------------------
 2 files changed, 70 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
index c90f41c75500..bb8267aafc43 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
@@ -307,9 +307,6 @@ struct dsaf_misc_op {
 	void (*ge_srst)(struct dsaf_device *dsaf_dev, u32 port, bool dereset);
 	void (*ppe_srst)(struct dsaf_device *dsaf_dev, u32 port, bool dereset);
 	void (*ppe_comm_srst)(struct dsaf_device *dsaf_dev, bool dereset);
-	void (*hns_dsaf_srst_chns)(struct dsaf_device *dsaf_dev, u32 msk,
-				   bool dereset);
-	void (*hns_dsaf_roce_srst)(struct dsaf_device *dsaf_dev, bool dereset);
 
 	phy_interface_t (*get_phy_if)(struct hns_mac_cb *mac_cb);
 	int (*get_sfp_prsnt)(struct hns_mac_cb *mac_cb, int *sfp_prsnt);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
index 5df19c604d09..91391a49fcea 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
@@ -326,69 +326,6 @@ static void hns_dsaf_xge_srst_by_port_acpi(struct dsaf_device *dsaf_dev,
 				   HNS_XGE_RESET_FUNC, port, dereset);
 }
 
-/**
- * hns_dsaf_srst_chns - reset dsaf channels
- * @dsaf_dev: dsaf device struct pointer
- * @msk: xbar channels mask value:
- * @dereset: false - request reset , true - drop reset
- *
- * bit0-5 for xge0-5
- * bit6-11 for ppe0-5
- * bit12-17 for roce0-5
- * bit18-19 for com/dfx
- */
-static void
-hns_dsaf_srst_chns(struct dsaf_device *dsaf_dev, u32 msk, bool dereset)
-{
-	u32 reg_addr;
-
-	if (!dereset)
-		reg_addr = DSAF_SUB_SC_DSAF_RESET_REQ_REG;
-	else
-		reg_addr = DSAF_SUB_SC_DSAF_RESET_DREQ_REG;
-
-	dsaf_write_sub(dsaf_dev, reg_addr, msk);
-}
-
-/**
- * hns_dsaf_srst_chns_acpi - reset dsaf channels
- * @dsaf_dev: dsaf device struct pointer
- * @msk: xbar channels mask value:
- * @dereset: false - request reset , true - drop reset
- *
- * bit0-5 for xge0-5
- * bit6-11 for ppe0-5
- * bit12-17 for roce0-5
- * bit18-19 for com/dfx
- */
-static void
-hns_dsaf_srst_chns_acpi(struct dsaf_device *dsaf_dev, u32 msk, bool dereset)
-{
-	hns_dsaf_acpi_srst_by_port(dsaf_dev, HNS_OP_RESET_FUNC,
-				   HNS_DSAF_CHN_RESET_FUNC,
-				   msk, dereset);
-}
-
-static void hns_dsaf_roce_srst(struct dsaf_device *dsaf_dev, bool dereset)
-{
-	if (!dereset) {
-		dsaf_write_sub(dsaf_dev, DSAF_SUB_SC_ROCEE_RESET_REQ_REG, 1);
-	} else {
-		dsaf_write_sub(dsaf_dev,
-			       DSAF_SUB_SC_ROCEE_CLK_DIS_REG, 1);
-		dsaf_write_sub(dsaf_dev,
-			       DSAF_SUB_SC_ROCEE_RESET_DREQ_REG, 1);
-		msleep(20);
-		dsaf_write_sub(dsaf_dev, DSAF_SUB_SC_ROCEE_CLK_EN_REG, 1);
-	}
-}
-
-static void hns_dsaf_roce_srst_acpi(struct dsaf_device *dsaf_dev, bool dereset)
-{
-	hns_dsaf_acpi_srst_by_port(dsaf_dev, HNS_OP_RESET_FUNC,
-				   HNS_ROCE_RESET_FUNC, 0, dereset);
-}
-
 static void hns_dsaf_ge_srst_by_port(struct dsaf_device *dsaf_dev, u32 port,
 				     bool dereset)
 {
@@ -729,8 +666,6 @@ struct dsaf_misc_op *hns_misc_op_get(struct dsaf_device *dsaf_dev)
 		misc_op->ge_srst = hns_dsaf_ge_srst_by_port;
 		misc_op->ppe_srst = hns_ppe_srst_by_port;
 		misc_op->ppe_comm_srst = hns_ppe_com_srst;
-		misc_op->hns_dsaf_srst_chns = hns_dsaf_srst_chns;
-		misc_op->hns_dsaf_roce_srst = hns_dsaf_roce_srst;
 
 		misc_op->get_phy_if = hns_mac_get_phy_if;
 		misc_op->get_sfp_prsnt = hns_mac_get_sfp_prsnt;
@@ -746,8 +681,6 @@ struct dsaf_misc_op *hns_misc_op_get(struct dsaf_device *dsaf_dev)
 		misc_op->ge_srst = hns_dsaf_ge_srst_by_port_acpi;
 		misc_op->ppe_srst = hns_ppe_srst_by_port_acpi;
 		misc_op->ppe_comm_srst = hns_ppe_com_srst;
-		misc_op->hns_dsaf_srst_chns = hns_dsaf_srst_chns_acpi;
-		misc_op->hns_dsaf_roce_srst = hns_dsaf_roce_srst_acpi;
 
 		misc_op->get_phy_if = hns_mac_get_phy_if_acpi;
 		misc_op->get_sfp_prsnt = hns_mac_get_sfp_prsnt_acpi;
-- 
2.47.1


