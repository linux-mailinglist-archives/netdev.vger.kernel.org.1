Return-Path: <netdev+bounces-207027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8456CB05522
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD53171327
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1842D274B43;
	Tue, 15 Jul 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bgxBS4PX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298226E143
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568820; cv=fail; b=bA6cpp8lFL57caHoiAxJYstB+aeAWpWDFlmnjk78DPrzj/6WRVxAq2oL9DsaeszzlSmq2WlX2j72G3phLyKvCuMseRVC4oRs4CCaasXg2ho+B1XakbAmEk8iG67Jncy2e6LJ3VQDSkCvJDbNjvwmohNv0UQy9Nb33i965+sV2ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568820; c=relaxed/simple;
	bh=LSKR3/VeO1a+e69MvKIPQMVdPJk78jh4fxqw3m42is0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tHQHPto1/fnq5vgRgqL5lYAXLndF+aMw3MgEcTcEHrC9FVxhBnlzdymaZRRUC9Lt5h6Zrv7l9VNapIkAygSOWxbgGS3Jwyt5dPTORJ89r4r1i24b9NY+r5SxpwiNK8dApgV1kog3Hz27iMgNGKjiwaRbgvyS6g/gBREXA0NffD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bgxBS4PX; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ru699b1neghNoX0bswnX/y9pZG/8pscva+zi4purLs4eLTWTYD/oOPS9Ch+D6CtAbmdrlj9W4w4l1boWtjlLeD2652AH3sJVI4gIwQfnX0EwkVfAnCQ5GZpKZLjRfr2YEx3IpgJjXpmonqf7JdyHjZEgwNDmGVp/lMNYTUo71XuoaDYynPWo+BavFDPJt0vgd5H9V8LNM26C2y8y50mkDTOooX/+sZ8JpIDy75bZqNyBu83auB+aZgzdfjDsqqWh7plBuoB4F2PjGPH9OmtRT8jNP8Ic0MK2VgLA5ZyEhOZsFRXeEzb43Qxp2CVHXeqXYESXgj49Mv17hukXpF1jmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdJJ+/NLbSJRTI3x5N/SD+yWttyytkxYh5kmCEV29lQ=;
 b=I3xKdBErEIyyyX7Pk+suKr0k1XGaJW6+TkXws/GSU9x1E+XtVQSerWlSA2uHjJwCAURrMjiFqR58Xdh+b8M0jqGnCqL+/tkv4cwobfs8eZ5GKUya3Ygk3Me7HDLQJJzru7fmLjEp951VyKWNiDTp7oCBsWj+mA4Ddk+WwYEKbapff7RdOWV+NMx1aT7080YA8Yd3aqCaDF1+peuyuKZfiJhG+PRDtugR4hgjlXq0agaJ+GJc3irz4FvuOn/obyNUClhENcuutMjUnFQQ+sPsS+TwepEl+brv3FbkHdq48BAgTxPr41qxfeMf0VlH+Getyx7QKnsdsVQNnwwUkfWohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdJJ+/NLbSJRTI3x5N/SD+yWttyytkxYh5kmCEV29lQ=;
 b=bgxBS4PXToH/+lLeOY+7hjHTQsBJJ1xax6fNxNcJ3tWHgAVrqi0+yUKij4Hb9MBBSuL7OrPcWnWXqAvQessuS1gZmzx7mFcnfzkFzanZs1pSquIEfEbG0ObXHb0VDmI2TtzW0AkvVgzpuKlc3HbIVJ7JBK7j1cC6pk4ZwEG91WfUvI8xNAMe2OHm/BUKwYYk20nwmHaUzUc6iwwFSxiOFvMzsCS683byjm1ZTGwzNvY8IevOa133TbCgnwi4bFi+qlzqZW4k8duQTB+N4Y1d+L12IU77CXINKPrM5KEe8krRXI7er4IbjM0zols7Xn3RFuvQ5eDP11yivAT8wXaPQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 15 Jul
 2025 08:40:16 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 08:40:16 +0000
Message-ID: <5fb69c47-cd55-4a51-a7eb-3eb3fa0ff1b1@nvidia.com>
Date: Tue, 15 Jul 2025 11:40:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 09/11] ethtool: rss: support setting
 input-xfrm via Netlink
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250714222729.743282-1-kuba@kernel.org>
 <20250714222729.743282-10-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250714222729.743282-10-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 059dbd70-fb51-4aaa-aa22-08ddc37b38c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHVVSzZaaE5YV08zZzUzb1JMSURLODhuYXlIM3dXUnlmR2FzWWo3b1FoVjRh?=
 =?utf-8?B?YUZNdmFmL2VLTnRLRTJoMlNrWk5aQndCdFN5Z09OZ3FKMmV0ME5ON01ERmRS?=
 =?utf-8?B?ZjR5VHJJYncxVkw0anNKdlhEZEZVaXQrSFpSVHc0MWJYOStWa2trWXFwMFhZ?=
 =?utf-8?B?a0Y0MEdOUmpxMSt4dWFha016b1VOUmhob3RUYXhGSmdYbEUzdWVENStFenJt?=
 =?utf-8?B?bUwyLzNMYWcwbHNDRUVtR0g4dVg0cWhsLzVNMm10MlIyV2lzS3kvRWtXRnVK?=
 =?utf-8?B?eDdjb1UzLzh5ME9lYXN6cVpSeXNhc0d1cGZsWEYxNGhiUVM0ZTFZc0VXUzk4?=
 =?utf-8?B?WVY1VWFHNTI3eTRTQ2lJOXZHM0htam5nS0FuYVNieXcxMjU1REI3VVNTRVk3?=
 =?utf-8?B?UHh3RXNLZHJ0RmgyYjBHbmlLaCtJc0p2VGI5bG8zMW1lYk9zT1JiMHVLWUxh?=
 =?utf-8?B?cTFBSVFFdEtnSWF5ajRiYiswT20wNnFEcE9LNVZBOHV0YUk1ZU5IZnpuYW9u?=
 =?utf-8?B?OHZCVjIzRGhyTUFaK2VSTTdMZVBTMHAxUVg0WDd0RWs2djdJU1JjeDdGVUFr?=
 =?utf-8?B?SDU3VXIxRGlEVFBoWVVlcHhKRkt6Qk1FWkdVNTdBS0RlRk1rOXE2WEt2V01v?=
 =?utf-8?B?VmhEUWpuSUlWUysrSlpGRTF6Y3IxRjdPTXo1L3JKVjlWTHd4M0IzUWpjOGRB?=
 =?utf-8?B?aVN4NEtqQ2NmOGJONGpPTDdHT3ZGVVF1NkJwelB0NjJnekhTQTZmREdGblFq?=
 =?utf-8?B?VDFFZUkyMjRreFF4amdGMWlFelpjMFBRS0NkbDQ1UVc4amxLb2Jzdi9EMTdX?=
 =?utf-8?B?ODFLSEtLT2hZQzZubWRMcTJ6ZE9HKzNKYjltT0NSOXJ6ejdiQ01vVkJuTlpn?=
 =?utf-8?B?WFJjTFBhUlI5YitDOEZnRUpxNE5zem4zR3BadUNUZExKRjJkTHNKZWUwMXNw?=
 =?utf-8?B?YkNNT2lVSzh6UEFFd2pCdEFFOERpalV1OU1DMEJDVy9uQ2N0akNxK2EzQWh0?=
 =?utf-8?B?NUZnUk1mdmk0L2l0cGxMbll1Uy9POXhieUpkOWF1SVpHVE1xdGhMKzc4Z1dH?=
 =?utf-8?B?WnZ6SEYyWVlERWVHSWZ0T0c2dmFPRXEvMTZrbmsvaE5mY2RJbStBRDF5eTlx?=
 =?utf-8?B?Y05ZZllJenF0Tkw5d2RhK0xFdjVNVFlEdmRlVzBTZUNmZ0hDamdLSXpNUGZY?=
 =?utf-8?B?MnA4bExiYlR3ZmNnc1lhQ1dxVUZXYmVMLzJpWUo4SEo2MWFzUGF4OHJuRVVN?=
 =?utf-8?B?U0pjaHF1eUVaNEs2MlZXS1kvWnJiVlZSYWVLaVdhQ012NUdhKzI5THhuRkNQ?=
 =?utf-8?B?V3ljOWlRRVcyanlvQzlVLzB1NDEvVzNVd3VPUU8rLzZEZU1iekdFZFpvK3VO?=
 =?utf-8?B?cWEyTzFzRGJzL1VkZU1pd0gyQmZha08wSDcwS2NIQ1R4REhUbHA4VSsvT2Ri?=
 =?utf-8?B?UEZGckIrYmtidjNuRENrR0liVDdEbmxZNmVNbmxCZU9Pa2dVdjM5cmswWkVa?=
 =?utf-8?B?UmlTdHFEOHU2QVd0aVl1enhmSWEzOENkL1ZkNFhYMzNxWTRSZWhwRU9BZTli?=
 =?utf-8?B?WkV5alFIWmJxRkpCdHo0MFp0L1cvZzM0d1pmVThqL094RnRrSEd3T1M4cjE0?=
 =?utf-8?B?STJmaHdjUDZvN3BvM2EyZEJBZGF3cjVWYndtanF6T2xFMzJPRUwyL2RoTVZw?=
 =?utf-8?B?YlY0N1g4WGxqYzNRaDU3ME5ydFZ2ZWFkTFZCaHJsczN4VzY3TkFGZHozZHBU?=
 =?utf-8?B?NStsUERSVkg0eXpxYzRIQXd0b2Y5T0hIMDdaS3NvNTUyb0dBcjJJMWFxUVBi?=
 =?utf-8?B?Nm5rSlpSNk0rZjQrdmhZejVPcWV6RkZvV0hXYUwxUk9GRTU4dVJ1VEwvYnFO?=
 =?utf-8?B?WmIxMzZhWTNxUmNvNDRTUTY0dmpURGRmSTZpbmU3VU00NnFmSi9MMWJMRUpF?=
 =?utf-8?Q?585jXVd5bkA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3R6N1BoTHBsZlNPT0lSenpQMHNDaHV3UnR1dDMySGNjVDI3THM3WU5GYmJz?=
 =?utf-8?B?UndvMldKdlhabkZ3WHNsUFVSc1ZBaTBlRGY2ZUptRVBrMk1JWlBHOGVocU90?=
 =?utf-8?B?ZjQ5NmpNdDRYNi9aRXpMRE9RRmNwT24rWU5JZmV3VXh0NmdDM1JVRENBZDF0?=
 =?utf-8?B?c2ZFYlpvcldpVmR4TitCTHBoR1RHazRadE9nMkgyaWl5anFaZXUxQmZkMTY2?=
 =?utf-8?B?VklGUnFqOU9jY3JuWjkvMkpBb21VSStXb2JxVG55aGhXZDZiNGN3TWtlcWFF?=
 =?utf-8?B?ZHdSS0ZKeG5kTVVUMTVvRW96d1hiSWk2dkVNT0FFNHhKOHRWQ2dxMGxUOXBL?=
 =?utf-8?B?N1hzUGFwbnI4empmYTFVRmN4M2xIL0RxV1dQQXlkRkk3a1hCbzNYbnNUMVVZ?=
 =?utf-8?B?YmtTMW5kNUJ3SUxXMEpEVkZLbTg1Sk1kOVMyTTYvazdFV0dkNzZ4ZDNicUNU?=
 =?utf-8?B?STBZT0RiSHo4U1hpaDFDaGVXemRhRU5KZlRaTHFVVkJScXZkOGFhb01MS0Zw?=
 =?utf-8?B?Y29mTGFxNVkrUEVkSzdVZmpRNkpkVnBaYjF0Q3B0MDgzbWxHZGlSYU5pekF4?=
 =?utf-8?B?L3Juak4vbk9QZXU5bjgrM2dZYXlrTzhZbGxmL2VRZHJmR01PT3ZSOGxFNXd2?=
 =?utf-8?B?b3cyNk1pLzRmR3o5N0hBYllTTDZxalE3K2szMCtDb25YOEd5QUhyb1AxdFVD?=
 =?utf-8?B?Mk9ZOHhxUVh2bWNTbEhyMVc4MUhOMktJZGo4UXk3TE95Ky82ei9tcVVEbkhq?=
 =?utf-8?B?SFQ5UmNjMFNhU2lRZW9palZrc3liKzBpK0dmTEdhK3ByUlRYMkZKYi9RUDg5?=
 =?utf-8?B?T0pxK0ZWNW9lUFdxODlTdFNXVC9YN0x4Sk5mZWVqalA3d2NiQjJIM0tMcHBH?=
 =?utf-8?B?a0t3NnpvaUpyWXNsalc5NFZRVHZuLzJaRU9Lam1rMFJyR1d4cmxpMy92bzRm?=
 =?utf-8?B?TlVyRTc2azFiWXErWkhNY0ZnVnUzdE1jK082TlFmSWlzRWhsZVkxNUltNUtz?=
 =?utf-8?B?QmszWUZKMnZJMTZpa3ByS0tmcENhcC9nWWZTaElIUjdQQ2FsTENBQkplWkFN?=
 =?utf-8?B?V1ZlZ2NQOFR1Tmc3bG9BZml4dk1zOUpYejdUWmlOdkFYcVBxY2t2Ym5wZEk0?=
 =?utf-8?B?V0lpZVJUcGZPTW5OcDRhZFE4RTYxVzRZZDVKdVZvSHdQRk15MG9PdittM1R1?=
 =?utf-8?B?cU8yRGhId2hjMVk3S1RDMCtvdWE3ZkwxeGxoYWh4Tmx5bWJ2Vks5aFY4OTBk?=
 =?utf-8?B?MGRVZ1JvR3ZOMHVWTGhaRkhXQ1FIY3ZNdkpOU0ptQ1diQmhPQ1MzQXl0WWNy?=
 =?utf-8?B?OUhUTUlFZlJJbUZGbkx3OXEyc0ozSG9JTmJmeUJqcUhsbzVPQzRadEMvOUFw?=
 =?utf-8?B?SXQvQnh3dzVSbll0UklaZzF2SUhPSTE0a3hXRzVnMU1IY2N3YjdRU1dPamVp?=
 =?utf-8?B?c2o4elJObS9XeE1XMk1wSlQ4VU85VGVkb1pRcHZjbEdWd3RBVklxMTdmc2xG?=
 =?utf-8?B?WExEbEcxYTRZYlVkakxWRCtweVBWQ1VxcE43TDl4TDVnMzRxaUlaak4wVWhm?=
 =?utf-8?B?enBEbzhBUm9ybHdZbVA4Uzc0c0ZYTGhyaHZFaHFLUEhvL2tBeDBnNkpnUlRi?=
 =?utf-8?B?Z2hnZHREZFhsZXJPZlcyY3ovZ3JlMzZkbGxtV1g3UUJSRTZ0czQzSEhNMGYx?=
 =?utf-8?B?cm5LdWlXNVlCR0ZJaW5oMzk0bWs1REtzTUJmVHUwL2NZa25XbnFXQlZSLzFG?=
 =?utf-8?B?VmN2N0g2R0gzMnFhd1lpZVZIbGxlWWF3M0Z5L1ZtTmZiUzlhNHZQTm9mSzM5?=
 =?utf-8?B?amt5MC92dk5RYlJEcEptNjJUeUY0RGJ1TU04eEhndG9vM0VuMTUzMEljdlNo?=
 =?utf-8?B?bXNOZFR0N0FPYW9JeXd4ZVlOMXJrcG13aG5SbkZqL1VPVHlyNlZUSDVkYnVE?=
 =?utf-8?B?VE43ZitVc0ZCd093Ry80aitURFQ0ZEhOQi81VFBJODhvcGxYVTFvMEFLTE9R?=
 =?utf-8?B?bVp1Y2lyR0FHV1ZNaTFjZlhVM1FMT0JmZzVJNnl2b1pIUFZGMDFGM0wvQkMw?=
 =?utf-8?B?bXVwSXF5U1V3US9wVGdRb0hCejFOdUtxaG94RUE2WUZxMUNzN3YvMXlVaEo2?=
 =?utf-8?Q?bfKxJFx1hzG824NayjxTpTxuD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059dbd70-fb51-4aaa-aa22-08ddc37b38c1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:40:16.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPqXstbxcjv+O4zkS9w8M1abjjtx25QUOjgVDz1wJ05EdlRllkDbUV2GXZugyE9N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484

On 15/07/2025 1:27, Jakub Kicinski wrote:
> Support configuring symmetric hashing via Netlink.
> We have the flow field config prepared as part of SET handling,
> so scan it for conflicts instead of querying the driver again.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>

