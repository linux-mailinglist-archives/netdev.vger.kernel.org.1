Return-Path: <netdev+bounces-122239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A17960846
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86701C22611
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D819E802;
	Tue, 27 Aug 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IKq6cnY/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4EC155CBD
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757255; cv=fail; b=nd9gu+0nI1nSgD4OWPBSGsj7D86x072yrOhQyvSr1fhlwDP74IzIUn1kz1cmrRKPgcDwy3fxjy+rgY1+b4WYjALZlfec8jX4sqTwj9FWyF/SD2JxfsXMBjGeoiH0lzNOKVf8lZgbSBkhLFYuKBAKGJKcC+2rJwMKfM9D9KbZC4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757255; c=relaxed/simple;
	bh=zd3hLqHhQgC7wLIyVZuXD3YawKdX+w/DQa3wqkPtySs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lbTQwTLCfV9I8pGxBwuoP4tD1ivGL3YYHr9NUonK9Oc7LsZcFgm+NWU+Xzm0fQS7w304/7U5R61W/Dt1NXowvpMR6xqMaF0s89JKdEnQ/bW1NQeWF/idg3nbV/ONxgGOLp7YhsoSLnWWD1OL9oaNEePE2JRwVyrfCf0GwjM3VhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IKq6cnY/; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eF3rZTMOqhzE+9WE7jrURNMvRktYlHIg178ymKEdAvdV8b/xvz5Ekph17E+cOWBnIO3u0z4oLcN0HDwocOIV2OAqrkJwOcLslRpWRhSIUrofZOgAQVxyH+HoLlAK2rgPPjfCJV0jmhgHJDRF+j4gVJp8nZB3A6Uzd3Pm7skuS6b5UsynmjDQKGkXFsAPGLn9w+4OIXl5g9qm26gXxc088MBsFbpZDkMZKix/m5CVMp+JzfSzwSxv/nP2ecNN2IxAHBmgl7a0d0Grc/oXWlsG6PADkzKWRrCQ9fhyTccl1xm7rxZTEXLDASz+kpa3ODkg4wLh6nWWRmAAchSSDLfcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd3hLqHhQgC7wLIyVZuXD3YawKdX+w/DQa3wqkPtySs=;
 b=LT1NIFoD6tPGD49e6UBPWGRDKMWn77u8uNN06cNHt0YPULiOhaNTnF7a7HC4dytdAVfol9e+f+ewnfScQnL4BhZWuBOnzTimR/hBJFejkiygT5GF8wfgNlq7M8aozugH2lh53jU0FQicGGsVldVV6hTizDJaWUmUlLe/vEUEZekCmlVydp2PTkNMdlW9w9yNGsd0MT7ZFphglz4msH2X51S4W+sEZKzhnU9mW/q3JjGAJvMT0ntq/Wzk6yGnUKLaDCWZxYp4penY2JCvxpq2XFVWbmyZV45ro0uzLXiXfrT2X8/bSCn9/ts1P4EKgsqV+pgWwgupoFD3LH5k4Nr+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd3hLqHhQgC7wLIyVZuXD3YawKdX+w/DQa3wqkPtySs=;
 b=IKq6cnY/A1XwjMAFve+Vf39lpCTVgmNMSWayBFVkeZ7bRHhK/U4XVZSweeuuIHfcHEXUKezS3K3t/VabzQS0FontFy4TpORhG5PH7BUI297oRxmEAktzzNF77NhQbaIJjn/mDXSMuW3EcpboF7A4vBE12mKthzJAvjYUq0zsRc3T3dOhHSNIKk9V0XHwpn+rJtkrg9M7FjfOTMg1GcJ/Qr3BZ/pwnjyv5mpOHVzifdkZaLTtMuouulTlPi2nsBm0p6rEQ4piMKnXzKWJ3F0cCSiGNuuqsmvfHeCu74KH0VVKwT6pcNVjnjNYPg+QOvYjq/WnVL5ws8IoDeX/ok2Ecw==
Received: from SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 11:14:10 +0000
Received: from SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::879d:bc5:e2fc:f010]) by SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::879d:bc5:e2fc:f010%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 11:14:10 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "horms@kernel.org" <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 03/10] net/mlx5: hw counters: Replace IDR+lists
 with xarray
Thread-Topic: [PATCH net-next 03/10] net/mlx5: hw counters: Replace IDR+lists
 with xarray
Thread-Index: AQHa7tvR6FyqYvpV2Ema+zx5lM8c0bIoVMOAgBKx94A=
Date: Tue, 27 Aug 2024 11:14:10 +0000
Message-ID: <0dce2c1d2f8adccbfbff39118af9796d84404a67.camel@nvidia.com>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
	 <20240815054656.2210494-4-tariqt@nvidia.com>
	 <20240815134425.GD632411@kernel.org>
In-Reply-To: <20240815134425.GD632411@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR12MB2717:EE_|SJ0PR12MB6942:EE_
x-ms-office365-filtering-correlation-id: 98932dbb-c387-404d-7338-08dcc6896012
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDZleXY4dGhKOUNkWEFJczhNd3NzUDBrNlBvcXBKLzUxMzJwRG9mWTVUZ2RB?=
 =?utf-8?B?eGFuaEd6TVE1ZllHVjBjQnRsN0FKMi9RT3JWUjV2akdFdXFGUjZPTUxrcGor?=
 =?utf-8?B?cmVqUy9CdEF0WTlZcmFGaHJaRTZiVDhrZzFNWTZzWW9leDNxbms4b1BCUkN2?=
 =?utf-8?B?cjhCbXpLMzlXN3QrNDllTVNkR2dKaGhiT2NVeHFoVEZYOE9SeEJidnQvNnY0?=
 =?utf-8?B?Y1E0bEJmNTVtaXcvdGFoOHRiMjc0WmxBNUUzOVhzK1RYSHdyazB0QVJrbnRK?=
 =?utf-8?B?TnROS1RxSXVIU2FYNU54OStmaVkwWEZKUUxHUTBJdnF0WW1vS2JTUStuUm1k?=
 =?utf-8?B?TXF0c1p5Vzk2ZnkyUFNwNFhSdWlSaGZNWlpXWGFXdXpSbHhNeXhqU2RjUHhB?=
 =?utf-8?B?TFRkdDBCUy9XSDBGd1U1eWZkelVmNWtuNHlLcnMyQ2FFbW4rNWx1VDNNN0dq?=
 =?utf-8?B?RDh6aVFwNUpJU1BmWS9qVTd5NjV6RkFHdnJNVnhsbVd2TlVBRzN6NUk3ZStV?=
 =?utf-8?B?Vjl2MDN0bnMyWGp0UkdHZFJFWmhIUkN2ZUdVanh4VWVoSDJIcEJWSEtlbWtL?=
 =?utf-8?B?MnZtVXlqbXZlL0tDK1ZhNm1wSVJYSU14R1RCQ0V2cFBoV01nL0RaYzFnL0pH?=
 =?utf-8?B?WXZ6dWxETFNPcFFpSHdKU3h2c1dSQUVSVmFDbUpFRHYzYTNwMXBGZTREbEN5?=
 =?utf-8?B?UGZrS2xjdEs1TVFnM2hHTVhrOGxpZ1d5d2tac242SnNrYkI3bFJmT0tXSXd0?=
 =?utf-8?B?TVdPQzZabnIyZ2YvVDJrbXpjMklKcUowandiL1lDSm9jM2I1S1NXN2tPdXRo?=
 =?utf-8?B?WnYwNnY1a2MzLzh4OVV4OGRHYzByRGpGcFBTZTc4ellPcEdIR1YrRkpDaVF0?=
 =?utf-8?B?a210RGhaNW83QkFranZrMkdQUktaQjNyVUk0NGI1bHdHRzVmK2ZWOFIwM2ZO?=
 =?utf-8?B?UW9XOThqTC9JN0xhakJwNGxNc1EreWc3cXFnbmJBdHMxUmpLc1A1S3VCZWFJ?=
 =?utf-8?B?SE1jQnNOb0lBVGdnYys3ZlRZMDZ1bVhHdUt6c244UUUxQ2J6Z3RncU9vMk54?=
 =?utf-8?B?UDA5V1JKOERoQ2lRZWRHMmdVRmhGTnhKcThXa3RkY3c3bkVteHNqdDlLWkhu?=
 =?utf-8?B?UFE0dU1ieUU5K3lUSUJaYmJhcUlYdUFzcGdMeWhUTzkzN1RsYUYxSGNkRkU3?=
 =?utf-8?B?MHpnWkVSWXUzbFlNclRsR0RLVHFBczBleEcyMHcvZjBLelVYYmRhOWFWdE8w?=
 =?utf-8?B?ZHZUT0dXZ0p0eFJ1T3IvTlFJeS81NEc1TWtkVXBqUmtxZkxwMUkzQ2NiVHRq?=
 =?utf-8?B?YU83Zjh4MStONXN2dlRYaVJGbjVyVS9vQVlqUWx3OW10T3JhZ3RvQkVnMVh3?=
 =?utf-8?B?bXd4MEFJaFR4YkRtdHkvUDZuMXhtS1dNMnBocmR4YnV1bE1qY1VNSDdyaWFC?=
 =?utf-8?B?eDVSYWxteDhodXAzRWlHQkc1MHV6Wk1tVHdWaDF0aXU5bUdQRkw5OVRyaG80?=
 =?utf-8?B?aFk0dmVaS0RBcUNDUEZXekwxWCtLanFyL1AzTDFVN2VTaEdVZHhadCtrdzR4?=
 =?utf-8?B?eVJxdXloM1hCa3RXSjNNdXZkMHJzMzhtcDdKa2NHUlg4YkJQL3dvMmFzMzZE?=
 =?utf-8?B?S25MYzgwYTVIb2swMTdjbVNXSC9tMlZNam54Y2FuTDROaWYyTWJBdGd3WkE5?=
 =?utf-8?B?SkNsS3NOUVcxcXJBRGJpUVVQd1QwYzdFU2M0VzFpY0NOWmRyR1VweDZpRXk3?=
 =?utf-8?B?YnNsS3FOdDZ4ZEpVNjZEY1RzYmZyQ0NERTRhUy9GbkUzL280bWJKTVc2d3lF?=
 =?utf-8?B?VThueWM2czNVcGk4c2ZpS0d2SGdma2YxMDFJNVV6UDNuWEprQXlFOENhaXU4?=
 =?utf-8?B?ZmFvOFRhSndWSzd2UzI2M2hldUhRZUNuQmlxV055bjAyZ1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2717.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aE4xeUVUT0cyOWdEaUIyUUc2QWJkSTRPRkFuT2d1UnVocEZiZ3JOeGdKUXZa?=
 =?utf-8?B?UjI1M0tkNFVTMDh5NDVndjdHKyt5VjdTZHRNSUpVdEdKczEzd29MME9ZRTFW?=
 =?utf-8?B?T2xFdXBFMnB1Yi8zT3l3VnYyMnVxczF0Y2xpcEJwZElqWlkrNGR1aWRweVIz?=
 =?utf-8?B?NVU0bWNJU0pGek9yN1V5Uk9iRkdzOHRweU81KzFWQmE2VDdvaUtKZEZMc2FZ?=
 =?utf-8?B?SllZNFBYYkd1SFY1UFpqQU1FN3kzUzNpbkNJT01hWUx3dzFPWUkwWTRRNVRF?=
 =?utf-8?B?Ynp3b0w1Y2RJQ0p1d1N1T2M2M3VkbnJvUllTWEcwZXlNeTZlRTVyb0FEa0I3?=
 =?utf-8?B?YzY0bkplaW5nYjJLQkV2aHJaejZ6RE5VRUc1WGpxbWdpNHFHTGF0QTRwdVhQ?=
 =?utf-8?B?NHBDRUVYYm15elVuUHhyNXFCV0pnODVVakt6OHg1K1d5ZnNUdEtydWZ4TVQz?=
 =?utf-8?B?VXRQSTNkTGk2Myt2bmlTQzA5RXcvcjAwb3M4L2hLU1huVkZoOStiR1EwMlU3?=
 =?utf-8?B?QnZQRjNnNEkwMVBXbDh0d1hWVVNmRzN3SWYwRWI4RTZlTFl3dGNxN1B5YVQr?=
 =?utf-8?B?bTdIMUljNmFLckZhemhveldXOURjeGY4RWw5RkYxbXI0SVdKNVh5TVNlWjR0?=
 =?utf-8?B?ckpoelJWVk1kbnpaMFljRGVJZTYvY2pqZy9wK0lWcnFsMUZIQjN6TzJ2ckhN?=
 =?utf-8?B?bHdXZ2ZJV0ltUEJtcGxSK3NaWEM4czZLcWlMMEE4T1BwSjBlaFpUdGtLTHlU?=
 =?utf-8?B?bXBBeGljcVJOQnJha2pQZCtCR0NiSHJNZTE3aXpaNUp3b1lFZmNITWlMMEJp?=
 =?utf-8?B?Qk5RWUhPRkRNSHRRK21ZWDNHOFVESFhDZDQ3WFlVZ2JhdFhaZFNPT3V3ZjNS?=
 =?utf-8?B?L2lncVRnV2N0SHdQbTRxakd0MG8zb2ZNSVd0SVc2ajNlREtqeUdMSkp2cjkv?=
 =?utf-8?B?MlRSVnlubHpRUC9OVm45T3BFdTVFV3I2VDh3VzEzSm9weDc1U3U0SDVWY2hG?=
 =?utf-8?B?KzAzanJYRVhqZW5vd0I3T0xnMjJZdGlSaUJ1SFpIT3ZOWUE2NFE2WVc5ckxT?=
 =?utf-8?B?WWpHbUhJdjErRzBFRHIvRG9veld0WXBvV0h4V2FHdFRScWx3bDZBcVpmQ3Z5?=
 =?utf-8?B?ZHVlZm1LUGxtVGovZ2hYa2p1Q3hnWGFsMUNtWW9XMUNEY1F0WjVCU0xDalFt?=
 =?utf-8?B?RGkrUjhBMlh6U2dvZkhTSVZYbktoY0k3LzJMYWgwSWlxaFc2SmVJeVBNK21v?=
 =?utf-8?B?KzZKd3dFb1FaYnluYVlFRzAwbVgydk9icy93MW9MVnJCUEdiczVUT2g3UkJi?=
 =?utf-8?B?M1l6VStnTlM5bHFDVGxBK25aNXNIM0UweS9ZMi9TcmdwenpPN0wxMHhYMFNH?=
 =?utf-8?B?T3pad24weDZlbEl4bGU4OW15TzhieGl1aEJwTFAzTVRXb3lGMVkycTJ4VUJU?=
 =?utf-8?B?anhQRVE4MlFkVWtMU1AxTmlaYXlnbXhLK1BKYVV4cHhBZHNUelZQeU5KcUV1?=
 =?utf-8?B?Q2JiU1UyaGUva2E2VVF5b3VBY1JEa3VkMEdTa2poMEpxdnlVNmFjSnZLd2ha?=
 =?utf-8?B?SHlTdTQvT291TjRBaTNKOTNyd0JLSjFWaGIzbjczczZBS202TUg2TUpMMGVJ?=
 =?utf-8?B?ZmdIcDc4NjRhd0dNdlVYZDZFZFZEeGlwVS81RHZscFZsVDd1R1lUbUlYQnBH?=
 =?utf-8?B?SnFNOWhsQVNxbTN0ejlEWnI0WFhmMFhmWmh3VzZCTDZxVWtkMVFQcVV2TEhy?=
 =?utf-8?B?d3NmOE1jRnFXNjNKRjdNaXczU1RueURiRkNWcW1NWk1CTlNLRW1lNGxKdC8v?=
 =?utf-8?B?Y2VHZkpWQm9wK2srbDFZNEtKc0pKRW1JTzdsL3IzM0pKMFRMMnRreDdVME5x?=
 =?utf-8?B?MVM4QTVIb0E0SC9ZWGV6WE43T2lBNE5KcFVYQjNCWUpWV1BralUvKytRTTJP?=
 =?utf-8?B?aHptMy9jenAwWHdvRGVCc2hVSW1oZ3laWGhYRURBM2ZhcFE5WXlFNDZWQXl6?=
 =?utf-8?B?WnhnMngrQjAvVmYwRmhPRWNtWFNiT0poOVpBVzk0ZjJ3alR0NWl0c0w2YVIw?=
 =?utf-8?B?QkxrbjBTdWhYM2hHOFVISXlIMWJZTGhxVHNpc0NEb1hjWjFhdHBIdFovUUVK?=
 =?utf-8?Q?z/3TSEbExSh2o1sdotmCF2w3l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31C22EC3E907EE469A32A77F4F6256B7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2717.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98932dbb-c387-404d-7338-08dcc6896012
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 11:14:10.4086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWPrQNgrQVmeGu5rInB/Bw/nUBIwqIXVJmgH672DWlP5zuIWvW0xp4pbr/3fbJxV0+vMMA+qkQpyJOyuCkomoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942

T24gVGh1LCAyMDI0LTA4LTE1IGF0IDE0OjQ0ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IE9uIFRodSwgQXVnIDE1LCAyMDI0IGF0IDA4OjQ2OjQ5QU0gKzAzMDAsIFRhcmlxIFRvdWthbiB3
cm90ZToNClsuLi5dDQo+ID4gKwl1MzIgbGFzdF9idWxrX2lkID0gMDsNCj4gPiArCXU2NCBidWxr
X3F1ZXJ5X3RpbWU7DQo+ID4gIAl1MzIgYnVsa19iYXNlX2lkOw0KWy4uLl0NCj4gPiArCXhhc19m
b3JfZWFjaCgmeGFzLCBjb3VudGVyLCBVMzJfTUFYKSB7DQpbLi4uXQ0KPiA+ICsJCWlmICh1bmxp
a2VseShjb3VudGVyLT5pZCA+PSBsYXN0X2J1bGtfaWQpKSB7DQo+ID4gKwkJCS8qIFN0YXJ0IG5l
dyBidWxrIHF1ZXJ5LiAqLw0KPiA+ICsJCQkvKiBGaXJzdCBpZCBtdXN0IGJlIGFsaWduZWQgdG8g
NCB3aGVuIHVzaW5nIGJ1bGsgcXVlcnkuICovDQo+ID4gKwkJCWJ1bGtfYmFzZV9pZCA9IGNvdW50
ZXItPmlkICYgfjB4MzsNClsuLi5dDQo+ID4gKwkJCWJ1bGtfcXVlcnlfdGltZSA9IGppZmZpZXM7
DQpbLi4uXQ0KPiA+ICAJCX0NCj4gDQo+IEhpIENvc21pbiBhbmQgVGFyaXEsDQo+IA0KPiBJdCBs
b29rcyBsaWtlIGJ1bGtfcXVlcnlfdGltZSBhbmQgYnVsa19iYXNlX2lkIG1heSBiZSB1bmluaXRp
YWxpc2VkIG9yDQo+IHN0YWxlIC0gZnJvbSBhIHByZXZpb3VzIGxvb3AgaXRlcmF0aW9uIC0gaWYg
dGhlIGNvbmRpdGlvbiBhYm92ZSBpcyBub3QgbWV0Lg0KPiANCj4gRmxhZ2dlZCBieSBTbWF0Y2gu
DQoNCkkgYmVsaWV2ZSB0aGlzIGlzIGEgZmFsc2UgcG9zaXRpdmUuIEkgc25pcHBlZCBwYXJ0cyBm
cm9tIHRoZSByZXBseQ0KYWJvdmUgdG8gZm9jdXMgb24gdGhlIHJlbGV2YW50IHBhcnRzOg0KLSBs
YXN0X2J1bGtfaWQgYWx3YXlzIHN0YXJ0cyBhdCAwIHNvDQotIHRoZSBpZiBicmFuY2ggd2lsbCBh
bHdheXMgYmUgZXhlY3V0ZWQgaW4gdGhlIGZpcnN0IGl0ZXJhdGlvbiBhbmQNCi0gaXQgd2lsbCBz
ZXQgYnVsa19xdWVyeV90aW1lIGFuZCBidWxrX2Jhc2VfaWQgZm9yIGZ1dHVyZSBpdGVyYXRpb25z
Lg0KDQpJIGFtIG5vdCBmYW1pbGlhciB3aXRoIFNtYXRjaCwgaXMgdGhlcmUgYSB3YXkgdG8gY29u
dmluY2UgaXQgdG8NCmludGVycHJldCB0aGUgY29kZSBjb3JyZWN0bHkgKHNvbWUgYW5ub3RhdGlv
bnMgcGVyaGFwcyk/DQpUaGUgYWx0ZXJuYXRpdmVzIGFyZSB0byBhY2NlcHQgdGhlIGZhbHNlIHBv
c2l0aXZlIG9yIGV4cGxpY2l0bHkNCmluaXRpYWxpemUgdGhvc2UgdmFycyB0byBzb21ldGhpbmcs
IHdoaWNoIGlzIHN1Ym9wdGltYWwgYW5kIHdvdWxkIGJlDQp3b3JraW5nIGFyb3VuZCBhIHRvb2xp
bmcgZmFpbHVyZS4NCg0KQ29zbWluLg0K

