Return-Path: <netdev+bounces-140624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B009B7463
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72DDEB21CE5
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 06:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00F5146580;
	Thu, 31 Oct 2024 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lH+z6hae"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42856140360;
	Thu, 31 Oct 2024 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730355482; cv=fail; b=r/7wSD3bAVxHDAh/+tA2w/Fuq9CtvmdZalUNwNH9S6UDONcyRTRwx+T5YWXGN4o89dkwxt479KLXi2kcWIvpftNXL8PhJwsT4vFcWzZbfPT4atlmfBOYN3spM80/tt3Zj+sZ8EO3GKERkFods2S8jiRecraAunAw49vh5Ph4qBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730355482; c=relaxed/simple;
	bh=QQUhpNH2RFZuRLM0zkEViwhzZGzR4PVQ3lV2rVup1Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELhnJxQ9D4TxTtklSsxa8Gq8iQl7MozwGeUOlZCQis4az6pP0AbPDNUqQRcfksNnH8Pfvt5Po8EMahlPtbpophRG1wbMctvSuWsMS73Q6AQIVDdQSQv2ZZ0ZclrPKjctoxYlOSW6Z7qgCXONcIsHsFYz/aDy1Knefm06fFbYo/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lH+z6hae; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/O5UjTtW98wWSEbn8xe0TpgmSLq3T9kg/uAo3US9XbuOVHbKoCdQLMhdMC9lTR6rN0bH0ubW7j2fYydpgZHpXR1Y3mnIfsBjDIb8XFTkPSgig7/gFMcX/qsapQJwEpSEZ1CkRQqwibUwys236gA/v3dTtP2WGfmneNoYsGiD07WJcn1cUQqKiVv7EmwUp+Gn/LAcpawNRoXAmb2ZG69e4W8U3iYE8beiNGDGlK+zSh4+7vQTirFgP9uWRsyJD4heHiFOV9XJrlbeDpi3GdEfyN5gJvNRvqMWEM04KUW7aZBOUR7McEGtlPIUloxfZwyUWx4ugLTC7srzOMiuZxuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylPiioU4F9rnrSo4SBY3quSqGgAN8C2Wq/TnnLrELEE=;
 b=tj9RAwZUNv/qi/uC4EfngiEaBbaFIS6OUSRoh/zowHKgK4tLrR/8d3iANTu9B7WbppjReJDN39uHvFdZFuvoPYKxFGU82HeusFH3kCWwelekBP74oTaCAnOMa4qSOqhqyXH/l8K9qJSBSjQSiujJBLEncm0gCGsU0MdMQq5a1PGVFJuH0PvzU5XE4vN1dd6KnJeZsJ2Xl3ETdr0YHW3TBexXn6Q9mmX6Z1eCadpeYZWAyWMAkl7sXB7PhuEJnFFMkJer2+pYVw/lC+P2M8FC9K43KD55nQyABYtBPGQJ3Ji6RC4UpVp7EcmsvN5/jh/uJS10LX39n8FfT3AnEYRunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylPiioU4F9rnrSo4SBY3quSqGgAN8C2Wq/TnnLrELEE=;
 b=lH+z6haexhDmRVVzW20PhMVHX1/rFcFBsvTJ2DEZOyBlwAwhSuD0xwqbh51ukmCkQ1JR1njBo4EjUVWNx8NzbqS5jfn/JLQNkZjhdiCiXk5Lpnsn5E8ZZ3yjfzMiQlWYhET15MT7g02BaQbxvihteQznhGQgTKhpBWrzWVk9Bw7Uk4iciUoxHP2XJLtiKFW2A9jHGspDp5/jeFK75+paF2rHkAREx4obnno2XKDhsO6ar6Kumap8A9OMYIGQjwOw3cJRJh9uZFq4oGOY75Z8aRHCvmVzGgqh4ATYvUJjy+oZxUFYufNvB1AYmmju8+2482AyfNhELLakN2HOsJwJfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8742.eurprd04.prod.outlook.com (2603:10a6:10:2e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 06:17:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 06:17:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net 1/2] net: enetc: allocate vf_state during PF probes
Date: Thu, 31 Oct 2024 14:02:46 +0800
Message-Id: <20241031060247.1290941-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031060247.1290941-1-wei.fang@nxp.com>
References: <20241031060247.1290941-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 84db34f5-ff0f-45b4-66b8-08dcf973c359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6oReVgPjl26rcHi+VZrT5UzDfvcbOe0h8m5fHzTInP5QR4DwoK4zPnb3Bc5h?=
 =?us-ascii?Q?C/ozxb9O4Sq7K9S5TIT5JeyHbzx6Xv1mP2H/2U0Ai1yyU9IIFnbJGfdc5Lgt?=
 =?us-ascii?Q?5HlxZH5iNMF6BIWvrC1s/8Tm5M7mi0ocVej5V6po56L6BEyzfe9/X21qKXJf?=
 =?us-ascii?Q?i3qXC4tkEF60iUe8wnLHv2Y9g29RvEx/cogPKthhsGz4NwaPcYt1SkrPji1y?=
 =?us-ascii?Q?nuBzIlyILKK3GxO6rmFEe5CvdkuO1UKnnHwBFK/O72p+U7MiPHu+cBURwfYr?=
 =?us-ascii?Q?AfAmnXlTsK4PQ8C1z8tpDv5TsdkEHB1KOZlsduTk/+Y+vR9Irw/n3Xcu/IS/?=
 =?us-ascii?Q?qp/xcYbZDEpbOtyPTXDpEaK12mgqSpCPFYwBAZ8y3pHsoDrv/H9h4T87yyjp?=
 =?us-ascii?Q?hcePa64/qQE5KgKg7ehmGHB0EC/1P+RO4wjC3BJ0SkVNcP8fL8yYhDkGvJy4?=
 =?us-ascii?Q?dM9KMZg4KRi0QtYbUZ1GOn+HtJBOII/xMpp72py0prTVwerx6LgYG+mkqD2k?=
 =?us-ascii?Q?5PfEB+Fw5lfmpcY8Dk7Ue4vMOTYH0G9I9uXWIVPmh/n08isxBFqPKlsjargG?=
 =?us-ascii?Q?Giem+9s/qlFg1G6sTw0sk2Q5C01zVV2o4MZntoHmihvkxtEV4ZzDfFl70BOk?=
 =?us-ascii?Q?6u7ZUZHHZOS6YKsnpW12H/dGhRYYoUGFv3mOI146R9nOjyul2J+APhutTd2u?=
 =?us-ascii?Q?2lhBZ+UAi/2shYJY6zuxoVD0kkvw3Dboj93WnUewGPOjDm7dKJpAOxbqT/CK?=
 =?us-ascii?Q?/cxJA50G4U0qWz6KndqxCKLifHw7yFm5ZKawyanDqWlsPCmEagMbUYQ+psFz?=
 =?us-ascii?Q?Obx0lR99NknMbMPClxBEeyN80I+381HWs06CWtASmeevqMt3mOxJeH7NULUC?=
 =?us-ascii?Q?pZ4siuSXGH04s2nDe6dRcDtDWy/So5/N7p3EKdWwvXZ8XtkIlpbDGZb0i9Bx?=
 =?us-ascii?Q?dGFaznU6AKB8Qdh7M6KuHe5tT8RC05FrQ/9iq22CheYBxXTHF5jQLFjvGJbB?=
 =?us-ascii?Q?eEGsDypOIU0B9Ch95hoA5MD0jmTxeIuoT+TI9P5S+KSYyMz8hxopo7yx03NL?=
 =?us-ascii?Q?Y1uL4zHPmvKd1PNwBqmjcUDqSZK27AMoIQv+TKJYPu5X1AiHYzn4ma++Uy6j?=
 =?us-ascii?Q?sUxyIhDyXCiL7LufzS1CUfC9hdc9BE5aX6WAHjEdTowmAKi+cmoGx5yfq/op?=
 =?us-ascii?Q?wUUxbJvXuSoDHi1db3RF45i34QX+MFgqduLpliP6d3j527YbVNt8FcxgD6pQ?=
 =?us-ascii?Q?OTiG9AffRvrP7VbdFps7Y71q8V43RKpITC2xv9+DZrtCpfM5/svDVmBtan5G?=
 =?us-ascii?Q?O15E3+V93FAmg/3nDHXdDmqwf989YMPN9xURsaM+a9lTl9F5dVMBG7IUA/d0?=
 =?us-ascii?Q?iqE9V1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPLsi/wYeeVfIJb+88cGdTNIZ1SjgMQpAl1D/xLDJedq5bfqchaaBkgliFja?=
 =?us-ascii?Q?wuKiUJBOFRI1OssWCielN/ZAzx+wpbFQe5UHijZNQq+ytEVwnCw8axWyf6iy?=
 =?us-ascii?Q?lGlE+A3J9LMGi2Wweb3tm7wQG0DkiCuJbwVMCTOGdtdsmA4kBpP2ZcXXMAfZ?=
 =?us-ascii?Q?fc62Q0Ia9TWDopK8z1jPyfH9z/wX1/Jt3R/p55x4GFN7sGQ26RObWeNVn+qP?=
 =?us-ascii?Q?QxmMC7zRmE92RKqFjJLweXk/ArMt1ePRQk4jSGn/dUdmPRiU7ylWoK/FrWxb?=
 =?us-ascii?Q?SGmkjcAiLpPu842SfHE6sePpfz1zs20NL5dw9U6ccSmmK6U+YJS94sVd48Wf?=
 =?us-ascii?Q?hlII828uIkyi7Zm2PND4d5uUs7peMDTaHDNZR9bnSy4HLYjW7GI6c5isiiQL?=
 =?us-ascii?Q?UvLIq+RKNis5r+3jI7Sgi9MjyfFdW5tUfmscPMHdO2rCxAyGgq1spJ8cqFY2?=
 =?us-ascii?Q?FQ750c0+C3Of/gzUnkXY9qufRPTf42c1NEdJU6GZbIM33A9Nexkd+G2TpSDU?=
 =?us-ascii?Q?9BSyvx8m4klPyOc+XVbAvafVvsU7rz/lDvgk2C7ujfZvUR+yOjD6i7Y/NwmU?=
 =?us-ascii?Q?sI/pOQJTs4T3BZamATsksaIjWTZ5oleEHlxoNXJh7NkGXHavIGQHg1kBPVDN?=
 =?us-ascii?Q?5vm/CPMfKZNuSNDBT4Kdc+Y4z+vwhA06BkxG8idtQvdEjInMwT6UU9OHs8Ve?=
 =?us-ascii?Q?fJPeuAONozy5KlxgkWj3Aj8nkwx0S73Id4y/T+Ehf4d/ZFSIOqT/ZLGz4rwK?=
 =?us-ascii?Q?KTVYw9HM13byaeoSgdP4BW2303mQdbXtCEqA1ac15cqVp+M2V+5TpS2MFho6?=
 =?us-ascii?Q?xOwAz+NN2dRUFShkjwoZr/I5JL7d6g/aBzujaALL8nMeKZ9inbZxOlKOFr/p?=
 =?us-ascii?Q?3UQPwVk5QSWN9DryV/jb3chvV4laMrAHdOEnvVN6LteFPi8JCa4Ftkdm6OrM?=
 =?us-ascii?Q?3oGc3mbJtfSK26bRwWrX/m/4otKmAuhyQDwNIlCITlxeTqpiYmSpFXvram+p?=
 =?us-ascii?Q?6A/H7nybCWZjqa0R0oHmiUn96IIeuobJBnmPQRxdFu3XlkAqjm9RKwrcCIh9?=
 =?us-ascii?Q?eaI2zOY+u42imQ/zOspLDnfIern8WcnmEP2AjKyGmKKV3pfUuUWp3hIDHI1I?=
 =?us-ascii?Q?VXZxS6/16zfIEd/9BARAZqOSnhr9TgwOgkOcnw8cBMxbZ9YAWtlDFAcJw1GC?=
 =?us-ascii?Q?XVpN7UeNg4iAOLNrMuEYq1H/lrtbTzmy2rS6NtIqCm/MyDZUMPwdGzLspVpC?=
 =?us-ascii?Q?CZ66IOtDS95nTOi4jw1O1L+LxJDHwbU/MNRCf4VsaymcElua+PIgNcKmmKNg?=
 =?us-ascii?Q?+c1Qf1OlX4AMGysWVFbtVWUf1/SApyrUxaQygvvKF0j2y7GvCv4NqL6hPO3D?=
 =?us-ascii?Q?8wFgkboG16F7vd5kxJZXhndsIz6IzVzRVFQ0AxseicOPVfhh7eLw6deUaiCi?=
 =?us-ascii?Q?YwlWCkpCrG4J1aQAJ8LS9YySVAPHuqFBVBKlsXNKfg+4izxZntTsYM9jw1Bw?=
 =?us-ascii?Q?oRoESPSBwhiOgRR3CDKHP/IlZhn+kjp6K+S26fAdc2LPYJA+63vbX2FCxOiZ?=
 =?us-ascii?Q?mdJj8jW6M9jZIYOEdOZqWgS4G5E8yGUIjbNCM8Vw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84db34f5-ff0f-45b4-66b8-08dcf973c359
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 06:17:57.6827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKQzUOw0uQ3hKZ/pWuYc6tU38fr7G2K/e2wWF3KoXl7k4sIqZ2eervXiZl4ePhPzzViH18LOwu6drAdePU9LEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8742

In the previous implementation, vf_state is allocated memory only when VF
is enabled. However, net_device_ops::ndo_set_vf_mac() may be called before
VF is enabled to configure the MAC address of VF. If this is the case,
enetc_pf_set_vf_mac() will access vf_state, resulting in access to a null
pointer. The simplified error log is as follows.

root@ls1028ardb:~# ip link set eno0 vf 1 mac 00:0c:e7:66:77:89
[  173.543315] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
[  173.637254] pc : enetc_pf_set_vf_mac+0x3c/0x80 Message from sy
[  173.641973] lr : do_setlink+0x4a8/0xec8
[  173.732292] Call trace:
[  173.734740]  enetc_pf_set_vf_mac+0x3c/0x80
[  173.738847]  __rtnl_newlink+0x530/0x89c
[  173.742692]  rtnl_newlink+0x50/0x7c
[  173.746189]  rtnetlink_rcv_msg+0x128/0x390
[  173.750298]  netlink_rcv_skb+0x60/0x130
[  173.754145]  rtnetlink_rcv+0x18/0x24
[  173.757731]  netlink_unicast+0x318/0x380
[  173.761665]  netlink_sendmsg+0x17c/0x3c8

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 8f6b0bf48139..c95a7c083b0f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -665,19 +665,11 @@ static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 
 	if (!num_vfs) {
 		enetc_msg_psi_free(pf);
-		kfree(pf->vf_state);
 		pf->num_vfs = 0;
 		pci_disable_sriov(pdev);
 	} else {
 		pf->num_vfs = num_vfs;
 
-		pf->vf_state = kcalloc(num_vfs, sizeof(struct enetc_vf_state),
-				       GFP_KERNEL);
-		if (!pf->vf_state) {
-			pf->num_vfs = 0;
-			return -ENOMEM;
-		}
-
 		err = enetc_msg_psi_init(pf);
 		if (err) {
 			dev_err(&pdev->dev, "enetc_msg_psi_init (%d)\n", err);
@@ -696,7 +688,6 @@ static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 err_en_sriov:
 	enetc_msg_psi_free(pf);
 err_msg_psi:
-	kfree(pf->vf_state);
 	pf->num_vfs = 0;
 
 	return err;
@@ -1286,6 +1277,12 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	pf = enetc_si_priv(si);
 	pf->si = si;
 	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
+	if (pf->total_vfs) {
+		pf->vf_state = kcalloc(pf->total_vfs, sizeof(struct enetc_vf_state),
+				       GFP_KERNEL);
+		if (!pf->vf_state)
+			goto err_alloc_vf_state;
+	}
 
 	err = enetc_setup_mac_addresses(node, pf);
 	if (err)
@@ -1363,6 +1360,8 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	free_netdev(ndev);
 err_alloc_netdev:
 err_setup_mac_addresses:
+	kfree(pf->vf_state);
+err_alloc_vf_state:
 	enetc_psi_destroy(pdev);
 err_psi_create:
 	return err;
@@ -1389,6 +1388,7 @@ static void enetc_pf_remove(struct pci_dev *pdev)
 	enetc_free_si_resources(priv);
 
 	free_netdev(si->ndev);
+	kfree(pf->vf_state);
 
 	enetc_psi_destroy(pdev);
 }
-- 
2.34.1


