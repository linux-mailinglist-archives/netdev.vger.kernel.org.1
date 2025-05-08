Return-Path: <netdev+bounces-189058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E95AB02A2
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBD44A7A4D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1A7212B28;
	Thu,  8 May 2025 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V6HEqIcJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D92A1BB
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728688; cv=fail; b=dFztAS3Isu5LjDTwVh9+1RP9QJ8SaOXWsu2D9plgOBCgEgZ4AaL8oFuARf6Et9RSoCHglA49MU6HDLAnfLlUhn1co/5KxhP9IjSGrlZI/4ovRCwEVlFxF6spM9yU45LG8skPOJBCC7eabMk6EXMxYkbQ4eegTs55RTzSnQT4ax4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728688; c=relaxed/simple;
	bh=j/ACQ6UD2x4FitDAfSTPBdo+rujoKPMzPQZle7uBxbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KREaZ0rQm4tOMLq30zD6AEfrZ2oPbjT1v+7woLhcIvKJiJs3n2SXH6BcSQLVXKg3TvM5pcCmsEk9809NZed/1YhGM2JgnS8Nj+aN2ywVI7lpivNXvTYohgOxRO4v89AazROhCTKYV9CC9HiXUuyLqiSJeXrhfh0BVzY2H+gy4VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V6HEqIcJ; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzavyo0YEDoBKJtzEY5mUSD6XKIpCojZOUNDtf8YYDhqdh3Al9J8RBhqhT4KvgsDppphxuTV4wClUklY3VSf65svyjxa7C6OzziGCx8Im/e/mY67zkAxD0N5JxQhlpDEEOQdoOvqvLXkS8HV/xL+3a7CqQ2tZzfQdzEbAugcX3++7jNR0i38Txik+8WRIHqoA6BHPoegwBLia8eb7Z5Krl6tN+LXQlPurs+faJf2nybV53XtHkYeXdEQsUyIW0mXl3dHOHRG9LHnbyVbhWxzYg8ZQoa/QSgxEcVbqAQL6FxzfH4stgaNP/XlzAlKpU3w4ohfalp20znZEWlnLacq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/ACQ6UD2x4FitDAfSTPBdo+rujoKPMzPQZle7uBxbE=;
 b=NH0x2G6Y6Vso3ioaGF0l3JXTp1Vu+Mh+Ts+VLuEK1/kgJt9PQPApfEwxEPM27TbuCdNKEUp/2noodYU6WevBwH285sOBrmG65CEP1Oq7Lud72IGDQR/3N1792+3+OfY0ei7MJVdk7kSQ09L9r3bNGMrQ0JZQg7ROay2WDyUQopoT/UUOH6nxHG2e8iwploeXYip8JfZ7jjtepYv8OWAOCuNqOY9JTPvxIR+qeOXjafWjO7yIFjfoo2kMrOAaiLGH3SerD6e+J/YxmNQgOtbGxA03rnqRRS86v//XkpWbEGwTuu5unY33VwITmbBN83FP8SRAUmsAPvS9qrmxr8EKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/ACQ6UD2x4FitDAfSTPBdo+rujoKPMzPQZle7uBxbE=;
 b=V6HEqIcJf1TcFC4+BlvuRbm2dRjpryOMB93BesSPYm5HoOay+kwJuedkH8FFaxdhEaS1+FfvlN0QIi4yMbccjFJZJct8YeKdC8evLj81GRqKE/8QgKYa1uSPuV2G4Z3Ctsq7w+2RSutZetLXxJDRrLaEoDnoDgVMeJ3t/RlHU0yqted/LtVDbZvjC9j0JjzPMQJJpvbJnvmMLyl1CgyKUgJ26/j/3Xc3z4PxF5nHzbPDSuyx5WjeOaKcss0co3Y3pjk310ijCgrlP2w6dd7Jr1Dl50ar5ysEcuTlQuaSdvkbmxx42CoBXtDDLXC/3ORXltaavajdKJLG3rRU4TFhIQ==
Received: from IA0PPF12042BF6F.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc8) by IA0PPFD4454CAA9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 8 May
 2025 18:24:39 +0000
Received: from IA0PPF12042BF6F.namprd12.prod.outlook.com
 ([fe80::205c:a915:afb1:60e9]) by IA0PPF12042BF6F.namprd12.prod.outlook.com
 ([fe80::205c:a915:afb1:60e9%6]) with mapi id 15.20.8655.031; Thu, 8 May 2025
 18:24:39 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] net: Lock lower level devices when updating
 features
Thread-Topic: [PATCH net v2] net: Lock lower level devices when updating
 features
Thread-Index: AQHbwClFy5Lv8FwEM0is7bTPJquih7PI58WAgAAk0gA=
Date: Thu, 8 May 2025 18:24:39 +0000
Message-ID: <b14f2b94b9ecfcb0926c09f8bce01dc2a52a0eca.camel@nvidia.com>
References: <20250508145459.1998067-1-cratiu@nvidia.com>
	 <aBzYAzPtf_TlhT0n@mini-arch>
In-Reply-To: <aBzYAzPtf_TlhT0n@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF12042BF6F:EE_|IA0PPFD4454CAA9:EE_
x-ms-office365-filtering-correlation-id: 7cd3c028-9f3d-4650-8fda-08dd8e5d9853
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEdSWHlrVExjNmJLaTVDNFV6b0ZNc2lBc3k1bGxrWFNieXRNSmhJVmloNlU2?=
 =?utf-8?B?TStmSmkrWUl6N1c3OGl1a0J2bHFGakJFUThpOXhuRDRIVlBuQlZueEhLSEFq?=
 =?utf-8?B?c0RYODdwc1FGaHdZMlF0dkhRMFdEWWJRa3V5YTdEaG0vbEVjRkt6bDdBRHZN?=
 =?utf-8?B?azdwTzdXSXFPbWRpdUpUbmZZUkhkOVpaWldtdzhFRlp3Q0FwR3J4ZnFYVVRX?=
 =?utf-8?B?K2dDeGgvSCtPMHk3YXVhc2dXT3FNRFk1SkNFemk2dUlrdDNFTGkxdE5mYmJk?=
 =?utf-8?B?c3hncFhkY0NkcFA2V0NlcVo1WGw1b3M4Qm9jamVYYTIya1hlMzUzYW1KYTdT?=
 =?utf-8?B?UVNTbmpnY1FKM3FBV3ErME8yY3phdm1Yc0tUUFlNZVBMejY3OHpmN0QxR0xr?=
 =?utf-8?B?UHlhcXB2b29hTklzMFRNNk5zMXpHWXdvZFpVZmd5anh4MnNleTYzQmxWMzZM?=
 =?utf-8?B?MW1xdDM1c0l4cDZ3dmZzUFhCZ2Q1OFI0NFhxbmVvbkNGNkI3OFQ5bndKYVJN?=
 =?utf-8?B?TXpQMnk2R09ocXhBTVRvbkl4UXl1SnROTTFyRmp1Rjg2aG4zdm1FTnYreTVt?=
 =?utf-8?B?UVJ6RGk3ZXpnOEJnYy9JaVZ2d2dPMnhtbWIrWENIRnZoZkpVOWd2Tnh5eEVC?=
 =?utf-8?B?Vi9xQVlETDFlVHdEWG52REc2TFV6WFRTbjdraDAzWjdremcwWGdiYnVnYm5K?=
 =?utf-8?B?Z1YwdjY4eDN6YWRpSzlKallCaGVBNDJVNDRuUG4xbzN4Sm9aUjI0OXR3Qk5S?=
 =?utf-8?B?ZGgyTFVQc1dWd1E3RnBxc0RlSEhEdGlPeUxTQmNza2N3VTNhK0RqbWtkM21m?=
 =?utf-8?B?dzdudkRmTkpYUVJJeGgzdWFmSExYcWpYMmtKb1l1dVp4RTJMVFdVTGU2Q2RZ?=
 =?utf-8?B?bFJCbStNUlFiNVhaOVI1YW0ra21iNkVLWUlNWm9hVUJRdmM5WTV0NmlPbk96?=
 =?utf-8?B?bHFnZGRudng5Yy9nYkd2ejQrbkhJckJyQjlaUEQ0YXVCYTc5blA3UlBKSGlO?=
 =?utf-8?B?WSsvYnBoSnB2cHVuVmQ2K3lCamxBbmcwSkVsSDgrZzJub3RSaU83SFZoWkhr?=
 =?utf-8?B?blRrazRIUGtGdUpueHk5QVdiZEw1Y3RoT1lqNTgrNDFocmxsUUJaT3pwRlFC?=
 =?utf-8?B?R1ZFRHlrSXVVTzZ2ZDFycERWZHNrejhKRE5jZUFKUFdmMlIvU04zd2dtdCs4?=
 =?utf-8?B?ai9JNjg1dGUwR29PN0NYWDlBMHo2U21ic1J0TUZKcGtPWlNmQXE4MkNHVkkv?=
 =?utf-8?B?VXhvR1RSaDMxc1RDTWtsQXUyajU2aTkzeHR5azdBQUpDdk9zUktXNHBNamE0?=
 =?utf-8?B?enhUeTIwLzUwWU44R1p6dVhPenZxRU1zNHpYbXp6bmF6L0pCeHZEVW9UaEY1?=
 =?utf-8?B?cllId2ZnbXdVdmdiNUpqcGZ4cFJtNHRGTEV3R3FuY0svWjJpK25PYTZPOVR6?=
 =?utf-8?B?OWxDOFZMaEdaNndyR3ZkcWVIbzYrbG03cm9sZkZ3Z0UyMVZHOS94QmorWkdr?=
 =?utf-8?B?QjdCUXh2Vm9wS0dXajg3QXE2SmxRL0twQjlVT3hsYmNXK2FEckx1aHhXZzgz?=
 =?utf-8?B?RDB0ZkE4VDFydDlDZk9CN25oeitnMTBrQzFodXhuV1VTZGZ4MnVVNndlblJO?=
 =?utf-8?B?ck5OQUpHbDBSeGIxK2wyZEMySm42UkRPbFQvdk0yWGxYSDJ0TEdQcTlZOVo5?=
 =?utf-8?B?UWhTOUxUOWZyTXE0Mk5YN1BtcVE2c2huaDVFZFl5K1dCVUNUQzliaXhqNDEr?=
 =?utf-8?B?VFFPNTRiZXZXUytrKzR0R2hiSFdKVEtJT0Y1SGNKc2RBbmJZOWFyaEphUzVY?=
 =?utf-8?B?b0IxenRLMEdHU1VXNEFMVDMvUGJqUzhGUG11U3h0MnAvby9VUVpsYUJZSFpI?=
 =?utf-8?B?eWR4eUNwK3J5VkVqOGhKdXRhSGVmMmdjalErMDFpMUJKWGhXWWZMZzFlWVI3?=
 =?utf-8?B?Y0RsWFM5RVNVbkFaeWVqcWl6bUppQ2tjN2tvbGdqZUovTXp5SVlEbnd0TEp5?=
 =?utf-8?B?cWFiNmprL1VBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF12042BF6F.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zk5FLyttbWJ5dHNHYWdET2UwSlFYSHlzMFhTVEhIc3lEbU1OcThMc1hKYmJZ?=
 =?utf-8?B?K0pjRk1vT2RHT3FOWW5SeVV4c3c4NDc1aTdwdVFVLytUckxSQnZVVEFIeWJ3?=
 =?utf-8?B?MWV1UkdqbVc0amUyUTFONlFuVHFWTDVXNGFkNlJXQk1YbGxkc2NlemZqVk5M?=
 =?utf-8?B?UHM5c0pDVkJxVFJCOUkzN1ZQYm5rdlo2Y1BHd1BQVHZaV2FkMGNQUEV4QStE?=
 =?utf-8?B?TE9sTWZlc1BNZlRKemVqbm9xaStiNWdQQzkrcWF2WStmZFBqVlRWT2Vad0Uy?=
 =?utf-8?B?dzRLeE8rZzB6QnhRRWo2bmtYV1JKKzNtczlqWm56TEpmQktoSm1VYUMvSTRJ?=
 =?utf-8?B?b3N5VU9wZGFIazJMVWpBRWxDWlJkS1pLdktEMVdvRjZnV2hmbE9DNHM0ZE5q?=
 =?utf-8?B?T2xMN2dGZ2tMVjF5WVlwMk1rOERMM0thMDJBNDJiVHFIRzVLcXlVNXliUXQr?=
 =?utf-8?B?Z0h2aGRpSmNyRGZMZXdLc2hSeTdjOGVCeGVEV2pHbUFybkVJQ0JySlhUNWZJ?=
 =?utf-8?B?eWd5YXJIMlA2R2duOTdwTXJUTjZZT0lPSERyUU5wWDVSRDE5cnF0WXZvYnlr?=
 =?utf-8?B?T1N1Y1Y3SlE1Q04zWjlFbXhIcEZUYW16REc1QUhaV3crSzgvSUM3QTFYeGFU?=
 =?utf-8?B?eWo3SWJIQ0dVKzhQQ3hoeS9yMG9SUGRITmlDMVlLNkJLWEh0bUxJV2FseEx2?=
 =?utf-8?B?SGFKTlIxemQ5c1JPVjBlYkFLNVdJbFhXZ2JlN2hnY3RzSjROQlpwWFdHbi9Z?=
 =?utf-8?B?cFYxUUphUjVmN0kyd0cvclJSVzNjMVllZmtsRGppRnE5RmNCeG04MkhVTDVp?=
 =?utf-8?B?cExuTWcxbXJDYi9Ba0lKODA5T3NGaFZDT0EyejNvT3FWMEQvT0hESk5xand3?=
 =?utf-8?B?QmR2OWx5eHVBTmt0WkV3U3RNUXdTcVZYR2tIY0Nua24wREx4WFduNnFGQmNl?=
 =?utf-8?B?ejJscjloRzhDa3NEYUdxdktld0VaQzRsRjRSWHRTaWVBR25UN1NIbWI2ZjFF?=
 =?utf-8?B?Q0pwS1cyOFYrVU1hZWx5K2FZSmprR0dLYmNRcGxsakhsOHpwUmVjb1Z6N1cv?=
 =?utf-8?B?YTFMdm1qSlN5ZUVLMFE1bDNMMUErZEVOQnlSdnhPSHBwLzRDTGgycWtjYkx5?=
 =?utf-8?B?enFJb08zY3dsQUZWUUo5RTVUSlNGdXJWMkNWRGhxSUJBMWJJTStZS3owa1ZF?=
 =?utf-8?B?VytQWmpoMC90WXh1ME43bVgrQytHTVZtTjdhd01uOVpNSUdnRzBWT2VNOE9H?=
 =?utf-8?B?SWg0ejhZVVN0QzJaU2h2cG81aStEd0hSSEgyaVpsc0tkY05ObnpLQ3FsN3FV?=
 =?utf-8?B?OHpieVVvRUlSaUZuYzdOVFk3VXhIdjRTc05YMTdsek9lMDkrOXlOamNrTkI4?=
 =?utf-8?B?eE9uYjkrdXpPUDlXdEtGTFR6Z0JjOWhCR3FBSHNYaWdSbllPTEhmKy9EZDNE?=
 =?utf-8?B?SjNUQkwwbWtlTVl4MUJ1ZVhrcjlLMjFaUXJHbFhPcktyN3lic29wZ3NBWkkv?=
 =?utf-8?B?MHlFQzcyRHJ3a0N5K013ejR2a2Q5K2gxa21tNzIzeHpDMDlleDdHZThMSTZG?=
 =?utf-8?B?Yi9wNW81b2xCNTAxQUFvZWsyQUtyM3EvdEUyZ04xWlhDUDhlN0RqN29sZ2Zx?=
 =?utf-8?B?a2VldDcvbXFMUUtQQTR5NG9VblRDSEljbm54d3F5RDUvQUNuUG8vejIyS1ky?=
 =?utf-8?B?OTdEUlYwdTE1bFNRU1VERy8vdDlSLzk5T1BkNWZlYmphL2w1V2FOTlZRazdt?=
 =?utf-8?B?cnZiSVM1R0NFOVVQenQ5TUlLQU5qcXJaclJFT1RSZzNEc01IZWFLQU1uYm12?=
 =?utf-8?B?aytMbW5sOVprUWczVGtBcVluSlRhOXpiWFc2ajJ3dUY0OXJua3o3dFkraCt0?=
 =?utf-8?B?YVI4RFZjWWEreXhzVlNWSFBPR1IyVW53RThjbkR5WUxiV3V3MzlLNjFGeHho?=
 =?utf-8?B?cHJpblU0bVBZNXE5NjdSVHl2S3ZxcGxmY3BZS2hBS1A4bG1KME5Qc3VnYSt1?=
 =?utf-8?B?UDc3WUZsNG1HNStZSnN6b09qTFl4L2tjRG1KS0tFZ2UrVVV2VXVxbi92Wldz?=
 =?utf-8?B?akY0RkpRMzIzMm1pM1UvZitCQ2s4MktPdWswRmgzRjNTTDBFUmNveVpzWUVC?=
 =?utf-8?Q?sgE2YKu5+RvhBO59c7qbIbmLe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6735D9BF5189294A8C9DE90A2A6C334A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF12042BF6F.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd3c028-9f3d-4650-8fda-08dd8e5d9853
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 18:24:39.5050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8Apy9gvtjylrjNBip6qmc09K6HwVKsNDGELHmgDKfWhAy1165tWyEW9V4GcCNqO9QNEUD/JaClRNINXlWd+yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD4454CAA9

T24gVGh1LCAyMDI1LTA1LTA4IGF0IDA5OjEyIC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+ID4gLS0tIGEvbmV0L2NvcmUvZGV2LmMNCj4gPiArKysgYi9uZXQvY29yZS9kZXYuYw0K
PiA+IEBAIC0xMDQ1NCw3ICsxMDQ1NCw5IEBAIHN0YXRpYyB2b2lkDQo+ID4gbmV0ZGV2X3N5bmNf
bG93ZXJfZmVhdHVyZXMoc3RydWN0IG5ldF9kZXZpY2UgKnVwcGVyLA0KPiA+IMKgCQkJbmV0ZGV2
X2RiZyh1cHBlciwgIkRpc2FibGluZyBmZWF0dXJlICVwTkYNCj4gPiBvbiBsb3dlciBkZXYgJXMu
XG4iLA0KPiA+IMKgCQkJCcKgwqAgJmZlYXR1cmUsIGxvd2VyLT5uYW1lKTsNCj4gPiDCoAkJCWxv
d2VyLT53YW50ZWRfZmVhdHVyZXMgJj0gfmZlYXR1cmU7DQo+ID4gKwkJCW5ldGRldl9sb2NrX29w
cyhsb3dlcik7DQo+ID4gwqAJCQlfX25ldGRldl91cGRhdGVfZmVhdHVyZXMobG93ZXIpOw0KPiA+
ICsJCQluZXRkZXZfdW5sb2NrX29wcyhsb3dlcik7DQo+ID4gwqANCj4gPiDCoAkJCWlmICh1bmxp
a2VseShsb3dlci0+ZmVhdHVyZXMgJiBmZWF0dXJlKSkNCj4gPiDCoAkJCQluZXRkZXZfV0FSTih1
cHBlciwgImZhaWxlZCB0bw0KPiA+IGRpc2FibGUgJXBORiBvbiAlcyFcbiIsDQo+IA0KPiBBbnkg
cmVhc29uIG5vdCB0byBjb3ZlciB0aGUgd2hvbGUgc2VjdGlvbiB1bmRlciB0aGUgaWYoKT8gRm9y
DQo+IGV4YW1wbGUsDQo+IGxvb2tpbmcgYXQgbmV0ZGV2X2ZlYXR1cmVzX2NoYW5nZSwgbW9zdCBv
ZiBpdHMgaW52b2NhdGlvbnMgYXJlIHVuZGVyDQo+IHRoZQ0KPiBsb2NrLCBzbyBrZWVwaW5nIHRo
ZSBsb2NrIGFyb3VuZCBpdCBtaWdodCBoZWxwIHdpdGggY29uc2lzdGVuY3kgKGFuZA0KPiB3ZSBj
YW4gY2xhcmlmeSBpdCBhcyBzdWNoIGluDQo+IERvY3VtZW50YXRpb24vbmV0d29ya2luZy9uZXRk
ZXZpY2VzLnJzdCkuDQo+IFBsdXMsIHdhbnRlZF9mZWF0dXJlcyBpcyBhbHJlYWR5IHNvcnQgb2Yg
b3BzLXByb3RlY3RlZCAobG9va2luZyBhdA0KPiBuZXRpZl9kaXNhYmxlX2xybytkZXZfZGlzYWJs
ZV9scm8pLg0KDQpUaGUgY3JpdGljYWwgc2VjdGlvbiBjb3VsZCBiZSBleHRlbmRlZCBmb3IgdGhl
IHdob2xlIGlmLCBidXQgdGhlcmUgYXJlDQphIGxvdCBvZiBuZXRkZXZfZmVhdHVyZXNfY2hhbmdl
KCkgY2FsbHMgaW4gbWFueSBkcml2ZXJzLCB3aGljaCBJIGFtIG5vdA0Kc3VyZSBhcmUgb3BzIHBy
b3RlY3RlZC4gU28gSSdkIGJlIHJlbHVjdGFudCB0byBzdGF0ZSB0aGF0DQpORVRERVZfRkVBVF9D
SEFOR0UgaXMgb3BzLXByb3RlY3RlZCBpbg0KRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL25ldGRl
dmljZXMucnN0LCBldmVuIHRob3VnaCBhbGwgY29yZQ0KaW52b2NhdGlvbnMgd291bGQgYmUgbWFk
ZSB3aXRoIHRoZSBvcHMgbG9jayBoZWxkLg0KDQpJIGd1ZXNzIHRoYXQncyB2MyBjb21pbmcgc29v
biB0aGVuLg0KDQpDb3NtaW4uDQoNCg0KDQoNCg==

