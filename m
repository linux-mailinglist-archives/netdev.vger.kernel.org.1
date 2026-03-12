Return-Path: <netdev+bounces-267187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLIlFdsUs2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:32:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53282278099
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04CBE303C124
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AADD3AA4F2;
	Thu, 12 Mar 2026 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CV6gWzZS"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F128E39B96A;
	Thu, 12 Mar 2026 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343275; cv=fail; b=TBqPDBracnJ9pGJ8FoYJA7IjAS78iu3CIlRqbHYRsBn53YwgdJ58lY55lvaHAP05AkWGIFBJL9rCnPDmoc4HMAJ5xc0g3DbdVlsstd8QRYmjW0AWRO6MVn6WnlXIOXvbfMNylibaR8GS9i+wpDsECPvQuHZHrtDuMTx76SEl9Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343275; c=relaxed/simple;
	bh=L5IXsgQsGSECg+llGsq8RlDo7ScELx2oWPa6DVLmR7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EJSJkuYMSs5wtANVbGQQrqgwDu7VmVmB3u/XK7OypW9LBBekxwqgvBr024zujzY3o22C3qeO5w3k/TwPvaN6X806Z8KDrR4kXgqC2pju16m61TAF306hMQXNEpLQzZgaRoJaizReOH3Co3Cy9S0dbmuDsFTngG4ttTRR9t7gFXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CV6gWzZS; arc=fail smtp.client-ip=52.101.72.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5t2E3g6Zln2oarhiyLq/pfZIk/9ilAk1dFxerDqBKmS2afsaqMH9lWXPx8J/cxZx0cydwWKPtUxtVbhh/tsnp6nYxV+av3P8LiZc+gqohmtnfZ81vKw8V8uIyAapp7RNnqpxUIEIDq7HypxqL43wG5/kBL/kJLZ+te8pJ4s5UlA9ESGuk87AbH8K0QPGyEj6yoGAS+EkEkY3n+xbVrnsxX/Wcz+CtmWqrjggQoG7PlXTWI1G89PGei/apOo1v8XJjNqMBm7DUr6aBDrQv23u56q5lMFRF8oFxdxiP50nfMTzcCIxXw6CZaJLEz8UhZiNkYkk5/G20nkXM1dbwUyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5IXsgQsGSECg+llGsq8RlDo7ScELx2oWPa6DVLmR7g=;
 b=bLuk1MoHAC30XmFp3+ZJsZeQA/KJNRGvKrNLdoOsF2Z3ZgYPxZV604iicFQK+kQbrLVyDwESVd9cs9p9f2du+b+kNWCL7jgwXvdAkhMDCoWjlIRobNNIb1UUzEyDe8HgW7J1GEoLOr2hwwg/PyaZ6LPaNlHhk3Iyf9yZ8G89lgnPVLGNIvcK4sycjiJNNQoGe23+vYccH46rGq+tAUqn1lTWOYQis61rIFCle12/RDHH1D4lwNFH4RQ4tCQJPJfHN0yvk4pjMIQ8VzmliHXzxAXrf0KEvwhGE8uspIXTbexB0BibqoR4pZFMyJq4Xqq8YvcsystfKNs10qiFszZoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5IXsgQsGSECg+llGsq8RlDo7ScELx2oWPa6DVLmR7g=;
 b=CV6gWzZSvn7ScWm/eIPmGW1F/JuqRMYPsLt4tcuTtUpe64OaYHZjoSl3RunKJFQhITY4+eHD4y/EDMznKQHeei+XhXOkeXZyqubFaBqn9aCqQZ98sE8O47BExy89CPFmi/4QkMrsnaJlKwH7SM6mnJRN9xzfgwWFsIsSLLMA/uo900nRe3jPjHvbfJjK/cLVCg7x4YTxRymaActuIShdJz5JXU2VSvbT9VQTryq/zSfZ8jhMsgCbWMAjrxCBcbHZ0xdBm9G8VGqEGRzC4R1TThGzVkCqCFGj9UfaY7HNwNm+SzfcQOLc56pzWAEnf59/3VAOdOC897H24Y6grgg4Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9124.eurprd04.prod.outlook.com (2603:10a6:102:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 19:21:04 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 19:21:04 +0000
From: Frank Li <Frank.Li@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com,
	horms@kernel.org,
	saikrishnag@marvell.com
Cc: Frank Li <frank.li@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net 1/2] net: enetc: reset PIR and CIR if they are not equal when initializing TX ring
Date: Thu, 12 Mar 2026 15:20:49 -0400
Message-ID: <20260312192051.3484705-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095415.669128-2-wei.fang@nxp.com>
References: <20260312095415.669128-2-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0234.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c7989c-e090-462d-3c07-08de806c8109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8nMBdLA/2tViHSvdNTXuzjU59rNKJHmqUYuQLBR9pn6YshOB1OqxA5XrzVAusSSpsiWfc0aRCGYYt1Gm2wmNZaLB2mBc7GREdjcpLLkbxcdKrHRzT1CiNbJWyOQKbCiLcQo4ESPNTZL0qMz58/cXBGcaa9TEW0kx3QaPIIx54Ot6ETxHnWxBXKV713MOMGURK+Jk7EHblS0DlSoMuFn6KlOCaRoquAXE4D4+4dEhiUFfBKXnaIvzXKv3aTlGA5IdtrY4y1ZshpGPVLsq+z03aV54z4W2c6SYVeN111PX8SUeZBgznbiFz4z3Ku4k7FCYO4j66tc47XypDx4daHMCqnmk04/QqQkFEtit/9jfCB2me4o7MVbx+ZJ0KZ/YnRaI/pZwvc0nQbjg2italthSiVpMPDSgkNvzlXP4mazF+5v9+GCVftDs3mvX4Q79lC4fdt7wqClY+XJc96f04JY7s1nYckQsOtqkdP7SieFsy28Y1y+ZdgUouKg9wCt4ChDYfTfHfvMT0YhMp+afChJ2vexHU7lm8DpLp95jsLxEKivD8tJFEvapfLQccUJryGTwKSCrDcBchI8kPbSPAa+HuoF5owCTjVD2UuUNIYhDH9aCtUJBuHnJS8rI+aJ2PW7RI/53UyRiw8CVKepp6XjJhiRbuLc14oZexFEprGZfEsoY6C+aPA3w1UNyIogpAFNpzJfzJ5LojiOUVk8in7volXE20Q+21UNOF9s5L/ONz4cPukPy/EGXHh5vrAGeO96QVkT3c20YnepOJiqRL7yqwVuNtIUe0I7xxkoLtBo5GPslMydOhTYFCchfsmPME7n/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zsB8+N4t/oUn9LiADrsNtSeIgwlPuuQWzMhZrCsJDEYYTac9J8qFDkBl4MHl?=
 =?us-ascii?Q?GLfaRdi/0v5knI6GzUvSeImnzftG4JcDJaXZK0EU8JRVyBKg3IW35cqz/XcH?=
 =?us-ascii?Q?GDRsp827ureAm3jY14U6U/8S0ESQxZvq0NF5hI8dJM/aPotv+9zNWzGzzKLY?=
 =?us-ascii?Q?3XDGFGV14daXq3/1v2oLg7LDkRvyhyA+hzVeK6RAHeb+ZgYqqlZbdMj82lfN?=
 =?us-ascii?Q?eruzKKPw8JLu9CYF1ccxtRbiTH+xNI+0C8QuSbU1LEZFZJ/FEuBtQPk2brgc?=
 =?us-ascii?Q?ckvGiPM0t38pH1svV1z/EoMDEfN3Fy15F215x6UeEjl1Yq8Cud9Gw8h2nDvH?=
 =?us-ascii?Q?2+jBrLFsb19M68ym4AX9quNsmNKU23xMgCTAQ+uLam8Jy3wFXrdUOV3gbzr/?=
 =?us-ascii?Q?U9/CUpehM/8q14hbHeH9Xzkyk0t8m1UAHvgPHoTpfcV1rMFDb+zHxYf77Qmu?=
 =?us-ascii?Q?jzxo9CCzrQXeXbXhWu/dDIGz2Q6q4cYo9dWuGU614G0rZ8ymql19TDVxUg9S?=
 =?us-ascii?Q?5fhDb7D3NEXqs8S3mJtdt5dR2WHguHoXJgzxX8/Qd3IsHsIxrka+MeQqQJfA?=
 =?us-ascii?Q?DCBC717qKEthzIW2qkJPZwUOFCw3JrUbRrEobmOxHrq3ZWJxq5B3YFkfmKRE?=
 =?us-ascii?Q?IIyyA0JQxpbMvYbxNjNeSySOPec8B60kuOMon3Y/t+Tni4fqu7txJhEbkMFX?=
 =?us-ascii?Q?onhCLHOvbKHWNBGK8jJseo4hGD7AxHH4Tn85bGqnXKGHKh92HxjCiDvK2x6y?=
 =?us-ascii?Q?VWAh12P0Edk6MDK6uNbLSJ9u4n/O1IW5WQncf2ceOHXMjOV8CZ2FeFWBdQ6C?=
 =?us-ascii?Q?Flf2Vqhn8yDQCBYiti9PbnFE+WAjtKo3navqKoI9CGu3VjV+IWWNTMF2P2O5?=
 =?us-ascii?Q?G2ZPqr6wGwPkzUAYVMcftk7xGyCVKPSNknQ1Lh3OWR/iXIhBOq2QkDYVVjVZ?=
 =?us-ascii?Q?SjWvsppA2rYhMiXMGmmlzBPTpD+vjusZCjUStvXxXUOlNCMxf99r8ErQLc2i?=
 =?us-ascii?Q?3XyK0KvCdvfFveJlA1jBkdm/YAQbN8K0Gv4EHBUVo/mC/dhSE2JvRut4/pFI?=
 =?us-ascii?Q?tCT5t0SOB3bIf/MMTfW+i4iZiJHemQ8oWjyGxZVvOmPhRe9aljDoLVtW1RLz?=
 =?us-ascii?Q?oRxoPl6+MxeXnqSXwXHNxgnwDkr8tTbbDQC8gjh0gQxjQXaHfH36sAdbDSXs?=
 =?us-ascii?Q?Yf59VcJqTPBBZb60qFHeMAOrjaUo9ryXbXRalnwEjo+nW2E26DtuZUdw1vTi?=
 =?us-ascii?Q?7SOVwLrKZzYy4QYDb3H1sRQ4fvYV+ueIu0xEPjkh9GWTglzLHddz6s1r+bDD?=
 =?us-ascii?Q?MnjJf5dmoeYeNx7Nr5W0X65YzUGM99pf4tCiCj5tgw47+Qe/iZBMQjBmdkfQ?=
 =?us-ascii?Q?qC5m/IJonPXR+huurBdr3IJPxJLYYM5VOaVVv/cLDAs9xvzkHzfen4YH/41f?=
 =?us-ascii?Q?2OCM3Yj7v98XtIwMtBTi5rckS0JVGY2pL+vM3aYc3wXVO4Y7WCjH9RehJ/tx?=
 =?us-ascii?Q?dXv5CIs1F4z5mwKVlDQEq2somVPx2rLvOfCngDcZliYx72XmhIGpUyy3tFma?=
 =?us-ascii?Q?PMiBEQXPfwsuzoZcqFQrutxwLqQCg6kY53Z/dTkT6hUKzfkKVyfngri7Makv?=
 =?us-ascii?Q?1iKCHW2U2llv+b1wlH9UgTxo2grM7p7EXegF5MjIghWvNCZs0ew+td+QXND9?=
 =?us-ascii?Q?9cv/PFPnFMMM662ehgk0NxHkNa1UecJauMWrws32fzHRfZ8c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c7989c-e090-462d-3c07-08de806c8109
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 19:21:04.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQkBIQIIh1dnmeTf/DArJQeCTO4/FoVpiUeKrwCCaDFWWPICnfvxyMjFbjlDAT9I3V1G+NQJGVQckUMwWvHeiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9124
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267187-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail,nxp.com:server fail];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53282278099
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li (AI-BOT) <frank.li@nxp.com>

> Currently the driver does not reset the producer index register (PIR) and
> consumer index register (CIR) when initializing a TX BD ring. The driver
> only reads the PIR and CIR and initializes the software indexes. If the
> TX BD ring is reinitialized when it still contains unsent frames, its PIR
> and CIR will not be equal after the reinitialization. However, the BDs
> between CIR and PIR have been freed and become invalid and this can lead
> to a hardware malfunction, causing the TX BD ring will not work perperly.

AI: Typo: "perperly" should be "properly"

Frank

