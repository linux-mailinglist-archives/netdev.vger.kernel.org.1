Return-Path: <netdev+bounces-206168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11389B01D07
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 15:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEAB1CA205E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3BE28EA4B;
	Fri, 11 Jul 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QkHaLAl2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D1288C06
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239494; cv=fail; b=PnrL79d/7RUwyJtN8mM2vZcebdg0BNXB3FPAx0J5ua/doVZberKlxjNoitQeGAOFLW9Y9QQjohccwH9LXyQ/y8uaF9wJahBpbenfPugFXbLEwrmky/Ng1li9A3wvtffwzSK6NEHtayuT7yV19xoATLozO53xeATxisIyeYxvbEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239494; c=relaxed/simple;
	bh=DDxn1vlq4Ktzr2n1LEAxC2zqbYyt3yDpqDj8UAdLbYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sZpEdu8qrXM3QifotfyHtzPZ8YCPcfvvH6wOb0nfpiW97hYC2Jsjb56p1vGSELzZ3YSs2Yh+CPwq3Df2LPJcQimGBuiE955478LU2POJCK2tSWkHEz1jX01gChPgmFdx5n0uEc5ZaW4wNQVbnKpapZSxxzsxtryAEpE7tWl65Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QkHaLAl2; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPD8l/OYLWZ9ZzYmAXb4wFQLUWw9iMHbTqWNCbQEub/IRCWhWxFW0cGRINQXqJJEsVbQ/oXzOWpF28q8aajzRkCxPgmcHpsag3hA9gRfuGrhMWFKO++pc6jXgKY9Gh6gWUWIisVHxyTHRgqlXETOWzYbLJ1NqHKVeMDXF0V6dOFAU7sBGU4b4+gwW0ZkKSEY8haTR3MUYf78dwwqjSL8DIbnhfnfPZLEPlWOgPw99eRLEc4V6yvOC+xQmequR4rpJBTuZG87TWWD320E2FPWdFD6afPgyqtXvjNBn3THGa9ZBT1fqmW/3wk3KzMIxu0BnhTu6Kr9vAaB6WABu/PqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDxn1vlq4Ktzr2n1LEAxC2zqbYyt3yDpqDj8UAdLbYU=;
 b=p5QoP5q6va9FoTw+8DgmSLCQd43V+gx281KJW91dQQayV0kg7p8SdCEy7fvUhkHxEV89AHhLH0JFdWulzw2aeZlyH2RoG7jL3PIYOLJuffTqM8E/E3TNPaicIzNsHbFc1d4xiEhcqYd8AZOZ9rOZOlCq2Z3QK0+nCdqrZwExmsCQOjdYd5l5oEZatyD7PH8B1MH4QOqF1sfk03cMtGvLMUVO/RoZFOyDtp42K0dtzti8ZFh3xyXsUgpf+PeSeYXx0F68hf7LceRY8PU9DQgIWn5ZmcnWaVHgU6dD2u9yEvZlnD4FUpPWGU+JtUhoVoZiyEimalEom+dXuzNxypU+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDxn1vlq4Ktzr2n1LEAxC2zqbYyt3yDpqDj8UAdLbYU=;
 b=QkHaLAl2lAZe7OOfi7ELN6vvLAC9XrCu/peg1rP1+utEdUicTT+OqtiqpOcMb9ZRo7DGq327kAgzks8gfp6MlvjQ/KN3Ovbj3L6zdTNHhJJa0Yr3I5TjmgkOVZODifWaFju+9MDAlXCDV5py6OpMfFAD2t4bDAe8twmfiwAl4+t9+rNUpq+BPRY8o/202zVG9BHiuW/f0p20CS3r6qiXMEuZ65jdxVHey7HK/oOiKNW+9rj64kUJf36b2fxHqlpFuc/GtQUerUy1Pn6pnqckmQtqjcNj+GrA3++MdhPQIl61vmRiLOZTAydWLO9x4Vle+kEEe5PgfXe9pMYe3isMxg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CH3PR12MB7714.namprd12.prod.outlook.com
 (2603:10b6:610:14e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 13:11:30 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8835.025; Fri, 11 Jul 2025
 13:11:29 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "corbet@lwn.net" <corbet@lwn.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, "edumazet@google.com"
	<edumazet@google.com>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: Boris Pismenny <borisp@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"kuniyu@google.com" <kuniyu@google.com>, "leon@kernel.org" <leon@kernel.org>,
	"toke@redhat.com" <toke@redhat.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, "willemb@google.com" <willemb@google.com>, Raed
 Salem <raeds@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"ncardwell@google.com" <ncardwell@google.com>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>, Saeed Mahameed
	<saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v3 00/19] add basic PSP encryption for TCP connections
Thread-Topic: [PATCH v3 00/19] add basic PSP encryption for TCP connections
Thread-Index: AQHb63SrSDoBOxEpgU6fVI5miUV0HLQgZmUAgAyNUQA=
Date: Fri, 11 Jul 2025 13:11:29 +0000
Message-ID: <7a63f8e6402b912df88e36def49e17eee55a25d6.camel@nvidia.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
	 <74db3f48-95c2-4f94-affa-7932e7593f17@gmail.com>
In-Reply-To: <74db3f48-95c2-4f94-affa-7932e7593f17@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CH3PR12MB7714:EE_
x-ms-office365-filtering-correlation-id: b97b66fe-3938-49b2-14f3-08ddc07c733d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHVnM01tYUtGa0hyM2R4OEtVZXpHSitWRnB5MkhJNG8vSy8rZHlHN2V6cXlW?=
 =?utf-8?B?VndXSDJEVmxWT3Qrb3QvWEp4b3NPeW1kb1pGcDk4Y0x0YkRYVHBlajlYdWhX?=
 =?utf-8?B?eXJCTWIrUmFVTjVHSmFlRFB4clNFSTFiZFhyakFoMk8xc05jTy9xZU9TYTJW?=
 =?utf-8?B?ZmJ4bm5hY3pkdGtvZVBUQ2hrNXYwbDZhc0VIZnIyT2prb2QzQjdiYzJlSFB6?=
 =?utf-8?B?UG1lbUVWa09taUpKYXZBeDAvQjZST0N1YjNkQzRyQzdOM0hLSXNWZUtzSzJS?=
 =?utf-8?B?cThIbTk4RFhpeEsxQnEycFhZZm42Sy9yWUFTaUllbi9lSklvL3hMV1poL01u?=
 =?utf-8?B?OFVPY1ZXc2ZIVXVZOGdKdzJsdWVPQWlJYmNVMDRiYk40aVUwMVlVekFnRWd3?=
 =?utf-8?B?Q1dkcW1kU3FKMmpKRE1LcVFhMkg2amNvbVJ6UWFmNmg4aGhOKzk2YUxObXIy?=
 =?utf-8?B?VVBQRU1Vb3MvQWwxa2RNaWxONlQ0SExaMmpaRGtkUHJWUVErV0NKQ2xGQXU4?=
 =?utf-8?B?M3RkYmN1eEF5VHBITGV0eDFsaGd3MHZ5MkVzWlRWZXNaSEQ3NGZITUhSYXZV?=
 =?utf-8?B?MFBPbUFMTGc0Z3ZKVDlGQnFRQ2orMEhEZXluRlJobjVTRDBLSTVKSHdTYW1v?=
 =?utf-8?B?MUZ3dm8zWWw5aEhOeFJHaFZnbXlTMC9BSHNXN0RCb2J4RkkxMHNhWHlxR0x1?=
 =?utf-8?B?alFRSW4xTHJLV0ZDdHh6VVN0TmV2NXVwSkVIQUFMWE8xRjIvbXo4T0FpM1lQ?=
 =?utf-8?B?alFmbGxGL2czWEtCZnBSc1pVRG0rc1NkZmpRVTNiZFdPS0lhQnF1dTN1TzRo?=
 =?utf-8?B?UDB6NXlHU3BPYTYrRUZ0bG8zbEN5VkNYOWlVWFdOY25Fb0dvU1llcUtaaTF3?=
 =?utf-8?B?NjVsVy9PUnBxNmNhN2M3UDVUQ3JySTRIV1YzVk1vM2pDL1lGb1VuL3lYMFhm?=
 =?utf-8?B?ZXNmd3luRm83bFRuTWtWSEJPVVk4YURDMjFuWmlxMHJSMXFkZmZOeHFvN01S?=
 =?utf-8?B?SkVDa2FGcDIzMHRnYW5YS0pmdVh1c2NyOWJrUDZuVitBaUduNTlYUCtBam8x?=
 =?utf-8?B?ZlhFWkNpc2swNGFHZXZLb2EzWm5FVlBHMXVRYVBZcmZQU1dSV0Vqdy9JZVpN?=
 =?utf-8?B?VE1mMUZOOEthamk2WmRRVVd6bGhGQkFSeVBaM09EUGFxYVpGZzJUdFlPUXBO?=
 =?utf-8?B?RHlwZnF1bG55OThlQWxOYmpzVkhNUVlKbVA2NGo2Rk1XT3JsRnFwaXJ1OTBV?=
 =?utf-8?B?M25lOTNKWWUya3NTRysydjhxVGtFWTAwRDR3M1dvZ0JNejZqMVo3M0dDQko2?=
 =?utf-8?B?WEZVdGp2NkMrcEhrRmQwL2dEdnBHaU9JRDRBV1B6RGU1MkhvNHVOMllpVUJ3?=
 =?utf-8?B?YlJNelFVKzBGM1greTNTSitWT3p5eXhETzdUSTJVWXZYNk9xM21jdHZLVE5N?=
 =?utf-8?B?TGxxeFhDYk5HYXZkVnR3SGdxbW9RUUtuV2FtOWVlZWR0a3c2bEtTekoxWWlC?=
 =?utf-8?B?d2kxUlNkN2svRnhLa0t5ZHhaMWEweG5QYTlKWldrcjdtVk1KRzlENjUxbFpi?=
 =?utf-8?B?WHREbjFiMWJ6UGVkV3l1czdsNldTVnN5VlVOdmpFTUxPcXAxK0tZUHdVUVAz?=
 =?utf-8?B?eHcxZHhQM3Juek5WRXREVXFIMVU3VFF0TE5UTERiQm52NmI4dFdLTDJzUnFU?=
 =?utf-8?B?ejNEelBPeUtHVFBDTEJnTnQ2eUV4K1dXOHY2RDZ4cnFUd3A2dkN3OVRIdlo5?=
 =?utf-8?B?SCtyQ3VhODhwTFM2SVVZNlAzZ1lOVHVSV241ZHh5MGdnRnJDcXoySTlsOGxX?=
 =?utf-8?B?QlVRbjM0WWpaTmM4WGxTNXplZE90VmZPYXBkK1F3MzRGeml4RG1xN1ZJVi9w?=
 =?utf-8?B?b1NmMnZYcnZBZzlIWlpPWHJtVEw2eE5BNllzUkF5cExZYWhuWTZwUklmc3RT?=
 =?utf-8?B?RXN0NEo5R0wyRHEvRDQ5MVB2MDJEMnZRZ0tLdm4veEdWQTNpRmI1dmlhTzF6?=
 =?utf-8?Q?GPBzQ89Qsh8NRvN2ctCkk3qT2UUzAw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3h5ZjlCcTFKN2Z0VDBrdXk3Wkp5VDNzWkxjMFNNdmZlK0RzQkdtUWFuYUlU?=
 =?utf-8?B?QTJuTmhZSTFReS8zUjVMck5BcnlhTGw1dm8zL0g3d2ZrWXZqT0pvcDNYK0lm?=
 =?utf-8?B?ZXNOYzk5eFpjeThsQlFFV1EvVHBpTGh1WThORmdIdkZkTjQwanhHYUlaSnFy?=
 =?utf-8?B?NXNqb3UvOEo0U0FyRndKYTdCQStDVjVUZUpnaVJBclRwNHhnOGNPU1lhSkFJ?=
 =?utf-8?B?VklhQURiZW9PUnJnaEtxYmhKc0hpbWtwTThGSGlPZjJ5MlVHamd1U0x2MkJx?=
 =?utf-8?B?QzV3M3dOK2xibVowbGgySlUyZTRLak9uakRZL09qQ3NIRFRaQ01YZEZtYUdP?=
 =?utf-8?B?V1J4YzRLWjV3RTlGdXFMNEN0T25vOEhlRW9pZTMyKzE2MXdFQXpaZlA4K3l1?=
 =?utf-8?B?R21pejJ6YTVqTGhJN1FieUdQZjlCL0VGS3Z3UWgvdlhGaUZrZTB2TGsvR0FQ?=
 =?utf-8?B?V0dxVForUDJCbGkzOFNWbDBYUkxJWkdobkxlc0doOFNqbXhvMlpPQU5yYmdX?=
 =?utf-8?B?OXZBRTE4STdxY0RkMHV2MkhTcEZMS0VVSzhFbThhN0kvVzhhTDQ0d2hzYzUv?=
 =?utf-8?B?elBHSE9DTkp1TlUyYXZWeGpGMFV2OU54YlZ6RDZCdVVZcXNCcEk5MUNhbW1V?=
 =?utf-8?B?NHVFY1NoZ0tNSlQ1ay9qU0c2WVVOanMxa0k2K0pueHllclN2NHhodW43djJ3?=
 =?utf-8?B?Y1ZJVEQ0N0YzVDAySklPM3R5c2JlSXhwUFpLYXR1MGhtSElIV1ZnWFNNNnp3?=
 =?utf-8?B?bGJZUVBwZ0htVC9wd1BuVUdld0Y3TnlzZGFJYm5MZEFRQ2dDUTVJdHpHWVNK?=
 =?utf-8?B?dVU0cWExaDRkY3dCN1JvTjlBZU1lSzdFZlRNTjg2dTUveVRTdmxxa2tONjJx?=
 =?utf-8?B?UEdMQi94MmZuci9nR3QzVDFEOW5WRmZwMnJpSHJ2Mml3Q1ZMYnV4MjFOaWRH?=
 =?utf-8?B?Q2lTY0xRV0puTUpaZWUzLzl1QjR1cFVCMXJLVUZMMEpsWUZBRFFaSkFkTy8v?=
 =?utf-8?B?cjBmZFN6NTM2bEkzd2RaeHl5QVBZbDgyRkp0aXBEd2JlRlpaOEFsWlMvaktH?=
 =?utf-8?B?OXlraTlPTDc3R3QwOVpJbXBiRHBSVXJSd1ZkdVdYQWJnVm9wQWFodmw1eits?=
 =?utf-8?B?Z2oybGV5Q0ZxM1VGa0lzNGNYeVBFWTdDUnJmQ0NGRU1UU2IvNW1ZbWFIRlRB?=
 =?utf-8?B?MWVrZ3dDV0NOU3dQcHl0TnAwaUprYm1GVVVNYkx6WGw1WC8rZ2dJYm5kMzdF?=
 =?utf-8?B?T2puY2JSYmgzTEU4R3N5MndXTzBSVjFuSkhDcU9Gc0NHRGUxUytqNTUrY1BU?=
 =?utf-8?B?dDZuYzFobU9IaXVIQlhMb2ZLZlh6cUdRYlA3OG8xdmJEeWluWmYyVG9aVENp?=
 =?utf-8?B?Y1FtWnpKNkdTQjZnZ2Z1OEpBTWhOTUxtNW1BRk9lQ3BqenhIWUd3WFh0dktY?=
 =?utf-8?B?U3ZzZC9ROGNmcHpCWjV5Rzd2N1A1K2wyc2hRTkZwTDhNMEZyWWwyWDhCYXdG?=
 =?utf-8?B?QzVFME1BUkR3bk5TMEF3b0phZ3ViTWF2Y3VlTDhBS3FISENLaVh3ZE5hbjlV?=
 =?utf-8?B?bkRvZFZmYWZuU2gyVHF0R21aK2luYkM5cGk2SkhzdHZMTWhadURvY1k5TGpz?=
 =?utf-8?B?TlhKamFzdkRFYW83UkVKZUZhbXpIcXRZOWFRSFBXalRCSXRGbThzSy9nZzgr?=
 =?utf-8?B?VHR2UjVxTVQxZ0E5dFpGRW9JVXpSOVd0NjNUSlNsYUc2TGVWaUNha2xiYlkz?=
 =?utf-8?B?VjJXTEVsckdyb3EyamdJUEltWUtIL2hrT25KcmFsNWpSTm1USlVQUkZmeWZS?=
 =?utf-8?B?UzJXWStXRmFqWUpFS2pXN3k0Vy81TTl0SDJCYzNSOVpPOGVOOWpGMU9qUG1k?=
 =?utf-8?B?dCtVcno4a0x4QjNjcityRFRtOFFJUFRyTUJoOTFmbDYxTEFIL1VtUHlrSUN1?=
 =?utf-8?B?R3JpazJWRFlTSlFaVXk3NDU2bWJ6cXJQMUxPOENLOSt2eDNzT0d1YnJvS21i?=
 =?utf-8?B?N3c0T3l4QW9yb2xsTE8yKzBUYS9KQVU1SzBVUGorMTd0eHNoOW96YmxOM1Ev?=
 =?utf-8?B?WjRUc0hzRHpmK2RxSlh1OFIveGVKZUNXMUZHNUIybzFvcDlFWnZQZjVxNW5U?=
 =?utf-8?Q?azHAvjcjqOnehGLpbBH/Tj3tq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED4641FDFFD9DF419D224D725A3B8FB7@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b97b66fe-3938-49b2-14f3-08ddc07c733d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 13:11:29.7799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uunLkQ59gTO/loHw7aG2oHTCvmpIfgq1t7GZnO7fVSA+cvXqsRem/SrGR6b3y+kGaqXoYsxU371/Zpx9OPLg2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714

T24gVGh1LCAyMDI1LTA3LTAzIGF0IDE2OjMwICswMzAwLCBUYXJpcSBUb3VrYW4gd3JvdGU6DQo+
IA0KPiBGb3IgdGhlIG1seDUgcGFydHM6DQo+IEFja2VkLWJ5OiBUYXJpcSBUb3VrYW4gPHRhcmlx
dEBudmlkaWEuY29tPg0KPiANCj4gVGhhbmtzLg0KDQpIaSBEYW5pZWwsDQoNCkkgbGVmdCBhIGZl
dyBjb21tZW50cyBmcm9tIG15IG9sZCBUT0RPcyByZWdhcmRpbmcgdGhpcyBzZXJpZXMuIFRoZXJl
DQp3ZXJlIG1vcmUsIGJ1dCBzb21lIG9mIHRoZW0gd2VyZSBhZGRyZXNzZWQgc2luY2UgSSB3cm90
ZSB0aGVtIGRvd24gYW5kDQpJIG9ubHkgY29tbWVudGVkIG9uIHRoZSB0cml2aWFsIGNsZWFudXBz
L2ltcHJvdmVtZW50cyB0aGF0IGNvdWxkIGJlDQpkb25lIG5vdywgSSBkaWRuJ3Qgd2FudCB0byBo
b2xkIHVwIHRoZSBzZXJpZXMgZm9yIHRvbyBsb25nLiBUaGVyZSBhcmUgYQ0KZmV3IHRoaW5ncyB3
aGljaCBhcmUgbW9yZSBpbnZvbHZlZCBhbmQgY291bGQgYmUgY2hhbmdlZCBsYXRlciBvbmNlIHRo
aXMNCmlzIG1lcmdlZC4NCg0KQWxzbywgc2luY2UgSSBlbmRlZCB1cCBtYXNzYWdpbmcgdGhlc2Ug
cGF0Y2hlcyBpbiB0aGUgcGFzdCAoc2ltaWxhciB0bw0KUmFodWwpLCBwZXJoYXBzIGl0IG1ha2Vz
IHNlbnNlIHRvIGFkZCBtZSB0byB0aGUgbWx4NSBwYXJ0cyBhcyAiU2lnbmVkLQ0Kb2ZmLWJ5Ij8N
Cg0KQ29zbWluLg0K

