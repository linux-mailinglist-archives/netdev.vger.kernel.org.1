Return-Path: <netdev+bounces-55933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B3E80CDA5
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FAE1F2197D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69C4E1B4;
	Mon, 11 Dec 2023 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XqViGnoN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0227A27A
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBuKly5+Zi5cOBxPDy5EhRXA/V81N2H6+GYCoQnj13x6hYZSVqZTBqzkNOI5QdNt0zKJcxE4hjPX38Yy3R/5TbIiTjIM60m+fqbAB2S3mIvW0vel3Ja/J5jAMW+1fs5yIMx/WBFFwmg98pDo7nF2EEPYH/qVTYeoJ3OEqZ706je5tdXVrtE2z9lDv7/VW1JCW2ot/mD1cQPua/WfH8YeACDk6dguC+YQ+D9iPxDeGtG8w74p6r0MttVYku68ivZ0fDq7A9LqZ1XuwGd0Sj+RXJZfzbE4yDZGX/gWR2pCWvytHgutmh8LXP2ZvI+GvXh/RV8b/EVAR/AJ7TaSAKQtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iK6crpGi8+O0c9NeOmfN2gIBUowIISQEKDeWH04P0w=;
 b=MNLKt4oJsFNjPiLrtXTFRBIjHwwrohTrDe3qkBKDIUtnBhtPCGbO8dC54n0Xm0nEXNHSKtU1lB/U0Ti05s7urqkxrRQ76PSTqg0XuFEYRg5RKAy+QyKfrr0Svj+Tb8Mr3rZ2InAheJbnDkL/A9NCKMvL67Rb+414s9+jq2DzbCf/98XZjn4kNDjgHUFHXvCG0u31uAPv/JJAIbBxwUYanyhepOnB+sI/hja6nGopIbYotheN+ntnnTQdt9xTomr8CctpB2H5XtEyGYoTGwTIOkKdhTK64eBdmUGIGqwyMV9/F24+u8ZQfsP45jKkUZ1zLmkBUXw44Y+fg9dG7QIcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iK6crpGi8+O0c9NeOmfN2gIBUowIISQEKDeWH04P0w=;
 b=XqViGnoN/cIo/lxPeyZRaC5xKOrWXiXR1XtRKGN80lOVFquPj5uKDvC3pO7qk7VzeHU58FS6u9yyYMXXkIJIFExvfEPlKqz47+Vh0NCwtLOCPDPbe2YW/mMl9xXAdkCFhDPH4PV2gzxArjsdIBtoS8g/lItkvQn0H1WyA2AyXoNBgpeGSJ46Ho3iAyk+oaXIJfseDeKT7GA4kdacIp+JHpYPMoU/iys9A0Ns3zu9xYJIfWbwJnNqNDHkEUPq2haaTaoc0D6K8uui8a5G7kBMsgS1iQi5cwdUoWRav3CY7D5r0k20/tUT5WZ4hJjtfGKCDp0jNBflFwZGnPNgfigF9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:16 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:16 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 14/20] bridge: vni: Remove unused argument in open_vni_port()
Date: Mon, 11 Dec 2023 09:07:26 -0500
Message-ID: <20231211140732.11475-15-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::22) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 57315d38-e4c6-40f3-839d-08dbfa529ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZZ9BVJSYMg/KNgUr3idERlzm3OrOcicP0YOtgYsq/JZVJWUiQZqJp8+1HbJl+L6odoClHRR0CJUjcqiy9Xyt2iLPyR9Tq4NS7WLs85XFo3CkXw4/iuR/EdwAWI9rRHBZwGxodSyEqCcZXeZZeqA7CUENND/cYT78F1meAhU4Y7iN5nDeOw00xbNtbnBu6qvvPCrkVtxoRsh+TCFjaaWm+qSn805vERSie9giPa6r9MYPyTfgTJaPRgd6YaYeg5CS/DKroYDO2CK+A/IiXHTWCV9UkLINyZisRqCz+s2b4qmX2gSQzKjzf5zL1nkBn4GNwWnp/8+2GZjWljkqVLXm40roZq/h0TJrQs9/wbGBsoSlkLAh1+obKntcZzT/P+uyKKYnn4kPwA0iiFJovZf1qPkqOOnYptLfrtCBnR1D6aP9gNbxVOVbSkRTl0k1t5ep8Egc3MnvNaooYEEgBRB/VWwvdXdsZLbGzQ1s+vtmHwo7f5jF5B4IBMyOPAWVA1ZjVOVtdazh04HZggo0kEfstNP3Rab2NpkVw6E+i6Vfmke2K6/s2FXqmkEnI+DlhRHf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(4744005)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dF/Gc5Vmw9VOhzAEOP4rjlppmtj65nHpig7jgQktjxqH/jdzcOvj9GNxGl/N?=
 =?us-ascii?Q?IdTszGXsLgRbOfB/4kXBuWclNKXknHfz4zegNgEiqH3eO33GfSl6f3sJG4Tr?=
 =?us-ascii?Q?YTotcrOARxcjyVLtEwjuRzR5TMqgiBRF10K1y1631cRITUStOAFcXM+Ao4/c?=
 =?us-ascii?Q?TQVj8uzHP8xFLn03kOUiZS1Blx+Z34hGlkTrsepsoZaoAZk5OoW9LMzA5phe?=
 =?us-ascii?Q?3T55ncCNgHbDPggLPypVMEz1MN8kRrUHS4W8OVtcawGzksptffs65VG6f7T4?=
 =?us-ascii?Q?U7c/XxoOQixnrj6nu6zL1D0qV8w6oKd1LNGGLjdKgC23YS9MhZ3XPYVZt+G+?=
 =?us-ascii?Q?DSvSAqPooxlgniZFy82I8g/RmmBn29/dBOp6+vSYS8czTbEyA475xvmhy2rK?=
 =?us-ascii?Q?BKKyFC9UpkTCHv7i2ZodTGVzH6w9akSLiIrcTxRrCs/hyF394dFjAUIG6Cs+?=
 =?us-ascii?Q?NWOoCguAZApvaGeKZC4S7obEShGLG+AYbCo9gBJBleJiFb15irX+A0xnM/MW?=
 =?us-ascii?Q?nvykpPZYveLz385fWlog+VRw1ALDuDoT6jpFC/UzxGL41+FQmtebaXBoGeqe?=
 =?us-ascii?Q?asV/OxV+kcbphqHxA8UD644Oa2Wa3vV04dEyyVNMs/2ouuSavoKwGnYDoX8E?=
 =?us-ascii?Q?1D0hE8dbAtBTvNovYwGO4kdqyxJ16QTV7ITRPv6CBkxksk7RsIU3PHEaNcFe?=
 =?us-ascii?Q?hRwhPIRWG37C4icXmlR5vraCeaH2bbX6vY/lpqOZ+XytgMufPLDxpRoowo6m?=
 =?us-ascii?Q?pOZn+aHo9EDREij65mbSatO3CUVsj1JZrC7nwVb1zVQqj1yPuE9wpUSvMr2D?=
 =?us-ascii?Q?fNlcnbVahD50GZA1xyaTw/r4DIGoaROxJNi9wDBo8nEiHJ7QgYYIo0Sxpfai?=
 =?us-ascii?Q?jcadDdKIeNUeS/rlekg3rgMWSw4Y5/A+vb7Mrpaf4+kNZ83l7B+5mK4FpwxC?=
 =?us-ascii?Q?MpptXAOZ8ol1b2k8PL6gAAZ8proIYnyb7z3NsWg4A0V7nSGHDxPuu+zBC6ux?=
 =?us-ascii?Q?0Ji/pF/FG+rplRRpe4k0TKi/wzXGXxbKQgcXN+Zi4piL2snW3R32tgDg5ri6?=
 =?us-ascii?Q?RwMSWT+z4KydO/YJRxsMoJUaiBypzcgvUbxlxXejJLbnrg+t6b8yA4ggpIML?=
 =?us-ascii?Q?ZzIb9IQ92rH4q7mX9JUFOCPd8BNu5snuZqTvQcC8G4Sf591LnEiAY8iW53cC?=
 =?us-ascii?Q?GEeEf3iqWBzWZJcNQlnA5GEh99GclNj1jH0CvO5fLS9Gx+NjEseDEpivvkBK?=
 =?us-ascii?Q?El0SUaXqiRKpfY3m3s9FxeDimLjQ69clgWlqUxWwbkSDZ/14A5hh9dd/6wyo?=
 =?us-ascii?Q?j2x39mUljuK9aca2nzs6Hr9XgVZMVQ1SkAsFVN8U8DyaJgac+z6n9dCmaAj4?=
 =?us-ascii?Q?NhFE29bmM/G6BbMuyj0rkG8jM6xFhZvtydpSK72iM5Vtt0TmOi8rj79YWF3p?=
 =?us-ascii?Q?nRQBg7QgFov5f8g2hJt5Wlyn3h5vQ0cKKQIcEqIYlqcAZsz8bi8Nxcq1ypsT?=
 =?us-ascii?Q?+KYlOM2oGEi6n/IltBDdgTe4mH3VUEMmIohdF9KESewA+ahUT0eHurcefWRy?=
 =?us-ascii?Q?472hykZW0srlWgpWg1qslNsBJQCNLuSDYUFxrmXs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57315d38-e4c6-40f3-839d-08dbfa529ea3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:15.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUJw3r6tovjIVm0CqQfLLHB1crM5uk1dqkUj1MU9MjpvuPoNPQ0Cr3aCqvW67e5iHilGTSmQbDCIBplnGcRvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index 0d8c1d34..44781b01 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -147,7 +147,7 @@ static int vni_modify(int cmd, int argc, char **argv)
 	return 0;
 }
 
-static void open_vni_port(int ifi_index, const char *fmt)
+static void open_vni_port(int ifi_index)
 {
 	open_json_object(NULL);
 	print_color_string(PRINT_ANY, COLOR_IFNAME, "ifname",
@@ -334,7 +334,7 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 			continue;
 
 		if (!opened) {
-			open_vni_port(tmsg->ifindex, "%s");
+			open_vni_port(tmsg->ifindex);
 			opened = true;
 		} else {
 			print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s  ", "");
-- 
2.43.0


