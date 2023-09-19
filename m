Return-Path: <netdev+bounces-35083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBFB7A6E76
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3262816E9
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4DB374DD;
	Tue, 19 Sep 2023 22:14:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666D3AC1A
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:14:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231C7E63
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeNmr/RBiYi3vuuLJqdzcyVVLhD68uxyl1JaJfAoHiejQ18EkoctSgkdp+hEc/JRlRbt9N4RHEXPq1gcF8tbKGdo/UjB8eYIBqfjIFsIsMxTB6DtiZyiZnpZ1/nxAnYVz8q+iRhFEX8W1t74roR/lt3qb5QosN4rz10Kz4T19UDKuRIv7eTufQhtJ2Dj6ZwZpLS++tndAtfSs5Xc55QTkZOYVtSJPYWDxe1UhK+AMW9iUl5MvqLG0QkJYrBFpJX4wPlj+p6TQwGW8lIFP2s4op8YPRfakNdQtm1l7MOe8OuUR4m+vc+hYlAkTaCenmjjpVP17NWBRIh+nA3e+dndyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdE4wYHCFKtSwvQ0N3SoQETigbASjmhiVHeIZ84fFrM=;
 b=DW7M+ISjMcUZkCPQkFC/P1OshDadzAnejzTlfoZ2aqmQNVmnJoo0e+A9Vbnsyhj/aq6F+tSLYpdK3yTRnyMONYD4IW7q9MAwllrUGfTpFBfZXg+kHHw7Axf3si+z/uNoxUq0dMMrQHJnC7YdKpe/uXh081Sp6q5rI3S/RBeHAUNEf5rIiZi1CeOuQGapQECMQ8fXbmNCIm02GlAZ/RBnxaD3I2af/2ZYFDR3XdghXZc3Q5oWxX6NxIpRKWOykeOMjtmweQecLgBDqqTJjfSfVtXGDED9Zm3MuaWy9pL8j8hz7Oyq4cHw2U4cbSpZxGeXj2qVxA+tH95rYXuiie4mzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdE4wYHCFKtSwvQ0N3SoQETigbASjmhiVHeIZ84fFrM=;
 b=WnIepyYCQ5G4X3/cQQvJjJUgPztsMB80PsoeNvACzWjmDx2TOnzFHXWKMa8U+TZAGufQWsCN2Sn40n6ru0A9/TIpChrnuI2AK8SpUN3tLsEuUwIt4UCA6y2u8CivQmIvku6Q7wIzy/V6cNBv6bLieRbPaUawQLoCndUrZsngMj9c8yv4no4eU7ateMkiSiAhWbzfGokKCqkDL+q52HVFMKSiuSQhYIFMaN3yBxRhrRJ9vSkmvKs6UqBSp5VevjW3ATMhnhcF+7bN5oh6sR19g2MwQD/g5VScUQ4Q9LFabuip2xIMBsmb4+WFHk8EIrZQOXpCYq09OZ+iUNDIOIYohw==
Received: from CH0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:610:b0::32)
 by CH2PR12MB4938.namprd12.prod.outlook.com (2603:10b6:610:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 22:13:23 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::73) by CH0PR03CA0027.outlook.office365.com
 (2603:10b6:610:b0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 22:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 22:13:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 15:13:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Sep 2023 15:13:11 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Sep 2023 15:13:10 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v1 0/3] mlxbf_gige: Fix several bugs
Date: Tue, 19 Sep 2023 18:13:05 -0400
Message-ID: <20230919221308.30735-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CH2PR12MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: db319b53-d354-4545-e5b5-08dbb95da37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rIQylmVY+wzfAFJqo7JS7enGQh+OuHki4KfjaAlgFd1UqJ3L0DZdkcbz+knXKYQ65jN+8MoKuJ6CF95b9YJgZx07b6U1ZKKlZNlnlwDA6F7QnHfYf1t1SSFbiW5VCMp4LDVwG3Wq8bdnfM0Ch83uR1M9IPF5JJabHIxfwmWzGipetKdr3hNCW4UCDlaIMKNEX99Ag/+i6XZKHeZ89txaFvFDJNCjh3FSXVAtwHtD4k1E7UhUuI/AAL0aUdCX0AzgS99rahCdav5+x2DyvCvgQjcXIL0J6iWKfLu/G0kFgDbnCdQtqaFw2+N0nS+ZVGT09jKV6DMAHb0AqdxyF+y2jlHpHhPEssqvUZcXU+ig+l5cSGF9gQNQxVqiqj0rrD+E2H1JlXQfoQRdQJRAndwr1VK7dqJ2uZ6aG4p/DeyvN4kY085t3t67dh0w6CtifBWtPYT68nuT/ABlt5j8tftCuwexo/Elo+EEAx0SkL+33wIKX+DPorwRcmqrJC8F/FTBbomsxnKnJ4CS+jxJiUwKG24jCABazmeYh49q0CxIGmbSKmK7JoLD/dfEUK9beiv1yC3Z417pIKq1WeOfa6O01I20EG7e8Emq6RMO8Ga/DBiDWXjUJjm1958HldrZxQ2MABJlhvMB49nn9lmvR3LujOmJM8Our0Jg686J22WGNjhimGem3UQFzbf7/zyCEkgfL7rq3wJYm5vrSwGqzyMN+ICpEwWDYcAY3weLw+S/2vLGU47YA47ICAbRO15IK5kd
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(6666004)(36756003)(478600001)(40480700001)(426003)(336012)(26005)(86362001)(316002)(2906002)(83380400001)(47076005)(4744005)(36860700001)(7696005)(40460700003)(82740400003)(356005)(7636003)(110136005)(70586007)(54906003)(5660300002)(2616005)(70206006)(41300700001)(8936002)(4326008)(8676002)(107886003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 22:13:22.7684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db319b53-d354-4545-e5b5-08dbb95da37d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4938
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix several bugs in the mlxbf_gige driver:
1) panic at shutdown
2) no ip assigned although link is up
3) clogged port due to RX pause frames

Asmaa Mnebhi (3):
  mlxbf_gige: Fix kernel panic at shutdown
  mlxbf_gige: Fix intermittent no ip issue
  mlxbf_gige: Enable the GigE port in mlxbf_gige_open

 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 26 +++++++++----------
 .../mellanox/mlxbf_gige/mlxbf_gige_rx.c       |  9 ++++---
 2 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.30.1


