Return-Path: <netdev+bounces-120884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5A95B206
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE2D1C2341D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141CF181317;
	Thu, 22 Aug 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ku5kH4of"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2051.outbound.protection.outlook.com [40.107.117.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C31E17CA19;
	Thu, 22 Aug 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319635; cv=fail; b=ijH+64s7dVKBwVmRt5c1CU56j0jkbpA5nPQJYtPo1MQCl3KYZqn/RtN8LK6e7KgwY5qaQrec1tOODFcgOTN/prbE6T2j2XMgcYoZd+MDhHHla+UoVlfSGQG3aJA7ySAsZUmMek/1S2QtQdVTBe8ytZSsdVTWuL45eksxI0Bbeck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319635; c=relaxed/simple;
	bh=a/GTsOSBf2+5leB0QGGLvMMipb6yR79g7TyXsu1NHsw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WLOcArfyFOUQsHP9FFaP/iJ0wManlnGjW+etUiYYFWpii0A0ZhxiVFJpenrHJSKrRgatvT5CryiKzZsE6quEpiezvBJRU6J3aHXCVVb/gWSqznFAuo6HPCZXdYh6vBe89fhWmG7j9oSKX0YV7bC5oRYrWpi00iEIplQ+0dFEf4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ku5kH4of; arc=fail smtp.client-ip=40.107.117.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nE2CA61yw5MWrS1VHv83hS7HZvlzwjTqEuJXszvDz+k8tB7oK2z5+b3VL5XOJrhcv7isNj9BCBarw4P21pgzWTDJon5ztyoVFw/UlG5NZQ5Ks2GA19Gjsvfsy3Xvsjok83WB8kvtqVrWPpKTTK+Sph4LcSFsb9OiIl6Z3MBFLi0muZwsCREKJYFLDbGhT/RpSaa0SnymDCqpMvm8vmgnFrfE+6fSVS4PKASyXJsNKt4/MMfHyutlB+6+/TyPL5Gx+M6eqrXQkPTQUKAL7iMjAURZkWU0bg48FnOrVpZI6Jv6LcmcJabwW7K8KdMhpTnswRNqlrQFGhtcw1SSeB/LsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzUP0GyvFmZvpD5bJWo1KA4cxLYarh7oI+LVaRIMEes=;
 b=hlNWd94BmWwxUzdAhKMloKoIn7kF0/c9+3BeMVABu6h1i7gKZmRd5Fwl8yG9rNltRN6pctFOOb/guXBOB5zYLE4L+ws48Q2x+236SuKp/LEIeGiVhRmJUOJvvLV2o7Aqm/f2wCAjGPd1UDmDcGZq3kQCkEA29NAMdcKHXOz2bV6/0+Dvc9KO2o6v1lw6kRCQElNMElVI4IKAN8aCLDvaAhm1KQGuRstyGYQkRjhyh0fNGN9zvviYcqwL6ti3mKorc8mQPpXKFl2PHBMoJ/bM+JhfAmx8VcifjLecHTVSvE3EGp70wfzvRHX2zrKG/d8PlaemWhUVROpERj9+NUDNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzUP0GyvFmZvpD5bJWo1KA4cxLYarh7oI+LVaRIMEes=;
 b=Ku5kH4ofISSXz83ZR30l8KlpAo+goSbGOIJzAovweyIi5tBPy756bM2pymcnzzQc2A8g8/Jurn2tr5UpZn/zQNu1kbKrZIARxSRIvtoD3ueY8GoVPcd5JFezIhdg/xsNu1NakFZoWVh4JPSUZ949eZ2cugUDP3TzO6kjqxmlvvSfG6GPYw3yGMaDO9Ym99T7FNUifAV5BScmoeRTvcDJCn1awUc9ruKpaIGSVD7oJ41WyqSiISWd4hkek+myFPZPtY04NOPGw42jiJx2Ui594uaYct1WhVgtw4StKAcTeXT6Jh1JO7WA+vEzjui1UN2G1zFPPMjq5nRV/1KQyY6TUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by OS8PR06MB7321.apcprd06.prod.outlook.com (2603:1096:604:289::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 09:40:30 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 09:40:30 +0000
Message-ID: <3f994754-2005-420d-9be4-33d7288bc811@vivo.com>
Date: Thu, 22 Aug 2024 17:40:28 +0800
User-Agent: Mozilla Thunderbird
Reply-To: 11162571@vivo.com
Subject: Re: [PATCH v1] drivers:atlx:Use max macro
To: Chris Snook <chris.snook@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240822075004.1367899-1-11162571@vivo.com>
From: Yang Ruibin <11162571@vivo.com>
In-Reply-To: <20240822075004.1367899-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::14) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|OS8PR06MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 28daa8b7-9954-414e-49b8-08dcc28e765a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUEyeDY0ZlR1M0pSU3ViZUxTZXlQaENjc0Mzc2t1elV3L1gyMEZDQzQ4bU1h?=
 =?utf-8?B?MDNkSHBKRE13QnBLR0RFVkpvZE02YVlURC9Ha0dRVlVhd0lyK200TU5VOUJq?=
 =?utf-8?B?R1VCeTM5WUNUdWZKTXJqM3F1WkFqdnV5SFk4WllBdWYxdDAwaEUrTTQ3alVB?=
 =?utf-8?B?cXFVV3Z5MjV2MTB0NFlBeGoyTXMrYzZQb00rU2N3TnJaVzRPWkthVkN4QVov?=
 =?utf-8?B?R24yUmlvcFZPbkRhYUc1N3Fab2xlNnp4aFpIakN1S1hJUk0vWDk4YjJaNWR0?=
 =?utf-8?B?ZXBYS1BzYWdKN1NEYlVIN0NOVk5FV0FobEUwZEhOTjdSY0UzeXZaNnpmaHc1?=
 =?utf-8?B?bGhKZHkreXQwRjk1M1BaZEdLcFJUeTdla3dza1ZBS3JtejJmQXJROFlkTVo1?=
 =?utf-8?B?b25FVDBtSHpMeXNZRXNSTFhYZkJMTGxOc0pORzRPVHpQSXUvWGoxUmdqakpk?=
 =?utf-8?B?UytMYUZNR3RYcmU0L0xEdUpZdmE4MHJBNU5mM25rSUxLN1lOM2ZkblNjbGFY?=
 =?utf-8?B?OThhRVA2OFZLQzhlMmdWNHFrNzNtQSt6Q2Q3RXNHdXJiRmQxRGJJU2xvbGNU?=
 =?utf-8?B?eW1rVTd2R25jWktObCthSUc5blU2MEk3TU8yMFVnaDB1SFNGM29PMTZyQXRp?=
 =?utf-8?B?SXlBcmxmTDM1UWRsR2o0YWJ4aWxrMjhKYU1IZFVtdStleHhuMGFLSDNJNkhw?=
 =?utf-8?B?SXJSSXpoVmlpMkZ2eVdQUkN0cWxxSHE1UUJMdW9uWEpzMFo2SEhVSkphSFVr?=
 =?utf-8?B?UHd1MnB0Tmp1cWppaFJGRGhkSjh3VnMvWktUMEpiOFFqUFV1UzdLN2tkcEto?=
 =?utf-8?B?dStQTlJ1MXhmZGdLaXB2bmxCN2EzWVdRL0gweHJQTXd4UjU3ZDdyMmlFemYr?=
 =?utf-8?B?djcwSTBWOWpUY3JXUjNwbllJc2dvb21McUhVMk9pdGVGSUplMlgwQjRTWUVF?=
 =?utf-8?B?ZDdzZzZRUzhXcmNmUXJXOENwWmxKSjBrNW5iRFZndElwdlRveWN0dUtOT0lG?=
 =?utf-8?B?SWdFVStobkIwZ3hoVVJBTGF0Wkc1WE44M09TYTFsTmZaTjN6MHVNNGVueGFt?=
 =?utf-8?B?VExVTTVjdlllcjM2Q2FFTDdzSmVVVGZ0eERhVE4zM0t2T2gwVmJzbUtrcDgw?=
 =?utf-8?B?OFk0bGx3WG9UOUhtYXkxK3YwTUtBbjFiYS9vYnEwN1JWQTIvVU4vNnlOVkln?=
 =?utf-8?B?NWQzZVo4dUJYVGwrbXVheXo5MFd4T1BrM1B6ejhmN2hmK09JKzNHTjd5TzZ6?=
 =?utf-8?B?UFdzZDl2UzNhZWNTYzFHVlBxTEFXT2MxcVVvNnpoV2MwcVZDZ1d4RzRydm5S?=
 =?utf-8?B?cE1FOEIybGgxVFF1RGlzMmZ0REp3N1BkaUdxbkVoT2dkUmRuY21OUXRIZmlw?=
 =?utf-8?B?NVJGcmRtY1dJcEZkVmd6VkdtVUU3d1ptMDBKZ3RlcHYvWkhGTWRjczk3emlr?=
 =?utf-8?B?RTVOY0JRMFZxeUNrWURnWnMyWDVPdWlCNXBiT0hrV05rcU51R2psd1VQS1Vj?=
 =?utf-8?B?cFc5TytzeVhJaXhkUDRwWUlBNGZFWDBvTXNlaWtFejRxbEhHYmROVkFObXc3?=
 =?utf-8?B?K0ZVem1rL0FyRmQzYzBLSWw4dE1nZUNUc2ZUVW94aVNtaE93dEN5dnF5NnRq?=
 =?utf-8?B?d1BnVGdrd0NtN3dLcGFOZ1RuY0tzS3pOYjByeU9nb2dSb2FsK0U4TEZoTDBH?=
 =?utf-8?B?WXdaWERBaG1IR1J1UXZjUUJuSDd0ZGJYblRlL3I0bmpyRUNGeFBjMlkxcGpX?=
 =?utf-8?B?elVwNGR4b1F2T2Jtdk5KS2pZdGsvNU9Edy9VTUVCMGVpYnh5VWdzWnJha2E4?=
 =?utf-8?B?cjFCTU9WRHVJNW8rZ25BZzUxd1FDa2FMOUNnM0pDem9PdHlsVzM5TUlxdkpZ?=
 =?utf-8?B?QzhBbkcxcjNkWlFzRXdNb2I4NWtzOUpKTnpvM1hQbllJWEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2lrbzBoQzdiam9tSWhyeVU1enZIaG1Md1Fydm9RUEg3SGNXRWE5WHlBc0ox?=
 =?utf-8?B?V29OMS9GZnFmV1N4OE0rdVhidEhtYitaNG4yY1NKTm1ONU9Xbk5yazM5UTh5?=
 =?utf-8?B?b1lzZzhCVXMza1hBZDFBdUVvaWc1NkRtMkJIU1RCVUtZRmRHLzlEVlFjYVFS?=
 =?utf-8?B?cmsyTDZ1dVRrWElhaHRtK2FEa29rai9CVTI1aU9nMFgzNjhiU2VSeVRSeGlW?=
 =?utf-8?B?b1ZTOXBxWTFPWWVqZjlHY1JSaDBqYkFmYk4zaFVWTnhzWER1QkRvMG9wVS9U?=
 =?utf-8?B?eitMTFd0alBuS0Vad3I5bzZsNTBQeGJ1bmxXandqcEphd3NuM3VZbk1MQmNN?=
 =?utf-8?B?TVZScitQOVRsQ2JHc1NCcE1OV0VHTldDS2Y2aUYrN0hxaWtRemU1WWhjdG9E?=
 =?utf-8?B?WHJ1NGZwNVdlUDhHeHVySHd1K0thcHBZblUzTkxoZUNPQlgzY0tsczNFR0dy?=
 =?utf-8?B?d3pZRURSTFFNSGZTa09oQWNIRGxySVdEdXQ2K2xoU0dDb3FZd2RvTnVlTnVV?=
 =?utf-8?B?TE04RVV2b3drMlZmbDBQZ0MyMWE5YWM2bDcxNUwySXR6WXVWRXhYUnNGUVFx?=
 =?utf-8?B?U2k4QU5BMHFBQ2NsNkE2MGtKWVRQQ1ZYTGNZRzZEdkp2bzJQOVNKdWZnWCt5?=
 =?utf-8?B?cjZlMWI3RkppaG1hdHlZU04yQTJubkhFaHdmOHg3YlNhYTFIWjdEQzNPNml1?=
 =?utf-8?B?b2RJUCtMWW5yYnFEemlmdmV6L3dSOU81TW1MM2x2UHlWSFh2MXFJOUV1V0J3?=
 =?utf-8?B?ZCtrQnpxcmN4L25nUVpmMG52K28vVFZlYmVsZS8wZk44d0V4NDJYOFExaDVQ?=
 =?utf-8?B?dXlyZHNPam15ZGxYVHFocklnQk5MWHpwVUtxeVVQTTJYekJUUWpMTDBUbE5G?=
 =?utf-8?B?bXJyWUxFTkthU1BIWDhLcnFnbUNtTngvNVZxbng4cjV1ZTNnWm1WTTlSUmIx?=
 =?utf-8?B?b3NEYU5mNTFjTy9lS255blhsRTk3K0pENUttRjBnSnh2aGl0aGNKVHpiYkVP?=
 =?utf-8?B?K29BZzE2bnBaOVlsM0RMSVBGRFpicDd2Ti82STdIbC91VDB0S3pzdDRoZHNm?=
 =?utf-8?B?MlpJMHVLeFBIRG5EZVdiMDFOUk5IRnB2NXRjTVpmYTE5K3ZwRFlNTHdtRGNF?=
 =?utf-8?B?c0xLNnM2NERkSk5vMUVRUW1rejJTKzhpbTIrL2VPQzJBMkJoS2w3WENSSlJC?=
 =?utf-8?B?VTg3ck55Z2ZBeSt3TG1teWVzdnRtbi9xM05kVXZVR0htV3lGQ3R6UTRHSm14?=
 =?utf-8?B?ZXVLa3lSVFd1LzJnYWloMVhhRWNnWkJkUzZacWZsUGs0dmtCaHpiQ0xGT2dO?=
 =?utf-8?B?Yy9pTDduZ1dVZnlaZFRBNEhiejJ2bWpGTEsvWEIzQ3lFUGxzejJIL09rLzdR?=
 =?utf-8?B?R2duOE1Yank5eHFCSDB1NlNBdk1SYkwzWHRPYVZUNm10N2VKQlFCRmxZSVBW?=
 =?utf-8?B?eFZOc3gyZ0lMSGdLSFZjRGdZNi9MK0JreGFEL1pqbkpiS0Fiem00WEphYmc4?=
 =?utf-8?B?SkF0c0VpNmJwOVIyaDZsNnZ1OUpCb0VyZlJlN051MUpWODFheUFYSEpPWWVG?=
 =?utf-8?B?bVJ1S0RkaS80ZCtQenBadzhTcjJLZWdQZU1JMnhMUC82Q2pJeWtNK0R6VnJD?=
 =?utf-8?B?NTluMlZ1OVJWSjNsRjhTQVlGdlVydUZOVVBma2RjcjFMRnd5NG0weVUzcUZy?=
 =?utf-8?B?cWZKaEUrSlQ3ZnpkRkF3N3JlZDAvTFd1cVdkazhFTTVlYWpQVFJ5dWNLWVRa?=
 =?utf-8?B?RFNjcXRuMGw1M0VHdjFXZXRBRXZCRzc0dDhqcnBvZGhRbnYwZnUrN2dGejBO?=
 =?utf-8?B?UXBYdXNjcURuWklnZ3NiYXFaODNIU1NrbHNVUUc2SzhIaUZTRHpaSEtDOWh4?=
 =?utf-8?B?K295VnlWYTNKYTIwZkhob05vQUpXZHdOOUNETEFWUFNPcE1uK09YRGE2dDhT?=
 =?utf-8?B?cEtmcWs2UHVPZ21SRFliMmhxTkpnajJMY2MwNWFlTThRRGhBdnIyN2JLWndC?=
 =?utf-8?B?MkJtWDhPM2cyVVBCWHY3V082ZWF5ZEhpRjlGeVVmdElsUngxSGNZMmtoejNI?=
 =?utf-8?B?djZUVjdhQkZXTWM3NHJ5eDhOWU0wL3JMWFVyN3lvYWRmUmRsTmpyMHNkY0hC?=
 =?utf-8?Q?2QPJ1ITpOTk/FIV/bySx7qXQu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28daa8b7-9954-414e-49b8-08dcc28e765a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:40:30.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMG94k9mNlwjXrIylAepuXtRacm3lqbZEatjBQAbqrao09CkS1I8mzFzEsHLcSxtEsuggLc2GI29GRIoe1kgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7321

Sorry, please ignore this patch.
Because the corresponding header file is not included, there may be 
compilation errors.

在 2024/8/22 15:50, Yang Ruibin 写道:
> Instead of using the max() implementation of
> the ternary operator, use real macros.
>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>   drivers/net/ethernet/atheros/atlx/atl2.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
> index fa9a4919f..3ff669e72 100644
> --- a/drivers/net/ethernet/atheros/atlx/atl2.c
> +++ b/drivers/net/ethernet/atheros/atlx/atl2.c
> @@ -2971,10 +2971,7 @@ static void atl2_check_options(struct atl2_adapter *adapter)
>   #endif
>   	/* init RXD Flow control value */
>   	adapter->hw.fc_rxd_hi = (adapter->rxd_ring_size / 8) * 7;
> -	adapter->hw.fc_rxd_lo = (ATL2_MIN_RXD_COUNT / 8) >
> -		(adapter->rxd_ring_size / 12) ? (ATL2_MIN_RXD_COUNT / 8) :
> -		(adapter->rxd_ring_size / 12);
> -
> +	adapter->hw.fc_rxd_lo = max(ATL2_MIN_RXD_COUNT / 8, adapter->rxd_ring_size / 12);
>   	/* Interrupt Moderate Timer */
>   	opt.type = range_option;
>   	opt.name = "Interrupt Moderate Timer";

