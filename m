Return-Path: <netdev+bounces-58329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C713815E31
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422611C21A1E
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D043C30;
	Sun, 17 Dec 2023 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O9G72Q0J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D66259C
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kcaba+1YU3PDy2qJDq2zwmzMEuHQdFB7Bz/45k2DevI0xHsCHB5p1NsveYyV8XJx09ocORJr78YBoR+8RaUAYsziV5T4SiYiNSFaBoT5SiHURlPQYj/4Yw9khYf+1+KDgZIEBqOb7i2pXcwYuKewFilr0MjKLlfVheJoSRUSyWbYCByLsVUZhMQKAwUxqUjikfeUXhH3IQXe/7h6iceIcMIZYvjgEXS28fqmqHU3Zi/SKIpQFCoArvDkKklYniMSrIadIwRCCRWvCYW9rkVoSrJ78HcsceI1H+I3cZstinNFb6YuLnAMPPpRuCk64Blnu7nOlZdxEegKKfNbrWrEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKS8WuPLQP5YGdEuFcO2Pc47tfS/fTfJpcnkT/s3r2w=;
 b=XDFuF1nE9VEu7L3WIXxpwxOQxnrmpAo64cuJqBv9naU/xCXx/G4uaOXkGLt98sjLL+PM5toPpIidEKMYfO7VNMp12Xk8tyTo0hXc6lxyQMdCKdDkuKNIlYfCw3dl+sVZppGnvY60DTWha7ucIcC3V/O4xkcYGmrkjKAcODQTQXmfrhb6uEcjmotIWS9ay5h/fwUOBXRUrjaQ8Pb57Q1nWx8Wk2992/TXElmEBMDxoVChwt406+MmfXwMo5uk9U3MxxRqZQMx46I6N6/ZmMYq8054gf352E6N6Let57l76Qf2wxeNo4LuFBNMx+wyHp+lwTPRjhdHwvoI2pyM0obP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKS8WuPLQP5YGdEuFcO2Pc47tfS/fTfJpcnkT/s3r2w=;
 b=O9G72Q0JYU1U2v9G6eo9knychpOjxSxKKEoeITYxEKz0Hj2M718SkvX5ZGlLVTlCD02iYwt13sajTIX9dKUb9jnl3sfkVc519NVoSXhtG3JlqqpfIExC9ACiiuA5VCS0GYfn8ehpEVLdm4bmAtfvjpTr+uOwpCl7CszHPPggz/RY8ishoP4WT1yqNCXa6lYyBYh+P9rBvIpdbHOeS3ARl4uCPXPVDgw1Tfi0QNR93QZYRtVPpU4Xs8oPFqCLsrI65Os6nx7nzkkiBJQXD6CgRu2JMztT5H96x7ogMzJhPTUoyil4apr2h9uNA46tsbPLDG0XoXm5XsnzW9p6+1V8Og==
Received: from MN2PR17CA0031.namprd17.prod.outlook.com (2603:10b6:208:15e::44)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 08:33:37 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::a0) by MN2PR17CA0031.outlook.office365.com
 (2603:10b6:208:15e::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32 via Frontend
 Transport; Sun, 17 Dec 2023 08:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 08:33:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Dec
 2023 00:33:24 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 17 Dec 2023 00:33:21 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/9] rtnetlink: bridge: Use a different policy for MDB bulk delete
Date: Sun, 17 Dec 2023 10:32:37 +0200
Message-ID: <20231217083244.4076193-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217083244.4076193-1-idosch@nvidia.com>
References: <20231217083244.4076193-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e96114-e3af-4514-9eb3-08dbfedadd56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wWaAKLPL+yktHHrF67mGkNpiW/CekSw0/RKRx2rchRYGkQuxB68TRLM3oNo2sXBAb5FLp4pT4iNTnsaVjpNhZYKapLk7isL+3grxg4cjbFe/1zPhAMTnv5qJBvD86p6nSm/DIsHV6elNlTo9rQ7zHRGztd/xQlIowZ+scFG+mWwGP7Rjkk0dHJRmlheY3WiA8zslB/x0KMRk+inOzpXXidDzgv7/gbxbnSzAorHjlWE4qUDy7RD2yN4E72XaohcT9pIXBypVfa+YHYR/3qGiFjrAHD6lLNI6RnpW9gNxzc5XWzWIXis+zHZ9B5+yH2z57CwUAsjTtIXUGLi1/FnkPhqdSDC4UV+LwSsV2YG6uE0jPEyeaqewDFerpVVSm+dwck2txL7+fiA7BcClEcmllVB0nzbTL8eYwIFjf0/6V8BmbFoG5WNID71UDo7FGKvgyGCr6sTYUZowBK11i+3dFXVXSuK2ldc6RVECpUFtTgfNq/eCxhxFMo+Sk20A8CgCj++EFKcGskCBPuY/4K0BRKmDp+9R40N0tLsy6bIW/jNA2m2OA8uwEIs5DWVumgqddoUEfuqjdyknw8tJbFYzcW1rFAud75Zt9+2IeKqxwpF1lOEcEQjYgYQ/mZcBpZZDpOf3A7Qu2arw46OjZLtduylHkgokc5PJj3OEzrsiUqTONEgO3oTEhI6vz3DVEGGrFz5c2upYidXq2V03gM8W0pt2BTeJzIxzGtgmnZQIiwOfiQf7pCpawOkL8upVlzoh
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(107886003)(2616005)(70206006)(110136005)(478600001)(54906003)(316002)(1076003)(26005)(40480700001)(70586007)(336012)(426003)(16526019)(4326008)(47076005)(8936002)(8676002)(40460700003)(6666004)(36860700001)(5660300002)(2906002)(86362001)(7636003)(356005)(82740400003)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 08:33:37.0949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e96114-e3af-4514-9eb3-08dbfedadd56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427

For MDB bulk delete we will need to validate 'MDBA_SET_ENTRY'
differently compared to regular delete. Specifically, allow the ifindex
to be zero (in case not filtering on bridge port) and force the address
to be zero as bulk delete based on address is not supported.

Do that by introducing a new policy and choosing the correct policy
based on the presence of the 'NLM_F_BULK' flag in the netlink message
header. Use nlmsg_parse() for strict validation.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/core/rtnetlink.c | 51 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 5e0ab4c08f72..30f030a672f2 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6416,17 +6416,64 @@ static int rtnl_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return dev->netdev_ops->ndo_mdb_add(dev, tb, nlh->nlmsg_flags, extack);
 }
 
+static int rtnl_validate_mdb_entry_del_bulk(const struct nlattr *attr,
+					    struct netlink_ext_ack *extack)
+{
+	struct br_mdb_entry *entry = nla_data(attr);
+	struct br_mdb_entry zero_entry = {};
+
+	if (nla_len(attr) != sizeof(struct br_mdb_entry)) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "Invalid attribute length");
+		return -EINVAL;
+	}
+
+	if (entry->state != MDB_PERMANENT && entry->state != MDB_TEMPORARY) {
+		NL_SET_ERR_MSG(extack, "Unknown entry state");
+		return -EINVAL;
+	}
+
+	if (entry->flags) {
+		NL_SET_ERR_MSG(extack, "Entry flags cannot be set");
+		return -EINVAL;
+	}
+
+	if (entry->vid >= VLAN_N_VID - 1) {
+		NL_SET_ERR_MSG(extack, "Invalid entry VLAN id");
+		return -EINVAL;
+	}
+
+	if (memcmp(&entry->addr, &zero_entry.addr, sizeof(entry->addr))) {
+		NL_SET_ERR_MSG(extack, "Entry address cannot be set");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct nla_policy mdba_del_bulk_policy[MDBA_SET_ENTRY_MAX + 1] = {
+	[MDBA_SET_ENTRY] = NLA_POLICY_VALIDATE_FN(NLA_BINARY,
+						  rtnl_validate_mdb_entry_del_bulk,
+						  sizeof(struct br_mdb_entry)),
+	[MDBA_SET_ENTRY_ATTRS] = { .type = NLA_NESTED },
+};
+
 static int rtnl_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
+	bool del_bulk = !!(nlh->nlmsg_flags & NLM_F_BULK);
 	struct nlattr *tb[MDBA_SET_ENTRY_MAX + 1];
 	struct net *net = sock_net(skb->sk);
 	struct br_port_msg *bpm;
 	struct net_device *dev;
 	int err;
 
-	err = nlmsg_parse_deprecated(nlh, sizeof(*bpm), tb,
-				     MDBA_SET_ENTRY_MAX, mdba_policy, extack);
+	if (!del_bulk)
+		err = nlmsg_parse_deprecated(nlh, sizeof(*bpm), tb,
+					     MDBA_SET_ENTRY_MAX, mdba_policy,
+					     extack);
+	else
+		err = nlmsg_parse(nlh, sizeof(*bpm), tb, MDBA_SET_ENTRY_MAX,
+				  mdba_del_bulk_policy, extack);
 	if (err)
 		return err;
 
-- 
2.40.1


