Return-Path: <netdev+bounces-41317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867617CA90B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2FF1C20B7E
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AD727ED6;
	Mon, 16 Oct 2023 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Giqp2HTM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6727739
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:14:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B969AB4
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgauorbv0A3gR6xK7aGKFPbOuAvv4syzoFmq3T/T7EUFezVeQEzySTg+P6AhzP8vqJis50TytNcKemEdhETieFxFyl5tYL35oNUE30JsFnETExYB4iHbA00WZzoUmYkqCloogpSu9kdnXNA8XeUnPaoY0Lg+BPRpz8uLGeoJZVB1GtC643O4m/wXxNrZrdfwNY2idOPM7zwNSnXbdo9HdVlzzNtBR7dznTxRsGp+GUBsn50Dd9nCk6HyofS27KRj8+TA6hCUOWT2k2gq3wGdfVb5zqgXlC3EG2T59XpOSVOk/7DEfdnR78VgeLYcN1N9BJGVSF9SDJZlFoWmL/dbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bscAPYujcdnifDVSY+NWRcPRixs9E7L/psZwgzJNN98=;
 b=VVfPcASvzmm9SkUbulIUrxcOI4CAOJKHTmU0zHNbFLUFPnIH6hWJjN72lGaLLBJ1yVrQ9duTTDtkWmYiSIyVoHZD8DOYxyjq2VTnX3fY9IT9/aabxCpkt7YMVuD4rE1rT60gM58ruhzh12ywmZmsOWAXH1Xzza0a8EDkRnJwgT4wztPERLz13qnmTqTuiHGkgRSlkKcyFhJpD8PfQrVh8Lp3FU8Tu6ke4EURxgQFPPZSoa/WGocB9lrzzMJmRH4F378AXLWvPRKLaKFRCAL7KCM+GdmKrveAWB2FWkQeLvAtob/4Igf5PTp5iDFYNoOWxgX741nxc9HAfReO55SFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bscAPYujcdnifDVSY+NWRcPRixs9E7L/psZwgzJNN98=;
 b=Giqp2HTM/9Zb/JVGP6X0vbVxd707N9vCeShzfes6PD5mCz4IwcUufnp7Kl1SKEeRemwAb6rzDHJmqVNT/lQ7LMZTt6/EWM+70RLtlOmDlpmgolnBJ+krvQTdmdHfiv/uELoPfE+pzztLEtssZU+Yo9qVymtJvoYpOkA95p9jedGiscxnpAk0C1mVD8oH91cpZt74R/1+EiLwjLx+LhFeQTpVJgqhhTm5ZM12Afo1KISWJx/PmsmybLz8zGAC/WfJzx6yeD7tPqjOUxBpSrARxjjNUy40tKSBDn3GEOrPsbAGhL9VmJb+8VCvYM3UFL8ndCdwBCicdBo2V087M7iK0Q==
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 13:13:55 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::f0) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Mon, 16 Oct 2023 13:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 13:13:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 06:13:37 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 06:13:34 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 01/13] bridge: mcast: Dump MDB entries even when snooping is disabled
Date: Mon, 16 Oct 2023 16:12:47 +0300
Message-ID: <20231016131259.3302298-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016131259.3302298-1-idosch@nvidia.com>
References: <20231016131259.3302298-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c37cea-0935-499d-e0e7-08dbce49c039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nUQXpYFYroRLzf6FVfC2fkTw3DbU/l616clcImT92qvfacr7RIDB7uhN7KFXJISBgLZg9xZtnKM/faIeRdhsX0+96UbVBiDOS9HZN0KyaXHD9eFJDQV5VRAYwSwfP52sITYmec/9vniL/ezzPxVaOt2NZD9T5RUFNecJQw5KxGBciSAKXQNKgo0/hmHq9EGb/7PxekR8hPrVkL+YKfuYykT2piDDsFzWQjgh+YCz5HRtihQJ0/8/L9Nrybs79qeus8VwuOjUnRNPojcUxECey7vsQebpzqcS8fyyXOKya9dSnezZLntymhxXA8pevEgOBTZCBjQOOW/nj33xYaPqb+p4xKLuSn3XXfrZLi485jg68vGcrNsnzrOdbcWOTvyuG99gxrPkTR53d7TK8G+eE/X9KFcBE2XtHvoDGc+tO87iWc5Al+oxCO57gvjwZFLGMJgsz/fcKPlvLg+vtXJlqP8Y4r22sUD/Eb1rQJCF8NqS/QXw0pGtd2Z2MDC3SvxAIILD+2xiRggpdJdwW+kcYoD/0M9v9gWrTpqjhpD19Aqz/H5uCkCARmftedF5lE8FeHt5knIjriNXj4p8ab322jE1ukbS4cJWOdIUmdwM+UXzlsdptiJbGXTO+iWPj6HMrX+KSGPWNuYCPsC7d/PqEThX+YURQXsPWq1dAAzYanGU6zvqCeoTgSLouGXPE9291PePgVlKnwJHSrYqjrH3O5INT79PGCgQbbpUE37fBaJoaTI6BaEGhHDyHrVxWnTu
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(478600001)(316002)(110136005)(41300700001)(8936002)(4326008)(8676002)(70206006)(70586007)(54906003)(5660300002)(40480700001)(36860700001)(7636003)(86362001)(356005)(47076005)(2616005)(107886003)(26005)(36756003)(336012)(426003)(16526019)(83380400001)(82740400003)(40460700003)(6666004)(1076003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:13:55.4603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c37cea-0935-499d-e0e7-08dbce49c039
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, the bridge driver does not dump MDB entries when multicast
snooping is disabled although the entries are present in the kernel:

 # bridge mdb add dev br0 port swp1 grp 239.1.1.1 permanent
 # bridge mdb show dev br0
 dev br0 port swp1 grp 239.1.1.1 permanent
 dev br0 port br0 grp ff02::6a temp
 dev br0 port br0 grp ff02::1:ff9d:e61b temp
 # ip link set dev br0 type bridge mcast_snooping 0
 # bridge mdb show dev br0
 # ip link set dev br0 type bridge mcast_snooping 1
 # bridge mdb show dev br0
 dev br0 port swp1 grp 239.1.1.1 permanent
 dev br0 port br0 grp ff02::6a temp
 dev br0 port br0 grp ff02::1:ff9d:e61b temp

This behavior differs from other netlink dump interfaces that dump
entries regardless if they are used or not. For example, VLANs are
dumped even when VLAN filtering is disabled:

 # ip link set dev br0 type bridge vlan_filtering 0
 # bridge vlan show dev swp1
 port              vlan-id
 swp1              1 PVID Egress Untagged

Remove the check and always dump MDB entries:

 # bridge mdb add dev br0 port swp1 grp 239.1.1.1 permanent
 # bridge mdb show dev br0
 dev br0 port swp1 grp 239.1.1.1 permanent
 dev br0 port br0 grp ff02::6a temp
 dev br0 port br0 grp ff02::1:ffeb:1a4d temp
 # ip link set dev br0 type bridge mcast_snooping 0
 # bridge mdb show dev br0
 dev br0 port swp1 grp 239.1.1.1 permanent
 dev br0 port br0 grp ff02::6a temp
 dev br0 port br0 grp ff02::1:ffeb:1a4d temp
 # ip link set dev br0 type bridge mcast_snooping 1
 # bridge mdb show dev br0
 dev br0 port swp1 grp 239.1.1.1 permanent
 dev br0 port br0 grp ff02::6a temp
 dev br0 port br0 grp ff02::1:ffeb:1a4d temp

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 7305f5f8215c..fb58bb1b60e8 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -323,9 +323,6 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 	struct net_bridge_mdb_entry *mp;
 	struct nlattr *nest, *nest2;
 
-	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
-		return 0;
-
 	nest = nla_nest_start_noflag(skb, MDBA_MDB);
 	if (nest == NULL)
 		return -EMSGSIZE;
-- 
2.40.1


