Return-Path: <netdev+bounces-257298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA/vCVbuhGkU6wMAu9opvQ
	(envelope-from <netdev+bounces-257298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:24:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE25F6CE8
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C3EF301650F
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA4332694C;
	Thu,  5 Feb 2026 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aDlqrgsg"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593C30CDAE;
	Thu,  5 Feb 2026 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319442; cv=fail; b=VlBWP7hRxOCGusH0bRX/aL3wCBcuXp4U9VlODQMRlja36/3Yw9A/gMTOij3b0Na0ZLRpBDuHs8xFSy7E2SG8ri74UQ4Nk8XWRH86V7aIxfKuQTGAKfLJKJvn7h32LhupDS2Mq8fOXv/wYOT+lYMO3i3kg/knCUojQnRqAmvjsi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319442; c=relaxed/simple;
	bh=gCMEyBTIIV1aK+VCSQobo4FnLH9BAzLH6mvAdeq2w/4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hRPi+xuH8m78F2sW0OLikQ07xwPPD0gqnP6QCO68bPTLJKWLOq0yBLSsYq8bwKJq7YO7YLOjaZer8+wxQRRMqQUobFN5bCq1X1T9TqhLsRWli3c+DbIoHLIKIvaW+aGrNRJyRXGF0KhZ0taEOXpp9NN2FpVfxNNGFbXWlHn3NP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aDlqrgsg; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFoDenBoGkRcGKWNM5w0Kd8KcR/IJ+S55CIZIFQ1ELWuznWwXyQr4N1wEvVtDzn/XSIl3QY8ZnNGw61Zc4TDtHkGeg5R17U+eth9lqPcLyWp9wBA2xtLWJn4AJYVEC85rQBorI3Krdbh1JWN4XJUki3bbvorHiXphuvpy6KprrWclK2e0oxkiTlOp97IGwld6hxrtsV+pvgMX/QXbBTksRQBWi69WMyDjBevfJTznWU86nIy7rDBCygEq532PbYSk93GQMH7+5WbcaIsd+ELOJLOyWgCl7pVDpg9njcM7tJJcej2GcgqmrsfB5H5xb1PjZSTIisza1cE4vjc9AMaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2T9ibEww4I5K0MvXv3R5P7d+pUYfOXLXmtLpPBB4Jc=;
 b=rYXorJ8lME8sq6wqyEf5h0IRfu7qnBji1AaHthIGi9OuXw/JQgjS/Lz82ApngzB27CsJ9Dm73klUwuQfYNma3sIss8p5cj2REr3dR9VQMyRnN2/yhKmMnGv+u9fSM5lrwsWC3hVOU6ty5Qc/gwRlnFr+NSneyP14s/RxJZrZvZBUV4wogcNJGmDhQhqPa45ekjlAGK4n8FyHyzNJp+ehPUknIinXgfhEfLv/InO7jihWDph0kYydqZ0TYMvPO2fcCB3FamwukhTB8URfcmVHqXgt9M9J/dX1Lxg9Mt85SqCo4VavAYuCWJTOE5TEuA9uVVnpNj/c33W+ASx4KucLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2T9ibEww4I5K0MvXv3R5P7d+pUYfOXLXmtLpPBB4Jc=;
 b=aDlqrgsg1yGnV5Q61EFMpleR5Ag8f9qvp2ahq2QfRF73ZzIgR3Gv+wW+G81QCudsoLMTyj2hJQfM2t7oKriMSRIJ/p20XAjruF5YVRcJvBDUx+35otdrHgKTqWyWe0VkJSsF5LfEYPc1eKKz+jcWcdVC3YZxASEmNbR+DD6QDVbtEqgp73JcmCaQpkHBPadUzTv222+SoeS5yXVSUO6vC1/iMS0vz5V2PoTeZqMricHaWbFJXM2r3Wkcy3ZPE/nM6gKGr4JxTszGQXlBNJV6zfuS9E0wk34WIGhDD4ZDguaQA+VXV4PQAwnQylcP3Taw6hCCAP7Ze025JMbYPdNrwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAWPR04MB9862.eurprd04.prod.outlook.com (2603:10a6:102:391::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 19:23:58 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 19:23:57 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phylink: guard link replay helpers against NULL phylink instance
Date: Thu,  5 Feb 2026 21:23:44 +0200
Message-Id: <20260205192344.21797-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAWPR04MB9862:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac2c616-c812-49d8-2b94-08de64ec1b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DvBM5M8MLrJ3fAmO8v+mHDRAjHaaP08sqk/stAoJJCIeM8/1ZTe6DIDwyDxX?=
 =?us-ascii?Q?D4EJw/drjTzmVBdPc65uS/d1HMy0eIE59YW2IcQpotnr+d5aJCSAVgf9gVdA?=
 =?us-ascii?Q?Fxr/vKtRKQmgHgNcpU7q3r1+gklL4ktmgAfroI+xXAwmSXEUHzy1JXVWtZMK?=
 =?us-ascii?Q?Th8Yv2KNA+6gZHW14CZatXecvT/jOo6GZ12eD/V4gZsW8cwDpga9vy9TYEFg?=
 =?us-ascii?Q?e4YQw9662PxHhM/fCnb6rI9++oUN+inL43ECZJLzAx60senPDQgwFx4CuDjr?=
 =?us-ascii?Q?9UW59TOoAXNUgd676qiBuq+28oneiuPFgOAsNLQVa9MJRWYz0jhTYAMFWUmz?=
 =?us-ascii?Q?2EvVuegIMd4Fv23BS7SXMWYP7uBB38qPfWJ5E/JNFjMxcg29+/jpbyeKjlPl?=
 =?us-ascii?Q?6MZI0ynQ3WiYj8aGeQ9X4tSBlD55IYu8RlI6dl7IRaWLbhxLv3mJzIpluRYd?=
 =?us-ascii?Q?M+et5ZCQ/f2vBsI4xVoSHhRAfCfdpjPfV22Aknfa3NpWJ0BTzgMTchQIIted?=
 =?us-ascii?Q?AO3fhnXGSxbjWRDf1ypNko+0RzJSzHR4DmbbbUNPNVqNeuToFYonyLTarRPZ?=
 =?us-ascii?Q?n6mnGxZHkPdCx6d/Le+fIAhzpEiiiaEWVJlW4LIK36qNYEAmBFtow0I/cePX?=
 =?us-ascii?Q?MNcYPNTOZjFNYPwJWJecn07eyo1jDV+lqfL7opy2kiLeGsC7xWAG4c8Ws4wF?=
 =?us-ascii?Q?c4qhOKTCDNZgxa51B9v3nMhcTPoSEAvpLs45VOrKdtqpvoDSYMu3mp8CS6kw?=
 =?us-ascii?Q?zERmtZNhNRrVMw6eIBpM2sqMxMJ6JerLUFrsJN2kfB5/nlcX1iiz2suSPyEu?=
 =?us-ascii?Q?Y4ho5vnQoiUGFJmwMXpiuo3AG/ykG1LApiKX2ee7fS7M85DPeDjiFHiPF5s2?=
 =?us-ascii?Q?lXu1HEdGgosjGxN5Tv8CsQ7rdkdyxM3xGkSL5QgpLZXA4K6kwQyMQaHBVxFv?=
 =?us-ascii?Q?NKLWYq+Ol78Cs27DOfMyu5wtEhk6rJDoyRDoZE20dW1naGVcA4OlN05bKHXt?=
 =?us-ascii?Q?rzGeWC/WyL/Tsp+AJy/Vb/abQd4ZGCZKtmYASuAz2av1cslo/CEylfaSgFVq?=
 =?us-ascii?Q?9GdYQe384QDh6j7UMMyFdlIQTWINjxfitzU9dmU0H8TmWfZnwp9nzmIn/Awk?=
 =?us-ascii?Q?VA6EKzfMXuYh1mXY4M5ZCaA55nsrepW40h3szSAa7TdsUmCit7HTyITla/Ev?=
 =?us-ascii?Q?BtonWsA7oJbbFB9hrLtAI0GKeaDtPXMhUDByBl254ilWx522HmBtutYGuuLv?=
 =?us-ascii?Q?tWuRdlu/kSuzg1tqLH8m859T8ueDPxtA+n/E8qxlIAGWLMOT2St2cPSNNMMg?=
 =?us-ascii?Q?dJpcwWvaSj012/oxKa9D3P9qhbn/8bwjMDdiqdRLbcKXCUXTvdIQfHAXgJ9P?=
 =?us-ascii?Q?5bb+iE905xSUqJiwehfLix1QYKaV8B1Ti4p+opf+SMjvyiDynBOIqnkk+LbX?=
 =?us-ascii?Q?n01V8hmxVMnBlv7PQ8muG6XcdCuPqi7j2YWDvcHiOVr9iaoLEolA5pvvzUj5?=
 =?us-ascii?Q?iX9q1CPnS1bXtr6wdcmfnGinMKewiXQhZCG9TZgx4fvzwURvQzUKV5r4Omzk?=
 =?us-ascii?Q?jN4aSMFyUdAjbX8SKpFZU2k0CB40+O4DRIViI86J6YRvpokbwJMUXu/VBcX0?=
 =?us-ascii?Q?8VbTNYXnuLLGcjMqtNqzhDk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vcT9mzvPLSzC9cbIJOqeEvavVQKysvDnQubXpVaaP0spV5bnWCE0pEQzTz6z?=
 =?us-ascii?Q?mzzhSooJylzMHxpc6orh+Kw3FNFt5uSDnv58n6qm9pGg5sLGvhMqIvyU8nLZ?=
 =?us-ascii?Q?9HPHMy+oFP0KPO41hCgsQt/XcIxl/xu32CssLtiOh3k2uToboI5pnkovQCID?=
 =?us-ascii?Q?vVbRlatOHix4W0bLf51K75mTpFmoiFj4V0rLhySWyMtoKw8DYXJlpkaQ2Ftp?=
 =?us-ascii?Q?OxpNS+2VB6KhFCYXhU+s9hNpohBz2eL0cyiINM/tJv2UJ125TJtGSt51URmj?=
 =?us-ascii?Q?kD0Lj2/PJihiZRjonMR2IhJf75MnwQyqScZGNk4jcepQhTWoudVJbVAjGTko?=
 =?us-ascii?Q?uUXcLFakbwtu7V6JAHjJh0CfblbUjNSHgeWuBgKIJp7i+srmYu1f9dJ/QqBF?=
 =?us-ascii?Q?rK7Pg0FEGcZZxHB9g0iP7X51chi/oSEpCPJVSHlbJzRC2OWGHaAminDOim81?=
 =?us-ascii?Q?ncysJ78TDe5k73lMhar4oCactB/Nfa6u+Q2AZctS1jcDJSxKfKXfaHziDLgs?=
 =?us-ascii?Q?XlKlDgogOz9PQP5wwuwKBHPm3YdvnXMXU+gfekP3abjZFr8vwmJJbAXZuwx8?=
 =?us-ascii?Q?9hh5Zg6ECjCcCElA0QsizU1Ht3EqnjstUsbU23EHtlnkytI39UIbOWpddxlc?=
 =?us-ascii?Q?ZL6RV9AXWIqZNbJXLtYCsNkFBWtKioMa62DF1YK908+nJ855HKODJg6Jg6Fx?=
 =?us-ascii?Q?1zxKXYuK03wByMdQ+Md+77l/G4Hety9zgHxo4k5Fh5r/8yeCU47jkEKYOwn3?=
 =?us-ascii?Q?q9YSJd83E477CDj6cl00t0RDebNjj3BRO5L6iLW1K/aht3jJjLZM1pJcbPMR?=
 =?us-ascii?Q?fiDgDoPmvijyjO7qcUhgk0xO3xINMOJUWDQ3VWzEmj7Bg/1KYKX1b/Ti7UXo?=
 =?us-ascii?Q?Tvk/4s9cpSDoMCXh2iS/nQ0vzcf+sanvu6J5THzV0Unq02j2POSxsL/B5a2x?=
 =?us-ascii?Q?xihzXkDb3G0W1KsfVdYbJ3Pos9pi9bgtUzQqLG/2kTLNtbl599Fm4k6qSjKh?=
 =?us-ascii?Q?G6B6Y5oarMUvJRrEFizPBIdv+34UxSvB0kv0QRbaW+zKF3RGuoIUS4Hu9m4B?=
 =?us-ascii?Q?Ct+B6gFgBsVM5N03l29v/GY1DblYD2T1O77HDPcknqVvEPInShULVRzsRa54?=
 =?us-ascii?Q?bQiN8ziLgwPzbzeKSQZCgEC+yMyrBhUy+BEINwXSJ7zT0NZC29/avqIMzQjt?=
 =?us-ascii?Q?yZsSCf+Y/niCNeUxjfqhx/7g8f/L6nx5a47eLBEDs6LW13v/U08YjM94JfFF?=
 =?us-ascii?Q?Z7MKrUc2HeJrzOrK/ARbfHqxpG3FNCjM92E+hm+0TO38ZBBbmrd7JqkL2FRW?=
 =?us-ascii?Q?ZHyorI+Kfkx1+1Gonkjbdg6W8XGl31oOmFEYX9PHH699cp6yE/7JICw74oou?=
 =?us-ascii?Q?jlmMgOuPkT9hL/UItdxU6v+hylDojJfooqS9Q53EDRvhfDXL3ZXm35wRFa8q?=
 =?us-ascii?Q?IFTUxfdhcy3vMVhHm9g6RHZooCSt+Z1uYgync5WdeXlo0NxeUSJlgYbzJ4DS?=
 =?us-ascii?Q?G/XMWYPi7HIy1Q4zaDwOkWR5Ta44sNd6f8esB/jAziTME0YBaURwML6tiqaV?=
 =?us-ascii?Q?IvH6fz9fVJete3v5cnlaTVAOpQq/KdWe0SH+/dVsNOqwVageUnmLpuz7D72/?=
 =?us-ascii?Q?X24MPEcDs/+fDjoPvLUjB59VkY5i3DRW/ljYQpjNUssvPU1IW3lSq0R+zY4W?=
 =?us-ascii?Q?vZhoJUo/IQIEabUnx33BqyovUGuMPv5yMf8AqKgjpEMvHf8HwotqG/TJKgy3?=
 =?us-ascii?Q?1FuVUdew7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac2c616-c812-49d8-2b94-08de64ec1b75
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 19:23:57.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqPlMhmwLj8yOS6/FJHd5leAhB8GtaBYEg16fBFyMNHwR4Xdw6M1QnPqi5iEJZbSNRqufEbSWPgYvr2srbzcXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9862
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-257298-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DE25F6CE8
X-Rspamd-Action: no action

There is a crash when unbinding the sja1105 driver under special
circumstances:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
Call trace:
phylink_run_resolve_and_disable+0x10/0x90
sja1105_static_config_reload+0xc0/0x410
sja1105_vlan_filtering+0x100/0x140
dsa_port_vlan_filtering+0x13c/0x368
dsa_port_reset_vlan_filtering.isra.0+0xe8/0x198
dsa_port_bridge_leave+0x130/0x248
dsa_user_changeupper.part.0+0x74/0x158
dsa_user_netdevice_event+0x50c/0xa50
notifier_call_chain+0x78/0x148
raw_notifier_call_chain+0x20/0x38
call_netdevice_notifiers_info+0x58/0xa8
__netdev_upper_dev_unlink+0xac/0x220
netdev_upper_dev_unlink+0x38/0x70
del_nbp+0x1a4/0x320
br_del_if+0x3c/0xd8
br_device_event+0xf8/0x2d8
notifier_call_chain+0x78/0x148
raw_notifier_call_chain+0x20/0x38
call_netdevice_notifiers_info+0x58/0xa8
unregister_netdevice_many_notify+0x314/0x848
unregister_netdevice_queue+0xe8/0xf8
dsa_user_destroy+0x50/0xa8
dsa_port_teardown+0x80/0x98
dsa_switch_teardown_ports+0x4c/0xb8
dsa_switch_deinit+0x94/0xb8
dsa_switch_put_tree+0x2c/0xc0
dsa_unregister_switch+0x38/0x60
sja1105_remove+0x24/0x40
spi_remove+0x38/0x60
device_remove+0x54/0x90
device_release_driver_internal+0x1d4/0x230
device_driver_detach+0x20/0x38
unbind_store+0xbc/0xc8
---[ end trace 0000000000000000 ]---

which requires an explanation.

When a port offloads a bridge, the switch must be reset to change
the VLAN awareness state (the SJA1105_VLAN_FILTERING reason for
sja1105_static_config_reload()). When the port leaves a VLAN-aware
bridge, it must also be reset for the same reason: it is returning
to operation as a VLAN-unaware standalone port.

sja1105_static_config_reload() triggers the phylink link replay helpers.

Because sja1105 is a switch, it has multiple user ports. During unbind,
ports are torn down one by one in dsa_switch_teardown_ports() ->
dsa_port_teardown() -> dsa_user_destroy().

The crash happens when the numerically first user port is not part of
the VLAN-aware bridge, but any other user port is.

Tearing down the first user port causes phylink_destroy() to be called
on dp->pl, and this pointer to be set to NULL. Then, when the second
user port is torn down, this was offloading a VLAN-aware bridge port, so
indirectly it will trigger sja1105_static_config_reload().

The latter function iterates using dsa_switch_for_each_available_port(),
and unconditionally dereferences dp->pl, including for the
aforementioned torn down previous port, and passes that to phylink.
This is where the NULL pointer is coming from.

There are multiple levels at which this could be avoided:
- add an "if (dp->pl)" in sja1105_static_config_reload()
- make the phylink replay helpers NULL-tolerant
- mark ports as DSA_PORT_TYPE_UNUSED after dsa_port_phylink_destroy()
  has run, such that subsequent dsa_switch_for_each_available_port()
  iterations skip them
- disconnect the entire switch at once from switchdev and
  NETDEV_CHANGEUPPER events while unbinding, not just port by port,
  likely using a "ds->unbinding = true" mechanism or similar

however options 3 and 4 are quite heavy and might have side effects,
option 1 is very unassuming and option 2 seems a more elegant variant
of 1, given the fact that sja1105 is the only user of these phylink
replay helpers. It allows to keep the driver simple and is the option
I went with.

Functionally speaking, transforming the replay helpers into no-ops for
ports without a phylink instance is fine, because that only happens
during driver removal (an operation which cannot be cancelled). The
ports are not required to work.

Fixes: 0b2edc531e0b ("net: dsa: sja1105: let phylink help with the replay of link callbacks")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phylink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e1f01d7fc4da..c09c357d0fbd 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -4379,6 +4379,9 @@ void phylink_replay_link_begin(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
+	if (!pl)
+		return;
+
 	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_REPLAY);
 }
 EXPORT_SYMBOL_GPL(phylink_replay_link_begin);
@@ -4402,6 +4405,9 @@ void phylink_replay_link_end(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
+	if (!pl)
+		return;
+
 	if (WARN(!test_bit(PHYLINK_DISABLE_REPLAY,
 			   &pl->phylink_disable_state),
 		 "phylink_replay_link_end() called without a prior phylink_replay_link_begin()\n"))
-- 
2.34.1


