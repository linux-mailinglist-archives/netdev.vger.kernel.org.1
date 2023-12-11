Return-Path: <netdev+bounces-55932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A74080CDA4
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D5A1F21971
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7F84E1B0;
	Mon, 11 Dec 2023 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MSIJJ1Jf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7DFA275
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8jviKfCqrErn9CTEuf6PiokLQxRbK6/tSGW6mhYfhexCqPt1pwLxp+6/CaZ5JluMkkhulHPZC6MmKoyCGtw7EB1EymBQkDaj7qctMmzfAPb2adVN4TaBHBkqDm8TCiA+ktLE7OxAdon4VUzpFyf6SAb+C+ysEnxN3fkaOE9nWHRZmWFklF3mko2RXrz0zXOCMglWse4CRV2LHFtjuxrJw4A2Hf9yrgKc0Pw88nnrK9OzUB8bdcVHgllq1mYr23bDoRFxWsxP27hbp8yWxH8fmNNGv+ly3gGmBD2l9uK0Bv/hgn0sB5OPH+ptIoHuneLM+pAtYYgxrXKvd0S2HnP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNQHUBsTq0ex2Oi2fkQS0vaWEzEO3eGz0yDYvwrlN8k=;
 b=gwTQ13qJbUmq7DkDlFGDsg8RaVqT8tVWjgy3ivkrhK1Ky4Z/tfX+xXiGAyo0mD5Dhz4rpC+e30K9ZZh+wxiVWrI8sj67GS//GFAomYmJ4nYLNjqsNu3tSVDpHUKmnRcMiupN3/MW+1vb6TsgKcfu8dMeiDEt9ATWOw/iUd5WX+EQKpUKYw8XPzgyzGoyYY53diKRW1569XVDlVoJTFuCnjt3Bn8t924Iv2f3Nm63ZzBMyKoAT7kTJGsOCgRiYzEEjks5bDDLUx+V6y9djc2ZIYa315wXq1ZR8T/qA084gibQ2ve2KNAVjrRnNfEJCfPolL/+vWeXqGi7JSkaMa8VkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNQHUBsTq0ex2Oi2fkQS0vaWEzEO3eGz0yDYvwrlN8k=;
 b=MSIJJ1JfD9YR4wp0QKNuzK14vk9r4fP0E9J+YwvKMZHr/s+I+qLSINTTImO8oAy3BSqfLle7jg1ohl9Uiq6KjLIYOopZBbfQ1GTmB1MzPd/Oupqs9na4mz9Iw6H3r+8kBjdNVjNV3rxIx6TumZfreHyufy8DlfEGz286wbQk5g62mNHmgKZBKhsRmRvxMTPnNp2Hw/IdNlxt85gkIkB+iWL3VfHzi2gMGDgWdBW5U+8CguS5wEdGk1CQBDdefYLr5WOMjdz/Yi2uEEuVdF6oTRlsMjMuUWoCoURLI8GMXTP2DxEP4jQpON0Hl32hrYOTMiDGC4q+p2YE42mAz8QmQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:14 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:14 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 13/20] bridge: vni: Replace open-coded instance of print_nl()
Date: Mon, 11 Dec 2023 09:07:25 -0500
Message-ID: <20231211140732.11475-14-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::40) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: e35b77eb-cd41-40a4-ffeb-08dbfa529dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qd7qW0DmYbxRkJlIX/Yl/su9P9LFvI40fZ8OLUBb9+euvy3gArBHz8uOEI92gxFbS0zArVqu0IUD0H+EK3b+2fFwAQ47+IbrDe9dXZgLI0vyQRQccEGY1STbQ9M/WW6qo36A+gZL7+PPk+xQYLBpxLwYC1pcWTaua29fCUc0ANEhkhuligB7sccFaOAk/gsc03iOUzEwLsY9+g6dMBOXR1BtjCULjeScJRyqYSY9HXzb1CJhIqj8UbQyL0RBQ+/mVgxG0lv/wvrdsVo7WSW7CgHo0UoloNhgNP/C8/6lA/4xKUKeBEvpd5ErJsP9NGJuvoMcQCh1LSoDywHPptkysx7JkZqbgaJkK0G4nWYQrcHYHaFlUS5LdlavoIYmk0wReq569KsGLBEnE2SHErAcBf5VMPiZmBAj38AcXh5DpbuYoBBOKuTswZZlYRH3v1mXcGjHct9ltSJjXaelN1pmqtPnLLlSt9ctEVqZ1mJFz4fxpIR3BkpR5Jl/MZtg0lryvKiKgZuvRM+Lghd8HdHCeXGFuzu4W616i8BIxr5w+bej/Sq+jZLQxDXx7IV8z6fT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(4744005)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LgWNdNw1XDoP87/PNr3QnEIRr84UY+K0r8F9Pk4HO1pBLlsD0XqLcoyVXnWk?=
 =?us-ascii?Q?1ZCq2j3/kMrSJsPmh7ipeTJ7ZGL985T14mIVIbhQp5fo1iGUIhMJ0bdkvU7m?=
 =?us-ascii?Q?RgHixYS/TPOtfUEcWHSBF5G2NtDryDJGnAylQ/t8ch5F1iqdp5R5psygeD2Y?=
 =?us-ascii?Q?JRusFy1l3u8Lya2XyAezL/dV/dS9/aWg7T1kkJIWkDaZWavNo8LtmCpNv8i8?=
 =?us-ascii?Q?C5R1lBzVl3nW1NGpPUYKqdjOthwRUUU5j6SZNB0Jm59e8jAMhKvh86iFbX2s?=
 =?us-ascii?Q?2bgZK6YzI+C7Uhx6kvZlDLjFuMrwpNvQy7VSBqVsL+9JG4CS6a8bqclMzFyV?=
 =?us-ascii?Q?FIB+5PW1Ka30b780d1zrprO60q/kcvsF6Q5ZGcXoYSLW6V+ptA1uuPQgJ/ud?=
 =?us-ascii?Q?1NoHQbloxnR4z8mw1ZtHtnjChNa9hmJvHJ3vbbyDAQF0HhmTKuO0ae7kLtUw?=
 =?us-ascii?Q?sugL0n/EPf1qsoM6WhMK64oj3uzW4YsyyJCnlqITA+s65sCAyj9DEdEQTHSH?=
 =?us-ascii?Q?b0azpdCK2JstkLJovSiMi7MkgootRIoRwtpj2/FsEiLp9wq45O420nuoAEUI?=
 =?us-ascii?Q?iKKrt/GzWvfmeq9WyJN7r1V7h48xHByYrdrIFxZkN+E+t3+T3oPVit6s/gzJ?=
 =?us-ascii?Q?kFhMtF+IDg9NMK2Nw/BGdWDuwqKed0EeAxs5RdBrTvPCRNgYAGtpnIghSiwD?=
 =?us-ascii?Q?X/1elyh59S162rsqsggGCEGRk9glCl+z5gELpXcyN1bNo/8B+l9E4fidDjX6?=
 =?us-ascii?Q?ol2V7Jv4owVWUIZS+/1q+nLutIWY9OSUpjjRsTzNr3Ei2878+AeT9bisezaS?=
 =?us-ascii?Q?b44Sr99osGhORizZKEHQKySvm73O0AkVFtJbVL9WegiuwNQoHlxdPSXsFStl?=
 =?us-ascii?Q?CwhIYIBu4LdTJ5d52iIbWvX9vCRwKR0cdkhH8LX9o/3XdAyIb4PbAF/wAN4e?=
 =?us-ascii?Q?6uhLG84XiKJcpmi364DEYFWfSuNl+uOhC8kHm4AE6KXv3ov2YzXkZquJbpQP?=
 =?us-ascii?Q?IG4C5xVhNTxT1xtWygQrhE8eUIFjZkfHYPTj7w8zkfznOxxDf5FNBtYf1re8?=
 =?us-ascii?Q?DDVWiexQUijHVrEiK/OgEN2qVV2sXt5BibRcp/Kp0H7mLpzqHpY2vgRfE+3H?=
 =?us-ascii?Q?eD6dmWUEHqVIAywBE/u1KHpw+xPb/JJrCgdqeev4cxCjXQTpMpeSHvw7UF6U?=
 =?us-ascii?Q?FWVl6D8FZyQ3J6ZqaFDHf4MvzTLbqJPsHR2ndl5A0tBr9bWjp2Qbq9uF0AtS?=
 =?us-ascii?Q?4fIuTNe30R9Lx3RBW6Ol/o0GlTbUdD3iF/YSbZnOKcqqEDsc6pEv07Kjs/BV?=
 =?us-ascii?Q?xgkibajO4d6Amxk9dyqfjTS7KFEtpNlsH1PdyBUKgOxXC5y4uUsNUFNpW1Kd?=
 =?us-ascii?Q?xc1DKzoxRORxweALBrCQGJ5zVYCM5+8nu6/oXJzLXUgKTSdfpKMEXOAKTy3d?=
 =?us-ascii?Q?OXuSHfh555jL9WvFbbhfHeRTZA6n0RhIYGkNVP9zBz2gAy+EEypXSPO/oCcr?=
 =?us-ascii?Q?5YXf4rXhXGwYRWsPRGNfMTDRyXkbFTPAHUnMw33DzSyo34tZEo1ZujDXnf+w?=
 =?us-ascii?Q?p7ToPimBTDBb7kL+VqCpz2Qfk2ee51VmQY1ccSYI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35b77eb-cd41-40a4-ffeb-08dbfa529dc0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:14.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bB+w8ctypMkKtvRrtnIULE4rLjk8bIIYqjtI4y/n/ky9XlGaSSQRdf3Wt4Ph1Zb7mHsPxU0hkIwxboN8l5veRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index 8f88a706..0d8c1d34 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -289,7 +289,7 @@ static void print_vni(struct rtattr *t, int ifindex)
 		print_vnifilter_entry_stats(ttb[VXLAN_VNIFILTER_ENTRY_STATS]);
 
 	close_json_object();
-	print_string(PRINT_FP, NULL, "%s", _SL_);
+	print_nl();
 }
 
 int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
-- 
2.43.0


