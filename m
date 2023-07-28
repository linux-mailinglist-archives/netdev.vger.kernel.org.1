Return-Path: <netdev+bounces-22353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D987671DB
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 18:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76E51C21963
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7212B8D;
	Fri, 28 Jul 2023 16:33:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4F15486
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 16:33:15 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3613C38
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVPSA1JwC33kgiRZw0yr80RTRj8vuhZ4bUoiNH8AN7CBM5eis0EFiMzhEzAMpv9tm0A4JoDcb1SyXhNOV5wYah2ReZIO8oNsczguZVP1olmUmABkQQZulPZ0LtoN3qoC860orhHQH+RmOpt6iYd8zkNNviCZ8jcR9+E405YL/QgcbOTURKDSwNYqT7vjHfx2YxrZzGlBLAc4o6bttihV70rSoIJ0LsnvGmggL8uY7r/X6wOfwRa0GiFy9GmL821LFVcCDs/BGh3rmBrUKR4HiIEdV77Z4Ee/pFCzEDvlM4FBeItI1GCjneVUG0Ucj136B4tIEdpJ7Z8NguGlpDav3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEMyHWtZgCpo0xSdWKU/1OdQllMMyTqRT6k0XmZS8qA=;
 b=PqZBzrYIbfVzAavTLGSGyd2vMdxXJeCdkYZqcMIO2EAol9IvV8wYSRgdyhOogIdw21s+Td91mNHr3Qy12YuMb7jt1SwliA/uH7FiwE/HRX58lKJgB2sU/UoE5CIqb5OXC9gprLZgFVdds2XoSIoKtcva5J0vBls3jK1Qaq6/dEBN751fGFFJ8YhZEUQ2fnM5LbPyjO96hUC3GfnPoYgSX3EZqsDihEVas8IqLm3YNztrPK9/mx37TAvRZB+GzdxfWi3Y+kYaR4ThL4irEfgzv0dItwBzkFHSXFsI1+5rV9ftx4+vM4R4jN4eGftCAe0xDwCg4sQcD+swbgO9nVYvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEMyHWtZgCpo0xSdWKU/1OdQllMMyTqRT6k0XmZS8qA=;
 b=azgyecYwfV+JmoQov3fHh/KBOuv8YKU4wDMCk6erN0L1DeXZw5x6BYBC07XgTkPH1D5aW1wDKOcs471y6sI2TSVGKUWvpC0lAjoVOuul6XD8cyXkn62OOiMb2hfzAHj4qPMMI1QrSOMykPCsHkr9GvCJ+gKr7gAsIv2XodgqOte7RAQIEhG4Q74hO1fAFcCrvfB1eBc4OtjTIdC7upWoCnCrh7dC4gZuHFCZoEJ0U0A5ZEI/fI+Z8KttZ2N6zo+z5Nbphe//qIQvhiys4Oiys7VCealyNzX4irsSqzG9mK0/+zYSDs1SnNghVqZQWmGl9Jx/49PMKgV1mQzOdu5iGQ==
Received: from BN0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:408:e6::17)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:33:11 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::5f) by BN0PR03CA0012.outlook.office365.com
 (2603:10b6:408:e6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 16:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.35 via Frontend Transport; Fri, 28 Jul 2023 16:33:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Jul 2023
 09:32:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 28 Jul 2023 09:32:51 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 28 Jul 2023 09:32:49 -0700
From: Vlad Buslov <vladbu@nvidia.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <amir.hanania@intel.com>,
	<jeffrey.t.kirsher@intel.com>, <john.fastabend@gmail.com>,
	<idosch@idosch.org>, Vlad Buslov <vladbu@nvidia.com>
Subject: [PATCH net] vlan: Fix VLAN 0 memory leak
Date: Fri, 28 Jul 2023 18:31:52 +0200
Message-ID: <20230728163152.682078-1-vladbu@nvidia.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd158cc-ff79-4956-da69-08db8f8854a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OviYwejTQRrCXp3v+B0GdRN/EWo8bZt0jL1jWIUSzXGz/88G8yoFXxt+81M4yavyyhKTGIKQYQYt+0GzGyh1USLUc3PjmlgDp3dF6RJawDxvlBvRTh+JMNi0Ds1SisdnvXfSi5SPFVciEqVa7BTG7Tv2b6Rr2xovvk9JI9eHz9oh800R5ze9CNoWdOjjCsaUPHv2vriZGaM9vhAfuQgya86mPTYwnjNbjwDuvzvUgohZ6qGaD3L3Kylz2LawCQNgQlxhsFp/JREgXIzDYvWj7ONlolNFt6uqp5vjMFfHSGuoOmFSe3SR9tQvsIalZo0t1vV/ITdT/kVjzK4He3sP1/2g1X1AW6AXBVwCM10AKe+/NxMaeTOz9dJkKKja6cHOtx2hlQppZG7PWG8dG7K0w9EFBYjTwI8yHFY6a29QT+Pcin+ScLWPShFPPwi169nZPfEeST5nAG0726r6LHni4FvxzUyAlwYZxJ8SBtCQg0+v7NKrwkazqMXQBOo+cHb6ZBZ6qVy9Scy9xELiwNa8DAaU6qYplYZtm1Vi84AFKvM5Gou9Ay9eZtWknY326wCLvfVhqW9a4W4Xvf5KXr/Hjrsv0JDlknje8ph6oQLghGOA6q47CFru64nw5vdzvbJu4gN+CuhbLqNPiBkPyDeblKiPZh3hx86dstJQAN3o7Gh+Mb2gDJDHiDtTRzX5aDo76xdxBlN+4po8PVhJr6CiljBksTq5NehwrYY1Si3nhFjDbd/LZPwTQVQ1YPIpmTfKao9kIw5qXXfYCTsCnJ08JQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(47076005)(110136005)(478600001)(54906003)(6666004)(7696005)(336012)(2616005)(70586007)(26005)(1076003)(426003)(2906002)(70206006)(316002)(8936002)(7636003)(5660300002)(8676002)(41300700001)(82740400003)(86362001)(356005)(36756003)(83380400001)(40480700001)(36860700001)(40460700003)(4326008)(107886003)(186003)(505234007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:33:09.9702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd158cc-ff79-4956-da69-08db8f8854a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The referenced commit intended to fix memleak of VLAN 0 that is implicitly
created on devices with NETIF_F_HW_VLAN_CTAG_FILTER feature. However, it
doesn't take into account that the feature can be re-set during the
netdevice lifetime which will cause memory leak if feature is disabled
during the device deletion as illustrated by [0]. Fix the leak by
unconditionally deleting VLAN 0 on NETDEV_DOWN event.

[0]:
> modprobe 8021q
> ip l set dev eth2 up
> ethtool -k eth2 | grep rx-vlan-filter
rx-vlan-filter: on
> ethtool -K eth2 rx-vlan-filter off
> ip l set dev eth2 down
> ip l set dev eth2 up
> modprobe -r mlx5_ib
> modprobe -r mlx5_core
> echo scan > /sys/kernel/debug/kmemleak
> cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff888165af1c00 (size 256):
  comm "ip", pid 1847, jiffies 4294908816 (age 155.892s)
  hex dump (first 32 bytes):
    00 80 12 0c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000081646e58>] kmalloc_trace+0x27/0xc0
    [<0000000096c47f74>] vlan_vid_add+0x444/0x750
    [<00000000a7304a26>] vlan_device_event+0x1f1/0x1f20 [8021q]
    [<00000000a888adcb>] notifier_call_chain+0x97/0x240
    [<000000005a6ebbb6>] __dev_notify_flags+0xe2/0x250
    [<00000000d423db72>] dev_change_flags+0xfa/0x170
    [<0000000048bc9621>] do_setlink+0x84b/0x3140
    [<0000000087d26a73>] __rtnl_newlink+0x954/0x1550
    [<00000000f767fdc2>] rtnl_newlink+0x5f/0x90
    [<0000000093aed008>] rtnetlink_rcv_msg+0x336/0xa40
    [<000000008d83ca71>] netlink_rcv_skb+0x12c/0x360
    [<000000006227c8de>] netlink_unicast+0x438/0x710
    [<00000000957f18cf>] netlink_sendmsg+0x7a0/0xc70
    [<00000000768833ad>] sock_sendmsg+0xc5/0x190
    [<0000000048d43666>] ____sys_sendmsg+0x534/0x6b0
    [<00000000bd83c8d6>] ___sys_sendmsg+0xeb/0x170
unreferenced object 0xffff888122bb9080 (size 32):
  comm "ip", pid 1847, jiffies 4294908816 (age 155.892s)
  hex dump (first 32 bytes):
    a0 1c af 65 81 88 ff ff a0 1c af 65 81 88 ff ff  ...e.......e....
    81 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000081646e58>] kmalloc_trace+0x27/0xc0
    [<00000000174174bb>] vlan_vid_add+0x4fd/0x750
    [<00000000a7304a26>] vlan_device_event+0x1f1/0x1f20 [8021q]
    [<00000000a888adcb>] notifier_call_chain+0x97/0x240
    [<000000005a6ebbb6>] __dev_notify_flags+0xe2/0x250
    [<00000000d423db72>] dev_change_flags+0xfa/0x170
    [<0000000048bc9621>] do_setlink+0x84b/0x3140
    [<0000000087d26a73>] __rtnl_newlink+0x954/0x1550
    [<00000000f767fdc2>] rtnl_newlink+0x5f/0x90
    [<0000000093aed008>] rtnetlink_rcv_msg+0x336/0xa40
    [<000000008d83ca71>] netlink_rcv_skb+0x12c/0x360
    [<000000006227c8de>] netlink_unicast+0x438/0x710
    [<00000000957f18cf>] netlink_sendmsg+0x7a0/0xc70
    [<00000000768833ad>] sock_sendmsg+0xc5/0x190
    [<0000000048d43666>] ____sys_sendmsg+0x534/0x6b0
    [<00000000bd83c8d6>] ___sys_sendmsg+0xeb/0x170

Fixes: efc73f4bbc23 ("net: Fix memory leak - vlan_info struct")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
---
 net/8021q/vlan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index e40aa3e3641c..b3662119ddbc 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -384,8 +384,7 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			dev->name);
 		vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
 	}
-	if (event == NETDEV_DOWN &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+	if (event == NETDEV_DOWN)
 		vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
 
 	vlan_info = rtnl_dereference(dev->vlan_info);
-- 
2.39.2


