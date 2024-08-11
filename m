Return-Path: <netdev+bounces-117459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0B594E07B
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 10:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68871F21544
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56331CAAC;
	Sun, 11 Aug 2024 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hGwo0P9R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFD61C2A3
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723364551; cv=fail; b=LEJApi8LIBQPUX3VDRGU5hwPyyl4L+EZxVH5zwyrutO1tHi6umqkTLuSaWKfv1VpSGaLKLJk6C4fCgcjeDkgda8H7QWQoLiYxBDxC1KaDN+zYUnD25viEzU+rHDMwVDsMfor7KA9icD1JiLLsB6GP9rCjr9fyHrOQ5WttC5XYxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723364551; c=relaxed/simple;
	bh=WipV/as1cJ4yimBy0G9EMcg7AYJtQHdieAPjfU16gM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ulUc1BYvzAvuC8ONGbRRlsa+3uNKexIOKy4OQveWgKV275AGyj8d0D2lB7TdD0BnpbVOLUjb5NYrWaeZ9p7Xhq7EJtPglkm65uPk772PLTMPMyP4b6X9MLtKNAhaBAz/eODhBHw+EfvebJrEv7c6zePgIuLN6nYDFjUkmc1QMQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hGwo0P9R; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob593jZ5At4BM4zoZS/2clmPJDwYrCOphFaDxn4OWFE1cvspL/Xmc9Yk1PJQapK7plpPASrXSfq7wv4tnn3QLKXRYUIMc9k+nlqqt2WIP7kXFmed2RHyfoy0EmBpHZR8pglx6f8PySa02+b1VgM5nu3XW9xYcDGW+KPIdJhti7zIF1w5x81rZyCT5LfQsm1lbQoe3+K1a9Mu+o7OmM81Yej2DHJFZBOyF2aeE/oVqOWLhsdlq/oo6cWNFdRwUE5PLyCc4qFNgPkV6MOlV16ivo7peV4H60Uldvc01BZY8DBVhCiN3dOqQE4QwzJgaYIL4BwgKLK+ZSDoPDc8uRoDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WipV/as1cJ4yimBy0G9EMcg7AYJtQHdieAPjfU16gM0=;
 b=FAsgXtbwwccF/+jgUCXS6H5sgtT2Y7fcdM1YSQQAd/KLYEmvKKrdwX9m++3icygXdv21s0GInYq7grBM5QFlEd71MUigpjhFC0rDbdoL1iTG8cDLJlht0+C4c8kQJpIoqjB1QDNaKAvDlSfGMyNcONtGWIuYLfuR0LybOP+G7q9pSKLLHkaIs3mJ2hOAR5pqFzekOfad4xqGA3TytKZSmMMSjJ9iztm8yZu+ZSdBzFbFP4iJFXWUwZQ9QhH5qNCzsmd9T6QJU27MsPuqMj3+YGFExTr0h7Vw2h+bvyKvOIysoy98OT04fVQpIBUEinj6Jt/0jU+8Xh3O3EqJv0qVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WipV/as1cJ4yimBy0G9EMcg7AYJtQHdieAPjfU16gM0=;
 b=hGwo0P9RZXNtfk+arMD7tHeXsCIFK1lqOtwJMtT2h1UcCYWcER0pHG8qkyOrHQr0aurjYJxgtJpGFpTY6MxRBCiroPkRNOCyyToBteyR3dG4lcKLM1cKYlqeAatj4o1pUrr2Q+wQQM+DIeUALRvlc4kuq9EzWdVlmffBDUh5zSe3aG0tLFrjZgMP6oiZS6RFJBwJSnkD70SEvhRbCz+fdpRqxOgsYkNoz6SLldXWZV00EZppvYZDMzcBONPd/zLetBcDowmOGQDK93XIg8aUcRXUyqtmqTl8WnmiS8zdU9B3b1giGoTqBz9zjJ7NhCSWL0/DXOWw6+cMYojm+mvgiQ==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Sun, 11 Aug
 2024 08:22:26 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%5]) with mapi id 15.20.7849.018; Sun, 11 Aug 2024
 08:22:25 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Michal Kubecek <mkubecek@suse.cz>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>
Subject: RE: [PATCH ethtool-next 0/4] Add ability to flash modules' firmware
Thread-Topic: [PATCH ethtool-next 0/4] Add ability to flash modules' firmware
Thread-Index: AQHa14G1FB+igyUZzk2DVN9+CsaMkLIfspcAgAIs1jA=
Date: Sun, 11 Aug 2024 08:22:25 +0000
Message-ID:
 <DM6PR12MB45166C24CE3A2DBB97EF355AD8842@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240716131112.2634572-1-danieller@nvidia.com>
 <tlni4jwvaznasghpjnhuy5zgq67f2bwisqopl2axda6mc6d77f@6uc7wbzm2djg>
In-Reply-To: <tlni4jwvaznasghpjnhuy5zgq67f2bwisqopl2axda6mc6d77f@6uc7wbzm2djg>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|IA1PR12MB6282:EE_
x-ms-office365-filtering-correlation-id: b8528154-2efb-47d6-e231-08dcb9debb70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXFiODRqUnB1dTYrSzRMaUFLRU5ibjJYRWlSeXVEQkJSaFhlc1pHdTRuaGdl?=
 =?utf-8?B?a1A0ZnR1L2l6ejd5ZUtLbEFiMXVtcTFneldXU1V0bExPeFhsanpVaGhONVI4?=
 =?utf-8?B?UWp1THI2Z0F0ZUVLdTdLbG1KWDlMWThwSytsMHZ3WUNXaGZQRFMvMGxzdmdr?=
 =?utf-8?B?MU5kZkVMakp0WWl2aWo0dlh4QUlLbFZ1bGNRbGU5VmczcDVSK2t0N0RGMzFI?=
 =?utf-8?B?MUgzMVlaWEtIanR2VGtFOVdyZ0hhK041aW4xSVlCL0hVTzhrSjBvUStPLzNx?=
 =?utf-8?B?bzNZTEoxcGhFU01YdWFvU21pMFJSanpBSVpzQ1VKaTgwZGlXNnZsUTYwV050?=
 =?utf-8?B?eE9WcGlnL1g1Sktybjd0WVVhV2RJSDJGbDhCMTFlVkFqTGlrYzJuTFNTSnJl?=
 =?utf-8?B?d0FnQXZKaU11MC8xazhCMlF2VTZzNngzcXF5RTYxYkJKUTNFWkIwamUxb1k5?=
 =?utf-8?B?TzFIQ2xOUnN5RlMxZkpqdjFIaWlMQWVPbFp1L21RL2wwUjJGczRMUm1FU3Bn?=
 =?utf-8?B?L0p6eHk5QjcrM1JKVjVmNE5KYmFjK1I4TkVaY3UrV2FTWEFzM2RHTnhzVm9T?=
 =?utf-8?B?SnJSNExFV1ZEWFpIanN5Vld1Z0RoV0tiaTlaMHVVUmZmTXBIa3ExdDUxU29l?=
 =?utf-8?B?UXVJMGtrL3YzUVJFRWNPQTFPaVZDQ05BUkk0NXcyZlpWNVdYYlUyQjB4ZlhJ?=
 =?utf-8?B?MzRKeERzNmRiY1lYczNYYmU3Vko3QkJGdEwzN3FqM3V5ckNRTUFtR1ZxK0t3?=
 =?utf-8?B?YnZoeGJxTDd4R2lWdVZoYkpHZkZuOTdXQlFsUzJRdUg3WVg0SkM3ZkM5MUZv?=
 =?utf-8?B?NGZUQjg5MFBwOGJUVmJxN1JrVENzNWFPcVZxcXdRVmhaRWtwVk8xRjRRN1B4?=
 =?utf-8?B?bk9UWTZsb0ZzaTNDdjkveXhITmV5dmZGU01leDZub0NySFJhRXFoNGlXcWww?=
 =?utf-8?B?aWZJdnVkTUk2KzMwcm5WSXQvd3lrMXFHUUh5dVFVV2R0d1dzemExV2FzNTVx?=
 =?utf-8?B?dTQ0UTQ0SlpHU1dBMzAwUTZzWTFTK0haSVJjemMzc0lOd1pkY0xLd3BESk0z?=
 =?utf-8?B?eVBpMGJMUEIwNVk2ZG1YMXdpcVhFMmdqRDFDYXlKcUJoNzFDditUNCszRjlM?=
 =?utf-8?B?VUFMUkRIQ1NCaUNaMllPdnhPOGVrV09GR0JRVXVSQ0QzSWhzZS9pakM5M3FI?=
 =?utf-8?B?azhUUmRZdUE1MGlNcTZ5SW5PMDY1LzRoR1AxeDl6LzNUUjVUV0VQQXkvZTBM?=
 =?utf-8?B?V3I5ZTBXS28rcERRY2ZJRktHc1JFcnMwS2pjREJpdXJ4NWEwd28rVmJ6cW42?=
 =?utf-8?B?RlZKL0lRZG9TOEFyK25mYURkcGJKZ3hVN1VtREhFK21kcVNsV1NpK2xudjJG?=
 =?utf-8?B?STFqRWZzVCtKVjVMWDY0ZjVRTExLdUJta1dCMHJxb2VFNVF3Z0RrcytKTmNW?=
 =?utf-8?B?dGRITkx5R0tqY2swTnJWME5RODJiQTZNZVZyR29BWHZKUFdkM3VielZUc0Q1?=
 =?utf-8?B?Vm1FdGhCV0pBMVhjeGNYcUI3ZjNkTEZUMHhGRHZVOUgzOUVKM01vT2RWZzJx?=
 =?utf-8?B?czhUMldySE1lb05pYXE0TGZxelJDQnVVbmtsKzZhR2FEWnVaSXBzdkt2a254?=
 =?utf-8?B?ZGRPYU1DRG00OWwrbklTMWFWME05ODdzTnd3RzdiRFVQVlNQRVBJL3dxSW9v?=
 =?utf-8?B?NGZKa1NZYk1jdHh5bnNXUlhSU1BHY0pDTkRRMlFQYlFQNFJUenZLSWlLd1c0?=
 =?utf-8?B?OW5uYWs4d3V6cVJudkQzTURVRE1tSlRZazBILzA5aDhVQjZYenRIbWdEMThX?=
 =?utf-8?B?Q2NyYnh2Q096WlhSYzlIN3VYQm52MHJmdG1aUzhPZ2pLUXlxTDM2M0Q4d2dN?=
 =?utf-8?B?Wi92ci9WTG9NUm85VUUybE1GSTNQaDFvWll3aEE3SEZncEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDdpa29rZnJsMmYzMmlpYUYvU3dXZ3JIQmxyN1pIaW8rcWNjeG8yMjhNViti?=
 =?utf-8?B?bXBaWGJMSEpzbE43NGg5MjNzSkRMR3JaeENDMHcwM1lCNGk4NWx3VWwwRUFm?=
 =?utf-8?B?NUpvRFNSd2JtZFRNNmcxZkV3MzJjMnBZOVZubTRTbVBEb3hUdUtqclVYRFdp?=
 =?utf-8?B?OUxYNkcySjBYc0lrVENKd1BBRzlDN0k0TWt2dU1LT3ZpM3JldDM4S3NNTmN5?=
 =?utf-8?B?QkoydjQxVTFyeStLK0VNUzlGS2FTTWU5blNDWTJydFBHSVgwd05MMWE5RUJF?=
 =?utf-8?B?b0dyakRJTkhJZWVVZUlMM1BrV3lrTktWajh6VW4yWTVBQ2tGM244S1dEL2Vu?=
 =?utf-8?B?OTNpVzFuYmM0Uk9jT2VGNzJySWlsWGEwa1ZiUkl1VkFHNnJVL2IvM2ZJNGNm?=
 =?utf-8?B?SFBKbUR4Vit3RU1pakdidDEybUNpWEcwSVdaUFhCZDFpVjRXd0NNSld6ci9J?=
 =?utf-8?B?N3pFd1pTSzY3SjViamNkcksrWVZhWWhDTTYxTGdncWxsbm9JWlFVS0dxeXBF?=
 =?utf-8?B?YjBnYmg2OHBxTmpPQUhzQkZnZE91dXdQWEhTZFhzRkQvZ1hKRFdmTjNYMHJ1?=
 =?utf-8?B?T0lFSEV1bGpETTRMYmRNQ2tIK09pZkQzcEVVUjJvcHF1UU5ISTEyb1hnWGpI?=
 =?utf-8?B?am5EMkY3MkxzdkpzUnp6OXFKdFRVMXp1cGdyT05NYzJ4cGgxYmZxT3BiTFpr?=
 =?utf-8?B?SldCODNiaXJQVGRZNmx4Rnl3dmIzczF4KzNacEFkRStzVHFYK1o5STR5Q2Ju?=
 =?utf-8?B?cUxERHRBOGo4a1MyTnlMRk5MY3JrY3VaS09MR2hjdGI2bDJFZ1dEeDZOMzZX?=
 =?utf-8?B?aFd4blRWaXB1c3NkVE9MNzdyRExNRjh0c0E3WGpQaVJUaXhrSldXdVlDOFhE?=
 =?utf-8?B?djhrd2dKRDhveE1IZ0kydFJYbTVTMUtJd0xMd0lTRlVHSmMvZ3V1SEZJcllo?=
 =?utf-8?B?ZHludkgxbGV2dENZaGh3d0wzaW5Wa05xdW1OWDFwSS9xY2RYU0h0NHFvY0x6?=
 =?utf-8?B?Q25tL0x2dWpLYm00SS9uekZ1Y2lGdkJrcldKQ2twTUFJcVpvMHA2YVpIU3p3?=
 =?utf-8?B?dXFMOUphb0NhcDJuaUM1a2FuSlBzRVFldjF1bkkvcUc5VUJKTjQ0SWpVdWhj?=
 =?utf-8?B?K3dwUlk5ZFVhdThvYVRnWUloT1owUmhRdFRmbDI2emhRY2RIQmpzNkZORjJP?=
 =?utf-8?B?TFRpSURhR3VNOTBTb1JrdjFoUU9LYm8vMG1hR3BMY0VscC9BVWYwWkFsaHdM?=
 =?utf-8?B?a1NLZUhKT3JSNzMwNlJncUdSMHdURWRXUFdDazFGcE5pYmtWWEE4RmxqYW5S?=
 =?utf-8?B?U0ovVDUvZVJrOXFadUFxR3BibkdPSHNucFl6SEJHQWFhMU1nNzZKQ1ZaZk9G?=
 =?utf-8?B?VjVzT0NLaWkwWUFSaEtiSUwxR29YWkdrMC9mMFYrMVdIdk5lYklVdzBaMGtE?=
 =?utf-8?B?dGFHbEVnbllGaEMxMHc2UG1SQmRqYmczdk12RWJ0b2xDbnhjbkEzYXRrdVNW?=
 =?utf-8?B?UTRDejF1bmxiaVdCNVRzMW9BKzgrTHRPSC9OZjc5cllFdkdITmdUZ0lkTmU3?=
 =?utf-8?B?aTNESXF5YXJEZGVTR2RTTWFaMHRRenltQStraFFOandRaUdZa25JNndnWER1?=
 =?utf-8?B?UUxxMlBkRkZQcXJXMlMyMkZ1ME9CYUVaZEhrWUtTcE96QzhxT0JlODBESkFP?=
 =?utf-8?B?Nk02aXdERWtOTkF0Tm0xbTVjUC9ReVk0bU5JNEoyaFBTQnFaZFBmYmtIWjFX?=
 =?utf-8?B?OU9uNUFNZko0ZnFRMEVHdENWVzU5ZzBRbVhwK0JreDZ4cVdJNzBLVWVFamJk?=
 =?utf-8?B?V01lUDVSaDNYUmdDeU0zQWthcXNEUnBZNGIwWmNrcFE2ekhDeTZyQ1ZsVjZ5?=
 =?utf-8?B?WEE5TEUvT2tNeGxHNUdPM1hXaGtBR1N2RW1qWmpRd0JpOE50SjJCUmRDMzY5?=
 =?utf-8?B?REZrTFY0cWE2d0FpaElpT0pXUzVGOVk1U3lhcXBFZi9CdWxyU2x1L0p2Qkti?=
 =?utf-8?B?TVZLdVZOK1l5dUwwWS9NYTIvVVZOMFU2SmxlSFlpVk5YY1NDNk1tWktJdkd0?=
 =?utf-8?B?VTFCazhXOWd6WmVEVHA4WmcyNzdZZWRNTEFVbkRiQmNFMVJNckNkYk9MRURM?=
 =?utf-8?Q?2Xd2XQhMHTIZqj0Xx7EG9eB8g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8528154-2efb-47d6-e231-08dcb9debb70
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2024 08:22:25.7794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oX5RAMyXjrN7Kt1Sus2HISpnF9QZS+KnjeJlpstWVxKjx1AnjnuyiqSCYbrtyUu36dQSOZN7w6hA2ZFlTFCnFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

PiBGcm9tOiBNaWNoYWwgS3ViZWNlayA8bWt1YmVjZWtAc3VzZS5jej4NCj4gU2VudDogU2F0dXJk
YXksIDEwIEF1Z3VzdCAyMDI0IDI6MDcNCj4gVG86IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVy
QG52aWRpYS5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBtbHhzdyA8bWx4c3dA
bnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBldGh0b29sLW5leHQgMC80XSBBZGQg
YWJpbGl0eSB0byBmbGFzaCBtb2R1bGVzJyBmaXJtd2FyZQ0KPiANCj4gT24gVHVlLCBKdWwgMTYs
IDIwMjQgYXQgMDQ6MTE6MDhQTSArMDMwMCwgRGFuaWVsbGUgUmF0c29uIHdyb3RlOg0KPiA+IENN
SVMgY29tcGxpYW50IG1vZHVsZXMgc3VjaCBhcyBRU0ZQLUREIG1pZ2h0IGJlIHJ1bm5pbmcgYSBm
aXJtd2FyZQ0KPiA+IHRoYXQgY2FuIGJlIHVwZGF0ZWQgaW4gYSB2ZW5kb3ItbmV1dHJhbCB3YXkg
YnkgZXhjaGFuZ2luZyBtZXNzYWdlcw0KPiA+IGJldHdlZW4gdGhlIGhvc3QgYW5kIHRoZSBtb2R1
bGUgYXMgZGVzY3JpYmVkIGluIHNlY3Rpb24gNy4yLjIgb2YNCj4gPiByZXZpc2lvbg0KPiA+IDQu
MCBvZiB0aGUgQ01JUyBzdGFuZGFyZC4NCj4gPg0KPiA+IEFkZCBhYmlsaXR5IHRvIGZsYXNoIHRy
YW5zY2VpdmVyIG1vZHVsZXMnIGZpcm13YXJlIG92ZXIgbmV0bGluay4NCj4gPg0KPiA+IEV4YW1w
bGUgb3V0cHV0Og0KPiA+DQo+ID4gICMgZXRodG9vbCAtLWZsYXNoLW1vZHVsZS1maXJtd2FyZSBl
dGgwIGZpbGUgdGVzdC5pbWcNCj4gPg0KPiA+IFRyYW5zY2VpdmVyIG1vZHVsZSBmaXJtd2FyZSBm
bGFzaGluZyBzdGFydGVkIGZvciBkZXZpY2Ugc3dwMjMNCj4gPiBUcmFuc2NlaXZlciBtb2R1bGUg
ZmlybXdhcmUgZmxhc2hpbmcgaW4gcHJvZ3Jlc3MgZm9yIGRldmljZSBzd3AyMw0KPiA+IFByb2dy
ZXNzOiA5OSUNCj4gPiBUcmFuc2NlaXZlciBtb2R1bGUgZmlybXdhcmUgZmxhc2hpbmcgY29tcGxl
dGVkIGZvciBkZXZpY2Ugc3dwMjMNCj4gPg0KPiA+IEluIGFkZGl0aW9uLCBhZGQgc29tZSBmaXJt
d2FyZSBhbmQgQ0RCIG1lc3NhZ2luZyBpbmZvcm1hdGlvbiB0bw0KPiA+IGV0aHRvb2wncyBvdXRw
dXQgZm9yIG9ic2VydmFiaWxpdHkuDQo+ID4NCj4gPiBQYXRjaHNldCBvdmVydmlldzoNCj4gPiBQ
YXRjaGVzICMxLSMyOiBhZGRzIGZpcm13YXJlIGluZm8gdG8gZXRodG9vbCdzIG91dHB1dC4NCj4g
PiBQYXRjaCAjMzogdXBkYXRlcyBoZWFkZXJzLg0KPiA+IFBhdGNoICM0OiBhZGRzIGFiaWxpdHkg
dG8gZmxhc2ggbW9kdWxlcycgZmlybXdhcmUuDQo+IA0KPiBIZWxsbywNCj4gDQo+IHRoaXMgc2Vy
aWVzIHNlZW1zIHRvIGJlIGJhc2VkIG9uIHNsaWdodGx5IGRpZmZlcmVudCB2ZXJzaW9uIG9mIHRo
ZSBrZXJuZWwNCj4gY291bnRlcnBhcnQgdGhhbiB3aGF0IHdhcyBtZXJnZWQgaW50byBtYWlubGlu
ZS4gT25lIGRpZmZlcmVuY2UgSSBub3RpY2VkIGlzDQo+IHRoYXQgdGhpcyBzZXJpZXMgdXNlcyBF
VEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNIX1BBU1Mgd2hpbGUga2VybmVsDQo+IGhlYWRlcnMgdXNl
IEVUSFRPT0xfQV9NT0RVTEVfRldfRkxBU0hfUEFTU1dPUkQ7IGJ1dCBJJ20gbm90IHN1cmUNCj4g
aWYgaXQncyB0aGUgb25seSBkaWZmZXJlbmNlLg0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBjaGVj
ayBpdCBhbmQgdXBkYXRlIHdoYXQgaXMgbmVlZGVkPw0KPiANCj4gTWljaGFsDQoNCkhpIE1pY2hh
bCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLg0KDQpJbGwgZml4IGl0IGluIGEgbmV3
IHZlcnNpb24sIHRoZXJlIGlzIG5vIG90aGVyIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgdmVyc2lv
bnMgdGhhdCBJIGNvdWxkIGZpbmQuDQoNClRoYW5rcywNCkRhbmllbGxlDQo=

