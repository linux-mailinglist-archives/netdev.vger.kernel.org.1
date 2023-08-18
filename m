Return-Path: <netdev+bounces-28711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCCD780552
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 07:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299762821EE
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 05:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1114285;
	Fri, 18 Aug 2023 05:05:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32D14280
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 05:05:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57823AAE
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 22:05:45 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRqVV4v85zNmyC;
	Fri, 18 Aug 2023 13:02:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 13:05:42 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <horatiu.vultur@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v2 2/3] net: lan966x: Fix return value check for vcap_get_rule()
Date: Fri, 18 Aug 2023 13:05:04 +0800
Message-ID: <20230818050505.3634668-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818050505.3634668-1-ruanjinjie@huawei.com>
References: <20230818050505.3634668-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As Simon Horman suggests, update vcap_get_rule() to always
return an ERR_PTR() and update the error detection conditions to
use IS_ERR(), so use IS_ERR() to fix the return value issue.

Fixes: 72df3489fb10 ("net: lan966x: Add ptp trap rules")
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Suggested-by: Simon Horman <horms@kernel.org>
---
v2:
- Update vcap_get_rule() to always return ERR_PTR instead of checking IS_ERR_OR_NULL()
- Update the commit message.
- Check IS_ERR() instead of NULL.
---
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 60bd0cff6677..63905bb5a63a 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -59,7 +59,7 @@ static int lan966x_ptp_add_trap(struct lan966x_port *port,
 	int err;
 
 	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
-	if (vrule) {
+	if (!IS_ERR(vrule)) {
 		u32 value, mask;
 
 		/* Just modify the ingress port mask and exit */
@@ -106,7 +106,7 @@ static int lan966x_ptp_del_trap(struct lan966x_port *port,
 	int err;
 
 	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
-	if (!vrule)
+	if (IS_ERR(vrule))
 		return -EEXIST;
 
 	vcap_rule_get_key_u32(vrule, VCAP_KF_IF_IGR_PORT_MASK, &value, &mask);
-- 
2.34.1


