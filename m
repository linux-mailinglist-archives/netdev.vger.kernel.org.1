Return-Path: <netdev+bounces-128516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66EF979F4B
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0CC1C219C7
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DDC25570;
	Mon, 16 Sep 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U9nnQnqu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AF71B3A;
	Mon, 16 Sep 2024 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482635; cv=fail; b=eG/ja36OoyIS9iqGifnzEEiKZLNy4qc/rGL5BIWVOeFrtPCy+z41WBiSD5fuptZmKBhZIiVpW/6CTRdyo/O2clMHddjuyRJ9Vosj3ggDE2LWR7fFpe2rHRC5STU+ZEBWSih+x7hCN7uARcdlh4eA3ghadqAhIAd/Y6pvKfr3XuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482635; c=relaxed/simple;
	bh=sBl75okLONfZUNjKPP4SHUA3InokrVUioaSN0IWjmQY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LBSSeIxIbxurRM9LPN/jewfDvSxnoVt84Ao+U3SaQib6R4xIm3ltAOkVZkqDnn9dkO+Z9UeDeleUMxRd4aPQ6TIkCkgYmuN6yZuEUj+aSqMPrkwAqXWvgAbc4+Jz9x0A2JR8ym2PylN0muUst6gl+uR6se/kCo/IlW6s2jIoE9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U9nnQnqu; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4qTpI8wP33ixbjgMVO/FC7h2uQkKOU9TYtkSCbShcLERDv8TekbUd/qSaFeEAmpDFKEHRoi3r52Bqx91J6khUdmzuw7IDRW3z3/QVqMwtKjY1jS5lhrieyRvy8wLhBEMs48FOGh6fQN9+it9DrKIXwdWl0dlqhiFYYKXD8bvoUcLUEd5nL08TOrZ1mxByvGu3cYWVmgJ8lUB5gu7eYbWDsBn3Murq25PVtv3YCFBcmgc+7Jgel8uqbUj/Mbsqj1x7Jub0yoNQhOszfnmcy6SM/h45lm2x25n0GowHMAbul+yk5azNU+fimlFUN1OKjJU8ssZizu8h7S+AinYm6lxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsLbGIjYLOS8V0OdFtXmXllpKMrf+zBSnBXp7h1OFQg=;
 b=SHOYWRt3OsP0+HqhWmDpRhyLLBI8nD9gcB0hEGIFzUhrRKWcijKfw9dOrlkPzA8zLLYeeYxscHvUCQi5mFx+EUh/l0YSYo9ny6HP38T09hghqt24RouDvhvKQKTmEtEDi93PgR3RuyO3g0zNYrAAqigeto/IJIplOJAFbNJCmFQXZ6gQuzmP/OkZLBHvRY/0TagZVgfSix9d0fpY7AGDnd/cpWUVnUsCk0EOJn6Urf12LaCfa6CoOtb72vBV1Aks1EK4ylJK2Yn4NS6GyHuclZyKOzoGap0xIlCVmSffZZnHawEmPk2LfFq+86ZUqqCQT6QbUUKdTpeXOGTcFThyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsLbGIjYLOS8V0OdFtXmXllpKMrf+zBSnBXp7h1OFQg=;
 b=U9nnQnqutz3W/FcolHQpTILRDOdHb/DtxPwLQzLdtP1Sb0NYcN4PXGZ1w71QoW3e0wDSjx3nLHSJ2pypRzUmVXI7seZesSnGFw/6A9Vr4kSpk0bTEUw4kDg965YV3FD50YwFiQwibXQZqxTpuywUhBk3K6bMH0/zE5LzGPXz4fA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Mon, 16 Sep 2024 10:30:28 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 10:30:27 +0000
Message-ID: <a9ecb9db-fd3c-21ec-b39a-a97bbcc8e988@amd.com>
Date: Mon, 16 Sep 2024 11:29:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 12/20] efx: use acquire_endpoint when looking for free
 HPA
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-13-alejandro.lucero-palau@amd.com>
 <339d40b0-95f7-4174-9d0e-a954dc23c164@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <339d40b0-95f7-4174-9d0e-a954dc23c164@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0232.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e7e3cc-719b-4f48-c657-08dcd63a94c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amdEbmlJUnJtajNPYWJzYzhvSEZaSUZaeDNEeHJ0V2dIcXpzMkQzNVlyekhn?=
 =?utf-8?B?alFhZHFRT05MaS8wRXo1VEc4bVBYc0YzNTJWRlFCVVFCS2NLcm52Z01TNEpX?=
 =?utf-8?B?KzBjbUhzczhZWlNBNkoxQkdJQlhoaWRneGpDMlRQbzJKbHRsY0QrZ1B1ZjEv?=
 =?utf-8?B?OEQ3RWlwWXBMcXNMYVRGWjF2b255RFpuUWxDTnNENVNWYlVJcDY2c0JCeW5j?=
 =?utf-8?B?M0cyVU5TUDFsejdHbGg5eExHZDBndGRVZWJNV2pxZEIwZXY0MVA0V1oxcVhX?=
 =?utf-8?B?c1c3aHREdFViTEN3TTZVckViR1NnOTVkdXI0cVlaRllzQ2MvUmtMZlZjdzBL?=
 =?utf-8?B?Snp4Qko2c1lpVVR5eGRTejNYTHpBQVNGTHBPR2ZPNWdnMXdHaWlhTDRJOGJz?=
 =?utf-8?B?NElUR1U4RnErTnVTOG5lQi9EazNPVWE0K0ZmOWpMUG9LMktTblJsb2dQNUVG?=
 =?utf-8?B?MkNydzhiNndxYUNKdnNyeXpjaW50UG9oZEllQmFnNmh3bERIWGxEbllWWWZn?=
 =?utf-8?B?VmJsSHg5UmhGR0N5Nm1VTmJwOVh1bFc5aWhQdm9jbWMxMStCVkZHYXRDR0dW?=
 =?utf-8?B?T0xOVXZPTWtuNTZyanErWGRaRjF4S3B3M1dXRk5XNC9aVVYwNUdKWUVIMTV0?=
 =?utf-8?B?bUlPcVdPNWIyallGd1VYUzhvenl5VlByczdoSFVJRVpPZ21UTVJTQzJHWXl2?=
 =?utf-8?B?WCs4dUJZT3l5WkJSVDRVMU9pbWlvV3ZrOHk5VUd6dHppMHVPbmd6cXdObnky?=
 =?utf-8?B?bk8ybXlPa1NNeW1zTlBoUmNhMWFaOFlhYjFDbTlJbE5WVi9VV2NlZTVJNllW?=
 =?utf-8?B?MTQwTTEzcnNzOGliaDlNUTFFWUdIOFJJN01NWTNNMzZZYTVxOVY5Y2habzZB?=
 =?utf-8?B?dWtEaU9wdy9Bajg2dkloMkxMUk9SZUd0UDVKSFNxeThST09RdU1YaitvN2lU?=
 =?utf-8?B?N3VET3ErbnMzMG4vTHR0T2RxMEc2TVZoTU9ZZUdMUnVuNWZmNmVGb0gyUVlu?=
 =?utf-8?B?blZGTWtrL2s3ZXV6R3Q2cVdhT2hwalVIa1JwWHRMTCtsNVdyS2xsZklqRjZZ?=
 =?utf-8?B?T0IrZEhZUEQzaStaYmViaTE2ZjZJMy9QMXVnLzNvVGp1bU9Xbms3Sy9SYkI0?=
 =?utf-8?B?NFppYlJTY1JqL0RHUUZ6NGhvc2lpQ3hnVVpTa29HQ0hsQU1aMXhKUDI5M0NN?=
 =?utf-8?B?S1cwSGdFUVJKT0YvSHhjbXdERXk4MkhaY3lESUdPcDg0Z1VIRXNzY0NxamQ3?=
 =?utf-8?B?VmNBa2RPcWo0cVBOUmtiWTQ4elBPVFduZkFzaVpONlh4eWE3ZUNzVVYwZ2d6?=
 =?utf-8?B?OElidVJCT09XblRzdWp3N1NJaGNBdTc4Zm0xY3FObitkRzE3TElKcEdHQm5N?=
 =?utf-8?B?THZtbFVSbHp4Zy8rYlFUdTBPVXZzTE45NFJMbTFCOVl1blg1ZHdaSVZ0S2ZE?=
 =?utf-8?B?RXFVMTJrRHJEMW5aREQrZnc4ZWIwRjFUQXVoTVpxYnFqUTJOamloa0s4WE5B?=
 =?utf-8?B?WXl6eFJUVm5CTlRmZ1owdDY3anNyTXladWZTdS9hV3FuNkxPeDdoVnFuUTV2?=
 =?utf-8?B?V3NHeGkyZEZGT3BRZDVFQ1pqc3hRVk40by9sdWhPRnpNaEtjekErNmVxcldJ?=
 =?utf-8?B?NE5XM2lIUllLajlxYXNLVVptd0Z1MUFjOStGazhsUDdZQjdGR2VTZ1NYbTdX?=
 =?utf-8?B?TEpjbyt4R2RSZUVCUCtMRGFNRnB3VVJKbEgxSTJ5a29rUHdtQlJCSlJIeVh4?=
 =?utf-8?B?S0JaTzVXd0duR1ZHUDhwVmhXc3YrQmh6WE1uWWxWUUh6WWc3cU1uTE9CU3pS?=
 =?utf-8?B?R2F3amYyUHNFVTBJTHVDL0plYXVZS3l2MUtZdytaS2phZWpaR3FiYmg5RHcz?=
 =?utf-8?Q?CprXA4Zef3pBc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VS8yWEdHK2tvYnp3ZGNBQWhXWC9BYVFUT0xrVjZsdWVtTW9lTUt5WUtEVW5W?=
 =?utf-8?B?UFJ6d1ZvS2lYeDJOU211WWRDS2tQZWt2RVdyM0xoN3ZLOGlMVkJmcldyckxG?=
 =?utf-8?B?cUtvNXkvVHJHOHZKMHRhalB2RC9MUjVmandCUjRQQUxGZTYzY1JxYnloRWh2?=
 =?utf-8?B?SnEyS3ZaQmhLVmJCQ2FNSUp1aHMwS2JZTG1YNlpxVzZBeWpPWHVqRnhWL2JS?=
 =?utf-8?B?aU9jQWtrS2F2RFRJY0dqNTRMT2tPVEJyendFM2JyYyswUDhGUjNsY25JelA5?=
 =?utf-8?B?V1p5dnhhMUFFZkRFQXdsbzlQNlMvMTZqM0FSU0FYcHpQM1hKdzF3VzluQ29W?=
 =?utf-8?B?aVlMaklHM3Z3UFdLSEVXMGVnaVBoS0plUXNQUDVDM0FtWFpHSTRtanpIYWo5?=
 =?utf-8?B?aUxzcEZQZXVacWw1Rlp4akNMd0twZFR1TWpKY0JlSDYyTWtzc21yckc4Z0hl?=
 =?utf-8?B?ZEZWcmkzQVJBNXdQUVhRcSt4OXJNUlhGRVh1ck8wTzJrZmFGUG94L09VUzhq?=
 =?utf-8?B?bjhpVkRaQ3ZRV3l5WmV3R3FoejV5V3FydkMrVFVJSGJZVWNoYWRuZzZ5dkpl?=
 =?utf-8?B?ZkgrN1ZLZEMxbUxLNzk2QXR6R0c1UUlMOWVyYit1OFU3VENxay81eVVzUHVN?=
 =?utf-8?B?SVlOM1JDbjg2blFpS1NNMWdYeHVsaG5telJVNXNXRTJPOVFMTjlyK2k1V3lo?=
 =?utf-8?B?VExXTU9FeEUva2EySXlGVjRCMzJpb29pTWx3U2pWM3gxWHBYQzlldzNMSGF3?=
 =?utf-8?B?QWE1VXdUcDIvNEdBekZUWS9WYUJUenk5VFlHY3VWTURqMCtSV3JHOVd3QkRX?=
 =?utf-8?B?Z0VKck5wUVJpSG1Dc1Y4UWVNcWE0UEtESVhZOWZUcDNuamRaaTRvVkpwMGp2?=
 =?utf-8?B?aU9wcFJWazNScUlPU0tmSGh6RmdLTFFrVXRPQStkWFI2SXRhb21uTjJHUVFM?=
 =?utf-8?B?bHJjTCtuWDRRTXpHWlRSYWcrdllNYW0xbW11ZFhWVEFsT2Fyelc1SDMxK01V?=
 =?utf-8?B?SFNuL2hsRVAyTi9vVFFZaW1TVlJiaHVTeG0zU1VLRk51Tmt2ZW5TZkxUeVRB?=
 =?utf-8?B?NDFOUEFNMlFFNWpqVTkraERxemtuZFE4SHJBMGhCaERSV3VYaktYL2k1U2FS?=
 =?utf-8?B?Sm91WUcwUHJ0NHlOWWhQMjJVRDZBeDg1M2VtdkQwRFlWeDhnL3FyTFpGUk9K?=
 =?utf-8?B?ekpQT1F2VUcxU2huNDArTEk2Ui8zbzdDV1B5MnkwOUNLd3VTeVlSTHFTeENt?=
 =?utf-8?B?VTlxeXhVd2FicVdEck1SN2kvRDVZclpyV2UvMXNrQnIyYVpEa2c5cGE0aEk0?=
 =?utf-8?B?UXROcTNQd250blVBUlFuYlAxQm5saGRwRXpJakJQdmZLZFFSMkxxVVFKSFN4?=
 =?utf-8?B?NVpOcmRXMElCL3pzcy9iVnR0dXd1U2lDSVhGdjg3VC9JVVlTMDNOdnduVU1Q?=
 =?utf-8?B?L3FFRHFsd1dlVGRpemtjT3dpVmswYlBPUmh4bmo2NGJuWGgwOWNueHJqVVA2?=
 =?utf-8?B?Sy9NR3FVcXNSOHJWWThMZXlVcWtDVTZKSW5MU0NUL1F3cFBKZTJrd2pHaFlW?=
 =?utf-8?B?K251WTN0TjNHc2IxcGJlZ2FhTjlJN3JjU3JjdlNOdzEyWEMrb1J3LzdBWTBL?=
 =?utf-8?B?SlVrdUJ4RWd6bHBXbGhpSmR4bnYwMmNjNUtpSnY4ZDU1RHhJN2Jqa1BWL3BO?=
 =?utf-8?B?eVFFZFowQVdPWldQeHlqQUplVGZTbGxXeERsSkdLU3pjKzFKcHc1YlJ5aVBp?=
 =?utf-8?B?UkgvZDNibzI0MW51c3FKT3c1MzBydTVNcTE2ekcxdlJWK3hJUzAyeTJ1ZWFj?=
 =?utf-8?B?R1pLWTc5UEU5aW1jNDVtV2ZqR09JdnFLM2g1MHhPWGhCQUZQNmx5QkFvV1p6?=
 =?utf-8?B?bmE5SG53ZERNanNDQU1DVnBvclVQTTVXR3JDM1oxV3lROWZUenIyaDFSV1ZM?=
 =?utf-8?B?SGpxQ2I0UnlucGoydUFiaHNiSy9TYXJTbER1WnhTRlkxN0pLWU94TDdWdldD?=
 =?utf-8?B?TGEvdTBpWjhwQVFITHVJejJPOW1JbzBKWk52WlJCNEJPcks3R1BtelNKUDIy?=
 =?utf-8?B?M0lzdVhjUkUxSDBCdXhzRHhuT2tjdTVQRW9BSk5yRlBQaTNFMHdwUmRDVTVN?=
 =?utf-8?Q?SXlbJ6j93V5nBdCPcYu2WZJch?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e7e3cc-719b-4f48-c657-08dcd63a94c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 10:30:27.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbcrgRw2+frqG9tLCELKN1Y4jRHMch3TsIAyhA52RgUsF7jmq2LjeNZsamHCnHoLpk7k4KD7NONNVsSl6lvU7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296


On 9/13/24 00:09, Dave Jiang wrote:
>
> On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Asking for availbale HPA space is the previous step to try to obtain
>> an HPA range suitable to accel driver purposes.
>>
>> Add this call to efx cxl initialization and use acquire_endpoint for
>> avoiding potential races with cxl port creation.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx.c     |  8 +++++++-
>>   drivers/net/ethernet/sfc/efx_cxl.c | 32 ++++++++++++++++++++++++++++++
>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
>> index 3a7406aa950c..08a2f527df16 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -1117,10 +1117,16 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>>   	 * used for PIO buffers. If there is no CXL support, or initialization
>>   	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
>>   	 * defined at specific PCI BAR regions will be used.
>> +	 *
>> +	 * The only error to handle is -EPROBE_DEFER happening if the root port
>> +	 * is not there yet.
>>   	 */
>>   	rc = efx_cxl_init(efx);
>> -	if (rc)
>> +	if (rc) {
>> +		if (rc == -EPROBE_DEFER)
>> +			goto fail2;
>>   		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
>> +	}
>>   
>>   	rc = efx_pci_probe_post_io(efx);
>>   	if (rc) {
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 899bc823a212..826759caa552 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -23,6 +23,7 @@ int efx_cxl_init(struct efx_nic *efx)
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>> +	resource_size_t max;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -90,7 +91,38 @@ int efx_cxl_init(struct efx_nic *efx)
>>   		goto err;
>>   	}
>>   
>> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
>> +	if (IS_ERR(cxl->endpoint)) {
>> +		rc = PTR_ERR(cxl->endpoint);
>> +		if (rc != -EPROBE_DEFER) {
>> +			pci_err(pci_dev, "CXL accel acquire endpoint failed");
>> +			goto err;
>> +		}
> What happens if (rc == -EPROBE_DEFER)? Here it drops down but you don't have a valid cxl->endpoint when cxl_get_hpa_freespace() is called.
>
> DJ
>   


I missed it!

I thought about implementing a test case for this situation what would 
have shown the bug ...

FWIW, the caller is checking that specific return.

Thanks!


>> +	}
>> +
>> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->endpoint,
>> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
>> +					   &max);
>> +
>> +	if (IS_ERR(cxl->cxlrd)) {
>> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
>> +		rc = PTR_ERR(cxl->cxlrd);
>> +		goto err_release;
>> +	}
>> +
>> +	if (max < EFX_CTPIO_BUFFER_SIZE) {
>> +		pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
>> +			__func__, max, EFX_CTPIO_BUFFER_SIZE);
>> +		rc = -ENOSPC;
>> +		goto err;
>> +	}
>> +
>> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>> +
>>   	return 0;
>> +
>> +err_release:
>> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>>   err:
>>   	kfree(cxl->cxlds);
>>   	kfree(cxl);

