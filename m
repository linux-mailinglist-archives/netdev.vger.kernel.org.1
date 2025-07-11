Return-Path: <netdev+bounces-206167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF4B01CFC
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 15:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81235C3819
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC82D0C67;
	Fri, 11 Jul 2025 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f+y34UPH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6252D23AB
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239179; cv=fail; b=FKd+433uu1H0G10OFdFOwGuK3EaJbuaWqllsyBvRPN8q2cvb3itJQsgFMnqHYViPILlyiHgsypWf8wqVRNeAh8MqylTZ0OkEh4IOwLdKFnU5Nacuk6669/TpbYp+Ns/JLI7GzX2cQgD0I2EHiFGTMyBuSaPZaCF9WnwI13jjqGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239179; c=relaxed/simple;
	bh=24f2TvaSFXQDXZ74+5cxDx3dYdtlhRjUukhqbNED488=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ao4jfs9OyA1zozIuUHhjw5Dyn/QOx5Wq6B74NtqdDgPp3WLs4PHEs7ezyGq8tSUQ1ncn+zhE0Yj1Xtk2MzPzV34S0HpuQi7+9ruMWtreH0wkmkKDCYcOs+0wIg/zptZWS4sqC/TNecYElVgb+LsFSaHzMdSiUqo20kEtJXTWsKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f+y34UPH; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1LNUPg0DBWF+SMvQh9xDgTy413iu3KoISVpq3cG8QTr1bpXllmc5jZumwD6rVEI2Agh7+TTefE8C33QKcFbqe7QvJ9awzrajAFAYxJ5EYE4fPsyUO2RM120Xfa3QkJ2sq+4YkiIfe5+1zp3kN8+tovDLq/eKstR1w1m1gOC6lFDak1SckVBIn+bd0ULyzxTvsXmnCZYvW1MQYt+77Yn3xopmmZOFRecgsRusJpHN15naI0vDSidjrlTqwdcocDikXJEtG+WLGoO+aMicH/RS1eS9zrth422uwjS5b/LYbD9doGJ0qV3oF770rAxGOJntQJYwmQ91+TQahZKcLAXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24f2TvaSFXQDXZ74+5cxDx3dYdtlhRjUukhqbNED488=;
 b=jRcZWb4PyLHxnijyoQ1krsbJIz9/MkyJtexuazug5EWbW8GkXzcv3rqaWnCMO/8u+Bi6lzzoR2VYiTwx0cKwhqrrf3QT5hmMxeMJn4WCMUQf5nLeA6dE+jbjg8TqlzevG2mMMfdWyhiyIUfUHGpZGojToItknHWHxYu4zZvJvCrMXYTGkZO7EKZes9bNCUz5GMIZi9v59ilW+t7GlgGkzRw6xU6X8aWUYCyrCLYNBBnqQV8JxN7NhLmFOz/4boNiXnMWHWkP0eGflBiMy4Qd2xYs2iXYg2wjySZEhAT5ZwmPM72ghczWXmg2S5zC2C8HwZHAIvOBpTaI4NeHLfro9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24f2TvaSFXQDXZ74+5cxDx3dYdtlhRjUukhqbNED488=;
 b=f+y34UPHdhbjG8o6lhvZnlouvGqFH1n2ExY0+G2nfCdCxpvQ9kOxDNyo6/SjwBNtNXA518HEPjfqc5nQKKYTi1Y2s84IVPhBFKnGqwMJBH94dOVzxe/YFEuBXpqq44HBDc3paEuo6KFH1bWRA7irJG1m2/136VrC53Brw0VvvbvZ0Ygr2LWQJy+LlLPM0awuY1SQ6q9AU/i7WCJ/zzz0l/f9ufmxLGdIdzgMVE2TFcmQp7zkyoArgQi6SLTUtjziQ89yFHzJIDv25xXb87xSPm2cllvWvzxex6cJRU+7SLq73IhjmtmsA8XIbW3drpexZAzmjK3MtuW2n02JC/Vi1g==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by PH0PR12MB7009.namprd12.prod.outlook.com
 (2603:10b6:510:21c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 13:06:15 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8835.025; Fri, 11 Jul 2025
 13:06:15 +0000
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
Subject: Re: [PATCH v3 14/19] net/mlx5e: Implement PSP Tx data path
Thread-Topic: [PATCH v3 14/19] net/mlx5e: Implement PSP Tx data path
Thread-Index: AQHb63TraX10kYasHEiE657aQkBom7Qs8j6A
Date: Fri, 11 Jul 2025 13:06:15 +0000
Message-ID: <0272db70126f24a5ba90b7ce918ba0b88cc55b7c.camel@nvidia.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
	 <20250702171326.3265825-15-daniel.zahka@gmail.com>
In-Reply-To: <20250702171326.3265825-15-daniel.zahka@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|PH0PR12MB7009:EE_
x-ms-office365-filtering-correlation-id: 36150136-1aea-457b-e0d4-08ddc07bb7b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TkREenFRaDVVS2hjSzl6Vm02TGFyZndkd0xTZldSU3FqWCtRNFhzMEFEc3NX?=
 =?utf-8?B?bmJFKzIySUV0bE1iSG5OYnp3Q2hLeWlUUStHeVE3dVc2NEJOaEl4N2E0M0gx?=
 =?utf-8?B?YlZjSGUwQ2xHUmxoL09GbXhYQmV6Q05vUGFLY0RINTczM0xVWGdTM1ZvYTIz?=
 =?utf-8?B?bjhUcHA0ZThoQVhEcXdPSXNwTWpmRTB5K1BPV0FGdVZuRmxBL3dPNVU0d1BO?=
 =?utf-8?B?eldDNzVjV2E3MjNNOVJsNEFnUXM4Y0c3SEtXRlhQa0J5VjBUek5ERCtrc21h?=
 =?utf-8?B?MDIySE5GVHlZeWdaazU3TldnUmpnYVpob2xjSzhzOEVpNzJSbnNqMFlzT01w?=
 =?utf-8?B?SHZNT2RSU2pOaVFZeFpuZ243bFpYSkNyYjAva1R3OElZaXl1M1pvYmxHdk1l?=
 =?utf-8?B?NUJvSW5xWmlIYlRaK0czOTI2SlV1emplSlpka0Q3empUNGNwWnpobFhRaCs1?=
 =?utf-8?B?dXorcCtLSDRNVitLV3lRREZJNGkra1QxY2ZLdUFNTU03NVluU0Zac3NpdzVz?=
 =?utf-8?B?MjRXRVFyVStlNmlXeU5zS2YrV2xrTzExeDQzdmVsUHRRZ1VENCtxTFV1ZUdT?=
 =?utf-8?B?bzFDcjFHeGkyQU8vazhuNXdSWUtHWkdPUE1FSXEvRU50MXgwcXZCUTNhanJh?=
 =?utf-8?B?cm81cTRMU1MrT1U3bjVXL3Zja2tOVDZFUzRFZURqZnMrQS9lY21xNzlIRUpn?=
 =?utf-8?B?N3JDSFo0cmdtdktzYUFzWnluOHBOUGxGTm82WGhEUk4rZWdWN3JCWUhVZ3F2?=
 =?utf-8?B?azQ5cWRQUUE3NUVGM3FvRHhXZ3dmejRjcWJOTzNQZ1B5a2RDWHFuV3N2eHdK?=
 =?utf-8?B?ekRGSFNsS0Q5U205TkNmNS8yZ1hOeXlFbS9yd0N3NUZvbWU3U1JQd3o4ckQ3?=
 =?utf-8?B?YU4va2JrVkNkblFRemMxMmpNd0l5ZFpNcmZjL1ZCZHlpeW9iYU5Ja1FxcTFS?=
 =?utf-8?B?bldQR2dlUEtBMVNVRzdxbDVzYmlMNk13MHhmZGhyRnpWZFk1TXlvcnljbEtZ?=
 =?utf-8?B?ZUFTeGswL202TnIwbG9TOEN5eDFJRFR2bGE5UnJlZ2Z3ekRJUHdadnI5MzFI?=
 =?utf-8?B?M2R5NURPT1JiTkRONm1ySmdLWEY4cHZhaXFySVlZVWhXT3lGVTNtb2hCU283?=
 =?utf-8?B?dGhHZk42Zzh4RnJXa2svQXkydVREV3N3Y3doUURCcno5R254dnlFRENMc3lE?=
 =?utf-8?B?SVkwSW82WHU5OHhKRHNOemVjK2VjamtreGc5TXpybUllelBuNnNXK0Q5R05W?=
 =?utf-8?B?Wm5yQXkzeXJ5cnQrck1SOHJ4czNlMElUS2x6cWxDRW41aWpab2VBOXFqcUdx?=
 =?utf-8?B?RzRmVWk3WFhnWm5lQ3BkeGdLbndXS1I0QTlpSEc5b3ZzamdaczNFOEIyOW5F?=
 =?utf-8?B?TStGZGx3SE1jSDJFTmx0RFdwdUVMcVRxc24yRktoVlpWeDZmOGdOWW5YcGN3?=
 =?utf-8?B?M0tESXUyZUQzckJTMkRYckFEMytpZVRLQmdBdU5nM29kMyt0S3JzLzhlWFNU?=
 =?utf-8?B?Y2lMb0c0VkJEeWxvZTl2MWdGRkNOdy9uN2srd0xOYkRvWFk4bXRkRmh0dFRC?=
 =?utf-8?B?d0pqa0pMdnEwYVlzcC8wSmtiZnI5NDAzZ3hPTVQzc2xTLzJOUGczQkJHWE5M?=
 =?utf-8?B?SXl4QUFVNVhqTEc4UW90MWpOdUxaQTd2VHpURTgrb0h1S3F1c1dCWGtaSzZy?=
 =?utf-8?B?VUs5SVQrT0lsNUd4ODFCS0M4KzVBY05QTU1hSXdHaDd5aGtNcUNxcm1CUDFZ?=
 =?utf-8?B?UmRwOHh1ZWM1Ky9PMTdpbnZRVXl5elY3bjR3TmRpelhVN3dxNk1YTGM2WjVI?=
 =?utf-8?B?WG1QeStrSDdVMzRYUVkvUEJmTzRrdlk2RUI1eVFoMWpOQnY0MGZVMlFIUmVh?=
 =?utf-8?B?N3lrWm9wbjMyWHlSekkvMjRxWWRZNUw2aVU2dUVGY3hibHJCZHArdEJYV3VT?=
 =?utf-8?B?LytmeEJYWFRnYXoyd0lsV1FaMVpvenZDNXVhODZvRVFpUnVaK1NoUWNNSnRG?=
 =?utf-8?Q?1sqs/MP8DzXuDa9XhuCGSnuhojsQfQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmlqYmJYeldCUHRYU1BhOEszc1g5Mk9EaVlCeTNBUXZ5K2o2eGpWdmhJekYv?=
 =?utf-8?B?ZktpRlR6WjhwL1ZEZ3hGSytKUEpqUjgwN1JpNHF1TmNTRFYyV0JrYUhURXdD?=
 =?utf-8?B?RDVyM0VFTjVSWEdSMEJoZW93dHdwa2VUOXpEdHFQQUFiTU40cTFZRkppR3NT?=
 =?utf-8?B?dTEwZFdvSXJmWHV0OEFGNGQxSG9sSTEra3JYTkhoME50R2JCajFzSGV1bnkw?=
 =?utf-8?B?eFhzL1pJcUs2bXhFRmpVVXloRDdEK3N5U3J5UlR0R2xTODd5bU9RT01tNHds?=
 =?utf-8?B?NWx6bk02cEQrZHhjd25GYUhDdy8yMnFjWmxuVkNCSHYvNkNaYS83bHhVVHR1?=
 =?utf-8?B?NUdaKzUzTWtoM1gvS1VWbUJCcmp0ci9tQVhWL05PdUUzWERrcmd5d2RRYng2?=
 =?utf-8?B?a2djQWxhYlEzS2xxaUpJZ2p0dWVLYW5zNjVMbW5Gd2Fuc0hRMURrWHZIelhS?=
 =?utf-8?B?Ni80U2hQdnpZNC9qckJBeWMvS0pYNndwN1JSWEo3eUIrR0d3M3NHZ1lMV1ov?=
 =?utf-8?B?S0FWYk9INUpHeFRwanVDV1VtUVVJN205NU5oSXN2aTFkbmk2aUJuMkdCcWJz?=
 =?utf-8?B?YlNLWkxMSk9jeENLQVBvc0NrUEw3dGhHbUVIckVFK3IzQ2t2ajBjSXgzYzN5?=
 =?utf-8?B?aEVOSTZSN3BoVVZ0TXEzQVdheldOR1VyRG1oREhINkFwN2gvVUlhMk9tUngx?=
 =?utf-8?B?cHprY0NVUTNIcVhrNDBNa3BNWEZnMk11Z2VrYytVQzBiZmcrK1N2QzVUNTlv?=
 =?utf-8?B?Kzkrb0d4ekVKblVaY1h4QnV0RHRBS21mQjR4eC9GQzRoY29aNER1RUJud3g0?=
 =?utf-8?B?RnFYWUppVTNJQ3V2L1FNaHhLR3Y0a2NFNVlUendpeElEYUlBSjk1a3JlSVN6?=
 =?utf-8?B?dkN2ci82d05EamMrMDNnRG9BSDNoVjZHZ0p6Q0FvUnNZRTh6OFFWZmJYNWZI?=
 =?utf-8?B?cE4rbmV0bDMwYXJNVGg0a3hYTzAyWk5yNXd0Sm1EVUYydjcybE9Gay9XUDJ1?=
 =?utf-8?B?RkJFYWowcEVOVVlTMkdQbkpYdHYyenRtQUJnMlhCVmFoUUVMU2RWbG4zakJX?=
 =?utf-8?B?Z0xmS0RJL2dBSkFDQUYxQVZEc2pIQzJmR1UwOUUrMXdCWGxqUjBuWTV3TWUv?=
 =?utf-8?B?LzFMbFI3SFVzeERRWkFZVDRjeFpKYjd1MFN4UXJqUnE3Q1Q3SFk0YTdYN0NS?=
 =?utf-8?B?QjRBVytCRE05YnFsZTR0SWtESzdncFN1VExPc01zeW9yR3FuOXl0S05WTHpY?=
 =?utf-8?B?VlFKNzFQV29QMFBUVGpsNWU4clNCRDF6blJ2V1FoeUtkM29JTXIrT1pETDBq?=
 =?utf-8?B?YmhlTU9EdG5JZHgxL0lWQ1F6TTgwUUE2aWI5V1VhUlE5OFNKWU92c1B6VEps?=
 =?utf-8?B?K3lNYTczcjNqd3ZITGdPU1RhNGhRQkxjN0JLbzRVS1NRUmNZODZMOElvS0Vu?=
 =?utf-8?B?eTVJRHlEQVIzdFBPa3VqME1aNGhpWnJqVmlld3BjVGYyUW9QTTZVYThlUk02?=
 =?utf-8?B?emFkRzg0K3ZvS1l5b1p2cGh4d1ZFVDJxbW5uL05EbEpReSs2ZzhOVHBVMmhi?=
 =?utf-8?B?MS9UdEFFVHhlYmdEWDF5L3JaYno1K1RCZ08vUnZNNDBKcHhHS0hUaitIdFpv?=
 =?utf-8?B?c25vOWpMQ0cyWVB6NjNqZStKWmlXN1ltUCt2NWE3TXY2S0tWUlRNekdXL2hs?=
 =?utf-8?B?TWlmTW15YnVTNENIZjRLZ3BqR3hqbXk5NDdEMUhmQ0dQZlA0SXdaSys2M3hQ?=
 =?utf-8?B?aDdGSEhha2Nqa3I4cFo3bjBxWmIyTmZJb0djZk5pbUZFR0FkRk0zTE5sRUx0?=
 =?utf-8?B?enFsMDV6YjhReWRpN3k1d3BSV3JUOHJQMzdLekdWbXk0N1p1dVo0NUpENE5D?=
 =?utf-8?B?Q296M1JTZkFQYlhLZDNaTkJWMXNYa3NuRHYzcjFRVDgrTzlhQ01ncUZoelox?=
 =?utf-8?B?SkZqQ0Q4TnFEMEJKWVhaT290dlJrMzdoWnluQ2l2YkNOMFdsbk5LVGtHMTR0?=
 =?utf-8?B?bCtCMWlQNGJHVnpIRzBFYithcGhPWjVvREZSQytQNWg4STRNWk9STXN5V1JP?=
 =?utf-8?B?andXUVlyYkoyRERQYWRSNFZUVjNMTlVLUE1EQjczY2YzWHVmaml6Z21jSWU1?=
 =?utf-8?Q?ZDrO2Zt91pWiSM1eUJSZi2UF1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32EDBD0049E0DC469A47575D8F52C6AF@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36150136-1aea-457b-e0d4-08ddc07bb7b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 13:06:15.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUvPm2OyBive46wZY+EJlKv8nBCrMVPQ/9+OeHUlWrnnulCd9Q/gzL5ShtHtWuBDo/mbaXUHnrlqWwMLGlQ+NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

T24gV2VkLCAyMDI1LTA3LTAyIGF0IDEwOjEzIC0wNzAwLCBEYW5pZWwgWmFoa2Egd3JvdGU6DQo+
IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUv
ZW5fYWNjZWwvcHNwX3J4dHguYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21s
eDUvY29yZS9lbl9hY2NlbC9wc3Bfcnh0eC5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uZTg1YjVkYjU2ZmZmDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL3BzcF9yeHR4
LmMNClsuLi5dDQo+ICtzdGF0aWMgYm9vbCBtbHg1ZV9wc3Bfc2V0X3N0YXRlKHN0cnVjdCBtbHg1
ZV9wcml2ICpwcml2LA0KPiArCQkJCXN0cnVjdCBza19idWZmICpza2IsDQo+ICsJCQkJc3RydWN0
IG1seDVlX2FjY2VsX3R4X3BzcF9zdGF0ZQ0KPiAqcHNwX3N0KQ0KPiArew0KPiArCXN0cnVjdCBw
c3BfYXNzb2MgKnBhczsNCj4gKwlib29sIHJldCA9IGZhbHNlOw0KPiArDQo+ICsJcmN1X3JlYWRf
bG9jaygpOw0KPiArCXBhcyA9IHBzcF9za2JfZ2V0X2Fzc29jX3JjdShza2IpOw0KPiArCWlmICgh
cGFzKQ0KPiArCQlnb3RvIG91dDsNCj4gKw0KPiArCXJldCA9IHRydWU7DQo+ICsJcHNwX3N0LT50
YWlsZW4gPSBQU1BfVFJMX1NJWkU7DQo+ICsJcHNwX3N0LT5zcGkgPSBwYXMtPnR4LnNwaTsNCj4g
Kwlwc3Bfc3QtPnZlciA9IHBhcy0+dmVyc2lvbjsNCj4gKwltZW1jcHkoJnBzcF9zdC0+a2V5aWQs
IHBhcy0+ZHJ2X2RhdGEsIHNpemVvZihwc3Bfc3QtDQo+ID5rZXlpZCkpOw0KDQpUaGlzIHNob3Vs
ZCBiZSBhIHNpbXBsZSB1MzIgYXNzaWdubWVudCBpbnN0ZWFkIG9mIGEgbWVtY3B5Lg0KU28gc29t
ZXRoaW5nIGxpa2U6DQpwc3Bfc3QtPmtleWlkID0gKih1MzIqKXBhcy0+ZHJ2X2RhdGE7DQoNCkNv
c21pbi4NCg==

