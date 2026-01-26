Return-Path: <netdev+bounces-253360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLz8A8sid2mZcgEAu9opvQ
	(envelope-from <netdev+bounces-253360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:16:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D98560C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC9DF3004233
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F892286897;
	Mon, 26 Jan 2026 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ba5IiFEK"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013007.outbound.protection.outlook.com [52.101.83.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800F214A8B;
	Mon, 26 Jan 2026 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769415368; cv=fail; b=RHe4NWmWPQol/PQLenkwfbJlvL2wAMb4AgVRYozLSKGSGBLfhdYofTScK36AgT6Qf5RAtDLX+EnoOEIEyRz74nGgs2eeWAzIWqDSdiPaRGKeYdxpYo7Mpw5BOWBUEKRIxKgSmUlTpoTdAi2XkhzhVsgW3FYgBEpY48bt8rzRcpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769415368; c=relaxed/simple;
	bh=lXYqpaf2GChlZhIIkPevZivFUizES6Ne6ip6Ls0+eSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IROV/+BY7ydtzTf/mRCVy12xLf0on18dQ9QOtjxlw1Age9pqllLED562ViPvPHAS5umHuDbWN/4GTM4F6QKy2N20oJjQKnMwUnbkzwrvdEdtre0+gQb5Ce2DdFJQyfLWHR2Q/IBet6ZJz0r9H2llmnXvkK93YaKhkXcJa5Ql+t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ba5IiFEK; arc=fail smtp.client-ip=52.101.83.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sb1i8kB/ShqDGsuzXdyR/tXqxTn3GWeSRYSJ0L5XafEgq34UWk2SrMeRgHk6HqoaZBFqoFGgX6V12NiSZPNVZmEleTWlyaArmv82DkE9c0zVfGxhSm1pMuXj6hbBe2RrgVlBVNYCzLVtAIPNoanqZrDsDJsi2et+d4g1NKgtcsI57Y2Y4gp0mjx4zwbWyPn+OOzEeb4qDtvN4WEaVNGrE/wjlJuY9A/f5dnD8UreyS8oOIyCbHoJDHq9tdjcW87GeXHgXoAIrfaBLZwnAiAhaz4rIcYyP4TyUGPYfTolRRv/LGfSlI1gSoYIZbtt7Q+jlidJyXHCkA7kmLYOXs1Vkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsKeB8e2P1kbJCT65eIE8/aIb9+6nnml+VgQz14MDtA=;
 b=qL7o1U0XVjK8ubd0yQh+mXki0uB3H8m8UNihanPBaU80jaiMXJI/hhlo4gWnKdCuWlcbkVG3a8VNJW94YRpwd4ywFCQ64Ez7O3g1FyhG6/gypcmKosdKNHVjFHb131yAIXvnS3t9KkLEQH+/QZ2reXk//1CZlAa8zITNk2yxO/GAvvyWxtoF0+ZTFdwXYmZBjQoh7x8py2pQRaKUWMi+xonT42r9F7s5QgWeImrVMPfKWTljAvgS4vTTPaw1EqIOiGTZojzBr4BlsCjOBS6RhZQEzfTkRyBAhjYv4fwAnOVBSGpxXJn4aOVI/a4pAkUXjUFo4piNpRDY086k9ho0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsKeB8e2P1kbJCT65eIE8/aIb9+6nnml+VgQz14MDtA=;
 b=ba5IiFEKSnoCrsLa4Nq8G1fI9fXXJswX3Jk+z3/C/Du88VI976PRWmhRWl4eDRhE5xU+XWlsS3gKoBCBFWiMxspzlMti9pMDNFDelcjSdwUU8cn32k/znewESHqoGuyJovgXl1um1nkOKYPmgm6AHHwSGtomDs2G3vUPyoTLSZHCYB+IdhM82uipWBTeIbxeuJCozi1G+cPV8y8vrV2PUgptwG3DOrA9zbRGezaarNny9FDC9ZJxOxL9/JTxdIPUxcNbnMCGzI57oaqqDKZfkZO4DgaABSng6sL7WYMzYEI+97O1FwZyAfX6dN8zH+e7LozGI5XP/OE7N8AEbdTUSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10444.eurprd04.prod.outlook.com (2603:10a6:102:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 08:16:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Mon, 26 Jan 2026
 08:16:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	florian.fainelli@broadcom.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: micrel: fix clk warning when removing the driver
Date: Mon, 26 Jan 2026 16:15:44 +0800
Message-Id: <20260126081544.983517-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10444:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eec403f-757c-4c38-2947-08de5cb325da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kt6LE+efmbPohG/RfCQLcaSoOxg2FL+atIj5KhpqBxDpJ3kEagFey7VhXQQs?=
 =?us-ascii?Q?13LE9ZsHWrWx1d+G0fHeChtRIriGTR/XnRiDOk57KXVzSrH9nRihJ5r5cKBG?=
 =?us-ascii?Q?K0zO0Mf0rq8eItTPE3bcF0mqJLHFXGczG7Fl3RSfH1if+kwOh/uojgAMCvv8?=
 =?us-ascii?Q?Z0rr1Gmto5oLKQEjEJZ8IG0yZQFZnF6RffzHizyuLLl2O0zRGeFSVZTGhSkp?=
 =?us-ascii?Q?SAvnAQ7DUBN4/1eZ0XPvVF/DmxEwnlfpr6LeHXQtqxpfOOYNCVTnp6Ma52HQ?=
 =?us-ascii?Q?5Y6kdn0+Ozsq/tUwzSUXJX38cJBfWK9GVTOeGQ9HD5PPs33LY8rcPV9P1lST?=
 =?us-ascii?Q?ltvnRTk5kWEFvda9noi77CsGZIYo1HFVoqJlAZJJwKCbG3dI+EAHqrlkn2q+?=
 =?us-ascii?Q?QFPhGzwrZXsZjQRMURehSR8JkQWmqTLjlIz0rW826Zz5G+REO2MH9Y8Nv7IW?=
 =?us-ascii?Q?DiR/OzvJRu9o4dorkUdqTYJzene/mbUDHG5IVCi3xW8r2tnbAD3Otz7juPQ2?=
 =?us-ascii?Q?1TLPHL0nV1kyEnmr1xkP2A3m2kwiADspoHRzyQbl303mB6qlPFVf7oGV4Kxh?=
 =?us-ascii?Q?X7Ee29T1Pxr3K1zaZCAw6s0yeJBh9NGUuVK9wcn1ARCO8NuJMRY8Lb0uVhpj?=
 =?us-ascii?Q?1upJgXyJXvFzKysfDz+3pk6nqPZ0geRMJtU5xRtG2/Rym4W/2bf20al9EbOB?=
 =?us-ascii?Q?7ICh8h7gN8H3GBQIx1UMmgZFrvNr/hbcoeiDDnzooy6VdU4AEJlmeLoCyAai?=
 =?us-ascii?Q?W5e45/gGwt6Ev/Vkem4B/sZ/BhMbvgxW4VPZgpMesog2Ls4eaxhRFpkL7f3n?=
 =?us-ascii?Q?/Y72+nxNa6xTFegUVH9+sBOVTc+6CLiLkbPiuELcy7IWVXtOcavMNk087463?=
 =?us-ascii?Q?L0kOWImfRjn3YuIcN9abRGe1O6LI05iDUQvQxi9aCXnCzV3zZzYeY8aIk5Sa?=
 =?us-ascii?Q?Xcqt2LhZnRKcnm1AVU1NouB1h/f2H2dzT9mZogXfQUHDVAPsuaMRC7/eHK6y?=
 =?us-ascii?Q?pbAi9PZpse1twRS8qxXaNiab8NE/hX7feXx7EOBgyFed7gg/9HMxDcQ9pq+h?=
 =?us-ascii?Q?hFNUGCfaavpG3bo1ycnqTUZFgP5Aw7Z02r7fQKT00N0mye4CkP/nlaUjueIg?=
 =?us-ascii?Q?nHrIc1WY+FrTd15JGHEBeuIwV0Emn+HjhfqCWkU+L94u2yBUhAMFzsNkk/f6?=
 =?us-ascii?Q?tssihYZ369UVfEPstR/NXJJbih6zMJyYCtSsiifIi82KiAAI+vkQtLH8z2JO?=
 =?us-ascii?Q?LUnWixN82txcClIxMpbNQZ1IbLc10js970Wnr5zTQPo3PSPxNFH0zKuf7ZSj?=
 =?us-ascii?Q?S2puksMXSbAn2fJBrYYaS1dlxoiwT5rCsxca0uNvlQIFMMnKhXK6FD5ZVUMT?=
 =?us-ascii?Q?xOKHued0/Tkpk2BVh7K3q7Iws3W8GnBOsdeF81a+Oa6QNr9++7INE7lXZCEl?=
 =?us-ascii?Q?B+czUcDDbR5h3L1ld8Dc6N72mwwi3IZooSMEEei106ApH/MtdaaizfZfEV6m?=
 =?us-ascii?Q?UFOxHfgprfFp04oFYlTXrx6VCnKmdwaK4WKfoNdkqlW5N3EWOq+ADCDtaSPi?=
 =?us-ascii?Q?yldyij/WKz53kTB861u2D3U64+809nXhsGRw+9WkqZMoBO0iICISg9CjpqJA?=
 =?us-ascii?Q?7bpTDMLfXVC5n1+IePlTKGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/HSyZn5QJfHcRNJGk79X5nV8lJmxkzomWtvM7mjvSi0kbGn/DqXs15zpuCfv?=
 =?us-ascii?Q?g/rYAZvtN/89MsWtRzTa9ZdSOI9G9nsMp58uSp6sJD1H+9ahPGAfmBMieecH?=
 =?us-ascii?Q?CpFXA/zNLDTwuAgc2aYe1wKpzA8IKyfHiIhANzXVfgpqrnjNP4n+J2EbK6IV?=
 =?us-ascii?Q?vgeAfNSO0b3oTRC+Pvyf9ojrQBvgKuuAwkG0VYDp+qErOFKnzx3vUuSy6ghu?=
 =?us-ascii?Q?01oO8Di5BPnZz3971pqpK56Uo/ihvUNKxvI5Od56aPOsjYGgdskmN1cKhMkA?=
 =?us-ascii?Q?qlGxKv1RChNOHZVAAF8LQN7zQq5eKi4IvTXVs5bD+qD1gjUDegYm/qHlQZyY?=
 =?us-ascii?Q?5SnGDwhQgx5YjclipZbNsfFRCLuVzvHiqHnJKxQ1/IKARTadwGIgCxwSYOAT?=
 =?us-ascii?Q?LSYVDYvTeQSAfwp6XYLX4soxkQBrWA7SUNvyeJXJuDC1Z6O8ZjE28Ed37teB?=
 =?us-ascii?Q?O1ODc43qQm3A5Mtp2Yk394nrT6LAOYpC0aekgCjYLg57+85wU4S8RXeCtT6X?=
 =?us-ascii?Q?swXiiUOI8CPNVk9JvWM+VEjOrKdgCrwDeN+0iRZkqIMtV11Dg22o2k4xY8ve?=
 =?us-ascii?Q?Bb5Hq7goGIpYCRKdS7WYxoJemYMWPamVcCB1y5FfcHCw4JnFwMWcXn8yNdB1?=
 =?us-ascii?Q?DCqwJjFxRIFME/L7yKx45x/FxeGdR85OOhuv0331vgTXwd8BZyJpsoX7T3yt?=
 =?us-ascii?Q?YeV4b0gNr59ZumJ0kU50Y3rIYUgNUWltj9s6YHAJe6BfLLVjbnJBQuusB8iV?=
 =?us-ascii?Q?5+G/rX48TxzkrgM5nAUhzgtSsiyyk8tdz6Hq+N55yoIa9WTqluuddya2KTmP?=
 =?us-ascii?Q?OADWsxa4s4kXYj1RnEk8kYshsh8ZB41cT+fo7anhWAEfg1obqd6XM9yrf/f/?=
 =?us-ascii?Q?O9/5P+l33T5q6ZYauu95SEclM8TXi1rXF2EW97UJBU6HnNDaf2Ut76ZMRH1v?=
 =?us-ascii?Q?Nnh2Ek+fyPB0a7OHH2VH1MfR188RXl8O/ym4agXHr3uRzMfTBCSiSeR7WU6j?=
 =?us-ascii?Q?TbjRtTc88CoN+hcPIOgFRDSXq8HA2WmJzfh/EU/oWhTla2JHeRvwAe7Beo9+?=
 =?us-ascii?Q?OeTxExxDyc/uH3R+JAVwcVOkdvrfHioGd9a5+7TTZAh9XxSWSsMssGSgx2As?=
 =?us-ascii?Q?7ZZdpr407MlYey6CCFhFNy3Yqw4yhYfRoWfeF2KFHyY2Y4iFe3NqAQSelKOj?=
 =?us-ascii?Q?6NNlGcOX8+Y25n8LD15d0oSVdmNqW5Oj9ecTwmFH2Cvq+Skj8THzpAIYw8+N?=
 =?us-ascii?Q?O5DfNuP1ZBoj50icKBitnsy8uZaq1vtDDwWhfp+Mv1TtrqMvIQBo08KTKAkF?=
 =?us-ascii?Q?LzeVWxRB9Q/QluQIm84rTpwcFc7sLsJJKljfg6ijdePrdIfIbS86u2fy3Un9?=
 =?us-ascii?Q?zvn/8XQIlgCTgzS4Wc6YJGsxqBfkA7BgdzQG1uTiqH1iQzycZxzrQkmPY97D?=
 =?us-ascii?Q?1N/FchbmdY4FLUkL9sRdTw3WqCj0Aml46K8Jq5bSGI+4Tl/AVfXqviBFwNGh?=
 =?us-ascii?Q?vc4pfik1tu+C5Vdib6oA5TdJ3J2hP7GLeXnNB5e7A5EgJGVuYsIADcmxU1uY?=
 =?us-ascii?Q?uKJ9QnUgg/kjCEzitICGcUXdkms5jHuxt9A869EEs189C978hGZ2AqxjfsF1?=
 =?us-ascii?Q?mXCL4n8yaTwWfyejAu2t5lvBvKPr5r/rbWw6PizsUbAx5WnewnX1C5r1EcJA?=
 =?us-ascii?Q?cSMxyq9BZ+QKHWXH+iHmxZegQO2IKCU7D6AAVHGOyoyrUJli?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eec403f-757c-4c38-2947-08de5cb325da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 08:16:04.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uHG8pypUo/0nSVLl6cgrNXdI+KTZlg9xEdK+mX7+fiBZJoc+CBPeyhez36hd+WDZILzkd0SuMySnu/ZcJ5hkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10444
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253360-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 461D98560C
X-Rspamd-Action: no action

Since the commit 25c6a5ab151f ("net: phy: micrel: Dynamically control
external clock of KSZ PHY"), the clock of Micrel PHY has been enabled
by phy_driver::resume() and disabled by phy_driver::suspend(). However,
devm_clk_get_optional_enabled() is used in kszphy_probe(), so the clock
will automatically be disabled when the device is unbound from the bus.
Therefore, this could cause the clock to be disabled twice, resulting
in clk driver warnings.

For example, this issue can be reproduced on i.MX6ULL platform, and we
can see the following logs when removing the FEC MAC drivers.

$ echo 2188000.ethernet > /sys/bus/platform/drivers/fec/unbind
$ echo 20b4000.ethernet > /sys/bus/platform/drivers/fec/unbind
[  109.758207] ------------[ cut here ]------------
[  109.758240] WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0xb4/0xd0, CPU#0: sh/639
[  109.771011] enet2_ref already disabled
[  109.793359] Call trace:
[  109.822006]  clk_core_disable from clk_disable+0x28/0x34
[  109.827340]  clk_disable from clk_disable_unprepare+0xc/0x18
[  109.833029]  clk_disable_unprepare from devm_clk_release+0x1c/0x28
[  109.839241]  devm_clk_release from devres_release_all+0x98/0x100
[  109.845278]  devres_release_all from device_unbind_cleanup+0xc/0x70
[  109.851571]  device_unbind_cleanup from device_release_driver_internal+0x1a4/0x1f4
[  109.859170]  device_release_driver_internal from bus_remove_device+0xbc/0xe4
[  109.866243]  bus_remove_device from device_del+0x140/0x458
[  109.871757]  device_del from phy_mdio_device_remove+0xc/0x24
[  109.877452]  phy_mdio_device_remove from mdiobus_unregister+0x40/0xac
[  109.883918]  mdiobus_unregister from fec_enet_mii_remove+0x40/0x78
[  109.890125]  fec_enet_mii_remove from fec_drv_remove+0x4c/0x158
[  109.896076]  fec_drv_remove from device_release_driver_internal+0x17c/0x1f4
[  109.962748] WARNING: drivers/clk/clk.c:1047 at clk_core_unprepare+0xfc/0x13c, CPU#0: sh/639
[  109.975805] enet2_ref already unprepared
[  110.002866] Call trace:
[  110.031758]  clk_core_unprepare from clk_unprepare+0x24/0x2c
[  110.037440]  clk_unprepare from devm_clk_release+0x1c/0x28
[  110.042957]  devm_clk_release from devres_release_all+0x98/0x100
[  110.048989]  devres_release_all from device_unbind_cleanup+0xc/0x70
[  110.055280]  device_unbind_cleanup from device_release_driver_internal+0x1a4/0x1f4
[  110.062877]  device_release_driver_internal from bus_remove_device+0xbc/0xe4
[  110.069950]  bus_remove_device from device_del+0x140/0x458
[  110.075469]  device_del from phy_mdio_device_remove+0xc/0x24
[  110.081165]  phy_mdio_device_remove from mdiobus_unregister+0x40/0xac
[  110.087632]  mdiobus_unregister from fec_enet_mii_remove+0x40/0x78
[  110.093836]  fec_enet_mii_remove from fec_drv_remove+0x4c/0x158
[  110.099782]  fec_drv_remove from device_release_driver_internal+0x17c/0x1f4

After analyzing the process of removing the FEC driver, as shown below,
it can be seen that the clock was disabled twice by the PHY driver.

fec_drv_remove()
  --> fec_enet_close()
    --> phy_stop()
      --> phy_suspend()
        --> kszphy_suspend() #1 The clock is disabled
  --> fec_enet_mii_remove()
    --> mdiobus_unregister()
      --> phy_mdio_device_remove()
        --> device_del()
          --> devm_clk_release() #2 The clock is disabled again

Therefore, devm_clk_get_optional() is used to fix the above issue. And
to avoid the issue mentioned by the commit 985329462723 ("net: phy:
micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
clock is enabled by clk_prepare_enable() to get the correct clock rate.

Fixes: 25c6a5ab151f ("net: phy: micrel: Dynamically control external clock of KSZ PHY")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/phy/micrel.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 05de68b9f719..8208ecbb575c 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2643,11 +2643,21 @@ static int kszphy_probe(struct phy_device *phydev)
 
 	kszphy_parse_led_mode(phydev);
 
-	clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, "rmii-ref");
+	clk = devm_clk_get_optional(&phydev->mdio.dev, "rmii-ref");
 	/* NOTE: clk may be NULL if building without CONFIG_HAVE_CLK */
 	if (!IS_ERR_OR_NULL(clk)) {
-		unsigned long rate = clk_get_rate(clk);
 		bool rmii_ref_clk_sel_25_mhz;
+		unsigned long rate;
+		int err;
+
+		err = clk_prepare_enable(clk);
+		if (err) {
+			phydev_err(phydev, "Failed to enable rmii-ref clock\n");
+			return err;
+		}
+
+		rate = clk_get_rate(clk);
+		clk_disable_unprepare(clk);
 
 		if (type)
 			priv->rmii_ref_clk_sel = type->has_rmii_ref_clk_sel;
@@ -2665,13 +2675,12 @@ static int kszphy_probe(struct phy_device *phydev)
 		}
 	} else if (!clk) {
 		/* unnamed clock from the generic ethernet-phy binding */
-		clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);
+		clk = devm_clk_get_optional(&phydev->mdio.dev, NULL);
 	}
 
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	clk_disable_unprepare(clk);
 	priv->clk = clk;
 
 	if (ksz8041_fiber_mode(phydev))
-- 
2.34.1


