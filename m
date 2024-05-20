Return-Path: <netdev+bounces-97169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA0F8C9AF6
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 12:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08631F21677
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4067048CDD;
	Mon, 20 May 2024 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RnOwRVsP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818E31CD32
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199589; cv=fail; b=Y6MVgshf4HTSmSTlo4azdJJ6WCA/n0H8KVJ8qK8pjpC/+xkXFZ/v2439QOEG6B5Mwvi3zN4dO7Jg49ZJNqmwah9IXSmUZ27hSGC8XYJ6ZakzVraEKhjh7A+E2Gg/EyY1HGpyW4JMqGR4lz9YB5x4f6Gx9Po84V094Q2xR4wigU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199589; c=relaxed/simple;
	bh=gnM2B/N+zeV8TY7q7BJJ6sHVrBQVipcXAa85rfBHkow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TTlQvCFuS1Lq9rdObIXmp29c5ePw/rV1VwX56T8xVnYIv1W7cfJ8+y51G2FyCt/MsXynVHKaz4TqkM9QWrSIvjgfJ6ThoKOzLCbl5gHXvqaYDPZqqNNfUGadRby+QFuAPDSPIdijnnUly5S7U6TEPIwLx3+TpdPNCeb5LfV7C6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RnOwRVsP; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/2fU+g7JAx5kNsA6eNMj3YGgIFjsMtzvcTLeMKM5yDDx+fzvvu4lHWoaGHoW+4p12mCZDTMGXJ8HeyEE9dIbhPhcWzfX4dhzcn6ki74+WmnAaIKIYr8bae2kAA9cKH1xF0x8y3ODOyZ0QcHRKuinqKJ6zGT/OmXDc02WFv4tEjTZB1MN9FDDUKvEnRHQbCINn70teuDiNGxC5nQi2MZkoxkeyKoecNj+gOlgQFIIoHhHV7EJI59dFc2VeKMTi997t9RuSQ9zUduyvGIFdPompsGVa5G3IgYFP65vk4DUFzEFlZ40aDvoWWGylDlewTfha5/9DnHXBfkmVbcbOeINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnM2B/N+zeV8TY7q7BJJ6sHVrBQVipcXAa85rfBHkow=;
 b=cH14OVs+f4U25frvqFAq0mNfsmjkJKH5Y5/8WhmBUE4BDE9jdLDpWJBLWfbWM5hAOGMNmWozpqKxGw3Fv2dGkh6qQpnov0aFHz13NjgY1Tf07ac9oSfCjScEmXJMyDuTwd0iRAGOhd1UwiCSkyLzhWAok6qPNHjn+wGbd1B8jLLiFFQbRMkB8YNbY/7m8wP+DNhtzyx6Pbzf+O6zO3feKgooHQSWzAEtoRoPtf4lW5DIpfETvovTaSWkxXzCpyoa5LrR24BJq4H8ijbn+C7QbHfhuDZda3NtMGggdH5gMzjoVze2GdSeBxJkj5yV36zxRPGaUE+/BnpbyDPNmzMb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnM2B/N+zeV8TY7q7BJJ6sHVrBQVipcXAa85rfBHkow=;
 b=RnOwRVsP94yx51GJ5X8JEFJRSswL7eKaexPNfhnTnX6raWbtSTuOc6a+n3YTlGzgWR+z590dzcm13XlWxikygTfIwvqtZqH50sE3imEo9gd1W7C5FmnR//iHoeZ0v02xNCClCVV2HiEO2ALNg6gInC++oVevMvXS+ZBEetE/ac4HFy3jGE1AcuMVAV5W+b0SBqw3FdsgVwxwWQPolY1JDFtj58UcXZ7ivMw2xTHX4ETnd6Q6h95cZTjSsiyiAyk1MMp0AkvtUO7kgUQ3IJolNyvue6MFHAJhYy7NnJq0P/g3uiAr8t8idBWR/46pjp5zUYlbsbVn7h2GlFpA5vd7wQ==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 10:06:24 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 10:06:24 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "edumazet@google.com" <edumazet@google.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Topic: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Index: AQHapRztf+XVv59L3kGimcbRJBg/jrGU9qgAgAFhhICAABVtAIAJgugA
Date: Mon, 20 May 2024 10:06:24 +0000
Message-ID: <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
References: <20240513100246.85173-1-jianbol@nvidia.com>
	 <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
	 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
	 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
In-Reply-To:
 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|MN0PR12MB6102:EE_
x-ms-office365-filtering-correlation-id: ed1e0b08-6d1b-423b-e7f9-08dc78b4819c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?K3dUNUJXYVBDZXFiK3lVRDhjc0hkS3ZFeXlIRXFYQUNOWVdYMHZaYmY2M29B?=
 =?utf-8?B?QmEwazJVZ005cTdleExYVHhmNkx5RzlZVkxnUFJMNmlXbWZuYmdWYW5QcHRH?=
 =?utf-8?B?S0l2eXRyQnBjaXBKNnY5QVM3d3E2Q1ozYVVWMEcwa0JpSjQxT2FoNElmcWhH?=
 =?utf-8?B?OVBVc3Y5dUVoNFNKRnpObFFyNlpIWWJHVU5yNmlQQi9EN01IazZaRmd4VU9W?=
 =?utf-8?B?NUpwUlVWa1N4WHpZVlRxUWVuQ0cxRWJySGVRY2g0bmxBUzI0eTI0MHA0eXVi?=
 =?utf-8?B?cWxKVERWc0Y3amszZWpqQi9qcE5kTFcyeEdnSWFTVlV6V0QraFJqZitFZnJI?=
 =?utf-8?B?K05IOFJUcVZZejVQN2NQZGMxTGFhbFZEVTR6S0VRdDdXRkpuczR0cDErMEkv?=
 =?utf-8?B?bkg1UWhWR3ZPeHJ0WSt4cjhnM1FFbzArV3VYTjRRZFM5NDhoR3pPb3FqVlRa?=
 =?utf-8?B?OERxcGR3c1RML00rejhvSkhTVysvR0FJeEJBSVdranJiL0x1MEs1WHk1MjVP?=
 =?utf-8?B?bXdLMEI1bXluQm8xYlVoMTJiY3gzcTVjNE9mZENOMCszamh3ZmVFTTdqN3FN?=
 =?utf-8?B?dUxDZVNiUU5EV3ZRa0E1MjJlQTFOTEdZMHMvUlNkWjA4cFVNckp0dkJOeW1O?=
 =?utf-8?B?RnhUZ1JLT05QbW1QS08rNEkwaUlNdlFSQlBPOEh5SHNsY0VsL0liV3I0TG96?=
 =?utf-8?B?bUlGSmtBTkMydFB4SDVtUkRTbTVPUmROTExGWWNiUjBOVSs0YlRybmtGVDFF?=
 =?utf-8?B?VjJPRm5VOEFHblVFOHp5cDgzVlc0U0ZxWVY2amJHMkx1ZEJYZUpOSjVHbGtp?=
 =?utf-8?B?Mks0d1dhdU1PNDRydzJ2bEE3eVFHZkhMTUFZMCtBampYT2hzbkY2NXpmeVBM?=
 =?utf-8?B?K3VHMldydDlTOU9LbERVcWMwWTdZcjFBSURhcUZ3aWEyVjNkd2J0bG9NN0VD?=
 =?utf-8?B?N2pBczVTZ25lQXZSWWlrcDFocFRvK3h0UWttSFZVY2E4VVB4RjUvdUNOSDVu?=
 =?utf-8?B?UGY0ZDBqczhCblVWRmtjTEE4QmRTQTBjQkQzaWZtUy9QMjBMWW5BNnE1Smg0?=
 =?utf-8?B?S0hpK3BEVVAxbzZaYTZpQXRIbEVnaUpid1B5aGF3SVNYRHZSbEtmRFc4ZDFv?=
 =?utf-8?B?eXU4US9DTWJHZ0VSaVI0bTNEcWxlQ3U0Snp3cnRaTXVqZmErT1lHanozWlhY?=
 =?utf-8?B?OGVaZkFja1dhUzByY1lxQzJjY3ZYMTl6SDl1QmwzWnp0VkFHMmx4SXF4WkM0?=
 =?utf-8?B?Y3ByUytKejZKd29KcnBkaWNUYVd4clA3Mm1qNlNadGQ3STMrZjlzYmhrK1ZP?=
 =?utf-8?B?TWRYWDZJU3Y3VmFxZGtzVnhmb0tlSEI3L09wekFYTUJ3M1Q5WER4YllTeU1I?=
 =?utf-8?B?YkZvODlvcndvY1VkYnI4aXNsTklWMnVIeUFscHlUN1hPY3ZFb0ZtTitJYWUv?=
 =?utf-8?B?amdsTDladEpidFJ3Z3gwNU8yVE1QaERCNWJCVnN0cTdnR3paajFEbUJjc055?=
 =?utf-8?B?b3F3N2RpMXZRUnhLRlYzWHd5TnZmbUQ1VWJIR2MvTFlkTEZSUC8rKzRsWHF6?=
 =?utf-8?B?MGFnOGZSRS80Vk85Vy9HZzQ4R2dGNzJPcGpxZnVObzdzeDV3UmMzUi9NSnZC?=
 =?utf-8?B?REkzY0lXbU84S3F2VzIyY1RUb0dDZU9ObVZZcEJoaTZLeEljSnR0cXdYVTRt?=
 =?utf-8?B?VkdoeGoxZ2dEbk1QRU4xakRXNU9jWE9NVnF1S0xXMWQvTXhhQXpWMXpwTXNS?=
 =?utf-8?B?R3hUOVlTbVl6OFlucVNNaDR3cXNXcnAxU1I2eG15VytXdTNkbzEzcStTWVkw?=
 =?utf-8?B?bWpFbzE0Rmc5a1d6eHJGQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnpLOWhwZ0Zram9MUkRiZm1zRG05aEQ0QnpwWmtla2JzZ001U3dWK2U1Tm84?=
 =?utf-8?B?K25Vb0VQZWRVMzZuR2VYaTFXTDE3Ni9ReGtGd2pHd2piYjBUc2xzQm1PUnRG?=
 =?utf-8?B?QU1DenlGT1FVUEtMRHc4azl5RnhBa0VOamwvUldyMGJZbkk4T3Jra2VlWXg2?=
 =?utf-8?B?UXFkT0V4alE3SmduUEdlKytKK2tWeCtxYitKVE02dzVTYzNUK2hkV0tPdi8r?=
 =?utf-8?B?WXhkWVg2S2dHYXdWZlhVVzVHcENtV1c5RU43MjQzVWJqSmdtMU1YT3pBeE9i?=
 =?utf-8?B?di9hRXhvaEE1b2ZYaE5rbGpPSFg4VTdhUkxXa0tNcDlkZGpVQ2pzM0VvRlRj?=
 =?utf-8?B?ZldQbGdyb3RFQ2UrYVZqTXRMSythM1FmMHJZNjQ3L2NQKzZQK0gxRkZnSVFW?=
 =?utf-8?B?YmEwWm00NjFoZHczQ3BaSzBOSXF0M2dWTStiS3VwTDYrT3J1TVJkOG84WEpG?=
 =?utf-8?B?WklwaUVzWWlPS3ZwYzI2QVJENFVFdmVJUkp1M013b3ZHYlgxSDRuZkpFdDdo?=
 =?utf-8?B?ZDhWZWU3SjdmdENzbDlmYzJ4cVBmRkxPcmw0cmZ2TUlTN1FhZVVCMi9ZeWlt?=
 =?utf-8?B?UGd0SVJ5UUJnZVd2MjY1NVhZdHhla05hZlNkVGlzeTZBTkdFaC9odXdaRktm?=
 =?utf-8?B?SVFqaE1qUkNJN01CMnFTbGdPcW1ESW80L0lJRG9yQy9KcnMwZVJhYmhoNzE4?=
 =?utf-8?B?bzBINGVrRDZzVmFBZlZoQW96U0lkY0s4Sm5CUE80eE5uL09hMHdBSml0WGlu?=
 =?utf-8?B?L282bms1L20wN1pPM1VRRGlXUGRFVThmNDVRTHlmdURpQS9XQ2tweUJGRFd0?=
 =?utf-8?B?ZGVBSXo0M2tjK3RWRzdrUkV4WkhJT1U4bzF0TTJOY21CTkNHcVpMNVdGTFZy?=
 =?utf-8?B?OTA5aEVHdTVKUG5qY2gyUkIvUDMyVUFVdDNyV0FUSXgxYkFNVEZjTWtHNlY5?=
 =?utf-8?B?MXJtWmlpTE1BNi82MTBRTVdNSmpFbVZ0L1RmSmVhbTlCVDdDaWJEQ2hqUThN?=
 =?utf-8?B?ZFhPUUs2MWRaSHNrTE05Y1ExbldETCtaNEVwTDZvUlk0dVVqVEpwakhTY1hV?=
 =?utf-8?B?ZEp6WTIxbHdlSHE4S3dVaktyd3VDY3grK3gzVGZsdVFqeUhVMkswNDVuUGZl?=
 =?utf-8?B?R01ERnlCdE1qVzJiUlNzUU5UdWMzY0J4eUFVc3RmaUxKbEdFN2RoV3IvWUQz?=
 =?utf-8?B?NmtGVXRFUHFLZXBieENZSkk2L1RkdHpzNUJLa1hRSUZyYXhpTUszOVBaKzUr?=
 =?utf-8?B?dUpyZE5OM3FaMEFLSklXMnVYa3AwVHN6dDJpMUZyaEU5QUpKMVNXZDE0VFdt?=
 =?utf-8?B?N1p6REw0cHRUT0ozbEp3Y1pJSm5ramtFNm5rT3o2YWdLNm1peVY1U2Z3RU0w?=
 =?utf-8?B?RGtXbWVSUjFxUkdSd0dSZUFRZjN1RDRqWEZJZCs0UjdNTk1TQzlUb3VaTFVN?=
 =?utf-8?B?RnZyU2lRS00xSG5VdGV2Sk9FMXVPdDNEUkhhQ090UXd3RkV4MWp1T3V6ZER1?=
 =?utf-8?B?Mk55NFNSSGY4TDBsc3ZUeWpDdWNCTW9jZXFuR1hZN01LYllVZ2hrS3F1N29W?=
 =?utf-8?B?aXZManpHZ1ZWM3YrU2syNnh4NUdrbnRWSEo0c2w2dGxxbm1URXVSY2U2VDVy?=
 =?utf-8?B?dFhMNXFzNjRQaGIwSVVaREo3eXN5bWJFT0w2M2JXTVVPMzh4SzFoNTFlTS9t?=
 =?utf-8?B?T013QUhpK2ZSUi9FS1J4MkVBV3ZBeER4MGFOcnUwbDZmSzVNd0o3RmxVVVJz?=
 =?utf-8?B?OUZKakxDcWphS2NZTnhETndvUDNGR01ERXMyRjdlNGd5aHFDRzk1ZmlHVzg1?=
 =?utf-8?B?Qml4d2VRQ1Rkby9YQ2d6Tm1kY2UvcDQ4ak9zZlM0M1NSUXVqTU4wSFd1Nkls?=
 =?utf-8?B?eHdkK0Z2TnBGOTRlQ0RsbGZmbStCZ2huZ2dybmI5K2tMMk9jRjg5T291NWxh?=
 =?utf-8?B?UXd3Z0pJUHBtUzh4bFFqS3IyQjZPMnhQVS9TbDZRUmMxc2NiTkF2UExRQ0hI?=
 =?utf-8?B?YUR4UHBRNEkwWUJTWjFjVDIwMEdISjFic1dtUUc0OHBLU2VtQWtKVFdoQzBo?=
 =?utf-8?B?RGZLM2VPdjBKRk5IQjdEZjJyc2h3ZnBPaEZQU2NtVGlldUcwZHlnOTljY0FS?=
 =?utf-8?Q?XmxA8EXejKLlqX9yH7F/vgd76?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A8BB1D862B5014798BEA9DC9872F16A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1e0b08-6d1b-423b-e7f9-08dc78b4819c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 10:06:24.3123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7ulDS7S4csk7vkpcvDe2J+frGxkgd8G3Uda6HkVOeH7LScYg8MJKf4BzEbrd84v1lW1E0edAQoz6N/2wm5obA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102

T24gVHVlLCAyMDI0LTA1LTE0IGF0IDEwOjUxICswMjAwLCBFcmljIER1bWF6ZXQgd3JvdGU6DQo+
IE9uIFR1ZSwgTWF5IDE0LCAyMDI0IGF0IDk6MzfigK9BTSBKaWFuYm8gTGl1IDxqaWFuYm9sQG52
aWRpYS5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyNC0wNS0xMyBhdCAxMjoy
OSArMDIwMCwgRXJpYyBEdW1hemV0IHdyb3RlOg0KPiA+ID4gT24gTW9uLCBNYXkgMTMsIDIwMjQg
YXQgMTI6MDTigK9QTSBKaWFuYm8gTGl1IDxqaWFuYm9sQG52aWRpYS5jb20+DQo+ID4gPiB3cm90
ZToNCj4gPiA+IA0KPiA+ID4gDQouLi4NCj4gPiA+IFRoaXMgYXR0cmlidXRpb24gYW5kIHBhdGNo
IHNlZW0gd3JvbmcuIEFsc28geW91IHNob3VsZCBDQyBYRlJNDQo+ID4gPiBtYWludGFpbmVycy4N
Cj4gPiA+IA0KPiA+ID4gQmVmb3JlIGJlaW5nIGZyZWVkIGZyb20gdGNwX3JlY3Ztc2coKSBwYXRo
LCBwYWNrZXRzIGNhbiBzaXQgaW4NCj4gPiA+IFRDUA0KPiA+ID4gcmVjZWl2ZSBxdWV1ZXMgZm9y
IGFyYml0cmFyeSBhbW91bnRzIG9mIHRpbWUuDQo+ID4gPiANCj4gPiA+IHNlY3BhdGhfcmVzZXQo
KSBzaG91bGQgYmUgY2FsbGVkIG11Y2ggZWFybGllciB0aGFuIGluIHRoZSBjb2RlDQo+ID4gPiB5
b3UNCj4gPiA+IHRyaWVkIHRvIGNoYW5nZS4NCj4gPiANCj4gPiBZZXMsIHRoaXMgYWxzbyBmaXhl
ZCB0aGUgaXNzdWUgaWYgSSBtb3ZlZCBzZWNwYXRjaF9yZXNldCgpIGJlZm9yZQ0KPiA+IHRjcF92
NF9kb19yY3YoKS4NCj4gPiANCj4gPiAtLS0gYS9uZXQvaXB2NC90Y3BfaXB2NC5jDQo+ID4gKysr
IGIvbmV0L2lwdjQvdGNwX2lwdjQuYw0KPiA+IEBAIC0yMzE0LDYgKzIzMTQsNyBAQCBpbnQgdGNw
X3Y0X3JjdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+IMKgwqDCoMKgwqDCoMKgIHRjcF92NF9m
aWxsX2NiKHNrYiwgaXBoLCB0aCk7DQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqAgc2tiLT5kZXYg
PSBOVUxMOw0KPiA+ICvCoMKgwqDCoMKgwqAgc2VjcGF0aF9yZXNldChza2IpOw0KPiA+IA0KPiA+
IMKgwqDCoMKgwqDCoMKgIGlmIChzay0+c2tfc3RhdGUgPT0gVENQX0xJU1RFTikgew0KPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSB0Y3BfdjRfZG9fcmN2KHNrLCBza2Ip
Ow0KPiA+IA0KPiA+IERvIHlvdSB3YW50IG1lIHRvIHNlbmQgdjIsIG9yIHB1c2ggYSBuZXcgb25l
IGlmIHlvdSBhZ3JlZSB3aXRoIHRoaXMNCj4gPiBjaGFuZ2U/DQo+IA0KPiBUaGF0IHdvdWxkIG9u
bHkgY2FyZSBhYm91dCBUQ1AgYW5kIElQdjQuDQo+IA0KPiBJIHRoaW5rIHdlIG5lZWQgYSBmdWxs
IGZpeCwgbm90IGEgcGFydGlhbCB3b3JrIGFyb3VuZCB0byBhbiBpbW1lZGlhdGUNCj4gcHJvYmxl
bS4NCj4gDQo+IENhbiB3ZSBoYXZlIHNvbWUgZmVlZGJhY2sgZnJvbSBTdGVmZmVuLCBJwqAgd29u
ZGVyIGlmIHdlIG1pc3NlZA0KPiBzb21ldGhpbmcgcmVhbGx5IG9idmlvdXMuDQo+IA0KPiBJdCBp
cyBoYXJkIHRvIGJlbGlldmUgdGhpcyBoYXMgYmVlbiBicm9rZW4gZm9yIHN1Y2jCoCBhIGxvbmcg
dGltZS4NCg0KQ291bGQgeW91IHBsZWFzZSBnaXZlIG1lIHNvbWUgc3VnZ2VzdGlvbnM/DQpTaG91
bGQgSSBhZGQgbmV3IGZ1bmN0aW9uIHRvIHJlc2V0IGJvdGggY3QgYW5kIHNlY3BhdGgsIGFuZCBy
ZXBsYWNlDQpuZl9yZXNldF9jdCgpIHdoZXJlIG5lY2Vzc2FyeSBvbiByZWNlaXZlIGZsb3c/DQoN
Cj4gDQo+IEkgdGhpbmsgdGhlIGlzc3VlIGNhbWUgd2l0aA0KPiANCj4gY29tbWl0IGQ3N2UzOGU2
MTJhMDE3NDgwMTU3ZmU2ZDJjMTQyMmY0MmNiNWI3ZTMNCj4gQXV0aG9yOiBTdGVmZmVuIEtsYXNz
ZXJ0IDxzdGVmZmVuLmtsYXNzZXJ0QHNlY3VuZXQuY29tPg0KPiBEYXRlOsKgwqAgRnJpIEFwciAx
NCAxMDowNjoxMCAyMDE3ICswMjAwDQo+IA0KPiDCoMKgwqAgeGZybTogQWRkIGFuIElQc2VjIGhh
cmR3YXJlIG9mZmxvYWRpbmcgQVBJDQo+IA0KPiDCoMKgwqAgVGhpcyBwYXRjaCBhZGRzIGFsbCB0
aGUgYml0cyB0aGF0IGFyZSBuZWVkZWQgdG8gZG8NCj4gwqDCoMKgIElQc2VjIGhhcmR3YXJlIG9m
ZmxvYWQgZm9yIElQc2VjIHN0YXRlcyBhbmQgRVNQIHBhY2tldHMuDQo+IMKgwqDCoCBXZSBhZGQg
eGZybWRldl9vcHMgdG8gdGhlIG5ldF9kZXZpY2UuIHhmcm1kZXZfb3BzIGhhcw0KPiDCoMKgwqAg
ZnVuY3Rpb24gcG9pbnRlcnMgdGhhdCBhcmUgbmVlZGVkIHRvIG1hbmFnZSB0aGUgeGZybQ0KPiDC
oMKgwqAgc3RhdGVzIGluIHRoZSBoYXJkd2FyZSBhbmQgdG8gZG8gYSBwZXIgcGFja2V0DQo+IMKg
wqDCoCBvZmZsb2FkaW5nIGRlY2lzaW9uLg0KPiANCj4gwqDCoMKgIEpvaW50IHdvcmsgd2l0aDoN
Cj4gwqDCoMKgIElsYW4gVGF5YXJpIDxpbGFudEBtZWxsYW5veC5jb20+DQo+IMKgwqDCoCBHdXkg
U2hhcGlybyA8Z3V5c2hAbWVsbGFub3guY29tPg0KPiDCoMKgwqAgWW9zc2kgS3VwZXJtYW4gPHlv
c3Npa3VAbWVsbGFub3guY29tPg0KPiANCj4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IEd1eSBTaGFw
aXJvIDxndXlzaEBtZWxsYW5veC5jb20+DQo+IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBJbGFuIFRh
eWFyaSA8aWxhbnRAbWVsbGFub3guY29tPg0KPiDCoMKgwqAgU2lnbmVkLW9mZi1ieTogWW9zc2kg
S3VwZXJtYW4gPHlvc3Npa3VAbWVsbGFub3guY29tPg0KPiDCoMKgwqAgU2lnbmVkLW9mZi1ieTog
U3RlZmZlbiBLbGFzc2VydCA8c3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbT4NCj4gDQo+IFdl
IHNob3VsZCBwcm9iYWJseSBoYW5kbGUgTkVUREVWX0RPV04vTkVUREVWX1VOUkVHSVNURVIgYmV0
dGVyLA0KPiBpbnN0ZWFkIG9mIGFkZGluZ8KgIHNlY3BhdGhfcmVzZXQoc2tiKSB0aGVyZSBhbmQg
dGhlcmUuDQoNCg==

