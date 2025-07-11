Return-Path: <netdev+bounces-206166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9148FB01CD0
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 15:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38506B440BE
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3042D948B;
	Fri, 11 Jul 2025 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oNHA6n5L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A1E5258
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238923; cv=fail; b=EwQ5NkDTVXl1ASmd3IOrhvoHE3ZJsuUy3XnnyZufaV7ePYuDxGtUBo5SaiU5iLjCmXApxU7XZekwYZDVnI4VeI2NT/TsuYvDuQU6X63Y0V5Lo1sm9FHcTxNoWkeKKWfhn7zmkyeYBrhvw359rUl7twCWYnk2vMRY5RYRJlmy0W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238923; c=relaxed/simple;
	bh=VRO/DquLTA2ZIfiewS4z/3CmkTrEQf/njcag6rwHQGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BgL0A+2aIVJ9K+Xva9xaohnZEVobaHd7kjQXs6MNkPTkBfA/W6Cm+YsF6Cgv7QI6rk53KsxudzRHER9pIVgqdcBH4zLe71fMU1j5t7+XFOM5FF7Gtp8C+oqkdgRok6mxHfTLL4m2U8Q536FseCIfGUi3yY1PGFJhGpZnW1OXYag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oNHA6n5L; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2k+ataMiEWYdqxuJnIlufbemtAdkxGiesheObX03UEJ9gM8EuSSRIMF//9wb8l1iDC3hL7Tp1jAFdeDlLOQED9sapCx55rLp10lnfJMYAkV0c7K+U0hB5hfNNJIEq7NR0rQDO4Ma3glETwtHVKW8t2jAlLy8jh6J+/W+A6wcNzcGuGdAZBgkhO3fW7hl4L/xap3TWWcT6o9ivu9gFl3+NPkM3BRDlO31zSpY41VJ2VjqytiDE8OInE4JNz+TcbMIdV2IZiyPQ4Xu4PEZvY1/or3Jq3MOxe+y9B2s/HJ7MB82OrRQdF09Qskgoo7fUkpicI8hmjGgIGXn+KqHAwkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRO/DquLTA2ZIfiewS4z/3CmkTrEQf/njcag6rwHQGw=;
 b=cvPizbJxkgMWOoalROKoyWHKLRandci11RnpTqEcDMdm0UAMx6zkJ/HK3qgRBO15qPOMSADbHiyMMzJ5ECAEGQqbkxhaNB8Od+HzCdZKJiw/4BzycUUuO2whpBOEIOyuyTBvwtDBHz/NE+/6d2m6TxxLWpCXBTaL5zvBVFcH++w5S1Ttf8IAA1cY6cuOg6n7OY5086FSbwWwrTuIudPx/7eBYV2MTq70AlD8sIUORZa+K4cXgZUywWxmDT8CjF6zVj3Nmr1oasMUXeprYy6hHR3ftaME1Xpaw3ha/SsG/RDkc6uUUizUhMDEEbFU6JpIbbYP/WC5q0OL3WKZJI/+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRO/DquLTA2ZIfiewS4z/3CmkTrEQf/njcag6rwHQGw=;
 b=oNHA6n5LGxjnzHG0wxOxIYRN70zBHGq1sS8YGuThf43b0HUafCXHG6ttUBIELlPCfNpsDIPS4m+ErJu9Td7zHBJNrI4+H/AezhY4SSYGo5ixCADchNkZ380sXtJOMJU7wnMx0+hNwaoUDPjnN/MwUVi6DzwVpFvmpbbkq666e9xe5PcjhGMk5M6/B8P1a3T7BExGvySqHpVi1ZrMQ4rGPK5XkqT/FgA/fBbLlTfgV/9cbjJKMeWnY1uyyAN+1Qjf5+PzpUAKQE65sem7z3Y13S2ke7tnDhR/T/DImKpua/QgA2gWQtk8G5nxrHB5uFtEHZWKFHw1pcEkG/5Hh97aMA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by PH0PR12MB7009.namprd12.prod.outlook.com
 (2603:10b6:510:21c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 13:01:58 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8835.025; Fri, 11 Jul 2025
 13:01:58 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "corbet@lwn.net" <corbet@lwn.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
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
Subject: Re: [PATCH v3 18/19] net/mlx5e: Add Rx data path offload
Thread-Topic: [PATCH v3 18/19] net/mlx5e: Add Rx data path offload
Thread-Index: AQHb63UFQV6wiCnpD0qP/REP//5Kp7Qs8QyA
Date: Fri, 11 Jul 2025 13:01:58 +0000
Message-ID: <9cda21ef8daef64cc88f2948bff3757d06af3377.camel@nvidia.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
	 <20250702171326.3265825-19-daniel.zahka@gmail.com>
In-Reply-To: <20250702171326.3265825-19-daniel.zahka@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|PH0PR12MB7009:EE_
x-ms-office365-filtering-correlation-id: 2f025f22-4da0-481a-49ac-08ddc07b1eca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QnVueERUS01RTGNMb2FiRlk3b05NQmJTQis5NzRxQXNrZnpuTWxSY3Q3RHRJ?=
 =?utf-8?B?RlpUVnFaWHJ1OTFpR3lENTNiUjB6WFVYQ3BycTgwajQrSXRjOWJoTXQzQ2h0?=
 =?utf-8?B?b01ocTNxZEUwMUErbEJuZmphOWRVQ1IzcmlFemlDY3pRbDdNa2tTK0c5ai9K?=
 =?utf-8?B?KzltbkllS3g0SXZ0NjlNbEFzN1lwbzBIbTI0M3BPcGxITzY5TGd4V1lzU0Ez?=
 =?utf-8?B?TzFzQkVTUDJDNDlUcys0SGFOVmwydGJhNVlERW0zemVTNFhoTlhLMWJlS3hz?=
 =?utf-8?B?ZEtFSFprSG9jOWZCSkg3VEFBWGkvS3JOLzc3ZXZlbEtqVXNKYS9nVHVwaGsw?=
 =?utf-8?B?Wi9TTnB2SzZURDYvOENaWG45a3VuUnhpa21VcjJVN2RWLzRlU00zMExUbnVT?=
 =?utf-8?B?RXVNbWlJTmdOWkUrOVUrMWNhVjhkV1Bvc0R3NUV1TnpkTGJBLzRaenZtR1Zr?=
 =?utf-8?B?b2NlN1FnVUJWQzhiblFrTDhOUTB3SmxyMWxkRVN0V1lYeEt5S2czdGNGVVFE?=
 =?utf-8?B?UXA3UURtLytHdWFxYm1HdzlrY1BHNElMNGx4ck8xM2VkNnZDR2pVdUZRS3Jx?=
 =?utf-8?B?MzZROFluYktyZjByWkYxeTRYZWdLMFQvNk93akZCS2hna0xsQmVnaEJ1U1I1?=
 =?utf-8?B?TmdYN2ZJSGhJVGJZSlJRYnhDeTJoNnYrNERhVFNLY0FxYSsweWtDQnpkNnUz?=
 =?utf-8?B?N1lYMUpINVBDTmF1aTBMMC9IdytnRFo0YlVYQWdURlVOOTYzYjZmUUpwaDZi?=
 =?utf-8?B?cE5uVWthQ0tRa0F1ZjlmVzY4OGhZNXlteGNtNGdRd3ZTTDBXWGhTWXRqMklQ?=
 =?utf-8?B?UjVHbHJ0Nnc1VWRuWjQvbm4xc2pGQnRTNE9MTGkzV3MxMGo4ZTBrdUtIUlVM?=
 =?utf-8?B?cEp3WGxTUHRKZkkwd1ZaTC9PaER0VnUza2x1ZzAzYmpZVmRIZm12eGN3NndI?=
 =?utf-8?B?VEIzNHE3Q1k5b1VETFhBZ0hqSXVZRHRYd29HWWJyT1pWK0pkN1hyQ2piRUdy?=
 =?utf-8?B?aks4ZTFiRlU2N3YyUWxoaVlXZXZIdlJ1c08zRERKRzBBV1ZvNnNBdzNKSU95?=
 =?utf-8?B?M0JFVm5QYXUxM3dkQVQvVXZISWJtOGdPaldwWGZsZnJ0VzA0ZmZwRkJlcFA2?=
 =?utf-8?B?OXFENmRaY0tmQlhRTThNbEJWZ3dOamJ3MDBSYkdlUkpnY1FVMldhTm16QmlY?=
 =?utf-8?B?Zm9DQkFvZzhkanMvUG81NmRzUkpUT2tyb2VxKzdtdW9kRFJ2YWRKWlRrdSt0?=
 =?utf-8?B?Z3FIZXRhQUJsWjF2ZmZzR1ltUFcwRzBLWURvaUJqUmx0cVlOQW9WbVNDNHNF?=
 =?utf-8?B?L3k4UW1na2RzZGkrQ2ovU3ppZy8vMlZDc0Q1Q2tVU3FlcEFkY1hhMHVvZlJw?=
 =?utf-8?B?dk9lemRVeXBuZnlPTHdVSHl3Y2NqVE9qcHVVQTkwd0dGZFBNMndnT2NBeWx1?=
 =?utf-8?B?K1drb0VMZDBuYU1UTVRjWWRyV05DbzB0Y1BKQlZabzVvVnd3Y05hNGZxWjhk?=
 =?utf-8?B?d1J1WDJNRDlScmk1R3lYQ2xRNUV0QXQyaHBKMzN4TGpCS2xxWG8yZXJuUjBj?=
 =?utf-8?B?VTAwSnYwWGU0QmxiUHJ4cnNESDByMUhFbG9ocVhoYWszSGVuZHFzbzlXT0xi?=
 =?utf-8?B?SzVyZEh6L3NqZVhHRTZIcFp5c1NNTDBYRkVtOFdHU0lqZWhaUUFLWThNQ0Er?=
 =?utf-8?B?ZHFrNm1vSmx2MWI5TmFhN0V6UCtCSFVtT0E2aVluQnBBZXpFTUJRakxVVmlQ?=
 =?utf-8?B?bitzQkx3ejQvS2ZHNkNYd0owM0I5cm05M0lsc2FISGRjOS8wa3hzYTgrSUI2?=
 =?utf-8?B?QlhhTmJRVWFWY0dzR1NhR2hTd0ZLZzNWZ29OZWE3MnFKS2J6dXh0T040Rkg4?=
 =?utf-8?B?V3hQZ2xJN25FRnBYVzhKRVh5Qk8wdVRRcWUxeXpyTGhuU2ZHTzFWUHZqUVRN?=
 =?utf-8?B?cXNSZEx1b1l2RGJWdVUyWXFQNXRDc0o5ZWdNNXBZVytJQ0d3N0RoUnFYK3dj?=
 =?utf-8?B?K0ZMb1dzUkpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEZLUm1UUmZnRnpFeWRoN1Y5ZTFQZWpRK2ZzaWVEcXY4eE9UcmdrYjgxQkZp?=
 =?utf-8?B?UHJvK01pVmRnRCtmMlUyQUxWMVFydFZtaC8zRWl5WlFkWkNwSTVBUzgyS3FZ?=
 =?utf-8?B?SUhod0Z0cGR6NGo3VFpyaXoyZysrazdaQnl0YlZwOHAyY1pGd1grMFBOUnBN?=
 =?utf-8?B?b095Nm5VN0pXcHI2elArY2VrQ2t5Y21VNzFvTkJZYjVpbnFlaGRwTFhURlpp?=
 =?utf-8?B?SUt6Tm4wVVBVUXhtbk9Nb0drNGRFMXE4STR6ZUYyQzdoV0xFSGd3cjJRMGNU?=
 =?utf-8?B?R2N6YUl2U3hUd0FDV0w3d0Mwb1dtenBCd3doalVNSG5IMEgvbmlYRXRsSGJz?=
 =?utf-8?B?NEFMam1BLzVVVG5HMmxac1pEazcxdUk0Wi9TOGRuWnQ3SnY4eWxMSUR4Q1Mv?=
 =?utf-8?B?R1hoeEErMU9xSng3V1ExeHU5aExqZHJRTzR2R290SG54RVVqYmlqc1pjbU4w?=
 =?utf-8?B?c3MxV2hqdGlQK3ZmSHBCT3lEZGRMU0kxNmFXN2ZpOWJzdDNtajdJbWpOdTkw?=
 =?utf-8?B?d1pKNExhTTRGMTVOL0paM0JoOXNHbWl0cjFTb3BoQnhZK2I0RS9qNlRRZDBL?=
 =?utf-8?B?MWJTSEVjZWZZZFF4WUVGQ05RL1VrdWV0SWMyaFFGMTBwWldGMVpzSGtjVVVN?=
 =?utf-8?B?Z3JxUzFvbjRSOTkybkxnSGdnc1BHOUhaYjl1OStCZk52U2xPWFRMMCtmemJ5?=
 =?utf-8?B?L0pvcHdoMXdiYmY0b2drcVUyaEJCYjVqV3RqYmhKRlUrbGdwemxqUUIzMXdk?=
 =?utf-8?B?Q21CUDE0dTYzMWJ6Q0Q0Z0dKdVlNa29qM2EvVUNmbDIzbzNvMG1rR3RueHI5?=
 =?utf-8?B?TjhWdDdjUGprT1VaQXF1L1cydHd1RzBsTXc1Zi9EMWtSeUprYThzcEdwZG1y?=
 =?utf-8?B?T1lFTHRTSVNiU0txOFVEZnRpTFhRZWlxL1dpZy9LeDJ5WXZYOUtLMDNtMnVV?=
 =?utf-8?B?a3BsTkVjeC9kNlg3L1JYK013T3dPSkRQYUlUcVVjZDBxWG9RNXAyWWJiaVJ2?=
 =?utf-8?B?OWtLeHMxcmVaTjUzZG95Q1UvOTUrbGpEaGwybHdydHEyaWxreEwzUVJWUjZn?=
 =?utf-8?B?dVZkYmJYS05FWVhsOFpSdjQ0WXYrYVFYRHUwZTI5NkdWY2prY3dGT0NSZnpx?=
 =?utf-8?B?TTg5SFM0bitwRXljam1qdU1sd2hUR0hJMFdFd2NEd3REL3UyTng1b3VqWGI1?=
 =?utf-8?B?T1krcHdoVVkzRFpvWDhEODdETjlRWERrdjdRZVdzUTNlbHlMTm5OeXhxSmtO?=
 =?utf-8?B?c2h1RWNKMkV6N0cza2MrMVFJNHdKT2FicVhMRTEvdU92S3FVZWJ0VnM5cnZr?=
 =?utf-8?B?bCtvL1ZicXpEOHh6dXhnM0lpWTlZcVVPU1FLMWxsSGN5S3Z2T20rMW9hUkFV?=
 =?utf-8?B?bXNUdGlpcTdiZ0k5cGd5K1o0SmxlSm1XUHBlTUN6eWhaOGJ1a3RLYTUrOG5t?=
 =?utf-8?B?Qmw0N0MyVjg3ZVBZTC9sc1NTcWVpUmlCckpuZ2lOMmxJc2VFeHQzSGpEUldV?=
 =?utf-8?B?OUZzTlRMMmhpZmxpbkNuQ2xUWXdNbzhmTlg2Z2JzV3dnRk93a2tPUlRSaFBj?=
 =?utf-8?B?SkNDSENqbTJLdmxHN2E1ZWFvSDExbGNMNXdZL256NCtZcXFGMDdNeTFGVFlH?=
 =?utf-8?B?UFY4NU4vVm1GSnI5Yyt6bVMvem1mUkNRYWhFbDlXSXpHS3diVVgwZEUvR1Bw?=
 =?utf-8?B?bm5QOFd3RmkyRkJvQUxsaTQ5dCtVb0hMKzhGUGpJekVpVFlmeHIxZFJqYy9K?=
 =?utf-8?B?TmswODRzZmtmYkpWUldjYVY4NklkQXNWYk1VVlB0SmVhc1phd0xneUxRcjR4?=
 =?utf-8?B?QnhYbTMrU0M3aXphczhEUlNZb0ZLdmRENHJhaXpzVU5qRGxXcEQ0eit2RWFK?=
 =?utf-8?B?VzZ6bTZZSy91cThBeUlpMDBpcFlLVUQ0TE1ucnVyLzBTeTRYNzNhVGFTR1kv?=
 =?utf-8?B?eHgyVmFYeDd3YzMxbVNjSm1WNnNJTUxNNHBlTGZHdDNSSVdqMU90UUdGaUlB?=
 =?utf-8?B?aVF4cXBod0kzUVUzZ25TYVJ0dXNKaVRxK3VqUGdlZXRqTFhtaWp0VmFQblVy?=
 =?utf-8?B?RDZlbmUzakdPdHdsMGFGV2FsTU9kNnllRnNpdGEyNjRxcktiZ05CQ1dOcXVy?=
 =?utf-8?Q?Gvmbm9lnQ5fAZL9goTfDNrXgC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D0F74466E52BD4990E128E71F5939E6@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f025f22-4da0-481a-49ac-08ddc07b1eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 13:01:58.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iyE5ma01VwFHAqyKq/YWedYKLk4MngscgXho7t5yO9ndd0HOko+XgoOFd5jiRxVhUBELrRMUcqunpAqx18v2+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

T24gV2VkLCAyMDI1LTA3LTAyIGF0IDEwOjEzIC0wNzAwLCBEYW5pZWwgWmFoa2Egd3JvdGU6DQo+
IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUv
ZW5fYWNjZWwvcHNwX3J4dHguaA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21s
eDUvY29yZS9lbl9hY2NlbC9wc3Bfcnh0eC5oDQo+IGluZGV4IDUyMWIyYzM2MjBlNi4uZTNjZjM0
YmFmYzI0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZW5fYWNjZWwvcHNwX3J4dHguaA0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
ZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvcHNwX3J4dHguaA0KPiBAQCAtMTAsNiArMTAsMTEg
QEANCj4gwqAjaW5jbHVkZSAiZW4uaCINCj4gwqAjaW5jbHVkZSAiZW4vdHhyeC5oIg0KPiDCoA0K
PiArLyogQml0MzA6IFBTUCBtYXJrZXIsIEJpdDI5LTIzOiBQU1Agc3luZHJvbWUsIEJpdDIyLTA6
IFBTUCBvYmogaWQgKi8NCj4gKyNkZWZpbmUgTUxYNV9QU1BfTUVUQURBVEFfTUFSS0VSKG1ldGFk
YXRhKcKgICgoKChtZXRhZGF0YSkgPj4gMzApICYNCj4gMHgzKSA9PSAweDMpDQo+ICsjZGVmaW5l
IE1MWDVfUFNQX01FVEFEQVRBX1NZTkRST00obWV0YWRhdGEpICgoKG1ldGFkYXRhKSA+PiAyMykg
Jg0KPiBHRU5NQVNLKDYsIDApKQ0KDQpOaXQ6IFRoaXMgc2hvdWxkIGJlIG5hbWVkIE1MWDVfUFNQ
X01FVEFEQVRBX1NZTkRST01FLCB3aXRoIGFuIEUuDQoNCkNvc21pbi4NCg==

