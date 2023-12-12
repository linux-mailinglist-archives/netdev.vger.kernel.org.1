Return-Path: <netdev+bounces-56542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 889B580F4D9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF739B20BB2
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616B87D8AB;
	Tue, 12 Dec 2023 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sNefzD1F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FA83
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 09:46:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKnuF2qgxemICc52Im5R2mdsPJq/FGIybo6LuD6Tjsmpu2c+tGrV6FvjU3PNoE6OQT+EEBWOUuGQIwBbLXG0TzhnwrNHbohTJrsX/kdSDpwR74u4xbQao0GeaA8Epe+ZqHqs968JFNkC91xCJdRaqCIAt6KhYV0KvYT2OmG+98wg7Qxb/krwX7mUpFZuseOSjKf1QAycnp/AoJxgVbJxhNE8S0KYP9wsUb7cHK6VBKwO2vYSOp5IhgZL1b2gLDpTDrIfgOLlTa3AVbrVVepSf8lEJ51xljyEyEYybxXt8KnMlHhw4OeJP+fo2AuCVISIzSSi2FkUAGJBUckeoXBvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcAtR2u/JEZ4Gk5w1cM87eTJFyr2yUHTk+PbB/wJOyI=;
 b=VZPwCJryuKgBL0m9k+uBB4Pm2wkndcCulR4Gl83W4W9IiFA4xCKdL4gzy18VrLqiEdOnPH6W62Lywq+xxVTfwetEnFrM7StzLHqZNqSnkJtbDqSOiK3wwqHy5db6cyW6J0PD5VGFuUPhH/oQG01z3//CSQ1HZccvqCRXIeC/NY/7h4Irrl2AlCpf3Gr1eotNmIqd2XjjdqlqCrXabqYALjXa4aFDMXS2nHxEK0IyP+ZnZfCz066v/x2vBXNtPfwqI5frrhlhpleOmS/mP5cQX4uwNvj0o6AwfxMiLuRjYXly0LfGYf4AIcjhQ3rAIVJFsHCJFiWOJ4Lp+rq6C5tZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcAtR2u/JEZ4Gk5w1cM87eTJFyr2yUHTk+PbB/wJOyI=;
 b=sNefzD1F5SuHsjgbONTSfaYC8DZIDMcmX0Jpqh0WOVpnwsoIy28Wg3ZkQc0VrIfBmgcDwUegx2nUrC1WQ+5LIqP4WU5ejBPEKfvrZEJzbdThRAW/1aBp4pdNr0FY9YgbYxvyd4DAxT1ANQ9A5hT7IzBPfGP2fAThkCuz3bcv4+AN2ShF0WZ/HmbhhzjBovYZdbRa5XLthrLcMRFVLjQP2+G5zoMsJAn0xEZAnyXvH6Qw6LgU+bBKWsWOxNFdkrcpq/A3LzHnhJAsrGAo7G1kcLddl/coSrixC/Vf26EySr6OKT3k5mMuhXKT+VdJgkBw+aTrVGVwE93putj8NWLhIw==
Received: from BL1PR13CA0086.namprd13.prod.outlook.com (2603:10b6:208:2b8::31)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 17:46:07 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::49) by BL1PR13CA0086.outlook.office365.com
 (2603:10b6:208:2b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.23 via Frontend
 Transport; Tue, 12 Dec 2023 17:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 17:46:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 09:45:40 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 09:45:37 -0800
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Date: Tue, 12 Dec 2023 18:22:28 +0100
In-Reply-To: <ZXcERjbKl2JFClEz@Laptop-X1>
Message-ID: <87fs07mi0w.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: f55edde3-0a65-4b0b-89f9-08dbfb3a3815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q89C8SEL5V0zI/iZyo0pFvr6aJ0WqeUafV7zGDEoj92cYRCBCGYldoyDu+jzhEJm1Isc7mNzLm7eRgSfbbe0nE6HTT7UmGzbDAjY1A9bP+bbMJUOwI7iCzlvp29+BwrwOoQRfmAl91tLRIUzDacmTPYIglBmZZgI1vZq7kyy1vmttMgOX2F/K+OKhB6Vc54/UejjSbT5gEMT0Q82eVfz/8NynJl0zhT42W2FhPIXQKWTZv58ykx5vg6yCuS7MGpy/xSHC44WnYzGBTalIYpFVta+Y9zmVSG3UBAqS+Cg88MoRI0KeCGu4I6r2CQ9SdQnM8jC3GJW2H4pNxBarVLkAxZAPU/CHkbM31R8r/r+KzShU4AnDWv+R6bN4+D1qV5+HcvxZrwlMWr7xmDGVGTen891ahe4BZz4e/1k5fhAdaxOZPlVOzbWPyBTmxkBcuqVWd+ImZQkgpZJ1x17pQ0/T82lQ6id64qgVhpJzB5O0ELmOAgfS6avcNlGJke9F+dDrmxnawn8vR/Mv6BNDO3ootGZlp+LtGwCWL9SKcZaEKkg19gh3NC8vM2fvmZtENgxtRD+te0u49I5n5evaCXOV5O4DmZeCZHdY/+xP6oU3OvTZVUd5x8zjDQBjhQWVjaN7SUg3cX+YDFLw9cF304At1OD4paaPSDnQIPHaBjmQO5KEYUUZR7qCc/nh+KXkP1L6X/nHcL3Qy7JuEaqTh05rXd3XFbgjjBAeY4r0fzT5Iu3f2bvLJQ7sn0Dv+NAAMW+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(107886003)(26005)(336012)(426003)(2616005)(47076005)(16526019)(82740400003)(36756003)(86362001)(356005)(7636003)(8936002)(5660300002)(8676002)(6916009)(316002)(4326008)(2906002)(6666004)(54906003)(70586007)(70206006)(478600001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 17:46:06.8636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f55edde3-0a65-4b0b-89f9-08dbfb3a3815
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282


Hangbin Liu <liuhangbin@gmail.com> writes:

> On Mon, Dec 11, 2023 at 01:01:06PM +0100, Petr Machata wrote:
>
>> @@ -38,7 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
>>  	source "$relative_path/forwarding.config"
>>  fi
>>  
>> -source ../lib.sh
>> +source ${lib_dir-.}/../lib.sh
>>  ##############################################################################
>>  # Sanity checks
>
> Hi Petr,
>
> Thanks for the report. However, this doesn't fix the soft link scenario. e.g.
> The bonding tests tools/testing/selftests/drivers/net/bonding add a soft link
> net_forwarding_lib.sh and source it directly in dev_addr_lists.sh.

I see, I didn't realize those exist.

> So how about something like:
>
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 8f6ca458af9a..7f90248e05d6 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -38,7 +38,8 @@ if [[ -f $relative_path/forwarding.config ]]; then
>         source "$relative_path/forwarding.config"
>  fi
>
> -source ../lib.sh
> +forwarding_dir=$(dirname $(readlink -f $BASH_SOURCE))
> +source ${forwarding_dir}/../lib.sh

Yep, that's gonna work.
I'll pass through our tests and send later this week.

