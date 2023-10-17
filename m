Return-Path: <netdev+bounces-41876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0E47CC141
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281691C20DEF
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43F24176F;
	Tue, 17 Oct 2023 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jpprEmYe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA141A91
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:56:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643511D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXpRkMmSY+pJ+kvk1yf+DZ/iucULqjN9aPWC1SmA0GGQQFbd9XsP4FzTgWLWuLKS4yD+NP99HchyXAaTwgJ/u5kLJr7bsbOGAbdGJ6eC2P5rVKbgqD8AzgTfHfMEibHP7p8r7T7ACrpYQpK76ZTXSE8bCxRSHZbZFeWOCvRC7Yg+ros42U9ca8/+M+5XBISEpCdSFrrCIjf7HGkB0jVnWKcsTvmj9f/+5FQDyWtIx253zEBwOoh1zJwLzI1DT1P+3cuHS77J4ZqIGbVRWZa7dsJqBlmE1cEaCKMozZFNKn8ueXgOc3IUEsk6/lgoFOZkGcs6JJ4JdE9E7L64iXZW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u26NP98Lpbkhrdc2ZvS5NmrCK/8yrJ03Lj1/3+IyZk=;
 b=XqpkPbe+x3wArw/vmh6bK6r3ZOXQRbmIux7CktT0HquyqaTwn6wNPlgFIb8bL/pZiFqeb/I44yg8qFiG4L0ETO2MtYcedarbM/PMb35l5iDkpPSJwCuuo62xryHzfVtUyfKM55mtG56yKTF/Q6lRa/LFAVbaQjxXRXnDbLczcR/5G7XNDhQ2yLoTpIkkF5jtnK7UzlKgnF2Tme/VbVdEzYkwmR7GFNglUFexnErtqpSho6Jyk3ZoaXD3CcYtzui2Zak9sHOnWUdSIjjbmOqrKH6Ce6F+O7rAcV2PgKCtc5SCsW/IzBEK/VsEI3RN374toIa+rtb1URTo2vCJfJHMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u26NP98Lpbkhrdc2ZvS5NmrCK/8yrJ03Lj1/3+IyZk=;
 b=jpprEmYe9qkTnIHdcLNWq77TDfQcoqyfftePPx0xdKDw8yvtLr3xHD+bdMjcRcXbEJU6OLCne8n+hhJY36plgGxcgkvqeTL+slWpfDFfkQcu9uePzZYJv0KRqmP2LHUz2cTn3k7eRs5Ci4IB7+BO8i5OxpQa22LNoCKro+vgmLRJEU96SSussoaGxTrw64pSXfrC3Rc5K4XFVi2AHXRKhlseO/fHz6Psz7jU1BO131RISUtQDRQ9yz0Tx5ABOQRmmRnPvatcnoCwGnRtYs2mTN2gQ9OK/lMyQrwWsOyGMSqyD7fobshgjpyUUAsNFPscGtJAuU+2UfnIGXQgnEM7+g==
Received: from DS7PR03CA0228.namprd03.prod.outlook.com (2603:10b6:5:3ba::23)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 10:56:17 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::87) by DS7PR03CA0228.outlook.office365.com
 (2603:10b6:5:3ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 10:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 10:56:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 03:56:07 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 03:56:04 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next v2 8/8] man: bridge: add a note about using 'master' and 'self' with flush
Date: Tue, 17 Oct 2023 13:55:32 +0300
Message-ID: <20231017105532.3563683-9-amcohen@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017105532.3563683-1-amcohen@nvidia.com>
References: <20231017105532.3563683-1-amcohen@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 0adec836-1c9c-4414-cfa3-08dbceffb007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yb7/aO1fheCO2hHO1BeikpuzvwzScodjqiAmrNORg8Qp82ppi6XE6W6/6llg/5UD6cJSisvFkJwpoVx91mDoYEDkC4ZGA1PVYDHaE1bUioSGcPO04ntI0mwSffsWZwjY9ZeMoBKoI3uD2z2DZah5iieFe1dT4sIKBc/YgVbV+1WRZ4xrmj+pBuf9D0OqI4zXXIww5q8CGeauCM1HTqu9qAmq+sYWjV6wOFdJLA3zezfUxvlzTurd4hMRkMdkVL9VHrHVRB1geGMpRIQrMei++wnh1NGQM6fOQtnK24qo+MiWkZukR2/ewr7HM7UBHLPfWhALscA0RH5nEqrQy2JHQPUPWojIFyL5YOPjQ+9kqlD/mHw+jdAakdb0FNT63tOSpoKlSDU1aev8n4c6g0TbKo/0DLCue5WplI9SOTEbuRdgXBEAqPs2OdatNPbrHxAqvSZVZiJe+dACVwCru7iExSzY8HknNnsbh+qnDallhLLKS3yCyP1lZ8dGj3VuFUD7NeR43h1qkXG3ERuDd+cJcxGf+eo+RXEXUKVqlshkrsT/kU4eO337FdKzzp9Nnzqdifd0yCfKvLqHko8vCwRrXrjElzJ9WWXBkV/dDaumYhQo4I+WgT5SY/pTe1tFHMIZukX2xVdFGAYAkvfQKfJMnxlxdxL+FzTtKb/zkXOwl5v3T06PxRwIM0D6dSqJquljFW0N1YOfE86HrbXCOo4xiruUL57DlzCenwGIpvpWantb8n+7Jd45zYSMcjfhNUPR
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(36840700001)(40470700004)(46966006)(70206006)(70586007)(40480700001)(316002)(54906003)(6916009)(86362001)(2906002)(40460700003)(5660300002)(41300700001)(8936002)(8676002)(4326008)(36756003)(2616005)(1076003)(478600001)(107886003)(6666004)(47076005)(336012)(426003)(82740400003)(7636003)(356005)(16526019)(26005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:56:16.7247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adec836-1c9c-4414-cfa3-08dbceffb007
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When 'master' and 'self' keywords are used, the command will be handled
by the driver of the device itself and by the driver that the device is
master on. For VXLAN, such command will be handled by VXLAN driver and by
bridge driver in case that the VXLAN is master on a bridge.

The bridge driver and VXLAN driver do not support the same arguments for
flush command, for example - "vlan" is supported by bridge and not by
VXLAN and "vni" is supported by VXLAN and not by bridge.

The following command returns an error:
$ bridge fdb flush dev vx10 vlan 1 self master
Error: Unsupported attribute.

This error comes from the VXLAN driver, which does not support flush by
VLAN, but this command is handled by bridge driver, so entries in bridge
are flushed even though user gets an error.

Note in the man page that such command is not recommended, instead, user
should run flush command twice - once with 'self' and once with 'master',
and each one with the supported attributes.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 man/man8/bridge.8 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index e5c6064c..07bb9787 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -943,6 +943,11 @@ command can also be used on the bridge device itself. The flag is set by default
 .B master
 if the specified network device is a port that belongs to a master device
 such as a bridge, the operation is fulfilled by the master device's driver.
+Flush with both 'master' and 'self' is not recommended with attributes that are
+not supported by all devices (e.g., vlan, vni). Such command will be handled by
+bridge or VXLAN driver, but will return an error from the driver that does not
+support the attribute. Instead, run flush twice - once with 'self' and once
+with 'master', and each one with the supported attributes.
 
 .TP
 .B [no]permanent
-- 
2.41.0


