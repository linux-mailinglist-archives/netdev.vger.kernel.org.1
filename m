Return-Path: <netdev+bounces-47983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F45D7EC221
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D44B203B1
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8CE18AEB;
	Wed, 15 Nov 2023 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uoGU9DYZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2E18B0C
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:20:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C8C9B
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:20:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYiPk9hq01mE8eBLMlPG3egRu8ihzZlzbvf/9kKSko7IsCjJxZC/LvZKxhYl6/+nFOqqY7nPf32uNWy4pclRtcv5+dtG6M1n9jTpp8Kk0/Ym2vKntHuOxSCtGE4gh9AUs+kUyOMwSpZ9ilnqZGLm1yvhXpo42z9BwtQIYycYiKTy2R0Dyv0R91jJFfQUBic5wqxgfzFhhvrYAJqDAqYD/BH+yHTh98fsv1wh+MG+UWHqYZuGF96I98LMwviXPp/HJdZo4HGmw8ETeYxLQOVN8DwyglTw2x6uFUheZi54r0QZCTSWVhFp5VW3cmBO1s9xKoSJ8camwURKvC0Y7JzsjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LtfzQoW7WNm+1qoDJpi2OQMjtojsGPOsH2dtx6x3nQ=;
 b=ju+ghVhZn2Co8kklmM2JtquTawtmpDK6e3Uk9Ij1U7jo9oVy+aZPWaW01w3f1NdyyZ0U2tHsjZNVzyg/Zjr5834FcZLbuC1UkNo3GWpP8spUT0vO0i0JYSiGxa56D46sNYK96zrL+F8eh/BpgXMMN345qCY8uLrOU0dUWUWIRYOO4Xin1pC5sg0T+/zKH8ZAZMxDj9fr3CrbGP/aVqz6YCXHKc8W89Utkm+Yqzalcwcmm5mq3glX8Y5FqWdNSnW5hJqL2N4ZhMGK0WuDaHdzLnxj3XnoAyk9kIlWPukjaAyYWpG0p1gKw1R4e8HC/N8dinfEfgp5Yk9AmKVN1fE8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LtfzQoW7WNm+1qoDJpi2OQMjtojsGPOsH2dtx6x3nQ=;
 b=uoGU9DYZLYsozqTYj1ZD9QLyjOS99sk0x9WjPtMHWjEBb/5ulAs84qkC/2h/DiDkydpbiA8hhKnDf/kmR5ymRPccHb+JABnUzHFd3qr4klyBWg0Y0l0J9FeckD9vqbghIFftA4mM6xcFY9EtCu/7XRBhvBXZSt/0aK9gQ1jcMbyZwHCf554Yeu/aO5q+40arJWCWdaVJoVbzwr2OIKlI5vrI3EWbqMRSGUq4ngm5u8xIaHf5eu3FU/oQwHqcj/aMF41IeWwNcWgCmAwCwkq7NDpG5rypbRdGcHsr2jGAv1/HGSYcL8xv6QjM6mf2pjXcJ1J1AZytElVhtuVrZhdgJQ==
Received: from BYAPR06CA0003.namprd06.prod.outlook.com (2603:10b6:a03:d4::16)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 12:20:20 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::1) by BYAPR06CA0003.outlook.office365.com
 (2603:10b6:a03:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 12:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:20:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:20:03 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:20:01 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 14/14] selftests: mlxsw: Add PCI reset test
Date: Wed, 15 Nov 2023 13:17:23 +0100
Message-ID: <f0dea3a59ae1e8eb73be5cb1269383bf1bcc922c.1700047319.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 01731c17-1019-4b73-82a4-08dbe5d53bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jLvMefUY3i2sN8trfgCQkTdWJEzTsCxZjyjkbD0E7LfC/D9rSkI8mJiiCRvS9o5Yvh/37BL0rUdmeoou6Es+CY9++jMLd1uua5d+i3eRLAnOIczP7bb3UdwbW/vUJJGn0TQQEEeBm/VVNXUG9nC+ZqfvtH8r4BqEkq4VimZihpQRSSFAsd1Rjv3JC3g0PkFj311uh4Z0fT0A0OHKBpl0DsCW8oZ7FkpzvdWi+0gRHWtmpcgKMNCHXOYwHeZ5Bpj9CWV0oRRC/jY90qlg3kxrGLRVbne6VN0ncMzS0ANpyThCZXOvuL4+6HK6yDx7UP4oLuHBxmuf/FLiTKXAJdbtfDohNW1VV4v24nt4roNGLQw6uBxXo4+dSa99S+Gx99YjpWfXh6PF0Afe8Lw2frd/mTeiV8yVp97zb9iqshMaphKktmAsw9qFPtCiUp1ePVEtthTsPsRnHwKgG/tYcINk0coVgCv9p5tqdb6OLmC4Xc0G9aKC/TYlkAniugbZF9lOjWOD83h5EYPN5+DS9vXoQnhiQrUTMpmdjezUlHcknovXVrtW3BNTGQrehk1WCbzXL8a4i7Ec3R+lCSa07AB3WZYOlQFMHJUCFK7g3SH1vGHvvgOkrQQQODM6R+uSC4XqtTKGhH8kQ4X+9MPDb1RbgmrXf7zNqk6uj6k9rnWw2iYYGnWwolmHRKNVYLXKTda02RhRD9iyU6eDZcwLTj4avXs3fCbTLJR0p+jxSuIIyupuAjjOGPvrbMDj6///9Vc5
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(5660300002)(40460700003)(7636003)(478600001)(356005)(316002)(82740400003)(86362001)(36860700001)(36756003)(70206006)(70586007)(107886003)(2616005)(16526019)(110136005)(26005)(6666004)(47076005)(336012)(41300700001)(426003)(83380400001)(4326008)(8676002)(8936002)(40480700001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:20:19.7972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01731c17-1019-4b73-82a4-08dbe5d53bf1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

From: Ido Schimmel <idosch@nvidia.com>

Test that PCI reset works correctly by verifying that only the expected
reset methods are supported and that after issuing the reset the ifindex
of the port changes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/pci_reset.sh  | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh

diff --git a/tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh b/tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh
new file mode 100755
index 000000000000..fe0343b95e6c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh
@@ -0,0 +1,58 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test that PCI reset works correctly by verifying that only the expected reset
+# methods are supported and that after issuing the reset the ifindex of the
+# port changes.
+
+lib_dir=$(dirname $0)/../../../net/forwarding
+
+ALL_TESTS="
+	pci_reset_test
+"
+NUM_NETIFS=1
+source $lib_dir/lib.sh
+source $lib_dir/devlink_lib.sh
+
+pci_reset_test()
+{
+	RET=0
+
+	local bus=$(echo $DEVLINK_DEV | cut -d '/' -f 1)
+	local bdf=$(echo $DEVLINK_DEV | cut -d '/' -f 2)
+
+	if [ $bus != "pci" ]; then
+		check_err 1 "devlink device is not a PCI device"
+		log_test "pci reset"
+		return
+	fi
+
+	if [ ! -f /sys/bus/pci/devices/$bdf/reset_method ]; then
+		check_err 1 "reset is not supported"
+		log_test "pci reset"
+		return
+	fi
+
+	[[ $(cat /sys/bus/pci/devices/$bdf/reset_method) == "bus" ]]
+	check_err $? "only \"bus\" reset method should be supported"
+
+	local ifindex_pre=$(ip -j link show dev $swp1 | jq '.[]["ifindex"]')
+
+	echo 1 > /sys/bus/pci/devices/$bdf/reset
+	check_err $? "reset failed"
+
+	# Wait for udev to rename newly created netdev.
+	udevadm settle
+
+	local ifindex_post=$(ip -j link show dev $swp1 | jq '.[]["ifindex"]')
+
+	[[ $ifindex_pre != $ifindex_post ]]
+	check_err $? "reset not performed"
+
+	log_test "pci reset"
+}
+
+swp1=${NETIFS[p1]}
+tests_run
+
+exit $EXIT_STATUS
-- 
2.41.0


