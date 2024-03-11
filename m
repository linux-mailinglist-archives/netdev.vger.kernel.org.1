Return-Path: <netdev+bounces-79075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C23877BFF
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC3A1F2111D
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 08:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A969212B8D;
	Mon, 11 Mar 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cKH030Wx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B912B81
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147477; cv=fail; b=bVpXYSrpUfXXsHFZF3Rpikv8tyBe+7ZYfIThjqZU9IicravCSvGvMrTK6fRq1Ev8N2bpDwnNBdcJyM3jPgDdUEIU4NX5LIQ6o8k3yNy9AhFfKWOkvAEvB+stq5Vqej3vFSCMo1dl45dTnfT5gVNOxL31qSnq3gJ862zzth2x5TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147477; c=relaxed/simple;
	bh=F8l4JAcoIr+qTYP7zTi/4cb7aJJTkWA9vHeZncR/PI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jVpXlePWdFxhkfV0LsB9V7tFzzJ+muI4qrPL1VhJYsuqcEW23D5nPf58X29TIcOtMMr6438iPkLh+B2l+bGHu6bqhFHNpfnjoE3pdAk0v971a2GxnosR9LKP0y26+o0t5RwhgWUg58djO9EQPejv4EtPuZzdTi3DWDlTCajY4hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cKH030Wx; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ5fV/a898QXnuZPPaDh4qnV5EqgihHAqNYkV2Y0L+wFWFWxQlQN5XlSp+Mu3dflnk2qCRnbcZNocLVIc3fMqQcdd4FuqD4UAn6VXQjWdT6CFbPKsCyFCM2iaTbkd2cIPLYRFqWdh+utJ2tY+7eW3EscTxdMEKREdmL6WWq2BNUheThSVegIUXL02HR/EWuWWPMdDkoYfwSKrzcXO0niyjM7Eh+SCEEiVzpSbreiOI474nbFuTp8/zBg6OB04KRmDYPQVyUmy7oceNhsE8oUfgqT81xnFxxG7IczONtjZcboqz9vh/D5EgOhV2BAcsbckFo3qnKFyTCnGRUZTIgp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W9n6FEpY3nOxPRu8M1MsCUJv5lCwCxfMpjB+R8toBA=;
 b=FXOIEEzhmsZ0EpY/XCeyfAk86vhyoOyJN/Zn+BeEOq+YNuEahjCkC7oHW9H0yjii6uBv7i1p1qid3RNraEPCUIYNOZdDWJyDT2nEMTSeXOLxYQi6GgRPF/dAPJ2cHzLgVj6JV0TPvzzdMfgQnkG92I5X5DMeQiTMpINioKazy+WENfqiZmKYg6tV5GDYhnuCaFmpya/Z+tkUW++tkA+w93X9xtiaYdLbh2BkQIKzIpwJY/pT0n2tZIrfNQNuJBncMpdY82bQim490DOwIxlh6kZjvFHMoQIg2RHMjw4F/m9uwZQwXS4JSZ6b7doKmWUh7uyo2B8wK0+SaYR6zar+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W9n6FEpY3nOxPRu8M1MsCUJv5lCwCxfMpjB+R8toBA=;
 b=cKH030WxY7JleLiYVS4/AL/WtXPVKiSiVBzdH4ig0oipsQ5xqgWPtkfXXz+Rkmad4QvkfV8cs5Tf/4UxdD7JPjVYMdVnNPhfXBpycy+H55NvSphsy1Q234EFqJgEkAWt3XrAEaOfM7QX2rpFuqR4cKGexbv8dnIGgQ9AyDuWhbQ0TrYxe7gY2cDNPod9igosMI9BIQOzCZ5Pjl9Jke66Bvz/vCBOBCP2cbX3WA1Kljon8LeXOjF3sxmHY8yGJIEr84pS1R9G1i4Ta6cv5RxweO06cVCFm+5c0tCP/64EmdNmPnssA/N8Vl2P9nRPGL0zHN7UX7RfKSYgGOAwNLZKpg==
Received: from CH2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:610:54::12)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Mon, 11 Mar
 2024 08:57:53 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::b1) by CH2PR11CA0002.outlook.office365.com
 (2603:10b6:610:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 08:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 08:57:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 01:57:42 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 01:57:39 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>
CC: Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net] devlink: Fix devlink parallel commands processing
Date: Mon, 11 Mar 2024 10:57:26 +0200
Message-ID: <20240311085726.273193-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: f009db4a-ba62-4d6c-05a5-08dc41a95628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nWRVBwwjG9BDASbf7dI9zVoJdNldQC1qJYXYoSNJpUB3uqPHFkW9HvcRb5pD/iFqI7OzF2HsA0aTnNrDfGLQ9nnswX7q4Iu/BVleT+jlF0crkFOfUSc1M/6ECJD4De3i0CVXNHbTveFCpA+dPVfNrSPNiyiI0tY5VKy/LdxG4D3KOmTYgKDLZDsaTHgeiE0XMXxkq0INBd23wbeZTHYCv1tCZg8Pe/3c8EwBqseKSvrdAgxR52ARjDUjXnJM4ZpMy444MjSVQP09XkUQukKxmQF72LwA+JwzoPomspOOvVDkXqnRWWYKTsIR7EOrlJHf5emBF6CHzC4YbxrBOo2fPl8MpsFzHxsy2wOPGxK9Fc/hhi4gvHpBnBA02dKuyT2t7eB3dRxLQsdNjhv+M9EXJc2NP6sxvmj8pzx7sfL0gaEDl1FF+gQ2P7VDkZ9Iwu7kF83pxVWRMvfiHF+nqTZ5tnCqay3BsR5yyI5oLwZqi8yzawC3K/SiRVq+d34ZhF+gKUYkvUxMIuCR7MAP8XL9udwM0C5h9bpG0dMZZBixTZGKjK9J+B1dUxgYgYwuvIGiSGqiHyoO0IXyTK919hrt2AmbvBDhCpqGJv7syblSXzKVpSvsfLWq5Cx6e4xtnLUlut529XmR/jkro/zoBWGxtmZI4AF4z6HscRFljp9tauFo325yZvsqQMV6+wO49m4W6w9EuiY1uMdnVZolbwkTcNaXk457GbiBKlkAlOZ/QGQ1m+4/E43Z2jLsqdFpWCC+
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 08:57:52.8947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f009db4a-ba62-4d6c-05a5-08dc41a95628
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204

Commit 870c7ad4a52b ("devlink: protect devlink->dev by the instance
lock") added devlink instance locking inside a loop that iterates over
all the registered devlink instances on the machine in the pre-doit
phase. This can lead to serialization of devlink commands over
different devlink instances.

For example: While the first devlink instance is executing firmware
flash, all commands to other devlink instances on the machine are
forced to wait until the first devlink finishes.

Therefore, in the pre-doit phase, take the devlink instance lock only
for the devlink instance the command is targeting. Devlink layer is
taking a reference on the devlink instance, ensuring the devlink->dev
pointer is valid. This reference taking was introduced by commit
a380687200e0 ("devlink: take device reference for devlink object").
Without this commit, it would not be safe to access devlink->dev
lockless.

Fixes: 870c7ad4a52b ("devlink: protect devlink->dev by the instance lock")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/netlink.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 499885c8b9ca..cffc7274de8c 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -193,15 +193,20 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		devl_dev_lock(devlink, dev_lock);
-		if (devl_is_registered(devlink) &&
-		    strcmp(devlink->dev->bus->name, busname) == 0 &&
+		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
 		    strcmp(dev_name(devlink->dev), devname) == 0)
-			return devlink;
-		devl_dev_unlock(devlink, dev_lock);
+			goto found;
 		devlink_put(devlink);
 	}
+	return ERR_PTR(-ENODEV);
+
+found:
+	devl_dev_lock(devlink, dev_lock);
+	if (devl_is_registered(devlink))
+		return devlink;
 
+	devl_dev_unlock(devlink, dev_lock);
+	devlink_put(devlink);
 	return ERR_PTR(-ENODEV);
 }
 
-- 
2.38.1


