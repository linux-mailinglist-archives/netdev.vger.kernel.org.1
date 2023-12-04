Return-Path: <netdev+bounces-53544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEA8803A67
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D84280CFC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494542E624;
	Mon,  4 Dec 2023 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SAolGSb0"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB0E116
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:35:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiGV1PdwDxIKQpZn8WZyxswzgCca5D/86fKuVoykWpVewbhLgAhDcNfipDtZf+w/pHWoBdxtYnx6asQD4dZdBrNxASwAR8FdaZMN/cx6hAHvL/EVgbcPplzM2sAzubN6zBmh+8klaMdOrnPM6HUOaDEeaUtXs78kyZlpACmLaBwbqFYCpYMSWvoobG3BFlWEPZ7jAP0+T8sx6RTLANv4Dc62ozLq/Bav1CXrj+kAnXRJGTKM6dce2okFULfPtI783DXp4pwbusX6EWUma83a6DzbAn08pvR15hDUd06RIhvoILJYP2gv1ecTGpS9um5Gp40f6L7pUnlDclVOfI1CSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqsCAGZLlBi2zZytwNAZrCFJ8Xtc2Q36K3aHPHwTobY=;
 b=JBt0GaC+MgI5Rjzp7wDvZNagvDTHEB9lftw4dEQ+uh72dVkgkfSXXOMNxfSmgZjJoIeix6gyEiLJoXKrNjD+0hHTt4/R2HjV/eFqgTGD3KzCsLl92ET4FEibMuJ6l10H1zrF5wtItyr7IjX8VAAVuzOMaOkiRI5WPqaowuvCcvPD93HTvV7OjmF+9RmFqRPjd3CA1C9Ik3Ktnugt4uqB5R27NvuG+zVKrvaw+e1QcXnHtVR8tsE/xZ4mraxO9yPcUyFHZ+AaP3q5YZqOi07ngJwy5XvQTaIbBoSmM9BTmlszJYzNrGAQ5iQliicKeBmnjfP11CnnpuZtH2fEX1yPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqsCAGZLlBi2zZytwNAZrCFJ8Xtc2Q36K3aHPHwTobY=;
 b=SAolGSb0rOSEiKJDYzsKOTxFZrh2nzKzeYc5FBZbAEqrG8IbLA6HswloIm2veklJ1AgaJ3Lt1Qjvb3QgRtpyVCx4ZH+LKKh/asjj8rAzbW/T1LxoEJppkmB7TW75FIQ0IcEZX0nBY+kFsITSpO0ML+1mrKL0glufCfBhkeBJu8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 16:35:54 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:35:54 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/8] dpaa2-switch: small improvements
Date: Mon,  4 Dec 2023 18:35:20 +0200
Message-Id: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0441.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::10) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 0200093a-df0f-4264-4ea1-08dbf4e715b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e7/7ogejGZ/opBrxK5BK2WCA5vsYXtMWm/9qhwcD0dRRPOqj4ck5aOyB1FzC1TcMC3obDefJTphzZrgghTFaLRbu14l0Vd1EDQ9EQXWtCQzsjgpNoIqeADx39GCX7ONyWpmFKedXJdCcgEJYURX2oonkaPMAKTQcic7cQKjm2kHmvgd6uCAR/7hX+urDTnpRAT/TlpkHkflrjvEIjPOl/pvi+FsDgVGIiKpoRpDMpcmyHRhvgiNg8hnQYfItxvi6Yo/9tkv/9VHNfaG0wqXSVvNhiPLnMPNMs36Ai03ueieM9Gh2T5Qu5ZiMv8b+G38lgRNM6mMUBQ/2CmU+VeaIl3kCmS9C30DprXo8B7ospOBWUiHMroiYEmW5XOeB+0b6ZjLWapKdM08g3Bhlojn6kURDMNZYVWrcU2xavTiwvIe0RSgLGGrX9dSCQI6LiuNrp17WAIzsnAr1F4jZIaeSjjxQHKWhCdS0o/Uk3BjupGj72liZUWE3li8W34Z1FPVkH1k3AizyQHbSVcF2qbWsEem5zSSMIanF6sAl9+eHoF80o4L/tqnOM0UCTO63IgnI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(44832011)(316002)(66946007)(5660300002)(4326008)(8936002)(8676002)(6486002)(38100700002)(83380400001)(86362001)(478600001)(2906002)(6666004)(26005)(2616005)(4744005)(6506007)(6512007)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5TfHyVjACdvle48nwtAmTZ2TSUHQjjqGNdovjJzgxgBEQzTRx9MLmvgFvKm6?=
 =?us-ascii?Q?AmePB97XTp+MYPEcJJfKTXMiDxuSLuZF26YxQ9HO3OYm4+t3oOwqyVZVj0g4?=
 =?us-ascii?Q?qjwpFtKaXT/th17X2ZimCVLytzutE2Wfcg/xVykiuSgvQDlLzW2rxnhxWdG2?=
 =?us-ascii?Q?JCyUEeC3NaUjovgpRbgRz1mz95eTshk2T1SjO1x4JnjkZnbleKZ62HFBcI1g?=
 =?us-ascii?Q?mci6/8JxE2OGWWShi7ixz7YiLKrAsAYKd0Qu1OmoroMStJUZ55hyFYyll8Dn?=
 =?us-ascii?Q?QTNy52zMlo7i4V0p7qpTN5d0EEWu5z87IR591PJFmFf9YPfSKDYoB+23Ta6k?=
 =?us-ascii?Q?RPvov0rRQCdKG7IQYSn5k2lGDviehlvxAgKPKYywwcQP3k6LG2Zn+zdto0+K?=
 =?us-ascii?Q?HSC8+3b4QI6Lzvfq5Y5Aj8AUaVIics8VF0BgE2rYrtGmNvxJDT4BagapaEm6?=
 =?us-ascii?Q?JMQPzQyXvyleZD8+29SM5DLc4WfFMtkn5sFz2V3I/RRvrwW9lV4220i4Zgfv?=
 =?us-ascii?Q?zicALVrreJo8go0azsfd+JW1H/v6lx8tFPMcjF3adCJteVGVPzj0ZMzggbvA?=
 =?us-ascii?Q?bZk8CogGwT0oNGTR5ZLRPNjVs5F7xCORKc6tY6UmtzL5o6GKpoPjeInpeO/J?=
 =?us-ascii?Q?OB+Q5ASoaUjWfWz2xNEEoXvhFuS16c9xadhwe0/nBlx6ngDJsn0VT8fyvMrk?=
 =?us-ascii?Q?ElllGbOlDxpBGKptt2T6jbJ+bCykrxgH3NhsKKiZ16hUyZOn1mp91AKi1auP?=
 =?us-ascii?Q?vHn04sZ7ynz8V5Hupu317EH3UtFiYLyALJQBvlV71ub14qUFmS+bISMHDtha?=
 =?us-ascii?Q?CqQkgSKURMB8Wn2a4Qd4iBsQ7lTUOTgTl5JUf4R2aN3E7xdJ1xmgrgQMZ538?=
 =?us-ascii?Q?tEwnM5xvb2sbFabjz/5BcXnSqht63NRVbUDIy3AfS7fKRxHFokFF+K+cRSC2?=
 =?us-ascii?Q?Lglv9vMRm9dOYImuxddDpdJLW9LjcUY6iti5L3d6k5LcC6yeAPd/Jl5DAsy9?=
 =?us-ascii?Q?dNcxTnW44+QAJoqA7BXKszaPsbGDNcf3VOxDswIdvA3UjEMYVytw4e+r3YE1?=
 =?us-ascii?Q?Bg+Da47eSfrnA1SW4pz4Mug9HJ4NSCgrmHs8VgbH0rlf0gOod4W/pgL3Lckz?=
 =?us-ascii?Q?t78CxWV6Rm2n6pyFOJeioiD9u4kO7kiA7ZzrRLX40Oe2e7V+Ear4iRxHM2JA?=
 =?us-ascii?Q?kQXKrN0iIHBakvOo49/EIU5tlLBpNnqNAn8fniBRCj7esvvse6mQPo1nX54U?=
 =?us-ascii?Q?PFx2PvPOeK1xorOFPYF/Ywv1mLovSCVCdmzGu4jmeeKPm1LcUiF0p/fSJPeI?=
 =?us-ascii?Q?kMYcui/hwxKvnH/1FAhViOMg1xc3EXqKTySLc70/WiSwgIXVK59sKrgSU/ws?=
 =?us-ascii?Q?ioZ7PCERzwUSDwssMJ/i7falNjJ+9LUgFBf4m2xN0gHXTgQ/5TtQV+cNOoe/?=
 =?us-ascii?Q?gKS/kD5EVeOtpcM7kaIh7QO9/gS62D1kObXKyukRe/n9Z+BvBniQldje0Ah1?=
 =?us-ascii?Q?YIs0SOH+S5ejYpf/H82ML7P2gE4dKp1TpAm3Zo5DXVYZwfdpF5AwxVHJHync?=
 =?us-ascii?Q?vni5y3TxMj0i4e/5YkpSv7/WhyWIoE/oGgDz3xrQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0200093a-df0f-4264-4ea1-08dbf4e715b6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:35:54.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFi0ImYpJLUCl8hSHhe5Fa7NU6kVgJdS7mCQGRHGjp9TM6Wj2gLP6E7R/x9wFWvhhpkev9VKI+uydGbWnBAAog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

This patch set consists of a series of small improvements on the
dpaa2-switch driver ranging from adding some more verbosity when
encountering errors to reorganizing code to be easily extensible.

Ioana Ciornei (8):
  dpaa2-switch: set interface MAC address only on endpoint change
  dpaa2-switch: declare the netdev as IFF_LIVE_ADDR_CHANGE capable
  dpaa2-switch: print an error when the vlan is already configured
  dpaa2-switch: add ENDPOINT_CHANGED to the irq_mask
  dpaa2-switch: do not clear any interrupts automatically
  dpaa2-switch: reorganize the [pre]changeupper events
  dpaa2-switch: move a check to the prechangeupper stage
  dpaa2-switch: cleanup the egress flood of an unused FDB

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 131 +++++++++++-------
 1 file changed, 84 insertions(+), 47 deletions(-)

-- 
2.25.1


