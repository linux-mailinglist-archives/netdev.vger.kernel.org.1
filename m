Return-Path: <netdev+bounces-161648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A03A22F0B
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 15:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130C93A3A38
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AABC1DDE9;
	Thu, 30 Jan 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N7PQ/dJ4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587BF1E7C08
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246679; cv=fail; b=SJnjYHB04CNgT3dtCueADGnrsLoGoI90yaNq2P25FcXh3drcpN0oSqC2qePaBL+9yrkHCJv6M9zKVTKYu8teUyWlSv3Hx54VziAksmNyRl/n5seL1oTnm4cIFayz6yLTrESinwlRtJO7ELFZOOa8bXeA1vF/m2ym+rH3HQKvz90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246679; c=relaxed/simple;
	bh=xMwiIsoNT7/3IZG1fqu8fhCKpvXIQOHbjq/CQIJELo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SfFZNm23m8f6OupY+/BX9X19WOQGble6FmrTcwV7ZUfS7BjmefV3fBYkoe1m4s0ycbgTyXZ8sqrr6xTjRt9XokJRZDxdyd5JDj4ya/BrV8M2u8ule7IANsHBlCzWxE+II4CfygzGrNCHYg1UQdRJBrI0v/FP21D3JzJvIxkZLws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N7PQ/dJ4; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCE2Pfei5ly/GbrpXNj3sThT2T5ksWRJFjTlbVqiRm12BwcAbzsWeiuYNad6EeYp50dOOpUwMQfLdL8bFakxsdozSMwjxNBGINyz0P1/UY5NTBBVuCOVP1cICpr7hzbM/0tF8t3riOZK+/JD/xXy9u9rukjA0czgWDjj9WF33J1F/RtiWuZuZPFa1JhnSUGKxnEjE0KHQk8jNccelR6wyUGcHNVJFBhc3Ek+wJ5BtX10XJoCiXV536kOOfnkUv3ltIK5RraVp3jC7qWatF9DGN8tvRCI+TTL9GOJsefZ8+SgvnzGlvNNcXi+8OFp8ZbUOnnfNxfb15vd2iIf8c85gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMwiIsoNT7/3IZG1fqu8fhCKpvXIQOHbjq/CQIJELo4=;
 b=g68gJ2ONRWq5Zasq9XpntyUmCLQJCe0raLwO1KROkoCZ4czJ4/ptnJB82/a9W/nxQ9/sCMvQj/rnG3rA4Hbs69GOaQNv8k6Mj0d/A+AyoqV509iFr8X6gmmoVbCEfYBK/1Df/RzP/4Q3X3ozYR6NxvuYB/fGImfm3ygdOi2LfSqzi6NqdUqh1eyxR7SZiptZn76a+5JbUwZ2M/WU+bxwgu4KLeQRknZWcSvHwCHBKKQk0VumR8N5qwfv8PC+SJIofxGt4orP0aa9X4q98El4HjSiC5yihKxuZkPYlNjlnk6RAeTgeUpVtfvdXvH4j2bhH8FaM9WwerHNZDUlfGk2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMwiIsoNT7/3IZG1fqu8fhCKpvXIQOHbjq/CQIJELo4=;
 b=N7PQ/dJ491FqzKYtGtm6utj42xqhPJSzx1gn+gGFSLeUZvixcFhHbVn3MNO9livYgG/abbFOgTOMsdnCT3H+olikoTVODAN41z28wZFNQvPOVsuUvF+twTO4jAHEg0bkFp/9pc6LfndZNUVAHav3LJMj2mWD7sahtiKCDJNYguySz6zXsOGoSQKLpz3B29+4Z33Y0FVv7+fNYNQzhxkJMwsImHRFjJTjv9A5PPOcKFF/v77mHz99U5Ahc8rMWJF3eTXoPeASkG6QE3JyygpbSF7hDnOacS93GVUO8iKbOpe7qXZ2ryZ3V0aeqjvRqndNlvzrG+IOUgORw0hCzwtS2w==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by SJ0PR11MB4925.namprd11.prod.outlook.com (2603:10b6:a03:2df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 14:17:53 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%3]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 14:17:53 +0000
From: <Woojung.Huh@microchip.com>
To: <frieder.schrempf@kontron.de>
CC: <andrew@lunn.ch>, <netdev@vger.kernel.org>, <lukma@denx.de>,
	<Tristram.Ha@microchip.com>
Subject: RE: KSZ9477 HSR Offloading
Thread-Topic: KSZ9477 HSR Offloading
Thread-Index:
 AQHbcZ/V7BrTHsAdqUafWk3/ZoT41LMsd0oAgADjJgCAAArSgIAANkeAgAAFAwCAACgGgIAANNSAgAAc85CAAOiAgIAAXJhw
Date: Thu, 30 Jan 2025 14:17:53 +0000
Message-ID:
 <BL0PR11MB29130BB177996C437F792106E7E92@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
 <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
 <BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
In-Reply-To: <1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|SJ0PR11MB4925:EE_
x-ms-office365-filtering-correlation-id: 8ae38609-3a98-4d40-1421-08dd4138e29c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkhCRDRreTZaRjQ4eXZIMHorZkRlZHI3OWkxaUp1Z3prRk10VWVFQkJjMVBV?=
 =?utf-8?B?aXJ0aU51b3pJdDd0OXlZTUVKQU1vMDZISENRR3ptYjZpVmRLcGJDSWl3OXVa?=
 =?utf-8?B?R2dodDZFZUZ1YktVdzNvWVpPVnI1ZW1RT1VTZjF0MUFINmJ5elUrSnhNb2hY?=
 =?utf-8?B?OEcvRWhhUGhrL2NFaHdhMzJnQU5GSVlkK2hDQ1hUTkNRRU80cmxJTWRNMlVW?=
 =?utf-8?B?WU5SdGU5VTQ3Z2srMFZMTzNPUm9iMkFWVVExK1JzQ0pRMnJhazluTzNva1Nl?=
 =?utf-8?B?by83ek4vSkRHb0xqY2k2RlBjQmJ1NlQ4bWRMQTZ5TUhMTGcxTHM3TTVBVXZk?=
 =?utf-8?B?TEpONTBYMk5pYVF2SmZmY1k2cFNOTE1lV0pJaUxybG5zRmNNTFAremRXOTFM?=
 =?utf-8?B?cEJaZGRsMUs3NkdBc3JCWEtrT2FSeU43dDhqVUNrdkFnRnNpRXB2L0dxNmJH?=
 =?utf-8?B?cnBPcitWdzYrNTIwcjFoSDRTbzNuNlFNRGlXSkRiZ0lqUUxOUzVsSFU2QVY0?=
 =?utf-8?B?SjVHbWFtbnJORkJldGJweUR2aStwRkl6Z1BxcFBOTVB5cElNeThla05UZm9K?=
 =?utf-8?B?Rk56dk8rTkFGbEJvaGdicmNGZnVKTVRaTmNmTzF6OGU2ckdmdjhqUzdXbWhj?=
 =?utf-8?B?SGtNeDBFRHRwMnBkUllCTlM5TGIyWkdiUUl4QW5KREFBemx5OCtYeUJvNG5N?=
 =?utf-8?B?eGhMWlZBNUZRMXVHZ00rbkphMC92NzJjaG1uWVdiZUp4RTVnZGs2RXEzMDh3?=
 =?utf-8?B?bFpvSGZMbGpnaGZSdnlHK3ZpTUY0czhFaEdyRWt1QmkxUWt0NTFzOFNBU2xL?=
 =?utf-8?B?b3UyRVZpc3ppdk11VHJyUFBnTEljWVZFbW5xZG9nRlROcEo2cURYejJBdkFT?=
 =?utf-8?B?UjVMYTF4ZGJQZWpJcUZYbkZiYmVaMDJsT2gxWGwyZlM1UlY4RU9oMFNrM2NP?=
 =?utf-8?B?VTVzWGNqczR3aElFeUMrbXpuUWxUTmJrQWg1YTlVclpWL2tTMk9aRGZrMjht?=
 =?utf-8?B?M3VPV3lOLzBTQzlDQ2l6WFRQWVhYd0VQcFBWczVtd3lsNmhhNFlKd3BHZ3Bz?=
 =?utf-8?B?NjNQWk4za1J0WmhnbkVwSDZuSlYyUThUb2E4OG9lWFplNlkyeUxiV2ZwckZy?=
 =?utf-8?B?NVdqRFBJanNiTzZUNWJrTWZyelVXK0xPRUNqWWp1TTE2RmVCL3pyMTgzV1FT?=
 =?utf-8?B?Ky9VcGNIbUpyVmdmbEpTaXM3djRBNVFVV0MxVCtaZWpJWlpFUHRLci91Skc3?=
 =?utf-8?B?S2xYWnEwcUkvQUtZNTdnSmRDZDNoVE0wVmo0WTQxSnlHNmMxcDgxTUtURE40?=
 =?utf-8?B?OU5nMk05eVNWTjVRZlAxSHFIZVdsOFlzTUxwZTBBVU1ZaENRTFlwblhhemZa?=
 =?utf-8?B?NG0xbldUTUZ2OWd0YjgvbmV3Zks0Nm1LS1FURkxMbVJjdnM3akw1ZDdVRkhn?=
 =?utf-8?B?Z3VtdVFaTk5KVXNZUEEwcllpenlhbUIrd0xib1hWSEhUQkU4Y1ZXY0lpeHpw?=
 =?utf-8?B?dHUrTlpua1UwL2dmdWlIWDZZK2dEZmZrZWh5Q2RJQ2dQTFdmUWpRdWpJeUdq?=
 =?utf-8?B?Y012bTdJSCtsNUhRakdUcTE5ZjJrV1FKNDBWVkd3ckxBY2pjY21aU0FwTkly?=
 =?utf-8?B?K0FQQU9GVmRnRjkwVzJoVWZmSmxQWFJTR1o5NkhEalQyR2hKcUFmbEJ5M1R6?=
 =?utf-8?B?RzhnZTR5MVIxcFh6Q3p6ZmZoU3Y5YTJENEM0N0M2ZjNZMUVlK3A4MkxIVkVD?=
 =?utf-8?B?MElRNElOSkV3MDhqS2RLeUlVNXR0enEyM1pEaTdIbjR2WUNyb3A3WTRDODBw?=
 =?utf-8?B?NlBlWEcxaFNXMHdEVTFadG1nMTM2TWhZL09HRGd6RktwdURYZGQxL0hRcU5C?=
 =?utf-8?B?RENRbTNUWXFDa1lQdGpaNzd2dHREWDYrNjRoNllNbEdNK3c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDhwTFUzdG9FL3pOU1BwNHNieXYyeXc3U2ZZVUlGSGs4d2JRZE9rNDkzcFh6?=
 =?utf-8?B?M3cyZG9ieUxPN2xpS1ZuZVdZZ1lmNmJCelVkN3RTVEV5dzQ2cjUyYUlnOGxM?=
 =?utf-8?B?RjF3TVZtRlZwQS9vV0FXM3lQNUdzUWJKa3hRbUNGd0ZSQ05EYkdIOXcvdk5P?=
 =?utf-8?B?b2V0bGRGaWI1c0wxblpaOWZycHR1MkR3aEZYTi9yQ1Yxc2RMZXNzMXJnZlda?=
 =?utf-8?B?Sk5OYTczM0p3SXRyalNhSExnMWpIVDBUeVlmeFgrcWxVbklBTU4zWFFyeVJ5?=
 =?utf-8?B?dGZ4aGxmbS9vMm5ZSUVuVVlpY2JPbkxpVTFMSEhQQlBHdHFEays3dzBKZkEv?=
 =?utf-8?B?U2R4WE9aQ1Rpemxvcm5JOHMwbjhiR2xTVUd5VktvcjZxRWJNNzhaQS9aM1J6?=
 =?utf-8?B?SjFVSjFKWkptMXhCVmg3NTBYL1dpTm44c1N3TG51REU4cHNUM1hBMHd3TmV1?=
 =?utf-8?B?Qk1NR2RMOERZQ0Vna3VPOEFObDhVdFpnTGhWc1Q4QUZNbUpCV01tdkxSZVB1?=
 =?utf-8?B?a1lpd0owanR1S2Voa3Q2bU9TQkwzLyt2VGFCTlllbzFIWnpWU0tHMnI2eWZ3?=
 =?utf-8?B?MmZwN2NYZXVRMk1QQlU2Z2o5b0tXYm1tUVJjQjVidE5kZWRKQjV4em4zYk82?=
 =?utf-8?B?ZFRLREFKOFNjZ3o1YVQ2bTMwMlBCcGRiN21YNXFhR2dpRVhORjhreWVVM1Zv?=
 =?utf-8?B?VW9yL3c2U042RDUvcnRyWnJCU2hTaWwvMW95T00zSGc2T3RmK2R4VkFVRFEv?=
 =?utf-8?B?NVJaWlZ1QmZyV3hHdGVYNFA5cjQ1V3htNGZoYTh0cDhNRTRZOTBiVHZlRWRW?=
 =?utf-8?B?RCtGS1hSMUx5blNsTjBaZDFZbi9pSGNoZC9uS210bGppenI5Tkxkem52b2FZ?=
 =?utf-8?B?ZU5hYjdMUVI2OGhOTXEyRXBoVGdnUmRubFVqc0RzUjZxMlY2cHNYZWZmN1BS?=
 =?utf-8?B?bUNBbUFESnk5b1NrOXZKTUVoaFlsMWV5UDc1NURvUXFTVUJ4UDhqYzNzMzJM?=
 =?utf-8?B?dks5UTcxVmVJcnZvRDVFSnp2dHBKYmJGTWtaWGZKWEJVdnBvaWVacmtqVHh1?=
 =?utf-8?B?RnhJdzkwM1U3LzIvTTlyOWF6YWhKNWE0OCs0cU9YQzVmRk9LQzBUV1NyNnFL?=
 =?utf-8?B?UEtUM1l1ZWJkbmx4c2s0U24rNGxHNVRVTTdBRzlrakgxdlRabHF5Z1VMVXRC?=
 =?utf-8?B?SkFKRlZrRW1UVG9aRjd6VERVR1V5Rlp6d2lkWkRhQkNGTHM0ZmNWU3VjS25k?=
 =?utf-8?B?ZU55NEFyY0pvQjJSVFRjWXAvWFlLTXh4R1BEVmJuWDFlTmlGTzl0UXV0NDZZ?=
 =?utf-8?B?QU5xMjJ5V0hPK09PRXIzUEx2RUMyZzNtZE5EaHV3U3RIaU1QdFRDNzU3Qk14?=
 =?utf-8?B?RUliMVBYQTU4ZzYwS1YvaFhraUxxa1R4czI1K0xxSHJUdmZIT3RmUXhQNzAy?=
 =?utf-8?B?allTK1V5ZjJSVzduWnZzcnZtY3VzNTRYYVhSUmxHd0xZTnZIRjFGSkVBTEVq?=
 =?utf-8?B?WFY3L1RrSmNrRXVTbVhYdEVmOHBvYjZUWjcxOThqT2k1dnQ1dm40eWsvVVZO?=
 =?utf-8?B?K3d1TmVJY25XVlk0U3JieEw5dGhNQVlQNzhodld2eWtEbU1OKytnRUtTYXVr?=
 =?utf-8?B?a1VmYzdXVzh0TU85R3FpWTdDamd4OWVPb3ozeEhTNHNOODFVVEdpcm5HRHhB?=
 =?utf-8?B?dTg5QlZ3OE1sVk1pZmlVVlBIekRrd0U5VHQ3UmlnMTU0ZVU2QlRQaWVsMnJx?=
 =?utf-8?B?VlU2TjAzTjdKMlR2NVFGdG5yWE84cDdHNDVjUmNiendiS2NXbjVYNG9hSlQ2?=
 =?utf-8?B?NDlkeXFBSEZEbTM1cmNsdFY1cEo0bDFHKzBJbXZaMkdVVHJTR2lodkdveXho?=
 =?utf-8?B?bC9yRHVCb2xtcWhIWmIvNWpZV29FVkpSSXBOakdtQ3BCeENxcElDVWFRMHRN?=
 =?utf-8?B?MVl2Mnh6VDFYeWsrNmJoenl0T05RcjI0V2w3b29WckIzTHZreDZ5a1lYZkhK?=
 =?utf-8?B?TzJndkNySWhtb0Jxa054Ry9qVXV2enVJTjg4UGdCbFVyZTBrV0Y4eHhtRjJs?=
 =?utf-8?B?eHdIWUpIa0tIWHM1VUZHT2MzekQxaUk4eVNzazlkVnM4SVZvU2x1U3R6WmtS?=
 =?utf-8?Q?Sg8OyGyHka+CrbzyXEb539xOf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae38609-3a98-4d40-1421-08dd4138e29c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 14:17:53.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1e8HQmrZ8QMTyiZd+IhzkJPv/H4S30z6vkDbg6bp9xqcpr9AxZA46oEjKk/x8PM4BztHaX5bGzrdqzrJGXn5cTB5h3cVz9STzDIJaQFRNGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4925

SEkgRnJpZWRlciwNCg0KVGhhbmtzIGZvciB0aGUgbGluay4gSSByZW1pbmRlZCB0aGUgc3VwcG9y
dCB0ZWFtIHRoaXMgdGlja2V0Lg0KUGxlYXNlIHdhaXQgcmVzcG9uc2UgaW4gdGhlIHRpY2tldC4g
SG9wZSB3ZSBjYW4gZ2V0IHRoZSBzb2x1dGlvbiBmb3IgeW91Lg0KDQpUaGFua3MuDQpXb29qdW5n
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRnJpZWRlciBTY2hyZW1w
ZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFy
eSAzMCwgMjAyNSAzOjQ0IEFNDQo+IFRvOiBXb29qdW5nIEh1aCAtIEMyMTY5OSA8V29vanVuZy5I
dWhAbWljcm9jaGlwLmNvbT4NCj4gQ2M6IGFuZHJld0BsdW5uLmNoOyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBsdWttYUBkZW54LmRlOyBUcmlzdHJhbSBIYSAtDQo+IEMyNDI2OCA8VHJpc3RyYW0u
SGFAbWljcm9jaGlwLmNvbT4NCj4gU3ViamVjdDogUmU6IEtTWjk0NzcgSFNSIE9mZmxvYWRpbmcN
Cj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IGtub3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgV29v
anVuZywNCj4gDQo+IE9uIDI5LjAxLjI1IDc6NTcgUE0sIFdvb2p1bmcuSHVoQG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+ID4gW1NpZSBlcmhhbHRlbiBuaWNodCBow6R1ZmlnIEUtTWFpbHMgdm9uIHdv
b2p1bmcuaHVoQG1pY3JvY2hpcC5jb20uIFdlaXRlcmUNCj4gSW5mb3JtYXRpb25lbiwgd2FydW0g
ZGllcyB3aWNodGlnIGlzdCwgZmluZGVuIFNpZSB1bnRlcg0KPiBodHRwczovL2FrYS5tcy9MZWFy
bkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiA+DQo+ID4gSGkgRnJpZWRlciwNCj4gPg0K
PiA+IENhbiB5b3UgcGxlYXNlIGNyZWF0ZSBhIHRpY2tldCBhdCBNaWNyb2NoaXAncyBzaXRlIGFu
ZCBzaGFyZSBpdCB3aXRoIG1lPw0KPiANCj4gU3VyZSwgaGVyZSBpcyB0aGUgbGluazoNCj4gaHR0
cHM6Ly9taWNyb2NoaXAubXkuc2l0ZS5jb20vcy9jYXNlLzUwMFY0MDAwMDBLUWkxdElBRC8NCj4g
DQo+IFRoYW5rcw0KPiBGcmllZGVyDQo=

