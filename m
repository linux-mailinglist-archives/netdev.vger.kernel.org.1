Return-Path: <netdev+bounces-241947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A90C8AF4D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF639344153
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E25326D6E;
	Wed, 26 Nov 2025 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WLhDHs5q"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D929B204
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174356; cv=fail; b=gIODwOtmFFgwLavOLBnmtxKBHesMRThyYfofC0fPv62YaAgDJQDFNAy934tblDk/Q57WL8jlzRZlvsyI8TLKTmwJu4iDjzofFYcfBQscXwUb2mqGS5N1GA+vRtfFdf8SOb5X7vi97YTI+YL0voPu5ccCipBULbIDxN0fUsWaH5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174356; c=relaxed/simple;
	bh=wZbq7iUDxdMDL1UAV97wvB3cbYUQS7/1whlOEAhaSO8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YEVtpdKttq1agdMoTRzdxyn9GIUksCi9I8CE8TUQIPiqwQT7fGGr8a0PRU2yXm1MDCpUu96DlYHiAfpHtiogu2CPZMKCywB8Hbez/2Xhwea2miJ1rPvF0jWsfjdiV6nvtjx56cjMxkcULL1MkADTz5lTJzlt7TtwIuIwpvPecBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WLhDHs5q; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thGMGPi29QD+gdrJZCuQltIB9bRrDuQwV61E5V4GhQwa85bhsFG5La+Rx6Ga2WGNoDqyLC5nKmekQ4uaZUbAMvHHAVCkzEPhecAdfTX+GcrAoY4dDK65mF7cWgc0ZS69a6p2gFyV8hEnZuX6gLrDxx0ccXn0aXxoOI/nSinP3dilsj/83D9f2Hhy8gAR3A4MXFuGdf8rChlTS3+h0dG54Cs78PqlhSOXMzL+KHKgFAk8CmmdWtn7dCx7H2ovJBIXFvC8sgP0/Vv583xWNVsxo6jb9O6FxgthpFUWgcg52kaQDdJG04OC1txI9IeWgQu3zdeTQYfc53PMZDCiIggspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnJss2qQtwFLOEeE1l3tl5Sh4EV5NFYg7dpHCnEE7bY=;
 b=xrYyfOboxKuv5ezUahZ9sh0Jfg2NFRM3Q2n8b0U6+7xHyvxH/CCOb+XQOBiCGW+25K3wuMD2EQN9OfOeLfGJgr/Mbig3jHzRa2Dql/ep4IgHGx/Kxnx2V/hEGHtfXcoIr3p2J2isQh6r7BjaQHaMIqN5uocjgpBdvqLuzvVCAsr16qZknSilw2ZfCTc0FFIr/+Ufio08rS+S+cW/sdNh3g91FiDdjbw2AdDYPf7CnEW4xcSMivBs3JEEKdFh2KX0OAnCyFAZgxJJDPVILD6xpuF8yt0UFNdNYtdAxm0nQSclyjw5rQqXQ5sfdYNCoS7gwm/vPsi2RKrcHasvABpxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnJss2qQtwFLOEeE1l3tl5Sh4EV5NFYg7dpHCnEE7bY=;
 b=WLhDHs5qapqxYODk0jgQmQt7j+xl2dNLtZPE5/Bfv5fArw5vemRleGlxhlg4tVIdQ0VIXo1uiaf2g0yGBhB5fJ9ClhwR0GGF6n/xxiLJdLmVPefx7hMR1cBYpJL1Ju7/CUnItffgiLSRIBuPQI9NvT7rVbU/D8TcX822rRLHfA8u/A7rs5SxqYoD6kBv7NfFDUGsxfeZDWE4m9DtO8TJdchBwzxNpKYjrwaBo3g0M8Im/B0uj9QwhR8W+GT2OXyJf4m8SWb3MFNRtqLK/CGVPgv8n9T0KMvgQAB0s3xzfkGJwNtHP4dFEduXXnoywdMIVWAUoB1Al09jpSSmKCvIkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 16:25:48 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 16:25:48 +0000
Message-ID: <1a770ddf-af27-4a44-95e0-b7971deac819@nvidia.com>
Date: Wed, 26 Nov 2025 10:25:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-8-danielj@nvidia.com>
 <20251124160517-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251124160517-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:5:bc::18) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdb1d4d-1197-445f-7e2e-08de2d087546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXN2U0ZneHFJZ3JQaVZTQU1oRXdKbWthcWhpbWQ3SnNxL0NZTnVnZnhsWDBr?=
 =?utf-8?B?MG5LSXBSMy9Uc1Zwa2FJbUdta0g0VlpEeVFMRW5EQjVrODIzVWhWQzhieDB4?=
 =?utf-8?B?OUJIL1UzbEFqOVRTanY2dFR3bitzaURxUGdwV3pwRTB6OU9ZWHZLaktxWTNR?=
 =?utf-8?B?T3VzbmdhWDZlN3NaSml1TVZIS1hiT2VncE41T3BleFpaS1BQejV0M2xvVFFx?=
 =?utf-8?B?Q3ZGQkF3ejRkQVZOcFdIN051UmkwMWJhNGFraWU4Z2pHa2tsUlRlOWFxYkNR?=
 =?utf-8?B?TnlBb0dkNmVNWjR0ekVsVmNQRnV0ZEJ6K1hVTE51WTA4QTJyaFh5TWtVdmJU?=
 =?utf-8?B?S05MaldZcDhZSi9MTDdLTkNjSU5Mb2NzTzNnS2xFR1VYRDVjcnpDU3pjZGND?=
 =?utf-8?B?OWJjQnVBc0Vxc2ZldUUzdmo1bDk2TnhmTlN4MWlxWklHNXczaCs3cTl0QllQ?=
 =?utf-8?B?OEwvUDhveWo5a3BpOS91UHI2aU54Z1pzcmorelg1TklwbDhSRGRyNC9wOHhn?=
 =?utf-8?B?WVU2N1pEYXkyK2I0SnFGaU51bU10czhZNVVTRDNqamcwSE1NbU1DUno1YkRv?=
 =?utf-8?B?MDZWV0NLdWlQaUgwb241cUxXMWlRSUYyL1hlbWd3bUlGR2FUczM1TVZBdjB5?=
 =?utf-8?B?ZTVTalN5NjhpTVZNcUpSQWZURzdDYUV3M041VEtFT1NiN3pRdlB0MHRpWjFj?=
 =?utf-8?B?YmNaVW0yd1JFenRLUEREbERqUkZ4dUNRMjhWK2dVMlM5eXY2OHJkVStmeTBB?=
 =?utf-8?B?YUIyQXNyZFdpQlU4cHMrVkk1RDRnd1dJUnRCTG5BbGhEN1NRRjZ0SzFVWUVV?=
 =?utf-8?B?SjZub1ZybmozblBnckNzNGZRazZ3WEg0a3FkdWE2OUx2M1ZCVUlzOVRaaHNv?=
 =?utf-8?B?bXZ6c2lZaDdlUHFpTkpuUHNnbEpKbjRBTnZ0aHJZazNaUDhQRTM5eVpsNjNw?=
 =?utf-8?B?T04yckZmdnNjd1VtbTY4eDFseUpLTGE5V1dhU01HNUtNSHh2WUl3bU5Oci8r?=
 =?utf-8?B?aXJnZGFFZWF6bElNUlFVeW5Sb1d4VHB2QTdzOEFJeHpDRmsrZ0Fka2ttaTd2?=
 =?utf-8?B?aEVNU0l1WHRTWDBZdWlZaGYwMTB3WE5hRjE0M3RoSFF3OW4xNm93VmZBaTl6?=
 =?utf-8?B?NXVKeEFRK2ZYWERmVW5lNklNSUlDdFptTlZjOUhQMlZaNWh3bzRDc3pJOTRX?=
 =?utf-8?B?TmEwQ3JKYzdtZnZGNDlHbDRHKzhkeWZTbHpFYUJoSEZVS1ZnOU5wYTMxd0Js?=
 =?utf-8?B?bjBNemthdGd2bEZ2MDdsS3J6Z2pmMFA5RUFwZVo0UzNzY28vVnV1QkNYaGVm?=
 =?utf-8?B?NWwxV09pcEs5d2FPb2dmdUljWHZUS0psUHpJUk5DOTlOWmlicHBaVTBWWXJM?=
 =?utf-8?B?dno0dXN5cXVVQkVpcjBidUF2dzB4U1BqZ0dnVVBMOHVvNnh4TWwwWUVCRnFl?=
 =?utf-8?B?ektIU09nZXBXQitKTUxDaXN5eTBZYTlOb2J4MXRUYm9vcHVIN2tKU0VUVXRs?=
 =?utf-8?B?V2o5bHp2RHV0ZWJKOXViTzFhdllxV3VJZVVidExteXVtVWpmSlFYOWpGb2RW?=
 =?utf-8?B?bEFmbDlnZVBkL1p0aEtJYmx2bDFudS9DT1IzT3E4Rys1WGcxQ05RaG5LMVR4?=
 =?utf-8?B?Z1JEdmh6Z0FhYTdKN1hkVE4vZ204OGJXN0VKTmxDRDBwbTJvMW1oRmJSclBs?=
 =?utf-8?B?OCtDNXA0UlFDclY1bFRuOUhEY0pObkJwSVMwRnoyVDdoY2VEQTBaR3dCN1l3?=
 =?utf-8?B?a2VtcitSVmxDSkpGTzk3Z0w3RTdaVmM5Q1E1WHUrNmt4dS9DY3NFWW1DZFY0?=
 =?utf-8?B?U2Nzd1o1OHQxK2d4ZytTdUFldndwb2FzRFhaK0VnYWkvc0l0SkF0ZlRjbDFl?=
 =?utf-8?B?VGVGdjlJRXBqY2ZEU200RGJNa2plM09jZXd3NDczUTZMVHJFd3BobGdNclV1?=
 =?utf-8?Q?1HDz9MjPtb+6DmpyIxKWI9Khyk1hO9s8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0VLTWlwYTlEQ04zK29ZTXE1SmVvZmIwdEV5YnQrSG8relRGQ05oVklCQmhR?=
 =?utf-8?B?N1pzb3krbjBFUC9jYWQyNG5LV1NzV0ZGamFZZURnVjhod0NobGNWTnhLYjJJ?=
 =?utf-8?B?bldrRWllMmw4N1RYZVA1djV5b1RmMmppWnpkQXQ5RlNkUFkybkZmdG9nNFVU?=
 =?utf-8?B?OGc5SXpkR1lvdi9OTWFFQ05Ya1Q3WUJYVGZCRGhyV3VlZDY0OFBmOHZQYU85?=
 =?utf-8?B?SmJRNG83SzNVQ1h6MEhxbldDYXJFMnk3MXhtcnI3U2J1SzBaM29URHJ4ZlVW?=
 =?utf-8?B?a0ZHQ0I2WDR1VjNrd21CK3BEZHI1NDFFUlZSRmloUjVQSm9jMVRJS2ZyZWkz?=
 =?utf-8?B?YkhKT1VxNUNmbEwyL1FPNmVEV1dxeStMbUNjaWtMa04va0twcjZoVHloeElU?=
 =?utf-8?B?REo1SWIrSDlSMC84dDhxUFRwSGFWUXRhOE9GT2wvRzlEUEtxQmdaSW15Tytx?=
 =?utf-8?B?YU5VRlhvMGhBWnFYU3FiSm1vUzlWMjYyd09qTHY2NHRXcFJ3MlVXUmZaL01G?=
 =?utf-8?B?c2xjMjVSdmZuN25wMzh6dFpmMXA0L3lCNWdyTTFRdHhJZWF1Wm5LdWhsTlI2?=
 =?utf-8?B?WHpib2xoOXpCT3VqVitEWE80UFZPSEpBRk5xSk5CMXlhSmsvaS9jdkhZNm5F?=
 =?utf-8?B?bkg1T0dZRUlBVVpCc3AwSVJNVzRSa05FUnp2aFZ0KzFkaExjQ1JZd2lMQ2tB?=
 =?utf-8?B?VTM1QlFSVi9aSk13M2hlWmJtZ25XQ002eXJOZ3h6OWxpZlJzWXNlbGsvaUdS?=
 =?utf-8?B?cXhmTGl0L2VWSWk0ZE1JRjVnNEg2d0pGRHVvU0JHM2N2Rm54ZkZPSUFaRmZu?=
 =?utf-8?B?SFNvb05CWDBQbXc3Z09pOUFkQlpHS3hjRmJLcThRQnhLWi9RVDB3SjBoVDZK?=
 =?utf-8?B?dEN6N1RpS3c5V3hhdnBlYXhwWjQzRUFxR1JHQzRPUW1FZWhzb1FxbG5jUWtB?=
 =?utf-8?B?ZEErak9yQWNEU09qaWtmTlh0VlZPT2VrZlRCT3l5ZC8rU0FpV2lNS1pqanlD?=
 =?utf-8?B?Mi8rWS9EWi9FREtQdWs2SGpGN1krbGVxOFNDV2crdzdvVzRBRCsvdkNldmM5?=
 =?utf-8?B?Njl5ZmdzWVNGK3Z2Q1JCMGtzSFBMcjgrUWIwTjR4ZDlhcHdQK0lvY2xlL3pn?=
 =?utf-8?B?c3ZPR2hKVmlZd0lSWEc1eEZ0SnhGNXBzTTRuZk0wcnpkQnVpaElwU1kxbTlB?=
 =?utf-8?B?dmZOTzJDSmdDbDN1ekp2Vk1meVR0TyttbVpENTZ3enZiWkFVODFEcXF5VFNz?=
 =?utf-8?B?MzR6cHlaKzh2bnkwWmNvMng0Q0xlQ3J1dWFIQUtoUTV3cWJEamY0WHF1QVJl?=
 =?utf-8?B?d0I2MVcrdnBTT3RIcExqS1gwd0FOMWV4TkoxTlFQanR6RVVuWmIrVy80V0FK?=
 =?utf-8?B?UG9xbE1MN09qVW80MVNnYXBWYmsxaHJvQWVJdDZFZ2xtY1U2TXkrUlU4OGtU?=
 =?utf-8?B?QkJQZ1hjQnZBSW11SEQwT0dGbk1oTWJSL2ZKSmtOeTJUQUcwU21FbURVVUJE?=
 =?utf-8?B?WTNQZWhUTkxSeXVaZVV2cGRhN3g0eUdnQXBCK2E0QVd6blYzLzg0WHN4Mmdy?=
 =?utf-8?B?c1IreVE4VHRCNzRoejdxOEpzZUxlUkMxUm0wUlowbHR6UjV1Q2l0L3JKRCtM?=
 =?utf-8?B?YVhmU3I2M2FQd1EzbEk1Zk1PL3RNWlNXbTR2alhpamNtYXJQVVAxTnErVk1z?=
 =?utf-8?B?RURZbTFLS2dzL05WTXEzVjdOSHBIaVdMWkIwcCtSOVdMalNCOWxKVVdCSjgy?=
 =?utf-8?B?dnc4d09iTDREcEJQb0ptV2NheWFQZnkxUkN1N1dnS2JBeG55L21CT0tVYm9K?=
 =?utf-8?B?eE1hRmMrNjNRSmNhRHZDSzNOM3V1UHB5VERuQkVMbGI0b09tc2xvSzhoenh4?=
 =?utf-8?B?M1M0aU9DK29OOS9PNWJFYWpaa2hNd2hNaVE2WkMyN3BmSFBrYmhwRDZzL0FE?=
 =?utf-8?B?VEdnUllSTWR0M05QS2NuVTZYbUIvMUw1NlIwS3lMeWc2WnlnbXN5bXhwZk5K?=
 =?utf-8?B?d0ZMdVRvMXZzUUNpY29hZXNUNnlMNXRnV0libFZSdUtNYzBpN0wyb25wRWNM?=
 =?utf-8?B?UVBVUUY3QVJ5R3o4OGJZN3kvQ05OVFA2Mkxsb1JMdmJoU1g0TnMralZUNk5k?=
 =?utf-8?Q?NAGmnyUwIwQ271N90h0YGNwjr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdb1d4d-1197-445f-7e2e-08de2d087546
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 16:25:48.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv3Qz/Yw5udjZH7gL2Q1yvBAD5jx9tFk5vIDQL2RDRZxQrVIqHvjNpUaQlJS/VlzLn/S0VuAcl1E137Dx5TyLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659

On 11/24/25 3:05 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:15:18PM -0600, Daniel Jurgens wrote:
>> @@ -5681,6 +5710,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>>  	.get_rxfh_fields = virtnet_get_hashflow,
>>  	.set_rxfh_fields = virtnet_set_hashflow,
>>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
>> +	.set_rxnfc = virtnet_set_rxnfc,
>>  };
>>  
>>  static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
> 
> should we not wire up get_rxnfc too? weird to be able to set but
> not get.
> 

I prefer to do that as the last patch. That's what really turn the
feature on. ethtool need to do gets before it can set. Also, this patch
is already quite large.

