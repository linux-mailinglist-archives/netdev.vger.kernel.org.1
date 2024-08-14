Return-Path: <netdev+bounces-118268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C2B9511D5
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 04:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3981328426C
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 02:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7F517BDC;
	Wed, 14 Aug 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JGtiPjPl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D5171A5
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601043; cv=fail; b=PlKKMIKg6oZRmK74PhBiGOD8BAa+63x27WNvv6oOV0HR35FkNYuwW4klongC0t6VZH+N+Qq6bB5AekK1wHhVFwJN48jTlcCnOIKro5fnY55B3pfmgPXkYEXZQxqQYlHxjY/cN2hbqTovDiEpDTxmoTD6Sk8cmeuIJvOqBVe5CiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601043; c=relaxed/simple;
	bh=J3N7QlhYzzgicRPPd8OxKTSUz6s2BqT4Q/+VTWXVHYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XE1ONnQmvUuKLajnc2WhuC4YDzUIZQTFDGrFA0reBpiFYPMCNGWxgxXDx63nXSbTueBhVk5mxFniRphInw6Y01FzPCKHn3xaU3M4s+DGKJBP9guYa5CvC/XwKN2fqET3XFpJVdMT4k1fBO1KL1PzjURIapqBUI5ayyH/cWa3VBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JGtiPjPl; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEXzbbHhMpkVD9eCd1HjiVmqZUnJL6BL+MFOEN6cWAXdhmKFf3eYc6W8dBonoVGupXFk27hVwLgyHa2fwSbTQmEEXcQfXvF802CJhv6yNRdnC4kL/D8Qbh36AECbh8LX6NTi1iZNU0euYqxPzlbJgI2fc9jZH9iv/cKJLbsagIya4fpM8J3eJKfDM0kJxalcV9sf/GXnbhsn9Jv/GbVFpAf6UZA3bKQJ9/mAoouSM34Npc3DzPZZPYCgDf1izEOhRj+inJWlHhOUxD+XYoRJlVXvFV/NJGty3p0zuceX0Z6grtQsN9ki7OcFJZ/YsggVi4jqpZePb4QwiywPiH6aXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3N7QlhYzzgicRPPd8OxKTSUz6s2BqT4Q/+VTWXVHYI=;
 b=mkIzg/tO0nWA7ul3A13jp1asWJhvRFKUveyZIuIA2Fa2MkvvHBhHZznP1g2b9EbxgJsHxDfnw3qN4WR23e3bwmbNeS8oKFonJU+ZnbA+oCNRUDQ7GLdv3vlH7KnUaahKR+8ks/49NGcpAJ2zbA8Qsbg6/SgZsbZ6le30N7na0q/gLmV5fL4KUE6q0pKpaGO7ijt1pJKnmYFZBvQoYmGDhwjXu8zNFm8l0gsamLlPsJG5c0F+YVIv+ulLDnUJgCgq6WoB9M4VxhCxVhyXTSWZ5fjIqdRgqbwm+WgI0mxkviTNvv/kc13BRebCWdsPJwC+S3+2CUwvC8zjkpnPvDpMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3N7QlhYzzgicRPPd8OxKTSUz6s2BqT4Q/+VTWXVHYI=;
 b=JGtiPjPl7ETDb8H3s1lC6kwu9b6GAMmkmzKuFRxZhGfm5sW8XGfkFbjs7v4C0RbwP4K9yal2sksr/WYmCejIbVAnNOoVy/OZHXXhyAAYuapIDiQD1x1cEmc+vhSvKJHqHTSqh50EZ55oz/KslLhXuQswqFbMcYWzW79j9U7MF+k1l9vql7V0YZBh8Wv3EoYOkUVV2pqvfc842SyIj6wj21hv+3wt1rzQEnIg1AEd0yQEJC1AUMUt/2hHUgbbwsB8OfRjBXCEyj3efI+YgXBBqtYH3P+ep9cxSo6m3nOhN8pHOQ6UObAD7ziBLDCo2S7HwWDRxinMzh6OtIMPaHy1nQ==
Received: from IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 02:03:59 +0000
Received: from IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d]) by IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 02:03:58 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "liuhangbin@gmail.com" <liuhangbin@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "andy@greyhouse.net"
	<andy@greyhouse.net>, Gal Pressman <gal@nvidia.com>, "jv@jvosburgh.net"
	<jv@jvosburgh.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>
Subject: Re: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and call
 it after deletion
Thread-Topic: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Thread-Index: AQHa5vUrWi/gseXBCEqaGlxcFyce2bIkZyIAgAAkNgCAAL0JgIAAxiQA
Date: Wed, 14 Aug 2024 02:03:58 +0000
Message-ID: <ad64982c3e12c15e2c8c577473dfcb7095065d77.camel@nvidia.com>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
	 <20240805050357.2004888-2-tariqt@nvidia.com>
	 <20240812174834.4bcba98d@kernel.org>
	 <14564f4a8e00ecfa149ef1712d06950802e72605.camel@nvidia.com>
	 <20240813071445.3e5f1cc9@kernel.org>
In-Reply-To: <20240813071445.3e5f1cc9@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8554:EE_|DM6PR12MB4403:EE_
x-ms-office365-filtering-correlation-id: be980c0c-d919-481c-4f79-08dcbc055c2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3dXOUIxTndLSStGT1UzbnRLYWUzWFRPS0VLNmxRampKQ2d2eDlrTGFMOFVv?=
 =?utf-8?B?dm53elIxb0RPZFNUZDd3UFV4cEU0bFJxVUJoTTVYTDFMZWc5UVR0cXgrbyts?=
 =?utf-8?B?ckxnOC96NzJVdi84R05nNnFaL2dacTZYMnRneGVOcHUrdkZ4TDdPNGZPem9h?=
 =?utf-8?B?UmRwNHpDNXVrc3h0N3BoOWRzbHVqZUtkUzFPS29LcUhJVGNpUHBneW50a1B2?=
 =?utf-8?B?ZUpWejFnb0pqU0k0RmN1TFBrUlpJYWtWRzlYL3pHb0dxcVFhajBiTUFTT3pm?=
 =?utf-8?B?dFVmMWlJbWUvQUF4cjhxb3pqWVFnZ09MZTJZdXFOSE0za2QvSVNDaDM3Z2RP?=
 =?utf-8?B?eW1IckY4Z0d3VUtYSTF6YkpmMnlLSnBOTzFxcXNKL0VsMUpQRkdSS0NvL2F2?=
 =?utf-8?B?WExKTEgzNE1hR3BIbU9wKzlaSnBxNno3bWRiZ2dleVIxNEVHcHZRRHZoQlZu?=
 =?utf-8?B?d2dPQlJWUWNNK1JhYUFSVVlZS3BOa3lsWWh5Y2tISWFQU09Yd25wQU11WGI1?=
 =?utf-8?B?STFBUmxlSUdqT3ZDMnV4Q2lBVDc0enlCWklKOG9YYUZyMHF1UTkyZWExNnpP?=
 =?utf-8?B?SWN4K0lOdVU5ZjJGdjVUdXY1LzRxbHV5NGpnMXVHQzNQMXdYU2hsRHhodlc0?=
 =?utf-8?B?U3g0a0FHVkMzYWd6Z3ZwaUxiYnJPb29TTzMzZVgxeGhDN3FVVktCclZwV0J4?=
 =?utf-8?B?dUkrL2l1aXA4SmJyT1laQUdYaUs0clZBVFRYQS9FaXZoY1NhU0lxWkJHUmZT?=
 =?utf-8?B?dVpZemltc3QzU2RkbEtFeWVSVlpleERxcWdTZ2FLTFJIeWZWdUtLdEQ0VSta?=
 =?utf-8?B?cGVSSWhiUG8ycVhsbks1MU9sR1IyaFNhakdSaEN0R05VRmFGUEtaMDlLNTBV?=
 =?utf-8?B?WG8wVDJDRTErMGlRZDhEdndkQUZxVUMyZnVtL2NQRkxVSm9EYTBUYStuWkZV?=
 =?utf-8?B?elkxNEMyQ0d3VFZZVjA1N2VEbFJWVmgyN0JkVVFBb1hPRmtDZE12WW85ZExp?=
 =?utf-8?B?U2hTeUI2U1BsOG9KTHZhbi9lKzd1bGs5N241U3VHSDkyaXltbW5OUC9EMVJH?=
 =?utf-8?B?bU9kK0RCaHlGL3drNE5VK2g5R3VjMjRwYjYybUNDQk5URlo3OFYwYjNQalRW?=
 =?utf-8?B?eDgxdHhHWmM5N2E5cmdrWU5sQlZ0bE5yeEVMaTVYYlpFM0RCSDJDUHo4Ukgy?=
 =?utf-8?B?bVRJMkkyS3dqd3BtU21EMnZLNGcybmxFMmtHZC8rK0R5OWYyeHhiRU9yZ2o0?=
 =?utf-8?B?OGZHQktJK2x0ZU80ZXlFRzhDMmJIOUdUeWJpNWhIdVRRaWI0YXo2RTVmdkt4?=
 =?utf-8?B?ZEE4TGhRdVJVaW1hczd0Qk9lR2hPSFE0S0x5L0s1bGRPME5BaWtWeGNWRWRI?=
 =?utf-8?B?NGlyeTFIb3dZUGMwQWRPOTJoQ0xhRHFPUWkzb0VnMVZpTzZ4dlQ2RTVEaTQr?=
 =?utf-8?B?OVR3c3dOUFJOb1p0b1l4UFoyTFRhZ3RWTkgya2NWc0JzWmt0TmVhb1R5RXp0?=
 =?utf-8?B?L1E5MjFWaC9NZ2R5bmNqZWcydWpKSExkc0QxenZ3eFJnYkpUNkl2bVFYRWRS?=
 =?utf-8?B?QlcwTFRnNWJaMTFaUWlqMUxFclEyZjcvUjNUSWMvUEJVSzNFZHo2T1BCMG1J?=
 =?utf-8?B?cjVNWi85QkoxdUR0ai9WcjNobEsycFNrZWZ5dzV0KzlBaEw0WGVVUnFMVzNT?=
 =?utf-8?B?ZlAyblluRThSN0M5bDVtRDhuRmg0cEN3UkFXdkVmVXhiWkZCalRZQmFjcDB6?=
 =?utf-8?B?WnQ1YitaRVJhc3BJclQ5Q2tVYk91OVlhOG0yNHp4UFBnaGcwZnF3MWhpV21i?=
 =?utf-8?Q?CXJPD7OSeRO/+YkGlbIT/AcA+3mIy3Y5AklSI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8554.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dk5mRStqY1Y5a2NpMDBBRkhUYUc0OUNJNHM4Mnp5SzV5dEYvMW9ndWp2N1p6?=
 =?utf-8?B?K00rcmZNTVF4Z1JSK1lJMWtJT004dTZVN1EvNkx6cXVCK0lHeUhlQk15c2tl?=
 =?utf-8?B?YzI4aGI3V0RVK3JrYmpFK0VrN0RlZ2hMWG8vWXdHem1lWkYzSmlOZTZKeGNl?=
 =?utf-8?B?WTVDZXVJbEFZeVVsSmhqTWIrdTdMVGowWG5ra0x2ODN2alhRNGthSHUrY2dT?=
 =?utf-8?B?Yk1BeVFCbXFyVzMwU0tPTy9qTEkzTEhkWVJhYmljMGhTK01QUlFmSER1cVNt?=
 =?utf-8?B?RjNYa21CbS8yVWFoWkxwZ09yNDV1L1NaN1hhOXh4WlZVSXFJN2ZJWXV2ZE1Y?=
 =?utf-8?B?NHhVZjBZclg0U0lyYmdVRHRrM0FKWTVVNnV3a2RGTzRsbFdsL1p5dWF3aFZi?=
 =?utf-8?B?MVpYMHI3akRpNzdQR0t2UURvcHpVUG45SHExYkpONk55KzByQzREbnUwOCtW?=
 =?utf-8?B?Z3dEcHIrd1c2OXpZQkRuSVdWcDhCVXdYeWlmdEFwWU9RUWtOTFdOdmo4RTVQ?=
 =?utf-8?B?RnFFcG8wYTh2YjltR2ZuUHBGSzN3K0YyRzYyUWpyTThEYXdrU0w0c01LWk1n?=
 =?utf-8?B?YXVIUXJNZWs5eG1MWEpkMU14UTFTZzhhcVJCR2d2cTZTdU00b2hIME9LeC9u?=
 =?utf-8?B?L3h0eDRTcHZxc0FwSDFORm80Nm1DWnZKbFFLbVdZUUhhUy84a09qaTN3NWoy?=
 =?utf-8?B?YXJHRjhGNGE4QkQ0YXhvZkVVaGpEaDRpN3pZQnhLYUNmaWc5RWlmSG1lSUt2?=
 =?utf-8?B?UVBzNkMzNHk4d1B1alM1dnN4YUdjUUF6U0RtbjlSQ08yVnVTbjhQNkZzdXBl?=
 =?utf-8?B?RUhVR203anVNakZPdDZ6NG5TYi9hWjVHRXBjUVJtanlXSCtnYnFZdkxCeUVn?=
 =?utf-8?B?SEs4SnNodWdsVkY3QlNRcS9BZWpQR3Z2WUNlblZyNjZEZFAxKys0Y0FWQVYz?=
 =?utf-8?B?T3QwNTl2ZWQxQVNNaU53MmxxMHNrQ2ZRbjlnWFhHc2p1RVh5NDBGd0lhTStH?=
 =?utf-8?B?YVQ5RGdLOVBMQitWWXpXdlVQS3JjNWFVajFJbU90djlGdWsxc3h5bE9YOE1G?=
 =?utf-8?B?aERvNWRpYUFsTzZrdWtGYjd3ajBORFlXSHNRZ1dtYjQ5blJIeXhlT3p5eGJD?=
 =?utf-8?B?amRTY2FUZmxWL1JBS0t2MEQvU250SXR1TWIyUkxEMUVXZlhZdE5JcWw5cGJP?=
 =?utf-8?B?a0xXUjA3Y3dmSHV0UjZWemxuai8xejIxSUJrY2tGVWRlV2hGb2piQjF2eTQ3?=
 =?utf-8?B?Q29xeENHdUVjUG1mdEpHQThyb0hwYVovREtkUDR1QXNUdXJKNmFSNjB6aTdI?=
 =?utf-8?B?WnJzY2xvYzhkYXloSGYwMHJyYlVnZGFNVWxxbGFzZGdUQ1V4QXYrd0l3alcx?=
 =?utf-8?B?b3FQY3g0eTlsYlJ4Qk1NZExoUElRNnRyUXpNS2YrVTRJeHBaN1N3S2pFcGVX?=
 =?utf-8?B?MjZ6QXh3MHh1d0c2RitGWHdJcHZFcVpUc05qRXpaVzJubEVLTUQyWXEzdUlv?=
 =?utf-8?B?dGM0YVNLVFpNY0J0NUN2OVo0cGpMR1BObGhCUzB0MXFDR0dUMUFhZzF3RDRm?=
 =?utf-8?B?MDduNHRmeldSMmRqQ1F2SWlidWQxNVVHWHlOOTVBQlZid0kxbEphZXc0amF3?=
 =?utf-8?B?U0F3dUduZEE4SDlEM0JDZTZGYldZbklPLzlTQXRwYk5Dd2xoUnorWWVLemVQ?=
 =?utf-8?B?UzNLeXV1cTZZdFR0UlREQ0IrUkhLRGpObHl4Z1oxellvZitLaFNCWDQxUXBX?=
 =?utf-8?B?SDhYSVlKWk82SVVXSlhyL3FNUGhQM2llOU9USGNYeVpiZXJYMDk5OElqWFAx?=
 =?utf-8?B?c1FxR1FrOURtNkhMeFQyUGFCdEpMTklwTStidnRQOVZnSDBpNTkrK3RtUkRJ?=
 =?utf-8?B?UHlXM3RraDZzU2NUMXVkQnAxbFgvRkcxUE1NdlV2cVJaVGtUbW9oRmtQRzho?=
 =?utf-8?B?T05rL09VOGkyYndhaUJ5eW5RcXk0VXUyb0liajNqb0VSZlVvY3E2bEtJZ3lV?=
 =?utf-8?B?QTloZEZBZ3I5RTQ3T3NKM0p6djlYVzdZNUZ5UDUxZG8xNnY1b3NvSXJzUXNz?=
 =?utf-8?B?djRRU2wzTFV4NlAxTVlPR3BwdDVSWUxWVWpNQmpZS2U4KytCQXVVMzFFdCs1?=
 =?utf-8?B?RUhDV2tsUFR1WlBjUkdEZEY2VTdzRHc5d2dHVnFRU1FBeEZxQ2pXZDFoNW9B?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAF386E984A83943BD989F3481841D34@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be980c0c-d919-481c-4f79-08dcbc055c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 02:03:58.7013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shSyayIXU4tSYp/Khjp8UC2uZZrHxdXJcg/EwMzUrDZAML2a3xYTjr31lWSy3px09P4L5zdXH3mB51DPReXUfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403

T24gVHVlLCAyMDI0LTA4LTEzIGF0IDA3OjE0IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAxMyBBdWcgMjAyNCAwMjo1ODoxMiArMDAwMCBKaWFuYm8gTGl1IHdyb3RlOg0K
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqByY3VfcmVhZF9sb2NrKCk7DQo+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoGJvbmQgPSBuZXRkZXZfcHJpdihib25kX2Rldik7DQo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoHNsYXZlID0gcmN1X2RlcmVmZXJlbmNlKGJvbmQtPmN1cnJfYWN0aXZlX3NsYXZlKTsNCj4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgcmVhbF9kZXYgPSBzbGF2ZSA/IHNsYXZlLT5kZXYgOiBOVUxM
Ow0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqByY3VfcmVhZF91bmxvY2soKTvCoCANCj4gPiA+IA0K
PiA+ID4gV2hhdCdzIGhvbGRpbmcgb250byByZWFsX2RldiBvbmNlIHlvdSBkcm9wIHRoZSByY3Ug
bG9jayBoZXJlP8KgIA0KPiA+IA0KPiA+IEkgdGhpbmsgaXQgc2hvdWxkIGJlIHhmcm0gc3RhdGUg
KGFuZCBib25kIGRldmljZSkuDQo+IA0KPiBQbGVhc2UgZXhwbGFpbiBpdCBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UgaW4gbW9yZSBjZXJ0YWluIHRlcm1zLg0KDQpTb3JyeSwgSSBkb24ndCB1bmRlcnN0
YW5kLiBUaGUgcmVhbF9kZXYgaXMgc2F2ZWQgaW4geHMtPnhzby5yZWFsX2RldiwNCmFuZCBhbHNv
IGJvbmQncyBzbGF2ZS4gSXQncyBzdHJhaWdodGZvcndhcmQuIFdoYXQgZWxzZSBkbyBJIG5lZWQg
dG8NCmV4cGxhaW4/DQoNClRoYW5rcyENCkppYW5ibw0K

