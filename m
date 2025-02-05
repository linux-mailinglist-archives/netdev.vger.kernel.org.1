Return-Path: <netdev+bounces-162954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F517A289F7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14140168AA5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9A722B8C3;
	Wed,  5 Feb 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dYAvoedj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583E021C19F
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757600; cv=fail; b=RblXax02eoEknwl0hq0Kfdz+zNdYchrWR8u1elxC3ZHRL6C6AKeCRbrKQWD7/S3z37yrzhIS1vb+c8Az1ZOjyTC6qdsXvnMOPWqmlo/i39k6cfU5pJT3AZa4+iVkFRKwzNGB2KH8BmmRkA+6m5b3qR8vc6LwqIIWMu/SPFOJib0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757600; c=relaxed/simple;
	bh=krbUf9Gdqq5W/0DRy8lOSNsZdfkMJ1zPU4lvglB8n9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N+n0h6Mjtb2o37mT6y9dw/cPNpKLExFPDA8pKs7akwG/sqBZuZaUH+G/+r2z2z0vdp5czXo5AG0vRBqGyTet7tk8bphUj3GSZn4x6oug7t48JTr/QVse9FiIqx3dSKbbTjaqjLawWQh2AoHunxuQcPw+D7ERVVN1ZCOGAIGKrxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dYAvoedj; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VepFtcPh49b6OpxnfmMwIoNCKcpOAKSh6Q3ol6sf/SLdCwRezdGa/Zhw76MJ2Vf7KRPMwOrCpdQ06FHvQ1FYiPUHLI2ceFYIfCFsaUHA9eYN2Bbw5FCK0SkihSHGu/b3/waeNcu/4V6htUjymRACeNwmLG0lfg5rAVu3EWkx6gkPGzOfVLZAMD8qkUoIOLhp1kmIwVltnAfD89nKJ7uQVZaPQYjB0jbKOuTsNazqRnxOT0pTf4GwB0EVqzxs2tVCe81izHnCz2eYX4xEaUkbbK5IrHj8a177pEoCKF37Kgv5vBUgzUAEbEYcClN7v/FnQYRt4dJyqEobbpnieNxibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krbUf9Gdqq5W/0DRy8lOSNsZdfkMJ1zPU4lvglB8n9k=;
 b=dqSG0jKB71X7Xq5EUMiHVP0ox8JpOGDCdyj/BV2QwwUUk0n8w7kMgPXm1gJLNI3h937DMQLf69DwFbdVfdhrVk7QIGywmsbd/gv9LYhz3/Htz8hRIgamob7VmEuG1rFTAiyqLxeXTJ44MMFyDC2EydhDscHB0zCCS+r1zBkJAC6ywYrvZboNP1jsm0D1enBw9HIVW5WLksJngBc9ClIo4UK/reCjzMEmxrQHka7codqGgk26aq+GCNPh09dks7mdcgY3eQFGZ+P9VL5H8GCy3uVCzh0lQ0gqeWcEgd4GLAM3lz5QWoLALMkwfKuqVcDPJrXY31IXlTdrixbExujZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krbUf9Gdqq5W/0DRy8lOSNsZdfkMJ1zPU4lvglB8n9k=;
 b=dYAvoedjBlXHBwylfs561JH+YIa34Wrw99kBMCHj+Ihric9DVPolQcWdwEc6x6zxoAinaQ6NAgk0REAdCtu5iwl6axrLd3OkwrpDoFbzpvl/12V2ZdfhPFmV+NAHjHEk1HeFrBpMEbFMXwham67VIL8b9hyD8UZOZKmsrEYPT7rIaMKC+FHvk66ZUN8/mBL08jlxpBoqvc8JpBk5qlbYYexNF15fd4QnHvFu0dmDhfXB0a79mGUQMslbAL0UmVsVRWLeHJ37AiN0Ronb3Y95nm+OnOyK2IjXuxz+qN1MHZ8UynZMPShwFNu+taPV4tqkgbMumPVcfm8QnTeWuoXF7g==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 12:13:14 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 12:13:14 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
	<kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Topic: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Index: AQHbdwpytanztMFZ5kSa6adxP+Q0lLM3/t6AgACJ54CAAAfH4A==
Date: Wed, 5 Feb 2025 12:13:13 +0000
Message-ID:
 <DM6PR12MB451696EDF6DF09074926E8F3D8F72@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
 <20250204133957.1140677-11-danieller@nvidia.com>
 <20250204183427.1b261882@kernel.org>
 <2ca4e13a-c260-40dc-b403-5cc73e664e02@linux.dev>
In-Reply-To: <2ca4e13a-c260-40dc-b403-5cc73e664e02@linux.dev>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|PH8PR12MB7424:EE_
x-ms-office365-filtering-correlation-id: e955008a-a857-4453-274d-08dd45de7723
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGZGaWJnRlM5UVRsZkl3bFgzaS96blZOeHJpQlgvazVkMGpDZUphenlrZmM3?=
 =?utf-8?B?VFhLa2xiSW9sNmMvWlhmMVBDbHJRaWZ5NXN1RnMwSkJQYU9VamwzUVNlTGg4?=
 =?utf-8?B?dVZDaktxVGFEYm1UbGc3WmF6VFdmRi9DWEY2ZjYwVlpMbWYyWFNpd3R1eG5l?=
 =?utf-8?B?NXdDNkVOZ0FFeVNJSm15ZFJnZGFmYkl1Rm1MQm5FdUpFa3hJZWJxWXBrMjB4?=
 =?utf-8?B?Y3BXeGt5VS9NN2U0bk5lRFo1R2NCUlkxb3UrbXhXR1lrd1pWOHJ4cVk0UGFS?=
 =?utf-8?B?UmRMK0d6QUdadTJUYytZQ09pTUp2Nm5NdkxPT1BKOGhJUmZFSUJqWUFndTFv?=
 =?utf-8?B?K0FJZHFwOW93MG9CVXdJakhGdEtxS1phenJhNXJBWU9ZclRVMVlPbDM3MHZ0?=
 =?utf-8?B?MGNJcGhEVHNBMFlXa3MzbTdhYm9xekp1bGxLUk1MbzNZNzQvYXg0NndQdDVr?=
 =?utf-8?B?VmhJUjEwWU85UUk5alNtdzJMRndicGw3dDJ0YXp2YUUzWXIzT2FyRmU2NUZB?=
 =?utf-8?B?dzd5czBXUWVpNzU1TjE0MkJ2b0RtRlFnY0Q2WEc3czJKR1FEd3hNbkZvQVB4?=
 =?utf-8?B?VFFta01TN3c4TFdJL1F3L3A0eEVDT2pSWWMvN2ZlbTMrNlRzeXFmTldPM0ph?=
 =?utf-8?B?Rnd6R2w3Sm4zNHM2K2Jkdm9lRjE2QzhMNHRxZXhFSmdxSnl4TXl2WlZFN08w?=
 =?utf-8?B?MWMzMkZTYTBuVy9FOXVLdW80cEtxeE1WTDdnOFpndDFiaHRpbzM1WkRnc0tr?=
 =?utf-8?B?WXkzNjk0VjhUdHFrVHI2c294eFhLTktZTlZlZW5XZkU0c2xYNWVPbm5UTHJm?=
 =?utf-8?B?a3hXUFNNSTZVR0dDSHZhNGVvU0UzTnRHb2ExOUtNRGlzMGRNcnlIeGl3TnBw?=
 =?utf-8?B?REZIY05CYjVMcHdBaVpqTnBRVjMyVGlsSnR5bTJTWGdEN0d6WmlqNjNaT3Yr?=
 =?utf-8?B?dUs4TlR0MWZBTEthSDM5Ujk5UndSV2NucGxHK1BGeitoWkpXVlV4ZnVQRmhs?=
 =?utf-8?B?RjJJSjh1SnJjaHhDd3BMbEExbXJ2Y1lZR2NNb2MyTmVEZEFiZUplSDN1Qmli?=
 =?utf-8?B?ZnhxMmRnM2IwMUo5aUplUGNYdTBQazBIczVmYTRzZkR4N3Y3d3B1QXdpMVVr?=
 =?utf-8?B?aFFOT3EraUhHeTFDQ0ZmV2ZrZU1KNjJBc2Ira0QwbzVsUzNsQ0xhRE9uK0Ey?=
 =?utf-8?B?bG5HNnFJUnJGT2NJWWdBMVZJWTFjdnJTZXdKdnlxUU1XalZoRHFnc3lacS92?=
 =?utf-8?B?NTBVZG5YUjYvNEZYRmc4TnBlMzRrNmhzQmVnVjNOS1NoQjBOZC9rMnlheUFN?=
 =?utf-8?B?Z3pCYmx6QlUxRHNGOGl5S3Q5Q1l0cVdDLzVTeTR5aG9PL28xNjVYd0xOdkZZ?=
 =?utf-8?B?R2F3Uk5NUUlYR0RzeGdDUUtwWGhjdkx4dnlDME1mc0R6QjEyeGdlRUhMb3Vw?=
 =?utf-8?B?djdwN1MvYTN6N2dKYkJIaExST014QkxaSC9RT0VuSGU4alpPcm02M0dMM1By?=
 =?utf-8?B?bTVSWWN6UVhtU0RnY0VQQVJiKzdKSnEyVnljRUdVTTVpOUxDV2h1WWRwU3l6?=
 =?utf-8?B?M0ZBQkFEOTdJRGpmNkpSdjlJQkpTTkwxNC9rMHlIRzA4UW9HQXNwVkZLaEdS?=
 =?utf-8?B?VWdmNjVDUjB4a01VODRRcWRkczBKVmtpWWJrQkFvQXNtQXlFRzY4dzlEemxB?=
 =?utf-8?B?ajB0WURPZG9TWkFjaUpseGFoRmRHR3F2a0doYzFWK1R3VGwxZCsrV3dWckxI?=
 =?utf-8?B?QkNXUUNOTXdFMlhROWEvd1lMM2VKYnVrUURUYkVsSkJaM0w5dGpmNEcvOTk1?=
 =?utf-8?B?SzhwWmpMenB3NWN6WlNYdkxWSEVhOEc4blVBUTZXTzdoeVFpMFpnMERTQTds?=
 =?utf-8?B?STZ5VnFQN2JMV3lqMGU1UjUrRVNLMU5LanBuSFdObmtKUmkxNkhIUHozWlln?=
 =?utf-8?Q?6rzdJpa6t8ncyBZWCHmulB//MObAurQw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTJIZlpKVDlnTU5vQ0FrSUt3RE5iZG9VOVZZcFpxTzR1cHc1SmZ2Z0MxdFJt?=
 =?utf-8?B?Y3hXY2pXMjdkdkVwSzFHT3pYRFIrU3JpVE8xaVFYZmo5NWRCMWM1NjhUZ2Ju?=
 =?utf-8?B?KzRGK2doZ01HSUY5R3pJS1pWVlRxQlVEek56b1ZvT1VCOXphaU1jZ2RLWkFL?=
 =?utf-8?B?THIrTkVTRStIT1puZmtuMzhvWVpzTjdMYkdPYmNYZWk2dEwwNTlBc0lYTER0?=
 =?utf-8?B?UVZkdE80M3BOdTh5enI5cG96UjJSOTlBam1MYURJZFNOVkUvZTBzODBzQ1Zl?=
 =?utf-8?B?RUR0LytVcWxLRE52OUhneXpLcTNvQzMzNHhLdGh4T2RCOHNCNUpnYm1wNmha?=
 =?utf-8?B?MDlwSk1iYlJzVzRReGtWUExQSFpvTHM4eHdyNDRFSERhM1NxUFo3QUpGYU01?=
 =?utf-8?B?bGw1WDNqak1TK2IwamRSV3hEcHIvdWR4aEZrR0ZkRFgwNWhnYnJMOFJsTHFi?=
 =?utf-8?B?Z2h4WjdGMGY1QUt4MERheExLOUsrM1NjTWtSM3F5emNiRjZGYXRRSjU5R0J4?=
 =?utf-8?B?L0JybkNoaG82QTdNL2I4QVNiYjBKemRMYTFGa1FLVHhBZEVJRFJjMkZrbkh6?=
 =?utf-8?B?YkgyMEdMMlNPVzN0dUI0TmVDNXl5NDRWb01sUi9GUDBldzlHRjNibnZTcUY1?=
 =?utf-8?B?eTdzN1FOVFg2RXk4MU9wYVZaL0hUTTk3VzN1RW5OUVR0akw4VHVBNytaMUQ0?=
 =?utf-8?B?V3dRamxqRWQzeUt3VEhnZUc5c3Mza21LMW9vc3g3RnZBYWlZSDNjZjY0Vm1H?=
 =?utf-8?B?dnFKNFhVWWY1dUFTQ2VQMWVFRzFPa2JuSnR1NTlVM1ZQdHRVQ29hWUcvUzlL?=
 =?utf-8?B?bFZsa1NRMndIVEl1L2JReFlOYXVKSmJDNjYwNzdvTUNqRXVNYWZZSEZqSXAw?=
 =?utf-8?B?RnlRQ0x3VWkwWEtWcy94WkhoRGIvemgxMFkxZEZFelpXZXBVaGVHSVdIVnQ1?=
 =?utf-8?B?MDVKOGVFTUNJYndpOVVid1pmc3paSTNWSFkzMXk4YjhvR3R0T3Q5SHhhdHB1?=
 =?utf-8?B?Y0QrN0ttYTNUNVdRZ0NXMFhMSkhrOGZQR0JsNW5VV1RSR3dON0QycXQ0WDZ5?=
 =?utf-8?B?ZGZlejAvWndDSkNEUkNGd3dyajA2L1Vsc2tBSldFaVpLY2hzYzNDZFBXRE5K?=
 =?utf-8?B?MkJIbWtZQ3NERTFGdXpyR2dMTllSVUpsWnEyVnZRRmpFalc0VWJUWU0rS2Z2?=
 =?utf-8?B?aHNvdHJ2OXdtdlNwb1E4RUlsOVE3Y3NxaFNEZUZNdFdHblZ3ZnNPOVJlQ2hJ?=
 =?utf-8?B?VGs3em8xMGd1OXJPTkptbHZjbnRsRi9WNTZpTTJ4OVJmTUNjWUIrOXlIaUNn?=
 =?utf-8?B?aU02blNBdTJQd05Yd0E5RXB3clhVZU15T0NkK3M3R3pTcUxBQk9lNjB5ZGYx?=
 =?utf-8?B?NlpBcEdhcm9pZWR4OFN4VmtHeC81a2ppTXllY2RZTGlPenh6bmRLdnF6NWxC?=
 =?utf-8?B?MSsxTjJOV2F0cmN5d0F0bjlrTEpvbnlnUXd4NktTTUtydk5SVVVlMS82TDhz?=
 =?utf-8?B?aitPam1GL3BNUlVGbUpJaC8wSFNDVDZ0MUwvNVgwVWpNakVFbmRhYUE1ZGZ6?=
 =?utf-8?B?NWJucXF6aHEza29heU5qbGlRZGpXZDJVVVl6M3BzZXVKNlZLTVUyYmppQ0V6?=
 =?utf-8?B?UWFQVmhvc1VPdDFlRW40NlZ3SzlhSlJjNGdyZzZ4S0c1M1J1cGtzdXk5a3U4?=
 =?utf-8?B?THNoc3cwZjBQU2dFeXkyVHJ4cDRxNDFnZFYwSkNlYzhIZGNQZ293Y0l3VEt2?=
 =?utf-8?B?ckYwbG8zR3NSS3ZVZ2Z4VUJRRmwzb0lLR1MwMk1rNk5vVFVBdEtTQXhDN2la?=
 =?utf-8?B?dHJuWDcrcWZYRk94Ky84VEZvSjFyQkRtQWl2VXRMR1JtZjhnSjAxZHZ3V1dK?=
 =?utf-8?B?SFJhMEI4OEVJRHppRjdvTlRuNHJtdU5DRXJiODR4Y3lNMWhTclFMVTdaZld5?=
 =?utf-8?B?azJpYWpDN09vMG5vWWhHSmZpeU5EUWluSW0ra1g3TWRnUmFRRDFrc2dBNk84?=
 =?utf-8?B?dzBnRUFNYytYRVlKT2JyZGk0L29rZ1cwWXZuSmtWb2tnQkpCZS80aFlVRnUz?=
 =?utf-8?B?WGZTSXkwZ2c2aTk5ZmJjQU9GRTZkRWErNXIvblpGNXdnanNDbVgrbHQwNVdI?=
 =?utf-8?Q?1XaPnthXObjribPxWodVdhhnr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e955008a-a857-4453-274d-08dd45de7723
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 12:13:14.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAhYy+/mGgoSpdyCMNluuLSCpoYNhBAiZ/ArWrQCMRHsEUtViE5YRiZhueP5WsZ20uZuacgS3rRuEEtMiwh6Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

PiBGcm9tOiBWYWRpbSBGZWRvcmVua28gPHZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgNSBGZWJydWFyeSAyMDI1IDEyOjQ4DQo+IFRvOiBKYWt1YiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPjsgRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNv
bT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IG1rdWJlY2VrQHN1c2UuY3o7IG1hdHRA
dHJhdmVyc2UuY29tLmF1Ow0KPiBkYW5pZWwuemFoa2FAZ21haWwuY29tOyBBbWl0IENvaGVuIDxh
bWNvaGVuQG52aWRpYS5jb20+OyBOQlUtbWx4c3cNCj4gPG5idS1tbHhzd0BleGNoYW5nZS5udmlk
aWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGV0aHRvb2wtbmV4dCB2MyAxMC8xNl0gcXNm
cDogQWRkIEpTT04gb3V0cHV0IGhhbmRsaW5nDQo+IHRvIC0tbW9kdWxlLWluZm8gaW4gU0ZGODYz
NiBtb2R1bGVzDQo+IA0KPiBPbiAwNS8wMi8yMDI1IDAyOjM0LCBKYWt1YiBLaWNpbnNraSB3cm90
ZToNCj4gPiBPbiBUdWUsIDQgRmViIDIwMjUgMTU6Mzk6NTEgKzAyMDAgRGFuaWVsbGUgUmF0c29u
IHdyb3RlOg0KPiA+PiArI2RlZmluZSBZRVNOTyh4KSAoKCh4KSAhPSAwKSA/ICJZZXMiIDogIk5v
IikgI2RlZmluZSBPTk9GRih4KSAoKCh4KQ0KPiA+PiArIT0gMCkgPyAiT24iIDogIk9mZiIpDQo+
ID4NCj4gPiBBcmUgdGhlc2UgbmVlZGVkID8gSXQgYXBwZWFycyB3ZSBoYXZlIHRoZW0gZGVmaW5l
ZCB0d2ljZSBhZnRlciB0aGlzDQo+ID4gc2VyaWVzOg0KPiA+DQo+ID4gJCBnaXQgZ3JlcCAnZGVm
aW5lIFlFUycNCj4gPiBjbWlzLmg6I2RlZmluZSBZRVNOTyh4KSAoKCh4KSAhPSAwKSA/ICJZZXMi
IDogIk5vIikNCj4gPiBtb2R1bGUtY29tbW9uLmg6I2RlZmluZSBZRVNOTyh4KSAoKCh4KSAhPSAw
KSA/ICJZZXMiIDogIk5vIikNCj4gDQo+IEFyZSB3ZSBzdHJpY3Qgb24gY2FwaXRhbCBmaXJzdCBs
ZXR0ZXIgaGVyZT8gSWYgbm90IHRoZW4gbWF5YmUgdHJ5IHRvIHVzZQ0KPiBzdHJfeWVzX25vKCkg
YW5kIHJlbW92ZSB0aGlzIGRlZmluaXRpb24gY29tcGxldGVseT8NCg0KSSBvbmx5IG1vdmVkIGl0
IHRvIGEgZGlmZmVyZW50IGZpbGUsIEkgZGlkbuKAmXQgZmluZCBhIHJlYXNvbiB0byBjaGFuZ2Ug
aXQgcmlnaHQgbm93LiANCkkgY2FuIGFkZCBhIHNlcGFyYXRlIHBhdGNoIHRvIGNoYW5nZSBhbGwg
dGhlIFlFU05PIGFuZCBPTk9GRiB1c2VzLCBhbmQgcmVtb3ZlIHRob3NlIGRlZmluaXRpb25zLCBk
byB5b3Ugd2FudCBtZSB0byBkbyB0aGF0Pw0KVG8gYmUgaG9uZXN0LCBJIGRvbuKAmXQga25vdyBp
ZiB0aGVyZSBpcyBhIGp1c3RpZmljYXRpb24gdG8gZG8gaXQgaW4gdGhhdCBwYXRjaHNldCwgY29u
c2lkZXJpbmcgaXQgaXMgYSBwcmV0dHkgbG9uZyBhbnl3YXkuDQo=

