Return-Path: <netdev+bounces-44161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9EC7D6B99
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 318C6B20FCA
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F427EFC;
	Wed, 25 Oct 2023 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CRzz/OAT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8527EE6
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:31:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C19C
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WINW4g8YKxB5hfaHLozdrnuYBhzM5De0S+IxE8g2GZCdElM+Gt3FyW17zN4KCG4rrqT6DWqRpAn8M6rVyhAFwNQNvRKhzeIbDyWwC0bVD4dQJfLAyosGEzOF73OlbiR55ps9b8xLXaLtcg3PUbi7JXfZwY+XwhRyftbpmmWMyGumWCOz1bW0ldaryGnJm6Q831c0glB3GgN4O+LOOvLZzyskrfCE6hriOERjchJc93CgvUhzx1ithvEaML91yisyqQh1Il+PmWltIjvhlbuNWZWaNtkoqSw1gFRuY7zXPmSBsSSHCoK+oRH/iLxvl8wEAEDtiMicSzVC7onjTT4FcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgtxxFCzn3VC8mcorTKgWJMxgzUkHqpP5BMNrJF1fF0=;
 b=RvywIStYsE6Kgx2W7ygyvhR2LuxIon8P1YyzRIHqyVPB9kJPjaJRFuHu1CRAyqvTXmPawAv6C3/Laj4ZTBINdmSbvcJyawr1mNK5k0J7h7TKWgBaCimB/3bZos6ucugeMNH5K+LGtN4RRmtV69ADtaS/dWPo6y1b+Yn/RPRDKgu76xziJWtIn8JAqt0AU9b7NzgPtZ/V13ejUYJtlYsaKtZspC4C03k7lGLetqJegLoog8bjzOqOcmsxksxzpyh8LwXSD5lSZUxF6xJ4bQPSIybw0X056dm1EBNkJ8L/WNWlGbA7QeRZuunz/YJ39yw2OzrkFUY8yZhKF+9I9YZnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgtxxFCzn3VC8mcorTKgWJMxgzUkHqpP5BMNrJF1fF0=;
 b=CRzz/OATWmaKUTO3y9P2UynuZf7XMzoZDuFMjgs1CALdirnGk9v4CC7LivmsMDbmEHSYnDTDYH9We5jWvTPmwDPRGbZlZnpXsu6JmmCecQG3rhczonCwmj93EWgyiboQPi2W3vJ8pN79TlDQ1Bze7v8xzfI94GpVvKbONIBfex5y3dWH2PYU7CnYK68fhLdB+9d9mbS9HzbUQjUdsnJEl3cTcDPMJcGROJKlDg42I7rWw1qBghcJCJ3TD2A+el9EPZJGXJ95RnNZaC5AC5y4NPbYDkse5XapOi7K2jVBbzjrPbilENB9pKPFrqt5AkLXBFv3eqJ8ir1/vcHSFJ72FQ==
Received: from DM6PR08CA0003.namprd08.prod.outlook.com (2603:10b6:5:80::16) by
 PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 12:31:14 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::fd) by DM6PR08CA0003.outlook.office365.com
 (2603:10b6:5:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:31:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:30:58 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:30:55 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 01/13] bridge: mcast: Dump MDB entries even when snooping is disabled
Date: Wed, 25 Oct 2023 15:30:08 +0300
Message-ID: <20231025123020.788710-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025123020.788710-1-idosch@nvidia.com>
References: <20231025123020.788710-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d83449-75c0-4479-fc83-08dbd55645ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oKkhYjpEpjZW45xr1zuYZRiHZrF1K+FDtMGkJb4yROCMkPJIxyh0fqv2nYa8O0bRevpvplaPso9OCrXo4okxSDvYQq1B60RWB0ItHoUoyAOMuXYkA2lkKaipEPM/ZUKSqoyb76BTen5pJVB0AE+TQO6u20EeZ0SSnQJMyYMaSPlTxrZOXIPKE7u+6kLoKdHzcAscbYGazQ9Qh/FIR2EHYA9wbnumUD9HdoU1TWXQbpkjzFY6intw5/dHHeMrFXHk/PpoMDU2p/5L76UUfoU7QAzYddSsoxyIdyYJ/+3pXKQMtq2nq+KDdco/WFo393zvAwI4wnqRxWSsS55yBFM3JaFrrmbPoeLBK6+ONAwJ497pQYni3leVgd9UESyYDrB54YQ4VfvnVu+wj0JkECM8aEV1SUMpFClSgifQ3E1zfb7pp1Rv06BkjZrXQL0XkVO82Pk1p8iGP5XRXKIID/9NE0+gSmMnbXHbVe1ffSmB0qv4/Z1GOP/1XrOqgas4i3Q4PJsJDsff681D7F89pCMtBZOgXGm6nUgjBcVWjbJUsCComfs32e1j9VGB+xbAwx9S1BAjstTPjjIYkyvRKZuBGjPzG61bzX9EJ1kulfzu1zVUdCNT/04U8JapTKRiJgHYoQxSKkzN9o37UnkL0xP/0/F0K7fJ9+j+ldwRAOaFY+Ov+jlB1ZwjPp8w6vKFtqDfhLuQkckgkeLg1LfAzZY6jivrAwwqwxj4r2rTY+8f1CR2eRlHswNQybhITodN4ngs
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(82310400011)(1800799009)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(83380400001)(8936002)(36860700001)(36756003)(2906002)(26005)(336012)(8676002)(107886003)(82740400003)(47076005)(16526019)(426003)(7636003)(1076003)(356005)(2616005)(4326008)(478600001)(316002)(5660300002)(6666004)(70206006)(41300700001)(54906003)(86362001)(110136005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:11.9646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d83449-75c0-4479-fc83-08dbd55645ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660

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
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
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


