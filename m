Return-Path: <netdev+bounces-181216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B2CA841DC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEB74C478E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE5828368E;
	Thu, 10 Apr 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kTLWf85E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22532281523;
	Thu, 10 Apr 2025 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285061; cv=fail; b=ZgcDTf/0nGus4+qgPGzxroe/FzaFSUExdFFl5xSE3yIo2Aayu5bAfXnraOIZNGG3DNa6OGt68DTGhBKYul7S3InZOO5g52ckchNOD1hpGsyvynj9rachc4q59yiD5MoKp4ZFXM+L0jH/qUlqnLYZqgsWBwzAu2ieDxGuglIa0s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285061; c=relaxed/simple;
	bh=cDWTrWdb1Snto4hrfBhxKkBKFESk0EOgj7ThebF+Gg0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O445M+4s6/HrLkSiR34ZdTfGQEFhlo8oQqOsV9HMzutouSy7qCA9aQLpCAiiAoK0WZXOaxB+94p4soon1ZwnLfOZiQH9juZXQR+W5dlfmPW2OoSFuaWzjyCTsDrS7zJasqFJZJ8MSbxE46AMGr5gdLjMzMAGeAmwYeybXJJ8hXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kTLWf85E; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BV5T+euNfdhEbZsvCJIjGTybVrqFvmNjoo1AV09EcrtYcZ56ZZToXfK9KRVVvYY0f34FZh6/WO3Z6EthseJnaZ6bJTNmLAiNUtt8D+aXhvsI6eaBFzF5T0FSEvVG2mrQKy5Qy9wX+0bZYvapkiNRvIg9YV9ekiI/oYfKxL2Pb6NvDHZoka6z+iBqixsMHq/pAOH0cPr9uMdzltrV2U2ODXBstFGNHW9NCIatVYmOcBQRf9fsW5/Lvre0DIBDswq7cHIN7fZQV6Bmcal2NeAbjJDLfipCo6ppHG7S60VlEa/2Fi2sf+YSoQPhzBcXmDIorNdPIMwiI74OCuHJE2w4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz0b3LqfHRbLjB2ToX+cqJB41BCIXS1ioE24GV1/CMo=;
 b=HzKfo1ao0zgLntkln1K79EUFYNDgs02TE1wSduD3d1FV6nJJKaO0Ge3SbooMcsjzDCItrdN0K9RJg5TIKtM/aTIDHMz6TQcPHuJ+Waxi2bUHa+/G7EkmqZLTU91Ix1Xtlh74LZrSqa3zO3X5mPwdWvgwuwkEm8pUlSNUqcVi1NU8jyXshh1DDJ7q6W/ab/SlqfNB6RKXROslkxqC1dh6MuT07goD0er+KOSgNwcW5f58x+1Ls8SgV6MNHY+QMY+UM4wQkEe2ar8MW8oBd2g8Sgtjc7+X+5ngtgFu25M/N/9KjoJS5ND6NgTOzYmrYYLRvqetvNzOiYLESepOuTUqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz0b3LqfHRbLjB2ToX+cqJB41BCIXS1ioE24GV1/CMo=;
 b=kTLWf85EHUKxYIOaNsLmvRJE5I2XKvD3LL09Y2TiNoqTfFxZ17Z5us2CpvxVgsv5VC8hUKNv3pRmzDMdLG2puQwlC3fxe+VHoxswQpbKczwGMPXSCkdrEuCRHkj9myMWEuAPmRDFMjA3UWtLQ0YMtmomAi4wr6bjzRXFUsYMh3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 10 Apr
 2025 11:37:34 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 11:37:34 +0000
Message-ID: <0c48a4a1-b23e-4648-8632-e1d068db9b08@amd.com>
Date: Thu, 10 Apr 2025 12:37:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/23] cxl: support dpa initialization without a
 mailbox
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-8-alejandro.lucero-palau@amd.com>
 <20250404170554.00007224@huawei.com>
 <c0f95226-7a7a-470f-a64b-8b5064568e80@amd.com>
In-Reply-To: <c0f95226-7a7a-470f-a64b-8b5064568e80@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::32) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: e02cc63c-2c5d-473a-c99d-08dd782415ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0M1NjVzMWxVSk1adDhUbVpYaTdpTkMwajJacWY1MzgraHZDd2JLMlZCQ3ZN?=
 =?utf-8?B?NndwRzNxa3dILzcwTE13TEFwdnhSNndSQy9rZ0RPeHhoekV2aTc2bWNnaWY0?=
 =?utf-8?B?RmYxaFZWWkFjUE45M20xUzM5NXBEUjFCUERkakltRlIyUzFUZys5N3ltUnRC?=
 =?utf-8?B?SGJaRzJ5T2ZSSEduT3kzcUE0UnJrMG5XbGs5UnErcUVDMXBKaCtYWmtLUXI0?=
 =?utf-8?B?dWE3MHp2UTVHcG0rdTBFdDQremJpcm91SkpMY0c1ZzRNTFBaQmxRWkkvY1pM?=
 =?utf-8?B?TTZJS1RMSmhZRFpqTTFTTStmYlIyQk9TSlJvZ1FOc3cxbFJ5K1k5UjJXTjZC?=
 =?utf-8?B?VGRnaVVuQ2ZwaU9ud3RqSGMxOC9TRlM0STczdm5tTmRxODUrODZWcXdEZ2JT?=
 =?utf-8?B?RnpEUkI2S2RubkpjUUJGRkIwSHZtZlNPekd1QW9Hc1EyOTl2bWZGSjhXd3A3?=
 =?utf-8?B?SVNGU0hsQzlLMjRaUXNGNFBqNlpNSDBsV29aL09mdGJBbEtsNFc3UnlsbG9F?=
 =?utf-8?B?L1dIQ04yQWJQYWhDeWxObDBqRTVla1M2ekZHcVpWSlZkamdISy9SWmtzbWZl?=
 =?utf-8?B?WDYwT1E1Y1RnaHR5WCtPM1JtODl5L2NDV1liaEZYa1VwdmczWnlpNDVlditT?=
 =?utf-8?B?TEtPNXZNZStNWDNnbWlUVGtHRWNMSUlhWmtic1RrTXJ1RnptMm4yZDVwT0or?=
 =?utf-8?B?dGhBZ1lycWZCMXo3QzZJN1hJOG8yZlc0azQzRjg5dGludVNhZUV6aitiS3Jv?=
 =?utf-8?B?RFJGMDVRcXUwSERPM0tkZGZKU0d0bnBOSzBaY2c4RG5nYnA2eU9KNnRtRFdx?=
 =?utf-8?B?N0ZJVlZBMit6YldGVDR2N0N5d3RaN0lOS1dhRHM4elg4Yy9tZ3JYcUhvQ29a?=
 =?utf-8?B?RHBkeEh4bG1BQ0Z2b2RrczhSMkQyci9HUytoMVpSYWNvaW53WUJqNVd3SkRx?=
 =?utf-8?B?WVZWVktkWmpMYUs1RkZZMzlBWnBuQk1PRDdnRTBQcklsdXhNSEVyUnV6OGdV?=
 =?utf-8?B?UjRsYzI2TGJlVU5Gc0g2ZHlZSmE2SlNlS2NSSU0wOU4yRTBySTFHWlk0Zjkr?=
 =?utf-8?B?NWVWTWpzTVU1SVhJZkluZEsvWDY1WjVCV1BaMzNuM1VBYkx5bjZOQ2taYWQx?=
 =?utf-8?B?cnpSZ2N2UWE4NVZNOHBsTXVYQUFiajhSR1ZiVlJJR3dqTVNnREFXL1U0bXpi?=
 =?utf-8?B?NTNWamw4MWdHaEhDSktvNFhwUFBKeVNwMjNYRStJcmtrZmxoUVNLeGZyS2Ra?=
 =?utf-8?B?Y1FjQ29Ya2hKeTVIZklTRm5kUnduRDNnelRINzlwemhUTnNwQ0VqMWNqVmdq?=
 =?utf-8?B?UTIydWg3R1dPS1dFTWpvcWExRWcrZGJzaHNOazEzWWNpVGZRMDFCTmd4QW9F?=
 =?utf-8?B?QWNBMzJ6UFkxUXM5bGhESGFtcGRHRVlDT1hINWNaZ2dGNTg5OHg4a3prTXF4?=
 =?utf-8?B?T3lMNTlja2s1aHpiWGMwRlk4VTVwWXpwR1g5TEVvU0t0SFNYSnczanY4cStH?=
 =?utf-8?B?WXlET0VEME5tQXhUeG9sZXJoaWt0RDA0cmV1NnZCTGJwSnozbjE3SkZPTHlQ?=
 =?utf-8?B?Ky9oamw0clVweHZweXRBNWRvdVB5QlpLRE9EZVorSlgrdW55MXp6eWhuRmVC?=
 =?utf-8?B?VHQ0ekJ4Q1BZR3ZVYzhSaEhtc2Q1ZXZEbTdPMm1lWStnNVVoV2xMZ1VURGFi?=
 =?utf-8?B?ZUxhMmFsalFSc3d2S0pPOGVoZGJmdmZVbFByV1BqRnRwM0Z4aUlSdnVldVlC?=
 =?utf-8?B?eHMrWXBtSkhEY2dOQVA1MkhOMGx6N20zZTMxKzVTVk5rNWZHMmRWRWwzMks0?=
 =?utf-8?B?Ujk1M2VwcUV0clhKL1FFYU5XQWNpYTZub0ZYN240YUZIeU4wYmIvVFFHZHZG?=
 =?utf-8?B?cC9ZN3AvZXZvR1BGQzV5bTRMa2RnRnQyVlBIamlQZVp5N0NKYkVvNlhBMEhT?=
 =?utf-8?Q?M7kJEBp4Q4w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0NnTDluL2hMREFGdnRBMlhFaGVPTmhWbEM1bjVJMEI5VXlWWnp2NTlJWXpG?=
 =?utf-8?B?OEpPNFFvLzhDNjlzZGI2ajROeUthdDlJNitjU0hMcXRaMklxakFQck52Q1BM?=
 =?utf-8?B?Ymw1THVYaHV5Qk9hbW5pV2VtOG5jemVrZk1US2NsRnRLaytvUFVuTmVoSGhI?=
 =?utf-8?B?bzVzUUZLVmFncklDb3FrMENLZndFbFBPWXhpcG5mRENHeDQ5OHMrMUVZbDNE?=
 =?utf-8?B?OGhaeDVyK1pxNjlEQ0kyZ0xrb1V4VnJwZGVyRFU2WGNGWmlLS3ZqUlA1dTll?=
 =?utf-8?B?c0IzejhPSHhreFYvdXdrMTk0WEc3ME9wUUlyZHBkSWdTbjhieVp5Z1BZeXJx?=
 =?utf-8?B?MjBkUHZyV1Z6RHkxL2oyQWtrVFExdkVMSXUxbjErMm5OUmpkOGZxOUp6Y2l0?=
 =?utf-8?B?YzJLdTl3UDF3bjdFeEtsdGlOSGhLTmlCYnVwcU52Nm1hek02a0d2UjRqZmpk?=
 =?utf-8?B?d2tEVzBsQ1RJSGFTTGhWN1dialRPaGEwYnJpVnppUm4rQ0N5VGZvdDhjdjFP?=
 =?utf-8?B?WEY5THZnYjBsUSs3TWJrSFJSaDF0aXBxSUJFSjJJcGo2NlFtbFJnTzZKT2RM?=
 =?utf-8?B?dGZvbjNyUjJSekxLWlB5OGVZb2xJZ251SE8rZFVRaTZuOWxWODBUVEFucEk0?=
 =?utf-8?B?T1doMW9RVU15NVlxL2pBSVNMZmRSTlNhUmZvclRhTWlYdUZzdkVxelJHQlNl?=
 =?utf-8?B?WmZoSmdwUWhWa2Y2a1B2cEFCbjRLQ2xXSGs5MndRYlFMOWoxUTQwS2xpNVB5?=
 =?utf-8?B?dEwvamxzRlJCNDhCdm5PeXhKWkZkQk50bnE1WUEwc3dqMXRaWFF6T1FEUGRU?=
 =?utf-8?B?MzdlQStBcFhBQVBJWTFqcGNrYU9URkMralZCdUJSNnpLTkxSNXRjRm9Mc1gz?=
 =?utf-8?B?NGtmczN2YmcvSEJTcmFPa1dReXVEZDlvRHFoOUFkcW1mYnprT3FzUVlHZDc0?=
 =?utf-8?B?RXBISzROM00xOXVqQWZFTFZpa2lYcXVQb0wwMmVwUWRBd2czUE1KcVlHaSs3?=
 =?utf-8?B?YzgzMlAzcmlvZEpUWEJTbWV1aTJibEFKQkJ2YUE3V0I1clFiS1c0THYwNFlS?=
 =?utf-8?B?RnordVlEazc0WTZmdjdrOWJIb3ljaHJUK3NWT0h6ck1aeHRjaTlCdHBTcVlS?=
 =?utf-8?B?bXRidDBnbjhWWTFDRHBmT2pBTWRVQkRHYWVQbWxqMWIvRWNpaDVsUGN4MjBN?=
 =?utf-8?B?N1R2YUFlQWlPRnZVWkM5TXU5Y0szSlRQcUFDQ1FUaVhMSVBJcjk0WVl4RHho?=
 =?utf-8?B?R3JWeGorRFlPRnJDKzlmdFhYdzN5UXo4Z0VqdXNCUUxwaU5zYnlJZjBOMktx?=
 =?utf-8?B?SUl6b1BPbWlZOE95TExmRnRYZ0F1Vi9zRi9pZ201N1pwNFdyK0hTOTJ5Z04y?=
 =?utf-8?B?RzQzbDVhR3ZkNFFBeGo1RWRlZ3BkNTcvQTVnck9DSG84U2k1Z0UvSFhyL3Fw?=
 =?utf-8?B?T1NvWXhBS056RkwvWGkvcmVGN1NOMENMekdab1NpbmM4Q2pYWVUxMjdxaklt?=
 =?utf-8?B?bkg1aWdaRjhiNjVjQWlEc1hKUExrb0s1ZWtBbWZSbDc3NkxZL1hIWXFmV2JD?=
 =?utf-8?B?aGliTU45b2ZxdkE0MS8xbkl3ejZSMDEzNE40UzFrN2dKV0FnTkc1bXJKc2Fm?=
 =?utf-8?B?N3B4RUlBcklFdzl5YWFLNlBYRHBQR1NLZjlmUmpsZHlVOGlUYXU5TThkSk5B?=
 =?utf-8?B?TlhaeDNmMmY1d1AwN0Yyc3k4dWNvMjdoUkMzcGpsdUhFK1lxZUplQUdtT2lF?=
 =?utf-8?B?cEtDZE5LRUs3MkhoY1lBZU9ObmowME9kYjFXRTUxQmxlRlpTZG9qUE9VSnF0?=
 =?utf-8?B?aHZFRitHNnFEN2xwaHNvaUovalM5Skl6WFVQaEhhN3BMMWQ0dXZ2MGp6ZUov?=
 =?utf-8?B?a1FjU2Jjc3ozOE5nNkw2MG5ocXBCUTBzOWhPb25oRWlibk9QUWdQalBFYXg5?=
 =?utf-8?B?NmdzWXdua3BOZjBkQ2dVVmtxL01MTll1dE9hckF3YVlTYXcrYm45bllQdnQ3?=
 =?utf-8?B?bmFoQTdRVGd6VHBWZC9sV3MvUXo5OXdabWJFOTN0b2Q4cDd5Ly9NN204bnVj?=
 =?utf-8?B?WSs2UWNOMitYaHllYTc1cFI1MDVSLzFKYU92UGVYblhiYTM0VXJMTGcyclFF?=
 =?utf-8?Q?WIVwDEPIz6TcPopCYexhHZKow?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02cc63c-2c5d-473a-c99d-08dd782415ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:37:34.0964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzK8IRhG5HMY3M4oj5VzQigvpyG/JMBOcv+FtVtQKWJOdF5ksrPe0qhwdAVFXh42rNOCz11fjZ0KQBiqsjE6Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135


On 4/7/25 11:53, Alejandro Lucero Palau wrote:
>
> On 4/4/25 17:05, Jonathan Cameron wrote:
>> On Mon, 31 Mar 2025 15:45:39 +0100
>> alejandro.lucero-palau@amd.com wrote:
>>
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
>>> memdev state params which end up being used for dma initialization.
>> DMA
>>
>
> Ok
>
>
>>> Allow a Type2 driver to initialize dpa simply by giving the size of its
>> DPA
>
>
> Ok
>
>
>>> volatile and/or non-volatile hardware partitions.
>>>
>>> Export cxl_dpa_setup as well for initializing those added dpa 
>>> partitions
>>> with the proper resources.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>> ---
>>>   drivers/cxl/core/mbox.c | 17 ++++++++++++++---
>>>   drivers/cxl/cxlmem.h    | 13 -------------
>>>   include/cxl/cxl.h       | 14 ++++++++++++++
>>>   3 files changed, 28 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>>> index ab994d459f46..e4610e778723 100644
>>> --- a/drivers/cxl/core/mbox.c
>>> +++ b/drivers/cxl/core/mbox.c
>>> @@ -1284,6 +1284,18 @@ static void add_part(struct cxl_dpa_info 
>>> *info, u64 start, u64 size, enum cxl_pa
>>>       info->nr_partitions++;
>>>   }
>>>   +void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
>>> +              u64 persistent_bytes)
>>> +{
>>> +    if (!info->size)
>> Why?  What is this defending against?
>
>
> The new function is used by cxl_mem_dpa_fetch as well for avoiding 
> duplicated code, where size is initialized before the potential 
> invocation of cxl_mem_dpa_init.
>
>
> But with your heads up, I think I can just set the size 
> unconditionally and to change the caller in cxl_mem_dpa_fetch for 
> setting is if such invocation, because partition_align_bytes != 0, 
> does not happen.
>
>

After looking at this for implementing the discussed changes, I think it 
is better to keep the setting conditionally to the cxl_dpa_info state, 
that is if not size is set yet what is the case for Type2 without an mbox.

The reason is the values used for initializing size are different than 
in the Type3 case, or they could be. Currently the value is set to that 
one obtained from the total_capacity from the cxl_mbox_identify struct, 
so I'll preserve it.

I'm using though the new cxl_mem_dpa_init() for the other case inside 
cxl_mem_dpa_fetch() as you suggested.


Thank you


> Thanks!
>
>
>>> +        info->size = volatile_bytes + persistent_bytes;
>>> +
>>> +    add_part(info, 0, volatile_bytes, CXL_PARTMODE_RAM);
>>> +    add_part(info, volatile_bytes, persistent_bytes,
>>> +         CXL_PARTMODE_PMEM);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_init, "CXL");

