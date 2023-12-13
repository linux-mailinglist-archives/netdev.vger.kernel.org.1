Return-Path: <netdev+bounces-56869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A668110D6
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C4BB20D3C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64428E17;
	Wed, 13 Dec 2023 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jVOyBCto"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D64E4
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nadpm9S46+7BknenRHHvfIzN/VAONoiHPyKBK54ZT8G+ERP8iTDVGlXqVdDYBNDrIuoElsHoxif7cHh34zupYAJJ7iUCPRygr+o5k1KDgiPR1u6OG4wZxbow/rlQ+EdKV2wEOSmxcBZFWcOSIXxSN2d/nExhPYT9UY94UkfT1iRpdA8XqYll6Dlb+FMJkoArBNsnmk+eZDVnfSVFQZmTIw5lY3MCaPMHAufpnXxNTPQR9ulWScMJXCn1inF5a5Q7BavZyYUB93M08HmzFkPpC/36b4H1JPXko/Bj7DYsPbf+Lra4yhRBubM3gl7qTorAzSkbs7/aNMNnH0qan/ZosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXFL2vD03rJQ6YlgqSdPcE9cZu50QTyLqhNqXfEgCaE=;
 b=DDTWtviUodr0YH7dGbWj8gkr27B2I45aF4rzjABCpCj4HKRMV0hGSaQqx8GbcPGDI7s01mylZEOsDmxVdJrqTzaHS8KP4aqU8vw4iDVbavKHcB6h0iz7Nc22HIRa/uPp86RtRX0Og3SfUs5jQ194tmhKPE+/COZFqtBXx+o/s7TfD6gzRgeLzbcGBCSBGMTzQ42kwU74Ss/Y/7+WThzyYVqCnCIrbOjmMaasctPnugyqUUjeUuJzQEHc4+Pbs5V/opTDoBxIV6i8WnyirOX+k6itsp090EMM0o/kl75rekFjciMJl6gWSJXDTX9N0DrfOVJ86w0/59yvF8xg8CjqUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXFL2vD03rJQ6YlgqSdPcE9cZu50QTyLqhNqXfEgCaE=;
 b=jVOyBCtoaU1gwtMYySK1lMJQ+frqU4QIo3aXMPFnhP080z66W/aAORuyiyjjNSYhSSS9AEkz2k8MDNyMrH+a1An/xbkARhnXjX5kn7Lcg3X23giRDNkdnoMUcRQqUN0OBHJrDnoMfIxVWV3E+EkITvuHcbLNBExNrlxCxdzWxWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:15:42 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 12:15:42 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v2 2/8] dpaa2-switch: declare the netdev as IFF_LIVE_ADDR_CHANGE capable
Date: Wed, 13 Dec 2023 14:14:05 +0200
Message-Id: <20231213121411.3091597-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0089.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::30) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f60671b-7030-4822-f490-08dbfbd53a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dNXpD7MOav+dK2A7p+uGJ1WPQZGqpKhWl0EkmyDmOxztSEsdxG3ygW8kIbuKeX7lk7e/9gBh/g8Yt2QFccZn3cretahLLgh73/7a2YK4gNj8Rv/+D/UPUMTJGyTTWB26c3ZGy6XXEmKrbMKomW8nDs5ltiIftmd345TZPU8QuNO4tUMVIb0OqhlMn8+CtX+RjGJHnu60sRZJVpoND8/yvwDQ9Y5rxEL+jXAZrEMVaycaGdEd32pg6eJoxN2B8+s819nU6vYEGj8Giv7gX1+gn6RA3zepexrerfbHehwTf0uMo4aejU9cEYsaANfq+NaUF/de2TAcq0cTnSqFBy5Orytw6SGSXL8cuW/f2v3Toeqam3dpZnB2UC4R2Bb8vYaaOE7uiORQdisnPXVrRORBEDQAdPHNHVYipLk+ahTdStzdSlAuzWpti4Etjap/HGfphSgvb9bq/LkT3slxWjdNafaCPpApQBDx5rPCpZm2yQ9iEx/n0RJTmQ3xJ7Q6mgKJCNvSa33aD1wJZQzwgOKrjaC9K+ThWzToKmk/G5JEh6X8/3trv4T1ti3Xs9j20WE/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(2616005)(1076003)(86362001)(6666004)(6506007)(6512007)(66946007)(6486002)(44832011)(478600001)(4326008)(8936002)(8676002)(36756003)(5660300002)(41300700001)(4744005)(2906002)(38100700002)(66476007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CtX/EMVVC8tP8FQxThAEO2gazU7IrmPiaq6t/HKb0TqiCrVPwWF5sPqdhcIY?=
 =?us-ascii?Q?c/Pt9R/s2g+j1GVUYHr2PnLYKxqrWz4Nx1sSHB9IVWI1rcJM3XiAHj9Rlpc0?=
 =?us-ascii?Q?zP6/IG6kQ6wa3fPTHS4uy6GDeUt2IrdOy8fFCXPeYm23WIlmdjRhPQAvXxzB?=
 =?us-ascii?Q?k9UpvuCZ50P+p28mgKauOh0fsX0Wi28k+RjLLn4rpKmhMS8r8q2gHUs5qcd/?=
 =?us-ascii?Q?qaM8T1mP4Smoi7PCF6jI6UejBJQiOorFjZhlrh77cazVxijK0uilLJKKm20w?=
 =?us-ascii?Q?9GLOf8p3AUX4DhxQIsGwnaCPB9xuoINZjzY+YuEscXuqufB1muagRRjaxO71?=
 =?us-ascii?Q?ev0fiNpwIOM2ytSZkzdlFm11P+X9mP3zp0YJQ2NZHprYSQJdkF3YLcjrk2uk?=
 =?us-ascii?Q?Ghl4D0Xcck9tMgd/3iin9X2RC5kqVcJHZ5+bJ9pzod2gZF/SvttK0PaOVnIV?=
 =?us-ascii?Q?wKdjDIEj7KTTtUhZna6rmtOr/4m3vE99gYcALcoCUdeTCl2V2PAYZM5EC497?=
 =?us-ascii?Q?1FM79qGWPoH+a9HeHnmhYLTBifYxS6Un2d5NxgwRvB1MNGCcqJX8yp3kgFo8?=
 =?us-ascii?Q?OACgzvvZAfvZyQYP54HQClTNijTcQ9SJgK9SGBDQ3Xfwcxn6bWHJRghCReyg?=
 =?us-ascii?Q?pO9E9uHQd+FfDqO9mJ+WBSlcs5EzIVCZC17qRMTnNG0vDRt670/hvVSOwAnG?=
 =?us-ascii?Q?1jA/Pv3SfWF3Q0psqtk8O5HFdG086t5gb0CdMzmvBFAxc/d8RciF/rIcPnen?=
 =?us-ascii?Q?AVsw+QYBDbfMKBzm+Hxk3s34DYDPw76/YROhBqk0x1ijrThsjhw4Rs8B9ZmG?=
 =?us-ascii?Q?GbgHo5PC1YqG41AZSHxfPiqs6ZpNQiJfRrlzqnnSt5uv+WoWHwpGltDaw5ZS?=
 =?us-ascii?Q?5lkLYtW34Hbto6r0R/mavpgzAjNVC22xcIMZpEdSqZv0hbOwsVNxj936OK4D?=
 =?us-ascii?Q?4gbS7e/YvcfTpjFCWkCemDAEerEnaxal5NObS4KWFIKjMlDd++g8ogJ8n2aQ?=
 =?us-ascii?Q?uhgGuI6TEO4VcTkiDgAqcIb8GXe3XMT1Sw1Da7zgKsG7O2bdXZOM4UkIaaMx?=
 =?us-ascii?Q?543Otc0NW89FgOUg7WjZZxLFqM3A4TpPLscSeI+bzVo9lOUU3w2gPlYu406m?=
 =?us-ascii?Q?3JFl4fSqx5PwRgJwc7SCJVF75ABKdpxioRweJ09mDCejUjNhd9aOjbQC62YP?=
 =?us-ascii?Q?y6rNazcL3VeTPcdL24yIqG+QRCKmWbn87pvtkk0J9njbCFrm8WHQ66PVd2vu?=
 =?us-ascii?Q?NKoVWjlCuoo4gVOVTMgz8CxvUZ2By7CWYas++/2ZuHScoq2JRHnkqVGn9/pb?=
 =?us-ascii?Q?dlMJUJw4w67Qs/SEx4cEdemdHNUG0V5TUNGIMtUPsv57DBXAGc9uiRJQnuy+?=
 =?us-ascii?Q?t+GH15b33lHfgqnwOg7O6dttzuGlA9CACNakxeIhc4Tf0fkA4WDszU81zf0A?=
 =?us-ascii?Q?AX+bE0vYvFoNY5uywIyjB/6G69+q4pfYU5h7jGB9xDAnxWp2BCHNPu4g8pLL?=
 =?us-ascii?Q?u7UKXlzaBAb5g2ZrGmscrYlf5bKsKfxsNLt59nP/m1Iy0EFNxgaFRNWR4L3O?=
 =?us-ascii?Q?+5iNExaqE1QcgTmdDP2c6Lws7cCi/lMDKopopRru?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f60671b-7030-4822-f490-08dbfbd53a11
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:15:42.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFoybuLEIpfdNuQW3JVBZvU86CYBOwGcXgVSH0ccKZ6fiHdWd3z0cCBBDPl9Uyh7t7jGHdCLQwWfsm9OMH5ZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

There is no restriction around the change of the MAC address on the
switch ports, thus declare the interface netdevs IFF_LIVE_ADDR_CHANGE
capable.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 08a4d64c1c7d..5b0ab06b40a7 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3300,6 +3300,7 @@ static int dpaa2_switch_probe_port(struct ethsw_core *ethsw,
 	port_netdev->features = NETIF_F_HW_VLAN_CTAG_FILTER |
 				NETIF_F_HW_VLAN_STAG_FILTER |
 				NETIF_F_HW_TC;
+	port_netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	err = dpaa2_switch_port_init(port_priv, port_idx);
 	if (err)
-- 
2.34.1


