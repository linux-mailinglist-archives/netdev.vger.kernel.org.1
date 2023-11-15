Return-Path: <netdev+bounces-47973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D257EC214
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C33DB20BFA
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B787182AC;
	Wed, 15 Nov 2023 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D9BwWnGs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8F18B00
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:19:51 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C2D125
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:19:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaKlH8STIPrFMKNkEXhQmydHcxQToAzVtY9ZsAw9by3hznRQRbzSBIHMUKPequY3Ohou8Zs1AFDUNbTj5mrMEP7/lVI4g0Rb0QzW0q8JinhhXJApKGKJR1gK790a+VNZ+SbMu5E3VVeNIxGanf1r78MQPB5qb+vKF29RCO3vCqvbuW5y3uZbbkN5BIuLATATyUSUhWB4MeLqGHQbBGUawWBXmt365Y5ell4Obr4/Afk4vrrF1E4yb7+6DJRWPFJAST3rllJxyv/U0AAwz5Br3D/E4BDvtNBmPXmAcAsng5ZC8Jd7LJipeH/PNt/t2tzyECAu8hl4imZxFc++FXZRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhSuN+M53usTgHVk6YYQEopFe6xJNBdjo9JER4hpFHY=;
 b=CrbVUlxnYXsEFd9wanaAUkdmlzT/elnzd1HLb8hxV88I5CpZFMZ5craTdsSnkp0HIRWVdui5Yhvt/yEk71VrWkVicCgsTgJ8TjonqKqwu5cNDkd/CUn+6PYkKEScn5Dv7Utp+NfrBGP0PIpjITLlJIKwZwLASpS81NoRQDch0bo4WU+Zc7BpEgTXRW0XP68DcQsncxqcrfPYoKYtn3Y3FGr5lGmf2SdFWecb5Hx6qcJzRmaIoDNO9oJU4w26qXsLL3fwzHBko6goiDe2aD9mt+crF7KIrT6DoJuRnG5VNO7bwzRNXm+U0ExGSmGE8Dvne/Nt/gWsqrT8citPzGCMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhSuN+M53usTgHVk6YYQEopFe6xJNBdjo9JER4hpFHY=;
 b=D9BwWnGs2jhGxE0ECj26bwI4DXljsfItTKMedbO6pscWNB9/+n80A2iNKKoMuQKwUjYR1Jc94GDnK9ppyR7GKngksEDFCXLh6lnJcaDgUZ5dwcpkxAQ32ciHPhV+kpmvpt3le/iROx7QsXBJg3dTiHViNzGSv2pqf7Q8VGqeGwkxwm9GYg0dKxw5K+HddTi/tq7tgMHt/+xMY5C4siluJpuDr7MC8WN8BtwuHumnJaBxgsOeunYZDeIhjMKTpVncHMn/MR/53KPgb9d0480r0AYKukXbLr4eEYHGfLPadrauvbi9DDWAe+vx0vtG5r58O2K6ZqZOL34TbvP9qyH+HA==
Received: from DM6PR02CA0080.namprd02.prod.outlook.com (2603:10b6:5:1f4::21)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 12:19:47 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::be) by DM6PR02CA0080.outlook.office365.com
 (2603:10b6:5:1f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 12:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:19:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:36 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:33 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 04/14] devlink: Allow taking device lock in pre_doit operations
Date: Wed, 15 Nov 2023 13:17:13 +0100
Message-ID: <ecb76739d85bb0cb2977520c17c9af31a6228abe.1700047319.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700047319.git.petrm@nvidia.com>
References: <cover.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d9c311-fae5-4b4f-202e-08dbe5d5283a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FnmdaEl5yQDwOJvxO3D2AqoToAffPS1HssEkQrwPVeQEP8tYeyLRxKkP8MSe+mS5zSLcZOZMY27rDB2VlCCnnOSRP945i4qn7TyHXmYHWdVqhaUgTIt2/CSVzanAZuath6//pKbNtOUgsDyZ1Xt6BYYN48eJCYRETjZE0dq/6cNAcklPZB8olHnuIvSNlXMNalWbl6syMc2EdW68dtEX0oKomT184PYSS31C2iIuTNO6NO1O7kknJrImYNkoNx0czgHGhlkMHlSJy2jpGHhEKLKATXvhv7Y/rvVguNcgbQNc4JwF1bs5o/avfYPOFrmZ2ZmaeFkkRjhgQ9Nfyi7XuXghd+wcFW3wrX3x+5jhizpfFC/PFy+Pbl4ZZRlNcNYqLdsgmhXuvAoCnxD0Uz2beSHHa+SapQgu507JUfA6ZnX0BYiMqvd7CkrBTN46TmnPISxpO3Bko2B9Juq43IhYQbGJTKBVeDRNJ47ESys6Z6nyVjw3CSxU4fqZ2yQlCe4VDR5/v41Nh5SCOo5N9ScwP0GmL8iExtpuOqK8JGGqnmKqpLieAylzbbfjXloTOD73dcmvzfxHvymyQhH5t+AFSrKIYQCKfj52vthWt6I2SmrqXE8YnRlMb6Dut+gSFG3tTjoGoD8XjXn+Mu4rMMCddE1Lf5vGc528d1lCo3DGMR5eVAfbyapgYkWklf3JeoRMHdXAIro8HnKR6bpUJZaX/bZZqBWJ7no9DlLZpXyCgtJTi9WL4hphn/QvegkF13nk
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(6666004)(478600001)(47076005)(7636003)(82740400003)(36860700001)(356005)(40480700001)(83380400001)(426003)(336012)(40460700003)(107886003)(2616005)(16526019)(26005)(41300700001)(8676002)(36756003)(8936002)(4326008)(86362001)(5660300002)(316002)(2906002)(54906003)(70206006)(70586007)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:19:46.7812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d9c311-fae5-4b4f-202e-08dbe5d5283a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332

From: Ido Schimmel <idosch@nvidia.com>

Introduce a new private flag ('DEVLINK_NL_FLAG_NEED_DEV_LOCK') to allow
netlink commands to specify that they need to acquire the device lock in
their pre_doit operation and release it in their post_doit operation.

The reload command will use this flag in the subsequent patch.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/devlink/devl_internal.h |  3 ++-
 net/devlink/health.c        |  3 ++-
 net/devlink/netlink.c       | 19 ++++++++++++-------
 net/devlink/region.c        |  3 ++-
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 178abaf74a10..5ea2e2012e93 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -152,7 +152,8 @@ typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 				       int flags);
 
 struct devlink *
-devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
+devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
+			    bool dev_lock);
 
 int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		      devlink_nl_dump_one_func_t *dump_one);
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 695df61f8ac2..71ae121dc739 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -1151,7 +1151,8 @@ devlink_health_reporter_get_from_cb_lock(struct netlink_callback *cb)
 	struct nlattr **attrs = info->attrs;
 	struct devlink *devlink;
 
-	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
+	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs,
+					      false);
 	if (IS_ERR(devlink))
 		return NULL;
 
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 5bb6624f3288..86f12531bf99 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -11,6 +11,7 @@
 
 #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
+#define DEVLINK_NL_FLAG_NEED_DEV_LOCK		BIT(2)
 
 static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
@@ -64,7 +65,8 @@ int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info)
 }
 
 struct devlink *
-devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
+devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
+			    bool dev_lock)
 {
 	struct devlink *devlink;
 	unsigned long index;
@@ -78,12 +80,12 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		devl_lock(devlink);
+		devl_dev_lock(devlink, dev_lock);
 		if (devl_is_registered(devlink) &&
 		    strcmp(devlink->dev->bus->name, busname) == 0 &&
 		    strcmp(dev_name(devlink->dev), devname) == 0)
 			return devlink;
-		devl_unlock(devlink);
+		devl_dev_unlock(devlink, dev_lock);
 		devlink_put(devlink);
 	}
 
@@ -93,11 +95,13 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 				 u8 flags)
 {
+	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
 	struct devlink_port *devlink_port;
 	struct devlink *devlink;
 	int err;
 
-	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs);
+	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs,
+					      dev_lock);
 	if (IS_ERR(devlink))
 		return PTR_ERR(devlink);
 
@@ -117,7 +121,7 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 	return 0;
 
 unlock:
-	devl_unlock(devlink);
+	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
 	return err;
 }
@@ -144,10 +148,11 @@ int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 				   u8 flags)
 {
+	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
 	struct devlink *devlink;
 
 	devlink = info->user_ptr[0];
-	devl_unlock(devlink);
+	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
 }
 
@@ -165,7 +170,7 @@ static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
 	struct devlink *devlink;
 	int err;
 
-	devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), attrs);
+	devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), attrs, false);
 	if (IS_ERR(devlink))
 		return PTR_ERR(devlink);
 	err = dump_one(msg, devlink, cb, flags | NLM_F_DUMP_FILTERED);
diff --git a/net/devlink/region.c b/net/devlink/region.c
index 0aab7b82d678..e3bab458db94 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -883,7 +883,8 @@ int devlink_nl_region_read_dumpit(struct sk_buff *skb,
 
 	start_offset = state->start_offset;
 
-	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
+	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs,
+					      false);
 	if (IS_ERR(devlink))
 		return PTR_ERR(devlink);
 
-- 
2.41.0


