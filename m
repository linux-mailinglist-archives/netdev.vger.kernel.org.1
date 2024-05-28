Return-Path: <netdev+bounces-98445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D58D172D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AFC2860F6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2B913D8A1;
	Tue, 28 May 2024 09:21:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166B757FF;
	Tue, 28 May 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888077; cv=fail; b=d/9gzg9xI6J9i5AUik7Nyu7jAaKAnZvqsJi0S2e+IY9rgM2+vJCnHTB8L9QgCs9axGNyv7qcOqNaaav7idTP1nzI45HbrJxgphItaRRl1ren96/LtOkqlHXWE3Umoi26piTCgQaZuGk3N3nGAcuzRn5QPHdf59PiZJ5i3LA4I1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888077; c=relaxed/simple;
	bh=/wr9dEGSyFY5Ec8P+iRMtcdxy/3xwHC+dnxEUqboew8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TrPW2xMLiOjr1DIUVPbaBawPZCqHlmVvNzLiwRPRRX90CQLuyfB8lr7EBbz09MDs8HHf6Q5cHf4a58sI2XTFKX0epgMpLCtogYFAwOsdI4fKe1D2UtXVElYbTc9i4M/BlLGz4IZdp0Wr4CiFWpCy0Z1ZFXhS8UqkrZPRffEEMt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44S7osWE024273;
	Tue, 28 May 2024 09:20:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yb56xatk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 09:20:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkKknr9LOwu/xy1Eds/ns//kxczXrZFaALP/JIvIN0Xvwascax4ft/FyuHm+MVAtfwqsq/XKQR0lDTDGKc5h/QrFEshzeEGSo2wxooptZtWFdMppTg5jk3lDP6Ow6tEhwR1664zSRbZlDcwoAVCMcyGAUYjW3BbcE6S+e49XhtlfZ4uSEs5jbLteQkPV8h/KdGxrWROuFrBnmTbx8+Xg/hHO7PIQ7PmpO8rB+BxJTr+qWKW5dDKRnW7TneO4xCNRaEeuDcrBM9zh15umP59peZSNJvcGmbxk3kmjhzK41LdKp0/QH0SazU22fUcIspbR+BmzHTQNwkWg1nr7ey3c6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUp+53SPKeCuGz7fLAVdGKkiKH8oJgol1upT06qOa2g=;
 b=PQcT6941SyPsb0fkTHExZV3L/4ptCzfCq0PSTxTD/TqCXYBGlndnRCyxy5WpLa1+0UD66UtJolOVAAO875+Svt81kYSWBHaRQKJnINVy0gcZ+O8mn23s3/RAiYehEHWpJSr8LFP28TjjupfNRkIc2wpH6YxoGiH9R+mNKzRi0Oc81ekYNMwyQ6xHPkGyhyijA9w3G4zfkTNKBQRyf7UCz/nNnosVXq7cs+cqvnbZXnNxvieRdECODiUosp8aybDpGN6YBbv2P1zDfunNEZsl0uoVWRsnSn0FODPJGshY34MjZwHHS7wVmFYYm38USttBZh0PeNy7NI7J/MYV8/prhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 09:20:28 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 09:20:28 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [net PATCH] net: stmmac: update priv->speed to SPEED_UNKNOWN when link down
Date: Tue, 28 May 2024 17:20:10 +0800
Message-Id: <20240528092010.439089-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::14) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e59872-43a4-4009-0870-08dc7ef76a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|7416005|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?upk4/b5svlGRPBHZBNZbP5zxBW+P9uyvDHSiqca+eeAUPdydNLp/OJxQFqXz?=
 =?us-ascii?Q?4ql+UCVesAHPDo5CTNEN6B4It+Hgm5s1Gry9mBar6JukDoclOvVzRBerDJDj?=
 =?us-ascii?Q?xqTdcPNmw+eOhqpCd3jbHNE14cnCTaVxtXzEQIxl/rrdrs2NySwjmMS2Sst6?=
 =?us-ascii?Q?yyiooBE2PmTZjas9oU+RPd0rTGNS9V9oDAuaCEFyEhv7qzUrTSrbvtxfQlFc?=
 =?us-ascii?Q?iFMIrUn8jJSUYGJ/+iSQwl7U/DCUN+7j8059Dp8zcGO3HRqQC/geQoZGAVPE?=
 =?us-ascii?Q?A2z4n/wpM6sFwdnMaK4pezSninKwUk0iVKIImK8KAD6JkUvR4/I+okKOmcdc?=
 =?us-ascii?Q?cmaMoFp3A9VlG7dgYXX/cDwYoAny2eKTt8spk8yrrpw1JbYymQPy/1KW77fq?=
 =?us-ascii?Q?qBItH2cIIUEPpd1GcF1Iu1Urv66EPnOBXPF/karhbtKFyndqLFHoEO9q82Jx?=
 =?us-ascii?Q?qK9TU0MkXMv/UlDXILMI7+5DoHXUzd6mApDhthl85AAon7bEBwsEaSC2ZoZ3?=
 =?us-ascii?Q?kV+1Y7Hd4a6yRsSjIAKZVMgnFURfnYyEkIV3z5xeDVuvlIIJWKqpsTPzUnaV?=
 =?us-ascii?Q?rwfEeod1IYje8rINU2+sUiGQ9Hm5WNOTnywXhVtuCAFq/PCxEr2uDw+lLKTJ?=
 =?us-ascii?Q?xq8HdHe27j99k5JA5ojYqBiFuv0vDBlhSmxpZXvlcZPlFLuVtS2QspXEgoyA?=
 =?us-ascii?Q?JXMJZDWkqksA2BotRtw+z+2bxmxRbblaIPr3E/DY3o0wjG8DOpkl+EcsorZ5?=
 =?us-ascii?Q?Mwt0/l23dVq8gzlAtSaoxX7oyPov4ykj64lXcN8/HlHSEUqbTcQgv/A10I/l?=
 =?us-ascii?Q?qUBNl0ZZuBtLonvvHnzcINeNxI9CihEOTYbko0I1iXhRx6ntbr6qQJh4wfdW?=
 =?us-ascii?Q?fS/oRpONdJ4hic+qScrOl6obAFLUaeWTGAQngf6BXrb5FiuJhbkdn1//MicV?=
 =?us-ascii?Q?4OY8ztwh6sgucv7b38FX6baqBZ5ujHRYEVilIWhiBcl28NUaCF/h3htULkVu?=
 =?us-ascii?Q?cGC2SOvcSOh3vPtwQ0PDaLibvlsb7aJn2cQvvhMuhMSp023ODFWlHA7dzYKc?=
 =?us-ascii?Q?5zxBDS5nEnuPFhG73vD3vFZHYf1F7EzsGjjXOBy3wfnYm7zWVnfy8ncG20l0?=
 =?us-ascii?Q?O2/haIhNNjrdgVub2rEb3d5OWAvNAr63kDxr1r1l7vaoXalC5MfmLbBgAVm+?=
 =?us-ascii?Q?1z+sd+ReFcR3bOn9umsts3i7jLTMOP1vYWpiOpTl750tKyvhd01Iw4rMXj3b?=
 =?us-ascii?Q?7T4tff+4qccmaCw65saJnSybS3WDrQHSgSo8O++tPBZcIoSc3vO8jPJFLfX+?=
 =?us-ascii?Q?gH4Eefs+5u1ZHcDLDld7FQfHWdzz8F/8/2S1awteNR2BOg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XmycGIsKuRoNnB4jNipsPyX2OAbz1plMOK1iVKxlEd4JhsCukXHxJC2DJb+u?=
 =?us-ascii?Q?0PBCi8ZhpVP39NNWAMLmlYZmQm1mnmvHcaVvftboKjNNebMjeoo2VcZrHgmd?=
 =?us-ascii?Q?dgZUCgBd7Nl+EKkeT/TDBT10kAfn4K9P5IzjLC+4+k0xVeKQb0qGpbpm/MKi?=
 =?us-ascii?Q?h8bpvFtliqV9GfbBx8xJq/0AtNv3nLLSdPflBslSkdp2VL/AmIV2UdAu3S0/?=
 =?us-ascii?Q?/5nzY8vND3rVWK3B5sHDvcYpXrYJ9fYHjZUxiXRZficPL671YQ5ARERe0ji3?=
 =?us-ascii?Q?6KpO6tgTBZ44gRBBMYHEDtR1VWCTdCY9xowz0NrlHxZUH62TgszkZ2sBRiUT?=
 =?us-ascii?Q?qQszYoS6vVb1qlQJbBdpZCn70hXyKmrn+uFrIQFl1RGgPUF5RTOywWo75yFj?=
 =?us-ascii?Q?erXJL/JibMJLTrGdYLO6O8TNfUNONEhMKikSsRQXv/90CVyt22YS5PD8wrII?=
 =?us-ascii?Q?YJvzX0KC+AuB9pBHK3tTg+vISoPoOH1LTeEzvaGC7wNa1dunsHlrApT5RR+H?=
 =?us-ascii?Q?Crn8xFSWiDtyS6Z0qUgCC562LrTKokSyjjkZkjbpX0yb2mKz9bzfZTgXtsG0?=
 =?us-ascii?Q?M5KCtAcxIp41+ob0/tUeduJMtqNJNv6QioUwg5GIYtiwZQ5KZt+cCvDy7SgZ?=
 =?us-ascii?Q?rIIQyfKYs6cJOJmkovYpEPEuXnagVpIto90fI1yuFN26+ZbFcWmFUK/NDLto?=
 =?us-ascii?Q?w1BH1Bj3A+d/nthL+RNzT9nfgpOdUY5aLwHl+gyFmD6cFjqj74JnkS8A84mI?=
 =?us-ascii?Q?Fg7GmlbNQQkaNARzQh2vJvC/alZF40mNJGy7RekFnG9Y/aXXjoMMk8W2Kn6F?=
 =?us-ascii?Q?bAVsw1YKumWuX2PnS/p8ewQlK2rKtJLK9nbLkbg/XZWfiBwrF4+P4sSY3d/W?=
 =?us-ascii?Q?5nfqmf/K2/vAZY8XbufPCVZVd/CoGfQol0qoyU1w2+nx6zs/8FrcWSpfge3N?=
 =?us-ascii?Q?vG885P+SoX+WJmMpArvWvyfrMsoKcaapr2WHfHUr9B2U8lvFAMYSOjaPtZ8P?=
 =?us-ascii?Q?Hrv7BIBtdHXwDL9Et1vmY0l9PV0epVYhoIAXoOtLnP4vLXex3Cb9UKxZYG4k?=
 =?us-ascii?Q?wKvnA+wgc2ZRICQY2XwU7B2FUFRBBNE7ghP8mXc6jPbaWkeIvfoq8+fAsAxe?=
 =?us-ascii?Q?DxJxZvjcjUWWxltS83hcfFH3d3koa3z3GHJ2syviXdxCp/pxZ2KEmUp7pXR4?=
 =?us-ascii?Q?X8pa/dXfNQgR5WMxMnsuEZdXl59ROIIYsoK/D1dwmEjXFsksueeGDdV2rDXl?=
 =?us-ascii?Q?Yfe7PZU2MjjIKZ5CqWlf/0ZbYfg1xSE+XPKELShgFohZX9M1IHWjQlpoKNUu?=
 =?us-ascii?Q?i3m05fN3OQOkGuWQlaoc4NFqchtFpWJdkA5H8mY9t78ZHKzVimTPODJBcmFd?=
 =?us-ascii?Q?gObVv8p1RztTTXxbVHr7NGnZdQQ3kRhPCF5JNh2YFuxq6fKcGBtZjA8Ht209?=
 =?us-ascii?Q?1C0jhF6ixtDXC6w7fvR1XE5d8hvXcoiqt8hr/c4s/I6SpEfhO5/TtSyqTXL7?=
 =?us-ascii?Q?NeCzKbN+sV74A6TmUA4+2JrB63KWVa/EjmCnOAtoo8RAx3EenN4mcr/j4idl?=
 =?us-ascii?Q?vBH/qdj2h5fnla6cF8mffc4zOys2LYFBZBj0ZMqhv/hibpbwWWLU54NXyEZx?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e59872-43a4-4009-0870-08dc7ef76a17
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:20:28.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqjoHqtk8rx3N3MH3anzX9aF4UWo94n0Y7MHVMMkI+j0TeDqiqJxPZZwJrkR5UaUrz6uYSiZWZuCWmqbbrUiSaIMZLir9RZkrSlTyS4ANDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-Proofpoint-ORIG-GUID: KX2Mui1xtmH99k-_Pu95itSaJ1Fx8uN4
X-Proofpoint-GUID: KX2Mui1xtmH99k-_Pu95itSaJ1Fx8uN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_05,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280069

The CBS parameter can still be configured when the port is
currently disconnected and link down. This is unreasonable.
The current speed_div and ptr parameters depend on the negotiated
speed after uplinking. So When the link is down, update priv->speed
to SPEED_UNKNOWN and an error log should be added.

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b3afc7cb7d72..604e2e053852 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -995,6 +995,7 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 	priv->tx_lpi_enabled = false;
 	priv->eee_enabled = stmmac_eee_init(priv);
 	stmmac_set_eee_pls(priv, priv->hw, false);
+	priv->speed = SPEED_UNKNOWN;
 
 	if (priv->dma_cap.fpesel)
 		stmmac_fpe_link_state_handle(priv, false);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 222540b55480..1e60033c6fbb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -378,6 +378,7 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 		speed_div = 100000;
 		break;
 	default:
+		dev_err(priv->device, "Link speed is not known");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.25.1


