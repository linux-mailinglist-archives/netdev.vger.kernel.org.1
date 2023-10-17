Return-Path: <netdev+bounces-41712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE47CBBE9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50E8B210FB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C41799D;
	Tue, 17 Oct 2023 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WwnX6MQ0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD472171C5
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:03:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDC7F5
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:03:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX1aJ27FE3IIFO3SN7Q+y73TXGnXczN+LHq7GcAvYK9XXyzjrRhhXUN1WKrKaZGuxTTsAni/HZl1hsNzAfPOuc562uEP8zvofgarUuTK/oLTsjjZGiuB9jA/nZVofeJKVh0fFtJCQr7pEaFVtzsIxiWKO+Rmp1Of5qbm0BhET3eiKaqh2Gd6stx55lUrQkUualgECdRWf/xWk+FLRLEA8hv3aecvxwbX1CTtyMYHZ3QaCmqESFQFcaD1lFiYFWsl9gAaymB2wQoo0lrRduAXRef1Qs1NOXw2PK1B+5VxFUFkoileznBafcO7i61+d9DOqqosEoDMb76XRc/7gU6/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bukTiZgSHneh0UAY9aN87ojPocTE7xV/Z8cQ2+taoEg=;
 b=W+2nZTkvr3wo2GE0R88lm+5IGNQc5LjdSZ33jbAHBHVu0TZN6ZbzSCnwixOa9hJ+C7krfyGqyCnMm8hn7hbCopcBoY/l9d5PD6qMO1isubwBJnRI2e5FaLET7OMCm82QZHuwygNrezEe7PQPo+Z1jjmWWsR6KNGSwuadm8SzRJwimSsrK7FsA4+2E2CXI/eyjQIgiYRBjvRi4qbNvNhhL7P15Lq9Qu/uLR16GL4AzWAq2vLE9Bu0ROvm/0ssRH30JPi7iT1W5Vva8JhMpTtimf9yJDK1DmEeCTqkIETAUNPvcYZFlppgJJ0C/I/EPv6Ld5/AZyU8ytYM+R3ML4JOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bukTiZgSHneh0UAY9aN87ojPocTE7xV/Z8cQ2+taoEg=;
 b=WwnX6MQ0y8wq0C9oe4GdeXvWwbjWLDDyaEUwM08TFl5E8L9sZr3r0vtTYIeGOaZwyNnyYkDWRq2JAedGSq+e1VfGj5kOep0bDF6YP/bSibGnvueROwQV1cDWo/rdxoVkIkyOXUVhK0HB6eO3UDo7rEwCy91sZ3FC/Aj56c2YCb1nFax3Vim/coN3EEG/S1qxj7lya1Rr1Owo0EOHzvHizDAwRO4Ff7JfpiU5cdCU2u3Lbhkpbc7RQKkwkiZQXCZyW0Psk4frlmqAljC7iZXe3OZ1gHGkGMK1zvf9GuYUEpUMWn9/k8A/Wa1XhVGqMB06qfPQp2Wc4uQXdo/9sl2QRA==
Received: from CY5P221CA0130.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::16)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 07:03:15 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::dd) by CY5P221CA0130.outlook.office365.com
 (2603:10b6:930:1f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 07:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 07:03:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:03:04 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:03:01 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next 8/8] man: bridge: add a note about using 'master' and 'self' with flush
Date: Tue, 17 Oct 2023 10:02:27 +0300
Message-ID: <20231017070227.3560105-9-amcohen@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017070227.3560105-1-amcohen@nvidia.com>
References: <20231017070227.3560105-1-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c1d711-106e-409c-be2e-08dbcedf2277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ggM9rTsksq3Xo3a6V9oMdyvLJSTgyCYKIwWOXgA0VKyHEE2hkDfo1etlDpCu8S8puXR3ZghfHVZHFKOMCb+X+DO15tsC9sHtElOavGNoqJxIYCb8gc8MtY5khhnWlacJljt2sbQPIPM9gZK4BuDGvsayz9bNvZb+hBrVZYJqB7xL0yWAWKzzBtXvK4kOkGJW/clmb8eKDJaH3RRUljV3/y3c6DBeuv6pQjpiEFcy5wJXPvRRP2stm4ONnNJBywsF4gYUuV/pocFOmygxwHRLInsuUhFS3GNuI7X4/BKh8bXD3/aZ1JugwjayZ7dd/0i4DGlwDkhRCF0UUwHK5tO17A6PSOQyMSoR+bvtwgzoaJRCxZl9scE5NC9bzXgfTOhNJeCS3pU6GmzEhMz95Z1CvUAV/Bns6MoNQMFCNZtqi0kFszWlLI18gKmjdy/tz4aMlnucY66xQLEy5LpbdkFkeYphjrFytmsCVPmzcfsl8GFW/8ZBZNiyPZhAemPHiq06DtRXFIKUgx+hRiju91iYmoYELmSoOz0PZ6oUbifAeJGUrDgH9dm8ov1Vnkd6ye6bVNFDtmzQ0ze2KZ9vG5FHATSqUY893CN+ZZr235CfpRD5InzeU6OB5UnelMzHJU67tNS7kmVO/fp+LJ6XncQrhOqai++JyfpTPEdMfcD4gytYHv943VFXUMgSmPkztQZpQZz8mDN1gIkb4sN/DDoHHcYo6hk3EuNyYRpK7pmInVg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(40470700004)(46966006)(36840700001)(47076005)(8936002)(4326008)(316002)(8676002)(36860700001)(70586007)(478600001)(6666004)(336012)(26005)(16526019)(1076003)(107886003)(6916009)(70206006)(54906003)(426003)(2616005)(2906002)(36756003)(356005)(82740400003)(5660300002)(86362001)(7636003)(41300700001)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:03:15.3265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c1d711-106e-409c-be2e-08dbcedf2277
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
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
---
 man/man8/bridge.8 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index f76bf96b..ee6f2260 100644
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


