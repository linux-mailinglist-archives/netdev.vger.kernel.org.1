Return-Path: <netdev+bounces-47943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FCE7EC0C1
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AAD1F26A78
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E446A8;
	Wed, 15 Nov 2023 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHKr+JJA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67608FBF2
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:33:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F820C2
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 02:33:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxrIcF5LHWjFbLfHAWMV/eHkbaVeby7NpYnKJmlRkRPUYiqo8hIP6BWPkH1cTvXsVpUW+FgkBzdGD/L0zgZeGcBAZDLk6iyzAWldp6stnvBKtAUPTgRV/LczJLT27+gIld7m9nKVV+/Ifcqse46HfNw5jq55CH1cflOMYQkdDZz/pE/zFxy2PwNHDzbxRh4QRH8bWpHR3ksHN/N9s2TSsviL5pl8hqCGi0xneP7+2q5esCZ6gUGUbopE/fsGTPjNvrgRNqzx7cKXsyTWOG7Kis6aM8KNT4F67xXJr+SM/JCJWRdIT/5YT7KutKP9O0AJO/NkkPj1Olmo1e7jGkDb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/sWFUFbIZX64ATjnlAyCh/d8/opZ7fjV+Eh4Adrlu8=;
 b=acuD2aZwNBytsSfV8qsQXuAl8jsa3Iowz+E7yxtBo2B3DOzX6tK4JrO2g2egJFGZONbRvnaztgkTB4Cy+puiVGcsSuvwF/1v+EeQU2xWO4LGFCnL0r29zte+wnFJ4eJVLY5vF8SKf31jE5TCy6nWVce711rqmJQof5ogUF2ZaigoGNSFFSJDgewFL4Py9xcqtkM548zYTDGbjcFJ6Xsa+J4OCJHMqfy8BItQpPLkhpjKReMTPtz3CEXV7CmYngLiPuzH1SE6nKOJ9bDiEQBt3XcUx1jcRuXDzqEl9UUulwkyqhN3Lq7Lz/6+EV9EDBMsRAcG6RG/NaXlCpCfRscKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/sWFUFbIZX64ATjnlAyCh/d8/opZ7fjV+Eh4Adrlu8=;
 b=fHKr+JJAviC8s9KU2PDdxtU6dAxei9vn/E+0jmKXz3WZnHdPkiiyFAr0jQjckZPaTZK7WCK6N2+X4jQIuV6prknQnYFFeNKrywTtJp6Z9WW+IxAHxzvPTd1H9H9IBNDNzI08wThc4symqeNcppra3QvY/v2phpVGKUCL1T2dIK1hps11MhYhGFX/hkf06PW7C74c+1NHpJ3oO8nj737ivnN5GeRjkXuMS/w7/vyUGK7GSMUiBG5dShykRxzdTCbkOPjb/q4PYnnbBXRPmbJhcysNzfK0+NvsZgKX6nawnvjoTbb5kmoy2r7kfchX1aXSfgribpWH1hmckYwLabuoQQ==
Received: from CY8PR12CA0052.namprd12.prod.outlook.com (2603:10b6:930:4c::27)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 10:33:44 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:4c:cafe::e1) by CY8PR12CA0052.outlook.office365.com
 (2603:10b6:930:4c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 10:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 10:33:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 02:33:31 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 02:33:30 -0800
References: <20231114193350.475050ae@hermes.local>
 <20231115075650.33219-1-heminhong@kylinos.cn>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: heminhong <heminhong@kylinos.cn>
CC: <stephen@networkplumber.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] iproute2: prevent memory leak
Date: Wed, 15 Nov 2023 11:23:28 +0100
In-Reply-To: <20231115075650.33219-1-heminhong@kylinos.cn>
Message-ID: <87y1ezwbk8.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0004acbb-7eec-47c7-dd76-08dbe5c65816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s5g2MH2LOfuh5AyQ4USg2VXn30Pl9DcHE2DhtbxAxKw+WO0JVSsjh2Kp1gctcPXGVl0CLX/VASrU1SY4UkXCHAYFTy0VbeZEJoLntwxy7IdDwy59osCkHV4BJM7RzhfOJMBhd0njUwMVaiPXzviQh70OU4w9esoXauJ1wzDgpz23KlgEPwybuvaYgqlqbUPzF1My8vAgyYsvUM4+bDVqyG9CCT8o16SLgKLxl7rOCxbZLjhFxHJ4zSbEd+QKwAbSk5zeHdbrRDijiN0allf3MLs7As00jFgdigCtzAD/5i3E4sVngJZHgQpm6Tce7gmBwa16q8zyYX0Jh6QIAM/jFm2LTLk68Hd1DwQvYXvrHqwI+xFxHsSIvYiaVh6LC2dveiQeKvWxWETUB0MII/978XV00qVvbpJ8ToQ9gpd3KWt7l3fDPfv9KdwLsT+RF68wLiGLOW9Uh/27nhglRAPR6fqmrtGsnP551Kmjk+T4e5CPtfVnfw0L1VptEPTbS7/bbIWWoJt20O+yiDF5ARBJjIv82+xXT5ZcD68wvCQ/FA7opdMSKAYB3vRHRq3SbhRSt0OoFaPMahed/G0B0yxH8kVp8D0Xn1MczATg4C0wKdEWtG66dSk4thoH+rPaXP8sUTRB0EXCkoeDA/p4NWIY43Dpf9fNQ5lIGR5CunPAdloSI4Yv3x3li5wZA55ethIhEul+561lZ+LUvcJNHtskd98nPkmpHZ6zA8LZC5HRANF9EhOGwfeAZgYrnwQ69zZD
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(2616005)(41300700001)(36860700001)(82740400003)(6916009)(86362001)(36756003)(70586007)(316002)(70206006)(54906003)(356005)(7636003)(478600001)(5660300002)(2906002)(26005)(16526019)(47076005)(426003)(336012)(4326008)(8936002)(8676002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 10:33:44.6142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0004acbb-7eec-47c7-dd76-08dbe5c65816
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044


heminhong <heminhong@kylinos.cn> writes:

> When the return value of rtnl_talk() is greater than
> or equal to 0, 'answer' will be allocated.
> The 'answer' should be free after using,
> otherwise it will cause memory leak.

The patch also frees the memory when rtnl_talk() returns < 0. In that
case the answer has not been initialized. You should probably initialize
the answer to NULL.

> Signed-off-by: heminhong <heminhong@kylinos.cn>
> ---
>  ip/link_gre.c    | 1 +
>  ip/link_gre6.c   | 1 +
>  ip/link_ip6tnl.c | 1 +
>  ip/link_iptnl.c  | 1 +
>  ip/link_vti.c    | 1 +
>  ip/link_vti6.c   | 1 +
>  6 files changed, 6 insertions(+)
>
> diff --git a/ip/link_gre.c b/ip/link_gre.c
> index 74a5b5e9..3d3fcbae 100644
> --- a/ip/link_gre.c
> +++ b/ip/link_gre.c
> @@ -113,6 +113,7 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
>  get_failed:
>  			fprintf(stderr,
>  				"Failed to get existing tunnel info.\n");
> +			free(answer);
>  			return -1;
>  		}
>  

The context of this hunk is:

 	struct nlmsghdr *answer;
 
 	... answer untouched here ...
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			free(answer);
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
 		}

If rtnl_talk() fails, answer is never initialized, so passing it to free
is invalid.

