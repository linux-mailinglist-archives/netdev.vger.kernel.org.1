Return-Path: <netdev+bounces-28122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DC277E4AB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B217A281AE3
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382D156CA;
	Wed, 16 Aug 2023 15:07:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC5156C8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:07:33 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7585125
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:07:32 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G8NOFh003130;
	Wed, 16 Aug 2023 08:07:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=8PuaQAiIXLDzgwUvyR6sZ3TAc0ta8rUsUU2We0P1dnE=;
 b=SwxJLdutnASuftavFORugAtycqhSDX3JMukTnr1EWG+n9+ZnsOVLelkH9+7ULFaecjIW
 +lgC8qQQcrrDJhKz2bQV5gMUyVPceHmXV0q0+YwM4gJ8zXF8WuWlqWZwKj7eOsmLJa3i
 dYefXDli+7kvGQUxZDjEsga97VeT18Y+gmIa5UvgVMcHcXCjbKo7OVt0zNT/NgGnCVgX
 cNkgbZSiyUoeIGodae/OYVQbyAAzPZBIKxwphJqwSf2CF89uZni5cm0DQfy1VPJIZJUU
 rVrXauGwlqISZVnINPv/tjGwQJhpIgK+FcN4QHmJ5W2tQbwMxksDa/pLPYE/plvS+FQx 3A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sgtwch81d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 08:07:21 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 16 Aug
 2023 08:07:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 16 Aug 2023 08:07:20 -0700
Received: from falcon.marvell.com (unknown [10.30.46.95])
	by maili.marvell.com (Postfix) with ESMTP id F28CB3F707E;
	Wed, 16 Aug 2023 08:07:13 -0700 (PDT)
From: Manish Chopra <manishc@marvell.com>
To: <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <aelior@marvell.com>, <palok@marvell.com>,
        <njavali@marvell.com>, <skashyap@marvell.com>, <jmeneghi@redhat.com>,
        <yuval.mintz@qlogic.com>, <skalluru@marvell.com>, <pabeni@redhat.com>,
        <edumazet@google.com>, <horms@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: [PATCH v3 net] qede: fix firmware halt over suspend and resume
Date: Wed, 16 Aug 2023 20:37:11 +0530
Message-ID: <20230816150711.59035-1-manishc@marvell.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: j2EGeQme74Ma4RJmhbWrH8up1T03ErvF
X-Proofpoint-ORIG-GUID: j2EGeQme74Ma4RJmhbWrH8up1T03ErvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_15,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While performing certain power-off sequences, PCI drivers are
called to suspend and resume their underlying devices through
PCI PM (power management) interface. However this NIC hardware
does not support PCI PM suspend/resume operations so system wide
suspend/resume leads to bad MFW (management firmware) state which
causes various follow-up errors in driver when communicating with
the device/firmware afterwards.

To fix this driver implements PCI PM suspend handler to indicate
unsupported operation to the PCI subsystem explicitly, thus avoiding
system to go into suspended/standby mode.

Without this fix device/firmware does not recover unless system
is power cycled.

Fixes: 2950219d87b0 ("qede: Add basic network device support")
Cc: David Miller <davem@davemloft.net>
Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Alok Prasad <palok@marvell.com>
---
V1->V2:
* Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS

V2->V3:
* Removed unnecessary device NULL check in qede_suspend()
* Updated the commit description to reflect that without
  this fix firmware can't be recovered over suspend/resume
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index d57e52a97f85..c7911a13e8f5 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -177,6 +177,15 @@ static int qede_sriov_configure(struct pci_dev *pdev, int num_vfs_param)
 }
 #endif
 
+static int __maybe_unused qede_suspend(struct device *dev)
+{
+	dev_info(dev, "Device does not support suspend operation\n");
+
+	return -EOPNOTSUPP;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(qede_pm_ops, qede_suspend, NULL);
+
 static const struct pci_error_handlers qede_err_handler = {
 	.error_detected = qede_io_error_detected,
 };
@@ -191,6 +200,7 @@ static struct pci_driver qede_pci_driver = {
 	.sriov_configure = qede_sriov_configure,
 #endif
 	.err_handler = &qede_err_handler,
+	.driver.pm = &qede_pm_ops,
 };
 
 static struct qed_eth_cb_ops qede_ll_ops = {
-- 
2.27.0


