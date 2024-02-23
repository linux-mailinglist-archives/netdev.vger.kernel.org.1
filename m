Return-Path: <netdev+bounces-74623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B922861FC5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 23:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63B3B23670
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2441914E2C6;
	Fri, 23 Feb 2024 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vll6A42v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F914DFEF
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727284; cv=fail; b=qJGyqajiALAMxTeWRovfij499nLPFxVLhVIP2bM0ms4n09Wcl+kt6x26aA99uFtwxsRENmHHNk89iouxTpiUAmmU9qSTQCHaB+Wl5SvzWbTdhf1OccR78dHhm6Z2FkTBdAzulJCKpQrOFd2J8/bCFIFOQKajKS+5YfzY35nTrY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727284; c=relaxed/simple;
	bh=HRkurGl7oDRE5vfFtooEx7cX/eQ5I1Vphq1Txms/NEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMehcrHqhJfNGhGTThnhYktCuFjgrOFTbqElq9UvixeD0j2+A46yZtmuDDREGZ19KB8+jO0T2dlqw2CVdFFZWSFUj1lDHIs39xAyLoSXMEh4vJpcq6hHO4bvv+ubHB8z//eHMJqT+aPDBkAIJKrgRnaVgL6fqLLr6gaFNS+y4Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vll6A42v; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eth9R5VNaVdGlLK0+/XF7nIOhtlaYhmDiIEqHawyiqv/HjX8ovfu91XXWLvHYoh86QoqLNdXNTLC6INmSSUkcg3P30Th2CoWMVtDZo2p3RJOnRYattyjaHRkNejhnZPLyofMYCCNdqiHUJMkEvaxCQ4ehlts8KEF01qBCt61uXqVMshIIczki8WhWyYSKF1c/xcmDqhz8B1mZ07phB0BSYOpGc4VoGe6VIXU6pS0SIQrEo4pdOzzVKiI2OnZxq8riw/3QHX4qi81z6Ojn42DWWo4dRPL+hkk235Y1bOOxsLdDIch66pQy0M3kI6fH4OAzTBqyHBvA3OyLJPi4HyXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1C/+WeYEoxdqpLQHnwoCwvAdfW+XPY9SDI+Qkj/N/8=;
 b=KlWC4AUMU9uEeysHeXaPVKB2zKMY4qUukWT5rgbfrC+LzYRw+jb0DwPZfsa2XkRIDRUWr21ELyPig3Dgp73FqGVbllEi7ijryzN3UnoCQkUAQMqVzoMo/hXyhzuA7S/IPnEhj7pANuHX3j0Xm6jNffztXa/N/8AHHlieRaEkI3LLPqe4Y6Lnfo85ILnaOWm/H7rmTAsOeHL6Kheu2OVoD3jPapW2+LLnGkyVYcqWgw/RIUcXKspByHkMe1f9fiSqBOkXsZ30PFqDup/OwCH7e+7Xqy4A2iUqXQizy5v7G7w8FRJB0iFXIZbDjgYQG8otM4vThELr1Cch/H7tiLdUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1C/+WeYEoxdqpLQHnwoCwvAdfW+XPY9SDI+Qkj/N/8=;
 b=vll6A42veZBx8UGPqJOa1YVfB5NqR8+XgnPprvY9wObi6OnUTWUbHj6Pok3n1mgf4lKbjJlreBQNet5/iBNt14krh9wI1tIctBH75DJ8zxo0yziVHpy/hpbsL3lT7RQOTCHhcH0ffFlMW5VIUid4vVhB6JUwU3xthyg8XfxhKnM=
Received: from SA9PR03CA0025.namprd03.prod.outlook.com (2603:10b6:806:20::30)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Fri, 23 Feb
 2024 22:28:00 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::7c) by SA9PR03CA0025.outlook.office365.com
 (2603:10b6:806:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Fri, 23 Feb 2024 22:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 22:28:00 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 16:27:59 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 3/3] ionic: restore netdev feature bits after reset
Date: Fri, 23 Feb 2024 14:27:42 -0800
Message-ID: <20240223222742.13923-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240223222742.13923-1-shannon.nelson@amd.com>
References: <20240223222742.13923-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf5c19b-2262-4789-5590-08dc34beb164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+P9E4bNUNw9Bbj6mdGjnDwE1izAJ0tbs4HOWjVbxvQvPQSvpcOLE18AOUXii/slFxt6BO3OYbZUQRRJNzcwwVGRlw7rJzO9QZB/TFNaYLA3uXXnHUnyY4bjTrOXsVnk7XlE5D4SLPQtYMZkgGr1mQsZBjDe9MRXExwT9/tDSjPanmN/LgxqYsTdxkdGuUdzeY34RYhlOfq/4angbWF7B5IZgPXf4Xfr8MiOCDpnSnzUEj8vdysDVpG3qv7kNYr41pqkttApe4u+Oi7AirDZVAFAsuWaa/XUQspSVymYTrop8XRDJ9pbJAW7Nsdf8+CWYnCXLeQdiQGrJIP2sh+2roBT9xzf6T7xgeSBfEAhddRLjXI50adUfrLvdatG9g4CXr64nhpuAr4thIpwBwdWukKFZnbXPwWMz7ljxTOt4nWbDW6gzgxrOw7iyxUOklL1vD+kkN+dg7juk+/vjkb8DmWnVj3sqdH10Awz7gD+8KVX5hP/lWAgXFZzNO1nII2iW0yZPozKPQn1l5DwTN+ai24Jel+nUNPuWA6vU/kD6jzHZ0XTkKi8xP9mFhIp6a36pINbf3TongUGGnIe7egLaC3Zxj5VExPUiz4IkE1XU75XlN7JoBh3LFKWj1bQuZAKze4/XQaYKQ93LDpZ3ePMt/Vm619tX4pdHau2jrE0bD/0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:28:00.3716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf5c19b-2262-4789-5590-08dc34beb164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193

When rebuilding the lif after an FLR, be sure to restore the
current netdev features, not do the usual first time feature
init.  This prevents losing user changes to things like TSO
or vlan tagging states.

Fixes: 45b84188a0a4 ("ionic: keep filters across FLR")
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index cf2d5ad7b68c..fcb44ceeb6aa 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3559,7 +3559,10 @@ int ionic_lif_init(struct ionic_lif *lif)
 			goto err_out_notifyq_deinit;
 	}
 
-	err = ionic_init_nic_features(lif);
+	if (test_bit(IONIC_LIF_F_FW_RESET, lif->state))
+		err = ionic_set_nic_features(lif, lif->netdev->features);
+	else
+		err = ionic_init_nic_features(lif);
 	if (err)
 		goto err_out_notifyq_deinit;
 
-- 
2.17.1


