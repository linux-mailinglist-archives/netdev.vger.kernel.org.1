Return-Path: <netdev+bounces-29329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83390782AA2
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EA2280E47
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB247746E;
	Mon, 21 Aug 2023 13:36:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD416FBE
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:36:02 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A49F5
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:35:54 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RTtk7416Vz1L9Pt;
	Mon, 21 Aug 2023 21:34:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 21:35:49 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next] dp83640: Use list_for_each_entry() helper
Date: Mon, 21 Aug 2023 21:35:28 +0800
Message-ID: <20230821133528.3131786-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert list_for_each() to list_for_each_entry() where applicable.

No functional changed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/phy/dp83640.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index ef8b14135133..2657be7cc049 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -631,7 +631,6 @@ static void recalibrate(struct dp83640_clock *clock)
 	s64 now, diff;
 	struct phy_txts event_ts;
 	struct timespec64 ts;
-	struct list_head *this;
 	struct dp83640_private *tmp;
 	struct phy_device *master = clock->chosen->phydev;
 	u16 cal_gpio, cfg0, evnt, ptp_trig, trigger, val;
@@ -648,8 +647,7 @@ static void recalibrate(struct dp83640_clock *clock)
 	/*
 	 * enable broadcast, disable status frames, enable ptp clock
 	 */
-	list_for_each(this, &clock->phylist) {
-		tmp = list_entry(this, struct dp83640_private, list);
+	list_for_each_entry(tmp, &clock->phylist, list) {
 		enable_broadcast(tmp->phydev, clock->page, 1);
 		tmp->cfg0 = ext_read(tmp->phydev, PAGE5, PSF_CFG0);
 		ext_write(0, tmp->phydev, PAGE5, PSF_CFG0, 0);
@@ -667,10 +665,8 @@ static void recalibrate(struct dp83640_clock *clock)
 	evnt |= (CAL_EVENT & EVNT_SEL_MASK) << EVNT_SEL_SHIFT;
 	evnt |= (cal_gpio & EVNT_GPIO_MASK) << EVNT_GPIO_SHIFT;
 
-	list_for_each(this, &clock->phylist) {
-		tmp = list_entry(this, struct dp83640_private, list);
+	list_for_each_entry(tmp, &clock->phylist, list)
 		ext_write(0, tmp->phydev, PAGE5, PTP_EVNT, evnt);
-	}
 	ext_write(0, master, PAGE5, PTP_EVNT, evnt);
 
 	/*
@@ -709,8 +705,7 @@ static void recalibrate(struct dp83640_clock *clock)
 	event_ts.sec_hi = ext_read(master, PAGE4, PTP_EDATA);
 	now = phy2txts(&event_ts);
 
-	list_for_each(this, &clock->phylist) {
-		tmp = list_entry(this, struct dp83640_private, list);
+	list_for_each_entry(tmp, &clock->phylist, list) {
 		val = ext_read(tmp->phydev, PAGE4, PTP_STS);
 		phydev_info(tmp->phydev, "slave  PTP_STS  0x%04hx\n", val);
 		val = ext_read(tmp->phydev, PAGE4, PTP_ESTS);
@@ -730,10 +725,8 @@ static void recalibrate(struct dp83640_clock *clock)
 	/*
 	 * restore status frames
 	 */
-	list_for_each(this, &clock->phylist) {
-		tmp = list_entry(this, struct dp83640_private, list);
+	list_for_each_entry(tmp, &clock->phylist, list)
 		ext_write(0, tmp->phydev, PAGE5, PSF_CFG0, tmp->cfg0);
-	}
 	ext_write(0, master, PAGE5, PSF_CFG0, cfg0);
 
 	mutex_unlock(&clock->extreg_lock);
-- 
2.34.1


