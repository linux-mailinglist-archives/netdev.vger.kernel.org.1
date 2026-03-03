Return-Path: <netdev+bounces-263115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCmwJfS3pmk7TAAAu9opvQ
	(envelope-from <netdev+bounces-263115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:29:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 311271ECAA5
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 510BE3027E36
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 10:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600A6394784;
	Tue,  3 Mar 2026 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KVhBMMRh"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6138944C;
	Tue,  3 Mar 2026 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533746; cv=fail; b=doloRIyXAUcLL7Zk/fPiPCIAsVwQen80vWjnYgYPfEs58MZKPezfy/Hvdbgd8dkZfClSKazSDbnf5BYQBoPFXPiL/ns1qILkBYiX7eZ2xL1V3BoCLopa7yy50n3jGaCNyvRdziPGpRzjzpyoJxUqqLQSeNP8FO8EiR3rRBd5U0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533746; c=relaxed/simple;
	bh=elQ3Ay8M6ZyF7zAgOU/3DYKps0JJlFbGTOmuuRqbPAg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Wjlez04Ji6oE3/7Dek7Ix2zvTdbvfRpb7e1kvE5PDD5uUk1sIgHt+eAL13vapFGhsMDLA+UZ58h3Qeoel01qdSuAjg7M+yD+953txdGApdLDYfDSI1l1pkM5/HDlTGHPNOKyPBy+SlZw7p2kz2wndvUX9C7CmNTfNnaQe2/SRXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KVhBMMRh; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNhDWmz3N4ulGMcWqn6Pke1WMcHQNJqng+tUvwSDOKR5cyNTSIED9xGLr8GlVpNHH7C8bEFrMgkMZRdEPG4AEEHqqpD96Fw82M74Wip2qz3KTzSGCzLDlWOAEnTlsuDoURPKkipWioHApK7q4l3rehZemKLD8HMdZBdN4rLfOhFVRTUdgkkwAYfwLbrGtpkK+EUh+QbsczJabCIb33wtah685TzxIsCGwhYwyddJmYfpTSJVil0PhCbpNvuY8dRx9mKE93GDhbRoOv4susIN1CJA5R2QEpmwTdzDECKg0g+ZDr4Lfj6O8+cNXnaVjsW6DvbnmSVDM4zbnkA00Pg+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZO7ZlRKMMK81EKYWAJmQzoF7UBTFZ+HAcBQxbz4gQE=;
 b=ljPLp5NAn4x/DTrIBKYRtdHt6bUEUydUUzSZB5TEGI01KBzHmJxEYr/hKdaU5l8iXDNRmhP6tZjAlGW7cpziH4GEz3WLd6rOIxHv6taxtbbuJ4HU1ggVtVku6Kr/tlXRm4nMpRejXq467suDu/t9whgl33JUlpvfRB82XC54QQIYzEX6/oIA0G4acvbM2YYHASzRmg14SR/X4OKAOuO94TrYUwDN9cV3tZFcCAzQzGLmQ+mdy3OcIzNJ9SyRvkOAY6RsIkjK/6c2CEKkPi8mU3PFJMpbpuPqMXsFV//gsTt3ms8YUbK7mQ0jqBx4OjAFQ9wyC9AsG0SPygoqeIfZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZO7ZlRKMMK81EKYWAJmQzoF7UBTFZ+HAcBQxbz4gQE=;
 b=KVhBMMRhb2jfXNikrhj5Cpvto063s25qy5+dt0K8I01/2Der9fmNfbox60weEMmattbk/QIIlDVnk8vVhN1TO62MivBYu/RyFoZJ0MnXz0fDR9cSS6d2jwU3sl+ATLJELZLXFtOQS6FGWBebLShd2nxC5ye7y6JqC64IENGwutov2l71kr7XcCocjcG5g6XuczG5WBJRprr5+XtQ8wfwQzo8YqDk99zaU60NE0jfwulL25bRDFWb+sMmG4NnkZII9q8IQRTQfc/HkM4Fmp5Jl/zJ9POdAeCzKZyfZZYw425lZvb/SrELwbhSt3sQjGHDIaiSjcFHF428F0MSXjOCtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11906.eurprd04.prod.outlook.com (2603:10a6:10:61b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Tue, 3 Mar
 2026 10:29:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 10:29:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexander.stein@ew.tq-group.com
Cc: aziz.sellami@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] net: enetc: fix fallback PHY address handling and do not skip setting for addr 0
Date: Tue,  3 Mar 2026 18:30:47 +0800
Message-Id: <20260303103047.228005-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::13)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11906:EE_
X-MS-Office365-Filtering-Correlation-Id: 04822dee-90b0-4680-4776-08de790faf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	LxsZsL1sUpYCTYeuYWz9IPvg1AyYd8oiXn1THiTaSyuXN9iTvSruMmxHtRg6JWyr14L/cw7kN2OcNg1aaWR+NFb1xxyWY9tT686YfaavxS/5gbNyWM9SOIkokBHw+wtGGZDLRnHmaS2PbXOjKzQeOQXzFtuq9/DJ9tmdGkfY/mZJY90IiBklXhrIsA7TCzjtNMGvYbl2xJU//0M0t2E+0u/QsyLPbat66YG+OHDdfWpnAy2XqayRKkM4IBpgmwKHTkaUsc6lRF4PV7JH5TADTLfM+onSsroE/mL+9n8xMVcjtHZglLuBId3gjAAXUwCeT7LK3jLJyOT1/4PO/zvExgsxxEJ1pg1ozbVVVRB4KTmgUE59QcrmPmE4bqbSYoPDNdWxiMBSOyecO/Wn/va5UR2JWsPq9F1SlmDAmLf9W3cOd5F0EaYzQ63TxQNART5GB49iaETdGJnZ1lbKMWDIQ4ddGApvxb84gkOIOto0htvJmc99SBELb5TQbOOhzppAPmgWRRCbtP5KsVlOR8nbGpZslFqa7DMsgyduvrKIvkNIqcvzfJiR++FwFhDsX0ghGzPg2oy7WRwG+N7EaROsn0IwOtg8/G1vxN4f0KSLy4rOZea6hQ6U/mZDKSBQY68vPYehHDLxzqI7DBeOcpTGUHi0zgD1hibCirses73TrEpkIs9kHdHc4DhuFkOT2IQ5a1DzU8gciQ5g7p0EqxaTjQj5iXcIHbH3Sqdg9PNDSx08dFycJ/F2hdCu7CrE+mpovpdx8ZVFgqBrq0ELKRlEIyz0AHIF6CiSkcgteSU2XLI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nl24MQ2XOMbPEYLCwHE6cQSqpeQH7j8WKiHsK3Y1ZihHkCDnw2e2hXkj4Y9U?=
 =?us-ascii?Q?BsVvW2tD78FYz0jYZYrhMy1c9/+8mTL17gipUsSJC4oVd9PmtFTFQ30rOy70?=
 =?us-ascii?Q?rLLlW3KRU7eS/WaYvHab63adI8Tz3YYrQtjKpLqAlk6hGEJz6r8aMRcb/+UT?=
 =?us-ascii?Q?+FGhZOdxxDb5vx8PbcqDiXONF04Eg5bi0IhRTqIsywCb3v7acp7a2oRRm6Qi?=
 =?us-ascii?Q?cMVMOfhDbU0CRIgSa3eQFCE6qTHoZaDiT24IYBg3Ii+w+9Y18tScMdfHNYc9?=
 =?us-ascii?Q?K1Dj3jJXzb+rGiGDDn+pgLCDFTO1q6MxIDy6+a22eGmDrAwtud0jIK8KcafR?=
 =?us-ascii?Q?GFNJir+KG53GHM79hTQZIzJHo2Jbo8cHWFIpgqlVC7rYCEl2NmFeDAxZoqvo?=
 =?us-ascii?Q?Z1N3xBOuUkA1WJgSLnm6t/xgKrs+a4ZpwsGe4hi+RurBu6zwmuvtDt/Jr633?=
 =?us-ascii?Q?KhFKi98WcJT/fLksJpvSEvMm9MvE5cUfVTu8OyP3DsYwsj+nPmwsYCMrGoMf?=
 =?us-ascii?Q?cpX3xg9584QUSi5mPw3PeKLNtyrJj8CXcgSRqviTZ8zkm9z8dejyM1Z9vuTA?=
 =?us-ascii?Q?QMBDGR9r4fenaitjyd21tTcJK+dMyfMZ0+t0biRThr0jAIzxkRV+TVSuz9VZ?=
 =?us-ascii?Q?HfCTDN6o24P3BbtPBbVs2MHefBVLdogwl5PJHDJYpcLDuHd3oHLPcTyOxNKs?=
 =?us-ascii?Q?/uCz4CcDvmdaJ5pL/GPYibEXd6oI+CAuAJU8P3ExtltpRRfrBn6L6LSxTl23?=
 =?us-ascii?Q?FFCOpsul7bSx0AYuaC9keVzGjlcThj592RG9HP74We5BgllEbz7Z+BIF4nOI?=
 =?us-ascii?Q?AbvBiJkhIDYm+yUUaN855brCEk37F7m2J2hrU8/c6Qcc2PQH483BZsO52ktS?=
 =?us-ascii?Q?3UnwNbEkwI9UhVRVPHjF3UDmfMsqlswQwWEmNrszqdlgFBzsU1rdp09B1o89?=
 =?us-ascii?Q?UTzkdxz78nFqQ1z1rb3Rx3M8i3o38czqee0JLwv7ShMzoB0Osk1OsAhVMe65?=
 =?us-ascii?Q?gxMGTsDipy1KRvslt67b8g7AyY7dEbJlIy4OvOPcNOPYp6eRwznRXD7RNqcp?=
 =?us-ascii?Q?+rTry7hJC3ZEpWrauH3YYUviBBe98p1U2tKp7b7/a/fOGkFNkA3nVUklqKC1?=
 =?us-ascii?Q?J/hdiBioe9bmxE8MR5vI31oZwWAqUjmNk2SQBm9jd12gS7z/QdTRDfZnRZq9?=
 =?us-ascii?Q?fpFi66c5jheQa49cAajTP45rKoev9vfdfcjqiM2rkBxot7aUfPiGKK1uXJwy?=
 =?us-ascii?Q?thk32weGPwDKK2jN802ph5NS3Qept4760tmKqqdVAkrfvbpsWAtjgqeJtwdR?=
 =?us-ascii?Q?vU8f3Kq2gxOXhfqFgRO6bqNxR9kZMpF+oD38LGJW1xEE4DaqhFXuAEYV8SEF?=
 =?us-ascii?Q?3wGfoFwy+kfpQDSODqHfeq0qHmHJs6hceb60wf9dG5Qsp9Zv/XZD8QHve+tQ?=
 =?us-ascii?Q?mzpLOd2vZ08q/yYs7E+CUiT1x5IpfMlgxge8wOhGsZsxfyiaUxNL/jXpn/u0?=
 =?us-ascii?Q?LklX0F9pyOi/hnpXwYxXgwK2HBSANYH9zqD/4CGDd2endSVLBDfCG889UDvf?=
 =?us-ascii?Q?PbCODILKL3sgSsv3eT/ZGy95UHfDRWTwZ8PjbijaSIEkJPYLvfSaXmXtEzJj?=
 =?us-ascii?Q?AwSoF49CZkKpFUyFqhse4bjL6y2OledMHhqE01WMBfrHfRZ1t/OP63WqRkep?=
 =?us-ascii?Q?gP9KZCzPPgbye4Tn3pf4L6XqMtrrQwK5SlZCLpVbjd7hRbi+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04822dee-90b0-4680-4776-08de790faf98
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:29:01.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiUlBPbNVre3QFPhhp6yKkyzfDqzKNDXOWbOgUAjjPSrjsQ+na2O9fReb8Tgu+vrdMuycLecfQbIkTsXB1/JPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11906
X-Rspamd-Queue-Id: 311271ECAA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263115-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid,tq-group.com:email]
X-Rspamd-Action: no action

The current netc_get_phy_addr() implementation falls back to PHY address
0 when the "mdio" node or any PHY child node is missing. On i.MX95, this
causes failures when a real PHY is actually assigned address 0 and is
managed through the EMDIO interface, the bit 0 of phy_mask becomes set,
leading imx95_enetc_mdio_phyaddr_config() to return an error, and the
netc_blk_ctrl driver probe subsequently fails. Fix this by returning
-ENODEV when neither an "mdio" node nor any PHY node is present.

Given that some platforms may use PHY address 0 (I suppose the PHY may
not treat address 0 as a broadcast address or default response address).
It is possible for some boards to connect multiple PHYs to a single
ENETC MAC, for example:

  - a SGMII PHY with a non-zero address (selected via DTS_A)
  - a RGMII PHY with address 0 (selected via DTS_B)

For the case where the ENETC port MDIO is used to manage the PHY, when
switching from DTS_A to DTS_B via soft reboot, LaBCR[MDIO_PHYAD_PRTAD]
must be updated to 0 because the NETCMIX block is not reset during soft
reboot. However, the current driver explicitly skips configuring address
0, which leaves the hardware in an inconsistent state.

Therefore, remove the special-case skip of PHY address 0 so that valid
configurations using address 0 are properly supported.

Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Closes: https://lore.kernel.org/all/7825188.GXAFRqVoOG@steina-w
Fixes: 6633df05f3ad ("net: enetc: set the external PHY address in IERB for port MDIO usage")
Fixes: 50bfd9c06f0f ("net: enetc: set external PHY address in IERB for i.MX94 ENETC")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 7fd39f895290..92a0f824dae7 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -333,11 +333,13 @@ static int netc_get_phy_addr(struct device_node *np)
 
 	mdio_node = of_get_child_by_name(np, "mdio");
 	if (!mdio_node)
-		return 0;
+		return -ENODEV;
 
 	phy_node = of_get_next_child(mdio_node, NULL);
-	if (!phy_node)
+	if (!phy_node) {
+		err = -ENODEV;
 		goto of_put_mdio_node;
+	}
 
 	err = of_property_read_u32(phy_node, "reg", &addr);
 	if (err)
@@ -423,6 +425,9 @@ static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
 
 			addr = netc_get_phy_addr(gchild);
 			if (addr < 0) {
+				if (addr == -ENODEV)
+					continue;
+
 				dev_err(dev, "Failed to get PHY address\n");
 				return addr;
 			}
@@ -433,12 +438,6 @@ static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
 				return -EINVAL;
 			}
 
-			/* The default value of LaBCR[MDIO_PHYAD_PRTAD ] is
-			 * 0, so no need to set the register.
-			 */
-			if (!addr)
-				continue;
-
 			switch (bus_devfn) {
 			case IMX95_ENETC0_BUS_DEVFN:
 				netc_reg_write(priv->ierb, IERB_LBCR(0),
@@ -578,16 +577,13 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
 
 	addr = netc_get_phy_addr(np);
 	if (addr < 0) {
+		if (addr == -ENODEV)
+			return 0;
+
 		dev_err(dev, "Failed to get PHY address\n");
 		return addr;
 	}
 
-	/* The default value of LaBCR[MDIO_PHYAD_PRTAD] is 0,
-	 * so no need to set the register.
-	 */
-	if (!addr)
-		return 0;
-
 	if (phy_mask & BIT(addr)) {
 		dev_err(dev,
 			"Find same PHY address in EMDIO and ENETC node\n");
-- 
2.34.1


