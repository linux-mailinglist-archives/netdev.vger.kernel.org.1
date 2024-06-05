Return-Path: <netdev+bounces-101062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D298FD158
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219D61C20F20
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ECD3A8C0;
	Wed,  5 Jun 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EWLYKKo2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839EF27701
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599865; cv=fail; b=HhT/u61Mm6e/NmL/dF8YrxYelUFZ0G7gBCFQoIZ3CHSAITCWCyH5oqrM1gxcTlHRLSX3IbZhyUiRBcAD2sXdUg9j/fUY3XXbZmTNDkM+Vef/htKIaYlo4Anm4O+OKDaejKNX5BpSK6nAO5/567whm+eegMiwq3qsKQ22UjyzM+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599865; c=relaxed/simple;
	bh=LQKtfokTyLyca9Jr03/w6AhEx4EEq7PoFa89MzbdLxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sU3A0rZZq+H9AaAg6fzNNGPUIMCrDcKeCiIupURHW4+w99aq6utWjcUg9TY5DwnNahaQ8ewrYAmXJrbb1VqgE9wpfwotFYq+osBybvhN/tidBqGmv7feyoHpeqpmu6NqhrFv8E+bPEAIC9A5DZRgKn3KxNIQ6FZ8+qrkMOiMFL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EWLYKKo2; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ0AutBRPdOKiWPBqyytNIutfhQaE/QOxOa7FH3xlw9Qurc1BtyFdqrWYMhU3HlSmWSixKw6VkRrSE7Luu2I2d+Ql8rhhIMo2NNTTidhQiS1FgJniee18NRPuzSulf44a/LId87BkKqqM1cQZ5EcDtM09KbYAvAOZsN8nv0PfdBYBpnHrmB33A98P4c35xXaeG0ELz3Sm0GV8JOtMtXllkJxOJc/RZ2+OlB105NXRxf42Ud6YBhgzIaQ62vrSFyLZkesSbiQCL+0SxN+GdBmj92Hhgpr4wqt1upIu8lUcGSgagdEDMeP0P+HDNU6Aa2bZgF//dVbXXmRDdgxs8nJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQKtfokTyLyca9Jr03/w6AhEx4EEq7PoFa89MzbdLxM=;
 b=cUUB2e5vB2p/NEyAJRVOp5WcbVR8fBTiVW0Mcrw/r8WeKee9/t9jZL1k/pbSWBZ1R6eV8sBGRb8hiCnsi4bXkEEt6WKMVEpiYkSiiK4/FbnvrlnsbS2A/HXmkkZBe5oObmXjXpgacoyQe5P8m95eohYnPcuta1deCBPEkUET6iOKrkNZGVRX7PJ8B47Y3LkTgzU1mmhsbhfk44icNEc1Wkkd4Doj33eOIf1gNg7gl536EPfbMOGSNT8CQPZYczS9wRFnEeuQdLag+GAltKFFbGNNNR3sFvmLTPi8Mnm+Z2VBYsMBKjcK37n3Ho3oaDqS3fhdIW6JBUN2AuYBKdn2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQKtfokTyLyca9Jr03/w6AhEx4EEq7PoFa89MzbdLxM=;
 b=EWLYKKo2roj1fX+yVSEVHbzTT/qExLCRTjM++X/igm50qlwQKtNgelwISJ6zsA1ABL+kGGgLu9Mk6w3GID9XyPi2jLWnv5oRAEnh7fJZ13twSn4t8HiJ9a1cgv+TjJufu/OBEWgfRhlZ2paZ1Oqc4ELgfsbr/pONXO1iivZ2uPqfbWyOl025ycUtQiAtDndMyxLl1MoOwcGu38Mb7nagbTrSxrvk4jgV32kQA7qTRkAwINHnzVVxq/igWVcJV2YFdTGkAPpvWAnVTK6aiyjcYzZIufeZAio/PempDgB/nH96Uwj7YxeXcOxr4e3ZOY2Tlwdbd00nHbjywclm9mHdwg==
Received: from PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Wed, 5 Jun
 2024 15:04:18 +0000
Received: from PH8PR12MB6843.namprd12.prod.outlook.com
 ([fe80::5958:e64b:fe79:d386]) by PH8PR12MB6843.namprd12.prod.outlook.com
 ([fe80::5958:e64b:fe79:d386%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 15:04:18 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>
CC: "jhs@mojatatu.com" <jhs@mojatatu.com>, "sridhar.samudrala@intel.com"
	<sridhar.samudrala@intel.com>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "madhu.chittim@intel.com"
	<madhu.chittim@intel.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>, "sgoutham@marvell.com"
	<sgoutham@marvell.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Thread-Topic: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Thread-Index: AQHaoYVXQr0ZEh7smUGzOF/0ek52q7G5cDcA
Date: Wed, 5 Jun 2024 15:04:18 +0000
Message-ID: <abe35bb09ff1449eafaa6b78a1bce2110dee52e7.camel@nvidia.com>
References:
 <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
In-Reply-To:
 <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6843:EE_|MN0PR12MB5764:EE_
x-ms-office365-filtering-correlation-id: efdc6d83-d05e-47ea-d134-08dc8570c5ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkdYT3BJTVFsNmZibGIyWWUrVkY2eXJFQmM1eTVYSGw0eWhJK1E3ZkRBTkVo?=
 =?utf-8?B?M0VYYVl6OEZ1bTY5dmk4WmNTR05ZbFNENVZVWDE0TzkxYXk0LysxNFdxb0NN?=
 =?utf-8?B?d3BDNEh0TWNicktBUnkwZklWd2ZheGdvaVBmbVprL2xqVEFLVmhHTEJ5UkYx?=
 =?utf-8?B?S2lwMkZnZWgzLzR2K0dKZkxOdy9GS2pIcGxTV3pYSGpsVElGc2w3UmJBMDBW?=
 =?utf-8?B?bWIyZUIzWXdEUEM5eitCNUVnSEsxdWR4clFoSmM4bHh4ZjRMMjlaZXhVNEIz?=
 =?utf-8?B?S3RFV2k5NVNiMVJURzA2KzNkN09SbitaTm9TcXdDYjJuTytmUXVtckcvR015?=
 =?utf-8?B?RktzZzNMOWhta0RHQWs3UjZZUmIxcjloRFlvWXFrYzZQMFJIcmxzWmVXOUJE?=
 =?utf-8?B?OGtwNTZ6YlBpcVRDZFNzZ0VoRmdBaU45K0NqUzJLdnFVbXRJV0l6dHRXZU5v?=
 =?utf-8?B?K2IxdUxncWNwWnVDL2l1TFZ5dHRTKzFVckt2ZHRJUCtsUy84YkE5OXJnYWdt?=
 =?utf-8?B?cDNxQmhXUXMwUDdQSFVDVzQxWWtRQ2NLdzdBT0t0MjFRYWRuT2dkTXpmUmJr?=
 =?utf-8?B?WWdmQWJVbjhaZkJ6MmozQTFiVmpjMU5qTHREUFQ0aE00aUxzTFpCc0NvTDls?=
 =?utf-8?B?S0haTm9QMlhGZnQyNjE0RzRHT1llSWFzeWZMOGRlOVdoSjZYNjV4ek1vRHlk?=
 =?utf-8?B?TER4QzBrcEJQR0JiV1NIUDN4VHpBTmxuU3FSdW9xRHpnNE1JVVVRV1E0bTdu?=
 =?utf-8?B?QWFQaTFnUmljZ3JJTllyV3hpM3BGSDZaREVmVml6Tnpqek5GTy9ISVNvbVNq?=
 =?utf-8?B?akVDanRlcmp2bG5UcUlnWGM0c002TDQyQUVGUmd3MjdrNFpYNU5hdnNxYjlD?=
 =?utf-8?B?RytkdGRsTGtSNlpGWjkrbDZXU0kxcDlic2JVS3BBTlErejZOM0dQYmUzYnBa?=
 =?utf-8?B?K2R5UVBqWnN0b2VmNFJuQzUvdjZMTlR0QWFqaFdWd2N3SHg0Rkp4VUlLb3VI?=
 =?utf-8?B?ckdEUmhCVTNNMld3ZnczaHVBSTRuRFZPREVnQUVEZUNZVytMdEd1eUptbDN0?=
 =?utf-8?B?bnVFWDg2bTJYdnQzbnZmYk16VzJ5TENGSVQ3VnhXdWdFaUhRMG1HdDR1WHVi?=
 =?utf-8?B?a1R0V0YxbU1DUHg1alJuNXh5ejFtSENxbWYxWjdiY2FrS1E2KzBPZ0dzOEZk?=
 =?utf-8?B?MEVUdDZhQm1ldmJKWHRFS0ZYdkxmalAvUzA3akMwYzZXOHB6TitkYmI1ZmNR?=
 =?utf-8?B?bEpyOStqNnpOSEtGd3prSnY0N0VBRUdWczRvVDhRY2hIcVV2QVd0a3VINzNy?=
 =?utf-8?B?cXA5UHNLOTQvd0FwcE5rRTV4SXdZVUVGUEpwZ2tnN3ZYeUxzOHI4eEpZVVlG?=
 =?utf-8?B?NDNvM1VkUm5SWmNCa3VxUW1LZWI2RzMzdm5jS1loKzYrWGtnVVVHeG5uQXJU?=
 =?utf-8?B?Y0thM3E2TmpzMFhYRVBZQmpaemZVTkpXc3VmZXBqU2VKRGRzUGJKQmtKVjBu?=
 =?utf-8?B?OUZJWmZmTHlOK1ZRK1R1WlZhRHpPRmdod01ESUpDWHRGd01ieFE3TVl2bkhT?=
 =?utf-8?B?MUpXcWR1dFcyaUVZQ1cwd0FYdHZ3T2p2ZERVZExoZHMxTWh4TjNWeFpGZmJ4?=
 =?utf-8?B?OW5teHVqVW9aTCtLMWsyREFpaExDdW9WTlpaNFE2bWF1eDBWcW5FT0FDUHN1?=
 =?utf-8?B?eFlEbCtDNkhaSWh2c3lWS2ZaRlNTbjhOYmxkK0ZEcUZMTkd1ZVNKSGlpY3JW?=
 =?utf-8?B?c1B1dGo1Y3ByK3pFZGc4WkV3SVBwYWE3ekpLcktBeUl6WDBDakh5V3d2dHVN?=
 =?utf-8?Q?H8/NM9TTC2nomOyIjNpNJ1waYsDftXYSnbUXU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THhwdmZSMDV3N3UwUlFmTHliUUNQdTM4UlpxRnlLSk9VbVNlL0F4eFVSRjNa?=
 =?utf-8?B?UHd6NC83RmFSeklmdDFGQzdaMktkZG9IVzBZcUEwRzFYUWpZNVdVN0ZuNVkr?=
 =?utf-8?B?NU5pZ2VlNXhqaEtMbEhFTW5lWHZ6QXVaTGxXR1IwbnhETndVYnJZYnFWSU1j?=
 =?utf-8?B?VzMzaW5XcmdHcVBiNmdZcnNhVnREdHV6WTNxTi96VU8xL3VYSFA5cVh6VDJN?=
 =?utf-8?B?V2cyaFEzT2VsWk9xVkNjQmtPU2x5QUk0WGFnN2VQKzVvNVJyM1RZRkd1Z3Rm?=
 =?utf-8?B?K0hmWjVwMWE3Wkxnd0ZEVXc5VmNOS3VsQlNkSW1NbERFQ1Bqc05MK29qYU1w?=
 =?utf-8?B?Qm9ISjR6a3VJV21tRGFvVTM1Nk9La0NBanl3dW9zYnpUWXRCTktVOXpteEly?=
 =?utf-8?B?WDI5YTRsb3ZvU3NKcHFCT3ViL001TFBsd3RrYXVnaktEbTRUUUh5cmNYeDYw?=
 =?utf-8?B?aTBvYlJWaXhkZksvb2hiSmlSOGM5NWRpZ3krajNVSmIwaXVrUUVrVXhMSFJh?=
 =?utf-8?B?MlptLzdUMDB4KzV3ZjErUHhnVThZdTFCT1JFRnVWV1k4dDA4ZllIZExhYTVR?=
 =?utf-8?B?UGNIQW8rdXhlajMzNXlqMTdZMzZsQ3pNRWNjMkxzdHdRdis3UVNrLzFabVQx?=
 =?utf-8?B?dzZUSCtEa1hXMDVOM2VocHRLaGkzVG9FQXphMnBKcERPZnQxTXM5RU9kS05u?=
 =?utf-8?B?bnlieGovZmx2VjNubmNQWjhiNFN6SGRFVUlnOHpGdWVCM29sTEdTRnR0K3VN?=
 =?utf-8?B?WS8zUkhCbzZxdm9VdEY2NGVFZnZzQVovUXljZjVUTHZnY05TSFVCaTkveFMy?=
 =?utf-8?B?TEYyMGdhODRUK2NsQldlN29QRW1jcy9rak94MHhCUktNdzE0K2lNejhLWFd3?=
 =?utf-8?B?dVZoTkxsamxFZGFtaXY1MVJIdW1CNkl3K1J3andBR1U2eWNucTdCV2J6V1ZV?=
 =?utf-8?B?TEgzbTYwd2ZsWit5MFVUaHlxVE5rOVBxd0NoZmNQQ00vU3VpNTRpMWY2OHg3?=
 =?utf-8?B?cTFCWFJrYVB6Y1YyUDlNWEQrRDNOR0thb3FRRndYQStHTTZRZHJxck5VbnBq?=
 =?utf-8?B?am1Vc29JUkZneE94MGRtY0JBNTN4L1pEMFQyRFdteEN1NjIyUHdDSEgyVWg1?=
 =?utf-8?B?cDBtMUY1d21YblJEenN0dmNuQ01pTHBGUExFUU82emR0aGFHYmxzMGZxZ3c3?=
 =?utf-8?B?M2hwUTRHVGRzb3RmSGh6WDRxTHJwYXZGYThDRGxPa1FsWEhTdkpET1luRW42?=
 =?utf-8?B?RzVDYjFKK05tRXI0dTJOQWZYNFhKOXBMSy8vaG5ZWXZrRnhFUGZ4a2QySTBH?=
 =?utf-8?B?b2N2cHBzNzdPc0NCdC9haDBHT25PSCt4NEx5cnlreEZ4WlJoT0NvbjhkN0pq?=
 =?utf-8?B?RURhWmRpTStiQUl6bzdLaDlOeHhXbWQ2N0g4U1ZnUlYzVElqWVlGaW04Q0pM?=
 =?utf-8?B?UlhnOUVScWlDOWsyVHJaS1k2OHpPWUdFVzI4TWpURUhOaG9BcEx4U2tTWkZZ?=
 =?utf-8?B?eE9heHArN0l3bXJpNEZEVHV6RVFURTVpVFRQQVhDb1gzWDlnRVppV2E5Qmxy?=
 =?utf-8?B?SkJFZktlcnBNeWd3WVpacXpCUHlMclhQdk1qV25iaVBPUEtyaEx3aDJwRkdH?=
 =?utf-8?B?a0ljT2VKd2toSkxHSzFFVnZucjZvR25yQjRBbGJaRmg1L3ZVK3c5TnVZUU9O?=
 =?utf-8?B?OHZkanhsRFR0bXZEaW9rWkRsY1FHVnRObFZJY3duaVlNcGhHNzUrNUNUTzZV?=
 =?utf-8?B?bnE3UHBFUFRUajRJQmxVN0dKL2VsNWR2blgySVd1YXBhZmJRQ2k3K3RYTFdl?=
 =?utf-8?B?VnJsaWtSblk2eTROOGw2NEd3VEMxenprdnozcVk4TE5GenFNdTk2dHZSWjhn?=
 =?utf-8?B?ME03ZERXK05Wc091QlhRN2FwV1BiSy9XWHNWb2VCK1BvWkNrZ1k2bDJOL01z?=
 =?utf-8?B?TkxuOW9JNjI3WDJzWmNqVFhscEhuQ3ZUZDhmR3d4dFJGVlMxMWU0NUMwa21r?=
 =?utf-8?B?YW5sR2ZmbnpNVElnWkR6OUZ1dmVnbjA1YW03aHBXYUU4a3IwZnFRSFdQSm5R?=
 =?utf-8?B?dVhNMnYzcmJGN3F2eGUxV3dhc01TOFY1QW1aa200RjRhT3VzWmYrTGZFTjVM?=
 =?utf-8?Q?qpfdAw4mxclLBpQyW7bJtCvak?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F633E6E8AF151B4EADDBA62F75FF97CE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdc6d83-d05e-47ea-d134-08dc8570c5ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 15:04:18.2810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDQ83OknjxBtPkoytT1Fv6ZSP+9L2YS84vatGdKq0Qs6EnCItsJKQpQCwP7EoxOeekN43zFJzD06sUo1G4F+UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764

T24gV2VkLCAyMDI0LTA1LTA4IGF0IDIyOjIwICswMjAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCg0K
PiArLyoqDQo+ICsgKiBzdHJ1Y3QgbmV0X3NoYXBlcl9pbmZvIC0gcmVwcmVzZW50cyBhIHNoYXBp
bmcgbm9kZSBvbiB0aGUgTklDIEgvVw0KPiArICogQG1ldHJpYzogU3BlY2lmeSBpZiB0aGUgYncg
bGltaXRzIHJlZmVycyB0byBQUFMgb3IgQlBTDQo+ICsgKiBAYndfbWluOiBNaW5pbXVtIGd1YXJh
bnRlZWQgcmF0ZSBmb3IgdGhpcyBzaGFwZXINCj4gKyAqIEBid19tYXg6IE1heGltdW0gcGVhayBi
dyBhbGxvd2VkIGZvciB0aGlzIHNoYXBlcg0KPiArICogQGJ1cnN0OiBNYXhpbXVtIGJ1cnN0IGZv
ciB0aGUgcGVlayByYXRlIG9mIHRoaXMgc2hhcGVyDQo+ICsgKiBAcHJpb3JpdHk6IFNjaGVkdWxp
bmcgcHJpb3JpdHkgZm9yIHRoaXMgc2hhcGVyDQo+ICsgKiBAd2VpZ2h0OiBTY2hlZHVsaW5nIHdl
aWdodCBmb3IgdGhpcyBzaGFwZXINCj4gKyAqLw0KPiArc3RydWN0IG5ldF9zaGFwZXJfaW5mbyB7
DQo+ICsJZW51bSBuZXRfc2hhcGVyX21ldHJpYyBtZXRyaWM7DQo+ICsJdTY0IGJ3X21pbjsJLyog
bWluaW11bSBndWFyYW50ZWVkIGJhbmR3aWR0aCwgYWNjb3JkaW5nIHRvIG1ldHJpYyAqLw0KPiAr
CXU2NCBid19tYXg7CS8qIG1heGltdW0gYWxsb3dlZCBiYW5kd2lkdGggKi8NCj4gKwl1MzIgYnVy
c3Q7CS8qIG1heGltdW0gYnVyc3QgaW4gYnl0ZXMgZm9yIGJ3X21heCAqLw0KDQonYnVyc3QnIHJl
YWxseSBzaG91bGQgYmUgdTY0IGlmIGl0IGNhbiBkZWFsIHdpdGggYnl0ZXMuIEluIGEgNDAwR2Jw
cw0KbGluaywgdTMyIHJlYWxseSBpcyBwZWFudXRzLg0KDQo+ICsvKioNCj4gKyAqIGVudW0gbmV0
X3NoYXBlcl9zY29wZSAtIHRoZSBkaWZmZXJlbnQgc2NvcGVzIHdoZXJlIGEgc2hhcGVyIGNvdWxk
IGJlIGF0dGFjaGVkDQo+ICsgKiBATkVUX1NIQVBFUl9TQ09QRV9QT1JUOiAgIFRoZSByb290IHNo
YXBlciBmb3IgdGhlIHdob2xlIEgvVy4NCj4gKyAqIEBORVRfU0hBUEVSX1NDT1BFX05FVERFVjog
VGhlIG1haW4gc2hhcGVyIGZvciB0aGUgZ2l2ZW4gbmV0d29yayBkZXZpY2UuDQo+ICsgKiBATkVU
X1NIQVBFUl9TQ09QRV9WRjogICAgIFRoZSBzaGFwZXIgaXMgYXR0YWNoZWQgdG8gdGhlIGdpdmVu
IHZpcnR1YWwNCj4gKyAqIGZ1bmN0aW9uLg0KPiArICogQE5FVF9TSEFQRVJfU0NPUEVfUVVFVUVf
R1JPVVA6IFRoZSBzaGFwZXIgZ3JvdXBzIG11bHRpcGxlIHF1ZXVlcyB1bmRlciB0aGUNCj4gKyAq
IHNhbWUgZGV2aWNlLg0KPiArICogQE5FVF9TSEFQRVJfU0NPUEVfUVVFVUU6ICBUaGUgc2hhcGVy
IGlzIGF0dGFjaGVkIHRvIHRoZSBnaXZlbiBkZXZpY2UgcXVldWUuDQo+ICsgKg0KPiArICogTkVU
X1NIQVBFUl9TQ09QRV9QT1JUIGFuZCBORVRfU0hBUEVSX1NDT1BFX1ZGIGFyZSBvbmx5IGF2YWls
YWJsZSBvbg0KPiArICogUEYgZGV2aWNlcywgdXN1YWxseSBpbnNpZGUgdGhlIGhvc3QvaHlwZXJ2
aXNvci4NCj4gKyAqIE5FVF9TSEFQRVJfU0NPUEVfTkVUREVWLCBORVRfU0hBUEVSX1NDT1BFX1FV
RVVFX0dST1VQIGFuZA0KPiArICogTkVUX1NIQVBFUl9TQ09QRV9RVUVVRSBhcmUgYXZhaWxhYmxl
IG9uIGJvdGggUEZzIGFuZCBWRnMgZGV2aWNlcy4NCj4gKyAqLw0KPiArZW51bSBuZXRfc2hhcGVy
X3Njb3BlIHsNCj4gKwlORVRfU0hBUEVSX1NDT1BFX1BPUlQsDQo+ICsJTkVUX1NIQVBFUl9TQ09Q
RV9ORVRERVYsDQo+ICsJTkVUX1NIQVBFUl9TQ09QRV9WRiwNCj4gKwlORVRfU0hBUEVSX1NDT1BF
X1FVRVVFX0dST1VQLA0KPiArCU5FVF9TSEFQRVJfU0NPUEVfUVVFVUUsDQo+ICt9Ow0KDQpIb3cg
d291bGQgbW9kZWxsaW5nIGdyb3VwcyBvZiBWRnMgKGFzIGltcGxlbWVudGVkIGluIFsxXSkgbG9v
ayBsaWtlDQp3aXRoIHRoaXMgcHJvcG9zYWw/DQpJIGNvdWxkIGltYWdpbmUgYSBORVRfU0hBUEVS
X1NDT1BFX1ZGX0dST1VQIHNjb3BlLCB3aXRoIGEgc2hhcmVkIHNoYXBlcg0KYWNyb3NzIG11bHRp
cGxlIFZGcy4gSG93IHdvdWxkIG1hbmFnaW5nIG1lbWJlcnNoaXAgb2YgVkZzIGluIGEgZ3JvdXAN
Cmxvb2sgbGlrZT8gV2lsbCB0aGUgZGV2bGluayBBUEkgY29udGludWUgdG8gYmUgdXNlZCBmb3Ig
dGhhdD8gT3Igd2lsbA0Kc29tZXRoaW5nIGVsc2UgYmUgaW50cm9kdWNlZD8NCg0KTG9va2luZyBh
IGJpdCBpbnRvIHRoZSBmdXR1cmUgbm93Li4uDQpJIGFtIG5vd2FkYXlzIHRoaW5raW5nIGFib3V0
IGV4dGVuZGluZyB0aGUgbWx4NSBWRiBncm91cCByYXRlIGxpbWl0DQpmZWF0dXJlIHRvIHN1cHBv
cnQgVkZzIGZyb20gbXVsdGlwbGUgUEZzIGZyb20gdGhlIHNhbWUgTklDICh0aGUNCmhhcmR3YXJl
IGNhbiBiZSBjb25maWd1cmVkIHRvIHVzZSBhIHNoYXJlZCBzaGFwZXIgYWNyb3NzIG11bHRpcGxl
DQpwb3J0cyksIGhvdyBjb3VsZCB0aGF0IGZlYXR1cmUgYmUgcmVwcmVzZW50ZWQgaW4gdGhpcyBB
UEksIGdpdmVuIHRoYXQNCm9wcyByZWxhdGUgdG8gYSBuZXRkZXZpY2U/IFdoaWNoIG5ldGRldmlj
ZSBzaG91bGQgYmUgdXNlZCBmb3IgdGhpcw0Kc2NlbmFyaW8/DQpJbiB0aGF0IHdvcmxkLCB0aGVy
ZSB3b3VsZCBiZSBtdWx0aXBsZSAncm9vdCctbGV2ZWwgbm9kZXMgaW4gdGhpcw0KaGllcmFyY2h5
LCBlYWNoIGNvcnJlc3BvbmRpbmcgdG8gYSBncm91cCBvZiBWRnMgZnJvbSBwb3RlbnRpYWxseQ0K
bXVsdGlwbGUgUEZzLg0KDQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8xNjIy
NjM2MjUxLTI5ODkyLTEtZ2l0LXNlbmQtZW1haWwtZGxpbmtpbkBudmlkaWEuY29tL1QvI3UNCg0K
Q29zbWluLg0K

