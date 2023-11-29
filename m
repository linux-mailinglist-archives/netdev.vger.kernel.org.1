Return-Path: <netdev+bounces-52098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD83D7FD488
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA5B1C21215
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9167D1A732;
	Wed, 29 Nov 2023 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XwetMa5N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB97FF4
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 02:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyUN7c5d9jWY0+5aG9209Cjb8kTJi1pERQDoJ5MyWe1d9GeWlwFX/yHnC6TjQhbLSLkKUyuLHDFE+zdzXmmsPjH4l0kuWO0uPeqegre1HcXs45oX28HiF0TtaRd5dGmBKrapRaypXwayMzgfvt6duAufq51DLuF725vBIpB8Cd3R7Ryo877gES70JLgH8PK9xf51Ut0dJpVNwXuQBf5cYBqyV9WWKEX0nPVo8luuxrtIKyMRu1W4G5Yql96S04mMn48pedm8PWbiGPfR+dQnOwrbiRv+vgmvtnXLackQVqhNnJPsQpSl3StllJ0W6LhiPX0UJb/yc2JTBJ75NcTrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/OvNkKBi3LpemyISGJUD/R7qke2oy4mMkjAheBD/VI=;
 b=k0EqXD6M/m9vpmcS50ENUTn+PE22YTn4NQsyV9yhulwEey0EBJMWtie+6P6QItLOWVcS1x2K1iGbcVWAbVO2FhdPTB6j1ffzxn2FqL905wtUKfX9bWzxXqBCkEI2jiV9mCSub7kNgeCfPTue0P6TLBIoN51QrzW2WqCeYlSOa2swQJ6Vh/CtPZSjIwdbE21+6OQTRpYM/tHAJxcPPiAh5ca9hNeRUaOE8f+HAPSpgGNmQhyCeh64T5i3nF+9eyzxvFeMiuNlbcjtjOkJG61bhPSbDze3rJhbQwPbXDD+4x0DIEz2q47DjwP+BZJO7j+8kHxfXo7484Ij3JCzhXkDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/OvNkKBi3LpemyISGJUD/R7qke2oy4mMkjAheBD/VI=;
 b=XwetMa5NftLfGJfOuWs5/XrfE6yhMxOf/QCA1jTuFijAJYmBUawM22SOC6aDyOOi3t17whq8IQ83RdSlAGpDRO5RNQyivjmK7OlnYXR+zTPyU7MYDaCc2zYcK6hSOsg7SbfJM4ugHZ0Ynysv/kcI9AmJDKPmHurrFDiho5X98tHGuyYKMQmRZ0WnHsKm4Qj1SLELpnKX6h3y7wruhKabBj7A9GCX8Wp0nJykB+qiFKy2XfgsV1W0XIFRUf/bBHEddQB03bYwabBoSU2ewnbA4YgGmvEuWGgcW8n4fiRQ/qjoJNiW7lPkO5rT3WI/eSzEZUJIqiUR9s5TzBD5eOiOCQ==
Received: from DM6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:5:177::25)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 10:41:51 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::43) by DM6PR02CA0048.outlook.office365.com
 (2603:10b6:5:177::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Wed, 29 Nov 2023 10:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 10:41:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 29 Nov
 2023 02:41:38 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 29 Nov
 2023 02:41:37 -0800
References: <1nkdhqz7po5-1nkg1mm1tbq@nsmail7.0.0--kylin--1>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: =?utf-8?B?5L2V5pWP57qi?= <heminhong@kylinos.cn>
CC: Stephen Hemminger <stephen@networkplumber.org>, Petr Machata
	<petrm@nvidia.com>, netdev <netdev@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= Re: =?utf-8?B?5Zue5aSNOg==?= Re:
 [PATCH] iproute2: prevent memory leak on error
 return
Date: Wed, 29 Nov 2023 11:35:11 +0100
In-Reply-To: <1nkdhqz7po5-1nkg1mm1tbq@nsmail7.0.0--kylin--1>
Message-ID: <87edg8c04l.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: c195c9b2-2fdc-4378-cdae-08dbf0c7cbfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GjpsRl12W7t56EbOk2FuAET4Kmrqkv0p2VWutR/upMjffz/C3gcUrOB+jP3BXVbc7o+lz9HBEbZ9oVuyZUd8F6HncUQ7b81ext+iiptR78z7AWXkAhHx3PTMpwlh80ONYmEEJgOffC53QNJN7BK9TKkCdu25KFD1RKwkqX7/e0ZWnmduQr+WzV6bGAT1iAzjBSLZMmTLzxbxKBfWgcw/4zPzrs0/GAtaDxqbOS/Vgnr3W9V2SS+6OdIZgGbMU7BIZuA3f1inH/mY/L8IVFx1aiA8ssACTQTbEhCaM4KmxLCC8f3uMhWnTp3jHrTJl0cYLI5gtgRkpWrnxBvsDMp/QTqp/Y3J/DEL80mb912lNtgPcTH09JCRfgfGC58laqcVy1s2uUkA4lBmZ06KLUHo6Fkea5izFKKIOkZBakta7HY2WFXTTKdiXKTAR0U7qZhDD26LKRkHFkdaQQL9mef5CEvAG3Uz/B2sD58088H/Pq9lZwzlPIHrOeyn4bKf+DNtKNhIS43dTWIugJtrMR+cxRwhlnblTyVLfuzZoNjsQuF5tsrXJjeMwgIMPzIuJc6L2vowkyIJwpipiRioSt87cz3MIJV/52eymyWJtA1V61aycKRcqzcRLK5MVjx6wb2C0hmlEG6Qc4cKcX9nOegL/eOIDdGCE3lXM+f1b2wxceIijMVYrDB5y0tSadvIoZrLIhwFx0pMEs+3RR7qLe0w3vcnf+hV+bif0O5yFp/619GB5Qqe8GeftsPY+wNfTR8l
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(36860700001)(7636003)(47076005)(356005)(558084003)(2906002)(5660300002)(86362001)(26005)(82740400003)(336012)(426003)(16526019)(2616005)(6666004)(36756003)(41300700001)(224303003)(54906003)(316002)(6916009)(478600001)(70586007)(70206006)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 10:41:51.3217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c195c9b2-2fdc-4378-cdae-08dbf0c7cbfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223

=E4=BD=95=E6=95=8F=E7=BA=A2 <heminhong@kylinos.cn> writes:

> Content-Type: text/html; charset=3D"UTF-8"
> Content-Transfer-Encoding: base64

[snip]

Let's not have this. The patch that you sent previously was properly
plain text -- can you revert whatever changes you made in the meantime
that make it send HTML mails now?

