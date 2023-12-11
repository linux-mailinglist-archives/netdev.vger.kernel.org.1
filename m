Return-Path: <netdev+bounces-55927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA080CD9F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7FD28141B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683114D128;
	Mon, 11 Dec 2023 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rXCmTe88"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F345E3AAE
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9u/6lYFctw8IeWYnRdam2SKVsGAFFvAG3aRIEUerxlABMb8W7ELRrQJfE2WUaWKW1zb1AEJdOwv4UU34xDzFI6i/Y1gdbvTuLkuxJaHZ4EEM2mWC7lsggTKWlKiw3ZokJe5Y+gZd9nOBiCPca53HSR/zOLhiAQHlMW3dXMAyVESQ/11/dm5Vq51yum7Fac9Ekxu0dGxN8nUIykMhGJGoEdikdEuvVUtW1wBF/O/+MvkhWfwwQ0/gSCab66tVb01Jry1nzr4HTxmx3Xfrljo4aT8ZahfLR2RdbTMC9EzTrk7DkrSGMxaL3YVy5zvjMG3r+KVdpfqr656k9BLRK8SPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gGalSWQnkmLyq8GixPzxHwiPZxZ5uMyGwFY29R1SaY=;
 b=PsY0UczELz7dv18vsLAJ6SnKYE3HAF7K3pLIS2mEMSMvi7hRqOeahM5aRmx7uTp498TsT4XcwyRswyRjehRXizANC+52slYtz5kE89mNqtkFWzZNULPpDhW3kfoEteDyT/3+Z+RSdFNiSDe2eWoLWgW9EgzInCwC2wnTMnEL26UT/Rp71NfHQcuYSXtNAvyTpaJR5pdOL3E1QPP7n9d/pY70Pn3GzhcrJt4B4uX8Rf5yNHZKTkO1Zf4wU1QxFALDEoBpkTJAP63UzXiwh+n8NFeZw+ZcEK5HR1sARF8huKzqoDxnbJrvqOMmDbCkjCgl0N+s59dYOLBwtv4nVIFjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gGalSWQnkmLyq8GixPzxHwiPZxZ5uMyGwFY29R1SaY=;
 b=rXCmTe88bL19UuPQkKE8Uj8FaDovfbQ68MgZqtLbBQ9zdHavI/+T9gaS8BoC61QUH5p3Yb8b2Q2iJ6/+cOCnI8vriXxqId1eDzEUX1GkbpnoDSnaKv+IIEcvXVqQi51Fv8cMOCcX+KeCmu4bCGN+AOjRj7j2cQPMcE4QBtGues4BC4+7xcruD+jLycp9rKc/cMNpV9wdyTqF9kObtwL9OqNG+E1dAxZiWZsNAKFvpsQmjNLs0AozPC/W3d6VvZXO6k07tfJ57ZPfFyCT4kUU24XRPJsYuSrxCsq5YvNfafEOG/RVEeKshm3G8XqNMk8+dY0yiKhFJGurLUarkIkDXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:04 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:04 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 09/20] bridge: vni: Move open_json_object() within print_vni()
Date: Mon, 11 Dec 2023 09:07:21 -0500
Message-ID: <20231211140732.11475-10-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXP288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::35) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 00532ede-9f84-44b9-c5a5-08dbfa5297cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a/IuvxeKn70F18lk742TTfHNAdsx+h5n7+qvCNuHxuuaHkU/7jsrdOlHLVWy1HR/ebKkzyMNhwuJezMZhTV8Nt+MxPDATXXOtfgodYi7629cViOSimtsQaYO/ZI9a51gVCDExEBjsqSE+TVUI8Vy144rPwNTyo3nmDIIi3f9JbB5WEUD66yZKfgnBtDRVXOYaW5IPyqWLCx7c0yKqoOgheWOf74NWlqZ7J8pNoqbjOpcdH6JeuqP/uW0yvph3oqQGzRzgq1dw+J+w0h4LkQGtsUZ1hifIfAHG3ym7FsH83dtxaTEAIrNGFTKMpuvm9pG4WnxbFQ7iSYCVzT65/NBfXOGyziIBI0sS66whLNKoNhymliUJj8vRXaLKqagcPkFKFK58hssxmMBSwrdeBewGWmW9Um29C9rK65+CSEjckMUUNDraErHQexbaL1wyaPjpLhDbp2NV0Lb+d9zxPFAr14KAaGgnULCkTTKa5xtXyYXsO31+Ss3dc6G4Xcjcp/NQ4wi6tvpRE8XdygKzgVc0uwACE1+0rhjoNNMYBS7IPWq/WIixYuv7VgVlqSxmQb9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CON76TMKGDc5VkifTjbZy4UN8HDgaC6+a+/Y3gUeq9YBgg7UWxFmW7+GgKqe?=
 =?us-ascii?Q?D/c7ZV/nfeLwKIo2y0WpIhyytrC3wCoohz00hZMvEyr5npPjB37LO62Afz3K?=
 =?us-ascii?Q?pMijnccodqg34MwujpF3mEUZvFOHvsIcgdXoN03Pz0Eo11uishNc1gn7H6iA?=
 =?us-ascii?Q?5rMSAb6XyCHVw+Q4BiE9bJR8AaKpsBXjqaCmDBYp12199MEmB23RIhO0Q1yg?=
 =?us-ascii?Q?uCcmRLG4hOFGpNiafM9McKQupgAp1iPdLqVnRpqqE/mtpguwhrskAHwG/Y7v?=
 =?us-ascii?Q?HFgyl/93BHsBIJ9hAfZpZwaqxg2CTuUVaDcj5knmkRJmcHmGf4+z2ldB6glI?=
 =?us-ascii?Q?SIaV12SO6cv3lgPPI0x7aSql5W8NfnsQ3Bw+2jFwdEKb5Fie/FKyLNBIET2/?=
 =?us-ascii?Q?yx1Jxhrj+LuMCqTBsimk/w1Olg/BKzLJyXGxLh8CISK97va+5q3JjS2qgWOy?=
 =?us-ascii?Q?mZHvhCEbhWeYDnNRcc3s0Gz+lKYulBJCsJDnR73gze386xs/fSNqs/7HxNPS?=
 =?us-ascii?Q?6PRkCXXvl0rg0qljymqJjEkfIosGnL7Thz/z4LKryda7YAoYfcoV2/CpEvv4?=
 =?us-ascii?Q?S+HgTKlTdzdQrosCLCrcpCLKeG5y5ilbhrmzvipYWXCUeWfrkSW8e0UwXqiS?=
 =?us-ascii?Q?YDzIMhB+rSRI29NjwmY2L1wA7IdlLZ/13JTiwJsEnHvGCO3is5v4OFtLVH9w?=
 =?us-ascii?Q?UhvzbC0f77bFR46lCLfZDnoTl2zAifxV0RjwgnYs0rP3vpidfYduc7U2srcd?=
 =?us-ascii?Q?4QGbLYFfse+4EJQKVgqhhi4yddJDFDy5jlaLKHnnK5/CtgbjBmK1OHnPOWTA?=
 =?us-ascii?Q?t2uCPDY+VhmjSPsPEMdIf3x5MOUNlVa/Krnfv/wDOVwqc1l5tsMxkqQ1W+m4?=
 =?us-ascii?Q?seE3w8lldjVLzYaXV8DcMW7vuZTh7T5jqg8bnMTqxVWMvo0r7o6/+hOcXXcQ?=
 =?us-ascii?Q?2VS7eVZmxkg+XyaLmbe0y1s1phSUdCBNW2r2sNFGPchQ/x1Ceu1R6YSc9fz5?=
 =?us-ascii?Q?r3uJElBCTUfJwSJeWqPaX1HoP5r9dyB8aueCuMKpQgKdzPl2StFrDjeW1IcY?=
 =?us-ascii?Q?nfT5k89k/QEqW/vQil1mGmGnXD/9gH0lfmvYpxysCUL9afstpNxWFenREkfM?=
 =?us-ascii?Q?hN3Y55md8E1rhE+nRuCJbL0UdTVOLqowwaJJ0pAzZthi5k06cPvqDL/wbC4B?=
 =?us-ascii?Q?LkJn+3aCXgO8SrhioW4RJdZz6C6rrADb0alcRWst8Is3GUHkRaebFS33CkM2?=
 =?us-ascii?Q?0DLVHm4FooBmPhArbKP67b9p+wNAfDKwbgOLawZO/1YUpPfMIz2XzXd2mzk5?=
 =?us-ascii?Q?oeuDJRq7DydOQ2B8RdoBy659fxTdba6DOGh4UxCLJFhX8xBtJwnNDJKGzAd/?=
 =?us-ascii?Q?lHcRlXv1qNHM5asVCFgP5lfSQAaJKqKYMZ8qP72Zpx4/7UgYummNYMKvcKaf?=
 =?us-ascii?Q?+RIKlJ4eaTXiyKK3fWxJCMDkNDFOTpKfS+n7DYgTk0YlcJpqT8Bd4FKhny1Z?=
 =?us-ascii?Q?vmNn5v03YUg6B/GWj3CkU8O7nseGTvWHneR7bi5wfJWYLjim9wXbtA+1HtTc?=
 =?us-ascii?Q?50x33tHJLCI7ywEZy4IZjNGPLfWPgXDH02za+84s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00532ede-9f84-44b9-c5a5-08dbfa5297cf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:04.5817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQnVcEv/aYrm2eAPX1mg7xuBwpP9ucZ2wtIcQSst/Z5Z1axxtU96FlQb+3nWIH0eq6sFytcEy6JZtiuvvFhK2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

print_vni() is used to output one vni or vni range which, in json output
mode, looks like
      {
        "vni": 100
      }

Currently, the closing bracket is handled within the function but the
opening bracket is handled by open_json_object() before calling the
function. For consistency, move the call to open_json_object() within
print_vni().

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index 51e65b89..8a6ac245 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -242,6 +242,7 @@ static void print_vni(struct rtattr *t, int ifindex)
 	if (ttb[VXLAN_VNIFILTER_ENTRY_END])
 		vni_end = rta_getattr_u32(ttb[VXLAN_VNIFILTER_ENTRY_END]);
 
+	open_json_object(NULL);
 	if (vni_end)
 		print_range("vni", vni_start, vni_end);
 	else
@@ -333,10 +334,8 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 			continue;
 		if (first) {
 			open_vni_port(tmsg->ifindex, "%s");
-			open_json_object(NULL);
 			first = false;
 		} else {
-			open_json_object(NULL);
 			print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s  ", "");
 		}
 
-- 
2.43.0


