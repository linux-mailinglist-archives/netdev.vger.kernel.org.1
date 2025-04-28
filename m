Return-Path: <netdev+bounces-186478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04156A9F56C
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543BD4623D5
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF482798E6;
	Mon, 28 Apr 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YMSZPJeu"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012025.outbound.protection.outlook.com [52.101.71.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E55279359;
	Mon, 28 Apr 2025 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857012; cv=fail; b=sQuTTP+PHeZyM/0FXVtSNnNQhNqKZjUsF1KAYMsfiStGIdn6FiDtGM7Vz0FqjELAJr2LYIjQVhC/1fNdjYI0B2S6iNix5lPc0NJoAsDZCdjDeRR2k9hvNkLLpfjaYg10Vw8ptLAM9/KOaC9eurgPfZuc8ZP9SF3MBm7OeVnbMEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857012; c=relaxed/simple;
	bh=Jn4Ur3+o49kOmZe9t8CXlbRVJ1k7taI8CrmoSgHuahI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ETZeGCOrUc24HBeoRlnSIsSNDIEcQltAZ47fF3lfCZo39z0QZq57cynxKrP4UjEgvSYjeWx4odmSZDc8HFg+yH3Z6L3kAEtIrWjQBRj5If3Y1xQRthlg6hgrHqnXBxW3oWuWNpJ96lktBChDmTuEWoOAr0nAue3m/nI3JUqvPro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YMSZPJeu; arc=fail smtp.client-ip=52.101.71.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ony06w4zXTapoVPPMhR6Hd2U9YA6khCF7MGZOisQ27WgVASu1Pn1/ZFAwsNjpGhbSyN+MnIiczmeIIxfCTPPIygIP0iNXeFVNbbyVNc1Epd0etM9bu4c7TAHkCrzQ3UgEtjtEH/5ova6DX388zUwrvCoHwNJSb2E7UZcwM8VPh08LNJGpRPJRanVVGWiytxffZBr2S77MV/VlEIiJHJZIPXJ80xfdvzMRzV55bQeeM1Ez/8JG+sCu9jEnkh/5S2N6yvSXHps9MST40ZfdEuPQPZ+7BYjV13VpUP4SK5wsUDDgxvRdqQygC4SKOHCY0LkiNRiN0Ncls/m+iSUtxeG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn4Ur3+o49kOmZe9t8CXlbRVJ1k7taI8CrmoSgHuahI=;
 b=FI3RAK/1hCdeHHH7uLJLf2W9BlRixjlQUPVci1ZkIrhgCFdHvcHX0rDpQN9W57EhRrPbttwriV2TdL4D5B7Qc0Z69DXOglAYbncnsv4QWLg3xT34iEVTePdzFik3hBDo8xjtF5Y/xwIks9pkOHV/OYynsp3WXlMDfT+Tir5sUcXZQRBd0HLLTFUYYCDInnuv1pmBfiBxgpDoX6/povDTT3tNJbW610yB3kj4z80W7ZI4wOjZjLc8238wRb4pqSyzkIknvZixTxytRwF5r0VEzfV41cOFf1cfCx9V8Pw0YCEs+qaj0iN2jNFaLyPhnRShMJUE5UAXlgZphULWJ+M2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn4Ur3+o49kOmZe9t8CXlbRVJ1k7taI8CrmoSgHuahI=;
 b=YMSZPJeufgjp5zIh0Pu4jXfSQiVRF8pjmnXYXF6vVuL+K6uW6icAaig3AqxmTsNhmGk6gqCU3rsK3W92aP3TN2Uo88xkfc3D/n3UrTU2qMzB4kvuMdycEvksggUkje5mh379pxq1h28qBfuEdClGiYS2Oa6mpm6dyOtBVO6rTpPrm6d49/yAyZSW5Z3akdYe/t8GRnPgkals5e7ezoi8kLva+bhi2blaGOVfcnS/H2716Yu5hKU+aig3bnKMScYIBg+eyCvDreC/ee84VKJlXIdauwkZmEXjBXonvdcbnsFvEdFaUsKayO2wMUTEEBkTKND5KqkP51XfeFAE7+fZ5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DUZPR04MB9726.eurprd04.prod.outlook.com (2603:10a6:10:4e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 16:16:47 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 16:16:47 +0000
Date: Mon, 28 Apr 2025 19:16:44 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 net-next 00/14] Add more features for ENETC v4 - round
 2
Message-ID: <20250428161644.ygf3bg6pyyfftccn@skbuf>
References: <20250428105657.3283130-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428105657.3283130-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1P195CA0095.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::48) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DUZPR04MB9726:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f6c3c7-ff7d-4fce-2c91-08dd8670131d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vPx+WBx42FW0PVl0O1b5sD597yx1F6dddEou7HmXPqkkKQFG1FS+w4Z80i0I?=
 =?us-ascii?Q?cCwTfC8kJqI8ya6ySd//IfVWKjLtmkINQQDY6iMdaxGHII8QsLP7c+Kthlg3?=
 =?us-ascii?Q?e8WRUaLWHeAkhot6ucSFHk2azO9yKUHmhudNDz2rBU00KUmqAatK0dB8lEV4?=
 =?us-ascii?Q?Zb6MaOsWHVWZ94csK3VT5rXBDcW33lWUpS+B+NPxvSMUQybOS3KXtui+1pjf?=
 =?us-ascii?Q?ZcwauLu7fMCOrTN2NtC0E5LxlaV5ZkLiDcoEXf2xDmASWkeT6cn0pDqt4+Q7?=
 =?us-ascii?Q?hF4H0yU29Wd7rfxQUBytGAjqUoJjRZeMXIY6CmT/xe0ivbw8mcgBbHBZJS86?=
 =?us-ascii?Q?RBkIcFsSyrDgZVT4jjN90wKNxbm2NT3SofxrALmtKEytNB0SaUrOYWWaDj4j?=
 =?us-ascii?Q?HjrR6u5dWF6/Gz6RP2VjCmgwKEqkPf+vQiCSk/6KNatw4nzEEIExlc8DNBFC?=
 =?us-ascii?Q?jJ17Q1godId4d+GSk6vmp+38FSUSdHE27x8PqrI/SvQsGqE2+bjXK+OZ3dbV?=
 =?us-ascii?Q?mn7dKVwVWQrbWtt4RAhu6clv7rSqrAmCSb7OyEyuxh7Y4VBz3X8Ht8B4qtwh?=
 =?us-ascii?Q?B/TurAOa7U6OMGUNbi/itEHFmQwR8b32jUrahd6aBtvi/HgtEhBYgJO1hWVT?=
 =?us-ascii?Q?iR29BuOXbjz65Be/AUoP1XNZwAL1nIDPsuKVbkKqE5juvyzxG96BxYASPh94?=
 =?us-ascii?Q?RgAaigokYzKAxLNevtX6BZ9rbNEPO+3aYQ8kKzb1QNamBnBpCOAptR01ikSx?=
 =?us-ascii?Q?iQE9xXhl8PQV5hoHOBAQ0HyusfNRohoRwZoSJmzwKz8KtALgYG9fqi/vuqEo?=
 =?us-ascii?Q?1T2pYhmOA1YbJYvOyOufj0nelvzkXb97u9VML8SUUHikX+WNWGnDTOgqfYlm?=
 =?us-ascii?Q?yw1qlSorv0UmvP9QtIp9f9nc31714uUVtz3IgaUcF9H/Ty0rZAacJaIhlfTQ?=
 =?us-ascii?Q?L2XmI2Tt5bMo5SeGg0AgJvbJXZcaDA9PQQMjtx3NU76ETEWCs0L5gh1ESfhD?=
 =?us-ascii?Q?0e+L6y4ZPV+nnBMUzBdcuQCekwe/Hrb+GhqP14I92NhI+wG0EMgb5u3WAE0P?=
 =?us-ascii?Q?JMNrWoEcJTBp8uayuzFd6h7uo1gmJIu0FEcHr8c3LdX9bknNf+LqECDEdG+T?=
 =?us-ascii?Q?FuPh+jh46lPc4PyCJvYM7HuqvrOQHjtphFWoRPK+AU7szECCnfpyv5+wObl8?=
 =?us-ascii?Q?rARF579/xw/jxSA0102v/ltOu9g6SPfebhjqC1lDgTp3PC5L5squ3rDr6NMM?=
 =?us-ascii?Q?Mwoz6h0w4mMdknYXyxkkRm4Jd8DFkpeiUYKjwKPGGQMTHKINu5itMMJD+NTM?=
 =?us-ascii?Q?1yBuCz/g+eZ1n6N2/1C7nRjCpLIJszzXytDG3d2hAUzgSmFK87E9NoErCb5T?=
 =?us-ascii?Q?zUEV8JTcpO9bdb9vpoP1/7LMIpvhNYEMc/vCtTEnUNqiFa/vd2CZh9KoPszb?=
 =?us-ascii?Q?2MVApZXxGO0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nJcdZ5UjsWX4JR7kMwlXRyPVLj6Pm/dAmKHzOgUiARc7haVyWy/PDoLsvcjp?=
 =?us-ascii?Q?BfwtFcfvGJGxmA1Ixjl0DvNv4tYA9nWQFb7/27vE7f7njKmKzQMjD00NLRBf?=
 =?us-ascii?Q?UFDulKUnV6GV9oV+jcrCm3LKYkOCJTmQn7q+r1lqJq0kTmk82U4ofb6nWeG6?=
 =?us-ascii?Q?ZYKruLymbpei+u1jHEEKaRG+EvaVd78045XnDUazCixl5HRr+En9WXiseglQ?=
 =?us-ascii?Q?hqa9g46OuawOjzQmOvcJ/pO9f1nYkskPxvyCWW2U7kg6fL25gr0SJCKjx1vW?=
 =?us-ascii?Q?HMLH9SiNQuYPeqln9LPqNOeqqZ//GaQJ8pXRt+cHCRaOFNBVONfqZx4/WuA1?=
 =?us-ascii?Q?WC1ldT/IiB6CERgt19D+KAaFvSEybD1+QP8HBhb+DYcD/vEuERUSuNqfmMyL?=
 =?us-ascii?Q?W9mGkl6DlV6lwW1dz5ws/bFEMOiedxt+fI+i8fVmchQM/rRDewoov37Evvl6?=
 =?us-ascii?Q?9/kAAgyE23KT1EcHjIUl1uwZ87xFt+WsrKcHydyyZFb+c8kioj0XUM7XMxOk?=
 =?us-ascii?Q?86CMRiF73oNPOxhcr+HPsvx76xIjekoXa82GVz+2TMkCdD6VN2MViy8SRHtr?=
 =?us-ascii?Q?mohG4WVSF8ZT64TRviJr6R4xour5fs/vMWYe0Fpuy9VWE5VLrkAbtf6JOW70?=
 =?us-ascii?Q?3M0nz6zuMSe29+BfdZCOTnVmiJyV8Qof299cADe59xLFq59FLn3MM5gXzvGo?=
 =?us-ascii?Q?a5Tuh54pZwUam4cxHGjcGPe96j0tG8AqS2avtN2kpDTXjjbE9cIc4usEaIB2?=
 =?us-ascii?Q?GMwfh59DKXIpEaQ4yyoT7m2RkmE6CUBt1I/4Vs8zh76jFJvMGtSHTpFIt04s?=
 =?us-ascii?Q?L4f7HlzrvMhavWInOk8J/7FXV2dYkxLrL1ssv/dyn6WgCzkbsG5r8o7sgoIM?=
 =?us-ascii?Q?LM0UX/lIjulCVPnopjaL8Eqq13AbaYdilTfPSvjcbfDZTR7A6qs5Fscw247t?=
 =?us-ascii?Q?HeK3rYrZVB7gUlX6S0rGdqqTv/k9aEDi3tGLG4rkqVbsNwMZQViDQONTtRC2?=
 =?us-ascii?Q?5O0nr0iQdw81jy98kFAqiikRQS+viPk+8H92lc2xIGQGfpJF5BBpBy6ypmvp?=
 =?us-ascii?Q?L92ortGa+o7VfeedX1X0mlNHGQcQlqqaGGGg8bpRSh5v5jEH+QVjhuFIuWSd?=
 =?us-ascii?Q?m1b5gDdFA81o5ta7IFD1d6lSqWHczRrHmz3Mos2BTwJXHK9cadh3K177M4l+?=
 =?us-ascii?Q?G/ugboDkQBNBIy0F9PP1FeMPPeOo43qM5gb8bhSrs3kKpl9DpTvWeydJ881W?=
 =?us-ascii?Q?NWu9Qq8KN/gXH8FeVK/yJ3l885KDCMW9dc9C47YBwiH2CLuvSqoFsR2bb0YJ?=
 =?us-ascii?Q?zRwGFan3ttVVMym1gVMzVrSovIgpo6TmN3sNunY47+hraoP+Dex5DTog00mQ?=
 =?us-ascii?Q?GgZJ0pzS5RWpOZKExwtiF+8VhUDE3V9w4dkd3QdiZ3pDRtQ5SVKp2DvxJbZC?=
 =?us-ascii?Q?Q+JS/l/eNDe8GVDpWK8qQlE3wfI+RWrO7vPI0p4ytc8tRd24KpZUC4bLAw5g?=
 =?us-ascii?Q?8kjRIg32U/XF0gfeXvSkSaTPvfmqCwIcjkFteI3lF89ZHz31YyZ5zXvKWSmM?=
 =?us-ascii?Q?NrYWDZQrjHHcX5FTXkt0kV+B4kY49DvYH8o3Dj+mOUlxpltfqOBk4jEIjJhG?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f6c3c7-ff7d-4fce-2c91-08dd8670131d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 16:16:47.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dab0irRcnRX4T+DJOSlwDoyoH93Nbg1adiBUDDmsrZo2RujJHtUnefoLgd98RcVUXnjlBCw15jXP9kYIIsIR1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9726

Hi Wei,

On Mon, Apr 28, 2025 at 06:56:43PM +0800, Wei Fang wrote:
> This patch set adds the following features.
> 1. Compared with ENETC v1, the formats of tables and command BD of ENETC
> v4 have changed significantly, and the two are not compatible. Therefore,
> in order to support the NETC Table Management Protocol (NTMP) v2.0, we
> introduced the netc-lib driver and added support for MAC address filter
> table and RSS table.
> 2. Add MAC filter and VLAN filter support for i.MX95 ENETC PF.
> 3. Add RSS support for i.MX95 ENETC PF.
> 4. Add loopback support for i.MX95 ENETC PF.

I don't see any functional issues with this set. I am also not sure
whether MAC address filtering is implemented in the simplest way, but I
suppose it can also be simplified over time.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

