Return-Path: <netdev+bounces-221361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2835CB504C7
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F335E5BC3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CA4352FF1;
	Tue,  9 Sep 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bfiGHuQ2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A331D384
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440621; cv=fail; b=boI2NA0EM40dZdVj+U1S7sDEMrj4oy/6LkS//pgPYwkS2oIqTScQfttM01JNcjNZLtT7o8m70R1cQ/11+q1T4wHiN64PvM51qRqvAFFmiaQOMKEahHKJTyaNuCSyvHQTYVEH/uRO2KuVJbvNzuzY8l66m3vzeBE0bkSnfrbstx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440621; c=relaxed/simple;
	bh=F1+yFRwwl76QYezpQdgqv/9vDSREFnf/d+PzhfhiQVQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W5Ojeo032FfRK18b4tjCLww5J28FfuzBKGHP+3K1kimJ2i5mMHAi+JyiTtrQS/ogjzWGU1gEuksytIpSXsptMsm5ZsTgvPNazPoU8pNS6MNaa0kklhocwE247XaOM40db1vilRfBxDM0hyUsTaB8OzldjLYqI1TtEbLHkin7IKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bfiGHuQ2; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS2DgdA7QeR6SkiCIaMXK6aOf6Y6g4h56ZcuFGllENZlUxJzX33f/IrMtVObSlrT/cvCMh9VIUxjkpk+5/h/3L5p99HDnX789YtTIv1i2b8rVj5ZCQFXWXoPghzBX0JiX5jIG4O+hJDaxCyaPLo93cBNnppQdZy2ZiNcTbJTJ03ID7bVgI0zPnuqFZpQaQfnIcqYfqfvEI8UOmSkVN2TPyveNLD5VjDjp5auIr75V0yyXhcw2Mr8+d+uNUoKSR2MfD8t4bT0qD4dky6EUqVKwWYhbRFvaXJNAnSCfvqdNBpRomeGW2Dw0QxhGzHIc8uLK0QRipE8r8bsBnuXNlkElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZ3SiqJAihy42Zh/MBfIBB+r2rME+IX8KDWkp6KbZik=;
 b=tlFXczfahznWPYrqPkX2HgqLDAkxkIZRerv9uJmi4he9JFkzW8qVe/lDhH+sYFP149TLaBDoXpCOHrnZT7OETshp9YFizoEjyA7cWwXnQFepxBceIsCVmc6VsLqZ4/pVXCEf+2CpVDEClsZk1C5ui5fAmBslqSVNpTkvZbIz83JPGh4bepJ+xGqTKgor1Kbhg5+7k7GVTlPh1v/k3McHQ/dbs6wSffJdBnfbUhQdXYzCy7gEN6hfEDcplXUtbsVDRmlngy2+zd4cxAog9KdZg7t6i1GTgxpufaB39JtoArn0YMZB1wOrUEO5rJliGZJJQhnOVBEbjVlwvMnyC6hx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ3SiqJAihy42Zh/MBfIBB+r2rME+IX8KDWkp6KbZik=;
 b=bfiGHuQ2Ry0pHugQRyf5IQzo0Jlt+CFiH8B8vmeS+NrnAl3n9X/FOqcWXudIRr32K0o7C50qNW4S/SXnJ1vzzjwkeTvuodgbu4V82Anj2FtIN9e0fLA2gJGk+Ex16b+Jl3OZ3GuRRN6C7OQbu/Z997aRiGxPeHqMUcoz6ooCvcRZhfVxvnLu++cO+CRtS6k3ZiDwovUy3rz8M2PnC3vwY//beIPRB1xygmc8LAFBkM6TQJirkcqag5MyF0e2j1dMAVlG+GRUtWQLFisNU1abQ/xkIb7f5eWDfuLPl1JWr37Ht0NwvnMYMdCpiZiXkm1toh5IMLKdWAOZVIeXiVXt5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 17:56:57 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%6]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 17:56:56 +0000
Message-ID: <ff73e96f-8912-461a-8445-ea332f701cbc@nvidia.com>
Date: Tue, 9 Sep 2025 12:56:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/11] virtio-pci: Expose generic device
 capability operations
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 alex.williamson@redhat.com, virtualization@lists.linux.dev,
 pabeni@redhat.com, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, Yishai Hadas <yishaih@nvidia.com>
References: <20250908164046.25051-1-danielj@nvidia.com>
 <20250908164046.25051-2-danielj@nvidia.com>
 <20250909152947.GA20205@horms.kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250909152947.GA20205@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:510:4::18) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f277e3-d331-441e-0a3a-08ddefca442c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEQ5UVJZa2p3K2RHdkFJcUExazdXcEJ2VmlvWStJSXcwaXV4L2VEdVAyRTFM?=
 =?utf-8?B?WFVGMStKRnE5MEtOTjJNanZ5ZmRXeGh3S3kzZ3Q1NDRWNmlEc0s4YXVONjRx?=
 =?utf-8?B?dVNuS0VpY3ZwNlFpcngvZmk3djNGSUh4c2Z4MWVtYldtQ1BIMHdJaHduMVNM?=
 =?utf-8?B?MnRVMGRUdHoyRzVKSjlIKzZaMTF1T3BsUVFzVkd0SmYrN1ZpbWw0UlFGZWJS?=
 =?utf-8?B?bHJ4VnB2dDRRdFFzSmVPbXl6MnUycXZtS2MxVmcrRFRQSzkrSjhULzA4WjZX?=
 =?utf-8?B?aVl2dGphV3MyTnlza1ZLWmN5R1BEYWJuOU5vQ2g0ZGhEcE5objBTeW9YbEVZ?=
 =?utf-8?B?cjlVemg1MlZvUDRtQjNScUlCcktzSXZDb21aRWhDcEJqYUxkam4zQmlUbk9F?=
 =?utf-8?B?UW9YMC91M0ZXZ2p6Z2QySG1aMTRTdk9ITEFhdklHYkVTOFg4SW1vaFNJWnhY?=
 =?utf-8?B?TjhRdUdUdnQ3QVJUb1Q0bFQ1NXhLbGhVbVBrb3VyZ0duN0RPREd4OGFhNUk5?=
 =?utf-8?B?V3IrRlBCK2VPSmxmczRHQUYwYzMzMVNUOTE2ZE9hNVdRa1gxajVJWWFVR2pK?=
 =?utf-8?B?ZzlxTDBZV1VPeUp2dlcxdExXRnNTakJoS2tVSmlqZDVlVThpMzJ2czdzZ3or?=
 =?utf-8?B?WVVBTStFWHFsNFpQTGZHWjQycVM5cGtzMmRDWnFOQUt1YklvaFlLUDJnaDBm?=
 =?utf-8?B?THB2TTR1VS9sVDhXdERXVGtjNXlaN0ZHYzBiMGREeUY1cE1acktJcmhqREE2?=
 =?utf-8?B?aE1wM29KWUVrTjdJc2I3R1hObTYzTU5waU5NRE54VEFBVHpaVGdZOEZNWmRH?=
 =?utf-8?B?cGxIQWduTG4rRnUrajQ5WjhwVUUxOEJXQmRSTXYzam1nMHZIUDRaUkFReUhl?=
 =?utf-8?B?VkZqbGE0dUxYOUlZb0xucGUvcERsRFVMbzlnTURRTEJVaXJVVWl4bEhUMFR4?=
 =?utf-8?B?Skp6dUxnWWJpUnVXanlrejZiNFZHdUp3Z00xOTZMU3VZR29XSVROb3ZDVGJZ?=
 =?utf-8?B?c1plZ2NmUmo1V3dRWStYcnp3S1VwbW9RaDZrYzdZQ0ZWTzhXNXd4a3lXa2da?=
 =?utf-8?B?Rk5yUEFFbXNqWW1xazBXNnM0NlBlVU5Yc1BxTFBITGlmRlR0K01GdkJJZTRG?=
 =?utf-8?B?WHVwS29XT2UvckZxYWRnRUl4WXZwaUtId1htTnQ2a1ZMcXFVc3JseU84azkw?=
 =?utf-8?B?L3F5SkZrN0RaVFZERkRyeWJaREFlRDl1SjR6bWt4bm9BMUxXQ1Z2L1h5bzZl?=
 =?utf-8?B?cWpmQ2JQR0R4S1BPNDRoK1FMazdheFU5bFZnRlBCYXg3R1JUYi84YWwxMjJj?=
 =?utf-8?B?UXRhb3N0Q2hhNjFUSExra0dlZ2Z5U2xoZzlmUlhMWUdwUGM1TWlBY29TaVBx?=
 =?utf-8?B?ZEEzUUx6cnJqaGdsOFM4SDl4K3pXRnRPa0RUd01HSEg5NCtIdVZEQTFyVk9o?=
 =?utf-8?B?cHIvelVTaUFPOG0wcU5IeGY5SjlIS2FzQnEyamI0WE5zVzZaeXBWWEIvbVcx?=
 =?utf-8?B?UFBWYU1sOGdMRVlsVnM4Ylk0T2QrS0xRSzBvWTVNeGx6UmJNLzcwcmpXSjVk?=
 =?utf-8?B?SjVCaS9VWllPWUd1RDFjVVRqeFNvRWhTbVdvOU1PZGZlYlo5MCszUU5peWkv?=
 =?utf-8?B?TXZac2ZZa1N0NHE5MUVYRnRPQ0E1ZDBPSDUvSC9KcHdMY0dIS3NISk5nTlhi?=
 =?utf-8?B?UElCenBYVzYvcGlaalFuTmt3aWV3VnpKNmhyWERIU0lJa2RXbjV1MmlXeXRQ?=
 =?utf-8?B?NzlGcTlKQU5qaFJvNVdRSExhOFZSNk5CZ1k1MDkrbnJicEtKTEl2OXlKekht?=
 =?utf-8?B?R2NyTVhQQlEwd0ZZeUIzUHRCclRKZkQwNWpNaEVoWFk4Uk5qM2hPT0M1NUlo?=
 =?utf-8?B?eFZDMm9OUFdkSVFCY2tXU3oxRVJHQ0MvL2F1YlVxRFZKWnV1Y0VNTzB1N0Vs?=
 =?utf-8?Q?g1ke+11YBGk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmtPWmU0VG1SQTdyL1RwOHREaWRESlRNUmF0dE85OEVWTk90QTRCWjltTnlk?=
 =?utf-8?B?RUJJeTArTElESEpxTFNRckl1YXdKVlhVQkhaWTBrb1d2bENhUDVqODFOaUdH?=
 =?utf-8?B?T0VudEMzU0NpeUtTZ2lkaC8xTUZRVk9hRy9KbVVkc28yOGJteUY5MlowT1RH?=
 =?utf-8?B?YXVvQ1FqZDFUMXNUeEZYQkdpK2Zmdzc0WnRGWFpjSCtsTkdwYmxvRXM1cnpI?=
 =?utf-8?B?NjhVaE5iTFFHakVrSEdOR1VCQ1d2OEhNbGU5Mm9xRjloQkdIOFEwd2I1ZGQz?=
 =?utf-8?B?RjBSUWFzRHN6Y3NrZDA3UzdycEwvU3gvUFVUWUtZeFc5L2IxaVlxbDFqQjhR?=
 =?utf-8?B?NG5kMkpuN0RUeFB1M1pncGFFTFRIZURqUjdIWGUrZklqM21kK0I5T2xnditW?=
 =?utf-8?B?citrcDh0cUFhS1VaZmdOSTRSd1FrcHlYQmxGME5NOHBicWM2VDVaKzdPYnJS?=
 =?utf-8?B?K1lGOGcvM3djdUdOb1NqTGdMRU5yMkV4VVRndmJXNGVlc0ZIRU5qTXZ2L0pB?=
 =?utf-8?B?QzMxbzNuVUZNT0Y0STU2WHU5YWpaWitwUDVQbGU5YW5TZmpxRmdtK21wdENv?=
 =?utf-8?B?dytqSU9BbVFIbnJVSVA5WXVwWFhCNW1jeGxKMFk2ZUJxTFh2VG9CVXo4S3c3?=
 =?utf-8?B?OUhhZmhoSW5YVmhUclA4M1NSWXE3VkRaYTlmRGFLS0NBdm9Ub2V5dVB3N2FF?=
 =?utf-8?B?bHFnUlIxZ09SbGJZcTFlWU8vaUhGVWZWQ0pPbXNjNkV2WVhrRDE4NGZPVlRC?=
 =?utf-8?B?djJzdEk4MnppUnk2Wkt3RzdtaGwzS3JoZHgwc29odXloOWNLeTRwYjRoUWJ0?=
 =?utf-8?B?Q29FVDE1ZFM3MVpuUFZiN1YyZkV5RUh5LzJJUjhZMGFnSGIvZEFUeXFBSG14?=
 =?utf-8?B?a1NDVFRneUZSQ3ZidVZ1OXV6TG9ST25ZbjViaTYvc1hkOS9RdHpqcUk5RHhF?=
 =?utf-8?B?WkxZQk50d1ZydWRsUzlCQ0FkNVkyNVVobmRjWEhWUUt0WlVRWUFVQVZsdGFG?=
 =?utf-8?B?VVFWOEF4SFFMTGZQTkMwNytwbmhRbXFyd2dkYkJ5cXdubkljYVJ2NnRNd1hW?=
 =?utf-8?B?eW1FSHF2ZmJlbFhhSjd1ZjROeFR6UFdnZEJNVUhDMWhlNUN0Rm9ZOVhSazVh?=
 =?utf-8?B?KzJ3Z0pKNXFEaXhSMC9TTkJicmo3QnpVWkFOWWxxa0ZYU3VQUkNDczhXSks4?=
 =?utf-8?B?ZjZTR1RSSzFiSEFJS1VURDJxaS9GRkNZU2JkQWlXUVpVZ015L0FQMlRQeHJV?=
 =?utf-8?B?dDMzUjg3R1FVeUQ1RVhseEYzWUVWelZsUVFua0tWdThmaFBaTUQ3MUVUOFJa?=
 =?utf-8?B?WGltRmE0Q2h2YUZaVVBTc2dPNGN0aTFVT1k5L2Z3TzRxbm41K0xQUkdzZHNm?=
 =?utf-8?B?NURpM3V6Q0pRcnhMWFJjU3NJVFZsL1I2R3lhWlJraE5KOWptNmErSUJQNTIx?=
 =?utf-8?B?c0NuTThJWlppTmRDbDdETXIrbUE3Y1Qrcm5VcUZJbUxGVzFLQmZlcDk0dS8z?=
 =?utf-8?B?QmR4czVYaTBnNDhMOUMzdEpiVXB6VGtnOW8vQUpPaVhQMFJtckFnby80QlJr?=
 =?utf-8?B?dzM0MGZOcG9MT24wbENRNXJEaGswd0MxaVYwWWpnZkFoTnM3Z3dPTzkrT1pP?=
 =?utf-8?B?OEhUMFVSaEJiMHllR1JOMEQ3SU1TQkZTSHpVYmdDVFcwWVZqQTIwd3M5ZjEv?=
 =?utf-8?B?RDhFWEc2SXZWaWtLcDlsamh2NGlZWTU4UnQ4NXNjSzYvUFJ2N0x2NDVXWUxO?=
 =?utf-8?B?THdaSGd5YTI5SmR1UFg3dXVWYjZZZ2ZVandnemRBL29zS2syN3czYkhVbnp3?=
 =?utf-8?B?MHJ3NjcwV0ErSDZicGREWHlSODR2WGg0alp0TTR1YUoxdVNzVE1UeUJkK3RK?=
 =?utf-8?B?QnNOWVNNRW5Ca08wWEhtY1ZPOFBWRFg2V3U4WnVoNzI1QUhUZHhTQVVUTGhs?=
 =?utf-8?B?ck14c2RLTWMwei9YNnBXeUptZ3V3M2sySnp0aDdub3lqd0tRTGFrazRhcXFU?=
 =?utf-8?B?NVoyM2t2Z3hLbjNrMDhxeEhicW9OejdjVWY2UXVDcUNRUzh2KzZrV2l1WDMz?=
 =?utf-8?B?UWgxTWx5VkRsNEdLUHd6WG5aeGlUY3pxam5vNHZiSXlUWVFOb2o5dVB0aTBH?=
 =?utf-8?Q?1NeQ9xLmL7ijTO+A3+KSTSN3G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f277e3-d331-441e-0a3a-08ddefca442c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 17:56:56.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2AcNHhjtU6q1Owmf4Gl0AZJqNFaxr/ChWV6Y/VcRwY24HeaRqsLu+w7b2I/wGRAww3YmjYpFWBKoZiY+P1jCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562

On 9/9/25 10:29 AM, Simon Horman wrote:
> On Mon, Sep 08, 2025 at 11:40:36AM -0500, Daniel Jurgens wrote:
> 
> ...
> 
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index db31fc6f4f1f..a6e121b6f1f1 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -12,6 +12,7 @@
>>  #include <linux/dma-mapping.h>
>>  #include <linux/completion.h>
>>  #include <linux/virtio_features.h>
>> +#include <linux/virtio_admin.h>
>>  
>>  /**
>>   * struct virtqueue - a queue to register buffers for sending or receiving.
>> @@ -161,6 +162,7 @@ struct virtio_device {
>>  	struct virtio_device_id id;
>>  	const struct virtio_config_ops *config;
>>  	const struct vringh_config_ops *vringh_config;
>> +	const struct virtio_admin_ops *admin_ops;
> 
> nit: Please consider also adding admin_ops to the Kernel doc for
>      struct virtio_device.
> 
>>  	struct list_head vqs;
>>  	VIRTIO_DECLARE_FEATURES(features);
>>  	void *priv;
> 
> ...

Thanks Simon, added for v3.

