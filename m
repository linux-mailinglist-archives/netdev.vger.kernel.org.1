Return-Path: <netdev+bounces-200597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBEAAE63C4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFCF3AD91E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE9B2882A9;
	Tue, 24 Jun 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dhJ9Ju1t"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A51280CC8
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765405; cv=fail; b=IP139iZpz5Fag6ph4zJIEnJ7lLxVYRjC0lSOJ7HNlIi+4mqkZLZ2fWsfPjY1MvQZf9V+8Hhk+n0fFbfFJcLpxETpIjAS4smbC3pk4uS3geATSZihMlZkIZSxa6f4pg5klYHhBx6femVVRQ41VYNWHsKclnNkGerx15s2mRYRvPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765405; c=relaxed/simple;
	bh=nz4qd8W4VEK29rUvdJGeaIeqIa+rG5mtt4G+zEwmQUs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ft0Y4idUwa+4K6YbZd+nXvkapyn+2K0HIMOG/6mZ39T/8oNn9xTrCGKDEijtWUGZ5YwY9h+KV6h0NZev1NBjZf172JQ2awEZRVkFvvvmZAHEybTqIn0La5A4pXcTO0oS6nU1rK1k5p8fCk3lOYgXG3VYb/Nh8QZoW7XSm6RGBZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dhJ9Ju1t; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EO9OVoTdOlrHL0PfNKYr8lVDiozglkCTI5nkHi6k5W5DDkNJsCsCeSco3QkAJzVqzxSCtFCkr/6CjEpFUHkMuSACyG1Ctz1WttD7tpYCfWjn3r7adgWCsDHH2dCLkzAPqKdUBMSEypUOEVDxFoMWpyJrzVmfHBkvQtkDVqH4PvQ9NnLv73GU16Wgmt/URS/BE3HjFLNRPgibGDz8Dl/EVfufgrfGJoyNIntLO3S7QblrbLkG8zJbu3kg04yr6zOLvfw4MGyWYhoH3uZXwKuwIUXBvoGuo8j3DJJ+4GTd+USe38Li28hppyAaG0Q6ayxy2ukNCCUR71YKjU/nIMBwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nIJfMSuyYbSyB1LYbabltiQDdcjxnsIvvUVN5OKtyo=;
 b=SIM7ouBzxKIXtEDGg0IGWEdbu63BvFfGXzRZqDg935Vn1frDe9MnfHgQhzMVo4QZ8N2G2Bsh0dJMoQqi+Ot/9g51uGzhijWoAS/4DERyLt2oFy4kVCyE7zYcDWTCGFP5NF2sqLvfNw/Uz+4eVBaeSsCies7d7mrO2kvx55BaGLMZrirU+wa4MRyNywB+ap20ANUqBTVJxXPS5awOeYXv3adUnFnVhE9e/gtRNc4dH3N75hd9y/Q50YhGpZyupjGICoiUup2mzw3jxLI0qyUD7g7MYcZG6lXn2c03ufsKh++UfTyCl3SollXN5z+U/vp8UwJ3kVbWAlaJZHuESb8YmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nIJfMSuyYbSyB1LYbabltiQDdcjxnsIvvUVN5OKtyo=;
 b=dhJ9Ju1te3CYEyAsi0cRu9GPPXITZVCGGiRvPLlGXAqt+udkiOx+74PdKi51UX5DvBWyWkwBl7zSS8VM9m5aYRtIjLoRvuIaJiN3OLd0g1/pxRo4kotsRh1nx0JM1chP2LSDdJiU0Nx5cFy+esCctyxRoa8okRuAPQuw48DiNZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by AM7PR02MB6401.eurprd02.prod.outlook.com (2603:10a6:20b:1b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 11:43:18 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%3]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 11:43:18 +0000
Message-ID: <fda1e6aa-3b92-423d-b98b-e4b8a39e5d15@axis.com>
Date: Tue, 24 Jun 2025 13:43:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: phy: bcm54811: Fix the PHY
 initialization
To: netdev <netdev@vger.kernel.org>
References: <20250623151048.2391730-1-kamilh@axis.com>
 <20250623151048.2391730-3-kamilh@axis.com>
 <aFl5GJqBDeoK4fTd@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
In-Reply-To: <aFl5GJqBDeoK4fTd@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::13) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|AM7PR02MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: e96591b3-2064-462a-0003-08ddb3145007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2J4SUhLVWwyVmIzbDhNb1plTXdvVVQ5WHF3U25OckNQc2RJR2ZtS0xVc1Fr?=
 =?utf-8?B?dDdzM3UranZ5bE10MlhNOUZ0WkhsMmpDazVkWldsR1dlYVFRblM2NENyOGtm?=
 =?utf-8?B?eWF5c0JIcGVZL01DOWdrUkNjTW55Si93UXorSlJOTWRpZjB2RG5LQW1oa2RZ?=
 =?utf-8?B?VmpWQTU3dU1VczBVNlphb1F3WGM5M2VRNEVRMmtBalVGNG9ZL1FkeUxVejBN?=
 =?utf-8?B?SEhMclVPNjU1OHhrbmNxMnZHbUphSTFzS0x5S1p1STE3R0txM3ZPZy9BYVZi?=
 =?utf-8?B?b1E2ZzZ3b09lWThseWp6YVZsWTl1d05CNzVzNVhMeDI4eDhuYnY1ZEJPMHRQ?=
 =?utf-8?B?Z3YyOUU1YVpwY2NoMGU4N0hLNmoxNlhTR25sWExIWlk4V0pHYzFyWVpKbkxX?=
 =?utf-8?B?U2ZNN2gva2ZuWmladGdZbEYrNVd1c0NWMmlSN2hmNW8xRG5CcnIwUkZjWlhq?=
 =?utf-8?B?NUwySkROdGVHdDYvSXUrbElSaXhOaGo1bUpZWlNjaTd6bG52SDNsQmpUd3dx?=
 =?utf-8?B?QTA0YXM1TkVWQlpIcGkvT2xVdllrbXNHdGlieENsZzFVK2F3Z1RsdnIyUmdt?=
 =?utf-8?B?S0RlNUFQQk1WNzdoemNrOThwZHFVcUVFMm82b04xUThtdHFUWGR5dCtzMGpZ?=
 =?utf-8?B?bytRSEFrcS9YVkVQYnhrWDd5bHdLRnU0YmRkV3JsaWVhbXkyMEN2WDJRd1Yx?=
 =?utf-8?B?cHg4SVUvbnh1aXFqamRtUjJYSUxTOWM3b1AxKzh0NlhXOUJFUjV0NlA5V1Na?=
 =?utf-8?B?QjVGOWVTQkh6SjV4eDNjMEI1eERZaWM2ZkpYMEtRSGlDYTNxbmtzYnVRaDF2?=
 =?utf-8?B?YnRrTDU0YWRHZkVuOG0vYzRJMURIY0tGWkdkU016SUFWb3RURFB0dWdDK0g0?=
 =?utf-8?B?V1pCUXczbjRYQktKbGU1clptWjV2SDBrWWMvVm9udTlqVGsydDBrdjVsRy82?=
 =?utf-8?B?djJlU0dnQUFKRGJMWS9VNlQ1bitaSXkxS2xGMmNBcTVUR1V4SDBmM1FYdnhE?=
 =?utf-8?B?aG9vTUkvR3l5OHJpeHpPdDc5ditmZXo1UXA0cXg3VlRRSWxBeE5JZWNlOVIv?=
 =?utf-8?B?aWUzQnJBbXo0L3ErQVhFaFRRNjdUY3FteTUwTE50Ym42dG5Wa2FDamJtRWVE?=
 =?utf-8?B?N1V1SWVRMEpPQWFqT0JWdjNHZGU1ZTJMak41TlhlSE1UK0tOWmZsOTgwZkc1?=
 =?utf-8?B?YmZSNjZkcWVFWDNsUHJ1cmQ1NFh6NCtZc3FpTEJpVlN4TExEMmFLQVhGanVr?=
 =?utf-8?B?bHQxeXc1eUh6MHIzOEdhRW5LTmsrd3N6amFyK1c4RjFQUTRONW9tY1B6aFQr?=
 =?utf-8?B?NDhBLzB1REtLK1VWbFhrNWlwaHJ6SzZhNVJMR3YyRFB4d0hnMmJGN2FGQzF3?=
 =?utf-8?B?bjExUTN5bThEKys0RXg0QUovQ2lId0dLUFBHc2FaMm9YMXJ1eDd2YmRuTGgv?=
 =?utf-8?B?ZGRJNCtWL3ZIbGFGN1JNeVpESnN6c0doNTdYdU9MWFUwZldqM1lzM1JJQ29i?=
 =?utf-8?B?cWtKNWNqSWgyZkhmbkFqeVAxYWFNaDVtZXZ6K0IzT0pCdWZmajM5ZFd3RTlo?=
 =?utf-8?B?TWZZNzNvUzZHUjFBRDBwNEQzTjBucDlzYzBPeEppSVlYZ1dBeWE0VUphdnRY?=
 =?utf-8?B?cnBNaDBJcnowUW1CZzhiM3NsQitUUU9RSy9NSHdzaHB5c2JISVdaOGVMZDlj?=
 =?utf-8?B?WlZES3lRSUVmV3F5Z3JBTzg3QXkzMDJ4NmU0R1h3dG8zNStLYloxU3hBdThZ?=
 =?utf-8?B?cVRUdGZYN2VUTWhnbm5wN3kvM29qMXdXNmNSRzlOclpFVXZNMHAydEQvK09a?=
 =?utf-8?B?YW9DU01wdWw0Rm5PcU9OR1JtV0VXMm9sUzN1cGlCdGdpMlNPcmhSUWp6Z3o0?=
 =?utf-8?B?akZHWjNZRVJjK2s2Zk1kUS9Xcy9yYmk1WHZGT2VSeGppTGR5VDZ5ZEtYVnli?=
 =?utf-8?Q?ZZN3/QKeuW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cURGemNJSngrOC9NTnZ4UFBiY1hoYk5kbkVmK0ZhUStzL3ArK08vbVZFVk5U?=
 =?utf-8?B?K1N1RGcwb0RXS3BpVUI4SVlkK0lVZVV1c0VOa2JqU2dUbDJKTENhWEJlRXBJ?=
 =?utf-8?B?T1Q1amE1MGhRRWZHdHZESXJkVFg4bjlzK1BaNEwxNmlHYXJYUlhNMmFzNG5B?=
 =?utf-8?B?TU1nVDhqSmpxdFZtajlIZEE3U1BtczNObWswalptUzdtTld2TzE3ZFZxTENp?=
 =?utf-8?B?VDNlNnE3ZkRtV1p3SENoMmM4dFhPNjZqa1RjYUx5OG51TFA0UXhnY09CRFlJ?=
 =?utf-8?B?VzBJRDJHSGZ6QytyMUVieTR0VGZpbG8zbzVXQWZGb2N1SjlsYWVJclkxQU9C?=
 =?utf-8?B?MnpjTjJPdnVyL0Y5WmhaYkFtNEdWVGJvT3lvNEpIdVZ6eVI3SGt1ZEFEUTU5?=
 =?utf-8?B?Z1NrM0RwYTluL1oyTDJkWlA5VEVsWDlkWHpoZDQ3d09XV0NJTWpiNDZBakRh?=
 =?utf-8?B?a2N3a1N1U3N3K2hQZ1hUMU5OZ1hLNUhDcEE3YVpEK0dGYTJJdGtZbWVRTkZ3?=
 =?utf-8?B?SEMyUnM2SURqQkRaUEFIakhjdGpZdkV3K05Gb1NsTDBJM2hRZjdIUHVna3A2?=
 =?utf-8?B?Y2M3L0xSbG9yaHd5SGhQUmVYY05Bd2ViUXptUmJ1TFhZT2tLZC9TeXNNeCtR?=
 =?utf-8?B?eEkwNUxEV21RUi9aNG9kbUVwT1FJRHJLeXhaRDFhUHc1SW4zZmdxNENWa3hP?=
 =?utf-8?B?cXVlaTFUTHdwOWdkV05VYWhIcU9PWGpsdjhtdDNkcEZKa2plTkIrZEczaDZS?=
 =?utf-8?B?WXlBamc4aGhjV2tGSUVXT0RMZWZLS0FJdzFHU1MwMmdYbFljZU1HL3N4Ykd0?=
 =?utf-8?B?aXlkTnN3bXQrMlVjaXducm4rVUExQUJwVDZpbXgrNk96OFhacndHSmFyam55?=
 =?utf-8?B?TW5qWkxZc0VWOUlyaGNxMW85dzJ6bUo2bERML0c0cjI4ZjdGYWZtQkRuSVc4?=
 =?utf-8?B?U2NkQmxFZzQrNFM1TGNocXovVElUQXJPWEoxOVExU0I3UnpNSmpZalF5a2xy?=
 =?utf-8?B?b0UzbzhLQ1pQK29kcExFbjRoMGFDWFllUE5oZ1N3WGsvZDI2RHd5VVNkb2Fk?=
 =?utf-8?B?UmhtdG5aSld2MlZTV0duQk0zckJ6N3lwemYxUDQ2WmFQQ0hiWkNZbExYSmE0?=
 =?utf-8?B?Kzc1aUwzRFVyeGs3dmk1NzlwTmR4WjlYWE8vWXlFZkZQVnZZUlpZcXBaaDlS?=
 =?utf-8?B?K0hHQ0hiamgvQUpkNytMbkhNWUwvdW1CanFsWFFsQWpid3UxV014ZXk5KzN3?=
 =?utf-8?B?ZkJ1dHBFSEFrME9jdVRIVC9GWHQwaThMRC91YVB0ZWhIeVFZMmwxbVdIRnBC?=
 =?utf-8?B?bHZuMk16cGNjYVJrSCs0cjU0U205WjRlT1NPdktIWEQ2cUhTeXh1cnA2bDNk?=
 =?utf-8?B?eUJkcW1oc1Q4SHhYWmtGOTB2VTB2cTNkUFB2R2lwT203clVpbmo1SmI5OVBH?=
 =?utf-8?B?THpwRWdvdTM5VGlqd2h3M0RCUjZOZXA3U0RwbGdQZHNhRTcra25UUG00bzNj?=
 =?utf-8?B?TU1vZ3pYZk9MM1l1dWJoMUJNMWFucTZ2dFFVSEk5VURRSDEzeXRoT0pEN3FI?=
 =?utf-8?B?cDlWRGxhZi82dStPVmtadXN0a3B1QzBOY3l4OVdRc2FDZ0hhYlRJdkVtQzZD?=
 =?utf-8?B?eWROVHIvcnE1dlRtUHREalBYMXlleG9DalMxS3FBSHlCeTN2bW0rNnpQTU5m?=
 =?utf-8?B?eDhjZndFeW5RNXNIcWJrblJsMUtQcVorNGNsMDZMRUhsQ0tjci8rdXk0Y1Ey?=
 =?utf-8?B?THF1dHJTUjBWa0ppSXBvY0wvaVA1Ukw5LzFZT1ZWK1hNenNyaXBNQmdDdEg0?=
 =?utf-8?B?TFJSY3BHN3BteXR5MndXL05ZT0JhSUxsNVFLRU85R1VHQzBVZlV0UXpCUW1i?=
 =?utf-8?B?TmlSWXRPUTdNd1BraVpLam9RaksxVGVkbFU4QnRKZEdKUERKbkp2ZE9qa3ow?=
 =?utf-8?B?ZGVKMk1CcW5sdUtWL0kwblEzVjlYb3NqU3lJWmZuM2I2UWFyZSsyVldmTGo1?=
 =?utf-8?B?c3UyTEdDM3oxWDZ3cHVRb3VBU3ZsNjhZQ3hmWHBwdVlRZXphWjl5dVBLRytS?=
 =?utf-8?B?UWFoVzNYTGNYU3krNkF0N0N4bVVBSkdJQmRuak9TejdUbDJrNUUweDJ0aklK?=
 =?utf-8?Q?CNKHby6scgkEZK1G25+rYPci4?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96591b3-2064-462a-0003-08ddb3145007
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 11:43:18.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRzYvVRkKzox/QX6gecVTtcCGl5XqJInxAShMLSIxU4HD4OOfvRNxJ5i7VTErHnh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6401



On 6/23/25 17:56, Russell King (Oracle) wrote:
 > On Mon, Jun 23, 2025 at 05:10:47PM +0200, Kamil Horák - 2N wrote:
 >>       /* With BCM54811, BroadR-Reach implies no autoneg */
 >> -    if (priv->brr_mode)
 >> +    if (priv->brr_mode) {
 >>           phydev->autoneg = 0;
 >
 > This, to me, looks extremely buggy. Setting phydev->autoneg to zero does
 > not prevent userspace enabling autoneg later. It also doesn't report to
 > userspace that autoneg is disabled. Not your problem, but a latent bug
 > in this driver.
So I'll try to do this cleanly. Hope it is possible somehow, because of 
the bcm54811 and bcm54810 properties: the bcm54810 is fully featured PHY 
version which includes auto-negotiation of its own (called LDS or Long 
Distance Signalling) by Broadcom. The bcm54811 is limited, mainly in 
absence of LDS - but the controlling bit is set upon reset, exactly as 
in the bcm54810. The bcm54811 datasheet states "Reserved, reset value 1, 
must be written to zero after every device reset" without describing the 
purpose of the bit. The bcm54810 datasheet describes the bit as "LDS 
Enable" = enable auto-negotiation in BroadR-Reach mode. In other words, 
the LDS control bit exists on the bcm54811 and must be zeroed in order 
to be able to use the PHY in forced speed / master / slave mode. Strange 
enough. Still we need to disable any auto-negotioation if there is 
bcm54811 in BroadR-Reach link mode. For bcm54811 in IEEE mode (using 
"normal" wiring for 1000/100/10MBit, standard IEEE PHY handling would be 
used, including the possibility of half/full duplex.


 >
 >> +        /* Disable Long Distance Signaling, the BRR mode autoneg */
 >> +        err = phy_modify(phydev, MII_BCM54XX_LRECR, LRECR_LDSEN, 0);
 >> +        if (err < 0)
 >> +            return err;
 >> +    }
 >>   -    return bcm5481x_set_brrmode(phydev, priv->brr_mode);
 >> +    if (!phy_interface_is_rgmii(phydev) ||
 >> +        phydev->interface == PHY_INTERFACE_MODE_MII) {
 >
 > Not sure this condition actually reflects what you're trying to
 > achieve, because if we're using PHY_INTERFACE_MODE_MII, then
 > !phy_interface_is_rgmii(phydev) will be true because phydev->interface
 > isn't one of the RGMII modes. So, I think this can be reduced to simply
 >
 >     if (!phy_interface_is_rgmii(phydev)) {
 >
 >> +        /* Misc Control: GMII/MII Mode (not RGMII) */
 >> +        err = bcm54xx_auxctl_write(phydev,
 >> +                       MII_BCM54XX_AUXCTL_SHDWSEL_MISC,
 >> +                       MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN |
 >> +                       MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD
 >> +        );
 >
 > I don't think this addition is described in the commit message.
 >
This will change with introducing of new interface mode for MII-Lite as 
recommended in other answers to this group of patches.


Kamil

