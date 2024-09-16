Return-Path: <netdev+bounces-128543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7554197A3E5
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EB51F2A084
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95921158524;
	Mon, 16 Sep 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zeKc5fwt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A515622E;
	Mon, 16 Sep 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495823; cv=fail; b=tQF1gDXJKrF78wOqcIx9gt9wOhGZZnfIwGznDbx19DqocyFdp3Ls7tEO8xYevB9eJwUkPmglWXLN/rZU61/kbnksUfh5s3JnRu73IhlC3fTFR+K6e8PkbMaOA6RuSiOtC2TtpwqyVPvVUcsuGNmjvvcNtgH4U09jnaXVf1jdZVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495823; c=relaxed/simple;
	bh=Ink4TBfdpwgkYxrGKH+MnkObzUrdFlNXPy9nQS5eO48=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j8u8nKyxq3iaC0+HovtA84KZD3XCdWXiHqpEmReSXKqyZZhwbPPGpuzsVnzuFA5cHW3jQmp98kKRF5bu0cMfW9ePpiLwWjNqxP2bGej1DqrO1MnZZngpnDqbfFKNu7ES+Rsst0fWnLeIUzrIpd1FsZMaEwcr4VIjvgU84z0MRd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zeKc5fwt; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8m5Ihz0hHKBtsnidmrVewYA5bo3uIsVIcMEED/aOQ7zIg2xVhn+W0H8LDfhiezO7if8dE0Noe7iUOtFuxc+T09jEFUGs3vXCELt0byrPWueUrCKTuIS2plItGTdoRFGRW4yBxYf5zJ4qfl1X8yWR4X2iAZo55Mf2w+htIE30o5KYUcERU6kn733aXNEabvq4T8hq2CHGxCvYQfndOMo2cpv7c3fBUS3NKZd28mCtAq11QaTwDJa/3Cx4HLKYFllX/6xjgU0n6L5uYWSj/XA9gkVch7hYtOfrlTK0xUJakwsuRlJF0nXNJVkuZNvbCpuLv1uKURFyMhOBq67kqLzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lesaEuC11MAsD3lN58XeiEUcl/ACvl5WbWNN9Cb+c0=;
 b=spyWi//PPjY6csHgc+IhBYM5YmbzyKGMjlAHT5TQ4iIC44+/n1BL88beVatf+cKU4B0rSDZoTLgmPwAHZM7Gk4tMtihzN0/rzcxN5ye2NgqSJduMIIxZ0D+BPaIqPUc/n9KJm/KshKq0c01st2g7Qvrgh73uh+tn4eSua9iJ/41dRT+rEJmqw8zFC5CHDFJr6Eb4NGujhXLcVU1NOZFFvUX5DwtgQfIDoMifUKYTTgj//UcIL2A6X/XP8xIcptg9chckuJnqRYRTdjNuUMIh5EnjwTPR7jvZODSCY/BptSd2Wa+1xoqkDTLs8Sgsyuly1xN89le+Pzbd0wCAmKxoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lesaEuC11MAsD3lN58XeiEUcl/ACvl5WbWNN9Cb+c0=;
 b=zeKc5fwtqMHoCMVSDW2lYD4l69ctbu1h4kiG+uLeXywzVsbYV72B/o0v+ata4eATHrZAm92iQu7xfUf8qcwfXMuA6g+ak+ms415y0B6OezpATkn8fmoN1zAj21dc6mmGN909egTkiCnczAbD+hHzDGKZMYehCgoXvCo3X7TWbiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 14:10:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 14:10:19 +0000
Message-ID: <e72b8f47-cd0b-fb2f-dca5-8a89f5828e3f@amd.com>
Date: Mon, 16 Sep 2024 15:09:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 11/20] cxl: define a driver interface for HPA free
 space enumaration
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-12-alejandro.lucero-palau@amd.com>
 <20240913185232.000000c9@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240913185232.000000c9@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cdbdbc9-1273-41af-5c23-08dcd6594b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzBLREVMMExjR3Y5NVN5RlpiQ3Z5SHdvaVpBV0lKd1piZHRPaFh6Wms3M3hh?=
 =?utf-8?B?dWZzK3dRL0JCVXBFVHRBaWRBVGl0b2thbUtXTjNLYXROaXA5aXEvTHI0ektv?=
 =?utf-8?B?NmtucHFhT2g3b1RpelQwTUU5R2YrRjlmcVZMdVBETEMwdjljbHlVR0JKMFhR?=
 =?utf-8?B?WHJmYkZyZlVHM0VMUzNIRFJVOU9VUmZtemxSUGJZc3FzTjAydjNMZzlQVEZQ?=
 =?utf-8?B?NFF0cmVZUWV0Q0RiUHVNTlhmRU9JZjJtcXJ2RjNZdmNYRThVRkY3aENyalF5?=
 =?utf-8?B?YUhEcUFVL3BtS3JjeXdmSHBIcHB1UC93cElSTmtwMis4czA4TFVoVmxNaGJR?=
 =?utf-8?B?ZFpRVStzWWQ2NHJWekZzNUhTanhyUVRkVVlFQjE3UVBidCszeHRSOWRIVFVx?=
 =?utf-8?B?ZW5vVG9WUFdxK1dTcXhMSDJwZ3hxbjhaYWllTHRYb0h4Z3BWVm0wV3FHWmVS?=
 =?utf-8?B?WkhlQ0hvUGJsSm15MElGcnpKVkxzbGpnRy9mSmpPZ3EvbVA4T2w0Rm01VG4w?=
 =?utf-8?B?UmRITUxUelNzRUk0YWszYUdONG00UXlxL25qdXBqeU9ycnRFZFNjYzhwdDFn?=
 =?utf-8?B?UHFaQVNYY2tiMHB4TjFVWWluRWh1WWtoOHU2czQ2MG94OVo3MHJlbjRCUHBE?=
 =?utf-8?B?b0EvclN1cDBha3UxRG9vSS9WZ0xUZ3BUTG5mZ1FuUmxBcEZMZ2gvYkJ5RG9C?=
 =?utf-8?B?Qzh4U3BOaWR1ZUxYM1Bvd2NYbEhZVUxPUmdnYWtmR1NheFg3YTFxdUJqcys4?=
 =?utf-8?B?VHlyV0x3bnVUWXo2Q09SaEtUc09uY3hwVytlaVdFdWV2SUtWQkphZG1KK1Nk?=
 =?utf-8?B?bDJQVVBZVndSWi9sdVhhVGxPKzFuVldueUZCa3ErMUloYkZUam1YeloxeC9r?=
 =?utf-8?B?MjlCOFMwN3dWREVvaEhIdUR2NTIzcUtzVFBMNGRvY1lSdGhUdWZUSDd6RFZu?=
 =?utf-8?B?dzMyVHJoaW1YdWtNU2c4ZDd1b2dMaW5meTNTQzdWcjh1V25BcUU5WU1BVEMx?=
 =?utf-8?B?c1ZQV2Y4dFFVV2JwczdjU2hUNzJaSFI5UXA2dFJIaCsrVkN0WTQ2Y01PSVBi?=
 =?utf-8?B?M2M3YWU4OEdwS3FlZVNaMWIrY1drYmtBdVJ1d20zVEIvaWsrMUg2dXIvNFdK?=
 =?utf-8?B?TTh0RzZ4Y3ZzME9SM25Cd1MraC9DeFRhZWl0TTd2MWJHVGdBQXRud1JnY0d0?=
 =?utf-8?B?Qi9rU1FRQnNyMjZpV1R5RnU2aTRjUndCMXJqT1FzMVZuY3J1aWszaC9RUSta?=
 =?utf-8?B?VWxjMnd1ZEd0YmNmSGFSai9JVW1ENENpbnl2YkUwcVYxQkxndkVZbzVCeU9C?=
 =?utf-8?B?QmlTMlZWTWc2YS9hK1NYR2VXNHZic3lMVUtCZmw4eDlYdFFqTVAzNHJ4aE42?=
 =?utf-8?B?OS90Z29uMzVwMVdpbGplYTdZWHgrV3dxM1VLMWZpS0pnV0VJalJLSkgvTGhF?=
 =?utf-8?B?akZqKzBlQXVyeW5Yd1R2Skp0THNVdnNoVk0zWjZrdTkxYmRPUUxsUDE2MlZi?=
 =?utf-8?B?SXRHcGxBR3JMOW1nWG41SW9mRXBob2ZrVElzQ3hYQkdNWlhFY2RZM3ZvZUpK?=
 =?utf-8?B?RHBSMVJTWjh6RlZERVhNTjkrUUcxSzYySVhQUGszaVFkdy9CVG9zd1BYUFpQ?=
 =?utf-8?B?dmlDSjd0bUJzNlArUlM3YU9QUDVXcDFKUWw0QTZvS2o4SjRlS2NOUkx2Vm9Z?=
 =?utf-8?B?eFIzNnFkdExXTnp4V0ZrNnBBeEJtdC9yV2c2cVpBd1RSNDh2Z2F3NVFzMU9H?=
 =?utf-8?B?V01sOTE4WUR5aUJWdUtiYWpZSloyZXoyY1pjWkVRQTZIRmtiSmpiTnZ1R3lK?=
 =?utf-8?Q?X4Vs+k91suJ2FfASV8e8QgNthVyQWAaG01zTo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXR3MHlQNXVsTmpSMW5kNVd1T1gvUmhZaEdFWkxGTVlaMTNybjVocVh4V1hy?=
 =?utf-8?B?dWMya0RsNWU4WENqTEVHV1hhaWpPTEtqZFllYXBvTnNUMzJkcEVyWjNya3Vp?=
 =?utf-8?B?eXo4NDM3NnN2V2J6QkwwS2RIWDRMVnkxNkU4cUdjRFNLR21CRGozRUZIUkFt?=
 =?utf-8?B?cXAwMWF1blpRUjFnMzM2aWREdzZHMENoU2V4ZXVaSmN3dzVYanZmajdjZ0tW?=
 =?utf-8?B?czJqa3g1TEF0YnB3d0lQR0dBL3BqUTBUK1doNklrblc0Mk1taW9IUkhXT1JW?=
 =?utf-8?B?TTBwVDVSWW1NZDlucXBROEhqa2IvNkw3UjFoTUxHVU1WSEh3V05XWUtJKytr?=
 =?utf-8?B?OW1VSnhkRFdsUGJaVWFwMnkzY3hGdGMvbUpMYlhVaWIwT243ZlEzTUdLWGt0?=
 =?utf-8?B?K0FnMUVSVEx1ZGFYQ0d6MFE1cVhXS1JQN2FLQWNHZnBQS2ZPbnNIVmlHdy9I?=
 =?utf-8?B?TEZjVFBwb00yU2ZDSFRXZUZxVTdsOXJ3Qmt1bFpVemIxbHFxTS9lb1dINE9S?=
 =?utf-8?B?N1hHaUtSQWNwbXhIdlZQeENxbWFSc1JYRjFzMU82cndXYmxINnl0N0t1MzVL?=
 =?utf-8?B?K0sxcjd3MHA2RGdjaHB6a0VHcGcvdTR2d2REbmM2OXZaeEJnZEV1dGJSM3BU?=
 =?utf-8?B?MmxKaWs0VW9lTWhReXJQZ2FQRXJHc1ZyeHUxYVZtczg3S1lWUlNGSEFpSnlR?=
 =?utf-8?B?RW54dUo1VXNaZ1FXV3VGNUxWYmhKRTFLVmcxZ29Hbk9iclFTdDJrZERSd3hw?=
 =?utf-8?B?QjQ2OEV0OWs1RUNGbkFYS2tCT2dnbHZLRGpNZnFoUGZtcUtNdksvbjJqYTNK?=
 =?utf-8?B?ZFEzUHAwZld4Wk9IZkVVNDFCRk1sSDdKalF1eFZ1cklxNzVyRi9ac3N5dTZW?=
 =?utf-8?B?REoyUHI3dFhaai8xbzZwYzVlSVh3Zyt1UzhFdlBFc3ozbnV0NERYbW1CZUtI?=
 =?utf-8?B?bjUxdkR1eDliY3cvclB2MG9RYk83YzJ6eUl0ZVQrQjZIKytVZE5UN3FKSlZE?=
 =?utf-8?B?SlJReUlNTkpRWDhYb2t2d202NW1mdjdvY1ZFZUZaUGtCN2hTd29BT0RBNzQ4?=
 =?utf-8?B?RTF2dFJTeGo1UHNqbUhER0l1c0s2UWVoTzQvT0F6OXhqcmJYQ0pZSWlXeW1J?=
 =?utf-8?B?TlY5NDlWTTIrUVhuM1liMmE4dXMzVzU4VHRud0RrRytrNTVsajN0cFJGSXBp?=
 =?utf-8?B?VDIvNmlHT0VMZ2Y2d2xHa3l1NjVsTnJzbDVwT24zUWNITXE1ZGhXUXB0bXph?=
 =?utf-8?B?bHBQRzJyWkU3L2srMHVOc3pXUG9KWWNOejltRVgxaUdScWNMY3l0L25TdUxN?=
 =?utf-8?B?dS9aVThKUll2WUhLTzV3ZjlkaHdjZFV1SXgrM1QvVVp3em80Z3lJL3Vyc1p3?=
 =?utf-8?B?dlZyQ1dIUUFpdjNlR1lQNXJmaVhNa2xSZ3V0eFRvQUlIZTVibW1UQVpEMkdL?=
 =?utf-8?B?eXo4cGlVYU1WQUd4TGx0clZESnJUajE5K3BkTlk3MVkyT3lzTjk3T2xRcS8v?=
 =?utf-8?B?bVhwWDJBak1sYkRTQTFZNjRudkJQSVdQSTVrNXA1K2tuc2xIb1g0YmpMdW03?=
 =?utf-8?B?aXZSS2toUVprVDZXSCtOZVhXSklyWkdEYTc4QWpWcmtTd2d5SnlRbEZnOFBU?=
 =?utf-8?B?Nnl4ajQzTG5tZjhqTGFabFVEMDNCYUNGV05FUkE5ZzFpekZuVWVxb0FOVm5V?=
 =?utf-8?B?QVhXcUlZVE9FN0NYYUZJeDc1U3FTamMvWlJkbi9zSE4zUUcxT3ZZRFNTN2J4?=
 =?utf-8?B?MS9aSENOblZtWVVoUllBUTE2R0MwK3g2T0ZlbnNHZXR5eFNsbFpXaTBETzVo?=
 =?utf-8?B?dEdUZ2xmbnowWjlyNnphb25uTWNSQmtRNHBvMDNBakdkRk1aNlA2MWpmeGZk?=
 =?utf-8?B?aFR1WE5mQnlJQjRCUVNOQkp3RG5MSldSdzhqMTJ6MGNkY1luVjl5M3Vub0Rh?=
 =?utf-8?B?M0xTM0RYcTRUMmdFOFpHN1NDdW9aSG9CZEJmazNabjZNWkJRU25zNVB5OFFG?=
 =?utf-8?B?a2p5Rk9XY3ZaOC9ob0xzLytRMHlIZWtkUEd1RVd0SDQvcTM3Wld1VExSUTlV?=
 =?utf-8?B?TlhzMU1HVFlvdFAzN3ZhcnJ5MlpZSDhlR1V4YkpLL0NER0NxS0VyVytHcCtR?=
 =?utf-8?Q?f5xnQgtqZvbuovbGLjDcR/+xg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdbdbc9-1273-41af-5c23-08dcd6594b99
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:10:18.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyHZ4hL4RlkYAeqiR51WJ/uU4FgXTwKSxwrvshVSKehb0qYRUyjTZrgaK89x76rHVT3HEUuUF/XFf9gGASOlQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108


On 9/13/24 18:52, Jonathan Cameron wrote:
> On Sat, 7 Sep 2024 09:18:27 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is create equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Trivial comment inline.
>
> J
>> ---
>>   drivers/cxl/core/region.c | 141 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   drivers/cxl/cxlmem.h      |   3 +
>>   include/linux/cxl/cxl.h   |   8 +++
>>   4 files changed, 155 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21ad5f242875..bb227bf894c4 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -703,6 +703,147 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device *host_bridge;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxld = &cxlrd->cxlsd.cxld;
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "%s, flags not matching: %08lx vs %08lx\n",
>> +			__func__, cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	/* An accelerator can not be part of an interleaved HPA range. */
>> +	if (cxld->interleave_ways != 1) {
>> +		dev_dbg(dev, "%s, interleave_ways not matching\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	cxlsd = &cxlrd->cxlsd;
> Perhaps move this before the
> cxld = and use it there as well?
>

Yes, I'll do.


>> +
>> +	guard(rwsem_read)(&cxl_region_rwsem);
>> +	if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
>> +		dev_dbg(dev, "%s, HOST BRIDGE DOES NOT MATCH\n", __func__);
> Capitals seem a bit ott.


I agree!

Thanks


>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	max = 0;
>> +	res = cxlrd->res->child;
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
>> +		__func__, &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
>> +		get_device(CXLRD_DEV(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +		dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
>> +			__func__, &max);
>> +	}
>> +	return 0;
>> +}

