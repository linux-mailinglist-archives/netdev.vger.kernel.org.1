Return-Path: <netdev+bounces-78168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8E8743E5
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895401F21657
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4519F1CAB7;
	Wed,  6 Mar 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i5y7XE2p"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8B1CA84
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767820; cv=fail; b=Om93RVcjLRZtgq4CJTJJrlx9X0+sq7T3opWjStIJ+nUlt0TgPAEJOKiNUc9cqhLkgfjgo/wfv7RFzyp5R7fbfu50r3k6G3j/dd6YBzkpEcvQustpILkMQwIkeQ818U+Wgl/P9Ku4EOiUDNqADDZozpynml1rDsAU+4nV68utmHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767820; c=relaxed/simple;
	bh=VraMFe7gzdur3HW0xSm/2MTgDFSZnPgihl1f8Gf19nc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cgwWyStwTCze9Vd4vZ8IXdXV+9M0l80sG+rOhGKNHYBU1aA+hE83iK1L3nWx2ZC9Yz2Hj0Qpwx1Ip1kymxdiNNOA69CeuzU3GvugMQ6ob3knfpciCPzUio4WFJsIdqMdGZmgO7YpiudVouV7VzoP7vIrSGMgprWjYZ93yMjkz8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i5y7XE2p; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEWNznhJz8YGshfYn5cmK4Mf2Gs/4ftx61hPOcufVNv7TRF3l9Rn2/aFqAVNUTdBOfdTj++POqpuqxLhPXiot7wogAUjPlgljSc4YmvoJ/SQKQJDujBTYEVoJ9jN2aOlQII+x80vC0Ld2Sn3iIVDPAtQKEZdeNdTTZ6atEYv5FP69MWzMurzx0B7fgeUuGt/KhpbY32UYN+K3FvURIJZVKc87WUi3ciMFBBpi4nJkX/V5cxyvxNJoY0kzQBkGbYmKYb/Om9EdsoHsvkrp1cbFX332a0YMwHFbxuuoJBRxDsmVAiqICEAEtUEUpWSxPm43jokooUDhsVj/w00KbbP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnYUPBo9rwXv34/+iSN+/O41OJYKjp6zcDRXPGBh538=;
 b=Q/Q/9a7oBSHtzuLg93iRliw7l8bM/t8kcSnqETZh+dWxXMdG0dGYtO1RynQxk+SbRlLPvuY6IB26HCon1pYiWIkTSlZ7nVTthc+N9RhhH0EEelkmpDS89kjGUQqJXQ2I4ECiAnGQRR4pnAtDN2+JBah2u4S3tlvuny3zDs93M8XxzSwm5pPYQwTGROZJ8w3jxQTD30bMSzy3PKLlby19ImSxrQMzGAFlpvtoK1gVj6Z4ycIM+W1JG18TN5kcJvIsOxk70o2MBTY6MP18zY8mB6+Dr5wqv9tjogNkBezXWBDg76mrqrHz30MvvZ24BswffMHEBAxvvBRt0M13C3BTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnYUPBo9rwXv34/+iSN+/O41OJYKjp6zcDRXPGBh538=;
 b=i5y7XE2pP38XzG87BdORqRO488fHr6gN4DeO0fXNcvRX7INLvBDJPA9ge3+JvHG4rFecnsI006Xdd/EhEXkUicSB43iXmauU6yQYV1vFkZnGQVpJFs/qLZtDJ9V+ZGcWFav170LWlmkcnMUbTCmjZR+bcAG3H2NOPIrUORVV1Fo=
Received: from SA9PR03CA0025.namprd03.prod.outlook.com (2603:10b6:806:20::30)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Wed, 6 Mar
 2024 23:30:15 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::9f) by SA9PR03CA0025.outlook.office365.com
 (2603:10b6:806:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:14 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:12 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 00/14] ionic: putting ionic on a diet
Date: Wed, 6 Mar 2024 15:29:45 -0800
Message-ID: <20240306232959.17316-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: ee808eba-434e-4f02-4622-08dc3e356038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f1+nbMiOhiBPtOrgp6I7GhLUolDnokG6+4l8uR2oOxuELfi7CtoC/s3dFZUMtoEs2AkREeBu4LQy5poOBJqYFb8ME9pCQr4ZrfasiKuHirkkRPXH5+/vQldGHkho/EeFJtAujl7n8csPHQr4BaoS6PuSP19HQA7E0LNff355jIlM3a7BWOcEzTPJBKjaa3SF+hCJPjuEEPxdOqm1NmSYX+O6PGa7ETwh+P3VNGfeGrlBd1mXKgBdt3nnKGomgKJZJjzetDJ9rwcN9Ww0Z+kyQTONYi9q5OT47jHt+bS7S/Py95ys+DyZLIZWMQ3OxCF1rUGbyAexJp9z0jS+Xq9D6IyAX5cvRh5Tjt2g5km+2158uSN3NqAIoJiP0NBLpsEoj5WU1yJJ9nySoNeieMBKPjfs0XjJI4Hmtxc0xIJ7J3mMFRzPtuyYp6VWcfwtuCDsV56yRv5EQu9AeRdoxxhUg/kMNGXlvGmYtE03cN+9kbkm2ryiX83X3oK+/iQt1jvQmf2KdkrmJaU0NNiehXEdyvPClfAGSWaevuzTnlwi1qK1CR45uoKHSsFf18zPuOorBdOEcVuYMA3vnCNzBHh6K4nbPvm6vGMkrflfnvCqj0bqxub50HlvHNj96Hrgy8u2s8+oYx2HqTlv578c7bceDWkQbR23/GRCGgPAFCN/PErY9Jn1fuefIWRMv/WGTvjF6TlaMdMnpWFcZGnyTD9yTQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:14.7632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee808eba-434e-4f02-4622-08dc3e356038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

Building on the performance work done in the previous patchset
    [Link] https://lore.kernel.org/netdev/20240229193935.14197-1-shannon.nelson@amd.com/
this patchset puts the ionic driver on a diet, decreasing the memory
requirements per queue, and simplifies a few more bits of logic.

We trimmed the queue management structs and gained some ground, but
the most savings came from trimming the individual buffer descriptors.
The original design used a single generic buffer descriptor for Tx, Rx and
Adminq needs, but the Rx and Adminq descriptors really don't need all the
info that the Tx descriptors track.  By splitting up the descriptor types
we can significantly reduce the descriptor sizes for Rx and Adminq use.

There is a small reduction in the queue management structs, saving about
3 cachelines per queuepair:

    ionic_qcq:
	Before:	/* size: 2176, cachelines: 34, members: 23 */
	After:	/* size: 2048, cachelines: 32, members: 23 */

We also remove an array of completion descriptor pointers, or about
8 Kbytes per queue.

But the biggest savings came from splitting the desc_info struct into
queue specific structs and trimming out what was unnecessary.

    Before:
	ionic_desc_info:
		/* size: 496, cachelines: 8, members: 10 */
    After:
	ionic_tx_desc_info:
		/* size: 496, cachelines: 8, members: 6 */
	ionic_rx_desc_info:
		/* size: 224, cachelines: 4, members: 2 */
	ionic_admin_desc_info:
		/* size: 8, cachelines: 1, members: 1 */

In a 64 core host the ionic driver will default to 64 queuepairs of
1024 descriptors for Rx, 1024 for Tx, and 80 for Adminq and Notifyq. 

The total memory usage for 64 queues:
    Before:
	  65 * sizeof(ionic_qcq)			   141,440
	+ 64 * 1024 * sizeof(ionic_desc_info)		32,505,856
	+ 64 * 1024 * sizeof(ionic_desc_info)		32,505,856
	+ 64 * 1024 * 2 * sizeof(ionic_qc_info)		    16,384
	+  1 *   80 * sizeof(ionic_desc_info)		    39,690
							----------
							65,201,038

    After:
	  65 * sizeof(ionic_qcq)			   133,120
	+ 64 * 1024 * sizeof(ionic_tx_desc_info)	32,505,856
	+ 64 * 1024 * sizeof(ionic_rx_desc_info)	14,680,064
	+                           (removed)		         0
	+  1 *   80 * sizeof(ionic_admin desc_info)	       640
							----------
							47,319,680

This saves us approximately 18 Mbytes per port in a 64 core machine,
a 28% savings in our memory needs.

In addition, this improves our simple single thread / single queue
iperf case on a 9100 MTU connection from 86.7 to 95 Gbits/sec.


Shannon Nelson (14):
  ionic: remove desc, sg_desc and cmb_desc from desc_info
  ionic: drop q mapping
  ionic: move adminq-notifyq handling to main file
  ionic: remove callback pointer from desc_info
  ionic: remove the cq_info to save more memory
  ionic: use specialized desc info structs
  ionic: fold adminq clean into service routine
  ionic: refactor skb building
  ionic: carry idev in ionic_cq struct
  ionic: rearrange ionic_qcq
  ionic: rearrange ionic_queue for better layout
  ionic: remove unnecessary NULL test
  ionic: better dma-map error handling
  ionic: keep stats struct local to error handling

 drivers/net/ethernet/pensando/ionic/ionic.h   |   2 +
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 105 +----
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  79 ++--
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 165 +++-----
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   8 +-
 .../net/ethernet/pensando/ionic/ionic_main.c  | 115 ++++-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 399 ++++++++----------
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |   2 +-
 8 files changed, 371 insertions(+), 504 deletions(-)

-- 
2.17.1


