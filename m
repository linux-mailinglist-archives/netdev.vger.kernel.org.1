Return-Path: <netdev+bounces-233883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0F2C19F72
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 12:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD533B16EA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDE620297E;
	Wed, 29 Oct 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="25a3BlwT"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284778F29;
	Wed, 29 Oct 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736812; cv=fail; b=gutf9UAKPljAdYn+MHX/p1t9bcmpEluWXfImSwFNeXxHSfbU32RZOdXiE+GxSX/Rbjmb47a0hdTGc4wfL/1CWreRxU65mf9WGuuOU6kPMwCDJyh9oe5hZ0dyuymFRDlzA3cp00g7wf9kZEH37B6AN48jCMxAB3OXBsfonJ6xulk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736812; c=relaxed/simple;
	bh=irZDGw2tzOmAcD1/6xv7+3pC+YlOXqFKZhO7Wz/5kFU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BNhb33HBsEtOqJ/ZmLea3cdwvlUOsQpTLg5zUUCDh33xzgIc5shdER4Hb6ZCFMA99ZtMTlktCv+dTtzsBb4VCYXPOJ3Dogy50UDpovE0n+z/xv2SHQ0mpwxDnV9j4CFqvEFIRd4fmcaK28pZjCZnYjldtxd8cc4lycb7m52SqZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=25a3BlwT; arc=fail smtp.client-ip=52.101.56.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5MJzcogjnxLZwbp38ViGaAfxFxSI/YtIGnpsSGBZZRNhQ4iqIExAOn2CCxr5zYdoQRJrIV6Qr6dg/SShGqNPoEjhnE5OUQ90hteKRzzITbXs5aRAsGJSfsJuPkgoRXsmlGKbWBolcGRpXJ17guAR6Sgf6T13t/8ODPOgdjUmhaL4xgPs2JhJT2ODrqWSgeJa5OjRgke9Ejhniy48HApca1OIK0vqkWN8U+qBsGZo9e0Zx9kgFHctMAS9fhJNPUusW94lkuJIl4gDA28uwE8SQbBAIGcB1ZheoZoUF4/qD/Vu2QFKnmistrS3DbKnd82xmbaoDaFB/CYtK2IZaRKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfNIdgIFLtkHg3bSMhkMmBnK/AJQgy/R+N314DcUoyg=;
 b=tXhvFcYnNxqKJZct/g7x7oHfR+uyeat6n/h34Oll6yTOkFw636B8bza4rwxrtMYtNMmzZ6Fu+ED0ncz2a/OArulgxudhzq1fJCcUAr57TiphJniIqNV+J0GXXHxduiCTf10kxfT/csW2kTDohNbTNT9VnNTbLxvTh7AqsyAKg6iJ7b9XfVooLbg73GL1DNISg3+TUwjJD/9svBZge4BioImwgFBsZJU0Q0UUXVvSZMlHXDrQZ2oiRrIel/ah5NBcAKPrxy98JhstmJ50b7EObS7ipyp/nShA94Jrnrr9Bs2NjqB2wp+lBFiWmxc50qe6cadnNVb79Gyov1mEdx/YtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfNIdgIFLtkHg3bSMhkMmBnK/AJQgy/R+N314DcUoyg=;
 b=25a3BlwTvesLV5LqmPJByozs3MCGz9XDWNJ+RS9iNB6TvuZiDMLqGpdGTcKrx8bJIf+RjUiwrvw4bbiGJDRH0lOu4URI/2D4x0tsHMwCnDQ1Qs4pDGRzfv35UfTPbbVlSOL61s3634n9P36F0kftacdvyHke24L+TTLbx0ViDd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 11:20:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9253.011; Wed, 29 Oct 2025
 11:20:05 +0000
Message-ID: <801f4bcb-e12e-4fe2-a6d4-a46ca96a15f6@amd.com>
Date: Wed, 29 Oct 2025 11:20:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 01/22] cxl/mem: Arrange for always-synchronous memdev
 attach
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-2-alejandro.lucero-palau@amd.com>
 <20251007134053.00000dd3@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251007134053.00000dd3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::21) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dd06c1-5ff6-4ca1-6307-08de16dd1c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck9YU2FMdTRscjN4Zktkd0FobWlxUXNKa01ZMjhPOEVIcmROSTAyYlQwRnZn?=
 =?utf-8?B?MnI0VFZrQ2Z5cFFKU0UwajFWbXZqdlhmOEwrZytSMEJUeTNCUjJIazA3RVVE?=
 =?utf-8?B?QkhSYTVFV0xMY1V5ckRjWTMvZHBCOUhETzBpRk5aakpUcnR5RStRZk8xZWgw?=
 =?utf-8?B?NlFKbXZkTThONUliM0xrL0JOZVBQOXp6Y0lXOWZaUjNRN3lxVXZJTnRJcEx2?=
 =?utf-8?B?Y2FndEY2R2pDYWdOaWVUaDc4RmNjNVpjejk5ZjlxQWt4ZUs5RjNrVTNMemRO?=
 =?utf-8?B?TXJrb0l3bWNwSEtFOEh3d2xVWGh2RGdZajlGYTdpbW9QVE8rZ3RBTDl0WEo2?=
 =?utf-8?B?VTg3NTF3dG11Y0xKekZTYXQ1Y0Z1WHpSZjE4U2U0SzBMYXZ1VVBsMDZ1ellL?=
 =?utf-8?B?bFhNZ3dxaHFlOEc4MkYyZTE3REVyZnBXdVFkZlhybEhoLy8wNFlLNmdwUFpZ?=
 =?utf-8?B?YXdjR0s4MG1RemxLNXJBa0dQUkdnTWZjMTNSbkRQM3RmN2I0NlJka1ZnRTh2?=
 =?utf-8?B?Zy9yOURVRURkcEFsdy9STGNoUXhwc0FTQ3p4RzZVZ25JaHgzV3BIVFFZSmlm?=
 =?utf-8?B?emMrWVNlb1E4MWVQRnNnMXRteXhMR0pzTks4Y3MyT2cwQ1VXbHU4VlVsSzY2?=
 =?utf-8?B?Z3UvK2JXem9Lcmpud2lBOFBockFCRmc3OUdGUGNtN0RUMm9vNWF0MW9XT2JB?=
 =?utf-8?B?ZWtzdk5BdUxyQTBYbVRKalh1ZEtRbzNjTWdYZElGamk0cTBUSnFjanlrU1Ay?=
 =?utf-8?B?VXR0NUtyN2FBcjI1WkhqYS9wVEhpY3I4Nk1sTEpkZzcveHkzSmxhSzBVczZl?=
 =?utf-8?B?dmt5cklVZGNLTkhKdGlhQzhhQU56SWh5M3FJWlhpSXdsUWNSK0lHUFpMRVBQ?=
 =?utf-8?B?T2kycm1NREp1aHQ5VE9mNklzV1RPWkpwTFIrM2xOTlZWVGRlRFh2Zk5VL3Zi?=
 =?utf-8?B?eng3TVNQejJicG1KZ0RsRzVUWUFLK0lHaEhjQzdvOXF2SDVvcTZ5aW1od1Zi?=
 =?utf-8?B?cERQWGx3dTZUMVhQMUNUMGVPeFpWakNvY3p2cHIwR0Z3MTQ5SUU2cFUwb2xY?=
 =?utf-8?B?anFkdzFmcnFSUGdvR2dHQktGQ1FCMk9kRVNtVll0LzhwckRxTWE2OWtRNmJm?=
 =?utf-8?B?UlpRTkhHR1RBcTFLR2NINURQb3BBMU9KR0RoazU0bzVHaWVjeVQ5RUtkT1V4?=
 =?utf-8?B?aE9UTXFleGJwTUhaL1FVMUI1dWUxNFFCb01tZlRlNEF1RWtHTXhxL1VJYjV4?=
 =?utf-8?B?S3hoZWlCSTArMDNrcmkxYlJkOWpSMjQzRmdYYjZweWdjMlR6TktEU0xmRnE3?=
 =?utf-8?B?SmpsY3FXbVZnU2dtMTlIeU9UaS9wSTR0K2NGRjQ2WEl2d0M2ZkFFM1MvZGwx?=
 =?utf-8?B?ZjE5L1hiZHA0a0w1STlpYUR4YTY4M0ZtckZyVmZQS3BiOGphQy83Y0ZFQ3A0?=
 =?utf-8?B?bEVFVGNkQncxZUx5aU5ZdzNJa0dSMGczcUtwcTdXdHEwMlpCUWVJc1p1blZN?=
 =?utf-8?B?ZFJSVUF0TXhzd2Y1MkhYZmlXTXREY3BSalAyMGFSOWNWZmc5MjJKMVN5UTBN?=
 =?utf-8?B?aDFIRHA4OXpHeEtDb1YzVjRuVEdHbjVUS2YramV6cWF2QnZOL0d6SzRRd0V2?=
 =?utf-8?B?R25PQi9FeHpPWFE1UlpIYnJWYmRQVEJUKzdrRGlucHRleWFBNEVCVmJKRHBF?=
 =?utf-8?B?NHIvVEU1a29NeFpEQkdXbWF2UW8xeG44amJqaUc5OHByYmkreHE0LzhBQWVV?=
 =?utf-8?B?Z3F5dXVmM3VkVW5GV0VZMklOMkhqOHhaKzF1WDJ5OFhnUEk2Tm1pdEFBTnA4?=
 =?utf-8?B?NVFCRnVTL2lvOHBkK2wxZ1BJYVp1OFU1VGttZjBETDgyWFR2cXBVbmo1UUNh?=
 =?utf-8?B?REhqQ0RuN3JDUDFZNHFqZ2d5a2E5NTdOUDNWZVB3VDg0NTUzWXZaYmRQZG42?=
 =?utf-8?Q?7zASMktH88HrkRjswmwVKYInu0yDJpjC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG50TGhQeXcxRlJ2UW9xZmM2RmJrQ055cmYwTFNsa1hMU1NtM2dibDVqN3Q5?=
 =?utf-8?B?L0JEM0V4QVdLeUNQYXFRRGJDNUwzbUpEVS9NbzlxZnU3eDlRUHUvZzFveUp2?=
 =?utf-8?B?OFlaeE5rQkovVTdlMy9WZ0krM1crYUU4eUxhMGlRS0JyTjYvUWdQNU9IWWxF?=
 =?utf-8?B?Zk5HK0lpSU55T0JqVWlZT3pmVjcvVUJhazE2RlJlUU5vQ2piS3B2VlRQaXQ0?=
 =?utf-8?B?LzJxZm1GcmlnWmdNU1hKc3NhU3BJZnU2V3FQRlZpdlVLelFDNkxDd25mdGVs?=
 =?utf-8?B?OVBlZEJCUlVpZGpXTTN6cGZRVys5S0JwTEd3ckhUWnplTmMzM0VFdWtpMWpX?=
 =?utf-8?B?UFBxT0VDM21Kc0wxSFI3RmVpK3dFYmpUR3djZzdyOHRJUFFIdmVSdUUvMyt6?=
 =?utf-8?B?OVdmbnF3eG5XQWZKT2I0TU5ocHcwanVxWCs1a3BORCtGVDBQWnZzRWNPTHRO?=
 =?utf-8?B?OVRuVE5zNUNIcFMyZXFUaW9haDdKd3UvRXRuWFdhRmYxRzhtYmdTbkFVbEds?=
 =?utf-8?B?Mk1oZVFTdFNOc0gyeGhVaDFFRVptRE1VaHZDdmRqdFlGRG51U2JNUGU5cng3?=
 =?utf-8?B?SUVWdWJLM25oemRzNDVyM25mQ0Ntc0ozaUVVSzlQaGxjNVBxeHNVaTRlL3VC?=
 =?utf-8?B?THlPVTlSOG1lb3pmTy93aDRUS2tLeEhaWFBlUWIvUW9WMEU0V1RsN3o2TUhj?=
 =?utf-8?B?bUh0M3ZxamxiQkFVMzRTYTFNb0NpSm5BZlZEOGNRZkxhVnNBa3BwQm9xMU83?=
 =?utf-8?B?amJKU0dWNFovdmFJdGRnY0MrU1JYSElQaFpjK3htWlBBbmFRWmNKMXZyaFRo?=
 =?utf-8?B?Qm03MjdWSVQ1c2ErT2o0NmZQR1FBQ3RiS0hRZFVGdnRDL1RIRWNwQTFnUGJp?=
 =?utf-8?B?bGlkZzg5Z2xMNVZ0eWpRTWNEZ1pHRW5TNXhPb2NLcWVyK1BqV3NhY3RteWJX?=
 =?utf-8?B?ZGRLdUhoUFhvdDluZmc4YmdScVZwV1RmbDdLVi9jc3VIVVFyNXRUNDd3aXBJ?=
 =?utf-8?B?bmVhUzhrM21icXR2VlJ4UnpkR3BscDg4ZHBOUWFFdUMyRUpsczdiUVBBYjNt?=
 =?utf-8?B?d0ZHOTdGUUJiV3I4SXR3WDhja1VJMTVLT21BV2RFNFMxM0djcjV4Q3g5WHVx?=
 =?utf-8?B?SUgvMlJScW0xQ1pNN1VMZFMrUmxicmEwSmcrRFlDM2J0VnR2TUpJSUhiUnpB?=
 =?utf-8?B?ZlhhVUlzUEJ0VE5yLzBMd3pNWHkzSmVWMVBiR0J3SlhCd2NJYjhsNDdGY291?=
 =?utf-8?B?Uk9zNUZKNUtYM3FQRGlMM3djVncrNGp6SlBpcEM4cDV6UjdrMlJNSDB4WWtR?=
 =?utf-8?B?djZib0dDcnBkbmFGWjdIOWp4MTduUGhxYmdWVGYyM3NmY0ZVRDBOVjQvWHU1?=
 =?utf-8?B?akd0TUZOcWFxaDNQOUwvcWZkWUw2Z2NyVGg5bjE4VWttMHRjUWhJV3lHcXB0?=
 =?utf-8?B?WkhoMU9HSGcrdUUrTThPY01aUjg2MUNSNEpkNWhreW5RT1NRdENNWWxYM2p4?=
 =?utf-8?B?YU5DdkdtZTRmc1pyaWFYSUNaUG5KOUZweTBwVitHYmJuSWYvcWZpVUJ6c2Fv?=
 =?utf-8?B?b1E4MmYyOEx5SjdQYlRPMWNPQ2xCbGNFOFZDd0VMWnVBTks1RUVsUSt0Vitn?=
 =?utf-8?B?RnQ3WlhHZVRyVnZVQ2JqVTVZTGdmRWlLbXdoNkhkbnBMbnE5RHBsK2RtMDRQ?=
 =?utf-8?B?d2JDTytkMGlzRkk2VlZ6RnpoOFR1R0VZaGtWZzQwejdnQi9CT1FNWUtFb1Rk?=
 =?utf-8?B?TU0vVENsWHhxVkF2MmVNRzZHSHFRZEluZjJTUEdyeXJjNmZJZFFlODh1ajM2?=
 =?utf-8?B?aHd2akFGY3ZVZFlEai9yWDc3RTRWcTlKR2pkQkpkbWlOaTg2SEtIaTIvS1Vs?=
 =?utf-8?B?QWUwSnRlbVl1UFJ0dXJnb1VzRWQ2MVlBUGQ5RG9IMzBDYWhJbjNOeWIxQjB3?=
 =?utf-8?B?WTVoRWlPN3dEaGZaaVhOQy8zK1RHQkEyQ0VlanlpRG42K2JURFZ1ZzZxdVFU?=
 =?utf-8?B?cTcveXpNY1RLM05zZGxLTStDRlRvRWoweFRjV1VJN0toTXVwRDhwbTJNVVkz?=
 =?utf-8?B?VHFjRWRSQWJWaU9oTlA4N2d4UGk5SmFURFhTY1VIV3p4K3B1U0lxLzltT2M1?=
 =?utf-8?Q?ZxqN440wXusyA4328a6NKRpPv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dd06c1-5ff6-4ca1-6307-08de16dd1c2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 11:20:05.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mmasAOwMOayWsCmEH94FN76yAIvkuXDjSAxBbfbSqqX7wWdq5WQZOMgKZHxTM4QD05vfJeWe4SnwnMKCoTfTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388


On 10/7/25 13:40, Jonathan Cameron wrote:
> On Mon, 6 Oct 2025 11:01:09 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for CXL accelerator drivers that have a hard dependency on
>> CXL capability initialization, arrange for the endpoint probe result to be
>> conveyed to the caller of devm_cxl_add_memdev().
>>
>> As it stands cxl_pci does not care about the attach state of the cxl_memdev
>> because all generic memory expansion functionality can be handled by the
>> cxl_core. For accelerators, that driver needs to know perform driver
>> specific initialization if CXL is available, or exectute a fallback to PCIe
>> only operation.
>>
>> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
>> loading as one reason that a memdev may not be attached upon return from
>> devm_cxl_add_memdev().
>>
>> The diff is busy as this moves cxl_memdev_alloc() down below the definition
>> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
>> preclude needing to export more symbols from the cxl_core.
>>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Alejandro, SoB chain broken here which makes this currently unmergeable.
>
> Should definitely have your SoB as you sent the patch to the list and need
> to make a statement that you believe it to be fine to do so (see the Certificate
> of origin stuff in the docs).  Also, From should always be one of the authors.
> If Dan wrote this as the SoB suggests then From should be set to him..
>
> git commit --amend --author="Dan Williams <dan.j.williams@intel.com>"
>
> Will fix that up.  Then either you add your SoB on basis you just 'handled'
> the patch but didn't make substantial changes, or your SoB and a Codeveloped-by
> if you did make major changes.  If it is minor stuff you can an
> a sign off with # what changed
> comment next to it.


Understood. I'll ask Dan what he prefers.


>
> A few minor comments inline.
>
> Thanks,
>
> Jonathan
>
>
>> ---
>>   drivers/cxl/Kconfig       |  2 +-
>>   drivers/cxl/core/memdev.c | 97 ++++++++++++++++-----------------------
>>   drivers/cxl/mem.c         | 30 ++++++++++++
>>   drivers/cxl/private.h     | 11 +++++
>>   4 files changed, 82 insertions(+), 58 deletions(-)
>>   create mode 100644 drivers/cxl/private.h
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 028201e24523..111e05615f09 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -22,6 +22,7 @@ if CXL_BUS
>>   config CXL_PCI
>>   	tristate "PCI manageability"
>>   	default CXL_BUS
>> +	select CXL_MEM
>>   	help
>>   	  The CXL specification defines a "CXL memory device" sub-class in the
>>   	  PCI "memory controller" base class of devices. Device's identified by
>> @@ -89,7 +90,6 @@ config CXL_PMEM
>>   
>>   config CXL_MEM
>>   	tristate "CXL: Memory Expansion"
>> -	depends on CXL_PCI
>>   	default CXL_BUS
>>   	help
>>   	  The CXL.mem protocol allows a device to act as a provider of "System
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index c569e00a511f..2bef231008df 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> -
>> -err:
>> -	kfree(cxlmd);
>> -	return ERR_PTR(rc);
>>   }
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
>>   
>>   static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>>   			       unsigned long arg)
>> @@ -1023,50 +1012,44 @@ static const struct file_operations cxl_memdev_fops = {
>>   	.llseek = noop_llseek,
>>   };
>>   
>> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> -				       struct cxl_dev_state *cxlds)
>> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
>>   {
>>   	struct cxl_memdev *cxlmd;
>>   	struct device *dev;
>>   	struct cdev *cdev;
>>   	int rc;
>>   
>> -	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>> -	if (IS_ERR(cxlmd))
>> -		return cxlmd;
>> +	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
> It's a little bit non obvious due to the device initialize mid way
> through this, but given there are no error paths after that you can
> currently just do.
> 	struct cxl_memdev *cxlmd __free(kfree) =
> 		cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
> and
> 	return_ptr(cxlmd);
>
> in the good path.  That lets you then just return rather than having
> the goto err: handling for the error case that currently frees this
> manually.
>
> Unlike the change below, this one I think is definitely worth making.


I agree so I'll do it. The below suggestion is also needed ...


>
>> +	if (!cxlmd)
>> +		return ERR_PTR(-ENOMEM);
>>   
>> -	dev = &cxlmd->dev;
>> -	rc = dev_set_name(dev, "mem%d", cxlmd->id);
>> -	if (rc)
>> +	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
>> +	if (rc < 0)
>>   		goto err;
>> -
>> -	/*
>> -	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
>> -	 * needed as this is ordered with cdev_add() publishing the device.
>> -	 */
>> +	cxlmd->id = rc;
>> +	cxlmd->depth = -1;
>>   	cxlmd->cxlds = cxlds;
>>   	cxlds->cxlmd = cxlmd;
>>   
>> -	cdev = &cxlmd->cdev;
>> -	rc = cdev_device_add(cdev, dev);
>> -	if (rc)
>> -		goto err;
>> +	dev = &cxlmd->dev;
>> +	device_initialize(dev);
>> +	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
>> +	dev->parent = cxlds->dev;
>> +	dev->bus = &cxl_bus_type;
>> +	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>> +	dev->type = &cxl_memdev_type;
>> +	device_set_pm_not_required(dev);
>> +	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>   
>> -	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>> -	if (rc)
>> -		return ERR_PTR(rc);
>> +	cdev = &cxlmd->cdev;
>> +	cdev_init(cdev, &cxl_memdev_fops);
>>   	return cxlmd;
>>   
>>   err:
>> -	/*
>> -	 * The cdev was briefly live, shutdown any ioctl operations that
>> -	 * saw that state.
>> -	 */
>> -	cxl_memdev_shutdown(dev);
>> -	put_device(dev);
>> +	kfree(cxlmd);
>>   	return ERR_PTR(rc);
>>   }
>> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
>>   
>>   static void sanitize_teardown_notifier(void *data)
>>   {
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index f7dc0ba8905d..144749b9c818 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -7,6 +7,7 @@
>>   
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>> +#include "private.h"
>>   #include "core/core.h"
>>   
>>   /**
>> @@ -203,6 +204,34 @@ static int cxl_mem_probe(struct device *dev)
>>   	return devm_add_action_or_reset(dev, enable_suspend, NULL);
>>   }
>>   
>> +/**
>> + * devm_cxl_add_memdev - Add a CXL memory device
>> + * @host: devres alloc/release context and parent for the memdev
>> + * @cxlds: CXL device state to associate with the memdev
>> + *
>> + * Upon return the device will have had a chance to attach to the
>> + * cxl_mem driver, but may fail if the CXL topology is not ready
>> + * (hardware CXL link down, or software platform CXL root not attached)
>> + */
>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> +				       struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_memdev *cxlmd = cxl_memdev_alloc(cxlds);
> Bit marginal but you could do a DEFINE_FREE() for cxlmd
> similar to the one that exists for put_cxl_port
>
> You would then need to steal the pointer for the devm_ call at the
> end of this function.


We are not freeing cxlmd in case of errors after we got the allocation, 
so I think it makes sense.


Thank you.


>
>> +	int rc;
>> +
>> +	if (IS_ERR(cxlmd))
>> +		return cxlmd;
>> +
>> +	rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
>> +	if (rc) {
>> +		put_device(&cxlmd->dev);
>> +		return ERR_PTR(rc);
>> +	}
>> +
>> +	return devm_cxl_memdev_add_or_reset(host, cxlmd);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");

