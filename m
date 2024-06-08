Return-Path: <netdev+bounces-101987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD30900F96
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 06:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E3F1C21163
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 04:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D695101F2;
	Sat,  8 Jun 2024 04:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C76125;
	Sat,  8 Jun 2024 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717822038; cv=fail; b=qeMizJ+6pR6fyB4hdQG5EwiITnKkQkipCwF4IFxx72ktVKt2gOvI8l3WCfntOKbf3ujuh5QSsavsl/Iu0whkX2dD8qhcyqXq68OulrmPLABmOU9TNc+3ygVYIDy5/rqJVH3T22FJa3C+OHlbWrvCfDA5wzl/9Q0PjjQKotd+zUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717822038; c=relaxed/simple;
	bh=D5alwGaoR0aJZsa2OeaJtub4ZvQWYhVxDNPwlBpyIz0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u7wkYmM28sLuiGz17ttwdrRpdvnUxpsv2TuINW6NonO4lTlcYTd0Atkb8sFFmIuPYTOhL52bF17wpJ+damIs04WAmXwdbPu1fRTAlp1Yor5pM9i7i0sSa01tAZH0kDwXY+YposWntnQErtctRooD+jYoYiNf0OCD+/XVuTkFlME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4584YbPF028306;
	Fri, 7 Jun 2024 21:46:28 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yg35f6tu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 21:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtVSiaMbhSqu1XijeFbtlM0zznVdn5q/LyemgU4aZhsbTZ5NF+m3pO89skFF53UgSJt6rmDz/Slk814PQBaqdTDUlOXP23g7HIX8TJ7nXy5eANri9gcMUuNjOujiIQYDLrvp+Qg3sgks78ZWCKh9R0P/JdH3Hx4lD7SSaFK0PSA6BXgC+VinBbOr7IarfMCHuadqY88DRdGPUDnn/Czn8+mQDVuD78ToJyCO2r5bdPrBMN55UO6f5HrOPkFz2xGhybwyKU09GutGWDQFAoRd2nuP7UPIyjVY7ZlO/k7XJ1ouGql+P6DuvvDfGeXEptny2TSbWqWfAhd8gzIHKMXS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AfrWFiLBLrYFs1NEavK8S78FMKMyjbCq1RQGlQYahk=;
 b=Y/AXbTDiMuDPAnjpSsRlMg+CXF+YsVdMhR7dfK+UQeXbcC0okL9gW7xxEO5kg69l46A83WSVFPcgB+IXKNk+V5124iMwiB8R1ELtYJSrVMzrhmPQGYRqKF9GerWoykSGEGQjd9G9TXupEEWy/JzNvqNYvWjsqjvWl7KpuCKtOEB8GKfXWpt8Q74dQPmgaolPoRFo1ZxgrbBsz/jG/oMAuDOVRNGhvG8Ncwmtq7QyrqIbqLAfcwYKnllJnC3avUBEiig8ZDh0AeO/cr/nTW+2M5wrxhPNuNCoaLaF4cdTjcSn7MwaQsIjOtLvi1Hpi8odLPpKQ8GViyeMatRB+q5oZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Sat, 8 Jun
 2024 04:46:23 +0000
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::4ebe:8375:ccb:b4ad]) by SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::4ebe:8375:ccb:b4ad%3]) with mapi id 15.20.7633.021; Sat, 8 Jun 2024
 04:46:23 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: olteanv@gmail.com, linux@armlinux.org.uk, andrew@lunn.ch,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        wojciech.drewek@intel.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [net v4 PATCH] net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters
Date: Sat,  8 Jun 2024 12:45:57 +0800
Message-Id: <20240608044557.1380550-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5769:EE_|PH0PR11MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 3127efda-e567-40e8-f91d-08dc8775f20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|7416005|366007|1800799015|376005|52116005|921011|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JhUynIW3r3OSKB1ark/4TtwmdMOB1p7lNIb4qAIujua11x7xFdCmHLjExlTe?=
 =?us-ascii?Q?3O9K7W2kQ49Ab7kOy1Bn5kULkCAwIElzgjEeqJjAzV06f62Zlybf5ZKrdOWx?=
 =?us-ascii?Q?hlIvjYXBWjrHpVv2s3H1kQOS3b493+f051Ck1f52lIiWh5/pEMBn+GLp/Aby?=
 =?us-ascii?Q?j+CPsYHfkLY55UEM2wQ1EtkerRCb4yQWLdyQ8hQQpsXt4zI9uQE5VgxeVOtN?=
 =?us-ascii?Q?PdLuWFt/2u7lwklI904y172rkt3MpHS5PTZ5+ofIS5LVP8oMho6deYUgi8Ho?=
 =?us-ascii?Q?NXq4PqaA1ZmTwYu/Dw5+iCdOFyDaX39yrvSQAR0dv5yuzp2mt868nT2VFI5J?=
 =?us-ascii?Q?8d8h2JYa0AikWgvpef+JGZeLCtYZdwZY+9vB1YeIaCUm/HtaEDSJGAYx1l9J?=
 =?us-ascii?Q?xWNMm9IMP7XAUH4nhN7Ke3gAx+Kuv9yHA+aP2RK1RjUe+i0Nt4uWkLi/kq03?=
 =?us-ascii?Q?st3+SbDN3vxe0pJcyX3ajljtTwtdzHbEZlQBQrtOiWi8e38XXc4irjDAgszm?=
 =?us-ascii?Q?hi/PxMCP59zvcX1GXd+fP++gKoETkdmBxWtTHMLNcWn2vu+sQ4x57mRcn15w?=
 =?us-ascii?Q?2fwTRXmfuMWDMSX5Vdo9Vx63qivH27p01vpFUN2qEs7mkEX93N+Wx8E1B0az?=
 =?us-ascii?Q?VB5LhIpfTkLid7gTCmtGl8jNiA3w9VuMqrRLv6sbeldfezZh5JFuw6wbNd89?=
 =?us-ascii?Q?+qQ7elu6h5CdtcGukEBeYXelNTF2Fd/LDPdE+8jlMG0TGkkRLaapneuONBJG?=
 =?us-ascii?Q?QspZDl7M6izHOw9Dg15LSmdIs1scv6aHaKU9K7/oA71hLvFIs48beSs+lhXT?=
 =?us-ascii?Q?dZLJxZFL2NdVZANWXcu3HjSwo/gIa9ztlx3sJ7nBzvraqF19/N1wMjo+eR2H?=
 =?us-ascii?Q?jrDAIY6rv06653UNgEELZ6PFM/JqDtst/jGU0Ejz76l+xSzdvet6hle0/JNt?=
 =?us-ascii?Q?xocWT0Of/hHh9t/z+WXWxeOuqx0SNpsviWGUZ1eqA3uEeW7++VNGkHjX8cPa?=
 =?us-ascii?Q?h1aU9nEWSHHnMeD6VR7owl+rJed2oTzt4l00x/X5jkxtViXGR+vCjSWk7TxM?=
 =?us-ascii?Q?0WXnswg1PtvYbs5Bw94ykXiGkTRpPcwVtO27fxgrUpQdo8QL2rg1yVNd+wNo?=
 =?us-ascii?Q?Kzh888aNGkB6Jzvwl1AJpSYDWe3vb2637nA87Bzyvv56pgyYhwWyEJ3DJ0TL?=
 =?us-ascii?Q?gvzZQt9HQQRZ3/avjIrst4h7d6Wr20/JNVnkL0chadjysiWMjPA0gWQyHFdy?=
 =?us-ascii?Q?RisdECK3fU+QMc3YCHbujonUznKZZ/2xr/qyrWfckBqwNNptOBplIqQapy8q?=
 =?us-ascii?Q?rOvwTlTCSz1UqVQX9IA1XYe5/Mx+JHiQZse5GpiRglXTLg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VWlLQoPP/bg5DjvV6r8rSGJi80AFoz0SHsypLbZ8Ldvrf8XVQ9Zp4sgLXd/G?=
 =?us-ascii?Q?joFB8WrCY19lG4R2azavOc7cbDmFAHxvPBs4zbeuN6zrgwzuG7z/gJQGKztW?=
 =?us-ascii?Q?D42EG1eh821sqnhYPHRYXD3E1mcGWpCeA7Jz+Y89NzFKOIFMouLHL8HupP1V?=
 =?us-ascii?Q?tbsHbmFiVqJvAty+J91i9fFnz/MC6MHteZt89OHi9ttAufbJlk1sZvi9LMmv?=
 =?us-ascii?Q?50mMcz8N+x7XfCzJzbqbZ6uXUBLLSIxt7RGGpNtzlwZ4k161pvHtJEipwGHO?=
 =?us-ascii?Q?HUysXdB0MxwumPq0N/mG05F6fUw/xMmI5tOEN0iEOXD1g1UomCuV+n/GE/Dk?=
 =?us-ascii?Q?2aEZI5bgrSCpZ8zQW0t2qHXZS6h02S+f1HzbYNld3qVLJjxF4maTVA9WZbJI?=
 =?us-ascii?Q?DoETuWLYPRPqv2Zba4AuuOPtu9WtAkkUHQAiSjJCyQsebRkqGUPpov0DPaJ+?=
 =?us-ascii?Q?VemBEo65OUMcTUFWqw3mX/wCSNRrDXr9jATTTXSb3XzRuOxTJZQsGP9booU6?=
 =?us-ascii?Q?Yz6o9AEH6fLI4UH3p2TktZT3JXwvEMJ3OwZ2l9DLPuL+SBc6ebhwG6+IRiIY?=
 =?us-ascii?Q?10llsKp/IYtwN6ATcdBUChQMM8ujmzJ8pdmz65jLiO5mwgk3bHZrQ8kwyQEd?=
 =?us-ascii?Q?JWz3hxPbiMroD/HXSh5PqDem3Kb3x2T7HF7ECnrBsz0wU9UiVF059xMzzx5W?=
 =?us-ascii?Q?84bn6upDkeucdA/qGaQ0rQe7W3TXmj+Gh3qXhDEjU8KEDukgHGLLsbmuO9ip?=
 =?us-ascii?Q?bUj7D66bEoFLDNxZRHeURYvLbnZ5tq2YOCVFvuBLlgjLZYVyOhPA215RX5Ga?=
 =?us-ascii?Q?+pwlMjwcxAs1xQ9s2Eu4SZdZrSifMNhGdpbVic1AunNlfR7dF4ukx0pBde+o?=
 =?us-ascii?Q?kdmb5zmF9O7YTdMglFTn+MbLfKHRh0hYzmL80fyhv0iVL0nZafM5GinDfCyx?=
 =?us-ascii?Q?Q6HZVtLGc2RAe2cQBb36N5U8Y0VUr7U8Bgd5yHKlK1BEQCPgrDIsjXFODk0k?=
 =?us-ascii?Q?HYFVNev8PPT0e7JK5PsbBqND67MvgvMR0VavBFImlsJr1A/kZIk80OAyH499?=
 =?us-ascii?Q?CVzqZd9C1W/GjyB3fsUGzhGJhukD7YNiH2NPyu3NstiiPQMy36c0gTmUvv9c?=
 =?us-ascii?Q?MGPCyru+rxkmfBPLzmMN5PgEuRGtIOjm4GXKe6Q+Madu5fFOtb/RFveo3lU4?=
 =?us-ascii?Q?fNZVsFDcyElJLChp79DQPcjWrsxBEcOMhZjGRXOaeI+/k2blWmGU/yzLDehC?=
 =?us-ascii?Q?HAVbYjnukCbBHVC1YgzWdIIvNX/w17tbbH5mG/HL5+QaPdVEabYA7QA7lYrl?=
 =?us-ascii?Q?4p4mXTrqw+WKIqCvOjqOOe8aJLbyOjDqvlBbVIFsq6SV9i3Iz9gaMddHCmou?=
 =?us-ascii?Q?fOepzQsAbxrQaWYRpAPKz23b1MSZEIE0C2sWiMhX1wdK4Ml0oMgxHDABGItZ?=
 =?us-ascii?Q?49UEx/u8UW3CU5JAb+1yyFsTe0ReodvqzIbyg5yLhYcvSGcHCILDT2kjsZoa?=
 =?us-ascii?Q?x4mqmuy8Z8xSwW3td913/1CklTWCpKatRxu3Lm4J3cimN2I8z9QCbNFTlbHd?=
 =?us-ascii?Q?zGVk6bJHheFWObU6lj5pw/F55r7MLQKt437XS5csFt2FkPuNuAdBk/6P4gF0?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3127efda-e567-40e8-f91d-08dc8775f20c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 04:46:22.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZTsKGXzRlc4qABH2/NJv/xten5vveBr/AgcSQ2Kixp4gY0u88YIw26OydSu2T695Gj/9nndnO/vDflR4IJM7LZ8GKz69KhtjVrKY6mHglk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
X-Proofpoint-GUID: KkmkQ8SZ3PrVOzAkBQMNHgxg-Zdy6Uak
X-Proofpoint-ORIG-GUID: KkmkQ8SZ3PrVOzAkBQMNHgxg-Zdy6Uak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 clxscore=1011 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406080032

The current cbs parameter depends on speed after uplinking,
which is not needed and will report a configuration error
if the port is not initially connected. The UAPI exposed by
tc-cbs requires userspace to recalculate the send slope anyway,
because the formula depends on port_transmit_rate (see man tc-cbs),
which is not an invariant from tc's perspective. Therefore, we
use offload->sendslope and offload->idleslope to derive the
original port_transmit_rate from the CBS formula.

Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---

Change log:

v1:
    https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240528092010.439089-1-xiaolei.wang@windriver.com/
v2:
    Update CBS parameters when speed changes after linking up
    https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240530061453.561708-1-xiaolei.wang@windriver.com/
v3:
    replace priv->speed with the  portTransmitRate from the tc-cbs parameters suggested by Vladimir Oltean
    link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240607103327.438455-1-xiaolei.wang@windriver.com/
v4:
    Delete speed_div variable, delete redundant port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope; and update commit log

 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 20 +++++++------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 222540b55480..87af129a6a1d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -344,10 +344,11 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 {
 	u32 tx_queues_count = priv->plat->tx_queues_to_use;
 	u32 queue = qopt->queue;
-	u32 ptr, speed_div;
+	u32 ptr;
 	u32 mode_to_use;
 	u64 value;
 	int ret;
+	s64 port_transmit_rate_kbps;
 
 	/* Queue 0 is not AVB capable */
 	if (queue <= 0 || queue >= tx_queues_count)
@@ -355,27 +356,20 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	if (!priv->dma_cap.av)
 		return -EOPNOTSUPP;
 
+	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
+
 	/* Port Transmit Rate and Speed Divider */
-	switch (priv->speed) {
+	switch (div_s64(port_transmit_rate_kbps, 1000)) {
 	case SPEED_10000:
-		ptr = 32;
-		speed_div = 10000000;
-		break;
 	case SPEED_5000:
 		ptr = 32;
-		speed_div = 5000000;
 		break;
 	case SPEED_2500:
-		ptr = 8;
-		speed_div = 2500000;
-		break;
 	case SPEED_1000:
 		ptr = 8;
-		speed_div = 1000000;
 		break;
 	case SPEED_100:
 		ptr = 4;
-		speed_div = 100000;
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -398,10 +392,10 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	}
 
 	/* Final adjustments for HW */
-	value = div_s64(qopt->idleslope * 1024ll * ptr, speed_div);
+	value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
 	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
 
-	value = div_s64(-qopt->sendslope * 1024ll * ptr, speed_div);
+	value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);
 	priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
 
 	value = qopt->hicredit * 1024ll * 8;
-- 
2.25.1


