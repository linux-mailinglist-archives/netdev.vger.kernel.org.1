Return-Path: <netdev+bounces-30970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8553878A482
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 04:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB7A1C203E0
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 02:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F89643;
	Mon, 28 Aug 2023 02:13:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4577E4
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 02:13:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F668123
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 19:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GniV3wD7ESjv3SUtMteIr/OC4eq1jbprAOoUHk8CzQptL5ZrU9R4QW9FUXMTTc2GK0U3GEw6KJNmZlK6dB9h4HQiAGEJyx0LEX9jcJcDPdCtqA9iw6gV8kEImabX+bRHh9YWV51frZJItEY+VhZ9CRKk7UAXWfOu4Z1E90yhKwNmZCiBSksGNJ94RCBv6EmESs5Rf2naWMQF6V6xTiEFi6mbbblKytFmGgQqOuAshD4htMZ3LF4F6E1Wk0/8RsaN91p4k3mXwXcKScOOpqLQCr28NykGKKG3SadvCULgKi1KPwJSrx/XMtgErV5nVdxlHDNpNQWQAb5xr6hBsx+6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieoVAAJX8jErG8BnFNFmtcDkjEk+kEgxDDZ4j0Ic1iI=;
 b=IxtXLsDweucY9PS52O6/gy4w/2+fQInH2UT1WO5BroRrPhaSkgZq7U4eno60nEbHClI3YGImSsdUrT5Fs3b4aUoPJUngZZ0MsnYQb7VRexMcTwFbZtloKLmioHby/pigksbVdEE/Df9ojKJSyZ6Hsg2g636jKc9b/hTMS7/sTqDuzi3jJHFVEbWESVe+CXudp/4l9bmTjP0081uQ9WRQDrtwnWK82PjMyVlXarlJGD06u47oQNfu/vCMyDRK9+6SePnH7/hF3BDHlLwaSl7bYUTdbOVv9QthrR/zJtnS9nj9NMv92kHwXri75b17YhAtzpC+i/dZXzBtE2028Iidlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieoVAAJX8jErG8BnFNFmtcDkjEk+kEgxDDZ4j0Ic1iI=;
 b=F5eyT/TAtqqyC72BNUXaPJICPkS1wWsOdaQV+X/Gg847S33Zpczu3Ce41H/bW+L09BNsaxOnFM2vlRbwo6iwuvF0JwDcEGxV1tpdA+6HaaIKF7BIU2ga8FGYPo3Lgx5c3LvrT89guZi91EYDkG5wYGzHfjzMTdwQ1TKRKkkn21g=
Received: from SA0PR11CA0177.namprd11.prod.outlook.com (2603:10b6:806:1bb::32)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 02:12:43 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::b3) by SA0PR11CA0177.outlook.office365.com
 (2603:10b6:806:1bb::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 02:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 02:12:42 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 27 Aug
 2023 21:12:41 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<nhorman@tuxdriver.com>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [RFC PATCH net] bonding: add loadbalance case to queue override
Date: Sun, 27 Aug 2023 19:12:23 -0700
Message-ID: <20230828021223.42149-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CH0PR12MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f75e81b-70bb-4a89-1aa9-08dba76c4346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bjtuwMATVTo0nB1wdGDx5FUgPwz8vq5EFqUek5gRIsNF3RQRL2aB3a4B8VO0zAMjFRsvgjhiFD+stfIBEqvksHtGUJidWDjzmOTf85UzUBanaJZxkTsgFiGV59qc5b6OhRxuTkwL+tKFPqUyTkhterOvVcbmuhs4ZcV5YSSq41WEPc0QX92RYSgbpNSjozXdcuIaIEwMXiLDc+c1exko6CKUQeH7if1ErvBMLdKqUrP7nI2zKUMAP6S7SWWm5Z9z5LO1f1wjHHFN11BpU1RVq6r8Q+6zP6Opd/05ZM/OhE03bZ3Cuahktu9hKfXm/B9D3a+AEzCkeyqqFMfmXaQuOCYOeL1cXoKXy3G1foZq7kUk9Pe+L2jWoSpqPm4QHdRjewqjxAgUXmrwrJDYcWfxfuefxwT6HJe8s99ARp6k5+oi0DfezTbDbhoJlgbPMIl+/11QHp+2IDpOhGnJrNLSckB7czuTHDB7LlCstKE0n8HQ01yyjXPBikI/TmnxixC5dIx9un+DmOeF3a3nh05gqQgX5DUkxL/3HHGVj+qYl7sX99uSdPvPmdfrpNEC1ywmkjJo9cTfrizB/O0+YY0uCdS7l4GPQH7yDXmHtXN7KdETP7n/z9WNxZ9ToMwXzP9YvgAqlJgOqzhEmnKo1LBGvdHg5dCKkbVoezPa89RyEDw6tWwHTEp07Uv9wMmJ+fxBfHBQvZNPJdj+CfNrfXDz/ew1TFgIMpnSdb7NAh0fyFsQeikaUnt1izyFrkqwEHeZq0caHuhPuVKGioFgF1gmeQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(186009)(82310400011)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(5660300002)(2906002)(4326008)(44832011)(356005)(81166007)(82740400003)(40480700001)(86362001)(966005)(478600001)(83380400001)(2616005)(16526019)(26005)(36756003)(1076003)(336012)(426003)(6666004)(70586007)(41300700001)(316002)(70206006)(8936002)(8676002)(36860700001)(47076005)(110136005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 02:12:42.9406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f75e81b-70bb-4a89-1aa9-08dba76c4346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

    (RFC - At the risk of possibly kicking over an old dormant bee's nest,
     as well as displaying my own naivety in matters of bonding ...)

Someone asked me why the bond slave override queue selection didn't work
in the load balancer mode.  After digging into it a little, I found that
it was originally added [1] only allowing round-robin and active-backup modes
and has not changed since.

On initial review, it seems a simple matter to simply add the BOND_MODE_XOR
to the bond_should_override_tx_queue() logic, especially since all the
potential slaves should be up and active for the XOR anyway.  Jay's and
Neil's comments about using balance-xor [2],[3] seem to hint this should
work.  Of course, something "simple" likely has something not so simple
hiding in the background.

No, I haven't actually tested this, I wanted to first throw out the
question to those smarter than me before going any further down a possibly
bumpy path.

So, what am I missing?

Thanks,
sln

Links:
 [1]: https://lists.openwall.net/netdev/2010/05/11/6
 [2]: https://lists.openwall.net/netdev/2010/05/11/77
 [3]: https://lists.openwall.net/netdev/2010/05/12/2

Fixes: bb1d912323d5 ("bonding: allow user-controlled output slave selection")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 include/net/bonding.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 30ac427cf0c6..e812a84dbc05 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -296,6 +296,7 @@ static inline struct bonding *bond_get_bond_by_slave(struct slave *slave)
 static inline bool bond_should_override_tx_queue(struct bonding *bond)
 {
 	return BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP ||
+	       BOND_MODE(bond) == BOND_MODE_XOR          ||
 	       BOND_MODE(bond) == BOND_MODE_ROUNDROBIN;
 }
 
-- 
2.17.1


