Return-Path: <netdev+bounces-200300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ABEAE4795
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F97E168C66
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8645126E152;
	Mon, 23 Jun 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZiwUdpdF"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2574725E465;
	Mon, 23 Jun 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690321; cv=fail; b=OpIfrMlkqo6nKcMZOsrX33+52DjvH25puNwhDX4dF85O51+lqEzXH5U7SDXdGpNj7XGWBXqOjHJfgjZlpzw+PQsz20GN+BwwRp8Krynkya2uDp7eH10Zm2kRJNmPFKgKN7MdKWq8YMMKP1xdHgVKJuVB8jYUuaZ/+W5chxihK7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690321; c=relaxed/simple;
	bh=EHbMlMpf1bVD2aDajeelHxKUQOqNxTJwjv0ON7qCrcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DpLI0+ilUC/Vk4qqV8//v8G/XRnDUzQMaTL33iJWn6/DM7XGw4VwRLTJewQCtW3AMxHu7sxW8dfbY7kGtnar29Jw+J9qoajeQPsgwyJ137SVcle99ILhHKK/HkFDcGhOVJ0pZTw6WQQXYhINEQz4p40uP+Y4tVs6nBpH59tPIjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZiwUdpdF; arc=fail smtp.client-ip=40.107.159.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7kjCl5mB6wmjMV+jMiTgSwlHfcVTEZz0KDnQWhjW9XhExe/twW+r1H9rrFj4vo0HgB2cmFB+CTOaZzPCC240Zeitf24zoYlyPuf2Ffd+1yzAa7CNQ/yLb2r2ivxRQ1btneD53+8W9iDTVWuN3n4rxkrJAvxBPF39QdjJ3EEzCm5cXrrbLf1ZjLRj+Ybc5yuEubqtO+M5F7JEfHKj7fFLAGTunjjM1DZj1ppKODKtXsoKIYdjy/WR6XabybTxRvzG3uAQC/pnfR+pwcnUfnm3cfNQ7W0U2jG5sdiOxIcFjCc2H/8ZX57m52D+uAaUFOnvRGOT5IW9Deas8LYrpYybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI6KQqfFMe9Su60UJBRf6oLKoud199VJaupRXUy5fRk=;
 b=ik7YNKnKRVFjqujfrXoTYwYcahxKdi8BPiv0Xc0Gzyi+48KOGa2AULCC6tcOsNKD9myXNYWUYZIC3+O9SFEekKowHhjDOz13FERN9eLfKNprxJ4ksIl3oxFQ89nKrdv6gzwquS3wQ2RbnE8kJ2NUiPY+ip/pdjaPtLOT+NgSYXQzxn5lo0M14uJqfrZZ2VcIYlLbZ1SPTnhDc1bk/m/h6bu8owf3uvV14N/xU4vO4IsZOoFdyLW1iZEe3+Dqoq3aQ1R+QrhJBVqO+i9Zsu7v4sUUP/Wsxmh4DUa2J/5HKebq0JOkWeGbADSlMcApSeVSgUnZvxfyCKMvMSywnRVDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI6KQqfFMe9Su60UJBRf6oLKoud199VJaupRXUy5fRk=;
 b=ZiwUdpdFhLBjWN/OO90N0RBVPN5TXx3DRqpCvapfcPT+CGYPz2mffhg/I+ONoGZBtOrXQQRWOQ3zJrTBYQLYmfaMvHF5F4JG1qfPMqDR0l1S4bmgYeyC/FCIQiKRQwOWSEKQ5nsEs0+13KmYN3WwY6JSoD/HgqNDhSdg7/WIU1payuEu+YDB9Tud4O8tlXHYAhD1MFBBCJQamymgti4zXphRpocbFPT0TwvSl/a8NK4EmmK+S45g/uTKK+QELuG80GJTAq+U1fglRYUuqyDi5y+JY6FxONV0e5DH0u95+Dt8jUvC1NFDPh7EHMSINE66fZWyNx2wtxqVqMdA8HXCmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 14:51:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Mon, 23 Jun 2025
 14:51:53 +0000
Date: Mon, 23 Jun 2025 10:51:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	catalin.marinas@arm.com, will@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, ulf.hansson@linaro.org,
	richardcochran@gmail.com, kernel@pengutronix.de, festevam@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-pm@vger.kernel.or, ye.li@nxp.com, ping.bai@nxp.com,
	aisheng.dong@nxp.com
Subject: Re: [PATCH v6 2/9] dt-bindings: soc: imx-blk-ctrl: add i.MX91
 blk-ctrl compatible
Message-ID: <aFlp/Pyp0DOgZPS1@lizhi-Precision-Tower-5810>
References: <20250623095732.2139853-1-joy.zou@nxp.com>
 <20250623095732.2139853-3-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623095732.2139853-3-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b7e3ed-c0fd-4ae8-ca7c-08ddb2657e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q1ta2dvKIbo8UuB6BDIDSS+rnZHFvbVdONiYfY0M3z2eDDlKwHXTTnfz1/PY?=
 =?us-ascii?Q?HTXpiFnqTrbbh5yz2iN4fiIlG26AAccgj/AtyJLj5NXGh/2vGMShy96Lg5kr?=
 =?us-ascii?Q?FmURZ2FBp0V743txZ4hwukjDdmTIvVa36R42bY8lupQEMtX5VN3Z3A/65bVh?=
 =?us-ascii?Q?bG5SmL1vOhnqHPe6kOj7f4/mDUmnnCmRLnvJoBQJJfhWJmz/D7ximbUq/REi?=
 =?us-ascii?Q?pjHn2oqGDknDldTgRugWlEYoJXpEocg6FMfiTpCwR3FRwAodsohDoDZhOhpe?=
 =?us-ascii?Q?PjhNvu1saTwAr+KshOuqHqUyU0ux36A23XNW2iTo31yZxlRJV3M532iOK5wK?=
 =?us-ascii?Q?UEoBphL3Yy093ahU3yiMM17nhF8+cPERlo8F0wFgKwRD0qxcTc1g5swSFpML?=
 =?us-ascii?Q?XmAmn6BtisOf92l5doORy3Mi1ut+POkbmck8uOB4zC1erck8nje22PVga5pA?=
 =?us-ascii?Q?i1FMsSPEW3aplfOL9WGQu/giwwo/v/3DxTMdIpwZe4GBAmwK29Z7F0aIKRt5?=
 =?us-ascii?Q?de0stQZQT+JMCfM0HBjxUfz7W9OkO9M96h8Vfblxn19TovsA+eiLpjoIuMBF?=
 =?us-ascii?Q?fFVKgtVo1mrtN7JnOFCu5pmEM3Mh2+eEeAFQJ2832gCTuB2fY2Ioq8c1fSsg?=
 =?us-ascii?Q?tv06a2FsTV2M7ZE7ArKKYyUA3KMLoX0paQmrj9s6nRvRx5tZBS0wNgBAjPvC?=
 =?us-ascii?Q?I1CzwN2hxmouke2IGzM6qVQMzMNLu9fCv6UoIFuC9wj2swlQl6tGwp2ggwxK?=
 =?us-ascii?Q?LHCE04rzDrIMDeFv/qXwsmus48Vl35sAI8PLLMSyiF8uYE01J7wdBgKbz6PM?=
 =?us-ascii?Q?7vnTn5QEioy7VbUA8Jrk4Rw5YYSY/kErT3TYsMNkvpQjjoWGxARAo5DLzO3J?=
 =?us-ascii?Q?GA08loZbDji/AdxgDTpQM0HoFaz4JHn2UhTM0w/VDzOExK0CjI7pQV/khQzz?=
 =?us-ascii?Q?YtVQxwT6Js6LggPk6mOn2PT6Gkp7cp183K7nBt5LURf8KCcbOOgOU02gkNcw?=
 =?us-ascii?Q?FBTPBGOXP03g8/zz92e2J3kp3S+jwNvVMaFUuDV6ooQ1kIxVdagls7h9EjjR?=
 =?us-ascii?Q?VZmmFj7+4HUcpyAIgKC0PWe1LahmvTNvyWMTqGjOX/fc0bCMz3xJhjA7JCrU?=
 =?us-ascii?Q?en80Xqhte051oU5tZkl3SKfMBnCMvTipzoMr9Uhpt0PqxCU8d+TqGomABBbj?=
 =?us-ascii?Q?1JUq6Zsl/xl/E0jqVqVA80KcxcGqvlehTC/uhsnp8X/QYDvjSsLkI7gZyTQq?=
 =?us-ascii?Q?sGBYlcMh0KH5B9VP9Bwe7GrzQF1V7djRIkeIUi4DURna372cqOEQdsvt6726?=
 =?us-ascii?Q?Pv3sxQ7YFtdd4D72EWJRBkTd7I8Pur7vgvGpZLUHnnvQWZfuMVyq+Q7hr3Lk?=
 =?us-ascii?Q?/aIgS7viaKZzN1l2YJpL24OGdh6M4yVFyIo4gXtsc7XV7bFywleBgEqqqffI?=
 =?us-ascii?Q?hWLqKnC8TFlGg7j2cKTgXoWmaWi18dtS/1qwVC31mqCNlzNpWSlUoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wsU6eny/yA+zaaGNaVzwMWenksrUj+FcRffDYTtlSdTuFww/56TveyfbD//q?=
 =?us-ascii?Q?ks0ij0g9QUFuzaykvbY7zgB5MUfzW3IqzHVcxO0CUwwIxWKwEV2Y7fWbyRxP?=
 =?us-ascii?Q?KtrFmvDPxuxWFW9WUyqDfiu1J977cvQDAa2MhxIagIcWPbOVeBfbiRaaie1i?=
 =?us-ascii?Q?tkvO04O+115BTP14bH+L31KKfe3N/5SeyB8orPuld31R4o2UtwxCRXWf/u7J?=
 =?us-ascii?Q?Sel99PAXvU0jIKb5Jq0S26Xyq3nTPTMwe6H6AGcVwBt3VvSRk6YcnXZbfJ+N?=
 =?us-ascii?Q?ryc45VDPbLzSFbIMNSLHRd+EgEsoE61hZqU2CPt0IOoQaR85K8AjeQwfb2Y3?=
 =?us-ascii?Q?50DzyCJbxyiqUEUjxIU3L8thAsgq6/e12q+tL3pH/16EgZmML5MVGCoK6J6q?=
 =?us-ascii?Q?IXL3BbT4YSdpi0NBS1nu3Sx6s2E+ikY9O1MCBzX6yW6bvKel4+v1GIAY2KDi?=
 =?us-ascii?Q?X4+UlSnStOuMrEkuoA6TObZ/EctH3w6Jke1RGLgad8KnXPRFox3zaEsj/pAY?=
 =?us-ascii?Q?Rs3DozPUElaNB8ZU8F3ENJNVsx7WDvRCOM71or/yezvN3XmquYKaIyk/XMDm?=
 =?us-ascii?Q?Yquo41ZgTgvt3/NpZohiQdeIIsq7mZXlXSHrS9OnW30LxviGbHJR0kE8TnUb?=
 =?us-ascii?Q?U35rHK3Jdolriiict0RiESYGQgu7MHVpjnBWOCCYRdEszPGOH7jmRONJwQdI?=
 =?us-ascii?Q?6QtKC68lonrmbKXBEgI9lLJpDX9nnR3RKcN+mdQOhZTchRTOoABRflQ16ZrI?=
 =?us-ascii?Q?XgSlCB+5mRDW2jdTHpxFoEmblqpVGqiD5m8D2FPBw2KT0ihML6Xx0hdq6eP2?=
 =?us-ascii?Q?La1CpoaSDuARwYC1TF4Rfzqm28Kt4GEJ5Ogv3wbmhSR1DEvYb2r3t5MrBGSq?=
 =?us-ascii?Q?UdkQKpmalnOacEYky7F9i5cH7GEK/aiGX/fLPKec1ENqlgDEiSs1DNHlZ8VD?=
 =?us-ascii?Q?c9EnBerVpPGhp+4WgLhpZ1QARxwi+7nIdPSDziYio/xEsZgUmXnpDIYn/oLG?=
 =?us-ascii?Q?VpMMTQSK91OX4tzhtBtuR+BA+dDZ3tGtMHvfEgrBExgOq8gLgSQk6ubXEaDv?=
 =?us-ascii?Q?xHp20VIWI8bfJzpY68hAj4wKf/SobQLLukdf2YgSrMiXsA7JlRC/0lu+yD/e?=
 =?us-ascii?Q?AXaboKKEMu8hhvVeuMRvVwPQLqbPoBaxzRgKZ6K6es6Qv6t8dZmsp+Ahd7Co?=
 =?us-ascii?Q?nbTIIfy9b3+MNzOg4vnKE1IctFje8JRN8q3cfxeHVqeP6v8sOqjls5IY3ULQ?=
 =?us-ascii?Q?dHSy8JpubjHu62+f5aNea5x3eE8/EvFWhEFGiu9ioOmD+6p27h9FvqbhkEYi?=
 =?us-ascii?Q?XkHEz18+lZahXtosIRBIYmADheVDR5G4LlZUSgMn5MXLW3IRu5n2109noOfj?=
 =?us-ascii?Q?b73UH6jCc6vKQs298Nk5Gh2wfsgnAHF7Y64QZMMITWZO1aCttN0rbdw+cgD8?=
 =?us-ascii?Q?CxFhtZ0scrIRy3JPTjFJXOL5McKmH04odNY1B6IvO7KAI3qhmKb34kuqkVwx?=
 =?us-ascii?Q?lEGWpg8FoFLmrkBPKkww/oth9jFWiURy5I9q6DScNzNIIQ9DtaLj6Bdw9DzB?=
 =?us-ascii?Q?Jq8bTxd83Rcwt2jQNFfUfe/uvyactq5o4610gtje?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b7e3ed-c0fd-4ae8-ca7c-08ddb2657e00
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:51:53.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDYz1zboPp+T0Fcf83SqdVTAE9zX6CqjaAISg6ByWhE/ZPw8t/MF2n2RtfZJU+MuDusDL9RIdfWKceyforX91Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8833

On Mon, Jun 23, 2025 at 05:57:25PM +0800, Joy Zou wrote:
> Add new compatible string "fsl,imx91-media-blk-ctrl" for i.MX91,
> which has different input clocks compared to i.MX93. Update the
> clock-names list and handle it in the if-else branch accordingly.
>
> Keep the same restriction for the existed compatible strings.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes for v5:
> 1. modify the imx93-blk-ctrl binding for imx91 support.
> ---
>  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 55 +++++++++++++++----
>  1 file changed, 43 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> index b3554e7f9e76..db5ee65f8eb8 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> @@ -18,7 +18,9 @@ description:
>  properties:
>    compatible:
>      items:
> -      - const: fsl,imx93-media-blk-ctrl
> +      - enum:
> +          - fsl,imx91-media-blk-ctrl
> +          - fsl,imx93-media-blk-ctrl
>        - const: syscon
>
>    reg:
> @@ -31,21 +33,50 @@ properties:
>      maxItems: 1
>
>    clocks:
> +    minItems: 8
>      maxItems: 10
>
>    clock-names:
> -    items:
> -      - const: apb
> -      - const: axi
> -      - const: nic
> -      - const: disp
> -      - const: cam
> -      - const: pxp
> -      - const: lcdif
> -      - const: isi
> -      - const: csi
> -      - const: dsi
> +    minItems: 8
> +    maxItems: 10
>
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx93-media-blk-ctrl
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: axi
> +            - const: nic
> +            - const: disp
> +            - const: cam
> +            - const: pxp
> +            - const: lcdif
> +            - const: isi
> +            - const: csi
> +            - const: dsi
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx91-media-blk-ctrl
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: axi
> +            - const: nic
> +            - const: disp
> +            - const: cam
> +            - const: lcdif
> +            - const: isi
> +            - const: csi
>  required:
>    - compatible
>    - reg
> --
> 2.37.1
>

