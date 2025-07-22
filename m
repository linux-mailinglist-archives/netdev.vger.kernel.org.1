Return-Path: <netdev+bounces-208986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC44EB0DF29
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0CB3B3220
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC8E2EBB82;
	Tue, 22 Jul 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oHKXrFVZ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76362EAB6D;
	Tue, 22 Jul 2025 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195008; cv=fail; b=sQ4bZF/BcoM354LpO8tmFCWl8lsmXX0TFz02rvYJ7ceDFaix948W2P1X+0jjZrEMj+OYRJ6Hrp3Qryszhn4ZxlXPoY/rKJILqFyaMqX96q6kZJ4YC7kcqiNBSwvUV4K24YqAeNozh/wkPxajDIbhmUn+JwMWHpPML1p86BslQ4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195008; c=relaxed/simple;
	bh=l+vmdkzDdfFfkwoOboEvJYuQJlpmy1vec9+ZUO8SGXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ArFmvPrhOWhusVocDZsbKSgtHqrzgphoJs/leqKqdGYm4CdqfheOAo1IOtkNLF2e4J/Z16Ce8kAf0Fw6fdlWKfIZPyuqQqcDbBactiHZWwMrGz5cLWTacd/53BM9GOokWpQeLy7gksOxTosfJuvhPasLmLJeP81o5i7C+5yyF60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oHKXrFVZ; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3YR81EGNkVFlcS5CsJE6dH6Cy/lgJUnDiu3srOX7tlJ/beAMz/HnVlyfOBz/eJl4ccOtP7W5KlU8eEaivgOHYIuPbvFSMTZZefzbqKl7e9JCYuOpe4Hy/tHmtOhUvjULkM+5FQO2mPwstE43GoCNETNDiLefH85OI3wkQCc20OrrdtZsfOAo3WDD7DFMm3sBW1U4ToSgs/RfT3cvsUo3y2HRbK902Uol2pbDBcZIo8YULmF8VPFYodq+9/SM/7QugMGuWDze8AUiARYob5Lp/YuBa+v2KveWVAWqayeMrARXUdNKqMfyY1fwHGrgWN+PM/aDnIFrejRG43ziUyThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6l9vCAqr3h83Qgy5ghlKIy6dmhGm3xGaZGah9hgzQM=;
 b=n59noJqb4OBCNJBd080HGcniw2Ko20o1LeNjJANnZkY1fwRLIyzQ/p34gi3TG3nglMcKf42kNcOixkYyzEoxiCO0grGCgK9PvNdEd+1bxd3swtQQCWPjvh7QJBiqY8eaxo4zsqUNd9OqNTUt7FrEYHPxsYYs/1alOO/axpKAjOAW7W1CspdiKneakMsWu5h2cb6ngTElzQCUzt+MrLclrA7VJnZqZgmPlqyfQrAt/0BUkJot1Y8D0X5w1DeqzJDnXC+7ofp704E+/bf9AQlSWx/fyXVZB/UH+DIsqnVQTuA1N4gYN9C664bb/44eGPDH/tnqh5hpYD9vlgvQstto/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6l9vCAqr3h83Qgy5ghlKIy6dmhGm3xGaZGah9hgzQM=;
 b=oHKXrFVZAg8HkRjjag19X8y470e8IoaPH3fzMJ8x9Ygc5l9SjW91ywcgzU244Ofu4VWwSL7HTyExOF8Yp5EufiD1gVbTXAkpW6ITycdbhU/IX3Sro2qEi6OEjyipBEz7UiR8elRkiKyvt0mReTzVNu2RLtldZSrIkOSXX+Akvkpa86N8kMg7QqC8d2d7ZvSm7IIERZ1HlCuoUix2h1Wpnkd61rPEgmJ1KY6I0Bg/TeLl5/f/ORvZ/cgIF3+lY2aX4Hx+tiyu6MBDWrmxRd6X1+OcnYz0u8yM68VLhbQlkQTpTmcR3Se46cTY5ZCZOyO3jP5ZP0/jaTd4c3p+WUHWmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PR3PR04MB7226.eurprd04.prod.outlook.com (2603:10a6:102:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 14:36:42 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 14:36:42 +0000
Date: Tue, 22 Jul 2025 17:36:38 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <20250722143638.av4nlnbqdhgueygx@skbuf>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-2-wei.fang@nxp.com>
 <20250717-furry-hummingbird-of-growth-4f5f1d@kuoka>
 <PAXPR04MB8510F642E509E915B85062318851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717090547.f5c46ehp5rzey26b@skbuf>
 <PAXPR04MB851096B3E7F59181C7377A128851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717124241.f4jca65dswas6k47@skbuf>
 <aHkRbNu61h4tgByd@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHkRbNu61h4tgByd@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: VI1PR0102CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::40) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PR3PR04MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8118fd-a960-49ab-2409-08ddc92d2d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|10070799003|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wm+vL9leibWb9M8wriv7Zch/KxW8OfW9P6oeHb56wuMzOfG3aqin0l0p/Krr?=
 =?us-ascii?Q?Fg1cOdiMAPrFymfxvn8NFPmxv/aPGS6Iv7VP6z4DDIhU6hXmbFfZ0kNrM0ck?=
 =?us-ascii?Q?n2ue2ljNOF7Vibwb/2fm88SHCl1tVizWuRVSKP1yCXlvXWUBUIJETUF5CNHj?=
 =?us-ascii?Q?Ila9f/rlqfacw5kzBoeHSvxu7VcEfEZJW7lSQKQCOaseaBsKX9EwPB6xDMGW?=
 =?us-ascii?Q?AuPFYSlKKR0nmLy0GeZJ4Vn4zd8vd9RyYX54fzFCuma0lDX0/SDE08Q3sMcu?=
 =?us-ascii?Q?KZQnzUu0cyNhdzBI80oQ6GTdeatmbUh2NgyZXFAw/l1Z+gjo7UkO5a+c4haX?=
 =?us-ascii?Q?nO+eOkQZ+Zfm7mXp15PXgHkSQ4uT8hNsmbUim760mXk9wFRJ0PUBKbB68cLA?=
 =?us-ascii?Q?vH6UPderw57hdL3x2q5bdRBKyMwgXAcgnxxpsDtjDksFJV5xSGtWXbdj/Te7?=
 =?us-ascii?Q?axSoTMibW7wOjFaoo8/VbxMipNVw+ke/q133ekrCewklHeNKLFoXc1JbTjrk?=
 =?us-ascii?Q?NSkxb3G5m62qIZ98b09ZWdttMQcueltw21XixOikXpi2sA9qz5fLUOnzBRux?=
 =?us-ascii?Q?pRFvNZmsyCTG6JaZfedOgIx8pFFlI5Ub71giF6I4PJzL/0z0bBvCfxBHQ0ne?=
 =?us-ascii?Q?+d3SwnUTigqWqR2s23OMT3KSoDMDGZeMiq88+0q3uPa2pjC9vG8C7l3Xjzcz?=
 =?us-ascii?Q?Dk0m4PMZuiJByD7D33/Xs2iM+Q1c0Z+Ozmkoubv7rCH+jRjwsM9PYGb0gY/l?=
 =?us-ascii?Q?o/lX2kSURQIk0Kh1obmjwYQ4Cfofr1TaFxjLtNqgFQRtNpZn0dMifXSx6Tvo?=
 =?us-ascii?Q?nZvo/sR8uU7+ZKTbKCBJeRgLpMqaZs9PhO+0yU4qZ7fxbsT3am5hWYyJ9sdX?=
 =?us-ascii?Q?//URuFHeIF2MCS9gtlLnzBD4cf4IGCd19365vxBiJW0opkKV76gDTjs9NNYK?=
 =?us-ascii?Q?ySfbqZAiCBwbwan0Ci0TKjKK2Y1nPdcsuGTiRbaLwoZtNAOgIcvPSYWiP1TT?=
 =?us-ascii?Q?Mfh1mVKNlXOV81iXD6Mqz6hxxgZ1ijpkMZhu6N0KQmT3JvE9jjPY8/XS8f/1?=
 =?us-ascii?Q?5vW5w/szXy+eXi0GSRE9qz5DBqfqrw9AB+66MRfqWVLe2s9LcAJF6oZpTbp1?=
 =?us-ascii?Q?Hug5rQ6Iuk4lr/TYbKKm8BKS4rJ7O5GpwYeRXx/8XlkEDhBq6n0qsDEkWZwO?=
 =?us-ascii?Q?voKSK4bH69m1QMshWRC9jRPHenDdDoIOZKHXdACBjR+DMfyBnWrLAM08W/W3?=
 =?us-ascii?Q?CFPQ/I1WnDQEZGmExAPlgEWmu49xRVhjvhbcLyV71N3x76jNZ3KxgfitXxmr?=
 =?us-ascii?Q?AvmdaqseNrJP58JzXHTahd77rkGeezlaKlBhIFIeNN+DffJloEcuUG8Gr3/4?=
 =?us-ascii?Q?jMAz1Q5XB2Hr03ff9jiFhlyTW4oFpkth2AbFA/iGJVxo8pcT7wdMCRYDs5lx?=
 =?us-ascii?Q?mKXeQ8vjtl0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(10070799003)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Y0tVa8F3Nd9+3NrTh4qSkpQhvJfklwUcZSJmAgnOTWEm8IfW+JaKtW9A+5S?=
 =?us-ascii?Q?jWTrRxjJIWT7g8ZH9BPDE58nzhcVtutDYhIIsc19jasdSAdDO6OxnJAVpyjU?=
 =?us-ascii?Q?6OVCPCCgHqssKR4bGrf6FjDsvHWoAWANhPEYBwsPC9jgcwKLjYFsK6CVCa4h?=
 =?us-ascii?Q?hDUKvvFkumqsKtJ2a9mh3PM7lC52qmMCS1atzGL8PVRUHcZVhnegv45mjaIe?=
 =?us-ascii?Q?G7sXtpefCLIgt4UQOf5bn2DTREFFNaRWHIkYc98Wly5+QlM8UV5KEKyEGlZa?=
 =?us-ascii?Q?QKVLzi6Oq1oyRg0qZSDKcgDtEvD2+NfBBRCevpKR3xehhVkZLPanasyA01p6?=
 =?us-ascii?Q?gHGhCjJn3XwyjrZQfgLSOhUMeTvjL7PhBxCJJu4tMqr1SHyRDfT2mBdeseJH?=
 =?us-ascii?Q?Hy1af62KsxG5QDvUpQzLu/77ge/aoHgsTv809OgjiR+FoDZ1ALpkxi2f/f8f?=
 =?us-ascii?Q?rWXC/M7vqSJk29Z9tjgLBzbFjTAVeWh380v2Yc/OMzeF/FWbI9OufWzuBYYc?=
 =?us-ascii?Q?9y15V9EOwNN/olBRm+wPl06dvpodMpv3ESbZV7OmbNQNYqxi0/fX0PRt6cxN?=
 =?us-ascii?Q?woWWyjIdes3OPw3Y5+no2mcW9u9TsN1LlV29hCfWHAn9Gy0QaalCXfOU+NJx?=
 =?us-ascii?Q?3FWZBlHiwSDQGMlkv2FruM+tV2Ws9pfiwe333CuWmI9fEJxsKsASLs7c5p77?=
 =?us-ascii?Q?5mQchKOQLzy2Iuwgxfjy2FRjtM0T5fOq9eLrX2QTobIuxE/RhZa6Q57GHn9U?=
 =?us-ascii?Q?qGcLbl6IzI/w4vipE+t1RCEfsD2II3dEnvHDyN2IwvmrZjHA3lkcUNQ3MZhy?=
 =?us-ascii?Q?oeRwGVUjQm9egsU1zMRh+xSrWwLW6k+Hj+9gzvLFkIYt8e57mZXCsu+LZO3+?=
 =?us-ascii?Q?LN6AAbI3KL4kUP2jhqiSkM/D2aziWbwZ+faDWJ51nxFKPZPUXK2LuiiULllG?=
 =?us-ascii?Q?f7KwQEYEmLQGrk1S6/fPalZJilKyWalhbFFgQfmF2YsLBWPd1QSneCYV9ahT?=
 =?us-ascii?Q?0edMLVIHydbE3BjgMVDrsYfBJFS6B0Bjoiv9fovnITcei2CHOiDNadXkS+yC?=
 =?us-ascii?Q?w/Co33x7j9Vm9zUQL1vEZNaJVA57XscDHn3HlmFbbL0IgT9YcJG3h6RANbtE?=
 =?us-ascii?Q?RFkAaklHlmHZWwGz6OtS1rWgg8OaUV02hZvYpbCb2tDJkM9y7oeU2ETm3tHr?=
 =?us-ascii?Q?3c+QzzxyfEXjPX3Ymbm8RX1WS+ECYX47KD0d/rtJy46r66fK0QOU9bMJ2vN6?=
 =?us-ascii?Q?+dYS4IAqCBDKx6Pad5l4jc2qNUSINa5Sb9J6K2rQinVsjyt42W9XpxATTIUC?=
 =?us-ascii?Q?A3mIV1qcG2uJTGQHB+SrVNf2+hrMUD3HqP+vghBc8qQktph//wvlUYUOFEYP?=
 =?us-ascii?Q?cTkiuUCzPTFsLBhzXR91WSCPbbyabcGbrjBbPgKacBi8PUOnTsJfjfpJY3NV?=
 =?us-ascii?Q?YzkxMcLUkgMjaauo1xvTrwThWEfI0Xb2GxA5EeorOXzGgfYnf/yAXQ9Z29Lk?=
 =?us-ascii?Q?ybhm1DDD+Exbgc1pttHDBxzcB1o8/XbzpsV3DrZMeh1TKsiRV/v5hBvgbXm9?=
 =?us-ascii?Q?tf+T0C/+Odao6Q6sIdbxlJIVrydMWqnulVjcnAY0KdvGLvKLSfXB6+ntC50j?=
 =?us-ascii?Q?1QY1CfXf0OFxidXFGN162egTv3DBl0g02do1kWpGRe/JidcvpqvRVy1pzy9g?=
 =?us-ascii?Q?T7MWvQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8118fd-a960-49ab-2409-08ddc92d2d1c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 14:36:42.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kG6McjuKWQ8xhORxrhXdBS7oRTV+XC8iUx4DqfjTUSotXo2Acsvb5htLyLDsIzxKOenHsfqWjKnxbKapq/o/sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7226

Hi Frank,

On Thu, Jul 17, 2025 at 11:06:20AM -0400, Frank Li wrote:
> On Thu, Jul 17, 2025 at 03:42:41PM +0300, Vladimir Oltean wrote:
> > On Thu, Jul 17, 2025 at 12:55:27PM +0300, Wei Fang wrote:
> > > > > "system" is the system clock of the NETC subsystem, we can explicitly specify
> > > > > this clock as the PTP reference clock of the Timer in the DT node. Or do not
> > > > > add clock properties to the DT node, it implicitly indicates that the reference
> > > > > clock of the Timer is the "system" clock.
> > > >
> > > > It's unusual to name the clock after the source rather than after the
> > > > destination. When "clock-names" takes any of the above 3 values, it's
> > > > still the same single IP clock, just taken from 3 different sources.
> > > >
> > > > I see you need to update TMR_CTRL[CK_SEL] depending on where the IP
> > > > clock is sourced from. You use the "clock-names" for that. Whereas the
> > > > very similar ptp-qoriq uses a separate "fsl,cksel" property. Was that
> > > > not an acceptable solution, do we need a new way of achieving the same
> > > > thing?
> > >
> > > This an option, as I also mentioned in v1, either we have to parse the
> > > clock-names or we need to add a new property.
> >
> > I think a new property like "fsl,cksel" is preferable, due to the
> > arguments above: already used for ptp_qoriq, and the alternative of
> > parsing the clock-names implies going against the established convention
> > that the clock name should be from the perspective of this IP, not from
> > the perspective of the provider.
> 
> The similar problem already was discussed at
> https://lore.kernel.org/imx/20250403103346.3064895-2-ciprianmarian.costea@oss.nxp.com/
> 
> Actually there are clock mux inside IP, which have some inputs. Only one
> was chosen. Rob prefer use clock-names to distingish which one is used.
> 
> discuss thread in https://lore.kernel.org/imx/59261ba0-2086-4520-8429-6e3f08107077@oss.nxp.com/
> 
> Frank

Thanks for the reference. From the linked discussion you provided, I
am not able to draw the conclusion "Rob prefers to use clock-names to
distinguish which one is used". This seems to have been Ciprian Costea's
preference, and Rob just stated "Really, you probably should [ list all
possible clock sources ] no matter what, as you need to describe what's
in the h/w, not configuration".

Really, Rob just didn't object to the use of clock-names to identify the
source, but I don't see him expressing a preference for it.

