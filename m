Return-Path: <netdev+bounces-128116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB36978108
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FC61F272D7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1C1D935A;
	Fri, 13 Sep 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zg+VgAqr"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013030.outbound.protection.outlook.com [52.101.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738051DA630
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233691; cv=fail; b=du1JbMEjmhCS23y/djLeMT4zseNr+7CEOTb+sp5STW6Qe1XxMGkd1ImoJRgWj2QKVswbsqrHabWQ0ARzTG+QLPcxQ+xXIMUKeG+90Pymw9UQqsQDkcYiBazXpp+ZG3lB/xHxa2yBFd/9wNA1grBFZvnhiEV8Vza+ocfuxUyNdUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233691; c=relaxed/simple;
	bh=N8Ky7sb4LrzZdybtUdEk9XlOXNzgqVKLZhW0IyWbiBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KdLLJRrd8vFtEvEr+h47rahI5DfoIQKyyrwUsdj9QMVPs9iMtYdAx5MeHlPUApzswjnpwRpdf52gy9ry/HIXocWCbGvZnUdfR5GB6kjCOgA0fIAqZX0gN0rdi8yQ/c83XSXu4K6V1d8SoxUTcOXqNjdhLle00xBfkihgnDtSt0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zg+VgAqr; arc=fail smtp.client-ip=52.101.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd46eqlcsTIaVV1+7sGENxnig9GzVQUqv5dI0+LKVaUHHtic77e23S1EK9UD9g3kEn1uJFpo6y+Rxt3EQzhzybKy34Eowwoj6R8w06qkp5mG4NTtrc4x5w+ZdTkucCtBqie9lKPJb1RXWAcXtu9BsQAPvpj6780l3tLvMBjCEux9Z7dLpr4GgzLTt0ThiUQzD+iNuUK8CrnjtN/x5XXznOF2f0eF/MM1iZJbdHHUbhOEuBK+dzgq/XAuNZmN34I+oSKD5v7+JWa2xaBwXRB3aCjOJMvhC9YGY1xpBfSbfbc3qeO0v4GcBjNIz8UsWR08sjYKyvXq/K2udBpiHf1A8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mqyRwq0R8Mm9HsYNXFNOufWGZrWjC8qNy1nt9oHQhs=;
 b=yWV/lD1FjFwmUzEnYeZYWX599ONo6/2SVQi1g8Oqq8kQHpLIOxnscQewngtz38IIBKnu8aTosa+Gj6h7mmXUy8pBtJowqdyylO/bDF42epam8Isly1b08GpXr1+V3lSuQLFgJ0ZQVOdHJPee07u7ZKmQQ5SCU/+9Xw7We53dpIq8OV9mY22u+JN+ESrKyO4R1DNvBChE3YBZB7FGNawWDT1M6Z92e9CSLRLKGCRCljxMsSFzMEn5BFdHPrhIKYoBBhwrBbv59WWmuWVwv9BwYg//JTV2+gFShbc/ln2yY6BxgRc+cPQ/DCyeaV+fb4BJRY8pzVOdZG/0Z5vwGwmIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mqyRwq0R8Mm9HsYNXFNOufWGZrWjC8qNy1nt9oHQhs=;
 b=Zg+VgAqrKSVH4WZOfI3aoim1Y3irv3/fRDiagIKcXJgYaFp+dby3w7h4fUBrMuqCvoIExS4uP3i9hj/SACZf26ERLHVSYX+9RhVpOhgPrLGZ+GuwLaAJUPlhxhNjJpPoXOcZmFHQHQqmQBrlpwFDkoJIPXusD+TgbCPuk7Ps/BiQIZIr6ss7uNqu79U2PHF2MaItpmkLntdSuaw1nBrWRMY/dXUIcimA28omeuaW9hUaBffLPVu9VnF/iEe7c00QZn7LkFtMUeF2vDU5JZPqZERp82fOZCCausruSzTqnpLw5IxBF9Yh/2LPvDlqWp4TYbpdy6UPY1jvLWplBRqpEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8842.eurprd04.prod.outlook.com (2603:10a6:20b:409::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 13 Sep
 2024 13:21:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 13:21:26 +0000
Date: Fri, 13 Sep 2024 16:21:23 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Hans-Frieder Vogt <hfdevel@gmx.net>
Subject: Re: [PATCH net] net: phy: aquantia: fix -ETIMEDOUT PHY probe failure
 when firmware not present
Message-ID: <20240913132123.ipjldglefg34cbcd@skbuf>
References: <20240913121230.2620122-1-vladimir.oltean@nxp.com>
 <CACMJSesEsWXvb6_-VvdD9T+6TP8rYt+D0pU76KEGwRhU5j0RVw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMJSesEsWXvb6_-VvdD9T+6TP8rYt+D0pU76KEGwRhU5j0RVw@mail.gmail.com>
X-ClientProxiedBy: BE1P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: d70ea60c-3070-4420-7c6b-08dcd3f6f83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PgZZlPKPNXJPASx7TAtdy8acD7f9mRQqzAll+aIJb6e59kSTwib1Om7wf0Nf?=
 =?us-ascii?Q?lx73l1HbmdfcW5rGHDeEAGUnlnHrklzdk8XZHsBk26pAa9oqucI12SZmne8P?=
 =?us-ascii?Q?+pKexmp6JBACsos7bTF1oaoKzPRg0pCyRc2JJ1ienoy7Nu9wpD/s17v9cHbK?=
 =?us-ascii?Q?/O0oxXZAIW0R06g3FR4MkEeMEKj6gtypmLgnVkjyJqqkOKPXT6faMVMxFCZ8?=
 =?us-ascii?Q?/i8uaoTMNTutF1aUHkhyK2Z4Wx2QNkh7CcFcWa4Rp1yWVJ3aKnyrROSBumsm?=
 =?us-ascii?Q?bqm2UaFn3Qb9Yq1U254iNLNvCI90Il+cGC+eMwiv6epQO5f3r5MQyW7IAJup?=
 =?us-ascii?Q?2KogK86ifLSUmsuaeFm2X3wa5Hzhk1y/VgzfPsyh3bPp6bq/uQ74MrfFO7OT?=
 =?us-ascii?Q?r5+B7XdJaX7O4ipmGkig/D7pgwbDjWe8bbFgAPk+iTDwHlHrj56xnl58hqMh?=
 =?us-ascii?Q?JXNf+W79onK3kyRZrnoHjcYuEb14AydNlPn8Jw1ZoySQ79uKmpL/6RtbH4/Q?=
 =?us-ascii?Q?j7Pyeh+dbPiGnW4bIzAbkk0Jpv2taQKzvNvrbyEyFiPn7TwAKbIRlrlatg4q?=
 =?us-ascii?Q?SoSRxK2GMQDN1OfnvKpfUnZwQaSo6q7ECOYwJV8fo0GU+F0XKdlLnNkSuZUO?=
 =?us-ascii?Q?c2o8nHzB5BSe5YVRzfiStUY6Q0nDDGrcco+qky8nmQG/WbTln42VLsLa14CM?=
 =?us-ascii?Q?cj2FIrGMVU/qEnA1uBxLPsXk+dqGlAyvKx9ICILdNbgU7XpJYOHbd2BjwTAM?=
 =?us-ascii?Q?GuYtvvmVyLpSSujcOAyVn52MTNXEEB29XTeWyOoN32DEJXxRlY5jbeLwuR9E?=
 =?us-ascii?Q?jI5WHHtd8/0WC+SW2v08ywAZ0pH7dFPqGFdJkkiHV3TtEh2pT5G6qYVz61oZ?=
 =?us-ascii?Q?vF7fvhT4cvkDbY4J+zfRRzKsu5EnC5lNmJULbtQlFB8aQ8JHnbqYtzp1fI5U?=
 =?us-ascii?Q?vfSCBqMfamWk6ov1oILEAv2CIzAiXTJbzHXteu0VWdt/gZgFlSFm5cT/cPyj?=
 =?us-ascii?Q?RSiLHW0IrKIhQ6dS+on434yb6ixsNq5lCbt+M8ttS6zoAEfXJkgq/qCPuQ8e?=
 =?us-ascii?Q?ByLzvSTqV9g/PClxhNLs9ZqeBPUf4h6skcS2LTdGNR4hUqpv7qDzR1AcotIm?=
 =?us-ascii?Q?0MNRuIe/sf4kvvcY7/rnpgguztJQEYDATcQePYyTQQ8Fo3Vw9hPdTVuNR4Ij?=
 =?us-ascii?Q?bded0yuC1ExPz0Hr1fhA2DfgIDIaBEnjwwWYMGx6SFrMQHVUPnsMCzynMHg1?=
 =?us-ascii?Q?HPTJSaXjDpzGiObJ5fahnrheqGxcBcnrDrwSpnWnExVE8DpRXjh7EkiPZkTq?=
 =?us-ascii?Q?b75bAyL81hbP4tiSU2n5epkZD07ejSHb7zMZyhzIgN5MEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O/b/0QWslwcwl0Nhdb6DFE5kfFVgb3llMbk155JIZ7sWadQelW2kNz4mocMy?=
 =?us-ascii?Q?MzKTXUiK58Zqg337puTYm4q68JgnCTXRaUIDOkvCYzCcSZxtkNAO5hsKmbDy?=
 =?us-ascii?Q?5NQALOrctBGlebM7RAcLYbh3cyeDDky3raSbgWMUjrpSna+RRWANyHNSqf4h?=
 =?us-ascii?Q?kwTUJEbojPtOlq7fvDIQgzKLqMzyaj/8VJ/SL0Z5TdaXdG9kkaaHUNqSLfV/?=
 =?us-ascii?Q?rq7hlCiSfoq9MIvgTRurjsb1+tJluki9uzWTtYPixsy87CaJXi90HiXlX85f?=
 =?us-ascii?Q?q7OSwo6Z9qy3ssWKuhwsmfKoZ5cSF5H8jUS9bf6R+qtueJNJ6vDfozQY0GPL?=
 =?us-ascii?Q?fD86CGnSf2jY3UaODMjZGebHbeNOBK8rjFveA6JPdWIhe2FLD82RVL7qfGqS?=
 =?us-ascii?Q?DFME4WA02NIg+lKqNR0+AvR1ZPAxmBxuBhmTLZ6m2P9HSBv1ZO3ci+/PeCYk?=
 =?us-ascii?Q?ktocb+ZS2XJ6EehpruFtwECerHc6PRk94YzNFWyUi+e205g86jo/RBQPvzeX?=
 =?us-ascii?Q?UYdsB/apUiDAQp5ecfzv47XiZ1SF9nqkFPfNaBTlFadCZo/3bnPGi3dsUjmo?=
 =?us-ascii?Q?mOrICmMPKZdJCN2iaupqKdf/fl5CANum6gzA3+Fyfg4rq632koKwSmKyU87T?=
 =?us-ascii?Q?cZfQVPzTrwQnD3xX4s7zml0PE4OdpSXxLfIMKZDefVWsyz7P9pPqFgZAPH0P?=
 =?us-ascii?Q?NyUZBzHWMxK+wJ87qfJzZJ7e++fCIghcuG2PxvUO6tRjhvlHjuHHf0om1O85?=
 =?us-ascii?Q?J5/DopmLGUsNqdy/RycpvWS1G19s01MUFdi9xm4nnU+fu8dOqNiDJYjlw0hp?=
 =?us-ascii?Q?ZNJtoyEmKg0V7DSBNOUhfGW9LG/3q5O5S6odCGF3frTd8s3Of4nNZNBuaoiC?=
 =?us-ascii?Q?m2VMsFJNSmI/GhzWaBCNkh6xNQUER4zvPCcqdsNKnNH0z5FOi9iuPVAvMjCI?=
 =?us-ascii?Q?+DRhNLi8GOHerOnchZUQo4pfnVTOWREWcYshxyHyDutkdvsUobtbv7a9MLfg?=
 =?us-ascii?Q?ADEfwRDvkuM2t3F6rlUk/uG8DcY52Ik8cHw5821B/nNmlI54rN2axmy3db54?=
 =?us-ascii?Q?JFBqA9S3BlkQjEYjbOmWsxh7zcdBXh1CO70AeRQuQI/HW0OT6CY4TTlox6AA?=
 =?us-ascii?Q?PRkZAUwwn0nCU44Kna9FdZBh3onwTCFbomdR8vlZYR5zNprNyqDHFJehq5+7?=
 =?us-ascii?Q?YTl1OeG6D0lgXH//PiLQo9/HYmfUjerrzhFOK72QF+MBUH3cbEm+3EiYfY8p?=
 =?us-ascii?Q?sTWSwpbIAHnk9uojU/HOpwTobUNeIiSDRN1SG1hg9tsiyiX+q2nGEAUGvD6F?=
 =?us-ascii?Q?4Km3K7/cxlUoOmkOOz8i1/Wg+326sbYmwOvZ/Ue/WiA19lv9iOc0J4KQfHMN?=
 =?us-ascii?Q?qaFB1SLaS2pRY8WCmRM1GFfiMHq89YAnqkUlyBOllAI/CoO1P4rMZIn9GxiO?=
 =?us-ascii?Q?VRCqG79kehHvQK0AZ0Ux8NuFL0cNcSMeWTz3jckU4K+VGDbPiq8RvyTvweup?=
 =?us-ascii?Q?WpsrbpUM3qWjMP5tspXBJdYJpFla07QE7v6Oxcn5ro49+OQ6v310REc6WmPE?=
 =?us-ascii?Q?hsaiQciFrPj5D5dPT4cmMjxZWltNytge2eoaEacj9Efh2mQLNowacyIj00AD?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70ea60c-3070-4420-7c6b-08dcd3f6f83c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:21:26.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8SQfYEwpkUc6poeJgQfM/kHcfRqvEqPKvoDshRjzoCPx4W4OtIoyNtbooD9RjzR7/8MueePXehhIzz2wqjuwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8842

On Fri, Sep 13, 2024 at 03:18:42PM +0200, Bartosz Golaszewski wrote:
> Still works on sa8775p-ride v3
> 
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Thanks for testing, I appreciate it.

