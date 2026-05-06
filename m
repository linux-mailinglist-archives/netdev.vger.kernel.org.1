Return-Path: <netdev+bounces-284697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPH1CSbF+mkzSgMAu9opvQ
	(envelope-from <netdev+bounces-284697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:35:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0254D621C
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A4473040C96
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 04:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62582E762C;
	Wed,  6 May 2026 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wsBGURmO"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8260426158C
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042144; cv=fail; b=JbJkgfJVpcFoUtGiQJe4RoSnZ22vpG2Ixuf6RwY459GuMtgw4yEGpAlPMcyN8N4FfMfrWZ4Ir9tnkS5rNTivE2SN24BO2s5iTaaTeUqWBDiThFAhSur3OwlCYAB4nDMQBnSHKMknurFTLpHucr0avFJkQfQadW/YaALyXJP1mZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042144; c=relaxed/simple;
	bh=wWcBMMgxRgYpXvsRtDJtxxr2VgXlwKEWwrFnwcO+IKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcqBiSCpyViFI1YhMZQO/rZpdgAkPuKBweNbCAiH5JnOqJSaiGwiw6VqVp4GKBfBLWLEgLJ5g24WZ1R0ZIfJ30IQoyX+DlgGXj2j3YHU/2Bajry1yVEqqE8nxw1gM+iav+wYws+PF3WG2W5nKMq31T0XVxSMIP6Sbt27M2GdvQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wsBGURmO; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2zvaugq/aZTtUyaW64k29mI+NHyTAUbqu2RqytKN7YqV0oMdO/wpgDjAQYVC0766juTuTMrUUQwJGkuQFyflOY6Gh3DRi+TapkZ4HTwfUZ7oQ8LtyNXyIqMo/dDDH7tM7iBrScgHgYqlPOmPbVU97EflBuY+p3qARtI/JsqlJe3xFPla94OBhMF/1+MBfqN90IleaOsjOc9B05x5b0tXNh00u6USKRg3xY1tWV3NOWMzR4UDrCwlIUArAf+0hOeG/PPIbzyJe8lJgDEfXZBoXET8Tq9bRcLdpoqngetZM1s3Zgbw+PpYq6bw2dbeKOQZpbmfWM06dmEOKZfEGIVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDQMApe/04WBHSfRcec+zfDwhpxi8bj13yxjGUCsxls=;
 b=XMWP+EW+N6tKtZgmEuzR1dAj2BabZD8Yl/0QzV863tRkjmFMvKNJumFqBi9qq5eAf1A5UBWSrpK4Y72s6Pg+sM782sM0VLMPSZ27LPvVQytdPYUQQQLa9698Ywt7gQ+4IpzE4k68eJADsc34UAPzcF5ll5pvO1eOy6dEBo4cXLUhZin8+3b1biClPbKZul5h7AoTPbIz+3IucqLJM1ndF38EonDKoi2EkIIh2Y2xa6KuMrb4myHX2RjelskxyVm8HyhtJNz/8wliGL34ii6mPLvi1NpLmm93cUOiUO9MGsuLPvOZl6VGf9PDTRPv+/LjyftU1F2ugIx8LuXM3ai1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDQMApe/04WBHSfRcec+zfDwhpxi8bj13yxjGUCsxls=;
 b=wsBGURmOvGbkpfJI69FIGY6uEwHQHabgc4lKC0zmKT5rKiE3U2eoZEsicdXfzjVfgvqIFqj7FWiL3S1NybTGy/WiXWz7FwdH0CPUP21UEVKzalnf77x85k2iNgCA37iAoR/MFfk/oIiUkqqaNZ6OESMvqvgqF2l1Zc45D3M3HJE=
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 04:35:40 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::74) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 04:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 04:35:40 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 23:35:39 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v2 1/5] ionic: Small improvements in devcmd retry logic
Date: Tue, 5 May 2026 21:35:21 -0700
Message-ID: <20260506043526.64301-2-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506043526.64301-1-eric.joyner@amd.com>
References: <20260506043526.64301-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e16a26-42b0-4c3c-7a70-08deab28ed53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	59fZ/zbDAHPTz7b/+2RPRUAmPoQkWewuN3GRVsjL7cfEmiSdkCD65BmuuHhIDh+G8v/A41hZEWArroRdrUFqTksuJS+cBqHvMmVEd+v6/+1rj2alULUNwgIK4PiU6lqvzwoWXQDqzOC22j9tBsLZ9DWUi3eMx/67wL2yAWUSVkzklvoUbTYFM8uwIbkOx69zKFt1lJ6PaGl/baiMaFClm1D0OxwYUFtmYpuUsWOV4Esg7ASmrnObwtWybPmDksJSZxsnU2KvzeLmPpQWuAjEWsqwHXAIhWA7EbCd8JogMxUR+iAys3etkJjyyf2qbb85vK/kkii95UhxWz2crEGskeOur9X2/mMvdmhA/jKvpQIEQgd4c4q42GEwLsOOCf/oNWvWnqf3Zu/ZCrdLiPuZw4POGk31O6VwuLeeeHlk5l5eUdVqKhRIDgCH2E81weebcpwMnH+FkVWVZiSzUj4b1d0+jkJcjaA7/TydtOyGVccVb3H1GVmVC0fsvAKCwR3319on9Uxt7TGMEfCi+GStcdmEx2bNjqRnUOFkG/qwQcIMRgal2iPi+dDsmlXD0b26BbIkM0hrEWAE2dhWCk8UOGImr+XB2e83qwkwRKhSOAk634UkFdJNgKYj+tKTX8TV/Bqb8GIqf/OO0DAGf0r/Xtiptd8KiPQUWA7safdcKxPTbX9g9jWFjYaS9ckVcujCbruz9j1xPzFnCTsQ8ecviB/mKzztFhHwAd61IPLksMg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q8TeOeG3ixl5JBD1fJ0v9sM258BRelRFkYeSGAM5R2pnBfruMRWcDqgPvWpTNLuOq8+rbcVxrwB7aH+nR/usbHDBMpNlN6INIWyCxApkl4YODUCU/WxiPsqOC5kiwKn6Dl/r6hiIWeSe7Hzr5bOi+tfWIXRNVtgm3WMV2xcWtsFu7fei7XccVoMOuxIyaETYwfHHu8pbJBJIyKOt80u5Rohn14Q7wPwo6nUIai4fa6X5ZneS4RRyPAs6T+RY2cBAh3iclCthzr+pdSczePkDLrzVb6Bl/liejvN/Wq6iBbTxjqTNjBcrZxSY4GRHq4R9wPxZLTkfMw13Ogm5wZBYyNCiBq8H4fCQOxFmMvYMe4lrbBnumaYbdgJFuzoLM/KhEhkPKfnqWPvNa8La+HwFLZfoHvRNa3mA2FmMAmhk9P0CUqO4oGEYETyoxxUM0+py
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:35:40.0556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e16a26-42b0-4c3c-7a70-08deab28ed53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
X-Rspamd-Queue-Id: 8C0254D621C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284697-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

If the timeout time is hit when the last attempt returned EAGAIN, the
driver returns -ETIMEDOUT. This causes the -EAGAIN result to be lost.
Fix this by returning -EAGAIN if the timeout time is hit and the
previous result matches. Another commit uses this return value to help
signal that a deferred probe should be performed due to the firmware not
being ready, which is why it would return EAGAIN.

Also, reduce the sleep between the write to done and doorbell registers.
The msleep(1000) was initially added in an arbitrary manner. However,
this long of a sleep is problematic because it reduces the number of
retries when -EAGAIN is returned, which may result in the devmcd giving
up early due to the timeout. Fix this by reducing the sleep to
msleep(50).

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 3c5200e2fdb7..92f2ec0bd5af 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -554,6 +554,11 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 
 	if (!done && !time_before(jiffies, max_wait)) {
 		ionic_dev_cmd_clean(ionic);
+
+		/* allow caller to manage EAGAIN from previous attempt */
+		if (err == IONIC_RC_EAGAIN)
+			return -EAGAIN;
+
 		dev_warn(ionic->dev, "DEVCMD %s (%d) timeout after %ld secs\n",
 			 ionic_opcode_to_str(opcode), opcode, max_seconds);
 		return -ETIMEDOUT;
@@ -568,7 +573,7 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 				ionic_error_to_str(err), err);
 
 			iowrite32(0, &idev->dev_cmd_regs->done);
-			msleep(1000);
+			msleep(50);
 			iowrite32(1, &idev->dev_cmd_regs->doorbell);
 			goto try_again;
 		}
-- 
2.17.1


