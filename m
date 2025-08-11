Return-Path: <netdev+bounces-212471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9B3B20C3F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610081884D2A
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F454255E27;
	Mon, 11 Aug 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a5iKLytF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA32BEC2D;
	Mon, 11 Aug 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923129; cv=fail; b=te+HZcO8DXQ9swJmzkzZodKBafzRIzITYQ0DK+L5dyL2ADa0Irv8Jt4QEToQT46jeyOt3eNfUrVadjOJFsE73aIgdeLpiSqIQHAhE/uRXPFx4W84zF/2HMIpAizuwVJ4skulWCYLkN2L62YaBR9jrGxZE4thL6rXfhAb5qMQq4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923129; c=relaxed/simple;
	bh=FurQ49gRXtHYb6LQg/bFhUT9RsmstU1i8O3FqfYyK+w=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C2uKtbSPPXUZXE9hP2AnUw4LEzigE+rI4TROSU0vvOyvoa9nmrTol2/vSmWJbdYUdIuSNkiADnK6Lu5wmkBGnPGXjT8BT+jw9A03FkA+3TR7H2Eall1O1qvYgf0q+oS5JNXxtNElycJ2IIHOvOw0tMvkdaO+/fRz/6vXl5LUNxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a5iKLytF; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMdfjIXtpqbT8RN0wf7UpJiMb08KotyncmStQdVmIZUcWDLy/2hR9aOq4YRFY7ATqwyuGWxYMemeF4Tu9akGi8T1UlyslZGYuAmGalpVyv+rz9IUUGvpOyihuAwusodAlLcJDvJrkrCKgW9y/A0zQLyEXf3qa+ft3+U4bcpaStBDRE5SotcFbSmuHo20tWP9+z1HnfePsudy+evXfzuVh+k8OXeoXwY4b6vkDQnsErUrVqv69a8VxiHmkbdnoSrWA88lRnrPzPxyF/YXtFHMNSq08Dsz7GSaEHsSO77nfz/05B8AnacSNgC9+s210sURe4ca54aZX9Han3RBjQUA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FbvMm77Wl2kzDy32QtECdNobDql54A33oCl6Abt4EQ=;
 b=rw/Xg8ROK2KViTTL1SJFzJFL8E/Y3olSa4rvswcG73h9qU+4bXijnIMraOtthxvqhpBddcuix7yn3Wz+jaSCOwtCQqLqmDhXGd4U8TSiesFzVhaN0sb4NYcFCKbMcm/kr2QAzE0SKXSIsCvXoCN9VgkloJb+SuvnFiDJLXGXzYUJCeeUrboVB2EL7u4jFLLpGtETWBIlAE8ij0bY52LqKxlVHzKAsadiLM3101nBCoLEtOSjjv2tOQ+v/4dYdsaMmghZadxYYE6/UOE+A7DRhYcPwsZmvaa6byhVfE3EDc3r2OWlH/zmwht4/66qmKSQ5tAq1qBoq4bA0g8VyoH7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FbvMm77Wl2kzDy32QtECdNobDql54A33oCl6Abt4EQ=;
 b=a5iKLytFDTTL60/bH1hVpEgSv0qO+CbG94FrTopZogSn0vsxCloysdW36W4hVAuVJ5CyNuo6RB1Ynovlp1mziRAGQKUQewnVZgCSH8cuGIJS0GjNNhUlCvVP4DL1ynn4mr2S05PCHd4jZSIBd9g6XIlfA1lK+N/7NxuJJ6ZettA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 14:38:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:38:41 +0000
Message-ID: <fb959fa6-26bd-4aaf-b5cd-3b8184d9f79f@amd.com>
Date: Mon, 11 Aug 2025 15:38:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 20/22] sfc: create cxl region
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-21-alejandro.lucero-palau@amd.com>
 <6887a3482072a_11968100ac@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6887a3482072a_11968100ac@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0316.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 976ceb80-d9f9-4b15-3724-08ddd8e4c420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnFhUEZDZ0h6TlVqQVpMaTZSdmVLYnNuV29QUFVIL1NhZG5EQmNPdmJUT2Zh?=
 =?utf-8?B?MkRVTWljL1NoQ1g2YVI5UGN3dUJ4QzJ3QkViSW84RjIvMERSdUIrRFl3dUNn?=
 =?utf-8?B?aFRrQXFHS3BBcW1Kb1cvOTNrcDM1YS9DblFPV1IyYzF0U0ZHZmtBZjhWV1Ju?=
 =?utf-8?B?aTcvOSsxWGoxYTdmSktQYnhERUVGNHdtdU5acDFsUkRWY1ZMc2hmTmQ5OExM?=
 =?utf-8?B?QTY4L2JTbFlrSXp4Q2xCZHRkOEZOSVJZK0RWZ2hWZVBsQ21pRDZPNDNBYTFH?=
 =?utf-8?B?bm9hKzhnWnpFdWRUTFNGZGQ4RUhCVUNZaW1BL0RscEZvNUtiaUJZUzJzMWZH?=
 =?utf-8?B?ak9lZlhFYkhHNExGYzBrd0ZHODJVZU0wbnY3MFR1b2wrSmNBcEJ2cHQ4R3V6?=
 =?utf-8?B?UkMyWW1qeDNXS2RQMnBTYVRCc3p3UDZnd1RQRDdPVGgxeC8vcnhLK3BXYlY2?=
 =?utf-8?B?bEE0R3N4Vi9sV0ZzNGVVVEk3a2pyaEwvaGdkcU1QeUNxWlZVS25NeGJObkNU?=
 =?utf-8?B?NUI4TUZreEVpRnZ0bmNUVlJkbWQ3MVN5LzVxYTlXTXh6THJrVVp4R052Sk1P?=
 =?utf-8?B?ZWtsMzIzaFRaN1RwZFZDdi8vRHQvZWVwWmdNVDl0Qk9kVlluM01oM0lDUFBu?=
 =?utf-8?B?eWM1YUF0LzFwa2dqNk5xYTJqbzZ5ZXQyb3JKUkVqelpLRDdrbHA0SS9yU2pW?=
 =?utf-8?B?M21XOWRsNFB1QnB0dm52Uy9Ed2hnb2tnYkR3RkhweDBxM2dBL1J5OGZoYXhq?=
 =?utf-8?B?WU1ZU3M0cm9zZEc0WXY3U2xrK1hwZ1NUaTB4cnhLd3hPYzhoOU1IY2FrL1hv?=
 =?utf-8?B?bmRXOE9sZlZWRnZ3NVQxbHNaQmdVSDFvNU1kTXFyOGd1ajFhbmR0N1JINko5?=
 =?utf-8?B?S0w1aWt2dGx5UTZ3K3JIcVR0MGNQVUg5MkZlWVpCbSs2VGxnU1B3aGRDbUVk?=
 =?utf-8?B?Zy9zdXhReXBqakpNdUVsS1dNZkMrbTIvWGtNSm9yS1V4VXRqQmM0L0ZBMk9R?=
 =?utf-8?B?UjV2MWd0TEFNMzBJTjFHdUhHcWRLQ2JpSGpwU2UrSWVLR3lRMkhuQ2tuWEND?=
 =?utf-8?B?TWZhS2VOWVhNRWpORXBQc2JkMjExa0wxVUg3WFlmQ013Wi8rdGcrZEwwTTlI?=
 =?utf-8?B?WXczNXU0aWRiNVp1NDFUM0kxTW80R0UwWUY0MTNtbDhkMmlmeHBKSktXc0Iv?=
 =?utf-8?B?bnhhRW5sOEhqaHJXVmNxakEvd3RmZW5kVCtSNDhhSXl5WHJHUEFES2V5VHVl?=
 =?utf-8?B?QzhTdllmVjNNREJVcytaQWRhcDJES00xeEMrT3AwcHNVK1psRXBMNm1ua2hO?=
 =?utf-8?B?QlQ3WXNkcjZPNTNnR2hiN2d2MWU4MWtDT2h4dWZBZHdybGdYV0R6cUdMdEFt?=
 =?utf-8?B?Tkw5OGtUWVN6QUJFdDdYWDNjNWdwYzBKOHVPMW5qcGsxNDFNbGdsUGwvS0NX?=
 =?utf-8?B?TVVNR0RPWS9mZ3VLUWtCb0xpbzB2dEhlK25YeklzcFRORGtYQ2dMUzk3eklT?=
 =?utf-8?B?dnAwZlFVSyt0OUlrOGVVVEJsVjZDS0JGckgvamxQZzRXRW1HdEZpQTQ5WlND?=
 =?utf-8?B?SlFxdHMwUnRLWE9BZC9KU2c5QnRvQW15WEtmZzZSUmUxOXk4TFFFaStnL1FP?=
 =?utf-8?B?YkwzK0R5QUd2MEdITTNUQWpnNUVUakQ0TmFFUDJSTjdBMWl0bkRvUG5KOEJh?=
 =?utf-8?B?Q3lTVDAzRm9rQUpaMzVZUm8rZEI5MGw0OFlLaDh2ajc1SVA2Y2pwcHNVSW1i?=
 =?utf-8?B?elF5Z1pVYWtBV1g4d3pnN2FFQjNaU1dWVnR1SFpESnRKRGdZU3ViL212aUNC?=
 =?utf-8?B?U1U0NVZjRGM4dGF2ZkhtWjlkdnFNc1ZHNGxsQitWUG1JMHNTY0F6Sk56K1Fj?=
 =?utf-8?B?V0RYMG9tcGIxdW1VT2NPLzdUelBoRm5xWTZCc3JQbER5eUM0NnhkMzNnUHV3?=
 =?utf-8?B?Z1d0b0lwQlhycGhoeWx0M2c1SytBMzVLS1UzalVxTExyenNpQk5WZThwU01w?=
 =?utf-8?B?WGg2L0pkM1lRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEZ0K1pNSFpXbFNtelljTW93YUEvSm1Vbm92SnErWVYxdjdaQ1E4Qm1ZcFJa?=
 =?utf-8?B?SHRlcENvQm0yU2tidjlWZmh4TE9vM0tQZzJQY1BVeVVhaVRRYzJVS0k1bmdH?=
 =?utf-8?B?YnRzY3BzV0lQaUdoTldyaHVIcmpPdHBnT3VqT0lKQXZUOGdyUWtzUlRhS3Rk?=
 =?utf-8?B?QWlRSnlDd2J0WHRSekQrMlJtMUJCcys4NjNCS05hR3dJZDhCZFAxcHR3ZURX?=
 =?utf-8?B?NUtIS3RTYVRwK2g0TlZCdUtLM2h4eDFZdURkYytyeTlGcGZzNGN5SnBiaVlN?=
 =?utf-8?B?OUc5Uk5KOHpSbFAxRE5UdkpXTkw0cHQrenc0cDRmZUZtTmVxOFF6TGNPcHJh?=
 =?utf-8?B?MjVUeU9xRjVtdFNhY0lIS084WVNZZEFnQjVsNy9SVXpzdEFzY0VSZ0hxakts?=
 =?utf-8?B?TWdKaHpsT2hQZ0dqMmpWcHA2S3JweHk2SEExdDVwSDN1UUl1ZnVNSzBmM3F5?=
 =?utf-8?B?eTlRSncwMFlNLzFMcFVpaTNlRmVsc29EOXhsd1c0TXYzcGk2Njd6TXRadDlh?=
 =?utf-8?B?azlUazhodGR6aGFHNUNpR0lvOG1LNDVObTZXUGQ4MGRQV2dieFFBWDRza0Va?=
 =?utf-8?B?cGJDVE9HdE5LVzdGWm5leE9TQUVNczc2SXFMWGpkUnV5NFE0TTloU1FuZ1B4?=
 =?utf-8?B?aXI2RVhNUHN2VVB3NEpNaEhreDBFZ040YlF4WUEyWFE0ZWRXc2YxUFhhRUM4?=
 =?utf-8?B?eE9OejJUNjV0UllWUnBqaDMwcFgzYWxyQktWalA2T29oMGgreXdIbUJxREpE?=
 =?utf-8?B?OFJ0V3FJYkJCdEl3cERVN1IweW50VzBRMW5lbUc3MnlTL3pmb0NQZEdwKzRn?=
 =?utf-8?B?NmhSajlabkZQVEFJeDJKSjZTTlg0TDkxMHFOUUZoUDRRQ0c4ekdPNmFhL3di?=
 =?utf-8?B?Z3crem1ZWnBqbE95dEs3RElvOVFWMGZrSzhVemFTMS9UNUhqRG1nUzJzZnlY?=
 =?utf-8?B?SUpJKzRVS2tCREZwbjdJRlorRXd0dXhyRDVEdjVteS9wZ09OcjF0dk5TUkdz?=
 =?utf-8?B?L2R0YkI3TXBLb0tXUnlFYXJMWGhwb3h1L2MyTVdVQkwxRS9VQkxpWnpJSldT?=
 =?utf-8?B?SlJlQkFZMWdEZGtZWENCbDVza0ZGRStRRldFd3UvcldIbVJRc3VETlJqL1lr?=
 =?utf-8?B?VGkwbWVSODljVmYvTEg0NFFISkZ2bUlNT3lsdGtHa3E2ZkFvVHd3VXpEZWxy?=
 =?utf-8?B?d3orcFBqcUNnbUxIQmRUcHFKOEFnTGdnNkc3NWNQd1U5Tm5tbE03d0NyY2Ra?=
 =?utf-8?B?OGNibTJ0cmdKNTBKdnEvMUJEQjd2TjZLZ0JxcDJDUWU1NnRVWnJBZU4vaFBs?=
 =?utf-8?B?bVd4S0pMQTNWendKMGl3allNc3dDanFIZDFGNXpROERFa2pHZ0dDbko3NDFn?=
 =?utf-8?B?dVYremRaRFhYMmh6dUo5MDN6SGpoTEY5NjFZamFSa0FpZk8vbDhROUFwNzlp?=
 =?utf-8?B?UWV1TkRNa3JTd1grM0o5V0ZoNWgyV2ppTWk3RTF6b3FQcmtRSXRXYjl2QmJE?=
 =?utf-8?B?V3dLNUpvLy9KU1p5cGYxK1pTQjFldTU0ZmNmdFhheVJnZ1RnMUFWNUVXeW45?=
 =?utf-8?B?Y2VST1Fpa09XNERnSmJGMWNqTjhXRmtsMnhWay90clhmaEdWekFwcnNXMkU1?=
 =?utf-8?B?dy9kdTRoNHo5RUtJb2VNampEVVVzWjViUGxoZm05NTRaUTVWSmd3dUpTeHVI?=
 =?utf-8?B?UXh1UTFaZ0hDTytFRVVaRnI5M3R5RGNSbUl2ZWF1YUFkUW4zeHAyYk1PeDBE?=
 =?utf-8?B?Z1p2N3dLcHY3aVBFTVRqWU0wQ2RYVUlLUHdTQVNPVzNVaTFuV1g4NWtGMDhP?=
 =?utf-8?B?VmltZkRtYmtrbkxKd1FGVGFCRkF1TWYzbXpZTThJT080WWxpanNHZ3VueDRW?=
 =?utf-8?B?ZG92OEMyWkVPZnZqWVpJbXBWeUdnVlVFK0RXTUZwamNyVkpoQkNoN2JLakRE?=
 =?utf-8?B?bVRFVGc2cXJJZDVzWkRWK2ZLeEd3YzNmc041WVFPQzk3VVI1WUtuc1F0UVJY?=
 =?utf-8?B?bU9Ba0FEVnpnZHRlektqeUxOOHArbW0zeUgvS0F2V01YZEtGcm8vM2FTYnZQ?=
 =?utf-8?B?VVpWeEFqV2VLbjArUDZOcWhpMk1JVHdmNzZKWUJTdUZZSzg0Q2dHc0swK1gx?=
 =?utf-8?Q?83pvH/hA5dxwulleNRQQk294t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976ceb80-d9f9-4b15-3724-08ddd8e4c420
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:38:41.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2aTWrcf4mUW1r+eTEdm7SISJlj6oifDGLRwBOj0Nse+Ob/3Ab2fhK4LbUIIX8CA7PWFgzNMza7E4Y9SK+mCqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843


On 7/28/25 17:20, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for creating a region using the endpoint decoder related to
>> a DPA range.
>>
>> Add a callback for unwinding sfc cxl initialization when the endpoint port
>> is destroyed by potential cxl_acpi or cxl_mem modules removal.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 24 +++++++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index ffbf0e706330..7365effe974e 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -18,6 +18,16 @@
>>   
>>   #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>>   
>> +static void efx_release_cxl_region(void *priv_cxl)
>> +{
>> +	struct efx_probe_data *probe_data = priv_cxl;
>> +	struct efx_cxl *cxl = probe_data->cxl;
>> +
>> +	iounmap(cxl->ctpio_cxl);
> There is no synchronization here. If someone unbinds the a cxl_port
> while the driver is using @ctpio_cxl, it looks it will cause a crash.


Yes, the unmapping should be after changing cxl_pio_initialised. I will 
fix it if this mechanism stays ...


>
> The loss of CXL connectivity after the driver has already committed to
> it likely means that the whole driver needs to be shutdown, not just
> this region cleanup.


What I am trying to handle here is not an CXL error but removal of cxl 
modules. If the latter happens, the driver will keep using other 
datapath but not the cxl_pio memory.


About a CXL error, I really do not know what is the right thing to do 
here. If further CXL.mem writes after such an error are not problematic, 
then this is enough. If not, I'm afraid we can not safely deal with this 
since the host/driver will be notified too late.


