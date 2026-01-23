Return-Path: <netdev+bounces-252601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP37B33bcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:22:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 086306F907
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43D32300909C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84289352927;
	Fri, 23 Jan 2026 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sd20GIJk"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72012EBB86;
	Fri, 23 Jan 2026 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134961; cv=fail; b=iqUEOqG27Kq3DRF6GDG78JB/d3c3i13WnvIoCmb5JaAAYgmy32xNZjt3gqoCa9Vj6YY8KlDCHlR8HDpg5WsbvPnBhotd3cmf9z9OfP8p8PjCUV5ueXHSXG7KkMfBmic3lMZnNfulzThtxfIhCE5WZTlEHvRBjkyPanIFayxM1q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134961; c=relaxed/simple;
	bh=++5BwbXI6gsLka6qAUzrvbfIDIWhlLfuMOnODDgcGVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=usKOU9imx1Z82dnxmbVy8AthncJ8o8avK0ZGO3cZciUVMsPygnHwAIz0faMel3ftL+8LSMxrUe4P1UAyVV4ShrSDRcaUkacYG0kI1pcdOEL/5J0QCRImG12GCWFSwvnzWYiIg9m1iRJOHSuFyMVZx3oN3Uh+PpiPttRphkKK8ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sd20GIJk; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJWADVy1Eq3xli2oLWTat1AUsU/x9pA3/rafeSsFecTfNLg/krU939COfD3+5zsgCeosFksRvZgRsh+8ZYn8P2Pwu0LEC/FE4EJV+uFnDCJUdZMxm7HNF6MeYcTrgEl3DiYDvAhDSP7lt9ddvWaJNlAxNDeG2CA7hmFZ/aQvDbWDsmVmveM+ikNPd4Pt8xWuJuM1WeQR1jipiT+MnomIWoq+8cGfWHerwltHGjZknaecvQ4xjmPh00rMBQOVfyww5tR34oqu6Bt/Mf4KwuZ0w5vqL60NKFzfSOSWMSjsxHpMUVMfzTmZTJZ9sxpoRLhEXnfIFlaLiCyVpjjFO9HbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BkCGt8PQsr6pzPjEl54Zc8fTuQCm8RmbczY/wHYp68=;
 b=ZgSDeZl76HSktrthaJGNAVNaezSVD86pdNRBHHUodFgR5EzwTXjCIbdSXBg8vorHDoxoHmrwxa6N+l1RAuki9ilc7BIkvLojd/Kg11E068wUAlE36K2a4Gd8CIKhUv5fYkIjtmgJCzEQGYRSiTKayWH5HC+nYx2BWuC+NC2luVPSncVKZ5KcEypS10Vz7nUXgfbwonjC6h9+pzvMBRbt+T8U5keB8erueuopHBLAvgyCUTljf0uJ7y21Vti9Z747usCDBMpkUzn/4JeXp+KyesAmvp8LtDg8mfhonGEoeQAijrpEBR8/WkZhjc4/qsOmP9YLNtzkUSq0KzZLzwXwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BkCGt8PQsr6pzPjEl54Zc8fTuQCm8RmbczY/wHYp68=;
 b=Sd20GIJkrUzWmvHx+F5S4s2mNFj8cfqnRns6uzoVjIkRRwGVRcZp1/hjDp7C40BK9IDMNLApvNORwDKaUoh+aJyJ9m8NYUIzZeZl8Mf/4gPF8xj1xnXVNi4k31sc/u1x3Lvm+s4t/+xLGjTZC+qE8a9zv06uVkn+OJFfbq8pJDs4HC/xnHwsYEbA9PaYH2i04yzY7ptUBSqw/Bh+RGyuu23UTrben2smlc8Ag2hhzQzrZHfiq27owj1R3NSI/rBiD7qIk00XoibtD1FI8GLjRgIRCy4eRsgJ9DqguEwfJxiTHq5kcpzq4F8lERhmN5OJp5mty3WVlLhV+OV1VWIVXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 02/15] net: fec: add fec_rx_error_check() to check RX errors
Date: Fri, 23 Jan 2026 10:21:30 +0800
Message-Id: <20260123022143.4121797-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ac9446-da06-4229-f6e1-08de5a26379b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nVvpKd7VtnSWzd7w+MUihF4XGjdXNKdlOSrmkV/+F64/IKskBIflLLLPasL3?=
 =?us-ascii?Q?Sniz0GnLEEyezRF9gbkvnrbrEAFN/Bh0589ZSzkyBXBBfZNcLgL6TK9KduiD?=
 =?us-ascii?Q?DNOWjC2cnlIKwZSnfW4Qy85gmSIMfuzMaEuJEI+PObzrEiew3Ej6sbWwGPhz?=
 =?us-ascii?Q?/kPd/MztrR30N5DXelAhHTEzAitxLUe7aM8g0gcMlD4vYMk28yTMAuKIT93N?=
 =?us-ascii?Q?uOngqRQEp6UChxFGLHn+Dc1I3vOmgz1aygY02PfPKoVHijIsH9H74Rm/bs7m?=
 =?us-ascii?Q?5yG+7/egYYTUXvZEoCGkfYTFQn24bz3qdtsI+pbmtCQH5zHTJSAc5TlxYrrQ?=
 =?us-ascii?Q?DrEPjfmvZqf1QKl628hXeFaPgJUzrWlDEQmQQk/tJ7yTaS/Ybi1ypv26PRJ+?=
 =?us-ascii?Q?+j1lFu5+KO/gcihfplaeWy68W36i3zUHETS2zncLNj3wp4QFwinUGrSCyv2v?=
 =?us-ascii?Q?sSl4aQZN7f/LUD3HqIwQBV9eCc6h9yIsZyX7KUMc1+0pyN2v9te8hNCF4s9x?=
 =?us-ascii?Q?bmFHtl9SNloCZbf7U2YxSDMTJ/mcmM/8snfopwqudwt0/fiQ6cjkKSjISZbM?=
 =?us-ascii?Q?k1dlG+IaTgmeGh6CUJ8ih6D5A9vEyt0qtaddppqpyaOOOAriqflf4PViWAdQ?=
 =?us-ascii?Q?bibEAQk22Ie9QDoX3bA+oOIOLB0cSn5VofoPLgcpSzH9l+1jrLCKpBunhOJO?=
 =?us-ascii?Q?tUA/JFlrXpUQTG2IIkHhOFOQbJCtLUObbICax5cEQqqTNsMy5dhOHhYmfHOe?=
 =?us-ascii?Q?kbu/kEqMEYBFEPBWPVBLsxRqPrUlbnq1CT8IIq9ZUghzXCTcAqA8i32iWnsv?=
 =?us-ascii?Q?80dlKgUEyKtIH4HwOZf+kwUV5nCeLWn37+wGD9xK80YLJHBvXMzISBLZqt/B?=
 =?us-ascii?Q?xNBG3o3LDKbgmiqPBnM0OGjCz3JvIVhJ7WkjIg6zgndm1ZNTLNZFRwX9Usvr?=
 =?us-ascii?Q?coEHOli/Qs/Cwl968v3A6XaQj4qdgsOdGgxkJ/5gITMK1K+qZpT7+HxVfTsR?=
 =?us-ascii?Q?4P0tg8rfI73t1iZq0PH/TTVqPlcY5Eo1Aiy3MF+KrWl71Je58LkMH+VH0SVn?=
 =?us-ascii?Q?YrIu93FypU5YZZO0nqJDCSt+UQLLkOJp3rqd8plFk8qKaQJFvHiZThgHbvMF?=
 =?us-ascii?Q?S7fhCsRb38LDlUOTldfomenyRaJ1yY/oYq0twISC0FU4l5HCdJzR8mB0o8is?=
 =?us-ascii?Q?AMm2YkCeKKGByta5hY+kVgkylkG9TEqz+HrwPi5qKw8Nt7tbyLRic33gmhlg?=
 =?us-ascii?Q?IQf86lN91aWMIVKc+s0wjA5Wcou3PGAd/YLo5OQibw1fGJBloSl+ceUfA6Bq?=
 =?us-ascii?Q?l0UVrBWbLgygg7qc+a+1lUVWk0OnJmmPwo34A0rReHlNESyIyRlyrwA/Cy5E?=
 =?us-ascii?Q?v0BOeIwNgmSx+Whlc+ob6AzyNbIKs6LTzcta93RVriYGsX3b5d4oRei2+AwX?=
 =?us-ascii?Q?tAWg3MrqQhZuDLxi3pq04XzYBKCK8YFfAiretgkezI+zdkEtOjnLoOUqvt6A?=
 =?us-ascii?Q?1Z/tkAjGAamiGTzlyHiZBzLJmtgUDn1giVwdIyjIQlf9N/oSHYTLiag9t9Ua?=
 =?us-ascii?Q?x6oWDEJ7k9NdtoZfogNbHWqgd1JXMf1zamel5MzckRc+1ACNotEGS3XKNRiL?=
 =?us-ascii?Q?WsnluH+fYI3EoxfbPt8JaZerV92w7PndBWelrF0lo2PM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?27NLtXhjAg242x1OOrIydYbe/I2k0N7jewPr7vjELWxhX3foCgAr9GoqOrMz?=
 =?us-ascii?Q?hgahio4ctoOT8JXf+d2tnnjdjeskBc1dP+gDOAPRfIZMZLEr24elsGXJKXzf?=
 =?us-ascii?Q?E/UPaIgz9DaRVXzCDuz7P/DIhqe0vk3xBU5+S+X/lG14jWKtqn/0n84Quwzt?=
 =?us-ascii?Q?8yP47Am4DegFHviF4jPub8LMlNQfsAibqQqRLhKcmxngWrOiCfh/T1KMmtvI?=
 =?us-ascii?Q?gcaXcLean/LjRxiVZWv1y66+KOOUprPRkLnKDB5ZABpOT9EHzk9u7kNBkciD?=
 =?us-ascii?Q?6LFxbnY7eb9RJrPM95aDQdLEDcybDRvZfOeWwT6Y5rdmN+iNjWl8Pkfd+rWx?=
 =?us-ascii?Q?02e5Yo40izqwq+23tmvaRME52q5uxpJPsohkDOJSZQFCJSdwJ1OMixeSpdRP?=
 =?us-ascii?Q?rHYBtbzNuLFegwJoRIGIKs6MaccHoGjfJWtlcWF9iZ1+xOUAH5pBg7I44nT6?=
 =?us-ascii?Q?RqWTBkB6xoet2JqI1NGkJLbOQ2h7Mmb5mRonhkdIXK1oFffJR2mP8GvN9ZJE?=
 =?us-ascii?Q?dyhwti/NauyoHEHb/BIw8NatEz94e1JUqdrRGRtEuF2jCE6PND64xW3bZo6M?=
 =?us-ascii?Q?L5umhA/erjyBCiKBa32IcJFgnRuaCSt3kiRTUU4+y0+2LljTYY+Lhg89T3/T?=
 =?us-ascii?Q?kBqQeqeeGiteWDqOjBQsIDSh8kovEykGe3iU3Z7EdeMnNjx84tW/rW+J4xKL?=
 =?us-ascii?Q?0HGJ1e1F+mH8Z71penn1fXD0in0rlgnUwb5X6tmJ7Ur500VBOqobZDbqZV4P?=
 =?us-ascii?Q?YTWqnJ1S3w1O0kXRVTU1tqOcyZC0PWXmmM1gaLwcbwdeIDOKvocZtc9vjLM/?=
 =?us-ascii?Q?T8ghxB6y0c1hXdC0IgzG4L0sqvqzLPAagq1lX9DgpXWkKysXonkiBckAi6+z?=
 =?us-ascii?Q?QrfkyxZQqyJ4Z+Fyq0qkxD1Bxr1rqvC4Ywc6sT1M33WsXz599w/SvVHBPPLZ?=
 =?us-ascii?Q?soUmwWWfE3ARchcmmUDYTOSZeKHs2nfGIQ7RD6uZMvOGhATOfNevyN7FPA/1?=
 =?us-ascii?Q?b6gXvWwpv5kpu2xlGLdxqP50GV0jt7clX4+yG6/dB00u8z8zEIqVEXTXHxnm?=
 =?us-ascii?Q?f5Zan+XvddE1qrXWk4UerVigVDSoyop8ym7nclWJzVTsnmjFP04WMnZ9Mm9P?=
 =?us-ascii?Q?Gs5EPDnncU7uZq53fNfGVx8uZARoypDtzrCmpIcPttw7uYgHZH2DvgCca2iM?=
 =?us-ascii?Q?mqRNPrw9ZsPTc4/whEMLWbbLZMaulmWol7oz86urBqZ8wbAyIZzvjiRsoODY?=
 =?us-ascii?Q?OuNvvviw4H30oCURWW5dC3EIC/cQL9yy5CZapJm83Col00S9sppVKr3LCfXx?=
 =?us-ascii?Q?XYHkIW4PgQ8TWFv1EVOnzoU3Fbu1pZpD3G3x+EtzJ7RTpj4SgrfItXPLlVnR?=
 =?us-ascii?Q?E9tBe8Jj+KsmdSMlPWTgL7hzVRemM10h86V470L4AhXjA7s4Px/9Tzk1vzph?=
 =?us-ascii?Q?8RVFJrA7nrVc9LF8SQuuqGxPiOWFOdLW/96wZiKR/MROOhS9KthB53WGxAB3?=
 =?us-ascii?Q?Nhm/xlQd/IVk3FTSWg3qdPhkg9v0zq313zSTB8+4hTXf+MY9tt3IPb787g8f?=
 =?us-ascii?Q?fbjARK9GCimtIVkgzX4t66q2J06KZFLiL9R58QJhs+b0J9AvxTpvN1eJIVVP?=
 =?us-ascii?Q?IvaOclo8ndOqKikJwsBeYl94jNNedZTV5KF2+rXZKVGKgshyIkoYhGBZTuqN?=
 =?us-ascii?Q?NSaU7Jlw4Ps6OHF4Fzrd6LoznuijUExt0XssDgIQ+bTyC0I1At1sq+msXN3z?=
 =?us-ascii?Q?to4qmjfoiQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ac9446-da06-4229-f6e1-08de5a26379b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:12.3612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNr2KMRk6VQ0WnHXpbC2Lk8V2kJ0+D1MZfq8hNrBivIJzv4DiAkKgGINSPFweVEewmGfrnHE27Pc9mN2c0R7Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252601-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 086306F907
X-Rspamd-Action: no action

Extract fec_rx_error_check() from fec_enet_rx_queue(), this helper is
used to check RX errors. And it will be used in XDP and XDP zero copy
paths in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++---------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 85bcca932fd2..0fa78ca9bc04 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1746,6 +1746,41 @@ static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 	}
 }
 
+static int fec_rx_error_check(struct net_device *ndev, u16 status)
+{
+	if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
+		      BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
+		      BD_ENET_RX_CL)) {
+		ndev->stats.rx_errors++;
+
+		if (status & BD_ENET_RX_OV) {
+			/* FIFO overrun */
+			ndev->stats.rx_fifo_errors++;
+			return -EIO;
+		}
+
+		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH |
+			      BD_ENET_RX_LAST)) {
+			/* Frame too long or too short. */
+			ndev->stats.rx_length_errors++;
+			if ((status & BD_ENET_RX_LAST) && net_ratelimit())
+				netdev_err(ndev, "rcv is not +last\n");
+		}
+
+		/* CRC Error */
+		if (status & BD_ENET_RX_CR)
+			ndev->stats.rx_crc_errors++;
+
+		/* Report late collisions as a frame error. */
+		if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+			ndev->stats.rx_frame_errors++;
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1806,29 +1841,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
-		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-			   BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
-			   BD_ENET_RX_CL)) {
-			ndev->stats.rx_errors++;
-			if (status & BD_ENET_RX_OV) {
-				/* FIFO overrun */
-				ndev->stats.rx_fifo_errors++;
-				goto rx_processing_done;
-			}
-			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
-						| BD_ENET_RX_LAST)) {
-				/* Frame too long or too short. */
-				ndev->stats.rx_length_errors++;
-				if (status & BD_ENET_RX_LAST)
-					netdev_err(ndev, "rcv is not +last\n");
-			}
-			if (status & BD_ENET_RX_CR)	/* CRC Error */
-				ndev->stats.rx_crc_errors++;
-			/* Report late collisions as a frame error. */
-			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
-				ndev->stats.rx_frame_errors++;
+		if (unlikely(fec_rx_error_check(ndev, status)))
 			goto rx_processing_done;
-		}
 
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
-- 
2.34.1


