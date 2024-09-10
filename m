Return-Path: <netdev+bounces-126887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E53972C8D
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E6C1C23FC7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A122181D00;
	Tue, 10 Sep 2024 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ig/xzimm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178F16F27E;
	Tue, 10 Sep 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958421; cv=fail; b=fXSdn/2Hz6rMuLtN2ijPu/MB61VGcUiyiHtFcGqc4dsz+Z8G/I4mnyJqyd9iDWwD18hl+STB85XftUoJajc/oSze8UX+LqanlNk3YGBhbaFzNMrQ817eqgRiH+B5eL3KlEUaBUKy0txYi7RWt49frtm55QR/X1YTq2IDYWNeHxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958421; c=relaxed/simple;
	bh=d0oHYTnDfnzReqCXPIVJOmQKAAYYpkWie4kO54oIGU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQmr3DJ58qMcoRMnwj8KI0hXFAMC/DDNflb50pNA7IcT40BKEEpNaJkjiJMphyqXuHFDGmdKKjRfngxgDn+1z7UGdKqPV4on5ptgtQ9b39fWqaGuAdPkSNhu8tNebLNs/wIUUlgl51tjKx3ivHLJogzBJaZiUk7tPTqy3bdxCV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ig/xzimm; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mqa6jWyPYPpPas8BHjGwmMxfULWG+zdmOEVYHVPcIDuj/uKx3/9GAT2ZlMd1yfZXX5EL7YRN3iPP/j22ipq4z33I1xIeOVmWFS3voex/PnOGHd9Nhfiw7At6kEqPeh3invpgGSgf1N6GCuOtJhhL/X6PQmAq9UrSL7Gtru4/5jT1BIszIMUpd3nR/Dpa4gOgWEGds5nvDZOZlVxGhXzaN+pUZp0nIaxkdSrNFCRUgFaBcwvVlmJdjMYSH2msPOWM/8UKTaGLaM+jr34uECb2gFIp33eI3Bl/mU/qTvuYfXsUT4A2S8GbTpFRHLruqjaK62yr2aF7khc18TJ+tVyITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0oHYTnDfnzReqCXPIVJOmQKAAYYpkWie4kO54oIGU8=;
 b=UzLasv4i/jY/dWPDBY4/XwLufIBzirYtwWABRWLEdstGqLpgXr4k80eB1PFKTw7XhlK5biuGruis0aTMAOio2G/NTDtY47kB2QswOjZWSPtkwOcoPfUEo+O1gsjptJ22IM4mu8UfJGHzEaJIyYEMHhiNVRznymxe8uTAD8VytCl1ykRwN8fzEwbbL5mflovHYHWJK0HiOIeQRgw9rtL1j34CEMlPeCzxX3DRM/9RI6huXG1gd3qqSwFXi59Mu4GVYodm5uKVgIV6c1ANjWG3fIreNDEuMlUNoduO1+qPKs/Vy8hW8gWVrAwRgHhnuSlhBk/imDuKYBDdOYm4IchTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0oHYTnDfnzReqCXPIVJOmQKAAYYpkWie4kO54oIGU8=;
 b=ig/xzimmBJE5SbYYAqwTosjrVpBWcKKbr51B6RYSHQ55+7c7//UrzGa1VC+3Cog+yvvL8e9poAAQyNdTAqQVYL1Ix6/9FSRwdvKQERaxtOji3ygvJIWRTmjwEN6VAEyALvoZzRTd83LtDEoE1iFQdMuDXvrnITKtf69G9wamyMPHAi1xbW+qEvjDYA+hkUdUjIj67bqYobeLFi1p+CRjYwqlehQnqiOVWQBPByJ7Y4UuS+LZjtM8ee555UazXHC8zVwbV1oB6mnoOA8BXAzzbOKXNjCEQguB2HevoY6D2PCRj8Ym9v47jldEbM6FuDl6pt9mgSU6T8/QKBbyu1ya1g==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 08:53:36 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 08:53:35 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"yuehaibing@huawei.com" <yuehaibing@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH net-next 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Thread-Topic: [PATCH net-next 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Thread-Index: AQHbACGwwamJhKQcg0+MA3lZ5lTSirJMXy8AgAReSqA=
Date: Tue, 10 Sep 2024 08:53:35 +0000
Message-ID:
 <DM6PR12MB451663AD549DA6D3407B92C4D89A2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240906055700.2645281-1-danieller@nvidia.com>
 <20240906055700.2645281-3-danieller@nvidia.com>
 <20240907141042.GR2097826@kernel.org>
In-Reply-To: <20240907141042.GR2097826@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|PH7PR12MB8124:EE_
x-ms-office365-filtering-correlation-id: 336a50d2-b618-4b63-5c91-08dcd1760e6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1RjWVhPcThPMGhBZDJhMDdvZnFLTStxb3BhWUVjRUNhenZwVlVSZjF6RE9F?=
 =?utf-8?B?Wk9vTkc1WkRZdmVVTFpNaitlM3lBaFFQcUkvWE9QVnRvK3FGNWx4VW50V0Ry?=
 =?utf-8?B?QVVOR0dkMmlldFpidlpUM0tlQVc3ajNFMjJIN1lSM2swSEM3Q044T2Z1cHRF?=
 =?utf-8?B?WnZmNUd6WStBLzhrRXhlT0k1QmdaeFdaVzRqTUdmU29pV3lTZGc1VTRjakEx?=
 =?utf-8?B?NXlCYkQwa25mSE8vZVZHL1BmQmRUK09vcFhyUVlUN2RsRzNISUdHeWpLYVlH?=
 =?utf-8?B?V25PakRzakFGQzlETGpoZGxodjhZd0k4SW5mVkoyd1F3VjRKYk1EbTNJSzcz?=
 =?utf-8?B?cENwM0l0SDYxZUZOQjh6UktreXQ4d0lCSS9TRTRuWjhwWXZnbDZwQlhEeURZ?=
 =?utf-8?B?eVdlWVZpc2poVnlYVEhjb295N3gvbWk0YlVaeXRSQVEySFZHQytVN3NiVXM2?=
 =?utf-8?B?RWZuVEVMZWZENWp3VVZwTHpmWkptTWxQMDB2VjVNNEN2N0V1R0lxOXN1Y3JF?=
 =?utf-8?B?MWZVM1RTTGlQZjdmbjBrUmdiT0k2MVFSUTBJUCtVWTNnM25lekR0V01lRHJl?=
 =?utf-8?B?L2oxbzMwUEdWVzZOMUxhcmFHQlByeEc4dW1ZdFQ5V1hoQS95aTRHVU9Pa1cz?=
 =?utf-8?B?WWoxWGMvallmZTA3UlltOUlOTUZ3bmExTU1zb25jR294RWdRMTNpQnZTOXkw?=
 =?utf-8?B?UFVvb1ZacmFxT01WTEd1bkZkSWNpT09RUElDZ0NhY3BYQURVY1RBWHdrTzdC?=
 =?utf-8?B?elcycmFla3N1MHZlb3F4NUVnS1owZC9GOVQ4UnRNaE9WS2J0UU00WnFuSDFN?=
 =?utf-8?B?WTlqREMwNjRkeXlhTWRWd0laR3ZDeDFGbzRJcU42ZFJ1YTlwemMvMEhMd0hH?=
 =?utf-8?B?QUpiMVRsaTN0RGlod1ZPMjhnU3IzQ3dYSVJCZGVoYlZ3SmhWL2c1NEZjbXBK?=
 =?utf-8?B?Y3Y3MDhRZVlyakl5TlNmNWl1N0c5eEVWTDM4eng0NStLSUhCeEhQRUhKTm85?=
 =?utf-8?B?RHJvQ2EyOWhJK1IrQy9rdHdROS9vVTY1L2JQL285RmIxbERaSGZjbkhZK2cy?=
 =?utf-8?B?d1NOOCs2QlhxSDFYMXBhbVp5WHhwV2JSR3hHYmIrY29URDlKSzl1OVJKZkFZ?=
 =?utf-8?B?S2s3WGZyZVJrMVlhOUdqM2tubjJyTUdnbXpuREZkWEtnVFlpODlkWU1OYktl?=
 =?utf-8?B?dklXVWlyUlBycVJ0RURwMGduNkRpREM3azdhZ2ZPSTR4SDRtdXI4cnlhUkdv?=
 =?utf-8?B?VGo0OGNqTXJsVzJJZzBPYUlDNVNCVVQ3aHdkeVRabXRkb0x5RGdENExwYWFX?=
 =?utf-8?B?NTRGMlBGd25DMVcwUDJMSnFRK2UxQStTdGxBaWRuUnpJOFFGcVEya1NMWnMv?=
 =?utf-8?B?ZUtZb3JrdjNWYTN3WDk3dWoxUXFBTW9mUkRuSWZBakFnSmZuTk1DRjU3K1dK?=
 =?utf-8?B?b0srUTdzZVcraUdXTjEzNGFuR2I3aVg5dm5sYTlBYjN3aU9RQVg1Sk4zbUp5?=
 =?utf-8?B?SmFzVzhOdkhwa0ZiaG5hV0JTbDBZRjU1eUZYVUZiNmtXMmxVbkl2RE1VUXFp?=
 =?utf-8?B?MVl0U1ZVV2Y0NXZHMzQvVXdnUE4wbk9veFI5M2ViZlg4NWRQaEFFZWszR2V4?=
 =?utf-8?B?eDk4U1ZjTzBMS1VuRzJrSTZuNzhWMHpFKzF4TlF4S0ZadlFKcmpSOVN4L2tM?=
 =?utf-8?B?V3NVMHhQbjFzUmlRRmxrUncrMngzWElheXJLV1RwZGs2SVI5cU1RZ1NxT3FY?=
 =?utf-8?B?dFFMV01YN3kzV2VjVlVmUWI4ZzF2Vy90SFkxVnZGZ2pSR0l5cmtYTDFZa0pM?=
 =?utf-8?B?d2xoNHoxMHJwMnhTZExtQkN1d2ZSOFBKeXRWcjBRb1c2MmMvNjV4TUwwU1Fi?=
 =?utf-8?B?QU1BMG1LNnlQenIyWE9DK3ZNMEZrZTdXeVZvbkVnS0UvM3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0l4WGJiam9CNFpGUTFiNjhuQVlnOHRURXJjKzI2anlkTWFjenpWekxkM2px?=
 =?utf-8?B?cG1SWkVYZzhvNFcremVhb2huK3RzcGRXemhBN25OTG9vSTVHZ01IMlVEOURC?=
 =?utf-8?B?ZkhXVllkSXpjK2NiS2NGMnUvNTUxenY4S0dzOXhRV2cwV2tvN3phb3VIZzRn?=
 =?utf-8?B?ZzQ1TkhmT2U1a1JXT1MrUTF6Vkk0SkhRdUNUTVJuSkF5cXhqQVVqYkFSTklD?=
 =?utf-8?B?OWxVcnpGVEpVUTVYbTczZ2dpOHJuMWwyZ1lraGlDamh0TGVQdXFBdGdyT1hw?=
 =?utf-8?B?dW0yd2ZYV0N4eVFWZGxJdmZpd1Avek5hanlGblYraEZYaXhBODlSaDBsUWx3?=
 =?utf-8?B?TzlhQlBXcXhCMzBHWjM2MHk3WmR2TCtXcnZKaWRvRmthUHppSkFXNHdDZ2tD?=
 =?utf-8?B?ZVFKblVUVXN4VERXYTVRc0VFMzYrUjdEam5LSGNjYzZURTQ3em4vTmpzTlJa?=
 =?utf-8?B?V096U2orMFZWWVV1WVhDcGJpUllheVNkcUo0cURUazU3TXcwSmh5bFlJbVUy?=
 =?utf-8?B?SnNjNXNSdXRqU1JqTmJXd0xKZldNdFlHQ1BiRnhSbldBVGhDNjZOSDAwemlD?=
 =?utf-8?B?ZDlTc081SkMwS0FDL3dKWUIvRmltOU1HcG1NUWl4TDBxOWszTGJESDZsYzcx?=
 =?utf-8?B?UUY4ekp0akYvdEFoU2FRbHltclFEUElqSUxSNFhXTlNGOVVKN29PbVZPNXhV?=
 =?utf-8?B?T3R6Tm5YT1kreHo1eW1FUm9lTXZja3RROXY0OHlZR0lkakdXeUJoWGNYKyty?=
 =?utf-8?B?YUZRaWN0VFQvMHg1eGFIbUFUMjdCd0l6WkIxR1VYODBSYmQvL3VnWE9vOFJQ?=
 =?utf-8?B?czdBU09VUjFRdis4ajBZdUhPdHZWZG9hdEtERFRjbm5MSGV4Q3pFT29IZHl5?=
 =?utf-8?B?Y1FZMjJ0R1o1TWgyZHdJUjdYZ1Qra0Z4UnRhWU1ncmd4WFhJY2FWNW4xeTJv?=
 =?utf-8?B?dFRtenI5eWtkdm1Rd3NhZHg0ME1DMENCeUg2WlY4a3JRY2Q1NTRxSW0vTklu?=
 =?utf-8?B?MGVrdG1tU0JRak1KTUNMY0llZk41YXR2WUFONnd2bEhFVHV0Qld4RG9nRUVn?=
 =?utf-8?B?dG9YblZDenZ4SjdXSFVhY3FXMUY0NHU1eGJ6aGFzbXk2OGVvWWxHdi9nUkp1?=
 =?utf-8?B?TXYwd0ZvMjJkWHA3VGljdk1kOWpWdWFQY1VleUZsWE42dUpFZzVSTFQ3SDNm?=
 =?utf-8?B?SHk4NHo2cC9UWm1BeEJwUklDeEdlUUdLaDlpbVdPWmlVUjBMQkFJQTZ0czVj?=
 =?utf-8?B?Qkdpd2hhdk1oeEZDMVFtRjNOektnenQwczk3YlAyMDlGZEJ6NGx1U0o1NGRa?=
 =?utf-8?B?dEhxNzc0R3pVNEJRaGpWbFdvQlRwQ3UzR2k4dXgwaDBwS0xaSSt6eTM1b2lJ?=
 =?utf-8?B?MGFFNHBySHhWbmpKNUNmVXJWRkJWOEh5QW1QZUdWaUNxODVPdjVNWkI0UkhC?=
 =?utf-8?B?dFdmcFdVT0N3VjhvK0hiMXRhUHpvMDQ1UXZKd1lwQWZ0dmtRVW9NZDJVc1h4?=
 =?utf-8?B?S1A4K1k2SUNpZFByTGx5UEcrd0Z5UEtJRHJWMjY1RWdxMVJnUkZCbmJoZFVj?=
 =?utf-8?B?TnhnY3lDbXQ2aW5nNlVzZ2UrcnVSazNBZGhQdGJHc3p4cDNTanhka1Z4ZjRX?=
 =?utf-8?B?dVFqSGdScjVuc1VoTmc3SXZyQ2VacU9MeDVxM0hqK3hlNlBXaTZFa3llanBL?=
 =?utf-8?B?eGx6VTQwSU43eTNzTWVvL0NEcjlKSVN6d0J1TG9EaWc1ejN4ZXdTczJlNnlm?=
 =?utf-8?B?OG9INmI2VVhVb1BEd3hrN2NtNlBKUCtCRGtyNStqL2tmVGQ2QWpwdVpyZy8z?=
 =?utf-8?B?NVJxdXZCNDNJTWNVV0VIQzQrUnBOcUFXdzd2QjJZamh3dk9paWhCaDYvTWpu?=
 =?utf-8?B?REN0Um91SXVSMW5LRmt0VHFJMWJsT0Nycm05WnIyZGdkRXdkbEVpZWhoaDdS?=
 =?utf-8?B?N3RnZEF6c2wrQ1ZBYjg3MXJtemFzSHRFazBCTFNpU1BRNVhJcDk4dnp3cWVn?=
 =?utf-8?B?dlE5a2hYUW1CY0tUeUNHYUtjWDJQZ0IrMzBsVVhTa04xbkFzRkMzQStET1hh?=
 =?utf-8?B?d1JuVWllYnErWEpLeE5jN2JuZ0E5WWh6OWRDUmpHMWNWRUU3T0dnWE1lbHJM?=
 =?utf-8?Q?cbqHzHPIf0zeB0Mijx229H9A/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 336a50d2-b618-4b63-5c91-08dcd1760e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 08:53:35.7982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qG0hChCLzxhx/6srZP8iwXMBJBWhi+S2LYMUi7DP3mIK6DBKi8o3xMNWgh5U6+0iW6SlE5SvJhspBFwuxUTCew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24gSG9ybWFuIDxo
b3Jtc0BrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgNyBTZXB0ZW1iZXIgMjAyNCAxNzox
MQ0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCj4gQ2M6IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2ds
ZS5jb207DQo+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IHl1ZWhhaWJpbmdA
aHVhd2VpLmNvbTsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFBldHIgTWFjaGF0
YSA8cGV0cm1AbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCAyLzJd
IG5ldDogZXRodG9vbDogQWRkIHN1cHBvcnQgZm9yIHdyaXRpbmcNCj4gZmlybXdhcmUgYmxvY2tz
IHVzaW5nIEVQTCBwYXlsb2FkDQo+IA0KPiBPbiBGcmksIFNlcCAwNiwgMjAyNCBhdCAwODo1Nzow
MEFNICswMzAwLCBEYW5pZWxsZSBSYXRzb24gd3JvdGU6DQo+ID4gSW4gdGhlIENNSVMgc3BlY2lm
aWNhdGlvbiBmb3IgcGx1Z2dhYmxlIG1vZHVsZXMsIExQTCAoTG93LVByaW9yaXR5DQo+ID4gUGF5
bG9hZCkgYW5kIEVQTCAoRXh0ZW5kZWQgUGF5bG9hZCBMZW5ndGgpIGFyZSB0d28gdHlwZXMgb2Yg
ZGF0YQ0KPiA+IHBheWxvYWRzIHVzZWQgZm9yIG1hbmFnaW5nIHZhcmlvdXMgZnVuY3Rpb25zIGFu
ZCBmZWF0dXJlcyBvZiB0aGUgbW9kdWxlLg0KPiA+DQo+ID4gRVBMIHBheWxvYWRzIGFyZSB1c2Vk
IGZvciBtb3JlIGNvbXBsZXggYW5kIGV4dGVuc2l2ZSBtYW5hZ2VtZW50DQo+ID4gZnVuY3Rpb25z
IHRoYXQgcmVxdWlyZSBhIGxhcmdlciBhbW91bnQgb2YgZGF0YSwgc28gd3JpdGluZyBmaXJtd2Fy
ZQ0KPiA+IGJsb2NrcyB1c2luZyBFUEwgaXMgbXVjaCBtb3JlIGVmZmljaWVudC4NCj4gPg0KPiA+
IEN1cnJlbnRseSwgb25seSBMUEwgcGF5bG9hZCBpcyBzdXBwb3J0ZWQgZm9yIHdyaXRpbmcgZmly
bXdhcmUgYmxvY2tzDQo+ID4gdG8gdGhlIG1vZHVsZS4NCj4gPg0KPiA+IEFkZCBzdXBwb3J0IGZv
ciB3cml0aW5nIGZpcm13YXJlIGJsb2NrIHVzaW5nIEVQTCBwYXlsb2FkLCBib3RoIHRvDQo+ID4g
c3VwcG9ydCBtb2R1bGVzIHRoYXQgc3VwcG9ydHMgb25seSBFUEwgd3JpdGUgbWVjaGFuaXNtLCBh
bmQgdG8NCj4gPiBvcHRpbWl6ZSB0aGUgZmxhc2hpbmcgcHJvY2VzcyBvZiBtb2R1bGVzIHRoYXQg
c3VwcG9ydCBMUEwgYW5kIEVQTC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbmllbGxlIFJh
dHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFBldHIgTWFjaGF0
YSA8cGV0cm1AbnZpZGlhLmNvbT4NCj4gDQo+IC4uLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0
L2V0aHRvb2wvY21pc19jZGIuYyBiL25ldC9ldGh0b29sL2NtaXNfY2RiLmMNCj4gDQo+IC4uLg0K
PiANCj4gPiBAQCAtNTQ4LDYgKzU1NSw0OSBAQCBfX2V0aHRvb2xfY21pc19jZGJfZXhlY3V0ZV9j
bWQoc3RydWN0DQo+IG5ldF9kZXZpY2UgKmRldiwNCj4gPiAgCXJldHVybiBlcnI7DQo+ID4gIH0N
Cj4gPg0KPiA+ICsjZGVmaW5lIENNSVNfQ0RCX0VQTF9QQUdFX1NUQVJUCQkJMHhBMA0KPiA+ICsj
ZGVmaW5lIENNSVNfQ0RCX0VQTF9QQUdFX0VORAkJCTB4QUYNCj4gPiArI2RlZmluZSBDTUlTX0NE
Ql9FUExfRldfQkxPQ0tfT0ZGU0VUX1NUQVJUCTEyOA0KPiA+ICsjZGVmaW5lIENNSVNfQ0RCX0VQ
TF9GV19CTE9DS19PRkZTRVRfRU5ECTI1NQ0KPiA+ICsNCj4gPiArc3RhdGljIGludA0KPiA+ICtl
dGh0b29sX2NtaXNfY2RiX2V4ZWN1dGVfZXBsX2NtZChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0K
PiA+ICsJCQkJIHN0cnVjdCBldGh0b29sX2NtaXNfY2RiX2NtZF9hcmdzICphcmdzLA0KPiA+ICsJ
CQkJIHN0cnVjdCBldGh0b29sX21vZHVsZV9lZXByb20gKnBhZ2VfZGF0YSkgew0KPiA+ICsJdTE2
IGVwbF9sZW4gPSBiZTE2X3RvX2NwdShhcmdzLT5yZXEuZXBsX2xlbik7DQo+ID4gKwl1MzIgYnl0
ZXNfd3JpdHRlbjsNCj4gPiArCXU4IHBhZ2U7DQo+ID4gKwlpbnQgZXJyOw0KPiANCj4gSGkgRGFu
aWVsbGUsDQo+IA0KPiBBIG1pbm9yIGlzc3VlIGZyb20gbXkgc2lkZToNCj4gSW4gdGhlIGZpcnN0
IGl0ZXJhdGlvbiBvZiB0aGUgbG9vcCBiZWxvdyBieXRlc193cml0dGVuIGlzIHVzZWQgdW5pbml0
aWFsaXNlZC4NCj4gDQo+IEZsYWdnZWQgYnkgVz0xIGJ1aWxkcyB1c2luZyBjbGFuZy0xOCBhbmQg
Z2NjLTE0Lg0KDQpIaSwgDQoNCldpbGwgZml4IHRoYW5rcyENCg0KRGFuaWVsbGUNCg0KPiANCj4g
PiArDQo+ID4gKwlmb3IgKHBhZ2UgPSBDTUlTX0NEQl9FUExfUEFHRV9TVEFSVDsNCj4gPiArCSAg
ICAgcGFnZSA8PSBDTUlTX0NEQl9FUExfUEFHRV9FTkQgJiYgYnl0ZXNfd3JpdHRlbiA8IGVwbF9s
ZW47DQo+IHBhZ2UrKykgew0KPiA+ICsJCXUxNiBvZmZzZXQgPSBDTUlTX0NEQl9FUExfRldfQkxP
Q0tfT0ZGU0VUX1NUQVJUOw0KPiA+ICsNCj4gPiArCQl3aGlsZSAob2Zmc2V0IDw9IENNSVNfQ0RC
X0VQTF9GV19CTE9DS19PRkZTRVRfRU5EICYmDQo+ID4gKwkJICAgICAgIGJ5dGVzX3dyaXR0ZW4g
PCBlcGxfbGVuKSB7DQo+ID4gKwkJCXUzMiBieXRlc19sZWZ0ID0gZXBsX2xlbiAtIGJ5dGVzX3dy
aXR0ZW47DQo+ID4gKwkJCXUxNiBzcGFjZV9sZWZ0LCBieXRlc190b193cml0ZTsNCj4gPiArDQo+
ID4gKwkJCXNwYWNlX2xlZnQgPSBDTUlTX0NEQl9FUExfRldfQkxPQ0tfT0ZGU0VUX0VORA0KPiAt
IG9mZnNldCArIDE7DQo+ID4gKwkJCWJ5dGVzX3RvX3dyaXRlID0gbWluX3QodTE2LCBieXRlc19s
ZWZ0LA0KPiA+ICsJCQkJCSAgICAgICBtaW5fdCh1MTYsIHNwYWNlX2xlZnQsDQo+ID4gKwkJCQkJ
CSAgICAgYXJncy0+cmVhZF93cml0ZV9sZW5fZXh0KSk7DQo+ID4gKw0KPiA+ICsJCQllcnIgPSBf
X2V0aHRvb2xfY21pc19jZGJfZXhlY3V0ZV9jbWQoZGV2LA0KPiBwYWdlX2RhdGEsDQo+ID4gKwkJ
CQkJCQkgICAgIHBhZ2UsIG9mZnNldCwNCj4gPiArCQkJCQkJCSAgICAgYnl0ZXNfdG9fd3JpdGUs
DQo+ID4gKwkJCQkJCQkgICAgIGFyZ3MtPnJlcS5lcGwgKw0KPiBieXRlc193cml0dGVuKTsNCj4g
PiArCQkJaWYgKGVyciA8IDApDQo+ID4gKwkJCQlyZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArCQkJ
b2Zmc2V0ICs9IGJ5dGVzX3RvX3dyaXRlOw0KPiA+ICsJCQlieXRlc193cml0dGVuICs9IGJ5dGVz
X3RvX3dyaXRlOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICBzdGF0aWMgdTggY21pc19jZGJfY2FsY19jaGVja3N1bShjb25zdCB2b2lkICpk
YXRhLCBzaXplX3Qgc2l6ZSkgIHsNCj4gPiAgCWNvbnN0IHU4ICpieXRlcyA9IChjb25zdCB1OCAq
KWRhdGE7DQo+IA0KPiAtLQ0KPiBwdy1ib3Q6IGNyDQo=

