Return-Path: <netdev+bounces-206639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CB3B03D7C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA244189A9A0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16B246784;
	Mon, 14 Jul 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UG+qQ8P2"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8824502D;
	Mon, 14 Jul 2025 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493065; cv=fail; b=pJMHdcnG8Q0KgD2/eJlLlq2YpJzZ2ODGWmjejw4I+koxOyBfqjbKod+1VIXeBYpaiSK++aaUSTVCq0PaySflcMCm6FZDBjzswcL0dwhqMH3UrkK7tJ1EYsM5ayUdJM68VQRaZKoER4ROv23SRMZ85rqSxR5PtaHYTpKpX9GUztc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493065; c=relaxed/simple;
	bh=yrTFnCilvXai92Ojk+rXLbdoh/DKqfwp2ScAraz3OTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eRltZcEBrNu+2mYLbXzbHR+BEb4PPLlAT6/cso8MvPAUPec9hlgOQvNyei0T9caIyYAkN0tqsxXR7I6nLmRs/pxfkHbDBgMxVoncVB2UmebNew0HpOiUcHTsRokYEgwHHSU5Tc5L327VB8t9zuQQ/83DK+KNFfYQEpSOi0L6nCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UG+qQ8P2; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjzLaocymh/DobJbEsw5XcSFRijoYm93gQ+M7SZTOkVQ/osorsn+Re0/IgAVSMo3vrprhNLI1r+iKC1TsWHYd8JBfcJtyz2Pb4ft5MMZ3lWwQn3p6bbgCOBAC25vNU/g3eVKy/bDUfZnxI3+sX7gaV+USk+41o26CeZ1HYSCDvgYlQs82jp5nNjQ2OJU0yrKMbnKChB4B4ylowe8DPdVBLGMUj4YIPYlC3olhDA4sMIDakGpdnA9YmSGy2Y0MKWCFEy0ACzQBFsGIAKoxtVhJeQyWYk5wPrORlOjgE+S06DWf1i+DkaFXYpYh4Wqc8ewI58RghnRX2evZg17/stK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wULO7A9AXOaw1sJneDzVAhqwJCHJ/wZIhcjIkTu0R54=;
 b=Rb1+LdF56FQW/gxkVpMvERWteLVAFXn2DGm0akttYBR93klmtpn4pml6EI5jldALJ3118WRCj61fRU5PLz9SUQGlnIxlOkSaK3ahKf4VQMkN4ZQvxeIdiKVOLgwNxy+cYVcbvr4OIdfyrBcV5Y87DcchG2pNwMq3/yYL9mQ1vjmYGPZNRM78YL77wuPqLydpKJgsSMNAaA1yW4M9ZOwEVJFgMCdvvhFV9RWSeJRg6jenRhxTm6kgpMPBMPVtvdlvUDsGL+HbyucbRnhN3s1JsonJlR3VwnI3iiH01D7Hose7c1UgMGWMRoapXw5v1gB0WF/U2QYbRYyYb/rtLOLZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wULO7A9AXOaw1sJneDzVAhqwJCHJ/wZIhcjIkTu0R54=;
 b=UG+qQ8P26jbcC/jmxmGUIY7tOSU01UQtImdvjzyovhFKPjuh6WiT7wNfgmDspZzx6V7+ErlR8S+MjldB8tsZzMZFVt0CWpBr+nUUUoLe1GPpPKhB6NHOIFd5eDSH6C44NCIi5P47B02aM8QcfvJepVSdjqP/IAcJNnAUWpxBOMe097TxDmMdUbTKxrK61WAm0ZqVXMpBGgg5YKyilwUh5WxXHku2w7WLmFwQK/1qP08huxWYSy8B8jETvIsykWoIOF1hS57yezNQdv45F+5P18k4rT7RoogU4KUVatclOKHikqswyuWHHFqrq29dUU0WPRVWviARoSJly9zI+HzWDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10176.eurprd04.prod.outlook.com (2603:10a6:800:244::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 11:37:40 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 11:37:39 +0000
Date: Mon, 14 Jul 2025 14:37:36 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
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
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Message-ID: <20250714113736.cegd3jh5tsb5rprf@skbuf>
References: <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
 <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
 <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
 <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714103104.vyrkxke7cmknxvqj@skbuf>
 <PAXPR04MB85105A933CBD5BE38F08EB018854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85105A933CBD5BE38F08EB018854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::8) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10176:EE_
X-MS-Office365-Filtering-Correlation-Id: 546d225c-287f-4dc3-7cf1-08ddc2cad6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|19092799006|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BbOZ8DAe1bisErsbeqSlKIwUgWcI8R58Vjoz2j5eyGigI5Q17cj9CA/HNEPq?=
 =?us-ascii?Q?Fq3fmMrzb8a6ZkUTnljAo1pR0eKPvLTrXY6vYSXZ9wJ+fFTeKgtaCqc5eepO?=
 =?us-ascii?Q?Ocu78zM/QvV2ULz7G7QW6szyIoqW2fXjONJJ8aA6vlThYXZf3Njr7waCLv90?=
 =?us-ascii?Q?45ZKIkPQHNwj+/8kbFVpb+jA8w7czdIA2C/EO6tEMDdYaKN61Rs6vU8iCxqz?=
 =?us-ascii?Q?TPKRq3z/NxxGS+f5LTdZhX4+LAHejOT3L/WA4BsSXstex1L2dBoNE5AsJCfE?=
 =?us-ascii?Q?faEjeIvRBip/KVCaRPTVor8Ao/QmaiCiSw6Tt9RXg6gbdyHz/kM9/cCXy92R?=
 =?us-ascii?Q?P4s6ZNNxwjOaPWTwa9aHDNKmyUCfxERHpWwhrWphA2WkF9usl60Drh699v6O?=
 =?us-ascii?Q?5NnhFDUW2roY0KQ7OJ5WtlbfbRbCzdnLI78rXo3dVneaveHAifK1MXaeCqh9?=
 =?us-ascii?Q?uoXvXoeOUPLYEFN5FWui0xmyGKf5M/rrKhfbnvjWLfLEASnjqp44ZLvdK79T?=
 =?us-ascii?Q?fZMJJfQo6o05x+B5cJ0TdF+1V3NxnaUJj7o5h1ZX3ZxzIgLXFxXIlR1+ouPr?=
 =?us-ascii?Q?MVNYBaRkK8NEvbcmq9WEzvMNzsE0MC373/72xj2EBsrEUnWDSsoFdmtW0JVZ?=
 =?us-ascii?Q?rYTUv7VpbACA3gsSbE1T9PQ8/1t3UvnaMvTkkMtgCEk47GEUCDYbaJUiPn47?=
 =?us-ascii?Q?q12152j6qUmhbcjtYq/9lFGdriwQrueEGLRkt/waeSOCx41KWwEi+SN0Wtxt?=
 =?us-ascii?Q?T+VG9zQP2T16BK5J2igbeABE9a1g91yUDbEVX0emsdH22J2I6U9c2BW3ora2?=
 =?us-ascii?Q?u15+m0Ey4tgcvul7eGRT0afOTyHTiPemA6xlrgj7corEfZuIgmRyPnLjl90v?=
 =?us-ascii?Q?zwx1vwrqwHuepnhql2O7TWv0EjEueiNeOToL+3GYp2UxgVQ9anojQrGqqCaH?=
 =?us-ascii?Q?PyVfPMRqjVv7mDmZfU532HkSnMjlRF/mQb2FkCXy+Kcrfl/A34tLbi05AuyY?=
 =?us-ascii?Q?KIms1TDOx0RjnuLvIApS/5Q2z7WZo6n1RNQIDks1rzep2riMXs2ruVnfMDmQ?=
 =?us-ascii?Q?AtYyd9et9yJbnjlFPgU8EaNbLaJeqpCGGCB2aLJT23zbzvK4A1xMoSegdVs7?=
 =?us-ascii?Q?oec/ghXUPDHtILj8tG4v8Lue6pLW2dgi+K56zfAtEX4VQVqP+qcIJ31iJ4og?=
 =?us-ascii?Q?xCNp/zbpx8fuOBPr99c2EK8TXxuEypInRDOCi/GgcrjlkUVTRVhtP+cQGbB2?=
 =?us-ascii?Q?uT/hRZ+RN86bKNdMFoII8h9/Y07cFtlkE4gRYqknnM3IRvPmBao7BqYnamO5?=
 =?us-ascii?Q?FzsseVPQvTnG9uDx7eZTZPmieZGyP1DxtE3/OXyPjCaV5Z0eZzyV7NW97LiK?=
 =?us-ascii?Q?/Wfe16T0VgVhcUZJR382aVSMySsE/J77FpJOl+3epJ3lyj0T2qwNk1tm8aRQ?=
 =?us-ascii?Q?+mXTiLyJ4Rs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(19092799006)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWY+IKx+z1fv218+J9jzm+lPtlWzRLPaai/TBUk2EDk24M3Pyl83sqPZKrIv?=
 =?us-ascii?Q?MhjHW3/JRrCZSv0DMqVUeo6DQufnmzjfQtN+0/ESnJI540kul+CU76rdSCL1?=
 =?us-ascii?Q?8g7Afpu6FAUTFHdKyZ4mhENQCJ0zurWNH4g1WgMDTEh1bocG3CrbjEbuQHRw?=
 =?us-ascii?Q?0lCuxAeC1Ocnqx2C+iD0IfEQBvQmcy3FRlYDB+yFjzzDjsEFMJmm/otdqQp8?=
 =?us-ascii?Q?pxxRbPzgud0py+3LRrEM13kAw2WDGhI0uYyl+rrxZR4p8iT8lkJgOmzTNIkf?=
 =?us-ascii?Q?iQkRvO80RSH1eTfq8lxpDoIhDT524vfEEvpivS3GJsqLeRry45sIRUIuELr2?=
 =?us-ascii?Q?Ynj7EJrJLEJNtujrcmOqTFRZz64/mTuwYL0oQPvtDqDce9amTZo0D1aVTyGI?=
 =?us-ascii?Q?2IxQ1EEV98YCW0ZUQZlabFqVhU9ervzYufx9KEJi8W5/z8zmSTy2AuMkxqaX?=
 =?us-ascii?Q?FPeTy6sDq5gIJPFPUzsxHsp7rGxHdcmSSLOEL7K49BeoRBANh0JA0zFbp2pj?=
 =?us-ascii?Q?zLVlTBa/gdg+Hksgagw8sfvqGgw75NEiAm3yrh6A8nKEjorDj7tVbCDqZMPO?=
 =?us-ascii?Q?gZxJr8pWtmAHRiDjoRE3wHhv6u/BN5tyVf4u74b46QBGT2eEMRzheoL8De9l?=
 =?us-ascii?Q?SRM8uGKFFPel0oudhIz3oIE0Lv9pKLcOc0hkZ/yYHXak3GOz1NWzMgK3OZHn?=
 =?us-ascii?Q?W4yNhtUxhNDAY2vOnauOf1iMn0qdduB0I0QZtEjmSxgCmP5EqHDxEQOVlkfO?=
 =?us-ascii?Q?x4ud9YwI7zqWjpOXhF5IcHqGySmbzW9bwdsLmrx5cqVKNiTafi8lof/NPLGf?=
 =?us-ascii?Q?uxPug6O/Nh+xbVToRvZqbIkPy43ZLl4CP2eoxiN4LiZ0afJ8cIbK0jbGvHtj?=
 =?us-ascii?Q?+A99ibhC3X5z1Qaju6VB7/ot5QqHkRmkgEf4NA4hVrWbkg3Ct65DX4dig8+8?=
 =?us-ascii?Q?P0kzBTX3msOQHTedGAyIvpv4OTpaCskge2CKEcK2D6WyyK5ijf5OKGv/mdmf?=
 =?us-ascii?Q?NT+GFAjbNRZWamz2vHJioMHSVrBSjPBGGmCQZ/YZ18dHHQhNjzXuEMcE4KGQ?=
 =?us-ascii?Q?cofQxifOXTxM5MDt+F6WqKSf9PZFdcaTj3B6XKJ0W725/AXqgMe8rp5e/9Gl?=
 =?us-ascii?Q?59m0bCUlV4db/bHITD4kiiTLrlaWMkn9xiDGlGG1zAOYJKru8nSnCEoQjV2l?=
 =?us-ascii?Q?JFUkx6CbCE0w62kXprnERtiVb8uST4yhckpNmBsFesQ58gac0gWSDTk36nlE?=
 =?us-ascii?Q?lcXueSAGFv2UJv3DFN4WIo+uR4Tn40rmb85Z4rwEH1PUN6Oe7+9A1eGx6Tx2?=
 =?us-ascii?Q?QmymRm/omvEeVrum0rO+2agZmD1QCIAJPv2aY+C/soIbSIxQSzYoKKLqD8SL?=
 =?us-ascii?Q?UBRmrTEZ9fekKJ44IG2wUjfI2uvCuewh8drQoW7nzLvLDwZhTk7Z6Zd1AJ0k?=
 =?us-ascii?Q?0aoYcsyllxLGVtgJhepttoM6PJyUoebsAptI94UDkWUoJ0ZQSiMWNQZ8ETrK?=
 =?us-ascii?Q?7jiQolDd3rYCJXkrWcimL+SYtNq657EsZ8BPuor6ZkL+NP2uyUktua6t3zh+?=
 =?us-ascii?Q?D/G6VpWtEy56qWwKmOTMriJQw/BHEPGU2VSG+HIE6PCkZ0m803/wTO4uwcLX?=
 =?us-ascii?Q?uLMEzNAdaWwBU4cIwhG6Rgu8SHd6Gfel94WnsFcCXw9a8GgYxj8aj1s/rOdG?=
 =?us-ascii?Q?Q5GaSQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546d225c-287f-4dc3-7cf1-08ddc2cad6ac
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 11:37:39.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rl3Cx4i54Ha/10S1QHduLFvslj3OyHrTKtKD2k2JPOA8e/YdWMX5yC6t9FjkO7hEcuamxjDZnjYd2LZUOw8B4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10176

On Mon, Jul 14, 2025 at 01:43:49PM +0300, Wei Fang wrote:
> > On Mon, Jul 14, 2025 at 01:28:04PM +0300, Wei Fang wrote:
> > > I do not understand, the property is to indicate which pin the board is
> > > used to out PPS signal, as I said earlier, these pins are multiplexed with
> > > other devices, so different board design may use different pins to out
> > > this PPS signal.
> > 
> > Did you look at the 'pins' API in ptp, as used by other drivers, to set
> > a function per pin?
> 
> ptp_set_pinfunc()?

You're in the right area, but ptp_set_pinfunc() is an internal function.
I was specifically referring to struct ptp_clock_info :: pin_config, the
verify() function, etc.

> > > The PPS interface (echo x > /sys/class/ptp/ptp0/pps_enable) provided
> > > by the current PTP framework only supports enabling or disabling the
> > > PPS signal. This is obviously limited for PTP devices with multiple channels.
> > 
> > For what we call "PPS" I think you should be looking at the periodic
> > output (perout) function. "PPS" is to emit events towards the local
> > system.
> 
> The driver supports both PPS and PEROUT.

Ok, I noticed patch 3 but missed patch 4. Anyway, the role of
PTP_CLK_REQ_PPS is to emit events which can be monitored on the
/dev/ppsN char device. It shouldn't have anything to do with external
pins.

