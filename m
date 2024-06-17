Return-Path: <netdev+bounces-103898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF690A1DA
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 03:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796701F21B5B
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 01:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF2101F2;
	Mon, 17 Jun 2024 01:40:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BFDDDA;
	Mon, 17 Jun 2024 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588444; cv=fail; b=fowOFIuqxAcnUL3z8NJKaKWkCNwHB0x5kBMBI+QvuHTktrFvNUX/TvLyAuSQgUteyglQmNdcBU7SbE7/iQAvHCoPYMi+aTLE7H7/JHwn8XBTOFm9aIVxUfBIyrYtYzQ+TLo7upuiPNlVecoATgVZljvpXNnNHr/nuAudy6l8E4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588444; c=relaxed/simple;
	bh=4WJ6n/wkSHw3hp5Hglm7YU15pIE/teRc8UoHgDQiVX0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=P2QVhu03A1ReXTY/+dDlhMGMqvs1xlrKWRWffr3rZpmtZA2eYaSxl298pl0IDvVjjTyEqXJ36grykbX5e6TN76RZVzoe9KNl6YxETll46ayQn92MncL0/qg8jhBJdd5Ojk5nFw8JFONPb3Jqo2nKHYkfO7Dr6774w/wvqxdcdTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H1XjAu024478;
	Sun, 16 Jun 2024 18:39:50 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ys682h5ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 18:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCzGXfay8c69ZUauxuNOJipwYdfl8ZFF3/jZ+OFpbjp4JruJ5IwU1eBBagpjn7oz6A0YUehTQPmpKTDn851vhEZ01YxBO6SxlEExd/QT/sJXTCZLVMZrq+O/3c+0Q9KI4C7ATzi18vKPMCCYWLHVznqVdy6NMKYn6sZZHpq3siKcHym6ZipLWlWC0fU7uNwMiPC9R/YfqKW8IrIlMYQxoMvKMD6P/Sj91i0OKf9BdMqMZbFz6bNSi1zD0WXlsNIgEdAWfJcxnefw+/j9lmvFkradw6kvwCV4P7/cJfTbXRGsru41j1tFi6lBkvBMoujg3bhvwPLhMyLglXcZ7oarKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KStUmuf9fu2Ydpisxp7ieI2P+EjRA12gmm1YeBkaKvw=;
 b=Jb6BwP+jdHx57TIHRa2lCSznxgRt3cQKlic9MZpCOq7l5bBNuhhFXApS/v5yqxzKjjCnqv97Sfbz9UPT1O8GKcevWHh9Vir/p706qAq5DmNte3mZpTQw2E5ADvBpD6/BEN0tq+gNlJF3pt72s5L+gajXV63J+EgFevpyTclAItKOf2FPWbd8AxFcXYIu16Se88V1ZsBjj5h7h3rfnrdOJD/sqSFo488KS6ZB/7MlNEes8PXLiMGIl+AiJsoLg21KgoI0O37FgiVrpP8N4wRLCexJP4FAQLt/uo7yxt2uf0JHtvFcxH8B0dL8xb0AX+lthce1GVCDwlYJpzKqOLZsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW4PR11MB6810.namprd11.prod.outlook.com (2603:10b6:303:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Mon, 17 Jun
 2024 01:39:47 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 01:39:47 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: horms@kernel.org, olteanv@gmail.com, linux@armlinux.org.uk,
        alexandre.torgue@foss.st.com, andrew@lunn.ch, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        wojciech.drewek@intel.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [net v2 PATCH] net: stmmac: No need to calculate speed divider when offload is disabled
Date: Mon, 17 Jun 2024 09:39:22 +0800
Message-Id: <20240617013922.1035854-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0087.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::27) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MW4PR11MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: a82b6125-f3f1-44b3-58d9-08dc8e6e5f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230037|1800799021|366013|52116011|7416011|376011|38350700011|921017;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zqhTlhyhI4S6ykBvYJbLMhmHGBB2zUbfaAUAqN9/5HbekSWuj3zFfx6Dq7Fs?=
 =?us-ascii?Q?Otf44Oze/XrPiNkrqcF54YT7LsBnJcJOLb1+UX6G7Cl/12R8cP4Jg2y1reRH?=
 =?us-ascii?Q?jqj3F2Chb0ApMa9HAaek7oLmPSv9GnS2poniDOYRDLDcWd4HoKkWncxnzgMR?=
 =?us-ascii?Q?EadXgqHbMIrI1BVxyLMmEHvUCEMtTLKm2lxvHoeHjy8Ea5tXaQzUby8oYqF3?=
 =?us-ascii?Q?ZZRDZqlzqrFWNlJkF2bRF9Mvs2ILu0A0EfF+hdQYGgEYlm3IWMj5kAvDVt0q?=
 =?us-ascii?Q?o8lXLoEzwrrl9GX9DQ5dKmpbukQxtrVpTRISxnpsB4/oMTFmitwHdPhuUXF4?=
 =?us-ascii?Q?9YSHFfyXvMJEEcqP/H35/1KaifpDfuHcIBku70GKT8EcAVbsbMey0/Brbxci?=
 =?us-ascii?Q?3d33d+vcsT/rCSF5TItt5J0dB/1jlHpiQzS/IdcmEQvrBxqerUePU2o/qjwU?=
 =?us-ascii?Q?3DTQPPmInGwkOnBAwJj0ie8wETaa4JoykuLq3mYEii7dKWeD01P/31X72uY9?=
 =?us-ascii?Q?Nqbs2SB6SQqb9AuVmSTPaYlbSHLo3Is9sNbavH1lkCuWpJUfHliYvkub4hVR?=
 =?us-ascii?Q?pGX7F5MBwV4Y0zozvbfcVIrEUQJCtCR8SDsppZ6Iv3keY7aqeKnBAFAfE1UC?=
 =?us-ascii?Q?Mp7Q1JE3ej4eCEmc6/yBQlzElns49RE5tTSCr84nwzlx3BIOXSn988akf0FR?=
 =?us-ascii?Q?qLntxVqzZhan5DkYbMI420e1WkXLgd6vp2nhk17gT7346QnpDa10G/A8h8Ap?=
 =?us-ascii?Q?SkQURe/OQWOVmco+f5aycifv7swNhxij+71f4g8qkD8kzxKb36jxE0geVD5h?=
 =?us-ascii?Q?7dmCAO1If3jrmBcHox3C8xHQ4PeE6LtqOa2YwUHd/OCpPXJy0dmSuS3hC5C6?=
 =?us-ascii?Q?F/g9yPVCttAkxsuXJT99XoXvoWtH13URTGYwZNh12SmghzayW52WdJDB6+ur?=
 =?us-ascii?Q?UMaY+ASQRFKuN5sbRf3tZqi/1IQp1C3KTCylNp53X3e/9bgmNUrsvJw2zbFK?=
 =?us-ascii?Q?G49Rqg3nB/srjeJniH8HZ8Ocsyo2O4KdIRdHn9LZvc+5QEVQ/+lkMISmeCxd?=
 =?us-ascii?Q?jS7oFcO8GVbXjG209JEHq/GOEisJNLsHyROPCz6pxHrbSFgHXZdSEPKT6WEq?=
 =?us-ascii?Q?2BZY1kZzO1tVV1/ZlhDnuoVptbAYCrz196snjHYfej1BFH7mnChs/Ir3n15+?=
 =?us-ascii?Q?LhiGWQixhrF6fMe41NTfaI+27JMYuHHZ5z3o78uuclqR6/e3XGijnTMWfeQM?=
 =?us-ascii?Q?0VEkLd6WwFw/eom5kUPDAWePCdMGXq7h/Muuk65LJFiq68cR6o+GGsUIyOnb?=
 =?us-ascii?Q?6Bf6hEJL3VvU3J1Bw3Z7lqzGh2uazv0RwIDs1r+/FX06/Lm0R+W6o2syfJwq?=
 =?us-ascii?Q?5ldbNsSb3Fy1Tl5XvwPSeEwBrucX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(52116011)(7416011)(376011)(38350700011)(921017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pMkKrZokIw3cSWdvCl5N5p9XfP3v+jkZGkk6dP7VlahAnlxd3FLc23VKP+SG?=
 =?us-ascii?Q?g02d23jr7n6/npxaBSI/B1HOtaZEuifchIRxnGXbki1Eg3iksKOCYj1gmd/N?=
 =?us-ascii?Q?PReCutgbtfBSWBoGqOZ2b/jG3jVzAEdurBcbv+w6rjqVHhm7uP6OTCc9EXlR?=
 =?us-ascii?Q?yn2g+mpVH+wQc3LSC2YG7prKFrmDBu2GTsTQdChWqpR6wgDXYCdUUK5K4XxV?=
 =?us-ascii?Q?vC3tMYN+K+sUhB6UM1TNIyiSLCcOf7Sa5kaJRZ9oCA0L5bb4msXoZF4Owtgn?=
 =?us-ascii?Q?nTtNsofQkQoifP1raS5zu0wgKOyw3W1qRWKj/+p177R9S9eD4ndI+0x70oy4?=
 =?us-ascii?Q?uT7X7X/GwekPhYf5CpVXH6WbighaM/7oQkxXCk9WaTJxFKDIv/yso9Ixc3e8?=
 =?us-ascii?Q?dvV9KPXN/RAqdLnI1iBLDnI6PRvwOS5KC4gc5KtJwM5Lbu2qGifvE8T9uaK8?=
 =?us-ascii?Q?aDwEuW1fSTlZANojqoVxSwNn39NqEdSTqvO9bx8DPAi4lE/HV9jSHdqmRXQx?=
 =?us-ascii?Q?MX5U49AKHNBzSMwAtnrzSFN6aDmQx6piX3eMm8sayWlw5Yn6peW1hpfv+OFm?=
 =?us-ascii?Q?8IcruMiykpcZbCapL/JUiq2RUicNK6uaM9g1ArdYBwbg6XcBheO8sRHdtMCs?=
 =?us-ascii?Q?iL33KevZiDYLlktpT7seni+8RvyILOPrvtYfTJqd6//lLmIGZ9jrN81Ryark?=
 =?us-ascii?Q?i5QICgwpDcY5zqsV8wniQDmEqZ5JExhDH3MlhtYne9m7078TnW7EedkJ3qNf?=
 =?us-ascii?Q?TQlzqqhE4AfPMOLl0pfay9R1SrbsQVIS8rJNliJxzmCdYqSi3DgJAXpsnQqH?=
 =?us-ascii?Q?4HGmK0WL/fofitRRaiizr6Kbq79ZV3kD2v4uzIp0LGbMfWl0as8nQ31H9p1u?=
 =?us-ascii?Q?TrFocpZX/zFULCbR0vnvVRRbBzqrnpuQ8xr3NidRRYH/Kqnrlzt/W5WDnk8p?=
 =?us-ascii?Q?wNIN9Ph0rv/nprBZEwD2sv9Z3zgF6CnEfxShnjW1yHPMVrtda9myINOkpFwg?=
 =?us-ascii?Q?F1vufVlos2p9Z/FIwO2NSwJRyybDh9+ttkwe9OftliyPpaS6vQz2REFjM0Ju?=
 =?us-ascii?Q?Sp0O54flqbdJeYIKf9wDEcfstYPbeUCSZbEtD5WE0IB9AaYOZ8PCKNWCRJvc?=
 =?us-ascii?Q?aMOOtF3Y2JSemKeiCUEFGcNURLFO4keNwAHHKU+wDaM+YRt4lGz0qi5g4g23?=
 =?us-ascii?Q?2HUB3RdsBNiQyNiZWIisnmjdhUoVMtcdmYdHFSU5ZHW4Z2rnFp7PbazEQx3/?=
 =?us-ascii?Q?+zwjA3iSpggzcwx1ndsReOS4R28QCMwRoSrzJMwt81epTReP09Zs8roXiN3h?=
 =?us-ascii?Q?sQAa/CGMKWFqBFcyUgxsfL6IzJhW3OyqNt5qDu8rmiCu/eAdiLN84mtFMbL6?=
 =?us-ascii?Q?HnExQchzbFR3iPQRqYpXnOvUp2wySgqZvhELHvFxx7sZ9HckUQ6U7N79imAO?=
 =?us-ascii?Q?EEXQWcDJHnT0ytTsPJlISguSSrsmUgH3NysEwWTNGgR5tKqSF25tGc3atmzF?=
 =?us-ascii?Q?pkogVII2pwfu7ZKtDEDKWSTu26/qrKYyRZQ5ghyUGdbx09oEwiDfjKOtU+p3?=
 =?us-ascii?Q?sm2tQ35T3fE+1yCcIYIDE0pqVT4xDX0fZa0RaeXtApO1Cp/2kO9I+GjFGu4a?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82b6125-f3f1-44b3-58d9-08dc8e6e5f36
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 01:39:47.7668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+Cr8HhyfXSFWAu0kJnwLDwTTobXK6a/tQ4MnvN4TsmEz4GWeBJlOIWrjsFoBvQbmuMn3O+SxUDQ40+G8BRVTtMpIrebG71O3ng8vW/so3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6810
X-Proofpoint-ORIG-GUID: CQHBq263v7ZBH9uMbJFg6cfGxjcMR9X0
X-Proofpoint-GUID: CQHBq263v7ZBH9uMbJFg6cfGxjcMR9X0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_01,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406170011

commit be27b8965297 ("net: stmmac: replace priv->speed with
the portTransmitRate from the tc-cbs parameters") introduced
a problem. When deleting, it prompts "Invalid portTransmitRate
0 (idleSlope - sendSlope)" and exits. Add judgment on cbs.enable.
Only when offload is enabled, speed divider needs to be calculated.

Fixes: be27b8965297 ("net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---

Change log:

v1:
    https://patchwork.kernel.org/project/netdevbpf/patch/20240614081916.764761-1-xiaolei.wang@windriver.com/
v2:
    When offload is disabled, ptr is initialized to 0

 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 40 ++++++++++---------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 1562fbdd0a04..996f2bcd07a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -358,24 +358,28 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 
 	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
 
-	/* Port Transmit Rate and Speed Divider */
-	switch (div_s64(port_transmit_rate_kbps, 1000)) {
-	case SPEED_10000:
-	case SPEED_5000:
-		ptr = 32;
-		break;
-	case SPEED_2500:
-	case SPEED_1000:
-		ptr = 8;
-		break;
-	case SPEED_100:
-		ptr = 4;
-		break;
-	default:
-		netdev_err(priv->dev,
-			   "Invalid portTransmitRate %lld (idleSlope - sendSlope)\n",
-			   port_transmit_rate_kbps);
-		return -EINVAL;
+	if (qopt->enable) {
+		/* Port Transmit Rate and Speed Divider */
+		switch (div_s64(port_transmit_rate_kbps, 1000)) {
+		case SPEED_10000:
+		case SPEED_5000:
+			ptr = 32;
+			break;
+		case SPEED_2500:
+		case SPEED_1000:
+			ptr = 8;
+			break;
+		case SPEED_100:
+			ptr = 4;
+			break;
+		default:
+			netdev_err(priv->dev,
+				   "Invalid portTransmitRate %lld (idleSlope - sendSlope)\n",
+				   port_transmit_rate_kbps);
+			return -EINVAL;
+		}
+	} else {
+		ptr = 0;
 	}
 
 	mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
-- 
2.25.1


