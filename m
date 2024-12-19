Return-Path: <netdev+bounces-153383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5B99F7CF5
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71051663E0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9352B2248AC;
	Thu, 19 Dec 2024 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rVVY3Owh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991269D2B
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617898; cv=fail; b=lI0lYZa32fU9E0RKt+X2VWLtUDJILQBcF93kkz70VEzg/QS9O0U6TDGHC2q9NdRI/kx84iKPopVRLBfyKWB6Vg6/m2y26pvxMZJ21WQUIRxNM08W1TrBhwbGhlZvPh5v0hE+ZxxgJqLpokgjfs+LHeLD2ZeU4rMIvaQsjD4WqRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617898; c=relaxed/simple;
	bh=gmrpUkp+/qdiJk2sz4+ic6nBpU/qIhtmpf7b17Knt6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mu+gco0DF2xWW+QTB+OPgj7KBdhryIrCI6ajqfzUevd+tA4K6x03fIDipKp/EZoS5dDTncgDJKRB8JTXT8EsfgQBYggWbPpa/BRdlyZTGloCYaGmJg0fjSNB0VpNRMkxcMAM5Ak3zC1qSmsvqSVT+UrY0ke4OFZqxSUe+cuiV4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rVVY3Owh; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jR2uL6JncyItihwsyszMdEC4TzQ8aXmHny7EdD9b7hp+cKubAiG9VrSw9m2ID3nRoBsbZsrcif0AdgVDfZp/KPT/tqIpdnHMEnQ3mJiBH0B6XWJxAt38ju7akgHd53qohnp/7MBQ4wdM0hyyxrOf579zyd95OUlvwMLu2lqjxTxv1iC3FA3CYX/OnXvju80vRl4XTbyvROJ2NHnPcdeS9ryBdT2e6D5Mby3zMt8MB2ixEFGyQxOmaXSF+3ANLQDSWEAicLK+yOYHvY7eGt3NrMsu9dJMBpGiQy0nHEkE7E5H9GT9ywLzvL7zDSQIb+hAaroBvmEyrCtDhDWPp2Co/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmrpUkp+/qdiJk2sz4+ic6nBpU/qIhtmpf7b17Knt6o=;
 b=KJsH1cQHChWYUnMyo2KqzxnMQAkQMt3ao+AFdzB87hnpyzZkIfd/NHxvcmUIq67eTRIhD1tCSHI5ONE4jCmDnl+B8q/W5yc7I1VyxaVfv6nLKAIUrLAVU/N+oqDCQEU/Tn79xdL+fU2J4ARylvQ04zjWrwdWR7wPbXKR0i2F0g/oJP1Y1MMBrheHBUs6lMNN9+rz5KLAGXjLRNOci7cDMFAgzzXmFLUi6FUL3G75hqp3/DsvbhWjQSc5b4JqPXjm+8vkYuXJ5/amKbbxBKcwpSHtnsMx/aPkCqP2FVyHJ/rnYG2On7dBCAtYK+1WaRTGNLDS54zOVWOZy7xl0V/waw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmrpUkp+/qdiJk2sz4+ic6nBpU/qIhtmpf7b17Knt6o=;
 b=rVVY3OwhYnHLiRJd2Enuu/F8y2w1eBZmRp0Ls3U3e0Not2lEU3EF2ljHFLd8Fa8eASOR7192NhzUbZSKTz9t7JkwjqNyEphe0eppovhYGzCgmiBFhU2Q+ezEhRWKFDf3QTzhxCdpwQkgoGcT9rMcZB58TvT6didlA+ExOiqdF+Tul/uDZYX0JHTQyGCjls/GVvPi4mZB0q9+LrlGo10Lx31KEE2goKk8is7aGl5WcyA/bjRHFh+IuV4yXW9+q4Q3hx/LSqNdIMbVv4x+AUn7MpdbcRdinIQpGnL3XnunWRm0R3LOfLytWqFgV8icEToqrmg3mbguLq36avHrQzkSiA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Thu, 19 Dec 2024 14:18:11 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%2]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 14:18:11 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>
Subject: RE: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Topic: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Index:
 AQHbHz7DQv+I+3IfGkOF2TEcLZxABLKPd+pQgAHPmYCACQ73QIAuaH6AgAJJKNCAAGFwgIABVcQggBTmQACAANtR8IAJxpXA
Date: Thu, 19 Dec 2024 14:18:11 +0000
Message-ID:
 <DM6PR12MB4516E1A2E2C99E36ECA9D87AD8062@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
 <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
 <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
 <cd258b2f-d43f-4ae6-bd7c-ca22777d35e3@gmail.com>
 <MN2PR12MB45179CC5F6CC57611E5024E2D8282@MN2PR12MB4517.namprd12.prod.outlook.com>
 <f3272bbe-3b3d-496e-95c6-9a35d469b6e7@gmail.com>
 <DM6PR12MB45169CD5A409D9B133EF3658D8292@DM6PR12MB4516.namprd12.prod.outlook.com>
 <02060f90-1520-4c17-9efe-8b701269f301@gmail.com>
 <DM6PR12MB4516F7998D67014D9835C5F5D83F2@DM6PR12MB4516.namprd12.prod.outlook.com>
In-Reply-To:
 <DM6PR12MB4516F7998D67014D9835C5F5D83F2@DM6PR12MB4516.namprd12.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|DS7PR12MB8252:EE_
x-ms-office365-filtering-correlation-id: 72b123cb-7b18-4286-bb6b-08dd2037f817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGI2am9rTWZBSk4wZkpVMWlDTmFiN2M4bjBFSnFVRTZDQWFFakp5NXRzL1A5?=
 =?utf-8?B?dnhZV29jVFFVc2dnMlFpQXYwWUdsRXl1NndEeEdLRGttNGhzUWFqZUJ3TFF1?=
 =?utf-8?B?TU5UNS84OHowMFhvM2VaOGZ3TDIwWWprSktheFNFaCtTNzlXUUNCV2JyRGNB?=
 =?utf-8?B?bHRNTUt1b25ZU1FhU2I2dkFFbnhpTTVOK082QXhWNmZ4bE1uZk1ZN2ROOVhs?=
 =?utf-8?B?a2JlY0ZnKzVrTWUrakJncm8rV3ppd0gwRDVTTFBDMXduVnBObkpQQUxtUk5V?=
 =?utf-8?B?SFo5dGhSYUN4ZDFiejhJeSs0SnRDdjRPaWhTZzZxelB1eWZoQkxCdWo2Q1Y1?=
 =?utf-8?B?M1hNT2xIZ08vYm9QT2k0SE1jcUJ2OUhYcHRyNHdkanJjSUdDajhxRHplMUtk?=
 =?utf-8?B?Wnl2UzF2ZFk1a3BUekFhY25iS1pIdW1NSmMzdDh1MFhTekhPRG1ET01OSkRM?=
 =?utf-8?B?blB6MlNvRVpXZ0MwTndiMEl6b2hFSCtrZU1kd2I1d25xNXg4cFQxamk4Q3U1?=
 =?utf-8?B?NFpyY2tmb1RDbnZ6R0FZTWs0UmdVMDg3b0taWnNWZWJWRzhrUmVwblIwU2ZB?=
 =?utf-8?B?aWJsdVRITmtvMkErMzZSdURLU3JBWmZINHRDb2dPVHJoNE4xYUhvcTBkNzhX?=
 =?utf-8?B?SUw2VTdTNjJFREFYaEwrR1FpTUY4cElncEN4cXpBRFpYcmcrRjdpcS9HRm81?=
 =?utf-8?B?cFZzNFlxb3FvcVhxbktmaS8ydFBlemw5VjA5TGV3UTBPVTVTVkVNRmNtYmJH?=
 =?utf-8?B?UFZYR1F0ZzN6b25WeWRIYkhWSmFvUkdBdWMzdWFRSXcvN2VNclE4NHd4Q1Ju?=
 =?utf-8?B?SmJSMkk0NHlVMGN2U0dQL05PS3Z4VXlhSnI3MlJnSTdWK2phYXp5M0pYeW1Y?=
 =?utf-8?B?VjdXT1lBVE9QN01uc0NKejVUL0FPYjRKN0pKekxYdFBqOVpRc2ZPalRhbzRo?=
 =?utf-8?B?eW5DODNkaFhxaGtaMzJRc2lOSWEvb2ZxWEh6UWVNS3hnbUlTbmlRTHNHWDB2?=
 =?utf-8?B?OHJLK3V4RWhIdHhTRnAzUEl1bGRXOU52OTBYSHBWZ2h2NlBEdmo1cGNHYXdS?=
 =?utf-8?B?TGtUK2toZGVpNTJWT2tGWlBIanJRNGtoSkZjUjl6OUhaVCsrN3ZVTy84ME1l?=
 =?utf-8?B?bXJnejRlenJlRWlOdjArbmhPcVBEUHlXTlZqTnVxUkRJaDR4dk40MFJVZ1B5?=
 =?utf-8?B?Rkw2NGNLWkJHMFVNV0hwYnUxbCtERi82M2RYaXBQSVorUWQ2Q2JacEdGbFF2?=
 =?utf-8?B?SU5YbCtHclZFV2dCekpLMTBNUXRmeGZGZnhUL1hMUFp2NTNIYmo2dUM2ZEdo?=
 =?utf-8?B?MFlJT0lrQ2pUZnRUQm5QY1pVekwzeUkxOXdMM2Q3bmxaeG83RUdMMW9QVWtL?=
 =?utf-8?B?aTZUN01SZVlmV0dRRVA3NktVZi9XUWYyM0oyV21odm1Hc01KdUVuZWhrTHAr?=
 =?utf-8?B?YWh0WUFLa2d6dENCOW4zeVc3VkRIQnJtaG50T202M3dqOXZKSStKWlg2cXoy?=
 =?utf-8?B?bGpxb0dvTDNaQW1nUTljS095TksyVzMwL0wxWENwbER3dVpWMy9NZzJ5MURh?=
 =?utf-8?B?MTZyQWxUcGJLdW9paFNyRUJHbXZBRDFjcVdjcDR2bmdyUlVSU1QwRG54cE1u?=
 =?utf-8?B?bGxFSWNoWGdqZVIzcEFDNkVGbUx0akZYQ244NGZyRTQwajlpdC9NYUhnSkVj?=
 =?utf-8?B?VUdnU1hPSkYxYjNicmNQUUc1UE1Gc0ErQjNMNVMzMmRsaUQ1blRwK2ROUWRL?=
 =?utf-8?B?eGY5SkpjSGpYTUFUd05SUkdOaW1GbTZoR1RxdVRKTU94SEY3K3poQzlpZEYx?=
 =?utf-8?B?ZTdFcW9KQ2RDV0hrNXRmVmlCdHIxUmpZbnl1Q1B0aGRiZEdRWC9OZzZ2NkR6?=
 =?utf-8?B?VHhJT1VHUlNpd2Q1bzBld3ZkMjd4dGcyaXVTeWtOWDI2eko3OVl4UmVoMEc2?=
 =?utf-8?Q?u1Mn03wPE8zqP0vrmFkagXiYfzQ1JtOC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0o2Z0k0NlEzVVRiakx5RGw1Nk8zZ3dQQ3MvcmR0N2Nrb0hmazRxVk15Wk9v?=
 =?utf-8?B?b08zREpFdzJoU0RmWWZCbS90Z1pqVEcralZBUUJ0VVZvM3pUb3pheDRlbkF4?=
 =?utf-8?B?QTcrT0tVd21nc3oxVmJDSE5YOVJDaldZZ2cxdEVpV3hiM0J4eEVlTi9Lejkz?=
 =?utf-8?B?MzBTY3lqTnFJMnlqZTNvcTA4bXBxcHJXajdTK2Y4bWVrV3ZncU9BTjgvUUNr?=
 =?utf-8?B?VmphK2xzZi9WK1NTZjBOTVFpcEdFeEZXaDFUYzJkbFBGbzE0Mk9vZ25VaFkx?=
 =?utf-8?B?QW1QYkpDNkdQWGxWRDNrUWcxYW11TXNRTnovSlBweXltRFJ3aFRwY0d3SFVk?=
 =?utf-8?B?dU10bzFVamtCVDg2M0lCRjBtRk9LK3phMytJSDd3dlZwN1ZsaXBwMThmWTdW?=
 =?utf-8?B?V0RuczYwbFFQbDNCc28wclQ4bkd4Vk9WNTl3WmMwZUtEWEJLaFkwbk9QN2o2?=
 =?utf-8?B?Ri8yQVNQdFc5T25BRHBycll3WFpraDEwREk5MzkxcVJvRlg5c2cwRlNuVkNk?=
 =?utf-8?B?MVRRUGY1TjR1a3dwOGUwRjBldUNlVXJJQm96Mmt6YTJ4T2ZvdlMzbG5udW84?=
 =?utf-8?B?STNrbExQUXQ5dDBZQTBUVU1nOUtrTjZ5RkFobll5RzMyWXYvR2gxUmFPajlE?=
 =?utf-8?B?OTZmT0hhMVUvNFZZVW1EWC9HQ3o4SUhZelhURHNPSW5LaVd5MERWZHdCdmpX?=
 =?utf-8?B?azMybGtJWEhjSkw5d0FUZXMxR3lPK3lZL0tVWFFYbUdETC9aYUw1YU14OTFl?=
 =?utf-8?B?eThGUk9XU1FTQjFPTkdZRW9lSXVrYVg1Q0ZXdTRHYm5Bc3JEbm5YazkzanRs?=
 =?utf-8?B?V3NXbHVWV1dJdlNTSk5LczFpMHlJZE5tcVZxMERidU0vUHJaVkNFby9aMDNo?=
 =?utf-8?B?UkxEcEhXWS81K1ZpRW9EOG1lWlhubG1uWHdGU3E0TExnNVY0SnJzdlRGVS9o?=
 =?utf-8?B?RlVON2VCRjk3UGJjRFpEYXJwMUNBTyt4MWpJTUkzbjYxUURMMnVER1lRYXF2?=
 =?utf-8?B?cnVrTVpsMlltK1dvMmpHeWlvUzFPcjJrNFNEbzhvYlNTQzlGUjRCS04vbGh6?=
 =?utf-8?B?anBsQ1Z1L3YxTUtOTjAwNzhKNXovOVVDeC9IYmZ6Z0pGdndiNDJxbFBKVTlR?=
 =?utf-8?B?d0pTYWg0aHQzL0JoOHduRWxJUHA0TGFZeXNPVktpL2RhYkRLMkhLWmU1WENZ?=
 =?utf-8?B?alhLank4MzAxSkpRbkF6Z3BlYXVvbDZ6b2g5bGg0cXI0NDRYYUhaY1gxZWRO?=
 =?utf-8?B?VWpnaExTbGlFTmJtY3A1b1hVZFNnWVAwcjlQYnc0dExWd2hJN1Mrb1pJaEsv?=
 =?utf-8?B?V2lCMGM2aEYvM3ZDSnY5NEVGbzBCU2FBYVpmRFY1aGx5am4xNklidkw2N00y?=
 =?utf-8?B?akdXN2F3WjVjR0NzUEtoRENpS0VDMkk1VWcyVUlZSFF6akpobWowMDMzV1Vu?=
 =?utf-8?B?V3JNSS9EbklCVytJMjNDN0svQW81RjJnQXBKbGFUdXhCcmd3QmF4S1diSEI5?=
 =?utf-8?B?QnpQaG15elFsTkpleGZiQzBSWTlpcFNJYWl0eGRPcVJhSWdTZk00RVZVUC9r?=
 =?utf-8?B?L2tpUUVmcnV4RTRaVkJWbTZjL0EyVFcwVlErRmZRcW1WMUQwM0RNWG9DZ1lr?=
 =?utf-8?B?MEdibWlCTE16dnJlUUZyOFlFKzZEc0tCbHNyYVVxYjdRL1pUK0dQYXhXSWgy?=
 =?utf-8?B?ck9pZitoRTdwTy9nTDhRbmdEcTA1cUFnM1NCZCtYNURqSWdFNHNrWnJGM3Bt?=
 =?utf-8?B?SFBCamJadFFwbFRvSzJZeElsSE1zdVM1ZDJPdVh6ckdiOCswWjI3NytXbWpz?=
 =?utf-8?B?amNQdFh2UGprenMya2ZnVEVtMXBPTnNkRGJCNlNhSE5Qa1QxOGtCdE5GenFT?=
 =?utf-8?B?NWNzR0V0a1M3ak5Yc1RIdmpDZ01NTFd0VlREeGxsOTZNNDllMVhFL0psbkFw?=
 =?utf-8?B?OHgzMWg1UGZNN0pKdWZ3U1ZVeS9TaDUvNkxReERObXZLT3B4MkxQTVJYcHJr?=
 =?utf-8?B?RnVUUlpsdlZEdjd2eEE4T1VERmxmMUNTL2IzaUJVdFpsdlFyNytUL3haU0Rr?=
 =?utf-8?B?SU53RlRWMjFOSU9MWGx3MzU4NmJYVU0xZUorMHZ5S3d4RDFXWERzZE13QjJ4?=
 =?utf-8?Q?Knweqa99MqCgOB2GadP5dq23W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b123cb-7b18-4286-bb6b-08dd2037f817
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 14:18:11.3938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mms4af5nrQ2alr4WCpj+xNgixMkJgSBhng8RhV+S67l8ZyU+wlFjqzP6WOtSzYi3lDjwNM6rbqmcCUr4o3Km9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252

SGkgRGFuaWVsLA0KDQpJIGRpZG7igJl0IGdldCBhIHJlcGx5IGZyb20geW91Lg0KQW55d2F5LCBo
ZXJlJ3MgYSBsaWtlIHRvIG15IGdpdCByZXBvc2l0b3J5OiBodHRwczovL2dpdGh1Yi5jb20vZGFu
aWVsbGVydHMvZXRodG9vbC90cmVlL2VlcHJvbV9qc29uX3JmYy4NClRoZSBsYXN0IDQgY29tbWl0
cyBhcmUgdGhlIHJlbGV2YW50IG9uZXMuDQoNCkFsbCB0aGUgQ01JUyBtb2R1bGVzIGR1bXAgZmll
bGRzIGFyZSBpbXBsZW1lbnRlZCB3ZXJlIHNlbnQgdG8gaW50ZXJuYWwgcmV2aWV3Lg0KDQpUaGFu
a3MsDQpEYW5pZWxsZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERh
bmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCAx
MiBEZWNlbWJlciAyMDI0IDg6MzgNCj4gVG86IERhbmllbCBaYWhrYSA8ZGFuaWVsLnphaGthQGdt
YWlsLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+OyBJZG8gU2NoaW1tZWwNCj4gPGlkb3NjaEBudmlkaWEuY29tPjsgbWt1
YmVjZWtAc3VzZS5jeg0KPiBTdWJqZWN0OiBSRTogW1JGQyBldGh0b29sXSBldGh0b29sOiBtb2Nr
IEpTT04gb3V0cHV0IGZvciAtLW1vZHVsZS1pbmZvDQo+IA0KPiBIaSBEYW5pZWwsDQo+IA0KPiBV
bmZvcnR1bmF0ZWx5LCBJIGhhZCBzb21lIGFzc2lnbm1lbnRzIHRoYXQgcHJldmVudGVkIG1lIGZy
b20gcHJvZ3Jlc3NpbmcuDQo+IENhbiBpdCB3YWl0IGFub3RoZXIgMiB3ZWVrcyBhbmQgaWxsIHRy
eSB0byBwdXNoIGl0IGFzIG11Y2ggYXMgcG9zc2libGU/IEkgYW0gbm90DQo+IHN1cmUgaG93IHRv
IGxldCB5b3UgaW4gdGhlIGNvZGUgcmlnaHQgbm93Lg0KPiANCj4gV2lsbCBpdCBoZWxwIHRoYXQg
aWxsIHNlbmQgeW91IHNvbWUgb2YgdGhlIGltcGxlbWVudGVkIGNvZGUgcGVyc29uYWxseT8NCj4g
DQo+IFRoYW5rcywgYW5kIHNvcnJ5IGZvciB0aGUgZGVsYXkuDQo+IERhbmllbGxlDQo+IA0KPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogRGFuaWVsIFphaGthIDxkYW5p
ZWwuemFoa2FAZ21haWwuY29tPg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgMTEgRGVjZW1iZXIgMjAy
NCAxOToyOA0KPiA+IFRvOiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEuY29tPg0K
PiA+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJu
ZWwub3JnPjsgSWRvDQo+ID4gU2NoaW1tZWwgPGlkb3NjaEBudmlkaWEuY29tPjsgbWt1YmVjZWtA
c3VzZS5jeg0KPiA+IFN1YmplY3Q6IFJlOiBbUkZDIGV0aHRvb2xdIGV0aHRvb2w6IG1vY2sgSlNP
TiBvdXRwdXQgZm9yIC0tbW9kdWxlLWluZm8NCj4gPg0KPiA+DQo+ID4gT24gMTEvMjgvMjQgNToy
MCBBTSwgRGFuaWVsbGUgUmF0c29uIHdyb3RlOg0KPiA+ID4+PiBJIGJlbGlldmUgSSB3aWxsIHNl
bmQgYSB2ZXJzaW9uIGFib3V0IHR3byB3ZWVrcyBmcm9tIG5vdy4NCj4gPg0KPiA+DQo+ID4gSXMg
dGhpcyB0aW1lIGZyYW1lIHN0aWxsIGxvb2tpbmcgZ29vZD8gSWYgeW91IHB1c2ggeW91ciB3b3Jr
IGluDQo+ID4gcHJvZ3Jlc3MgcGF0Y2hlcyB0byBhIHB1YmxpYyBnaXQgcmVwb3NpdG9yeSwgSSBj
YW4gdGVzdCBvbiBteQ0KPiA+IG1hY2hpbmVzLCBvciB3cml0ZSBzb21lIGNvZGUgdG8gaGVscCBm
aW5pc2ggdGhlIGltcGxlbWVudGF0aW9uLiBJIGhhdmUNCj4gPiBhIG5lZWQgZm9yIHRoaXMgZmVh
dHVyZSwgc28gSSB3b3VsZCBsaWtlIHRvIGhlbHAgZ2V0IHBhdGNoZXMgb3V0IGZvciByZXZpZXcu
DQoNCg==

