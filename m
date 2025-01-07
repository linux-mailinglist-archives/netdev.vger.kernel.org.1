Return-Path: <netdev+bounces-155663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63C1A0350F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC817A07B1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311F141987;
	Tue,  7 Jan 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AG9h5TBw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D91991B2
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216403; cv=fail; b=RA9uu38Tloy/E5K2tZ8LQfl5y0MIFTK0PXF380GwkUb/ic19hkHcIqbP9fCZPalmH1LgOVdwwg2oQ6/kf4/y66WVteioKcOSGZsQkCnxY9R91Naoj/Mbg6Pe866skmFqzkXV8QAjXDI8xVYjB3xSxC1mDPViR7H/CpfQpsn01d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216403; c=relaxed/simple;
	bh=t/+BIOpdUZ7aY58iBnXMVkP/u7FTJQxHeRt68pJAlCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rwwIxc/CX1ZK1hA7+K9jTgW/tivaplnpgv0SM2bd46WMZlt0DW28FK1KIu+Vi7/VABLj7GzJc034fTSXGbx6S42CFZuCmGR+8a+QXa21B0Jdk26SpNkqhL0R4H9XaaiSa39+a3tSez+Xsjp1iwA7prKOEMcTnRRPRO5LEFzeeJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AG9h5TBw; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLShhgRMWGZT2Hyy1oiO6wt29EU0DdKT0L7uS5SgCILRgh9ROM9+F9kQtYUxWL76DXKq6aWT8/GqL66taBw7QRPOeVlNnhEdtAsMR3CWuGdnLDOAhkturnKVHdSGVtYpd4boVHhsX7CDSJRfyUrIJF84VLru7prH3KYkO5GseAcoOZbrj1RDTOh/t2y7wtZNKHzfxxC1x4kdIMmmOP/qwJJcL1YABzdlrNNutrOwddzmTCM4VjCbyzX9Bb8ZEUHjtCyNptbDteh+N43AwnJmvnR/Xj7vleGbh1Q6AM0bJNhsJ3Vb8KflbyQa1W9ZbPNGXP4ziaFWqi8+BGV8nttaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/+BIOpdUZ7aY58iBnXMVkP/u7FTJQxHeRt68pJAlCI=;
 b=ZB5LdvWvmJcmpL/59/Muyvb6ov9sx6ns67k39s9Jn0H/QTzH2duRjDyBdPz9aJ6uCkQzL7k6c5zAGX3gsINZvFFZ12c6I9ufvonVmAaRBCOm/Vt8vHnm7utm2WkjsUp7HuO75rwIHSMejQ7aHEzTi+FcXFKQgiF/k2speVCINQDm8AnyjtOQ0gCv2lBBgPd1lmuiVW8Hm7UjZmxYSPkVWPzcRZQ/YrI5X757uUqumyUQ7M+ahUjSqYU4rxKUCg0Gf/4xFilo5vNKu5M0Sd41/4pydAF7jtK/XogK5z2CpV6IxTCF6vd/zqegJWNv6QADLbAhKP4RjyIOLBGLn8IwpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/+BIOpdUZ7aY58iBnXMVkP/u7FTJQxHeRt68pJAlCI=;
 b=AG9h5TBw1KS/g4Jo8hwp4ZT9IOy5KqtjkVtrEuhRhdiVmBPB+P354IEcDSI1mJn2iPQGQPUyEz7JE9acIsG+AqAV2L6mdgxStFeRCwK6+n6tDIZ8IeB49ldCZMDMxggA9hSjYEap+gcVSTNLE5n2XpJVXWmEkttHJDlfr3zPqKGGNbHkDNfD9NvI7Sij4ITZsNY/ykXh+Z27O0mVcCaM6mjlOLu9xTwzWLhlD1J+MH8PGCE+t7X1xKVUXEJ+efe97pXWUCh1wXLTjP3PbKUF5hXaNpoaWUfsquOhCLXsjhlcR2FRHLqIt6GYpoqqjQwiBH+FCZIOPxq5Mt59lz41sg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6809.eurprd04.prod.outlook.com (2603:10a6:10:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 02:19:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 02:19:53 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Russell King - ARM Linux
	<linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: EEE unsupported on enetc
Thread-Topic: EEE unsupported on enetc
Thread-Index: AQHbYEAEPp0VVipOt0OTBhisL57pd7MKgsxwgAARFbA=
Date: Tue, 7 Jan 2025 02:19:53 +0000
Message-ID:
 <PAXPR04MB8510028FA548562F1A7B7A1688112@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <965a1d69-d1fb-4433-b312-086ffd2a4c12@gmail.com>
 <PAXPR04MB8510A9A1597FEB4037E76DDB88112@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510A9A1597FEB4037E76DDB88112@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB8PR04MB6809:EE_
x-ms-office365-filtering-correlation-id: d5e4ae2d-a827-4d27-f321-08dd2ec1c58b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WU5JcmRzR2xhTFNvNyswU1hkUVNaVkNyVVZuVndYTGM3RENKczdmR1FSSkI0?=
 =?utf-8?B?MFIvYlloMVc3bzFqenJURG9ndGx2MElBMGdSYVdVWVVGaC9GU2RUQzluS0hu?=
 =?utf-8?B?b1FObktPbUFCL240Nmt5UFFUa1JOUnU4MkR4eWd4Tmwzdm05YXBOVHpEZlFj?=
 =?utf-8?B?MEs5cEF3Q3htR1NOV3FvYytUTUM1Y3JjSENNd2hTL1Urai9JcFVLNjZmellm?=
 =?utf-8?B?elRzS3hHelFTWkcyM2pFWk9iR2VCeVhCNDRvN3RVc2VndnYzN0lmeVJSaXhs?=
 =?utf-8?B?Qk5NNlRaZHltaXJjdlYzdmtsbGlTZlpobkVkZlh5UGNzN0g0eHY2NFFZemlJ?=
 =?utf-8?B?MEt3aE1XM1g3d2RhKzQ1Z1VZc21MS3EwOGZpOE03Y0plUGV0RndtbzlEZWxz?=
 =?utf-8?B?SnNxYUl1U3QzVmh5VitGYXlONjZqZGdqQlJhUWFaOVZIU1lENUxFODJ4bFZ2?=
 =?utf-8?B?T3hFeTlBc0FJSTZieXJlY3RiWGJhN3RBMVRpRUhVYmRSZVpIK0tBRGlFWDA3?=
 =?utf-8?B?bVh0YzUzQ084c1Z3WkpBTTlRaUE1K29DVm9rSTJab1V2NUVsczJuaWU5OW5s?=
 =?utf-8?B?c1R6UllDRFgwZW9kYmRmUjUycHRsc01iVWs3UmRLdG9CVDlGN1NHU0IrVk8v?=
 =?utf-8?B?d0pMVFhVemFqaHlXR1VpQ1FUcVVNZ1p3OTVPQVlEbGYzem1JYmZITEh0aEZo?=
 =?utf-8?B?a2M4V2k2bXdCbGdGMVcrQ09VMkJHMjU0K0JKV0dKYm5GaUNoMEdFWWZCalR4?=
 =?utf-8?B?am9yOU84VkZnNENrRS9xSGcyQ3ZOOCsvRUFGQmZQM2xIMHBoVmg2alB4Mllu?=
 =?utf-8?B?WWpSd2JXYVpkRWs5Si9UaUd0bm8rWTE0SFgvWFZBSFQ2M1BHQmE5QkR0Z25i?=
 =?utf-8?B?UWVpZzhlaHozZDhUOXBPRTI3QklxM2tIcEcrMHlYd05SemFKa25sL0RCOVcv?=
 =?utf-8?B?WkY4QTd6d2pncEMyWENHVldKVWh0UXE5Vk54OGNwRGVHL0dJOERvR3pnL2pW?=
 =?utf-8?B?U0IwME5wU1ZtOGQzOGNDeGU4OVVGUU1HcFNlMFdEckpudWRmNFJtd1UxRmox?=
 =?utf-8?B?My9YQnV5TElJUjRJVkRBWXd0dDFPRE9TbnlzTXVUTlFUNDQrcnRxQ2k0WExl?=
 =?utf-8?B?Y2VjbVUvQzVzWGpJb2RGWkVKZGNJNlBnanpKaEVXZlJGaVpObjdVQ1pzRU1q?=
 =?utf-8?B?T040eUlUN1ZoZCtZZ0ZnWnJLMUhTTGNnVUdpaDNHWXlSb3k2Y05ITktSVm5W?=
 =?utf-8?B?eUppQnByZXFsZnNudlNrTkd5RXZPbW11U1EwdjZha3FFSGRRK1U5Z3g2eDBQ?=
 =?utf-8?B?b2JFSWJLZTZYTlZyMjg5UU4xR2hzZjFIRmN2YWRXSXFNN1V2YzNsNlFnZUlL?=
 =?utf-8?B?clkyR2NHRGZ6Vmk2dDhjbnZRQnNwMUxaSnhEZ3NiUnZmam1SWXpzUGM4SGFi?=
 =?utf-8?B?YnF5SU5CQm9kQmF4OWtWSUdvSTZtZkM5WnJBbTBWTlh5ZDlpN1JNdkp1Wk1C?=
 =?utf-8?B?MTdYWGVtNjJCTDNMc1h6Qk9OMS82RTNFT1Z3TjZIRkpHWG5iLzhVSDUyZmxI?=
 =?utf-8?B?c1RDbzIwenZjZVFXRmtNREptZXVLcjBtL3JNaTdIT3RCNVJiWjNzQ3pYUVhz?=
 =?utf-8?B?S2VwekljSzZRMGpDLzZjbGZkaHM1ZEo3SlNMV3B2bEVKYmFZWDdyRXFwcDIr?=
 =?utf-8?B?bURXT0lCYk44Z2lsSDErZ3JDODI3V2ozdnZaY0tSYzVOdE9pM0tRZTh5RDhI?=
 =?utf-8?B?L1E0MFRNQURWRlpVSWlleHprSkFydEdxUW80VWJzR1o0bXpaR3pOTi9TRG9Y?=
 =?utf-8?B?RWpjRnRnS3Z1Y0syRUlxVzFvMUltVEVCKzM4QjhOMytIQXBzSWpHcFlFM1RF?=
 =?utf-8?B?UExYOVNsRVRkM2FtMVZMU2NUMEFmV3RVblFrbGFPTEcxUngyVHVjQlJ2bnFI?=
 =?utf-8?Q?8CJHLefN4lolqO/PDw7z+20GHQIEsD04?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVFVTmp2WDJwNWdKNjlHWmlnYTVEME5PTzZscC91RjVPakFQOTgzNXVac2hm?=
 =?utf-8?B?K09iZ1JPd1pmdlk1aVZnRFRNSzFVV05wM2xybE9JZWFjTTRGOHVSQXE3OFZY?=
 =?utf-8?B?V0ZiYnZIOGFVaGJrM0tjV3lObjF1dmxJK2JiOTJPNVdXTU9XaDJNZHNoaytR?=
 =?utf-8?B?SysvU016ZXNVWFNjc3JyQ0w4OEhicnFGTXIvNFZQTXM1ZzFGc3dObjl2TG5U?=
 =?utf-8?B?NlJ5WmN6TjlCS0xzdWxzVUhWWFowK3A4eXJzejNvTUhTZWQ3V0orMkhYcnRm?=
 =?utf-8?B?ZnQwaHNab3gzb2JFekRJekdDU3M0U01adU4yckdVcVZKNW5xSWpCNmxRNVdv?=
 =?utf-8?B?clB6QndSWmsxOXZxbi9SS1gvVjhxRmw0YVFJRitFQlB4cTdPOU9GbjZBYm1Y?=
 =?utf-8?B?K0VKRmxpeWNEanZBY1Jra2w0Q1QxdC8vR0ZqVTBsRmF2N0U5QVlsSmhJemFm?=
 =?utf-8?B?eXRwRm5ITVdXdUw2Wld5OVFsTGNtVWJDS1ZzY2dLMXFVL0tUYUxWOS90YzRQ?=
 =?utf-8?B?M1BBUURVZmRwNFA0UDA0RTZxbjBrMGo2bitIRW9uUkUxNVoyZXJZR0dIQUZi?=
 =?utf-8?B?TW9ZY1IxcEMwNi9UQ2FJWTJyRG9JenJSVWNzTU5sdmc3THFjZEx4alFjTWc1?=
 =?utf-8?B?Uit1WHNOWVdRbDdpa2x4MGlGK3RTc05WaWtTSmdYRElhQ29QUXVvSXdMU3N0?=
 =?utf-8?B?dTRCRTRwYU1NVDdkVGpGZkhUUmN4akhoVHVXRkttSHduaTY0LzlBTUdRYVVY?=
 =?utf-8?B?MjlHUXFlVGlYdkx4UTZHbVYvSFp5T29ta0xRbWxvTDMxN0x0YURiUHBuUUhD?=
 =?utf-8?B?aks2VERCa0JubnJhT3VKOUl5RXJRTXRFYUV2OVpPd2JsQ1FuVXU0cmNmWnhy?=
 =?utf-8?B?blV3bXo1VURDaEd5UXdQa2hxNklLZkp0Q21ySktxVUNhWGFJNGhWY0hxeFds?=
 =?utf-8?B?bUk5b0xXdWNvc2srVkE5MzZ3TUcwZnFPNlNtN0EwbllQdDJEWXVYUEpUVkZ1?=
 =?utf-8?B?Si83aG91eFRtVTB5bjJtcUgyY3hnZklsbjFqTERNUlg1MkEyNFZ4b0JORGdn?=
 =?utf-8?B?Vi9OZVZmSWNtdXdKc0x5T1dwZzZkQ2JhdEN2YllJTWsrNVM3UlJvcUNpeWpl?=
 =?utf-8?B?dVoxRTlWNWVKTi9EQTd5SmZmejNFaG5vWXpSajhGcCs5bFc3ZVBOUXlSUDg4?=
 =?utf-8?B?THZUV2NGbEhGcXBrQjdqRHl4ck9hSTdvWWZ3cHZGVE1CaFEvUktMWUpYVlZt?=
 =?utf-8?B?bldGdXZ0WkEwRnpzZ1VyVTFOczZrSGZWQjZwS3RiRCtUbXV5ZDlEZHZHNk51?=
 =?utf-8?B?R1V1RFdzUTR2dXVOWG5DNFhBd0hmbzlTNFV0cXE5UFBGMmdxajhVUHkzWFZt?=
 =?utf-8?B?SUwvL1pqalJKazhtMFNvdGNwSGZkbldzZmEzM0hOczJmZ2c4bXQxU3BmL0Nr?=
 =?utf-8?B?aXFpS2xHcngyRmRFN0YvR3BiVWVHeVJsdlFoSHl6ZWtZWWh1YWMxWExjc0lM?=
 =?utf-8?B?R3A4UFpLR2RxckxVVmtVU0VjV01lUjVWUTZZa3VxVm5nTjNzdlBzUGpZQjlP?=
 =?utf-8?B?bDdQWUZxR3JuTEF1MExScXBUanhXQUVLMC9hZUhBVCtZWEcwNmhJK0RGMjlG?=
 =?utf-8?B?MnJ6WEdxTUdlZUYwV3JPblFtRVd0cndVTXZHMlVTbExkRlRNTjBQcGVlTmFt?=
 =?utf-8?B?N3NpVGJlVUkwaXkrQ0Q1MEJ1VVorblFSOXphQy83NFRZNWxPZnJxcDgrSFJn?=
 =?utf-8?B?MSs4aDJTRWhTamRxYWtBckllU3hwUHAvaURqbFR5d2lkc2V3VjhRQktzcEVL?=
 =?utf-8?B?eU9NVWpjeDJ5TDhFdllLUnY0M2NoMjlFTllHYlV0Y3k0NFRPTSt2TmdQdHZZ?=
 =?utf-8?B?T25BU1pUMWM3azgyaUJwRVJiRUJlQXhwdUdrZUZ5dDRmQ0xZK2RnbGRiS3hu?=
 =?utf-8?B?S3J3cHRjQmxUNU9XYlZRS2JFdmlUOEVMSjJ2bEl1c05EU0dObHI2Y3EvUVVD?=
 =?utf-8?B?QU95SWtveFRHeFVYL0FQVzNQRFJiYU9meEJ1S3MzZ1NXUWhyZzBOL2pGRWg5?=
 =?utf-8?B?TVEzSlo3MVllUlF0eEpWK2FVd1d1NlVNRHptTWc4endQRFRLa2hQazBGRHZK?=
 =?utf-8?Q?6Tx0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e4ae2d-a827-4d27-f321-08dd2ec1c58b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 02:19:53.3990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMfxAYVBxFnL90EESlkm388WGrUimMXuNfXyI8ERYa6i+cMMhSdJ3sg4XvZiE1UKdNVkK4vOo9hnsNKJ97+lug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6809

PiA+IEluIGVuZXRjX3BoeWxpbmtfY29ubmVjdCgpIHdlIGhhdmUgdGhlIGZvbGxvd2luZzoNCj4g
Pg0KPiA+IC8qIGRpc2FibGUgRUVFIGF1dG9uZWcsIHVudGlsIEVORVRDIGRyaXZlciBzdXBwb3J0
cyBpdCAqLw0KPiA+IG1lbXNldCgmZWRhdGEsIDAsIHNpemVvZihzdHJ1Y3QgZXRodG9vbF9rZWVl
KSk7DQo+ID4gcGh5bGlua19ldGh0b29sX3NldF9lZWUocHJpdi0+cGh5bGluaywgJmVkYXRhKTsN
Cj4gPg0KPiA+IElzIGl0IGEgaHcgY29uc3RyYWludCAoaWYgeWVzLCBvbiBhbGwgSVAgdmVyc2lv
bnM/KSB0aGF0IEVFRSBpc24ndCBzdXBwb3J0ZWQsDQo+ID4gb3IgaXMganVzdCBzb21lIGRyaXZl
ciBjb2RlIGZvciBscGkgdGltZXIgaGFuZGxpbmcgbWlzc2luZz8NCj4gPiBBbnkgcGxhbnMgdG8g
Zml4IEVFRSBpbiB0aGlzIGRyaXZlcj8NCj4gDQo+IEhpIEhlaW5lciwNCj4gDQo+IEN1cnJlbnRs
eSwgdGhlcmUgYXJlIHR3byBwbGF0Zm9ybXMgdXNlIHRoZSBlbmV0YyBkcml2ZXIsIG9uZSBpcyBM
UzEwMjhBLA0KPiB3aG9zZSBFTkVUQyB2ZXJzaW9uIGlzIHYxLjAsIGFuZCB0aGUgb3RoZXIgaXMg
aS5NWDk1LCB3aG9zZSB2ZXJzaW9uIGlzDQo+IHY0LjEuIEFzIGZhciBhcyBJIGtub3csIHRoZSBF
TkVUQyBoYXJkd2FyZSBvZiBib3RoIHBsYXRmb3JtcyBzdXBwb3J0cw0KPiBFRUUsIGJ1dCB0aGUg
aW1wbGVtZW50YXRpb24gaXMgZGlmZmVyZW50LiBBcyB0aGUgbWFpbnRhaW5lciBvZiBpLk1YDQo+
IHBsYXRmb3JtLCBJIGRlZmluaXRlbHkgc3VyZSBDbGFyayB3aWxsIGFkZCB0aGUgRUVFIHN1cHBv
cnQgZm9yIGkuTVg5NSBpbiB0aGUNCj4gZnV0dXJlLiBCdXQgZm9yIExTMTAyOEEsIGl0IGlzIG5v
dCBjbGVhciB0byBtZSB3aGV0aGVyIFZsYWRpbWlyIGhhcyBwbGFucw0KPiB0byBzdXBwb3J0IEVF
RS4NCg0KQnkgdGhlIHdheSwgSSBhbSBjb25maXJtaW5nIHdpdGggTkVUQyBhcmNoaXRlY3QgaW50
ZXJuYWxseSB3aGV0aGVyIExTMTAyOEENCkVORVRDIHN1cHBvcnRzIGR5bmFtaWMgTFBJIG1vZGUg
bGlrZSBpLk1YOTUgKFJNIGRvZXMgbm90IGluZGljYXRlIHRoaXMsDQpidXQgdGhlIHJlbGV2YW50
IHJlZ2lzdGVycyBleGlzdCkuIElmIGl0IGRvZXMsIHdlIGNhbiBhZGQgRUVFIHN1cHBvcnQgdG8N
CkxTMTAyOEEgYW5kIGkuTVg5NSB0b2dldGhlci4NCg0K

