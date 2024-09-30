Return-Path: <netdev+bounces-130442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA498A876
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C739284934
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2355198A32;
	Mon, 30 Sep 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c2m0Wgpa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B739198A06
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710100; cv=fail; b=S+bzddsDA7iJA0oLXUESlJFFXoVrIv2jVa7zgRTXZnPGJZqCNmw5aVXO1GANhwifAbdIvk/xHelAinsW1snY1rh47a/bLBwfPWrOYHqAxK01EpjFNRtgBZZNiDfdreZdoh3uH2PMFifl9tRS6seiyKVO1ZuvMBKPwnwSn5GuIW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710100; c=relaxed/simple;
	bh=hx/sx7LTavJiQhkRIatCMhqA5egVYtla6tnzry+is4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=InPvSHTxJ68H7Yk+E8OK89UN/2qeZFJ3kOYJztphLUFoAuvWgjOT7W1Q1lyg6qrnZUD5FesfhX6pidLylo7I8gSI9ZFuk9x/sRTYDu8flTw3NP9Ror5yLXUt+oifRZ3qUls1BgQBa+ikFTOYDB3kEpOh1ccMGKWYuulPNqw7wBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c2m0Wgpa; arc=fail smtp.client-ip=40.107.95.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3eHNzN97bisIF72GTnBN12ZeV4SGx2ZF/RcCx5LM9qxuC24rkhed62FJ+3iNUQre2MLowozKKFLYe00GRdELofAh2q7D78/+kqlLvL7MJJnuOGbwzY+rL7zF/9nALstRp67VmOdmz8atuvKL8jC/2ruO3+3CRPOrJ9GwIVaHIb45MHFnS+cEcgUH3RSgVWI4IBRoPQA2Bt/4TtMGall+Oy+xafTePOBbE6Ty55doEXt/VbEoE6PdoNqbwbD0UN0eH+rOM8cj8a9l2kJRd+UqQl26SBOLUe41u0O2lR648371Qmn/1zLA5ZtzuhrDksteqxpktGf8ebBAka6QM2GLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx/sx7LTavJiQhkRIatCMhqA5egVYtla6tnzry+is4g=;
 b=V3bNg1r9cOI//chFUPJJv7om036/oOZo11JjWbnjIJSHvaV9Xx9N3lhXXGa6gJty505T6mODk+j+lW+bsCCFU/nZV27YBnDSms1MlEeO5UF88p2D3qOXCNmW2RimsnlBhSTMHyvMUFDnKxMLrm70LEz2SP5fiLez1ZvJhbt18mIbFeX8LVSUZwfte+GsnOXMcOYz/XCorfEySz9MvqQRfv3S6/Hxwc0RO6Zi5qJRZWHh7OtyoDXl4Z9DMy+3GRyZg3uZrrZCfg6YheYzGPfwjSqUFnsSsFECJ4f2uEwOd8B5/74VlICys1IFIuvCb94pjA6kbiksPWi0tCmhXFrP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx/sx7LTavJiQhkRIatCMhqA5egVYtla6tnzry+is4g=;
 b=c2m0WgpabrHxYAsXMgp5uD0+T0oCnZH3swP7GZ/iAB12T6fUl8BuybQ5MURSXneOtVyRJR5b9r9IOnnclXOZq/3+XeEy+2k/x2zmoImlMhRM2EjgLBN08fPEBTP/LQV5xAeucfea/xm6KbFe59314BxsanChy/vOhLY1pqptJfUhFZ2QUgvyePwr/KvNQX94KF6K9UcnO0ilN1vzT3Em9TGVy1UQAsty2GggYolHreuVd60+EI6kB5+OKL7z32E71G0U9YvgSL1wNPO81ov+pZdwRpeAyZN7eC97XIMsZTkhD5onM2AYE/1MR4sDX4b+QaNXXC9pTvp0TJwX0H6T8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 15:28:16 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8005.026; Mon, 30 Sep 2024
 15:28:16 +0000
Date: Mon, 30 Sep 2024 18:28:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: gal@nvidia.com, Tariq Toukan <tariqt@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [mlx4] Mellanox ConnectX2 (MHQH29C aka 26428) and module
 diagnostic support (ethtool -m) issues
Message-ID: <ZvrDhfaIe-bgOyVd@shredder.mtl.com>
References: <a7904c43-01c7-4f9c-a1f9-e0a7ce2db532@ans.pl>
 <ZthZ-GJkLVQZNdA3@shredder.mtl.com>
 <b0ec22eb-2ae8-409d-9ed3-e96b1b041069@ans.pl>
 <7ba77c1e-9146-4a58-8f21-5ff5e1445a87@ans.pl>
 <Ztna8O1ZGUc4kvKJ@shredder.mtl.com>
 <dabeaf9c-fe6c-464e-a647-815e51ec33ce@ans.pl>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dabeaf9c-fe6c-464e-a647-815e51ec33ce@ans.pl>
X-ClientProxiedBy: FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e871f51-9610-41c4-289f-08dce1648110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b29NUmpsMGVPS0JCdUV0aSs0RTc2cWxJemZZelRBRGw2SkYyYWxBRlpRd3JS?=
 =?utf-8?B?WDVad01zQzh5Y0VoRjZIRnhsQmYyUk14bHpTUmtIK2RHRHJRbzRBeW5HS3F2?=
 =?utf-8?B?blN3R2Y4TEFyZURzZUtYcDRrUkNLa1gxZDhmbUcweXBKaXQ5VXRNMGpiMEVZ?=
 =?utf-8?B?Zlpld2VPWVZxbnRSQ1V0OEM4Ui8rd29wTGF6VlZkaTB2RlpIaUdJZVZEcng5?=
 =?utf-8?B?eWxGUUl6OFlzN0xNd3ZCdDN3N3pIQUFlNXg2R0lGOExqVEVOd1ZkRTh2TGs4?=
 =?utf-8?B?M1pPVGV6S1JDeEVTM1R1K0FQVDR0d09kdUdqd2NMdlFvT1prVmNPaUpONUtk?=
 =?utf-8?B?eFdvVy9aMzh2cElwQjl0SGV4a1ZseDQ4WEhZUGJwTE9lMWN2b1Evd2hWMXhM?=
 =?utf-8?B?OVIrd0xBNEVtOWo3aGlpS1YyYzhJckxTTFBDa0MyR1J3dm1Ca3F3VEhpUXEx?=
 =?utf-8?B?bi91RWVUVHZLZUF5anVWai9wWXZ3aXdqbCtMZjIrVC9QK2Y2WlN5UVJuelI5?=
 =?utf-8?B?Vnc2OE0veXBvWFdyOGFnWmZ2WWdUKzlIZmg0b3p5VmJ6RHRmMkpuRWZjNXpG?=
 =?utf-8?B?cHFaS1o5SkU1QUVXNkVZVWNmUFl0aE13NjBQTC9jM2lZQUxXd1pWTnkwWE51?=
 =?utf-8?B?aEtkakNaTE9KWHBWdHpsOFkvZkkzWG5PaW9WWXI0SEo1cWdaUmJlV2FJSWNq?=
 =?utf-8?B?anNKNDhNUHRXaTR4YXZXalVJSU9HR2lwaDZjaVA1RnIrMzVjcW41SG5CRDZw?=
 =?utf-8?B?NkEzSXB4ODY2SzM0MVUxaTEwS2RuVk9DY3M2ak1iL0w4cytseXVCVlBqVitk?=
 =?utf-8?B?TS9RNjF6NW5KOFZ0SXhiWFh6TVZTbUdsbEV0eVRSQmZYVnErTVNVc2ExbGR0?=
 =?utf-8?B?VGUyS3Z2UXRDWDJKVWNnY2hBRzlaSHJoMmFyMXF2YmJZOXgvUHBrMTBwbUND?=
 =?utf-8?B?UEtnNGtKWHZhS0FRYys2OHFTZVVuOFJRNm1ReWJFanRJMFVZL0ZFNXQzNU5G?=
 =?utf-8?B?QlJ3UmUzOVRCWGhzUnVhMG14eDVrbWFsdnVtUWN6ZE1CSTYvbjZyN1pHbmtI?=
 =?utf-8?B?aEtVRnhodTE3c2JUZ2hCbk9VYzd6bGZoVk5LdG8ybER4NVdySDkvMXZBNlNE?=
 =?utf-8?B?eGtmeTRCWWdqN1RjRVdtOWZ5bVZlWnhrenY5Y1N5eGlGSTlEdEFSODk0TGlZ?=
 =?utf-8?B?dmxDSlBXdDZGZ2w5TzQ1SStRTnV3V1M5ZWRyYmhsRzB5ajA4NDhDTGZIOFlH?=
 =?utf-8?B?Qm9XNkxkc042YjZHTGxUZkRndURxelF4NFFQdWExc2E1YUFJV3Q4MFgySDA4?=
 =?utf-8?B?VnJkSzdxWmVVSUlHOU4vbmdKL2t5djQyWXMwbC9KcTFOUFZKS05QNXpUYTNw?=
 =?utf-8?B?LzVqdlErL1lJeEhjOFAvNWFjbmF2YzlSQWpRQTdvRitDT3BKLzM5d1htQW4v?=
 =?utf-8?B?SEdOT1Z3SnFKNGxkZzhvRyt1bFpacEZIR2wyejhFZzFVZ29lN3lJNEdaOTV2?=
 =?utf-8?B?SEg4M0k1SVpILzU5MXNZUm1aMkJlZTBkSmpEWjdEaXNibzcyN3hDVXUwSmt2?=
 =?utf-8?B?R1ZtYmY3T2hSNkZLU0V1c0hkbkZqMTJxNDRyMWora05SQXV5VlYwSFp1UjVm?=
 =?utf-8?B?dWMvUmQyUmFwY25MK043S2dqeU1xNkoyOVNobSt1T3RDRkpqbVNvRzlrNExX?=
 =?utf-8?B?QS8wZ1NvN1BTTDdMRFBIRjlhY01sNEF1akR0ZDBBRHNVVkhYNG10bEdxY1pj?=
 =?utf-8?B?cmMyRmZSV2NLcnR3K3AyRjlYZ0RJdk0xaEY1aTBBb0VhMmZNc3lkQ2VsTytG?=
 =?utf-8?B?OVFrVFpIM0RWNWJXMG1wdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmZWVnNwM2FkN2RzdXorQlJ2TG1MWWp1aG1GZktXN3RXY3p4RkxFQnErR3JV?=
 =?utf-8?B?aG5ZVFpNMGF4Rm9HdU42MmN1cmtMQzY2UFlWNXRZQVJyaVZEVHpCV2NGYVdo?=
 =?utf-8?B?V2pOQnJ6bTB4M3NKYmZDNXJyRWFVV1NGbWg3QTNPNjVxamJiTjQ1NU56ZFE4?=
 =?utf-8?B?eTJzOHdsa09DQUNaenBjeG1FQzdmd1Z0Z25TV1ltT2hWZHZseFdyWlpkU0x5?=
 =?utf-8?B?SXc3ZDRLb0tXYjg0RmVSZExFV2lkdjdWNU9KdDRwaTJ2MkdpWGJ5d25mZVdB?=
 =?utf-8?B?dEhoT0VEbDU5NkFqUHNkeXBYL0c3WElPWVhoM09CWUN2Uk5UN2RGTHl6RXh0?=
 =?utf-8?B?eGwramlobmhMb3A3d1I4N0hpbHQ3WVE0NXVCa1B4c2JKUW9RTnJTMExlN1hx?=
 =?utf-8?B?WXF2VktyUUtZR1FUMXdCMGpBQ284bm85UWkzRzJiYWJTbnFxT2RsVmNKQmVX?=
 =?utf-8?B?a0lYU2laVmdObHQ2T2VXRVRjcmgzS0U4bjFZMkV3UFlnQXpVaHV6bDgzQXJD?=
 =?utf-8?B?enRaQmlxYkk3VDllckNkendud2NTYm1oZkVCcVJMNE15aWlGK0tScEszYzR4?=
 =?utf-8?B?VXhUcS9xdG5MMFdZRFpvN0RHS003L21PVEc2ekViKzNhcDJ0NGJUT1g2c2ho?=
 =?utf-8?B?TXdSS3RuQ3RzRnNBQlJsMy8xU1I0bncvYnIyUjZ2c3BlRDVlQlJ0MDVnZ0xM?=
 =?utf-8?B?ZkwwajhOMm5VZVJQd1RpcEJsaGYrdEJRQkRtR1U3TkhiSW5SZjVCVjROdXQr?=
 =?utf-8?B?ZFpsOU5DbUNleTdSWnJ5cHJHb256enMxZzM0cVdGOWovbVUrejFqTUVhT3hV?=
 =?utf-8?B?cHJLZlB0QU5VRjZxNlZHdVRzVS80SkdqMmtFa0RaMmIrSEU5RG04NVBtc3RR?=
 =?utf-8?B?R3d4b1JvdjU3Q2piWGxvYldlREtNUzZCS1BmeTN4Mi8xMmxuejF3WEhGdThE?=
 =?utf-8?B?amZ5aksvQ3NvMWdNWmdyZDRJVkMyNmpNbkNna040bFRvWnYxM3BEZU4zVXVP?=
 =?utf-8?B?cXE0cSt1MHozUlg0UmF4cXJFblYweW5FV21oYkxjVXF2LzRwUm5yVy9nLzNF?=
 =?utf-8?B?VVZNcFJKdFJ3ejFWQzlSdExLaHkxV3ZPeEZGUmoxUjI3ajVjMTVEQ2xNYlpv?=
 =?utf-8?B?QmtrZ1JQMGRRRTR0NW14YTFjd0ZLTDRMVDBYMUt1cFovcXF1ZEl0cXZlUXNB?=
 =?utf-8?B?Q0VTVmJVQXo0VWwyNlBQdEErVGtHQ2pHclBTWTdEWTdlR3lodzR5Sm9xczFQ?=
 =?utf-8?B?VFBkRVd4OTJLV3NIUUZCTVpZK2Uvb0dYTEE3NXlvVXpITkJLYWlnKzd4QTJl?=
 =?utf-8?B?ekcyamdwazd2elMwYTNWVHl6OGlNbkVWL3lmOGtoT2g5bUg0eUdCVmJaM3o0?=
 =?utf-8?B?Y3djNmh4UzlaeVo2dkxFNGlnN29YVEhXeEhQQTVUTUt3bitERXJtSVJPbjJ5?=
 =?utf-8?B?emVxbTEwdVB5aGZoK3F1ZEZjbzk1Z3dyanFScUtycGl5YjV6RUQwUXZWbml1?=
 =?utf-8?B?cXR0Ymdmd2hoOHR3dnovZ3ZRUUQxRkZHczNxcmM4L3RDVnRvclpwZUc4KzRl?=
 =?utf-8?B?TWFLNjVxUVVLVE1UcHJJcndOQ1pOV3EwYnpFQkNJM0lhcVh5ZktPdms1NjB4?=
 =?utf-8?B?b3hRSmhaZGVwM1RNVHBSWWZCR1BVQTVCVVlzU1BiaVFONUh6Z0pYOGxsamI1?=
 =?utf-8?B?OUVBRHl6bVFDV2JabmFEdmNSd3VHQnkwRCtHdDg1UHZuNm84TUtmZTNHbVk1?=
 =?utf-8?B?dU5qUFZVMXNmYnd1S3ZKNHNhQ3gxWGFHQXNkeFprMnhlRlRxVEc4VENjdzMz?=
 =?utf-8?B?YWs0MlhncDB4YUZqQnljU1hyZ0lwQkRaVG5Gd3ZiLzNzVE50c1VpZTZ6Y0tx?=
 =?utf-8?B?V1FibWxrR2xnYVV2YzhzTEFtcTZrNERtU0JyanBJcUp4QmR3c2x2bnBXbStZ?=
 =?utf-8?B?dHZLaWUzZTNLUzBoWDNmZ3RIaFpDMlBQUzJhRStkUU84a0ZjaG1Rcml3MW5y?=
 =?utf-8?B?dHIyMWIzYkhiTlVlc0VjQUNQWHB6MG5sVldBcnh2MEZlcWlSeEpoZThQYy9w?=
 =?utf-8?B?ZEFBZ2tFaDdjSlZoM01HUG9zMmhFS1pSR0FqbExDK05nbm93MzI3bUJmM0RQ?=
 =?utf-8?Q?SYwuoySj6eQ/De6rXMkz07ULb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e871f51-9610-41c4-289f-08dce1648110
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:28:16.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZ7KT8OwrQ285Y0F+nTcMA4a8FwQHZJxBgPXAN5+vGeotvOyG4gjqpJeNFhqH0E3xrj05e16NTruw0DafIRRiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

On Wed, Sep 11, 2024 at 11:46:11PM -0700, Krzysztof Olędzki wrote:
> Sure, I can also try to work on that one. Would mlx5/core/en_ethtool.c
> be a good example of how this should be implemented?

Yes. You can also look at mlxsw_env_get_module_eeprom_by_page() which is
using the same firmware interface as mlx5 (but not mlx4). Basically,
this operation is very simple as far as the driver is concerned. You get
a "3D address" (bank + page + offset) from user space and ask the device
to fetch the required info.

In the case of mlx4 bank is irrelevant so you can always return an error
for "bank != 0". For the rest of the fields in 'struct
ethtool_module_eeprom' the mapping to 'struct mlx4_cable_info' is as
follows (AFAIU):

struct ethtool_module_eeprom::offset -> struct mlx4_cable_info::dev_mem_address
struct ethtool_module_eeprom::length -> struct mlx4_cable_info::size
struct ethtool_module_eeprom::page -> struct mlx4_cable_info::page_num
struct ethtool_module_eeprom::i2c_address -> struct mlx4_cable_info::i2c_addr

Note that mlx4 firmware can only read up to 48 bytes
(MODULE_INFO_MAX_READ), so you need to implement a loop like the one in
mlx5e_get_module_eeprom_by_page(). Also note that extack is available so
try to use it to communicate failures instead of printing to the kernel
log.

