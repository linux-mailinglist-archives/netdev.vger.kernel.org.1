Return-Path: <netdev+bounces-283083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBd6Fewb9Gnp+QEAu9opvQ
	(envelope-from <netdev+bounces-283083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:20:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C84A9E7E
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39FA630089A6
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 03:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4F2E2840;
	Fri,  1 May 2026 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="thKxDt3x"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B229CE1
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777605608; cv=fail; b=JkUQbKSaU1mrokTKu5STDfLW/qdl/mmqSAy/TadbvwXoAGZ7wLgTmSdSDnZib3l6cyJZuF5rttTUSUhUbutFh6Y/MeZ1jkJRSgftbUcm3iXXIeA00LY4T76VV0qvCCGGI6JB5aG8lYY3OPn0mD87cH8Rp+UFEsRwjGsDyjSSZf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777605608; c=relaxed/simple;
	bh=3HTobRdLLaKDT3uso81k1VdMjKjZBJvLOMQtmc7jmQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RzPuHoX9HmAalp/3zeYpoE8Pyp1G2YLz+vog5jdollETEAA0TV2vpErql6cZMghl3Kwc4/v+exxH4R+ucRJL08f4mOBit9fMFJqr4BbkOWdsAjCjbYpPpEKLG+ClfeDhSG1O2pd9TKuIJiVfCZFFwvLUKlTlvodNTNYxPhrLCS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=thKxDt3x; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzmcTopVSmtaFM35GTsQR94aRMTYZY8eYArZ8Zd9Oh4QF7xajnQVmZeFPk9MhkbUi/ntU6CHRygXneiIQRNrY+rtQLpvMVTaATKUDEawcVUEgeC2rvSnhCd47CAQKPErpSNFjMqV90xP9bQn561fp+lMz6wRt5VndbNDAzanf/3RNeUohV8i1aJxKKRsE1VMvDLw9lGx5xJTNL41P71E9US/HvFsTb/9qyM41HxkhnKe7Cv0+nJYIQ7v5r0gIXYNAnNrveiu19qUzMtJH1sRKEvjMMwLFSS9al7SlLuENiR+vOuk2Ld6g2cYCU/1+sC3T0IMlP3Gr337WQShpfW69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhgHDM0rFypn10JdWoC5+CSDLGjxlF/cbozHABAH/q0=;
 b=XNtsVTEMA3iLAOBMLAmv9uuOxTvHgxzOds87cnpEpPmxKkULZtsZs2gXKMalAMsUa55A2U8O/Vf0/7dnZTqG47I0bNqJkU60looEtaOxE4V1ou2jirKU6o47MUzPSEY20JtSjHNZ8hFXXvwnzHi5N18x6r5nSgN4v3Pp6zLcOAciGYvOj8yJTWvYr/ed0dfZdkBJMGdW0KNnEWdzFP9UOelFxJayCXtBXyC9fTgUs1b9hOSqofBt9p+kCVvADW0m7aiZN5mSdsbKRZADzaJdqTUzlX6gwTjzGRTJED/qbKpGFykM9bRp9N20Pix8mtm8t71dlqctIBqHPED7McNUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhgHDM0rFypn10JdWoC5+CSDLGjxlF/cbozHABAH/q0=;
 b=thKxDt3xWo3WNC1uJL8BhXx68FWxrKJQy0bwZua2NRKhjvV3bT0MlUB/C1y7aA9XBp29pDmhSsNPy7W8TYGtW7+cg1Fnn0T0FZqXw+sRntRJy/3LqS4p1s+6fcQ8a6Z5hGFfs+6H8XHJscFunKy89EGz0GLLOes347s553T7jKY=
Received: from PH8P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::10)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 03:20:02 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:2d8:cafe::f0) by PH8P221CA0005.outlook.office365.com
 (2603:10b6:510:2d8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Fri,
 1 May 2026 03:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Fri, 1 May 2026 03:20:01 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 22:20:00 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net] pds_core: Fix potential invalid stack memory access
Date: Thu, 30 Apr 2026 20:19:44 -0700
Message-ID: <20260501031944.52172-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da401a2-9d84-4b7e-33c3-08dea730882f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yvbBvEBuKjdYUJ7xG7QAst/GuzaPt/oCDra6Ku3z4hCAqQejjqukgey+mEibm7I0j1pF2gAsLrfzZBsh5ODAzhN9c1/fnB5+LzXPRdRriQWfNl65TkRsyeiPh6uVerklHnDizR5VQRzbUkt2izgZtdOJEIMF6mt27UllLZGI21Edz62IivAYKhmnBtAT1meoATeWG1pvp9MeaPjAoFqK2iO8sloGixgOhpydDwtcftpEg5E6rwznlEqsWrsxpr46S2AGdmGQpVazip+N6k+OKs9jDDbU643JGG5tpWdUWhj8KICQpkNgPdXvr0GpPBqF/bqu62Kr/htD1ySsHjHXxmWuDh1FiiQTHPpPauXVZ9nXxymgGuZf3odNauTz3HE6+W25UNN+EXHdu9xe7RbU7o7bICknA3KeT3p2uWOb3pfxGM+D/8lvdNW28LKLpptqT5CW0pu3H8VnegxJ+TkIQPGrd21ezDzN+5toFdsPzgW8STEgSBcOo3vKOMuqzufRhaj4rmU4kf690rd8tnA4guKlQzDW2osuaFfcTebQOXhuIHqpwP8XTIkwq3ccSxYbqKKQK1xUCYc9Lkmv2F3Q6R1bqDv2u846ePdqTT0qGpfGKQ0OhWAk9097bnG3rEnrIDgXrE6LFAPoF8bIqiqHT0zylj6noM3+ToSKOWAMjcaDYY1Li2VMc9tBwqeQ94iR4qwo4AZFHoGyJkyfzKPydRqbKxYqohudxhLAC982mnU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IErIkP/VlsY+J5DSxkK3aiT4XrqMOJPjbkpLQLgP+nXwZq0tKWX2YjOPOPAUHsbqtQs0/Dn+D39WggRmTwyvapnqkckvQz7WO470ctfN+jIpjgAD9qhyj8qTM37h+b7XN5q628MxvZOmXMJKlSgbOURLwTe9tbgBpYKMKVk5+lsbg1UE9824WOESXdR43KeXS+tbKMotmTJsC2ZqoZwpeGW1l788gWR/0z1v/CcvAT54G3o5CF3E5PsjRsLIZl9hf5yPVMyUhnwwozR6yOqocqURsP67yLqwn0pRoRANZZT1tmY+hKr1356He8K0a2T8Y3b4XbogPldrRnvt3JD91USt77C4j4Dl18ElrOHTlszx8LnUkVMx+uAWkAbFjtIAxtwC3BGEOyq3PE+V+BvFLJWNLzLkBpLmU+6mC0gYGbardhKmE3FNkyMu0NasRdyU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 03:20:01.6957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da401a2-9d84-4b7e-33c3-08dea730882f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148
X-Rspamd-Queue-Id: DC3C84A9E7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283083-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

pds_adminq_post() and pds_process_adminq() can run concurrently
together; either one can check if the current request is complete:
pds_adminq_post() does it after the loop inside it times out waiting
for the completion, and pds_process_adminq() when it sees the
uncompleted request on the ring.

However, since pds_adminq_post() does not do any synchronization
around checking for an incomplete command after it reaches its timeout
and marking the command as complete, there is a small window where both
pds_process_adminq() and pds_adminq_post() can execute their
if(!completion_done()) clauses when the completion_done() returns
false; if pdsc_adminq_post() finishes first and its callers return,
then pdsc_process_adminq() will attempt to access q_info->dest after
the address in there points to an invalid location.

(q_info->dest will be invalid after pdsc_adminq_post()'s call chain
exits because it is pointing to a stack variable "comp" in
pdsc_fw_rpc())

Fix this by locking around the completion_done() check and the
complete() contained in the if-statement with the same adminq_lock that
pds_process_adminq() uses, which will prevent this synchronization
issue from occurring.

Fixes: 3f77c3dfffc7 ("pds_core: make wait_context part of q_info")
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 097bb092bdb8..6db7d29cdf5c 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -283,9 +283,15 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		__func__, jiffies_to_msecs(time_done - time_start));
 
 	/* Check the results and clear an un-completed timeout */
-	if (time_after_eq(time_done, time_limit) && !completion_done(wc)) {
-		err = -ETIMEDOUT;
-		complete(wc);
+	if (time_after_eq(time_done, time_limit)) {
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&pdsc->adminq_lock, irqflags);
+		if (!completion_done(wc)) {
+			err = -ETIMEDOUT;
+			complete(wc);
+		}
+		spin_unlock_irqrestore(&pdsc->adminq_lock, irqflags);
 	}
 
 	dev_dbg(pdsc->dev, "read admin queue completion idx %d:\n", index);

base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
-- 
2.17.1


