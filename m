Return-Path: <netdev+bounces-195427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B024AD0195
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5485A178E4D
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC42882C3;
	Fri,  6 Jun 2025 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SzY/chR7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BFD287510;
	Fri,  6 Jun 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211197; cv=fail; b=PEe18h3ZSX4exzT0gPWPCP6JzL0j1TEUyF/wrfMdOpTLxiw39+erp08/TXHDdEfz5i0C/HuPejMUr6qbRnqZFXr7T4IhH1Np90LdHdLIpRxmYbQymlNiR59HesMPPx8zbRRmYrc3EHiHPhEXUhDcz/qnuzECM0uQUwlej4906jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211197; c=relaxed/simple;
	bh=ZbQ3UE8/5idrklRJxZMUgTPTskOddnahbOSfyKtSOs8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FN6Rv0+V6aLOXK/+zjSAxXLYLdzP+iGQKcLJcMCvYZOiI988kTLZUlKPB+SrmYI3XBYUjZ3Rk2pSfoL3pBcYvcpv+YXH7IHylvzi6si/ncGM7u8sxq2PyU1GLN8Vai36Og+dqHTDYLZR5iPaf07XelW4XoGFZcXXt7QeGw3Dbtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SzY/chR7; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEF59GmQQmBq7DxFJboEqT/2r49xZT7V8uegAWWQjXcvRT+F+lnptq2rz6Jz7yED1DL8DNU8XUFbtX7hz7/JaIlqu37jvdwCrEKgGrL/rhrQrkjUcGRpdzI7FwzaDqZFDoSTzY5fmMtOuPzu9AwaODbeGGixa0B0WeGimAiPUW9JaumosZTfNfOnNgFmBqn2PM+v3bndtn2lYiKs3++E32myj0Q79olWzcbA2KM/no9VceY5Mfc+KiqDJ3wFoQOtJ9LR+qW49U7jUEaR/BJ5jENg5tdIhKYsNvAvztKDTsaz9BaUrgxq1Ko+ebeazmAijyboDs6ZZoXwrkeivQTjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRMs3YbZNAu8SFIoqGK7IDqdvfAZScUlu2hH8AUrfWg=;
 b=mzylronBa9yVxVon00ipKwSzK2/cEpSd1vBknRhjpdTYx+T04uN8AwY9+vNwHTQB3J+A/0Tl7XSDyhXsCHOt9ruybhXn+2W/eT/B802hbE7HXPyWx7yQkPNmCJlsPFGzHBg9IB3lQbhBIB3tolGsrTQk00WCWxLuB5AXsnt79jef/NtRY5fPoI/MvhiPgTwwhrhHfHbUlsW4LoT7iLSQyf0lngH8bIh/l3AlfxSdRKne7XwqOQmRriYLVliFrePz/IX5Gf7tT0lWCd5bEgTX2WMFFBYPM6MtF/zFa1EQnOa267Za18uw/hpVSVE1HOTtXmgzff1QTCk71yozTO67xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRMs3YbZNAu8SFIoqGK7IDqdvfAZScUlu2hH8AUrfWg=;
 b=SzY/chR7c1kGR/kTg+l8Fh/PGdLVe9NcpKxOiLW2BxfQXGnupqNTtbrbR4I5Nu1eYDMBdAM3hiFYEpJ3euCwJrQyKdMYtyimPVmVUuY50ORg/X3a28g158qEWx3SZUvfSpyStIgT8uaD3uO9t35ns0dc4bvBf61vwB2tfSioXmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 11:59:52 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8792.036; Fri, 6 Jun 2025
 11:59:52 +0000
Message-ID: <d59c00f9-b8e3-46d2-a862-7ef20446e0f9@amd.com>
Date: Fri, 6 Jun 2025 12:59:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 05/22] cxl: Add function for type2 cxl regs setup
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-6-alejandro.lucero-palau@amd.com>
 <682e1b368fc8_1626e100c3@dwillia2-xfh.jf.intel.com.notmuch>
 <d64fad40-20f9-44ff-867a-8caacd70767b@amd.com>
 <682f835fba701_3e70100a5@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682f835fba701_3e70100a5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0595.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ede2d1-23c7-4c3e-9041-08dda4f1a4d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2NXV1daWGR5djdHZ2VpZTZHV05YTTh2L2dlVmhGMlRpalNSbjRoM0FuWkxM?=
 =?utf-8?B?RTVzcWNlLzdUaDNDL05VWTZzNGkzTUJUdHRTZVN1K1hjQTBVS2ZxVGZ5enU5?=
 =?utf-8?B?cjR6UEk1eDB1ZEJkc1dOV2hacDFTSkNnQ2toUm90aGNGVVJ0UE1lR09WNEJu?=
 =?utf-8?B?TGVPeUtRcHgvWGdxMklaTGl5T2pFRUhURVYvcHpXWkZhSHE2ajF4S1ZsSE1K?=
 =?utf-8?B?UDAvU2pvN1dKZmVqS2ZETml4SzRBQnVQMkpTdU83VzdqbFloU0tEV0ZTSWRT?=
 =?utf-8?B?Z21DakNuZVJ2bDZwNlRzWGYvbjEyclduY2xMMENka1Fqc2o2RUVwcjZSRUdn?=
 =?utf-8?B?eUpLR2FuMjJRdjRkVlhYcjdmQWE5RG84RU0zRklHSkt5V2pGL1RjakpqR09Q?=
 =?utf-8?B?UnZzalovUUFlUmlpSmQxZFhNaEpGaFVZVC83TlQzSmF1WEtnNkN2ZDRHWHRD?=
 =?utf-8?B?Ti96VDM0ZTBtY0tta1N0VmdNZDNXdGtTcGFhWCtxdDd6ZFpVSUFxZGh3R094?=
 =?utf-8?B?UTNVR0xmOU1ZOWFZQWNHUnhnV1Z5YnNOR3pFK1c1TFZicjM0UlBGQkRwblFB?=
 =?utf-8?B?a2QvQkdKZk5pZE9hNVMvOWhGcE93MXVEVjZuNlZhMG1Eem8yMEFTUHNyVWRL?=
 =?utf-8?B?K0dyNHVoYVVzSW9qZDhzNnQ4U2lxVDlSZkVyN3hleW9OV2c1Tkk0Q1YvNnJh?=
 =?utf-8?B?aU4xVHl4cmdhNVk1UWE5S0hBRnJscnNnS3BSa2RRQTdPVUJrNkRSU1NDb3ZS?=
 =?utf-8?B?SFJuV25uZ25VS1Z0YXgybmlZZWEzK0R1L1R2UkRURmxjRkhTZE1tQThhN1l4?=
 =?utf-8?B?d0syMEdhcWF3bkphQXpzNDF5MzFhYXJQaWVUa1ROWjZYSTZOcm1hOVljeUJS?=
 =?utf-8?B?QkpHYWFlMjlYMUp1MnNRUGcrQzB5VG9BdXd5ZncrNEpMRDQvS21Yb2VWK0Y2?=
 =?utf-8?B?MVBTeE53emg1dHVzdWp5eUIyblR1VGtZRk9TUDFaUmt3ODgrK2hsL2dxb0ZK?=
 =?utf-8?B?eEtFWVhaWW45Z2NyRm03eEF1cVpadEVhSFd5ODBkWnV5MVZBOXQ0cUd4ajdN?=
 =?utf-8?B?UW0rV3AyZ0M2eGNqS0JnTUxCTDRudkxGeGZVNFQrWFBDVHQ3d05WUXpNcFhF?=
 =?utf-8?B?VUlZc1oyd2EvWXd3QXh1WC84R256OHJOREJ0YXJnTllEaEFPeU90b0lNUkdZ?=
 =?utf-8?B?OXllZ2VxaFFwbHUyd2pWUHMxU2tXM0NwNFJpQnQwbDdOcjM4UStGd3FNMEFn?=
 =?utf-8?B?QU03SEM1TW04cVZsbkNySGhiS29SL0NidENTYWdtMitya1Z3OE9vSUQ4VUxa?=
 =?utf-8?B?Q0xUUUVsVmt0UjhaYktReTV4NDZSUGFMQTUxenVVbHBpUmNIcFZrU1Zkck5H?=
 =?utf-8?B?Y2p0Nit4L2Roak9TZks2a0kwbjROdjVBd0w1K2VhbzZFYlpyOS9UcXYramU0?=
 =?utf-8?B?bDlTVFh6b1F2QUwxQUMrbzVLWWxteW1KRDR4aFQ4U2pvNElnaFRQVHJlY1hO?=
 =?utf-8?B?aCtWVzljYldmbDNlSkd0RkhIL2orbFBkMlErOGdJbVhFNTZ2aU16S2c3bDJR?=
 =?utf-8?B?SGIvT2IvZ0NQaVJPd1hkN3FZa1h4TnVucVRJdjN2RzVOUUZocHcvMU5JQU9t?=
 =?utf-8?B?TVZvT0NvK09IZGtMRFhvZVhyTlgxaU1kSVZEWTNTQlpaUzBlMzZ2MlBBaGRa?=
 =?utf-8?B?MjQxbisvMlJWclZvUkhhOXRWaExVMCsyemtIVURTcFVzczFKeFhsN3pWL3pV?=
 =?utf-8?B?eklIc0Vtc2JJdy9pK1dZRXJWZUdQdDEydG9MenBVUDVEVkZvcUU2c1BudjV0?=
 =?utf-8?B?c3lwZ1RRbmU2OUN3bjRaaXdkY3RsV2oxUW9LbmowNlRkeEs2aGZtc3BTdVdZ?=
 =?utf-8?B?Ujc2SlYxU1kyOEpKUnR4ZUNieEhCWXhkdTJDckdQUGxwWEhQMkw0R0piL2Qx?=
 =?utf-8?B?a2xqdzE2aVdLb1ZsWVFoYmN4K1BIM0F1QVNQSExYWENDTFRJVXplUFdtR0I4?=
 =?utf-8?B?WGhwYlBIS1p3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDVXbjY4aEcwUGFSS1l3aXd4WDRMZjkxbXUvTWkxMWdGNU1yVmRHSVNLVW5q?=
 =?utf-8?B?b0FKdnNsNDFER3JnVXV4Myt5ZklXYkQrQnJRVjVXZXE1WkFGK0hOWDUrRmhi?=
 =?utf-8?B?c0RYY1F0V3MrVVRvblJ1d25uNWUwQXA5TU5YRUJhUS9VaGxNT0dxU2M2MGtK?=
 =?utf-8?B?MFZ6VzFodVBFRHRQUFpCNVF2akJ5MUwxOGkrbTdoTk95SDZZb2ZWaXM4d2Js?=
 =?utf-8?B?d2FkOFB4d3RmMktIaElzaUlVNVpZakx5ckdRRUxHdkZaU2V4cVRkU1o2UTVK?=
 =?utf-8?B?bE1teUt2bnJmc1NWb0VuKzUrMEFIQ0NmenhLS21VVWJoYk5HU0tnMTdvWVoz?=
 =?utf-8?B?VmltbW44U2lMZnBBcDVKUS9zVmlQanhERjNRY21DL2pPaDdqL2VwOSswc2NT?=
 =?utf-8?B?WjNpUSt2RGErUnZFT0ExRFRTWDUwM3RwRjkzcVdSOXl6aEN2TGFJV0JsZW0r?=
 =?utf-8?B?NncxRU1obys1UEJIMHdjTlZVRk1XaEhtRENWVWpIWHkvNlk4bGJLakYxRmVu?=
 =?utf-8?B?MHk0ZmpxM3BBVHNQdURNUU5Xczk5aVp1bS9zaGZLeDY3MUZ1YTRBd2RHazVN?=
 =?utf-8?B?SGV1eXBWQU9HYU5EWnh3RDRTTkgvcnFkRjRmQXJOWUtNSEJndHBnbzlxVkJl?=
 =?utf-8?B?RnJMbEdMcmxpTG1sM0dwOHVqenc2dkNYZFVYa01mMHMyYzFYQnlwT3NrTEhu?=
 =?utf-8?B?UGUrVnJhWWlzeVl1UjI1U0FiY0hQdld0aWtvN0JXVzFLei9oK3lmYUpGUnYz?=
 =?utf-8?B?UzBnbVorVGNJN2VxclBEZkMxMU1oN2JwWU9SbWlMN1J2VmtkOFdYZE52NHZ0?=
 =?utf-8?B?ME9hSVBYQnFpbjNQSWZjblpqRXMyUFBzSVoxSTBpTXpmNDNibnR2bC8raHBq?=
 =?utf-8?B?Q2lkRWJBR3BKcW1oMGpPeWVtZ1NhVzdvVGhFUWloY1BrTzZ0UDlZRWlvZ0hK?=
 =?utf-8?B?NTdpVmgwWkNjdm56NEk4a3NJZEE4RURjbVpPTDZLYmZWczVxUVZzVHFjazk4?=
 =?utf-8?B?c09jN0dnbkFrSFpEYndOM1E1bU5ZaHlmR2J2NHllSWMvWlJNSzFpaG4vRERP?=
 =?utf-8?B?eG5EcnZvVVUxWE9wckVTaVE4K1pzdk9Hd201cDduYlBXTVJzcXUvZU1aVEhj?=
 =?utf-8?B?Z3hsOGtjYlIxUzN0bUZqOGZIUGtEc2JIdWdGdWdJUG8wZEU1akNndTl3dFZQ?=
 =?utf-8?B?NmJGUWdSQ2Q2WFI5bCtYSlEvT3VWTUtnSndSMjZvY0NjTkM3YmwzOHRBazVU?=
 =?utf-8?B?RGpYQTdGZlNpUzVJb01BUml4bjc1a1g4b3hRdGEvdVRtQVNQL0FsWDBINVFo?=
 =?utf-8?B?NEl0YmQ0S1ljbHlBMHhLNkdLaStpTW5UYUhQNE9MdXNzR1kvWmZyYXFic2tU?=
 =?utf-8?B?VEdkMWdEK3JuZy9wTDJTcHh4OUVycllxNDUrTjlQY21WT093ajRzc2FocWpX?=
 =?utf-8?B?cUhGTXRZOURpQndnSHJXaHYzNmxQSE9ZbjhMVVYyclU1SWdadzNzazVzbWVx?=
 =?utf-8?B?S0cySm8va1pwUFFkUmVtbWJjQU9qTjR4K3NNY1ZJYmlTS3RQRDhGWElNcDZs?=
 =?utf-8?B?Wk5NUlU4VEorU2sxdFNBN3ArRkkwZWlaRy9yZTIzZnJqcUN1VlluSzg3YlMx?=
 =?utf-8?B?Zk56bitkMzBxeVRTckVhZDFvR2Yrbk9pWDU5MXB6dDFDTnNkL1VwdlFPVlcr?=
 =?utf-8?B?bTgyVllDNUZMSittR05zTWUvZGpGc0pyUUlxZkhnaDl1NEhOY0FNZG5LVlBK?=
 =?utf-8?B?YThHV3B4OGd2MXFxczM1a1RyYTdQdkdsMGlCV1JxSjFMeGplTU1wQWcvaitS?=
 =?utf-8?B?MHl4V1BqWWMwSHBrMms4Y2srZHU2MUJIZkZvNGxyT1REYnk0bjRrbndmMDRG?=
 =?utf-8?B?a2I5T0J4eGd3Y3pYcmVOais3VGFPNXdQKzhWYy9vWnp3MmIxUVhtQWEzZ1ht?=
 =?utf-8?B?cW5wUzVJOEx5TkQyTHg5djVLWTQ3WktRcmVnM1I3clp0S0NIM1NvcVMzUnFL?=
 =?utf-8?B?dWcvdStkajlISkhVeEErbTN5Vm9URjdRbndoLzNkbDIzNk00ZU1mWGdpUFFI?=
 =?utf-8?B?Qm5xbERZSDB2aDcvYUw1bUhyT29EczZFcjQ4ZVdBUm9jVktVQnFVRFlHSG9j?=
 =?utf-8?Q?LkrqB/zlDblMAq4HvR4MJBEXO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ede2d1-23c7-4c3e-9041-08dda4f1a4d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 11:59:51.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qj4wQX65K+IJ6PL2fmqzt5n9NsdjAMI4uf/HNGoAYmj5y2hArKC5RhI5sNl/NJOn3qxvuO79EmpgIYAbHqGiaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738


On 5/22/25 21:04, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
> [..]
>>> The driver should know in advance if calling:
>>>
>>>       cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>>
>>> ...will fail. Put that logic where it belongs in the probe function of
>>> the type-2 driver directly. This helper is not helping, it is just
>>> obfuscating.
>>
>> As I said in the previous email, I disagree. The CXL API should be
>> handling all this. A client only cares about certain things, let's say
>> manageable things like capabilities, without going deep into CXL specs
>> about how all that needs to be implemented. This patch introduces a
>> function embedding different calls for those innerworkings which should
>> only be handled by the CXL core.
> No. Please keep this policy out of the core. Do not invent a new
> "capabilities" contract that the CXL core needs to maintain, and do not
> add thin "cxl_pci_accel_" helpers that just wrap existing core
> functionality. Call existing core functions directly and only augment
> them at the point where fundamental assumptions are violated between
> the "Type-3" and "Type-2" device models.
>
> If the fundamental assumption violation boils down to a policy
> difference between Type-2 and Type-3 then move that policy out of the
> core. For example, register discovery is a mechanism, what the client
> does with the result of that mechanism is policy and belongs in the
> leaf/client. It was an accident of implementation that mandatory Type-3
> register blocks were validated in the core not in cxl_pci from the
> outset.


While addressing this I did realize what you propose is far simpler ... 
what confused me for some time: how could I ended up adding so much 
complexity?


Then I realized the problem was the original request for not allowing 
Type2 drivers to use CXL core structs ... . All this changed with the 
way cxl_dev_state_create is now implemented so your proposal makes a lot 
of sense with the current situation.


I guess the patchset evolution makes things harder.


On another note, addressing this makes the patchset two patches shorter 
what is always a good thing.


