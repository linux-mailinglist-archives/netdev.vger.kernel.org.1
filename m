Return-Path: <netdev+bounces-207186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BB8B0624A
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10B93A8665
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F11E5B7B;
	Tue, 15 Jul 2025 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ll1KcG7/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4E2186294
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591893; cv=fail; b=GUJcX5zWs0jjvQbqi+WjZdvFWuvj2PzMcPycbXerMtQQ+w3DA9Cl5R+GPpHWbBHF2mhSYIGrc8tcgMP+kXWTF59DUFvsxuFzbYK4oO9fT1IYeYm8dHNj+4WZCL2BPvkWH9NxDg07eu0eX/A+BeXImvNlT5uV4Mf6So57cFcaKAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591893; c=relaxed/simple;
	bh=cQA4y3Ls151BKJyDEEogNk9+Q82OemcQDuzVS9AK9cc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=evYedGBsYIzP3p9KsewRtBuantXbhTei0B08UAX3xIzFl+K4pTy+w9lLgwUGM+/3GqkePtd/wyTGaPVe7sfhQTSPKtu0vMywbvL65UcMxoQATdExiYg6xPGKOF4jK8X0PojHWcu9qIJMGnhF/WICm1aRrUlfXK7ymbdlquSo30Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ll1KcG7/; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA7hD1jMmNanpsHrrvkcaNnK+ZkMlZL4m+Iu7OkPehoWwp1z5XEYOMIKAT4AFwUQvt8QYmSMehHplYS1SYZPsmfuOjA+N4uOXKKOQLdaZcbjUcslmik+HMiKnIfoZJRC5uyBa9XymlZCxMx9esQKhIAgHGVFavi1ZBTZwQLSnuij4xgBIHrH/QtNum4dM9OVdexNISrSf7je3tXaDQvGkQlon9MInl+KhTfK/G+/HUfCqIkhw8HUe03UvGIbp9rXAkrK20qjSdhnhCpIaNR2zoXNJG2qtOsvB9f9BQ0zTNAAbqdjI/Z7EeoZq9av/BO8iG5UvtZ9GqlaPzIixF+0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQA4y3Ls151BKJyDEEogNk9+Q82OemcQDuzVS9AK9cc=;
 b=gblgmGitdVvu5fPfOZoBSFNGcKCGD+RU3CthFJAu6Bbw8v0l3ysfNuBbjlBvSJH5lQCUDwNQ21Oz0RMAcNxyUc/Wnsz2TDaheNDMXkVJYpIbrVIBYvgHZ9tS9xqFVK3AktbYeEY7OwqQMR75KJMdyUdjAJJvIAS9qbc9ZiLEjfYpMi5wMpzZzDa4URb3NWxX4xu/DafWav628NF7WdebFF0R664tTKPbvvaT3wbQZwgZY+NBeW1ifiu6Saoq07zi5dMf6dj1WvM/MSyG0WMlnZqBU6m3AXPtL17+NRTjJfLMMY95hP0aX5GaB8w6tcFCEz9CamvKmaBiGRzN8WUXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQA4y3Ls151BKJyDEEogNk9+Q82OemcQDuzVS9AK9cc=;
 b=Ll1KcG7/7NGblwiVfwgdxK+ODWX5lSAIRawAR2PVz1FaI9tg3D7DvPwoKxeRBy9a+pneH9JYB3oxuNPumm+11Iwy8UH/XoBM7/c8X1wUrNCOnRMltiASNOr2bAXgY/3EGk9tEyVWIsmu7TqBv5ddL8dwCrGSNUXpKRREJtbb2t72cyl5iz4vqZZhfsFx8yMKsQCW3EQr/jJaPQkk6V9L3V/aZKA9BNhXg573NM17DJv38sL3uoRGo8nfZZoLuZt+hfUV8xMuk4N3pU7lifKQy5VHP7NqEyncSTZltG74iPcOs9zRGSDj0Tulzl+8a15KXTUhK3DAx+ZVgnSn/aFBdg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by SA3PR12MB7974.namprd12.prod.outlook.com
 (2603:10b6:806:307::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 15:04:48 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8835.025; Tue, 15 Jul 2025
 15:04:48 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sdf@fomichev.me" <sdf@fomichev.me>
CC: "kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Sleeping in atomic context with VLAN and netdev instance lock drivers
Thread-Topic: Sleeping in atomic context with VLAN and netdev instance lock
 drivers
Thread-Index: AQHb9ZnO+kjhBdD8ckK42p/bZlc01A==
Date: Tue, 15 Jul 2025 15:04:48 +0000
Message-ID: <2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|SA3PR12MB7974:EE_
x-ms-office365-filtering-correlation-id: 2fb41265-7f1e-43c6-dece-08ddc3b0f15e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlppbGpwaDVXS1ViVDdUMVZTeG4vMDIyT0ZHMTI4QTE3QjFpaUFicTRCMzQx?=
 =?utf-8?B?VktUZTc4MUhtWDJsTlFFazM3L2xQTWtkTy9mY3UyQW50VDBFVTJ0K2gvS3Ra?=
 =?utf-8?B?Yy9meDdPRzg2czJHZ3JEa3J5QWI0SUpjYWVFUGE5eVpodlUxUzhJZmhlVWxH?=
 =?utf-8?B?dlhvSVZNYVRFaWZ5VVU1R0k5NmhLeCttUm1qQnZINHlEcC9HL0VCUWJ3R01a?=
 =?utf-8?B?UFd5T0liRTdkNEN0WjduaEszTENlK3g2U1ptaHN3cFRKQ2g1UnhML0JjeU4y?=
 =?utf-8?B?Vkl4VGJycElsRkIzVzJXdWpzWUpaamVjajFxcTZQVlBpWVdQOXM5UnJPRGpY?=
 =?utf-8?B?TFBwZWZuYlFtZ2YrV2xNamo0MEFPVFlFSWZtZndONFRlVUd0SUg2QXpaUEh4?=
 =?utf-8?B?QnovOHFtZnc4b253ZkdhdDkrbGVJbmtuZ0xhWnFkM2sxSm12MzEzUzVzSCs2?=
 =?utf-8?B?TnFwVnovLzNqbklMSm43YzhxRldSRTFWQVBtaDU3VTltdFNrVHRTK2J5S0M4?=
 =?utf-8?B?RnpxaXlLMnZKODV1RlJoc0xXejhsOUFMOXIxdVRkMmtiWUprbzZPTERsNXRs?=
 =?utf-8?B?ajNmcUt6OUhDbDZ2aFNjdnRROXY0ODJHZ2dTZEVubm5lOGVUUDlyaitFTUJL?=
 =?utf-8?B?cGdDVlE2ZUh6RzNGZEEyYXM4U2YrWkUySEwxaDN5YkZyT2YvSFV2blQ1c1dx?=
 =?utf-8?B?bUt3RmxKcVhObnJQM3dRckRhRnJPUFlCeTRRZndHMUVJOEtYMUxrT3RaN3d4?=
 =?utf-8?B?UWZWQzZmcnprcmNUa0FrWEIxejF6ZVR2VHVNZkZ3T1dXcDRhV1BGdUJqZldp?=
 =?utf-8?B?amx5cFVCSUtERGNLa0RCRlFLT0xyN1R0akh3WkpVZmFVeFNibnRoZHNvenNK?=
 =?utf-8?B?VHM5Q201TDIwcERoNFB3UjYzZUxsdnZ1andFdXVrc3JTbEhxU2VDOUptVmxo?=
 =?utf-8?B?MFgxK290bmlQRFF0d2ZTRjYzL3pKckZwYkNlaUV6KzB4MUR6aS93K0xvQnkv?=
 =?utf-8?B?clF1dkN6c3RIMFJpVUhiREsyT1Uxd004VWZIVXo0UXFBMzBVdWo4eTJiaHVl?=
 =?utf-8?B?SHNoUTVkT2M4cnFjRlVneEU5aEowV2cwcEMyMXJ0SjFDOGdHbHRjbHNWdDZV?=
 =?utf-8?B?UkhaS0lXTXBjREFXZ1JzRGNrcnUzTThZVzRFWlNVNUp3MlN6T3dzSlNmaG1y?=
 =?utf-8?B?ZHNFVVZhT1JlcFVZNG5zYWdTSmZtMkljaWw3a1p2eVRNK25OMENYYklOWG92?=
 =?utf-8?B?Qi9IR2NTZjZwQXduSWNHNWlYMVlvZ3RLaVNNRFFLdVBuMUEySlQ2RmhPckxC?=
 =?utf-8?B?K1lqOHA2ekVQMml2TVpoc2poamM2T00weGU1eHFwdFVCMFZqb0JpN1FNbE1T?=
 =?utf-8?B?U2tvTERWL1plWG1WejZLY1V3TW5ZdlB5SDNBRHhiVU5qVlZja0Nid1VWWjVC?=
 =?utf-8?B?RXBuVUJzaTczaE0wMWxTVGR3NDVMb0lkRmdRSEFINy9wVmNzcTM4QlVJS0ZN?=
 =?utf-8?B?a08vZ3VhbkUvKytLUk5oUHZaZHpKd2VzUUtoalcwSlhZRkRxbTdXMEgrVFRI?=
 =?utf-8?B?Q0N3Z1BkT0czTCt6M2ROb09jYXVTTzdWWndwVlROSWhSWnFBNWl3YkhtUWlj?=
 =?utf-8?B?a0hSVzJQOHlaMGVCaWFZa2ZXWHE3eTFmYzdnTkNHdDFQRmFoMGwxTzRWSFpz?=
 =?utf-8?B?anBoNmNQeFZxU2ZDQ1dNcm9JRzNlV2kzdDhUK2FMd0ZmUGdPU292M1VEUzR3?=
 =?utf-8?B?ZVB4dW41UFlIaDk5aXdzUnpzdVAvVHZ1aTBBbXZhWmp0dkZuc0dzdEVNRW04?=
 =?utf-8?B?c1V0aUJRSnZtdVdzN0psMWRYeUk2R2ZHRmFTQVNuckdrcUlEaGhZSnh0dmFa?=
 =?utf-8?B?Rlg2RzVwL2IrZ0p4MTRZU3JmRk0rWTJSeDdHeHNTRDVvb29GZlNYTno0eUw0?=
 =?utf-8?B?TzFWaHBCRnZML0NINEVsbEowcmZOODBDVlU2em1XbXNGcmJ3Ni9mWTNUTC81?=
 =?utf-8?B?Rm5DZVZ2NUp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3ZudFZLQ1ZqbFViQXp6U2pWbCtYTnlvOVdUVWk5UEtsRytjNFF1Z3pWQ2oy?=
 =?utf-8?B?b2R6REpvVGRhVm1JK29oanhPalRYSmFxV2NVKzJ2NEZSL3VvczdiZ2c3Tkdx?=
 =?utf-8?B?OVV2RTd6c0FoZkZGeDE2NE1WcjNqWDZYUkpGbDl2SXR4U1pxcmdNdUwrQUpE?=
 =?utf-8?B?RnJNNmFSK1kxN1hEZmwrM0Q0MFMvSVVLQ0pxdzBad3grWHVFNENsS2JoSXpL?=
 =?utf-8?B?U3BTRmRpNU4wUmJsbFE4YkFqVmdyQ1JXZW8wcm84Y0lQK2htQXREN3BFTjRr?=
 =?utf-8?B?OEpNQk5wNE5xMWVhRGV2Zk1Sc0pQdnRsdCtpTkNYMTdWRU9vNTc0akV3cEkw?=
 =?utf-8?B?Qmk1aFZwb2RsVnQyMjg5c3lKTEhwcTU1ZnJYVkNjU1hIamkrT3ZqYWhZb3ZZ?=
 =?utf-8?B?cHVuSXZqMEZFY0MxN2xadnltTnJXamRIb0p4OWJVK0pKQXFPYjlQMnppcVVU?=
 =?utf-8?B?KzIvVGdYZkR1eDlWUCtGZVZhUUgxakFwWkJSMldMZ2k2blVzSjZoYnRZVGp3?=
 =?utf-8?B?SEhTTHZ4RjhPN1VhdTJhQVJaWDY1WlJOcXY2cXI3S1NzeVRMdDI0eURqWVpM?=
 =?utf-8?B?bGovcGJwUkNianB6WCtGeGxjTkFkeUw2YTJDNHVUQkhHNkd5TXo4WjI2Vlow?=
 =?utf-8?B?Z0hoaUJITUpiZHMwc3NGczlJVDZYaHBKcHFHQU10RXd1MDdxSm1mMis0Njc4?=
 =?utf-8?B?UFdOQzFRd3pTSHR0elA5bDBtZ0thNnJCbnVkVk0rTE1TTHRNbGhPeE14d2JI?=
 =?utf-8?B?c0JKN2RDTHJhZ2x4NkdOLzBmeStLYXZLMWxTT2dVd3hCY0J0ekRQRXpaN3Bt?=
 =?utf-8?B?VytPS2hOY2UzK3dLNjk0L3ZCaXhMRlc2cTJ0OXIxVVdKaDFmSExobCt4eG5G?=
 =?utf-8?B?TzN4dU13enk1R1NrYUhoQ2NUL3hLVVJWWUIwdnlabmpEb3Q5Y2VYc1lVQVpu?=
 =?utf-8?B?K2E1cDN1M0tiOHBpMGtEUUJWOGkwSEhyN1JUbVJPUmRPTC80NDFBby9vaE5s?=
 =?utf-8?B?N0c1RjQ0RDRyV2wxZS9QWldZeUJSNUlPamdxbmlsM0R6SlptUUVlaUJHR2ZV?=
 =?utf-8?B?QUM4ano5aTl6RkVGNnFRc2dHcTRyRHNINE1VT0tncm5LQm9nYjRrSGlvdGxv?=
 =?utf-8?B?MmVCa25Hay9EYkRnVnBNSUZIYkhmK2d3cUp1QXJTWFJsVW1wNXpHUXhWd3pO?=
 =?utf-8?B?bWE5ZFBjdExFSDRNZVpxOXEyaWxNTDZ3R3UrcytzMEpIaURCRzVsUm52S3hJ?=
 =?utf-8?B?anliOExZQXVvdEozekRBcndDaDUzeGJDWGR0MkxFbWNXVm1vSjhrS1JKdWI5?=
 =?utf-8?B?Q3RqNjVzQm5GN0ZpRVVtY1hmdnVkTTg2Qk5aeVpVdnVqeXBGMWptK1BSSW01?=
 =?utf-8?B?bjNmcFc2VmhGeU5TMkhNdzV0UVNMaHg3K1c3RlpSS2ltZHdla3hySFdEN1Z5?=
 =?utf-8?B?ZFBKbEVEZHk1bUR6K1VnTzRkZm1hbTAvejh4WUpycEhiVjNKOEdzOE56b2cy?=
 =?utf-8?B?Qlg4UERjeWpydGdpRmFIcWY1eHdvV1NFVGVvcGNxak1aRFR4QlQzOWx5QUFu?=
 =?utf-8?B?R25zZ2JreTd1TGkzZVNSZ2QvWDVWbzRHakswSFQvNTBoVkF6SDZMbHZjUEY3?=
 =?utf-8?B?S1hBODZWQ21TbzUvdUh6SFQveEJsZ2pvcXVJL0hUZTkya2VEOFl4U3gxbGNR?=
 =?utf-8?B?RmkwRmM0dGpTVTg1eWNrUXBPZHkzTC8rWll1emo5bGJmRndqcjE2SUNNK3dx?=
 =?utf-8?B?d2xMbkpwSU9CWHFGbmVtSm9CS2hNYWpUZDFvT2hudC9xRGxFNXNLU0dnb084?=
 =?utf-8?B?Q29SV0YrZ1dXM3AwMzVuUG9mZzMrSUZqNDdKVm5WaEFxenpWakFoS1kvMDEy?=
 =?utf-8?B?aVZocHJpbVZUUCtZdFVyeTNPME1DdFh0eFMrS3NpYUxRUGh1NjB4cnI2UzBL?=
 =?utf-8?B?MS8zcHljK0NlSVBvR1ZkRFV0UExZRThiRnlxNWhGd20rREhqT2ZyaUZlNWMz?=
 =?utf-8?B?T0dZZEt4TVRJZFN0QU9DWTl1aFhFaXlMeWVLdis4Y0VqNDlZQ1kyTS9VdHpr?=
 =?utf-8?B?NkNmTy9adjVDaWdTQTEvbjNXZ2FTbVF0TmRBMEEwZFNPTmxBT3crUC9XSThM?=
 =?utf-8?Q?5BOfrGQpUsKQdmx8GjuEsVkgw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B663C375479B1045A3D6FB28656728FC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb41265-7f1e-43c6-dece-08ddc3b0f15e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 15:04:48.7082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLvFaZwRHF/Esb/KqGVah/DulN2PC6DJhEL8Ud8Uypbmezc64ZuE0L0PMQ/ory2Lh4bd1jddGv7Y7F+9p8EOSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

SGkgU3RhbmlzbGF2LA0KDQpUaGVyZSdzIGEgYnVnIHRoYXQgd2FzIHVuY292ZXJlZCByZWNlbnRs
eSBpbiBhIGtlcm5lbCB3aXRoDQpERUJVR19BVE9NSUNfU0xFRVAgcmVsYXRlZCB0byB0aGUgbmV3
IG5ldGRldiBpbnN0YW5jZSBsb2NraW5nLg0KDQpJIGxvb2tlZCBhIGJpdCBpbnRvIGl0IGFuZCBJ
IGFtIG5vdCBzdXJlIGhvdyB0byBzb2x2ZSBpdCwgSSdkIGxpa2UgeW91cg0KaGVscC4gT24gYSBu
ZXRkZXZpY2Ugd2l0aCBpbnN0YW5jZSBsb2NraW5nIGVuYWJsZWQgd2hpY2ggc3VwcG9ydHMNCm1h
Y3NlYyAoZS5nLiBtbHg1KSBhbmQgYSBrZXJuZWwgd2l0aDoNCkNPTkZJR19NQUNTRUM9eQ0KQ09O
RklHX01MWDVfTUFDU0VDPXkNCkNPTkZJR19ERUJVR19BVE9NSUNfU0xFRVA9eQ0KDQpSdW4gdGhl
c2U6DQoNCklGPWV0aDENCmlwIGxpbmsgZGVsIG1hY3NlYzANCmlwIGxpbmsgYWRkIGxpbmsgJElG
IG1hY3NlYzAgdHlwZSBtYWNzZWMgc2NpIDMxNTQgY2lwaGVyIGdjbS1hZXMtMjU2DQplbmNyeXB0
IG9uIGVuY29kaW5nc2EgMA0KaXAgbGluayBzZXQgZGV2IG1hY3NlYzAgdXANCmlwIGxpbmsgYWRk
IGxpbmsgbWFjc2VjMCBuYW1lIG1hY3NlY192bGFuIHR5cGUgdmxhbiBpZCAxDQppcCBsaW5rIHNl
dCBkZXYgbWFjc2VjX3ZsYW4gYWRkcmVzcyAwMDoxMToyMjozMzo0NDo4OA0KaXAgbGluayBzZXQg
ZGV2IG1hY3NlY192bGFuIHVwDQoNCkFuZCB5b3UgZ2V0IHRoaXMgc3BsYXQ6DQojIEJVRzogc2xl
ZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20gaW52YWxpZCBjb250ZXh0IGF0DQprZXJuZWwvbG9j
a2luZy9tdXRleC5jOjI3NQ0KIyAgIGR1bXBfc3RhY2tfbHZsKzB4NGYvMHg2MA0KIyAgIF9fbWln
aHRfcmVzY2hlZCsweGViLzB4MTQwDQojICAgbXV0ZXhfbG9jaysweDFhLzB4NDANCiMgICBkZXZf
c2V0X3Byb21pc2N1aXR5KzB4MjYvMHg5MA0KIyAgIF9fZGV2X3NldF9wcm9taXNjdWl0eSsweDg1
LzB4MTcwDQojICAgX19kZXZfc2V0X3J4X21vZGUrMHg2OS8weGEwDQojICAgZGV2X3VjX2FkZCsw
eDZkLzB4ODANCiMgICB2bGFuX2Rldl9vcGVuKzB4NWYvMHgxMjAgWzgwMjFxXQ0KIyAgX19kZXZf
b3BlbisweDEwYy8weDJhMA0KIyAgX19kZXZfY2hhbmdlX2ZsYWdzKzB4MWE0LzB4MjEwDQojICBu
ZXRpZl9jaGFuZ2VfZmxhZ3MrMHgyMi8weDYwDQojICBkb19zZXRsaW5rLmlzcmEuMCsweGRiMC8w
eDEwZjANCiMgIHJ0bmxfbmV3bGluaysweDc5Ny8weGIwMA0KIyAgcnRuZXRsaW5rX3Jjdl9tc2cr
MHgxY2IvMHgzZjANCiMgIG5ldGxpbmtfcmN2X3NrYisweDUzLzB4MTAwDQojICBuZXRsaW5rX3Vu
aWNhc3QrMHgyNzMvMHgzYjANCiMgIG5ldGxpbmtfc2VuZG1zZysweDFmMi8weDQzMA0KDQpUaGUg
cHJvYmxlbSBpcyB0YWtpbmcgdGhlIG5ldGRldiBpbnN0YW5jZSBsb2NrIHdoaWxlIGhvbGRpbmcg
dGhlIGRldi0NCj5hZGRyX2xpc3RfbG9jayBzcGlubG9jay4NCg0KQW55IHN1Z2dlc3Rpb25zIG9u
IGhvdyB0byByZWZhY3RvciB0aGluZ3MgdG8gYXZvaWQgdGhpcz8gTWF5YmUgc2NoZWR1bGUNCmEg
d3EgdGFzayBmcm9tIHZsYW5fZGV2X2NoYW5nZV9yeF9mbGFncyBpbnN0ZWFkIG9mIHN5bmNocm9u
b3VzbHkgdHJ5aW5nDQp0byBkbyB0aGUgY2hhbmdlPyBJJ20gbm90IHN1cmUgdGhhdCB3b3VsZCBl
bnRpcmVseSBzb2x2ZSB0aGUgaXNzdWUNCnRob3VnaC4NCg0KQ29zbWluLg0K

