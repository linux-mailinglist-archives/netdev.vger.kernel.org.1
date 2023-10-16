Return-Path: <netdev+bounces-41323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FCD7CA91A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FF71C20BFC
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1807A28682;
	Mon, 16 Oct 2023 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lvk3zSEX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830A27734
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:14:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B577124
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/uTs04pn4jxLnN4pWPCEalogZ+8nd4bUCDAy+8O5mTmn8BoBlyjxojmausooE/Id428lhH7fH6hDQSGKC53QFEIBDD+LRIMbo17A94FiH5mj3kpfTu7gngBTA/zxMVo3QwnGlarvxNWVUE9FTNfo+XUTteecppp58pZKp6cbnJb8eZ7WqPsfQx9eaMaiT+5VQSkadZatoYPc+3du24O+EC+heVJKwbVLYX39iPMgY8H93FYy5JtX9O45Smlsr8z4YLODOcd+hwze9S3UvM/oTd9gjPKe4TvYOYZkBVQ22kF2dOZ957k3lUqS0Am+ZQz7el0ordVFNwrCM92Q9JloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHN1TKhsg+zpUSQzmah2NESJCnPaiPmR+MA78MJlse4=;
 b=Vot92DQ3Idwz5ULIvovxy+CjrOOPv7AeuqTVhUHhOykGQD25+Ut1IudWh8DrM7X/Z6hh+mNj5EpAQJaX+hWc+B7a5ehnPXpBRDeoO0p7+y57FaySjbQMYwnX4FDEem4IcNXTBGVg4gs8Ex91Oq9k8tRm7pNm3qXschKcdXR22dgkRg9T9WYdg6yLiLpRs81QIwG3uOuUGpoGsUYuI3DiXBJF/fUafV8JqQI3YRiIvwhOA2Qw443td2u3ihf7ihz1fYfGNy2MiUJTGtSiVNqqddXNIIMdNmshnWjlVi0ceah47WoEr7tuB6DDcZGd/Yg1MmJVDdvbM+tykx1Otu8BUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHN1TKhsg+zpUSQzmah2NESJCnPaiPmR+MA78MJlse4=;
 b=lvk3zSEXJDCFx2aqoXPQKyqJTNseAsTlSnIsmos1A6ny6d2+DYdfEbESfgbSLNbRgLzqVnyqudUmi3hf3Qtc5saNAQEHDQh97CNGTwK0sMo3bVk9ch7094G+1bGqE4jNvCacFwYBTg+mTNIUkNJA5P/SpeqicHMfJQjQfaPMXO0YfRZZS8iabCZZbCNQ56lvpKdoZtSr+SJzOh/LKzOdBAkr3AQqyxsPpKRUInTV0r8+MByx6kOY8FgpzYZVoUFwLNx9Lm0kn2Y4AKwikQ/5yy6HvzIdNn4Mrg13kMYT09I3uQWyPN0XOc4bS95ImIsJZvNI9K0S/nDdlFRqpAWM7w==
Received: from MN2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:c0::25)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 13:14:13 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::ec) by MN2PR05CA0012.outlook.office365.com
 (2603:10b6:208:c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Mon, 16 Oct 2023 13:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 13:14:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 06:13:59 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 06:13:56 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 08/13] net: Add MDB get device operation
Date: Mon, 16 Oct 2023 16:12:54 +0300
Message-ID: <20231016131259.3302298-9-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db9c7c0-c23a-41b3-0734-08dbce49cabf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	weLEEj1dxyhYeRCo0vGQEVug/GrXmKgwcm+Xwa4NiYMXqD4mI4vvhva2MY5gnT6/XAPpobmYRpzmjytyjykXsj/x21sMk4TfUTiFf+Cxc46hf4yAwqrbmNUqrUtLfbJxK/m3peQwA1BMEC03i8U8rOlKFMtbZghSWw0O5m10eMBKY8Ix6mAuPAYSmhTgeS+oOCHv0K6/9KMZ6BzrH2pTYOeUFJribB5Y4F4eL6JISeBhmJvEy4gHQ3nQjI97+5I6JLuqMKfRC2ZrrsoBhuk8NRm7H3Ya2xSk8wV3+rBt+1QGWpmVMxhx1xT/Hc4IvdNR5edCgsWP+6CH1EcTVkq1pjXOAXTSFkN+xIyP4FxhIebZFhQE878Jc2p4OYYCunauoguJBlhNlVYPP39l7WF1LI++jCd6Va1+4zvsiD1v/F9Pja1/FsNw4ZTc7T7J4x7jlZIAlgE6H6OmfSa9eOJM7hkpQ1/Tl6n4U6I0zbJTew9kvbt2KoiLOCYs1knuBdIkM7uWXtbEL4HsARc0G+16V9xHo5QlRJn148f3V+MW0tgbP2bO7Y8/Sm3/eYVJW+m0MRzLXlscVQPOyoJaXwyOdaixHj66gtHyIHQ+ts8jhPkLGcINc1YS+lIpQdnnf7S8ArgKR5wcSIeb3QnfOzWNHHdxenpMSgxCMiWrqVCCnX8Tw0Rkj1vFGNKQPZAQu5KqoZ8Ze+HxhTg3LETYYnMFf6viXCXOWL3tkM9/nr9WZ6fvt/tNLlaclh4dT+tzipnW
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(110136005)(70586007)(316002)(70206006)(54906003)(16526019)(1076003)(26005)(336012)(36756003)(107886003)(426003)(83380400001)(7636003)(2616005)(356005)(47076005)(82740400003)(86362001)(36860700001)(40480700001)(478600001)(41300700001)(5660300002)(2906002)(4744005)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:14:13.0477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db9c7c0-c23a-41b3-0734-08dbce49cabf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add MDB net device operation that will be invoked by rtnetlink code in
response to received RTM_GETMDB messages. Subsequent patches will
implement the operation in the bridge and VXLAN drivers.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/linux/netdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1c7681263d30..18376b65dc61 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1586,6 +1586,10 @@ struct net_device_ops {
 	int			(*ndo_mdb_dump)(struct net_device *dev,
 						struct sk_buff *skb,
 						struct netlink_callback *cb);
+	int			(*ndo_mdb_get)(struct net_device *dev,
+					       struct nlattr *tb[], u32 portid,
+					       u32 seq,
+					       struct netlink_ext_ack *extack);
 	int			(*ndo_bridge_setlink)(struct net_device *dev,
 						      struct nlmsghdr *nlh,
 						      u16 flags,
-- 
2.40.1


