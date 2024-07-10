Return-Path: <netdev+bounces-110467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CB692C838
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 04:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CB41C21D0D
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 02:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7818F5D;
	Wed, 10 Jul 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Al/STfuD"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F298BE7;
	Wed, 10 Jul 2024 02:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576925; cv=fail; b=OODhEU4fXop1FwrgWwIyjrn+PTl64rBPP7naNm80hXNQOaj7djOta17HTotCeE0+iMGh/Y5GNmWsfi8MKToFsuSr0jCJzgYYgG6VDwlB8AeHPV16P6a07nN0wSXcwWOi8tdX9A8D+EXI7rjYnMHeoAzZ1UtRbr7FL1M+yr9k8Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576925; c=relaxed/simple;
	bh=7Df3cNIVot6MDTlGDyQdDX2CNvFKk+IrI7Bb2qui2X8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=piftgWj5MPd/RBFfj+hjzaK6xAgcCiv78osb28QHPvsdNUlpedKmEQPVXosQkt8+9Mr+PzReSyD7chlTrI5k5tODHYj1U+dw9Ws1qwBIRBm4Fsf4I8UvQ9ni4+onbqn6BD0gZmDP1TOnmRJiXndrpOdpbhPENJ4+TaFH+VGmKcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Al/STfuD; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPxpgUbtXfVCYtgFCTUnPOvOx7bxxa38Iz4urOWCgU763LY6Qhy3npc6ixnARkiO+T8ApwThvRjBRMRfVrUn6oFDUi20AxLZzWHRLPC20mgLhlwpWhnTIs59q13iXsLzoS5t5+jZgKGQSgCRd+JDlB9IRuMLttP8oil3Yv8kGvkg4VM5YpJV+e8TxZve5yys3lwwF966Ho51+cQYPoNUyeniDc7aSJnJQ37rNOW38WILnAhkvzw1Tv+0OxZjRTVHudT7ik6H1hWzkGyjcVacjEYp13ttxxHTzUgBetvmJWC7aBcGejCvSyOHdhUylrzczOR0JI06ZF2s6xuKxKq83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Df3cNIVot6MDTlGDyQdDX2CNvFKk+IrI7Bb2qui2X8=;
 b=GC85YJDwZ1sWuyaLfKZcpd4m9GfRJrtKmY25M/riJjhUincKiFuw2h31sEMYP3r+RY00kvlkQtSWzxAcsxerxBNIHj+78tq4RPyI6irBg4qw6+plwCiQRU0JLRixTCeAD+3xhNwjWIM68UfcV+vemKeNsWCOExFRHHLUb6VHSj39SZbBRR0Uuvvdlw5f20SLDfHkrwGeMDQ9HMcKdX3wmh+IZlrj5hGAXsLv94nokN8r+STHB4JW7rGo5omxTo2LE9phlV4LZqpRqB64dnaJV+jy3N7tFqUmfGLuoAIacGZPf1ebvgmFOuhSW9ZkSxQ+x6cCs6Ure0hCXbrfkv7MfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Df3cNIVot6MDTlGDyQdDX2CNvFKk+IrI7Bb2qui2X8=;
 b=Al/STfuDriJ14CY03+zYu+5CdWD4rKStLYeWf1AUXDmn5j4QsiZ++tGD9MQxrhGEGrYuQYsRcyagOKExyNrltFu9Jzo1nulcIJK/o9LFWq0JCfTeKNRAPWR7Eb7INhHWbRg98a6LHmWAhHVcFRtBd3IUhiICEd6REnp44uczj40=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 10 Jul
 2024 02:01:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:01:58 +0000
From: Wei Fang <wei.fang@nxp.com>
To: 'Rob Herring' <robh@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "krzk@kernel.org" <krzk@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [PATCH v2 1/1] dt-bindings: net: convert enetc to yaml
Thread-Topic: [PATCH v2 1/1] dt-bindings: net: convert enetc to yaml
Thread-Index: AQHax+U3Zm0nW+5pRUG/N+UuUo631rHsoNfAgAHi7QCAAL/8kA==
Date: Wed, 10 Jul 2024 02:01:58 +0000
Message-ID:
 <PAXPR04MB8510E9CE015BD7B5C4D96B6B88A42@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240626162307.1748759-1-Frank.Li@nxp.com>
 <PAXPR04MB85101FF8C01B57F87DF1B04A88DA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <CAL_JsqJt+6_YrUaapxd+u7GjQffFi=okirkq+cotTUE43Knwqw@mail.gmail.com>
In-Reply-To:
 <CAL_JsqJt+6_YrUaapxd+u7GjQffFi=okirkq+cotTUE43Knwqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB9117:EE_
x-ms-office365-filtering-correlation-id: 67f6e83b-90ea-465f-b123-08dca08447dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0xLaW9FcmlTeHVmZHJEem96K2ZGYWR1ekUwOU14UEdZSG5XOEZ4RXpnc2E5?=
 =?utf-8?B?RC9kUGdDOWxZMGVsUGw2U2xMa2RNcjBnRXkrN09tZlQ5MTZrRmV0dUc4Q21C?=
 =?utf-8?B?eUhFNTI1Q3lXVlZoVzgyMU42YUZsdWNHb1lYVnpqcC9xMEFSU1JJd2JnRklu?=
 =?utf-8?B?TEpmTFhIdW10VjdHSFFCeTdmSVVxMkhlUXo2dWVyWUN5WDQxZE5SMEFSOE9s?=
 =?utf-8?B?U1RVc3dvNGtWRTVxN1NnU1paeWNTb0tVcEI4ckZMQXprbis4V0xqTHJlZy9a?=
 =?utf-8?B?a0l3N1o5Y0ppWnpSUFEzQUZzb3FuWXZOdWhBaUhHNGxjeVFaMHN1aGg1ZkVt?=
 =?utf-8?B?bGJ6UE9PdnNOeDBwTFY2dG80czgyZ0VYMUxyMjBRVmpVY2M1clIweGxTdVQ3?=
 =?utf-8?B?bno4MkZSaDFNdEFjazFIc3Q0aWdmLytpTDBrRHVQSzRLTWJVMFJpa3c2QXho?=
 =?utf-8?B?MmtjLzZaQjU3S2JXTllzMGtLMEM2ZGVualFNK0xiLzRZK1BnOTJmaXd6akVr?=
 =?utf-8?B?UUdxR1VUakxwdWhrbk1jSWphSVFiaTdYbGVoOWN5cFlDeDBnY3Bpa1p6bUl1?=
 =?utf-8?B?dGFPSmtTcHBIUFJ6QUZIejdJbnlOT0lQYWFUbHZCelFyV3Z2SkdMWVNsbTNE?=
 =?utf-8?B?OHBjWGtKak93bG1RV2xzM3hkaHNacXk5dmxBcFpBSmRCZWtqNFRhZ050dGpx?=
 =?utf-8?B?eW9lcWJWZThUVzd3cnJpTVNFcjhHSlFWcUxVck0ybThXUDBzZHU0NGNtSjUy?=
 =?utf-8?B?S0ZFejRsdjFIMmg3a0hHYnpVT0NYUndTYXFUR1ptbk5LLzNMZ1dSS0V1LzI2?=
 =?utf-8?B?d2JPNjRlUHpRVTl5VTdBeHlScVVSTjJoOHhEbnBtNTlweER1Y2Nuc1Zqam9v?=
 =?utf-8?B?d3AxVWhXNFE2WVhSSERnYTNUN3plUzZTMG1NaHN2all2NnAzSGhLcGd0WVBn?=
 =?utf-8?B?Q2xrZXhrZU1xclJpbEJMWFBEUFdWTEs4WTZ5SmtyUmRnWGIzNjI2T2JrY0hh?=
 =?utf-8?B?MGR1M25HRWpRK2ZvMy9lZW5BMm9yUHM5SjFTb0pGYzM1aUlaWEZZVWUxNmJ6?=
 =?utf-8?B?b1h6K2gzRmRJaUQwdWx2eUcydWQydVNvamtvUURUUXVqMWlUMUJwMWhudUVi?=
 =?utf-8?B?SS9QZTAxUjFjZjBJbHFtc3BtNEJpMFVKdUhYcWE0bFI4WFdmWExoQVQvbTU4?=
 =?utf-8?B?M0cyMDJNZDFFT3E1Z0xNU3NaSkdDZ2pQWXUvbVIvUDZkM2tJeEQ3NEFoRWZh?=
 =?utf-8?B?UmJKL2l3V3lZamRyeEozaE43KzNBVS9hdENOTjUrRWZUalN6MHQ4ejF6c3gr?=
 =?utf-8?B?dUhFSjJORlZPZEUzWFhhWlJ2K2JxYUszOUM0TkErcC9mWDFxZnJ6NHg2VDdP?=
 =?utf-8?B?cVZjNmE2WU1hMDJqbWZTS0RTL25JRUJRd0pJdE9sakN2ZEcxdVgyUmFYaE1t?=
 =?utf-8?B?QVZsWFlMMWtvRVlQVUFNanJqbExDR3RFclF5bU03SXpzWUd1dVczWUdybTVp?=
 =?utf-8?B?blJWTE5GbkRkNHl0NHE2QjFGSUkvT01XTnJKdDJqc2I0TEdma0lHY2ZwL3Bl?=
 =?utf-8?B?bDFIRDduc1BROWhOZXBzaVdjTXdTMTgvQjZKTlF4OStpd2FQeWNHZmpqcVZn?=
 =?utf-8?B?My9JVGxvK1dMN2xhVjd0QXFjeGdxNzlTcm05USt2cGxXdWE5VTZYOHhuTDBl?=
 =?utf-8?B?TWxoNUJIbDZ3QmRqQzhpMitxSVRmL0xESkFPZ0UyMjZta2p6bklOKy9hdWtV?=
 =?utf-8?B?UWJ3S1JvYWxjb2FYZEh0Y1hyU3krem1RckNyYU9LOXYwYlltS09QemZpbDdC?=
 =?utf-8?B?NE5oSnQ4SFZIMTAxdEVpT1VLdm9LSVljajgyWmoyT29MMnNVREYxS2dJck9u?=
 =?utf-8?B?cnVFbWtHdk9pNXhJS2l0N3BSU1NVNEdOZHAzVWhuZ2dwdXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V00vcHppTGsvVmtEbm1LMmlnUFFrYzgzd3FoaHBWSkdtU2l3cWJkTEViS003?=
 =?utf-8?B?YmJPamYzcHdodnl0aDk5STlkdzc3T2lMQkpRaHVYbFBlemwzajNTdGR3bjhn?=
 =?utf-8?B?akYyOVUxcDBlQ2Q5c09vMDRkMWQ0YkllQ2lRa3hTV1lXTWNmUVN3aDZJajdU?=
 =?utf-8?B?dnc0cFdINXQ0R0NPMitoT2trRHcxVzVTTXVJYUV2TE81QUdHcEVjS1FXRmNK?=
 =?utf-8?B?R292NVhwMzhzRzBybFJUei9aL0xpUzRWTng5a25VWHRra1BKTWxaTEg3dDZr?=
 =?utf-8?B?dXdySldNWUZRTkY5ekJTMDBtOCtSdDhDVzJacW9ybE9qd1NoNThXSUp6d1A1?=
 =?utf-8?B?THNXcjNZWnJia3Zsd1dWa1k1dlhFSGhNbXhYZ3BZaGpBTjFaa1REcGhlVVFE?=
 =?utf-8?B?S25qUzMzdTE5S0NPbTNyMmhnWldNSURURmdlTUxWMVlmVjl5a1oySC8xMGJ4?=
 =?utf-8?B?YmY3a2kwSGpJcm95V1R0bXBOanZ3Sm4zOXBCTjhGbTFpWEdKSy9jaVF0REli?=
 =?utf-8?B?aFZFeXIwNURhVC9UNnREK3BZL1p5MFZYS0hDY1ozZVhXb1ExdWhCQ095dE5H?=
 =?utf-8?B?ZitzMm1OTDVPSFpLa3VaN3Yva2grbjJhQUVONkhOcC8wL2MyUFM0cFRmTUNN?=
 =?utf-8?B?YWlUWFNXRy8wbDFQYUg1S3ZSNCtMZ1hKSnFqdnNObnBJZndKZnMxNEg0QWJV?=
 =?utf-8?B?QzV5UkljSDFpbnllVzlSYjIxNHBhVmxkR1R6QnYzVWpOb1lyUlVXSkFuTVFX?=
 =?utf-8?B?MkQ4cEw5QkxYYWEzZW56NXdrWlJMekt3amVyT0d1VXp0dldpSysvMCtPRGp2?=
 =?utf-8?B?NlRvdW44ZThwZEZRMFV2dkU0MGdqbktyNzhxSlhEVU0yaVRQMEdoaG1uWDY1?=
 =?utf-8?B?cUcvNm9lbkJ2RndJT0hKQnRrZEdPSnRzdkpJZHQ3K2VxZ29IWDc4OVFLU3RD?=
 =?utf-8?B?V1hYZzk1YnNRMS8ybFZlWmc5T2tWN0xDcDhWbmRDZ1lIY2hxRmw2VHdHRUd1?=
 =?utf-8?B?bzdDa3BtMEtCQTlqUXlBZncvd3lWNGVuSXV6cU5BZndDMFIzcFVXK0wvdERk?=
 =?utf-8?B?VmhtN3Z3YWgzais2T0syeDFqSUIzTEJrYzNNR2FBK3psbnJHS3c0bG9WSVlH?=
 =?utf-8?B?S3FaQ0J6Wm5DUWZuSWNHamVMRWprN1pNbStOYklOaGhhQXBFdmNKenhYSW5I?=
 =?utf-8?B?SVRVRlZETkpydnVMckpUMno0NXNqTGVCMWo2ZWNCdmQwMnRocUt4UERFNEo3?=
 =?utf-8?B?M0llR0VQTkVvMHdDUWJFQWpMN01xSTB1UlhON0ErYjY2MXBVZGpzWUJlcVhX?=
 =?utf-8?B?TEhBNE1EQW1LMS90TW9lZFpwb1RodFRML1ZNRjdublMxczVCMWpUU1VHUmFT?=
 =?utf-8?B?a2JtNkwyV2tOK20wS3JpMGNkSnhySlgrSk5RMjRaUHFLRDB0RXlidHk3NzJ0?=
 =?utf-8?B?dS93ZWxiZU45cGU3YzFUY3ZZcDJTYndTQU00cG1LOGg0OEMveWluOE5ucFdW?=
 =?utf-8?B?TmlDejZBZUV0VFFpc0N2cGxGaC9USmNlTm1PZDltSmtWa0pDR0tSc0RPUStE?=
 =?utf-8?B?VnpXL0hDNHc2UUVVdU5QWjd4T2doSmN4MFVkN0pRMkFaR3M5MUNBZkR5NEFr?=
 =?utf-8?B?ZGtaYmVUU1VqWHNVS1VPY2VvVkx3NDkzY3Y1Y3Z2cnM3K3BsWWt5a1BYMHFF?=
 =?utf-8?B?SThoZDA1eURiaEgzQVBCTjBHTG5uY2xNa3NPN21pMHF6bXpTQVBMVGQ0YXFX?=
 =?utf-8?B?SklseEhEakRvTnBSTi9SWWt6eGduNWdlMGlXaFViRDBocmJOVlhFU0plb0xN?=
 =?utf-8?B?ZHNVMlJ2VE14SllURE11WHlDeGxvWXJTd043Rkx2WlZTV2RjU1pZSjJlVVBR?=
 =?utf-8?B?SVhwYXMzWk1zT25SN2EyZHRwbGRKZ0ZaQmdjYjliNHJGQXNDQXkrSFk5V2l2?=
 =?utf-8?B?aFB4Vm5UbzhNTkpSWGVTRndjaEloUVZubEdvRTFDVy9obkVXTUdpQWxRSWhQ?=
 =?utf-8?B?UmFscHhOQ3M1bVVMc3RDdCtBdjlERk0wMEFlbE5hdEZFZ21QOG5xcUVkb1lD?=
 =?utf-8?B?TVorSWZyVnlubk9qeXpUV1NqZkVvZjBENjVmQkd4WGc1d2FpZWdrRSt6QStz?=
 =?utf-8?Q?F8BQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f6e83b-90ea-465f-b123-08dca08447dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 02:01:58.1476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtpkevLiiUus+7XMQE5xezOoHcfxVba34IntUs/AmatBFjsiuC5MSMng64AEYKrbzuwJyuQbWRpqabVQM3x3yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDI05bm0N+aciDnml6UgMjI6MTENCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBr
cnprQGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IGRhdmVtQGRhdmVtbG9mdC5u
ZXQ7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBp
bXhAbGlzdHMubGludXguZGV2OyBrcnprK2R0QGtlcm5lbC5vcmc7IGt1YmFAa2VybmVsLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
cGFiZW5pQHJlZGhhdC5jb207DQo+IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54
cC5jb20+OyBDbGF1ZGl1IE1hbm9pbA0KPiA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47IENsYXJr
IFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAx
LzFdIGR0LWJpbmRpbmdzOiBuZXQ6IGNvbnZlcnQgZW5ldGMgdG8geWFtbA0KPiANCj4gT24gTW9u
LCBKdWwgOCwgMjAyNCBhdCA0OjA34oCvQU0gV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
RnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gPiBTZW50OiAyMDI05bm0NuaciDI35pel
IDA6MjMNCj4gPiA+IFRvOiBrcnprQGtlcm5lbC5vcmcNCj4gPiA+IENjOiBGcmFuayBMaSA8ZnJh
bmsubGlAbnhwLmNvbT47IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+ID4gPiBkYXZlbUBkYXZlbWxv
ZnQubmV0OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGVkdW1hemV0QGdvb2ds
ZS5jb207IGlteEBsaXN0cy5saW51eC5kZXY7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gPiA+IGt1
YmFAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5lbC5vcmcNCj4g
PiA+IFN1YmplY3Q6IFtQQVRDSCB2MiAxLzFdIGR0LWJpbmRpbmdzOiBuZXQ6IGNvbnZlcnQgZW5l
dGMgdG8geWFtbA0KPiA+ID4NCj4gPiA+IENvbnZlcnQgZW5ldGMgZGV2aWNlIGJpbmRpbmcgZmls
ZSB0byB5YW1sLiBTcGxpdCB0byAzIHlhbWwgZmlsZXMsDQo+ID4gPiAnZnNsLGVuZXRjLnlhbWwn
LCAnZnNsLGVuZXRjLW1kaW8ueWFtbCcsICdmc2wsZW5ldGMtaWVyYi55YW1sJy4NCj4gPiA+DQo+
ID4NCj4gPiBTb3JyeSBJIGRpZG4ndCBzZWUgdGhpcyBwYXRjaCB1bnRpbCBub3csIEkgd2FzIHBs
YW5uaW5nIHRvIG1ha2UgdGhpcw0KPiA+IGNvbnZlcnNpb24gYnV0IGRpZG4ndCByZWFsaXplIHlv
dSBoYWQgc3RhcnRlZCBpdCBmaXJzdC4gSXQncyB2ZXJ5IG5pY2UsIHRoYW5rcyENCj4gPg0KPiA+
ID4gQWRkaXRpb25hbCBDaGFuZ2VzOg0KPiA+ID4gLSBBZGQgcGNpPHZlbmRvciBpZD4sPHByb2R1
Y3Rpb24gaWQ+IGluIGNvbXBhdGlibGUgc3RyaW5nLg0KPiA+ID4gLSBSZWYgdG8gY29tbW9uIGV0
aGVybmV0LWNvbnRyb2xsZXIueWFtbCBhbmQgbWRpby55YW1sLg0KPiA+ID4gLSBSZW1vdmUgZml4
ZWQtbGluayBwYXJ0Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFu
ay5MaUBueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBDaGFuZ2UgZnJvbSB2MSB0byB2Mg0KPiA+
ID4gLSByZW5hbWVlIGZpbGUgYXMgZnNsLGVuZXRjLW1kaW8ueWFtbCwgZnNsLGVuZXRjLWllcmIu
eWFtbCwNCj4gPiA+IGZzbCxlbmV0Yy55YW1sDQo+ID4gPiAtIGV4YW1wbGUgaW5jbHVkZSBwY2ll
IG5vZGUNCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9iaW5kaW5ncy9uZXQvZnNsLGVuZXRjLWllcmIu
eWFtbCAgICAgICAgICB8ICAzNSArKysrKysNCj4gPiA+ICAuLi4vYmluZGluZ3MvbmV0L2ZzbCxl
bmV0Yy1tZGlvLnlhbWwgICAgICAgICAgfCAgNTMgKysrKysrKysNCj4gPiA+ICAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvZnNsLGVuZXRjLnlhbWwgICAgfCAgNTAgKysrKysrKysNCj4gPiA+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZnNsLWVuZXRjLnR4dCAgICAgfCAxMTkgLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMzggaW5zZXJ0aW9ucygr
KSwgMTE5IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4gPiA+IDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy1pZXJiLnlhbWwNCj4gPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQNCj4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvZnNsLGVuZXRjLW1kaW8ueWFtbA0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+
ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5ldGMueWFtbA0K
PiA+ID4gIGRlbGV0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9mc2wtZW5ldGMudHh0DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdA0KPiA+
ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy1tZGlv
LnlhbWwNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2ws
ZW5ldGMtbWRpby55YW1sDQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXgg
MDAwMDAwMDAwMDAwMC4uNjA3NDBlYTU2Y2IwOA0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5ldGMtbWRp
by55YW1sDQo+ID4NCj4gPiBJIHN1Z2dlc3QgY2hhbmdpbmcgdGhlIGZpbGUgbmFtZSB0byBueHAs
bmV0Yy1lbWRpby55YW1sLiAiZnNsIiBpcyBhDQo+ID4gdmVyeSBvdXRkYXRlZCBwcmVmaXguIEZv
ciBuZXcgZmlsZXMsIEkgdGhpbmsgIm54cCIgaXMgYSBiZXR0ZXIgcHJlZml4Lg0KPiANCj4gQ29u
dmVudGlvbiBpcyBmaWxlbmFtZXMgdXNlIHRoZSBjb21wYXRpYmxlIHN0cmluZy4gU28gbm8uDQpB
Y3R1YWxseSwgdGhlICJmc2wsZW5ldGMtbWRpbyIgY29tcGF0aWJsZSBpcyBub3QgdXNlZCBpbiB0
aGUgZHJpdmVyLCBJJ20gbm90DQpzdXJlIHdoZXRoZXIgd2Ugc2hvdWxkIHN0aWxsIGtlZXAgaXQg
aW4gdGhlIERUUywgbWF5YmUgd2UgY2FuIHJlbW92ZSBpdA0KZnJvbSBEVFMgZmlyc3QsIG9yIHJl
bmFtZSB0aGUgY29tcGF0aWJsZSBzdHJpbmcsIElNTywgImZzbCxlbmV0Yy1tZGlvIiBpcw0Kbm90
IHF1aWV0IHJpZ2h0LCB0aGlzIE1ESU8gY29udHJvbGxlciBub3Qgb25seSBwcm92aWRlIE1ESU8g
YnVzIHRvIEVORVRDLA0KYnV0IGFsc28gdG8gTkVUQyBzd2l0Y2guDQoNCj4gDQo+ID4gPiBAQCAt
MCwwICsxLDUzIEBADQo+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAt
b25seSBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ID4gKy0tLQ0KPiA+ID4gKw0KPiA+
ID4gK3RpdGxlOiBFTkVUQyB0aGUgY2VudHJhbCBNRElPIFBDSWUgZW5kcG9pbnQgZGV2aWNlDQo+
ID4gZXh0ZXJuYWwgaXMgYmV0dGVyLCB0aGF0IGlzIHdoeSB3ZSBjYWxsIGl0IEVNRElPLg0KPiA+
DQo+ID4gPiArDQo+ID4gPiArZGVzY3JpcHRpb246DQo+ID4gPiArICBJbiB0aGlzIGNhc2UsIHRo
ZSBtZGlvIG5vZGUgc2hvdWxkIGJlIGRlZmluZWQgYXMgYW5vdGhlciBQQ0llDQo+ID4gPiArICBl
bmRwb2ludCBub2RlLCBhdCB0aGUgc2FtZSBsZXZlbCB3aXRoIHRoZSBFTkVUQyBwb3J0IG5vZGVz
DQo+ID4gPiArDQo+ID4gVGhpcyBteSBsb2NhbCBkZXNjcmlwdGlvbiwgZXhjZXJwdGVkIGZyb20g
TkVUQydzIGJsb2NrIGd1aWRlLCBGWUkuDQo+ID4gZGVzY3JpcHRpb246IHwNCj4gPiAgIE5FVEMg
cHJvdmlkZXMgYW4gZXh0ZXJuYWwgbWFzdGVyIE1ESU8gaW50ZXJmYWNlIChFTURJTykgZm9yIG1h
bmFnaW5nDQo+IGV4dGVybmFsDQo+ID4gICBkZXZpY2VzIChQSFlzKS4gRU1ESU8gc3VwcG9ydHMg
Ym90aCBDbGF1c2UgMjIgYW5kIDQ1IHByb3RvY29scy4gQW5kDQo+IHRoZSBFTURJTw0KPiA+ICAg
cHJvdmlkZXMgYSBtZWFucyBmb3IgZGlmZmVyZW50IHNvZnR3YXJlIG1vZHVsZXMgdG8gc2hhcmUg
YSBzaW5nbGUgc2V0IG9mDQo+IE1ESU8NCj4gPiAgIHNpZ25hbHMgdG8gYWNjZXNzIHRoZWlyIFBI
WXMuDQo+ID4NCj4gPiA+ICttYWludGFpbmVyczoNCj4gPiA+ICsgIC0gRnJhbmsgTGkgPEZyYW5r
LkxpQG54cC5jb20+Lg0KPiA+IFZsYWRpbWlyIGFuZCBDbGF1ZGl1IGFzIHRoZSBkcml2ZXIgbWFp
bnRhaW5lciwgaXQgaXMgYmVzdCB0byBhZGQgdGhlbQ0KPiA+IHRvIHRoaXMgbGlzdA0KPiA+DQo+
ID4gPiArDQo+ID4gPiArcHJvcGVydGllczoNCj4gPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gPiAr
ICAgIGl0ZW1zOg0KPiA+ID4gKyAgICAgIC0gZW51bToNCj4gPiA+ICsgICAgICAgICAgLSBwY2kx
OTU3LGVlMDENCj4gPiA+ICsgICAgICAtIGNvbnN0OiBmc2wsZW5ldGMtbWRpbw0KPiA+DQo+ID4g
IiBmc2wsZW5ldGMtbWRpbyIgaXMgbWVhbmluZ2xlc3MsIHdlIGRpZCBub3QgdXNlIGl0IGV2ZXIu
DQo+IA0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpOg0K
PiAgY29tcGF0aWJsZSA9ICJwY2kxOTU3LGVlMDEiLCAiZnNsLGVuZXRjLW1kaW8iOw0KPiANCj4g
SW4gZmFjdCwgdW50aWwgSSByZWNlbnRseSBhZGRlZCB0aGUgc3RhbmRhcmQgUENJIGNvbXBhdGli
bGVzLCB0aGVzZSB3ZXJlIHRoZQ0KPiBvbmx5IGNvbXBhdGlibGUgc3RyaW5ncyB1c2VkLg0KPiAN
Cj4gDQoNCg==

