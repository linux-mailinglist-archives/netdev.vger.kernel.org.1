Return-Path: <netdev+bounces-52094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B4E7FD433
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EB31C20F6D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448BF1A5A8;
	Wed, 29 Nov 2023 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R4UsrC/+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF58BA
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 02:32:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvXGHucP920ceqJ8tc0+rGTAy38OfVQIu7S7h/QPStTuHLIcRCrmgZ/nGVcP5h1c+HCS6zi5c9I7hT6Y7wnK0awiQL+oWW/pmW2FFt9VGw2SlrG0kTeWhFYbJjEolXOYMD8J5TWFgUSOjFGahF9am+9xF9VK2uvdpwK9q6/FFBbryygpqBMx/jfNclekf+Xths5m9WtN8RnEfeEBynqHVUoqszBVvkPagmQ5NTabmrHreypV4kfH+CsyXulFFwRmRwRzG2GrCfFH98T0fq6TJpCNqJn6Pgtxj0ysgZRdYg4TkgF3JKpFPf+wi4hOTP9/BudICaP1Nk5nyXEiyMZoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68/IJxKs9D7n1oiNjU76NFs8i6Xctxb1/5rk9Xe2BhQ=;
 b=AO+L74ZECnUcSSic2gChUAybh+u5xvI6gNr2gVF2qskP9CVW08ANNpRE6I24a83S+XQ0qny2JskhUdKKsYHXdG5/AL0bOkkZSM/Po7FeBurpoAEZblWnTNScRJz58TZgg8QHBcmlTSq4FRKZBQF8b8x4UXaAbLJOXTikQd7kLi2+7dSynjAe+HHLqS1jk2/xTYbkIHdKpgRjGwgk+Iw/wJNVPpE3du/ALteSaSGulfNz7QzoGAHmsVsgj5Ev+OouqESMvbMQLkFunqpajrmMUpTk3mt3BLkxw3m/KjF5JskVBobkTllZilxXylLqj6+XaHJMAvhTYRrlQOD12AstZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68/IJxKs9D7n1oiNjU76NFs8i6Xctxb1/5rk9Xe2BhQ=;
 b=R4UsrC/+nQZktyNoyBxvDw/z2sLiyA0dxcPDSI/RnB/uY9G6sn8hEocRAZcZ+X7myRuq1+L5x+hEqsAi3w4edrC2nBULuL8JO8XQvUzcjfqhsNoZkf+eO0O+KMchaxvY5xNRodycL9jukPu9gmlPZuSrCy71oZvb43F3gGSaCHDOr6pnTS99foXgkrxnTDmOkxgPkNlTSfMAwqLO2nJ/WObMfm1vFvOL2coSREx5zI5bynoMoq1VfcGE9RbzFZCVOq2DjXN6i5uoKg1JDzubg2p0s+Z1Cc5xbk51W0PYyUcKgaPb3BCF4wM3r28Zj0k58UhmkZUHe+TCEFRxuYP47w==
Received: from CY5PR19CA0102.namprd19.prod.outlook.com (2603:10b6:930:83::28)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 10:32:53 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:83:cafe::2f) by CY5PR19CA0102.outlook.office365.com
 (2603:10b6:930:83::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 10:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 10:32:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 29 Nov
 2023 02:32:41 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 29 Nov
 2023 02:32:39 -0800
References: <cover.1701183891.git.petrm@nvidia.com>
 <20231128200252.41da0f15@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/17] mlxsw: Support CFF flood mode
Date: Wed, 29 Nov 2023 11:30:27 +0100
In-Reply-To: <20231128200252.41da0f15@kernel.org>
Message-ID: <87il5kc0je.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4e7477-6dc0-4bb4-4ce8-08dbf0c68b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mx+O+U+eC4c8p4lJ1NMpP3u505+Lkmv4qBoP/5yICL8THuaAQC9Ig7iLeD5Gd6g3dAgqo5rNeFGYnr0n3JkzcEh9HZzopWD0ZV2SohqUYCUy9RIfiLKv+ZO5J5QW0lSfxvwykAlBhVxVw2QEbUAAq+fqA7y1Md/FHHplfv7tpHsooO5wH0D5zXFPJY4t8iJs+1FAVYDhh1jzpwBnQvK33K7MTHURLjRQCnBmW4fEgRIKFcNUkjv0zbIOObi0zIDjZ8nPQ+zz2YUZzmH3Hl+tKixoaef5tN80zuN3h/eXbxJ8GfMQSxJ8UBjZ6xuHaSKtlLptl2sJyPjxeX9PRHapr5Ei3imMBSyqkP6jyhKow4ZEqRzCJxY/3MyPB30InnNSMmp/+3ZpGv0AfDPpZ9A8KCjy2cIEaBVi6j56imy/yMV6QHmvd+L0YBtqafDEEv9zQc/aLrf0oycJYC7b9oieEg/Vhp6YzL53Ezb6UZMT48RHojwhdx7Vhg4Vag4VAwoZsO3mOaDO6yJU1b7Nfr7/PJoIv4iKI39f91VNOKf001MhHNnuUaRQFQO9Op8DrvXBu/oUEiksD80ltp+mU8yntVi3/cCwept26HZnaYMqLt4LtJ6J2nZY+QQ61FuCw2VfXLcL9lWhEyC6Coc08Q5Lz+kuj2ZUnBuAcwO7gqG2ZMK2UMvE0bqSEc3hl5lWYIzlek66fKQ5m5cqNv4cNgxKPTumPDLGG9rMauu5zt7b2EC7ocnPpE8TqEFT/fYHmq9H
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(6666004)(4326008)(8936002)(8676002)(6916009)(54906003)(316002)(478600001)(40460700003)(86362001)(7636003)(47076005)(356005)(4744005)(36756003)(40480700001)(41300700001)(36860700001)(107886003)(26005)(70586007)(2906002)(2616005)(426003)(5660300002)(336012)(82740400003)(16526019)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 10:32:53.5547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4e7477-6dc0-4bb4-4ce8-08dbf0c68b70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 28 Nov 2023 16:50:33 +0100 Petr Machata wrote:
>> - Patches #15 and #16 add code to implement, respectively, bridge FIDs and
>>   RSP FIDs in CFF mode.
>> 
>> - In patch #17, toggle flood_mode_prefer_cff on Spectrum-2 and above, which
>>   makes the newly-added code live.
>
> Is there a reason not to split this series into two?

I can do 5 + 12. I'll resend.

